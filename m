Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261403AbTDBDY4>; Tue, 1 Apr 2003 22:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261401AbTDBDYz>; Tue, 1 Apr 2003 22:24:55 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:16272 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S261400AbTDBDYw>;
	Tue, 1 Apr 2003 22:24:52 -0500
Date: Wed, 2 Apr 2003 13:36:04 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: jgarzik@pobox.com
Cc: akpm@zip.com.au, LKML <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: [PATCH] e100_asf_enabled is only used when CONFIG_PM
Message-Id: <20030402133604.1a7519d5.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Not sure where this needs to be sent. This patch kills a warning
when CONFIG_PM is not set.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.66-040110/drivers/net/e100/e100_main.c 2.5.66-040110-e100/drivers/net/e100/e100_main.c
--- 2.5.66-040110/drivers/net/e100/e100_main.c	2003-04-02 13:35:15.000000000 +1000
+++ 2.5.66-040110-e100/drivers/net/e100/e100_main.c	2003-04-02 13:25:00.000000000 +1000
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
