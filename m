Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWJEAaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWJEAaw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 20:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWJEAav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 20:30:51 -0400
Received: from zoot.lnxi.com ([63.145.151.20]:57774 "EHLO zoot.lnxi.com")
	by vger.kernel.org with ESMTP id S1751264AbWJEAau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 20:30:50 -0400
Date: Wed, 4 Oct 2006 18:30:23 -0600
From: Ryan Jackson <rjackson@lnxi.com>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [MTD] MAPS: Add parameter to amd76xrom to override rom window size if set incorrectly by BIOS
Message-ID: <20061005003023.GF3345@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2 bits controlling the window size are often set to allow reading
the BIOS, but too small to allow writing, since the lock registers are
4MB lower in the address space than the data.  This is intended to
prevent flashing the bios, perhaps accidentally.

The bits are 6 and 7.  If both bits are set, it is a 5MB window.
If only the 7 Bit is set, it is a 4MB window.  Otherwise, it is a
64KB window.

This parameter allows the driver to override the BIOS settings.

Signed-off-by: Ryan Jackson <rjackson@lnxi.com>

---
 drivers/mtd/maps/amd76xrom.c |   34 ++++++++++++++++++++++++++++------
 1 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/maps/amd76xrom.c b/drivers/mtd/maps/amd76xrom.c
index 447955b..d439f9d 100644
--- a/drivers/mtd/maps/amd76xrom.c
+++ b/drivers/mtd/maps/amd76xrom.c
@@ -7,6 +7,7 @@
 
 #include <linux/module.h>
 #include <linux/types.h>
+#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <asm/io.h>
@@ -44,6 +45,23 @@ struct amd76xrom_map_info {
 	char map_name[sizeof(MOD_NAME) + 2 + ADDRESS_NAME_LEN];
 };
 
+/* The 2 bits controlling the window size are often set to allow reading
+ * the BIOS, but too small to allow writing, since the lock registers are
+ * 4MB lower in the address space than the data.
+ *
+ * This is intended to prevent flashing the bios, perhaps accidentally.
+ *
+ * This parameter allows the normal driver to over-ride the BIOS settings.
+ *
+ * The bits are 6 and 7.  If both bits are set, it is a 5MB window.
+ * If only the 7 Bit is set, it is a 4MB window.  Otherwise, a
+ * 64KB window.
+ *
+ */
+static uint win_size_bits = 0;
+module_param(win_size_bits, uint, 0);
+MODULE_PARM_DESC(win_size_bits, "ROM window size bits override for 0x43 byte, normally set by BIOS.");
+
 static struct amd76xrom_window amd76xrom_window = {
 	.maps = LIST_HEAD_INIT(amd76xrom_window.maps),
 };
@@ -94,6 +112,16 @@ static int __devinit amd76xrom_init_one 
 	/* Remember the pci dev I find the window in */
 	window->pdev = pdev;
 
+	/* Enable the selected rom window.  This is often incorrectly
+	 * set up by the BIOS, and the 4MB offset for the lock registers
+	 * requires the full 5MB of window space.
+	 *
+	 * This 'write, then read' approach leaves the bits for
+	 * other uses of the hardware info.
+	 */
+	pci_read_config_byte(pdev, 0x43, &byte);
+	pci_write_config_byte(pdev, 0x43, byte | win_size_bits );
+
 	/* Assume the rom window is properly setup, and find it's size */
 	pci_read_config_byte(pdev, 0x43, &byte);
 	if ((byte & ((1<<7)|(1<<6))) == ((1<<7)|(1<<6))) {
@@ -128,12 +156,6 @@ static int __devinit amd76xrom_init_one 
 			(unsigned long long)window->rsrc.end);
 	}
 
-#if 0
-
-	/* Enable the selected rom window */
-	pci_read_config_byte(pdev, 0x43, &byte);
-	pci_write_config_byte(pdev, 0x43, byte | rwindow->segen_bits);
-#endif
 
 	/* Enable writes through the rom window */
 	pci_read_config_byte(pdev, 0x40, &byte);
-- 
1.4.2.1

