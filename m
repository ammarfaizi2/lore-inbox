Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310375AbSCBNRH>; Sat, 2 Mar 2002 08:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310376AbSCBNQ6>; Sat, 2 Mar 2002 08:16:58 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:60846 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S310375AbSCBNQo>;
	Sat, 2 Mar 2002 08:16:44 -0500
Date: Sat, 2 Mar 2002 14:16:42 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200203021316.OAA23779@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] DMI / local APIC fixes updated
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've updated the DMI/APIC fixes patch kit with two new DMI
blacklist rules, for IBM's Thinkpad T20 and Microstar's 6163
series of mainboards. Both of these appear to suffer from
similar problems as the infamous Dell Inspiron: enabling the
local APIC (via CONFIG_SMP or CONFIG_X86_UP_APIC) causes
semi-random lockups due to BIOS bugs.

An older version of the patch kit found its way into 2.5.6-pre1
via the -dj tree. Included below is an incremental update for
2.5.6-pre1 which adds the new DMI rules and eliminates an ugly
and redundant #include in ioremap.c.

The new 2.5 patch and the updated kit for 2.4 are also available
at <http://www.csd.uu.se/~mikpe/linux/patches/>.

/Mikael

diff -ruN linux-2.5.6-pre1/arch/i386/kernel/dmi_scan.c linux-2.5.6-pre1.dmi-apic-fixes/arch/i386/kernel/dmi_scan.c
--- linux-2.5.6-pre1/arch/i386/kernel/dmi_scan.c	Thu Feb 28 02:04:29 2002
+++ linux-2.5.6-pre1.dmi-apic-fixes/arch/i386/kernel/dmi_scan.c	Thu Feb 28 02:06:43 2002
@@ -438,6 +438,25 @@
 }
 
 /*
+ * The Microstar 6163-2 (a.k.a Pro) mainboard will hang shortly after
+ * resumes, and also at what appears to be asynchronous APM events,
+ * if the local APIC is enabled.
+ */
+static int __init apm_kills_local_apic(struct dmi_blacklist *d)
+{
+#ifdef CONFIG_X86_LOCAL_APIC
+	extern int dont_enable_local_apic;
+	if (apm_info.bios.version && !dont_enable_local_apic) {
+		dont_enable_local_apic = 1;
+		printk(KERN_WARNING "%s with broken BIOS detected. "
+		       "Refusing to enable the local APIC.\n",
+		       d->ident);
+	}
+#endif
+	return 0;
+}
+
+/*
  * The Intel AL440LX mainboard will hang randomly if the local APIC
  * timer is running and the APM BIOS hasn't been disabled.
  */
@@ -612,6 +631,17 @@
 			NO_MATCH, NO_MATCH
 			} },
 
+	{ local_apic_kills_bios, "IBM Thinkpad T20", {
+			MATCH(DMI_BOARD_VENDOR, "IBM"),
+			MATCH(DMI_BOARD_NAME, "264741U"),
+			NO_MATCH, NO_MATCH
+			} },
+
+	{ apm_kills_local_apic, "Microstar 6163", {
+			MATCH(DMI_BOARD_VENDOR, "MICRO-STAR INTERNATIONAL CO., LTD"),
+			MATCH(DMI_BOARD_NAME, "MS-6163"),
+			NO_MATCH, NO_MATCH } },
+
 	{ apm_kills_local_apic_timer, "Intel AL440LX", {
 			MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
 			MATCH(DMI_BOARD_NAME, "AL440LX"),
diff -ruN linux-2.5.6-pre1/arch/i386/mm/ioremap.c linux-2.5.6-pre1.dmi-apic-fixes/arch/i386/mm/ioremap.c
--- linux-2.5.6-pre1/arch/i386/mm/ioremap.c	Thu Feb 28 02:04:29 2002
+++ linux-2.5.6-pre1.dmi-apic-fixes/arch/i386/mm/ioremap.c	Thu Feb 28 02:06:43 2002
@@ -162,7 +162,6 @@
 		return vfree((void *) (PAGE_MASK & (unsigned long) addr));
 }
 
-#include <asm/fixmap.h>
 void __init *bt_ioremap(unsigned long phys_addr, unsigned long size)
 {
 	unsigned long offset, last_addr;
