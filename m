Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278941AbRJ2B3C>; Sun, 28 Oct 2001 20:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278943AbRJ2B2x>; Sun, 28 Oct 2001 20:28:53 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:63502 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S278941AbRJ2B2n>; Sun, 28 Oct 2001 20:28:43 -0500
Message-ID: <3BDCAFC4.EBA4E785@zip.com.au>
Date: Sun, 28 Oct 2001 17:24:20 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Kuebel <kuebelr@email.uc.edu>
CC: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 8139too reparent_to_init() race
In-Reply-To: <20011028200153.A331@cartman>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Kuebel wrote:
> 
> hello all,
> 
> lately i noticed this message during boot-up (when the network
> interfaces were being configured) ...
> 
> "task `ifconfig' exit_signal 17 in reparent_to_init"
> 
> this happens only about 1/2 of the time.
> 
> after some digging this is what i found...
> sometimes ifconfig's parent exits before ifconfig reaches
> rtl8139_thread().  when this happens, ifconfig's exit_signal is set to
> SIGCHLD (in forget_original_parent), because its new parent is init.
> then rlt8139_thread() is reached it calls reparent_to_init(), which
> complains that exit_signal is already non-zero.
> 
> basically this patch stops rtl8139_thread() from calling
> reparent_to_init() when its parent is already init.
> 

Thanks - that's a useful analysis.

The check in reparent_to_init() was to warn about the situation
where someone had deliberately set the exit signal to some
non-zero value and then the child calls reparent_to_init() - it's
telling you that we're about to stomp on your chosen exit signal.
I hadn't thought about the forget_original_parent() case.

So the fix should be to change the debug code in reparent_to_init()
so it doesn't complain if the exit signal is already SIGCHLD.  Or
just kill it off altogether.


--- linux-2.4.14-pre3/kernel/sched.c	Tue Oct 23 23:09:48 2001
+++ linux-akpm/kernel/sched.c	Sun Oct 28 17:23:26 2001
@@ -1250,11 +1250,6 @@ void reparent_to_init(void)
 	SET_LINKS(this_task);
 
 	/* Set the exit signal to SIGCHLD so we signal init on exit */
-	if (this_task->exit_signal != 0) {
-		printk(KERN_ERR "task `%s' exit_signal %d in "
-				__FUNCTION__ "\n",
-			this_task->comm, this_task->exit_signal);
-	}
 	this_task->exit_signal = SIGCHLD;
 
 	/* We also take the runqueue_lock while altering task fields

-
