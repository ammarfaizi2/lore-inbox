Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267481AbTAGU3o>; Tue, 7 Jan 2003 15:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267484AbTAGU3o>; Tue, 7 Jan 2003 15:29:44 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:52937 "HELO atlrel7.hp.com")
	by vger.kernel.org with SMTP id <S267481AbTAGU3i>;
	Tue, 7 Jan 2003 15:29:38 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: [PATCH] AGP 4/7: add generic print of AGP version & mode
Date: Tue, 7 Jan 2003 13:38:17 -0700
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200301071338.17372.bjorn_helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.974   -> 1.975  
#	drivers/char/agp/generic.c	1.11    -> 1.12   
#	drivers/char/agp/sworks-agp.c	1.14    -> 1.15   
#	drivers/char/agp/amd-k8-agp.c	1.17    -> 1.18   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/01/07	bjorn_helgaas@hp.com	1.975
# Print AGP version & mode when programming devices.
# --------------------------------------------
#
diff -Nru a/drivers/char/agp/amd-k8-agp.c b/drivers/char/agp/amd-k8-agp.c
--- a/drivers/char/agp/amd-k8-agp.c	Tue Jan  7 12:52:25 2003
+++ b/drivers/char/agp/amd-k8-agp.c	Tue Jan  7 12:52:25 2003
@@ -382,9 +382,6 @@
 			 * Ok, here we have a AGP device. Disable impossible 
 			 * settings, and adjust the readqueue to the minimum.
 			 */
-
-			printk (KERN_INFO "AGP: Setting up AGPv3 capable device at %d:%d:%d\n",
-					device->bus->number, PCI_FUNC(device->devfn), PCI_SLOT(device->devfn));
 			pci_read_config_dword(device, cap_ptr + 4, &scratch);
 
 			/* adjust RQ depth */
@@ -402,15 +399,11 @@
 			if (!((command & 0x10) && (scratch & 0x10) && (mode & 0x10)))
 				command &= ~0x10;
 
-			if (!((command & 2) && (scratch & 2) && (mode & 2))) {
+			if (!((command & 2) && (scratch & 2) && (mode & 2)))
 				command &= ~2;		/* 8x */
-				printk (KERN_INFO "AGP: Putting device into 8x mode\n");
-			}
 
-			if (!((command & 1) && (scratch & 1) && (mode & 1))) {
+			if (!((command & 1) && (scratch & 1) && (mode & 1)))
 				command &= ~1;		/* 4x */
-				printk (KERN_INFO "AGP: Putting device into 4x mode\n");
-			}
 		}
 	}
 	/*
@@ -433,7 +426,7 @@
 	 *        command registers.
 	 */
 
-	agp_device_command(command);
+	agp_device_command(command, 1);
 }
 
 
diff -Nru a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
--- a/drivers/char/agp/generic.c	Tue Jan  7 12:52:25 2003
+++ b/drivers/char/agp/generic.c	Tue Jan  7 12:52:25 2003
@@ -314,15 +314,22 @@
 
 /* Generic Agp routines - Start */
 
-void agp_device_command(u32 command)
+void agp_device_command(u32 command, int agp_v3)
 {
 	struct pci_dev *device;
+	int mode;
+
+	mode = command & 0x7;
+	if (agp_v3)
+		mode *= 4;
 
 	pci_for_each_dev(device) {
 		u8 agp = pci_find_capability(device, PCI_CAP_ID_AGP);
 		if (!agp)
 			continue;
 
+		printk(KERN_INFO PFX "Putting AGP V%d device at %s into %dx mode\n",
+				agp_v3 ? 3 : 2, device->slot_name, mode);
 		pci_write_config_dword(device, agp + 8, command);
 	}
 }
@@ -409,7 +416,7 @@
 	 *        command registers.
 	 */
 
-	agp_device_command(command);
+	agp_device_command(command, 0);
 }
 
 int agp_generic_create_gatt_table(void)
diff -Nru a/drivers/char/agp/sworks-agp.c b/drivers/char/agp/sworks-agp.c
--- a/drivers/char/agp/sworks-agp.c	Tue Jan  7 12:52:25 2003
+++ b/drivers/char/agp/sworks-agp.c	Tue Jan  7 12:52:25 2003
@@ -496,7 +496,7 @@
 	 *        command registers.
 	 */
 
-	agp_device_command(command);
+	agp_device_command(command, 0);
 }
 
 static int __init serverworks_setup (struct pci_dev *pdev)

