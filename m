Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbTEYAl5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 20:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbTEYAl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 20:41:57 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:52883 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261245AbTEYAlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 20:41:55 -0400
Date: Sat, 24 May 2003 20:07:01 -0400
From: Ben Collins <bcollins@debian.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Resend [PATCH] Make KOBJ_NAME_LEN match BUS_ID_SIZE
Message-ID: <20030525000701.GG504@phunnypharm.org>
References: <20030513071412.GS433@phunnypharm.org> <Pine.LNX.4.44.0305130808040.9816-100000@cherise> <20030516002059.GE433@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030516002059.GE433@phunnypharm.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Given that the problem with KOBJ_NAME_LEN == 20 affecting one snd driver
has so far only been explained as a compiler bug, can I suggest this
patch be applied? Even aside from the KOBJ_NAME_LEN == 20, the snprintf
changes will keep things from breaking in other ways that are current
now.


Index: include/linux/kobject.h
===================================================================
--- include/linux/kobject.h	(revision 10014)
+++ include/linux/kobject.h	(working copy)
@@ -12,7 +12,7 @@
 #include <linux/rwsem.h>
 #include <asm/atomic.h>
 
-#define KOBJ_NAME_LEN	16
+#define KOBJ_NAME_LEN	20
 
 struct kobject {
 	char			name[KOBJ_NAME_LEN];
Index: drivers/base/class.c
===================================================================
--- drivers/base/class.c	(revision 10014)
+++ drivers/base/class.c	(working copy)
@@ -87,8 +87,9 @@
 
 	INIT_LIST_HEAD(&cls->children);
 	INIT_LIST_HEAD(&cls->interfaces);
-	
-	strncpy(cls->subsys.kset.kobj.name,cls->name,KOBJ_NAME_LEN);
+
+	snprintf(cls->subsys.kset.kobj.name, KOBJ_NAME_LEN, "%s",
+		 cls->name);
 	subsys_set_kset(cls,class_subsys);
 	subsystem_register(&cls->subsys);
 
@@ -258,7 +259,7 @@
 		 class_dev->class_id);
 
 	/* first, register with generic layer. */
-	strncpy(class_dev->kobj.name, class_dev->class_id, KOBJ_NAME_LEN);
+	snprintf(class_dev->kobj.name, KOBJ_NAME_LEN, "%s", class_dev->class_id);
 	kobj_set_kset_s(class_dev, class_obj_subsys);
 	if (parent)
 		class_dev->kobj.parent = &parent->subsys.kset.kobj;
Index: drivers/base/core.c
===================================================================
--- drivers/base/core.c	(revision 10014)
+++ drivers/base/core.c	(working copy)
@@ -211,7 +211,7 @@
 		 dev->bus_id, dev->name);
 
 	/* first, register with generic layer. */
-	strncpy(dev->kobj.name,dev->bus_id,KOBJ_NAME_LEN);
+	snprintf(dev->kobj.name, KOBJ_NAME_LEN, "%s", dev->bus_id);
 	if (parent)
 		dev->kobj.parent = &parent->kobj;
 
Index: drivers/base/bus.c
===================================================================
--- drivers/base/bus.c	(revision 10014)
+++ drivers/base/bus.c	(working copy)
@@ -431,7 +431,7 @@
 	if (bus) {
 		pr_debug("bus %s: add driver %s\n",bus->name,drv->name);
 
-		strncpy(drv->kobj.name,drv->name,KOBJ_NAME_LEN);
+		snprintf(drv->kobj.name, KOBJ_NAME_LEN, "%s", drv->name);
 		drv->kobj.kset = &bus->drivers;
 
 		if ((error = kobject_register(&drv->kobj))) {
@@ -540,7 +540,8 @@
  */
 int bus_register(struct bus_type * bus)
 {
-	strncpy(bus->subsys.kset.kobj.name,bus->name,KOBJ_NAME_LEN);
+	snprintf(bus->subsys.kset.kobj.name, KOBJ_NAME_LEN, "%s",
+		 bus->name);
 	subsys_set_kset(bus,bus_subsys);
 	subsystem_register(&bus->subsys);
 
