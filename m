Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261950AbVAHGbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbVAHGbR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 01:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbVAHGaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 01:30:13 -0500
Received: from mail.kroah.org ([69.55.234.183]:33414 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261950AbVAHFs4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:56 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <1105163269810@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:49 -0800
Message-Id: <11051632692480@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.47, 2004/12/20 15:00:38-08:00, stern@rowland.harvard.edu

[PATCH] USB: Hub driver: several bug fixes and simplifications [11/13]

This patch adds several relatively minor bug fixes and code
simplifications for the hub driver.

	Perhaps most significantly, a test is added to usbfs to prevent
	users from unbinding the hub driver from a hub with children.
	That could cause some bad headaches, and it's best to avoid the
	situation.

	Don't set unused bits in the change_bits and event_bits fields
	(this aids in debugging, nothing more).

	Use the correct spinlock in the hub ioctl routine!

	Add an argument to hub_port_disable, indicating whether the
	device behind the disabled port should be marked NOTATTACHED.
	Normally it should, but for retries during usb_reset_device
	it should not.

	Pass the child device as an argument to hub_port_suspend and
	hub_port_resume rather than making them recalculate it.

	Call usb_set_device_state in the suspend/resume code rather
	than setting udev->state directly.

	Set udev->power.power_state in the suspend/resume code so that
	the correct values are visible in sysfs.

	Recognize during hub_port_resume that the child device udev
	might be NULL (this will happen when a new device is plugged
	into a suspended port).

	Don't allow hub_port_init to drop the usb_address0_sem lock
	while a device on the bus is still using address 0!

	Make khubd acquire a reference to the hub interface rather than
	the hub device.  This simplifies disconnect/unbind testing.

	Don't print a debugging message about hub events while not
	holding some lock to protect the hub.

	Remember to drop the reference acquired above if we fail to
	lock the hub.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/core/devio.c |   11 +++++
 drivers/usb/core/hub.c   |  101 +++++++++++++++++++++++++----------------------
 2 files changed, 66 insertions(+), 46 deletions(-)


diff -Nru a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
--- a/drivers/usb/core/devio.c	2005-01-07 15:42:59 -08:00
+++ b/drivers/usb/core/devio.c	2005-01-07 15:42:59 -08:00
@@ -1122,6 +1122,7 @@
 	int			retval = 0;
 	struct usb_interface    *intf = NULL;
 	struct usb_driver       *driver = NULL;
+	int			i;
 
 	/* get input parameters and alloc buffer */
 	if (copy_from_user(&ctrl, arg, sizeof (ctrl)))
@@ -1153,6 +1154,16 @@
 
 	/* disconnect kernel driver from interface */
 	case USBDEVFS_DISCONNECT:
+
+		/* don't allow the user to unbind the hub driver from
+		 * a hub with children to manage */
+		for (i = 0; i < ps->dev->maxchild; ++i) {
+			if (ps->dev->children[i])
+				retval = -EBUSY;
+		}
+		if (retval)
+			break;
+
 		down_write(&usb_bus_type.subsys.rwsem);
 		if (intf->dev.driver) {
 			driver = to_usb_driver(intf->dev.driver);
diff -Nru a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
--- a/drivers/usb/core/hub.c	2005-01-07 15:42:59 -08:00
+++ b/drivers/usb/core/hub.c	2005-01-07 15:42:59 -08:00
@@ -465,7 +465,7 @@
 		schedule_delayed_work(&hub->leds, LED_CYCLE_PERIOD);
 
 	/* scan all ports ASAP */
-	hub->event_bits[0] = ~0;
+	hub->event_bits[0] = (1UL << (hub->descriptor->bNbrPorts + 1)) - 1;
 	kick_khubd(hub);
 }
 
@@ -688,7 +688,7 @@
 		hub->indicator [0] = INDICATOR_CYCLE;
 
 	hub_power_on(hub);
-	hub->change_bits[0] = ~0;
+	hub->change_bits[0] = (1UL << (hub->descriptor->bNbrPorts)) - 1;
 	hub_activate(hub);
 	return 0;
 
@@ -816,10 +816,9 @@
 	switch (code) {
 	case USBDEVFS_HUB_PORTINFO: {
 		struct usbdevfs_hub_portinfo *info = user_data;
-		unsigned long flags;
 		int i;
 
-		spin_lock_irqsave(&hub_event_lock, flags);
+		spin_lock_irq(&device_state_lock);
 		if (hdev->devnum <= 0)
 			info->nports = 0;
 		else {
@@ -832,7 +831,7 @@
 						hdev->children[i]->devnum;
 			}
 		}
-		spin_unlock_irqrestore(&hub_event_lock, flags);
+		spin_unlock_irq(&device_state_lock);
 
 		return info->nports + 1;
 		}
@@ -1413,11 +1412,11 @@
 	return status;
 }
 
-static int hub_port_disable(struct usb_device *hdev, int port)
+static int hub_port_disable(struct usb_device *hdev, int port, int set_state)
 {
 	int ret;
 
-	if (hdev->children[port]) {
+	if (hdev->children[port] && set_state) {
 		usb_set_device_state(hdev->children[port],
 				USB_STATE_NOTATTACHED);
 	}
@@ -1439,7 +1438,7 @@
 	struct usb_hub *hub;
 
 	dev_dbg(hubdev(hdev), "logical disconnect on port %d\n", port + 1);
-	hub_port_disable(hdev, port);
+	hub_port_disable(hdev, port, 1);
 
 	/* FIXME let caller ask to power down the port:
 	 *  - some devices won't enumerate without a VBUS power cycle
@@ -1468,12 +1467,11 @@
  * tree above them to deliver data, such as a keypress or packet.  In
  * some cases, this wakes the USB host.
  */
-static int hub_port_suspend(struct usb_device *hdev, int port)
+static int hub_port_suspend(struct usb_device *hdev, int port,
+		struct usb_device *udev)
 {
-	int			status;
-	struct usb_device	*udev;
+	int	status;
 
-	udev = hdev->children[port];
 	// dev_dbg(hubdev(hdev), "suspend port %d\n", port + 1);
 
 	/* enable remote wakeup when appropriate; this lets the device
@@ -1513,7 +1511,7 @@
 	} else {
 		/* device has up to 10 msec to fully suspend */
 		dev_dbg(&udev->dev, "usb suspend\n");
-		udev->state = USB_STATE_SUSPENDED;
+		usb_set_device_state(udev, USB_STATE_SUSPENDED);
 		msleep(10);
 	}
 	return status;
@@ -1620,8 +1618,10 @@
 		} else
 			status = -EOPNOTSUPP;
 	} else
-		status = hub_port_suspend(udev->parent, port);
+		status = hub_port_suspend(udev->parent, port, udev);
 
+	if (status == 0)
+		udev->dev.power.power_state = state;
 	return status;
 }
 EXPORT_SYMBOL(__usb_suspend_device);
@@ -1675,9 +1675,10 @@
 	 * first two on the host side; they'd be inside hub_port_init()
 	 * during many timeouts, but khubd can't suspend until later.
 	 */
-	udev->state = udev->actconfig
-		? USB_STATE_CONFIGURED
-		: USB_STATE_ADDRESS;
+	usb_set_device_state(udev, udev->actconfig
+			? USB_STATE_CONFIGURED
+			: USB_STATE_ADDRESS);
+	udev->dev.power.power_state = PM_SUSPEND_ON;
 
  	/* 10.5.4.5 says be sure devices in the tree are still there.
  	 * For now let's assume the device didn't go crazy on resume,
@@ -1745,12 +1746,10 @@
 }
 
 static int
-hub_port_resume(struct usb_device *hdev, int port)
+hub_port_resume(struct usb_device *hdev, int port, struct usb_device *udev)
 {
-	int			status;
-	struct usb_device	*udev;
+	int	status;
 
-	udev = hdev->children[port];
 	// dev_dbg(hubdev(hdev), "resume port %d\n", port + 1);
 
 	/* see 7.1.7.7; affects power usage, but not budgeting */
@@ -1764,7 +1763,8 @@
 		u16		portchange;
 
 		/* drive resume for at least 20 msec */
-		dev_dbg(&udev->dev, "RESUME\n");
+		if (udev)
+			dev_dbg(&udev->dev, "RESUME\n");
 		msleep(25);
 
 #define LIVE_FLAGS	( USB_PORT_STAT_POWER \
@@ -1788,7 +1788,8 @@
 		} else {
 			/* TRSMRCY = 10 msec */
 			msleep(10);
-			status = finish_port_resume(udev);
+			if (udev)
+				status = finish_port_resume(udev);
 		}
 	}
 	if (status < 0)
@@ -1838,7 +1839,7 @@
 		}
 	} else if (udev->state == USB_STATE_SUSPENDED) {
 		// NOTE this fails if parent is also suspended...
-		status = hub_port_resume(udev->parent, port);
+		status = hub_port_resume(udev->parent, port, udev);
 	} else {
 		status = 0;
 	}
@@ -1937,7 +1938,7 @@
 			continue;
 		down (&udev->serialize);
 		if (portstat & USB_PORT_STAT_SUSPEND)
-			status = hub_port_resume(hdev, port);
+			status = hub_port_resume(hdev, port, udev);
 		else {
 			status = finish_port_resume(udev);
 			if (status < 0) {
@@ -2292,6 +2293,8 @@
 	retval = 0;
 
 fail:
+	if (retval)
+		hub_port_disable(hdev, port, 0);
 	up(&usb_address0_sem);
 	return retval;
 }
@@ -2424,11 +2427,15 @@
 	}
 
 #ifdef  CONFIG_USB_SUSPEND
-	/* If something is connected, but the port is suspended, wake it up.. */
+	/* If something is connected, but the port is suspended, wake it up. */
 	if (portstatus & USB_PORT_STAT_SUSPEND) {
-		status = hub_port_resume(hdev, port);
-		if (status < 0)
-			dev_dbg(hub_dev, "can't clear suspend on port %d; %d\n", port+1, status);
+		status = hub_port_resume(hdev, port, NULL);
+		if (status < 0) {
+			dev_dbg(hub_dev,
+				"can't clear suspend on port %d; %d\n",
+				port+1, status);
+			goto done;
+		}
 	}
 #endif
 
@@ -2474,7 +2481,7 @@
 					&devstat);
 			if (status < 0) {
 				dev_dbg(&udev->dev, "get status %d ?\n", status);
-				goto loop;
+				goto loop_disable;
 			}
 			cpu_to_le16s(&devstat);
 			if ((devstat & (1 << USB_DEVICE_SELF_POWERED)) == 0) {
@@ -2487,7 +2494,7 @@
 					schedule_work (&hub->leds);
 				}
 				status = -ENOTCONN;	/* Don't retry */
-				goto loop;
+				goto loop_disable;
 			}
 		}
  
@@ -2527,7 +2534,7 @@
 
 		up (&udev->serialize);
 		if (status)
-			goto loop;
+			goto loop_disable;
 
 		status = hub_power_remaining(hub);
 		if (status)
@@ -2537,8 +2544,9 @@
 
 		return;
 
+loop_disable:
+		hub_port_disable(hdev, port, 1);
 loop:
-		hub_port_disable(hdev, port);
 		ep0_reinit(udev);
 		release_address(udev);
 		usb_put_dev(udev);
@@ -2547,13 +2555,14 @@
 	}
  
 done:
-	hub_port_disable(hdev, port);
+	hub_port_disable(hdev, port, 1);
 }
 
 static void hub_events(void)
 {
 	struct list_head *tmp;
 	struct usb_device *hdev;
+	struct usb_interface *intf;
 	struct usb_hub *hub;
 	struct device *hub_dev;
 	u16 hubstatus;
@@ -2583,10 +2592,8 @@
 
 		hub = list_entry(tmp, struct usb_hub, event_list);
 		hdev = hub->hdev;
-		hub_dev = &hub->intf->dev;
-
-		usb_get_dev(hdev);
-		spin_unlock_irq(&hub_event_lock);
+		intf = hub->intf;
+		hub_dev = &intf->dev;
 
 		dev_dbg(hub_dev, "state %d ports %d chg %04x evt %04x\n",
 				hdev->state, hub->descriptor
@@ -2596,14 +2603,16 @@
 				(u16) hub->change_bits[0],
 				(u16) hub->event_bits[0]);
 
+		usb_get_intf(intf);
+		spin_unlock_irq(&hub_event_lock);
+
 		/* Lock the device, then check to see if we were
 		 * disconnected while waiting for the lock to succeed. */
-		if (locktree(hdev) < 0)
-			break;
-		if (hdev->state != USB_STATE_CONFIGURED ||
-				!hdev->actconfig ||
-				hub != usb_get_intfdata(
-					hdev->actconfig->interface[0]))
+		if (locktree(hdev) < 0) {
+			usb_put_intf(intf);
+			continue;
+		}
+		if (hub != usb_get_intfdata(intf) || hub->quiescing)
 			goto loop;
 
 		if (hub->error) {
@@ -2675,7 +2684,7 @@
 						connect_change = 1;
 				} else {
 					ret = -ENODEV;
-					hub_port_disable(hdev, i);
+					hub_port_disable(hdev, i, 1);
 				}
 				dev_dbg (hub_dev,
 					"resume on port %d, status %d\n",
@@ -2724,7 +2733,7 @@
 
 loop:
 		usb_unlock_device(hdev);
-		usb_put_dev(hdev);
+		usb_put_intf(intf);
 
         } /* end while (1) */
 }

