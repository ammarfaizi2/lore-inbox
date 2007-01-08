Return-Path: <linux-kernel-owner+w=401wt.eu-S1161330AbXAHQGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161330AbXAHQGq (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 11:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161333AbXAHQGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 11:06:46 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:57838 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1161330AbXAHQGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 11:06:45 -0500
Date: Mon, 8 Jan 2007 11:06:44 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Greg KH <greg@kroah.com>, Kay Sievers <kay.sievers@novell.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Driver core: fix refcounting bug
Message-ID: <Pine.LNX.4.44L0.0701081103530.4249-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (as832) fixes a newly-introduced bug in the driver core.
When a kobject is assigned to a kset, it must acquire a reference to
the kset.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

The bug was introduced in Kay's "unify /sys/class and /sys/bus at 
/sys/subsystem" patch.

I left the assignment of class_dev->kobj.parent as it was, although it is 
not needed.  The following call to kobject_add() will end up doing the 
same thing.

Alan Stern

P.S.: Tracking down refcounting bugs is a real pain!  I spent an entire 
afternoon on this one...  :-(


Index: usb-2.6/drivers/base/class.c
===================================================================
--- usb-2.6.orig/drivers/base/class.c
+++ usb-2.6/drivers/base/class.c
@@ -648,7 +648,7 @@ int class_device_add(struct class_device
 		class_dev->kobj.parent = &parent_class_dev->kobj;
 	else {
 		/* assign parent kset for uevent hook */
-		class_dev->kobj.kset = &parent_class->devices_dir;
+		class_dev->kobj.kset = kset_get(&parent_class->devices_dir);
 		/* the device directory in /sys/subsystem/<name>/devices */
 		class_dev->kobj.parent = &parent_class->devices_dir.kobj;
 	}

