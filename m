Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262030AbVDEVoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbVDEVoO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 17:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbVDEVmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 17:42:22 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7096 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262052AbVDEVit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 17:38:49 -0400
Date: Tue, 5 Apr 2005 23:38:32 +0200
From: Pavel Machek <pavel@ucw.cz>
To: david-b@pacbell.net, linux-kernel@vger.kernel.org
Subject: Re: fix u32 vs. pm_message_t in usb
Message-ID: <20050405213832.GJ1380@elf.ucw.cz>
References: <20050405104202.GD1330@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405104202.GD1330@openzaurus.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Actually, please do NOT apply this.  It conflicts with other
> patches, which have been in the past few MM releases, have
> also been circulated on linux-usb-devel, and actually address
> some of the bugs which crept in as things have changed around
> the USB stack.

It seems to me that USB stack still needs some u32-vs-pm_message_t
changes (in rc2-mm1):

Could you apply them?
								Pavel

--- clean-mm/drivers/usb/core/hub.c	2005-04-05 11:22:15.000000000 +0200
+++ linux-mm/drivers/usb/core/hub.c	2005-04-05 12:13:38.000000000 +0200
@@ -1456,7 +1456,7 @@
 	/* FIXME let caller ask to power down the port:
 	 *  - some devices won't enumerate without a VBUS power cycle
 	 *  - SRP saves power that way
-	 *  - usb_suspend_device(dev,PM_SUSPEND_DISK)
+	 *  - usb_suspend_device(dev, PMSG_SUSPEND)
 	 * That's easy if this hub can switch power per-port, and
 	 * khubd reactivates the port later (timer, SRP, etc).
 	 * Powerdown must be optional, because of reset/DFU.
@@ -1531,7 +1531,7 @@
 
 /*
  * Devices on USB hub ports have only one "suspend" state, corresponding
- * to ACPI D2 (PM_SUSPEND_MEM), "may cause the device to lose some context".
+ * to ACPI D2, "may cause the device to lose some context".
  * State transitions include:
  *
  *   - suspend, resume ... when the VBUS power link stays live
--- clean-mm/drivers/usb/gadget/omap_udc.c	2005-03-19 00:31:52.000000000 +0100
+++ linux-mm/drivers/usb/gadget/omap_udc.c	2005-04-05 12:13:38.000000000 +0200
@@ -2809,17 +2809,15 @@
 	return 0;
 }
 
-/* suspend/resume/wakeup from sysfs (echo > power/state) */
-
-static int omap_udc_suspend(struct device *dev, u32 state, u32 level)
+static int omap_udc_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	if (level != 0)
 		return 0;
 
 	DBG("suspend, state %d\n", state);
 	omap_pullup(&udc->gadget, 0);
-	udc->gadget.dev.power.power_state = 3;
-	udc->gadget.dev.parent->power.power_state = 3;
+	udc->gadget.dev.power.power_state = PMSG_SUSPEND;
+	udc->gadget.dev.parent->power.power_state = PMSG_SUSPEND;
 	return 0;
 }
 
@@ -2829,8 +2827,8 @@
 		return 0;
 
 	DBG("resume + wakeup/SRP\n");
-	udc->gadget.dev.parent->power.power_state = 0;
-	udc->gadget.dev.power.power_state = 0;
+	udc->gadget.dev.parent->power.power_state = PMSG_ON;
+	udc->gadget.dev.power.power_state = PMSG_ON;
 	omap_pullup(&udc->gadget, 1);
 
 	/* maybe the host would enumerate us if we nudged it */
--- clean-mm/drivers/usb/host/ohci-omap.c	2005-04-05 10:55:21.000000000 +0200
+++ linux-mm/drivers/usb/host/ohci-omap.c	2005-04-05 12:13:38.000000000 +0200
@@ -458,9 +458,11 @@
 
 /* states match PCI usage, always suspending the root hub except that
  * 4 ~= D3cold (ACPI D3) with clock off (resume sees reset).
+ *
+ * FIXME: above comment is not right, and code is wrong, too :-(.
  */
 
-static int ohci_omap_suspend(struct device *dev, u32 state, u32 level)
+static int ohci_omap_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	struct ohci_hcd	*ohci = hcd_to_ohci(dev_get_drvdata(dev));
 	int		status = -EINVAL;
--- clean-mm/drivers/usb/host/ohci-pxa27x.c	2005-03-19 00:31:53.000000000 +0100
+++ linux-mm/drivers/usb/host/ohci-pxa27x.c	2005-04-05 12:13:38.000000000 +0200
@@ -337,7 +337,7 @@
 	return 0;
 }
 
-static int ohci_hcd_pxa27x_drv_suspend(struct device *dev, u32 state, u32 level)
+static int ohci_hcd_pxa27x_drv_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 //	struct platform_device *pdev = to_platform_device(dev);
 //	struct usb_hcd *hcd = dev_get_drvdata(dev);
@@ -346,7 +346,7 @@
 	return 0;
 }
 
-static int ohci_hcd_pxa27x_drv_resume(struct device *dev, u32 state)
+static int ohci_hcd_pxa27x_drv_resume(struct device *dev, u32 level)
 {
 //	struct platform_device *pdev = to_platform_device(dev);
 //	struct usb_hcd *hcd = dev_get_drvdata(dev);


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
