Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965118AbWIEP0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbWIEP0x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 11:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965076AbWIEP0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 11:26:53 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:61714 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S965119AbWIEP0t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 11:26:49 -0400
Date: Tue, 5 Sep 2006 11:26:48 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: USB development list <linux-usb-devel@lists.sourceforge.net>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
cc: Rodolfo Giometti <giometti@linux.it>
Subject: [RFC] USB device persistence across suspend-to-disk
Message-ID: <Pine.LNX.4.44L0.0609051104260.14667-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lots of people have asked why USB mass-storage devices don't survive
suspend-to-disk (swsusp).  The answer is technical and not too
interesting; what matters is that people have been forced to unmount all
filesystems on USB devices before doing suspend-to-disk.  On some systems
this is necessary even for suspend-to-RAM.

This patch adds the capability for USB devices to persist across such
suspends.  You can even suspend with your root fs on a USB flash device!  
(I think -- I haven't actually tried it.  But it _should_ work.)

It's all explained in Documentation/usb/persist.txt, added by the patch.  
The "persist" mode is turned off by default because it can be dangerous.

The patch is based on 2.6.18-rc5-mm1.  If people like it, I'll submit it
to Greg KH for inclusion in the USB development tree.

Alan Stern


Index: mm/drivers/usb/core/generic.c
===================================================================
--- mm.orig/drivers/usb/core/generic.c
+++ mm/drivers/usb/core/generic.c
@@ -194,6 +194,8 @@ static int generic_suspend(struct usb_de
 
 static int generic_resume(struct usb_device *udev)
 {
+	if (udev->do_persist)
+		return usb_reset_persistent_device(udev);
 	return usb_port_resume(udev);
 }
 
Index: mm/drivers/usb/core/hub.c
===================================================================
--- mm.orig/drivers/usb/core/hub.c
+++ mm/drivers/usb/core/hub.c
@@ -61,6 +61,18 @@ module_param (blinkenlights, bool, S_IRU
 MODULE_PARM_DESC (blinkenlights, "true to cycle leds on hubs");
 
 /*
+ * Support persistence of devices across power-loss during suspend.
+ *
+ * WARNING: This option can corrupt filesystems and crash the kernel
+ * if a mass-storage device or its media are switched while the system
+ * is asleep and the controller is unpowered.
+ */
+static int persist;
+module_param(persist, bool, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(persist, "Make devices persist across suspend-to-disk "
+		"(USE AT YOUR OWN RISK)");
+
+/*
  * As of 2.6.10 we introduce a new USB device initialization scheme which
  * closely resembles the way Windows works.  Hopefully it will be compatible
  * with a wider range of devices than the old scheme.  However some previously
@@ -540,6 +552,12 @@ static void hub_pre_reset(struct usb_int
 	struct usb_device *hdev = hub->hdev;
 	int port1;
 
+	/* If this is part of a "persistent-device" reset then we should
+	 * do nothing, especially not disconnect the children.
+	 */
+	if (hdev->do_persist)
+		return;
+
 	for (port1 = 1; port1 <= hdev->maxchild; ++port1) {
 		if (hdev->children[port1 - 1]) {
 			usb_disconnect(&hdev->children[port1 - 1]);
@@ -1056,6 +1074,9 @@ void usb_set_device_state(struct usb_dev
  * is resumed and Vbus power has been interrupted or the controller
  * has been reset.  The routine marks all the children of the root hub
  * as NOTATTACHED and marks logical connect-change events on their ports.
+ *
+ * But if the "persist" module parameter is set, instead the routine
+ * begins the power-session recovery procedure at the root hub.
  */
 void usb_root_hub_lost_power(struct usb_device *rhdev)
 {
@@ -1064,6 +1085,13 @@ void usb_root_hub_lost_power(struct usb_
 	unsigned long flags;
 
 	dev_warn(&rhdev->dev, "root hub lost power or was reset\n");
+
+	/* Start the "persistent device" mechanism */
+	if (persist) {
+		usb_reset_persistent_device(rhdev);
+		return;
+	}
+
 	spin_lock_irqsave(&device_state_lock, flags);
 	hub = hdev_to_hub(rhdev);
 	for (port1 = 1; port1 <= rhdev->maxchild; ++port1) {
@@ -1077,6 +1105,90 @@ void usb_root_hub_lost_power(struct usb_
 }
 EXPORT_SYMBOL_GPL(usb_root_hub_lost_power);
 
+/**
+ * usb_reset_persistent_device - reset device following power-session loss
+ * @udev: device to be reset instead of resumed
+ *
+ * If a host controller doesn't maintain VBUS suspend current during a
+ * system sleep or is reset when the system wakes up, all the USB
+ * power sessions below it will be broken.  This is especially troublesome
+ * for mass-storage devices containing mounted filesystems, since the
+ * device will appear to have disconnected and all the memory mappings
+ * to it will be lost.
+ *
+ * As an alternative, this routine attempts to recover power sessions for
+ * devices that are still present by resetting them instead of resuming
+ * them.  If all goes well, the devices will appear to persist across the
+ * the interruption of the power sessions.
+ *
+ * This facility is inherently dangerous.  Although usb_reset_device()
+ * makes every effort to insure that the same device is present after the
+ * reset as before, it cannot provide a 100% guarantee.  Furthermore it's
+ * quite possible for a device to remain unaltered but its media to be
+ * changed.  If the user replaces a flash memory card while the system is
+ * asleep, he will have only himself to blame when the filesystem on the
+ * new card is corrupted and the system crashes.
+ */
+int usb_reset_persistent_device(struct usb_device *udev)
+{
+	struct usb_host_config *config;
+	int i;
+
+	/* Root hubs don't need to be (and can't be) reset */
+	if (!udev->parent)
+		goto mark_children;
+
+	/* The parent hub's port connect-change status might be set */
+	clear_port_feature(udev->parent, udev->portnum,
+			USB_PORT_FEAT_C_CONNECTION);
+
+	/* Can't reset it if it's marked as suspended */
+	usb_set_device_state(udev, USB_STATE_ADDRESS);
+	i = usb_reset_device(udev);
+	if (i < 0)
+		return i;
+
+	/* Let the interface drivers know the device has been reset.
+	 * The call to the post_reset() method essentially replaces the
+	 * call to resume().
+	 */
+	config = udev->actconfig;
+	if (config) {
+		struct usb_interface *cintf;
+		struct usb_driver *drv;
+
+		for (i = 0; i < config->desc.bNumInterfaces; ++i) {
+			cintf = config->interface[i];
+
+			/* We can't lock the interface because we already
+			 * hold the pm_mutex.  Luckily it doesn't matter
+			 * since no other tasks will be running during a
+			 * system resume.
+			 */
+			if (device_is_registered(&cintf->dev) &&
+					cintf->dev.driver &&
+					!is_active(cintf)) {
+				drv = to_usb_driver(cintf->dev.driver);
+				if (drv->pre_reset && drv->post_reset) {
+					(drv->pre_reset)(cintf);
+					(drv->post_reset)(cintf);
+					mark_active(cintf);
+				}
+			}
+		}
+	}
+
+	/* Mark the child devices for reset */
+mark_children:
+	for (i = 0; i < udev->maxchild; ++i) {
+		if (udev->children[i])
+			udev->children[i]->do_persist = 1;
+	}
+
+	udev->do_persist = 0;
+	return 0;
+}
+
 #endif	/* CONFIG_PM */
 
 static void choose_address(struct usb_device *udev)
@@ -2845,6 +2957,8 @@ static int config_descriptors_changed(st
 	unsigned			len = 0;
 	struct usb_config_descriptor	*buf;
 
+	/* FIXME: Compare the Vendor, Product, and Serial string descriptors */
+
 	for (index = 0; index < udev->descriptor.bNumConfigurations; index++) {
 		if (len < le16_to_cpu(udev->config[index].desc.wTotalLength))
 			len = le16_to_cpu(udev->config[index].desc.wTotalLength);
Index: mm/drivers/usb/core/usb.h
===================================================================
--- mm.orig/drivers/usb/core/usb.h
+++ mm/drivers/usb/core/usb.h
@@ -36,6 +36,7 @@ extern int usb_suspend_both(struct usb_d
 extern int usb_resume_both(struct usb_device *udev);
 extern int usb_port_suspend(struct usb_device *dev);
 extern int usb_port_resume(struct usb_device *dev);
+extern int usb_reset_persistent_device(struct usb_device *udev);
 
 #else
 
Index: mm/include/linux/usb.h
===================================================================
--- mm.orig/include/linux/usb.h
+++ mm/include/linux/usb.h
@@ -355,7 +355,8 @@ struct usb_device {
 	unsigned short bus_mA;		/* Current available from the bus */
 	u8 portnum;			/* Parent port number (origin 1) */
 
-	int have_langid;		/* whether string_langid is valid */
+	unsigned do_persist:1;		/* Needs persistent-device reset */
+	unsigned have_langid:1;		/* whether string_langid is valid */
 	int string_langid;		/* language ID for strings */
 
 	/* static strings from the device */
Index: mm/Documentation/kernel-parameters.txt
===================================================================
--- mm.orig/Documentation/kernel-parameters.txt
+++ mm/Documentation/kernel-parameters.txt
@@ -1235,6 +1235,16 @@ and is between 256 and 4096 characters. 
 			Format: { 0 | 1 }
 			See arch/parisc/kernel/pdc_chassis.c
 
+	persist=	[USB] Enable USB device persistence across power loss
+			during system suspend.
+			Format: { 0 | 1 }
+			See also Documentation/usb/persist.txt
+			WARNING!!  If a USB mass-storage device or its media
+			are changed while the system is suspended, the kernel
+			may not realize what has happened.  If this option is
+			enabled then filesystem corruption and a system crash
+			may result.
+
 	pf.		[PARIDE]
 			See Documentation/paride.txt.
 
Index: mm/Documentation/usb/persist.txt
===================================================================
--- /dev/null
+++ mm/Documentation/usb/persist.txt
@@ -0,0 +1,154 @@
+		USB device persistence during system suspend
+
+		   Alan Stern <stern@rowland.harvard.edu>
+
+				September 2, 2006
+
+
+
+	What is the problem?
+
+According to the USB specification, when a USB bus is suspended the
+bus must continue to supply suspend current (around 1-5 mA).  This
+is so that devices can maintain their internal state and hubs can
+detect connect-change events (devices being plugged in or unplugged).
+The technical term is "power session".
+
+If a USB device's power session is interrupted then the system is
+required to behave as though the device has been unplugged.  It's a
+conservative approach; in the absence of suspend current the computer
+has no way to know what has actually happened.  Perhaps the same
+device is still attached or perhaps it was removed and a different
+device plugged into the port.  The system must assume the worst.
+
+By default, Linux behaves according to the spec.  If a USB host
+controller loses power during a system suspend, then when the system
+wakes up all the devices attached to that controller are treated as
+though they had disconnected.  This is always safe and it is the
+"officially correct" thing to do.
+
+For many sorts of devices this behavior doesn't matter in the least.
+If the kernel wants to believe that your USB keyboard was unplugged
+while the system was asleep and a new keyboard was plugged in when the
+system woke up, who cares?  It'll still work the same when you type on
+it.
+
+Unfortunately problems _can_ arise, particularly with mass-storage
+devices.  The effect is exactly the same as if the device really had
+been unplugged while the system was suspended.  If you had a mounted
+filesystem on the device, you're out of luck -- everything in that
+filesystem is now inaccessible.  This is especially annoying if your
+root filesystem was located on the device, since your system will
+instantly crash.  :-(
+
+Loss of power isn't the only mechanism to worry about.  Anything that
+interrupts a power session will have the same effect.  For example,
+even though suspend current may have been maintained while the system
+was asleep, on many systems during the initial stages of wakeup the
+firmware (i.e., the BIOS) resets the motherboard's USB host
+controllers.  Result: all the power sessions are destroyed and again
+it's as though you had unplugged all the USB devices.  Yes, it's
+entirely the BIOS's fault, but that doesn't do _you_ any good unless
+you can convince the BIOS supplier to fix the problem (lots of luck!).
+
+On many systems the USB host controllers will get reset after a
+suspend-to-RAM.  On almost all systems, no suspend current is
+available during suspend-to-disk (also known as swsusp).  You can
+check the kernel log after resuming to see if either of these has
+happened; look for lines saying "root hub lost power or was reset".
+
+In practice, people are forced to unmount any filesystems on a USB
+device before suspending.  If the root filesystem is on a USB device,
+the system can't be suspended at all.  (All right, it _can_ be
+suspended -- but it will crash as soon as it wakes up, which isn't
+much better.)
+
+
+	What is the solution?
+
+Setting the "persist=y" module parameter for usbcore will cause the
+kernel to work around these issues.  If usbcore is build into the
+main kernel instead of as a separate module, you can put
+"usbcore.persist=1" on the boot command line.  You can also change the
+kernel's behavior on the fly using sysfs: Type
+
+	echo y >/sys/module/usbcore/parameters/persist
+
+to turn the option on, and replace the 'y' with an 'n' to turn it off.
+
+The "persist" option enables a mode in which the core USB device data
+structures are allowed to persist across a power-session disruption.
+It works like this.  If the kernel sees that a USB host controller is
+not in the expected state during resume (i.e., if the controller was
+reset or otherwise had lost power) then it applies a persistence check
+to each of the USB devices below that controller.  It doesn't try to
+resume the device; that can't work once the power session is gone.
+Instead it issues a USB port reset followed by a re-enumeration.
+(This is exactly the same thing that happens whenever a USB device is
+reset.)  If the re-enumeration shows that the device now attached to
+that port has the same descriptors as before, including the Vendor and
+Product IDs, then the kernel continues to use the same device
+structure.  In effect, the kernel treats the device as though it had
+merely been reset instead of unplugged.
+
+If no device is now attached to the port, or if the descriptors are
+different from what the kernel remembers, then the treatment is what
+you would expect.  The kernel destroys the old device structure and
+behaves as though the old device had been unplugged and a new device
+plugged in, just as it would without the "persist=y" option.
+
+The end result is that the USB device remains available and usable.
+Mounts and memory mappings are unaffected, and the world is now a good
+and happy place.
+
+
+	Is this the best solution?
+
+Perhaps not.  Arguably, keeping track of mounted filesystems and
+memory mappings across device disconnects should be handled by a
+centralized Logical Volume Manager.  Such a solution would allow you
+to plug in a USB flash device, create a persistent volume associated
+with it, unplug the flash device, plug it back in later, and still
+have the same persistent volume associated with the device.  As such
+it would be more far-reaching than usbcore's "persist=y" option.
+
+On the other hand, writing a persistent volume manager would be a big
+job and using it would require significant input from the user.  This
+solution is much quicker and easier -- and it exists now, a giant
+point in its favor!
+
+Furthermore, the "persist" option applies to _all_ USB devices, not
+just mass-storage devices.  It might turn out to be equally useful for
+other device types, such as network interfaces.
+
+
+	WARNING: Using "persist=y" can be dangerous!!
+
+When recovering an interrupted power session the kernel does its best
+to make sure the USB device hasn't been changed; that is, the same
+device is still plugged into the port as before.  But the checks
+aren't guaranteed to be 100% accurate.
+
+If you replace one USB device with another of the same type (same
+manufacturer, same IDs, and so on) there's an excellent chance the
+kernel won't detect the change.  Serial numbers and other strings are
+not compared.  In many cases it wouldn't help if they were, because
+manufacturers frequently omit serial numbers entirely in their
+devices.
+
+Furthermore it's quite possible to leave a USB device exactly the
+same while changing its media.  If you replace the flash memory card
+in a USB card reader while the system is asleep, the kernel will have
+no way to know you did it.  The kernel will assume that nothing has
+happened and will continue to use the partition tables and memory
+mappings for the old card.
+
+If the kernel gets fooled in this way, it's almost certain to cause
+filesystem corruption and to crash your system.  You'll have no one to
+blame but yourself.
+
+YOU HAVE BEEN WARNED!  USE AT YOUR OWN RISK!
+
+That having been said, most of the time there shouldn't be any trouble
+at all.  The "persist" feature can be extremely useful.  Make the most
+of it.
Index: mm/drivers/usb/core/message.c
===================================================================
--- mm.orig/drivers/usb/core/message.c
+++ mm/drivers/usb/core/message.c
@@ -764,7 +764,7 @@ int usb_string(struct usb_device *dev, i
 			err = -EINVAL;
 			goto errout;
 		} else {
-			dev->have_langid = -1;
+			dev->have_langid = 1;
 			dev->string_langid = tbuf[2] | (tbuf[3]<< 8);
 				/* always use the first langid listed */
 			dev_dbg (&dev->dev, "default language 0x%04x\n",
Index: mm/Documentation/power/swsusp.txt
===================================================================
--- mm.orig/Documentation/power/swsusp.txt
+++ mm/Documentation/power/swsusp.txt
@@ -405,6 +405,9 @@ safest thing is to unmount all filesyste
 Firewire, CompactFlash, MMC, external SATA, or even IDE hotplug bays)
 before suspending; then remount them after resuming.
 
+There is a work-around for this problem.  For more information, see
+Documentation/usb/persist.txt.
+
 Q: I upgraded the kernel from 2.6.15 to 2.6.16. Both kernels were
 compiled with the similar configuration files. Anyway I found that
 suspend to disk (and resume) is much slower on 2.6.16 compared to

