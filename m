Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267443AbTAGU1F>; Tue, 7 Jan 2003 15:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267449AbTAGU1F>; Tue, 7 Jan 2003 15:27:05 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:45737 "HELO atlrel9.hp.com")
	by vger.kernel.org with SMTP id <S267443AbTAGU1D>;
	Tue, 7 Jan 2003 15:27:03 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: [PATCH] AGP 1/7: factor device command updates
Date: Tue, 7 Jan 2003 13:35:36 -0700
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, davidm@hpl.hp.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200301071335.36360.bjorn_helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a series of minor AGP cleanups for 2.5.  The point of
doing these is to reduce all the code duplication in the agp_enable
functions.  The next step will be to wean hp-agp from its dependence
on "fake PCI devices," which requires a new agp_enable function, and
I didn't have the stomach to copy-n-paste all the stuff in there again.

Summary:
    1:  factor device command updates
    2:  fix old pci_find_capability merge botch
    3:  remove unused var in amd-k8-agp.c
    4:  add generic print of AGP version & mode when programming devices
    5:  factor device capability collection
    6:  use PCI_AGP_* constants
    7:  use pci_find_capability in sworks-agp.c

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.971   -> 1.972  
#	drivers/char/agp/generic.c	1.10    -> 1.11   
#	drivers/char/agp/sworks-agp.c	1.12    -> 1.13   
#	drivers/char/agp/amd-k8-agp.c	1.15    -> 1.16   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/01/07	bjorn_helgaas@hp.com	1.972
# Factor out updating AGP device command registers.
# --------------------------------------------
#
diff -Nru a/drivers/char/agp/amd-k8-agp.c b/drivers/char/agp/amd-k8-agp.c
--- a/drivers/char/agp/amd-k8-agp.c	Tue Jan  7 12:51:49 2003
+++ b/drivers/char/agp/amd-k8-agp.c	Tue Jan  7 12:51:49 2003
@@ -435,11 +435,7 @@
 	 *        command registers.
 	 */
 
-	pci_for_each_dev(device) {
-		cap_ptr = pci_find_capability(device, PCI_CAP_ID_AGP);
-		if (cap_ptr != 0x00)
-			pci_write_config_dword(device, cap_ptr + 8, command);
-	}
+	agp_device_command(command);
 }
 
 
diff -Nru a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
--- a/drivers/char/agp/generic.c	Tue Jan  7 12:51:49 2003
+++ b/drivers/char/agp/generic.c	Tue Jan  7 12:51:49 2003
@@ -313,6 +313,20 @@
 
 
 /* Generic Agp routines - Start */
+
+void agp_device_command(u32 command)
+{
+	struct pci_dev *device;
+
+	pci_for_each_dev(device) {
+		u8 agp = pci_find_capability(device, PCI_CAP_ID_AGP);
+		if (!agp)
+			continue;
+
+		pci_write_config_dword(device, agp + 8, command);
+	}
+}
+
 void agp_generic_agp_enable(u32 mode)
 {
 	struct pci_dev *device = NULL;
@@ -395,11 +409,7 @@
 	 *        command registers.
 	 */
 
-	pci_for_each_dev(device) {
-		cap_ptr = pci_find_capability(device, PCI_CAP_ID_AGP);
-		if (cap_ptr != 0x00)
-			pci_write_config_dword(device, cap_ptr + 8, command);
-	}
+	agp_device_command(command);
 }
 
 int agp_generic_create_gatt_table(void)
diff -Nru a/drivers/char/agp/sworks-agp.c b/drivers/char/agp/sworks-agp.c
--- a/drivers/char/agp/sworks-agp.c	Tue Jan  7 12:51:49 2003
+++ b/drivers/char/agp/sworks-agp.c	Tue Jan  7 12:51:49 2003
@@ -506,11 +506,7 @@
 	 *        command registers.
 	 */
 
-	pci_for_each_dev(device) {
-		cap_ptr = pci_find_capability(device, PCI_CAP_ID_AGP);
-		if (cap_ptr != 0x00)
-			pci_write_config_dword(device, cap_ptr + 8, command);
-	}
+	agp_device_command(command);
 }
 
 static int __init serverworks_setup (struct pci_dev *pdev)

