Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130265AbQLAGk3>; Fri, 1 Dec 2000 01:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129756AbQLAGkT>; Fri, 1 Dec 2000 01:40:19 -0500
Received: from linuxcare.com.au ([203.29.91.49]:1555 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S129516AbQLAGkH>; Fri, 1 Dec 2000 01:40:07 -0500
Message-Id: <200012010609.eB169YI11916@wattle.linuxcare.com.au>
To: torvalds@transmeta.com
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        linux-laptop@vger.kernel.org
Subject: [PATCH]  Various APM fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <11913.975650973.1@linuxcare.com.au>
Date: Fri, 01 Dec 2000 17:09:33 +1100
From: Stephen Rothwell <sfr@linuxcare.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is essentially what Alan has in his ac tree.  It does the following:

	make unloading and loading of the apm module
		reliable.
	enable and engage the APM BIOS a bit earlier
	allow for Dell bad BIOS workaround

The first required that the connection version be included in the
persistant data for the apm driver (thus the apm_bios_info -> apm_info
change). Also, we needed to tell procfs that we were a module and disengage
from the BIOS connection when the module was unloaded.

The last is the apm_info.get_power_status_broken variable which will
be set by Alan's dmi_scan routines (if necessary) when they are included.

Cheers,
Stephen
-- 
Stephen Rothwell, Open Source Researcher, Linuxcare, Inc.
+61-2-62628990 tel, +61-2-62628991 fax 
sfr@linuxcare.com, http://www.linuxcare.com/ 
Linuxcare. Support for the revolution.

diff -ruN 2.4.0-test12pre3/arch/i386/kernel/apm.c 2.4.0-test12pre3-APM.1/arch/i386/kernel/apm.c
--- 2.4.0-test12pre3/arch/i386/kernel/apm.c	Mon Nov 20 14:05:17 2000
+++ 2.4.0-test12pre3-APM.1/arch/i386/kernel/apm.c	Fri Dec  1 14:23:12 2000
@@ -37,6 +37,7 @@
  * Nov 1999, Version 1.11
  * Jan 2000, Version 1.12
  * Feb 2000, Version 1.13
+ * Nov 2000, Version 1.14
  *
  * History:
  *    0.6b: first version in official kernel, Linux 1.3.46
@@ -144,6 +145,9 @@
  *         <tmh@magenta-logic.com> and <zlatko@iskon.hr>) modified by sfr.
  *         Remove CONFIG_APM_SUSPEND_BOUNCE.  The bounce ignore
  *         interval is now configurable.
+ *   1.14: Make connection version persist across module unload/load.
+ *         Enable and engage power management earlier.
+ *         Disengage power management on module unload.
  *
  * APM 1.1 Reference:
  *
@@ -344,9 +348,9 @@
 
 static DECLARE_WAIT_QUEUE_HEAD(apm_waitqueue);
 static DECLARE_WAIT_QUEUE_HEAD(apm_suspend_waitqueue);
-static struct apm_user *	user_list = NULL;
+static struct apm_user *	user_list;
 
-static char			driver_version[] = "1.13";	/* no spaces */
+static char			driver_version[] = "1.14";	/* no spaces */
 
 static char *	apm_event_name[] = {
 	"system standby",
@@ -527,7 +531,7 @@
 			&dummy, &dummy))
 		return (eax >> 8) & 0xff;
 	*event = ebx;
-	if (apm_bios_info.version < 0x0102)
+	if (apm_info.connection_version < 0x0102)
 		*info = ~0; /* indicate info not valid */
 	else
 		*info = ecx;
@@ -559,7 +563,7 @@
 #ifdef ALWAYS_CALL_BUSY
 	clock_slowed = 1;
 #else
-	clock_slowed = (apm_bios_info.flags & APM_IDLE_SLOWS_CLOCK) != 0;
+	clock_slowed = (apm_info.bios.flags & APM_IDLE_SLOWS_CLOCK) != 0;
 #endif
 	return 1;
 }
@@ -670,15 +674,15 @@
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
 #endif
@@ -691,6 +695,8 @@
 	u32	edx;
 	u32	dummy;
 
+	if (apm_info.get_power_status_broken)
+		return APM_32_UNSUPPORTED;
 	if (apm_bios_call(APM_FUNC_GET_STATUS, APM_DEVICE_ALL, 0,
 			&eax, &ebx, &ecx, &edx, &dummy))
 		return (eax >> 8) & 0xff;
@@ -710,7 +716,7 @@
 	u32	edx;
 	u32	esi;
 
-	if (apm_bios_info.version < 0x0102) {
+	if (apm_info.connection_version < 0x0102) {
 		/* pretend we only have one battery. */
 		if (which != 1)
 			return APM_BAD_DEVICE;
@@ -734,15 +740,15 @@
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
@@ -890,7 +896,7 @@
 				printk(KERN_CRIT "apm: Critical suspend was vetoed, expect armageddon\n" );
 				return 0;
 			}
-			if (apm_bios_info.version > 0x100)
+			if (apm_info.connection_version > 0x100)
 				apm_set_power_state(APM_STATE_REJECT);
 			return 0;
 		}
@@ -993,13 +999,13 @@
 
 		case APM_USER_SUSPEND:
 #ifdef CONFIG_APM_IGNORE_USER_SUSPEND
-			if (apm_bios_info.version > 0x100)
+			if (apm_info.connection_version > 0x100)
 				apm_set_power_state(APM_STATE_REJECT);
 			break;
 #endif
 		case APM_SYS_SUSPEND:
 			if (ignore_bounce) {
-				if (apm_bios_info.version > 0x100)
+				if (apm_info.connection_version > 0x100)
 					apm_set_power_state(APM_STATE_REJECT);
 				break;
 			}
@@ -1064,7 +1070,7 @@
 	int		err;
 
 	if ((standbys_pending > 0) || (suspends_pending > 0)) {
-		if ((apm_bios_info.version > 0x100) && (pending_count-- <= 0)) {
+		if ((apm_info.connection_version > 0x100) && (pending_count-- <= 0)) {
 			pending_count = 4;
 			if (debug)
 				printk(KERN_DEBUG "apm: setting state busy\n");
@@ -1334,7 +1340,7 @@
 	unsigned short	bx;
 	unsigned short	cx;
 	unsigned short	dx;
-	unsigned short	error;
+	int		error;
 	unsigned short  ac_line_status = 0xff;
 	unsigned short  battery_status = 0xff;
 	unsigned short  battery_flag   = 0xff;
@@ -1351,7 +1357,7 @@
 		if ((cx & 0xff) != 0xff)
 			percentage = cx & 0xff;
 
-		if (apm_bios_info.version > 0x100) {
+		if (apm_info.connection_version > 0x100) {
 			battery_flag = (cx >> 8) & 0xff;
 			if (dx != 0xffff) {
 				units = (dx & 0x8000) ? "min" : "sec";
@@ -1399,9 +1405,9 @@
 
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
@@ -1417,7 +1423,7 @@
 	unsigned short	bx;
 	unsigned short	cx;
 	unsigned short	dx;
-	unsigned short	error;
+	int		error;
 	char *		power_stat;
 	char *		bat_stat;
 
@@ -1429,22 +1435,53 @@
 	sigfillset(&current->blocked);
 	current->tty = NULL;	/* get rid of controlling tty */
 
-	if (apm_bios_info.version > 0x100) {
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
+		}
+	}
+
+	if (debug)
+		printk(KERN_INFO "apm: Connection version %d.%d\n",
+			(apm_info.connection_version >> 8) & 0xff,
+			apm_info.connection_version & 0xff);
+
+#ifdef CONFIG_APM_DO_ENABLE
+	if (apm_info.bios.flags & APM_BIOS_DISABLED) {
 		/*
-		 * We only support BIOSs up to version 1.2
+		 * This call causes my NEC UltraLite Versa 33/C to hang if it
+		 * is booted with PM disabled but not in the docking station.
+		 * Unfortunate ...
 		 */
-		if (apm_bios_info.version > 0x0102)
-			apm_bios_info.version = 0x0102;
-		if (apm_driver_version(&apm_bios_info.version) != APM_SUCCESS) {
-			/* Fall back to an APM 1.0 connection. */
-			apm_bios_info.version = 0x100;
+		error = apm_enable_power_management(1);
+		if (error) {
+			apm_error("enable power management", error);
+			return -1;
+		}
+	}
+#endif
+
+	if ((apm_info.bios.flags & APM_BIOS_DISENGAGED)
+	    && (apm_info.connection_version > 0x0100)) {
+		error = apm_engage_power_management(APM_DEVICE_ALL, 1);
+		if (error) {
+			apm_error("engage power management", error);
+			return -1;
 		}
 	}
-	if (debug && (smp_num_cpus == 1)) {
-		printk(KERN_INFO "apm: Connection version %d.%d\n",
-			(apm_bios_info.version >> 8) & 0xff,
-			apm_bios_info.version & 0xff);
 
+	if (debug && (smp_num_cpus == 1)) {
 		error = apm_get_power_status(&bx, &cx, &dx);
 		if (error)
 			printk(KERN_INFO "apm: power status not available\n");
@@ -1469,7 +1506,7 @@
 				printk("unknown\n");
 			else
 				printk("%d%%\n", cx & 0xff);
-			if (apm_bios_info.version > 0x100) {
+			if (apm_info.connection_version > 0x100) {
 				printk(KERN_INFO
 				       "apm: battery flag 0x%02x, battery life ",
 				       (cx >> 8) & 0xff);
@@ -1483,29 +1520,6 @@
 		}
 	}
 
-#ifdef CONFIG_APM_DO_ENABLE
-	if (apm_bios_info.flags & APM_BIOS_DISABLED) {
-		/*
-		 * This call causes my NEC UltraLite Versa 33/C to hang if it
-		 * is booted with PM disabled but not in the docking station.
-		 * Unfortunate ...
-		 */
-		error = apm_enable_power_management(1);
-		if (error) {
-			apm_error("enable power management", error);
-			return -1;
-		}
-	}
-#endif
-	if ((apm_bios_info.flags & APM_BIOS_DISENGAGED)
-	    && (apm_bios_info.version > 0x0100)) {
-		error = apm_engage_power_management(APM_DEVICE_ALL, 1);
-		if (error) {
-			apm_error("engage power management", error);
-			return -1;
-		}
-	}
-
 	/* Install our power off handler.. */
 	if (power_off)
 		pm_power_off = apm_power_off;
@@ -1584,17 +1598,19 @@
  */
 static int __init apm_init(void)
 {
-	if (apm_bios_info.version == 0) {
+	struct proc_dir_entry *apm_proc;
+
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
@@ -1603,23 +1619,23 @@
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
 
@@ -1647,16 +1663,16 @@
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
@@ -1667,15 +1683,17 @@
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
 
-	create_proc_info_entry("apm", 0, NULL, apm_get_info);
+	apm_proc = create_proc_info_entry("apm", 0, NULL, apm_get_info);
+	if (apm_proc)
+		SET_MODULE_OWNER(apm_proc);
 
 	kernel_thread(apm, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGHAND | SIGCHLD);
 
@@ -1692,6 +1710,14 @@
 
 static void __exit apm_exit(void)
 {
+	int	error;
+
+	if (((apm_info.bios.flags & APM_BIOS_DISENGAGED) == 0)
+	    && (apm_info.connection_version > 0x0100)) {
+		error = apm_engage_power_management(APM_DEVICE_ALL, 0);
+		if (error)
+			apm_error("disengage power management", error);
+	}
 	misc_deregister(&apm_device);
 	remove_proc_entry("apm", NULL);
 #ifdef CONFIG_MAGIC_SYSRQ
diff -ruN 2.4.0-test12pre3/arch/i386/kernel/i386_ksyms.c 2.4.0-test12pre3-APM.1/arch/i386/kernel/i386_ksyms.c
--- 2.4.0-test12pre3/arch/i386/kernel/i386_ksyms.c	Mon Nov 20 14:05:17 2000
+++ 2.4.0-test12pre3-APM.1/arch/i386/kernel/i386_ksyms.c	Fri Dec  1 10:47:55 2000
@@ -68,7 +68,7 @@
 EXPORT_SYMBOL(pm_idle);
 EXPORT_SYMBOL(pm_power_off);
 EXPORT_SYMBOL(get_cmos_time);
-EXPORT_SYMBOL(apm_bios_info);
+EXPORT_SYMBOL(apm_info);
 EXPORT_SYMBOL(gdt);
 
 EXPORT_SYMBOL_NOVERS(__down_failed);
diff -ruN 2.4.0-test12pre3/arch/i386/kernel/setup.c 2.4.0-test12pre3-APM.1/arch/i386/kernel/setup.c
--- 2.4.0-test12pre3/arch/i386/kernel/setup.c	Thu Nov 30 10:11:13 2000
+++ 2.4.0-test12pre3-APM.1/arch/i386/kernel/setup.c	Fri Dec  1 10:47:55 2000
@@ -126,7 +126,7 @@
  */
 struct drive_info_struct { char dummy[32]; } drive_info;
 struct screen_info screen_info;
-struct apm_bios_info apm_bios_info;
+struct apm_info apm_info;
 struct sys_desc_table_struct {
 	unsigned short length;
 	unsigned char table[0];
@@ -608,7 +608,7 @@
  	ROOT_DEV = to_kdev_t(ORIG_ROOT_DEV);
  	drive_info = DRIVE_INFO;
  	screen_info = SCREEN_INFO;
-	apm_bios_info = APM_BIOS_INFO;
+	apm_info.bios = APM_BIOS_INFO;
 	if( SYS_DESC_TABLE.length != 0 ) {
 		MCA_bus = SYS_DESC_TABLE.table[3] &0x2;
 		machine_id = SYS_DESC_TABLE.table[0];
diff -ruN 2.4.0-test12pre3/include/linux/apm_bios.h 2.4.0-test12pre3-APM.1/include/linux/apm_bios.h
--- 2.4.0-test12pre3/include/linux/apm_bios.h	Mon Feb 21 15:37:09 2000
+++ 2.4.0-test12pre3-APM.1/include/linux/apm_bios.h	Fri Dec  1 14:25:25 2000
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
@@ -91,12 +100,9 @@
 #define	APM_FUNC_TIMER_GET	2
 
 /*
- * in init/main.c
+ * in arch/i386/kernel/setup.c
  */
-extern struct apm_bios_info	apm_bios_info;
-
-extern int		apm_register_callback(int (*callback)(apm_event_t));
-extern void		apm_unregister_callback(int (*callback)(apm_event_t));
+extern struct apm_info	apm_info;
 
 #endif	/* __KERNEL__ */
 
@@ -176,7 +182,7 @@
 /*
  * This is the "All Devices" ID communicated to the BIOS
  */
-#define APM_DEVICE_BALL		((apm_bios_info.version > 0x0100) ? \
+#define APM_DEVICE_BALL		((apm_info.connection_version > 0x0100) ? \
 				 APM_DEVICE_ALL : APM_DEVICE_OLD_ALL)
 #endif
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
