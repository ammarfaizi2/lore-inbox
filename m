Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265514AbUBIXiG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265511AbUBIXbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:31:38 -0500
Received: from mail.kroah.org ([65.200.24.183]:32447 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265369AbUBIX3N convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:29:13 -0500
Subject: Re: [PATCH] Driver Core update for 2.6.3-rc1
In-Reply-To: <10763691411179@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 9 Feb 2004 15:25:41 -0800
Message-Id: <10763691411242@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1607, 2004/02/09 14:01:07-08:00, greg@kroah.com

Driver Core: fix up list_for_each() calls to list_for_each_entry()

Now this should get that Rusty^Wmonkey off my back...


 drivers/base/class.c        |   25 +++++++------------------
 drivers/base/class_simple.c |    4 +---
 2 files changed, 8 insertions(+), 21 deletions(-)


diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	Mon Feb  9 15:08:55 2004
+++ b/drivers/base/class.c	Mon Feb  9 15:08:55 2004
@@ -3,8 +3,8 @@
  *
  * Copyright (c) 2002-3 Patrick Mochel
  * Copyright (c) 2002-3 Open Source Development Labs
- * Copyright (c) 2003 Greg Kroah-Hartman
- * Copyright (c) 2003 IBM Corp.
+ * Copyright (c) 2003-2004 Greg Kroah-Hartman
+ * Copyright (c) 2003-2004 IBM Corp.
  * 
  * This file is released under the GPLv2
  *
@@ -278,7 +278,6 @@
 {
 	struct class * parent;
 	struct class_interface * class_intf;
-	struct list_head * entry;
 	int error;
 
 	class_dev = class_device_get(class_dev);
@@ -302,11 +301,9 @@
 	if (parent) {
 		down_write(&parent->subsys.rwsem);
 		list_add_tail(&class_dev->node, &parent->children);
-		list_for_each(entry, &parent->interfaces) {
-			class_intf = container_of(entry, struct class_interface, node);
+		list_for_each_entry(class_intf, &parent->interfaces, node)
 			if (class_intf->add)
 				class_intf->add(class_dev);
-		}
 		up_write(&parent->subsys.rwsem);
 	}
 
@@ -330,16 +327,13 @@
 {
 	struct class * parent = class_dev->class;
 	struct class_interface * class_intf;
-	struct list_head * entry;
 
 	if (parent) {
 		down_write(&parent->subsys.rwsem);
 		list_del_init(&class_dev->node);
-		list_for_each(entry, &parent->interfaces) {
-			class_intf = container_of(entry, struct class_interface, node);
+		list_for_each_entry(class_intf, &parent->interfaces, node)
 			if (class_intf->remove)
 				class_intf->remove(class_dev);
-		}
 		up_write(&parent->subsys.rwsem);
 	}
 
@@ -395,7 +389,6 @@
 {
 	struct class * parent;
 	struct class_device * class_dev;
-	struct list_head * entry;
 
 	if (!class_intf || !class_intf->class)
 		return -ENODEV;
@@ -408,10 +401,8 @@
 	list_add_tail(&class_intf->node, &parent->interfaces);
 
 	if (class_intf->add) {
-		list_for_each(entry, &parent->children) {
-			class_dev = container_of(entry, struct class_device, node);
+		list_for_each_entry(class_dev, &parent->children, node)
 			class_intf->add(class_dev);
-		}
 	}
 	up_write(&parent->subsys.rwsem);
 
@@ -421,7 +412,7 @@
 void class_interface_unregister(struct class_interface *class_intf)
 {
 	struct class * parent = class_intf->class;
-	struct list_head * entry;
+	struct class_device *class_dev;
 
 	if (!parent)
 		return;
@@ -430,10 +421,8 @@
 	list_del_init(&class_intf->node);
 
 	if (class_intf->remove) {
-		list_for_each(entry, &parent->children) {
-			struct class_device *class_dev = container_of(entry, struct class_device, node);
+		list_for_each_entry(class_dev, &parent->children, node)
 			class_intf->remove(class_dev);
-		}
 	}
 	up_write(&parent->subsys.rwsem);
 
diff -Nru a/drivers/base/class_simple.c b/drivers/base/class_simple.c
--- a/drivers/base/class_simple.c	Mon Feb  9 15:08:55 2004
+++ b/drivers/base/class_simple.c	Mon Feb  9 15:08:55 2004
@@ -197,12 +197,10 @@
 void class_simple_device_remove(dev_t dev)
 {
 	struct simple_dev *s_dev = NULL;
-	struct list_head *tmp;
 	int found = 0;
 
 	spin_lock(&simple_dev_list_lock);
-	list_for_each(tmp, &simple_dev_list) {
-		s_dev = list_entry(tmp, struct simple_dev, node);
+	list_for_each_entry(s_dev, &simple_dev_list, node) {
 		if (s_dev->dev == dev) {
 			found = 1;
 			break;

