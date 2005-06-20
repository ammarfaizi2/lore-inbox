Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbVFUC4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbVFUC4W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbVFUCzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:55:11 -0400
Received: from mail.kroah.org ([69.55.234.183]:12772 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261668AbVFTW7i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:38 -0400
Cc: stern@rowland.harvard.edu
Subject: [PATCH] usbcore: Don't call device_release_driver recursively
In-Reply-To: <1119308367735@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:27 -0700
Message-Id: <1119308367477@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] usbcore: Don't call device_release_driver recursively

This patch fixes usb_driver_release_interface() to make it avoid calling
device_release_driver() recursively, i.e., when invoked from within the
disconnect routine for the same device.  The patch applies to your
"driver" tree.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit f409661877a25d11c2495bcd879807f17c286684
tree ce14b7c16191af662d087c9be4a3fcbe642a63af
parent c95a6b057b108c2b7add35cba1354f9af921349e
author Alan Stern <stern@rowland.harvard.edu> Fri, 06 May 2005 15:41:08 -0400
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:29 -0700

 drivers/usb/core/usb.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -322,9 +322,15 @@ void usb_driver_release_interface(struct
 	if (!dev->driver || dev->driver != &driver->driver)
 		return;
 
-	/* don't disconnect from disconnect(), or before dev_add() */
-	if (!klist_node_attached(&dev->knode_driver) && !klist_node_attached(&dev->knode_bus))
+	/* don't release from within disconnect() */
+	if (iface->condition != USB_INTERFACE_BOUND)
+		return;
+
+	/* release only after device_add() */
+	if (klist_node_attached(&dev->knode_bus)) {
+		iface->condition = USB_INTERFACE_UNBINDING;
 		device_release_driver(dev);
+	}
 
 	dev->driver = NULL;
 	usb_set_intfdata(iface, NULL);

