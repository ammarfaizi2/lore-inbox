Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbVAHF6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVAHF6L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 00:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbVAHF6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 00:58:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:17029 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261798AbVAHFrz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:47:55 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632692480@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:49 -0800
Message-Id: <1105163269213@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.48, 2004/12/20 15:01:03-08:00, stern@rowland.harvard.edu

[PATCH] USB: Hub driver cleanups [12/13]

This patch does a little cleanup of the hub driver, nothing dramatic
(although it is long because it touches a lot of code).  The main feature
is that the private hub structure is passed as an argument to internal
routines rather than the hub device structure.  This simplifies
conversions, because it's easier to go from the private structure to the
device structure than vice versa.  The other change is to store a pointer
to the interface's embedded struct device rather than the interface
itself.  This helps because that pointer is mainly used for dev_xxx log
messages.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/core/hub.c |  202 +++++++++++++++++++++++--------------------------
 drivers/usb/core/hub.h |    2 
 2 files changed, 99 insertions(+), 105 deletions(-)


diff -Nru a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
--- a/drivers/usb/core/hub.c	2005-01-07 15:42:51 -08:00
+++ b/drivers/usb/core/hub.c	2005-01-07 15:42:51 -08:00
@@ -94,10 +94,10 @@
 }
 #endif
 
-/* for dev_info, dev_dbg, etc */
-static inline struct device *hubdev (struct usb_device *hdev)
+/* Note that hdev or one of its children must be locked! */
+static inline struct usb_hub *hdev_to_hub(struct usb_device *hdev)
 {
-	return &hdev->actconfig->interface[0]->dev;
+	return usb_get_intfdata(hdev->actconfig->interface[0]);
 }
 
 /* USB 2.0 spec Section 11.24.4.5 */
@@ -148,15 +148,15 @@
  * for info about using port indicators
  */
 static void set_port_led(
-	struct usb_device *hdev,
+	struct usb_hub *hub,
 	int port,
 	int selector
 )
 {
-	int status = set_port_feature(hdev, (selector << 8) | port,
+	int status = set_port_feature(hub->hdev, (selector << 8) | port,
 			USB_PORT_FEAT_INDICATOR);
 	if (status < 0)
-		dev_dbg (hubdev (hdev),
+		dev_dbg (hub->intfdev,
 			"port %d indicator %s status %d\n",
 			port,
 			({ char *s; switch (selector) {
@@ -226,13 +226,13 @@
 		}
 		if (selector != HUB_LED_AUTO)
 			changed = 1;
-		set_port_led(hdev, i + 1, selector);
+		set_port_led(hub, i + 1, selector);
 		hub->indicator[i] = mode;
 	}
 	if (!changed && blinkenlights) {
 		cursor++;
 		cursor %= hub->descriptor->bNbrPorts;
-		set_port_led(hdev, cursor + 1, HUB_LED_GREEN);
+		set_port_led(hub, cursor + 1, HUB_LED_GREEN);
 		hub->indicator[cursor] = INDICATOR_CYCLE;
 		changed++;
 	}
@@ -305,7 +305,7 @@
 
 	default:		/* presumably an error */
 		/* Cause a hub reset after 10 consecutive errors */
-		dev_dbg (&hub->intf->dev, "transfer --> %d\n", urb->status);
+		dev_dbg (hub->intfdev, "transfer --> %d\n", urb->status);
 		if ((++hub->nerrors < 10) || hub->error)
 			goto resubmit;
 		hub->error = urb->status;
@@ -332,7 +332,7 @@
 
 	if ((status = usb_submit_urb (hub->urb, GFP_ATOMIC)) != 0
 			&& status != -ENODEV && status != -EPERM)
-		dev_err (&hub->intf->dev, "resubmit --> %d\n", status);
+		dev_err (hub->intfdev, "resubmit --> %d\n", status);
 }
 
 /* USB 2.0 spec Section 11.24.2.3 */
@@ -432,7 +432,7 @@
 
 	/* if hub supports power switching, enable power on each port */
 	if ((hub->descriptor->wHubCharacteristics & HUB_CHAR_LPSM) < 2) {
-		dev_dbg(&hub->intf->dev, "enabling power on all ports\n");
+		dev_dbg(hub->intfdev, "enabling power on all ports\n");
 		for (i = 0; i < hub->descriptor->bNbrPorts; i++)
 			set_port_feature(hub->hdev, i + 1,
 					USB_PORT_FEAT_POWER);
@@ -460,7 +460,7 @@
 	hub->quiescing = 0;
 	status = usb_submit_urb(hub->urb, GFP_NOIO);
 	if (status < 0)
-		dev_err(&hub->intf->dev, "activate --> %d\n", status);
+		dev_err(hub->intfdev, "activate --> %d\n", status);
 	if (hub->has_indicators && blinkenlights)
 		schedule_delayed_work(&hub->leds, LED_CYCLE_PERIOD);
 
@@ -476,7 +476,7 @@
 
 	ret = get_hub_status(hub->hdev, &hub->status->hub);
 	if (ret < 0)
-		dev_err (&hub->intf->dev,
+		dev_err (hub->intfdev,
 			"%s failed (err = %d)\n", __FUNCTION__, ret);
 	else {
 		*status = le16_to_cpu(hub->status->hub.wHubStatus);
@@ -490,7 +490,7 @@
 	struct usb_endpoint_descriptor *endpoint)
 {
 	struct usb_device *hdev = hub->hdev;
-	struct device *hub_dev = &hub->intf->dev;
+	struct device *hub_dev = hub->intfdev;
 	u16 hubstatus, hubchange;
 	unsigned int pipe;
 	int maxp, ret;
@@ -749,18 +749,16 @@
 	struct usb_endpoint_descriptor *endpoint;
 	struct usb_device *hdev;
 	struct usb_hub *hub;
-	struct device *hub_dev;
 
 	desc = intf->cur_altsetting;
 	hdev = interface_to_usbdev(intf);
-	hub_dev = &intf->dev;
 
 	/* Some hubs have a subclass of 1, which AFAICT according to the */
 	/*  specs is not defined, but it works */
 	if ((desc->desc.bInterfaceSubClass != 0) &&
 	    (desc->desc.bInterfaceSubClass != 1)) {
 descriptor_error:
-		dev_err (hub_dev, "bad descriptor, ignoring hub\n");
+		dev_err (&intf->dev, "bad descriptor, ignoring hub\n");
 		return -EIO;
 	}
 
@@ -780,18 +778,18 @@
 		goto descriptor_error;
 
 	/* We found a hub */
-	dev_info (hub_dev, "USB hub found\n");
+	dev_info (&intf->dev, "USB hub found\n");
 
 	hub = kmalloc(sizeof(*hub), GFP_KERNEL);
 	if (!hub) {
-		dev_dbg (hub_dev, "couldn't kmalloc hub struct\n");
+		dev_dbg (&intf->dev, "couldn't kmalloc hub struct\n");
 		return -ENOMEM;
 	}
 
 	memset(hub, 0, sizeof(*hub));
 
 	INIT_LIST_HEAD(&hub->event_list);
-	hub->intf = intf;
+	hub->intfdev = &intf->dev;
 	hub->hdev = hdev;
 	INIT_WORK(&hub->leds, led_work, hub);
 
@@ -842,9 +840,9 @@
 }
 
 /* caller has locked the hub device */
-static void hub_pre_reset(struct usb_device *hdev)
+static void hub_pre_reset(struct usb_hub *hub)
 {
-	struct usb_hub *hub = usb_get_intfdata(hdev->actconfig->interface[0]);
+	struct usb_device *hdev = hub->hdev;
 	int i;
 
 	for (i = 0; i < hdev->maxchild; ++i) {
@@ -855,10 +853,8 @@
 }
 
 /* caller has locked the hub device */
-static void hub_post_reset(struct usb_device *hdev)
+static void hub_post_reset(struct usb_hub *hub)
 {
-	struct usb_hub *hub = usb_get_intfdata(hdev->actconfig->interface[0]);
-
 	hub_activate(hub);
 	hub_power_on(hub);
 }
@@ -1288,18 +1284,14 @@
 }
 
 
-static int hub_port_status(struct usb_device *hdev, int port,
+static int hub_port_status(struct usb_hub *hub, int port,
 			       u16 *status, u16 *change)
 {
-	struct usb_hub *hub = usb_get_intfdata(hdev->actconfig->interface[0]);
 	int ret;
 
-	if (!hub)
-		return -ENODEV;
-
-	ret = get_port_status(hdev, port + 1, &hub->status->port);
+	ret = get_port_status(hub->hdev, port + 1, &hub->status->port);
 	if (ret < 0)
-		dev_err (&hub->intf->dev,
+		dev_err (hub->intfdev,
 			"%s failed (err = %d)\n", __FUNCTION__, ret);
 	else {
 		*status = le16_to_cpu(hub->status->port.wPortStatus);
@@ -1320,7 +1312,7 @@
 #define HUB_LONG_RESET_TIME	200
 #define HUB_RESET_TIMEOUT	500
 
-static int hub_port_wait_reset(struct usb_device *hdev, int port,
+static int hub_port_wait_reset(struct usb_hub *hub, int port,
 				struct usb_device *udev, unsigned int delay)
 {
 	int delay_time, ret;
@@ -1334,7 +1326,7 @@
 		msleep(delay);
 
 		/* read and decode port status */
-		ret = hub_port_status(hdev, port, &portstatus, &portchange);
+		ret = hub_port_status(hub, port, &portstatus, &portchange);
 		if (ret < 0)
 			return ret;
 
@@ -1362,7 +1354,7 @@
 		if (delay_time >= 2 * HUB_SHORT_RESET_TIME)
 			delay = HUB_LONG_RESET_TIME;
 
-		dev_dbg (hubdev (hdev),
+		dev_dbg (hub->intfdev,
 			"port %d not reset yet, waiting %dms\n",
 			port + 1, delay);
 	}
@@ -1370,27 +1362,28 @@
 	return -EBUSY;
 }
 
-static int hub_port_reset(struct usb_device *hdev, int port,
+static int hub_port_reset(struct usb_hub *hub, int port,
 				struct usb_device *udev, unsigned int delay)
 {
 	int i, status;
-	struct device *hub_dev = hubdev (hdev);
 
 	/* Reset the port */
 	for (i = 0; i < PORT_RESET_TRIES; i++) {
-		status = set_port_feature(hdev, port + 1, USB_PORT_FEAT_RESET);
+		status = set_port_feature(hub->hdev,
+				port + 1, USB_PORT_FEAT_RESET);
 		if (status)
-			dev_err(hub_dev, "cannot reset port %d (err = %d)\n",
+			dev_err(hub->intfdev,
+					"cannot reset port %d (err = %d)\n",
 					port + 1, status);
 		else
-			status = hub_port_wait_reset(hdev, port, udev, delay);
+			status = hub_port_wait_reset(hub, port, udev, delay);
 
 		/* return on disconnect or reset */
 		switch (status) {
 		case 0:
 		case -ENOTCONN:
 		case -ENODEV:
-			clear_port_feature(hdev,
+			clear_port_feature(hub->hdev,
 				port + 1, USB_PORT_FEAT_C_RESET);
 			/* FIXME need disconnect() for NOTATTACHED device */
 			usb_set_device_state(udev, status
@@ -1399,21 +1392,22 @@
 			return status;
 		}
 
-		dev_dbg (hub_dev,
+		dev_dbg (hub->intfdev,
 			"port %d not enabled, trying reset again...\n",
 			port + 1);
 		delay = HUB_LONG_RESET_TIME;
 	}
 
-	dev_err (hub_dev,
+	dev_err (hub->intfdev,
 		"Cannot enable port %i.  Maybe the USB cable is bad?\n",
 		port + 1);
 
 	return status;
 }
 
-static int hub_port_disable(struct usb_device *hdev, int port, int set_state)
+static int hub_port_disable(struct usb_hub *hub, int port, int set_state)
 {
+	struct usb_device *hdev = hub->hdev;
 	int ret;
 
 	if (hdev->children[port] && set_state) {
@@ -1422,7 +1416,7 @@
 	}
 	ret = clear_port_feature(hdev, port + 1, USB_PORT_FEAT_ENABLE);
 	if (ret)
-		dev_err(hubdev(hdev), "cannot disable port %d (err = %d)\n",
+		dev_err(hub->intfdev, "cannot disable port %d (err = %d)\n",
 			port + 1, ret);
 
 	return ret;
@@ -1433,12 +1427,10 @@
  * time later khubd will disconnect() any existing usb_device on the port
  * and will re-enumerate if there actually is a device attached.
  */
-static void hub_port_logical_disconnect(struct usb_device *hdev, int port)
+static void hub_port_logical_disconnect(struct usb_hub *hub, int port)
 {
-	struct usb_hub *hub;
-
-	dev_dbg(hubdev(hdev), "logical disconnect on port %d\n", port + 1);
-	hub_port_disable(hdev, port, 1);
+	dev_dbg(hub->intfdev, "logical disconnect on port %d\n", port + 1);
+	hub_port_disable(hub, port, 1);
 
 	/* FIXME let caller ask to power down the port:
 	 *  - some devices won't enumerate without a VBUS power cycle
@@ -1449,7 +1441,6 @@
 	 * Powerdown must be optional, because of reset/DFU.
 	 */
 
-	hub = usb_get_intfdata(hdev->actconfig->interface[0]);
 	set_bit(port, hub->change_bits);
  	kick_khubd(hub);
 }
@@ -1467,12 +1458,12 @@
  * tree above them to deliver data, such as a keypress or packet.  In
  * some cases, this wakes the USB host.
  */
-static int hub_port_suspend(struct usb_device *hdev, int port,
+static int hub_port_suspend(struct usb_hub *hub, int port,
 		struct usb_device *udev)
 {
 	int	status;
 
-	// dev_dbg(hubdev(hdev), "suspend port %d\n", port + 1);
+	// dev_dbg(hub->intfdev, "suspend port %d\n", port + 1);
 
 	/* enable remote wakeup when appropriate; this lets the device
 	 * wake up the upstream hub (including maybe the root hub).
@@ -1497,9 +1488,9 @@
 	}
 
 	/* see 7.1.7.6 */
-	status = set_port_feature(hdev, port + 1, USB_PORT_FEAT_SUSPEND);
+	status = set_port_feature(hub->hdev, port + 1, USB_PORT_FEAT_SUSPEND);
 	if (status) {
-		dev_dbg(hubdev(hdev),
+		dev_dbg(hub->intfdev,
 			"can't suspend port %d, status %d\n",
 			port + 1, status);
 		/* paranoia:  "should not happen" */
@@ -1618,7 +1609,8 @@
 		} else
 			status = -EOPNOTSUPP;
 	} else
-		status = hub_port_suspend(udev->parent, port, udev);
+		status = hub_port_suspend(hdev_to_hub(udev->parent), port,
+				udev);
 
 	if (status == 0)
 		udev->dev.power.power_state = state;
@@ -1746,16 +1738,17 @@
 }
 
 static int
-hub_port_resume(struct usb_device *hdev, int port, struct usb_device *udev)
+hub_port_resume(struct usb_hub *hub, int port, struct usb_device *udev)
 {
 	int	status;
 
-	// dev_dbg(hubdev(hdev), "resume port %d\n", port + 1);
+	// dev_dbg(hub->intfdev, "resume port %d\n", port + 1);
 
 	/* see 7.1.7.7; affects power usage, but not budgeting */
-	status = clear_port_feature(hdev, port + 1, USB_PORT_FEAT_SUSPEND);
+	status = clear_port_feature(hub->hdev,
+			port + 1, USB_PORT_FEAT_SUSPEND);
 	if (status) {
-		dev_dbg(&hdev->actconfig->interface[0]->dev,
+		dev_dbg(hub->intfdev,
 			"can't resume port %d, status %d\n",
 			port + 1, status);
 	} else {
@@ -1776,13 +1769,13 @@
 		 * sequence.
 		 */
 		devstatus = portchange = 0;
-		status = hub_port_status(hdev, port,
+		status = hub_port_status(hub, port,
 				&devstatus, &portchange);
 		if (status < 0
 				|| (devstatus & LIVE_FLAGS) != LIVE_FLAGS
 				|| (devstatus & USB_PORT_STAT_SUSPEND) != 0
 				) {
-			dev_dbg(&hdev->actconfig->interface[0]->dev,
+			dev_dbg(hub->intfdev,
 				"port %d status %04x.%04x after resume, %d\n",
 				port + 1, portchange, devstatus, status);
 		} else {
@@ -1793,7 +1786,7 @@
 		}
 	}
 	if (status < 0)
-		hub_port_logical_disconnect(hdev, port);
+		hub_port_logical_disconnect(hub, port);
 
 	return status;
 }
@@ -1815,7 +1808,7 @@
  */
 int usb_resume_device(struct usb_device *udev)
 {
-	int			port, status;
+	int	port, status;
 
 	port = locktree(udev);
 	if (port < 0)
@@ -1839,7 +1832,8 @@
 		}
 	} else if (udev->state == USB_STATE_SUSPENDED) {
 		// NOTE this fails if parent is also suspended...
-		status = hub_port_resume(udev->parent, port, udev);
+		status = hub_port_resume(hdev_to_hub(udev->parent),
+				port, udev);
 	} else {
 		status = 0;
 	}
@@ -1921,7 +1915,7 @@
 		u16			portstat, portchange;
 
 		udev = hdev->children [port];
-		status = hub_port_status(hdev, port, &portstat, &portchange);
+		status = hub_port_status(hub, port, &portstat, &portchange);
 		if (status == 0) {
 			if (portchange & USB_PORT_STAT_C_SUSPEND) {
 				clear_port_feature(hdev, port + 1,
@@ -1938,13 +1932,13 @@
 			continue;
 		down (&udev->serialize);
 		if (portstat & USB_PORT_STAT_SUSPEND)
-			status = hub_port_resume(hdev, port, udev);
+			status = hub_port_resume(hub, port, udev);
 		else {
 			status = finish_port_resume(udev);
 			if (status < 0) {
 				dev_dbg(&intf->dev, "resume port %d --> %d\n",
 					port + 1, status);
-				hub_port_logical_disconnect(hdev, port);
+				hub_port_logical_disconnect(hub, port);
 			}
 		}
 		up(&udev->serialize);
@@ -1998,7 +1992,7 @@
 #define HUB_DEBOUNCE_STEP	  25
 #define HUB_DEBOUNCE_STABLE	 100
 
-static int hub_port_debounce(struct usb_device *hdev, int port)
+static int hub_port_debounce(struct usb_hub *hub, int port)
 {
 	int ret;
 	int total_time, stable_time = 0;
@@ -2006,7 +2000,7 @@
 	unsigned connection = 0xffff;
 
 	for (total_time = 0; ; total_time += HUB_DEBOUNCE_STEP) {
-		ret = hub_port_status(hdev, port, &portstatus, &portchange);
+		ret = hub_port_status(hub, port, &portstatus, &portchange);
 		if (ret < 0)
 			return ret;
 
@@ -2021,7 +2015,7 @@
 		}
 
 		if (portchange & USB_PORT_STAT_C_CONNECTION) {
-			clear_port_feature(hdev, port+1,
+			clear_port_feature(hub->hdev, port+1,
 					USB_PORT_FEAT_C_CONNECTION);
 		}
 
@@ -2030,7 +2024,7 @@
 		msleep(HUB_DEBOUNCE_STEP);
 	}
 
-	dev_dbg (hubdev (hdev),
+	dev_dbg (hub->intfdev,
 		"debounce: port %d: total %dms stable %dms status 0x%x\n",
 		port + 1, total_time, stable_time, portstatus);
 
@@ -2079,11 +2073,12 @@
  * pointers, it's not necessary to lock the device.
  */
 static int
-hub_port_init (struct usb_device *hdev, struct usb_device *udev, int port,
+hub_port_init (struct usb_hub *hub, struct usb_device *udev, int port,
 		int retry_counter)
 {
 	static DECLARE_MUTEX(usb_address0_sem);
 
+	struct usb_device	*hdev = hub->hdev;
 	int			i, j, retval;
 	unsigned		delay = HUB_SHORT_RESET_TIME;
 	enum usb_device_speed	oldspeed = udev->speed;
@@ -2105,7 +2100,7 @@
 	down(&usb_address0_sem);
 
 	/* Reset the device; full speed may morph to high speed */
-	retval = hub_port_reset(hdev, port, udev, delay);
+	retval = hub_port_reset(hub, port, udev, delay);
 	if (retval < 0)		/* error or disconnect */
 		goto fail;
 				/* success, speed is known */
@@ -2156,9 +2151,6 @@
 		udev->ttport = hdev->ttport;
 	} else if (udev->speed != USB_SPEED_HIGH
 			&& hdev->speed == USB_SPEED_HIGH) {
-		struct usb_hub *hub;
-
-		hub = usb_get_intfdata(hdev->actconfig->interface[0]);
 		udev->tt = &hub->tt;
 		udev->ttport = port + 1;
 	}
@@ -2210,7 +2202,7 @@
 					buf->bMaxPacketSize0;
 			kfree(buf);
 
-			retval = hub_port_reset(hdev, port, udev, delay);
+			retval = hub_port_reset(hub, port, udev, delay);
 			if (retval < 0)		/* error or disconnect */
 				goto fail;
 			if (oldspeed != udev->speed) {
@@ -2294,7 +2286,7 @@
 
 fail:
 	if (retval)
-		hub_port_disable(hdev, port, 0);
+		hub_port_disable(hub, port, 0);
 	up(&usb_address0_sem);
 	return retval;
 }
@@ -2358,7 +2350,7 @@
 		remaining -= delta;
 	}
 	if (remaining < 0) {
-		dev_warn(&hub->intf->dev,
+		dev_warn(hub->intfdev,
 			"%dmA over power budget!\n",
 			-2 * remaining);
 		remaining = 0;
@@ -2378,7 +2370,7 @@
 					u16 portstatus, u16 portchange)
 {
 	struct usb_device *hdev = hub->hdev;
-	struct device *hub_dev = &hub->intf->dev;
+	struct device *hub_dev = hub->intfdev;
 	int status, i;
  
 	dev_dbg (hub_dev,
@@ -2386,7 +2378,7 @@
 		port + 1, portstatus, portchange, portspeed (portstatus));
 
 	if (hub->has_indicators) {
-		set_port_led(hdev, port + 1, HUB_LED_AUTO);
+		set_port_led(hub, port + 1, HUB_LED_AUTO);
 		hub->indicator[port] = INDICATOR_AUTO;
 	}
  
@@ -2402,7 +2394,7 @@
 #endif
 
 	if (portchange & USB_PORT_STAT_C_CONNECTION) {
-		status = hub_port_debounce(hdev, port);
+		status = hub_port_debounce(hub, port);
 		if (status < 0) {
 			dev_err (hub_dev,
 				"connect-debounce failed, port %d disabled\n",
@@ -2429,7 +2421,7 @@
 #ifdef  CONFIG_USB_SUSPEND
 	/* If something is connected, but the port is suspended, wake it up. */
 	if (portstatus & USB_PORT_STAT_SUSPEND) {
-		status = hub_port_resume(hdev, port, NULL);
+		status = hub_port_resume(hub, port, NULL);
 		if (status < 0) {
 			dev_dbg(hub_dev,
 				"can't clear suspend on port %d; %d\n",
@@ -2463,7 +2455,7 @@
 		}
 
 		/* reset and get descriptor */
-		status = hub_port_init(hdev, udev, port, i);
+		status = hub_port_init(hub, udev, port, i);
 		if (status < 0)
 			goto loop;
 
@@ -2545,7 +2537,7 @@
 		return;
 
 loop_disable:
-		hub_port_disable(hdev, port, 1);
+		hub_port_disable(hub, port, 1);
 loop:
 		ep0_reinit(udev);
 		release_address(udev);
@@ -2555,7 +2547,7 @@
 	}
  
 done:
-	hub_port_disable(hdev, port, 1);
+	hub_port_disable(hub, port, 1);
 }
 
 static void hub_events(void)
@@ -2592,7 +2584,7 @@
 
 		hub = list_entry(tmp, struct usb_hub, event_list);
 		hdev = hub->hdev;
-		intf = hub->intf;
+		intf = to_usb_interface(hub->intfdev);
 		hub_dev = &intf->dev;
 
 		dev_dbg(hub_dev, "state %d ports %d chg %04x evt %04x\n",
@@ -2637,7 +2629,7 @@
 					!connect_change)
 				continue;
 
-			ret = hub_port_status(hdev, i,
+			ret = hub_port_status(hub, i,
 					&portstatus, &portchange);
 			if (ret < 0)
 				continue;
@@ -2684,7 +2676,7 @@
 						connect_change = 1;
 				} else {
 					ret = -ENODEV;
-					hub_port_disable(hdev, i, 1);
+					hub_port_disable(hub, i, 1);
 				}
 				dev_dbg (hub_dev,
 					"resume on port %d, status %d\n",
@@ -2890,10 +2882,11 @@
  */
 int usb_reset_device(struct usb_device *udev)
 {
-	struct usb_device *parent = udev->parent;
-	struct usb_device_descriptor descriptor = udev->descriptor;
-	int i, ret = 0, port = -1;
-	int udev_is_a_hub = 0;
+	struct usb_device		*parent_hdev = udev->parent;
+	struct usb_hub			*parent_hub;
+	struct usb_device_descriptor	descriptor = udev->descriptor;
+	struct usb_hub			*hub = NULL;
+	int 				i, ret = 0, port = -1;
 
 	if (udev->state == USB_STATE_NOTATTACHED ||
 			udev->state == USB_STATE_SUSPENDED) {
@@ -2902,14 +2895,14 @@
 		return -EINVAL;
 	}
 
-	if (!parent) {
+	if (!parent_hdev) {
 		/* this requires hcd-specific logic; see OHCI hc_restart() */
 		dev_dbg(&udev->dev, "%s for root hub!\n", __FUNCTION__);
 		return -EISDIR;
 	}
 
-	for (i = 0; i < parent->maxchild; i++)
-		if (parent->children[i] == udev) {
+	for (i = 0; i < parent_hdev->maxchild; i++)
+		if (parent_hdev->children[i] == udev) {
 			port = i;
 			break;
 		}
@@ -2919,13 +2912,14 @@
 		dev_err(&udev->dev, "Can't locate device's port!\n");
 		return -ENOENT;
 	}
+	parent_hub = hdev_to_hub(parent_hdev);
 
 	/* If we're resetting an active hub, take some special actions */
 	if (udev->actconfig &&
 			udev->actconfig->interface[0]->dev.driver ==
-			&hub_driver.driver) {
-		udev_is_a_hub = 1;
-		hub_pre_reset(udev);
+				&hub_driver.driver &&
+			(hub = hdev_to_hub(udev)) != NULL) {
+		hub_pre_reset(hub);
 	}
 
 	for (i = 0; i < SET_CONFIG_TRIES; ++i) {
@@ -2933,7 +2927,7 @@
 		/* ep0 maxpacket size may change; let the HCD know about it.
 		 * Other endpoints will be handled by re-enumeration. */
 		ep0_reinit(udev);
-		ret = hub_port_init(parent, udev, port, i);
+		ret = hub_port_init(parent_hub, udev, port, i);
 		if (ret >= 0)
 			break;
 	}
@@ -2984,11 +2978,11 @@
 	}
 
 done:
-	if (udev_is_a_hub)
-		hub_post_reset(udev);
+	if (hub)
+		hub_post_reset(hub);
 	return 0;
  
 re_enumerate:
-	hub_port_logical_disconnect(parent, port);
+	hub_port_logical_disconnect(parent_hub, port);
 	return -ENODEV;
 }
diff -Nru a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
--- a/drivers/usb/core/hub.h	2005-01-07 15:42:51 -08:00
+++ b/drivers/usb/core/hub.h	2005-01-07 15:42:51 -08:00
@@ -186,7 +186,7 @@
 extern void usb_hub_tt_clear_buffer (struct usb_device *dev, int pipe);
 
 struct usb_hub {
-	struct usb_interface	*intf;		/* the "real" device */
+	struct device		*intfdev;	/* the "interface" device */
 	struct usb_device	*hdev;
 	struct urb		*urb;		/* for interrupt polling pipe */
 

