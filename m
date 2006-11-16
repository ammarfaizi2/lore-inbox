Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424109AbWKPOzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424109AbWKPOzT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 09:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424120AbWKPOzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 09:55:19 -0500
Received: from nat-132.atmel.no ([80.232.32.132]:23252 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1424109AbWKPOzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 09:55:16 -0500
Date: Thu, 16 Nov 2006 15:54:55 +0100
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Subject: [RFC/PATCH] arch-neutral GPIO calls: AVR32 implementation
Message-ID: <20061116155455.3833f3a4@cad-250-152.norway.atmel.com>
In-Reply-To: <200611111541.34699.david-b@pacbell.net>
References: <200611111541.34699.david-b@pacbell.net>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Nov 2006 15:41:32 -0800
David Brownell <david-b@pacbell.net> wrote:

> Below, find what I think is a useful proposal, trivially
> implementable on many ARMs (at91, omap, pxa, ep93xx, ixp2000,
> pnx4008, davinci, more) as well as the new AVR32.

FYI, here's the AVR32 implementation of the API you propose. Thanks for
writing this up, Dave.

I'm still not sure about how to implement the
gpio_request()/gpio_free() calls, though. Since they're not supposed to
do any port configuration, I think I might convert them to no-ops and
do the allocation (and warn about conflicts) when configuring the port
multiplexer. Since the pin will be configured for one particular usage,
having multiple drivers try to use it will cause problems and handing
it out to the first driver that comes along will not really solve
anything...

Of course, if other arches want gpio_request()/gpio_free(), I'm all for
keeping them.

I'll send you an updated SPI driver using this API after I've tested it
a bit more.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/mach-at32ap/pio.c               |  103 ++++++++++++++++++++
 include/asm-avr32/arch-at32ap/at32ap7000.h |  139 ++++++++++++++++++++++++++++
 include/asm-avr32/arch-at32ap/gpio.h       |   25 +++++
 include/asm-avr32/arch-at32ap/irq.h        |   11 ++
 include/asm-avr32/gpio.h                   |    6 +
 include/asm-avr32/irq.h                    |    8 +-
 6 files changed, 290 insertions(+), 2 deletions(-)

diff --git a/arch/avr32/mach-at32ap/pio.c b/arch/avr32/mach-at32ap/pio.c
index d3aabfc..b6c8b42 100644
--- a/arch/avr32/mach-at32ap/pio.c
+++ b/arch/avr32/mach-at32ap/pio.c
@@ -13,6 +13,7 @@ #include <linux/debugfs.h>
 #include <linux/fs.h>
 #include <linux/platform_device.h>
 
+#include <asm/gpio.h>
 #include <asm/io.h>
 
 #include <asm/arch/portmux.h>
@@ -31,6 +32,21 @@ struct pio_device {
 
 static struct pio_device pio_dev[MAX_NR_PIO_DEVICES];
 
+static struct pio_device *gpio_to_pio(unsigned int gpio)
+{
+	struct pio_device *pio;
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
 void portmux_set_func(unsigned int portmux_id, unsigned int pin_id,
 		      unsigned int function_id)
 {
@@ -48,6 +64,93 @@ void portmux_set_func(unsigned int portm
 	pio_writel(pio, PDR, mask);
 }
 
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
+	if (test_and_set_bit(pin, &pio->alloc_mask))
+		return -EBUSY;
+
+	pio_writel(pio, PER, 1 << pin);
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
+	BUG_ON(!pio);
+
+	pin = gpio & 0x1f;
+	clear_bit(pin, &pio->alloc_mask);
+}
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
+
 static int __init pio_probe(struct platform_device *pdev)
 {
 	struct pio_device *pio = NULL;
diff --git a/include/asm-avr32/arch-at32ap/at32ap7000.h b/include/asm-avr32/arch-at32ap/at32ap7000.h
new file mode 100644
index 0000000..b84fdf7
--- /dev/null
+++ b/include/asm-avr32/arch-at32ap/at32ap7000.h
@@ -0,0 +1,139 @@
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
+ * also be used as IRQ numbers.
+ */
+#define GPIO_PIOA_BASE	(0)
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
diff --git a/include/asm-avr32/arch-at32ap/gpio.h b/include/asm-avr32/arch-at32ap/gpio.h
new file mode 100644
index 0000000..411a686
--- /dev/null
+++ b/include/asm-avr32/arch-at32ap/gpio.h
@@ -0,0 +1,25 @@
+#ifndef __ASM_AVR32_GPIO_H
+#define __ASM_AVR32_GPIO_H
+
+#include <linux/compiler.h>
+#include <asm/irq.h>
+
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
@@ -2,8 +2,12 @@ #ifndef __ASM_AVR32_IRQ_H
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
1.4.3.2

