Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752031AbWCCDbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbWCCDbO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 22:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752081AbWCCDbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 22:31:14 -0500
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:6567 "EHLO
	topsns2.toshiba-tops.co.jp") by vger.kernel.org with ESMTP
	id S1752031AbWCCDbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 22:31:13 -0500
Date: Fri, 03 Mar 2006 12:31:10 +0900 (JST)
Message-Id: <20060303.123110.32501622.nemoto@toshiba-tops.co.jp>
To: akpm@osdl.org
Cc: ram.gupta5@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix potential jiffies overflow
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060302184502.5177c9db.akpm@osdl.org>
References: <728201270603020843s4feacb1cv3a8acc620e636ffa@mail.gmail.com>
	<20060303.113246.01208537.nemoto@toshiba-tops.co.jp>
	<20060302184502.5177c9db.akpm@osdl.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 2 Mar 2006 18:45:02 -0800, Andrew Morton <akpm@osdl.org> said:
akpm> Thanks, that looks like 2.6.16 material.

akpm> What happens if the machine slept for more than 49.7 days?

Well, jiffies will lose 49.7 days...  Then, how about this?  We can
sleep 136 years.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
index a14d594..be5d079 100644
--- a/arch/i386/kernel/time.c
+++ b/arch/i386/kernel/time.c
@@ -400,7 +400,7 @@ static int timer_resume(struct sys_devic
 {
 	unsigned long flags;
 	unsigned long sec;
-	unsigned long sleep_length;
+	u64 sleep_length;
 
 #ifdef CONFIG_HPET_TIMER
 	if (is_hpet_enabled())
@@ -408,7 +408,7 @@ static int timer_resume(struct sys_devic
 #endif
 	setup_pit_timer();
 	sec = get_cmos_time() + clock_cmos_diff;
-	sleep_length = (get_cmos_time() - sleep_start) * HZ;
+	sleep_length = (u64)(get_cmos_time() - sleep_start) * HZ;
 	write_seqlock_irqsave(&xtime_lock, flags);
 	xtime.tv_sec = sec;
 	xtime.tv_nsec = 0;

