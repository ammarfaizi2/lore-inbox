Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272252AbTHNHKb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 03:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272253AbTHNHKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 03:10:31 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31530 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S272252AbTHNHK3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 03:10:29 -0400
To: Pavel Machek <pavel@suse.cz>, Greg KH <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] call drv->shutdown at rmmod 
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Aug 2003 01:06:45 -0600
Message-ID: <m1he4kzpiy.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


At the kexec BOF at OSDL there was some discussion on calling the
device shutdown method at module remove time, in addition to calling
it during reboot.  The driver was the observation that the primary
source of problems in booting linux from linux are drivers with bad
or missing drv->shutdown() routines.  The hope is this will increase
the testing so people can get it right and kexec can become more
useful.  In addition to making normal reboots more reliable.

The following patch is an implementation of that idea it calls drv->shutdown()
before calling drv->remove().  If drv->shutdown() is implemented.

In addition the driver model documentation in 2.6.0-test3 is badly out of
date.  So I have attached a minor correction which at least mentions
drv->shutdown().

Eric


diff -uNr linux-2.6.0-test3/Documentation/driver-model/driver.txt linux-2.6.0-test3-shutdown_before_remove/Documentation/driver-model/driver.txt
--- linux-2.6.0-test3/Documentation/driver-model/driver.txt	Mon Jul 14 03:34:33 2003
+++ linux-2.6.0-test3-shutdown_before_remove/Documentation/driver-model/driver.txt	Wed Aug 13 12:51:49 2003
@@ -16,10 +16,10 @@
         int     (*probe)        (struct device * dev);
         int     (*remove)       (struct device * dev);
 
+	void    (*shutdown)     (struct device * dev);
+
         int     (*suspend)      (struct device * dev, u32 state, u32 level);
         int     (*resume)       (struct device * dev, u32 level);
-
-        void    (*release)      (struct device_driver * drv);
 };
 
 
@@ -194,6 +194,18 @@
 
 If the device is still present, it should quiesce the device and place
 it into a supported low-power state.
+
+
+	void    (*shutdown)     (struct device * dev);
+
+shutdown is called to quiescent a device before a reboot, or before
+the device is removed.  A device is quiescent if all on going
+transactions are stopped, and it is not setup to spontaneously
+generate new ones.  In addition the device should be in a state
+that it is reasonable for the drivers initialization code can get it
+working again.  shutdown is a separate case from remove because on a
+reboot the data structures do not need to be freed, and not freeing
+them increases the robustness of a reboot.
 
 	int	(*suspend)	(struct device * dev, u32 state, u32 level);
 
diff -uNr linux-2.6.0-test3/drivers/base/bus.c linux-2.6.0-test3-shutdown_before_remove/drivers/base/bus.c
--- linux-2.6.0-test3/drivers/base/bus.c	Mon Jul 14 03:31:58 2003
+++ linux-2.6.0-test3-shutdown_before_remove/drivers/base/bus.c	Wed Aug 13 12:52:20 2003
@@ -350,6 +350,8 @@
 	if (drv) {
 		sysfs_remove_link(&drv->kobj,dev->kobj.name);
 		list_del_init(&dev->driver_list);
+		if (drv->shutdown)
+			drv->shutdown(dev);
 		if (drv->remove)
 			drv->remove(dev);
 		dev->driver = NULL;
