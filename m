Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWKGLmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWKGLmi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 06:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWKGLmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 06:42:38 -0500
Received: from nat-132.atmel.no ([80.232.32.132]:26866 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S932126AbWKGLmh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 06:42:37 -0500
Date: Tue, 7 Nov 2006 12:31:06 +0100
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, Andrew Victor <andrew@sanpeople.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [-mm patch 2/4] AVR32: spi/ethernet platform_device update
Message-ID: <20061107123106.69032174@cad-250-152.norway.atmel.com>
In-Reply-To: <20061107122715.3022da2f@cad-250-152.norway.atmel.com>
References: <20061107122507.6f1c6e81@cad-250-152.norway.atmel.com>
	<20061107122715.3022da2f@cad-250-152.norway.atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the spi platform_device definitions match the driver and add
definitions for the second spi controller on at32ap7000. The driver
expects the device name to be "atmel_spi" and the main clock to be
"pclk".

Also add platform_device definitions for the second ethernet controller
on at32ap7000.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/mach-at32ap/at32ap7000.c |   64 ++++++++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 7 deletions(-)

Index: linux-2.6.19-rc4-mm2/arch/avr32/mach-at32ap/at32ap7000.c
===================================================================
--- linux-2.6.19-rc4-mm2.orig/arch/avr32/mach-at32ap/at32ap7000.c	2006-11-07 10:30:59.000000000 +0100
+++ linux-2.6.19-rc4-mm2/arch/avr32/mach-at32ap/at32ap7000.c	2006-11-07 10:46:12.000000000 +0100
@@ -650,6 +650,15 @@ DEFINE_DEV_DATA(macb, 0);
 DEV_CLK(hclk, macb0, hsb, 8);
 DEV_CLK(pclk, macb0, pbb, 6);
 
+static struct eth_platform_data macb1_data;
+static struct resource macb1_resource[] = {
+	PBMEM(0xfff01c00),
+	IRQ(26),
+};
+DEFINE_DEV_DATA(macb, 1);
+DEV_CLK(hclk, macb1, hsb, 9);
+DEV_CLK(pclk, macb1, pbb, 7);
+
 struct platform_device *__init
 at32_add_device_eth(unsigned int id, struct eth_platform_data *data)
 {
@@ -683,6 +692,33 @@ at32_add_device_eth(unsigned int id, str
 		}
 		break;
 
+	case 1:
+		pdev = &macb1_device;
+
+		select_peripheral(PD13, B);	/* TXD0	*/
+		select_peripheral(PD14, B);	/* TXD1	*/
+		select_peripheral(PD11, B);	/* TXEN	*/
+		select_peripheral(PD12, B);	/* TXCK */
+		select_peripheral(PD10, B);	/* RXD0	*/
+		select_peripheral(PD6, B);	/* RXD1	*/
+		select_peripheral(PD5, B);	/* RXER	*/
+		select_peripheral(PD4, B);	/* RXDV	*/
+		select_peripheral(PD3, B);	/* MDC	*/
+		select_peripheral(PD2, B);	/* MDIO	*/
+
+		if (!data->is_rmii) {
+			select_peripheral(PC19, B);	/* COL	*/
+			select_peripheral(PC23, B);	/* CRS	*/
+			select_peripheral(PC26, B);	/* TXER	*/
+			select_peripheral(PC27, B);	/* TXD2	*/
+			select_peripheral(PC28, B);	/* TXD3 */
+			select_peripheral(PC29, B);	/* RXD2	*/
+			select_peripheral(PC30, B);	/* RXD3	*/
+			select_peripheral(PC24, B);	/* RXCK	*/
+			select_peripheral(PD15, B);	/* SPD	*/
+		}
+		break;
+
 	default:
 		return NULL;
 	}
@@ -700,8 +736,15 @@ static struct resource atmel_spi0_resour
 	PBMEM(0xffe00000),
 	IRQ(3),
 };
-DEFINE_DEV(spi, 0);
-DEV_CLK(mck, spi0, pba, 0);
+DEFINE_DEV(atmel_spi, 0);
+DEV_CLK(pclk, atmel_spi0, pba, 0);
+
+static struct resource atmel_spi1_resource[] = {
+	PBMEM(0xffe00400),
+	IRQ(4),
+};
+DEFINE_DEV(atmel_spi, 1);
+DEV_CLK(pclk, atmel_spi1, pba, 1);
 
 struct platform_device *__init
 at32_add_device_spi(unsigned int id)
@@ -711,13 +754,17 @@ at32_add_device_spi(unsigned int id)
 
 	switch (id) {
 	case 0:
-		pdev = &spi0_device;
+		pdev = &atmel_spi0_device;
 		select_peripheral(PA0, A);	/* MISO	 */
 		select_peripheral(PA1, A);	/* MOSI	 */
 		select_peripheral(PA2, A);	/* SCK	 */
-		select_peripheral(PA3, A);	/* NPCS0 */
-		select_peripheral(PA4, A);	/* NPCS1 */
-		select_peripheral(PA5, A);	/* NPCS2 */
+		break;
+
+	case 1:
+		pdev = &atmel_spi1_device;
+		select_peripheral(PB0, B);	/* MISO	 */
+		select_peripheral(PB1, B);	/* MOSI	 */
+		select_peripheral(PB5, B);	/* SCK	 */
 		break;
 
 	default:
@@ -836,7 +883,10 @@ struct clk *at32_clock_list[] = {
 	&atmel_usart3_usart,
 	&macb0_hclk,
 	&macb0_pclk,
-	&spi0_mck,
+	&macb1_hclk,
+	&macb1_pclk,
+	&atmel_spi0_pclk,
+	&atmel_spi1_pclk,
 	&lcdc0_hclk,
 	&lcdc0_pixclk,
 };
