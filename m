Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129065AbRBEGwa>; Mon, 5 Feb 2001 01:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129188AbRBEGwU>; Mon, 5 Feb 2001 01:52:20 -0500
Received: from linuxcare.com.au ([203.29.91.49]:30225 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S129065AbRBEGwI>; Mon, 5 Feb 2001 01:52:08 -0500
Message-Id: <200102050652.f156q5H00375@wattle.linuxcare.com.au>
To: alan@lxorguk.ukuu.org.uk
cc: linux-kernel@vger.kernel.org, linux-laptop@vger.kernel.org
Subject: [PATCH] tidy up 2.2.19pre8 APM
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <372.981355925.1@linuxcare.com.au>
Date: Mon, 05 Feb 2001 17:52:05 +1100
From: Stephen Rothwell <sfr@linuxcare.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

This just brings 2.2.19pre8 into line with the DPMI and APM
from 2.4.  It also only cripples /proc/apm for the actually
buggy Dell BIOS.

Cheers,
Stephen
-- 
Stephen Rothwell, Open Source Researcher
Linuxcare, Inc. +61-2-62628990 tel, +61-2-62628991 fax 
sfr@linuxcare.com.au, http://www.linuxcare.com/ 
Linuxcare. Putting open source to work.
------------------------------------------------------------------------
diff -ruN 2.2.19pre8/CREDITS 2.2.19pre8-APM.1/CREDITS
--- 2.2.19pre8/CREDITS	Mon Feb  5 13:45:59 2001
+++ 2.2.19pre8-APM.1/CREDITS	Mon Feb  5 13:58:28 2001
@@ -1869,7 +1869,7 @@
 S: Germany
 
 N: Stephen Rothwell
-E: sfr@linuxcare.com
+E: sfr@linuxcare.com.au
 W: http://linuxcare.com.au/sfr
 P: 1024/BD8C7805 CD A4 9D 01 10 6E 7E 3B  91 88 FA D9 C8 40 AA 02
 D: Boot/setup/build work for setup > 2K
diff -ruN 2.2.19pre8/arch/i386/kernel/apm.c 2.2.19pre8-APM.1/arch/i386/kernel/apm.c
--- 2.2.19pre8/arch/i386/kernel/apm.c	Mon Dec 11 12:24:58 2000
+++ 2.2.19pre8-APM.1/arch/i386/kernel/apm.c	Mon Feb  5 17:04:15 2001
@@ -36,6 +36,7 @@
  * Oct 1999, Version 1.10
  * Nov 1999, Version 1.11
  * Jan 2000, Version 1.12
+ * Feb 2000, Version 1.13
  *
  * History:
  *    0.6b: first version in official kernel, Linux 1.3.46
@@ -55,7 +56,7 @@
  *         The new replacment for it is, but Linux doesn't yet support this.
  *         Alan Cox Linux 2.1.55
  *    1.3: Set up a valid data descriptor 0x40 for buggy BIOS's
- *    1.4: Upgraded to support APM 1.2. Integrated ThinkPad suspend patch by 
+ *    1.4: Upgraded to support APM 1.2. Integrated ThinkPad suspend patch by
  *         Dean Gaudet <dgaudet@arctic.org>.
  *         C. Scott Ananian <cananian@alumni.princeton.edu> Linux 2.1.87
  *    1.5: Fix segment register reloading (in case of bad segments saved
@@ -127,7 +128,7 @@
  *         scripts that check for it before doing power off
  *         work (Jim Avera <jima@hal.com>).
  *   1.13: Fix the Thinkpad (again) :-( (CONFIG_APM_IGNORE_MULTIPLE_SUSPENDS
- *         is now the way life works). 
+ *         is now the way life works).
  *         Fix thinko in suspend() (wrong return).
  *   1.13ac: Added apm_battery_horked() for Compal boards (Dell 5000e etc)
  *
@@ -242,8 +243,8 @@
 
 /*
  * Define to re-initialize the interrupt 0 timer to 100 Hz after a suspend.
- * This patched by Chad Miller <cmiller@surfsouth.com>, orig code by David 
- * Chen <chen@ctpa04.mit.edu>
+ * This patched by Chad Miller <cmiller@surfsouth.com>, original code by
+ * David Chen <chen@ctpa04.mit.edu>
  */
 #undef INIT_TIMER_AFTER_SUSPEND
 
@@ -326,7 +327,6 @@
 #else
 static int			power_off_enabled = 1;
 #endif
-static int 			dell_crap = 0;	/*Set if we find a 5000e */
 
 static DECLARE_WAIT_QUEUE_HEAD(apm_waitqueue);
 static DECLARE_WAIT_QUEUE_HEAD(apm_suspend_waitqueue);
@@ -522,7 +522,7 @@
 			&dummy, &dummy))
 		return (eax >> 8) & 0xff;
 	*event = ebx;
-	if (apm_bios_info.version < 0x0102)
+	if (apm_info.connection_version < 0x0102)
 		*info = ~0; /* indicate info not valid */
 	else
 		*info = ecx;
@@ -554,7 +554,7 @@
 #ifdef ALWAYS_CALL_BUSY
 	clock_slowed = 1;
 #else
-	clock_slowed = (apm_bios_info.flags & APM_IDLE_SLOWS_CLOCK) != 0;
+	clock_slowed = (apm_info.bios.flags & APM_IDLE_SLOWS_CLOCK) != 0;
 #endif
 	return 1;
 }
@@ -620,7 +620,7 @@
 	 * This may be called on an SMP machine.
 	 */
 #ifdef CONFIG_SMP
-	/* Many bioses don't like being called from CPU != 0 */
+	/* Some bioses don't like being called from CPU != 0 */
 	while (cpu_number_map[smp_processor_id()] != 0) {
 		kernel_thread(apm_magic, NULL,
 			CLONE_FS | CLONE_FILES | CLONE_SIGHAND | SIGCHLD);
@@ -638,15 +638,15 @@
 {
 	u32	eax;
 
-	if ((enable == 0) && (apm_bios_info.flags & APM_BIOS_DISENGAGED))
+	if ((enable == 0) && (apm_info.bios.flags & APM_BIOS_DISENGAGED))
 		return APM_NOT_ENGAGED;
 	if (apm_bios_call_simple(APM_FUNC_ENABLE_PM, APM_DEVICE_BALL,
 			enable, &eax))
 		return (eax >> 8) & 0xff;
 	if (enable)
-		apm_bios_info.flags &= ~APM_BIOS_DISABLED;
+		apm_info.bios.flags &= ~APM_BIOS_DISABLED;
 	else
-		apm_bios_info.flags |= APM_BIOS_DISABLED;
+		apm_info.bios.flags |= APM_BIOS_DISABLED;
 	return APM_SUCCESS;
 }
 
@@ -658,6 +658,8 @@
 	u32	edx;
 	u32	dummy;
 
+	if (apm_info.get_power_status_broken)
+		return APM_32_UNSUPPORTED;
 	if (apm_bios_call(APM_FUNC_GET_STATUS, APM_DEVICE_ALL, 0,
 			&eax, &ebx, &ecx, &edx, &dummy))
 		return (eax >> 8) & 0xff;
@@ -677,7 +679,7 @@
 	u32	edx;
 	u32	esi;
 
-	if (apm_bios_info.version < 0x0102) {
+	if (apm_info.connection_version < 0x0102) {
 		/* pretend we only have one battery. */
 		if (which != 1)
 			return APM_BAD_DEVICE;
@@ -701,15 +703,15 @@
 	u32	eax;
 
 	if ((enable == 0) && (device == APM_DEVICE_ALL)
-	    && (apm_bios_info.flags & APM_BIOS_DISABLED))
+	    && (apm_info.bios.flags & APM_BIOS_DISABLED))
 		return APM_DISABLED;
 	if (apm_bios_call_simple(APM_FUNC_ENGAGE_PM, device, enable, &eax))
 		return (eax >> 8) & 0xff;
 	if (device == APM_DEVICE_ALL) {
 		if (enable)
-			apm_bios_info.flags &= ~APM_BIOS_DISENGAGED;
+			apm_info.bios.flags &= ~APM_BIOS_DISENGAGED;
 		else
-			apm_bios_info.flags |= APM_BIOS_DISENGAGED;
+			apm_info.bios.flags |= APM_BIOS_DISENGAGED;
 	}
 	return APM_SUCCESS;
 }
@@ -931,7 +933,7 @@
 		if (call->callback(event) && undo) {
 			for (fix = callback_list; fix != call; fix = fix->next)
 				fix->callback(undo);
-			if (apm_bios_info.version > 0x100)
+			if (apm_info.connection_version > 0x100)
 				apm_set_power_state(APM_STATE_REJECT);
 			return 0;
 		}
@@ -974,7 +976,7 @@
 
 		case APM_USER_SUSPEND:
 #ifdef CONFIG_APM_IGNORE_USER_SUSPEND
-			if (apm_bios_info.version > 0x100)
+			if (apm_info.connection_version > 0x100)
 				apm_set_power_state(APM_STATE_REJECT);
 			break;
 #endif
@@ -1035,7 +1037,7 @@
 	int		err;
 
 	if ((standbys_pending > 0) || (suspends_pending > 0)) {
-		if ((apm_bios_info.version > 0x100) && (pending_count-- <= 0)) {
+		if ((apm_info.connection_version > 0x100) && (pending_count-- <= 0)) {
 			pending_count = 4;
 			if (debug)
 				printk(KERN_DEBUG "apm: setting state busy\n");
@@ -1244,18 +1246,6 @@
 	return 0;
 }
 
-/*
- *	This is called by the DMI code when it finds an Inspiron 5000e
- *	(aka compal reference board). We actually do the check by the BIOS
- *	vendor name, version and serial so we can extend it to try and catch
- *	non Dell stuff later.
- */
- 
-void apm_battery_horked(void)
-{
-	dell_crap = 1;
-}
-
 static int apm_get_info(char *buf, char **start, off_t fpos, int length, int dummy)
 {
 	char *		p;
@@ -1272,14 +1262,14 @@
 
 	p = buf;
 
-	if ((smp_num_cpus == 1) && (!dell_crap) && 
+	if ((smp_num_cpus == 1) &&
 	    !(error = apm_get_power_status(&bx, &cx, &dx))) {
 		ac_line_status = (bx >> 8) & 0xff;
 		battery_status = bx & 0xff;
 		if ((cx & 0xff) != 0xff)
 			percentage = cx & 0xff;
 
-		if (apm_bios_info.version > 0x100) {
+		if (apm_info.connection_version > 0x100) {
 			battery_flag = (cx >> 8) & 0xff;
 			if (dx != 0xffff) {
 				units = (dx & 0x8000) ? "min" : "sec";
@@ -1327,9 +1317,9 @@
 
 	p += sprintf(p, "%s %d.%d 0x%02x 0x%02x 0x%02x 0x%02x %d%% %d %s\n",
 		     driver_version,
-		     (apm_bios_info.version >> 8) & 0xff,
-		     apm_bios_info.version & 0xff,
-		     apm_bios_info.flags,
+		     (apm_info.bios.version >> 8) & 0xff,
+		     apm_info.bios.version & 0xff,
+		     apm_info.bios.flags,
 		     ac_line_status,
 		     battery_status,
 		     battery_flag,
@@ -1349,22 +1339,28 @@
 	char *		power_stat;
 	char *		bat_stat;
 
-	if (apm_bios_info.version > 0x100) {
-		/*
-		 * We only support BIOSs up to version 1.2
-		 */
-		if (apm_bios_info.version > 0x0102)
-			apm_bios_info.version = 0x0102;
-		if (apm_driver_version(&apm_bios_info.version) != APM_SUCCESS) {
-			/* Fall back to an APM 1.0 connection. */
-			apm_bios_info.version = 0x100;
+	if (apm_info.connection_version == 0) {
+		apm_info.connection_version = apm_info.bios.version;
+		if (apm_info.connection_version > 0x100) {
+			/*
+			 * We only support BIOSs up to version 1.2
+			 */
+			if (apm_info.connection_version > 0x0102)
+				apm_info.connection_version = 0x0102;
+			error = apm_driver_version(&apm_info.connection_version);
+			if (error != APM_SUCCESS) {
+				apm_error("driver version", error);
+				/* Fall back to an APM 1.0 connection. */
+				apm_info.connection_version = 0x100;
+			}
 		}
 	}
-	if (debug && (smp_num_cpus == 1)) {
+	if (debug)
 		printk(KERN_INFO "apm: Connection version %d.%d\n",
-			(apm_bios_info.version >> 8) & 0xff,
-			apm_bios_info.version & 0xff);
+			(apm_info.connection_version >> 8) & 0xff,
+			apm_info.connection_version & 0xff);
 
+	if (debug && (smp_num_cpus == 1)) {
 		error = apm_get_power_status(&bx, &cx, &dx);
 		if (error)
 			printk(KERN_INFO "apm: power status not available\n");
@@ -1389,7 +1385,7 @@
 				printk("unknown\n");
 			else
 				printk("%d%%\n", cx & 0xff);
-			if (apm_bios_info.version > 0x100) {
+			if (apm_info.connection_version > 0x100) {
 				printk(KERN_INFO
 				       "apm: battery flag 0x%02x, battery life ",
 				       (cx >> 8) & 0xff);
@@ -1404,7 +1400,7 @@
 	}
 
 #ifdef CONFIG_APM_DO_ENABLE
-	if (apm_bios_info.flags & APM_BIOS_DISABLED) {
+	if (apm_info.bios.flags & APM_BIOS_DISABLED) {
 		/*
 		 * This call causes my NEC UltraLite Versa 33/C to hang if it
 		 * is booted with PM disabled but not in the docking station.
@@ -1417,8 +1413,8 @@
 		}
 	}
 #endif
-	if ((apm_bios_info.flags & APM_BIOS_DISENGAGED)
-	    && (apm_bios_info.version > 0x0100)) {
+	if ((apm_info.bios.flags & APM_BIOS_DISENGAGED)
+	    && (apm_info.connection_version > 0x0100)) {
 		error = apm_engage_power_management(APM_DEVICE_ALL, 1);
 		if (error) {
 			apm_error("engage power management", error);
@@ -1482,17 +1478,17 @@
 
 static int __init apm_init(void)
 {
-	if (apm_bios_info.version == 0) {
+	if (apm_info.bios.version == 0) {
 		printk(KERN_INFO "apm: BIOS not found.\n");
 		return -ENODEV;
 	}
 	printk(KERN_INFO
 		"apm: BIOS version %d.%d Flags 0x%02x (Driver version %s)\n",
-		((apm_bios_info.version >> 8) & 0xff),
-		(apm_bios_info.version & 0xff),
-		apm_bios_info.flags,
+		((apm_info.bios.version >> 8) & 0xff),
+		(apm_info.bios.version & 0xff),
+		apm_info.bios.flags,
 		driver_version);
-	if ((apm_bios_info.flags & APM_32_BIT_SUPPORT) == 0) {
+	if ((apm_info.bios.flags & APM_32_BIT_SUPPORT) == 0) {
 		printk(KERN_INFO "apm: no 32 bit BIOS support\n");
 		return -ENODEV;
 	}
@@ -1501,23 +1497,23 @@
 	 * Fix for the Compaq Contura 3/25c which reports BIOS version 0.1
 	 * but is reportedly a 1.0 BIOS.
 	 */
-	if (apm_bios_info.version == 0x001)
-		apm_bios_info.version = 0x100;
+	if (apm_info.bios.version == 0x001)
+		apm_info.bios.version = 0x100;
 
 	/* BIOS < 1.2 doesn't set cseg_16_len */
-	if (apm_bios_info.version < 0x102)
-		apm_bios_info.cseg_16_len = 0; /* 64k */
+	if (apm_info.bios.version < 0x102)
+		apm_info.bios.cseg_16_len = 0; /* 64k */
 
 	if (debug) {
 		printk(KERN_INFO "apm: entry %x:%lx cseg16 %x dseg %x",
-			apm_bios_info.cseg, apm_bios_info.offset,
-			apm_bios_info.cseg_16, apm_bios_info.dseg);
-		if (apm_bios_info.version > 0x100)
+			apm_info.bios.cseg, apm_info.bios.offset,
+			apm_info.bios.cseg_16, apm_info.bios.dseg);
+		if (apm_info.bios.version > 0x100)
 			printk(" cseg len %x, dseg len %x",
-				apm_bios_info.cseg_len,
-				apm_bios_info.dseg_len);
-		if (apm_bios_info.version > 0x101)
-			printk(" cseg16 len %x", apm_bios_info.cseg_16_len);
+				apm_info.bios.cseg_len,
+				apm_info.bios.dseg_len);
+		if (apm_info.bios.version > 0x101)
+			printk(" cseg16 len %x", apm_info.bios.cseg_16_len);
 		printk("\n");
 	}
 
@@ -1540,16 +1536,16 @@
 		 __va((unsigned long)0x40 << 4));
 	_set_limit((char *)&gdt[APM_40 >> 3], 4095 - (0x40 << 4));
 
-	apm_bios_entry.offset = apm_bios_info.offset;
+	apm_bios_entry.offset = apm_info.bios.offset;
 	apm_bios_entry.segment = APM_CS;
 	set_base(gdt[APM_CS >> 3],
-		 __va((unsigned long)apm_bios_info.cseg << 4));
+		 __va((unsigned long)apm_info.bios.cseg << 4));
 	set_base(gdt[APM_CS_16 >> 3],
-		 __va((unsigned long)apm_bios_info.cseg_16 << 4));
+		 __va((unsigned long)apm_info.bios.cseg_16 << 4));
 	set_base(gdt[APM_DS >> 3],
-		 __va((unsigned long)apm_bios_info.dseg << 4));
+		 __va((unsigned long)apm_info.bios.dseg << 4));
 #ifndef APM_RELAX_SEGMENTS
-	if (apm_bios_info.version == 0x100) {
+	if (apm_info.bios.version == 0x100) {
 #endif
 		/* For ASUS motherboard, Award BIOS rev 110 (and others?) */
 		_set_limit((char *)&gdt[APM_CS >> 3], 64 * 1024 - 1);
@@ -1560,11 +1556,11 @@
 #ifndef APM_RELAX_SEGMENTS
 	} else {
 		_set_limit((char *)&gdt[APM_CS >> 3],
-			(apm_bios_info.cseg_len - 1) & 0xffff);
+			(apm_info.bios.cseg_len - 1) & 0xffff);
 		_set_limit((char *)&gdt[APM_CS_16 >> 3],
-			(apm_bios_info.cseg_16_len - 1) & 0xffff);
+			(apm_info.bios.cseg_16_len - 1) & 0xffff);
 		_set_limit((char *)&gdt[APM_DS >> 3],
-			(apm_bios_info.dseg_len - 1) & 0xffff);
+			(apm_info.bios.dseg_len - 1) & 0xffff);
 	}
 #endif
 
diff -ruN 2.2.19pre8/arch/i386/kernel/dmi_scan.c 2.2.19pre8-APM.1/arch/i386/kernel/dmi_scan.c
--- 2.2.19pre8/arch/i386/kernel/dmi_scan.c	Mon Dec 11 12:24:58 2000
+++ 2.2.19pre8-APM.1/arch/i386/kernel/dmi_scan.c	Thu Jan 18 23:04:57 2001
@@ -1,8 +1,8 @@
-#include <linux/config.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/init.h>
+#include <linux/apm_bios.h>
 #include <asm/io.h>
 
 struct dmi_header
@@ -125,17 +125,19 @@
 			 *	< Does it Boot Win98 >-N--
 			 *               |Y
 			 *           [Ship It]
+			 *
+			 *	Phoenix A04  08/24/2000 is known bad (Dell Inspiron 5000e)
+			 *	Phoenix A07  09/29/2000 is known good (Dell Inspiron 5000)
 			 */
 			 
-			if(strcmp(dmi_string(dm, data[4]), "Phoenix Technologies LTD")==0 &&
-			   strcmp(dmi_string(dm, data[5]), "A04")==0 &&
-			   strcmp(dmi_string(dm, data[8]), "08/24/2000")==0)
+			if(strcmp(dmi_string(dm, data[4]), "Phoenix Technologies LTD")==0)
 			{
-#ifdef CONFIG_APM
-				extern void apm_battery_horked(void);
-			   	apm_battery_horked();			   	
-			   	printk(KERN_WARNING "BIOS strings suggest APM bugs, disabling battery reporting.\n");
-#endif			   	
+				if(strcmp(dmi_string(dm, data[5]), "A04")==0 
+					&& strcmp(dmi_string(dm, data[8]), "08/24/2000")==0)
+				{
+				   	apm_info.get_power_status_broken = 1;
+					printk(KERN_WARNING "BIOS strings suggest APM bugs, disabling power status reporting.\n");
+				}
 			}
 			break;
 #ifdef DUMP_DMI
diff -ruN 2.2.19pre8/arch/i386/kernel/setup.c 2.2.19pre8-APM.1/arch/i386/kernel/setup.c
--- 2.2.19pre8/arch/i386/kernel/setup.c	Mon Feb  5 13:46:02 2001
+++ 2.2.19pre8-APM.1/arch/i386/kernel/setup.c	Thu Jan 18 23:07:09 2001
@@ -99,7 +99,7 @@
  */
 struct drive_info_struct { char dummy[32]; } drive_info;
 struct screen_info screen_info;
-struct apm_bios_info apm_bios_info;
+struct apm_info apm_info;
 struct sys_desc_table_struct {
 	unsigned short length;
 	unsigned char table[0];
@@ -403,7 +403,7 @@
  	ROOT_DEV = to_kdev_t(ORIG_ROOT_DEV);
  	drive_info = DRIVE_INFO;
  	screen_info = SCREEN_INFO;
-	apm_bios_info = APM_BIOS_INFO;
+	apm_info.bios = APM_BIOS_INFO;
 	if( SYS_DESC_TABLE.length != 0 ) {
 		MCA_bus = SYS_DESC_TABLE.table[3] &0x2;
 		machine_id = SYS_DESC_TABLE.table[0];
diff -ruN 2.2.19pre8/include/linux/apm_bios.h 2.2.19pre8-APM.1/include/linux/apm_bios.h
--- 2.2.19pre8/include/linux/apm_bios.h	Mon Dec 11 12:25:25 2000
+++ 2.2.19pre8-APM.1/include/linux/apm_bios.h	Thu Jan 18 23:08:32 2001
@@ -38,7 +38,7 @@
 	unsigned short	dseg_len;
 };
 
-				/* Results of APM Installation Check */
+/* Results of APM Installation Check */
 #define APM_16_BIT_SUPPORT	0x0001
 #define APM_32_BIT_SUPPORT	0x0002
 #define APM_IDLE_SLOWS_CLOCK	0x0004
@@ -46,6 +46,15 @@
 #define APM_BIOS_DISENGAGED     0x0010
 
 /*
+ * Data for APM that is persistant across module unload/load
+ */
+struct apm_info {
+	struct apm_bios_info	bios;
+	unsigned short		connection_version;
+	int			get_power_status_broken;
+};
+
+/*
  * The APM function codes
  */
 #define	APM_FUNC_INST_CHECK	0x5300
@@ -91,9 +100,9 @@
 #define	APM_FUNC_TIMER_GET	2
 
 /*
- * in init/main.c
+ * in arch/i386/kernel/setup.c
  */
-extern struct apm_bios_info	apm_bios_info;
+extern struct apm_info	apm_info;
 
 extern int		apm_register_callback(int (*callback)(apm_event_t));
 extern void		apm_unregister_callback(int (*callback)(apm_event_t));
@@ -176,7 +185,7 @@
 /*
  * This is the "All Devices" ID communicated to the BIOS
  */
-#define APM_DEVICE_BALL		((apm_bios_info.version > 0x0100) ? \
+#define APM_DEVICE_BALL		((apm_info.connection_version > 0x0100) ? \
 				 APM_DEVICE_ALL : APM_DEVICE_OLD_ALL)
 #endif
 
------------------------------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
