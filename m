Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267484AbTAGUa6>; Tue, 7 Jan 2003 15:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267487AbTAGUay>; Tue, 7 Jan 2003 15:30:54 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:48299 "HELO atlrel9.hp.com")
	by vger.kernel.org with SMTP id <S267484AbTAGUa3>;
	Tue, 7 Jan 2003 15:30:29 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: [PATCH] AGP 5/7: factor device capability collection
Date: Tue, 7 Jan 2003 13:39:07 -0700
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200301071339.07973.bjorn_helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.975   -> 1.976  
#	drivers/char/agp/generic.c	1.12    -> 1.13   
#	drivers/char/agp/sworks-agp.c	1.15    -> 1.16   
#	drivers/char/agp/amd-k8-agp.c	1.18    -> 1.19   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/01/07	bjorn_helgaas@hp.com	1.976
# Factor out collecting status of all AGP devices.
# --------------------------------------------
#
diff -Nru a/drivers/char/agp/amd-k8-agp.c b/drivers/char/agp/amd-k8-agp.c
--- a/drivers/char/agp/amd-k8-agp.c	Tue Jan  7 12:52:37 2003
+++ b/drivers/char/agp/amd-k8-agp.c	Tue Jan  7 12:52:37 2003
@@ -370,61 +370,10 @@
 
 	pci_read_config_dword(agp_bridge.dev, agp_bridge.capndx+4, &command);
 
-	/*
-	 * PASS2: go through all devices that claim to be
-	 *        AGP devices and collect their data.
-	 */
-
-	pci_for_each_dev(device) {
-		cap_ptr = pci_find_capability(device, PCI_CAP_ID_AGP);
-		if (cap_ptr != 0x00) {
-			/*
-			 * Ok, here we have a AGP device. Disable impossible 
-			 * settings, and adjust the readqueue to the minimum.
-			 */
-			pci_read_config_dword(device, cap_ptr + 4, &scratch);
-
-			/* adjust RQ depth */
-			command =
-			    ((command & ~0xff000000) |
-			     min_t(u32, (mode & 0xff000000),
-				 min_t(u32, (command & 0xff000000),
-				     (scratch & 0xff000000))));
-
-			/* disable SBA if it's not supported */
-			if (!((command & 0x200) && (scratch & 0x200) && (mode & 0x200)))
-				command &= ~0x200;
-
-			/* disable FW if it's not supported */
-			if (!((command & 0x10) && (scratch & 0x10) && (mode & 0x10)))
-				command &= ~0x10;
-
-			if (!((command & 2) && (scratch & 2) && (mode & 2)))
-				command &= ~2;		/* 8x */
-
-			if (!((command & 1) && (scratch & 1) && (mode & 1)))
-				command &= ~1;		/* 4x */
-		}
-	}
-	/*
-	 * PASS3: Figure out the 8X/4X setting and enable the
-	 *        target (our motherboard chipset).
-	 */
-
-	if (command & 2)
-		command &= ~5;	/* 8X */
-
-	if (command & 1)
-		command &= ~6;	/* 4X */
-
+	command = agp_collect_device_status(mode, command);
 	command |= 0x100;
 
 	pci_write_config_dword(agp_bridge.dev, agp_bridge.capndx+8, command);
-
-	/*
-	 * PASS4: Go through all AGP devices and update the
-	 *        command registers.
-	 */
 
 	agp_device_command(command, 1);
 }
diff -Nru a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
--- a/drivers/char/agp/generic.c	Tue Jan  7 12:52:37 2003
+++ b/drivers/char/agp/generic.c	Tue Jan  7 12:52:37 2003
@@ -314,6 +314,69 @@
 
 /* Generic Agp routines - Start */
 
+u32 agp_collect_device_status(u32 mode, u32 command)
+{
+	struct pci_dev *device;
+	u8 agp;
+	u32 scratch; 
+
+	pci_for_each_dev(device) {
+		agp = pci_find_capability(device, PCI_CAP_ID_AGP);
+		if (!agp)
+			continue;
+
+		/*
+		 * Ok, here we have a AGP device. Disable impossible 
+		 * settings, and adjust the readqueue to the minimum.
+		 */
+		pci_read_config_dword(device, agp + 4, &scratch);
+
+		/* adjust RQ depth */
+		command = ((command & ~0xff000000) |
+		     min_t(u32, (mode & 0xff000000),
+			 min_t(u32, (command & 0xff000000),
+			     (scratch & 0xff000000))));
+
+		/* disable SBA if it's not supported */
+		if (!((command & 0x00000200) &&
+		      (scratch & 0x00000200) &&
+		      (mode & 0x00000200)))
+			command &= ~0x00000200;
+
+		/* disable FW if it's not supported */
+		if (!((command & 0x00000010) &&
+		      (scratch & 0x00000010) &&
+		      (mode & 0x00000010)))
+			command &= ~0x00000010;
+
+		if (!((command & 4) &&
+		      (scratch & 4) &&
+		      (mode & 4)))
+			command &= ~0x00000004;
+
+		if (!((command & 2) &&
+		      (scratch & 2) &&
+		      (mode & 2)))
+			command &= ~0x00000002;
+
+		if (!((command & 1) &&
+		      (scratch & 1) &&
+		      (mode & 1)))
+			command &= ~0x00000001;
+	}
+
+	if (command & 4)
+		command &= ~3;	/* 4X */
+
+	if (command & 2)
+		command &= ~5;	/* 2X (8X for AGP3.0) */
+
+	if (command & 1)
+		command &= ~6;	/* 1X (4X for AGP3.0) */
+
+	return command;
+}
+
 void agp_device_command(u32 command, int agp_v3)
 {
 	struct pci_dev *device;
@@ -336,85 +399,16 @@
 
 void agp_generic_agp_enable(u32 mode)
 {
-	struct pci_dev *device = NULL;
-	u32 command, scratch; 
-	u8 cap_ptr;
+	u32 command;
 
 	pci_read_config_dword(agp_bridge.dev, agp_bridge.capndx + 4, &command);
 
-	/*
-	 * PASS1: go through all devices that claim to be
-	 *        AGP devices and collect their data.
-	 */
-
-	pci_for_each_dev(device) {
-		cap_ptr = pci_find_capability(device, PCI_CAP_ID_AGP);
-		if (cap_ptr != 0x00) {
-			/*
-			 * Ok, here we have a AGP device. Disable impossible 
-			 * settings, and adjust the readqueue to the minimum.
-			 */
-
-			pci_read_config_dword(device, cap_ptr + 4, &scratch);
-
-			/* adjust RQ depth */
-			command = ((command & ~0xff000000) |
-			     min_t(u32, (mode & 0xff000000),
-				 min_t(u32, (command & 0xff000000),
-				     (scratch & 0xff000000))));
-
-			/* disable SBA if it's not supported */
-			if (!((command & 0x00000200) &&
-			      (scratch & 0x00000200) &&
-			      (mode & 0x00000200)))
-				command &= ~0x00000200;
-
-			/* disable FW if it's not supported */
-			if (!((command & 0x00000010) &&
-			      (scratch & 0x00000010) &&
-			      (mode & 0x00000010)))
-				command &= ~0x00000010;
-
-			if (!((command & 4) &&
-			      (scratch & 4) &&
-			      (mode & 4)))
-				command &= ~0x00000004;
-
-			if (!((command & 2) &&
-			      (scratch & 2) &&
-			      (mode & 2)))
-				command &= ~0x00000002;
-
-			if (!((command & 1) &&
-			      (scratch & 1) &&
-			      (mode & 1)))
-				command &= ~0x00000001;
-		}
-	}
-	/*
-	 * PASS2: Figure out the 4X/2X/1X setting and enable the
-	 *        target (our motherboard chipset).
-	 */
-
-	if (command & 4)
-		command &= ~3;	/* 4X */
-
-	if (command & 2)
-		command &= ~5;	/* 2X */
-
-	if (command & 1)
-		command &= ~6;	/* 1X */
-
-	command |= 0x00000100;
+	command = agp_collect_device_status(mode, command);
+	command |= 0x100;
 
 	pci_write_config_dword(agp_bridge.dev,
 			       agp_bridge.capndx + 8,
 			       command);
-
-	/*
-	 * PASS3: Go throu all AGP devices and update the
-	 *        command registers.
-	 */
 
 	agp_device_command(command, 0);
 }
diff -Nru a/drivers/char/agp/sworks-agp.c b/drivers/char/agp/sworks-agp.c
--- a/drivers/char/agp/sworks-agp.c	Tue Jan  7 12:52:37 2003
+++ b/drivers/char/agp/sworks-agp.c	Tue Jan  7 12:52:37 2003
@@ -413,88 +413,22 @@
 
 static void serverworks_agp_enable(u32 mode)
 {
-	struct pci_dev *device = NULL;
-	u32 command, scratch, cap_id;
-	u8 cap_ptr;
+	u32 command;
 
 	pci_read_config_dword(serverworks_private.svrwrks_dev,
 			      agp_bridge.capndx + 4,
 			      &command);
 
-	/*
-	 * PASS1: go throu all devices that claim to be
-	 *        AGP devices and collect their data.
-	 */
+	command = agp_collect_device_status(mode, command);
 
+	command &= ~0x10;	/* disable FW */
+	command &= ~0x08;
 
-	pci_for_each_dev(device) {
-		cap_ptr = pci_find_capability(device, PCI_CAP_ID_AGP);
-		if (cap_ptr != 0x00) {
-			/*
-			 * Ok, here we have a AGP device. Disable impossible 
-			 * settings, and adjust the readqueue to the minimum.
-			 */
-
-			pci_read_config_dword(device, cap_ptr + 4, &scratch);
-
-			/* adjust RQ depth */
-			command =
-			    ((command & ~0xff000000) |
-			     min_t(u32, (mode & 0xff000000),
-				 min_t(u32, (command & 0xff000000),
-				     (scratch & 0xff000000))));
-
-			/* disable SBA if it's not supported */
-			if (!((command & 0x00000200) &&
-			      (scratch & 0x00000200) &&
-			      (mode & 0x00000200)))
-				command &= ~0x00000200;
-
-			/* disable FW */
-			command &= ~0x00000010;
-
-			command &= ~0x00000008;
-
-			if (!((command & 4) &&
-			      (scratch & 4) &&
-			      (mode & 4)))
-				command &= ~0x00000004;
-
-			if (!((command & 2) &&
-			      (scratch & 2) &&
-			      (mode & 2)))
-				command &= ~0x00000002;
-
-			if (!((command & 1) &&
-			      (scratch & 1) &&
-			      (mode & 1)))
-				command &= ~0x00000001;
-		}
-	}
-	/*
-	 * PASS2: Figure out the 4X/2X/1X setting and enable the
-	 *        target (our motherboard chipset).
-	 */
-
-	if (command & 4) {
-		command &= ~3;	/* 4X */
-	}
-	if (command & 2) {
-		command &= ~5;	/* 2X */
-	}
-	if (command & 1) {
-		command &= ~6;	/* 1X */
-	}
-	command |= 0x00000100;
+	command |= 0x100;
 
 	pci_write_config_dword(serverworks_private.svrwrks_dev,
 			       agp_bridge.capndx + 8,
 			       command);
-
-	/*
-	 * PASS3: Go throu all AGP devices and update the
-	 *        command registers.
-	 */
 
 	agp_device_command(command, 0);
 }

