Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265746AbUGITW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265746AbUGITW1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 15:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265655AbUGITW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 15:22:26 -0400
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:49630 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S265782AbUGITVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 15:21:45 -0400
Message-ID: <40EEF10F.1030404@am.sony.com>
Date: Fri, 09 Jul 2004 12:25:03 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] preset loops_per_jiffy for faster booting
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch which allows developers or users to preset the
value for loops per jiffy.  This avoids the overhead of
performing the calibration at boot time.  This saves about
250 milliseconds on many non-x86 architectures, and about
25 milliseconds on x86.  (The amount of time saved depends
on the value of HZ, and NOT on the processor speed.)

Besides allowing a value to be compiled in, the patch also allows
the value to be specified on the kernel command line with
the syntax: "lpj=xxx"  This is available whether the code
is configured with the option or not.

Finally, this code adds a new FASTBOOT menu to the kernel
config system, where we (CE Linux Forum developers) would like
to add this and other config options which can be used to
reduce kernel bootup time.

This technique (of disabling calibration for loops_per_jiffy)
is used by many embedded developers for reducing bootup time.

More commentary on this issue is available at:
http://tree.celinuxforum.org/pubwiki/moin.cgi/PresetLPJ

Comments are welcome.

Thanks.

=============================
Tim Bird
Bootup Time Working Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
E-mail: tim.bird@am.sony.com
=============================

preset-lpj.patch:


Signed-off-by: Tim Bird <tim.bird@am.sony.com> for CELF
---

  Kconfig |   35 ++++++++++++++++++++++++++++
  main.c  |   78 +++++++++++++++++++++++++++++++++++++++++-----------------------
  2 files changed, 86 insertions(+), 27 deletions(-)


diff -ruN -x CVS -x '.#*' -X dontdiff tag_LINUX_2_6_7/init/Kconfig branch_PRESET_LPJ/init/Kconfig
--- tag_LINUX_2_6_7/init/Kconfig	2004-06-18 17:13:03.000000000 -0700
+++ branch_PRESET_LPJ/init/Kconfig	2004-06-22 13:16:05.000000000 -0700
@@ -218,6 +218,41 @@
  	  This option enables access to kernel configuration file and build
  	  information through /proc/config.gz.

+menuconfig FASTBOOT
+	bool "Fast boot options"
+	help
+	  Say Y here to enable faster booting of the Linux kernel.  If you
+	  say Y here, you may be asked to provide hardcoded values for some
+	  parameters that the kernel usually determines automatically.
+
+	  If unsure, say N.
+
+config USE_PRESET_LPJ
+	bool "Use preset loops_per_jiffy" if FASTBOOT
+	help
+	  Say Y here to use a preset value for loops_per_jiffy.  This
+	  is a value used internally in the kernel for busywait delays.
+	  Calculating this value at boot time can take up to 250 ms.
+	  Saying Y here, and specifying the value (next) will save
+	  this time during boot up.
+
+	  If unsure, say N.
+
+config PRESET_LPJ
+	int "Preset loops_per_jiffy" if USE_PRESET_LPJ
+	help
+	  This is the number of loops used by delay() to achieve a single
+	  jiffy of delay inside the kernel.  It is roughly BogoMips * 5000.
+	  To determine the correct value for your kernel, first turn off
+	  the fast booting option, compile and boot the kernel on your
+	  target hardware, then see what value is printed during the
+	  kernel boot.  Use that value here.
+
+	  If unsure, don't enable the "Use preset loops_per_jiffy" option.
+	  An incorrect value will cause delays in the kernel to be
+	  incorrect.  Although unlikely, in the extreme case this might
+	  damage your hardware.
+

  menuconfig EMBEDDED
  	bool "Configure standard kernel features (for small systems)"
diff -ruN -x CVS -x '.#*' -X dontdiff tag_LINUX_2_6_7/init/main.c branch_PRESET_LPJ/init/main.c
--- tag_LINUX_2_6_7/init/main.c	2004-06-18 17:13:02.000000000 -0700
+++ branch_PRESET_LPJ/init/main.c	2004-06-22 13:16:05.000000000 -0700
@@ -167,6 +167,15 @@
  	return 0;
  }

+static int __init lpj_setup(char *str)
+{
+	/* low bit indicates a value provided at boot time */
+	loops_per_jiffy = simple_strtoul(str,NULL,10) | 1;
+	return 1;
+}
+
+__setup("lpj=", lpj_setup);
+
  /* this should be approx 2 Bo*oMips to start (note initial shift), and will
     still work even if initially too large, it will just take slightly longer */
  unsigned long loops_per_jiffy = (1<<12);
@@ -183,40 +192,55 @@
  	unsigned long ticks, loopbit;
  	int lps_precision = LPS_PREC;

-	loops_per_jiffy = (1<<12);
-
-	printk("Calibrating delay loop... ");
-	while ((loops_per_jiffy <<= 1) != 0) {
-		/* wait for "start of" clock tick */
-		ticks = jiffies;
-		while (ticks == jiffies)
-			/* nothing */;
-		/* Go .. */
-		ticks = jiffies;
-		__delay(loops_per_jiffy);
-		ticks = jiffies - ticks;
-		if (ticks)
-			break;
+#ifdef CONFIG_USE_PRESET_LPJ
+	/* if lpj is not provided on command line, use preset value */
+	if ((loops_per_jiffy & 1) == 0) {
+		loops_per_jiffy = CONFIG_PRESET_LPJ | 1;
  	}
+#endif /* CONFIG_USE_PRESET_LPJ */

-/* Do a binary approximation to get loops_per_jiffy set to equal one clock
-   (up to lps_precision bits) */
-	loops_per_jiffy >>= 1;
-	loopbit = loops_per_jiffy;
-	while ( lps_precision-- && (loopbit >>= 1) ) {
-		loops_per_jiffy |= loopbit;
-		ticks = jiffies;
-		while (ticks == jiffies);
-		ticks = jiffies;
-		__delay(loops_per_jiffy);
-		if (jiffies != ticks)	/* longer than 1 tick */
-			loops_per_jiffy &= ~loopbit;
+	if (loops_per_jiffy & 1) {
+		printk("Calibrating delay loop (skipped)... ");
+	} else {
+
+		printk("Calibrating delay loop... ");
+		while ((loops_per_jiffy <<= 1) != 0) {
+			/* wait for "start of" clock tick */
+			ticks = jiffies;
+			while (ticks == jiffies)
+				/* nothing */;
+			/* Go .. */
+			ticks = jiffies;
+			__delay(loops_per_jiffy);
+			ticks = jiffies - ticks;
+			if (ticks)
+				break;
+		}
+
+	/* Do a binary approximation to get loops_per_jiffy set to equal one clock
+	   (up to lps_precision bits) */
+		loops_per_jiffy >>= 1;
+		loopbit = loops_per_jiffy;
+		while ( lps_precision-- && (loopbit >>= 1) ) {
+			loops_per_jiffy |= loopbit;
+			ticks = jiffies;
+			while (ticks == jiffies);
+			ticks = jiffies;
+			__delay(loops_per_jiffy);
+			if (jiffies != ticks)	/* longer than 1 tick */
+				loops_per_jiffy &= ~loopbit;
+		}
  	}

-/* Round the value and print it */	
+/* Round the value and print it */
  	printk("%lu.%02lu BogoMIPS\n",
  		loops_per_jiffy/(500000/HZ),
  		(loops_per_jiffy/(5000/HZ)) % 100);
+
+#ifndef CONFIG_USE_PRESET_LPJ
+	printk("Set 'Preset loops_per_jiffy'=%lu for preset lpj.\n",
+		loops_per_jiffy);
+#endif /* CONFIG_USE_PRESET_LPJ */
  }

  static int __init debug_kernel(char *str)
