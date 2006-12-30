Return-Path: <linux-kernel-owner+w=401wt.eu-S1030197AbWL3BOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbWL3BOI (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 20:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030198AbWL3BOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 20:14:08 -0500
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:22357 "HELO
	smtp110.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1030197AbWL3BOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 20:14:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=V4Z+m7B3rvOolkidKiARoxDw4XsTsErJVd1CFhGlAHrdE5bAae5GNL9PsDG//JA1tgWjUzuosDYS3qvW0V7fonYnBTuj5CGS9ec+1XNfcrswB+LZVFjjMjwM1HEOiY3ncNRwLAha6jd/pjKyku/l3mvPOYDdCY4tiwjSgZTuv0w=  ;
X-YMail-OSG: UqkUZ9cVM1mhN.I5baSu1YaFgMvwTOSKWzXvP43.wYT.YfXJZqocftWV8qlCfqNossI.fyNs_5F2GA6VTYxeXQW5UA4S1zksxUvq074Z.1c4d3r8rvwDSys8pvrEzCfQQZfQhv94Z5xrIiw-
From: David Brownell <david-b@pacbell.net>
To: "pHilipp Zabel" <philipp.zabel@gmail.com>
Subject: Re: [patch 2.6.20-rc1 4/6] PXA GPIO wrappers
Date: Fri, 29 Dec 2006 17:13:52 -0800
User-Agent: KMail/1.7.1
Cc: "Nicolas Pitre" <nico@cam.org>, "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Andrew Victor" <andrew@sanpeople.com>,
       "Bill Gatliff" <bgat@billgatliff.com>,
       "Haavard Skinnemoen" <hskinnemoen@atmel.com>,
       "Kevin Hilman" <khilman@mvista.com>,
       "Russell King" <rmk@arm.linux.org.uk>,
       "Tony Lindgren" <tony@atomide.com>
References: <200611111541.34699.david-b@pacbell.net> <Pine.LNX.4.64.0612211457390.18171@xanadu.home> <74d0deb30612212253s7d35cf92q80bbebe9d8ae9476@mail.gmail.com>
In-Reply-To: <74d0deb30612212253s7d35cf92q80bbebe9d8ae9476@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612291713.53558.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just FYI -- I updated your patch, fixed a compile bug, and switched
some code over to use this new API.  The patch is appended.

I happen to think it's a lot easier to read this way.  Maybe to some
people it's easy to remember what a GPLR, GPCR, and GPSR register is
supposed to do, after a long time away from PXA or StrongARM platform
code; I'm not one of them.

And on a side note, yes it would make sense for someone to update the
GPIO IRQ support to properly manage PWER, so there's less need for
board-specific PM glue code.  :)

- Dave



This is an UNTESTED bunch of conversions of PXA code to use the new GPIO
interfaces, and other build/warning fixes.  It's not complete, or even
fully reviewed; but it builds.

Note that the idioms in the API are, as with other architectures, a very
direct match for the existing code ... and so the conversions are easy
to do and to review.

 arch/arm/mach-pxa/corgi.c           |   13 ++++---------
 arch/arm/mach-pxa/corgi_lcd.c       |    8 ++++++--
 arch/arm/mach-pxa/corgi_pm.c        |   25 ++++++++++---------------
 arch/arm/mach-pxa/corgi_ssp.c       |   18 ++++++++++--------
 arch/arm/mach-pxa/sharpsl.h         |    6 ------
 arch/arm/mach-pxa/spitz_pm.c        |    6 +++---
 drivers/usb/gadget/pxa2xx_udc.c     |   20 ++++++++++++++------
 drivers/usb/gadget/pxa2xx_udc.h     |   21 ++-------------------
 drivers/video/backlight/corgi_bl.c  |    2 +-
 drivers/video/backlight/locomolcd.c |    3 ++-
 10 files changed, 52 insertions(+), 70 deletions(-)

Index: pxa/arch/arm/mach-pxa/corgi.c
===================================================================
--- pxa.orig/arch/arm/mach-pxa/corgi.c	2006-12-10 01:30:42.000000000 -0800
+++ pxa/arch/arm/mach-pxa/corgi.c	2006-12-29 16:44:15.000000000 -0800
@@ -28,6 +28,7 @@
 #include <asm/irq.h>
 #include <asm/io.h>
 #include <asm/system.h>
+#include <asm/gpio.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -239,15 +240,12 @@ static void corgi_mci_setpower(struct de
 {
 	struct pxamci_platform_data* p_d = dev->platform_data;
 
-	if (( 1 << vdd) & p_d->ocr_mask)
-		GPSR1 = GPIO_bit(CORGI_GPIO_SD_PWR);
-	else
-		GPCR1 = GPIO_bit(CORGI_GPIO_SD_PWR);
+	gpio_set_value(CORGI_GPIO_SD_PWR, (1 << vdd) & p_d->ocr_mask);
 }
 
 static int corgi_mci_get_ro(struct device *dev)
 {
-	return GPLR(CORGI_GPIO_nSD_WP) & GPIO_bit(CORGI_GPIO_nSD_WP);
+	return gpio_get_value(CORGI_GPIO_nSD_WP);
 }
 
 static void corgi_mci_exit(struct device *dev, void *data)
@@ -269,10 +267,7 @@ static struct pxamci_platform_data corgi
  */
 static void corgi_irda_transceiver_mode(struct device *dev, int mode)
 {
-	if (mode & IR_OFF)
-		GPSR(CORGI_GPIO_IR_ON) = GPIO_bit(CORGI_GPIO_IR_ON);
-	else
-		GPCR(CORGI_GPIO_IR_ON) = GPIO_bit(CORGI_GPIO_IR_ON);
+	gpio_set_value(CORGI_GPIO_IR_ON, mode & IR_OFF);
 }
 
 static struct pxaficp_platform_data corgi_ficp_platform_data = {
Index: pxa/drivers/usb/gadget/pxa2xx_udc.h
===================================================================
--- pxa.orig/drivers/usb/gadget/pxa2xx_udc.h	2006-12-10 01:31:53.000000000 -0800
+++ pxa/drivers/usb/gadget/pxa2xx_udc.h	2006-12-29 16:32:41.000000000 -0800
@@ -139,6 +139,8 @@ struct pxa2xx_udc {
 	struct pxa2xx_ep			ep [PXA_UDC_NUM_ENDPOINTS];
 };
 
+static struct pxa2xx_udc *the_controller;
+
 /*-------------------------------------------------------------------------*/
 
 #ifdef CONFIG_ARCH_LUBBOCK
@@ -175,25 +177,6 @@ struct pxa2xx_udc {
 
 /*-------------------------------------------------------------------------*/
 
-static struct pxa2xx_udc *the_controller;
-
-static inline int pxa_gpio_get(unsigned gpio)
-{
-	return (GPLR(gpio) & GPIO_bit(gpio)) != 0;
-}
-
-static inline void pxa_gpio_set(unsigned gpio, int is_on)
-{
-	int mask = GPIO_bit(gpio);
-
-	if (is_on)
-		GPSR(gpio) = mask;
-	else
-		GPCR(gpio) = mask;
-}
-
-/*-------------------------------------------------------------------------*/
-
 /*
  * Debugging support vanishes in non-debug builds.  DBG_NORMAL should be
  * mostly silent during normal use/testing, with no timing side-effects.
Index: pxa/arch/arm/mach-pxa/corgi_ssp.c
===================================================================
--- pxa.orig/arch/arm/mach-pxa/corgi_ssp.c	2006-12-10 01:30:42.000000000 -0800
+++ pxa/arch/arm/mach-pxa/corgi_ssp.c	2006-12-29 16:16:18.000000000 -0800
@@ -16,6 +16,8 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
+
+#include <asm/gpio.h>
 #include <asm/hardware.h>
 #include <asm/mach-types.h>
 
@@ -52,13 +54,13 @@ unsigned long corgi_ssp_ads7846_putget(u
 
 	spin_lock_irqsave(&corgi_ssp_lock, flag);
 	if (ssp_machinfo->cs_ads7846 >= 0)
-		GPCR(ssp_machinfo->cs_ads7846) = GPIO_bit(ssp_machinfo->cs_ads7846);
+		gpio_set_value(ssp_machinfo->cs_ads7846, 0);
 
 	ssp_write_word(&corgi_ssp_dev,data);
  	ssp_read_word(&corgi_ssp_dev, &ret);
 
 	if (ssp_machinfo->cs_ads7846 >= 0)
-		GPSR(ssp_machinfo->cs_ads7846) = GPIO_bit(ssp_machinfo->cs_ads7846);
+		gpio_set_value(ssp_machinfo->cs_ads7846, 1);
 	spin_unlock_irqrestore(&corgi_ssp_lock, flag);
 
 	return ret;
@@ -78,7 +80,7 @@ void corgi_ssp_ads7846_lock(void)
 void corgi_ssp_ads7846_unlock(void)
 {
 	if (ssp_machinfo->cs_ads7846 >= 0)
-		GPSR(ssp_machinfo->cs_ads7846) = GPIO_bit(ssp_machinfo->cs_ads7846);
+		gpio_set_value(ssp_machinfo->cs_ads7846, 1);
 	spin_unlock(&corgi_ssp_lock);
 }
 
@@ -124,7 +126,7 @@ unsigned long corgi_ssp_dac_put(ulong da
 	/* Read null data back from device to prevent SSP overflow */
 	ssp_read_word(&corgi_ssp_dev, &tmp);
 	if (ssp_machinfo->cs_lcdcon >= 0)
-		GPSR(ssp_machinfo->cs_lcdcon) = GPIO_bit(ssp_machinfo->cs_lcdcon);
+		gpio_set_value(ssp_machinfo->cs_lcdcon, 1);
 
 	ssp_disable(&corgi_ssp_dev);
 	ssp_config(&corgi_ssp_dev, (SSCR0_National | (SSCR0_DSS & 0x0b )), 0, 0, SSCR0_SerClkDiv(ssp_machinfo->clk_ads7846));
@@ -181,7 +183,7 @@ int corgi_ssp_max1111_get(ulong data)
 	ssp_config(&corgi_ssp_dev, (SSCR0_National | (SSCR0_DSS & 0x0b )), 0, 0, SSCR0_SerClkDiv(ssp_machinfo->clk_ads7846));
 	ssp_enable(&corgi_ssp_dev);
 	if (ssp_machinfo->cs_max1111 >= 0)
-		GPSR(ssp_machinfo->cs_max1111) = GPIO_bit(ssp_machinfo->cs_max1111);
+		gpio_set_value(ssp_machinfo->cs_max1111, 1);
 	spin_unlock_irqrestore(&corgi_ssp_lock, flag);
 
 	if (voltage1 & 0xc0 || voltage2 & 0x3f)
@@ -245,11 +247,11 @@ static int corgi_ssp_suspend(struct plat
 static int corgi_ssp_resume(struct platform_device *dev)
 {
 	if (ssp_machinfo->cs_lcdcon >= 0)
-		GPSR(ssp_machinfo->cs_lcdcon) = GPIO_bit(ssp_machinfo->cs_lcdcon);  /* High - Disable LCD Control/Timing Gen */
+		gpio_set_value(ssp_machinfo->cs_lcdcon, 1);  /* High - Disable LCD Control/Timing Gen */
 	if (ssp_machinfo->cs_max1111 >= 0)
-		GPSR(ssp_machinfo->cs_max1111) = GPIO_bit(ssp_machinfo->cs_max1111); /* High - Disable MAX1111*/
+		gpio_set_value(ssp_machinfo->cs_max1111, 1); /* High - Disable MAX1111*/
 	if (ssp_machinfo->cs_ads7846 >= 0)
-		GPSR(ssp_machinfo->cs_ads7846) = GPIO_bit(ssp_machinfo->cs_ads7846); /* High - Disable ADS7846*/
+		gpio_set_value(ssp_machinfo->cs_ads7846, 1); /* High - Disable ADS7846*/
 	ssp_restore_state(&corgi_ssp_dev,&corgi_ssp_state);
 	ssp_enable(&corgi_ssp_dev);
 
Index: pxa/drivers/usb/gadget/pxa2xx_udc.c
===================================================================
--- pxa.orig/drivers/usb/gadget/pxa2xx_udc.c	2006-12-27 13:38:43.000000000 -0800
+++ pxa/drivers/usb/gadget/pxa2xx_udc.c	2006-12-29 16:45:58.000000000 -0800
@@ -47,6 +47,7 @@
 
 #include <asm/byteorder.h>
 #include <asm/dma.h>
+#include <asm/gpio.h>
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/mach-types.h>
@@ -156,7 +157,7 @@ static int is_vbus_present(void)
 	struct pxa2xx_udc_mach_info		*mach = the_controller->mach;
 
 	if (mach->gpio_vbus)
-		return pxa_gpio_get(mach->gpio_vbus);
+		return gpio_get_value(mach->gpio_vbus);
 	if (mach->udc_is_connected)
 		return mach->udc_is_connected();
 	return 1;
@@ -168,7 +169,7 @@ static void pullup_off(void)
 	struct pxa2xx_udc_mach_info		*mach = the_controller->mach;
 
 	if (mach->gpio_pullup)
-		pxa_gpio_set(mach->gpio_pullup, 0);
+		gpio_set_value(mach->gpio_pullup, 0);
 	else if (mach->udc_command)
 		mach->udc_command(PXA2XX_UDC_CMD_DISCONNECT);
 }
@@ -178,7 +179,7 @@ static void pullup_on(void)
 	struct pxa2xx_udc_mach_info		*mach = the_controller->mach;
 
 	if (mach->gpio_pullup)
-		pxa_gpio_set(mach->gpio_pullup, 1);
+		gpio_set_value(mach->gpio_pullup, 1);
 	else if (mach->udc_command)
 		mach->udc_command(PXA2XX_UDC_CMD_CONNECT);
 }
@@ -1636,7 +1637,14 @@ int usb_gadget_register_driver(struct us
 	dev->gadget.dev.driver = &driver->driver;
 	dev->pullup = 1;
 
-	device_add (&dev->gadget.dev);
+	retval = device_add (&dev->gadget.dev);
+	if (retval < 0) {
+		DMSG("add gadget dev --> error %d\n", retval);
+
+		dev->driver = NULL;
+		dev->gadget.dev.driver = NULL;
+		return retval;
+	}
 	retval = driver->bind(&dev->gadget);
 	if (retval) {
 		DMSG("bind to driver %s --> error %d\n",
@@ -1647,7 +1655,7 @@ int usb_gadget_register_driver(struct us
 		dev->gadget.dev.driver = NULL;
 		return retval;
 	}
-	device_create_file(dev->dev, &dev_attr_function);
+	retval = device_create_file(dev->dev, &dev_attr_function);
 
 	/* ... then enable host detection and ep0; and we're ready
 	 * for set_configuration as well as eventual disconnect.
@@ -1756,7 +1764,7 @@ lubbock_vbus_irq(int irq, void *_dev)
 static irqreturn_t udc_vbus_irq(int irq, void *_dev)
 {
 	struct pxa2xx_udc	*dev = _dev;
-	int			vbus = pxa_gpio_get(dev->mach->gpio_vbus);
+	int			vbus = gpio_get_value(dev->mach->gpio_vbus);
 
 	pxa2xx_udc_vbus_session(&dev->gadget, vbus);
 	return IRQ_HANDLED;
Index: pxa/arch/arm/mach-pxa/corgi_pm.c
===================================================================
--- pxa.orig/arch/arm/mach-pxa/corgi_pm.c	2006-12-10 01:30:42.000000000 -0800
+++ pxa/arch/arm/mach-pxa/corgi_pm.c	2006-12-29 16:57:32.000000000 -0800
@@ -20,6 +20,7 @@
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 #include <asm/hardware.h>
+#include <asm/gpio.h>
 #include <asm/hardware/scoop.h>
 
 #include <asm/arch/sharpsl.h>
@@ -45,10 +46,7 @@ static void corgi_charger_init(void)
 
 static void corgi_measure_temp(int on)
 {
-	if (on)
-		GPSR(CORGI_GPIO_ADC_TEMP_ON) = GPIO_bit(CORGI_GPIO_ADC_TEMP_ON);
-	else
-		GPCR(CORGI_GPIO_ADC_TEMP_ON) = GPIO_bit(CORGI_GPIO_ADC_TEMP_ON);
+	gpio_set_value(CORGI_GPIO_ADC_TEMP_ON, on);
 }
 
 static void corgi_charge(int on)
@@ -69,10 +67,7 @@ static void corgi_charge(int on)
 
 static void corgi_discharge(int on)
 {
-	if (on)
-		GPSR(CORGI_GPIO_DISCHARGE_ON) = GPIO_bit(CORGI_GPIO_DISCHARGE_ON);
-	else
-		GPCR(CORGI_GPIO_DISCHARGE_ON) = GPIO_bit(CORGI_GPIO_DISCHARGE_ON);
+	gpio_set_value(CORGI_GPIO_DISCHARGE_ON, on);
 }
 
 static void corgi_presuspend(void)
@@ -81,17 +76,17 @@ static void corgi_presuspend(void)
 	unsigned long wakeup_mask;
 
 	/* charging , so CHARGE_ON bit is HIGH during OFF. */
-	if (READ_GPIO_BIT(CORGI_GPIO_CHRG_ON))
+	if (gpio_get_value(CORGI_GPIO_CHRG_ON))
 		PGSR1 |= GPIO_bit(CORGI_GPIO_CHRG_ON);
 	else
 		PGSR1 &= ~GPIO_bit(CORGI_GPIO_CHRG_ON);
 
-	if (READ_GPIO_BIT(CORGI_GPIO_LED_ORANGE))
+	if (gpio_get_value(CORGI_GPIO_LED_ORANGE))
 		PGSR0 |= GPIO_bit(CORGI_GPIO_LED_ORANGE);
 	else
 		PGSR0 &= ~GPIO_bit(CORGI_GPIO_LED_ORANGE);
 
-	if (READ_GPIO_BIT(CORGI_GPIO_CHRG_UKN))
+	if (gpio_get_value(CORGI_GPIO_CHRG_UKN))
 		PGSR1 |= GPIO_bit(CORGI_GPIO_CHRG_UKN);
 	else
 		PGSR1 &= ~GPIO_bit(CORGI_GPIO_CHRG_UKN);
@@ -171,13 +166,13 @@ unsigned long corgipm_read_devdata(int t
 {
 	switch(type) {
 	case SHARPSL_STATUS_ACIN:
-		return ((GPLR(CORGI_GPIO_AC_IN) & GPIO_bit(CORGI_GPIO_AC_IN)) != 0);
+		return gpio_get_value(CORGI_GPIO_AC_IN) != 0;
 	case SHARPSL_STATUS_LOCK:
-		return READ_GPIO_BIT(sharpsl_pm.machinfo->gpio_batlock);
+		return gpio_get_value(sharpsl_pm.machinfo->gpio_batlock);
 	case SHARPSL_STATUS_CHRGFULL:
-		return READ_GPIO_BIT(sharpsl_pm.machinfo->gpio_batfull);
+		return gpio_get_value(sharpsl_pm.machinfo->gpio_batfull);
 	case SHARPSL_STATUS_FATAL:
-		return READ_GPIO_BIT(sharpsl_pm.machinfo->gpio_fatal);
+		return gpio_get_value(sharpsl_pm.machinfo->gpio_fatal);
 	case SHARPSL_ACIN_VOLT:
 		return sharpsl_pm_pxa_read_max1111(MAX1111_ACIN_VOLT);
 	case SHARPSL_BATT_TEMP:
Index: pxa/drivers/video/backlight/corgi_bl.c
===================================================================
--- pxa.orig/drivers/video/backlight/corgi_bl.c	2006-12-10 01:31:55.000000000 -0800
+++ pxa/drivers/video/backlight/corgi_bl.c	2006-12-29 16:34:41.000000000 -0800
@@ -121,7 +121,7 @@ static int corgibl_probe(struct platform
 		machinfo->limit_mask = -1;
 
 	corgi_backlight_device = backlight_device_register ("corgi-bl",
-		NULL, &corgibl_data);
+		&pdev->dev, NULL, &corgibl_data);
 	if (IS_ERR (corgi_backlight_device))
 		return PTR_ERR (corgi_backlight_device);
 
Index: pxa/arch/arm/mach-pxa/corgi_lcd.c
===================================================================
--- pxa.orig/arch/arm/mach-pxa/corgi_lcd.c	2006-12-10 01:30:42.000000000 -0800
+++ pxa/arch/arm/mach-pxa/corgi_lcd.c	2006-12-29 16:45:42.000000000 -0800
@@ -20,6 +20,8 @@
 #include <linux/platform_device.h>
 #include <linux/module.h>
 #include <linux/string.h>
+
+#include <asm/gpio.h>
 #include <asm/arch/akita.h>
 #include <asm/arch/corgi.h>
 #include <asm/hardware.h>
@@ -449,8 +451,10 @@ static unsigned long (*get_hsync_time)(s
 
 static void inline sharpsl_wait_sync(int gpio)
 {
-	while((GPLR(gpio) & GPIO_bit(gpio)) == 0);
-	while((GPLR(gpio) & GPIO_bit(gpio)) != 0);
+	while (gpio_get_value(gpio) == 0)
+		continue;
+	while (gpio_get_value(gpio) != 0)
+		continue;
 }
 
 #ifdef CONFIG_PXA_SHARP_C7xx
Index: pxa/drivers/video/backlight/locomolcd.c
===================================================================
--- pxa.orig/drivers/video/backlight/locomolcd.c	2006-12-10 01:31:55.000000000 -0800
+++ pxa/drivers/video/backlight/locomolcd.c	2006-12-29 16:37:31.000000000 -0800
@@ -184,7 +184,8 @@ static int locomolcd_probe(struct locomo
 
 	local_irq_restore(flags);
 
-	locomolcd_bl_device = backlight_device_register("locomo-bl", NULL, &locomobl_data);
+	locomolcd_bl_device = backlight_device_register("locomo-bl",
+			&ldev->dev, NULL, &locomobl_data);
 
 	if (IS_ERR (locomolcd_bl_device))
 		return PTR_ERR (locomolcd_bl_device);
Index: pxa/arch/arm/mach-pxa/spitz_pm.c
===================================================================
--- pxa.orig/arch/arm/mach-pxa/spitz_pm.c	2006-12-10 01:30:42.000000000 -0800
+++ pxa/arch/arm/mach-pxa/spitz_pm.c	2006-12-29 16:50:47.000000000 -0800
@@ -176,11 +176,11 @@ unsigned long spitzpm_read_devdata(int t
 	case SHARPSL_STATUS_ACIN:
 		return (((~GPLR(SPITZ_GPIO_AC_IN)) & GPIO_bit(SPITZ_GPIO_AC_IN)) != 0);
 	case SHARPSL_STATUS_LOCK:
-		return READ_GPIO_BIT(sharpsl_pm.machinfo->gpio_batlock);
+		return gpio_get_value(sharpsl_pm.machinfo->gpio_batlock);
 	case SHARPSL_STATUS_CHRGFULL:
-		return READ_GPIO_BIT(sharpsl_pm.machinfo->gpio_batfull);
+		return gpio_get_value(sharpsl_pm.machinfo->gpio_batfull);
 	case SHARPSL_STATUS_FATAL:
-		return READ_GPIO_BIT(sharpsl_pm.machinfo->gpio_fatal);
+		return gpio_get_value(sharpsl_pm.machinfo->gpio_fatal);
 	case SHARPSL_ACIN_VOLT:
 		return sharpsl_pm_pxa_read_max1111(MAX1111_ACIN_VOLT);
 	case SHARPSL_BATT_TEMP:
Index: pxa/arch/arm/mach-pxa/sharpsl.h
===================================================================
--- pxa.orig/arch/arm/mach-pxa/sharpsl.h	2006-12-10 01:30:42.000000000 -0800
+++ pxa/arch/arm/mach-pxa/sharpsl.h	2006-12-29 16:51:14.000000000 -0800
@@ -44,12 +44,6 @@ void corgi_wait_hsync(void);
 void spitz_wait_hsync(void);
 
 
-/*
- * SharpSL Battery/PM Driver
- */
-
-#define READ_GPIO_BIT(x)    (GPLR(x) & GPIO_bit(x))
-
 /* MAX1111 Channel Definitions */
 #define MAX1111_BATT_VOLT   4u
 #define MAX1111_BATT_TEMP   2u
