Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263883AbTKLREM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 12:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263890AbTKLREM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 12:04:12 -0500
Received: from ida.rowland.org ([192.131.102.52]:21508 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S263883AbTKLRED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 12:04:03 -0500
Date: Wed, 12 Nov 2003 12:04:02 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Greg KH <greg@kroah.com>, Patrick Mochel <mochel@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: PATCH: (as132) Improve documentation for kobjects
Message-ID: <Pine.LNX.4.44L0.0311121159030.939-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg and Patrick:

Here is a suggested amendment to Documentation/kobject.h.  Please check it 
for accuracy and tell me if you think it could be improved at all.

Alan Stern


===== kobject.txt 1.9 vs edited =====
--- 1.9/Documentation/kobject.txt	Sat Sep  6 08:08:47 2003
+++ edited/Documentation/kobject.txt	Wed Nov 12 11:33:55 2003
@@ -2,7 +2,7 @@
 
 Patrick Mochel <mochel@osdl.org>
 
-Updated: 3 June 2003
+Updated: 12 November 2003
 
 
 Copyright (c)  2003 Patrick Mochel
@@ -128,7 +128,33 @@
 (like the networking layer). 
 
 
-1.4 sysfs
+1.4 Order dependencies
+
+Fields in a kobject must be initialized before they are used, as 
+indicated in this table:
+
+	k_name		Before kobject_add() (1)
+	name		Before kobject_add() (1)
+	refcount	Before kobject_init() (2)
+	entry		Set by kobject_init()
+	parent		Before kobject_add() (3)
+	kset		Before kobject_init() (4)
+	ktype		Before kobject_add() (4)
+	dentry		Set by kobject_add()
+
+(1) If k_name isn't already set when kobject_add() is called,
+it will be set to name.
+
+(2) Although kobject_init() sets refcount to 1, a warning will be logged
+if refcount is not equal to 0 beforehand.
+
+(3) If parent isn't already set when kobject_add() is called,
+it will be set to kset's embedded kobject.
+
+(4) kset and ktype are optional. If they are used, they should be set
+at the times indicated.
+
+1.5 sysfs
 
 Each kobject receives a directory in sysfs. This directory is created
 under the kobject's parent directory. 
@@ -210,7 +236,25 @@
 name. The kobject, if found, is returned. 
 
 
-2.3 sysfs
+2.3 Order dependencies
+
+Fields in a kset must be initialized before they are used, as indicated
+in this table:
+
+	subsys		Before kset_add()
+	ktype		Before kset_add() (1)
+	list		Set by kset_init()
+	kobj		Before kset_init() (2)
+	hotplug_ops	Before kset_add() (1)
+
+(1) ktype and hotplug_ops are optional. If they are used, they should
+be set at the times indicated.
+
+(2) kobj is passed to kobject_init() during kset_init() and to
+kobject_add() during kset_add(); it must initialized accordingly.
+
+
+2.4 sysfs
 
 ksets are represented in sysfs when their embedded kobjects are
 registered. They follow the same rules of parenting, with one
@@ -352,7 +396,21 @@
 - Sets obj->subsys.kset.kobj.kset to the subsystem's embedded kset.
 
 
-4.4 sysfs
+4.4 Order dependencies
+
+Fields in a subsystem must be initialized before they are used,
+as indicated in this table:
+
+	kset		Before subsystem_register() (1)
+	rwsem		Set by subsystem_register()
+
+(1) kset is minimally initialized by the decl_subsys macro. It is
+passed to kset_init() and kset_add() by subsystem_register(). If its
+subsys member isn't already set, subsystem_register() sets it to the
+containing subsystem.
+
+
+4.5 sysfs
 
 subsystems are represented in sysfs via their embedded kobjects. They
 follow the same rules as previously mentioned with no exceptions. They

