Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbTDVMD7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 08:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbTDVMD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 08:03:59 -0400
Received: from hera.cwi.nl ([192.16.191.8]:15037 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261246AbTDVMD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 08:03:57 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 22 Apr 2003 14:16:02 +0200 (MEST)
Message-Id: <UTC200304221216.h3MCG2421837.aeb@smtp.cwi.nl>
To: jgarzik@pobox.com
Subject: [PATCH] warning fix e100_main.c
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/e100/e100_main.c:4176: warning: `e100_asf_enabled' defined but not used

Since e100_asf_enabled is used only inside #ifdef CONFIG_PM
this patch moves its definition also inside.

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/net/e100/e100_main.c b/drivers/net/e100/e100_main.c
--- a/drivers/net/e100/e100_main.c	Sun Apr 20 12:59:32 2003
+++ b/drivers/net/e100/e100_main.c	Tue Apr 22 14:11:57 2003
@@ -228,7 +228,6 @@
 				 char *);
 unsigned char e100_wait_exec_cmplx(struct e100_private *, u32, u8, u8);
 void e100_exec_cmplx(struct e100_private *, u32, u8);
-static unsigned char e100_asf_enabled(struct e100_private *bdp);
 
 /**
  * e100_get_rx_struct - retrieve cell to hold skb buff from the pool
@@ -4102,6 +4101,31 @@
 }
 
 #ifdef CONFIG_PM
+/**
+ * e100_asf_enabled - checks if ASF is configured on the current adaper
+ *                    by reading registers 0xD and 0x90 in the EEPROM 
+ * @bdp: atapter's private data struct
+ *
+ * Returns: true if ASF is enabled
+ */
+static unsigned char
+e100_asf_enabled(struct e100_private *bdp)
+{
+	u16 asf_reg;
+	u16 smbus_addr_reg;
+	if ((bdp->pdev->device >= 0x1050) && (bdp->pdev->device <= 0x1055)) {
+		asf_reg = e100_eeprom_read(bdp, EEPROM_CONFIG_ASF);
+		if ((asf_reg & EEPROM_FLAG_ASF)
+		    && !(asf_reg & EEPROM_FLAG_GCL)) {
+			smbus_addr_reg = 
+				e100_eeprom_read(bdp, EEPROM_SMBUS_ADDR);
+			if ((smbus_addr_reg & 0xFF) != 0xFE) 
+				return true;
+		}
+	}
+	return false;
+}
+
 static int
 e100_notify_reboot(struct notifier_block *nb, unsigned long event, void *p)
 {
@@ -4164,31 +4188,6 @@
 }
 #endif /* CONFIG_PM */
 
-/**
- * e100_asf_enabled - checks if ASF is configured on the current adaper
- *                    by reading registers 0xD and 0x90 in the EEPROM 
- * @bdp: atapter's private data struct
- *
- * Returns: true if ASF is enabled
- */
-static unsigned char
-e100_asf_enabled(struct e100_private *bdp)
-{
-	u16 asf_reg;
-	u16 smbus_addr_reg;
-	if ((bdp->pdev->device >= 0x1050) && (bdp->pdev->device <= 0x1055)) {
-		asf_reg = e100_eeprom_read(bdp, EEPROM_CONFIG_ASF);
-		if ((asf_reg & EEPROM_FLAG_ASF)
-		    && !(asf_reg & EEPROM_FLAG_GCL)) {
-			smbus_addr_reg = 
-				e100_eeprom_read(bdp, EEPROM_SMBUS_ADDR);
-			if ((smbus_addr_reg & 0xFF) != 0xFE) 
-				return true;
-		}
-	}
-	return false;
-}
-
 #ifdef E100_CU_DEBUG
 unsigned char
 e100_cu_unknown_state(struct e100_private *bdp)
