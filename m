Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbUEFKeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbUEFKeR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 06:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbUEFKeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 06:34:17 -0400
Received: from mail.donpac.ru ([80.254.111.2]:25579 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S261984AbUEFKcP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 06:32:15 -0400
Subject: [PATCH 1/6] Export DMI probe function
In-Reply-To: <10838395372888@donpac.ru>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 6 May 2004 14:32:21 +0400
Message-Id: <10838395411151@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN -X /usr/share/dontdiff linux-2.6.6-rc3.vanlila/arch/i386/kernel/dmi_scan.c linux-2.6.6-rc3/arch/i386/kernel/dmi_scan.c
--- linux-2.6.6-rc3.vanlila/arch/i386/kernel/dmi_scan.c	2004-05-05 21:01:28.000000000 +0400
+++ linux-2.6.6-rc3/arch/i386/kernel/dmi_scan.c	2004-05-05 21:47:37.000000000 +0400
@@ -10,6 +10,7 @@
 #include <asm/io.h>
 #include <linux/pm.h>
 #include <asm/system.h>
+#include <linux/dmi.h>
 #include <linux/bootmem.h>
 
 unsigned long dmi_broken;
@@ -139,22 +140,6 @@
 	return -1;
 }
 
-
-enum
-{
-	DMI_NONE,
-	DMI_BIOS_VENDOR,
-	DMI_BIOS_VERSION,
-	DMI_BIOS_DATE,
-	DMI_SYS_VENDOR,
-	DMI_PRODUCT_NAME,
-	DMI_PRODUCT_VERSION,
-	DMI_BOARD_VENDOR,
-	DMI_BOARD_NAME,
-	DMI_BOARD_VERSION,
-	DMI_STRING_MAX
-};
-
 static char *dmi_ident[DMI_STRING_MAX];
 
 /*
@@ -176,25 +161,6 @@
 		printk(KERN_ERR "dmi_save_ident: out of memory.\n");
 }
 
-/*
- *	DMI callbacks for problem boards
- */
-
-struct dmi_strmatch
-{
-	u8 slot;
-	char *substr;
-};
-
-struct dmi_blacklist
-{
-	int (*callback)(struct dmi_blacklist *);
-	char *ident;
-	struct dmi_strmatch matches[4];
-};
-
-#define MATCH(a,b)	{ a, b }
-
 /* 
  * Reboot options and system auto-detection code provided by
  * Dell Inc. so their systems "just work". :-)
@@ -203,7 +169,7 @@
 /* 
  * Some machines require the "reboot=b"  commandline option, this quirk makes that automatic.
  */
-static __init int set_bios_reboot(struct dmi_blacklist *d)
+static __init int set_bios_reboot(struct dmi_system_id *d)
 {
 	extern int reboot_thru_bios;
 	if (reboot_thru_bios == 0)
@@ -217,7 +183,7 @@
 /*
  * Some machines require the "reboot=s"  commandline option, this quirk makes that automatic.
  */
-static __init int set_smp_reboot(struct dmi_blacklist *d)
+static __init int set_smp_reboot(struct dmi_system_id *d)
 {
 #ifdef CONFIG_SMP
 	extern int reboot_smp;
@@ -233,7 +199,7 @@
 /*
  * Some machines require the "reboot=b,s"  commandline option, this quirk makes that automatic.
  */
-static __init int set_smp_bios_reboot(struct dmi_blacklist *d)
+static __init int set_smp_bios_reboot(struct dmi_system_id *d)
 {
 	set_smp_reboot(d);
 	set_bios_reboot(d);
@@ -244,7 +210,7 @@
  * Some bioses have a broken protected mode poweroff and need to use realmode
  */
 
-static __init int set_realmode_power_off(struct dmi_blacklist *d)
+static __init int set_realmode_power_off(struct dmi_system_id *d)
 {
        if (apm_info.realmode_power_off == 0)
        {
@@ -259,7 +225,7 @@
  * Some laptops require interrupts to be enabled during APM calls 
  */
 
-static __init int set_apm_ints(struct dmi_blacklist *d)
+static __init int set_apm_ints(struct dmi_system_id *d)
 {
 	if (apm_info.allow_ints == 0)
 	{
@@ -273,7 +239,7 @@
  * Some APM bioses corrupt memory or just plain do not work
  */
 
-static __init int apm_is_horked(struct dmi_blacklist *d)
+static __init int apm_is_horked(struct dmi_system_id *d)
 {
 	if (apm_info.disabled == 0)
 	{
@@ -283,7 +249,7 @@
 	return 0;
 }
 
-static __init int apm_is_horked_d850md(struct dmi_blacklist *d)
+static __init int apm_is_horked_d850md(struct dmi_system_id *d)
 {
 	if (apm_info.disabled == 0) {
 		apm_info.disabled = 1;
@@ -298,7 +264,7 @@
  * Some APM bioses hang on APM idle calls
  */
 
-static __init int apm_likes_to_melt(struct dmi_blacklist *d)
+static __init int apm_likes_to_melt(struct dmi_system_id *d)
 {
 	if (apm_info.forbid_idle == 0) {
 		apm_info.forbid_idle = 1;
@@ -313,7 +279,7 @@
  * attaching or detaching the power cord, or entering BIOS setup screens
  * through magic key sequences.
  */
-static int __init local_apic_kills_bios(struct dmi_blacklist *d)
+static int __init local_apic_kills_bios(struct dmi_system_id *d)
 {
 #ifdef CONFIG_X86_LOCAL_APIC
 	extern int enable_local_apic;
@@ -331,7 +297,7 @@
  * Don't access SMBus on IBM systems which get corrupted eeproms 
  */
 
-static __init int disable_smbus(struct dmi_blacklist *d)
+static __init int disable_smbus(struct dmi_system_id *d)
 {   
 	if (is_unsafe_smbus == 0) {
 		is_unsafe_smbus = 1;
@@ -344,7 +310,7 @@
  * Work around broken HP Pavilion Notebooks which assign USB to
  * IRQ 9 even though it is actually wired to IRQ 11
  */
-static __init int fix_broken_hp_bios_irq9(struct dmi_blacklist *d)
+static __init int fix_broken_hp_bios_irq9(struct dmi_system_id *d)
 {
 #ifdef CONFIG_PCI
 	extern int broken_hp_bios_irq9;
@@ -373,7 +339,7 @@
  *	Phoenix A07  09/29/2000 is known good (Dell Inspiron 5000)
  */
 
-static __init int broken_apm_power(struct dmi_blacklist *d)
+static __init int broken_apm_power(struct dmi_system_id *d)
 {
 	apm_info.get_power_status_broken = 1;
 	printk(KERN_WARNING "BIOS strings suggest APM bugs, disabling power status reporting.\n");
@@ -388,7 +354,7 @@
  * We also want to avoid using certain functions of the PnP BIOS.
  */
 
-static __init int sony_vaio_laptop(struct dmi_blacklist *d)
+static __init int sony_vaio_laptop(struct dmi_system_id *d)
 {
 	if (is_sony_vaio_laptop == 0)
 	{
@@ -403,7 +369,7 @@
  * have this problem).
  */
  
-static __init int swab_apm_power_in_minutes(struct dmi_blacklist *d)
+static __init int swab_apm_power_in_minutes(struct dmi_system_id *d)
 {
 	apm_info.get_power_status_swabinminutes = 1;
 	printk(KERN_WARNING "BIOS strings suggest APM reports battery life in minutes and wrong byte order.\n");
@@ -417,7 +383,7 @@
  * The MP1.4 table is right however and so SMP kernels tend to work. 
  */
  
-static __init int broken_pirq(struct dmi_blacklist *d)
+static __init int broken_pirq(struct dmi_system_id *d)
 {
 
 	printk(KERN_INFO " *** Possibly defective BIOS detected (irqtable)\n");
@@ -438,7 +404,7 @@
  * ASUS K7V-RM has broken ACPI table defining sleep modes
  */
 
-static __init int broken_acpi_Sx(struct dmi_blacklist *d)
+static __init int broken_acpi_Sx(struct dmi_system_id *d)
 {
 	printk(KERN_WARNING "Detected ASUS mainboard with broken ACPI sleep table\n");
 	dmi_broken |= BROKEN_ACPI_Sx;
@@ -449,7 +415,7 @@
  * Toshiba keyboard likes to repeat keys when they are not repeated.
  */
 
-static __init int broken_toshiba_keyboard(struct dmi_blacklist *d)
+static __init int broken_toshiba_keyboard(struct dmi_system_id *d)
 {
 	printk(KERN_WARNING "Toshiba with broken keyboard detected. If your keyboard sometimes generates 3 keypresses instead of one, see http://davyd.ucc.asn.au/projects/toshiba/README\n");
 	return 0;
@@ -459,7 +425,7 @@
  * Toshiba fails to preserve interrupts over S1
  */
 
-static __init int init_ints_after_s1(struct dmi_blacklist *d)
+static __init int init_ints_after_s1(struct dmi_system_id *d)
 {
 	printk(KERN_WARNING "Toshiba with broken S1 detected.\n");
 	dmi_broken |= BROKEN_INIT_AFTER_S1;
@@ -467,7 +433,7 @@
 }
 
 #ifdef CONFIG_ACPI_SLEEP
-static __init int reset_videomode_after_s3(struct dmi_blacklist *d)
+static __init int reset_videomode_after_s3(struct dmi_system_id *d)
 {
 	/* See acpi_wakeup.S */
 	extern long acpi_video_flags;
@@ -481,7 +447,7 @@
  * disabled before the suspend. Linux used to get terribly confused by that.
  */
 
-static __init int broken_ps2_resume(struct dmi_blacklist *d)
+static __init int broken_ps2_resume(struct dmi_system_id *d)
 {
 	printk(KERN_INFO "%s machine detected. Mousepad Resume Bug workaround hopefully not needed.\n", d->ident);
 	return 0;
@@ -492,14 +458,14 @@
  *	some entries
  */
 
-static __init int exploding_pnp_bios(struct dmi_blacklist *d)
+static __init int exploding_pnp_bios(struct dmi_system_id *d)
 {
 	printk(KERN_WARNING "%s detected. Disabling PnPBIOS\n", d->ident);
 	dmi_broken |= BROKEN_PNP_BIOS;
 	return 0;
 }
 
-static __init int acer_cpufreq_pst(struct dmi_blacklist *d)
+static __init int acer_cpufreq_pst(struct dmi_system_id *d)
 {
 	printk(KERN_WARNING "%s laptop with broken PST tables in BIOS detected.\n", d->ident);
 	printk(KERN_WARNING "You need to downgrade to 3A21 (09/09/2002), or try a newer BIOS than 3A71 (01/20/2003)\n");
@@ -513,7 +479,7 @@
  *	Simple "print if true" callback
  */
  
-static __init int print_if_true(struct dmi_blacklist *d)
+static __init int print_if_true(struct dmi_system_id *d)
 {
 	printk("%s\n", d->ident);
 	return 0;
@@ -523,7 +489,7 @@
 #ifdef	CONFIG_ACPI_BOOT
 extern int acpi_force;
 
-static __init __attribute__((unused)) int dmi_disable_acpi(struct dmi_blacklist *d) 
+static __init __attribute__((unused)) int dmi_disable_acpi(struct dmi_system_id *d) 
 { 
 	if (!acpi_force) { 
 		printk(KERN_NOTICE "%s detected: acpi off\n",d->ident); 
@@ -538,7 +504,7 @@
 /*
  * Limit ACPI to CPU enumeration for HT
  */
-static __init __attribute__((unused)) int force_acpi_ht(struct dmi_blacklist *d) 
+static __init __attribute__((unused)) int force_acpi_ht(struct dmi_system_id *d) 
 { 
 	if (!acpi_force) { 
 		printk(KERN_NOTICE "%s detected: force use of acpi=ht\n", d->ident); 
@@ -553,7 +519,7 @@
 #endif
 
 #ifdef	CONFIG_ACPI_PCI
-static __init int disable_acpi_pci(struct dmi_blacklist *d) 
+static __init int disable_acpi_pci(struct dmi_system_id *d) 
 { 
 	printk(KERN_NOTICE "%s detected: force use of pci=noacpi\n", d->ident); 	
 	acpi_noirq_set();
@@ -571,293 +537,293 @@
  *	interrupt mask settings according to the laptop
  */
  
-static __initdata struct dmi_blacklist dmi_blacklist[]={
+static __initdata struct dmi_system_id dmi_blacklist[]={
 	{ broken_ps2_resume, "Dell Latitude C600", {	/* Handle problems with APM on the C600 */
-			MATCH(DMI_SYS_VENDOR, "Dell"),
-			MATCH(DMI_PRODUCT_NAME, "Latitude C600"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude C600"),
 			} },
 	{ set_apm_ints, "Dell Latitude", {  /* Allow interrupts during suspend on Dell Latitude laptops*/
-			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
-			MATCH(DMI_PRODUCT_NAME, "Latitude C510"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude C510"),
 			} },
 	{ apm_is_horked, "Dell Inspiron 2500", { /* APM crashes */
-			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
-			MATCH(DMI_PRODUCT_NAME, "Inspiron 2500"),
-			MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION,"A11")
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 2500"),
+			DMI_MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION,"A11")
 			} },
 	{ set_apm_ints, "Dell Inspiron", {	/* Allow interrupts during suspend on Dell Inspiron laptops*/
-			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
-			MATCH(DMI_PRODUCT_NAME, "Inspiron 4000"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 4000"),
 			} },
 	{ broken_apm_power, "Dell Inspiron 5000e", {	/* Handle problems with APM on Inspiron 5000e */
-			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION, "A04"),
-			MATCH(DMI_BIOS_DATE, "08/24/2000"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION, "A04"),
+			DMI_MATCH(DMI_BIOS_DATE, "08/24/2000"),
 			} },
 	{ broken_apm_power, "Dell Inspiron 2500", {	/* Handle problems with APM on Inspiron 2500 */
-			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION, "A12"),
-			MATCH(DMI_BIOS_DATE, "02/04/2002"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION, "A12"),
+			DMI_MATCH(DMI_BIOS_DATE, "02/04/2002"),
 			} },
 	{ apm_is_horked, "Dell Dimension 4100", { /* APM crashes */
-			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
-			MATCH(DMI_PRODUCT_NAME, "XPS-Z"),
-			MATCH(DMI_BIOS_VENDOR,"Intel Corp."),
-			MATCH(DMI_BIOS_VERSION,"A11")
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "XPS-Z"),
+			DMI_MATCH(DMI_BIOS_VENDOR,"Intel Corp."),
+			DMI_MATCH(DMI_BIOS_VERSION,"A11")
 			} },
 	{ set_realmode_power_off, "Award Software v4.60 PGMA", {	/* broken PM poweroff bios */
-			MATCH(DMI_BIOS_VENDOR, "Award Software International, Inc."),
-			MATCH(DMI_BIOS_VERSION, "4.60 PGMA"),
-			MATCH(DMI_BIOS_DATE, "134526184"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "Award Software International, Inc."),
+			DMI_MATCH(DMI_BIOS_VERSION, "4.60 PGMA"),
+			DMI_MATCH(DMI_BIOS_DATE, "134526184"),
 			} },
 	{ set_smp_bios_reboot, "Dell PowerEdge 1300", {	/* Handle problems with rebooting on Dell 1300's */
-			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
-			MATCH(DMI_PRODUCT_NAME, "PowerEdge 1300/"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge 1300/"),
 			} },
 	{ set_bios_reboot, "Dell PowerEdge 300", {	/* Handle problems with rebooting on Dell 300's */
-			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
-			MATCH(DMI_PRODUCT_NAME, "PowerEdge 300/"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge 300/"),
 			} },
 	{ set_bios_reboot, "Dell PowerEdge 2400", {  /* Handle problems with rebooting on Dell 2400's */
-			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
-			MATCH(DMI_PRODUCT_NAME, "PowerEdge 2400"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge 2400"),
 			} },
 	{ set_apm_ints, "Compaq 12XL125", {	/* Allow interrupts during suspend on Compaq Laptops*/
-			MATCH(DMI_SYS_VENDOR, "Compaq"),
-			MATCH(DMI_PRODUCT_NAME, "Compaq PC"),
-			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION,"4.06")
+			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Compaq PC"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION,"4.06")
 			} },
 	{ set_apm_ints, "ASUSTeK", {   /* Allow interrupts during APM or the clock goes slow */
-			MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer Inc."),
-			MATCH(DMI_PRODUCT_NAME, "L8400K series Notebook PC"),
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "L8400K series Notebook PC"),
 			} },					
 	{ apm_is_horked, "ABIT KX7-333[R]", { /* APM blows on shutdown */
-			MATCH(DMI_BOARD_VENDOR, "ABIT"),
-			MATCH(DMI_BOARD_NAME, "VT8367-8233A (KX7-333[R])"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "ABIT"),
+			DMI_MATCH(DMI_BOARD_NAME, "VT8367-8233A (KX7-333[R])"),
 			} },
 	{ apm_is_horked, "Trigem Delhi3", { /* APM crashes */
-			MATCH(DMI_SYS_VENDOR, "TriGem Computer, Inc"),
-			MATCH(DMI_PRODUCT_NAME, "Delhi3"),
+			DMI_MATCH(DMI_SYS_VENDOR, "TriGem Computer, Inc"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Delhi3"),
 			} },
 	{ apm_is_horked, "Fujitsu-Siemens", { /* APM crashes */
-			MATCH(DMI_BIOS_VENDOR, "hoenix/FUJITSU SIEMENS"),
-			MATCH(DMI_BIOS_VERSION, "Version1.01"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "hoenix/FUJITSU SIEMENS"),
+			DMI_MATCH(DMI_BIOS_VERSION, "Version1.01"),
 			} },
 	{ apm_is_horked_d850md, "Intel D850MD", { /* APM crashes */
-			MATCH(DMI_BIOS_VENDOR, "Intel Corp."),
-			MATCH(DMI_BIOS_VERSION, "MV85010A.86A.0016.P07.0201251536"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "Intel Corp."),
+			DMI_MATCH(DMI_BIOS_VERSION, "MV85010A.86A.0016.P07.0201251536"),
 			} },
 	{ apm_is_horked, "Intel D810EMO", { /* APM crashes */
-			MATCH(DMI_BIOS_VENDOR, "Intel Corp."),
-			MATCH(DMI_BIOS_VERSION, "MO81010A.86A.0008.P04.0004170800"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "Intel Corp."),
+			DMI_MATCH(DMI_BIOS_VERSION, "MO81010A.86A.0008.P04.0004170800"),
 			} },
 	{ apm_is_horked, "Dell XPS-Z", { /* APM crashes */
-			MATCH(DMI_BIOS_VENDOR, "Intel Corp."),
-			MATCH(DMI_BIOS_VERSION, "A11"),
-			MATCH(DMI_PRODUCT_NAME, "XPS-Z"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "Intel Corp."),
+			DMI_MATCH(DMI_BIOS_VERSION, "A11"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "XPS-Z"),
 			} },
 	{ apm_is_horked, "Sharp PC-PJ/AX", { /* APM crashes */
-			MATCH(DMI_SYS_VENDOR, "SHARP"),
-			MATCH(DMI_PRODUCT_NAME, "PC-PJ/AX"),
-			MATCH(DMI_BIOS_VENDOR,"SystemSoft"),
-			MATCH(DMI_BIOS_VERSION,"Version R2.08")
+			DMI_MATCH(DMI_SYS_VENDOR, "SHARP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PC-PJ/AX"),
+			DMI_MATCH(DMI_BIOS_VENDOR,"SystemSoft"),
+			DMI_MATCH(DMI_BIOS_VERSION,"Version R2.08")
 			} },
 	{ apm_is_horked, "Dell Inspiron 2500", { /* APM crashes */
-			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
-			MATCH(DMI_PRODUCT_NAME, "Inspiron 2500"),
-			MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION,"A11")
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 2500"),
+			DMI_MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION,"A11")
 			} },
 	{ apm_likes_to_melt, "Jabil AMD", { /* APM idle hangs */
-			MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
-			MATCH(DMI_BIOS_VERSION, "0AASNP06"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
+			DMI_MATCH(DMI_BIOS_VERSION, "0AASNP06"),
 			} },
 	{ apm_likes_to_melt, "AMI Bios", { /* APM idle hangs */
-			MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
-			MATCH(DMI_BIOS_VERSION, "0AASNP05"), 
+			DMI_MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
+			DMI_MATCH(DMI_BIOS_VERSION, "0AASNP05"), 
 			} },
 	{ sony_vaio_laptop, "Sony Vaio", { /* This is a Sony Vaio laptop */
-			MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
-			MATCH(DMI_PRODUCT_NAME, "PCG-"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PCG-"),
 			} },
 	{ swab_apm_power_in_minutes, "Sony VAIO", { /* Handle problems with APM on Sony Vaio PCG-N505X(DE) */
-			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION, "R0206H"),
-			MATCH(DMI_BIOS_DATE, "08/23/99"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION, "R0206H"),
+			DMI_MATCH(DMI_BIOS_DATE, "08/23/99"),
 			} },
 
 	{ swab_apm_power_in_minutes, "Sony VAIO", { /* Handle problems with APM on Sony Vaio PCG-N505VX */
-			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION, "W2K06H0"),
-			MATCH(DMI_BIOS_DATE, "02/03/00"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION, "W2K06H0"),
+			DMI_MATCH(DMI_BIOS_DATE, "02/03/00"),
 			} },
 			
 	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-XG29 */
-			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION, "R0117A0"),
-			MATCH(DMI_BIOS_DATE, "04/25/00"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION, "R0117A0"),
+			DMI_MATCH(DMI_BIOS_DATE, "04/25/00"),
 			} },
 
 	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-Z600NE */
-			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION, "R0121Z1"),
-			MATCH(DMI_BIOS_DATE, "05/11/00"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION, "R0121Z1"),
+			DMI_MATCH(DMI_BIOS_DATE, "05/11/00"),
 			} },
 
 	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-Z600NE */
-			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION, "WME01Z1"),
-			MATCH(DMI_BIOS_DATE, "08/11/00"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION, "WME01Z1"),
+			DMI_MATCH(DMI_BIOS_DATE, "08/11/00"),
 			} },
 
 	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-Z600LEK(DE) */
-			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION, "R0206Z3"),
-			MATCH(DMI_BIOS_DATE, "12/25/00"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION, "R0206Z3"),
+			DMI_MATCH(DMI_BIOS_DATE, "12/25/00"),
 			} },
 
 	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-Z505LS */
-			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION, "R0203D0"),
-			MATCH(DMI_BIOS_DATE, "05/12/00"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION, "R0203D0"),
+			DMI_MATCH(DMI_BIOS_DATE, "05/12/00"),
 			} },
 
 	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-Z505LS */
-			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION, "R0203Z3"),
-			MATCH(DMI_BIOS_DATE, "08/25/00"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION, "R0203Z3"),
+			DMI_MATCH(DMI_BIOS_DATE, "08/25/00"),
 			} },
 	
 	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-Z505LS (with updated BIOS) */
-			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION, "R0209Z3"),
-			MATCH(DMI_BIOS_DATE, "05/12/01"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION, "R0209Z3"),
+			DMI_MATCH(DMI_BIOS_DATE, "05/12/01"),
 			} },
 
 	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-F104K */
-			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION, "R0204K2"),
-			MATCH(DMI_BIOS_DATE, "08/28/00"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION, "R0204K2"),
+			DMI_MATCH(DMI_BIOS_DATE, "08/28/00"),
 			} },
 
 	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-C1VN/C1VE */
-			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION, "R0208P1"),
-			MATCH(DMI_BIOS_DATE, "11/09/00"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION, "R0208P1"),
+			DMI_MATCH(DMI_BIOS_DATE, "11/09/00"),
 			} },
 
 	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-C1VE */
-			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION, "R0204P1"),
-			MATCH(DMI_BIOS_DATE, "09/12/00"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION, "R0204P1"),
+			DMI_MATCH(DMI_BIOS_DATE, "09/12/00"),
 			} },
 
 	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-C1VE */
-			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-			MATCH(DMI_BIOS_VERSION, "WXPO1Z3"),
-			MATCH(DMI_BIOS_DATE, "10/26/01"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION, "WXPO1Z3"),
+			DMI_MATCH(DMI_BIOS_DATE, "10/26/01"),
 			} },
 			
 	{ exploding_pnp_bios, "Higraded P14H", {	/* PnPBIOS GPF on boot */
-			MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
-			MATCH(DMI_BIOS_VERSION, "07.00T"),
-			MATCH(DMI_SYS_VENDOR, "Higraded"),
-			MATCH(DMI_PRODUCT_NAME, "P14H")
+			DMI_MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
+			DMI_MATCH(DMI_BIOS_VERSION, "07.00T"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Higraded"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "P14H")
 			} },
 	{ exploding_pnp_bios, "ASUS P4P800", {	/* PnPBIOS GPF on boot */
-			MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer Inc."),
-			MATCH(DMI_BOARD_NAME, "P4P800"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer Inc."),
+			DMI_MATCH(DMI_BOARD_NAME, "P4P800"),
 			} },
 
 	/* Machines which have problems handling enabled local APICs */
 
 	{ local_apic_kills_bios, "Dell Inspiron", {
-			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
-			MATCH(DMI_PRODUCT_NAME, "Inspiron"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron"),
 			} },
 
 	{ local_apic_kills_bios, "Dell Latitude", {
-			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
-			MATCH(DMI_PRODUCT_NAME, "Latitude"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude"),
 			} },
 
 	{ local_apic_kills_bios, "IBM Thinkpad T20", {
-			MATCH(DMI_BOARD_VENDOR, "IBM"),
-			MATCH(DMI_BOARD_NAME, "264741U"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
+			DMI_MATCH(DMI_BOARD_NAME, "264741U"),
 			} },
 
 	{ local_apic_kills_bios, "ASUS L3C", {
-			MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
-			MATCH(DMI_BOARD_NAME, "P4_L3C"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "P4_L3C"),
 			} },
 
 	/* Problem Intel 440GX bioses */
 
 	{ broken_pirq, "SABR1 Bios", {			/* Bad $PIR */
-			MATCH(DMI_BIOS_VENDOR, "Intel Corporation"),
-			MATCH(DMI_BIOS_VERSION,"SABR1"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_BIOS_VERSION,"SABR1"),
 			} },
 	{ broken_pirq, "l44GX Bios", {        		/* Bad $PIR */
-			MATCH(DMI_BIOS_VENDOR, "Intel Corporation"),
-			MATCH(DMI_BIOS_VERSION,"L440GX0.86B.0094.P10"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_BIOS_VERSION,"L440GX0.86B.0094.P10"),
                         } },
 	{ broken_pirq, "l44GX Bios", {        		/* Bad $PIR */
-			MATCH(DMI_BIOS_VENDOR, "Intel Corporation"),
-			MATCH(DMI_BIOS_VERSION,"L440GX0.86B.0115.P12"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_BIOS_VERSION,"L440GX0.86B.0115.P12"),
                         } },
 	{ broken_pirq, "l44GX Bios", {        		/* Bad $PIR */
-			MATCH(DMI_BIOS_VENDOR, "Intel Corporation"),
-			MATCH(DMI_BIOS_VERSION,"L440GX0.86B.0120.P12"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_BIOS_VERSION,"L440GX0.86B.0120.P12"),
                         } },
 	{ broken_pirq, "l44GX Bios", {		/* Bad $PIR */
-			MATCH(DMI_BIOS_VENDOR, "Intel Corporation"),
-			MATCH(DMI_BIOS_VERSION,"L440GX0.86B.0125.P13"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_BIOS_VERSION,"L440GX0.86B.0125.P13"),
 			} },
 	{ broken_pirq, "l44GX Bios", {		/* Bad $PIR */
-			MATCH(DMI_BIOS_VENDOR, "Intel Corporation"),
-			MATCH(DMI_BIOS_VERSION,"L440GX0.86B.0066.P07.9906041405"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_BIOS_VERSION,"L440GX0.86B.0066.P07.9906041405"),
 			} },
 
 	{ broken_pirq, "IBM xseries 370", {		/* Bad $PIR */
-			MATCH(DMI_BIOS_VENDOR, "IBM"),
-			MATCH(DMI_BIOS_VERSION,"MMKT33AUS"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "IBM"),
+			DMI_MATCH(DMI_BIOS_VERSION,"MMKT33AUS"),
 			} },
                         
 	/* Intel in disguise - In this case they can't hide and they don't run
 	   too well either... */
 	{ broken_pirq, "Dell PowerEdge 8450", {		/* Bad $PIR */
-			MATCH(DMI_PRODUCT_NAME, "Dell PowerEdge 8450"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell PowerEdge 8450"),
 			} },
 			
 	{ broken_acpi_Sx, "ASUS K7V-RM", {		/* Bad ACPI Sx table */
-			MATCH(DMI_BIOS_VERSION,"ASUS K7V-RM ACPI BIOS Revision 1003A"),
-			MATCH(DMI_BOARD_NAME, "<K7V-RM>"),
+			DMI_MATCH(DMI_BIOS_VERSION,"ASUS K7V-RM ACPI BIOS Revision 1003A"),
+			DMI_MATCH(DMI_BOARD_NAME, "<K7V-RM>"),
 			} },
 
 	{ broken_toshiba_keyboard, "Toshiba Satellite 4030cdt", { /* Keyboard generates spurious repeats */
-			MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),
 			} },
 	{ init_ints_after_s1, "Toshiba Satellite 4030cdt", { /* Reinitialization of 8259 is needed after S1 resume */
-			MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),
 			} },
 #ifdef CONFIG_ACPI_SLEEP
 	{ reset_videomode_after_s3, "Toshiba Satellite 4030cdt", { /* Reset video mode after returning from ACPI S3 sleep */
-			MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),
 			} },
 #endif
 
 	{ print_if_true, KERN_WARNING "IBM T23 - BIOS 1.03b+ and controller firmware 1.02+ may be needed for Linux APM.", {
-			MATCH(DMI_SYS_VENDOR, "IBM"),
-			MATCH(DMI_BIOS_VERSION, "1AET38WW (1.01b)"),
+			DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
+			DMI_MATCH(DMI_BIOS_VERSION, "1AET38WW (1.01b)"),
 			} },
 	 
 	{ fix_broken_hp_bios_irq9, "HP Pavilion N5400 Series Laptop", {
-			MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-			MATCH(DMI_BIOS_VERSION, "GE.M1.03"),
-			MATCH(DMI_PRODUCT_VERSION, "HP Pavilion Notebook Model GE"),
-			MATCH(DMI_BOARD_VERSION, "OmniBook N32N-736"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_BIOS_VERSION, "GE.M1.03"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "HP Pavilion Notebook Model GE"),
+			DMI_MATCH(DMI_BOARD_VERSION, "OmniBook N32N-736"),
 			} },
  
 
@@ -866,7 +832,7 @@
 	 */
 	 
 	{ set_apm_ints, "IBM", {	/* Allow interrupts during suspend on IBM laptops */
-			MATCH(DMI_SYS_VENDOR, "IBM"),
+			DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
 			} },
 
 	/*
@@ -874,7 +840,7 @@
 	 */
 	 
 	{ disable_smbus, "IBM", {
-			MATCH(DMI_SYS_VENDOR, "IBM"),
+			DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
 			} },
 
 	/*
@@ -883,8 +849,8 @@
 	 * Mention this, and disable cpufreq.
 	 */
 	{ acer_cpufreq_pst, "Acer Aspire", {
-			MATCH(DMI_SYS_VENDOR, "Insyde Software"),
-			MATCH(DMI_BIOS_VERSION, "3A71"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde Software"),
+			DMI_MATCH(DMI_BIOS_VERSION, "3A71"),
 			} },
 
 #ifdef	CONFIG_ACPI_BOOT
@@ -898,8 +864,8 @@
 	 */
 
 	{ dmi_disable_acpi, "IBM Thinkpad", {
-			MATCH(DMI_BOARD_VENDOR, "IBM"),
-			MATCH(DMI_BOARD_NAME, "2629H1G"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
+			DMI_MATCH(DMI_BOARD_NAME, "2629H1G"),
 			} },
 
 	/*
@@ -907,64 +873,64 @@
 	 */
 
 	{ force_acpi_ht, "FSC Primergy T850", {
-			MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
-			MATCH(DMI_PRODUCT_NAME, "PRIMERGY T850"),
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PRIMERGY T850"),
 			} },
 	{ force_acpi_ht, "DELL GX240", {
-			MATCH(DMI_BOARD_VENDOR, "Dell Computer Corporation"),
-			MATCH(DMI_BOARD_NAME, "OptiPlex GX240"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "Dell Computer Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "OptiPlex GX240"),
 			} },
 	{ force_acpi_ht, "HP VISUALIZE NT Workstation", {
-			MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
-			MATCH(DMI_PRODUCT_NAME, "HP VISUALIZE NT Workstation"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP VISUALIZE NT Workstation"),
 			} },
 	{ force_acpi_ht, "Compaq ProLiant DL380 G2", {
-			MATCH(DMI_SYS_VENDOR, "Compaq"),
-			MATCH(DMI_PRODUCT_NAME, "ProLiant DL380 G2"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ProLiant DL380 G2"),
 			} },
 	{ force_acpi_ht, "Compaq ProLiant ML530 G2", {
-			MATCH(DMI_SYS_VENDOR, "Compaq"),
-			MATCH(DMI_PRODUCT_NAME, "ProLiant ML530 G2"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ProLiant ML530 G2"),
 			} },
 	{ force_acpi_ht, "Compaq ProLiant ML350 G3", {
-			MATCH(DMI_SYS_VENDOR, "Compaq"),
-			MATCH(DMI_PRODUCT_NAME, "ProLiant ML350 G3"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ProLiant ML350 G3"),
 			} },
 	{ force_acpi_ht, "Compaq Workstation W8000", {
-			MATCH(DMI_SYS_VENDOR, "Compaq"),
-			MATCH(DMI_PRODUCT_NAME, "Workstation W8000"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Workstation W8000"),
 			} },
 	{ force_acpi_ht, "ASUS P4B266", {
-			MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
-			MATCH(DMI_BOARD_NAME, "P4B266"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "P4B266"),
 			} },
 	{ force_acpi_ht, "ASUS P2B-DS", {
-			MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
-			MATCH(DMI_BOARD_NAME, "P2B-DS"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "P2B-DS"),
 			} },
 	{ force_acpi_ht, "ASUS CUR-DLS", {
-			MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
-			MATCH(DMI_BOARD_NAME, "CUR-DLS"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "CUR-DLS"),
 			} },
 	{ force_acpi_ht, "ABIT i440BX-W83977", {
-			MATCH(DMI_BOARD_VENDOR, "ABIT <http://www.abit.com>"),
-			MATCH(DMI_BOARD_NAME, "i440BX-W83977 (BP6)"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "ABIT <http://www.abit.com>"),
+			DMI_MATCH(DMI_BOARD_NAME, "i440BX-W83977 (BP6)"),
 			} },
 	{ force_acpi_ht, "IBM Bladecenter", {
-			MATCH(DMI_BOARD_VENDOR, "IBM"),
-			MATCH(DMI_BOARD_NAME, "IBM eServer BladeCenter HS20"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
+			DMI_MATCH(DMI_BOARD_NAME, "IBM eServer BladeCenter HS20"),
 			} },
 	{ force_acpi_ht, "IBM eServer xSeries 360", {
-			MATCH(DMI_BOARD_VENDOR, "IBM"),
-			MATCH(DMI_BOARD_NAME, "eServer xSeries 360"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
+			DMI_MATCH(DMI_BOARD_NAME, "eServer xSeries 360"),
 			} },
 	{ force_acpi_ht, "IBM eserver xSeries 330", {
-			MATCH(DMI_BOARD_VENDOR, "IBM"),
-			MATCH(DMI_BOARD_NAME, "eserver xSeries 330"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
+			DMI_MATCH(DMI_BOARD_NAME, "eserver xSeries 330"),
 			} },
 	{ force_acpi_ht, "IBM eserver xSeries 440", {
-			MATCH(DMI_BOARD_VENDOR, "IBM"),
-			MATCH(DMI_PRODUCT_NAME, "eserver xSeries 440"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "eserver xSeries 440"),
 			} },
 #endif	// CONFIG_ACPI_BOOT
 
@@ -974,10 +940,10 @@
 	 */
 
 	{ disable_acpi_pci, "ASUS A7V", {
-			MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC"),
-			MATCH(DMI_BOARD_NAME, "<A7V>"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC"),
+			DMI_MATCH(DMI_BOARD_NAME, "<A7V>"),
 			/* newer BIOS, Revision 1011, does work */
-			MATCH(DMI_BIOS_VERSION, "ASUS A7V ACPI BIOS Revision 1007"),
+			DMI_MATCH(DMI_BIOS_VERSION, "ASUS A7V ACPI BIOS Revision 1007"),
 			} },
 #endif
 	{ NULL, }
@@ -985,16 +951,42 @@
 
 
 /*
- *	Walk the blacklist table running matching functions until someone 
- *	returns 1 or we hit the end.
+ *	dmi_check_system - check system DMI data
+ *	@list: array of dmi_system_id structures to match against
+ *
+ *	Walk the blacklist table running matching functions until someone
+ *	returns non zero or we hit the end. Callback function is called for
+ *	each successfull match. Returns the number of matches.
  */
- 
+int dmi_check_system(struct dmi_system_id *list)
+{
+	int i, count = 0;
+	struct dmi_system_id *d = list;
+
+	while (d->ident) {
+		for (i = 0; i < ARRAY_SIZE(d->matches); i++) {
+			int s = d->matches[i].slot;
+			if (s == DMI_NONE)
+				continue;
+			if (dmi_ident[s] && strstr(dmi_ident[s], d->matches[i].substr))
+				continue;
+			/* No match */
+			goto fail;
+		}
+		if (d->callback && d->callback(d))
+			break;
+		count++;
+fail:		d++;
+	}
+
+	return count;
+}
+
+EXPORT_SYMBOL(dmi_check_system);
+
 
 static __init void dmi_check_blacklist(void)
 {
-	struct dmi_blacklist *d;
-	int i;
-		
 #ifdef	CONFIG_ACPI_BOOT
 #define	ACPI_BLACKLIST_CUTOFF_YEAR	2001
 
@@ -1017,24 +1009,7 @@
 	}
 #endif
 
-	d=&dmi_blacklist[0];
-	while(d->callback)
-	{
-		for(i=0;i<4;i++)
-		{
-			int s = d->matches[i].slot;
-			if(s==DMI_NONE)
-				continue;
-			if(dmi_ident[s] && strstr(dmi_ident[s], d->matches[i].substr))
-				continue;
-			/* No match */
-			goto fail;
-		}
-		if(d->callback(d))
-			return;
-fail:			
-		d++;
-	}
+	dmi_check_system(dmi_blacklist);
 }
 
 	
diff -urN -X /usr/share/dontdiff linux-2.6.6-rc3.vanlila/include/linux/dmi.h linux-2.6.6-rc3/include/linux/dmi.h
--- linux-2.6.6-rc3.vanlila/include/linux/dmi.h	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6.6-rc3/include/linux/dmi.h	2004-05-05 21:04:35.000000000 +0400
@@ -0,0 +1,44 @@
+#ifndef __DMI_H__
+#define __DMI_H__
+
+enum {
+	DMI_NONE,
+	DMI_BIOS_VENDOR,
+	DMI_BIOS_VERSION,
+	DMI_BIOS_DATE,
+	DMI_SYS_VENDOR,
+	DMI_PRODUCT_NAME,
+	DMI_PRODUCT_VERSION,
+	DMI_BOARD_VENDOR,
+	DMI_BOARD_NAME,
+	DMI_BOARD_VERSION,
+	DMI_STRING_MAX,
+};
+
+/*
+ *	DMI callbacks for problem boards
+ */
+struct dmi_strmatch {
+	u8 slot;
+	char *substr;
+};
+
+struct dmi_system_id {
+	int (*callback)(struct dmi_system_id *);
+	char *ident;
+	struct dmi_strmatch matches[4];
+};
+
+#define DMI_MATCH(a,b)	{ a, b }
+
+#ifdef CONFIG_X86
+
+extern int dmi_check_system(struct dmi_system_id *list);
+
+#else
+
+static inline int dmi_check_system(struct dmi_system_id *list) { return 0; }
+
+#endif
+
+#endif	/* __DMI_H__ */

