Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030398AbWARQi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030398AbWARQi4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 11:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030400AbWARQiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 11:38:55 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:22456 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1030395AbWARQiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 11:38:55 -0500
Date: Wed, 18 Jan 2006 11:38:54 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: Chandra Seetharaman <sekharan@us.ibm.com>, Keith Owens <kaos@sgi.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/8] Notifier chain update
Message-ID: <Pine.LNX.4.44L0.0601181125470.4632-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Notifier chain re-implementation (as638): Remove the notifier code
used by the USB core and switch it over to the new standard API.
There's no longer any need for the special USB code because the new
API is protected.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Chandra Seetharaman <sekharan@us.ibm.com>

---

Index: l2616/drivers/usb/core/notify.c
===================================================================
--- l2616.orig/drivers/usb/core/notify.c
+++ l2616/drivers/usb/core/notify.c
@@ -16,56 +16,7 @@
 #include "usb.h"
 
 
-static struct notifier_block *usb_notifier_list;
-static DECLARE_MUTEX(usb_notifier_lock);
-
-static void usb_notifier_chain_register(struct notifier_block **list,
-					struct notifier_block *n)
-{
-	down(&usb_notifier_lock);
-	while (*list) {
-		if (n->priority > (*list)->priority)
-			break;
-		list = &((*list)->next);
-	}
-	n->next = *list;
-	*list = n;
-	up(&usb_notifier_lock);
-}
-
-static void usb_notifier_chain_unregister(struct notifier_block **nl,
-				   struct notifier_block *n)
-{
-	down(&usb_notifier_lock);
-	while ((*nl)!=NULL) {
-		if ((*nl)==n) {
-			*nl = n->next;
-			goto exit;
-		}
-		nl=&((*nl)->next);
-	}
-exit:
-	up(&usb_notifier_lock);
-}
-
-static int usb_notifier_call_chain(struct notifier_block **n,
-				   unsigned long val, void *v)
-{
-	int ret=NOTIFY_DONE;
-	struct notifier_block *nb = *n;
-
-	down(&usb_notifier_lock);
-	while (nb) {
-		ret = nb->notifier_call(nb,val,v);
-		if (ret&NOTIFY_STOP_MASK) {
-			goto exit;
-		}
-		nb = nb->next;
-	}
-exit:
-	up(&usb_notifier_lock);
-	return ret;
-}
+static BLOCKING_NOTIFIER_HEAD(usb_notifier_list);
 
 /**
  * usb_register_notify - register a notifier callback whenever a usb change happens
@@ -75,7 +26,7 @@ exit:
  */
 void usb_register_notify(struct notifier_block *nb)
 {
-	usb_notifier_chain_register(&usb_notifier_list, nb);
+	blocking_notifier_chain_register(&usb_notifier_list, nb);
 }
 EXPORT_SYMBOL_GPL(usb_register_notify);
 
@@ -88,27 +39,28 @@ EXPORT_SYMBOL_GPL(usb_register_notify);
  */
 void usb_unregister_notify(struct notifier_block *nb)
 {
-	usb_notifier_chain_unregister(&usb_notifier_list, nb);
+	blocking_notifier_chain_unregister(&usb_notifier_list, nb);
 }
 EXPORT_SYMBOL_GPL(usb_unregister_notify);
 
 
 void usb_notify_add_device(struct usb_device *udev)
 {
-	usb_notifier_call_chain(&usb_notifier_list, USB_DEVICE_ADD, udev);
+	blocking_notifier_call_chain(&usb_notifier_list, USB_DEVICE_ADD, udev);
 }
 
 void usb_notify_remove_device(struct usb_device *udev)
 {
-	usb_notifier_call_chain(&usb_notifier_list, USB_DEVICE_REMOVE, udev);
+	blocking_notifier_call_chain(&usb_notifier_list,
+			USB_DEVICE_REMOVE, udev);
 }
 
 void usb_notify_add_bus(struct usb_bus *ubus)
 {
-	usb_notifier_call_chain(&usb_notifier_list, USB_BUS_ADD, ubus);
+	blocking_notifier_call_chain(&usb_notifier_list, USB_BUS_ADD, ubus);
 }
 
 void usb_notify_remove_bus(struct usb_bus *ubus)
 {
-	usb_notifier_call_chain(&usb_notifier_list, USB_BUS_REMOVE, ubus);
+	blocking_notifier_call_chain(&usb_notifier_list, USB_BUS_REMOVE, ubus);
 }


