Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267269AbUHEMlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267269AbUHEMlJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 08:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266686AbUHEMj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 08:39:29 -0400
Received: from cantor.suse.de ([195.135.220.2]:35757 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262328AbUHEMim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 08:38:42 -0400
Date: Thu, 5 Aug 2004 14:38:37 +0200
From: Andi Kleen <ak@suse.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Automatically enable bigsmp on big HP machines
Message-Id: <20040805143837.4a6dce7e.ak@suse.de>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This enables apic=bigsmp automatically on some big HP machines that need it. 
This makes them boot without kernel parameters on a generic arch kernel.

Also it removes an unnecessary panic in the same area.

-Andi

diff -u linux-2.6.7/arch/i386/kernel/dmi_scan.c-HP linux-2.6.7/arch/i386/kernel/dmi_scan.c
--- linux-2.6.7/arch/i386/kernel/dmi_scan.c-HP	2004-08-05 14:00:29.325072566 +0200
+++ linux-2.6.7/arch/i386/kernel/dmi_scan.c	2004-08-05 14:19:57.058593500 +0200
@@ -272,6 +272,16 @@
 }  
 #endif
 
+static __init int hp_ht_bigsmp(struct dmi_blacklist *d) 
+{ 
+#ifdef CONFIG_X86_GENERICARCH
+ 	extern int dmi_bigsmp;
+ 	printk(KERN_NOTICE "%s detected: force use of apic=bigsmp\n", d->ident);
+ 	dmi_bigsmp = 1;
+#endif
+ 	return 0;
+} 
+
 /*
  *	Process the DMI blacklists
  */
@@ -460,6 +455,17 @@
 #endif	// CONFIG_ACPI_BOOT
 
 #ifdef	CONFIG_ACPI_PCI
+
+	{ hp_ht_bigsmp, "HP ProLiant DL760 G2", {
+			MATCH(DMI_BIOS_VENDOR, "HP"),
+			MATCH(DMI_BIOS_VERSION, "P44-"),
+			NO_MATCH, NO_MATCH }},
+
+	{ hp_ht_bigsmp, "HP ProLiant DL740", {
+			MATCH(DMI_BIOS_VENDOR, "HP"),
+			MATCH(DMI_BIOS_VERSION, "P47-"),
+			NO_MATCH, NO_MATCH }},
+
 	/*
 	 *	Boxes that need ACPI PCI IRQ routing disabled
 	 */
diff -u linux-2.6.7/arch/i386/kernel/io_apic.c-HP linux-2.6.7/arch/i386/kernel/io_apic.c
--- linux-2.6.7/arch/i386/kernel/io_apic.c-HP	2004-08-05 14:00:29.328072077 +0200
+++ linux-2.6.7/arch/i386/kernel/io_apic.c	2004-08-05 14:17:49.595383418 +0200
@@ -1714,7 +1714,7 @@
 		reg_00.raw = io_apic_read(apic, 0);
 		spin_unlock_irqrestore(&ioapic_lock, flags);
 		if (reg_00.bits.ID != mp_ioapics[apic].mpc_apicid)
-			panic("could not set ID!\n");
+			printk(" could not set ID!\n");
 		else
 			printk(" ok.\n");
 	}
