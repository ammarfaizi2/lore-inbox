Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262044AbVEDHEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbVEDHEM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 03:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbVEDHDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 03:03:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:65508 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262047AbVEDHCW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 03:02:22 -0400
Cc: ssant@in.ibm.com
Subject: [PATCH] PCI: fix up word-aligned 16-bit PCI config access through sysfs
In-Reply-To: <11151901371381@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 May 2005 00:02:17 -0700
Message-Id: <11151901373936@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: fix up word-aligned 16-bit PCI config access through sysfs

This patch adds the possibility to do word-aligned 16-bit atomic PCI
configuration space accesses via the sysfs PCI interface. As a result, problems
with Emulex LFPC on IBM PowerPC64 are fixed.

Patch is present in SLES 9 SP1.

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 4c0619add8c3a8b28e7fae8b15cc7b62de2f8148
tree 2e27d1c516480dd6f3686c05caac09b196475951
parent bc56b9e01190b9f1ad6b7c5c694b61bfe34c7aa5
author ssant@in.ibm.com <ssant@in.ibm.com> 1112939611 +0900
committer Greg KH <gregkh@suse.de> 1115189115 -0700

Index: drivers/pci/pci-sysfs.c
===================================================================
--- 9979aed502d987538c51d9820be9c288462f9996/drivers/pci/pci-sysfs.c  (mode:100644 sha1:d57ae71d32b1dd42a77689498e691263d263c3e4)
+++ 2e27d1c516480dd6f3686c05caac09b196475951/drivers/pci/pci-sysfs.c  (mode:100644 sha1:8568b207f18927f4d4cc23006ff2edf07dc932be)
@@ -91,6 +91,7 @@
 	struct pci_dev *dev = to_pci_dev(container_of(kobj,struct device,kobj));
 	unsigned int size = 64;
 	loff_t init_off = off;
+	u8 *data = (u8*) buf;
 
 	/* Several chips lock up trying to read undefined config space */
 	if (capable(CAP_SYS_ADMIN)) {
@@ -108,30 +109,47 @@
 		size = count;
 	}
 
-	while (off & 3) {
-		unsigned char val;
+	if ((off & 1) && size) {
+		u8 val;
 		pci_read_config_byte(dev, off, &val);
-		buf[off - init_off] = val;
+		data[off - init_off] = val;
 		off++;
-		if (--size == 0)
-			break;
+		size--;
+	}
+
+	if ((off & 3) && size > 2) {
+		u16 val;
+		pci_read_config_word(dev, off, &val);
+		data[off - init_off] = val & 0xff;
+		data[off - init_off + 1] = (val >> 8) & 0xff;
+		off += 2;
+		size -= 2;
 	}
 
 	while (size > 3) {
-		unsigned int val;
+		u32 val;
 		pci_read_config_dword(dev, off, &val);
-		buf[off - init_off] = val & 0xff;
-		buf[off - init_off + 1] = (val >> 8) & 0xff;
-		buf[off - init_off + 2] = (val >> 16) & 0xff;
-		buf[off - init_off + 3] = (val >> 24) & 0xff;
+		data[off - init_off] = val & 0xff;
+		data[off - init_off + 1] = (val >> 8) & 0xff;
+		data[off - init_off + 2] = (val >> 16) & 0xff;
+		data[off - init_off + 3] = (val >> 24) & 0xff;
 		off += 4;
 		size -= 4;
 	}
 
-	while (size > 0) {
-		unsigned char val;
+	if (size >= 2) {
+		u16 val;
+		pci_read_config_word(dev, off, &val);
+		data[off - init_off] = val & 0xff;
+		data[off - init_off + 1] = (val >> 8) & 0xff;
+		off += 2;
+		size -= 2;
+	}
+
+	if (size > 0) {
+		u8 val;
 		pci_read_config_byte(dev, off, &val);
-		buf[off - init_off] = val;
+		data[off - init_off] = val;
 		off++;
 		--size;
 	}
@@ -145,6 +163,7 @@
 	struct pci_dev *dev = to_pci_dev(container_of(kobj,struct device,kobj));
 	unsigned int size = count;
 	loff_t init_off = off;
+	u8 *data = (u8*) buf;
 
 	if (off > dev->cfg_size)
 		return 0;
@@ -152,26 +171,41 @@
 		size = dev->cfg_size - off;
 		count = size;
 	}
-
-	while (off & 3) {
-		pci_write_config_byte(dev, off, buf[off - init_off]);
+	
+	if ((off & 1) && size) {
+		pci_write_config_byte(dev, off, data[off - init_off]);
 		off++;
-		if (--size == 0)
-			break;
+		size--;
 	}
+	
+	if ((off & 3) && size > 2) {
+		u16 val = data[off - init_off];
+		val |= (u16) data[off - init_off + 1] << 8;
+                pci_write_config_word(dev, off, val);
+                off += 2;
+                size -= 2;
+        }
 
 	while (size > 3) {
-		unsigned int val = buf[off - init_off];
-		val |= (unsigned int) buf[off - init_off + 1] << 8;
-		val |= (unsigned int) buf[off - init_off + 2] << 16;
-		val |= (unsigned int) buf[off - init_off + 3] << 24;
+		u32 val = data[off - init_off];
+		val |= (u32) data[off - init_off + 1] << 8;
+		val |= (u32) data[off - init_off + 2] << 16;
+		val |= (u32) data[off - init_off + 3] << 24;
 		pci_write_config_dword(dev, off, val);
 		off += 4;
 		size -= 4;
 	}
+	
+	if (size >= 2) {
+		u16 val = data[off - init_off];
+		val |= (u16) data[off - init_off + 1] << 8;
+		pci_write_config_word(dev, off, val);
+		off += 2;
+		size -= 2;
+	}
 
-	while (size > 0) {
-		pci_write_config_byte(dev, off, buf[off - init_off]);
+	if (size) {
+		pci_write_config_byte(dev, off, data[off - init_off]);
 		off++;
 		--size;
 	}

