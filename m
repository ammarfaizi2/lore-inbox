Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVAHF7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVAHF7X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 00:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVAHF7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 00:59:22 -0500
Received: from mail.kroah.org ([69.55.234.183]:17797 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261799AbVAHFrz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:47:55 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <1105163268738@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:48 -0800
Message-Id: <1105163268388@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.43, 2004/12/20 14:19:38-08:00, stern@rowland.harvard.edu

[PATCH] USB: Create usb_hcd structures within usbcore [4/13]

This patch alters the UHCI driver, removing the routine that allocates the
hcd structure and introducing inline functions to convert safely between
the public and private hcd structures.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/host/uhci-hcd.c |   23 +++++------------------
 drivers/usb/host/uhci-hcd.h |   16 ++++++++++++----
 2 files changed, 17 insertions(+), 22 deletions(-)


diff -Nru a/drivers/usb/host/uhci-hcd.c b/drivers/usb/host/uhci-hcd.c
--- a/drivers/usb/host/uhci-hcd.c	2005-01-07 15:43:29 -08:00
+++ b/drivers/usb/host/uhci-hcd.c	2005-01-07 15:43:29 -08:00
@@ -1891,7 +1891,7 @@
 	uhci->state_end = jiffies + HZ;
 	outw(USBCMD_RS | USBCMD_CF | USBCMD_MAXP, io_addr + USBCMD);
 
-        uhci->hcd.state = USB_STATE_RUNNING;
+        uhci_to_hcd(uhci)->state = USB_STATE_RUNNING;
 	return 0;
 }
 
@@ -2151,7 +2151,7 @@
 
 	udev->speed = USB_SPEED_FULL;
 
-	if (hcd_register_root(udev, &uhci->hcd) != 0) {
+	if (hcd_register_root(udev, hcd) != 0) {
 		dev_err(uhci_dev(uhci), "unable to start root hub\n");
 		retval = -ENOMEM;
 		goto err_start_root_hub;
@@ -2277,24 +2277,11 @@
 		if ((rc = start_hc(uhci)) != 0)
 			return rc;
 	}
-	uhci->hcd.state = USB_STATE_RUNNING;
+	hcd->state = USB_STATE_RUNNING;
 	return 0;
 }
 #endif
 
-static struct usb_hcd *uhci_hcd_alloc(void)
-{
-	struct uhci_hcd *uhci;
-
-	uhci = (struct uhci_hcd *)kmalloc(sizeof(*uhci), GFP_KERNEL);
-	if (!uhci)
-		return NULL;
-
-	memset(uhci, 0, sizeof(*uhci));
-	uhci->hcd.product_desc = "UHCI Host Controller";
-	return &uhci->hcd;
-}
-
 /* Wait until all the URBs for a particular device/endpoint are gone */
 static void uhci_hcd_endpoint_disable(struct usb_hcd *hcd,
 		struct usb_host_endpoint *ep)
@@ -2313,6 +2300,8 @@
 
 static const struct hc_driver uhci_driver = {
 	.description =		hcd_name,
+	.product_desc =		"UHCI Host Controller",
+	.hcd_priv_size =	sizeof(struct uhci_hcd),
 
 	/* Generic hardware linkage */
 	.irq =			uhci_irq,
@@ -2326,8 +2315,6 @@
 	.resume =		uhci_resume,
 #endif
 	.stop =			uhci_stop,
-
-	.hcd_alloc =		uhci_hcd_alloc,
 
 	.urb_enqueue =		uhci_urb_enqueue,
 	.urb_dequeue =		uhci_urb_dequeue,
diff -Nru a/drivers/usb/host/uhci-hcd.h b/drivers/usb/host/uhci-hcd.h
--- a/drivers/usb/host/uhci-hcd.h	2005-01-07 15:43:29 -08:00
+++ b/drivers/usb/host/uhci-hcd.h	2005-01-07 15:43:29 -08:00
@@ -314,9 +314,6 @@
 	UHCI_RESUMING_2
 };
 
-#define hcd_to_uhci(hcd_ptr) container_of(hcd_ptr, struct uhci_hcd, hcd)
-#define uhci_dev(u)	((u)->hcd.self.controller)
-
 /*
  * This describes the full uhci information.
  *
@@ -324,7 +321,6 @@
  * a subset of what the full implementation needs.
  */
 struct uhci_hcd {
-	struct usb_hcd hcd;		/* must come first! */
 
 #ifdef CONFIG_PROC_FS
 	/* procfs */
@@ -382,6 +378,18 @@
 
 	wait_queue_head_t waitqh;		/* endpoint_disable waiters */
 };
+
+/* Convert between a usb_hcd pointer and the corresponding uhci_hcd */
+static inline struct uhci_hcd *hcd_to_uhci(struct usb_hcd *hcd)
+{
+	return (struct uhci_hcd *) (hcd->hcd_priv);
+}
+static inline struct usb_hcd *uhci_to_hcd(struct uhci_hcd *uhci)
+{
+	return container_of((void *) uhci, struct usb_hcd, hcd_priv);
+}
+
+#define uhci_dev(u)	(uhci_to_hcd(u)->self.controller)
 
 struct urb_priv {
 	struct list_head urb_list;

