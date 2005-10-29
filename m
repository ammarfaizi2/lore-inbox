Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbVJ2C5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbVJ2C5I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 22:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbVJ2C5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 22:57:08 -0400
Received: from mtiwmhc11.worldnet.att.net ([204.127.131.115]:62922 "EHLO
	mtiwmhc11.worldnet.att.net") by vger.kernel.org with ESMTP
	id S1751106AbVJ2C5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 22:57:07 -0400
From: larry.finger@att.net (Larry.Finger@lwfinger.net)
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.14 - Fix for incorrect CPU speed determination in powernow for i386
Date: Sat, 29 Oct 2005 02:57:06 +0000
Message-Id: <102920050257.11500.4362E5020003C9EF00002CEC21602813029D0A09020700D2979D9D0E04@att.net>
X-Mailer: AT&T Message Center Version 1 (Feb 14 2005)
X-Authenticated-Sender: bGFycnkuZmluZ2VyQGF0dC5uZXQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On an HP ze1115 notebook with a Mobile AMD K7, the CPU speed is measured twice, once when the CPU is initialized, and a second time when the powerrnow system is started. Sometimes the two readings agree; however, the second reading is usually higher, sometimes by very large factors. The dmesg excerpts below show one case where the difference is small.

Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1100.134 MHz process


powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
Detected 1148.044 MHz processor.
powernow: SGTC: 10000
powernow: Minimum speed 521 MHz. Maximum speed 1148 MHz.

The cpu frequency on this machine is measured using calibrate_tsc, which calls mach_countup between rdtsc calls. When the second speed determination is made, interrupts have been enabled, which makes the loop counter value in mach_count to be too small and the cpu frequency to be too high.

The two-line patch against 2.6.14 is shown below. With it, a second (faulty) determination of cpu_khz is avoided. BTW, this fix handles Bugzilla bugs #5266 and 5435.


Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

---

diff --git a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c
+++ b/arch/i386/kernel/time.c
@@ -78,7 +78,7 @@ u64 jiffies_64 = INITIAL_JIFFIES;

 EXPORT_SYMBOL(jiffies_64);

-unsigned int cpu_khz;  /* Detected as we calibrate the TSC */
+unsigned int cpu_khz=0; /* Detected as we calibrate the TSC */
 EXPORT_SYMBOL(cpu_khz);

 extern unsigned long wall_jiffies;
diff --git a/arch/i386/kernel/timers/common.c b/arch/i386/kernel/timers/common.c
--- a/arch/i386/kernel/timers/common.c
+++ b/arch/i386/kernel/timers/common.c
@@ -151,7 +151,7 @@ unsigned long read_timer_tsc(void)
 /* calculate cpu_khz */
 void init_cpu_khz(void)
 {
-       if (cpu_has_tsc) {
+       if (cpu_has_tsc && !cpu_khz) {
                unsigned long tsc_quotient = calibrate_tsc();
                if (tsc_quotient) {
                        /* report CPU clock rate in Hz.

