Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129514AbQKWDVY>; Wed, 22 Nov 2000 22:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129529AbQKWDVN>; Wed, 22 Nov 2000 22:21:13 -0500
Received: from linuxcare.com.au ([203.29.91.49]:35598 "EHLO
        front.linuxcare.com.au") by vger.kernel.org with ESMTP
        id <S129514AbQKWDVC>; Wed, 22 Nov 2000 22:21:02 -0500
Message-Id: <200011230250.eAN2oj100869@wattle.linuxcare.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0test11-ac2 
In-Reply-To: Your message of Wed, 22 Nov 2000 18:11:30 +0100.
             <E13yeMn-0006HW-00@the-village.bc.nu> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <866.974947844.1@linuxcare.com.au>
Date: Thu, 23 Nov 2000 13:50:44 +1100
From: Stephen Rothwell <sfr@linuxcare.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> Changes in 2.4.0test11ac2
> 
> o	APM update 					(Stephen Rothwell)
> o	Work arounds for broken Dell laptop APM		(me)

Here is (in my opinion) a better patch.  It also means that we can
use apm as a module and have the Dell workaround work.

Most of this patch is a change of mind on my part after I posted
my previous patch ... (sorry about that).

This patch also make unloading of the apm module impossible is
someone has /proc/apm open ...  (BUG FIX)

Patch against 2.4.0test11ac2.

Cheers,
Stephen
-- 
Stephen Rothwell, Open Source Researcher, Linuxcare, Inc.
+61-2-62628990 tel, +61-2-62628991 fax 
sfr@linuxcare.com, http://www.linuxcare.com/ 
Linuxcare. Support for the revolution.

diff -ruN 2.4.0-test11-ac2/arch/i386/kernel/apm.c 2.4.0-test11-ac2-APM.2/arch/i386/kernel/apm.c
--- 2.4.0-test11-ac2/arch/i386/kernel/apm.c	Thu Nov 23 10:29:19 2000
+++ 2.4.0-test11-ac2-APM.2/arch/i386/kernel/apm.c	Thu Nov 23 12:47:02 2000
@@ -338,7 +338,6 @@
 #endif
 static int			debug;
 static int			apm_disabled;
-static int			dell_crap;	/* Set for broken 5000e */
 #ifdef CONFIG_SMP
 static int			power_off;
 #else
@@ -564,7 +563,7 @@
 #ifdef ALWAYS_CALL_BUSY
 	clock_slowed = 1;
 #else
-	clock_slowed = (apm_info.bios_info.flags & APM_IDLE_SLOWS_CLOCK) != 0;
+	clock_slowed = (apm_info.bios.flags & APM_IDLE_SLOWS_CLOCK) != 0;
 #endif
 	return 1;
 }
@@ -675,15 +674,15 @@
 {
 	u32	eax;
 
-	if ((enable == 0) && (apm_info.bios_info.flags & APM_BIOS_DISENGAGED))
+	if ((enable == 0) && (apm_info.bios.flags & APM_BIOS_DISENGAGED))
 		return APM_NOT_ENGAGED;
 	if (apm_bios_call_simple(APM_FUNC_ENABLE_PM, APM_DEVICE_BALL,
 			enable, &eax))
 		return (eax >> 8) & 0xff;
 	if (enable)
-		apm_info.bios_info.flags &= ~APM_BIOS_DISABLED;
+		apm_info.bios.flags &= ~APM_BIOS_DISABLED;
 	else
-		apm_info.bios_info.flags |= APM_BIOS_DISABLED;
+		apm_info.bios.flags |= APM_BIOS_DISABLED;
 	return APM_SUCCESS;
 }
 #endif
@@ -696,6 +695,8 @@
 	u32	edx;
 	u32	dummy;
 
+	if (apm_info.get_power_status_broken)
+		return APM_32_UNSUPPORTED;
 	if (apm_bios_call(APM_FUNC_GET_STATUS, APM_DEVICE_ALL, 0,
 			&eax, &ebx, &ecx, &edx, &dummy))
 		return (eax >> 8) & 0xff;
@@ -739,15 +740,15 @@
 	u32	eax;
 
 	if ((enable == 0) && (device == APM_DEVICE_ALL)
-	    && (apm_info.bios_info.flags & APM_BIOS_DISABLED))
+	    && (apm_info.bios.flags & APM_BIOS_DISABLED))
 		return APM_DISABLED;
 	if (apm_bios_call_simple(APM_FUNC_ENGAGE_PM, device, enable, &eax))
 		return (eax >> 8) & 0xff;
 	if (device == APM_DEVICE_ALL) {
 		if (enable)
-			apm_info.bios_info.flags &= ~APM_BIOS_DISENGAGED;
+			apm_info.bios.flags &= ~APM_BIOS_DISENGAGED;
 		else
-			apm_info.bios_info.flags |= APM_BIOS_DISENGAGED;
+			apm_info.bios.flags |= APM_BIOS_DISENGAGED;
 	}
 	return APM_SUCCESS;
 }
@@ -1333,19 +1334,6 @@
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
-
 static int apm_get_info(char *buf, char **start, off_t fpos, int length)
 {
 	char *		p;
@@ -1362,7 +1350,7 @@
 
 	p = buf;
 
-	if ((smp_num_cpus == 1) && !dell_crap &&
+	if ((smp_num_cpus == 1) &&
 	    !(error = apm_get_power_status(&bx, &cx, &dx))) {
 		ac_line_status = (bx >> 8) & 0xff;
 		battery_status = bx & 0xff;
@@ -1417,9 +1405,9 @@
 
 	p += sprintf(p, "%s %d.%d 0x%02x 0x%02x 0x%02x 0x%02x %d%% %d %s\n",
 		     driver_version,
-		     (apm_info.bios_info.version >> 8) & 0xff,
-		     apm_info.bios_info.version & 0xff,
-		     apm_info.bios_info.flags,
+		     (apm_info.bios.version >> 8) & 0xff,
+		     apm_info.bios.version & 0xff,
+		     apm_info.bios.flags,
 		     ac_line_status,
 		     battery_status,
 		     battery_flag,
@@ -1448,7 +1436,7 @@
 	current->tty = NULL;	/* get rid of controlling tty */
 
 	if (apm_info.connection_version == 0) {
-		apm_info.connection_version = apm_info.bios_info.version;
+		apm_info.connection_version = apm_info.bios.version;
 		if (apm_info.connection_version > 0x100) {
 			/*
 			 * We only support BIOSs up to version 1.2
@@ -1470,7 +1458,7 @@
 			apm_info.connection_version & 0xff);
 
 #ifdef CONFIG_APM_DO_ENABLE
-	if (apm_info.bios_info.flags & APM_BIOS_DISABLED) {
+	if (apm_info.bios.flags & APM_BIOS_DISABLED) {
 		/*
 		 * This call causes my NEC UltraLite Versa 33/C to hang if it
 		 * is booted with PM disabled but not in the docking station.
@@ -1484,7 +1472,7 @@
 	}
 #endif
 
-	if ((apm_info.bios_info.flags & APM_BIOS_DISENGAGED)
+	if ((apm_info.bios.flags & APM_BIOS_DISENGAGED)
 	    && (apm_info.connection_version > 0x0100)) {
 		error = apm_engage_power_management(APM_DEVICE_ALL, 1);
 		if (error) {
@@ -1610,17 +1598,19 @@
  */
 static int __init apm_init(void)
 {
-	if (apm_info.bios_info.version == 0) {
+	struct proc_dir_entry *apm_proc;
+
+	if (apm_info.bios.version == 0) {
 		printk(KERN_INFO "apm: BIOS not found.\n");
 		return -ENODEV;
 	}
 	printk(KERN_INFO
 		"apm: BIOS version %d.%d Flags 0x%02x (Driver version %s)\n",
-		((apm_info.bios_info.version >> 8) & 0xff),
-		(apm_info.bios_info.version & 0xff),
-		apm_info.bios_info.flags,
+		((apm_info.bios.version >> 8) & 0xff),
+		(apm_info.bios.version & 0xff),
+		apm_info.bios.flags,
 		driver_version);
-	if ((apm_info.bios_info.flags & APM_32_BIT_SUPPORT) == 0) {
+	if ((apm_info.bios.flags & APM_32_BIT_SUPPORT) == 0) {
 		printk(KERN_INFO "apm: no 32 bit BIOS support\n");
 		return -ENODEV;
 	}
@@ -1629,23 +1619,23 @@
 	 * Fix for the Compaq Contura 3/25c which reports BIOS version 0.1
 	 * but is reportedly a 1.0 BIOS.
 	 */
-	if (apm_info.bios_info.version == 0x001)
-		apm_info.bios_info.version = 0x100;
+	if (apm_info.bios.version == 0x001)
+		apm_info.bios.version = 0x100;
 
 	/* BIOS < 1.2 doesn't set cseg_16_len */
-	if (apm_info.bios_info.version < 0x102)
-		apm_info.bios_info.cseg_16_len = 0; /* 64k */
+	if (apm_info.bios.version < 0x102)
+		apm_info.bios.cseg_16_len = 0; /* 64k */
 
 	if (debug) {
 		printk(KERN_INFO "apm: entry %x:%lx cseg16 %x dseg %x",
-			apm_info.bios_info.cseg, apm_info.bios_info.offset,
-			apm_info.bios_info.cseg_16, apm_info.bios_info.dseg);
-		if (apm_info.bios_info.version > 0x100)
+			apm_info.bios.cseg, apm_info.bios.offset,
+			apm_info.bios.cseg_16, apm_info.bios.dseg);
+		if (apm_info.bios.version > 0x100)
 			printk(" cseg len %x, dseg len %x",
-				apm_info.bios_info.cseg_len,
-				apm_info.bios_info.dseg_len);
-		if (apm_info.bios_info.version > 0x101)
-			printk(" cseg16 len %x", apm_info.bios_info.cseg_16_len);
+				apm_info.bios.cseg_len,
+				apm_info.bios.dseg_len);
+		if (apm_info.bios.version > 0x101)
+			printk(" cseg16 len %x", apm_info.bios.cseg_16_len);
 		printk("\n");
 	}
 
@@ -1673,16 +1663,16 @@
 		 __va((unsigned long)0x40 << 4));
 	_set_limit((char *)&gdt[APM_40 >> 3], 4095 - (0x40 << 4));
 
-	apm_bios_entry.offset = apm_info.bios_info.offset;
+	apm_bios_entry.offset = apm_info.bios.offset;
 	apm_bios_entry.segment = APM_CS;
 	set_base(gdt[APM_CS >> 3],
-		 __va((unsigned long)apm_info.bios_info.cseg << 4));
+		 __va((unsigned long)apm_info.bios.cseg << 4));
 	set_base(gdt[APM_CS_16 >> 3],
-		 __va((unsigned long)apm_info.bios_info.cseg_16 << 4));
+		 __va((unsigned long)apm_info.bios.cseg_16 << 4));
 	set_base(gdt[APM_DS >> 3],
-		 __va((unsigned long)apm_info.bios_info.dseg << 4));
+		 __va((unsigned long)apm_info.bios.dseg << 4));
 #ifndef APM_RELAX_SEGMENTS
-	if (apm_info.bios_info.version == 0x100) {
+	if (apm_info.bios.version == 0x100) {
 #endif
 		/* For ASUS motherboard, Award BIOS rev 110 (and others?) */
 		_set_limit((char *)&gdt[APM_CS >> 3], 64 * 1024 - 1);
@@ -1693,15 +1683,17 @@
 #ifndef APM_RELAX_SEGMENTS
 	} else {
 		_set_limit((char *)&gdt[APM_CS >> 3],
-			(apm_info.bios_info.cseg_len - 1) & 0xffff);
+			(apm_info.bios.cseg_len - 1) & 0xffff);
 		_set_limit((char *)&gdt[APM_CS_16 >> 3],
-			(apm_info.bios_info.cseg_16_len - 1) & 0xffff);
+			(apm_info.bios.cseg_16_len - 1) & 0xffff);
 		_set_limit((char *)&gdt[APM_DS >> 3],
-			(apm_info.bios_info.dseg_len - 1) & 0xffff);
+			(apm_info.bios.dseg_len - 1) & 0xffff);
 	}
 #endif
 
-	create_proc_info_entry("apm", 0, NULL, apm_get_info);
+	apm_proc = create_proc_info_entry("apm", 0, NULL, apm_get_info);
+	if (apm_proc)
+		apm_proc->owner = THIS_MODULE;
 
 	kernel_thread(apm, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGHAND | SIGCHLD);
 
@@ -1720,7 +1712,7 @@
 {
 	int	error;
 
-	if (((apm_info.bios_info.flags & APM_BIOS_DISENGAGED) == 0)
+	if (((apm_info.bios.flags & APM_BIOS_DISENGAGED) == 0)
 	    && (apm_info.connection_version > 0x0100)) {
 		error = apm_engage_power_management(APM_DEVICE_ALL, 0);
 		if (error)
diff -ruN 2.4.0-test11-ac2/arch/i386/kernel/dmi_scan.c 2.4.0-test11-ac2-APM.2/arch/i386/kernel/dmi_scan.c
--- 2.4.0-test11-ac2/arch/i386/kernel/dmi_scan.c	Thu Nov 23 10:29:19 2000
+++ 2.4.0-test11-ac2-APM.2/arch/i386/kernel/dmi_scan.c	Thu Nov 23 12:49:28 2000
@@ -3,6 +3,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/init.h>
+#include <linux/apm_bios.h>
 #include <asm/io.h>
 
 struct dmi_header
@@ -127,11 +128,8 @@
 			   strcmp(dmi_string(dm, data[5]), "A04")==0)
 //			   &&strcmp(dmi_string(dm, data[8]), "???")==0)
 			{
-#ifdef CONFIG_APM
-				extern void apm_battery_horked(void);
-			   	apm_battery_horked();			   	
-			   	printk(KERN_WARNING "BIOS strings suggest APM bugs, disabling battery reporting.\n");
-#endif			   	
+			   	apm_info.get_power_status_broken = 1;
+			   	printk(KERN_WARNING "BIOS strings suggest APM bugs, disabling power status reporting.\n");
 			}
 			break;
 		case 1:
diff -ruN 2.4.0-test11-ac2/arch/i386/kernel/setup.c 2.4.0-test11-ac2-APM.2/arch/i386/kernel/setup.c
--- 2.4.0-test11-ac2/arch/i386/kernel/setup.c	Thu Nov 23 10:29:19 2000
+++ 2.4.0-test11-ac2-APM.2/arch/i386/kernel/setup.c	Thu Nov 23 12:06:10 2000
@@ -608,7 +608,7 @@
  	ROOT_DEV = to_kdev_t(ORIG_ROOT_DEV);
  	drive_info = DRIVE_INFO;
  	screen_info = SCREEN_INFO;
-	apm_info.bios_info = APM_BIOS_INFO;
+	apm_info.bios = APM_BIOS_INFO;
 	if( SYS_DESC_TABLE.length != 0 ) {
 		MCA_bus = SYS_DESC_TABLE.table[3] &0x2;
 		machine_id = SYS_DESC_TABLE.table[0];
diff -ruN 2.4.0-test11-ac2/include/linux/apm_bios.h 2.4.0-test11-ac2-APM.2/include/linux/apm_bios.h
--- 2.4.0-test11-ac2/include/linux/apm_bios.h	Thu Nov 23 10:29:22 2000
+++ 2.4.0-test11-ac2-APM.2/include/linux/apm_bios.h	Thu Nov 23 12:47:33 2000
@@ -49,8 +49,9 @@
  * Data for APM that is persistant across module unload/load
  */
 struct apm_info {
-	struct apm_bios_info	bios_info;
+	struct apm_bios_info	bios;
 	unsigned short		connection_version;
+	int			get_power_status_broken;
 };
 
 /*
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
