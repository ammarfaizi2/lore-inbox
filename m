Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbVCCOmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVCCOmd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 09:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbVCCOmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 09:42:32 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35272 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261753AbVCCOmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 09:42:23 -0500
Date: Thu, 3 Mar 2005 14:42:18 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Symlinks from devices to classes
Message-ID: <20050303144218.GC28741@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When looking through sysfs, I find myself frequently wanting to see
the class attributes associated with a device.  At the moment, that's
inconvenient to do -- you have to go back up to /sys/class/<classname>,
find the device and then look at its attributes.  Additionally, you may
not realise that a device already has attributes available through one
of its classes.

This patch adds links from the device back to the classes that it has.
Things will go wrong if a device has attributes with the same name as
the classes it belongs to, but that's a really confusing thing for the
device to have anyway, so I think people should be forced to rename
their attributes if they've done that.

There is one nasty I've discovered with this patch:

# ls -l /sys/devices/parisc/0/0:0/pci0000:00/0000:00:04.0 |grep tty
tty -> ../../../../../../class/tty/ttyS2
tty -> ../../../../../../class/tty/ttyS2
tty -> ../../../../../../class/tty/ttyS2

This happens because this is a PCI device with three serial ports:

# ls -l /sys/class/tty/ttyS[0-2] |grep device
device -> ../../../devices/parisc/0/0:0/pci0000:00/0000:00:04.0
device -> ../../../devices/parisc/0/0:0/pci0000:00/0000:00:04.0
device -> ../../../devices/parisc/0/0:0/pci0000:00/0000:00:04.0

so we create the symlink three times.  What's the right way to solve
this?  Have sysfs decline to create a symlink if an entry of the same
name already exists?  Should we create 'ttyS0', 'ttyS1' and 'ttyS2'
directories in the parent's directory?  We'll have to do that anyway if
we want ttyS* to have sysfs attributes (and presumably we do, eventually)

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

Index: ./drivers/base/class.c
===================================================================
RCS file: /var/lib/cvs/linux-2.6/drivers/base/class.c,v
retrieving revision 1.15
diff -u -p -r1.15 class.c
--- ./drivers/base/class.c	12 Jan 2005 20:16:13 -0000	1.15
+++ ./drivers/base/class.c	20 Feb 2005 22:01:07 -0000
@@ -197,15 +197,33 @@ void class_device_remove_bin_file(struct
 
 static int class_device_dev_link(struct class_device * class_dev)
 {
-	if (class_dev->dev)
-		return sysfs_create_link(&class_dev->kobj,
-					 &class_dev->dev->kobj, "device");
+	int retval = 0;
+	if (!class_dev->dev)
+		goto out;
+
+	retval = sysfs_create_link(&class_dev->kobj, &class_dev->dev->kobj,
+					"device");
+	if (retval)
+		goto out;
+
+	retval = sysfs_create_link(&class_dev->dev->kobj, &class_dev->kobj,
+					class_dev->class->name);
+	if (retval)
+		goto unlink;
+
 	return 0;
+
+ unlink:
+	sysfs_remove_link(&class_dev->kobj, "device");
+ out:
+	return retval;
 }
 
 static void class_device_dev_unlink(struct class_device * class_dev)
 {
 	sysfs_remove_link(&class_dev->kobj, "device");
+	if (class_dev->dev)
+		sysfs_remove_link(&class_dev->dev->kobj, class_dev->class->name);
 }
 
 static int class_device_driver_link(struct class_device * class_dev)

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
