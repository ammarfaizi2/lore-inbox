Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268686AbUJDWSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268686AbUJDWSx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 18:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268650AbUJDVfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 17:35:45 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:29387 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S268646AbUJDVcI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 17:32:08 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org
Subject: PATCH/RFC: usbcore wakeup updates (3/4)
Date: Mon, 4 Oct 2004 14:07:47 -0700
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200410041407.47500.david-b@pacbell.net>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jubYB1cyMbwYV5k"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_jubYB1cyMbwYV5k
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

There were already some hooks in usbcore, but they were only
configurable for root hubs ... but not keyboards, mice, Ethernet
adapters, or other devices.



--Boundary-00=_jubYB1cyMbwYV5k
Content-Type: text/x-diff;
  charset="us-ascii";
  name="wake-usbcore.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="wake-usbcore.patch"

This replaces USB core wakeup bits with new pmcore wakeup bits:

 - Initialized or disabled in usb_set_configuration(), depending
   on whether the configuration supports wakeup;
 - Lets userspace change the initial may_wakeup policy, eliminating
   some guesswork marked by a couple FIXMEs
 - Virtual root hub uses the driver model wakeup support, which can
   change the initial may_wakeup policy.
 - PCI bus glue updates, including using those pmcore wakeup bits.

Since I'm too lazy to split them out, the PCI bus glue updates include
some unrelated changes, notably:

 - Handles "suspend deeper" (e.g. PCI_D1 to PCI_D2) per spec, although
   nobody is likely to issue such requests lately.

 - Requests to suspend to unsupported D1 and D2 states are treated
   as just hints, where D3cold is OK too ... many systems need this
   to enter ACPI G1/S1 (standby).
   
 - Makes "legacy" systems act like they support PCI PM, so they can
   enter ACPI G1 states ... though of course without wakeup support.
   (There may be some wierdness lurking here though, since some of
   them can wakeup from S3/STR even though PCI PME# isn't involved.)

NOTE:  breaks both OHCI and EHCI builds.

[ against 2.6.9-rc3 ]


--- 1.31/drivers/usb/core/hcd-pci.c	Thu Sep 30 11:23:16 2004
+++ edited/drivers/usb/core/hcd-pci.c	Mon Oct  4 12:56:41 2004
@@ -266,6 +266,18 @@
 
 #ifdef	CONFIG_PM
 
+static char __attribute_used__ *pci_state(u32 state)
+{
+	switch (state) {
+	case 0:		return "D0";
+	case 1:		return "D1";
+	case 2:		return "D2";
+	case 3:		return "D3hot";
+	case 4:		return "D3cold";
+	}
+	return NULL;
+}
+
 /**
  * usb_hcd_pci_suspend - power management suspend of a PCI-based HCD
  * @dev: USB Host Controller being suspended
@@ -286,16 +298,34 @@
 	 * PM-sensitive HCDs may already have done this.
 	 */
 	has_pci_pm = pci_find_capability(dev, PCI_CAP_ID_PM);
-	if (has_pci_pm)
-		dev_dbg(hcd->self.controller, "suspend D%d --> D%d\n",
-			dev->current_state, state);
+	if (state > 4)
+		state = 4;
 
 	switch (hcd->state) {
 	case USB_STATE_HALT:
 		dev_dbg (hcd->self.controller, "halted; hcd not suspended\n");
 		break;
 	case HCD_STATE_SUSPENDED:
-		dev_dbg (hcd->self.controller, "hcd already suspended\n");
+		dev_dbg (hcd->self.controller, "PCI %s --> %s\n",
+				pci_state(dev->current_state),
+				pci_state(state));
+		if (state > 3)
+			state = 3;
+
+		if (state == dev->current_state)
+			break;
+		else if (state < dev->current_state)
+			retval = -EIO;
+		else if (has_pci_pm)
+			retval = pci_set_power_state (dev, state);
+		else
+			dev->current_state = state;
+
+		if (retval == 0)
+			dev->dev.power.power_state = state;
+		else
+			dev_dbg (hcd->self.controller, 
+					"re-suspend fail, %d\n", retval);
 		break;
 	default:
 		retval = hcd->driver->suspend (hcd, state);
@@ -306,22 +336,48 @@
 		else {
 			hcd->state = HCD_STATE_SUSPENDED;
 			pci_save_state (dev, hcd->pci_state);
-#ifdef	CONFIG_USB_SUSPEND
-			pci_enable_wake (dev, state, hcd->remote_wakeup);
-			pci_enable_wake (dev, 4, hcd->remote_wakeup);
-#endif
+
 			/* no DMA or IRQs except in D0 */
 			pci_disable_device (dev);
 			free_irq (hcd->irq, hcd);
 			
-			if (has_pci_pm)
+			if (has_pci_pm) {
 				retval = pci_set_power_state (dev, state);
-			dev->dev.power.power_state = state;
+
+				/* POLICY: treat D1/D2 as just hints; D3hot
+				 * always works (may take longer to resume).
+				 */
+				if (retval < 0 && state < 3) {
+					retval = pci_set_power_state (dev, 3);
+					if (retval == 0)
+						state = 3;
+				}
+				if (retval == 0) {
+#ifdef	CONFIG_USB_SUSPEND
+					int do_resume =
+						device_may_wakeup (&dev->dev);
+					pci_enable_wake (dev, state, do_resume);
+					pci_enable_wake (dev, 4, do_resume);
+#endif
+					dev->dev.power.power_state = state;
+				}
+			} else {
+				if (state > 3)
+					state = 3;
+				dev->current_state = state;
+				dev->dev.power.power_state = state;
+			}
 			if (retval < 0) {
 				dev_dbg (&dev->dev,
-						"PCI suspend fail, %d\n",
+						"PCI %s suspend fail, %d\n",
+						pci_state(state),
 						retval);
 				(void) usb_hcd_pci_resume (dev);
+			} else {
+				dev_dbg(hcd->self.controller,
+					"suspended to PCI %s%s\n",
+					pci_state(state),
+					has_pci_pm ? " (PM)" : "");
 			}
 		}
 	}
@@ -343,9 +399,10 @@
 
 	hcd = pci_get_drvdata(dev);
 	has_pci_pm = pci_find_capability(dev, PCI_CAP_ID_PM);
-	if (has_pci_pm)
-		dev_dbg(hcd->self.controller, "resume from state D%d\n",
-				dev->current_state);
+
+	/* D3cold resume isn't usually reported this way... */
+	dev_dbg(hcd->self.controller, "resume from PCI %s\n",
+			pci_state(dev->current_state));
 
 	if (hcd->state != HCD_STATE_SUSPENDED) {
 		dev_dbg (hcd->self.controller, 
@@ -356,6 +413,8 @@
 
 	if (has_pci_pm)
 		pci_set_power_state (dev, 0);
+	else
+		dev->current_state = 0;
 	dev->dev.power.power_state = 0;
 	retval = request_irq (dev->irq, usb_hcd_irq, SA_SHIRQ,
 				hcd->description, hcd);
--- 1.67/drivers/usb/core/message.c	Thu Aug 26 16:29:16 2004
+++ edited/drivers/usb/core/message.c	Mon Oct  4 12:53:40 2004
@@ -1297,10 +1297,16 @@
 		goto free_interfaces;
 
 	dev->actconfig = cp;
+	device_init_wakeup(&dev->dev, 0);
 	if (!cp)
 		usb_set_device_state(dev, USB_STATE_ADDRESS);
 	else {
 		usb_set_device_state(dev, USB_STATE_CONFIGURED);
+		if (cp->desc.bmAttributes & USB_CONFIG_ATT_WAKEUP) {
+			dev_dbg (&dev->dev, "config #%d can issue wakeup\n",
+				configuration);
+			device_init_wakeup(&dev->dev, 1);
+		}
 
 		/* Initialize the new interface structures and the
 		 * hc/hcd/usbcore interface/endpoint state.
--- 1.97/drivers/usb/core/hcd.c	Mon Sep 13 16:23:44 2004
+++ edited/drivers/usb/core/hcd.c	Mon Oct  4 12:53:40 2004
@@ -352,19 +352,21 @@
 	/* DEVICE REQUESTS */
 
 	case DeviceRequest | USB_REQ_GET_STATUS:
-		ubuf [0] = (hcd->remote_wakeup << USB_DEVICE_REMOTE_WAKEUP)
+		ubuf [0] = (device_may_wakeup(&urb->dev->dev)
+					<< USB_DEVICE_REMOTE_WAKEUP)
 				| (1 << USB_DEVICE_SELF_POWERED);
 		ubuf [1] = 0;
 		break;
 	case DeviceOutRequest | USB_REQ_CLEAR_FEATURE:
 		if (wValue == USB_DEVICE_REMOTE_WAKEUP)
-			hcd->remote_wakeup = 0;
+			device_set_wakeup_enable(&urb->dev->dev, 0);
 		else
 			goto error;
 		break;
 	case DeviceOutRequest | USB_REQ_SET_FEATURE:
-		if (hcd->can_wakeup && wValue == USB_DEVICE_REMOTE_WAKEUP)
-			hcd->remote_wakeup = 1;
+		if (wValue == USB_DEVICE_REMOTE_WAKEUP
+				&& device_can_wakeup(&urb->dev->dev))
+			device_set_wakeup_enable(&urb->dev->dev, 1);
 		else
 			goto error;
 		break;
@@ -392,7 +394,7 @@
 				bufp = fs_rh_config_descriptor;
 				len = sizeof fs_rh_config_descriptor;
 			}
-			if (hcd->can_wakeup)
+			if (device_can_wakeup(&urb->dev->dev))
 				patch_wakeup = 1;
 			break;
 		case USB_DT_STRING << 8:
--- 1.46/drivers/usb/core/hcd.h	Thu Sep 30 11:23:16 2004
+++ edited/drivers/usb/core/hcd.h	Mon Oct  4 12:55:19 2004
@@ -74,8 +74,6 @@
 	 */
 	struct hc_driver	*driver;	/* hw-specific hooks */
 	unsigned		saw_irq : 1;
-	unsigned		can_wakeup:1;	/* hw supports wakeup? */
-	unsigned		remote_wakeup:1;/* sw should use wakeup? */
 	int			irq;		/* irq allocated */
 	void __iomem		*regs;		/* device memory/io */
 
@@ -354,11 +352,13 @@
 {
 	/* hcd->driver->start() reported can_wakeup, probably with
 	 * assistance from board's boot firmware.
-	 * NOTE:  normal devices won't enable wakeup by default.
+	 * NOTE:  usb_set_configuration() enables wakeup by default;
+	 * it can then be disabled from userspace.
 	 */
-	if (hcd->can_wakeup)
+#ifdef	CONFIG_USB_SUSPEND
+	if (device_can_wakeup(hcd->self.controller))
 		dev_dbg (hcd->self.controller, "supports USB remote wakeup\n");
-	hcd->remote_wakeup = hcd->can_wakeup;
+#endif
 
 	return usb_register_root_hub (usb_dev, hcd->self.controller);
 }
--- 1.108/drivers/usb/core/hub.c	Mon Sep 13 11:47:25 2004
+++ edited/drivers/usb/core/hub.c	Mon Oct  4 12:53:40 2004
@@ -1422,11 +1422,7 @@
 	 * NOTE:  OTG devices may issue remote wakeup (or SRP) even when
 	 * we don't explicitly enable it here.
 	 */
-	if (udev->actconfig
-			// && FIXME (remote wakeup enabled on this bus)
-			// ... currently assuming it's always appropriate
-			&& (udev->actconfig->desc.bmAttributes
-				& USB_CONFIG_ATT_WAKEUP) != 0) {
+	if (device_may_wakeup(&udev->dev)) {
 		status = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
 				USB_REQ_SET_FEATURE, USB_RECIP_DEVICE,
 				USB_DEVICE_REMOTE_WAKEUP, 0,

--Boundary-00=_jubYB1cyMbwYV5k--
