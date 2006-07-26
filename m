Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030392AbWGZGTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030392AbWGZGTI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 02:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030394AbWGZGTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 02:19:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57804 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030315AbWGZGTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 02:19:06 -0400
Date: Tue, 25 Jul 2006 23:18:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Sukadev Bhattiprolu <sukadev@us.ibm.com>
Cc: achirica@gmail.com, hch@infradead.org, linville@tuxdriver.com,
       haveblue@us.ibm.com, serue@us.ibm.com, clr@fr.ibm.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kthread: airo.c
Message-Id: <20060725231839.6a69a85e.akpm@osdl.org>
In-Reply-To: <20060724181309.GA23938@us.ibm.com>
References: <20060713205319.GA23594@us.ibm.com>
	<20060724181309.GA23938@us.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2006 11:13:09 -0700
Sukadev Bhattiprolu <sukadev@us.ibm.com> wrote:

> Sukadev Bhattiprolu [sukadev@us.ibm.com] wrote:
> 
> | Andrew,
> | 
> | Javier Achirica, one of the major contributors to drivers/net/wireless/airo.c
> | took a look at this patch, and doesn't have any problems with it. It doesn't
> | fix any bugs and is just a cleanup, so it certainly isn't a candidate
> | for this mainline cycle
> 
> Here is the same patch, merged up to 2.6.18-rc2. Christoph's patch (see
> http://lkml.org/lkml/2006/7/13/332) still applies cleanly on top of this.
> 
> -----
> The airo driver is currently caching a pid for later use, but with the
> implementation of containers, pids themselves do not uniquely identify
> a task. The driver is also using kernel_thread() which is deprecated in
> drivers.
> 
> This patch essentially replaces the kernel_thread() with kthread_create().
> It also stores the task_struct of the airo_thread rather than its pid.
> Since this introduces a second task_struct in struct airo_info, the patch
> renames airo_info.task to airo_info.list_bss_task.
> 
> As an extension of these changes, the patch further:
> 
>          - replaces kill_proc() with kthread_stop()
>          - replaces signal_pending() with kthread_should_stop()
> 	 - removes thread completion synchronisation which is handled by
> 	   kthread_stop().
> 
> ..
>
> @@ -1736,9 +1736,9 @@ static int readBSSListRid(struct airo_in
>  		issuecommand(ai, &cmd, &rsp);
>  		up(&ai->sem);
>  		/* Let the command take effect */
> -		ai->task = current;
> +		ai->list_bss_task = current;
>  		ssleep(3);
> -		ai->task = NULL;
> +		ai->list_bss_task = NULL;

This looks a little racy to me.  It's relatively benign - a race will cause
us to sleep for too long.  But it's easy to fix:


--- a/drivers/net/wireless/airo.c~kthread-airoc-race-fix
+++ a/drivers/net/wireless/airo.c
@@ -1733,10 +1733,10 @@ static int readBSSListRid(struct airo_in
 		cmd.cmd=CMD_LISTBSS;
 		if (down_interruptible(&ai->sem))
 			return -ERESTARTSYS;
+		ai->list_bss_task = current;
 		issuecommand(ai, &cmd, &rsp);
 		up(&ai->sem);
 		/* Let the command take effect */
-		ai->list_bss_task = current;
 		ssleep(3);
 		ai->list_bss_task = NULL;
 	}
_

<looks more closely>

Actually, ssleep() ends up doing

        while (timeout)
                timeout = schedule_timeout_uninterruptible(timeout);

so if the intent of this code is to terminate the sleep early, when the
interrupt has happened then it isn't working right.  A fix would be to
convert the ssleep(3) into schedule_timeout_uninterruptible(3 * HZ).
