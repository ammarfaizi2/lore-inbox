Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275457AbTHJFEx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 01:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275469AbTHJFEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 01:04:53 -0400
Received: from harlech.math.ucla.edu ([128.97.4.250]:17041 "EHLO
	harlech.math.ucla.edu") by vger.kernel.org with ESMTP
	id S275457AbTHJFEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 01:04:48 -0400
Date: Sat, 9 Aug 2003 22:04:45 -0700 (PDT)
From: Jim Carter <jimc@math.ucla.edu>
To: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org
Cc: michael@talamasca.ocis.net
Subject: [PATCH] apm.c, 2.4.20, limits rate of power status calls
Message-ID: <Pine.LNX.4.53.0308091658010.3413@xena.cft.ca.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Dell Inspiron series of laptops (Phoenix BIOS) is notorious because
"the clock runs slow in Linux".  michael@talamasca.ocis.net "Michael
Deutschmann" (posted in comp.protocols.time.ntp) attributes this to use
of System Management Mode to interrogate the battery.  Empirically on
the Inspiron 4100, clock interrupts are lost for 15 msec each time
/proc/apm is read.  If a monitor applet checks the temperature, load,
wireless, battery, etc. once a second, the machine needs tick=10153,
which is outrageous.

This patch provides a new parameter, battery_interval (in seconds).  The
APM_FUNC_GET_STATUS call is done no more frequently than this; saved values
are returned between times.  The interval is adjusted so you see (almost)
every percent change in charge, and an actual call is enabled after every
incoming APM event, like a power source change.  Ticks are still lost, but
much less frequently.  Separately I posted a patch to time.c that detects
and recovers the lost ticks.

Unrelated, in apm_bios_call() and apm_bios_call_simple() the assembler
wanted a star for the indirect lcall, so I gave it one.  This is with
gcc-3.3.

The patch is relative to 2.4.20 from SuSE Linux 8.2.  As far as I can
see, there are no SuSE hacks in this file.  Since the file changes
rarely, the patch should apply cleanly to other kernel versions.  I have
been running the patched module for about 3 weeks with good effect,
including tests when I ran the battery down, to verify that calls were
done frequently enough to show (nearly) every percent change even in a
rapid decline.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)


--- arch/i386/kernel/apm.c.orig	2003-03-17 07:51:20.000000000 -0800
+++ arch/i386/kernel/apm.c	2003-08-09 15:44:24.000000000 -0700
@@ -177,6 +177,8 @@
  *         CONFIG_APM_CPU_IDLE now just affects the default value of
  *         idle_threshold (sfr).
  *         Change name of kernel apm daemon (as it no longer idles) (sfr).
+ *   1.17: Limit frequency of power status calls due to excessive blockage
+ *         times and eating interrupts in some BIOSes.  <jimc@math.ucla.edu>
  *
  * APM 1.1 Reference:
  *
@@ -270,6 +272,9 @@
  * 	broken in BIOS [Reported by Garst R. Reese <reese@isn.net>]
  * ?: AcerNote-950: oops on reading /proc/apm - workaround is a WIP
  * 	Neale Banks <neale@lowendale.com.au> December 2000
+ * P: Dell Inspiron eats clock interrupts for 15 msec when you interrogate
+ *	the battery.  Seen on 3800, 4100, 4150, 8200, probably all models.
+ *	Phoenix BIOS.
  *
  * Legend: U = unusable with APM patches
  *         P = partially usable with APM patches
@@ -419,7 +424,7 @@
 static DECLARE_WAIT_QUEUE_HEAD(apm_suspend_waitqueue);
 static struct apm_user *	user_list;

-static char			driver_version[] = "1.16";	/* no spaces */
+static char			driver_version[] = "1.17";	/* no spaces */

 /*
  *	APM event names taken from the APM 1.2 specification. These are
@@ -614,7 +619,7 @@
 	__asm__ __volatile__(APM_DO_ZERO_SEGS
 		"pushl %%edi\n\t"
 		"pushl %%ebp\n\t"
-		"lcall %%cs:" SYMBOL_NAME_STR(apm_bios_entry) "\n\t"
+		"lcall %%cs:*" SYMBOL_NAME_STR(apm_bios_entry) "\n\t"
 		"setc %%al\n\t"
 		"popl %%ebp\n\t"
 		"popl %%edi\n\t"
@@ -666,7 +671,7 @@
 		__asm__ __volatile__(APM_DO_ZERO_SEGS
 			"pushl %%edi\n\t"
 			"pushl %%ebp\n\t"
-			"lcall %%cs:" SYMBOL_NAME_STR(apm_bios_entry) "\n\t"
+			"lcall %%cs:*" SYMBOL_NAME_STR(apm_bios_entry) "\n\t"
 			"setc %%bl\n\t"
 			"popl %%ebp\n\t"
 			"popl %%edi\n\t"
@@ -994,6 +999,9 @@
 }
 #endif

+static int battery_interval /*= 0*/;	/* Seconds between power status calls */
+static unsigned long next_get_power /*= 0*/; /* Next get_power call, jiffies */
+
 /**
  *	apm_get_power_status	-	get current power state
  *	@status: returned status
@@ -1006,6 +1014,13 @@
  *	of life and a status value for the battery. The estimated life
  *	if reported is a lifetime in secodnds/minutes at current powwer
  *	consumption.
+ *
+ *	michael@talamasca.ocis.net "Michael Deutschmann" (posted in
+ *	comp.protocols.time.ntp) says that some laptop BIOS drop you into SMM
+ *	(system management mode) which eats interrupts.  Seen on Dell Inspiron,
+ *	various models, Phoenix BIOS; it lasts 15 msec.  Hence the interval
+ *	between calls can be restricted, saved data being returned between
+ *	times.  It still eats clock ticks but a lot fewer. <jimc@math.ucla.edu>
  */

 static int apm_get_power_status(u_short *status, u_short *bat, u_short *life)
@@ -1015,19 +1030,45 @@
 	u32	ecx;
 	u32	edx;
 	u32	dummy;
+	static unsigned long interval;	/* Jiffies between calls, adjusted */
+	static u_short s_status;	/* Flags: AC power, battery present */
+	static u_short s_bat;		/* Battery percent charge */
+	static u_short s_life;		/* Battery life in minutes */
+	u_short dbat;			/* abs(change in battery percent) */

 	if (apm_info.get_power_status_broken)
 		return APM_32_UNSUPPORTED;
-	if (apm_bios_call(APM_FUNC_GET_STATUS, APM_DEVICE_ALL, 0,
+	if (jiffies >= next_get_power) {
+		if (apm_bios_call(APM_FUNC_GET_STATUS, APM_DEVICE_ALL, 0,
 			&eax, &ebx, &ecx, &edx, &dummy))
-		return (eax >> 8) & 0xff;
-	*status = ebx;
-	*bat = ecx;
-	if (apm_info.get_power_status_swabinminutes) {
-		*life = swab16((u16)edx);
-		*life |= 0x8000;
-	} else
-		*life = edx;
+			return (eax >> 8) & 0xff;
+		dbat = (ecx >= s_bat) ? ecx - s_bat : s_bat - ecx;
+		s_status = ebx;
+		s_bat = ecx;
+		if (apm_info.get_power_status_swabinminutes) {
+			s_life = swab16((u16)edx);
+			s_life |= 0x8000;
+		} else
+			s_life = edx;
+		/*
+		 * At end of life, bat declines rapidly.  Adjust interval so
+		 * we see each percent of change in battery life.
+		 */
+		if (dbat == 0) {
+			interval += interval >> 4;
+		} else if (dbat >= 2) {
+			interval /= dbat;
+		}
+		if (interval <= HZ || battery_interval <= 0) {
+			interval = HZ;
+		} else if (interval > HZ*battery_interval) {
+			interval = HZ*battery_interval;
+		}
+		next_get_power = jiffies + interval;
+	}
+	*status = s_status;
+	*bat = s_bat;
+	*life = s_life;
 	return APM_SUCCESS;
 }

@@ -1408,6 +1449,7 @@
 	} else
 		pending_count = 4;
 	check_events();
+	next_get_power = 0;	/* Allow immediate get_power_status call */
 }

 /*
@@ -2091,5 +2133,8 @@
 MODULE_PARM(smp, "i");
 MODULE_PARM_DESC(smp,
 	"Set this to enable APM use on an SMP platform. Use with caution on older systems");
+MODULE_PARM(battery_interval, "i");
+MODULE_PARM_DESC(battery_interval,
+	"Seconds between power status calls; saved value used between times");

 EXPORT_NO_SYMBOLS;
