Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263074AbTDQFyF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 01:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263077AbTDQFwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 01:52:34 -0400
Received: from granite.he.net ([216.218.226.66]:53008 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263073AbTDQFu5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 01:50:57 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10505595032542@kroah.com>
Subject: [PATCH] More USB fixes for 2.5.67
In-Reply-To: <20030417060317.GI2201@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 16 Apr 2003 23:05:03 -0700
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1055, 2003/04/14 10:13:28-07:00, david-b@pacbell.net

[PATCH] USB: disconnect cleanup, new HCD callback

Here's a streamlined version:  doesn't require the unlink
cleanup, and expects the *hci-hcd updates later.  Smaller,
and sanity checked against all three major HCDs.

  - reverts that unlink() patch: disconnect() callbacks
    can continue to act like they always have.

  - adds new "disable that endpoint" support, necessary
    for safely changing configurations or altsettings
    as well as physical disconnect (which is almost the
    same as setting config to zero, except for ep0).

  - NEW BEHAVIOUR:  usbcore cleans up after drivers that
    return from disconnect() with urbs still linked, by
    using the new "disable that endpoint" support.

Because it doesn't have any *hci-hcd updates, the hardware
synch needed by EHCI and OHCI (not UHCI) still gets done
through the bus->deallocate(dev) call ... not where we've
ever needed it, but 2.3-compatible (and finally fixable).

That gets rid of some problematic disconnect scenarios, and
other fixes can be phased in over time:  the *hci-hcd updates
to relocate the hardware synch point so it always happens in
a task context, and disabling endpoints before their configs
change (invalidating all HC state).


diff -Nru a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
--- a/drivers/usb/core/hcd.c	Wed Apr 16 10:49:39 2003
+++ b/drivers/usb/core/hcd.c	Wed Apr 16 10:49:39 2003
@@ -1068,6 +1068,28 @@
 
 /*-------------------------------------------------------------------------*/
 
+/* this makes the hcd giveback() the urb more quickly, by kicking it
+ * off hardware queues (which may take a while) and returning it as
+ * soon as practical.  we've already set up the urb's return status,
+ * but we can't know if the callback completed already.
+ */
+static void
+unlink1 (struct usb_hcd *hcd, struct urb *urb)
+{
+	if (urb == (struct urb *) hcd->rh_timer.data)
+		usb_rh_status_dequeue (hcd, urb);
+	else {
+		int		value;
+
+		/* failures "should" be harmless */
+		value = hcd->driver->urb_dequeue (hcd, urb);
+		if (value != 0)
+			dev_dbg (hcd->controller,
+				"dequeue %p --> %d\n",
+				urb, value);
+	}
+}
+
 struct completion_splice {		// modified urb context:
 	/* did we complete? */
 	struct completion	done;
@@ -1176,6 +1198,7 @@
 	spin_unlock (&hcd_data_lock);
 	spin_unlock_irqrestore (&urb->lock, flags);
 
+	// FIXME remove splicing, so this becomes unlink1 (hcd, urb);
 	if (urb == (struct urb *) hcd->rh_timer.data) {
 		usb_rh_status_dequeue (hcd, urb);
 		retval = 0;
@@ -1213,11 +1236,98 @@
 
 /*-------------------------------------------------------------------------*/
 
-/* called by khubd, rmmod, apmd, or other thread for hcd-private cleanup */
+/* disables the endpoint: cancels any pending urbs, then synchronizes with
+ * the hcd to make sure all endpoint state is gone from hardware. use for
+ * set_configuration, set_interface, driver removal, physical disconnect.
+ *
+ * example:  a qh stored in hcd_dev.ep[], holding state related to endpoint
+ * type, maxpacket size, toggle, halt status, and scheduling.
+ */
+static void hcd_endpoint_disable (struct usb_device *udev, int endpoint)
+{
+	unsigned long	flags;
+	struct hcd_dev	*dev;
+	struct usb_hcd	*hcd;
+	struct urb	*urb;
+	unsigned	epnum = endpoint & USB_ENDPOINT_NUMBER_MASK;
 
-// FIXME:  likely best to have explicit per-setting (config+alt)
-// setup primitives in the usbcore-to-hcd driver API, so nothing
-// is implicit.  kernel 2.5 needs a bunch of config cleanup...
+	dev = udev->hcpriv;
+	hcd = udev->bus->hcpriv;
+
+rescan:
+	/* (re)block new requests, as best we can */
+	if (endpoint & USB_DIR_IN) {
+		usb_endpoint_halt (udev, epnum, 0);
+		udev->epmaxpacketin [epnum] = 0;
+	} else {
+		usb_endpoint_halt (udev, epnum, 1);
+		udev->epmaxpacketout [epnum] = 0;
+	}
+
+	/* then kill any current requests */
+	spin_lock_irqsave (&hcd_data_lock, flags);
+	list_for_each_entry (urb, &dev->urb_list, urb_list) {
+		int	tmp = urb->pipe;
+
+		/* ignore urbs for other endpoints */
+		if (usb_pipeendpoint (tmp) != epnum)
+			continue;
+		if ((tmp ^ endpoint) & USB_DIR_IN)
+			continue;
+
+		/* another cpu may be in hcd, spinning on hcd_data_lock
+		 * to giveback() this urb.  the races here should be
+		 * small, but a full fix needs a new "can't submit"
+		 * urb state.
+		 */
+		if (urb->status != -EINPROGRESS)
+			continue;
+		usb_get_urb (urb);
+		spin_unlock (&hcd_data_lock);
+
+		spin_lock (&urb->lock);
+		tmp = urb->status;
+		if (tmp == -EINPROGRESS)
+			urb->status = -ESHUTDOWN;
+		spin_unlock (&urb->lock);
+
+		/* kick hcd unless it's already returning this */
+		if (tmp == -EINPROGRESS) {
+			tmp = urb->pipe;
+			unlink1 (hcd, urb);
+			dev_dbg (hcd->controller,
+				"shutdown urb %p pipe %08x ep%d%s%s\n",
+				urb, tmp, usb_pipeendpoint (tmp),
+				(tmp & USB_DIR_IN) ? "in" : "out",
+				({ char *s; \
+				 switch (usb_pipetype (tmp)) { \
+				 case PIPE_CONTROL:	s = ""; break; \
+				 case PIPE_BULK:	s = "-bulk"; break; \
+				 case PIPE_INTERRUPT:	s = "-intr"; break; \
+				 default: 		s = "-iso"; break; \
+				}; s;}));
+		}
+		usb_put_urb (urb);
+
+		/* list contents may have changed */
+		goto rescan;
+	}
+	spin_unlock_irqrestore (&hcd_data_lock, flags);
+
+	/* synchronize with the hardware, so old configuration state
+	 * clears out immediately (and will be freed).
+	 */
+	might_sleep ();
+	if (hcd->driver->endpoint_disable)
+		hcd->driver->endpoint_disable (hcd, dev, endpoint);
+}
+
+/*-------------------------------------------------------------------------*/
+
+/* called by khubd, rmmod, apmd, or other thread for hcd-private cleanup.
+ * we're guaranteed that the device is fully quiesced.  also, that each
+ * endpoint has been hcd_endpoint_disabled.
+ */
 
 static int hcd_free_dev (struct usb_device *udev)
 {
@@ -1270,6 +1380,7 @@
 	.deallocate =		hcd_free_dev,
 	.buffer_alloc =		hcd_buffer_alloc,
 	.buffer_free =		hcd_buffer_free,
+	.disable =		hcd_endpoint_disable,
 };
 EXPORT_SYMBOL (usb_hcd_operations);
 
diff -Nru a/drivers/usb/core/hcd.h b/drivers/usb/core/hcd.h
--- a/drivers/usb/core/hcd.h	Wed Apr 16 10:49:39 2003
+++ b/drivers/usb/core/hcd.h	Wed Apr 16 10:49:39 2003
@@ -153,6 +153,8 @@
 			dma_addr_t *dma);
 	void (*buffer_free)(struct usb_bus *bus, size_t size,
 			void *addr, dma_addr_t dma);
+
+	void (*disable)(struct usb_device *udev, int bEndpointAddress);
 };
 
 /* each driver provides one of these, and hardware init support */
@@ -198,6 +200,10 @@
 	// urb_enqueue, and not freed by urb_dequeue
 	void		(*free_config) (struct usb_hcd *hcd,
 				struct usb_device *dev);
+
+	/* hw synch, freeing endpoint resources that urb_dequeue can't */
+	void 	(*endpoint_disable)(struct usb_hcd *hcd,
+			struct hcd_dev *dev, int bEndpointAddress);
 
 	/* root hub support */
 	int		(*hub_status_data) (struct usb_hcd *hcd, char *buf);
diff -Nru a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
--- a/drivers/usb/core/urb.c	Wed Apr 16 10:49:39 2003
+++ b/drivers/usb/core/urb.c	Wed Apr 16 10:49:39 2003
@@ -381,16 +381,7 @@
  */
 int usb_unlink_urb(struct urb *urb)
 {
-	/* FIXME
-	 * We should not care about the state here, but the host controllers
-	 * die a horrible death if we unlink a urb for a device that has been
-	 * physically removed.
-	 */
-	if (urb &&
-	    urb->dev &&
-	    (urb->dev->state >= USB_STATE_DEFAULT) &&
-	    urb->dev->bus &&
-	    urb->dev->bus->op)
+	if (urb && urb->dev && urb->dev->bus && urb->dev->bus->op)
 		return urb->dev->bus->op->unlink_urb(urb);
 	else
 		return -ENODEV;
diff -Nru a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
--- a/drivers/usb/core/usb.c	Wed Apr 16 10:49:39 2003
+++ b/drivers/usb/core/usb.c	Wed Apr 16 10:49:39 2003
@@ -786,8 +786,12 @@
  */
 void usb_disconnect(struct usb_device **pdev)
 {
-	struct usb_device * dev = *pdev;
-	int i;
+	struct usb_device	*dev = *pdev;
+	struct usb_bus		*bus = dev->bus;
+	struct usb_operations	*ops = bus->op;
+	int			i;
+
+	might_sleep ();
 
 	if (!dev)
 		return;
@@ -808,13 +812,25 @@
 			usb_disconnect(child);
 	}
 
+	/* disconnect() drivers from interfaces (a key side effect) */
 	dev_dbg (&dev->dev, "unregistering interfaces\n");
 	if (dev->actconfig) {
 		for (i = 0; i < dev->actconfig->desc.bNumInterfaces; i++) {
-			struct usb_interface *interface = &dev->actconfig->interface[i];
+			struct usb_interface	*interface;
 
 			/* remove this interface */
+			interface = &dev->actconfig->interface[i];
 			device_unregister(&interface->dev);
+		}
+	}
+
+	/* deallocate hcd/hardware state */
+	if (ops->disable) {
+		void	(*disable)(struct usb_device *, int) = ops->disable;
+
+		for (i = 0; i < 15; i++) {
+			disable (dev, i);
+			disable (dev, USB_DIR_IN | i);
 		}
 	}
 

