Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbTKQVck (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 16:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbTKQVck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 16:32:40 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:22765 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261891AbTKQVcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 16:32:32 -0500
Subject: Re: Terrible interactivity with 2.6.0-t9-mm3
From: john stultz <johnstul@us.ibm.com>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>,
       "Ronny V. Vindenes" <s864@ii.uib.no>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, cat@zip.com.au,
       gawain@freda.homelinux.org, gene.heskett@verizon.net,
       papadako@csd.uoc.gr
In-Reply-To: <200311172046.17736.schlicht@uni-mannheim.de>
References: <1069071092.3238.5.camel@localhost.localdomain>
	 <3FB8C92E.7030201@gmx.de>  <200311172046.17736.schlicht@uni-mannheim.de>
Content-Type: text/plain
Organization: 
Message-Id: <1069104441.11424.1979.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Nov 2003 13:27:21 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-17 at 11:46, Thomas Schlichter wrote:
> On Monday 17 November 2003 14:12, Prakash K. Cheemplavam wrote:
> > Ronny V. Vindenes wrote:
> > > I've found that neither linus.patch nor
> > > context-switch-accounting-fix.patch is causing the problem, but rather
> > > acpi-pm-timer-fixes.patch & acpi-pm-timer.patch
> > >
> > > With these applied my cpu (athlon64) is detected as 0.0Mhz, bogomips
> > > drops to 50% and anything cpu intensive destroys interactivity. Revert
> > > them and performance is back at -mm2 level.
> >
> > Yup, works for me too. Reverting those patches and my machine is smooth
> > again. :)

Not configuring the ACPI PM time source in should also work as well. 

> I was able to reproduce the interactivity problem, too. My simple testcase 
> was:
> 1. open a KDE Konsole
> 2. execute "while true; do a=2; done" in the Konsole
> 3. Move the Konsole window.
> 
> With test9-mm3 booted with "clock=pit" or "clock=pmtmr" moving the window was 
> very sluggish... Booted with "clock=tsc" made it work fine again. (Btw. which 
> kind of hardware is needed to make "clock=hpet" work?)
> 
> The problem is that sched_clock() uses the TSC if the hardware supports it. 
> But the needed scaling factors are only initialized in init_tsc() and 
> init_hpet(). So there are 2 possibilities to fix this:
> 1. Call the neccessary parts of init_tsc() in init_pmtmr() and init_pit().
> 2. Use the TSC in sched_clock() only if "clock=tsc" was set.


As far as sched_clock() goes, I haven't followed its development
closely, but it seem that it is very close to monotonic_clock() in
functionality. The benefit of monotonic_clock is that it is implemented
for each time source (however its not implemented for every arch). For
i386 at least, we may want to make sched_clock just call
monotonic_clock, but I need to look into the details. 


> I've attached a small patch that does the 2nd thing. For me it fixed the 
> interactivity problem...

That tentatively looks OK to me, but I suspect that sched_clock needs
further work on i386. 


> Btw. the BogoMIPS value is the argument for the __delay() function needed to 
> wait 1 jiffy. The difference is that the TSC version of this function uses 
> the clock cycle count as its argument whereas the PMTMR and PIT versions take 
> the count of loops to wait as their argument. Well, and it seems that each 
> loop iteration needs 2 clock cycles.

__delay() is called with loops as an argument. calibrate_delay() sets
loops_per_jiffy such that mdelay() and udelay() will delay for the
proper amount of time. BogoMIPS may not line up w/ your cpu frequency,
but don't let that worry you. 


> The problem with the shown CPU frequency is, that cpu_khz is only set in 
> init_tsc() and init_hpet(). But I don't know how this can be fixed without 
> using the TSC...

You're correct, I forgot to initialize cpu_khz in the ACPI PM timesource
init code. This patch fixes that. 

thanks for the great testing and feedback!
-john

diff -Nru a/arch/i386/kernel/timers/common.c b/arch/i386/kernel/timers/common.c
--- a/arch/i386/kernel/timers/common.c	Mon Nov 17 13:23:43 2003
+++ b/arch/i386/kernel/timers/common.c	Mon Nov 17 13:23:43 2003
@@ -137,3 +137,23 @@
 }
 #endif
 
+/* calculate cpu_khz */
+void __init init_cpu_khz(void)
+{
+	if (cpu_has_tsc) {
+		unsigned long tsc_quotient = calibrate_tsc();
+		if (tsc_quotient) {
+			/* report CPU clock rate in Hz.
+			 * The formula is (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =
+			 * clock/second. Our precision is about 100 ppm.
+			 */
+			{	unsigned long eax=0, edx=1000;
+				__asm__("divl %2"
+		       		:"=a" (cpu_khz), "=d" (edx)
+        	       		:"r" (tsc_quotient),
+	                	"0" (eax), "1" (edx));
+				printk("Detected %lu.%03lu MHz processor.\n", cpu_khz / 1000, cpu_khz % 1000);
+			}
+		}
+	}
+}
diff -Nru a/arch/i386/kernel/timers/timer_cyclone.c b/arch/i386/kernel/timers/timer_cyclone.c
--- a/arch/i386/kernel/timers/timer_cyclone.c	Mon Nov 17 13:23:43 2003
+++ b/arch/i386/kernel/timers/timer_cyclone.c	Mon Nov 17 13:23:43 2003
@@ -212,27 +212,8 @@
 		}
 	}
 
-	/* init cpu_khz.
-	 * XXX - This should really be done elsewhere, 
-	 * 		and in a more generic fashion. -johnstul@us.ibm.com
-	 */
-	if (cpu_has_tsc) {
-		unsigned long tsc_quotient = calibrate_tsc();
-		if (tsc_quotient) {
-			/* report CPU clock rate in Hz.
-			 * The formula is (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =
-			 * clock/second. Our precision is about 100 ppm.
-			 */
-			{	unsigned long eax=0, edx=1000;
-				__asm__("divl %2"
-		       		:"=a" (cpu_khz), "=d" (edx)
-        	       		:"r" (tsc_quotient),
-	                	"0" (eax), "1" (edx));
-				printk("Detected %lu.%03lu MHz processor.\n", cpu_khz / 1000, cpu_khz % 1000);
-			}
-		}
-	}
-
+	init_cpu_khz();
+	
 	/* Everything looks good! */
 	return 0;
 }
diff -Nru a/arch/i386/kernel/timers/timer_pm.c b/arch/i386/kernel/timers/timer_pm.c
--- a/arch/i386/kernel/timers/timer_pm.c	Mon Nov 17 13:23:43 2003
+++ b/arch/i386/kernel/timers/timer_pm.c	Mon Nov 17 13:23:43 2003
@@ -57,14 +57,18 @@
 		if (value2 == value1) 
 			continue;
 		if (value2 > value1)
-			return 0;
+			goto pm_good;
 		if ((value2 < value1) && ((value2) < 0xFFF))
-			return 0;
+			goto pm_good;
 		printk(KERN_INFO "PM-Timer had inconsistent results: 0x%#x, 0x%#x - aborting.\n", value1, value2);
 		return -EINVAL;
 	}
 	printk(KERN_INFO "PM-Timer had no reasonable result: 0x%#x - aborting.\n", value1);
 	return -ENODEV;
+
+pm_good:
+	init_cpu_khz();
+	return 0;
 }
 
 static inline u32 cyc2us(u32 cycles)
diff -Nru a/include/asm-i386/timer.h b/include/asm-i386/timer.h
--- a/include/asm-i386/timer.h	Mon Nov 17 13:23:43 2003
+++ b/include/asm-i386/timer.h	Mon Nov 17 13:23:43 2003
@@ -39,6 +39,7 @@
 #endif
 
 extern unsigned long calibrate_tsc(void);
+extern void init_cpu_khz(void);
 #ifdef CONFIG_HPET_TIMER
 extern struct timer_opts timer_hpet;
 extern unsigned long calibrate_tsc_hpet(unsigned long *tsc_hpet_quotient_ptr);



