Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272377AbTGaA2l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 20:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272380AbTGaA2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 20:28:41 -0400
Received: from mail.kroah.org ([65.200.24.183]:4244 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272377AbTGaA1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 20:27:47 -0400
Date: Wed, 30 Jul 2003 17:27:42 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] Driver core and kobject paranoia checks
Message-ID: <20030731002742.GA5873@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a fun patch for the driver core, and the kobject core that will
tell you if any programmers messed up when they implemented driver and
kobject code.  Running with this patch shows lots of people who messed
things up (myself included.)  I have patches in the USB tree to fix all
of the warnings that this patch throws, and the network people know are
busy fixing their issues too.

The kobject portion of the patch can give false positives when kobjects
that are static are unregistered, so I don't think that patch should be
added to the kernel tree right now.  Andrew, feel free to pick up the
other portion for the -mm tree if you want.  After the usb and
networking changes get into Linus's tree, I'll probably push for this
too.

Oh, this patch also moves the driver and kobject api quite a few steps
up Rusty's "how bad is the API" rating scale :)

thanks,

greg k-h


# driver core and kobject paranoia checks.

diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	Wed Jul 30 16:35:16 2003
+++ b/drivers/base/class.c	Wed Jul 30 16:35:16 2003
@@ -194,6 +194,12 @@
 
 	if (cls->release)
 		cls->release(cd);
+	else {
+		printk(KERN_ERR "Device class '%s' does not have a release() function, "
+			"it is broken and must be fixed.\n",
+			cd->class_id);
+		WARN_ON(1);
+	}
 }
 
 static struct kobj_type ktype_class_device = {
diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	Wed Jul 30 16:35:16 2003
+++ b/drivers/base/core.c	Wed Jul 30 16:35:16 2003
@@ -77,6 +77,12 @@
 	struct device * dev = to_dev(kobj);
 	if (dev->release)
 		dev->release(dev);
+	else {
+		printk(KERN_ERR "Device '%s' does not have a release() function, "
+			"it is broken and must be fixed.\n",
+			dev->bus_id);
+		WARN_ON(1);
+	}
 }
 
 static struct kobj_type ktype_device = {
diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	Wed Jul 30 16:35:16 2003
+++ b/lib/kobject.c	Wed Jul 30 16:35:16 2003
@@ -397,6 +397,13 @@
 	pr_debug("kobject %s: cleaning up\n",kobj->name);
 	if (t && t->release)
 		t->release(kobj);
+	else {
+		printk(KERN_ERR "kobject '%s' does not have a release() function, "
+			"it is broken and must be fixed.\n",
+			kobj->name);
+		WARN_ON(1);
+	}
+
 	if (s)
 		kset_put(s);
 }
