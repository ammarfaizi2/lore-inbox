Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263008AbTIVGeP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 02:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263018AbTIVGeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 02:34:15 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:15560 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S263008AbTIVGdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 02:33:54 -0400
Date: Mon, 22 Sep 2003 08:33:24 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
To: kernel@onerussian.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB problem. 'irq 9: nobody cared!'
Message-ID: <20030922063324.GF3398@ppp0.net>
Mail-Followup-To: kernel@onerussian.com, linux-kernel@vger.kernel.org
References: <20030921184149.GA12274@washoe.rutgers.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030921184149.GA12274@washoe.rutgers.edu>
I-love-doing-this: really
X-Modeline: vim:set ts=8 sw=4 smarttab tw=72 si noic notitle:
X-Operating-System: Linux/2.4.22aa1 (i686)
X-Uptime: 18:41:53 up 19 days,  8:40,  9 users,  load average: 0.25, 0.18, 0.20
Accept-Languages: de, en, fr
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yaroslav Halchenko <kernel@onerussian.com> wrote on 2003-09-21 14:41:49
> Dear Gurus,
> 
> Since one of the bk versions in -test4- USB problem persist. On boot I'm
> getting next dump. More information about my system and configuration is at
> 
> http://www.onerussian.com/Linux/bug.USB/
> 
> Please help to get rid of the problem cause USB doesn't work now for me :-(

Try reverting the following patch, taken from the bk4-bk5 incremental
diff (Apply with patch -p1 -R). This fixed it for me.

   Jan

--
Jan Dittmer - jdittmer@ppp0.net

diff -urN linux-2.6.0-test4-bk4/drivers/usb/core/hcd-pci.c linux-2.6.0-test4-bk5/drivers/usb/core/hcd-pci.c
--- linux-2.6.0-test4-bk4/drivers/usb/core/hcd-pci.c	2003-08-22 16:55:40.000000000 -0700
+++ linux-2.6.0-test4-bk5/drivers/usb/core/hcd-pci.c	2003-09-03 04:46:52.000000000 -0700
@@ -139,6 +139,7 @@
 			return retval;
 		}
 	}
+	// hcd zeroed everything
 	hcd->regs = base;
 	hcd->region = region;
 
@@ -165,6 +166,7 @@
 		dev_err (hcd->controller, "can't reset\n");
 		goto clean_3;
 	}
+	hcd->state = USB_STATE_HALT;
 
 	pci_set_master (dev);
 #ifndef __sparc__
@@ -230,7 +232,8 @@
 		BUG ();
 
 	hub = hcd->self.root_hub;
-	hcd->state = USB_STATE_QUIESCING;
+	if (HCD_IS_RUNNING (hcd->state))
+		hcd->state = USB_STATE_QUIESCING;
 
 	dev_dbg (hcd->controller, "roothub graceful disconnect\n");
 	usb_disconnect (&hub);
@@ -287,8 +290,8 @@
 		pci_save_state (dev, hcd->pci_state);
 
 		/* driver may want to disable DMA etc */
+		hcd->state = USB_STATE_QUIESCING;
 		retval = hcd->driver->suspend (hcd, state);
-		hcd->state = USB_STATE_SUSPENDED;
 	}
 
  	pci_set_power_state (dev, state);
diff -urN linux-2.6.0-test4-bk4/drivers/usb/core/hcd.c linux-2.6.0-test4-bk5/drivers/usb/core/hcd.c
--- linux-2.6.0-test4-bk4/drivers/usb/core/hcd.c	2003-08-22 16:57:00.000000000 -0700
+++ linux-2.6.0-test4-bk5/drivers/usb/core/hcd.c	2003-09-03 04:46:52.000000000 -0700
@@ -483,7 +483,7 @@
 {
 	struct urb	*urb;
 	struct usb_hcd	*hcd;
-	int		length;
+	int		length = 0;
 	unsigned long	flags;
 
 	urb = (struct urb *) ptr;
@@ -499,7 +499,9 @@
 		return;
 	}
 
-	length = hcd->driver->hub_status_data (hcd, urb->transfer_buffer);
+	if (!HCD_IS_SUSPENDED (hcd->state))
+		length = hcd->driver->hub_status_data (
+					hcd, urb->transfer_buffer);
 
 	/* complete the status urb, or retrigger the timer */
 	spin_lock (&hcd_data_lock);
@@ -1097,6 +1099,8 @@
 static int hcd_get_frame_number (struct usb_device *udev)
 {
 	struct usb_hcd	*hcd = (struct usb_hcd *)udev->bus->hcpriv;
+	if (!HCD_IS_RUNNING (hcd->state))
+		return -ESHUTDOWN;
 	return hcd->driver->get_frame_number (hcd);
 }
 
@@ -1193,6 +1197,12 @@
 		goto done;
 	}
 
+	/* running ~= hc unlink handshake works (irq, timer, etc)
+	 * halted ~= no unlink handshake is needed
+	 * suspended, resuming == should never happen
+	 */
+	WARN_ON (!HCD_IS_RUNNING (hcd->state) && hcd->state != USB_STATE_HALT);
+
 	if (!urb->hcpriv) {
 		retval = -EINVAL;
 		goto done;
@@ -1208,6 +1218,17 @@
 		goto done;
 	}
 
+	/* PCI IRQ setup can easily be broken so that USB controllers
+	 * never get completion IRQs ... maybe even the ones we need to
+	 * finish unlinking the initial failed usb_set_address().
+	 */
+	if (!hcd->saw_irq) {
+		dev_warn (hcd->controller, "Unlink after no-IRQ?  "
+			"Different ACPI or APIC settings may help."
+			"\n");
+		hcd->saw_irq = 1;
+	}
+
 	/* maybe set up to block until the urb's completion fires.  the
 	 * lower level hcd code is always async, locking on urb->status
 	 * updates; an intercepted completion unblocks us.
@@ -1287,6 +1308,8 @@
 	dev = udev->hcpriv;
 	hcd = udev->bus->hcpriv;
 
+	WARN_ON (!HCD_IS_RUNNING (hcd->state) && hcd->state != USB_STATE_HALT);
+
 	local_irq_disable ();
 
 rescan:
@@ -1483,6 +1506,7 @@
 	if (unlikely (hcd->state == USB_STATE_HALT))	/* irq sharing? */
 		return IRQ_NONE;
 
+	hcd->saw_irq = 1;
 	hcd->driver->irq (hcd, r);
 	if (hcd->state != start && hcd->state == USB_STATE_HALT)
 		usb_hc_died (hcd);
diff -urN linux-2.6.0-test4-bk4/drivers/usb/core/hcd.h linux-2.6.0-test4-bk5/drivers/usb/core/hcd.h
--- linux-2.6.0-test4-bk4/drivers/usb/core/hcd.h	2003-08-22 16:53:55.000000000 -0700
+++ linux-2.6.0-test4-bk5/drivers/usb/core/hcd.h	2003-09-03 04:46:52.000000000 -0700
@@ -73,6 +73,7 @@
 	 * hardware info/state
 	 */
 	struct hc_driver	*driver;	/* hw-specific hooks */
+	unsigned		saw_irq : 1;
 	int			irq;		/* irq allocated */
 	void			*regs;		/* device memory/io */
 	struct device		*controller;	/* handle to hardware */
@@ -89,13 +90,11 @@
 
 	int			state;
 #	define	__ACTIVE		0x01
-#	define	__SLEEPY		0x02
 #	define	__SUSPEND		0x04
 #	define	__TRANSIENT		0x80
 
 #	define	USB_STATE_HALT		0
 #	define	USB_STATE_RUNNING	(__ACTIVE)
-#	define	USB_STATE_READY		(__ACTIVE|__SLEEPY)
 #	define	USB_STATE_QUIESCING	(__SUSPEND|__TRANSIENT|__ACTIVE)
 #	define	USB_STATE_RESUMING	(__SUSPEND|__TRANSIENT)
 #	define	USB_STATE_SUSPENDED	(__SUSPEND)
diff -urN linux-2.6.0-test4-bk4/drivers/usb/core/message.c linux-2.6.0-test4-bk5/drivers/usb/core/message.c
--- linux-2.6.0-test4-bk4/drivers/usb/core/message.c	2003-08-22 16:53:13.000000000 -0700
+++ linux-2.6.0-test4-bk5/drivers/usb/core/message.c	2003-09-03 04:46:52.000000000 -0700
@@ -246,21 +246,22 @@
 		io->status = urb->status;
 
 		/* the previous urbs, and this one, completed already.
-		 * unlink the later ones so they won't rx/tx bad data,
-		 *
-		 * FIXME don't bother unlinking urbs that haven't yet been
-		 * submitted; those non-error cases shouldn't be syslogged
+		 * unlink pending urbs so they won't rx/tx bad data.
 		 */
 		for (i = 0, found = 0; i < io->entries; i++) {
+			if (!io->urbs [i])
+				continue;
 			if (found) {
 				status = usb_unlink_urb (io->urbs [i]);
-				if (status && status != -EINPROGRESS)
-					err ("sg_complete, unlink --> %d",
-							status);
+				if (status != -EINPROGRESS && status != -EBUSY)
+					dev_err (&io->dev->dev,
+						"%s, unlink --> %d\n",
+						__FUNCTION__, status);
 			} else if (urb == io->urbs [i])
 				found = 1;
 		}
 	}
+	urb->dev = 0;
 
 	/* on the last completion, signal usb_sg_wait() */
 	io->bytes += urb->actual_length;
@@ -356,7 +357,7 @@
 			goto nomem;
 		}
 
-		io->urbs [i]->dev = dev;
+		io->urbs [i]->dev = 0;
 		io->urbs [i]->pipe = pipe;
 		io->urbs [i]->interval = period;
 		io->urbs [i]->transfer_flags = urb_flags;
@@ -448,6 +449,7 @@
 	for (i = 0; i < io->entries && !io->status; i++) {
 		int	retval;
 
+		io->urbs [i]->dev = io->dev;
 		retval = usb_submit_urb (io->urbs [i], SLAB_ATOMIC);
 
 		/* after we submit, let completions or cancelations fire;
@@ -459,9 +461,9 @@
 		case -ENXIO:	// hc didn't queue this one
 		case -EAGAIN:
 		case -ENOMEM:
+			io->urbs [i]->dev = 0;
 			retval = 0;
 			i--;
-			// FIXME:  should it usb_sg_cancel() on INTERRUPT?
 			yield ();
 			break;
 
@@ -477,8 +479,10 @@
 
 			/* fail any uncompleted urbs */
 		default:
+			io->urbs [i]->dev = 0;
 			io->urbs [i]->status = retval;
-			dbg ("usb_sg_msg, submit --> %d", retval);
+			dev_dbg (&io->dev->dev, "%s, submit --> %d\n",
+				__FUNCTION__, retval);
 			usb_sg_cancel (io);
 		}
 		spin_lock_irqsave (&io->lock, flags);
@@ -521,9 +525,9 @@
 			if (!io->urbs [i]->dev)
 				continue;
 			retval = usb_unlink_urb (io->urbs [i]);
-			if (retval && retval != -EINPROGRESS)
-				warn ("usb_sg_cancel, unlink --> %d", retval);
-			// FIXME don't warn on "not yet submitted" error
+			if (retval != -EINPROGRESS && retval != -EBUSY)
+				dev_warn (&io->dev->dev, "%s, unlink --> %d\n",
+					__FUNCTION__, retval);
 		}
 	}
 	spin_unlock_irqrestore (&io->lock, flags);
diff -urN linux-2.6.0-test4-bk4/drivers/usb/core/usb.c linux-2.6.0-test4-bk5/drivers/usb/core/usb.c
--- linux-2.6.0-test4-bk4/drivers/usb/core/usb.c	2003-08-22 16:56:17.000000000 -0700
+++ linux-2.6.0-test4-bk5/drivers/usb/core/usb.c	2003-09-03 04:46:52.000000000 -0700
@@ -991,8 +991,8 @@
  *
  * This call is synchronous, and may not be used in an interrupt context.
  *
- * Only hub drivers (including virtual root hub drivers for host
- * controllers) should ever call this.
+ * Only the hub driver should ever call this; root hub registration
+ * uses it only indirectly.
  */
 #define NEW_DEVICE_RETRYS	2
 #define SET_ADDRESS_RETRYS	2
@@ -1417,11 +1417,46 @@
 			usb_pipein (pipe) ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
 }
 
+static int usb_device_suspend(struct device *dev, u32 state)
+{
+	struct usb_interface *intf;
+	struct usb_driver *driver;
+
+	if ((dev->driver == &usb_generic_driver) || 
+	    (dev->driver_data == &usb_generic_driver_data))
+		return 0;
+
+	intf = to_usb_interface(dev);
+	driver = to_usb_driver(dev->driver);
+
+	if (driver && driver->suspend)
+		return driver->suspend(intf, state);
+	return 0;
+}
+
+static int usb_device_resume(struct device *dev)
+{
+	struct usb_interface *intf;
+	struct usb_driver *driver;
+
+	if ((dev->driver == &usb_generic_driver) || 
+	    (dev->driver_data == &usb_generic_driver_data))
+		return 0;
+
+	intf = to_usb_interface(dev);
+	driver = to_usb_driver(dev->driver);
+
+	if (driver && driver->resume)
+		return driver->resume(intf);
+	return 0;
+}
 
 struct bus_type usb_bus_type = {
 	.name =		"usb",
 	.match =	usb_device_match,
 	.hotplug =	usb_hotplug,
+	.suspend =	usb_device_suspend,
+	.resume =	usb_device_resume,
 };
 
 #ifndef MODULE
@@ -1509,7 +1544,6 @@
 EXPORT_SYMBOL(usb_find_interface);
 EXPORT_SYMBOL(usb_ifnum_to_if);
 
-EXPORT_SYMBOL(usb_new_device);
 EXPORT_SYMBOL(usb_reset_device);
 EXPORT_SYMBOL(usb_disconnect);
 
diff -urN linux-2.6.0-test4-bk4/drivers/usb/host/uhci-hcd.c linux-2.6.0-test4-bk5/drivers/usb/host/uhci-hcd.c
--- linux-2.6.0-test4-bk4/drivers/usb/host/uhci-hcd.c	2003-08-22 16:59:32.000000000 -0700
+++ linux-2.6.0-test4-bk5/drivers/usb/host/uhci-hcd.c	2003-09-03 04:46:52.000000000 -0700
@@ -2099,7 +2099,7 @@
 	uhci->state_end = jiffies + HZ;
 	outw(USBCMD_RS | USBCMD_CF | USBCMD_MAXP, io_addr + USBCMD);
 
-        uhci->hcd.state = USB_STATE_READY;
+        uhci->hcd.state = USB_STATE_RUNNING;
 }
 
 /*
@@ -2143,6 +2143,20 @@
 #endif
 }
 
+static int uhci_reset(struct usb_hcd *hcd)
+{
+	struct uhci_hcd *uhci = hcd_to_uhci(hcd);
+
+	uhci->io_addr = (unsigned long) hcd->regs;
+
+	/* Maybe kick BIOS off this hardware.  Then reset, so we won't get
+	 * interrupts from any previous setup.
+	 */
+	pci_write_config_word(hcd->pdev, USBLEGSUP, USBLEGSUP_DEFAULT);
+	reset_hc(uhci);
+	return 0;
+}
+
 /*
  * Allocate a frame list, and then setup the skeleton
  *
@@ -2159,7 +2173,7 @@
  *  - The fourth queue is the bandwidth reclamation queue, which loops back
  *    to the high speed control queue.
  */
-static int __devinit uhci_start(struct usb_hcd *hcd)
+static int uhci_start(struct usb_hcd *hcd)
 {
 	struct uhci_hcd *uhci = hcd_to_uhci(hcd);
 	int retval = -EBUSY;
@@ -2171,7 +2185,6 @@
 	struct proc_dir_entry *ent;
 #endif
 
-	uhci->io_addr = (unsigned long) hcd->regs;
 	io_size = pci_resource_len(hcd->pdev, hcd->region);
 
 #ifdef CONFIG_PROC_FS
@@ -2188,10 +2201,6 @@
 	uhci->proc_entry = ent;
 #endif
 
-	/* Reset here so we don't get any interrupts from an old setup */
-	/*  or broken setup */
-	reset_hc(uhci);
-
 	uhci->fsbr = 0;
 	uhci->fsbrtimeout = 0;
 
@@ -2343,9 +2352,6 @@
 
 	init_stall_timer(hcd);
 
-	/* disable legacy emulation */
-	pci_write_config_word(hcd->pdev, USBLEGSUP, USBLEGSUP_DEFAULT);
-
 	udev->speed = USB_SPEED_FULL;
 
 	if (usb_register_root_hub(udev, &hcd->pdev->dev) != 0) {
@@ -2446,7 +2452,7 @@
 		reset_hc(uhci);
 		start_hc(uhci);
 	}
-	uhci->hcd.state = USB_STATE_READY;
+	uhci->hcd.state = USB_STATE_RUNNING;
 	return 0;
 }
 #endif
@@ -2484,6 +2490,7 @@
 	.flags =		HCD_USB11,
 
 	/* Basic lifecycle operations */
+	.reset =		uhci_reset,
 	.start =		uhci_start,
 #ifdef CONFIG_PM
 	.suspend =		uhci_suspend,
@@ -2504,18 +2511,9 @@
 };
 
 static const struct pci_device_id uhci_pci_ids[] = { {
-
 	/* handle any USB UHCI controller */
-	.class = 		((PCI_CLASS_SERIAL_USB << 8) | 0x00),
-	.class_mask = 	~0,
+	PCI_DEVICE_CLASS(((PCI_CLASS_SERIAL_USB << 8) | 0x00), ~0),
 	.driver_data =	(unsigned long) &uhci_driver,
-
-	/* no matter who makes it */
-	.vendor =	PCI_ANY_ID,
-	.device =	PCI_ANY_ID,
-	.subvendor =	PCI_ANY_ID,
-	.subdevice =	PCI_ANY_ID,
-
 	}, { /* end: all zeroes */ }
 };
 
