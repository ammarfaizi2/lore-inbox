Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265920AbUGIXBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265920AbUGIXBp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 19:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266013AbUGIXBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 19:01:45 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:4087 "EHLO
	mail.kroptech.com") by vger.kernel.org with ESMTP id S265920AbUGIXBi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 19:01:38 -0400
Date: Fri, 9 Jul 2004 19:35:28 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Tim Bird <tim.bird@am.sony.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] preset loops_per_jiffy for faster booting
Message-ID: <20040709193528.A23508@mail.kroptech.com>
References: <40EEF10F.1030404@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40EEF10F.1030404@am.sony.com>; from tim.bird@am.sony.com on Fri, Jul 09, 2004 at 12:25:03PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 12:25:03PM -0700, Tim Bird wrote:
> Here is a patch which allows developers or users to preset the
> value for loops per jiffy.  This avoids the overhead of
> performing the calibration at boot time.  This saves about
> 250 milliseconds on many non-x86 architectures, and about
> 25 milliseconds on x86.  (The amount of time saved depends
> on the value of HZ, and NOT on the processor speed.)

Here's an alternate patch (compile tested only) which is slightly
simpler, slightly more flexible, and fixes a small bug in the original.

The simplification centers around removing USE_PRESET_LPJ and
interpeting a preset value of 0 as a signal to autodetect. This 
eliminates ifdefs in the code and avoids giving magic significance 
to the loops_per_jiffy LSb. Additionally, the user can always disable
the preset by using "lpj=0" which would allow booting a kernel that
crashes due to a bogus preset. The only problem I can think of with
this approach is if there is a system out there so slow that lpj=0 is
actually a valid setting.

The final change is to fix a small bug in the original patch:
loops_per_jiffy was no longer initialized each time calibrate_delay()
was invoked. This is potentially an issue on SMP systems since
calibrate_delay() will be invoked for each CPU. One related thing to
keep in mind is that on an SMP system, using an lpj preset will result
in the same lpj setting on each CPU. On sane systems this shouldn't be
a problem, but if there's a machine out there with unequal CPUs it will
be a problem. Perhaps this is worth mentioning in the help text as well.

While we're on the topic: Should FASTBOOT perhaps depend on EMBEDDED? I
can imagine a user with a massively MP system perhaps finding this
option useful, so maybe not.

--Adam


--- linux-2.6.7/init/main.c.orig	Mon Jun 21 17:55:09 2004
+++ linux-2.6.7/init/main.c	Fri Jul  9 18:31:50 2004
@@ -167,6 +167,15 @@
 	return 0;
 }
 
+static unsigned long preset_lpj = CONFIG_PRESET_LPJ;
+static int __init lpj_setup(char *str)
+{
+	preset_lpj = simple_strtoul(str,NULL,10);
+	return 1;
+}
+
+__setup("lpj=", lpj_setup);
+
 /* this should be approx 2 Bo*oMips to start (note initial shift), and will
    still work even if initially too large, it will just take slightly longer */
 unsigned long loops_per_jiffy = (1<<12);
@@ -183,40 +192,48 @@
 	unsigned long ticks, loopbit;
 	int lps_precision = LPS_PREC;
 
-	loops_per_jiffy = (1<<12);
+	if (preset_lpj) {
+		loops_per_jiffy = preset_lpj;
+		printk("Calibrating delay loop (skipped)... \n");
+	} else {
+		loops_per_jiffy = (1<<12);
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
+
+	/* Round the value and print it */	
+		printk("%lu.%02lu BogoMIPS\n",
+			loops_per_jiffy/(500000/HZ),
+			(loops_per_jiffy/(5000/HZ)) % 100);
+		printk("Set 'Preset loops_per_jiffy'=%lu for preset lpj.\n",
+			loops_per_jiffy);
 
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
 	}
-
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
-	}
-
-/* Round the value and print it */	
-	printk("%lu.%02lu BogoMIPS\n",
-		loops_per_jiffy/(500000/HZ),
-		(loops_per_jiffy/(5000/HZ)) % 100);
 }
 
 static int __init debug_kernel(char *str)
--- linux-2.6.7/init/Kconfig.orig	Mon Jun 21 17:55:09 2004
+++ linux-2.6.7/init/Kconfig	Fri Jul  9 18:41:02 2004
@@ -218,6 +218,40 @@
 	  This option enables access to kernel configuration file and build
 	  information through /proc/config.gz.
 
+menuconfig FASTBOOT
+	bool "Fast boot options"
+	help
+	  Say Y here to select among various options that can decrease
+	  kernel boot time. These options commonly involve providing
+	  hardcoded values for some parameters that the kernel usually
+	  determines automatically.
+	
+	  This option is useful primarily on embedded systems.
+	
+	  If unsure, say N.
+
+config PRESET_LPJ
+	int "Preset loops_per_jiffy" if FASTBOOT
+	default 0
+	help
+	  This is the number of loops used by delay() to achieve a single
+	  jiffy of delay inside the kernel.  It is normally calculated at
+	  boot time, but that calculation can take up to 250 ms per CPU.
+	  Specifying a constant value here will eliminate that delay.
+	  
+	  loops_per_jiffy is roughly BogoMips * 5000. To determine the correct
+	  value for your kernel, first turn off the fast booting option,
+	  compile and boot the kernel on your target hardware, then see what
+	  value is printed during the kernel boot.  Use that value here.
+
+	  A value of 0 results in the normal autodetect behavior at boot.
+	  
+	  The kernel command line parameter "lpj=" can be used to override
+	  the value configured here.
+
+	  If unsure, set this to 0.  An incorrect value will cause delays in
+	  the kernel to be incorrect.  Although unlikely, in the extreme case
+	  this might damage your hardware.
 
 menuconfig EMBEDDED
 	bool "Configure standard kernel features (for small systems)"
