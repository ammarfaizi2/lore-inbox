Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161121AbWI1Nck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161121AbWI1Nck (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 09:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161120AbWI1Nbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 09:31:40 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:9207 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751889AbWI1Nbg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 09:31:36 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Victor <andrew@sanpeople.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 1/4] atmel_serial: Pass fixed register mappings through platform_data
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Thu, 28 Sep 2006 15:31:39 +0200
Message-Id: <11594503023213-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.1.1
In-Reply-To: <11594503023218-git-send-email-hskinnemoen@atmel.com>
References: <11594503023218-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order to initialize the serial console early, the atmel_serial
driver had to do a hack where it compared the physical address of the
port with an address known to be permanently mapped, and used it as a
virtual address. This got around the limitation that ioremap() isn't
always available when the console is being initalized.

This patch removes that hack and replaces it with a new "regs" field
in struct atmel_uart_data that the board-specific code can initialize
to a fixed virtual mapping for platform devices where this is possible.
It also initializes the DBGU's regs field with the address the driver
used to check against.

On AVR32, the "regs" field is initialized from the physical base
address when this it can be accessed through a permanently 1:1 mapped
segment, i.e. the P4 segment.

If regs is NULL, the console initialization is delayed until the "real"
driver is up and running and ioremap() can be used.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/arm/mach-at91rm9200/devices.c      |    1 +
 arch/avr32/mach-at32ap/at32ap7000.c     |   33 +++++++++++++++++++++++++------
 drivers/serial/atmel_serial.c           |    5 +++--
 include/asm-arm/arch-at91rm9200/board.h |    1 +
 include/asm-avr32/arch-at32ap/board.h   |    5 +++++
 5 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-at91rm9200/devices.c b/arch/arm/mach-at91rm9200/devices.c
index b8c0344..a4ea616 100644
--- a/arch/arm/mach-at91rm9200/devices.c
+++ b/arch/arm/mach-at91rm9200/devices.c
@@ -561,6 +561,7 @@ static struct resource dbgu_resources[] 
 static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
+	.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91_DBGU),
 };
 
 static struct platform_device at91rm9200_dbgu_device = {
diff --git a/arch/avr32/mach-at32ap/at32ap7000.c b/arch/avr32/mach-at32ap/at32ap7000.c
index 05d1296..3dd3058 100644
--- a/arch/avr32/mach-at32ap/at32ap7000.c
+++ b/arch/avr32/mach-at32ap/at32ap7000.c
@@ -523,32 +523,48 @@ void __init at32_add_system_devices(void
  *  USART
  * -------------------------------------------------------------------- */
 
+static struct atmel_uart_data atmel_usart0_data = {
+	.use_dma_tx	= 1,
+	.use_dma_rx	= 1,
+};
 static struct resource atmel_usart0_resource[] = {
 	PBMEM(0xffe00c00),
 	IRQ(7),
 };
-DEFINE_DEV(atmel_usart, 0);
+DEFINE_DEV_DATA(atmel_usart, 0);
 DEV_CLK(usart, atmel_usart0, pba, 4);
 
+static struct atmel_uart_data atmel_usart1_data = {
+	.use_dma_tx	= 1,
+	.use_dma_rx	= 1,
+};
 static struct resource atmel_usart1_resource[] = {
 	PBMEM(0xffe01000),
 	IRQ(7),
 };
-DEFINE_DEV(atmel_usart, 1);
+DEFINE_DEV_DATA(atmel_usart, 1);
 DEV_CLK(usart, atmel_usart1, pba, 4);
 
+static struct atmel_uart_data atmel_usart2_data = {
+	.use_dma_tx	= 1,
+	.use_dma_rx	= 1,
+};
 static struct resource atmel_usart2_resource[] = {
 	PBMEM(0xffe01400),
 	IRQ(8),
 };
-DEFINE_DEV(atmel_usart, 2);
+DEFINE_DEV_DATA(atmel_usart, 2);
 DEV_CLK(usart, atmel_usart2, pba, 5);
 
+static struct atmel_uart_data atmel_usart3_data = {
+	.use_dma_tx	= 1,
+	.use_dma_rx	= 1,
+};
 static struct resource atmel_usart3_resource[] = {
 	PBMEM(0xffe01800),
 	IRQ(9),
 };
-DEFINE_DEV(atmel_usart, 3);
+DEFINE_DEV_DATA(atmel_usart, 3);
 DEV_CLK(usart, atmel_usart3, pba, 6);
 
 static inline void configure_usart0_pins(void)
@@ -597,8 +613,13 @@ static struct platform_device *setup_usa
 		configure_usart3_pins();
 		break;
 	default:
-		pdev = NULL;
-		break;
+		return NULL;
+	}
+
+	if (PXSEG(pdev->resource[0].start) == P4SEG) {
+		/* Addresses in the P4 segment are permanently mapped 1:1 */
+		struct atmel_uart_data *data = pdev->dev.platform_data;
+		data->regs = (void __iomem *)pdev->resource[0].start;
 	}
 
 	return pdev;
diff --git a/drivers/serial/atmel_serial.c b/drivers/serial/atmel_serial.c
index 4625541..8fff85c 100644
--- a/drivers/serial/atmel_serial.c
+++ b/drivers/serial/atmel_serial.c
@@ -694,8 +694,9 @@ static void __devinit atmel_init_port(st
 	port->mapbase	= pdev->resource[0].start;
 	port->irq	= pdev->resource[1].start;
 
-	if (port->mapbase == AT91_VA_BASE_SYS + AT91_DBGU)		/* Part of system perpherals - already mapped */
-		port->membase = (void __iomem *) port->mapbase;
+	if (data->regs)
+		/* Already mapped by setup code */
+		port->membase = data->regs;
 	else {
 		port->flags	|= UPF_IOREMAP;
 		port->membase	= NULL;
diff --git a/include/asm-arm/arch-at91rm9200/board.h b/include/asm-arm/arch-at91rm9200/board.h
index d565270..3cc9aec 100644
--- a/include/asm-arm/arch-at91rm9200/board.h
+++ b/include/asm-arm/arch-at91rm9200/board.h
@@ -103,6 +103,7 @@ extern void __init at91_init_serial(stru
 struct atmel_uart_data {
 	short		use_dma_tx;	/* use transmit DMA? */
 	short		use_dma_rx;	/* use receive DMA? */
+	void __iomem	*regs;		/* virtual base address, if any */
 };
 extern void __init at91_add_device_serial(void);
 
diff --git a/include/asm-avr32/arch-at32ap/board.h b/include/asm-avr32/arch-at32ap/board.h
index 82e5404..4355072 100644
--- a/include/asm-avr32/arch-at32ap/board.h
+++ b/include/asm-avr32/arch-at32ap/board.h
@@ -12,6 +12,11 @@ void at32_add_system_devices(void);
 #define ATMEL_MAX_UART	4
 extern struct platform_device *atmel_default_console_device;
 
+struct atmel_uart_data {
+	short		use_dma_tx;	/* use transmit DMA? */
+	short		use_dma_rx;	/* use receive DMA? */
+	void __iomem	*regs;		/* virtual base address, if any */
+};
 struct platform_device *at32_add_device_usart(unsigned int id);
 
 struct eth_platform_data {
-- 
1.4.1.1

