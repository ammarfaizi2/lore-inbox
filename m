Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268968AbRG0VHv>; Fri, 27 Jul 2001 17:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268972AbRG0VHp>; Fri, 27 Jul 2001 17:07:45 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:11222 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S268968AbRG0VHa>;
	Fri, 27 Jul 2001 17:07:30 -0400
Date: Sat, 28 Jul 2001 07:07:25 +1000 (EST)
Message-Id: <200107272107.f6RL7Pr12839@pcug.org.au>
From: sfr@canb.auug.org.au
To: torvalds@transmet.com
Cc: alan@redhat.com, linux-kernel@vger.kernel.org, marc@mbsi.ca
Subject: [PATCH] APM patches
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi Linus,

This patch brings the APM code (basically) in line with Alan's
tree (the sysreq changes are missing).  It also works around
a bug in one of the VAIO's BIOSes.  Please consider applying
as it automates the detection of various bugs in APM BIOSes.
(This is the apm part that uses the DMI detection code that
got integrated in 2.4.7.)

Cheers,
Stephen Rothwell

diff -ruN 2.4.8-pre1/arch/i386/kernel/apm.c 2.4.8-pre1-APM.1/arch/i386/kernel/apm.c
--- 2.4.8-pre1/arch/i386/kernel/apm.c	Thu Jul 19 16:06:48 2001
+++ 2.4.8-pre1-APM.1/arch/i386/kernel/apm.c	Fri Jul 27 13:45:26 2001
@@ -148,6 +148,12 @@
  *   1.14: Make connection version persist across module unload/load.
  *         Enable and engage power management earlier.
  *         Disengage power management on module unload.
+ *         Make CONFIG_APM_REAL_MODE_POWER_OFF run time configurable.
+ *         (Arjan van de Ven <arjanv@redhat.com>) modified by sfr.
+ *         Work around byte swap bug in one of the Vaio's BIOS's
+ *         (Marc Boucher <marc@mbsi.ca>).
+ *         Exposed the disable flag to dmi so that we can handle known
+ *	   broken APM (Alan Cox <alan@redhat.com>).
  *
  * APM 1.1 Reference:
  *
@@ -339,14 +345,25 @@
 static int			got_clock_diff;
 #endif
 static int			debug;
-static int			apm_disabled;
+static int			apm_disabled = -1;
 #ifdef CONFIG_SMP
 static int			power_off;
 #else
 static int			power_off = 1;
 #endif
+#ifdef CONFIG_APM_REAL_MODE_POWER_OFF
+static int			realmode_power_off = 1;
+#else
+static int			realmode_power_off;
+#endif
 static int			exit_kapmd;
 static int			kapmd_running;
+#ifdef CONFIG_APM_ALLOW_INTS
+static int			allow_ints = 1;
+#else
+static int			allow_ints;
+#endif
+static int			broken_psr;
 
 static DECLARE_WAIT_QUEUE_HEAD(apm_waitqueue);
 static DECLARE_WAIT_QUEUE_HEAD(apm_suspend_waitqueue);
@@ -413,11 +430,12 @@
  * Also, we KNOW that for the non error case of apm_bios_call, there
  * is no useful data returned in the low order 8 bits of eax.
  */
-#ifndef CONFIG_APM_ALLOW_INTS
-#	define APM_DO_CLI	__cli()
-#else
-#	define APM_DO_CLI	__sti()
-#endif
+#define APM_DO_CLI	\
+	if (apm_info.allow_ints) \
+		__sti(); \
+	else \
+		__cli();
+
 #ifdef APM_ZERO_SEGS
 #	define APM_DECL_SEGS \
 		unsigned int saved_fs; unsigned int saved_gs;
@@ -641,7 +659,6 @@
 
 static void apm_power_off(void)
 {
-#ifdef CONFIG_APM_REAL_MODE_POWER_OFF
 	unsigned char	po_bios_call[] = {
 		0xb8, 0x00, 0x10,	/* movw  $0x1000,ax  */
 		0x8e, 0xd0,		/* movw  ax,ss       */
@@ -651,7 +668,6 @@
 		0xb9, 0x03, 0x00,	/* movw  $0x0003,cx  */
 		0xcd, 0x15		/* int   $0x15       */
 	};
-#endif
 
 	/*
 	 * This may be called on an SMP machine.
@@ -664,11 +680,10 @@
 		schedule();
 	}
 #endif
-#ifdef CONFIG_APM_REAL_MODE_POWER_OFF
-	machine_real_restart(po_bios_call, sizeof(po_bios_call));
-#else
-	(void) apm_set_power_state(APM_STATE_OFF);
-#endif
+	if (apm_info.realmode_power_off)
+		machine_real_restart(po_bios_call, sizeof(po_bios_call));
+	else
+		(void) apm_set_power_state(APM_STATE_OFF);
 }
 
 #ifdef CONFIG_APM_DO_ENABLE
@@ -704,7 +719,11 @@
 		return (eax >> 8) & 0xff;
 	*status = ebx;
 	*bat = ecx;
-	*life = edx;
+	if (apm_info.get_power_status_swabinminutes) {
+		*life = swab16((u16)edx);
+		*life |= 0x8000;
+	} else
+		*life = edx;
 	return APM_SUCCESS;
 }
 
@@ -1552,9 +1571,15 @@
 			apm_disabled = 1;
 		if (strncmp(str, "on", 2) == 0)
 			apm_disabled = 0;
+		if ((strncmp(str, "allow-ints", 10) == 0) ||
+		    (strncmp(str, "allow_ints", 10) == 0))
+ 			apm_info.allow_ints = 1;
 		if ((strncmp(str, "broken-psr", 10) == 0) ||
 		    (strncmp(str, "broken_psr", 10) == 0))
 			apm_info.get_power_status_broken = 1;
+		if ((strncmp(str, "realmode-power-off", 18) == 0) ||
+		    (strncmp(str, "realmode_power_off", 18) == 0))
+			apm_info.realmode_power_off = 1;
 		invert = (strncmp(str, "no-", 3) == 0);
 		if (invert)
 			str += 3;
@@ -1620,6 +1645,16 @@
 		return -ENODEV;
 	}
 
+	if (allow_ints)
+		apm_info.allow_ints = 1;
+	if (broken_psr)
+		apm_info.get_power_status_broken = 1;
+	if (realmode_power_off)
+		apm_info.realmode_power_off = 1;
+	/* User can override, but default is to trust DMI */
+	if (apm_disabled != -1)
+		apm_info.disabled = 1;
+
 	/*
 	 * Fix for the Compaq Contura 3/25c which reports BIOS version 0.1
 	 * but is reportedly a 1.0 BIOS.
@@ -1644,8 +1679,9 @@
 		printk("\n");
 	}
 
-	if (apm_disabled) {
-		printk(KERN_NOTICE "apm: disabled on user request.\n");
+	if (apm_info.disabled) {
+		if(apm_disabled == 1)
+			printk(KERN_NOTICE "apm: disabled on user request.\n");
 		return -ENODEV;
 	}
 	if ((smp_num_cpus > 1) && !power_off) {
@@ -1747,5 +1783,9 @@
 MODULE_PARM_DESC(power_off, "Enable power off");
 MODULE_PARM(bounce_interval, "i");
 MODULE_PARM_DESC(bounce_interval, "Set the number of ticks to ignore suspend bounces");
+MODULE_PARM(allow_ints, "i");
+MODULE_PARM_DESC(allow_ints, "Allow interrupts during BIOS calls");
+MODULE_PARM(broken_psr, "i");
+MODULE_PARM_DESC(broken_psr, "BIOS has a broken GetPowerStatus call");
 
 EXPORT_NO_SYMBOLS;
diff -ruN 2.4.8-pre1/arch/i386/kernel/dmi_scan.c 2.4.8-pre1-APM.1/arch/i386/kernel/dmi_scan.c
--- 2.4.8-pre1/arch/i386/kernel/dmi_scan.c	Fri Jul 27 16:20:36 2001
+++ 2.4.8-pre1-APM.1/arch/i386/kernel/dmi_scan.c	Fri Jul 27 16:28:13 2001
@@ -253,6 +253,13 @@
 	return 0;
 }		
 
+static __init int swab_apm_power_in_minutes(struct dmi_blacklist *d)
+{
+	apm_info.get_power_status_swabinminutes = 1;
+	printk(KERN_WARNING "BIOS strings suggest APM reports battery life in minutes and wrong byte order.\n");
+	return 0;
+}
+
 /*
  *	Process the DMI blacklists
  */
@@ -303,6 +310,11 @@
 			MATCH(DMI_SYS_VENDOR, "TriGem Computer, Inc"),
 			MATCH(DMI_PRODUCT_NAME, "Delhi3"),
 			NO_MATCH, NO_MATCH,
+			} },
+	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-Z505LS */
+			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			MATCH(DMI_BIOS_VERSION, "R0203Z3"),
+			MATCH(DMI_BIOS_DATE, "08/25/00"), NO_MATCH
 			} },
 	{ NULL, }
 };
diff -ruN 2.4.8-pre1/include/linux/apm_bios.h 2.4.8-pre1-APM.1/include/linux/apm_bios.h
--- 2.4.8-pre1/include/linux/apm_bios.h	Mon Jul 23 16:40:07 2001
+++ 2.4.8-pre1-APM.1/include/linux/apm_bios.h	Fri Jul 27 12:41:39 2001
@@ -52,6 +52,7 @@
 	struct apm_bios_info	bios;
 	unsigned short		connection_version;
 	int			get_power_status_broken;
+	int			get_power_status_swabinminutes;
 	int			allow_ints;
 	int			realmode_power_off;
 	int			disabled;
