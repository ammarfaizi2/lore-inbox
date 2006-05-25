Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965071AbWEYHWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965071AbWEYHWm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 03:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbWEYHWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 03:22:09 -0400
Received: from mkedef2.rockwellautomation.com ([63.161.86.254]:10819 "EHLO
	ramilwsmtp01.ra.rockwell.com") by vger.kernel.org with ESMTP
	id S965067AbWEYHVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 03:21:43 -0400
Message-ID: <44755B2F.9090004@ra.rockwell.com>
Date: Thu, 25 May 2006 09:22:23 +0200
From: Milan Svoboda <msvoboda@ra.rockwell.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] usb gadget: update pxa2xx_udc.c and arch dependent files
 for ixp4xx
X-MIMETrack: Itemize by SMTP Server on RAMilwSMTP01/Milwaukee/RA/Rockwell(Release
 6.5.4FP1|June 19, 2005) at 05/25/2006 02:22:25 AM,
	Serialize by Router on RAMilwSMTP01/Milwaukee/RA/Rockwell(Release 6.5.4FP1|June
 19, 2005) at 05/25/2006 02:22:27 AM,
	Serialize complete at 05/25/2006 02:22:27 AM
Content-Type: multipart/mixed;
 boundary="------------000007070707080905080408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000007070707080905080408
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed

From: Milan Svoboda <msvoboda@ra.rockwell.com>

This patch adds platform device ixp4xx_gadget that uses pxa2xx-udc device
driver. Also pxa2xx_udc.c is updated so it can be compiled without errors
on IXP4XX architecture.
The patch is against 2.6.16.13.

Signed-off-by: Milan Svoboda <msvoboda@ra.rockwell.com>
---




--------------000007070707080905080408
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
 name="make_it_compile.patch"
Content-Disposition: inline;
 filename="make_it_compile.patch"

diff -urpN -X orig/Documentation/dontdiff orig/arch/arm/mach-ixp4xx/common.c new_gadget/arch/arm/mach-ixp4xx/common.c
--- orig/arch/arm/mach-ixp4xx/common.c	2006-05-15 14:38:22.000000000 +0000
+++ new_gadget/arch/arm/mach-ixp4xx/common.c	2006-05-15 14:20:20.000000000 +0000
@@ -39,6 +39,8 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 
+#include <asm/arch/udc.h>
+
 /*************************************************************************
  * IXP4xx chipset I/O mapping
  *************************************************************************/
@@ -334,8 +336,41 @@ static struct platform_device ixp46x_i2c
 	.resource	= ixp46x_i2c_resources
 };
 
+static struct resource ixp4xx_gadget_resources[] = {
+	[0] = {
+		.start	= 0xc800b000,
+		.end	= 0xc800bfff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_USB,
+		.end	= IRQ_USB,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct pxa2xx_udc_mach_info ixp4xx_udc_info = {
+	.udc_is_connected	= NULL,
+	.udc_command		= NULL,
+};
+
+/*
+ * USB device controller. The IXP46x uses the same controller as PXA2XX,
+ * so we just use the same device name.
+ */
+static struct platform_device ixp4xx_gadget = {
+	.name		= "pxa2xx-udc",
+	.id		= -1,
+	.num_resources	= 2,
+	.resource	= ixp4xx_gadget_resources,
+	.dev		= {
+		.platform_data = &ixp4xx_udc_info,
+	},
+};
+
 static struct platform_device *ixp46x_devices[] __initdata = {
-	&ixp46x_i2c_controller
+	&ixp46x_i2c_controller,
+	&ixp4xx_gadget,
 };
 
 unsigned long ixp4xx_exp_bus_size;
diff -urpN -X orig/Documentation/dontdiff orig/drivers/usb/gadget/pxa2xx_udc.c new_gadget/drivers/usb/gadget/pxa2xx_udc.c
--- orig/drivers/usb/gadget/pxa2xx_udc.c	2006-05-15 10:21:14.000000000 +0000
+++ new_gadget/drivers/usb/gadget/pxa2xx_udc.c	2006-05-15 14:37:14.000000000 +0000
@@ -53,7 +53,9 @@
 #include <asm/mach-types.h>
 #include <asm/unaligned.h>
 #include <asm/hardware.h>
+#ifdef CONFIG_ARCH_PXA
 #include <asm/arch/pxa-regs.h>
+#endif
 
 #include <linux/usb_ch9.h>
 #include <linux/usb_gadget.h>
@@ -2432,7 +2434,7 @@ static struct pxa2xx_udc memory = {
 /*
  * 	probe - binds to the platform device
  */
-static int __init pxa2xx_udc_probe(struct platform_device *pdev)
+static int pxa2xx_udc_probe(struct platform_device *pdev)
 {
 	struct pxa2xx_udc *dev = &memory;
 	int retval, out_dma = 1;
@@ -2564,7 +2566,7 @@ static void pxa2xx_udc_shutdown(struct p
 	pullup_off();
 }
 
-static int __exit pxa2xx_udc_remove(struct platform_device *pdev)
+static int pxa2xx_udc_remove(struct platform_device *pdev)
 {
 	struct pxa2xx_udc *dev = platform_get_drvdata(pdev);
 
@@ -2576,10 +2578,12 @@ static int __exit pxa2xx_udc_remove(stru
 		free_irq(IRQ_USB, dev);
 		dev->got_irq = 0;
 	}
+#ifdef CONFIG_ARCH_LUBBOCK
 	if (machine_is_lubbock()) {
 		free_irq(LUBBOCK_USB_DISC_IRQ, dev);
 		free_irq(LUBBOCK_USB_IRQ, dev);
 	}
+#endif
 	platform_set_drvdata(pdev, NULL);
 	the_controller = NULL;
 	return 0;
diff -urpN -X orig/Documentation/dontdiff orig/include/asm-arm/arch-ixp4xx/irqs.h new_gadget/include/asm-arm/arch-ixp4xx/irqs.h
--- orig/include/asm-arm/arch-ixp4xx/irqs.h	2006-05-15 10:21:35.000000000 +0000
+++ new_gadget/include/asm-arm/arch-ixp4xx/irqs.h	2006-05-15 14:20:09.000000000 +0000
@@ -109,4 +109,10 @@
 #define        IRQ_NAS100D_PCI_INTD    IRQ_IXP4XX_GPIO8
 #define        IRQ_NAS100D_PCI_INTE    IRQ_IXP4XX_GPIO7
 
+/*
+ * This is used in pxa2xx usb device controller driver, so it
+ * doesn't follow ixp4xx naming convetions.
+ */
+#define IRQ_USB	IRQ_IXP4XX_USB
+
 #endif
diff -urpN -X orig/Documentation/dontdiff orig/include/asm-arm/arch-ixp4xx/udc.h new_gadget/include/asm-arm/arch-ixp4xx/udc.h
--- orig/include/asm-arm/arch-ixp4xx/udc.h	1970-01-01 00:00:00.000000000 +0000
+++ new_gadget/include/asm-arm/arch-ixp4xx/udc.h	2005-03-02 07:38:17.000000000 +0000
@@ -0,0 +1,18 @@
+/*
+ * linux/include/asm-arm/arch-pxa/udc.h
+ *
+ * This supports machine-specific differences in how the PXA2xx
+ * USB Device Controller (UDC) is wired.
+ *
+ * It is set in linux/arch/arm/mach-pxa/<machine>.c and used in
+ * the probe routine of linux/drivers/usb/gadget/pxa2xx_udc.c
+ */
+struct pxa2xx_udc_mach_info {
+        int  (*udc_is_connected)(void);		/* do we see host? */
+        void (*udc_command)(int cmd);
+#define	PXA2XX_UDC_CMD_CONNECT		0	/* let host see us */
+#define	PXA2XX_UDC_CMD_DISCONNECT	1	/* so host won't see us */
+};
+
+extern void pxa_set_udc_info(struct pxa2xx_udc_mach_info *info);
+





--------------000007070707080905080408--
