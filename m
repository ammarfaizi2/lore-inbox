Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266378AbTGEQCl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 12:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266380AbTGEQCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 12:02:41 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:8579
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S266378AbTGEQCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 12:02:39 -0400
Date: Sat, 5 Jul 2003 17:15:55 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307051615.h65GFtxM002809@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: PATCH: CMD640
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch seems to have vanished in the post first time around. It
cleans up the CMD640 logic a little and sorts out the registration bits
Its a requirement to making modular IDE work again

diff --exclude-from /usr/src/exclude -u --recursive linux.22-bk2/drivers/ide/pci/cmd640.c linux.22-pre2-ac1/drivers/ide/pci/cmd640.c
--- linux.22-bk2/drivers/ide/pci/cmd640.c	2003-07-05 16:58:51.000000000 +0100
+++ linux.22-pre2-ac1/drivers/ide/pci/cmd640.c	2003-06-29 16:10:16.000000000 +0100
@@ -102,6 +102,7 @@
 #define CMD640_PREFETCH_MASKS 1
 
 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
@@ -120,7 +121,8 @@
 /*
  * This flag is set in ide.c by the parameter:  ide0=cmd640_vlb
  */
-int cmd640_vlb = 0;
+
+static int cmd640_vlb = 0;
 
 /*
  * CMD640 specific registers definition.
@@ -716,7 +718,7 @@
 /*
  * Probe for a cmd640 chipset, and initialize it if found.  Called from ide.c
  */
-int __init ide_probe_for_cmd640x (void)
+static void __init ide_probe_for_cmd640x (void)
 {
 #ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
 	int second_port_toggled = 0;
@@ -731,13 +733,13 @@
 	} else {
 		cmd640_vlb = 0;
 		/* Find out what kind of PCI probing is supported otherwise
-		   Justin Gibbs will sulk.. */
+		   we break some Adaptec cards...  */
 		if (pci_conf1() && probe_for_cmd640_pci1())
 			bus_type = "PCI (type1)";
 		else if (pci_conf2() && probe_for_cmd640_pci2())
 			bus_type = "PCI (type2)";
 		else
-			return 0;
+			return;
 	}
 	/*
 	 * Undocumented magic (there is no 0x5b reg in specs)
@@ -745,7 +747,7 @@
 	put_cmd640_reg(0x5b, 0xbd);
 	if (get_cmd640_reg(0x5b) != 0xbd) {
 		printk(KERN_ERR "ide: cmd640 init failed: wrong value in reg 0x5b\n");
-		return 0;
+		return;
 	}
 	put_cmd640_reg(0x5b, 0);
 
@@ -760,7 +762,7 @@
 	cmd640_chip_version = cfr & CFR_DEVREV;
 	if (cmd640_chip_version == 0) {
 		printk ("ide: bad cmd640 revision: %d\n", cmd640_chip_version);
-		return 0;
+		return;
 	}
 
 	/*
@@ -874,6 +876,28 @@
 #ifdef CMD640_DUMP_REGS
 	CMD640_DUMP_REGS;
 #endif
-	return 1;
+	return;
+}
+
+static int __init cmd640_init(void)
+{
+	ide_register_driver(ide_probe_for_cmd640x);
+	return 0;
+}
+
+/*
+ *	Called by the IDE core when compiled in and cmd640=vlb is
+ *	selected.
+ */
+void init_cmd640_vlb(void)
+{
+	cmd640_vlb = 1;
 }
 
+module_init(cmd640_init);
+
+MODULE_AUTHOR("See Source");
+MODULE_DESCRIPTION("IDE support for CMD640 controller");
+MODULE_PARM(cmd640_vlb, "i");
+MODULE_PARM_DESC(cmd640_vlb, "Set to enable scanning for VLB controllers");
+MODULE_LICENSE("GPL");
