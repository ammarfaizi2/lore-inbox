Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVAWE0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVAWE0O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 23:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVAWEY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 23:24:29 -0500
Received: from soundwarez.org ([217.160.171.123]:11147 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261210AbVAWEYC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 23:24:02 -0500
Date: Sun, 23 Jan 2005 05:24:01 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 3/7] class_simple: pass dev_t to the class core
Message-ID: <20050123042401.GD9209@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>

===== drivers/base/class_simple.c 1.8 vs edited =====
--- 1.8/drivers/base/class_simple.c	2005-01-21 06:02:15 +01:00
+++ edited/drivers/base/class_simple.c	2005-01-22 16:20:16 +01:00
@@ -10,18 +10,15 @@
 
 #include <linux/config.h>
 #include <linux/device.h>
-#include <linux/kdev_t.h>
 #include <linux/err.h>
 
 struct class_simple {
-	struct class_device_attribute attr;
 	struct class class;
 };
 #define to_class_simple(d) container_of(d, struct class_simple, class)
 
 struct simple_dev {
 	struct list_head node;
-	dev_t dev;
 	struct class_device class_dev;
 };
 #define to_simple_dev(d) container_of(d, struct simple_dev, class_dev)
@@ -35,12 +32,6 @@ static void release_simple_dev(struct cl
 	kfree(s_dev);
 }
 
-static ssize_t show_dev(struct class_device *class_dev, char *buf)
-{
-	struct simple_dev *s_dev = to_simple_dev(class_dev);
-	return print_dev_t(buf, s_dev->dev);
-}
-
 static void class_simple_release(struct class *class)
 {
 	struct class_simple *cs = to_class_simple(class);
@@ -75,12 +66,6 @@ struct class_simple *class_simple_create
 	cs->class.class_release = class_simple_release;
 	cs->class.release = release_simple_dev;
 
-	cs->attr.attr.name = "dev";
-	cs->attr.attr.mode = S_IRUGO;
-	cs->attr.attr.owner = owner;
-	cs->attr.show = show_dev;
-	cs->attr.store = NULL;
-
 	retval = class_register(&cs->class);
 	if (retval)
 		goto error;
@@ -143,7 +128,7 @@ struct class_device *class_simple_device
 	}
 	memset(s_dev, 0x00, sizeof(*s_dev));
 
-	s_dev->dev = dev;
+	s_dev->class_dev.devt = dev;
 	s_dev->class_dev.dev = device;
 	s_dev->class_dev.class = &cs->class;
 
@@ -154,8 +139,6 @@ struct class_device *class_simple_device
 	if (retval)
 		goto error;
 
-	class_device_create_file(&s_dev->class_dev, &cs->attr);
-
 	spin_lock(&simple_dev_list_lock);
 	list_add(&s_dev->node, &simple_dev_list);
 	spin_unlock(&simple_dev_list_lock);
@@ -200,7 +183,7 @@ void class_simple_device_remove(dev_t de
 
 	spin_lock(&simple_dev_list_lock);
 	list_for_each_entry(s_dev, &simple_dev_list, node) {
-		if (s_dev->dev == dev) {
+		if (s_dev->class_dev.devt == dev) {
 			found = 1;
 			break;
 		}

