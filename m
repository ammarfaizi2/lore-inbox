Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965001AbWGIGZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbWGIGZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 02:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbWGIGZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 02:25:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27033 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965001AbWGIGZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 02:25:27 -0400
Date: Sat, 8 Jul 2006 23:25:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: jfannin@gmail.com (Joseph Fannin)
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, arjan@infradead.org
Subject: Re: [LOCKDEP] 2.6.18-rc1: inconsistent {hardirq-on-W} ->
 {in-hardirq-W} usage
Message-Id: <20060708232512.12b59269.akpm@osdl.org>
In-Reply-To: <20060709050525.GA1149@nineveh.rivenstone.net>
References: <20060709050525.GA1149@nineveh.rivenstone.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jul 2006 01:05:26 -0400
jfannin@gmail.com (Joseph Fannin) wrote:

> [   22.488000]
> [   22.488000] =================================
> [   22.488000] [ INFO: inconsistent lock state ]
> [   22.488000] ---------------------------------
> [   22.488000] inconsistent {hardirq-on-W} -> {in-hardirq-W} usage.
> [   22.488000] udevd/2684 [HC1[1]:SC0[0]:HE0:SE1] takes:
> [   22.488000]  (rtc_lock){+-..}, at: [<c0278c1c>] rtc_get_rtc_time+0x2c/0x1a0
> [   22.488000] {hardirq-on-W} state was registered at:
> [   22.488000]   [<c0144229>] lock_acquire+0x69/0x90
> [   22.488000]   [<c033c020>] _spin_lock+0x40/0x50
> [   22.488000]   [<c0106fa3>] get_cmos_time+0x13/0x170
> [   22.488000]   [<c048daeb>] hpet_time_init+0xb/0x70
> [   22.488000]   [<c0487744>] start_kernel+0x1f4/0x470
> [   22.488000]   [<c0100210>] 0xc0100210
> [   22.488000] irq event stamp: 193648

yup, thanks, bug.

--- a/arch/i386/kernel/time.c~get_cmos_time-locking-fix
+++ a/arch/i386/kernel/time.c
@@ -206,15 +206,16 @@ irqreturn_t timer_interrupt(int irq, voi
 unsigned long get_cmos_time(void)
 {
 	unsigned long retval;
+	unsigned long flags;
 
-	spin_lock(&rtc_lock);
+	spin_lock_irqsave(&rtc_lock, flags);
 
 	if (efi_enabled)
 		retval = efi_get_time();
 	else
 		retval = mach_get_cmos_time();
 
-	spin_unlock(&rtc_lock);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return retval;
 }
_

