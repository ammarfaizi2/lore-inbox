Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUEOBWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUEOBWp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 21:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbUENXJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:09:05 -0400
Received: from mail.kroah.org ([65.200.24.183]:51164 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263117AbUENXIC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:08:02 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.6
In-Reply-To: <10845760433004@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 14 May 2004 16:07:23 -0700
Message-Id: <10845760434173@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1587.5.25, 2004/05/11 16:31:46-07:00, maneesh@in.ibm.com

[PATCH] kobject_set_name - error handling

1) kobject_set_name-cleanup-01.patch

This patch corrects the following by checking the reutrn code from
kobject_set_name().

bus_add_driver()
bus_register()
sys_dev_register()



o The following patch cleansup the kobject_set_name() users. Basically checking
  return code from kobject_set_name(). There can be error returns like -ENOMEM
  or -EFAULT from kobject_set_name() if the name length exceeds KOBJ_NAME_LEN.


 drivers/base/bus.c |   11 +++++++++--
 drivers/base/sys.c |    5 ++++-
 2 files changed, 13 insertions(+), 3 deletions(-)


diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	Fri May 14 15:56:41 2004
+++ b/drivers/base/bus.c	Fri May 14 15:56:41 2004
@@ -451,7 +451,11 @@
 
 	if (bus) {
 		pr_debug("bus %s: add driver %s\n",bus->name,drv->name);
-		kobject_set_name(&drv->kobj,drv->name);
+		error = kobject_set_name(&drv->kobj,drv->name);
+		if (error) {
+			put_bus(bus);
+			return error;
+		}
 		drv->kobj.kset = &bus->drivers;
 		if ((error = kobject_register(&drv->kobj))) {
 			put_bus(bus);
@@ -557,7 +561,10 @@
 {
 	int retval;
 
-	kobject_set_name(&bus->subsys.kset.kobj,bus->name);
+	retval = kobject_set_name(&bus->subsys.kset.kobj,bus->name);
+	if (retval)
+		goto out;
+
 	subsys_set_kset(bus,bus_subsys);
 	retval = subsystem_register(&bus->subsys);
 	if (retval) 
diff -Nru a/drivers/base/sys.c b/drivers/base/sys.c
--- a/drivers/base/sys.c	Fri May 14 15:56:41 2004
+++ b/drivers/base/sys.c	Fri May 14 15:56:41 2004
@@ -180,8 +180,11 @@
 
 	/* But make sure we point to the right type for sysfs translation */
 	sysdev->kobj.ktype = &ktype_sysdev;
-	kobject_set_name(&sysdev->kobj,"%s%d",
+	error = kobject_set_name(&sysdev->kobj,"%s%d",
 			 kobject_name(&cls->kset.kobj),sysdev->id);
+	if (error)
+		return error;
+
 	pr_debug("Registering sys device '%s'\n",kobject_name(&sysdev->kobj));
 
 	/* Register the object */

