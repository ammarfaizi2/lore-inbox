Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270711AbTHOS1R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 14:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270709AbTHOSZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 14:25:58 -0400
Received: from mail.kroah.org ([65.200.24.183]:60034 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270711AbTHOSZe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 14:25:34 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10609719491100@kroah.com>
Subject: Re: [PATCH] Driver Core fixes for 2.6.0-test3
In-Reply-To: <10609719492406@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 15 Aug 2003 11:25:49 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1152.2.7, 2003/08/15 10:12:59-07:00, greg@kroah.com

Driver Core: add warnings if .release functions are not set for objects.

This has been in the -mm tree for a while and has helped a lot in finding
lots of improper users of the driver core.  It also moves the driver core
code up quite a few levels on the "Rusty's guide to kernel APIs".


 drivers/base/class.c |    6 ++++++
 drivers/base/core.c  |    6 ++++++
 2 files changed, 12 insertions(+)


diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	Fri Aug 15 11:15:48 2003
+++ b/drivers/base/class.c	Fri Aug 15 11:15:48 2003
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
--- a/drivers/base/core.c	Fri Aug 15 11:15:48 2003
+++ b/drivers/base/core.c	Fri Aug 15 11:15:48 2003
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

