Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422660AbWKHToJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422660AbWKHToJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 14:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422690AbWKHToI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 14:44:08 -0500
Received: from nat-132.atmel.no ([80.232.32.132]:49871 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1422660AbWKHToF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 14:44:05 -0500
Date: Wed, 8 Nov 2006 20:37:29 +0100
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrew Victor <andrew@sanpeople.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [-mm patch 2/2] [AVR32] Remove mii_phy_addr and eth_addr from
 eth_platform_data
Message-ID: <20061108203729.67b85fc1@cad-250-152.norway.atmel.com>
In-Reply-To: <20061108203643.470c2231@cad-250-152.norway.atmel.com>
References: <20061108203358.558c28d3@cad-250-152.norway.atmel.com>
	<20061108203643.470c2231@cad-250-152.norway.atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The macb driver will probe for the PHY chip and read the mac address
from the MACB registers, so we don't need them in eth_platform_data
anymore.

Since u-boot doesn't currently initialize the MACB registers with the
mac addresses, the tag parsing code is kept but instead of sticking
the information into eth_platform_data, it uses it to initialize
the MACB registers (in case the boot loader didn't do it.) This code
should be unnecessary at some point in the future.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/boards/atstk1000/atstk1002.c |   65 ++++++++++++++++++++++++++++----
 include/asm-avr32/arch-at32ap/board.h   |    3 -
 2 files changed, 57 insertions(+), 11 deletions(-)

Index: linux-2.6.19-rc5-mm1/arch/avr32/boards/atstk1000/atstk1002.c
===================================================================
--- linux-2.6.19-rc5-mm1.orig/arch/avr32/boards/atstk1000/atstk1002.c	2006-11-08 18:12:13.000000000 +0100
+++ linux-2.6.19-rc5-mm1/arch/avr32/boards/atstk1000/atstk1002.c	2006-11-08 20:09:46.000000000 +0100
@@ -7,13 +7,17 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/clk.h>
 #include <linux/device.h>
+#include <linux/etherdevice.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/platform_device.h>
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/spi/spi.h>
 
+#include <asm/io.h>
 #include <asm/setup.h>
 #include <asm/arch/at32ap7000.h>
 #include <asm/arch/board.h>
@@ -36,24 +40,70 @@ static struct spi_board_info spi_board_i
 	},
 };
 
+struct eth_addr {
+	u8 addr[6];
+};
+
+static struct eth_addr __initdata hw_addr[2];
+
 struct eth_platform_data __initdata eth_data[2];
 extern struct lcdc_platform_data atstk1000_fb0_data;
 
+/*
+ * The next two functions should go away as the boot loader is
+ * supposed to initialize the macb address registers with a valid
+ * ethernet address. But we need to keep it around for a while until
+ * we can be reasonably sure the boot loader does this.
+ *
+ * The phy_id is ignored as the driver will probe for it.
+ */
 static int __init parse_tag_ethernet(struct tag *tag)
 {
 	int i;
 
 	i = tag->u.ethernet.mac_index;
-	if (i < ARRAY_SIZE(eth_data)) {
-		eth_data[i].mii_phy_addr = tag->u.ethernet.mii_phy_addr;
-		memcpy(&eth_data[i].hw_addr, tag->u.ethernet.hw_address,
-		       sizeof(eth_data[i].hw_addr));
-		eth_data[i].valid = 1;
-	}
+	if (i < ARRAY_SIZE(hw_addr))
+		memcpy(hw_addr[i].addr, tag->u.ethernet.hw_address,
+		       sizeof(hw_addr[i].addr));
+
 	return 0;
 }
 __tagtable(ATAG_ETHERNET, parse_tag_ethernet);
 
+static void __init set_hw_addr(struct platform_device *pdev)
+{
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	const u8 *addr;
+	void __iomem *regs;
+	struct clk *pclk;
+
+	if (!res)
+		return;
+	if (pdev->id >= ARRAY_SIZE(hw_addr))
+		return;
+
+	addr = hw_addr[pdev->id].addr;
+	if (!is_valid_ether_addr(addr))
+		return;
+
+	/*
+	 * Since this is board-specific code, we'll cheat and use the
+	 * physical address directly as we happen to know that it's
+	 * the same as the virtual address.
+	 */
+	regs = (void __iomem __force *)res->start;
+	pclk = clk_get(&pdev->dev, "pclk");
+	if (!pclk)
+		return;
+
+	clk_enable(pclk);
+	__raw_writel((addr[3] << 24) | (addr[2] << 16)
+		     | (addr[1] << 8) | addr[0], regs + 0x98);
+	__raw_writel((addr[5] << 8) | addr[4], regs + 0x9c);
+	clk_disable(pclk);
+	clk_put(pclk);
+}
+
 void __init setup_board(void)
 {
 	at32_map_usart(1, 0);	/* /dev/ttyS0 */
@@ -71,8 +121,7 @@ static int __init atstk1002_init(void)
 	at32_add_device_usart(1);
 	at32_add_device_usart(2);
 
-	if (eth_data[0].valid)
-		at32_add_device_eth(0, &eth_data[0]);
+	set_hw_addr(at32_add_device_eth(0, &eth_data[0]));
 
 	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
 	at32_add_device_spi(0);
Index: linux-2.6.19-rc5-mm1/include/asm-avr32/arch-at32ap/board.h
===================================================================
--- linux-2.6.19-rc5-mm1.orig/include/asm-avr32/arch-at32ap/board.h	2006-11-08 18:10:35.000000000 +0100
+++ linux-2.6.19-rc5-mm1/include/asm-avr32/arch-at32ap/board.h	2006-11-08 20:05:15.000000000 +0100
@@ -21,10 +21,7 @@ void at32_map_usart(unsigned int hw_id, 
 struct platform_device *at32_add_device_usart(unsigned int id);
 
 struct eth_platform_data {
-	u8	valid;
-	u8	mii_phy_addr;
 	u8	is_rmii;
-	u8	hw_addr[6];
 };
 struct platform_device *
 at32_add_device_eth(unsigned int id, struct eth_platform_data *data);
