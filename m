Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267217AbTBILrV>; Sun, 9 Feb 2003 06:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267218AbTBILrU>; Sun, 9 Feb 2003 06:47:20 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:29553 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S267217AbTBILrT>; Sun, 9 Feb 2003 06:47:19 -0500
Date: Sun, 9 Feb 2003 03:56:50 -0800
Message-Id: <200302091156.h19BuoH07869@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Anton Blanchard <anton@samba.org>,
       Andrew Morton <akpm@digeo.com>, Arjan van de Ven <arjanv@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: heavy handed exit() in latest BK
In-Reply-To: Ingo Molnar's message of  Sunday, 9 February 2003 12:40:32 +0100 <Pine.LNX.4.44.0302091236590.4454-100000@localhost.localdomain>
X-Shopping-List: (1) Despondent ablutions
   (2) Intrusive cagey pliers
   (3) Buy & Break Mystic coolants
   (4) Dynamic fission
   (5) Climactic bear rodents
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  - a read_lock(&tasklist_lock) is missing around the group_send_sig_info()
>    in send_sig_info().

Indeed.  I still intend to clean up those entry points and haven't gotten
to it, so I hadn't bothered with this yet either (though I think I sent it
to you for the backport).  It certainly does bite in practice, e.g. SIGPIPE.

There is a similar failure to take the lock before using zap_other_threads.
I thought I sent this patch before, but it's not in 2.5 yet.

--- /home/roland/redhat/linux-2.5.59-1.1007/fs/exec.c.~1~	Fri Feb  7 20:04:27 2003
+++ /home/roland/redhat/linux-2.5.59-1.1007/fs/exec.c	Sun Feb  9 03:43:36 2003
@@ -601,9 +601,12 @@ static inline int de_thread(struct task_
 
 	if (thread_group_empty(current))
 		goto no_thread_group;
+
 	/*
-	 * Kill all other threads in the thread group:
+	 * Kill all other threads in the thread group.
+	 * We must hold tasklist_lock to call zap_other_threads.
 	 */
+	read_lock(&tasklist_lock);
 	spin_lock_irq(lock);
 	if (oldsig->group_exit) {
 		/*
@@ -611,6 +614,7 @@ static inline int de_thread(struct task_
 		 * return so that the signal is processed.
 		 */
 		spin_unlock_irq(lock);
+		read_unlock(&tasklist_lock);
 		kmem_cache_free(sighand_cachep, newsighand);
 		if (newsig)
 			kmem_cache_free(signal_cachep, newsig);
@@ -629,12 +633,15 @@ static inline int de_thread(struct task_
 		oldsig->group_exit_task = current;
 		current->state = TASK_UNINTERRUPTIBLE;
 		spin_unlock_irq(lock);
+		read_unlock(&tasklist_lock);
 		schedule();
+		read_lock(&tasklist_lock);
 		spin_lock_irq(lock);
 		if (oldsig->group_exit_task)
 			BUG();
 	}
 	spin_unlock_irq(lock);
+	read_unlock(&tasklist_lock);
 
 	/*
 	 * At this point all other threads have exited, all we have to


>  - session-IDs and group-IDs are set outside the tasklist lock. This
>    causes breakage in the USB code. The correct fix is to do this:

This is outside the part of the code that I've touched lately.


Thanks,
Roland
