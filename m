Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266533AbUAWGst (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 01:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266532AbUAWGqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 01:46:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25810 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266523AbUAWGgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 01:36:46 -0500
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org
From: davej@redhat.com
Subject: DMI updates from 2.4
Message-Id: <E1Ajuub-0000x4-00@hardwired>
Date: Fri, 23 Jan 2004 06:35:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A lot of the blacklists never made it forward, here's what I found
still lying around in my old 2.5 tree when I brought it up to date.

I think 2.4 has had more updates since then (and there may be
some entries languishing in vendor 2.4 trees), I'll take a peek
when I get some spare cycles.

    Dave


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/apm.c linux-2.5/arch/i386/kernel/apm.c
--- bk-linus/arch/i386/kernel/apm.c	2004-01-21 15:58:34.000000000 +0000
+++ linux-2.5/arch/i386/kernel/apm.c	2004-01-21 17:46:22.000000000 +0000
@@ -844,6 +844,8 @@ recalc:
 		idle_percentage *= 100;
 		idle_percentage /= jiffies_since_last_check;
 		use_apm_idle = (idle_percentage > idle_threshold);
+		if (apm_info.forbid_idle)
+			use_apm_idle = 0;
 		last_jiffies = jiffies;
 		last_stime = current->stime;
 	}
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/dmi_scan.c linux-2.5/arch/i386/kernel/dmi_scan.c
--- bk-linus/arch/i386/kernel/dmi_scan.c	2004-01-20 16:42:06.000000000 +0000
+++ linux-2.5/arch/i386/kernel/dmi_scan.c	2004-01-21 17:46:22.000000000 +0000
@@ -283,6 +283,30 @@ static __init int apm_is_horked(struct d
 	return 0;
 }
 
+static __init int apm_is_horked_d850md(struct dmi_blacklist *d)
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
+/* 
+ * Some APM bioses hang on APM idle calls
+ */
+
+static __init int apm_likes_to_melt(struct dmi_blacklist *d)
+{
+	if (apm_info.forbid_idle == 0) {
+		apm_info.forbid_idle = 1;
+		printk(KERN_INFO "%s machine detected. Disabling APM idle calls.\n", d->ident);
+	}
+	return 0;
+}
+
 /*
  * Some machines, usually laptops, can't handle an enabled local APIC.
  * The symptoms include hangs or reboots when suspending or resuming,
@@ -558,6 +582,22 @@ static __initdata struct dmi_blacklist d
 			MATCH(DMI_PRODUCT_NAME, "Latitude C600"),
 			NO_MATCH, NO_MATCH
 			} },
+	{ set_apm_ints, "Dell Latitude", {  /* Allow interrupts during suspend on Dell Latitude laptops*/
+			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			MATCH(DMI_PRODUCT_NAME, "Latitude C510"),
+			NO_MATCH, NO_MATCH
+			} },
+	{ apm_is_horked, "Dell Inspiron 2500", { /* APM crashes */
+			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			MATCH(DMI_PRODUCT_NAME, "Inspiron 2500"),
+			MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
+			MATCH(DMI_BIOS_VERSION,"A11")
+			} },
+	{ set_apm_ints, "Dell Inspiron", {	/* Allow interrupts during suspend on Dell Inspiron laptops*/
+			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			MATCH(DMI_PRODUCT_NAME, "Inspiron 4000"),
+			NO_MATCH, NO_MATCH
+			} },
 	{ broken_apm_power, "Dell Inspiron 5000e", {	/* Handle problems with APM on Inspiron 5000e */
 			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
 			MATCH(DMI_BIOS_VERSION, "A04"),
@@ -568,6 +608,12 @@ static __initdata struct dmi_blacklist d
 			MATCH(DMI_BIOS_VERSION, "A12"),
 			MATCH(DMI_BIOS_DATE, "02/04/2002"), NO_MATCH
 			} },
+	{ apm_is_horked, "Dell Dimension 4100", { /* APM crashes */
+			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			MATCH(DMI_PRODUCT_NAME, "XPS-Z"),
+			MATCH(DMI_BIOS_VENDOR,"Intel Corp."),
+			MATCH(DMI_BIOS_VERSION,"A11")
+			} },
 	{ set_realmode_power_off, "Award Software v4.60 PGMA", {	/* broken PM poweroff bios */
 			MATCH(DMI_BIOS_VENDOR, "Award Software International, Inc."),
 			MATCH(DMI_BIOS_VERSION, "4.60 PGMA"),
@@ -578,21 +624,16 @@ static __initdata struct dmi_blacklist d
 			MATCH(DMI_PRODUCT_NAME, "PowerEdge 1300/"),
 			NO_MATCH, NO_MATCH
 			} },
-	{ set_bios_reboot, "Dell PowerEdge 300", {	/* Handle problems with rebooting on Dell 1300's */
+	{ set_bios_reboot, "Dell PowerEdge 300", {	/* Handle problems with rebooting on Dell 300's */
 			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
 			MATCH(DMI_PRODUCT_NAME, "PowerEdge 300/"),
 			NO_MATCH, NO_MATCH
 			} },
-	{ set_bios_reboot, "Dell PowerEdge 2400", {  /* Handle problems with rebooting on Dell 300/800's */
+	{ set_bios_reboot, "Dell PowerEdge 2400", {  /* Handle problems with rebooting on Dell 2400's */
 			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
 			MATCH(DMI_PRODUCT_NAME, "PowerEdge 2400"),
 			NO_MATCH, NO_MATCH
 			} },
-	{ set_apm_ints, "Dell Inspiron", {	/* Allow interrupts during suspend on Dell Inspiron laptops*/
-			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
-			MATCH(DMI_PRODUCT_NAME, "Inspiron 4000"),
-			NO_MATCH, NO_MATCH
-			} },
 	{ set_apm_ints, "Compaq 12XL125", {	/* Allow interrupts during suspend on Compaq Laptops*/
 			MATCH(DMI_SYS_VENDOR, "Compaq"),
 			MATCH(DMI_PRODUCT_NAME, "Compaq PC"),
@@ -647,6 +688,16 @@ static __initdata struct dmi_blacklist d
 			MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
 			MATCH(DMI_BIOS_VERSION,"A11")
 			} },
+	{ apm_likes_to_melt, "Jabil AMD", { /* APM idle hangs */
+			MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
+			MATCH(DMI_BIOS_VERSION, "0AASNP06"),
+			NO_MATCH, NO_MATCH,
+			} },
+	{ apm_likes_to_melt, "AMI Bios", { /* APM idle hangs */
+			MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
+			MATCH(DMI_BIOS_VERSION, "0AASNP05"), 
+			NO_MATCH, NO_MATCH,
+			} },
 	{ sony_vaio_laptop, "Sony Vaio", { /* This is a Sony Vaio laptop */
 			MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
 			MATCH(DMI_PRODUCT_NAME, "PCG-"),
@@ -777,6 +828,11 @@ static __initdata struct dmi_blacklist d
                         } },
 	{ broken_pirq, "l44GX Bios", {        		/* Bad $PIR */
 			MATCH(DMI_BIOS_VENDOR, "Intel Corporation"),
+			MATCH(DMI_BIOS_VERSION,"L440GX0.86B.0115.P12"),
+			NO_MATCH, NO_MATCH
+                        } },
+	{ broken_pirq, "l44GX Bios", {        		/* Bad $PIR */
+			MATCH(DMI_BIOS_VENDOR, "Intel Corporation"),
 			MATCH(DMI_BIOS_VERSION,"L440GX0.86B.0120.P12"),
 			NO_MATCH, NO_MATCH
                         } },
@@ -790,6 +846,12 @@ static __initdata struct dmi_blacklist d
 			MATCH(DMI_BIOS_VERSION,"L440GX0.86B.0066.P07.9906041405"),
 			NO_MATCH, NO_MATCH
 			} },
+
+	{ broken_pirq, "IBM xseries 370", {		/* Bad $PIR */
+			MATCH(DMI_BIOS_VENDOR, "IBM"),
+			MATCH(DMI_BIOS_VERSION,"MMKT33AUS"),
+			NO_MATCH, NO_MATCH
+			} },
                         
 	/* Intel in disguise - In this case they can't hide and they don't run
 	   too well either... */
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/include/linux/apm_bios.h linux-2.5/include/linux/apm_bios.h
--- bk-linus/include/linux/apm_bios.h	2003-09-29 20:09:11.000000000 +0100
+++ linux-2.5/include/linux/apm_bios.h	2003-09-29 20:13:03.000000000 +0100
@@ -53,6 +53,7 @@ struct apm_info {
 	int			get_power_status_broken;
 	int			get_power_status_swabinminutes;
 	int			allow_ints;
+	int			forbid_idle;
 	int			realmode_power_off;
 	int			disabled;
 };
