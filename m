Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbVAHFz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbVAHFz7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 00:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVAHFz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 00:55:59 -0500
Received: from mail.kroah.org ([69.55.234.183]:16261 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261793AbVAHFry convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:47:54 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <1105163269213@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:49 -0800
Message-Id: <1105163269703@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.49, 2004/12/20 15:01:26-08:00, stern@rowland.harvard.edu

[PATCH] USB: Another hub driver cleanup [13/13]

This patch does some more cleaning up of the hub driver.  The idea is to
use 1-based port numbers everywhere, in accordance with the usage of the
USB spec, the values stored in USB messages, and the values printed in the
system log.  The downside is that we have to subtract 1 to index the
children[] array, but that's a lot better than all the additions of 1 that
were there before.  To emphasize the nature of this change, I renamed the
"port" local variable to "port1" every place it is used.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/core/hub.c |  280 ++++++++++++++++++++++++-------------------------
 drivers/usb/core/usb.c |    8 -
 2 files changed, 146 insertions(+), 142 deletions(-)


diff -Nru a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
--- a/drivers/usb/core/hub.c	2005-01-07 15:42:44 -08:00
+++ b/drivers/usb/core/hub.c	2005-01-07 15:42:44 -08:00
@@ -128,19 +128,21 @@
 /*
  * USB 2.0 spec Section 11.24.2.2
  */
-static int clear_port_feature(struct usb_device *hdev, int port, int feature)
+static int clear_port_feature(struct usb_device *hdev, int port1, int feature)
 {
 	return usb_control_msg(hdev, usb_sndctrlpipe(hdev, 0),
-		USB_REQ_CLEAR_FEATURE, USB_RT_PORT, feature, port, NULL, 0, HZ);
+		USB_REQ_CLEAR_FEATURE, USB_RT_PORT, feature, port1,
+		NULL, 0, HZ);
 }
 
 /*
  * USB 2.0 spec Section 11.24.2.13
  */
-static int set_port_feature(struct usb_device *hdev, int port, int feature)
+static int set_port_feature(struct usb_device *hdev, int port1, int feature)
 {
 	return usb_control_msg(hdev, usb_sndctrlpipe(hdev, 0),
-		USB_REQ_SET_FEATURE, USB_RT_PORT, feature, port, NULL, 0, HZ);
+		USB_REQ_SET_FEATURE, USB_RT_PORT, feature, port1,
+		NULL, 0, HZ);
 }
 
 /*
@@ -149,16 +151,16 @@
  */
 static void set_port_led(
 	struct usb_hub *hub,
-	int port,
+	int port1,
 	int selector
 )
 {
-	int status = set_port_feature(hub->hdev, (selector << 8) | port,
+	int status = set_port_feature(hub->hdev, (selector << 8) | port1,
 			USB_PORT_FEAT_INDICATOR);
 	if (status < 0)
 		dev_dbg (hub->intfdev,
 			"port %d indicator %s status %d\n",
-			port,
+			port1,
 			({ char *s; switch (selector) {
 			case HUB_LED_AMBER: s = "amber"; break;
 			case HUB_LED_GREEN: s = "green"; break;
@@ -263,14 +265,14 @@
 /*
  * USB 2.0 spec Section 11.24.2.7
  */
-static int get_port_status(struct usb_device *hdev, int port,
+static int get_port_status(struct usb_device *hdev, int port1,
 		struct usb_port_status *data)
 {
 	int i, status = -ETIMEDOUT;
 
 	for (i = 0; i < USB_STS_RETRIES && status == -ETIMEDOUT; i++) {
 		status = usb_control_msg(hdev, usb_rcvctrlpipe(hdev, 0),
-			USB_REQ_GET_STATUS, USB_DIR_IN | USB_RT_PORT, 0, port,
+			USB_REQ_GET_STATUS, USB_DIR_IN | USB_RT_PORT, 0, port1,
 			data, sizeof(*data), HZ * USB_STS_TIMEOUT);
 	}
 	return status;
@@ -428,13 +430,13 @@
 
 static void hub_power_on(struct usb_hub *hub)
 {
-	int i;
+	int port1;
 
 	/* if hub supports power switching, enable power on each port */
 	if ((hub->descriptor->wHubCharacteristics & HUB_CHAR_LPSM) < 2) {
 		dev_dbg(hub->intfdev, "enabling power on all ports\n");
-		for (i = 0; i < hub->descriptor->bNbrPorts; i++)
-			set_port_feature(hub->hdev, i + 1,
+		for (port1 = 1; port1 <= hub->descriptor->bNbrPorts; port1++)
+			set_port_feature(hub->hdev, port1,
 					USB_PORT_FEAT_POWER);
 	}
 
@@ -688,7 +690,7 @@
 		hub->indicator [0] = INDICATOR_CYCLE;
 
 	hub_power_on(hub);
-	hub->change_bits[0] = (1UL << (hub->descriptor->bNbrPorts)) - 1;
+	hub->change_bits[0] = (1UL << (hub->descriptor->bNbrPorts + 1)) - 2;
 	hub_activate(hub);
 	return 0;
 
@@ -899,7 +901,7 @@
 			 */
 			down(&udev->serialize);
 			up(&hdev->serialize);
-			return t;
+			return t + 1;
 		}
 	}
 	usb_unlock_device(hdev);
@@ -1190,22 +1192,22 @@
 					udev->config[0].desc.wTotalLength,
 					USB_DT_OTG, (void **) &desc) == 0) {
 			if (desc->bmAttributes & USB_OTG_HNP) {
-				unsigned		port;
+				unsigned		port1;
 				struct usb_device	*root = udev->parent;
 				
-				for (port = 0; port < root->maxchild; port++) {
-					if (root->children[port] == udev)
+				for (port1 = 1; port1 <= root->maxchild;
+						port1++) {
+					if (root->children[port1-1] == udev)
 						break;
 				}
-				port++;
 
 				dev_info(&udev->dev,
 					"Dual-Role OTG device on %sHNP port\n",
-					(port == bus->otg_port)
+					(port1 == bus->otg_port)
 						? "" : "non-");
 
 				/* enable HNP before suspend, it's simpler */
-				if (port == bus->otg_port)
+				if (port1 == bus->otg_port)
 					bus->b_hnp_enable = 1;
 				err = usb_control_msg(udev,
 					usb_sndctrlpipe(udev, 0),
@@ -1234,9 +1236,9 @@
 		 */
 		if (udev->bus->b_hnp_enable || udev->bus->is_b_host) {
 			static int __usb_suspend_device (struct usb_device *,
-						int port, u32 state);
+						int port1, u32 state);
 			err = __usb_suspend_device(udev,
-					udev->bus->otg_port - 1,
+					udev->bus->otg_port,
 					PM_SUSPEND_MEM);
 			if (err < 0)
 				dev_dbg(&udev->dev, "HNP fail, %d\n", err);
@@ -1284,12 +1286,12 @@
 }
 
 
-static int hub_port_status(struct usb_hub *hub, int port,
+static int hub_port_status(struct usb_hub *hub, int port1,
 			       u16 *status, u16 *change)
 {
 	int ret;
 
-	ret = get_port_status(hub->hdev, port + 1, &hub->status->port);
+	ret = get_port_status(hub->hdev, port1, &hub->status->port);
 	if (ret < 0)
 		dev_err (hub->intfdev,
 			"%s failed (err = %d)\n", __FUNCTION__, ret);
@@ -1312,7 +1314,7 @@
 #define HUB_LONG_RESET_TIME	200
 #define HUB_RESET_TIMEOUT	500
 
-static int hub_port_wait_reset(struct usb_hub *hub, int port,
+static int hub_port_wait_reset(struct usb_hub *hub, int port1,
 				struct usb_device *udev, unsigned int delay)
 {
 	int delay_time, ret;
@@ -1326,7 +1328,7 @@
 		msleep(delay);
 
 		/* read and decode port status */
-		ret = hub_port_status(hub, port, &portstatus, &portchange);
+		ret = hub_port_status(hub, port1, &portstatus, &portchange);
 		if (ret < 0)
 			return ret;
 
@@ -1356,13 +1358,13 @@
 
 		dev_dbg (hub->intfdev,
 			"port %d not reset yet, waiting %dms\n",
-			port + 1, delay);
+			port1, delay);
 	}
 
 	return -EBUSY;
 }
 
-static int hub_port_reset(struct usb_hub *hub, int port,
+static int hub_port_reset(struct usb_hub *hub, int port1,
 				struct usb_device *udev, unsigned int delay)
 {
 	int i, status;
@@ -1370,13 +1372,13 @@
 	/* Reset the port */
 	for (i = 0; i < PORT_RESET_TRIES; i++) {
 		status = set_port_feature(hub->hdev,
-				port + 1, USB_PORT_FEAT_RESET);
+				port1, USB_PORT_FEAT_RESET);
 		if (status)
 			dev_err(hub->intfdev,
 					"cannot reset port %d (err = %d)\n",
-					port + 1, status);
+					port1, status);
 		else
-			status = hub_port_wait_reset(hub, port, udev, delay);
+			status = hub_port_wait_reset(hub, port1, udev, delay);
 
 		/* return on disconnect or reset */
 		switch (status) {
@@ -1384,7 +1386,7 @@
 		case -ENOTCONN:
 		case -ENODEV:
 			clear_port_feature(hub->hdev,
-				port + 1, USB_PORT_FEAT_C_RESET);
+				port1, USB_PORT_FEAT_C_RESET);
 			/* FIXME need disconnect() for NOTATTACHED device */
 			usb_set_device_state(udev, status
 					? USB_STATE_NOTATTACHED
@@ -1394,30 +1396,30 @@
 
 		dev_dbg (hub->intfdev,
 			"port %d not enabled, trying reset again...\n",
-			port + 1);
+			port1);
 		delay = HUB_LONG_RESET_TIME;
 	}
 
 	dev_err (hub->intfdev,
 		"Cannot enable port %i.  Maybe the USB cable is bad?\n",
-		port + 1);
+		port1);
 
 	return status;
 }
 
-static int hub_port_disable(struct usb_hub *hub, int port, int set_state)
+static int hub_port_disable(struct usb_hub *hub, int port1, int set_state)
 {
 	struct usb_device *hdev = hub->hdev;
 	int ret;
 
-	if (hdev->children[port] && set_state) {
-		usb_set_device_state(hdev->children[port],
+	if (hdev->children[port1-1] && set_state) {
+		usb_set_device_state(hdev->children[port1-1],
 				USB_STATE_NOTATTACHED);
 	}
-	ret = clear_port_feature(hdev, port + 1, USB_PORT_FEAT_ENABLE);
+	ret = clear_port_feature(hdev, port1, USB_PORT_FEAT_ENABLE);
 	if (ret)
 		dev_err(hub->intfdev, "cannot disable port %d (err = %d)\n",
-			port + 1, ret);
+			port1, ret);
 
 	return ret;
 }
@@ -1427,10 +1429,10 @@
  * time later khubd will disconnect() any existing usb_device on the port
  * and will re-enumerate if there actually is a device attached.
  */
-static void hub_port_logical_disconnect(struct usb_hub *hub, int port)
+static void hub_port_logical_disconnect(struct usb_hub *hub, int port1)
 {
-	dev_dbg(hub->intfdev, "logical disconnect on port %d\n", port + 1);
-	hub_port_disable(hub, port, 1);
+	dev_dbg(hub->intfdev, "logical disconnect on port %d\n", port1);
+	hub_port_disable(hub, port1, 1);
 
 	/* FIXME let caller ask to power down the port:
 	 *  - some devices won't enumerate without a VBUS power cycle
@@ -1441,7 +1443,7 @@
 	 * Powerdown must be optional, because of reset/DFU.
 	 */
 
-	set_bit(port, hub->change_bits);
+	set_bit(port1, hub->change_bits);
  	kick_khubd(hub);
 }
 
@@ -1458,12 +1460,12 @@
  * tree above them to deliver data, such as a keypress or packet.  In
  * some cases, this wakes the USB host.
  */
-static int hub_port_suspend(struct usb_hub *hub, int port,
+static int hub_port_suspend(struct usb_hub *hub, int port1,
 		struct usb_device *udev)
 {
 	int	status;
 
-	// dev_dbg(hub->intfdev, "suspend port %d\n", port + 1);
+	// dev_dbg(hub->intfdev, "suspend port %d\n", port1);
 
 	/* enable remote wakeup when appropriate; this lets the device
 	 * wake up the upstream hub (including maybe the root hub).
@@ -1488,11 +1490,11 @@
 	}
 
 	/* see 7.1.7.6 */
-	status = set_port_feature(hub->hdev, port + 1, USB_PORT_FEAT_SUSPEND);
+	status = set_port_feature(hub->hdev, port1, USB_PORT_FEAT_SUSPEND);
 	if (status) {
 		dev_dbg(hub->intfdev,
 			"can't suspend port %d, status %d\n",
-			port + 1, status);
+			port1, status);
 		/* paranoia:  "should not happen" */
 		(void) usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
 				USB_REQ_CLEAR_FEATURE, USB_RECIP_DEVICE,
@@ -1522,13 +1524,13 @@
  * Linux (2.6) currently has NO mechanisms to initiate that:  no khubd
  * timer, no SRP, no requests through sysfs.
  */
-int __usb_suspend_device (struct usb_device *udev, int port, u32 state)
+int __usb_suspend_device (struct usb_device *udev, int port1, u32 state)
 {
 	int	status;
 
 	/* caller owns the udev device lock */
-	if (port < 0)
-		return port;
+	if (port1 < 0)
+		return port1;
 
 	if (udev->state == USB_STATE_SUSPENDED
 			|| udev->state == USB_STATE_NOTATTACHED) {
@@ -1609,7 +1611,7 @@
 		} else
 			status = -EOPNOTSUPP;
 	} else
-		status = hub_port_suspend(hdev_to_hub(udev->parent), port,
+		status = hub_port_suspend(hdev_to_hub(udev->parent), port1,
 				udev);
 
 	if (status == 0)
@@ -1638,13 +1640,13 @@
  */
 int usb_suspend_device(struct usb_device *udev, u32 state)
 {
-	int	port, status;
+	int	port1, status;
 
-	port = locktree(udev);
-	if (port < 0)
-		return port;
+	port1 = locktree(udev);
+	if (port1 < 0)
+		return port1;
 
-	status = __usb_suspend_device(udev, port, state);
+	status = __usb_suspend_device(udev, port1, state);
 	usb_unlock_device(udev);
 	return status;
 }
@@ -1738,19 +1740,19 @@
 }
 
 static int
-hub_port_resume(struct usb_hub *hub, int port, struct usb_device *udev)
+hub_port_resume(struct usb_hub *hub, int port1, struct usb_device *udev)
 {
 	int	status;
 
-	// dev_dbg(hub->intfdev, "resume port %d\n", port + 1);
+	// dev_dbg(hub->intfdev, "resume port %d\n", port1);
 
 	/* see 7.1.7.7; affects power usage, but not budgeting */
 	status = clear_port_feature(hub->hdev,
-			port + 1, USB_PORT_FEAT_SUSPEND);
+			port1, USB_PORT_FEAT_SUSPEND);
 	if (status) {
 		dev_dbg(hub->intfdev,
 			"can't resume port %d, status %d\n",
-			port + 1, status);
+			port1, status);
 	} else {
 		u16		devstatus;
 		u16		portchange;
@@ -1769,7 +1771,7 @@
 		 * sequence.
 		 */
 		devstatus = portchange = 0;
-		status = hub_port_status(hub, port,
+		status = hub_port_status(hub, port1,
 				&devstatus, &portchange);
 		if (status < 0
 				|| (devstatus & LIVE_FLAGS) != LIVE_FLAGS
@@ -1777,7 +1779,7 @@
 				) {
 			dev_dbg(hub->intfdev,
 				"port %d status %04x.%04x after resume, %d\n",
-				port + 1, portchange, devstatus, status);
+				port1, portchange, devstatus, status);
 		} else {
 			/* TRSMRCY = 10 msec */
 			msleep(10);
@@ -1786,7 +1788,7 @@
 		}
 	}
 	if (status < 0)
-		hub_port_logical_disconnect(hub, port);
+		hub_port_logical_disconnect(hub, port1);
 
 	return status;
 }
@@ -1808,11 +1810,11 @@
  */
 int usb_resume_device(struct usb_device *udev)
 {
-	int	port, status;
+	int	port1, status;
 
-	port = locktree(udev);
-	if (port < 0)
-		return port;
+	port1 = locktree(udev);
+	if (port1 < 0)
+		return port1;
 
 	/* "global resume" of the HC-to-USB interface (root hub), or
 	 * selective resume of one hub-to-device port
@@ -1833,7 +1835,7 @@
 	} else if (udev->state == USB_STATE_SUSPENDED) {
 		// NOTE this fails if parent is also suspended...
 		status = hub_port_resume(hdev_to_hub(udev->parent),
-				port, udev);
+				port1, udev);
 	} else {
 		status = 0;
 	}
@@ -1875,25 +1877,25 @@
 {
 	struct usb_hub		*hub = usb_get_intfdata (intf);
 	struct usb_device	*hdev = hub->hdev;
-	unsigned		port;
+	unsigned		port1;
 	int			status;
 
 	/* stop khubd and related activity */
 	hub_quiesce(hub);
 
 	/* then suspend every port */
-	for (port = 0; port < hdev->maxchild; port++) {
+	for (port1 = 1; port1 <= hdev->maxchild; port1++) {
 		struct usb_device	*udev;
 
-		udev = hdev->children [port];
+		udev = hdev->children [port1-1];
 		if (!udev)
 			continue;
 		down(&udev->serialize);
-		status = __usb_suspend_device(udev, port, state);
+		status = __usb_suspend_device(udev, port1, state);
 		up(&udev->serialize);
 		if (status < 0)
 			dev_dbg(&intf->dev, "suspend port %d --> %d\n",
-				port, status);
+				port1, status);
 	}
 
 	intf->dev.power.power_state = state;
@@ -1904,21 +1906,21 @@
 {
 	struct usb_device	*hdev = interface_to_usbdev(intf);
 	struct usb_hub		*hub = usb_get_intfdata (intf);
-	unsigned		port;
+	unsigned		port1;
 	int			status;
 
 	if (intf->dev.power.power_state == PM_SUSPEND_ON)
 		return 0;
 
-	for (port = 0; port < hdev->maxchild; port++) {
+	for (port1 = 1; port1 <= hdev->maxchild; port1++) {
 		struct usb_device	*udev;
 		u16			portstat, portchange;
 
-		udev = hdev->children [port];
-		status = hub_port_status(hub, port, &portstat, &portchange);
+		udev = hdev->children [port1-1];
+		status = hub_port_status(hub, port1, &portstat, &portchange);
 		if (status == 0) {
 			if (portchange & USB_PORT_STAT_C_SUSPEND) {
-				clear_port_feature(hdev, port + 1,
+				clear_port_feature(hdev, port1,
 					USB_PORT_FEAT_C_SUSPEND);
 				portchange &= ~USB_PORT_STAT_C_SUSPEND;
 			}
@@ -1932,13 +1934,13 @@
 			continue;
 		down (&udev->serialize);
 		if (portstat & USB_PORT_STAT_SUSPEND)
-			status = hub_port_resume(hub, port, udev);
+			status = hub_port_resume(hub, port1, udev);
 		else {
 			status = finish_port_resume(udev);
 			if (status < 0) {
 				dev_dbg(&intf->dev, "resume port %d --> %d\n",
-					port + 1, status);
-				hub_port_logical_disconnect(hub, port);
+					port1, status);
+				hub_port_logical_disconnect(hub, port1);
 			}
 		}
 		up(&udev->serialize);
@@ -1992,7 +1994,7 @@
 #define HUB_DEBOUNCE_STEP	  25
 #define HUB_DEBOUNCE_STABLE	 100
 
-static int hub_port_debounce(struct usb_hub *hub, int port)
+static int hub_port_debounce(struct usb_hub *hub, int port1)
 {
 	int ret;
 	int total_time, stable_time = 0;
@@ -2000,7 +2002,7 @@
 	unsigned connection = 0xffff;
 
 	for (total_time = 0; ; total_time += HUB_DEBOUNCE_STEP) {
-		ret = hub_port_status(hub, port, &portstatus, &portchange);
+		ret = hub_port_status(hub, port1, &portstatus, &portchange);
 		if (ret < 0)
 			return ret;
 
@@ -2015,7 +2017,7 @@
 		}
 
 		if (portchange & USB_PORT_STAT_C_CONNECTION) {
-			clear_port_feature(hub->hdev, port+1,
+			clear_port_feature(hub->hdev, port1,
 					USB_PORT_FEAT_C_CONNECTION);
 		}
 
@@ -2026,7 +2028,7 @@
 
 	dev_dbg (hub->intfdev,
 		"debounce: port %d: total %dms stable %dms status 0x%x\n",
-		port + 1, total_time, stable_time, portstatus);
+		port1, total_time, stable_time, portstatus);
 
 	if (stable_time < HUB_DEBOUNCE_STABLE)
 		return -ETIMEDOUT;
@@ -2073,7 +2075,7 @@
  * pointers, it's not necessary to lock the device.
  */
 static int
-hub_port_init (struct usb_hub *hub, struct usb_device *udev, int port,
+hub_port_init (struct usb_hub *hub, struct usb_device *udev, int port1,
 		int retry_counter)
 {
 	static DECLARE_MUTEX(usb_address0_sem);
@@ -2088,7 +2090,7 @@
 	 */
 	if (!hdev->parent) {
 		delay = HUB_ROOT_RESET_TIME;
-		if (port + 1 == hdev->bus->otg_port)
+		if (port1 == hdev->bus->otg_port)
 			hdev->bus->b_hnp_enable = 0;
 	}
 
@@ -2100,7 +2102,7 @@
 	down(&usb_address0_sem);
 
 	/* Reset the device; full speed may morph to high speed */
-	retval = hub_port_reset(hub, port, udev, delay);
+	retval = hub_port_reset(hub, port1, udev, delay);
 	if (retval < 0)		/* error or disconnect */
 		goto fail;
 				/* success, speed is known */
@@ -2152,7 +2154,7 @@
 	} else if (udev->speed != USB_SPEED_HIGH
 			&& hdev->speed == USB_SPEED_HIGH) {
 		udev->tt = &hub->tt;
-		udev->ttport = port + 1;
+		udev->ttport = port1;
 	}
  
 	/* Why interleave GET_DESCRIPTOR and SET_ADDRESS this way?
@@ -2202,7 +2204,7 @@
 					buf->bMaxPacketSize0;
 			kfree(buf);
 
-			retval = hub_port_reset(hub, port, udev, delay);
+			retval = hub_port_reset(hub, port1, udev, delay);
 			if (retval < 0)		/* error or disconnect */
 				goto fail;
 			if (oldspeed != udev->speed) {
@@ -2286,13 +2288,13 @@
 
 fail:
 	if (retval)
-		hub_port_disable(hub, port, 0);
+		hub_port_disable(hub, port1, 0);
 	up(&usb_address0_sem);
 	return retval;
 }
 
 static void
-check_highspeed (struct usb_hub *hub, struct usb_device *udev, int port)
+check_highspeed (struct usb_hub *hub, struct usb_device *udev, int port1)
 {
 	struct usb_qualifier_descriptor	*qual;
 	int				status;
@@ -2308,7 +2310,7 @@
 			"connect to a high speed hub\n");
 		/* hub LEDs are probably harder to miss than syslog */
 		if (hub->has_indicators) {
-			hub->indicator[port] = INDICATOR_GREEN_BLINK;
+			hub->indicator[port1-1] = INDICATOR_GREEN_BLINK;
 			schedule_work (&hub->leds);
 		}
 	}
@@ -2366,7 +2368,7 @@
  *		a firmware download)
  * caller already locked the hub
  */
-static void hub_port_connect_change(struct usb_hub *hub, int port,
+static void hub_port_connect_change(struct usb_hub *hub, int port1,
 					u16 portstatus, u16 portchange)
 {
 	struct usb_device *hdev = hub->hdev;
@@ -2375,17 +2377,17 @@
  
 	dev_dbg (hub_dev,
 		"port %d, status %04x, change %04x, %s\n",
-		port + 1, portstatus, portchange, portspeed (portstatus));
+		port1, portstatus, portchange, portspeed (portstatus));
 
 	if (hub->has_indicators) {
-		set_port_led(hub, port + 1, HUB_LED_AUTO);
-		hub->indicator[port] = INDICATOR_AUTO;
+		set_port_led(hub, port1, HUB_LED_AUTO);
+		hub->indicator[port1-1] = INDICATOR_AUTO;
 	}
  
 	/* Disconnect any existing devices under this port */
-	if (hdev->children[port])
-		usb_disconnect(&hdev->children[port]);
-	clear_bit(port, hub->change_bits);
+	if (hdev->children[port1-1])
+		usb_disconnect(&hdev->children[port1-1]);
+	clear_bit(port1, hub->change_bits);
 
 #ifdef	CONFIG_USB_OTG
 	/* during HNP, don't repeat the debounce */
@@ -2394,11 +2396,11 @@
 #endif
 
 	if (portchange & USB_PORT_STAT_C_CONNECTION) {
-		status = hub_port_debounce(hub, port);
+		status = hub_port_debounce(hub, port1);
 		if (status < 0) {
 			dev_err (hub_dev,
 				"connect-debounce failed, port %d disabled\n",
-				port+1);
+				port1);
 			goto done;
 		}
 		portstatus = status;
@@ -2411,7 +2413,7 @@
 		if ((hub->descriptor->wHubCharacteristics
 					& HUB_CHAR_LPSM) < 2
 				&& !(portstatus & (1 << USB_PORT_FEAT_POWER)))
-			set_port_feature(hdev, port + 1, USB_PORT_FEAT_POWER);
+			set_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
  
 		if (portstatus & USB_PORT_STAT_ENABLE)
   			goto done;
@@ -2421,11 +2423,11 @@
 #ifdef  CONFIG_USB_SUSPEND
 	/* If something is connected, but the port is suspended, wake it up. */
 	if (portstatus & USB_PORT_STAT_SUSPEND) {
-		status = hub_port_resume(hub, port, NULL);
+		status = hub_port_resume(hub, port1, NULL);
 		if (status < 0) {
 			dev_dbg(hub_dev,
 				"can't clear suspend on port %d; %d\n",
-				port+1, status);
+				port1, status);
 			goto done;
 		}
 	}
@@ -2437,10 +2439,11 @@
 		/* reallocate for each attempt, since references
 		 * to the previous one can escape in various ways
 		 */
-		udev = usb_alloc_dev(hdev, hdev->bus, port);
+		udev = usb_alloc_dev(hdev, hdev->bus, port1);
 		if (!udev) {
 			dev_err (hub_dev,
-				"couldn't allocate port %d usb_device\n", port+1);
+				"couldn't allocate port %d usb_device\n",
+				port1);
 			goto done;
 		}
 
@@ -2455,7 +2458,7 @@
 		}
 
 		/* reset and get descriptor */
-		status = hub_port_init(hub, udev, port, i);
+		status = hub_port_init(hub, udev, port1, i);
 		if (status < 0)
 			goto loop;
 
@@ -2481,7 +2484,7 @@
 					"can't connect bus-powered hub "
 					"to this port\n");
 				if (hub->has_indicators) {
-					hub->indicator[port] =
+					hub->indicator[port1-1] =
 						INDICATOR_AMBER_BLINK;
 					schedule_work (&hub->leds);
 				}
@@ -2494,7 +2497,7 @@
 		if (udev->descriptor.bcdUSB >= 0x0200
 				&& udev->speed == USB_SPEED_FULL
 				&& highspeed_hubs != 0)
-			check_highspeed (hub, udev, port);
+			check_highspeed (hub, udev, port1);
 
 		/* Store the parent's children[] pointer.  At this point
 		 * udev becomes globally accessible, although presumably
@@ -2511,7 +2514,7 @@
 		if (hdev->state == USB_STATE_NOTATTACHED)
 			status = -ENOTCONN;
 		else
-			hdev->children[port] = udev;
+			hdev->children[port1-1] = udev;
 		spin_unlock_irq(&device_state_lock);
 
 		/* Run it through the hoops (find a driver, etc) */
@@ -2519,7 +2522,7 @@
 			status = usb_new_device(udev);
 			if (status) {
 				spin_lock_irq(&device_state_lock);
-				hdev->children[port] = NULL;
+				hdev->children[port1-1] = NULL;
 				spin_unlock_irq(&device_state_lock);
 			}
 		}
@@ -2537,7 +2540,7 @@
 		return;
 
 loop_disable:
-		hub_port_disable(hub, port, 1);
+		hub_port_disable(hub, port1, 1);
 loop:
 		ep0_reinit(udev);
 		release_address(udev);
@@ -2547,7 +2550,7 @@
 	}
  
 done:
-	hub_port_disable(hub, port, 1);
+	hub_port_disable(hub, port1, 1);
 }
 
 static void hub_events(void)
@@ -2623,9 +2626,9 @@
 		}
 
 		/* deal with port status changes */
-		for (i = 0; i < hub->descriptor->bNbrPorts; i++) {
+		for (i = 1; i <= hub->descriptor->bNbrPorts; i++) {
 			connect_change = test_bit(i, hub->change_bits);
-			if (!test_and_clear_bit(i+1, hub->event_bits) &&
+			if (!test_and_clear_bit(i, hub->event_bits) &&
 					!connect_change)
 				continue;
 
@@ -2635,8 +2638,8 @@
 				continue;
 
 			if (portchange & USB_PORT_STAT_C_CONNECTION) {
-				clear_port_feature(hdev,
-					i + 1, USB_PORT_FEAT_C_CONNECTION);
+				clear_port_feature(hdev, i,
+					USB_PORT_FEAT_C_CONNECTION);
 				connect_change = 1;
 			}
 
@@ -2645,9 +2648,9 @@
 					dev_dbg (hub_dev,
 						"port %d enable change, "
 						"status %08x\n",
-						i + 1, portstatus);
-				clear_port_feature(hdev,
-					i + 1, USB_PORT_FEAT_C_ENABLE);
+						i, portstatus);
+				clear_port_feature(hdev, i,
+					USB_PORT_FEAT_C_ENABLE);
 
 				/*
 				 * EM interference sometimes causes badly
@@ -2657,21 +2660,22 @@
 				 */
 				if (!(portstatus & USB_PORT_STAT_ENABLE)
 				    && !connect_change
-				    && hdev->children[i]) {
+				    && hdev->children[i-1]) {
 					dev_err (hub_dev,
 					    "port %i "
 					    "disabled by hub (EMI?), "
 					    "re-enabling...\n",
-						i + 1);
+						i);
 					connect_change = 1;
 				}
 			}
 
 			if (portchange & USB_PORT_STAT_C_SUSPEND) {
-				clear_port_feature(hdev, i + 1,
+				clear_port_feature(hdev, i,
 					USB_PORT_FEAT_C_SUSPEND);
-				if (hdev->children[i]) {
-					ret = remote_wakeup(hdev->children[i]);
+				if (hdev->children[i-1]) {
+					ret = remote_wakeup(hdev->
+							children[i-1]);
 					if (ret < 0)
 						connect_change = 1;
 				} else {
@@ -2680,24 +2684,24 @@
 				}
 				dev_dbg (hub_dev,
 					"resume on port %d, status %d\n",
-					i + 1, ret);
+					i, ret);
 			}
 			
 			if (portchange & USB_PORT_STAT_C_OVERCURRENT) {
 				dev_err (hub_dev,
 					"over-current change on port %d\n",
-					i + 1);
-				clear_port_feature(hdev,
-					i + 1, USB_PORT_FEAT_C_OVER_CURRENT);
+					i);
+				clear_port_feature(hdev, i,
+					USB_PORT_FEAT_C_OVER_CURRENT);
 				hub_power_on(hub);
 			}
 
 			if (portchange & USB_PORT_STAT_C_RESET) {
 				dev_dbg (hub_dev,
 					"reset change on port %d\n",
-					i + 1);
-				clear_port_feature(hdev,
-					i + 1, USB_PORT_FEAT_C_RESET);
+					i);
+				clear_port_feature(hdev, i,
+					USB_PORT_FEAT_C_RESET);
 			}
 
 			if (connect_change)
@@ -2886,7 +2890,7 @@
 	struct usb_hub			*parent_hub;
 	struct usb_device_descriptor	descriptor = udev->descriptor;
 	struct usb_hub			*hub = NULL;
-	int 				i, ret = 0, port = -1;
+	int 				i, ret = 0, port1 = -1;
 
 	if (udev->state == USB_STATE_NOTATTACHED ||
 			udev->state == USB_STATE_SUSPENDED) {
@@ -2903,11 +2907,11 @@
 
 	for (i = 0; i < parent_hdev->maxchild; i++)
 		if (parent_hdev->children[i] == udev) {
-			port = i;
+			port1 = i + 1;
 			break;
 		}
 
-	if (port < 0) {
+	if (port1 < 0) {
 		/* If this ever happens, it's very bad */
 		dev_err(&udev->dev, "Can't locate device's port!\n");
 		return -ENOENT;
@@ -2927,7 +2931,7 @@
 		/* ep0 maxpacket size may change; let the HCD know about it.
 		 * Other endpoints will be handled by re-enumeration. */
 		ep0_reinit(udev);
-		ret = hub_port_init(parent_hub, udev, port, i);
+		ret = hub_port_init(parent_hub, udev, port1, i);
 		if (ret >= 0)
 			break;
 	}
@@ -2983,6 +2987,6 @@
 	return 0;
  
 re_enumerate:
-	hub_port_logical_disconnect(parent_hub, port);
+	hub_port_logical_disconnect(parent_hub, port1);
 	return -ENODEV;
 }
diff -Nru a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
--- a/drivers/usb/core/usb.c	2005-01-07 15:42:44 -08:00
+++ b/drivers/usb/core/usb.c	2005-01-07 15:42:44 -08:00
@@ -655,7 +655,7 @@
  * usb_alloc_dev - usb device constructor (usbcore-internal)
  * @parent: hub to which device is connected; null to allocate a root hub
  * @bus: bus used to access the device
- * @port: zero based index of port; ignored for root hubs
+ * @port1: one-based index of port; ignored for root hubs
  * Context: !in_interrupt ()
  *
  * Only hub drivers (including virtual root hub drivers for host
@@ -664,7 +664,7 @@
  * This call may not be used in a non-sleeping context.
  */
 struct usb_device *
-usb_alloc_dev(struct usb_device *parent, struct usb_bus *bus, unsigned port)
+usb_alloc_dev(struct usb_device *parent, struct usb_bus *bus, unsigned port1)
 {
 	struct usb_device *dev;
 
@@ -711,10 +711,10 @@
 		/* match any labeling on the hubs; it's one-based */
 		if (parent->devpath [0] == '0')
 			snprintf (dev->devpath, sizeof dev->devpath,
-				"%d", port + 1);
+				"%d", port1);
 		else
 			snprintf (dev->devpath, sizeof dev->devpath,
-				"%s.%d", parent->devpath, port + 1);
+				"%s.%d", parent->devpath, port1);
 
 		dev->dev.parent = &parent->dev;
 		sprintf (&dev->dev.bus_id[0], "%d-%s",

