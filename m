Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262519AbVCVFt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262519AbVCVFt6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 00:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262472AbVCVFr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 00:47:29 -0500
Received: from fire.osdl.org ([65.172.181.4]:64981 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262469AbVCVFnb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 00:43:31 -0500
Date: Mon, 21 Mar 2005 21:43:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, christoph@lameter.com,
       kenneth.w.chen@intel.com
Subject: Re: [PATCH 6/5] timers: enable irqs in __mod_timer()
Message-Id: <20050321214305.3b7af964.akpm@osdl.org>
In-Reply-To: <423ED7E4.2A1F0970@tv-sign.ru>
References: <423ED7E4.2A1F0970@tv-sign.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> wrote:
>
> If the timer is currently running on another CPU, __mod_timer()
>  spins with interrupts disabled and timer->lock held. I think it
>  is better to spin_unlock_irqrestore(&timer->lock) in __mod_timer's
>  retry path.
> 
>  This patch is unneccessary long. It is because it tries to cleanup
>  the code a bit. I do not like the fact that lock+test+unlock pattern
>  is duplicated in the code.
> 
>  If you think that this patch uglifies the code or does not match
>  kernel's coding style - just say nack :)

I've seen worse ;)

I think this makes it a bit more kernel-like?

--- 25/kernel/timer.c~timers-enable-irqs-in-__mod_timer-tidy	2005-03-21 21:41:03.000000000 -0800
+++ 25-akpm/kernel/timer.c	2005-03-21 21:41:57.000000000 -0800
@@ -174,12 +174,13 @@ int __mod_timer(struct timer_list *timer
 {
 	tvec_base_t *old_base, *new_base;
 	unsigned long flags;
-	int new_lock, ret;
+	int new_lock;
+	int ret = -1;
 
 	BUG_ON(!timer->function);
 	check_timer(timer);
 
-	for (ret = -1; ret < 0; ) {
+	do {
 		spin_lock_irqsave(&timer->lock, flags);
 		new_base = &__get_cpu_var(tvec_bases);
 		old_base = timer_base(timer);
@@ -227,7 +228,7 @@ unlock:
 		if (new_lock)
 			spin_unlock(&new_base->lock);
 		spin_unlock_irqrestore(&timer->lock, flags);
-	}
+	} while (ret == -1);
 
 	return ret;
 }
_

