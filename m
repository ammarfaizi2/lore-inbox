Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161380AbWATFMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161380AbWATFMK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 00:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161389AbWATFMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 00:12:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19437 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161380AbWATFMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 00:12:08 -0500
Date: Thu, 19 Jan 2006 21:11:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, mingo@elte.hu,
       george@wildturkeyranch.net, rostedt@goodmis.org
Subject: Re: [PATCH 7/7] [hrtimers] Set correct initial expiry time for
 relative SIGEV_NONE timers
Message-Id: <20060119211126.0ed279c2.akpm@osdl.org>
In-Reply-To: <20060120021343.296071000@tglx.tec.linutronix.de>
References: <20060120021336.134802000@tglx.tec.linutronix.de>
	<20060120021343.296071000@tglx.tec.linutronix.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> wrote:
>
> 
> The expiry time for relative timers with SIGEV_NONE set was never
> updated to the correct value.
> 

Ahem.

> +		if (mode == HRTIMER_REL)
> +			timer->expires = ktime_add(timer-expires,
> +						   timer->base->get_time());

doesn't compile, hence isn't tested.

Please confirm that with the below fix we get something which works OK?

--- devel/kernel/posix-timers.c~hrtimers-set-correct-initial-expiry-time-for-relative-fix	2006-01-19 21:08:44.000000000 -0800
+++ devel-akpm/kernel/posix-timers.c	2006-01-19 21:08:44.000000000 -0800
@@ -727,7 +727,7 @@ common_timer_set(struct k_itimer *timr, 
 	if (((timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE)) {
 		/* Setup correct expiry time for relative timers */
 		if (mode == HRTIMER_REL)
-			timer->expires = ktime_add(timer-expires,
+			timer->expires = ktime_add(timer->expires,
 						   timer->base->get_time());
 		return 0;
 	}
_
