Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263233AbTEMGsW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 02:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263246AbTEMGsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 02:48:22 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:10730 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263233AbTEMGsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 02:48:20 -0400
Date: Tue, 13 May 2003 02:26:40 -0400
From: Ben Collins <bcollins@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Make KOBJ_NAME_LEN match BUS_ID_SIZE
Message-ID: <20030513062640.GR433@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was causing me all sorts of problems with linux1394's 16-18 byte
long bus_id lengths. The sysfs names were all broken.

This not only makes KOBJ_NAME_LEN match BUS_ID_SIZE, but fixes the
strncpy's in drivers/base/ so that it can't happen again (atleast the
strings will be null terminated).

Index: include/linux/kobject.h
===================================================================
RCS file: /home/scm/linux-2.5/include/linux/kobject.h,v
retrieving revision 1.11
diff -u -r1.11 kobject.h
--- include/linux/kobject.h	12 Apr 2003 01:04:46 -0000	1.11
+++ include/linux/kobject.h	13 May 2003 06:56:30 -0000
@@ -12,7 +12,7 @@
 #include <linux/rwsem.h>
 #include <asm/atomic.h>
 
-#define KOBJ_NAME_LEN	16
+#define KOBJ_NAME_LEN	20
 
 struct kobject {
 	char			name[KOBJ_NAME_LEN];
Index: drivers/base/bus.c
===================================================================
RCS file: /home/scm/linux-2.5/drivers/base/bus.c,v
retrieving revision 1.24
diff -u -r1.24 bus.c
--- drivers/base/bus.c	29 Apr 2003 17:30:20 -0000	1.24
+++ drivers/base/bus.c	13 May 2003 06:56:30 -0000
@@ -432,6 +432,7 @@
 		pr_debug("bus %s: add driver %s\n",bus->name,drv->name);
 
 		strncpy(drv->kobj.name,drv->name,KOBJ_NAME_LEN);
+		drv->kobj.name[KOBJ_NAME_LEN-1] = '\0';
 		drv->kobj.kset = &bus->drivers;
 
 		if ((error = kobject_register(&drv->kobj))) {
@@ -541,6 +542,7 @@
 int bus_register(struct bus_type * bus)
 {
 	strncpy(bus->subsys.kset.kobj.name,bus->name,KOBJ_NAME_LEN);
+	bus->subsys.kset.kobj.name[KOBJ_NAME_LEN-1] = '\0';
 	subsys_set_kset(bus,bus_subsys);
 	subsystem_register(&bus->subsys);
 
Index: drivers/base/class.c
===================================================================
RCS file: /home/scm/linux-2.5/drivers/base/class.c,v
retrieving revision 1.18
diff -u -r1.18 class.c
--- drivers/base/class.c	11 May 2003 05:00:57 -0000	1.18
+++ drivers/base/class.c	13 May 2003 06:56:30 -0000
@@ -89,6 +89,7 @@
 	INIT_LIST_HEAD(&cls->interfaces);
 	
 	strncpy(cls->subsys.kset.kobj.name,cls->name,KOBJ_NAME_LEN);
+	cls->subsys.kset.kobj.name[KOBJ_NAME_LEN-1] = '\0';
 	subsys_set_kset(cls,class_subsys);
 	subsystem_register(&cls->subsys);
 
@@ -259,6 +260,7 @@
 
 	/* first, register with generic layer. */
 	strncpy(class_dev->kobj.name, class_dev->class_id, KOBJ_NAME_LEN);
+	class_dev->kobj.name[KOBJ_NAME_LEN-1] = '\0';
 	kobj_set_kset_s(class_dev, class_obj_subsys);
 	if (parent)
 		class_dev->kobj.parent = &parent->subsys.kset.kobj;
Index: drivers/base/core.c
===================================================================
RCS file: /home/scm/linux-2.5/drivers/base/core.c,v
retrieving revision 1.43
diff -u -r1.43 core.c
--- drivers/base/core.c	29 Apr 2003 17:30:20 -0000	1.43
+++ drivers/base/core.c	13 May 2003 06:56:30 -0000
@@ -214,6 +214,7 @@
 
 	/* first, register with generic layer. */
 	strncpy(dev->kobj.name,dev->bus_id,KOBJ_NAME_LEN);
+	dev->kobj.name[KOBJ_NAME_LEN-1] = '\0';
 	kobj_set_kset_s(dev,devices_subsys);
 	if (parent)
 		dev->kobj.parent = &parent->kobj;
