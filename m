Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262373AbUKQURP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbUKQURP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 15:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbUKQUPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 15:15:21 -0500
Received: from peabody.ximian.com ([130.57.169.10]:24735 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262403AbUKQUNQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 15:13:16 -0500
Subject: [patch] inotify: add sysfs store support
From: Robert Love <rml@novell.com>
To: ttb@tentacle.dhs.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1100714560.6280.7.camel@betsy.boston.ximian.com>
References: <1100710677.6280.2.camel@betsy.boston.ximian.com>
	 <1100714560.6280.7.camel@betsy.boston.ximian.com>
Content-Type: text/plain
Date: Wed, 17 Nov 2004 15:10:26 -0500
Message-Id: <1100722226.4981.46.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attached patch implements the final chunk of our sysfs solution: store
support.  I added basic write support with some simple checking (do not
allow zero) to the existing sysfs attributes.

I made a few other changes.  I added a newline after the values in the
show function.  The other sysfs attributes do this and it makes
sense--do a "cat *" in our sysfs directory before and after.  I also
just return sprintf() directly instead of the strlen().  I also made
max_queued_events unsigned, since dev->max_events is unsigned.  If we
don't do this we need to add checking in store_max_queued_events to
ensure that the given value is less than or equal to INT_MAX so this
seems easier and more optimal anyhow.  The other values I kept at int
since that is the range of atomic_t's.

I am running it now.  I can read and write the values fine.  Works
great.

	Robert Love


Add store support to our sysfs attributes and a few other changes.

 inotify.c |   35 +++++++++++++++++++++++++----------
 1 files changed, 25 insertions(+), 10 deletions(-)

diff -u linux/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux/drivers/char/inotify.c	2004-11-16 14:42:11.929575168 -0500
+++ linux/drivers/char/inotify.c	2004-11-17 12:28:27.921136656 -0500
@@ -40,7 +40,7 @@
 
 static int sysfs_attrib_max_user_devices;
 static int sysfs_attrib_max_user_watches;
-static int sysfs_attrib_max_queued_events;
+static unsigned int sysfs_attrib_max_queued_events;
 
 /*
  * struct inotify_device - represents an open instance of an inotify device
@@ -82,38 +82,53 @@
 
 static ssize_t show_max_queued_events(struct class_device *class, char *buf)
 {
-	sprintf(buf, "%d", sysfs_attrib_max_queued_events);
-	return strlen(buf) + 1;
+	return sprintf(buf, "%d\n", sysfs_attrib_max_queued_events);
 }
 
 static ssize_t store_max_queued_events(struct class_device *class,
 				       const char *buf, size_t count)
 {
-	return 0;
+	unsigned int max;
+
+	if (sscanf(buf, "%u", &max) > 0 && max > 0) {
+		sysfs_attrib_max_queued_events = max;
+		return strlen(buf);
+	}
+	return -EINVAL;
 }
 
 static ssize_t show_max_user_devices(struct class_device *class, char *buf)
 {
-	sprintf(buf, "%d", sysfs_attrib_max_user_devices);
-	return strlen(buf) + 1;
+	return sprintf(buf, "%d\n", sysfs_attrib_max_user_devices);
 }
 
 static ssize_t store_max_user_devices(struct class_device *class,
 				      const char *buf, size_t count)
 {
-	return 0;
+	int max;
+
+	if (sscanf(buf, "%d", &max) > 0 && max > 0) {
+		sysfs_attrib_max_user_devices = max;
+		return strlen(buf);
+	}
+	return -EINVAL;
 }
 
 static ssize_t show_max_user_watches(struct class_device *class, char *buf)
 {
-	sprintf(buf, "%d", sysfs_attrib_max_user_watches);
-	return strlen(buf) + 1;
+	return sprintf(buf, "%d\n", sysfs_attrib_max_user_watches);
 }
 
 static ssize_t store_max_user_watches(struct class_device *class,
 				      const char *buf, size_t count)
 {
-	return 0;
+	int max;
+
+	if (sscanf(buf, "%d", &max) > 0 && max > 0) {
+		sysfs_attrib_max_user_watches = max;
+		return strlen(buf);
+	}
+	return -EINVAL;
 }
 
 static CLASS_DEVICE_ATTR(max_queued_events, S_IRUGO | S_IWUSR,


