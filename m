Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266508AbUFWMwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266508AbUFWMwb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 08:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266484AbUFWMt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 08:49:59 -0400
Received: from mail.donpac.ru ([80.254.111.2]:4746 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S266462AbUFWMpA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 08:45:00 -0400
Subject: [PATCH 6/6] 2.6.7-mm1, port APM BIOS driver to new DMI probing
In-Reply-To: <10879946911371@donpac.ru>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Wed, 23 Jun 2004 16:44:55 +0400
Message-Id: <10879946952983@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch ports APM BIOS driver to new DMI probing API.

Signed-off-by: Andrey Panin <pazke@donpac.ru>

 arch/i386/kernel/apm.c      |  316 ++++++++++++++++++++++++++++++++++++++++
 arch/i386/kernel/dmi_scan.c |  340 --------------------------------------------
 2 files changed, 316 insertions(+), 340 deletions(-)

diff -urpN -X /usr/share/dontdiff linux-2.6.7-mm1.vanilla/arch/i386/kernel/apm.c linux-2.6.7-mm1/arch/i386/kernel/apm.c
--- linux-2.6.7-mm1.vanilla/arch/i386/kernel/apm.c	Sun May 23 22:02:03 2004
+++ linux-2.6.7-mm1/arch/i386/kernel/apm.c	Mon May 24 00:00:33 2004
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
+			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude C510"), }
+	},
+	{	/* APM crashes */
+		apm_is_horked, "Dell Inspiron 2500",
+		{	DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 2500"),
+			DMI_MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION,"A11"), },
+	},
+	{	/* Allow interrupts during suspend on Dell Inspiron laptops*/
+		set_apm_ints, "Dell Inspiron", {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
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
+	{	/* Allow interrupts during APM or the clock goes slow */
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
+
+	{	/* Handle problems with APM on Sony Vaio PCG-C1VN/C1VE */
+		swab_apm_power_in_minutes, "Sony VAIO",
+		{	DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION, "R0208P1"),
+			DMI_MATCH(DMI_BIOS_DATE, "11/09/00"), },
+	},
+	{	/* Handle problems with APM on Sony Vaio PCG-C1VE */
+		swab_apm_power_in_minutes, "Sony VAIO",
+		{	DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
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
diff -urpN -X /usr/share/dontdiff linux-2.6.7-mm1.vanilla/arch/i386/kernel/dmi_scan.c linux-2.6.7-mm1/arch/i386/kernel/dmi_scan.c
--- linux-2.6.7-mm1.vanilla/arch/i386/kernel/dmi_scan.c	Sun May 23 22:59:58 2004
+++ linux-2.6.7-mm1/arch/i386/kernel/dmi_scan.c	Mon May 24 00:01:48 2004
@@ -1,10 +1,8 @@
-#include <linux/config.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/apm_bios.h>
 #include <linux/slab.h>
 #include <asm/acpi.h>
 #include <asm/io.h>
@@ -215,73 +213,6 @@ static __init int set_smp_bios_reboot(st
 }
 
 /*
- * Some bioses have a broken protected mode poweroff and need to use realmode
- */
-
-static __init int set_realmode_power_off(struct dmi_blacklist *d)
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
-static __init int set_apm_ints(struct dmi_blacklist *d)
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
-static __init int apm_is_horked(struct dmi_blacklist *d)
-{
-	if (apm_info.disabled == 0)
-	{
-		apm_info.disabled = 1;
-		printk(KERN_INFO "%s machine detected. Disabling APM.\n", d->ident);
-	}
-	return 0;
-}
-
-static __init int apm_is_horked_d850md(struct dmi_blacklist *d)
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
-static __init int apm_likes_to_melt(struct dmi_blacklist *d)
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
@@ -301,28 +232,6 @@ static int __init local_apic_kills_bios(
 	return 0;
 }
 
-/*
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
-static __init int broken_apm_power(struct dmi_blacklist *d)
-{
-	apm_info.get_power_status_broken = 1;
-	printk(KERN_WARNING "BIOS strings suggest APM bugs, disabling power status reporting.\n");
-	return 0;
-}		
 
 /*
  * Several HP Proliant (and maybe other OSB4/ProFusion) systems
@@ -336,29 +245,6 @@ static __init int set_8042_noloop(struct
 }
 
 /*
- * This bios swaps the APM minute reporting bytes over (Many sony laptops
- * have this problem).
- */
- 
-static __init int swab_apm_power_in_minutes(struct dmi_blacklist *d)
-{
-	apm_info.get_power_status_swabinminutes = 1;
-	printk(KERN_WARNING "BIOS strings suggest APM reports battery life in minutes and wrong byte order.\n");
-	return 0;
-}
-
-/*
- * ASUS K7V-RM has broken ACPI table defining sleep modes
- */
-
-static __init int broken_acpi_Sx(struct dmi_blacklist *d)
-{
-	printk(KERN_WARNING "Detected ASUS mainboard with broken ACPI sleep table\n");
-	dmi_broken |= BROKEN_ACPI_Sx;
-	return 0;
-}
-
-/*
  * Toshiba keyboard likes to repeat keys when they are not repeated.
  */
 
@@ -389,28 +275,6 @@ static __init int reset_videomode_after_
 }
 #endif
 
-/*
- * Some Bioses enable the PS/2 mouse (touchpad) at resume, even if it was
- * disabled before the suspend. Linux used to get terribly confused by that.
- */
-
-static __init int broken_ps2_resume(struct dmi_blacklist *d)
-{
-	printk(KERN_INFO "%s machine detected. Mousepad Resume Bug workaround hopefully not needed.\n", d->ident);
-	return 0;
-}
-
-
-/*
- *	Simple "print if true" callback
- */
- 
-static __init int print_if_true(struct dmi_blacklist *d)
-{
-	printk("%s\n", d->ident);
-	return 0;
-}
-
 
 #ifdef	CONFIG_ACPI_BOOT
 extern int acpi_force;
@@ -490,48 +354,6 @@ static __init int disable_acpi_pci(struc
  */
  
 static __initdata struct dmi_blacklist dmi_blacklist[]={
-	{ broken_ps2_resume, "Dell Latitude C600", {	/* Handle problems with APM on the C600 */
-			MATCH(DMI_SYS_VENDOR, "Dell"),
-			MATCH(DMI_PRODUCT_NAME, "Latitude C600"),
-			NO_MATCH, NO_MATCH
-			} },
-	{ set_apm_ints, "Dell Latitude", {  /* Allow interrupts during suspend on Dell Latitude laptops*/
-			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
-			MATCH(DMI_PRODUCT_NAME, "Latitude C510"),
-			NO_MATCH, NO_MATCH
-			} },
-	{ apm_is_horked, "Dell Inspiron 2500", { /* APM crashes */
-			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
-			MATCH(DMI_PRODUCT_NAME, "Inspiron 2500"),
-			MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION,"A11")
-			} },
-	{ set_apm_ints, "Dell Inspiron", {	/* Allow interrupts during suspend on Dell Inspiron laptops*/
-			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
-			MATCH(DMI_PRODUCT_NAME, "Inspiron 4000"),
-			NO_MATCH, NO_MATCH
-			} },
-	{ broken_apm_power, "Dell Inspiron 5000e", {	/* Handle problems with APM on Inspiron 5000e */
-			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION, "A04"),
-			MATCH(DMI_BIOS_DATE, "08/24/2000"), NO_MATCH
-			} },
-	{ broken_apm_power, "Dell Inspiron 2500", {	/* Handle problems with APM on Inspiron 2500 */
-			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION, "A12"),
-			MATCH(DMI_BIOS_DATE, "02/04/2002"), NO_MATCH
-			} },
-	{ apm_is_horked, "Dell Dimension 4100", { /* APM crashes */
-			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
-			MATCH(DMI_PRODUCT_NAME, "XPS-Z"),
-			MATCH(DMI_BIOS_VENDOR,"Intel Corp."),
-			MATCH(DMI_BIOS_VERSION,"A11")
-			} },
-	{ set_realmode_power_off, "Award Software v4.60 PGMA", {	/* broken PM poweroff bios */
-			MATCH(DMI_BIOS_VENDOR, "Award Software International, Inc."),
-			MATCH(DMI_BIOS_VERSION, "4.60 PGMA"),
-			MATCH(DMI_BIOS_DATE, "134526184"), NO_MATCH
-			} },
 	{ set_smp_bios_reboot, "Dell PowerEdge 1300", {	/* Handle problems with rebooting on Dell 1300's */
 			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
 			MATCH(DMI_PRODUCT_NAME, "PowerEdge 1300/"),
@@ -547,147 +369,6 @@ static __initdata struct dmi_blacklist d
 			MATCH(DMI_PRODUCT_NAME, "PowerEdge 2400"),
 			NO_MATCH, NO_MATCH
 			} },
-	{ set_apm_ints, "Compaq 12XL125", {	/* Allow interrupts during suspend on Compaq Laptops*/
-			MATCH(DMI_SYS_VENDOR, "Compaq"),
-			MATCH(DMI_PRODUCT_NAME, "Compaq PC"),
-			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION,"4.06")
-			} },
-	{ set_apm_ints, "ASUSTeK", {   /* Allow interrupts during APM or the clock goes slow */
-			MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer Inc."),
-			MATCH(DMI_PRODUCT_NAME, "L8400K series Notebook PC"),
-			NO_MATCH, NO_MATCH
-			} },					
-	{ apm_is_horked, "ABIT KX7-333[R]", { /* APM blows on shutdown */
-			MATCH(DMI_BOARD_VENDOR, "ABIT"),
-			MATCH(DMI_BOARD_NAME, "VT8367-8233A (KX7-333[R])"),
-			NO_MATCH, NO_MATCH,
-			} },
-	{ apm_is_horked, "Trigem Delhi3", { /* APM crashes */
-			MATCH(DMI_SYS_VENDOR, "TriGem Computer, Inc"),
-			MATCH(DMI_PRODUCT_NAME, "Delhi3"),
-			NO_MATCH, NO_MATCH,
-			} },
-	{ apm_is_horked, "Fujitsu-Siemens", { /* APM crashes */
-			MATCH(DMI_BIOS_VENDOR, "hoenix/FUJITSU SIEMENS"),
-			MATCH(DMI_BIOS_VERSION, "Version1.01"),
-			NO_MATCH, NO_MATCH,
-			} },
-	{ apm_is_horked_d850md, "Intel D850MD", { /* APM crashes */
-			MATCH(DMI_BIOS_VENDOR, "Intel Corp."),
-			MATCH(DMI_BIOS_VERSION, "MV85010A.86A.0016.P07.0201251536"),
-			NO_MATCH, NO_MATCH,
-			} },
-	{ apm_is_horked, "Intel D810EMO", { /* APM crashes */
-			MATCH(DMI_BIOS_VENDOR, "Intel Corp."),
-			MATCH(DMI_BIOS_VERSION, "MO81010A.86A.0008.P04.0004170800"),
-			NO_MATCH, NO_MATCH,
-			} },
-	{ apm_is_horked, "Dell XPS-Z", { /* APM crashes */
-			MATCH(DMI_BIOS_VENDOR, "Intel Corp."),
-			MATCH(DMI_BIOS_VERSION, "A11"),
-			MATCH(DMI_PRODUCT_NAME, "XPS-Z"),
-			NO_MATCH,
-			} },
-	{ apm_is_horked, "Sharp PC-PJ/AX", { /* APM crashes */
-			MATCH(DMI_SYS_VENDOR, "SHARP"),
-			MATCH(DMI_PRODUCT_NAME, "PC-PJ/AX"),
-			MATCH(DMI_BIOS_VENDOR,"SystemSoft"),
-			MATCH(DMI_BIOS_VERSION,"Version R2.08")
-			} },
-	{ apm_is_horked, "Dell Inspiron 2500", { /* APM crashes */
-			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
-			MATCH(DMI_PRODUCT_NAME, "Inspiron 2500"),
-			MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION,"A11")
-			} },
-	{ apm_likes_to_melt, "Jabil AMD", { /* APM idle hangs */
-			MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
-			MATCH(DMI_BIOS_VERSION, "0AASNP06"),
-			NO_MATCH, NO_MATCH,
-			} },
-	{ apm_likes_to_melt, "AMI Bios", { /* APM idle hangs */
-			MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
-			MATCH(DMI_BIOS_VERSION, "0AASNP05"), 
-			NO_MATCH, NO_MATCH,
-			} },
-	{ swab_apm_power_in_minutes, "Sony VAIO", { /* Handle problems with APM on Sony Vaio PCG-N505X(DE) */
-			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION, "R0206H"),
-			MATCH(DMI_BIOS_DATE, "08/23/99"), NO_MATCH
-			} },
-
-	{ swab_apm_power_in_minutes, "Sony VAIO", { /* Handle problems with APM on Sony Vaio PCG-N505VX */
-			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION, "W2K06H0"),
-			MATCH(DMI_BIOS_DATE, "02/03/00"), NO_MATCH
-			} },
-			
-	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-XG29 */
-			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION, "R0117A0"),
-			MATCH(DMI_BIOS_DATE, "04/25/00"), NO_MATCH
-			} },
-
-	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-Z600NE */
-			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION, "R0121Z1"),
-			MATCH(DMI_BIOS_DATE, "05/11/00"), NO_MATCH
-			} },
-
-	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-Z600NE */
-			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION, "WME01Z1"),
-			MATCH(DMI_BIOS_DATE, "08/11/00"), NO_MATCH
-			} },
-
-	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-Z600LEK(DE) */
-			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION, "R0206Z3"),
-			MATCH(DMI_BIOS_DATE, "12/25/00"), NO_MATCH
-			} },
-
-	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-Z505LS */
-			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION, "R0203D0"),
-			MATCH(DMI_BIOS_DATE, "05/12/00"), NO_MATCH
-			} },
-
-	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-Z505LS */
-			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION, "R0203Z3"),
-			MATCH(DMI_BIOS_DATE, "08/25/00"), NO_MATCH
-			} },
-	
-	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-Z505LS (with updated BIOS) */
-			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION, "R0209Z3"),
-			MATCH(DMI_BIOS_DATE, "05/12/01"), NO_MATCH
-			} },
-
-	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-F104K */
-			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION, "R0204K2"),
-			MATCH(DMI_BIOS_DATE, "08/28/00"), NO_MATCH
-			} },
-
-	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-C1VN/C1VE */
-			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION, "R0208P1"),
-			MATCH(DMI_BIOS_DATE, "11/09/00"), NO_MATCH
-			} },
-
-	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-C1VE */
-			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION, "R0204P1"),
-			MATCH(DMI_BIOS_DATE, "09/12/00"), NO_MATCH
-			} },
-
-	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-C1VE */
-			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION, "WXPO1Z3"),
-			MATCH(DMI_BIOS_DATE, "10/26/01"), NO_MATCH
-			} },
 			
 	/* Machines which have problems handling enabled local APICs */
 
@@ -715,12 +396,6 @@ static __initdata struct dmi_blacklist d
 			NO_MATCH, NO_MATCH
 			} },
 
-	{ broken_acpi_Sx, "ASUS K7V-RM", {		/* Bad ACPI Sx table */
-			MATCH(DMI_BIOS_VERSION,"ASUS K7V-RM ACPI BIOS Revision 1003A"),
-			MATCH(DMI_BOARD_NAME, "<K7V-RM>"),
-			NO_MATCH, NO_MATCH
-			} },
-
 	{ broken_toshiba_keyboard, "Toshiba Satellite 4030cdt", { /* Keyboard generates spurious repeats */
 			MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),
 			NO_MATCH, NO_MATCH, NO_MATCH
@@ -735,21 +410,6 @@ static __initdata struct dmi_blacklist d
 			NO_MATCH, NO_MATCH, NO_MATCH
 			} },
 #endif
-
-	{ print_if_true, KERN_WARNING "IBM T23 - BIOS 1.03b+ and controller firmware 1.02+ may be needed for Linux APM.", {
-			MATCH(DMI_SYS_VENDOR, "IBM"),
-			MATCH(DMI_BIOS_VERSION, "1AET38WW (1.01b)"),
-			NO_MATCH, NO_MATCH
-			} },
-
-	/*
-	 *	Generic per vendor APM settings
-	 */
-	 
-	{ set_apm_ints, "IBM", {	/* Allow interrupts during suspend on IBM laptops */
-			MATCH(DMI_SYS_VENDOR, "IBM"),
-			NO_MATCH, NO_MATCH, NO_MATCH
-			} },
 
 	/*      
 	 * Several HP Proliant (and maybe other OSB4/ProFusion) systems

