Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264461AbUENXK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbUENXK4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263156AbUENXJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:09:37 -0400
Received: from mail.kroah.org ([65.200.24.183]:51932 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263162AbUENXIE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:08:04 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.6
In-Reply-To: <10845760423849@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 14 May 2004 16:07:22 -0700
Message-Id: <1084576042919@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1587.5.21, 2004/05/05 15:10:00-07:00, bellucda@tiscali.it

[PATCH] missing audit in bus_register()

|How about using a goto on the error path to clean up properly
|instead of the different return sections.

.. here goes Take 2:


 drivers/base/bus.c |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)


diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	Fri May 14 15:57:45 2004
+++ b/drivers/base/bus.c	Fri May 14 15:57:45 2004
@@ -555,21 +555,36 @@
  */
 int bus_register(struct bus_type * bus)
 {
+	int retval;
+
 	kobject_set_name(&bus->subsys.kset.kobj,bus->name);
 	subsys_set_kset(bus,bus_subsys);
-	subsystem_register(&bus->subsys);
+	retval = subsystem_register(&bus->subsys);
+	if (retval) 
+		goto out;
 
 	kobject_set_name(&bus->devices.kobj, "devices");
 	bus->devices.subsys = &bus->subsys;
-	kset_register(&bus->devices);
+	retval = kset_register(&bus->devices);
+	if (retval)
+		goto bus_devices_fail;
 
 	kobject_set_name(&bus->drivers.kobj, "drivers");
 	bus->drivers.subsys = &bus->subsys;
 	bus->drivers.ktype = &ktype_driver;
-	kset_register(&bus->drivers);
+	retval = kset_register(&bus->drivers);
+	if (retval)
+		goto bus_drivers_fail;
 
 	pr_debug("bus type '%s' registered\n",bus->name);
 	return 0;
+
+bus_drivers_fail:
+	kset_unregister(&bus->devices);
+bus_devices_fail:
+	subsystem_unregister(&bus->subsys);
+out:
+	return retval;
 }
 
 

