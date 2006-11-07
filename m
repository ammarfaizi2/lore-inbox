Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbWKGN7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWKGN7G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 08:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753876AbWKGN7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 08:59:06 -0500
Received: from nat-132.atmel.no ([80.232.32.132]:4822 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1753863AbWKGN7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 08:59:03 -0500
Date: Tue, 7 Nov 2006 14:51:32 +0100
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrew Victor <andrew@sanpeople.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [-mm patch 1/3] AVR32: Move ethernet tag parsing to board-specific
 code
Message-ID: <20061107145132.4686ba5e@cad-250-152.norway.atmel.com>
In-Reply-To: <20061107144942.25c2db42@cad-250-152.norway.atmel.com>
References: <20061107144942.25c2db42@cad-250-152.norway.atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By moving the ethernet tag parsing to the board-specific code we avoid
the issue of figuring out which device we're supposed to attach the
information to.  The board specific code knows this because it's
where the actual devices are instantiated.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/boards/atstk1000/atstk1002.c |   30 ++++++++++++++++++++++--------
 arch/avr32/kernel/setup.c               |   24 ------------------------
 2 files changed, 22 insertions(+), 32 deletions(-)

Index: linux-2.6.19-rc4-mm2/arch/avr32/boards/atstk1000/atstk1002.c
===================================================================
--- linux-2.6.19-rc4-mm2.orig/arch/avr32/boards/atstk1000/atstk1002.c	2006-11-07 14:01:46.000000000 +0100
+++ linux-2.6.19-rc4-mm2/arch/avr32/boards/atstk1000/atstk1002.c	2006-11-07 14:13:56.000000000 +0100
@@ -9,8 +9,12 @@
  */
 #include <linux/device.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/types.h>
 #include <linux/spi/spi.h>
 
+#include <asm/setup.h>
 #include <asm/arch/at32ap7000.h>
 #include <asm/arch/board.h>
 #include <asm/arch/init.h>
@@ -25,15 +29,24 @@ static struct spi_board_info spi_board_i
 	},
 };
 
-struct eth_platform_data __initdata eth0_data = {
-	.valid		= 1,
-	.mii_phy_addr	= 0x10,
-	.is_rmii	= 0,
-	.hw_addr	= { 0x6a, 0x87, 0x71, 0x14, 0xcd, 0xcb },
-};
-
+struct eth_platform_data __initdata eth_data[2];
 extern struct lcdc_platform_data atstk1000_fb0_data;
 
+static int __init parse_tag_ethernet(struct tag *tag)
+{
+	int i;
+
+	i = tag->u.ethernet.mac_index;
+	if (i < ARRAY_SIZE(eth_data)) {
+		eth_data[i].mii_phy_addr = tag->u.ethernet.mii_phy_addr;
+		memcpy(&eth_data[i].hw_addr, tag->u.ethernet.hw_address,
+		       sizeof(eth_data[i].hw_addr));
+		eth_data[i].valid = 1;
+	}
+	return 0;
+}
+__tagtable(ATAG_ETHERNET, parse_tag_ethernet);
+
 void __init setup_board(void)
 {
 	at32_map_usart(1, 0);	/* /dev/ttyS0 */
@@ -51,7 +64,8 @@ static int __init atstk1002_init(void)
 	at32_add_device_usart(1);
 	at32_add_device_usart(2);
 
-	at32_add_device_eth(0, &eth0_data);
+	if (eth_data[0].valid)
+		at32_add_device_eth(0, &eth_data[0]);
 
 	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
 	at32_add_device_spi(0);
Index: linux-2.6.19-rc4-mm2/arch/avr32/kernel/setup.c
===================================================================
--- linux-2.6.19-rc4-mm2.orig/arch/avr32/kernel/setup.c	2006-11-07 11:29:15.000000000 +0100
+++ linux-2.6.19-rc4-mm2/arch/avr32/kernel/setup.c	2006-11-07 14:11:41.000000000 +0100
@@ -229,30 +229,6 @@ static int __init parse_tag_rsvd_mem(str
 }
 __tagtable(ATAG_RSVD_MEM, parse_tag_rsvd_mem);
 
-static int __init parse_tag_ethernet(struct tag *tag)
-{
-#if 0
-	const struct platform_device *pdev;
-
-	/*
-	 * We really need a bus type that supports "classes"...this
-	 * will do for now (until we must handle other kinds of
-	 * ethernet controllers)
-	 */
-	pdev = platform_get_device("macb", tag->u.ethernet.mac_index);
-	if (pdev && pdev->dev.platform_data) {
-		struct eth_platform_data *data = pdev->dev.platform_data;
-
-		data->valid = 1;
-		data->mii_phy_addr = tag->u.ethernet.mii_phy_addr;
-		memcpy(data->hw_addr, tag->u.ethernet.hw_address,
-		       sizeof(data->hw_addr));
-	}
-#endif
-	return 0;
-}
-__tagtable(ATAG_ETHERNET, parse_tag_ethernet);
-
 /*
  * Scan the tag table for this tag, and call its parse function. The
  * tag table is built by the linker from all the __tagtable
