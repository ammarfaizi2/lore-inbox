Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262635AbUKXNHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbUKXNHs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 08:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbUKXNF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 08:05:56 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:28820 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262635AbUKXNAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:00:35 -0500
Subject: Suspend2 merge: 2/51: Find class by name
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101292784.5805.194.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 24 Nov 2004 23:56:57 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A second patch that shouldn't be needed but is at the moment. It is used
to find any framebuffer drivers and add put them in the kept-alive
device tree. Once Pavel's improvements to the PM_ states are merged, I
hope this will be able to go away.

Not sure if would be helpful elsewhere?

diff -ruN 207-find-class-by-name-old/drivers/base/class.c 207-find-class-by-name-new/drivers/base/class.c
--- 207-find-class-by-name-old/drivers/base/class.c	2004-11-24 09:52:56.000000000 +1100
+++ 207-find-class-by-name-new/drivers/base/class.c	2004-11-24 17:20:21.385685896 +1100
@@ -497,6 +497,25 @@
 	kobject_put(&class_dev->kobj);
 }
 
+struct class * class_find(char * name)
+{
+	struct class * this_class;
+
+	if (!name)
+		return NULL;
+
+	down_read(&class_subsys.rwsem);
+	list_for_each_entry(this_class, &class_subsys.kset.list, subsys.kset.kobj.entry) {
+		if (!(strcmp(this_class->name, name))) {
+			class_get(this_class);
+			up_read(&class_subsys.rwsem);
+			return this_class;
+		}
+	}
+	up_read(&class_subsys.rwsem);
+
+	return NULL;
+}
 
 int class_interface_register(struct class_interface *class_intf)
 {
@@ -579,3 +598,5 @@
 
 EXPORT_SYMBOL_GPL(class_interface_register);
 EXPORT_SYMBOL_GPL(class_interface_unregister);
+
+EXPORT_SYMBOL_GPL(class_find);
diff -ruN 207-find-class-by-name-old/include/linux/device.h 207-find-class-by-name-new/include/linux/device.h
--- 207-find-class-by-name-old/include/linux/device.h	2004-11-24 17:20:41.583615344 +1100
+++ 207-find-class-by-name-new/include/linux/device.h	2004-11-24 17:19:56.510467504 +1100
@@ -164,6 +164,7 @@
 
 extern struct class * class_get(struct class *);
 extern void class_put(struct class *);
+extern struct class * class_find(char * name);
 

 struct class_attribute {


