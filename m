Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265294AbUEZDCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265294AbUEZDCz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 23:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265295AbUEZDCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 23:02:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51376 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265294AbUEZDCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 23:02:52 -0400
Date: Tue, 25 May 2004 23:02:36 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] make proliant 8500 boot with 2.6
Message-ID: <Pine.LNX.4.44.0405252255270.30062-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vojtech,

the probes in i8042_enable_mux_mode, called at initialisation
time, make the hpaq proliant 8500 systems reboot immediately.
The system does boot with the "i8042.nomux" boot option.

The following (trivial) patch makes this automatic by setting
the i8042_nomux variable at DMI scanning time.

Please apply, thank you - Rik

--- linux-2.6.6/arch/i386/kernel/dmi_scan.c.hp8500	2004-05-25 16:03:37.370556464 -0400
+++ linux-2.6.6/arch/i386/kernel/dmi_scan.c	2004-05-25 16:38:00.565903096 -0400
@@ -401,6 +401,23 @@
 }
 
 /*
+ * HP Proliant 8500 systems can't use i8042 in mux mode,
+ * or they instantly reboot.
+ */
+#ifdef CONFIG_SERIO_I8042
+extern unsigned int i8042_nomux;
+static __init int set_8042_nomux(struct dmi_blacklist *d)
+{
+	if (i8042_nomux == 0)
+	{
+		i8042_nomux = 1;
+		printk(KERN_INFO "Disabling i8042 mux mode\n");
+	}
+	return 0;
+}
+#endif
+
+/*
  * This bios swaps the APM minute reporting bytes over (Many sony laptops
  * have this problem).
  */
@@ -924,6 +941,14 @@
 			MATCH(DMI_PRODUCT_NAME, "ProLiant ML350 G3"),
 			NO_MATCH, NO_MATCH }},
 
+#ifdef CONFIG_SERIO_I8042
+	{ set_8042_nomux, "Compaq Proliant 8500", {
+			MATCH(DMI_SYS_VENDOR, "Compaq"),
+			MATCH(DMI_PRODUCT_NAME , "ProLiant"),
+			MATCH(DMI_PRODUCT_VERSION, "8500"),
+			NO_MATCH }},
+#endif
+
 	{ force_acpi_ht, "Compaq Workstation W8000", {
 			MATCH(DMI_SYS_VENDOR, "Compaq"),
 			MATCH(DMI_PRODUCT_NAME, "Workstation W8000"),
--- linux-2.6.6/drivers/input/serio/i8042.c.hp8500	2004-05-25 16:37:03.819529856 -0400
+++ linux-2.6.6/drivers/input/serio/i8042.c	2004-05-25 16:37:54.117883344 -0400
@@ -32,7 +32,7 @@
 module_param_named(noaux, i8042_noaux, bool, 0);
 MODULE_PARM_DESC(noaux, "Do not probe or use AUX (mouse) port.");
 
-static unsigned int i8042_nomux;
+unsigned int i8042_nomux;
 module_param_named(nomux, i8042_nomux, bool, 0);
 MODULE_PARM_DESC(nomux, "Do not check whether an active multiplexing conrtoller is present.");
 


