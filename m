Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266065AbUGJB2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266065AbUGJB2T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 21:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266067AbUGJB2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 21:28:19 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:41210 "EHLO
	mail.kroptech.com") by vger.kernel.org with ESMTP id S266065AbUGJB2F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 21:28:05 -0400
Date: Fri, 9 Jul 2004 22:01:42 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Tim Bird <tim.bird@am.sony.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>,
       CE Linux Developers List <celinux-dev@tree.celinuxforum.org>
Subject: Re: [PATCH] preset loops_per_jiffy for faster booting
Message-ID: <20040709220142.B29198@mail.kroptech.com>
References: <40EEF10F.1030404@am.sony.com> <20040709193528.A23508@mail.kroptech.com> <40EF3637.4090105@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40EF3637.4090105@am.sony.com>; from tim.bird@am.sony.com on Fri, Jul 09, 2004 at 05:20:07PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 05:20:07PM -0700, Tim Bird wrote:
> Adam Kropelin wrote:
> > crashes due to a bogus preset. The only problem I can think of with
> > this approach is if there is a system out there so slow that lpj=0 is
> > actually a valid setting.
> It's hard to imagine this case, but that would merely result in
> a calibration, right?  For a machine that slow, calibrating the
> delay is the least of their worries. :-)

Good point. ;)

> > be a problem. Perhaps this is worth mentioning in the help text as well.
> I hadn't considered this.  (Too much "embedded" on the brain.)
> By help text, do you mean the config text, or something on the wiki page,
> or some other file (in Documentation?).

I meant the config text.

> On the subject of help text, is there a Documentation file I should modify
> or someone I should notify about the addition of a new kernel command line
> option?

Indeed, there is: Documentation/kernel-parameters.txt. You're right; we
should update it.

> > While we're on the topic: Should FASTBOOT perhaps depend on EMBEDDED? I
> > can imagine a user with a massively MP system perhaps finding this
> > option useful, so maybe not.
> 
> I had it there originally, then changed my mind.  I know some server
> guys are interested in fastboot.  This particular change might not
> be that interesting, but some of the other changes we are thinking of
> might not be specific to just embedded.

Ok, let's leave it as-is, then.

> I will do some runtime testing on your patch, but I probably won't be
> able to report back until Monday.

I've made an updated patch below that incorporates the items we just
discussed as well as a couple of things Andreas Dilger sent to me
privately.

> Thanks very much!

No problem. This was a nice little self-contained project to play with
this evening.


Signed-off-by: Adam Kropelin <akropel1@rochester.rr.com>

--- linux-2.6.7/init/main.c.orig	Mon Jun 21 17:55:09 2004
+++ linux-2.6.7/init/main.c	Fri Jul  9 21:07:44 2004
@@ -167,6 +167,15 @@
 	return 0;
 }
 
+static unsigned long preset_lpj = CONFIG_PRESET_LPJ;
+static int __init lpj_setup(char *str)
+{
+	preset_lpj = simple_strtoul(str,NULL,0);
+	return 1;
+}
+
+__setup("lpj=", lpj_setup);
+
 /* this should be approx 2 Bo*oMips to start (note initial shift), and will
    still work even if initially too large, it will just take slightly longer */
 unsigned long loops_per_jiffy = (1<<12);
@@ -183,40 +192,49 @@
 	unsigned long ticks, loopbit;
 	int lps_precision = LPS_PREC;
 
-	loops_per_jiffy = (1<<12);
+	if (preset_lpj) {
+		loops_per_jiffy = preset_lpj;
+		printk("Calibrating delay loop (skipped)... ");
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
+		/* Do a binary approximation to get loops_per_jiffy set to
+		   equal one clock (up to lps_precision bits) */
+		loops_per_jiffy >>= 1;
+		loopbit = loops_per_jiffy;
+		while ( lps_precision-- && (loopbit >>= 1) ) {
+			loops_per_jiffy |= loopbit;
+			ticks = jiffies;
+			while (ticks == jiffies)
+				/* nothing */;
+			ticks = jiffies;
+			__delay(loops_per_jiffy);
+			if (jiffies != ticks)	/* longer than 1 tick */
+				loops_per_jiffy &= ~loopbit;
+		}
+
+		/* Round the value and print it */	
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
+++ linux-2.6.7/init/Kconfig	Fri Jul  9 21:12:21 2004
@@ -218,6 +218,44 @@
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
+	  Note that on SMP systems the preset will be applied to all CPUs
+	  which will cause problems if for some reason your CPUs need
+	  significantly divergent settings.
+
+	  If unsure, set this to 0. An incorrect value will cause delays in
+	  the kernel to be incorrect.  Although unlikely, in the extreme case
+	  this might damage your hardware.
 
 menuconfig EMBEDDED
 	bool "Configure standard kernel features (for small systems)"
--- linux-2.6.7/Documentation/kernel-parameters.txt.orig	Fri Jul  9 21:20:16 2004
+++ linux-2.6.7/Documentation/kernel-parameters.txt	Fri Jul  9 21:17:11 2004
@@ -576,6 +576,12 @@
 				so, the driver will manage that printer.
 				See also header of drivers/char/lp.c.
 
+	lpj=n		[KNL]
+			Sets loops_per_jiffy to given constant, thus avoiding
+			time-consuming boot-time autodetection.
+			0 enables autodetection (default). See Kconfig help text
+			for PRESET_LPJ for details.
+
 	ltpc=		[NET]
 			Format: <io>,<irq>,<dma>
 
