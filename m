Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161224AbVKSCVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161224AbVKSCVK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 21:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161228AbVKSCVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 21:21:10 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:64749 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161210AbVKSCVG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 21:21:06 -0500
Subject: [RFC][PATCH 7/7]: Use notify call chain mechanism for usb
	notifiication
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: lse-tech@lists.sourceforge.net, stern@rowland.harvard.edu, greg@kroah.com
Content-Type: text/plain
Organization: IBM
Date: Fri, 18 Nov 2005 18:21:04 -0800
Message-Id: <1132366864.9617.20.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since the notifier chain was not protected, usb module was using its own
notifier mechanism which is very similar.

As we fixed the problem, moving usb notifier to use the basic notifier
chain mechanism.

Signed-off-by:  Chandra Seetharaman <sekharan@us.ibm.com>
Signed-off-by:  Alan Stern <stern@rowland.harvard.edu>
-----

 drivers/usb/core/notify.c |   63 +++++-----------------------------------------
 1 files changed, 7 insertions(+), 56 deletions(-)

Index: l2615-rc1-notifiers/drivers/usb/core/notify.c
===================================================================
--- l2615-rc1-notifiers.orig/drivers/usb/core/notify.c
+++ l2615-rc1-notifiers/drivers/usb/core/notify.c
@@ -22,56 +22,7 @@
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
@@ -81,7 +32,7 @@ exit:
  */
 void usb_register_notify(struct notifier_block *nb)
 {
-	usb_notifier_chain_register(&usb_notifier_list, nb);
+	notifier_chain_register(&usb_notifier_list, nb);
 }
 EXPORT_SYMBOL_GPL(usb_register_notify);
 
@@ -94,27 +45,27 @@ EXPORT_SYMBOL_GPL(usb_register_notify);
  */
 void usb_unregister_notify(struct notifier_block *nb)
 {
-	usb_notifier_chain_unregister(&usb_notifier_list, nb);
+	notifier_chain_unregister(&usb_notifier_list, nb);
 }
 EXPORT_SYMBOL_GPL(usb_unregister_notify);
 
 
 void usb_notify_add_device(struct usb_device *udev)
 {
-	usb_notifier_call_chain(&usb_notifier_list, USB_DEVICE_ADD, udev);
+	notifier_call_chain(&usb_notifier_list, USB_DEVICE_ADD, udev);
 }
 
 void usb_notify_remove_device(struct usb_device *udev)
 {
-	usb_notifier_call_chain(&usb_notifier_list, USB_DEVICE_REMOVE, udev);
+	notifier_call_chain(&usb_notifier_list, USB_DEVICE_REMOVE, udev);
 }
 
 void usb_notify_add_bus(struct usb_bus *ubus)
 {
-	usb_notifier_call_chain(&usb_notifier_list, USB_BUS_ADD, ubus);
+	notifier_call_chain(&usb_notifier_list, USB_BUS_ADD, ubus);
 }
 
 void usb_notify_remove_bus(struct usb_bus *ubus)
 {
-	usb_notifier_call_chain(&usb_notifier_list, USB_BUS_REMOVE, ubus);
+	notifier_call_chain(&usb_notifier_list, USB_BUS_REMOVE, ubus);
 }

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


