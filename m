Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbVAHGBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbVAHGBn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 01:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVAHGAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 01:00:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:18053 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261800AbVAHFrz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:47:55 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632672368@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:47 -0800
Message-Id: <11051632671729@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.35, 2004/12/17 15:39:44-08:00, stern@rowland.harvard.edu

[PATCH] USB: dummy_hcd: update to match the new endpoint changes

Here's the patch to make dummy_hcd build properly once again.  I did some
quick light testing to make sure that it still works too.  The patch takes
the easy way out by allocating a new private data structure for each URB,
just to keep a single united list of all the outstanding URBs.  More
extensive changes would be needed to make effective use of the
per-endpoint queues now available, and it's probably not worth the effort.


Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/gadget/dummy_hcd.c |   60 +++++++++++++++++++++++------------------
 1 files changed, 35 insertions(+), 25 deletions(-)


diff -Nru a/drivers/usb/gadget/dummy_hcd.c b/drivers/usb/gadget/dummy_hcd.c
--- a/drivers/usb/gadget/dummy_hcd.c	2005-01-07 15:45:03 -08:00
+++ b/drivers/usb/gadget/dummy_hcd.c	2005-01-07 15:45:03 -08:00
@@ -65,7 +65,7 @@
 
 
 #define DRIVER_DESC	"USB Host+Gadget Emulator"
-#define DRIVER_VERSION	"29 Oct 2004"
+#define DRIVER_VERSION	"17 Dec 2004"
 
 static const char	driver_name [] = "dummy_hcd";
 static const char	driver_desc [] = "USB Host+Gadget Emulator";
@@ -143,6 +143,11 @@
 
 #define FIFO_SIZE		64
 
+struct urbp {
+	struct urb		*urb;
+	struct list_head	urbp_list;
+};
+
 struct dummy {
 	struct usb_hcd			hcd;		/* must come first! */
 	spinlock_t			lock;
@@ -168,6 +173,7 @@
 	unsigned long			re_timeout;
 
 	struct usb_device		*udev;
+	struct list_head		urbp_list;
 };
 
 static inline struct dummy *hcd_to_dummy (struct usb_hcd *hcd)
@@ -830,16 +836,23 @@
  */
 
 static int dummy_urb_enqueue (
-	struct usb_hcd	*hcd,
-	struct urb	*urb,
-	int		mem_flags
+	struct usb_hcd			*hcd,
+	struct usb_host_endpoint	*ep,
+	struct urb			*urb,
+	int				mem_flags
 ) {
 	struct dummy	*dum;
+	struct urbp	*urbp;
 	unsigned long	flags;
 
 	if (!urb->transfer_buffer && urb->transfer_buffer_length)
 		return -EINVAL;
 
+	urbp = kmalloc (sizeof *urbp, mem_flags);
+	if (!urbp)
+		return -ENOMEM;
+	urbp->urb = urb;
+
 	dum = hcd_to_dummy (hcd);
 	spin_lock_irqsave (&dum->lock, flags);
 
@@ -849,7 +862,8 @@
 	} else if (unlikely (dum->udev != urb->dev))
 		dev_err (dummy_dev(dum), "usb_device address has changed!\n");
 
-	urb->hcpriv = dum;
+	list_add_tail (&urbp->urbp_list, &dum->urbp_list);
+	urb->hcpriv = urbp;
 	if (usb_pipetype (urb->pipe) == PIPE_CONTROL)
 		urb->error_count = 1;		/* mark as a new urb */
 
@@ -1055,8 +1069,7 @@
 static void dummy_timer (unsigned long _dum)
 {
 	struct dummy		*dum = (struct dummy *) _dum;
-	struct hcd_dev		*hdev;
-	struct list_head	*entry, *tmp;
+	struct urbp		*urbp, *tmp;
 	unsigned long		flags;
 	int			limit, total;
 	int			i;
@@ -1088,7 +1101,6 @@
 		spin_unlock_irqrestore (&dum->lock, flags);
 		return;
 	}
-	hdev = dum->udev->hcpriv;
 
 	for (i = 0; i < DUMMY_ENDPOINTS; i++) {
 		if (!ep_name [i])
@@ -1097,14 +1109,14 @@
 	}
 
 restart:
-	list_for_each_safe (entry, tmp, &hdev->urb_list) {
+	list_for_each_entry_safe (urbp, tmp, &dum->urbp_list, urbp_list) {
 		struct urb		*urb;
 		struct dummy_request	*req;
 		u8			address;
 		struct dummy_ep		*ep = 0;
 		int			type;
 
-		urb = list_entry (entry, struct urb, urb_list);
+		urb = urbp->urb;
 		if (urb->status != -EINPROGRESS) {
 			/* likely it was just unlinked */
 			goto return_urb;
@@ -1349,7 +1361,9 @@
 			continue;
 
 return_urb:
-		urb->hcpriv = 0;
+		urb->hcpriv = NULL;
+		list_del (&urbp->urbp_list);
+		kfree (urbp);
 		if (ep)
 			ep->already_seen = ep->setup_stage = 0;
 
@@ -1361,7 +1375,7 @@
 	}
 
 	/* want a 1 msec delay here */
-	if (!list_empty (&hdev->urb_list))
+	if (!list_empty (&dum->urbp_list))
 		mod_timer (&dum->timer, jiffies + msecs_to_jiffies(1));
 	else {
 		usb_put_dev (dum->udev);
@@ -1601,21 +1615,17 @@
 {
 	struct usb_hcd		*hcd = dev_get_drvdata (dev);
 	struct dummy		*dum = hcd_to_dummy (hcd);
-	struct urb		*urb;
+	struct urbp		*urbp;
 	size_t			size = 0;
 	unsigned long		flags;
-	struct hcd_dev		*hdev;
 
 	spin_lock_irqsave (&dum->lock, flags);
-	if (dum->udev) {
-		hdev = dum->udev->hcpriv;
-		list_for_each_entry (urb, &hdev->urb_list, urb_list) {
-			size_t		temp;
-
-			temp = show_urb (buf, PAGE_SIZE - size, urb);
-			buf += temp;
-			size += temp;
-		}
+	list_for_each_entry (urbp, &dum->urbp_list, urbp_list) {
+		size_t		temp;
+
+		temp = show_urb (buf, PAGE_SIZE - size, urbp->urb);
+		buf += temp;
+		size += temp;
 	}
 	spin_unlock_irqrestore (&dum->lock, flags);
 
@@ -1642,6 +1652,8 @@
 	dum->timer.function = dummy_timer;
 	dum->timer.data = (unsigned long) dum;
 
+	INIT_LIST_HEAD (&dum->urbp_list);
+
 	root = usb_alloc_dev (0, &hcd->self, 0);
 	if (!root)
 		return -ENOMEM;
@@ -1754,8 +1766,6 @@
 	hcd->self.hcpriv = hcd;
 	hcd->self.bus_name = dev->bus_id;
 	hcd->product_desc = "Dummy host controller";
-
-	INIT_LIST_HEAD (&hcd->dev_list);
 
 	usb_register_bus (&hcd->self);
 

