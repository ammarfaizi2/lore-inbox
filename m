Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbVAHGqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbVAHGqJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 01:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbVAHGpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 01:45:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:28294 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261940AbVAHFsw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:52 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632671247@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:47 -0800
Message-Id: <1105163267561@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.29, 2004/12/17 11:39:40-08:00, david-b@pacbell.net

[PATCH] USB: HCDs and per-device state (16/15)

SL811 changes getting rid of the "hcd_dev" support, using
usb_host_endpoint to hold the QH.  This also eliminates the
"sl811h_req" data type.  Compile-tested only!

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/host/sl811-hcd.c |  149 +++++++++++++++----------------------------
 drivers/usb/host/sl811.h     |   10 --
 2 files changed, 53 insertions(+), 106 deletions(-)


diff -Nru a/drivers/usb/host/sl811-hcd.c b/drivers/usb/host/sl811-hcd.c
--- a/drivers/usb/host/sl811-hcd.c	2005-01-07 15:47:03 -08:00
+++ b/drivers/usb/host/sl811-hcd.c	2005-01-07 15:47:03 -08:00
@@ -67,7 +67,7 @@
 MODULE_DESCRIPTION("SL811HS USB Host Controller Driver");
 MODULE_LICENSE("GPL");
 
-#define DRIVER_VERSION	"06 Dec 2004"
+#define DRIVER_VERSION	"15 Dec 2004"
 
 
 #ifndef DEBUG
@@ -314,7 +314,6 @@
 static struct sl811h_ep	*start(struct sl811 *sl811, u8 bank)
 {
 	struct sl811h_ep	*ep;
-	struct sl811h_req	*req;
 	struct urb		*urb;
 	int			fclock;
 	u8			control;
@@ -348,13 +347,12 @@
 					struct sl811h_ep, schedule);
 	}
 
-	if (unlikely(list_empty(&ep->queue))) {
+	if (unlikely(list_empty(&ep->hep->urb_list))) {
 		DBG("empty %p queue?\n", ep);
 		return NULL;
 	}
 
-	req = container_of(ep->queue.next, struct sl811h_req, queue);
-	urb = req->urb;
+	urb = container_of(ep->hep->urb_list.next, struct urb, urb_list);
 	control = ep->defctrl;
 
 	/* if this frame doesn't have enough time left to transfer this
@@ -432,17 +430,12 @@
 static void finish_request(
 	struct sl811		*sl811,
 	struct sl811h_ep	*ep,
-	struct sl811h_req	*req,
+	struct urb		*urb,
 	struct pt_regs		*regs,
 	int			status
 ) __releases(sl811->lock) __acquires(sl811->lock)
 {
 	unsigned		i;
-	struct urb		*urb = req->urb;
-
-	list_del(&req->queue);
-	kfree(req);
-	urb->hcpriv = NULL;
 
 	if (usb_pipecontrol(urb->pipe))
 		ep->nextpid = USB_PID_SETUP;
@@ -457,7 +450,7 @@
 	spin_lock(&sl811->lock);
 
 	/* leave active endpoints in the schedule */
-	if (!list_empty(&ep->queue))
+	if (!list_empty(&ep->hep->urb_list))
 		return;
 
 	/* async deschedule? */
@@ -496,7 +489,6 @@
 done(struct sl811 *sl811, struct sl811h_ep *ep, u8 bank, struct pt_regs *regs)
 {
 	u8			status;
-	struct sl811h_req	*req;
 	struct urb		*urb;
 	int			urbstat = -EINPROGRESS;
 
@@ -505,8 +497,7 @@
 
 	status = sl811_read(sl811, bank + SL11H_PKTSTATREG);
 
-	req = container_of(ep->queue.next, struct sl811h_req, queue);
-	urb = req->urb;
+	urb = container_of(ep->hep->urb_list.next, struct urb, urb_list);
 
 	/* we can safely ignore NAKs */
 	if (status & SL11H_STATMASK_NAK) {
@@ -577,7 +568,7 @@
 					urb->status = urbstat;
 				spin_unlock(&urb->lock);
 
-				req = NULL;
+				urb = NULL;
 				ep->nextpid = USB_PID_ACK;
 			}
 			break;
@@ -618,9 +609,8 @@
 				bank, status, ep, urbstat);
 	}
 
-	if ((urbstat != -EINPROGRESS || urb->status != -EINPROGRESS)
-			&& req)
-		finish_request(sl811, ep, req, regs, urbstat);
+	if (urb && (urbstat != -EINPROGRESS || urb->status != -EINPROGRESS))
+		finish_request(sl811, ep, urb, regs, urbstat);
 }
 
 static inline u8 checkdone(struct sl811 *sl811)
@@ -643,7 +633,7 @@
 		ctl = sl811_read(sl811, SL811_EP_B(SL11H_HOSTCTLREG));
 		if (ctl & SL11H_HCTLMASK_ARM)
 			sl811_write(sl811, SL811_EP_B(SL11H_HOSTCTLREG), 0);
-		DBG("%s DONE_B: ctrl %02x sts %02x\n", ctl,
+		DBG("%s DONE_B: ctrl %02x sts %02x\n",
 			(ctl & SL11H_HCTLMASK_ARM) ? "timeout" : "lost",
 			ctl,
 			sl811_read(sl811, SL811_EP_B(SL11H_PKTSTATREG)));
@@ -732,8 +722,8 @@
 		if (sl811->active_a) {
 			sl811_write(sl811, SL811_EP_A(SL11H_HOSTCTLREG), 0);
 			finish_request(sl811, sl811->active_a,
-				container_of(sl811->active_a->queue.next,
-					struct sl811h_req, queue),
+				container_of(sl811->active_a->hep->urb_list.next,
+					struct urb, urb_list),
 				NULL, -ESHUTDOWN);
 			sl811->active_a = NULL;
 		}
@@ -741,8 +731,8 @@
 		if (sl811->active_b) {
 			sl811_write(sl811, SL811_EP_B(SL11H_HOSTCTLREG), 0);
 			finish_request(sl811, sl811->active_b,
-				container_of(sl811->active_b->queue.next,
-					struct sl811h_req, queue),
+				container_of(sl811->active_b->hep->urb_list.next,
+					struct urb, urb_list),
 				NULL, -ESHUTDOWN);
 			sl811->active_b = NULL;
 		}
@@ -816,19 +806,18 @@
 /*-------------------------------------------------------------------------*/
 
 static int sl811h_urb_enqueue(
-	struct usb_hcd	*hcd,
-	struct urb	*urb,
-	int		mem_flags
+	struct usb_hcd		*hcd,
+	struct usb_host_endpoint *hep,
+	struct urb		*urb,
+	int			mem_flags
 ) {
 	struct sl811		*sl811 = hcd_to_sl811(hcd);
 	struct usb_device	*udev = urb->dev;
-	struct hcd_dev		*hdev = (struct hcd_dev *) udev->hcpriv;
 	unsigned int		pipe = urb->pipe;
 	int			is_out = !usb_pipein(pipe);
 	int			type = usb_pipetype(pipe);
 	int			epnum = usb_pipeendpoint(pipe);
 	struct sl811h_ep	*ep = NULL;
-	struct sl811h_req	*req;
 	unsigned long		flags;
 	int			i;
 	int			retval = 0;
@@ -838,16 +827,8 @@
 		return -ENOSPC;
 #endif
 
-	/* avoid all allocations within spinlocks: request or endpoint */
-	urb->hcpriv = req = kmalloc(sizeof *req, mem_flags);
-	if (!req)
-		return -ENOMEM;
-	req->urb = urb;
-
-	i = epnum << 1;
-	if (i && is_out)
-		i |= 1;
-	if (!hdev->ep[i])
+	/* avoid all allocations within spinlocks */
+	if (!hep->hcpriv)
 		ep = kcalloc(1, sizeof *ep, mem_flags);
 
 	spin_lock_irqsave(&sl811->lock, flags);
@@ -859,15 +840,14 @@
 		goto fail;
 	}
 
-	if (hdev->ep[i]) {
+	if (hep->hcpriv) {
 		kfree(ep);
-		ep = hdev->ep[i];
+		ep = hep->hcpriv;
 	} else if (!ep) {
 		retval = -ENOMEM;
 		goto fail;
 
 	} else {
-		INIT_LIST_HEAD(&ep->queue);
 		INIT_LIST_HEAD(&ep->schedule);
 		ep->udev = usb_get_dev(udev);
 		ep->epnum = epnum;
@@ -911,7 +891,7 @@
 			break;
 		}
 
-		hdev->ep[i] = ep;
+		hep->hcpriv = ep;
 	}
 
 	/* maybe put endpoint into schedule */
@@ -966,47 +946,38 @@
 	spin_lock(&urb->lock);
 	if (urb->status != -EINPROGRESS) {
 		spin_unlock(&urb->lock);
-		finish_request(sl811, ep, req, NULL, 0);
-		req = NULL;
+		finish_request(sl811, ep, urb, NULL, 0);
 		retval = 0;
 		goto fail;
 	}
-	list_add_tail(&req->queue, &ep->queue);
+	urb->hcpriv = hep;
 	spin_unlock(&urb->lock);
 
 	start_transfer(sl811);
 	sl811_write(sl811, SL11H_IRQ_ENABLE, sl811->irq_enable);
 fail:
 	spin_unlock_irqrestore(&sl811->lock, flags);
-	if (retval)
-		kfree(req);
 	return retval;
 }
 
 static int sl811h_urb_dequeue(struct usb_hcd *hcd, struct urb *urb)
 {
 	struct sl811		*sl811 = hcd_to_sl811(hcd);
-	struct usb_device	*udev = urb->dev;
-	struct hcd_dev		*hdev = (struct hcd_dev *) udev->hcpriv;
-	unsigned int		pipe = urb->pipe;
-	int			is_out = !usb_pipein(pipe);
+	struct usb_host_endpoint *hep = urb->hcpriv;
 	unsigned long		flags;
-	unsigned		i;
 	struct sl811h_ep	*ep;
-	struct sl811h_req	*req = urb->hcpriv;
 	int			retval = 0;
 
-	i = usb_pipeendpoint(pipe) << 1;
-	if (i && is_out)
-		i |= 1;
+	if (!hep)
+		return -EINVAL;
 
 	spin_lock_irqsave(&sl811->lock, flags);
-	ep = hdev->ep[i];
+	ep = hep->hcpriv;
 	if (ep) {
 		/* finish right away if this urb can't be active ...
 		 * note that some drivers wrongly expect delays
 		 */
-		if (ep->queue.next != &req->queue) {
+		if (ep->hep->urb_list.next != &urb->urb_list) {
 			/* not front of queue?  never active */
 
 		/* for active transfers, we expect an IRQ */
@@ -1022,7 +993,7 @@
 						0);
 				sl811->active_a = NULL;
 			} else
-				req = NULL;
+				urb = NULL;
 #ifdef	USE_B
 		} else if (sl811->active_b == ep) {
 			if (time_before_eq(sl811->jiffies_a, jiffies)) {
@@ -1036,14 +1007,14 @@
 						0);
 				sl811->active_b = NULL;
 			} else
-				req = NULL;
+				urb = NULL;
 #endif
 		} else {
 			/* front of queue for inactive endpoint */
 		}
 
-		if (req)
-			finish_request(sl811, ep, req, NULL, 0);
+		if (urb)
+			finish_request(sl811, ep, urb, NULL, 0);
 		else
 			VDBG("dequeue, urb %p active %s; wait4irq\n", urb,
 				(sl811->active_a == ep) ? "A" : "B");
@@ -1054,33 +1025,22 @@
 }
 
 static void
-sl811h_endpoint_disable(struct usb_hcd *hcd, struct hcd_dev *hdev, int epnum)
+sl811h_endpoint_disable(struct usb_hcd *hcd, struct usb_host_endpoint *hep)
 {
-	struct sl811		*sl811 = hcd_to_sl811(hcd);
-	struct sl811h_ep	*ep;
-	unsigned long		flags;
-	int			i;
-
-	i = (epnum & 0xf) << 1;
-	if (epnum && !(epnum & USB_DIR_IN))
-		i |= 1;
-
-	spin_lock_irqsave(&sl811->lock, flags);
-	ep = hdev->ep[i];
-	hdev->ep[i] = NULL;
-	spin_unlock_irqrestore(&sl811->lock, flags);
+	struct sl811h_ep	*ep = hep->hcpriv;
 
-	if (ep) {
-		/* assume we'd just wait for the irq */
-		if (!list_empty(&ep->queue))
-			msleep(3);
-		if (!list_empty(&ep->queue))
-			WARN("ep %p not empty?\n", ep);
+	if (!ep)
+		return;
 
-		usb_put_dev(ep->udev);
-		kfree(ep);
-	}
-	return;
+	/* assume we'd just wait for the irq */
+	if (!list_empty(&hep->urb_list))
+		msleep(3);
+	if (!list_empty(&hep->urb_list))
+		WARN("ep %p not empty?\n", ep);
+
+	usb_put_dev(ep->udev);
+	kfree(ep);
+	hep->hcpriv = 0;
 }
 
 static int
@@ -1481,7 +1441,7 @@
 		sl811_read(sl811, SL811_EP_B(SL11H_PKTSTATREG)));
 	seq_printf(s, "\n");
 	list_for_each_entry (ep, &sl811->async, schedule) {
-		struct sl811h_req	*req;
+		struct urb		*urb;
 
 		seq_printf(s, "%s%sqh%p, ep%d%s, maxpacket %d"
 					" nak %d err %d\n",
@@ -1497,10 +1457,10 @@
 			}; s;}),
 			ep->maxpacket,
 			ep->nak_count, ep->error_count);
-		list_for_each_entry (req, &ep->queue, queue) {
-			seq_printf(s, "  urb%p, %d/%d\n", req->urb,
-				req->urb->actual_length,
-				req->urb->transfer_buffer_length);
+		list_for_each_entry (urb, &ep->hep->urb_list, urb_list) {
+			seq_printf(s, "  urb%p, %d/%d\n", urb,
+				urb->actual_length,
+				urb->transfer_buffer_length);
 		}
 	}
 	if (!list_empty(&sl811->async))
@@ -1743,11 +1703,6 @@
 	sl811->hcd.self.op = &usb_hcd_operations;
 	sl811->hcd.self.hcpriv = sl811;
 
-	// NOTE: 2.6.11 starts to change the hcd glue layer some more,
-	// eventually letting us eliminate struct sl811h_req and a
-	// lot of the boilerplate code here 
-
-	INIT_LIST_HEAD(&sl811->hcd.dev_list);
 	sl811->hcd.self.release = &usb_hcd_release;
 
 	sl811->hcd.description = sl811h_hc_driver.description;
diff -Nru a/drivers/usb/host/sl811.h b/drivers/usb/host/sl811.h
--- a/drivers/usb/host/sl811.h	2005-01-07 15:47:03 -08:00
+++ b/drivers/usb/host/sl811.h	2005-01-07 15:47:03 -08:00
@@ -162,7 +162,7 @@
 }
 
 struct sl811h_ep {
-	struct list_head	queue;
+	struct usb_host_endpoint *hep;
 	struct usb_device	*udev;
 
 	u8			defctrl;
@@ -182,14 +182,6 @@
 
 	/* async schedule */
 	struct list_head	schedule;
-};
-
-struct sl811h_req {
-	/* FIXME usbcore should maintain endpoints' urb queues
-	 * directly in 'struct usb_host_endpoint'
-	 */
-	struct urb		*urb;
-	struct list_head	queue;
 };
 
 /*-------------------------------------------------------------------------*/

