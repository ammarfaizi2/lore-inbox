Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbVEEG5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbVEEG5b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 02:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVEEG5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 02:57:31 -0400
Received: from mail.kroah.org ([69.55.234.183]:19110 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261910AbVEEG5T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 02:57:19 -0400
Cc: rkagan@mail.ru
Subject: [PATCH] drivers/base/bus.c: fix iteration in driver_detach()
In-Reply-To: <11152762214193@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 May 2005 23:57:01 -0700
Message-Id: <11152762211382@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] drivers/base/bus.c: fix iteration in driver_detach()

With 2.6.11 and 2.6.12-rc2 (and perhaps a few versions before) usb
drivers for multi-interface devices, which do
usb_driver_release_interface() in their disconnect(), make rmmod hang.

It turns out to be due to a bug in drivers/base/bus.c:driver_detach(),
that iterates over the list of attached devices with
list_for_each_safe() under an assumption that device_release_driver()
only releases the current device, while it may also call
device_release_driver() for other devices on the same list.

The following patch fixes it.  Please consider applying.

Signed-off-by: Roman Kagan <rkagan@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit b2d84f078a8be40f5ae3b4d2ac001e2a7f45fe4f
tree 173f941991f1b68da820e9926a3b7ebdd3a2c8b9
parent 177a4324944478f2799ce4ede2797cb0f602f274
author Roman Kagan <rkagan@mail.ru> 1113414017 +0400
committer Greg KH <gregkh@suse.de> 1115275478 -0700

Index: drivers/base/bus.c
===================================================================
--- cc42dcdbce1c3b53ea147abd3ebf784f0d2bf1bc/drivers/base/bus.c  (mode:100644 sha1:f4fa27315fb4b69841ecf2a551d58d9a241c5546)
+++ 173f941991f1b68da820e9926a3b7ebdd3a2c8b9/drivers/base/bus.c  (mode:100644 sha1:2b3902c867dab76cf5b9b9d65d1778be20ac20e1)
@@ -405,9 +405,8 @@
 
 static void driver_detach(struct device_driver * drv)
 {
-	struct list_head * entry, * next;
-	list_for_each_safe(entry, next, &drv->devices) {
-		struct device * dev = container_of(entry, struct device, driver_list);
+	while (!list_empty(&drv->devices)) {
+		struct device * dev = container_of(drv->devices.next, struct device, driver_list);
 		device_release_driver(dev);
 	}
 }

