Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932830AbWFVHrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932830AbWFVHrA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 03:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932831AbWFVHrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 03:47:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64655 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932830AbWFVHrA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 03:47:00 -0400
Date: Thu, 22 Jun 2006 00:46:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz, linux-pm@osdl.org,
       stern@rowland.harvard.edu
Subject: Re: [linux-pm] swsusp regression [Was: 2.6.17-mm1]
Message-Id: <20060622004648.f1912e34.akpm@osdl.org>
In-Reply-To: <20060622061905.GD15834@kroah.com>
References: <20060621034857.35cfe36f.akpm@osdl.org>
	<4499BE99.6010508@gmail.com>
	<20060621221445.GB3798@inferi.kami.home>
	<20060622061905.GD15834@kroah.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006 23:19:05 -0700
Greg KH <greg@kroah.com> wrote:

> > I have the same problems also with suspend to disk. BTW I can't resume
> > from disk since 2.6.17-rc5-mm1, but I'll try to be more precise
> > tomorrow, as it seems removing the usb stuff makes it do some more steps
> > toward resumimg (eg: with usb modules this laptop immediately reboots
> > after reading all pages, without them I can reach "resuming device.."
> > stage).
> 
> Removing uhci-hcd causes all USB devices to be removed from the system.
> 
> Alan, you've been working in the "generic usb" section lately, any ideas
> why we can't suspend that kind of device now?

My laptop has the same problem.

This:

--- a/drivers/usb/core/usb.c~usb-more-suspend-debugging
+++ a/drivers/usb/core/usb.c
@@ -991,7 +991,11 @@ void usb_buffer_unmap_sg (struct usb_dev
 
 static int verify_suspended(struct device *dev, void *unused)
 {
-	return (dev->power.power_state.event == PM_EVENT_ON) ? -EBUSY : 0;
+	if (dev->power.power_state.event == PM_EVENT_ON) {
+		dev_printk(KERN_ERR, dev, "not suspended\n");
+		return -EBUSY;
+	}
+	return 0;
 }
 
 static int usb_generic_suspend(struct device *dev, pm_message_t message)
@@ -1005,13 +1009,18 @@ static int usb_generic_suspend(struct de
 	 * But those semantics are useless, so we equate the two (sigh).
 	 */
 	if (dev->driver == &usb_generic_driver) {
+		int ret;
+
 		if (dev->power.power_state.event == message.event)
 			return 0;
 		/* we need to rule out bogus requests through sysfs */
 		status = device_for_each_child(dev, NULL, verify_suspended);
+		suspend_report_result(verify_suspended, status);
 		if (status)
 			return status;
- 		return usb_suspend_device (to_usb_device(dev));
+		ret = usb_suspend_device(to_usb_device(dev));
+		suspend_report_result(usb_suspend_device, ret);
+		return ret;
 	}
 
 	if ((dev->driver == NULL) ||
@@ -1027,6 +1036,7 @@ static int usb_generic_suspend(struct de
 
 	if (driver->suspend && driver->resume) {
 		status = driver->suspend(intf, message);
+		suspend_report_result(driver->suspend, status);
 		if (status)
 			dev_err(dev, "%s error %d\n", "suspend", status);
 		else
diff -puN drivers/usb/core/hub.c~usb-more-suspend-debugging drivers/usb/core/hub.c
--- a/drivers/usb/core/hub.c~usb-more-suspend-debugging
+++ a/drivers/usb/core/hub.c
@@ -1638,6 +1638,7 @@ static int hub_port_suspend(struct usb_h
 				USB_DEVICE_REMOTE_WAKEUP, 0,
 				NULL, 0,
 				USB_CTRL_SET_TIMEOUT);
+		suspend_report_result(usb_control_msg, status);
 		if (status)
 			dev_dbg(&udev->dev,
 				"won't remote wakeup, status %d\n",
@@ -1646,6 +1647,7 @@ static int hub_port_suspend(struct usb_h
 
 	/* see 7.1.7.6 */
 	status = set_port_feature(hub->hdev, port1, USB_PORT_FEAT_SUSPEND);
+	suspend_report_result(set_port_feature, status);
 	if (status) {
 		dev_dbg(hub->intfdev,
 			"can't suspend port %d, status %d\n",
@@ -1706,6 +1708,8 @@ static int __usb_suspend_device (struct 
 			intf = udev->actconfig->interface[i];
 			if (is_active(intf)) {
 				dev_dbg(&intf->dev, "nyet suspended\n");
+				suspend_report_result(__usb_suspend_device,
+							-EBUSY);
 				return -EBUSY;
 			}
 		}
@@ -1714,9 +1718,11 @@ static int __usb_suspend_device (struct 
 	/* we only change a device's upstream USB link.
 	 * root hubs have no upstream USB link.
 	 */
-	if (udev->parent)
+	if (udev->parent) {
 		status = hub_port_suspend(hdev_to_hub(udev->parent), port1,
 				udev);
+		suspend_report_result(hub_port_suspend, status);
+	}
 
 	if (status == 0)
 		udev->dev.power.power_state = PMSG_SUSPEND;
_


Says:

Shrinking memory... done (0 pages freed)
hci_usb 3-1:1.1: no suspend for driver hci_usb?
hci_usb 3-1:1.0: no suspend for driver hci_usb?
 usbdev3.2_ep00: not suspended
usb_generic_suspend(): verify_suspended+0x0/0x3c() returns -16
suspend_device(): usb_generic_suspend+0x0/0x134() returns -16
Could not suspend device 3-1: error -16
hci_usb 3-1:1.0: no resume for driver hci_usb?
hci_usb 3-1:1.1: no resume for driver hci_usb?
Some devices failed to suspend
Restarting tasks... done


What's a usbdev3.2_ep00?

sony:/home/akpm> lsusb
Bus 005 Device 001: ID 0000:0000  
Bus 004 Device 001: ID 0000:0000  
Bus 003 Device 002: ID 044e:300c Alps Electric Co., Ltd 
Bus 003 Device 001: ID 0000:0000  
Bus 002 Device 003: ID 045e:00e1 Microsoft Corp. 
Bus 002 Device 001: ID 0000:0000  
Bus 001 Device 001: ID 0000:0000  

sony:/home/akpm> l /sys/bus/usb/devices
total 0
lrwxrwxrwx 1 root root 0 Jun 22 00:32 1-0:1.0 -> ../../../devices/pci0000:00/0000:00:1d.0/usb1/1-0:1.0
lrwxrwxrwx 1 root root 0 Jun 22 00:32 2-0:1.0 -> ../../../devices/pci0000:00/0000:00:1d.1/usb2/2-0:1.0
lrwxrwxrwx 1 root root 0 Jun 22 00:32 2-1 -> ../../../devices/pci0000:00/0000:00:1d.1/usb2/2-1
lrwxrwxrwx 1 root root 0 Jun 22 00:32 2-1:1.0 -> ../../../devices/pci0000:00/0000:00:1d.1/usb2/2-1/2-1:1.0
lrwxrwxrwx 1 root root 0 Jun 22 00:32 3-0:1.0 -> ../../../devices/pci0000:00/0000:00:1d.2/usb3/3-0:1.0
lrwxrwxrwx 1 root root 0 Jun 22 00:32 3-1 -> ../../../devices/pci0000:00/0000:00:1d.2/usb3/3-1
lrwxrwxrwx 1 root root 0 Jun 22 00:32 3-1:1.0 -> ../../../devices/pci0000:00/0000:00:1d.2/usb3/3-1/3-1:1.0
lrwxrwxrwx 1 root root 0 Jun 22 00:32 3-1:1.1 -> ../../../devices/pci0000:00/0000:00:1d.2/usb3/3-1/3-1:1.1
lrwxrwxrwx 1 root root 0 Jun 22 00:32 3-1:1.2 -> ../../../devices/pci0000:00/0000:00:1d.2/usb3/3-1/3-1:1.2

Seems to be this:

00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Sony Corporation Unknown device 81b9
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 16
        Region 4: I/O ports at 1860 [size=32]
00: 86 80 5a 26 05 00 80 02 03 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 61 18 00 00 00 00 00 00 00 00 00 00 4d 10 b9 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 03 00 00

I don't see anything in this patchpile which would break the bluetooth driver,
and drivers/usb/core/usb.c is effectively unchanged.

I can bisect it if we're stuck, but that'll require beer or something.
