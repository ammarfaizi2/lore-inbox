Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbWGHA4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbWGHA4K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 20:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWGHA4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 20:56:10 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:16649 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932474AbWGHA4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 20:56:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=hysOEc40XnH+sLtdRUUIaSyQ/uKBtBDjMPzedjlA3rLqIU2qouRCocIPdDvdEQ5c6tgYSFlW9nYsIIaz4s3RIHUC9agE2MutOdPbFZtTyEnDnqeVOlIBHYVIX7Q7I731SOnQAz5Nbxl5H8js0AnRNNJy2H5KX+7qQScxxaCaO8o=
Message-ID: <44AF02A3.3010705@gmail.com>
Date: Sat, 08 Jul 2006 08:56:03 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: framebuffer console code triggered might_sleep assertion.
References: <20060707220951.GA3356@redhat.com>
In-Reply-To: <20060707220951.GA3356@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> Whilst printk'ing to both console and serial console, I got this...
> (2.6.18rc1)
> 
> 		Dave
> 
> 
> BUG: sleeping function called from invalid context at kernel/sched.c:4438
> in_atomic():0, irqs_disabled():1
> 
> Call Trace:
>  [<ffffffff80271db8>] show_trace+0xaa/0x23d
>  [<ffffffff80271f60>] dump_stack+0x15/0x17
>  [<ffffffff8020b9f8>] __might_sleep+0xb2/0xb4
>  [<ffffffff8029232e>] __cond_resched+0x15/0x55
>  [<ffffffff80267eb8>] cond_resched+0x3b/0x42
>  [<ffffffff80268c64>] console_conditional_schedule+0x12/0x14
>  [<ffffffff80368159>] fbcon_redraw+0xf6/0x160
>  [<ffffffff80369c58>] fbcon_scroll+0x5d9/0xb52
>  [<ffffffff803a43c4>] scrup+0x6b/0xd6
>  [<ffffffff803a4453>] lf+0x24/0x44
>  [<ffffffff803a7ff8>] vt_console_print+0x166/0x23d
>  [<ffffffff80295528>] __call_console_drivers+0x65/0x76
>  [<ffffffff80295597>] _call_console_drivers+0x5e/0x62
>  [<ffffffff80217e3f>] release_console_sem+0x14b/0x232
>  [<ffffffff8036acd6>] fb_flashcursor+0x279/0x2a6
>  [<ffffffff80251e3f>] run_workqueue+0xa8/0xfb
>  [<ffffffff8024e5e0>] worker_thread+0xef/0x122
>  [<ffffffff8023660f>] kthread+0x100/0x136
>  [<ffffffff8026419e>] child_rip+0x8/0x12
> 
> 

Looks like the printk buffer was flushed on release_console_sem() while
the irqs are disabled. But the console (fbcon) thinks that it's still
okay to schedule() which triggered might_sleep().

Would the attached patch help? It disables console scheduling before
calling the console drivers.

Tony

diff --git a/kernel/printk.c b/kernel/printk.c
index 9940030..f98576d 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -780,6 +780,9 @@ void release_console_sem(void)
 		up(&secondary_console_sem);
 		return;
 	}
+
+	console_may_schedule = 0;
+
 	for ( ; ; ) {
 		spin_lock_irqsave(&logbuf_lock, flags);
 		wake_klogd |= log_start - log_end;
@@ -793,7 +796,6 @@ void release_console_sem(void)
 		local_irq_restore(flags);
 	}
 	console_locked = 0;
-	console_may_schedule = 0;
 	up(&console_sem);
 	spin_unlock_irqrestore(&logbuf_lock, flags);
 	if (wake_klogd && !oops_in_progress && waitqueue_active(&log_wait)) {
