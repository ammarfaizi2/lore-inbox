Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbUE1MDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUE1MDw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 08:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUE1MD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 08:03:29 -0400
Received: from mail.donpac.ru ([80.254.111.2]:43188 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S262329AbUE1Lzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 07:55:41 -0400
Subject: [PATCH 4/13] 2.6.7-rc1-mm1, Port APM BIOS driver to new DMI probing
In-Reply-To: <1085745333820@donpac.ru>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 28 May 2004 15:55:37 +0400
Message-Id: <10857453372934@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc1-mm1.vanilla/arch/i386/kernel/apm.c linux-2.6.7-rc1-mm1/arch/i386/kernel/apm.c
--- linux-2.6.7-rc1-mm1.vanilla/arch/i386/kernel/apm.c	Wed Apr 28 22:56:07 2004
+++ linux-2.6.7-rc1-mm1/arch/i386/kernel/apm.c	Wed Apr 28 23:36:33 2004
@@ -222,6 +222,7 @@
 #include <linux/kernel.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
+#include <linux/dmi.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -1884,6 +1885,319 @@ static struct miscdevice apm_device = {
 	&apm_bios_fops
 };
 
+
+/* Simple "print if true" callback */
+static int __init print_if_true(struct dmi_system_id *d)
+{
+	printk("%s\n", d->ident);
+	return 0;
+}
+
+/*
+ * Some Bioses enable the PS/2 mouse (touchpad) at resume, even if it was
+ * disabled before the suspend. Linux used to get terribly confused by that.
+ */
+static int __init broken_ps2_resume(struct dmi_system_id *d)
+{
+	printk(KERN_INFO "%s machine detected. Mousepad Resume Bug workaround hopefully not needed.\n", d->ident);
+	return 0;
+}
+
+/* Some bioses have a broken protected mode poweroff and need to use realmode */
+static int __init set_realmode_power_off(struct dmi_system_id *d)
+{
+	if (apm_info.realmode_power_off == 0) {
+		apm_info.realmode_power_off = 1;
+		printk(KERN_INFO "%s bios detected. Using realmode poweroff only.\n", d->ident);
+	}
+	return 0;
+}
+
+/* Some laptops require interrupts to be enabled during APM calls */
+static int __init set_apm_ints(struct dmi_system_id *d)
+{
+	if (apm_info.allow_ints == 0) {
+		apm_info.allow_ints = 1;
+		printk(KERN_INFO "%s machine detected. Enabling interrupts during APM calls.\n", d->ident);
+	}
+	return 0;
+}
+
+/* Some APM bioses corrupt memory or just plain do not work */
+static int __init apm_is_horked(struct dmi_system_id *d)
+{
+	if (apm_info.disabled == 0) {
+		apm_info.disabled = 1;
+		printk(KERN_INFO "%s machine detected. Disabling APM.\n", d->ident);
+	}
+	return 0;
+}
+
+static int __init apm_is_horked_d850md(struct dmi_system_id *d)
+{
+	if (apm_info.disabled == 0) {
+		apm_info.disabled = 1;
+		printk(KERN_INFO "%s machine detected. Disabling APM.\n", d->ident);
+		printk(KERN_INFO "This bug is fixed in bios P15 which is available for \n");
+		printk(KERN_INFO "download from support.intel.com \n");
+	}
+	return 0;
+}
+
+/* Some APM bioses hang on APM idle calls */
+static int __init apm_likes_to_melt(struct dmi_system_id *d)
+{
+	if (apm_info.forbid_idle == 0) {
+		apm_info.forbid_idle = 1;
+		printk(KERN_INFO "%s machine detected. Disabling APM idle calls.\n", d->ident);
+	}
+	return 0;
+}
+
+/*
+ *  Check for clue free BIOS implementations who use
+ *  the following QA technique
+ *
+ *      [ Write BIOS Code ]<------
+ *               |                ^
+ *      < Does it Compile >----N--
+ *               |Y               ^
+ *	< Does it Boot Win98 >-N--
+ *               |Y
+ *           [Ship It]
+ *
+ *	Phoenix A04  08/24/2000 is known bad (Dell Inspiron 5000e)
+ *	Phoenix A07  09/29/2000 is known good (Dell Inspiron 5000)
+ */
+static int __init broken_apm_power(struct dmi_system_id *d)
+{
+	apm_info.get_power_status_broken = 1;
+	printk(KERN_WARNING "BIOS strings suggest APM bugs, disabling power status reporting.\n");
+	return 0;
+}		
+
+/*
+ * This bios swaps the APM minute reporting bytes over (Many sony laptops
+ * have this problem).
+ */
+static int __init swab_apm_power_in_minutes(struct dmi_system_id *d)
+{
+	apm_info.get_power_status_swabinminutes = 1;
+	printk(KERN_WARNING "BIOS strings suggest APM reports battery life in minutes and wrong byte order.\n");
+	return 0;
+}
+
+static struct dmi_system_id __initdata apm_dmi_table[] = {
+	{
+		print_if_true,
+		KERN_WARNING "IBM T23 - BIOS 1.03b+ and controller firmware 1.02+ may be needed for Linux APM.",
+		{	DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
+			DMI_MATCH(DMI_BIOS_VERSION, "1AET38WW (1.01b)"), },
+	},
+	{	/* Handle problems with APM on the C600 */
+		broken_ps2_resume, "Dell Latitude C600", 
+		{	DMI_MATCH(DMI_SYS_VENDOR, "Dell"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude C600"), },
+	},
+	{	/* Allow interrupts during suspend on Dell Latitude laptops*/
+		set_apm_ints, "Dell Latitude",
+		{	DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude C510"), },
+	},
+	{	/* APM crashes */
+		apm_is_horked, "Dell Inspiron 2500",
+		{	DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 2500"),
+			DMI_MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION,"A11"), },
+	},
+	{	/* Allow interrupts during suspend on Dell Inspiron laptops*/
+		set_apm_ints, "Dell Inspiron",
+		{	DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 4000"), },
+	},
+	{	/* Handle problems with APM on Inspiron 5000e */
+		broken_apm_power, "Dell Inspiron 5000e",
+		{	DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION, "A04"),
+			DMI_MATCH(DMI_BIOS_DATE, "08/24/2000"), },
+	},
+	{	/* Handle problems with APM on Inspiron 2500 */
+		broken_apm_power, "Dell Inspiron 2500",
+		{	DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION, "A12"),
+			DMI_MATCH(DMI_BIOS_DATE, "02/04/2002"), },
+	},
+	{	/* APM crashes */
+		apm_is_horked, "Dell Dimension 4100",
+		{	DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "XPS-Z"),
+			DMI_MATCH(DMI_BIOS_VENDOR,"Intel Corp."),
+			DMI_MATCH(DMI_BIOS_VERSION,"A11"), },
+	},
+	{	/* Allow interrupts during suspend on Compaq Laptops*/
+		set_apm_ints, "Compaq 12XL125",
+		{	DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Compaq PC"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION,"4.06"), },
+	},
+	{   /* Allow interrupts during APM or the clock goes slow */
+		set_apm_ints, "ASUSTeK",
+		{	DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "L8400K series Notebook PC"), },
+	},					
+	{	/* APM blows on shutdown */
+		apm_is_horked, "ABIT KX7-333[R]",
+		{	DMI_MATCH(DMI_BOARD_VENDOR, "ABIT"),
+			DMI_MATCH(DMI_BOARD_NAME, "VT8367-8233A (KX7-333[R])"), },
+	},
+	{	/* APM crashes */
+		apm_is_horked, "Trigem Delhi3",
+		{	DMI_MATCH(DMI_SYS_VENDOR, "TriGem Computer, Inc"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Delhi3"), },
+	},
+	{	/* APM crashes */
+		apm_is_horked, "Fujitsu-Siemens",
+		{	DMI_MATCH(DMI_BIOS_VENDOR, "hoenix/FUJITSU SIEMENS"),
+			DMI_MATCH(DMI_BIOS_VERSION, "Version1.01"), },
+	},
+	{	/* APM crashes */
+		apm_is_horked_d850md, "Intel D850MD",
+		{	DMI_MATCH(DMI_BIOS_VENDOR, "Intel Corp."),
+			DMI_MATCH(DMI_BIOS_VERSION, "MV85010A.86A.0016.P07.0201251536"), },
+	},
+	{	/* APM crashes */
+		apm_is_horked, "Intel D810EMO",
+		{	DMI_MATCH(DMI_BIOS_VENDOR, "Intel Corp."),
+			DMI_MATCH(DMI_BIOS_VERSION, "MO81010A.86A.0008.P04.0004170800"), },
+	},
+	{	/* APM crashes */
+		apm_is_horked, "Dell XPS-Z",
+		{	DMI_MATCH(DMI_BIOS_VENDOR, "Intel Corp."),
+			DMI_MATCH(DMI_BIOS_VERSION, "A11"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "XPS-Z"), },
+	},
+	{	/* APM crashes */
+		apm_is_horked, "Sharp PC-PJ/AX",
+		{	DMI_MATCH(DMI_SYS_VENDOR, "SHARP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PC-PJ/AX"),
+			DMI_MATCH(DMI_BIOS_VENDOR,"SystemSoft"),
+			DMI_MATCH(DMI_BIOS_VERSION,"Version R2.08"), },
+	},
+	{	/* APM crashes */
+		apm_is_horked, "Dell Inspiron 2500",
+		{	DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 2500"),
+			DMI_MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION,"A11"), },
+	},
+	{	/* APM idle hangs */
+		apm_likes_to_melt, "Jabil AMD",
+		{	DMI_MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
+			DMI_MATCH(DMI_BIOS_VERSION, "0AASNP06"), },
+	},
+	{	/* APM idle hangs */
+		apm_likes_to_melt, "AMI Bios",
+		{	DMI_MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
+			DMI_MATCH(DMI_BIOS_VERSION, "0AASNP05"), },
+	},
+	{	/* Handle problems with APM on Sony Vaio PCG-N505X(DE) */
+		swab_apm_power_in_minutes, "Sony VAIO",
+		{	DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION, "R0206H"),
+			DMI_MATCH(DMI_BIOS_DATE, "08/23/99"), },
+	},
+	{	/* Handle problems with APM on Sony Vaio PCG-N505VX */
+		swab_apm_power_in_minutes, "Sony VAIO",
+		{	DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION, "W2K06H0"),
+			DMI_MATCH(DMI_BIOS_DATE, "02/03/00"), },
+	},
+	{	/* Handle problems with APM on Sony Vaio PCG-XG29 */
+		swab_apm_power_in_minutes, "Sony VAIO",
+		{	DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION, "R0117A0"),
+			DMI_MATCH(DMI_BIOS_DATE, "04/25/00"), },
+	},
+	{	/* Handle problems with APM on Sony Vaio PCG-Z600NE */
+		swab_apm_power_in_minutes, "Sony VAIO",
+		{	DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION, "R0121Z1"),
+			DMI_MATCH(DMI_BIOS_DATE, "05/11/00"), },
+	},
+	{	/* Handle problems with APM on Sony Vaio PCG-Z600NE */
+		swab_apm_power_in_minutes, "Sony VAIO",
+		{	DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION, "WME01Z1"),
+			DMI_MATCH(DMI_BIOS_DATE, "08/11/00"), },
+	},
+	{	/* Handle problems with APM on Sony Vaio PCG-Z600LEK(DE) */
+		swab_apm_power_in_minutes, "Sony VAIO",
+		{	DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION, "R0206Z3"),
+			DMI_MATCH(DMI_BIOS_DATE, "12/25/00"), },
+	},
+	{	/* Handle problems with APM on Sony Vaio PCG-Z505LS */
+		swab_apm_power_in_minutes, "Sony VAIO",
+		{	DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION, "R0203D0"),
+			DMI_MATCH(DMI_BIOS_DATE, "05/12/00"), },
+	},
+	{	/* Handle problems with APM on Sony Vaio PCG-Z505LS */
+		swab_apm_power_in_minutes, "Sony VAIO",
+		{	DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION, "R0203Z3"),
+			DMI_MATCH(DMI_BIOS_DATE, "08/25/00"), },
+	},
+	{	/* Handle problems with APM on Sony Vaio PCG-Z505LS (with updated BIOS) */
+		swab_apm_power_in_minutes, "Sony VAIO",
+		{	DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION, "R0209Z3"),
+			DMI_MATCH(DMI_BIOS_DATE, "05/12/01"), },
+	},
+	{	/* Handle problems with APM on Sony Vaio PCG-F104K */
+		swab_apm_power_in_minutes, "Sony VAIO",
+		{	DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION, "R0204K2"),
+			DMI_MATCH(DMI_BIOS_DATE, "08/28/00"), },
+	},
+	{	/* Handle problems with APM on Sony Vaio PCG-C1VN/C1VE */
+		swab_apm_power_in_minutes, "Sony VAIO",
+		{	DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION, "R0208P1"),
+			DMI_MATCH(DMI_BIOS_DATE, "11/09/00"), },
+	},
+	{	/* Handle problems with APM on Sony Vaio PCG-C1VE */
+		swab_apm_power_in_minutes, "Sony VAIO",
+		{ 	DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION, "R0204P1"),
+			DMI_MATCH(DMI_BIOS_DATE, "09/12/00"), },
+	},
+	{	/* Handle problems with APM on Sony Vaio PCG-C1VE */
+		swab_apm_power_in_minutes, "Sony VAIO",
+		{	DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION, "WXPO1Z3"),
+			DMI_MATCH(DMI_BIOS_DATE, "10/26/01"), },
+	},
+	{	/* broken PM poweroff bios */
+		set_realmode_power_off, "Award Software v4.60 PGMA",
+		{	DMI_MATCH(DMI_BIOS_VENDOR, "Award Software International, Inc."),
+			DMI_MATCH(DMI_BIOS_VERSION, "4.60 PGMA"),
+			DMI_MATCH(DMI_BIOS_DATE, "134526184"), },
+	},
+
+	/* Generic per vendor APM settings  */
+
+	{	/* Allow interrupts during suspend on IBM laptops */
+		set_apm_ints, "IBM",
+		{	DMI_MATCH(DMI_SYS_VENDOR, "IBM"), },
+	},
+
+	{ }
+};
+
+
 /*
  * Just start the APM thread. We do NOT want to do APM BIOS
  * calls from anything but the APM thread, if for no other reason
@@ -1899,6 +2213,8 @@ static int __init apm_init(void)
 	struct proc_dir_entry *apm_proc;
 	int ret;
 	int i;
+
+	dmi_check_system(apm_dmi_table);
 
 	if (apm_info.bios.version == 0) {
 		printk(KERN_INFO "apm: BIOS not found.\n");
diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc1-mm1.vanilla/arch/i386/kernel/dmi_scan.c linux-2.6.7-rc1-mm1/arch/i386/kernel/dmi_scan.c
--- linux-2.6.7-rc1-mm1.vanilla/arch/i386/kernel/dmi_scan.c	Wed Apr 28 23:35:57 2004
+++ linux-2.6.7-rc1-mm1/arch/i386/kernel/dmi_scan.c	Wed Apr 28 23:44:33 2004
@@ -4,7 +4,6 @@
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/apm_bios.h>
 #include <linux/slab.h>
 #include <asm/acpi.h>
 #include <asm/io.h>
@@ -203,73 +202,6 @@ static __init int set_smp_bios_reboot(st
 }
 
 /*
- * Some bioses have a broken protected mode poweroff and need to use realmode
- */
-
-static __init int set_realmode_power_off(struct dmi_system_id *d)
-{
-       if (apm_info.realmode_power_off == 0)
-       {
-               apm_info.realmode_power_off = 1;
-               printk(KERN_INFO "%s bios detected. Using realmode poweroff only.\n", d->ident);
-       }
-       return 0;
-}
-
-
-/* 
- * Some laptops require interrupts to be enabled during APM calls 
- */
-
-static __init int set_apm_ints(struct dmi_system_id *d)
-{
-	if (apm_info.allow_ints == 0)
-	{
-		apm_info.allow_ints = 1;
-		printk(KERN_INFO "%s machine detected. Enabling interrupts during APM calls.\n", d->ident);
-	}
-	return 0;
-}
-
-/* 
- * Some APM bioses corrupt memory or just plain do not work
- */
-
-static __init int apm_is_horked(struct dmi_system_id *d)
-{
-	if (apm_info.disabled == 0)
-	{
-		apm_info.disabled = 1;
-		printk(KERN_INFO "%s machine detected. Disabling APM.\n", d->ident);
-	}
-	return 0;
-}
-
-static __init int apm_is_horked_d850md(struct dmi_system_id *d)
-{
-	if (apm_info.disabled == 0) {
-		apm_info.disabled = 1;
-		printk(KERN_INFO "%s machine detected. Disabling APM.\n", d->ident);
-		printk(KERN_INFO "This bug is fixed in bios P15 which is available for \n");
-		printk(KERN_INFO "download from support.intel.com \n");
-	}
-	return 0;
-}
-
-/* 
- * Some APM bioses hang on APM idle calls
- */
-
-static __init int apm_likes_to_melt(struct dmi_system_id *d)
-{
-	if (apm_info.forbid_idle == 0) {
-		apm_info.forbid_idle = 1;
-		printk(KERN_INFO "%s machine detected. Disabling APM idle calls.\n", d->ident);
-	}
-	return 0;
-}
-
-/*
  * Some machines, usually laptops, can't handle an enabled local APIC.
  * The symptoms include hangs or reboots when suspending or resuming,
  * attaching or detaching the power cord, or entering BIOS setup screens
@@ -320,29 +252,6 @@ static __init int fix_broken_hp_bios_irq
 }
 
 /*
- *  Check for clue free BIOS implementations who use
- *  the following QA technique
- *
- *      [ Write BIOS Code ]<------
- *               |                ^
- *      < Does it Compile >----N--
- *               |Y               ^
- *	< Does it Boot Win98 >-N--
- *               |Y
- *           [Ship It]
- *
- *	Phoenix A04  08/24/2000 is known bad (Dell Inspiron 5000e)
- *	Phoenix A07  09/29/2000 is known good (Dell Inspiron 5000)
- */
-
-static __init int broken_apm_power(struct dmi_system_id *d)
-{
-	apm_info.get_power_status_broken = 1;
-	printk(KERN_WARNING "BIOS strings suggest APM bugs, disabling power status reporting.\n");
-	return 0;
-}		
-
-/*
  * HP Proliant 8500 systems can't use i8042 in mux mode,
  * or they instantly reboot.
  */
@@ -360,18 +269,6 @@ static __init int set_8042_nomux(struct 
 #endif
 
 /*
- * This bios swaps the APM minute reporting bytes over (Many sony laptops
- * have this problem).
- */
- 
-static __init int swab_apm_power_in_minutes(struct dmi_system_id *d)
-{
-	apm_info.get_power_status_swabinminutes = 1;
-	printk(KERN_WARNING "BIOS strings suggest APM reports battery life in minutes and wrong byte order.\n");
-	return 0;
-}
-
-/*
  * ASUS K7V-RM has broken ACPI table defining sleep modes
  */
 
@@ -414,17 +311,6 @@ static __init int reset_videomode_after_
 #endif
 
 /*
- * Some Bioses enable the PS/2 mouse (touchpad) at resume, even if it was
- * disabled before the suspend. Linux used to get terribly confused by that.
- */
-
-static __init int broken_ps2_resume(struct dmi_system_id *d)
-{
-	printk(KERN_INFO "%s machine detected. Mousepad Resume Bug workaround hopefully not needed.\n", d->ident);
-	return 0;
-}
-
-/*
  *	Exploding PnPBIOS. Don't yet know if its the BIOS or us for
  *	some entries
  */
@@ -446,17 +332,6 @@ static __init int acer_cpufreq_pst(struc
 }
 
 
-/*
- *	Simple "print if true" callback
- */
- 
-static __init int print_if_true(struct dmi_system_id *d)
-{
-	printk("%s\n", d->ident);
-	return 0;
-}
-
-
 #ifdef	CONFIG_ACPI_BOOT
 extern int acpi_force;
 
@@ -529,45 +404,6 @@ static __init int disable_acpi_pci(struc
  */
  
 static __initdata struct dmi_system_id dmi_blacklist[]={
-	{ broken_ps2_resume, "Dell Latitude C600", {	/* Handle problems with APM on the C600 */
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude C600"),
-			} },
-	{ set_apm_ints, "Dell Latitude", {  /* Allow interrupts during suspend on Dell Latitude laptops*/
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude C510"),
-			} },
-	{ apm_is_horked, "Dell Inspiron 2500", { /* APM crashes */
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 2500"),
-			DMI_MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
-			DMI_MATCH(DMI_BIOS_VERSION,"A11")
-			} },
-	{ set_apm_ints, "Dell Inspiron", {	/* Allow interrupts during suspend on Dell Inspiron laptops*/
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 4000"),
-			} },
-	{ broken_apm_power, "Dell Inspiron 5000e", {	/* Handle problems with APM on Inspiron 5000e */
-			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			DMI_MATCH(DMI_BIOS_VERSION, "A04"),
-			DMI_MATCH(DMI_BIOS_DATE, "08/24/2000"),
-			} },
-	{ broken_apm_power, "Dell Inspiron 2500", {	/* Handle problems with APM on Inspiron 2500 */
-			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			DMI_MATCH(DMI_BIOS_VERSION, "A12"),
-			DMI_MATCH(DMI_BIOS_DATE, "02/04/2002"),
-			} },
-	{ apm_is_horked, "Dell Dimension 4100", { /* APM crashes */
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "XPS-Z"),
-			DMI_MATCH(DMI_BIOS_VENDOR,"Intel Corp."),
-			DMI_MATCH(DMI_BIOS_VERSION,"A11")
-			} },
-	{ set_realmode_power_off, "Award Software v4.60 PGMA", {	/* broken PM poweroff bios */
-			DMI_MATCH(DMI_BIOS_VENDOR, "Award Software International, Inc."),
-			DMI_MATCH(DMI_BIOS_VERSION, "4.60 PGMA"),
-			DMI_MATCH(DMI_BIOS_DATE, "134526184"),
-			} },
 	{ set_smp_bios_reboot, "Dell PowerEdge 1300", {	/* Handle problems with rebooting on Dell 1300's */
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge 1300/"),
@@ -580,138 +416,6 @@ static __initdata struct dmi_system_id d
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge 2400"),
 			} },
-	{ set_apm_ints, "Compaq 12XL125", {	/* Allow interrupts during suspend on Compaq Laptops*/
-			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Compaq PC"),
-			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			DMI_MATCH(DMI_BIOS_VERSION,"4.06")
-			} },
-	{ set_apm_ints, "ASUSTeK", {   /* Allow interrupts during APM or the clock goes slow */
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "L8400K series Notebook PC"),
-			} },					
-	{ apm_is_horked, "ABIT KX7-333[R]", { /* APM blows on shutdown */
-			DMI_MATCH(DMI_BOARD_VENDOR, "ABIT"),
-			DMI_MATCH(DMI_BOARD_NAME, "VT8367-8233A (KX7-333[R])"),
-			} },
-	{ apm_is_horked, "Trigem Delhi3", { /* APM crashes */
-			DMI_MATCH(DMI_SYS_VENDOR, "TriGem Computer, Inc"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Delhi3"),
-			} },
-	{ apm_is_horked, "Fujitsu-Siemens", { /* APM crashes */
-			DMI_MATCH(DMI_BIOS_VENDOR, "hoenix/FUJITSU SIEMENS"),
-			DMI_MATCH(DMI_BIOS_VERSION, "Version1.01"),
-			} },
-	{ apm_is_horked_d850md, "Intel D850MD", { /* APM crashes */
-			DMI_MATCH(DMI_BIOS_VENDOR, "Intel Corp."),
-			DMI_MATCH(DMI_BIOS_VERSION, "MV85010A.86A.0016.P07.0201251536"),
-			} },
-	{ apm_is_horked, "Intel D810EMO", { /* APM crashes */
-			DMI_MATCH(DMI_BIOS_VENDOR, "Intel Corp."),
-			DMI_MATCH(DMI_BIOS_VERSION, "MO81010A.86A.0008.P04.0004170800"),
-			} },
-	{ apm_is_horked, "Dell XPS-Z", { /* APM crashes */
-			DMI_MATCH(DMI_BIOS_VENDOR, "Intel Corp."),
-			DMI_MATCH(DMI_BIOS_VERSION, "A11"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "XPS-Z"),
-			} },
-	{ apm_is_horked, "Sharp PC-PJ/AX", { /* APM crashes */
-			DMI_MATCH(DMI_SYS_VENDOR, "SHARP"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "PC-PJ/AX"),
-			DMI_MATCH(DMI_BIOS_VENDOR,"SystemSoft"),
-			DMI_MATCH(DMI_BIOS_VERSION,"Version R2.08")
-			} },
-	{ apm_is_horked, "Dell Inspiron 2500", { /* APM crashes */
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 2500"),
-			DMI_MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
-			DMI_MATCH(DMI_BIOS_VERSION,"A11")
-			} },
-	{ apm_likes_to_melt, "Jabil AMD", { /* APM idle hangs */
-			DMI_MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
-			DMI_MATCH(DMI_BIOS_VERSION, "0AASNP06"),
-			} },
-	{ apm_likes_to_melt, "AMI Bios", { /* APM idle hangs */
-			DMI_MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
-			DMI_MATCH(DMI_BIOS_VERSION, "0AASNP05"), 
-			} },
-	{ swab_apm_power_in_minutes, "Sony VAIO", { /* Handle problems with APM on Sony Vaio PCG-N505X(DE) */
-			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			DMI_MATCH(DMI_BIOS_VERSION, "R0206H"),
-			DMI_MATCH(DMI_BIOS_DATE, "08/23/99"),
-			} },
-
-	{ swab_apm_power_in_minutes, "Sony VAIO", { /* Handle problems with APM on Sony Vaio PCG-N505VX */
-			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			DMI_MATCH(DMI_BIOS_VERSION, "W2K06H0"),
-			DMI_MATCH(DMI_BIOS_DATE, "02/03/00"),
-			} },
-			
-	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-XG29 */
-			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			DMI_MATCH(DMI_BIOS_VERSION, "R0117A0"),
-			DMI_MATCH(DMI_BIOS_DATE, "04/25/00"),
-			} },
-
-	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-Z600NE */
-			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			DMI_MATCH(DMI_BIOS_VERSION, "R0121Z1"),
-			DMI_MATCH(DMI_BIOS_DATE, "05/11/00"),
-			} },
-
-	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-Z600NE */
-			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			DMI_MATCH(DMI_BIOS_VERSION, "WME01Z1"),
-			DMI_MATCH(DMI_BIOS_DATE, "08/11/00"),
-			} },
-
-	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-Z600LEK(DE) */
-			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			DMI_MATCH(DMI_BIOS_VERSION, "R0206Z3"),
-			DMI_MATCH(DMI_BIOS_DATE, "12/25/00"),
-			} },
-
-	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-Z505LS */
-			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			DMI_MATCH(DMI_BIOS_VERSION, "R0203D0"),
-			DMI_MATCH(DMI_BIOS_DATE, "05/12/00"),
-			} },
-
-	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-Z505LS */
-			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			DMI_MATCH(DMI_BIOS_VERSION, "R0203Z3"),
-			DMI_MATCH(DMI_BIOS_DATE, "08/25/00"),
-			} },
-	
-	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-Z505LS (with updated BIOS) */
-			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			DMI_MATCH(DMI_BIOS_VERSION, "R0209Z3"),
-			DMI_MATCH(DMI_BIOS_DATE, "05/12/01"),
-			} },
-
-	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-F104K */
-			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			DMI_MATCH(DMI_BIOS_VERSION, "R0204K2"),
-			DMI_MATCH(DMI_BIOS_DATE, "08/28/00"),
-			} },
-
-	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-C1VN/C1VE */
-			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			DMI_MATCH(DMI_BIOS_VERSION, "R0208P1"),
-			DMI_MATCH(DMI_BIOS_DATE, "11/09/00"),
-			} },
-
-	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-C1VE */
-			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			DMI_MATCH(DMI_BIOS_VERSION, "R0204P1"),
-			DMI_MATCH(DMI_BIOS_DATE, "09/12/00"),
-			} },
-
-	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-C1VE */
-			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			DMI_MATCH(DMI_BIOS_VERSION, "WXPO1Z3"),
-			DMI_MATCH(DMI_BIOS_DATE, "10/26/01"),
-			} },
 			
 	{ exploding_pnp_bios, "Higraded P14H", {	/* PnPBIOS GPF on boot */
 			DMI_MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
@@ -762,12 +466,6 @@ static __initdata struct dmi_system_id d
 			DMI_MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),
 			} },
 #endif
-
-	{ print_if_true, KERN_WARNING "IBM T23 - BIOS 1.03b+ and controller firmware 1.02+ may be needed for Linux APM.", {
-			DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
-			DMI_MATCH(DMI_BIOS_VERSION, "1AET38WW (1.01b)"),
-			} },
-	 
 	{ fix_broken_hp_bios_irq9, "HP Pavilion N5400 Series Laptop", {
 			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
 			DMI_MATCH(DMI_BIOS_VERSION, "GE.M1.03"),
@@ -776,13 +474,6 @@ static __initdata struct dmi_system_id d
 			} },
  
 
-	/*
-	 *	Generic per vendor APM settings
-	 */
-	 
-	{ set_apm_ints, "IBM", {	/* Allow interrupts during suspend on IBM laptops */
-			DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
-			} },
 
 	/*
 	 *	SMBus / sensors settings

