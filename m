Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbTD2VCF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 17:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbTD2VCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 17:02:05 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:57763 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261788AbTD2VCC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 17:02:02 -0400
Date: Tue, 29 Apr 2003 14:15:50 -0700
From: Greg KH <greg@kroah.com>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [Bluetooth] HCI USB driver update. Support for SCO over HCI USB.
Message-ID: <20030429211550.GA8669@kroah.com>
References: <200304290317.h3T3HOdA027579@hera.kernel.org> <200304290317.h3T3HOdA027579@hera.kernel.org> <5.1.0.14.2.20030429131303.10d7f330@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20030429131303.10d7f330@unixmail.qualcomm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 29, 2003 at 01:29:41PM -0700, Max Krasnyansky wrote:
> >You aren't calling usb_free_urb() as you are embedding a struct urb
> >within your struct _urb structure.  Any reason you can't use a struct
> >urb * instead and call the usb core's functions to create and return 
> >a urb ?
> I didn't want to do two allocations (one for struct _urb and one for
> struct urb).

I agree, and understand what you are doing, it makes sense for your
case.  Just wanted to make sure you were aware of the future danger :)

> >Otherwise any changes to the internal urb structures, and the
> >usb_alloc_urb() and usb_free_urb() functions will have to be mirrored
> >here in your functions, and I know I will forget to do that :)
> How about 

<snip>

Ok, that works for me.  Does the patch below work out for you?

> I was actually going to ask you guys if you'd be interested in
> generalizing this _urb_queue() stuff that I have for other drivers.
> Current URB api does not provide any interface for
> queueing/linking/etc of URBs in the _driver_ itself. Things like next,
> prev, etc are used in the HCD. So if driver submits bunch of different
> URBs (and potentially multiple URBs of the same type like hci_usb
> does) it has to implement its own lists, arrays and stuff. I used to
> use SKBs for URB queues but struct sk_buff is to big for that simple
> task.

Yes, generalizing that stuff would be nice to have.  Lots of drivers
have to manage their urbs on their own today, and making that easier to
do would be a good thing.

thanks,

greg k-h


# usb: create usb_init_urb() for those people who like to live dangerously (like the bluetooth stack.)

diff -Nru a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
--- a/drivers/usb/core/urb.c	Tue Apr 29 14:07:13 2003
+++ b/drivers/usb/core/urb.c	Tue Apr 29 14:07:13 2003
@@ -14,6 +14,29 @@
 #include "hcd.h"
 
 /**
+ * usb_init_urb - initializes a urb so that it can be used by a USB driver
+ * @urb: pointer to the urb to initialize
+ *
+ * Initializes a urb so that the USB subsystem can use it properly.
+ *
+ * If a urb is created with a call to usb_alloc_urb() it is not
+ * necessary to call this function.  Only use this if you allocate the
+ * space for a struct urb on your own.  If you call this function, be
+ * careful when freeing the memory for your urb that it is no longer in
+ * use by the USB core.
+ */
+int usb_init_urb(struct urb *urb)
+{
+	if (!urb)
+		return -EINVAL;
+	memset(urb, 0, sizeof(*urb));
+	urb->count = (atomic_t)ATOMIC_INIT(1);
+	spin_lock_init(&urb->lock);
+
+	return 0;
+}
+
+/**
  * usb_alloc_urb - creates a new urb for a USB driver to use
  * @iso_packets: number of iso packets for this urb
  * @mem_flags: the type of memory to allocate, see kmalloc() for a list of
@@ -38,13 +61,14 @@
 		mem_flags);
 	if (!urb) {
 		err("alloc_urb: kmalloc failed");
-		return NULL;
+		goto exit;
+	}
+	if (usb_init_urb(urb)) {
+		kfree(urb);
+		urb = NULL;
 	}
 
-	memset(urb, 0, sizeof(*urb));
-	urb->count = (atomic_t)ATOMIC_INIT(1);
-	spin_lock_init(&urb->lock);
-
+exit:
 	return urb;
 }
 
@@ -387,7 +411,7 @@
 		return -ENODEV;
 }
 
-// asynchronous request completion model
+EXPORT_SYMBOL(usb_init_urb);
 EXPORT_SYMBOL(usb_alloc_urb);
 EXPORT_SYMBOL(usb_free_urb);
 EXPORT_SYMBOL(usb_get_urb);
diff -Nru a/include/linux/usb.h b/include/linux/usb.h
--- a/include/linux/usb.h	Tue Apr 29 14:07:13 2003
+++ b/include/linux/usb.h	Tue Apr 29 14:07:13 2003
@@ -766,6 +766,7 @@
 }
 
 extern struct urb *usb_alloc_urb(int iso_packets, int mem_flags);
+extern int usb_init_urb(struct urb *urb);
 extern void usb_free_urb(struct urb *urb);
 #define usb_put_urb usb_free_urb
 extern struct urb *usb_get_urb(struct urb *urb);
