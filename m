Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262751AbVFVFcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262751AbVFVFcT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 01:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbVFVF3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 01:29:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:37015 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262751AbVFVFMQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:12:16 -0400
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] w1: Adds a sysfs entry (w1_master_search) that allows you to disable/enable periodic searches.
In-Reply-To: <111941712742@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:12:07 -0700
Message-Id: <1119417127917@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] w1: Adds a sysfs entry (w1_master_search) that allows you to disable/enable periodic searches.

Adds a sysfs entry (w1_master_search) that allows you to disable/enable
periodic searches.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 2a9d0c178158da4a9bcf22311a414c26a8102d13
tree 7039be0c9767193b1046d737686bb00c8dbf64d3
parent 6b729861831177b270a2932a13e79cb41d673146
author Evgeniy Polyakov <johnpol@2ka.mipt.ru> Sat, 04 Jun 2005 01:31:02 +0400
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:43:11 -0700

 drivers/w1/w1.c     |   50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/w1/w1.h     |    1 +
 drivers/w1/w1_int.c |    1 +
 3 files changed, 51 insertions(+), 1 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -148,6 +148,39 @@ static ssize_t w1_master_attribute_show_
 	return count;
 }
 
+static ssize_t w1_master_attribute_store_search(struct device * dev,
+						struct device_attribute *attr,
+						const char * buf, size_t count)
+{
+	struct w1_master *md = container_of(dev, struct w1_master, dev);
+
+	if (down_interruptible (&md->mutex))
+		return -EBUSY;
+
+	md->search_count = simple_strtol(buf, NULL, 0);
+
+	up(&md->mutex);
+
+	return count;
+}
+
+static ssize_t w1_master_attribute_show_search(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
+{
+	struct w1_master *md = container_of(dev, struct w1_master, dev);
+	ssize_t count;
+
+	if (down_interruptible (&md->mutex))
+		return -EBUSY;
+
+	count = sprintf(buf, "%d\n", md->search_count);
+
+	up(&md->mutex);
+
+	return count;
+}
+
 static ssize_t w1_master_attribute_show_pointer(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
@@ -242,6 +275,12 @@ static ssize_t w1_master_attribute_show_
 		__ATTR(w1_master_##_name, _mode,		\
 		       w1_master_attribute_show_##_name, NULL)
 
+#define W1_MASTER_ATTR_RW(_name, _mode)				\
+	struct device_attribute w1_master_attribute_##_name =	\
+		__ATTR(w1_master_##_name, _mode,		\
+		       w1_master_attribute_show_##_name,	\
+		       w1_master_attribute_store_##_name)
+
 static W1_MASTER_ATTR_RO(name, S_IRUGO);
 static W1_MASTER_ATTR_RO(slaves, S_IRUGO);
 static W1_MASTER_ATTR_RO(slave_count, S_IRUGO);
@@ -249,6 +288,7 @@ static W1_MASTER_ATTR_RO(max_slave_count
 static W1_MASTER_ATTR_RO(attempts, S_IRUGO);
 static W1_MASTER_ATTR_RO(timeout, S_IRUGO);
 static W1_MASTER_ATTR_RO(pointer, S_IRUGO);
+static W1_MASTER_ATTR_RW(search, S_IRUGO | S_IWUGO);
 
 static struct attribute *w1_master_default_attrs[] = {
 	&w1_master_attribute_name.attr,
@@ -258,6 +298,7 @@ static struct attribute *w1_master_defau
 	&w1_master_attribute_attempts.attr,
 	&w1_master_attribute_timeout.attr,
 	&w1_master_attribute_pointer.attr,
+	&w1_master_attribute_search.attr,
 	NULL
 };
 
@@ -643,11 +684,14 @@ int w1_process(void *data)
 		if (!dev->initialized)
 			continue;
 
+		if (dev->search_count == 0)
+			continue;
+
 		if (down_interruptible(&dev->mutex))
 			continue;
 
 		list_for_each_entry(sl, &dev->slist, w1_slave_entry)
-				clear_bit(W1_SLAVE_ACTIVE, (long *)&sl->flags);
+			clear_bit(W1_SLAVE_ACTIVE, (long *)&sl->flags);
 
 		w1_search_devices(dev, w1_slave_found);
 
@@ -662,6 +706,10 @@ int w1_process(void *data)
 			} else if (test_bit(W1_SLAVE_ACTIVE, (unsigned long *)&sl->flags))
 				sl->ttl = dev->slave_ttl;
 		}
+
+		if (dev->search_count > 0)
+			dev->search_count--;
+
 		up(&dev->mutex);
 	}
 
diff --git a/drivers/w1/w1.h b/drivers/w1/w1.h
--- a/drivers/w1/w1.h
+++ b/drivers/w1/w1.h
@@ -162,6 +162,7 @@ struct w1_master
 	int			slave_ttl;
 	int			initialized;
 	u32			id;
+	int			search_count;
 
 	atomic_t		refcnt;
 
diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
--- a/drivers/w1/w1_int.c
+++ b/drivers/w1/w1_int.c
@@ -69,6 +69,7 @@ static struct w1_master * w1_alloc_dev(u
 	dev->initialized	= 0;
 	dev->id			= id;
 	dev->slave_ttl		= slave_ttl;
+        dev->search_count	= -1; /* continual scan */
 
 	atomic_set(&dev->refcnt, 2);
 

