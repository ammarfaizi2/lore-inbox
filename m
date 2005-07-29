Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262900AbVG3Bf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262900AbVG3Bf2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 21:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbVG3Bdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 21:33:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:54703 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262661AbVG2TS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:18:26 -0400
Date: Fri, 29 Jul 2005 12:18:03 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ben-linux@fluff.org
Subject: [patch 26/29] USB: add S3C24XX USB Host driver support
Message-ID: <20050729191803.GB5095@kroah.com>
References: <20050729184950.014589000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050729191255.GA5095@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Dooks <ben-linux-usb@fluff.org>

USB (OHCI) Host driver for S3C2410/S3C2440 based systems

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/Kconfig             |    1 
 drivers/usb/host/ohci-hcd.c     |    5 
 drivers/usb/host/ohci-s3c2410.c |  496 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 502 insertions(+)

--- gregkh-2.6.orig/drivers/usb/Kconfig	2005-07-29 11:29:47.000000000 -0700
+++ gregkh-2.6/drivers/usb/Kconfig	2005-07-29 11:36:32.000000000 -0700
@@ -20,6 +20,7 @@
 	default y if SA1111
 	default y if ARCH_OMAP
 	default y if ARCH_LH7A404
+	default y if ARCH_S3C2410
 	default y if PXA27x
 	# PPC:
 	default y if STB03xxx
--- gregkh-2.6.orig/drivers/usb/host/ohci-hcd.c	2005-07-29 11:29:47.000000000 -0700
+++ gregkh-2.6/drivers/usb/host/ohci-hcd.c	2005-07-29 11:36:32.000000000 -0700
@@ -887,6 +887,10 @@
 #include "ohci-sa1111.c"
 #endif
 
+#ifdef CONFIG_ARCH_S3C2410
+#include "ohci-s3c2410.c"
+#endif
+
 #ifdef CONFIG_ARCH_OMAP
 #include "ohci-omap.c"
 #endif
@@ -909,6 +913,7 @@
 
 #if !(defined(CONFIG_PCI) \
       || defined(CONFIG_SA1111) \
+      || defined(CONFIG_ARCH_S3C2410) \
       || defined(CONFIG_ARCH_OMAP) \
       || defined (CONFIG_ARCH_LH7A404) \
       || defined (CONFIG_PXA27x) \
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ gregkh-2.6/drivers/usb/host/ohci-s3c2410.c	2005-07-29 11:36:32.000000000 -0700
@@ -0,0 +1,496 @@
+/*
+ * OHCI HCD (Host Controller Driver) for USB.
+ *
+ * (C) Copyright 1999 Roman Weissgaerber <weissg@vienna.at>
+ * (C) Copyright 2000-2002 David Brownell <dbrownell@users.sourceforge.net>
+ * (C) Copyright 2002 Hewlett-Packard Company
+ *
+ * USB Bus Glue for Samsung S3C2410
+ *
+ * Written by Christopher Hoover <ch@hpl.hp.com>
+ * Based on fragments of previous driver by Rusell King et al.
+ *
+ * Modified for S3C2410 from ohci-sa1111.c, ohci-omap.c and ohci-lh7a40.c
+ *	by Ben Dooks, <ben@simtec.co.uk>
+ *	Copyright (C) 2004 Simtec Electronics
+ *
+ * Thanks to basprog@mail.ru for updates to newer kernels
+ *
+ * This file is licenced under the GPL.
+*/
+
+#include <asm/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/hardware/clock.h>
+#include <asm/arch/usb-control.h>
+
+#define valid_port(idx) ((idx) == 1 || (idx) == 2)
+
+/* clock device associated with the hcd */
+
+static struct clk *clk;
+
+/* forward definitions */
+
+static void s3c2410_hcd_oc(struct s3c2410_hcd_info *info, int port_oc);
+
+/* conversion functions */
+
+struct s3c2410_hcd_info *to_s3c2410_info(struct usb_hcd *hcd)
+{
+	return hcd->self.controller->platform_data;
+}
+
+static void s3c2410_start_hc(struct platform_device *dev, struct usb_hcd *hcd)
+{
+	struct s3c2410_hcd_info *info = dev->dev.platform_data;
+
+	dev_dbg(&dev->dev, "s3c2410_start_hc:\n");
+	clk_enable(clk);
+
+	if (info != NULL) {
+		info->hcd	= hcd;
+		info->report_oc = s3c2410_hcd_oc;
+
+		if (info->enable_oc != NULL) {
+			(info->enable_oc)(info, 1);
+		}
+	}
+}
+
+static void s3c2410_stop_hc(struct platform_device *dev)
+{
+	struct s3c2410_hcd_info *info = dev->dev.platform_data;
+
+	dev_dbg(&dev->dev, "s3c2410_stop_hc:\n");
+
+	if (info != NULL) {
+		info->report_oc = NULL;
+		info->hcd	= NULL;
+
+		if (info->enable_oc != NULL) {
+			(info->enable_oc)(info, 0);
+		}
+	}
+
+	clk_disable(clk);
+}
+
+/* ohci_s3c2410_hub_status_data
+ *
+ * update the status data from the hub with anything that
+ * has been detected by our system
+*/
+
+static int
+ohci_s3c2410_hub_status_data (struct usb_hcd *hcd, char *buf)
+{
+	struct s3c2410_hcd_info *info = to_s3c2410_info(hcd);
+	struct s3c2410_hcd_port *port;
+	int orig;
+	int portno;
+
+	orig  = ohci_hub_status_data (hcd, buf);
+
+	if (info == NULL)
+		return orig;
+
+	port = &info->port[0];
+
+	/* mark any changed port as changed */
+
+	for (portno = 0; portno < 2; port++, portno++) {
+		if (port->oc_changed == 1 &&
+		    port->flags & S3C_HCDFLG_USED) {
+			dev_dbg(hcd->self.controller,
+				"oc change on port %d\n", portno);
+
+			if (orig < 1)
+				orig = 1;
+
+			buf[0] |= 1<<(portno+1);
+		}
+	}
+
+	return orig;
+}
+
+/* s3c2410_usb_set_power
+ *
+ * configure the power on a port, by calling the platform device
+ * routine registered with the platform device
+*/
+
+static void s3c2410_usb_set_power(struct s3c2410_hcd_info *info,
+				  int port, int to)
+{
+	if (info == NULL)
+		return;
+
+	if (info->power_control != NULL) {
+		info->port[port-1].power = to;
+		(info->power_control)(port, to);
+	}
+}
+
+/* ohci_s3c2410_hub_control
+ *
+ * look at control requests to the hub, and see if we need
+ * to take any action or over-ride the results from the
+ * request.
+*/
+
+static int ohci_s3c2410_hub_control (
+	struct usb_hcd	*hcd,
+	u16		typeReq,
+	u16		wValue,
+	u16		wIndex,
+	char		*buf,
+	u16		wLength)
+{
+	struct s3c2410_hcd_info *info = to_s3c2410_info(hcd);
+	struct usb_hub_descriptor *desc;
+	int ret = -EINVAL;
+	u32 *data = (u32 *)buf;
+
+	dev_dbg(hcd->self.controller,
+		"s3c2410_hub_control(%p,0x%04x,0x%04x,0x%04x,%p,%04x)\n",
+		hcd, typeReq, wValue, wIndex, buf, wLength);
+
+	/* if we are only an humble host without any special capabilites
+	 * process the request straight away and exit */
+
+	if (info == NULL) {
+		ret = ohci_hub_control(hcd, typeReq, wValue,
+				       wIndex, buf, wLength);
+		goto out;
+	}
+
+	/* check the request to see if it needs handling */
+
+	switch (typeReq) {
+	case SetPortFeature:
+		if (wValue == USB_PORT_FEAT_POWER) {
+			dev_dbg(hcd->self.controller, "SetPortFeat: POWER\n");
+			s3c2410_usb_set_power(info, wIndex, 1);
+			goto out;
+		}
+		break;
+
+	case ClearPortFeature:
+		switch (wValue) {
+		case USB_PORT_FEAT_C_OVER_CURRENT:
+			dev_dbg(hcd->self.controller,
+				"ClearPortFeature: C_OVER_CURRENT\n");
+
+			if (valid_port(wIndex)) {
+				info->port[wIndex-1].oc_changed = 0;
+				info->port[wIndex-1].oc_status = 0;
+			}
+
+			goto out;
+
+		case USB_PORT_FEAT_OVER_CURRENT:
+			dev_dbg(hcd->self.controller,
+				"ClearPortFeature: OVER_CURRENT\n");
+
+			if (valid_port(wIndex)) {
+				info->port[wIndex-1].oc_status = 0;
+			}
+
+			goto out;
+
+		case USB_PORT_FEAT_POWER:
+			dev_dbg(hcd->self.controller,
+				"ClearPortFeature: POWER\n");
+
+			if (valid_port(wIndex)) {
+				s3c2410_usb_set_power(info, wIndex, 0);
+				return 0;
+			}
+		}
+		break;
+	}
+
+	ret = ohci_hub_control(hcd, typeReq, wValue, wIndex, buf, wLength);
+	if (ret)
+		goto out;
+
+	switch (typeReq) {
+	case GetHubDescriptor:
+
+		/* update the hub's descriptor */
+
+		desc = (struct usb_hub_descriptor *)buf;
+
+		if (info->power_control == NULL)
+			return ret;
+
+		dev_dbg(hcd->self.controller, "wHubCharacteristics 0x%04x\n",
+			desc->wHubCharacteristics);
+
+		/* remove the old configurations for power-switching, and
+		 * over-current protection, and insert our new configuration
+		 */
+
+		desc->wHubCharacteristics &= ~cpu_to_le16(HUB_CHAR_LPSM);
+		desc->wHubCharacteristics |= cpu_to_le16(0x0001);
+
+		if (info->enable_oc) {
+			desc->wHubCharacteristics &= ~cpu_to_le16(HUB_CHAR_OCPM);
+			desc->wHubCharacteristics |=  cpu_to_le16(0x0008|0x0001);
+		}
+
+		dev_dbg(hcd->self.controller, "wHubCharacteristics after 0x%04x\n",
+			desc->wHubCharacteristics);
+
+		return ret;
+
+	case GetPortStatus:
+		/* check port status */
+
+		dev_dbg(hcd->self.controller, "GetPortStatus(%d)\n", wIndex);
+
+		if (valid_port(wIndex)) {
+			if (info->port[wIndex-1].oc_changed) {
+				*data |= cpu_to_le32(RH_PS_OCIC);
+			}
+
+			if (info->port[wIndex-1].oc_status) {
+				*data |= cpu_to_le32(RH_PS_POCI);
+			}
+		}
+	}
+
+ out:
+	return ret;
+}
+
+/* s3c2410_hcd_oc
+ *
+ * handle an over-current report
+*/
+
+static void s3c2410_hcd_oc(struct s3c2410_hcd_info *info, int port_oc)
+{
+	struct s3c2410_hcd_port *port;
+	struct usb_hcd *hcd;
+	unsigned long flags;
+	int portno;
+
+	if (info == NULL)
+		return;
+
+	port = &info->port[0];
+	hcd = info->hcd;
+
+	local_irq_save(flags);
+
+	for (portno = 0; portno < 2; port++, portno++) {
+		if (port_oc & (1<<portno) &&
+		    port->flags & S3C_HCDFLG_USED) {
+			port->oc_status = 1;
+			port->oc_changed = 1;
+
+			/* ok, once over-current is detected,
+			   the port needs to be powered down */
+			s3c2410_usb_set_power(info, portno+1, 0);
+		}
+	}
+
+	local_irq_restore(flags);
+}
+
+/* may be called without controller electrically present */
+/* may be called with controller, bus, and devices active */
+
+/*
+ * usb_hcd_s3c2410_remove - shutdown processing for HCD
+ * @dev: USB Host Controller being removed
+ * Context: !in_interrupt()
+ *
+ * Reverses the effect of usb_hcd_3c2410_probe(), first invoking
+ * the HCD's stop() method.  It is always called from a thread
+ * context, normally "rmmod", "apmd", or something similar.
+ *
+*/
+
+void usb_hcd_s3c2410_remove (struct usb_hcd *hcd, struct platform_device *dev)
+{
+	usb_remove_hcd(hcd);
+	s3c2410_stop_hc(dev);
+	iounmap(hcd->regs);
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+	usb_put_hcd(hcd);
+}
+
+/**
+ * usb_hcd_s3c2410_probe - initialize S3C2410-based HCDs
+ * Context: !in_interrupt()
+ *
+ * Allocates basic resources for this USB host controller, and
+ * then invokes the start() method for the HCD associated with it
+ * through the hotplug entry's driver_data.
+ *
+ */
+int usb_hcd_s3c2410_probe (const struct hc_driver *driver,
+			   struct platform_device *dev)
+{
+	struct usb_hcd *hcd = NULL;
+	int retval;
+
+	s3c2410_usb_set_power(dev->dev.platform_data, 0, 1);
+	s3c2410_usb_set_power(dev->dev.platform_data, 1, 1);
+
+	hcd = usb_create_hcd(driver, &dev->dev, "s3c24xx");
+	if (hcd == NULL)
+		return -ENOMEM;
+
+	hcd->rsrc_start = dev->resource[0].start;
+	hcd->rsrc_len   = dev->resource[0].end - dev->resource[0].start + 1;
+
+	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
+		dev_err(&dev->dev, "request_mem_region failed");
+		retval = -EBUSY;
+		goto err0;
+	}
+
+	clk = clk_get(NULL, "usb-host");
+	if (IS_ERR(clk)) {
+		dev_err(&dev->dev, "cannot get usb-host clock\n");
+		retval = -ENOENT;
+		goto err1;
+	}
+
+	clk_use(clk);
+	s3c2410_start_hc(dev, hcd);
+
+	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
+	if (!hcd->regs) {
+		dev_err(&dev->dev, "ioremap failed\n");
+		retval = -ENOMEM;
+		goto err2;
+	}
+
+	ohci_hcd_init(hcd_to_ohci(hcd));
+
+	retval = usb_add_hcd(hcd, dev->resource[1].start, SA_INTERRUPT);
+	if (retval != 0)
+		goto err2;
+
+	return 0;
+
+ err2:
+	s3c2410_stop_hc(dev);
+	iounmap(hcd->regs);
+	clk_unuse(clk);
+	clk_put(clk);
+
+ err1:
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+
+ err0:
+	usb_put_hcd(hcd);
+	return retval;
+}
+
+/*-------------------------------------------------------------------------*/
+
+static int
+ohci_s3c2410_start (struct usb_hcd *hcd)
+{
+	struct ohci_hcd	*ohci = hcd_to_ohci (hcd);
+	int ret;
+
+	if ((ret = ohci_init(ohci)) < 0)
+		return ret;
+
+	if ((ret = ohci_run (ohci)) < 0) {
+		err ("can't start %s", hcd->self.bus_name);
+		ohci_stop (hcd);
+		return ret;
+	}
+
+	return 0;
+}
+
+
+static const struct hc_driver ohci_s3c2410_hc_driver = {
+	.description =		hcd_name,
+	.product_desc =		"S3C24XX OHCI",
+	.hcd_priv_size =	sizeof(struct ohci_hcd),
+
+	/*
+	 * generic hardware linkage
+	 */
+	.irq =			ohci_irq,
+	.flags =		HCD_USB11 | HCD_MEMORY,
+
+	/*
+	 * basic lifecycle operations
+	 */
+	.start =		ohci_s3c2410_start,
+	.stop =			ohci_stop,
+
+	/*
+	 * managing i/o requests and associated device resources
+	 */
+	.urb_enqueue =		ohci_urb_enqueue,
+	.urb_dequeue =		ohci_urb_dequeue,
+	.endpoint_disable =	ohci_endpoint_disable,
+
+	/*
+	 * scheduling support
+	 */
+	.get_frame_number =	ohci_get_frame,
+
+	/*
+	 * root hub support
+	 */
+	.hub_status_data =	ohci_s3c2410_hub_status_data,
+	.hub_control =		ohci_s3c2410_hub_control,
+
+#if defined(CONFIG_USB_SUSPEND) && 0
+	.hub_suspend =		ohci_hub_suspend,
+	.hub_resume =		ohci_hub_resume,
+#endif
+};
+
+/* device driver */
+
+static int ohci_hcd_s3c2410_drv_probe(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	return usb_hcd_s3c2410_probe(&ohci_s3c2410_hc_driver, pdev);
+}
+
+static int ohci_hcd_s3c2410_drv_remove(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
+
+	usb_hcd_s3c2410_remove(hcd, pdev);
+	return 0;
+}
+
+static struct device_driver ohci_hcd_s3c2410_driver = {
+	.name		= "s3c2410-ohci",
+	.bus		= &platform_bus_type,
+	.probe		= ohci_hcd_s3c2410_drv_probe,
+	.remove		= ohci_hcd_s3c2410_drv_remove,
+	/*.suspend	= ohci_hcd_s3c2410_drv_suspend, */
+	/*.resume	= ohci_hcd_s3c2410_drv_resume, */
+};
+
+static int __init ohci_hcd_s3c2410_init (void)
+{
+	return driver_register(&ohci_hcd_s3c2410_driver);
+}
+
+static void __exit ohci_hcd_s3c2410_cleanup (void)
+{
+	driver_unregister(&ohci_hcd_s3c2410_driver);
+}
+
+module_init (ohci_hcd_s3c2410_init);
+module_exit (ohci_hcd_s3c2410_cleanup);

--
