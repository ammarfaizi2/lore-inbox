Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266489AbUGKDLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266489AbUGKDLU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 23:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266490AbUGKDLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 23:11:20 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:46844 "EHLO
	mail.kroptech.com") by vger.kernel.org with ESMTP id S266489AbUGKDLE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 23:11:04 -0400
Date: Sat, 10 Jul 2004 23:44:59 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Andrew Morton <akpm@osdl.org>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       tim.bird@am.sony.com, celinux-dev@tree.celinuxforum.org,
       tpoynor@mvista.com, geert@linux-m68k.org
Subject: Re: [PATCH] preset loops_per_jiffy for faster booting
Message-ID: <20040710234459.A26981@mail.kroptech.com>
References: <40EEF10F.1030404@am.sony.com> <20040710115413.A31260@mail.kroptech.com> <20040710142800.A5093@mail.kroptech.com> <200407101319.31147.dtor_core@ameritech.net> <099101c466ba$7d75aa30$03c8a8c0@kroptech.com> <20040710182527.47534358.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040710182527.47534358.akpm@osdl.org>; from akpm@osdl.org on Sat, Jul 10, 2004 at 06:25:27PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2004 at 06:25:27PM -0700, Andrew Morton wrote:
> "Adam Kropelin" <akropel1@rochester.rr.com> wrote:
> >
> > > Does 250 ms worth all this pain?
> > 
> >  On a desktop box, almost certainly not. On a massive SMP machine, maybe. On
> >  an embedded system that is required to boot in a ridiculously short time,
> >  absolutely.

Andrew, thanks for the review...

> wrt this particular patch:
> 
> a) I don't see much point in making it configurable.  Just add the boot
>    option and be done with it.  The few hundred bytes of extra code will be
>    dropped from core anyway.
> 
>    The main reason for this is that most people won't turn on the config
>    option, so your new code could get accidentally broken quite easily. 
>    Plus it removes some ifdefs.

Actually, there are no ifdefs at all (unless there are some
auto-generated ones I don't know about).  The only function of the config
option is to allow a preset without using the command line parameter. I
agree that the command line parameter alone is enough. I'm not an actual
user of this code, though, so perhaps Tim or someone else can comment if
the config option serves a useful purpose for them.

> b) Coding style consistency, please:

Will do. I actually purposely avoided making "gratuitous" changes to
existing code, but I definitely appreciate consistency so I'll happily
clean things up a bit.

Thanks for your feedback. Here's a patch implementing your suggestions.

Signed-off-by: Adam Kropelin <akropel1@rochester.rr.com>

--- linux-2.6.7/init/main.c.orig	Mon Jun 21 17:55:09 2004
+++ linux-2.6.7/init/main.c	Sat Jul 10 22:42:34 2004
@@ -167,15 +167,28 @@
 	return 0;
 }
 
-/* this should be approx 2 Bo*oMips to start (note initial shift), and will
-   still work even if initially too large, it will just take slightly longer */
+static unsigned long preset_lpj;
+static int __init lpj_setup(char *str)
+{
+	preset_lpj = simple_strtoul(str,NULL,0);
+	return 1;
+}
+
+__setup("lpj=", lpj_setup);
+
+/*
+ * This should be approx 2 Bo*oMips to start (note initial shift), and will
+ * still work even if initially too large, it will just take slightly longer
+ */
 unsigned long loops_per_jiffy = (1<<12);
 
 EXPORT_SYMBOL(loops_per_jiffy);
 
-/* This is the number of bits of precision for the loops_per_jiffy.  Each
-   bit takes on average 1.5/HZ seconds.  This (like the original) is a little
-   better than 1% */
+/*
+ * This is the number of bits of precision for the loops_per_jiffy.  Each
+ * bit takes on average 1.5/HZ seconds.  This (like the original) is a little
+ * better than 1%
+ */
 #define LPS_PREC 8
 
 void __devinit calibrate_delay(void)
@@ -183,40 +196,54 @@
 	unsigned long ticks, loopbit;
 	int lps_precision = LPS_PREC;
 
-	loops_per_jiffy = (1<<12);
+	if (preset_lpj) {
+		loops_per_jiffy = preset_lpj;
+		printk("Calibrating delay loop (skipped)... "
+			"%lu.%02lu BogoMIPS preset\n",
+			loops_per_jiffy/(500000/HZ),
+			(loops_per_jiffy/(5000/HZ)) % 100);
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
-	}
+		/*
+		 * Do a binary approximation to get loops_per_jiffy set to
+		 * equal one clock (up to lps_precision bits)
+		 */
+		loops_per_jiffy >>= 1;
+		loopbit = loops_per_jiffy;
+		while (lps_precision-- && (loopbit >>= 1)) {
+			loops_per_jiffy |= loopbit;
+			ticks = jiffies;
+			while (ticks == jiffies)
+				/* nothing */;
+			ticks = jiffies;
+			__delay(loops_per_jiffy);
+			if (jiffies != ticks)	/* longer than 1 tick */
+				loops_per_jiffy &= ~loopbit;
+		}
 
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
+		/* Round the value and print it */	
+		printk("%lu.%02lu BogoMIPS\n",
+			loops_per_jiffy/(500000/HZ),
+			(loops_per_jiffy/(5000/HZ)) % 100);
+		printk("Set 'Preset loops_per_jiffy'=%lu for preset lpj.\n",
+			loops_per_jiffy);
 	}
 
-/* Round the value and print it */	
-	printk("%lu.%02lu BogoMIPS\n",
-		loops_per_jiffy/(500000/HZ),
-		(loops_per_jiffy/(5000/HZ)) % 100);
 }
 
 static int __init debug_kernel(char *str)
@@ -238,8 +265,10 @@
 __setup("debug", debug_kernel);
 __setup("quiet", quiet_kernel);
 
-/* Unknown boot options get handed to init, unless they look like
-   failed parameters */
+/*
+ * Unknown boot options get handed to init, unless they look like
+ * failed parameters
+ */
 static int __init unknown_bootoption(char *param, char *val)
 {
 	/* Change NUL term back to "=", to make "param" the whole string. */
@@ -250,8 +279,10 @@
 	if (obsolete_checksetup(param))
 		return 0;
 
-	/* Preemptive maintenance for "why didn't my mispelled command
-           line work?" */
+	/*
+	 * Preemptive maintenance for "why didn't my mispelled command
+	 * line work?"
+	 */
 	if (strchr(param, '.') && (!val || strchr(param, '.') < val)) {
 		printk(KERN_ERR "Unknown boot option `%s': ignoring\n", param);
 		return 0;
@@ -289,7 +320,8 @@
 	unsigned int i;
 
 	execute_command = str;
-	/* In case LILO is going to boot us with default command line,
+	/*
+	 * In case LILO is going to boot us with default command line,
 	 * it prepends "auto" before the whole cmdline which makes
 	 * the shell think it should execute a script with such name.
 	 * So we ignore all arguments entered _before_ init=... [MJ]
@@ -483,9 +515,9 @@
 	check_bugs();
 
 	/* 
-	 *	We count on the initial thread going ok 
-	 *	Like idlers init is an unlocked kernel thread, which will
-	 *	make syscalls (and thus be locked).
+	 * We count on the initial thread going ok 
+	 * Like idlers init is an unlocked kernel thread, which will
+	 * make syscalls (and thus be locked).
 	 */
 	init_idle(current, smp_processor_id());
 
--- linux-2.6.7/Documentation/kernel-parameters.txt.orig	Fri Jul  9 21:20:16 2004
+++ linux-2.6.7/Documentation/kernel-parameters.txt	Sat Jul 10 22:46:30 2004
@@ -576,6 +576,20 @@
 				so, the driver will manage that printer.
 				See also header of drivers/char/lp.c.
 
+	lpj=n		[KNL]
+			Sets loops_per_jiffy to given constant, thus avoiding
+			time-consuming boot-time autodetection (up to 250 ms per
+			CPU). 0 enables autodetection (default). To determine
+			the correct value for your kernel, boot with normal
+			autodetection and see what value is printed. Note that
+			on SMP systems the preset will be applied to all CPUs,
+			which is likely to cause problems if your CPUs need
+			significantly divergent settings. An incorrect value
+			will cause delays in the kernel to be wrong, leading to
+			unpredictable I/O errors and other breakage. Although
+			unlikely, in the extreme case this might damage your
+			hardware.
+
 	ltpc=		[NET]
 			Format: <io>,<irq>,<dma>
 
