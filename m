Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266584AbUGKNHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266584AbUGKNHf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 09:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266585AbUGKNHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 09:07:35 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:509 "EHLO
	mail.kroptech.com") by vger.kernel.org with ESMTP id S266584AbUGKNH1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 09:07:27 -0400
Date: Sun, 11 Jul 2004 09:41:28 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, dtor_core@ameritech.net,
       karim@opersys.com, linux-kernel@vger.kernel.org, tim.bird@am.sony.com,
       celinux-dev@tree.celinuxforum.org, tpoynor@mvista.com
Subject: Re: [PATCH] preset loops_per_jiffy for faster booting
Message-ID: <20040711094128.A27649@mail.kroptech.com>
References: <40EEF10F.1030404@am.sony.com> <200407102351.05059.dtor_core@ameritech.net> <40F0C8E8.2060908@opersys.com> <200407110019.14558.dtor_core@ameritech.net> <20040710222702.3718842e.akpm@osdl.org> <Pine.GSO.4.58.0407110945010.3013@waterleaf.sonytel.be> <20040711005156.1d6558dd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040711005156.1d6558dd.akpm@osdl.org>; from akpm@osdl.org on Sun, Jul 11, 2004 at 12:51:56AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2004 at 12:51:56AM -0700, Andrew Morton wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > On Sat, 10 Jul 2004, Andrew Morton wrote:
> > > Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > > >
> > > > I am no longer question presence of the code in the kernel, I just don't like
> > > >  the message...
> > >
> > > yup, we shouldn't have the friendly message.
> > 
> > Just add the appropriate KERN_*, so it's not displayed by default, and people
> > who want it can look it up in syslog.
> 
> Oh crap, sorry.  I just worked out what the darn printk is for.  Yes, it's
> legit.  Let's just print the bogomips and loops_per_jiffy on the same line.

Here's a patch. It places the relevant information on the same line as
bogomips and does so without encouraging anyone to fiddle with
loops_per_jiffy and screw up their kernel. 

Signed-off-by: Adam Kropelin <akropel1@rochester.rr.com>

--- linux-2.6.7/init/main.c.orig	Mon Jun 21 17:55:09 2004
+++ linux-2.6.7/init/main.c	Sun Jul 11 08:56:07 2004
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
@@ -183,40 +196,53 @@
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
+		printk("%lu.%02lu BogoMIPS (lpj=%lu)\n",
+			loops_per_jiffy/(500000/HZ),
+			(loops_per_jiffy/(5000/HZ)) % 100,
+			loops_per_jiffy);
 	}
 
-/* Round the value and print it */	
-	printk("%lu.%02lu BogoMIPS\n",
-		loops_per_jiffy/(500000/HZ),
-		(loops_per_jiffy/(5000/HZ)) % 100);
 }
 
 static int __init debug_kernel(char *str)
@@ -238,8 +264,10 @@
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
@@ -250,8 +278,10 @@
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
@@ -289,7 +319,8 @@
 	unsigned int i;
 
 	execute_command = str;
-	/* In case LILO is going to boot us with default command line,
+	/*
+	 * In case LILO is going to boot us with default command line,
 	 * it prepends "auto" before the whole cmdline which makes
 	 * the shell think it should execute a script with such name.
 	 * So we ignore all arguments entered _before_ init=... [MJ]
@@ -483,9 +514,9 @@
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
 
