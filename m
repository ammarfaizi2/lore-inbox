Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965010AbWIKT72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbWIKT72 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 15:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965008AbWIKT72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 15:59:28 -0400
Received: from mout0.freenet.de ([194.97.50.131]:52636 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S965010AbWIKT72 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 15:59:28 -0400
Date: Mon, 11 Sep 2006 22:07:23 +0200
To: "Greg KH" <greg@kroah.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] class.c: added class_create_attrs() function
Reply-To: balagi@justmail.de
From: "Thomas Maier" <balagi@justmail.de>
Content-Type: text/plain; charset=US-ASCII
Message-ID: <op.tfqcrka5iudtyh@master>
User-Agent: Opera Mail/9.00 (Win32)
MIME-Version: 1.0
References: <op.tfkmp60biudtyh@master> <20060908210042.GA6877@kroah.com> <4501E33B.50204@cfl.rr.com> <20060908220129.GB20018@kroah.com> <op.tfmh56j9iudtyh@master> <20060909213054.GC19188@kroah.com>
In-Reply-To: <20060909213054.GC19188@kroah.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this is a patch based on linux 2.6.18-rc6.
It adds a class_create_attrs() function in
drivers/base/class.c .
This new function works similar to class_create(),
but also allows to create the class attribute files
(if any) during class creation.

-Thomas Maier


diff -urpN linux-2.6.18-rc6/drivers/base/class.c patch/drivers/base/class.c
--- linux-2.6.18-rc6/drivers/base/class.c	2006-09-11 21:45:12.000000000 +0200
+++ patch/drivers/base/class.c	2006-09-11 21:52:06.000000000 +0200
@@ -199,6 +199,18 @@ static int class_device_create_uevent(st
   */
  struct class *class_create(struct module *owner, char *name)
  {
+	return class_create_attrs(owner, name, NULL);
+}
+/**
+ * class_create_attrs - similar to class_create(), but can also
+ * create class attribute files on class creation.
+ * @owner: pointer to the module that is to "own" this struct class
+ * @name: pointer to a string for the name of this class.
+ * @cls_attrs: pointer to a class_attribute array.
+ */
+struct class *class_create_attrs(struct module *owner, char *name,
+				struct class_attribute *cls_attrs)
+{
  	struct class *cls;
  	int retval;

@@ -212,6 +224,7 @@ struct class *class_create(struct module
  	cls->owner = owner;
  	cls->class_release = class_create_release;
  	cls->release = class_device_create_release;
+	cls->class_attrs = cls_attrs;

  	retval = class_register(cls);
  	if (retval)
@@ -900,6 +913,7 @@ EXPORT_SYMBOL_GPL(class_remove_file);
  EXPORT_SYMBOL_GPL(class_register);
  EXPORT_SYMBOL_GPL(class_unregister);
  EXPORT_SYMBOL_GPL(class_create);
+EXPORT_SYMBOL_GPL(class_create_attrs);
  EXPORT_SYMBOL_GPL(class_destroy);

  EXPORT_SYMBOL_GPL(class_device_register);
diff -urpN linux-2.6.18-rc6/include/linux/device.h patch/include/linux/device.h
--- linux-2.6.18-rc6/include/linux/device.h	2006-09-11 21:53:10.000000000 +0200
+++ patch/include/linux/device.h	2006-09-11 21:54:21.000000000 +0200
@@ -272,6 +272,8 @@ extern int class_interface_register(stru
  extern void class_interface_unregister(struct class_interface *);

  extern struct class *class_create(struct module *owner, char *name);
+extern struct class *class_create_attrs(struct module *owner, char *name,
+					struct class_attribute *cls_attrs);
  extern void class_destroy(struct class *cls);
  extern struct class_device *class_device_create(struct class *cls,
  						struct class_device *parent,
