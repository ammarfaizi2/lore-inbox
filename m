Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbVLLMCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbVLLMCI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 07:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbVLLMCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 07:02:08 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53773 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751241AbVLLMCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 07:02:06 -0500
Date: Mon, 12 Dec 2005 12:01:57 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Fwd: [RFC] IRQ type flags
Message-ID: <20051212120157.GB10243@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20051106084012.GB25134@flint.arm.linux.org.uk> <20051212114759.GA10243@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051212114759.GA10243@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arrange for drivers which do:

	request_irq(irq, ...);
	set_irq_type(irq, ...);

or vice versa to use the new SA_TRIGGER flags with request_irq().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---

 arch/arm/mach-omap1/serial.c       |    3 +--
 arch/arm/mach-pxa/corgi.c          |    7 +++----
 arch/arm/mach-pxa/poodle.c         |    7 +++----
 arch/arm/mach-pxa/spitz.c          |    7 +++----
 arch/arm/mach-s3c2410/usb-simtec.c |    6 +++---
 drivers/i2c/chips/tps65010.c       |   11 ++++++-----
 drivers/input/keyboard/corgikbd.c  |    6 ++----
 drivers/input/keyboard/spitzkbd.c  |   27 ++++++++++++++-------------
 drivers/mfd/ucb1x00-core.c         |    5 ++---
 drivers/net/smc91x.c               |    5 +----
 drivers/net/smc91x.h               |   18 +++++++++---------
 11 files changed, 47 insertions(+), 55 deletions(-)

diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@ -252,9 +252,8 @@ static void __init omap_serial_set_port_
 		return;
 	}
 	omap_set_gpio_direction(gpio_nr, 1);
-	set_irq_type(OMAP_GPIO_IRQ(gpio_nr), IRQT_RISING);
 	ret = request_irq(OMAP_GPIO_IRQ(gpio_nr), &omap_serial_wake_interrupt,
-			  0, "serial wakeup", NULL);
+			  SA_TRIGGER_RISING, "serial wakeup", NULL);
 	if (ret) {
 		omap_free_gpio(gpio_nr);
 		printk(KERN_ERR "No interrupt for UART wake GPIO: %i\n",
diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -213,15 +213,14 @@ static int corgi_mci_init(struct device 
 
 	corgi_mci_platform_data.detect_delay = msecs_to_jiffies(250);
 
-	err = request_irq(CORGI_IRQ_GPIO_nSD_DETECT, corgi_detect_int, SA_INTERRUPT,
-			     "MMC card detect", data);
+	err = request_irq(CORGI_IRQ_GPIO_nSD_DETECT, corgi_detect_int,
+			  SA_INTERRUPT | SA_TRIGGER_RISING | SA_TRIGGER_FALLING,
+			  "MMC card detect", data);
 	if (err) {
 		printk(KERN_ERR "corgi_mci_init: MMC/SD: can't request MMC card detect IRQ\n");
 		return -1;
 	}
 
-	set_irq_type(CORGI_IRQ_GPIO_nSD_DETECT, IRQT_BOTHEDGE);
-
 	return 0;
 }
 
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -146,15 +146,14 @@ static int poodle_mci_init(struct device
 
 	poodle_mci_platform_data.detect_delay = msecs_to_jiffies(250);
 
-	err = request_irq(POODLE_IRQ_GPIO_nSD_DETECT, poodle_detect_int, SA_INTERRUPT,
-			     "MMC card detect", data);
+	err = request_irq(POODLE_IRQ_GPIO_nSD_DETECT, poodle_detect_int,
+			  SA_INTERRUPT | SA_TRIGGER_RISING | SA_TRIGGER_FALLING,
+			  "MMC card detect", data);
 	if (err) {
 		printk(KERN_ERR "poodle_mci_init: MMC/SD: can't request MMC card detect IRQ\n");
 		return -1;
 	}
 
-	set_irq_type(POODLE_IRQ_GPIO_nSD_DETECT, IRQT_BOTHEDGE);
-
 	return 0;
 }
 
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -293,15 +293,14 @@ static int spitz_mci_init(struct device 
 
 	spitz_mci_platform_data.detect_delay = msecs_to_jiffies(250);
 
-	err = request_irq(SPITZ_IRQ_GPIO_nSD_DETECT, spitz_detect_int, SA_INTERRUPT,
-			     "MMC card detect", data);
+	err = request_irq(SPITZ_IRQ_GPIO_nSD_DETECT, spitz_detect_int,
+			  SA_INTERRUPT | SA_TRIGGER_RISING | SA_TRIGGER_FALLING,
+			  "MMC card detect", data);
 	if (err) {
 		printk(KERN_ERR "spitz_mci_init: MMC/SD: can't request MMC card detect IRQ\n");
 		return -1;
 	}
 
-	set_irq_type(SPITZ_IRQ_GPIO_nSD_DETECT, IRQT_BOTHEDGE);
-
 	return 0;
 }
 
diff --git a/arch/arm/mach-s3c2410/usb-simtec.c b/arch/arm/mach-s3c2410/usb-simtec.c
--- a/arch/arm/mach-s3c2410/usb-simtec.c
+++ b/arch/arm/mach-s3c2410/usb-simtec.c
@@ -84,13 +84,13 @@ static void usb_simtec_enableoc(struct s
 	int ret;
 
 	if (on) {
-		ret = request_irq(IRQ_USBOC, usb_simtec_ocirq, SA_INTERRUPT,
+		ret = request_irq(IRQ_USBOC, usb_simtec_ocirq,
+				  SA_INTERRUPT | SA_TRIGGER_RISING |
+				   SA_TRIGGER_FALLING,
 				  "USB Over-current", info);
 		if (ret != 0) {
 			printk(KERN_ERR "failed to request usb oc irq\n");
 		}
-
-		set_irq_type(IRQ_USBOC, IRQT_BOTHEDGE);
 	} else {
 		free_irq(IRQ_USBOC, info);
 	}
diff --git a/drivers/i2c/chips/tps65010.c b/drivers/i2c/chips/tps65010.c
--- a/drivers/i2c/chips/tps65010.c
+++ b/drivers/i2c/chips/tps65010.c
@@ -494,6 +494,7 @@ tps65010_probe(struct i2c_adapter *bus, 
 {
 	struct tps65010		*tps;
 	int			status;
+	unsigned long		irqflags;
 
 	if (the_tps) {
 		dev_dbg(&bus->dev, "only one %s for now\n", DRIVER_NAME);
@@ -520,13 +521,14 @@ tps65010_probe(struct i2c_adapter *bus, 
 	}
 
 #ifdef	CONFIG_ARM
+	irqflags = SA_SAMPLE_RANDOM | SA_TRIGGER_LOW;
 	if (machine_is_omap_h2()) {
 		tps->model = TPS65010;
 		omap_cfg_reg(W4_GPIO58);
 		tps->irq = OMAP_GPIO_IRQ(58);
 		omap_request_gpio(58);
 		omap_set_gpio_direction(58, 1);
-		set_irq_type(tps->irq, IRQT_FALLING);
+		irqflags |= SA_TRIGGER_FALLING;
 	}
 	if (machine_is_omap_osk()) {
 		tps->model = TPS65010;
@@ -534,7 +536,7 @@ tps65010_probe(struct i2c_adapter *bus, 
 		tps->irq = OMAP_GPIO_IRQ(OMAP_MPUIO(1));
 		omap_request_gpio(OMAP_MPUIO(1));
 		omap_set_gpio_direction(OMAP_MPUIO(1), 1);
-		set_irq_type(tps->irq, IRQT_FALLING);
+		irqflags |= SA_TRIGGER_FALLING;
 	}
 	if (machine_is_omap_h3()) {
 		tps->model = TPS65013;
@@ -542,13 +544,12 @@ tps65010_probe(struct i2c_adapter *bus, 
 		// FIXME set up this board's IRQ ...
 	}
 #else
-#define set_irq_type(num,trigger)	do{}while(0)
+	irqflags = SA_SAMPLE_RANDOM;
 #endif
 
 	if (tps->irq > 0) {
-		set_irq_type(tps->irq, IRQT_LOW);
 		status = request_irq(tps->irq, tps65010_irq,
-			SA_SAMPLE_RANDOM, DRIVER_NAME, tps);
+			irqflags, DRIVER_NAME, tps);
 		if (status < 0) {
 			dev_dbg(&tps->client.dev, "can't get IRQ %d, err %d\n",
 					tps->irq, status);
diff --git a/drivers/input/keyboard/corgikbd.c b/drivers/input/keyboard/corgikbd.c
--- a/drivers/input/keyboard/corgikbd.c
+++ b/drivers/input/keyboard/corgikbd.c
@@ -19,7 +19,6 @@
 #include <linux/jiffies.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <asm/irq.h>
 
 #include <asm/arch/corgi.h>
 #include <asm/arch/hardware.h>
@@ -343,10 +342,9 @@ static int __init corgikbd_probe(struct 
 	for (i = 0; i < CORGI_KEY_SENSE_NUM; i++) {
 		pxa_gpio_mode(CORGI_GPIO_KEY_SENSE(i) | GPIO_IN);
 		if (request_irq(CORGI_IRQ_GPIO_KEY_SENSE(i), corgikbd_interrupt,
-						SA_INTERRUPT, "corgikbd", corgikbd))
+				SA_INTERRUPT | SA_TRIGGER_RISING,
+				"corgikbd", corgikbd))
 			printk(KERN_WARNING "corgikbd: Can't get IRQ: %d!\n", i);
-		else
-			set_irq_type(CORGI_IRQ_GPIO_KEY_SENSE(i),IRQT_RISING);
 	}
 
 	/* Set Strobe lines as outputs - set high */
diff --git a/drivers/input/keyboard/spitzkbd.c b/drivers/input/keyboard/spitzkbd.c
--- a/drivers/input/keyboard/spitzkbd.c
+++ b/drivers/input/keyboard/spitzkbd.c
@@ -19,7 +19,6 @@
 #include <linux/jiffies.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <asm/irq.h>
 
 #include <asm/arch/spitz.h>
 #include <asm/arch/hardware.h>
@@ -407,10 +406,9 @@ static int __init spitzkbd_probe(struct 
 	for (i = 0; i < SPITZ_KEY_SENSE_NUM; i++) {
 		pxa_gpio_mode(spitz_senses[i] | GPIO_IN);
 		if (request_irq(IRQ_GPIO(spitz_senses[i]), spitzkbd_interrupt,
-						SA_INTERRUPT, "Spitzkbd Sense", spitzkbd))
+				SA_INTERRUPT|SA_TRIGGER_RISING,
+				"Spitzkbd Sense", spitzkbd))
 			printk(KERN_WARNING "spitzkbd: Can't get Sense IRQ: %d!\n", i);
-		else
-			set_irq_type(IRQ_GPIO(spitz_senses[i]),IRQT_RISING);
 	}
 
 	/* Set Strobe lines as outputs - set high */
@@ -422,15 +420,18 @@ static int __init spitzkbd_probe(struct 
 	pxa_gpio_mode(SPITZ_GPIO_SWA | GPIO_IN);
 	pxa_gpio_mode(SPITZ_GPIO_SWB | GPIO_IN);
 
-	request_irq(SPITZ_IRQ_GPIO_SYNC, spitzkbd_interrupt, SA_INTERRUPT, "Spitzkbd Sync", spitzkbd);
-	request_irq(SPITZ_IRQ_GPIO_ON_KEY, spitzkbd_interrupt, SA_INTERRUPT, "Spitzkbd PwrOn", spitzkbd);
-	request_irq(SPITZ_IRQ_GPIO_SWA, spitzkbd_hinge_isr, SA_INTERRUPT, "Spitzkbd SWA", spitzkbd);
-	request_irq(SPITZ_IRQ_GPIO_SWB, spitzkbd_hinge_isr, SA_INTERRUPT, "Spitzkbd SWB", spitzkbd);
-
-	set_irq_type(SPITZ_IRQ_GPIO_SYNC, IRQT_BOTHEDGE);
-	set_irq_type(SPITZ_IRQ_GPIO_ON_KEY, IRQT_BOTHEDGE);
-	set_irq_type(SPITZ_IRQ_GPIO_SWA, IRQT_BOTHEDGE);
-	set_irq_type(SPITZ_IRQ_GPIO_SWB, IRQT_BOTHEDGE);
+	request_irq(SPITZ_IRQ_GPIO_SYNC, spitzkbd_interrupt,
+		    SA_INTERRUPT | SA_TRIGGER_RISING | SA_TRIGGER_FALLING,
+		    "Spitzkbd Sync", spitzkbd);
+	request_irq(SPITZ_IRQ_GPIO_ON_KEY, spitzkbd_interrupt,
+		    SA_INTERRUPT | SA_TRIGGER_RISING | SA_TRIGGER_FALLING,
+		    "Spitzkbd PwrOn", spitzkbd);
+	request_irq(SPITZ_IRQ_GPIO_SWA, spitzkbd_hinge_isr,
+		    SA_INTERRUPT | SA_TRIGGER_RISING | SA_TRIGGER_FALLING,
+		    "Spitzkbd SWA", spitzkbd);
+	request_irq(SPITZ_IRQ_GPIO_SWB, spitzkbd_hinge_isr,
+		    SA_INTERRUPT | SA_TRIGGER_RISING | SA_TRIGGER_FALLING,
+		    "Spitzkbd SWB", spitzkbd);
 
 	printk(KERN_INFO "input: Spitz Keyboard Registered\n");
 
diff --git a/drivers/mfd/ucb1x00-core.c b/drivers/mfd/ucb1x00-core.c
--- a/drivers/mfd/ucb1x00-core.c
+++ b/drivers/mfd/ucb1x00-core.c
@@ -27,7 +27,6 @@
 
 #include <asm/dma.h>
 #include <asm/hardware.h>
-#include <asm/irq.h>
 
 #include "ucb1x00.h"
 
@@ -507,14 +506,14 @@ static int ucb1x00_probe(struct mcp *mcp
 		goto err_free;
 	}
 
-	ret = request_irq(ucb->irq, ucb1x00_irq, 0, "UCB1x00", ucb);
+	ret = request_irq(ucb->irq, ucb1x00_irq, SA_TRIGGER_RISING,
+			  "UCB1x00", ucb);
 	if (ret) {
 		printk(KERN_ERR "ucb1x00: unable to grab irq%d: %d\n",
 			ucb->irq, ret);
 		goto err_free;
 	}
 
-	set_irq_type(ucb->irq, IRQT_RISING);
 	mcp_set_drvdata(mcp, ucb);
 
 	ret = class_device_register(&ucb->cdev);
diff --git a/drivers/net/smc91x.c b/drivers/net/smc91x.c
--- a/drivers/net/smc91x.c
+++ b/drivers/net/smc91x.c
@@ -88,7 +88,6 @@ static const char version[] =
 #include <linux/skbuff.h>
 
 #include <asm/io.h>
-#include <asm/irq.h>
 
 #include "smc91x.h"
 
@@ -2007,12 +2006,10 @@ static int __init smc_probe(struct net_d
 	}
 
 	/* Grab the IRQ */
-      	retval = request_irq(dev->irq, &smc_interrupt, 0, dev->name, dev);
+      	retval = request_irq(dev->irq, &smc_interrupt, SMC_IRQ_FLAGS, dev->name, dev);
       	if (retval)
       		goto err_out;
 
-	set_irq_type(dev->irq, SMC_IRQ_TRIGGER_TYPE);
-
 #ifdef SMC_USE_PXA_DMA
 	{
 		int dma = pxa_request_dma(dev->name, DMA_PRIO_LOW,
diff --git a/drivers/net/smc91x.h b/drivers/net/smc91x.h
--- a/drivers/net/smc91x.h
+++ b/drivers/net/smc91x.h
@@ -90,7 +90,7 @@
 			__l--;						\
 		}							\
 	} while (0)
-#define set_irq_type(irq, type)
+#define SMC_IRQ_FLAGS		(0)
 
 #elif defined(CONFIG_SA1100_PLEB)
 /* We can only do 16-bit reads and writes in the static memory space. */
@@ -109,7 +109,7 @@
 #define SMC_outw(v, a, r)	writew(v, (a) + (r))
 #define SMC_outsw(a, r, p, l)	writesw((a) + (r), p, l)
 
-#define set_irq_type(irq, type) do {} while (0)
+#define SMC_IRQ_FLAGS		(0)
 
 #elif defined(CONFIG_SA1100_ASSABET)
 
@@ -185,11 +185,11 @@ SMC_outw(u16 val, void __iomem *ioaddr, 
 #include <asm/mach-types.h>
 #include <asm/arch/cpu.h>
 
-#define	SMC_IRQ_TRIGGER_TYPE (( \
+#define	SMC_IRQ_FLAGS (( \
 		   machine_is_omap_h2() \
 		|| machine_is_omap_h3() \
 		|| (machine_is_omap_innovator() && !cpu_is_omap1510()) \
-	) ? IRQT_FALLING : IRQT_RISING)
+	) ? SA_TRIGGER_FALLING : SA_TRIGGER_RISING)
 
 
 #elif	defined(CONFIG_SH_SH4202_MICRODEV)
@@ -209,7 +209,7 @@ SMC_outw(u16 val, void __iomem *ioaddr, 
 #define SMC_insw(a, r, p, l)	insw((a) + (r) - 0xa0000000, p, l)
 #define SMC_outsw(a, r, p, l)	outsw((a) + (r) - 0xa0000000, p, l)
 
-#define set_irq_type(irq, type)	do {} while(0)
+#define SMC_IRQ_FLAGS		(0)
 
 #elif	defined(CONFIG_ISA)
 
@@ -237,7 +237,7 @@ SMC_outw(u16 val, void __iomem *ioaddr, 
 #define SMC_insw(a, r, p, l)	insw(((u32)a) + (r), p, l)
 #define SMC_outsw(a, r, p, l)	outsw(((u32)a) + (r), p, l)
 
-#define set_irq_type(irq, type)	do {} while(0)
+#define SMC_IRQ_FLAGS		(0)
 
 #define RPC_LSA_DEFAULT		RPC_LED_TX_RX
 #define RPC_LSB_DEFAULT		RPC_LED_100_10
@@ -319,7 +319,7 @@ static inline void SMC_outsw (unsigned l
 			au_writew(*_p++ , _a); \
 	} while(0)
 
-#define set_irq_type(irq, type) do {} while (0)
+#define SMC_IRQ_FLAGS		(0)
 
 #else
 
@@ -342,8 +342,8 @@ static inline void SMC_outsw (unsigned l
 
 #endif
 
-#ifndef	SMC_IRQ_TRIGGER_TYPE
-#define	SMC_IRQ_TRIGGER_TYPE	IRQT_RISING
+#ifndef	SMC_IRQ_FLAGS
+#define	SMC_IRQ_FLAGS		SA_TRIGGER_RISING
 #endif
 
 #ifdef SMC_USE_PXA_DMA

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
