Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758451AbWK1Mgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758451AbWK1Mgg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 07:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758447AbWK1Mgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 07:36:36 -0500
Received: from nat-132.atmel.no ([80.232.32.132]:51164 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1758250AbWK1Mge (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 07:36:34 -0500
Date: Tue, 28 Nov 2006 13:36:18 +0100
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Subject: [RFC/PATCH] arch-neutral GPIO calls: AVR32 implementation [take 2]
Message-ID: <20061128133618.0e6932fc@dhcp-252-105.norway.atmel.com>
In-Reply-To: <200611211103.43757.david-b@pacbell.net>
References: <200611111541.34699.david-b@pacbell.net>
 <200611201347.10331.david-b@pacbell.net>
 <20061121101103.47add0cf@dhcp-252-105.norway.atmel.com>
 <200611211103.43757.david-b@pacbell.net>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's another go at an implementation of the arch-neutral GPIO API for
AVR32. I've also thrown in the pin configuration stuff so that you can
see how all the pieces fit together.

Even though it is possible to tell from the hardware whether a pin is
set up for GPIO, I decided to use two allocation bitmasks per pio
controller to keep track of what the pins are used for: pinmux_mask and
gpio_mask.

pinmux_mask indicates which pins have been configured for usage either
by a peripheral or GPIO. If the corresponding bit is set when trying to
configure a pin, a warning will be printed along with a stack dump (no
BUG anymore.)

gpio_mask indicates which pins are available for GPIO. It starts out as
all ones, and whenever a pin is configured for GPIO, the corresponding
bit is cleared. gpio_request() test_and_set()s a bit in the mask
corresponding to the pin being requested, and if it's already set
(either because it hasn't been configured or because it's been
requested by a different driver), gpio_request() returns an error value.

The pin configuration API is AVR32-specific for now.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/mach-at32ap/at32ap7000.c        |  144 ++++++++++-----------
 arch/avr32/mach-at32ap/pio.c               |  186 ++++++++++++++++++++++++++--
 include/asm-avr32/arch-at32ap/at32ap7000.h |   26 ++++
 include/asm-avr32/arch-at32ap/gpio.h       |   39 ++++++
 include/asm-avr32/arch-at32ap/irq.h        |   11 ++
 include/asm-avr32/arch-at32ap/portmux.h    |   16 ---
 include/asm-avr32/gpio.h                   |    6 +
 include/asm-avr32/irq.h                    |    8 +-
 8 files changed, 333 insertions(+), 103 deletions(-)

diff --git a/arch/avr32/mach-at32ap/at32ap7000.c b/arch/avr32/mach-at32ap/at32ap7000.c
index 7ff6ad8..c80385d 100644
--- a/arch/avr32/mach-at32ap/at32ap7000.c
+++ b/arch/avr32/mach-at32ap/at32ap7000.c
@@ -11,8 +11,9 @@
 
 #include <asm/io.h>
 
+#include <asm/arch/at32ap7000.h>
 #include <asm/arch/board.h>
-#include <asm/arch/portmux.h>
+#include <asm/arch/gpio.h>
 #include <asm/arch/sm.h>
 
 #include "clock.h"
@@ -67,17 +68,8 @@ static struct clk devname##_##_name = {
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
+#define select_peripheral(pin, periph, pullup)				\
+	at32_select_periph(GPIO_PIN_##pin, GPIO_##periph, pullup)
 
 unsigned long at32ap7000_osc_rates[3] = {
 	[0] = 32768,
@@ -569,26 +561,26 @@ DEV_CLK(usart, atmel_usart3, pba, 6);
 
 static inline void configure_usart0_pins(void)
 {
-	portmux_set_func(PIOA,  8, FUNC_B);	/* RXD	*/
-	portmux_set_func(PIOA,  9, FUNC_B);	/* TXD	*/
+	select_peripheral(PA(8), PERIPH_B, 0);	/* RXD	*/
+	select_peripheral(PA(9), PERIPH_B, 0);	/* TXD	*/
 }
 
 static inline void configure_usart1_pins(void)
 {
-	portmux_set_func(PIOA, 17, FUNC_A);	/* RXD	*/
-	portmux_set_func(PIOA, 18, FUNC_A);	/* TXD	*/
+	select_peripheral(PA(17), PERIPH_A, 0);	/* RXD	*/
+	select_peripheral(PA(18), PERIPH_A, 0);	/* TXD	*/
 }
 
 static inline void configure_usart2_pins(void)
 {
-	portmux_set_func(PIOB, 26, FUNC_B);	/* RXD	*/
-	portmux_set_func(PIOB, 27, FUNC_B);	/* TXD	*/
+	select_peripheral(PB(26), PERIPH_B, 0);	/* RXD	*/
+	select_peripheral(PB(27), PERIPH_B, 0);	/* TXD	*/
 }
 
 static inline void configure_usart3_pins(void)
 {
-	portmux_set_func(PIOB, 18, FUNC_B);	/* RXD	*/
-	portmux_set_func(PIOB, 17, FUNC_B);	/* TXD	*/
+	select_peripheral(PB(18), PERIPH_B, 0);	/* RXD	*/
+	select_peripheral(PB(17), PERIPH_B, 0);	/* TXD	*/
 }
 
 static struct platform_device *at32_usarts[4];
@@ -663,27 +655,27 @@ at32_add_device_eth(unsigned int id, str
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
+		select_peripheral(PC(3), PERIPH_A, 0);		/* TXD0	*/
+		select_peripheral(PC(4), PERIPH_A, 0);		/* TXD1	*/
+		select_peripheral(PC(7), PERIPH_A, 0);		/* TXEN	*/
+		select_peripheral(PC(8), PERIPH_A, 0);		/* TXCK */
+		select_peripheral(PC(9), PERIPH_A, 0);		/* RXD0	*/
+		select_peripheral(PC(10), PERIPH_A, 0);		/* RXD1	*/
+		select_peripheral(PC(13), PERIPH_A, 0);		/* RXER	*/
+		select_peripheral(PC(15), PERIPH_A, 0);		/* RXDV	*/
+		select_peripheral(PC(16), PERIPH_A, 0);		/* MDC	*/
+		select_peripheral(PC(17), PERIPH_A, 0);		/* MDIO	*/
 
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
+			select_peripheral(PC(0), PERIPH_A, 0);	/* COL	*/
+			select_peripheral(PC(1), PERIPH_A, 0);	/* CRS	*/
+			select_peripheral(PC(2), PERIPH_A, 0);	/* TXER	*/
+			select_peripheral(PC(5), PERIPH_A, 0);	/* TXD2	*/
+			select_peripheral(PC(6), PERIPH_A, 0);	/* TXD3 */
+			select_peripheral(PC(11), PERIPH_A, 0);	/* RXD2	*/
+			select_peripheral(PC(12), PERIPH_A, 0);	/* RXD3	*/
+			select_peripheral(PC(14), PERIPH_A, 0);	/* RXCK	*/
+			select_peripheral(PC(18), PERIPH_A, 0);	/* SPD	*/
 		}
 		break;
 
@@ -714,12 +706,12 @@ struct platform_device *__init at32_add_
 	switch (id) {
 	case 0:
 		pdev = &spi0_device;
-		portmux_set_func(PIOA,  0, FUNC_A);	/* MISO	 */
-		portmux_set_func(PIOA,  1, FUNC_A);	/* MOSI	 */
-		portmux_set_func(PIOA,  2, FUNC_A);	/* SCK	 */
-		portmux_set_func(PIOA,  3, FUNC_A);	/* NPCS0 */
-		portmux_set_func(PIOA,  4, FUNC_A);	/* NPCS1 */
-		portmux_set_func(PIOA,  5, FUNC_A);	/* NPCS2 */
+		select_peripheral(PA(0), PERIPH_A, 0);	/* MISO	 */
+		select_peripheral(PA(1), PERIPH_A, 0);	/* MOSI	 */
+		select_peripheral(PA(2), PERIPH_A, 0);	/* SCK	 */
+		select_peripheral(PA(3), PERIPH_A, 0);	/* NPCS0 */
+		select_peripheral(PA(4), PERIPH_A, 0);	/* NPCS1 */
+		select_peripheral(PA(5), PERIPH_A, 0);	/* NPCS2 */
 		break;
 
 	default:
@@ -762,37 +754,37 @@ at32_add_device_lcdc(unsigned int id, st
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
+		select_peripheral(PC(19), PERIPH_A, 0);	/* CC	  */
+		select_peripheral(PC(20), PERIPH_A, 0);	/* HSYNC  */
+		select_peripheral(PC(21), PERIPH_A, 0);	/* PCLK	  */
+		select_peripheral(PC(22), PERIPH_A, 0);	/* VSYNC  */
+		select_peripheral(PC(23), PERIPH_A, 0);	/* DVAL	  */
+		select_peripheral(PC(24), PERIPH_A, 0);	/* MODE	  */
+		select_peripheral(PC(25), PERIPH_A, 0);	/* PWR	  */
+		select_peripheral(PC(26), PERIPH_A, 0);	/* DATA0  */
+		select_peripheral(PC(27), PERIPH_A, 0);	/* DATA1  */
+		select_peripheral(PC(28), PERIPH_A, 0);	/* DATA2  */
+		select_peripheral(PC(29), PERIPH_A, 0);	/* DATA3  */
+		select_peripheral(PC(30), PERIPH_A, 0);	/* DATA4  */
+		select_peripheral(PC(31), PERIPH_A, 0);	/* DATA5  */
+		select_peripheral(PD(0), PERIPH_A, 0);	/* DATA6  */
+		select_peripheral(PD(1), PERIPH_A, 0);	/* DATA7  */
+		select_peripheral(PD(2), PERIPH_A, 0);	/* DATA8  */
+		select_peripheral(PD(3), PERIPH_A, 0);	/* DATA9  */
+		select_peripheral(PD(4), PERIPH_A, 0);	/* DATA10 */
+		select_peripheral(PD(5), PERIPH_A, 0);	/* DATA11 */
+		select_peripheral(PD(6), PERIPH_A, 0);	/* DATA12 */
+		select_peripheral(PD(7), PERIPH_A, 0);	/* DATA13 */
+		select_peripheral(PD(8), PERIPH_A, 0);	/* DATA14 */
+		select_peripheral(PD(9), PERIPH_A, 0);	/* DATA15 */
+		select_peripheral(PD(10), PERIPH_A, 0);	/* DATA16 */
+		select_peripheral(PD(11), PERIPH_A, 0);	/* DATA17 */
+		select_peripheral(PD(12), PERIPH_A, 0);	/* DATA18 */
+		select_peripheral(PD(13), PERIPH_A, 0);	/* DATA19 */
+		select_peripheral(PD(14), PERIPH_A, 0);	/* DATA20 */
+		select_peripheral(PD(15), PERIPH_A, 0);	/* DATA21 */
+		select_peripheral(PD(16), PERIPH_A, 0);	/* DATA22 */
+		select_peripheral(PD(17), PERIPH_A, 0);	/* DATA23 */
 
 		clk_set_parent(&lcdc0_pixclk, &pll0);
 		clk_set_rate(&lcdc0_pixclk, clk_get_rate(&pll0));
diff --git a/arch/avr32/mach-at32ap/pio.c b/arch/avr32/mach-at32ap/pio.c
index d3aabfc..92e151d 100644
--- a/arch/avr32/mach-at32ap/pio.c
+++ b/arch/avr32/mach-at32ap/pio.c
@@ -13,10 +13,9 @@
 #include <linux/fs.h>
 #include <linux/platform_device.h>
 
+#include <asm/gpio.h>
 #include <asm/io.h>
 
-#include <asm/arch/portmux.h>
-
 #include "pio.h"
 
 #define MAX_NR_PIO_DEVICES		8
@@ -25,28 +24,191 @@ struct pio_device {
 	void __iomem *regs;
 	const struct platform_device *pdev;
 	struct clk *clk;
-	u32 alloc_mask;
+	u32 pinmux_mask;
+	u32 gpio_mask;
 	char name[32];
 };
 
 static struct pio_device pio_dev[MAX_NR_PIO_DEVICES];
 
-void portmux_set_func(unsigned int portmux_id, unsigned int pin_id,
-		      unsigned int function_id)
+static struct pio_device *gpio_to_pio(unsigned int gpio)
 {
 	struct pio_device *pio;
-	u32 mask = 1 << pin_id;
+	unsigned int index;
+
+	index = gpio >> 5;
+	if (index >= MAX_NR_PIO_DEVICES)
+		return NULL;
+	pio = &pio_dev[index];
+	if (!pio->regs)
+		return NULL;
+
+	return pio;
+}
+
+/* Pin multiplexing API */
 
-	BUG_ON(portmux_id >= MAX_NR_PIO_DEVICES);
+void __init at32_select_periph(unsigned int pin, unsigned int periph,
+			       int use_pullup)
+{
+	struct pio_device *pio;
+	unsigned int pin_index = pin & 0x1f;
+	u32 mask = 1 << pin_index;
+
+	pio = gpio_to_pio(pin);
+	if (unlikely(!pio)) {
+		printk("pio: invalid pin %u\n", pin);
+		goto fail;
+	}
 
-	pio = &pio_dev[portmux_id];
+	if (unlikely(test_and_set_bit(pin_index, &pio->pinmux_mask))) {
+		printk("%s: pin %u is busy\n", pio->name, pin_index);
+		goto fail;
+	}
 
-	if (function_id)
+	pio_writel(pio, PUER, mask);
+	if (periph)
 		pio_writel(pio, BSR, mask);
 	else
 		pio_writel(pio, ASR, mask);
+
 	pio_writel(pio, PDR, mask);
+	if (!use_pullup)
+		pio_writel(pio, PUDR, mask);
+
+	return;
+
+fail:
+	dump_stack();
+}
+
+void __init at32_select_gpio(unsigned int pin, int enable_output,
+			     int use_pullup)
+{
+	struct pio_device *pio;
+	unsigned int pin_index = pin & 0x1f;
+	u32 mask = 1 << pin_index;
+
+	pio = gpio_to_pio(pin);
+	if (unlikely(!pio)) {
+		printk("pio: invalid pin %u\n", pin);
+		goto fail;
+	}
+
+	if (unlikely(test_and_set_bit(pin_index, &pio->pinmux_mask))) {
+		printk("%s: pin %u is busy\n", pio->name, pin_index);
+		goto fail;
+	}
+
+	pio_writel(pio, PUER, mask);
+	if (enable_output)
+		pio_writel(pio, OER, mask);
+	else
+		pio_writel(pio, ODR, mask);
+
+	pio_writel(pio, PER, mask);
+	if (!use_pullup)
+		pio_writel(pio, PUDR, mask);
+
+	/* It's now allowed to use request_gpio on this pin */
+	clear_bit(pin_index, &pio->gpio_mask);
+
+	return;
+
+fail:
+	dump_stack();
+}
+
+/* GPIO API */
+
+int gpio_request(unsigned int gpio, const char *label)
+{
+	struct pio_device *pio;
+	unsigned int pin;
+
+	pio = gpio_to_pio(gpio);
+	if (!pio)
+		return -ENODEV;
+
+	pin = gpio & 0x1f;
+	if (test_and_set_bit(pin, &pio->gpio_mask))
+		return -EBUSY;
+
+	return 0;
+}
+EXPORT_SYMBOL(gpio_request);
+
+void gpio_free(unsigned int gpio)
+{
+	struct pio_device *pio;
+	unsigned int pin;
+
+	pio = gpio_to_pio(gpio);
+	if (!pio) {
+		printk(KERN_ERR
+		       "gpio: attempted to free invalid pin %u\n", gpio);
+		return;
+	}
+
+	pin = gpio & 0x1f;
+	if (!test_and_clear_bit(pin, &pio->gpio_mask))
+		printk(KERN_ERR "gpio: freeing already-free pin %s[%u]\n",
+		       pio->name, pin);
 }
+EXPORT_SYMBOL(gpio_free);
+
+int gpio_direction_input(unsigned int gpio)
+{
+	struct pio_device *pio;
+	unsigned int pin;
+
+	pio = gpio_to_pio(gpio);
+	if (!pio)
+		return -ENODEV;
+
+	pin = gpio & 0x1f;
+	pio_writel(pio, ODR, 1 << pin);
+
+	return 0;
+}
+EXPORT_SYMBOL(gpio_direction_input);
+
+int gpio_direction_output(unsigned int gpio)
+{
+	struct pio_device *pio;
+	unsigned int pin;
+
+	pio = gpio_to_pio(gpio);
+	if (!pio)
+		return -ENODEV;
+
+	pin = gpio & 0x1f;
+	pio_writel(pio, OER, 1 << pin);
+
+	return 0;
+}
+EXPORT_SYMBOL(gpio_direction_output);
+
+int gpio_get_value(unsigned int gpio)
+{
+	struct pio_device *pio = &pio_dev[gpio >> 5];
+
+	return (pio_readl(pio, PDSR) >> (gpio & 0x1f)) & 1;
+}
+EXPORT_SYMBOL(gpio_get_value);
+
+void gpio_set_value(unsigned int gpio, int value)
+{
+	struct pio_device *pio = &pio_dev[gpio >> 5];
+	u32 mask;
+
+	mask = 1 << (gpio & 0x1f);
+	if (value)
+		pio_writel(pio, SODR, mask);
+	else
+		pio_writel(pio, CODR, mask);
+}
+EXPORT_SYMBOL(gpio_set_value);
 
 static int __init pio_probe(struct platform_device *pdev)
 {
@@ -113,6 +275,12 @@ void __init at32_init_pio(struct platfor
 	pio->pdev = pdev;
 	pio->regs = ioremap(regs->start, regs->end - regs->start + 1);
 
+	/*
+	 * request_gpio() is only valid for pins that have been
+	 * configured as GPIO.
+	 */
+	pio->gpio_mask = ~0UL;
+
 	pio_writel(pio, ODR, ~0UL);
 	pio_writel(pio, PER, ~0UL);
 }
diff --git a/include/asm-avr32/arch-at32ap/at32ap7000.h b/include/asm-avr32/arch-at32ap/at32ap7000.h
new file mode 100644
index 0000000..8bdedbc
--- /dev/null
+++ b/include/asm-avr32/arch-at32ap/at32ap7000.h
@@ -0,0 +1,26 @@
+#ifndef __ASM_ARCH_AT32AP7000_H
+#define __ASM_ARCH_AT32AP7000_H
+
+#define GPIO_PERIPH_A	0
+#define GPIO_PERIPH_B	1
+
+#define NR_GPIO_CONTROLLERS	4
+
+/*
+ * Pin numbers identifying specific GPIO pins on the chip. They can
+ * also be converted to IRQ numbers by passing them through
+ * gpio_to_irq().
+ */
+#define GPIO_PIOA_BASE	(0)
+#define GPIO_PIOB_BASE	(GPIO_PIOA_BASE + 32)
+#define GPIO_PIOC_BASE	(GPIO_PIOB_BASE + 32)
+#define GPIO_PIOD_BASE	(GPIO_PIOC_BASE + 32)
+#define GPIO_PIOE_BASE	(GPIO_PIOD_BASE + 32)
+
+#define GPIO_PIN_PA(N)	(GPIO_PIOA_BASE + (N))
+#define GPIO_PIN_PB(N)	(GPIO_PIOB_BASE + (N))
+#define GPIO_PIN_PC(N)	(GPIO_PIOC_BASE + (N))
+#define GPIO_PIN_PD(N)	(GPIO_PIOD_BASE + (N))
+#define GPIO_PIN_PE(N)	(GPIO_PIOE_BASE + (N))
+
+#endif /* __ASM_ARCH_AT32AP7000_H */
diff --git a/include/asm-avr32/arch-at32ap/gpio.h b/include/asm-avr32/arch-at32ap/gpio.h
new file mode 100644
index 0000000..825582f
--- /dev/null
+++ b/include/asm-avr32/arch-at32ap/gpio.h
@@ -0,0 +1,39 @@
+#ifndef __ASM_AVR32_GPIO_H
+#define __ASM_AVR32_GPIO_H
+
+#include <linux/compiler.h>
+#include <asm/irq.h>
+
+/*
+ * Set up pin multiplexing, called from board init only.
+ *
+ * The following flags determine the initial state of the pin.
+ */
+#define AT32_GPIOF_PULLUP	0x00000001	/* Enable pull-up */
+#define AT32_GPIOF_OUTPUT	0x00000002	/* Enable output driver */
+#define AT32_GPIOF_HIGH		0x00000004	/* Set output high */
+
+void at32_select_periph(unsigned int pin, unsigned int periph,
+			unsigned long flags);
+void at32_select_gpio(unsigned int pin, unsigned long flags);
+
+/* Arch-neutral GPIO API */
+int __must_check gpio_request(unsigned int gpio, const char *label);
+void gpio_free(unsigned int gpio);
+
+int gpio_direction_input(unsigned int gpio);
+int gpio_direction_output(unsigned int gpio);
+int gpio_get_value(unsigned int gpio);
+void gpio_set_value(unsigned int gpio, int value);
+
+static inline int gpio_to_irq(unsigned int gpio)
+{
+	return gpio + GPIO_IRQ_BASE;
+}
+
+static inline int irq_to_gpio(unsigned int irq)
+{
+	return irq - GPIO_IRQ_BASE;
+}
+
+#endif /* __ASM_AVR32_GPIO_H */
diff --git a/include/asm-avr32/arch-at32ap/irq.h b/include/asm-avr32/arch-at32ap/irq.h
new file mode 100644
index 0000000..1e2513e
--- /dev/null
+++ b/include/asm-avr32/arch-at32ap/irq.h
@@ -0,0 +1,11 @@
+#ifndef __ASM_AVR32_ARCH_IRQ_H
+#define __ASM_AVR32_ARCH_IRQ_H
+
+#define EIM_IRQ_BASE	NR_INTERNAL_IRQS
+#define NR_EIM_IRQS	32
+#define GPIO_IRQ_BASE	(EIM_IRQ_BASE + NR_EIM_IRQS)
+#define NR_GPIO_IRQS	(4 * 32)
+
+#define NR_IRQS		(GPIO_IRQ_BASE + NR_GPIO_IRQS)
+
+#endif /* __ASM_AVR32_ARCH_IRQ_H */
diff --git a/include/asm-avr32/arch-at32ap/portmux.h b/include/asm-avr32/arch-at32ap/portmux.h
deleted file mode 100644
index 4d50421..0000000
--- a/include/asm-avr32/arch-at32ap/portmux.h
+++ /dev/null
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
diff --git a/include/asm-avr32/gpio.h b/include/asm-avr32/gpio.h
new file mode 100644
index 0000000..19e8ccc
--- /dev/null
+++ b/include/asm-avr32/gpio.h
@@ -0,0 +1,6 @@
+#ifndef __ASM_AVR32_GPIO_H
+#define __ASM_AVR32_GPIO_H
+
+#include <asm/arch/gpio.h>
+
+#endif /* __ASM_AVR32_GPIO_H */
diff --git a/include/asm-avr32/irq.h b/include/asm-avr32/irq.h
index f7e7257..83e6549 100644
--- a/include/asm-avr32/irq.h
+++ b/include/asm-avr32/irq.h
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
 
-- 
1.4.3.3

