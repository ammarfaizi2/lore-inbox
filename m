Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264252AbTIITSm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 15:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264315AbTIITSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 15:18:36 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:61824
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S264252AbTIITS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 15:18:26 -0400
Date: Tue, 9 Sep 2003 15:18:20 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Greg KH <greg@kroah.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       John Levon <levon@movementarian.org>
Subject: Re: [PATCH][2.6][CFT] rmmod floppy kills box fixes + default_device_remove
In-Reply-To: <20030909171354.GC5928@kroah.com>
Message-ID: <Pine.LNX.4.53.0309091359450.14426@montezuma.fsmlabs.com>
References: <Pine.LNX.4.53.0309072228470.14426@montezuma.fsmlabs.com>
 <20030908155048.GA10879@kroah.com> <Pine.LNX.4.53.0309081722270.14426@montezuma.fsmlabs.com>
 <20030908230852.GA3320@kroah.com> <Pine.LNX.4.53.0309090739270.14426@montezuma.fsmlabs.com>
 <Pine.LNX.4.53.0309091142550.14426@montezuma.fsmlabs.com>
 <20030909171354.GC5928@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Sep 2003, Greg KH wrote:

> Ugh.  Sure, point out the theoretical :)
> 
> Any thoughts on how to solve this?

How about something like the following, the kobj_type.done is passed from 
the driver so the driver's presence can maintain it's persistence and 
we're guaranteed that the ->release() function is not running on a 
processor at completion time.

Index: linux-2.6.0-test5/drivers/base/core.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test5/drivers/base/core.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 core.c
--- linux-2.6.0-test5/drivers/base/core.c	8 Sep 2003 22:07:57 -0000	1.1.1.1
+++ linux-2.6.0-test5/drivers/base/core.c	9 Sep 2003 18:38:45 -0000
@@ -334,6 +334,14 @@ void device_del(struct device * dev)
 
 }
 
+void device_release_notify(struct device *dev, struct completion *done)
+{
+	struct kobj_type *ktype = get_ktype(&dev->kobj);
+
+	init_completion(done);
+	ktype->done = done;
+}
+
 /**
  *	device_unregister - unregister device from system.
  *	@dev:	device going away.
Index: linux-2.6.0-test5/lib/kobject.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test5/lib/kobject.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 kobject.c
--- linux-2.6.0-test5/lib/kobject.c	8 Sep 2003 22:08:55 -0000	1.1.1.1
+++ linux-2.6.0-test5/lib/kobject.c	9 Sep 2003 18:10:50 -0000
@@ -448,8 +448,12 @@ void kobject_cleanup(struct kobject * ko
 	if (kobj->k_name != kobj->name)
 		kfree(kobj->k_name);
 	kobj->k_name = NULL;
-	if (t && t->release)
+	if (t && t->release) {
 		t->release(kobj);
+		if (t->done)
+			complete(t->done);
+	}
+
 	if (s)
 		kset_put(s);
 }
Index: linux-2.6.0-test5/include/linux/kobject.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test5/include/linux/kobject.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 kobject.h
--- linux-2.6.0-test5/include/linux/kobject.h	8 Sep 2003 22:08:50 -0000	1.1.1.1
+++ linux-2.6.0-test5/include/linux/kobject.h	9 Sep 2003 17:47:19 -0000
@@ -59,6 +59,7 @@ extern void kobject_put(struct kobject *
 
 struct kobj_type {
 	void (*release)(struct kobject *);
+	struct completion	* done;
 	struct sysfs_ops	* sysfs_ops;
 	struct attribute	** default_attrs;
 };


Then in the driver module_exit;

void cleanup_module(void)
{
	...
	struct completion done;
	struct device *dev = ...

	device_release_notify(dev, &done);

	...

	wait_for_completion(&done);
}
