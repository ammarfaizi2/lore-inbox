Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264288AbTEOWwL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 18:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264289AbTEOWwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 18:52:11 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:56907 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264288AbTEOWwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 18:52:08 -0400
Date: Thu, 15 May 2003 16:00:15 -0700
From: Andrew Morton <akpm@digeo.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: 2.5.69-mm5: pccard oops while booting: resolved
Message-Id: <20030515160015.5dfea63f.akpm@digeo.com>
In-Reply-To: <1053037915.569.2.camel@teapot.felipe-alfaro.com>
References: <1052964213.586.3.camel@teapot.felipe-alfaro.com>
	<20030514191735.6fe0998c.akpm@digeo.com>
	<1052998601.726.1.camel@teapot.felipe-alfaro.com>
	<20030515130019.B30619@flint.arm.linux.org.uk>
	<1053004615.586.2.camel@teapot.felipe-alfaro.com>
	<20030515144439.A31491@flint.arm.linux.org.uk>
	<1053037915.569.2.camel@teapot.felipe-alfaro.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 May 2003 23:04:54.0083 (UTC) FILETIME=[65749930:01C31B36]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
>
> The test kernel is
> a 2.5.69-mm5 with the "i8259-shutdown.patch" reverted, plus the above
> patch and your previous "verbose" patch. Attached to this message is the
> new "dmesg" from this patched kernel.
> 
> As I told Andrew, reverting "make-KOBJ_NAME-match-BUS_ID_SIZE.patch"
> solves the oops.

The weird thing is that this patch really doesn't do anything apart from
increasing KOBJ_NAME_LEN from 16 to 20.





From: Ben Collins <bcollins@debian.org>

This was causing me all sorts of problems with linux1394's 16-18 byte long
bus_id lengths.  The sysfs names were all broken.

This not only makes KOBJ_NAME_LEN match BUS_ID_SIZE, but fixes the
strncpy's in drivers/base/ so that it can't happen again (at least the
strings will be null terminated).



 drivers/base/bus.c      |    2 ++
 drivers/base/class.c    |    2 ++
 drivers/base/core.c     |    1 +
 include/linux/device.h  |    2 +-
 include/linux/kobject.h |    2 +-
 5 files changed, 7 insertions(+), 2 deletions(-)

diff -puN drivers/base/bus.c~make-KOBJ_NAME-match-BUS_ID_SIZE drivers/base/bus.c
--- 25/drivers/base/bus.c~make-KOBJ_NAME-match-BUS_ID_SIZE	2003-05-14 19:18:09.000000000 -0700
+++ 25-akpm/drivers/base/bus.c	2003-05-14 19:18:09.000000000 -0700
@@ -432,6 +432,7 @@ int bus_add_driver(struct device_driver 
 		pr_debug("bus %s: add driver %s\n",bus->name,drv->name);
 
 		strncpy(drv->kobj.name,drv->name,KOBJ_NAME_LEN);
+		drv->kobj.name[KOBJ_NAME_LEN-1] = '\0';
 		drv->kobj.kset = &bus->drivers;
 
 		if ((error = kobject_register(&drv->kobj))) {
@@ -541,6 +542,7 @@ struct bus_type * find_bus(char * name)
 int bus_register(struct bus_type * bus)
 {
 	strncpy(bus->subsys.kset.kobj.name,bus->name,KOBJ_NAME_LEN);
+	bus->subsys.kset.kobj.name[KOBJ_NAME_LEN-1] = '\0';
 	subsys_set_kset(bus,bus_subsys);
 	subsystem_register(&bus->subsys);
 
diff -puN drivers/base/class.c~make-KOBJ_NAME-match-BUS_ID_SIZE drivers/base/class.c
--- 25/drivers/base/class.c~make-KOBJ_NAME-match-BUS_ID_SIZE	2003-05-14 19:18:09.000000000 -0700
+++ 25-akpm/drivers/base/class.c	2003-05-14 19:18:09.000000000 -0700
@@ -89,6 +89,7 @@ int class_register(struct class * cls)
 	INIT_LIST_HEAD(&cls->interfaces);
 	
 	strncpy(cls->subsys.kset.kobj.name,cls->name,KOBJ_NAME_LEN);
+	cls->subsys.kset.kobj.name[KOBJ_NAME_LEN-1] = '\0';
 	subsys_set_kset(cls,class_subsys);
 	subsystem_register(&cls->subsys);
 
@@ -259,6 +260,7 @@ int class_device_add(struct class_device
 
 	/* first, register with generic layer. */
 	strncpy(class_dev->kobj.name, class_dev->class_id, KOBJ_NAME_LEN);
+	class_dev->kobj.name[KOBJ_NAME_LEN-1] = '\0';
 	kobj_set_kset_s(class_dev, class_obj_subsys);
 	if (parent)
 		class_dev->kobj.parent = &parent->subsys.kset.kobj;
diff -puN drivers/base/core.c~make-KOBJ_NAME-match-BUS_ID_SIZE drivers/base/core.c
--- 25/drivers/base/core.c~make-KOBJ_NAME-match-BUS_ID_SIZE	2003-05-14 19:18:09.000000000 -0700
+++ 25-akpm/drivers/base/core.c	2003-05-14 19:18:09.000000000 -0700
@@ -214,6 +214,7 @@ int device_add(struct device *dev)
 
 	/* first, register with generic layer. */
 	strncpy(dev->kobj.name,dev->bus_id,KOBJ_NAME_LEN);
+	dev->kobj.name[KOBJ_NAME_LEN-1] = '\0';
 	kobj_set_kset_s(dev,devices_subsys);
 	if (parent)
 		dev->kobj.parent = &parent->kobj;
diff -puN include/linux/kobject.h~make-KOBJ_NAME-match-BUS_ID_SIZE include/linux/kobject.h
--- 25/include/linux/kobject.h~make-KOBJ_NAME-match-BUS_ID_SIZE	2003-05-14 19:18:09.000000000 -0700
+++ 25-akpm/include/linux/kobject.h	2003-05-14 19:18:09.000000000 -0700
@@ -12,7 +12,7 @@
 #include <linux/rwsem.h>
 #include <asm/atomic.h>
 
-#define KOBJ_NAME_LEN	16
+#define KOBJ_NAME_LEN	20
 
 struct kobject {
 	char			name[KOBJ_NAME_LEN];
diff -puN include/linux/device.h~make-KOBJ_NAME-match-BUS_ID_SIZE include/linux/device.h
--- 25/include/linux/device.h~make-KOBJ_NAME-match-BUS_ID_SIZE	2003-05-14 19:18:09.000000000 -0700
+++ 25-akpm/include/linux/device.h	2003-05-14 19:18:16.000000000 -0700
@@ -35,7 +35,7 @@
 #define DEVICE_NAME_SIZE	50
 #define DEVICE_NAME_HALF	__stringify(20)	/* Less than half to accommodate slop */
 #define DEVICE_ID_SIZE		32
-#define BUS_ID_SIZE		20
+#define BUS_ID_SIZE		KOBJ_NAME_LEN
 
 
 enum {

_

