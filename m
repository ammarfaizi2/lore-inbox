Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVDESow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVDESow (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 14:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVDESmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 14:42:54 -0400
Received: from mx1.elte.hu ([157.181.1.137]:59875 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261897AbVDESiw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 14:38:52 -0400
Date: Tue, 5 Apr 2005 20:34:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
Message-ID: <20050405183413.GA7122@elte.hu>
References: <20050405000524.592fc125.akpm@osdl.org> <425240C5.1050706@ens-lyon.org> <20050405083001.GA28068@elte.hu> <42524EE2.5010703@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42524EE2.5010703@ens-lyon.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:

> >could you send the full bootlog (starting at the 'gcc...' line)? I'm not 
> >sure whether TSC calibration was done on your CPU. If cyc2ns_scale is 
> >not set up then sched_clock() will return 0, and this could result in 
> >that printk symptom.
> 
> Here you are.

weird - none of the WARN_ON(1)'s show up. In particular, the 
sched_clock() ones should have triggered at least once! I've attached a 
new version of the patch below (please unapply the previous patch), 
could you try it and send me the log?  (It will unconditionally print 
something in tsc_init(), which is always called during the boot 
process.)

	Ingo

--- linux/arch/i386/kernel/timers/timer_tsc.c.orig
+++ linux/arch/i386/kernel/timers/timer_tsc.c
@@ -137,16 +137,15 @@ static unsigned long long monotonic_cloc
 unsigned long long sched_clock(void)
 {
 	unsigned long long this_offset;
+	static int once = 1;
 
-	/*
-	 * In the NUMA case we dont use the TSC as they are not
-	 * synchronized across all CPUs.
-	 */
-#ifndef CONFIG_NUMA
-	if (!use_tsc)
-#endif
+	if (!cpu_has_tsc) {
+		if (once) { once = 0; WARN_ON(1); }
 		/* no locking but a rare wrong value is not a big deal */
 		return jiffies_64 * (1000000000 / HZ);
+	}
+
+	if (once) { once = 0; WARN_ON(1); }
 
 	/* Read the Time Stamp Counter */
 	rdtscll(this_offset);
@@ -434,7 +433,8 @@ static void mark_offset_tsc(void)
 
 static int __init init_tsc(char* override)
 {
-
+	printk("TSC init.\n");
+	WARN_ON(1);
 	/* check clock override */
 	if (override[0] && strncmp(override,"tsc",3)) {
 #ifdef CONFIG_HPET_TIMER
@@ -443,6 +443,7 @@ static int __init init_tsc(char* overrid
 		} else
 #endif
 		{
+			WARN_ON(1);
 			return -ENODEV;
 		}
 	}
@@ -518,8 +519,10 @@ static int __init init_tsc(char* overrid
 			}
 			set_cyc2ns_scale(cpu_khz/1000);
 			return 0;
-		}
+		} else
+			WARN_ON(1);
 	}
+	WARN_ON(1);
 	return -ENODEV;
 }
 
@@ -528,12 +531,14 @@ static int __init init_tsc(char* overrid
  * in cpu/common.c */
 static int __init tsc_setup(char *str)
 {
+	WARN_ON(1);
 	tsc_disable = 1;
 	return 1;
 }
 #else
 static int __init tsc_setup(char *str)
 {
+	WARN_ON(1);
 	printk(KERN_WARNING "notsc: Kernel compiled with CONFIG_X86_TSC, "
 				"cannot disable TSC.\n");
 	return 1;
--- linux/arch/i386/kernel/timers/common.c.orig
+++ linux/arch/i386/kernel/timers/common.c
@@ -39,8 +39,10 @@ unsigned long __init calibrate_tsc(void)
 
 
 		/* Error: ECTCNEVERSET */
-		if (count <= 1)
+		if (count <= 1) {
+			WARN_ON(1);
 			goto bad_ctc;
+		}
 
 		/* 64-bit subtract - gcc just messes up with long longs */
 		__asm__("subl %2,%0\n\t"
@@ -50,12 +52,16 @@ unsigned long __init calibrate_tsc(void)
 			 "0" (endlow), "1" (endhigh));
 
 		/* Error: ECPUTOOFAST */
-		if (endhigh)
+		if (endhigh) {
+			WARN_ON(1);
 			goto bad_ctc;
+		}
 
 		/* Error: ECPUTOOSLOW */
-		if (endlow <= CALIBRATE_TIME)
+		if (endlow <= CALIBRATE_TIME) {
+			WARN_ON(1);
 			goto bad_ctc;
+		}
 
 		__asm__("divl %2"
 			:"=a" (endlow), "=d" (endhigh)
@@ -107,12 +113,16 @@ unsigned long __init calibrate_tsc_hpet(
 		 "0" (tsc_endlow), "1" (tsc_endhigh));
 
 	/* Error: ECPUTOOFAST */
-	if (tsc_endhigh)
+	if (tsc_endhigh) {
+		WARN_ON(1);
 		goto bad_calibration;
+	}
 
 	/* Error: ECPUTOOSLOW */
-	if (tsc_endlow <= CALIBRATE_TIME_HPET)
+	if (tsc_endlow <= CALIBRATE_TIME_HPET) {
+		WARN_ON(1);
 		goto bad_calibration;
+	}
 
 	ASM_DIV64_REG(result, remain, tsc_endlow, 0, CALIBRATE_TIME_HPET);
 	if (remain > (tsc_endlow >> 1))
