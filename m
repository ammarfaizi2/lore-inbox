Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262625AbVCJBTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbVCJBTR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 20:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbVCJBSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:18:21 -0500
Received: from mail.kroah.org ([69.55.234.183]:52127 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262622AbVCJAm3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:29 -0500
Cc: kay.sievers@vrfy.org
Subject: [PATCH] class_simple: pass dev_t to the class core
In-Reply-To: <11104148811634@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:34:41 -0800
Message-Id: <1110414881502@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2041, 2005/03/09 09:33:17-08:00, kay.sievers@vrfy.org

[PATCH] class_simple: pass dev_t to the class core

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/class_simple.c |   21 ++-------------------
 1 files changed, 2 insertions(+), 19 deletions(-)


diff -Nru a/drivers/base/class_simple.c b/drivers/base/class_simple.c
--- a/drivers/base/class_simple.c	2005-03-09 16:29:41 -08:00
+++ b/drivers/base/class_simple.c	2005-03-09 16:29:41 -08:00
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
@@ -35,12 +32,6 @@
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
@@ -75,12 +66,6 @@
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
@@ -143,7 +128,7 @@
 	}
 	memset(s_dev, 0x00, sizeof(*s_dev));
 
-	s_dev->dev = dev;
+	s_dev->class_dev.devt = dev;
 	s_dev->class_dev.dev = device;
 	s_dev->class_dev.class = &cs->class;
 
@@ -154,8 +139,6 @@
 	if (retval)
 		goto error;
 
-	class_device_create_file(&s_dev->class_dev, &cs->attr);
-
 	spin_lock(&simple_dev_list_lock);
 	list_add(&s_dev->node, &simple_dev_list);
 	spin_unlock(&simple_dev_list_lock);
@@ -200,7 +183,7 @@
 
 	spin_lock(&simple_dev_list_lock);
 	list_for_each_entry(s_dev, &simple_dev_list, node) {
-		if (s_dev->dev == dev) {
+		if (s_dev->class_dev.devt == dev) {
 			found = 1;
 			break;
 		}

