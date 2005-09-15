Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030365AbVIOGyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030365AbVIOGyS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 02:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030370AbVIOGx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 02:53:56 -0400
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:41584 "HELO
	smtp106.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030357AbVIOGvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 02:51:41 -0400
Message-Id: <20050915064943.124653000.dtor_core@ameritech.net>
References: <20050915064552.836273000.dtor_core@ameritech.net>
Date: Thu, 15 Sep 2005 01:45:55 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@suse.de>,
Kay Sievers <kay.sievers@vrfy.org>,
Vojtech Pavlik <vojtech@suse.cz>,
Hannes Reinecke <hare@suse.de>
Subject: [patch 03/28] Driver core: allow nesting classes
Content-Disposition: inline; filename=nested-classes.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Driver core: allow nesting classes

This will allow unclutter /sys/classes directory, combining
classes related to the same subsystem "under one roof".

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/base/class.c   |    8 +++++++-
 include/linux/device.h |    1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

Index: work/drivers/base/class.c
===================================================================
--- work.orig/drivers/base/class.c
+++ work/drivers/base/class.c
@@ -135,6 +135,7 @@ static void remove_class_attrs(struct cl
 
 int class_register(struct class * cls)
 {
+	struct class *parent;
 	int error;
 
 	pr_debug("device class '%s': registering\n", cls->name);
@@ -146,7 +147,11 @@ int class_register(struct class * cls)
 	if (error)
 		return error;
 
-	subsys_set_kset(cls, class_subsys);
+	parent = class_get(cls->parent);
+	if (parent)
+		subsys_set_kset(cls, parent->subsys);
+	else
+		subsys_set_kset(cls, class_subsys);
 
 	error = subsystem_register(&cls->subsys);
 	if (!error) {
@@ -161,6 +166,7 @@ void class_unregister(struct class * cls
 	pr_debug("device class '%s': unregistering\n", cls->name);
 	remove_class_attrs(cls);
 	subsystem_unregister(&cls->subsys);
+	class_put(cls->parent);
 }
 
 static void class_create_release(struct class *cls)
Index: work/include/linux/device.h
===================================================================
--- work.orig/include/linux/device.h
+++ work/include/linux/device.h
@@ -157,6 +157,7 @@ struct class {
 	struct module		* owner;
 
 	struct subsystem	subsys;
+	struct class		* parent;
 	struct list_head	children;
 	struct list_head	interfaces;
 	struct semaphore	sem;	/* locks both the children and interfaces lists */

