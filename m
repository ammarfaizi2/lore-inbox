Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751556AbWH3GNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbWH3GNW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 02:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbWH3GNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 02:13:22 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:62162 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751548AbWH3GNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 02:13:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17653.11388.637189.113422@cargo.ozlabs.ibm.com>
Date: Wed, 30 Aug 2006 16:13:16 +1000
From: Paul Mackerras <paulus@samba.org>
To: Olaf Hering <olaf@aepfle.de>
Cc: Nathan Lynch <ntl@pobox.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@ozlabs.org
Subject: Re: Linux v2.6.18-rc5
In-Reply-To: <20060829155216.GA25861@aepfle.de>
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org>
	<20060829115537.GA24256@aepfle.de>
	<20060829130629.GW11309@localdomain>
	<20060829155216.GA25861@aepfle.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf,

This patch should fix it.  The problem was that I was comparing a
32-bit quantity with a 64-bit quantity, and consequently time wasn't
advancing.  This makes us use a 64-bit quantity on all platforms,
which ends up simplifying the code since we can now get rid of the
tb_last_stamp variable (which actually fixes another bug that Ben H
and I noticed while going carefully through the code).

This works fine on my G4 tibook.  Let me know how it goes on your
machines.

Paul.

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 18e59e4..a124499 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -125,15 +125,8 @@ static long timezone_offset;
 unsigned long ppc_proc_freq;
 unsigned long ppc_tb_freq;
 
-u64 tb_last_jiffy __cacheline_aligned_in_smp;
-unsigned long tb_last_stamp;
-
-/*
- * Note that on ppc32 this only stores the bottom 32 bits of
- * the timebase value, but that's enough to tell when a jiffy
- * has passed.
- */
-DEFINE_PER_CPU(unsigned long, last_jiffy);
+static u64 tb_last_jiffy __cacheline_aligned_in_smp;
+static DEFINE_PER_CPU(u64, last_jiffy);
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 /*
@@ -458,7 +451,7 @@ void do_gettimeofday(struct timeval *tv)
 		do {
 			seq = read_seqbegin_irqsave(&xtime_lock, flags);
 			sec = xtime.tv_sec;
-			nsec = xtime.tv_nsec + tb_ticks_since(tb_last_stamp);
+			nsec = xtime.tv_nsec + tb_ticks_since(tb_last_jiffy);
 		} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
 		usec = nsec / 1000;
 		while (usec >= 1000000) {
@@ -700,7 +693,6 @@ #endif
 		tb_next_jiffy = tb_last_jiffy + tb_ticks_per_jiffy;
 		if (per_cpu(last_jiffy, cpu) >= tb_next_jiffy) {
 			tb_last_jiffy = tb_next_jiffy;
-			tb_last_stamp = per_cpu(last_jiffy, cpu);
 			do_timer(regs);
 			timer_recalc_offset(tb_last_jiffy);
 			timer_check_rtc();
@@ -749,7 +741,7 @@ void __init smp_space_timers(unsigned in
 	int i;
 	unsigned long half = tb_ticks_per_jiffy / 2;
 	unsigned long offset = tb_ticks_per_jiffy / max_cpus;
-	unsigned long previous_tb = per_cpu(last_jiffy, boot_cpuid);
+	u64 previous_tb = per_cpu(last_jiffy, boot_cpuid);
 
 	/* make sure tb > per_cpu(last_jiffy, cpu) for all cpus always */
 	previous_tb -= tb_ticks_per_jiffy;
@@ -830,7 +822,7 @@ #endif
 	 * and therefore the (jiffies - wall_jiffies) computation
 	 * has been removed.
 	 */
-	tb_delta = tb_ticks_since(tb_last_stamp);
+	tb_delta = tb_ticks_since(tb_last_jiffy);
 	tb_delta = mulhdu(tb_delta, do_gtod.varp->tb_to_xs); /* in xsec */
 	new_nsec -= SCALE_XSEC(tb_delta, 1000000000);
 
@@ -950,8 +942,7 @@ void __init time_init(void)
 	if (__USE_RTC()) {
 		/* 601 processor: dec counts down by 128 every 128ns */
 		ppc_tb_freq = 1000000000;
-		tb_last_stamp = get_rtcl();
-		tb_last_jiffy = tb_last_stamp;
+		tb_last_jiffy = get_rtcl();
 	} else {
 		/* Normal PowerPC with timebase register */
 		ppc_md.calibrate_decr();
@@ -959,7 +950,7 @@ void __init time_init(void)
 		       ppc_tb_freq / 1000000, ppc_tb_freq % 1000000);
 		printk(KERN_DEBUG "time_init: processor frequency   = %lu.%.6lu MHz\n",
 		       ppc_proc_freq / 1000000, ppc_proc_freq % 1000000);
-		tb_last_stamp = tb_last_jiffy = get_tb();
+		tb_last_jiffy = get_tb();
 	}
 
 	tb_ticks_per_jiffy = ppc_tb_freq / HZ;
@@ -1036,7 +1027,7 @@ void __init time_init(void)
 	do_gtod.varp = &do_gtod.vars[0];
 	do_gtod.var_idx = 0;
 	do_gtod.varp->tb_orig_stamp = tb_last_jiffy;
-	__get_cpu_var(last_jiffy) = tb_last_stamp;
+	__get_cpu_var(last_jiffy) = tb_last_jiffy;
 	do_gtod.varp->stamp_xsec = (u64) xtime.tv_sec * XSEC_PER_SEC;
 	do_gtod.tb_ticks_per_sec = tb_ticks_per_sec;
 	do_gtod.varp->tb_to_xs = tb_to_xs;
diff --git a/include/asm-powerpc/time.h b/include/asm-powerpc/time.h
index dcde441..5785ac4 100644
--- a/include/asm-powerpc/time.h
+++ b/include/asm-powerpc/time.h
@@ -30,10 +30,6 @@ extern unsigned long tb_ticks_per_usec;
 extern unsigned long tb_ticks_per_sec;
 extern u64 tb_to_xs;
 extern unsigned      tb_to_us;
-extern unsigned long tb_last_stamp;
-extern u64 tb_last_jiffy;
-
-DECLARE_PER_CPU(unsigned long, last_jiffy);
 
 struct rtc_time;
 extern void to_tm(int tim, struct rtc_time * tm);
