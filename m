Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272117AbRHVU7M>; Wed, 22 Aug 2001 16:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272118AbRHVU6x>; Wed, 22 Aug 2001 16:58:53 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:57511 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S272117AbRHVU6m>; Wed, 22 Aug 2001 16:58:42 -0400
Date: Wed, 22 Aug 2001 16:58:53 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: alan@lxorguk.ukuu.org.uk, johannes@erdfelt.com
Cc: Pete Zaitcev <zaitcev@redhat.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: usb not working with 2.4.8-ac8
Message-ID: <20010822165853.A24726@devserv.devel.redhat.com>
In-Reply-To: <mailman.998431141.21252.linux-kernel2news@redhat.com> <200108220004.f7M04Qx01206@devserv.devel.redhat.com> <3B8355D9.7DE64E38@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B8355D9.7DE64E38@home.com>; from ledzep37@home.com on Wed, Aug 22, 2001 at 01:48:57AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The usb-uhci and ohci worked fine, so I poked uhci a little bit
and made it all work, at least with my setup. Apparently,
sometimes uhci returns a success (0) from submit_urb, but
forgets to deliver a completion callback.

The fix is a Johannes' territory and I not so sure of my way there,
so perhaps a better one may be forthcoming.

I left the diagnostic printout in for usb_start_wait_urb,
we may drop it later. It must not be triggered if everything
works as planned.

-- Pete

diff -ur -X dontdiff linux-2.4.8-ac9/drivers/usb/uhci.c linux-2.4.8-ac9-niph/drivers/usb/uhci.c
--- linux-2.4.8-ac9/drivers/usb/uhci.c	Wed Aug 22 11:01:57 2001
+++ linux-2.4.8-ac9-niph/drivers/usb/uhci.c	Wed Aug 22 13:25:00 2001
@@ -1471,6 +1471,7 @@
 
 static int uhci_submit_urb(struct urb *urb)
 {
+	struct usb_device *dev;
 	int ret = -EINVAL;
 	struct uhci *uhci;
 	unsigned long flags;
@@ -1480,15 +1481,16 @@
 	if (!urb)
 		return -EINVAL;
 
-	if (!urb->dev || !urb->dev->bus || !urb->dev->bus->hcpriv) {
+	dev = urb->dev;
+	if (!dev || !dev->bus || !dev->bus->hcpriv) {
 		warn("uhci_submit_urb: urb %p belongs to disconnected device or bus?", urb);
 		return -ENODEV;
 	}
 
-	uhci = (struct uhci *)urb->dev->bus->hcpriv;
+	uhci = (struct uhci *)dev->bus->hcpriv;
 
 	INIT_LIST_HEAD(&urb->urb_list);
-	usb_inc_dev_use(urb->dev);
+	usb_inc_dev_use(dev);
 
 	spin_lock_irqsave(&urb->lock, flags);
 
@@ -1497,7 +1499,7 @@
 		dbg("uhci_submit_urb: urb not available to submit (status = %d)", urb->status);
 		/* Since we can have problems on the out path */
 		spin_unlock_irqrestore(&urb->lock, flags);
-		usb_dec_dev_use(urb->dev);
+		usb_dec_dev_use(dev);
 
 		return ret;
 	}
@@ -1516,7 +1518,7 @@
 	}
 
 	/* Short circuit the virtual root hub */
-	if (urb->dev == uhci->rh.dev) {
+	if (dev == uhci->rh.dev) {
 		ret = rh_submit_urb(urb);
 
 		goto out;
@@ -1528,13 +1530,13 @@
 		break;
 	case PIPE_INTERRUPT:
 		if (urb->bandwidth == 0) {	/* not yet checked/allocated */
-			bustime = usb_check_bandwidth(urb->dev, urb);
+			bustime = usb_check_bandwidth(dev, urb);
 			if (bustime < 0)
 				ret = bustime;
 			else {
 				ret = uhci_submit_interrupt(urb);
 				if (ret == -EINPROGRESS)
-					usb_claim_bandwidth(urb->dev, urb, bustime, 0);
+					usb_claim_bandwidth(dev, urb, bustime, 0);
 			}
 		} else		/* bandwidth is already set */
 			ret = uhci_submit_interrupt(urb);
@@ -1548,7 +1550,7 @@
 				ret = -EINVAL;
 				break;
 			}
-			bustime = usb_check_bandwidth(urb->dev, urb);
+			bustime = usb_check_bandwidth(dev, urb);
 			if (bustime < 0) {
 				ret = bustime;
 				break;
@@ -1556,7 +1558,7 @@
 
 			ret = uhci_submit_isochronous(urb);
 			if (ret == -EINPROGRESS)
-				usb_claim_bandwidth(urb->dev, urb, bustime, 1);
+				usb_claim_bandwidth(dev, urb, bustime, 1);
 		} else		/* bandwidth is already set */
 			ret = uhci_submit_isochronous(urb);
 		break;
@@ -1578,8 +1580,14 @@
 
 	uhci_unlink_generic(uhci, urb);
 	uhci_destroy_urb_priv(urb);
+	if (ret == 0) {				/* N.B. Done, must notify */
+		/* uhci_call_completion(urb); */ /* ->> uhci_destroy_urb_priv */
+		urb->dev = NULL;
+		if (urb->complete)
+			urb->complete(urb);
+	}
 
-	usb_dec_dev_use(urb->dev);
+	usb_dec_dev_use(dev);
 
 	return ret;
 }
diff -ur -X dontdiff linux-2.4.8-ac9/drivers/usb/usb.c linux-2.4.8-ac9-niph/drivers/usb/usb.c
--- linux-2.4.8-ac9/drivers/usb/usb.c	Wed Aug 22 11:01:57 2001
+++ linux-2.4.8-ac9-niph/drivers/usb/usb.c	Wed Aug 22 11:41:04 2001
@@ -1085,10 +1085,17 @@
 	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&awd.wqh, &wait);
 
-	if (!timeout && !awd.done) {
-		printk("usb_control/bulk_msg: timeout\n");
-		usb_unlink_urb(urb);  // remove urb safely
-		status = -ETIMEDOUT;
+	if (!awd.done) {
+		if (urb->status != -EINPROGRESS) {	/* No callback?!! */
+			printk(KERN_ERR "usb: raced timeout, "
+			    "pipe 0x%x status %d time left %d\n",
+			    urb->pipe, urb->status, timeout);
+			status = urb->status;
+		} else {
+			printk("usb_control/bulk_msg: timeout\n");
+			usb_unlink_urb(urb);  // remove urb safely
+			status = -ETIMEDOUT;
+		}
 	} else
 		status = urb->status;
 
@@ -1111,16 +1118,15 @@
 	urb = usb_alloc_urb(0);
 	if (!urb)
 		return -ENOMEM;
-  
-	FILL_CONTROL_URB(urb, usb_dev, pipe, (unsigned char*)cmd, data, len,    /* build urb */  
-		   (usb_complete_t)usb_api_blocking_completion,0);
+
+	FILL_CONTROL_URB(urb, usb_dev, pipe, (unsigned char*)cmd, data, len,
+		   usb_api_blocking_completion, 0);
 
 	retv = usb_start_wait_urb(urb, timeout, &length);
 	if (retv < 0)
 		return retv;
 	else
 		return length;
-	
 }
 
 /**
@@ -1201,8 +1207,8 @@
 	if (!urb)
 		return -ENOMEM;
 
-	FILL_BULK_URB(urb,usb_dev,pipe,(unsigned char*)data,len,   /* build urb */
-			(usb_complete_t)usb_api_blocking_completion,0);
+	FILL_BULK_URB(urb, usb_dev, pipe, data, len,
+		    usb_api_blocking_completion, 0);
 
 	return usb_start_wait_urb(urb,timeout,actual_length);
 }
