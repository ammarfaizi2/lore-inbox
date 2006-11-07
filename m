Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWKGLmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWKGLmy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 06:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWKGLmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 06:42:54 -0500
Received: from nat-132.atmel.no ([80.232.32.132]:58871 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S932142AbWKGLmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 06:42:51 -0500
Date: Tue, 7 Nov 2006 12:27:15 +0100
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, Andrew Victor <andrew@sanpeople.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [-mm patch 1/4] GPIO framework for AVR32
Message-ID: <20061107122715.3022da2f@cad-250-152.norway.atmel.com>
In-Reply-To: <20061107122507.6f1c6e81@cad-250-152.norway.atmel.com>
References: <20061107122507.6f1c6e81@cad-250-152.norway.atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple GPIO framework for AVR32. This should be fairly similar
to the AT91 GPIO API, but there are still a couple of differences:

  * Naming. We prefix all functions with gpio_ instead of at91_
  * request_gpio() and free_gpio() should be called to make sure
    the required pins are available, but it will still work if you
    don't.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/mach-at32ap/at32ap7000.c        |  154 ++++++++++++++---------------
 arch/avr32/mach-at32ap/pio.c               |  139 ++++++++++++++++++++++++--
 include/asm-avr32/arch-at32ap/at32ap7000.h |  141 ++++++++++++++++++++++++++
 include/asm-avr32/arch-at32ap/gpio.h       |   14 ++
 include/asm-avr32/arch-at32ap/irq.h        |   11 ++
 include/asm-avr32/arch-at32ap/portmux.h    |   16 ---
 include/asm-avr32/irq.h                    |    8 +
 7 files changed, 380 insertions(+), 103 deletions(-)

Index: linux-2.6.19-rc4-mm2/arch/avr32/mach-at32ap/at32ap7000.c
===================================================================
--- linux-2.6.19-rc4-mm2.orig/arch/avr32/mach-at32ap/at32ap7000.c	2006-11-07 10:26:59.000000000 +0100
+++ linux-2.6.19-rc4-mm2/arch/avr32/mach-at32ap/at32ap7000.c	2006-11-07 10:30:59.000000000 +0100
@@ -11,8 +11,9 @@
 
 #include <asm/io.h>
 
+#include <asm/arch/at32ap7000.h>
 #include <asm/arch/board.h>
-#include <asm/arch/portmux.h>
+#include <asm/arch/gpio.h>
 #include <asm/arch/sm.h>
 
 #include "clock.h"
@@ -67,17 +68,12 @@ static struct clk devname##_##_name = {	
 	.index		= _index,				\
 }
 
-enum {
-	PIOA,
-	PIOB,
-	PIOC,
-	PIOD,
-};
-
-enum {
-	FUNC_A,
-	FUNC_B,
-};
+/*
+ * We call this lots of times, so we want everything to fit in a
+ * single line...
+ */
+#define select_peripheral(pin, func)				\
+	portmux_select_peripheral(GPIO_PIN_##pin, GPIO_PERIPH_##func)
 
 unsigned long at32ap7000_osc_rates[3] = {
 	[0] = 32768,
@@ -569,26 +565,26 @@ DEV_CLK(usart, atmel_usart3, pba, 6);
 
 static inline void configure_usart0_pins(void)
 {
-	portmux_set_func(PIOA,  8, FUNC_B);	/* RXD	*/
-	portmux_set_func(PIOA,  9, FUNC_B);	/* TXD	*/
+	select_peripheral(PA8, B);	/* RXD	*/
+	select_peripheral(PA9, B);	/* TXD	*/
 }
 
 static inline void configure_usart1_pins(void)
 {
-	portmux_set_func(PIOA, 17, FUNC_A);	/* RXD	*/
-	portmux_set_func(PIOA, 18, FUNC_A);	/* TXD	*/
+	select_peripheral(PA17, A);	/* RXD	*/
+	select_peripheral(PA18, A);	/* TXD	*/
 }
 
 static inline void configure_usart2_pins(void)
 {
-	portmux_set_func(PIOB, 26, FUNC_B);	/* RXD	*/
-	portmux_set_func(PIOB, 27, FUNC_B);	/* TXD	*/
+	select_peripheral(PB26, B);	/* RXD	*/
+	select_peripheral(PB27, B);	/* TXD	*/
 }
 
 static inline void configure_usart3_pins(void)
 {
-	portmux_set_func(PIOB, 18, FUNC_B);	/* RXD	*/
-	portmux_set_func(PIOB, 17, FUNC_B);	/* TXD	*/
+	select_peripheral(PB18, B);	/* RXD	*/
+	select_peripheral(PB17, B);	/* TXD	*/
 }
 
 static struct platform_device *at32_usarts[4];
@@ -663,27 +659,27 @@ at32_add_device_eth(unsigned int id, str
 	case 0:
 		pdev = &macb0_device;
 
-		portmux_set_func(PIOC,  3, FUNC_A);	/* TXD0	*/
-		portmux_set_func(PIOC,  4, FUNC_A);	/* TXD1	*/
-		portmux_set_func(PIOC,  7, FUNC_A);	/* TXEN	*/
-		portmux_set_func(PIOC,  8, FUNC_A);	/* TXCK */
-		portmux_set_func(PIOC,  9, FUNC_A);	/* RXD0	*/
-		portmux_set_func(PIOC, 10, FUNC_A);	/* RXD1	*/
-		portmux_set_func(PIOC, 13, FUNC_A);	/* RXER	*/
-		portmux_set_func(PIOC, 15, FUNC_A);	/* RXDV	*/
-		portmux_set_func(PIOC, 16, FUNC_A);	/* MDC	*/
-		portmux_set_func(PIOC, 17, FUNC_A);	/* MDIO	*/
+		select_peripheral(PC3, A);	/* TXD0	*/
+		select_peripheral(PC4, A);	/* TXD1	*/
+		select_peripheral(PC7, A);	/* TXEN	*/
+		select_peripheral(PC8, A);	/* TXCK */
+		select_peripheral(PC9, A);	/* RXD0	*/
+		select_peripheral(PC10, A);	/* RXD1	*/
+		select_peripheral(PC13, A);	/* RXER	*/
+		select_peripheral(PC15, A);	/* RXDV	*/
+		select_peripheral(PC16, A);	/* MDC	*/
+		select_peripheral(PC17, A);	/* MDIO	*/
 
 		if (!data->is_rmii) {
-			portmux_set_func(PIOC,  0, FUNC_A);	/* COL	*/
-			portmux_set_func(PIOC,  1, FUNC_A);	/* CRS	*/
-			portmux_set_func(PIOC,  2, FUNC_A);	/* TXER	*/
-			portmux_set_func(PIOC,  5, FUNC_A);	/* TXD2	*/
-			portmux_set_func(PIOC,  6, FUNC_A);	/* TXD3 */
-			portmux_set_func(PIOC, 11, FUNC_A);	/* RXD2	*/
-			portmux_set_func(PIOC, 12, FUNC_A);	/* RXD3	*/
-			portmux_set_func(PIOC, 14, FUNC_A);	/* RXCK	*/
-			portmux_set_func(PIOC, 18, FUNC_A);	/* SPD	*/
+			select_peripheral(PC0, A);	/* COL	*/
+			select_peripheral(PC1, A);	/* CRS	*/
+			select_peripheral(PC2, A);	/* TXER	*/
+			select_peripheral(PC5, A);	/* TXD2	*/
+			select_peripheral(PC6, A);	/* TXD3 */
+			select_peripheral(PC11, A);	/* RXD2	*/
+			select_peripheral(PC12, A);	/* RXD3	*/
+			select_peripheral(PC14, A);	/* RXCK	*/
+			select_peripheral(PC18, A);	/* SPD	*/
 		}
 		break;
 
@@ -700,26 +696,28 @@ at32_add_device_eth(unsigned int id, str
 /* --------------------------------------------------------------------
  *  SPI
  * -------------------------------------------------------------------- */
-static struct resource spi0_resource[] = {
+static struct resource atmel_spi0_resource[] = {
 	PBMEM(0xffe00000),
 	IRQ(3),
 };
 DEFINE_DEV(spi, 0);
 DEV_CLK(mck, spi0, pba, 0);
 
-struct platform_device *__init at32_add_device_spi(unsigned int id)
+struct platform_device *__init
+at32_add_device_spi(unsigned int id)
 {
 	struct platform_device *pdev;
+	unsigned int i;
 
 	switch (id) {
 	case 0:
 		pdev = &spi0_device;
-		portmux_set_func(PIOA,  0, FUNC_A);	/* MISO	 */
-		portmux_set_func(PIOA,  1, FUNC_A);	/* MOSI	 */
-		portmux_set_func(PIOA,  2, FUNC_A);	/* SCK	 */
-		portmux_set_func(PIOA,  3, FUNC_A);	/* NPCS0 */
-		portmux_set_func(PIOA,  4, FUNC_A);	/* NPCS1 */
-		portmux_set_func(PIOA,  5, FUNC_A);	/* NPCS2 */
+		select_peripheral(PA0, A);	/* MISO	 */
+		select_peripheral(PA1, A);	/* MOSI	 */
+		select_peripheral(PA2, A);	/* SCK	 */
+		select_peripheral(PA3, A);	/* NPCS0 */
+		select_peripheral(PA4, A);	/* NPCS1 */
+		select_peripheral(PA5, A);	/* NPCS2 */
 		break;
 
 	default:
@@ -762,37 +760,37 @@ at32_add_device_lcdc(unsigned int id, st
 	switch (id) {
 	case 0:
 		pdev = &lcdc0_device;
-		portmux_set_func(PIOC, 19, FUNC_A);	/* CC	  */
-		portmux_set_func(PIOC, 20, FUNC_A);	/* HSYNC  */
-		portmux_set_func(PIOC, 21, FUNC_A);	/* PCLK	  */
-		portmux_set_func(PIOC, 22, FUNC_A);	/* VSYNC  */
-		portmux_set_func(PIOC, 23, FUNC_A);	/* DVAL	  */
-		portmux_set_func(PIOC, 24, FUNC_A);	/* MODE	  */
-		portmux_set_func(PIOC, 25, FUNC_A);	/* PWR	  */
-		portmux_set_func(PIOC, 26, FUNC_A);	/* DATA0  */
-		portmux_set_func(PIOC, 27, FUNC_A);	/* DATA1  */
-		portmux_set_func(PIOC, 28, FUNC_A);	/* DATA2  */
-		portmux_set_func(PIOC, 29, FUNC_A);	/* DATA3  */
-		portmux_set_func(PIOC, 30, FUNC_A);	/* DATA4  */
-		portmux_set_func(PIOC, 31, FUNC_A);	/* DATA5  */
-		portmux_set_func(PIOD,  0, FUNC_A);	/* DATA6  */
-		portmux_set_func(PIOD,  1, FUNC_A);	/* DATA7  */
-		portmux_set_func(PIOD,  2, FUNC_A);	/* DATA8  */
-		portmux_set_func(PIOD,  3, FUNC_A);	/* DATA9  */
-		portmux_set_func(PIOD,  4, FUNC_A);	/* DATA10 */
-		portmux_set_func(PIOD,  5, FUNC_A);	/* DATA11 */
-		portmux_set_func(PIOD,  6, FUNC_A);	/* DATA12 */
-		portmux_set_func(PIOD,  7, FUNC_A);	/* DATA13 */
-		portmux_set_func(PIOD,  8, FUNC_A);	/* DATA14 */
-		portmux_set_func(PIOD,  9, FUNC_A);	/* DATA15 */
-		portmux_set_func(PIOD, 10, FUNC_A);	/* DATA16 */
-		portmux_set_func(PIOD, 11, FUNC_A);	/* DATA17 */
-		portmux_set_func(PIOD, 12, FUNC_A);	/* DATA18 */
-		portmux_set_func(PIOD, 13, FUNC_A);	/* DATA19 */
-		portmux_set_func(PIOD, 14, FUNC_A);	/* DATA20 */
-		portmux_set_func(PIOD, 15, FUNC_A);	/* DATA21 */
-		portmux_set_func(PIOD, 16, FUNC_A);	/* DATA22 */
-		portmux_set_func(PIOD, 17, FUNC_A);	/* DATA23 */
+		select_peripheral(PC19, A);	/* CC	  */
+		select_peripheral(PC20, A);	/* HSYNC  */
+		select_peripheral(PC21, A);	/* PCLK	  */
+		select_peripheral(PC22, A);	/* VSYNC  */
+		select_peripheral(PC23, A);	/* DVAL	  */
+		select_peripheral(PC24, A);	/* MODE	  */
+		select_peripheral(PC25, A);	/* PWR	  */
+		select_peripheral(PC26, A);	/* DATA0  */
+		select_peripheral(PC27, A);	/* DATA1  */
+		select_peripheral(PC28, A);	/* DATA2  */
+		select_peripheral(PC29, A);	/* DATA3  */
+		select_peripheral(PC30, A);	/* DATA4  */
+		select_peripheral(PC31, A);	/* DATA5  */
+		select_peripheral(PD0, A);	/* DATA6  */
+		select_peripheral(PD1, A);	/* DATA7  */
+		select_peripheral(PD2, A);	/* DATA8  */
+		select_peripheral(PD3, A);	/* DATA9  */
+		select_peripheral(PD4, A);	/* DATA10 */
+		select_peripheral(PD5, A);	/* DATA11 */
+		select_peripheral(PD6, A);	/* DATA12 */
+		select_peripheral(PD7, A);	/* DATA13 */
+		select_peripheral(PD8, A);	/* DATA14 */
+		select_peripheral(PD9, A);	/* DATA15 */
+		select_peripheral(PD10, A);	/* DATA16 */
+		select_peripheral(PD11, A);	/* DATA17 */
+		select_peripheral(PD12, A);	/* DATA18 */
+		select_peripheral(PD13, A);	/* DATA19 */
+		select_peripheral(PD14, A);	/* DATA20 */
+		select_peripheral(PD15, A);	/* DATA21 */
+		select_peripheral(PD16, A);	/* DATA22 */
+		select_peripheral(PD17, A);	/* DATA23 */
 
 		clk_set_parent(&lcdc0_pixclk, &pll0);
 		clk_set_rate(&lcdc0_pixclk, clk_get_rate(&pll0));
Index: linux-2.6.19-rc4-mm2/arch/avr32/mach-at32ap/pio.c
===================================================================
--- linux-2.6.19-rc4-mm2.orig/arch/avr32/mach-at32ap/pio.c	2006-11-07 10:26:59.000000000 +0100
+++ linux-2.6.19-rc4-mm2/arch/avr32/mach-at32ap/pio.c	2006-11-07 10:27:01.000000000 +0100
@@ -14,8 +14,9 @@
 #include <linux/platform_device.h>
 
 #include <asm/io.h>
+#include <asm/irq.h>
 
-#include <asm/arch/portmux.h>
+#include <asm/arch/gpio.h>
 
 #include "pio.h"
 
@@ -31,17 +32,141 @@ struct pio_device {
 
 static struct pio_device pio_dev[MAX_NR_PIO_DEVICES];
 
-void portmux_set_func(unsigned int portmux_id, unsigned int pin_id,
-		      unsigned int function_id)
+/* GPIO API */
+
+static struct pio_device *get_pio_for_pin(unsigned int pin)
+{
+	struct pio_device *pio;
+	unsigned int index;
+
+	index = (pin - GPIO_IRQ_BASE) >> 5;
+	if (index > MAX_NR_PIO_DEVICES)
+		return NULL;
+	pio = &pio_dev[index];
+	if (!pio->regs)
+		return NULL;
+
+	return pio;
+}
+
+int request_gpio(unsigned int pin)
+{
+	struct pio_device *pio;
+	unsigned int pio_pin;
+	u32 mask;
+
+	pio = get_pio_for_pin(pin);
+	if (!pio)
+		return -ENODEV;
+
+	pio_pin = pin & 0x1f;
+	if (test_and_set_bit(pio_pin, &pio->alloc_mask))
+		return -EBUSY;
+
+	mask = 1 << pio_pin;
+	pio_writel(pio, PUER, mask);
+	pio_writel(pio, ODR, mask);
+	pio_writel(pio, PER, mask);
+
+	return 0;
+}
+EXPORT_SYMBOL(request_gpio);
+
+void free_gpio(unsigned int pin)
+{
+	struct pio_device *pio;
+	unsigned int pio_pin;
+	u32 mask;
+
+	pio = get_pio_for_pin(pin);
+	BUG_ON(!pio);
+
+	pio_pin = pin & 0x1f;
+	mask = 1 << pio_pin;
+	pio_writel(pio, PUER, mask);
+	pio_writel(pio, ODR, mask);
+	pio_writel(pio, PER, mask);
+
+	clear_bit(pio_pin, &pio->alloc_mask);
+}
+EXPORT_SYMBOL(free_gpio);
+
+void gpio_set_value(unsigned int pin, int value)
+{
+	struct pio_device *pio;
+	u32 mask;
+
+	/* If you want gentle error handling, call request_gpio() first */
+	pio = get_pio_for_pin(pin);
+	BUG_ON(!pio);
+
+	mask = 1 << (pin & 0x1f);
+	if (value)
+		pio_writel(pio, SODR, mask);
+	else
+		pio_writel(pio, CODR, mask);
+}
+EXPORT_SYMBOL(gpio_set_value);
+
+int gpio_get_value(unsigned int pin)
+{
+	struct pio_device *pio;
+	unsigned int pio_pin;
+
+	pio = get_pio_for_pin(pin);
+	BUG_ON(!pio);
+
+	pio_pin = pin & 0x1f;
+	return (pio_readl(pio, PDSR) >> pio_pin) & 1;
+}
+EXPORT_SYMBOL(gpio_get_value);
+
+void gpio_set_output_enable(unsigned int pin, int enabled)
+{
+	struct pio_device *pio;
+	u32 mask;
+
+	pio = get_pio_for_pin(pin);
+	BUG_ON(!pio);
+
+	mask = 1 << (pin & 0x1f);
+	if (enabled)
+		pio_writel(pio, OER, mask);
+	else
+		pio_writel(pio, ODR, mask);
+}
+EXPORT_SYMBOL(gpio_set_output_enable);
+
+void gpio_set_pullup_enable(unsigned int pin, int enabled)
+{
+	struct pio_device *pio;
+	u32 mask;
+
+	pio = get_pio_for_pin(pin);
+	BUG_ON(!pio);
+
+	mask = 1 << (pin & 0x1f);
+	if (enabled)
+		pio_writel(pio, PUER, mask);
+	else
+		pio_writel(pio, PUDR, mask);
+}
+EXPORT_SYMBOL(gpio_set_pullup_enable);
+
+void __init portmux_select_peripheral(unsigned int pin, unsigned int function)
 {
 	struct pio_device *pio;
-	u32 mask = 1 << pin_id;
+	unsigned int pio_pin = pin & 0x1f;
+	u32 mask = 1 << pio_pin;
 
-	BUG_ON(portmux_id >= MAX_NR_PIO_DEVICES);
+	pio = get_pio_for_pin(pin);
+	BUG_ON(!pio);
 
-	pio = &pio_dev[portmux_id];
+	if (test_and_set_bit(pin & 0x1f, &pio->alloc_mask))
+		printk(KERN_ERR "%s: pin %d allocated twice\n",
+		       pio->name, pio_pin);
 
-	if (function_id)
+	if (function)
 		pio_writel(pio, BSR, mask);
 	else
 		pio_writel(pio, ASR, mask);
Index: linux-2.6.19-rc4-mm2/include/asm-avr32/arch-at32ap/at32ap7000.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.19-rc4-mm2/include/asm-avr32/arch-at32ap/at32ap7000.h	2006-11-07 10:27:01.000000000 +0100
@@ -0,0 +1,141 @@
+#ifndef __ASM_ARCH_AT32AP7000_H
+#define __ASM_ARCH_AT32AP7000_H
+
+#include <asm/irq.h>
+
+#define GPIO_PERIPH_A	0
+#define GPIO_PERIPH_B	1
+
+#define NR_GPIO_CONTROLLERS	4
+
+/*
+ * Pin numbers identifying specific GPIO pins on the chip. They can
+ * also be used as IRQ numbers.
+ */
+#define GPIO_PIOA_BASE	(GPIO_IRQ_BASE)
+#define GPIO_PIN_PA0	(GPIO_PIOA_BASE +  0)
+#define GPIO_PIN_PA1	(GPIO_PIOA_BASE +  1)
+#define GPIO_PIN_PA2	(GPIO_PIOA_BASE +  2)
+#define GPIO_PIN_PA3	(GPIO_PIOA_BASE +  3)
+#define GPIO_PIN_PA4	(GPIO_PIOA_BASE +  4)
+#define GPIO_PIN_PA5	(GPIO_PIOA_BASE +  5)
+#define GPIO_PIN_PA6	(GPIO_PIOA_BASE +  6)
+#define GPIO_PIN_PA7	(GPIO_PIOA_BASE +  7)
+#define GPIO_PIN_PA8	(GPIO_PIOA_BASE +  8)
+#define GPIO_PIN_PA9	(GPIO_PIOA_BASE +  9)
+#define GPIO_PIN_PA10	(GPIO_PIOA_BASE + 10)
+#define GPIO_PIN_PA11	(GPIO_PIOA_BASE + 11)
+#define GPIO_PIN_PA12	(GPIO_PIOA_BASE + 12)
+#define GPIO_PIN_PA13	(GPIO_PIOA_BASE + 13)
+#define GPIO_PIN_PA14	(GPIO_PIOA_BASE + 14)
+#define GPIO_PIN_PA15	(GPIO_PIOA_BASE + 15)
+#define GPIO_PIN_PA16	(GPIO_PIOA_BASE + 16)
+#define GPIO_PIN_PA17	(GPIO_PIOA_BASE + 17)
+#define GPIO_PIN_PA18	(GPIO_PIOA_BASE + 18)
+#define GPIO_PIN_PA19	(GPIO_PIOA_BASE + 19)
+#define GPIO_PIN_PA20	(GPIO_PIOA_BASE + 20)
+#define GPIO_PIN_PA21	(GPIO_PIOA_BASE + 21)
+#define GPIO_PIN_PA22	(GPIO_PIOA_BASE + 22)
+#define GPIO_PIN_PA23	(GPIO_PIOA_BASE + 23)
+#define GPIO_PIN_PA24	(GPIO_PIOA_BASE + 24)
+#define GPIO_PIN_PA25	(GPIO_PIOA_BASE + 25)
+#define GPIO_PIN_PA26	(GPIO_PIOA_BASE + 26)
+#define GPIO_PIN_PA27	(GPIO_PIOA_BASE + 27)
+#define GPIO_PIN_PA28	(GPIO_PIOA_BASE + 28)
+#define GPIO_PIN_PA29	(GPIO_PIOA_BASE + 29)
+#define GPIO_PIN_PA30	(GPIO_PIOA_BASE + 30)
+#define GPIO_PIN_PA31	(GPIO_PIOA_BASE + 31)
+
+#define GPIO_PIOB_BASE	(GPIO_PIOA_BASE + 32)
+#define GPIO_PIN_PB0	(GPIO_PIOB_BASE +  0)
+#define GPIO_PIN_PB1	(GPIO_PIOB_BASE +  1)
+#define GPIO_PIN_PB2	(GPIO_PIOB_BASE +  2)
+#define GPIO_PIN_PB3	(GPIO_PIOB_BASE +  3)
+#define GPIO_PIN_PB4	(GPIO_PIOB_BASE +  4)
+#define GPIO_PIN_PB5	(GPIO_PIOB_BASE +  5)
+#define GPIO_PIN_PB6	(GPIO_PIOB_BASE +  6)
+#define GPIO_PIN_PB7	(GPIO_PIOB_BASE +  7)
+#define GPIO_PIN_PB8	(GPIO_PIOB_BASE +  8)
+#define GPIO_PIN_PB9	(GPIO_PIOB_BASE +  9)
+#define GPIO_PIN_PB10	(GPIO_PIOB_BASE + 10)
+#define GPIO_PIN_PB11	(GPIO_PIOB_BASE + 11)
+#define GPIO_PIN_PB12	(GPIO_PIOB_BASE + 12)
+#define GPIO_PIN_PB13	(GPIO_PIOB_BASE + 13)
+#define GPIO_PIN_PB14	(GPIO_PIOB_BASE + 14)
+#define GPIO_PIN_PB15	(GPIO_PIOB_BASE + 15)
+#define GPIO_PIN_PB16	(GPIO_PIOB_BASE + 16)
+#define GPIO_PIN_PB17	(GPIO_PIOB_BASE + 17)
+#define GPIO_PIN_PB18	(GPIO_PIOB_BASE + 18)
+#define GPIO_PIN_PB19	(GPIO_PIOB_BASE + 19)
+#define GPIO_PIN_PB20	(GPIO_PIOB_BASE + 20)
+#define GPIO_PIN_PB21	(GPIO_PIOB_BASE + 21)
+#define GPIO_PIN_PB22	(GPIO_PIOB_BASE + 22)
+#define GPIO_PIN_PB23	(GPIO_PIOB_BASE + 23)
+#define GPIO_PIN_PB24	(GPIO_PIOB_BASE + 24)
+#define GPIO_PIN_PB25	(GPIO_PIOB_BASE + 25)
+#define GPIO_PIN_PB26	(GPIO_PIOB_BASE + 26)
+#define GPIO_PIN_PB27	(GPIO_PIOB_BASE + 27)
+#define GPIO_PIN_PB28	(GPIO_PIOB_BASE + 28)
+#define GPIO_PIN_PB29	(GPIO_PIOB_BASE + 29)
+#define GPIO_PIN_PB30	(GPIO_PIOB_BASE + 30)
+
+#define GPIO_PIOC_BASE	(GPIO_PIOB_BASE + 32)
+#define GPIO_PIN_PC0	(GPIO_PIOC_BASE +  0)
+#define GPIO_PIN_PC1	(GPIO_PIOC_BASE +  1)
+#define GPIO_PIN_PC2	(GPIO_PIOC_BASE +  2)
+#define GPIO_PIN_PC3	(GPIO_PIOC_BASE +  3)
+#define GPIO_PIN_PC4	(GPIO_PIOC_BASE +  4)
+#define GPIO_PIN_PC5	(GPIO_PIOC_BASE +  5)
+#define GPIO_PIN_PC6	(GPIO_PIOC_BASE +  6)
+#define GPIO_PIN_PC7	(GPIO_PIOC_BASE +  7)
+#define GPIO_PIN_PC8	(GPIO_PIOC_BASE +  8)
+#define GPIO_PIN_PC9	(GPIO_PIOC_BASE +  9)
+#define GPIO_PIN_PC10	(GPIO_PIOC_BASE + 10)
+#define GPIO_PIN_PC11	(GPIO_PIOC_BASE + 11)
+#define GPIO_PIN_PC12	(GPIO_PIOC_BASE + 12)
+#define GPIO_PIN_PC13	(GPIO_PIOC_BASE + 13)
+#define GPIO_PIN_PC14	(GPIO_PIOC_BASE + 14)
+#define GPIO_PIN_PC15	(GPIO_PIOC_BASE + 15)
+#define GPIO_PIN_PC16	(GPIO_PIOC_BASE + 16)
+#define GPIO_PIN_PC17	(GPIO_PIOC_BASE + 17)
+#define GPIO_PIN_PC18	(GPIO_PIOC_BASE + 18)
+#define GPIO_PIN_PC19	(GPIO_PIOC_BASE + 19)
+#define GPIO_PIN_PC20	(GPIO_PIOC_BASE + 20)
+#define GPIO_PIN_PC21	(GPIO_PIOC_BASE + 21)
+#define GPIO_PIN_PC22	(GPIO_PIOC_BASE + 22)
+#define GPIO_PIN_PC23	(GPIO_PIOC_BASE + 23)
+#define GPIO_PIN_PC24	(GPIO_PIOC_BASE + 24)
+#define GPIO_PIN_PC25	(GPIO_PIOC_BASE + 25)
+#define GPIO_PIN_PC26	(GPIO_PIOC_BASE + 26)
+#define GPIO_PIN_PC27	(GPIO_PIOC_BASE + 27)
+#define GPIO_PIN_PC28	(GPIO_PIOC_BASE + 28)
+#define GPIO_PIN_PC29	(GPIO_PIOC_BASE + 29)
+#define GPIO_PIN_PC30	(GPIO_PIOC_BASE + 30)
+#define GPIO_PIN_PC31	(GPIO_PIOC_BASE + 31)
+
+#define GPIO_PIOD_BASE	(GPIO_PIOC_BASE + 32)
+#define GPIO_PIN_PD0	(GPIO_PIOD_BASE +  0)
+#define GPIO_PIN_PD1	(GPIO_PIOD_BASE +  1)
+#define GPIO_PIN_PD2	(GPIO_PIOD_BASE +  2)
+#define GPIO_PIN_PD3	(GPIO_PIOD_BASE +  3)
+#define GPIO_PIN_PD4	(GPIO_PIOD_BASE +  4)
+#define GPIO_PIN_PD5	(GPIO_PIOD_BASE +  5)
+#define GPIO_PIN_PD6	(GPIO_PIOD_BASE +  6)
+#define GPIO_PIN_PD7	(GPIO_PIOD_BASE +  7)
+#define GPIO_PIN_PD8	(GPIO_PIOD_BASE +  8)
+#define GPIO_PIN_PD9	(GPIO_PIOD_BASE +  9)
+#define GPIO_PIN_PD10	(GPIO_PIOD_BASE + 10)
+#define GPIO_PIN_PD11	(GPIO_PIOD_BASE + 11)
+#define GPIO_PIN_PD12	(GPIO_PIOD_BASE + 12)
+#define GPIO_PIN_PD13	(GPIO_PIOD_BASE + 13)
+#define GPIO_PIN_PD14	(GPIO_PIOD_BASE + 14)
+#define GPIO_PIN_PD15	(GPIO_PIOD_BASE + 15)
+#define GPIO_PIN_PD16	(GPIO_PIOD_BASE + 16)
+#define GPIO_PIN_PD17	(GPIO_PIOD_BASE + 17)
+
+/*
+ * Technically, PIOE is also available, but we'll leave it alone since
+ * the SDRAM interface depends on it.
+ */
+
+#endif /* __ASM_ARCH_AT32AP7000_H */
Index: linux-2.6.19-rc4-mm2/include/asm-avr32/arch-at32ap/gpio.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.19-rc4-mm2/include/asm-avr32/arch-at32ap/gpio.h	2006-11-07 10:27:01.000000000 +0100
@@ -0,0 +1,14 @@
+#ifndef __ASM_AVR32_GPIO_H
+#define __ASM_AVR32_GPIO_H
+
+void portmux_select_peripheral(unsigned int pin, unsigned int function);
+
+int request_gpio(unsigned int pin);
+void free_gpio(unsigned int pin);
+
+void gpio_set_value(unsigned int pin, int value);
+int gpio_get_value(unsigned int pin);
+void gpio_set_output_enable(unsigned int pin, int enabled);
+void gpio_set_pullup_enable(unsigned int pin, int enabled);
+
+#endif /* __ASM_AVR32_GPIO_H */
Index: linux-2.6.19-rc4-mm2/include/asm-avr32/arch-at32ap/irq.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.19-rc4-mm2/include/asm-avr32/arch-at32ap/irq.h	2006-11-07 10:27:01.000000000 +0100
@@ -0,0 +1,11 @@
+#ifndef __ASM_AVR32_ARCH_IRQ_H
+#define __ASM_AVR32_ARCH_IRQ_H
+
+#define EXTERNAL_IRQ_BASE	NR_INTERNAL_IRQS
+#define NR_EXTERNAL_IRQS	32
+#define GPIO_IRQ_BASE		(EXTERNAL_IRQ_BASE + NR_EXTERNAL_IRQS)
+#define NR_GPIO_IRQS		(4 * 32)
+
+#define NR_IRQS			(GPIO_IRQ_BASE + NR_GPIO_IRQS)
+
+#endif /* __ASM_AVR32_ARCH_IRQ_H */
Index: linux-2.6.19-rc4-mm2/include/asm-avr32/arch-at32ap/portmux.h
===================================================================
--- linux-2.6.19-rc4-mm2.orig/include/asm-avr32/arch-at32ap/portmux.h	2006-11-07 10:26:59.000000000 +0100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,16 +0,0 @@
-/*
- * AT32 portmux interface.
- *
- * Copyright (C) 2006 Atmel Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#ifndef __ASM_AVR32_AT32_PORTMUX_H__
-#define __ASM_AVR32_AT32_PORTMUX_H__
-
-void portmux_set_func(unsigned int portmux_id, unsigned int pin_id,
-		      unsigned int function_id);
-
-#endif /* __ASM_AVR32_AT32_PORTMUX_H__ */
Index: linux-2.6.19-rc4-mm2/include/asm-avr32/irq.h
===================================================================
--- linux-2.6.19-rc4-mm2.orig/include/asm-avr32/irq.h	2006-11-07 10:26:59.000000000 +0100
+++ linux-2.6.19-rc4-mm2/include/asm-avr32/irq.h	2006-11-07 10:27:01.000000000 +0100
@@ -2,8 +2,12 @@
 #define __ASM_AVR32_IRQ_H
 
 #define NR_INTERNAL_IRQS	64
-#define NR_EXTERNAL_IRQS	64
-#define NR_IRQS			(NR_INTERNAL_IRQS + NR_EXTERNAL_IRQS)
+
+#include <asm/arch/irq.h>
+
+#ifndef NR_IRQS
+#define NR_IRQS			(NR_INTERNAL_IRQS)
+#endif
 
 #define irq_canonicalize(i)	(i)
 
