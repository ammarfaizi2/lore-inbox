Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268087AbUHXAMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268087AbUHXAMZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 20:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267528AbUHWTvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:51:11 -0400
Received: from mail.kroah.org ([69.55.234.183]:49091 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266836AbUHWSgV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:21 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860863161@kroah.com>
Date: Mon, 23 Aug 2004 11:34:47 -0700
Message-Id: <10932860871178@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.23, 2004/08/06 15:23:51-07:00, johnpol@2ka.mipt.ru

[PATCH] w1: attributes split, timeout unit changed.

Creates w1_master_attribute_* attributes and 2 routings to control them:
        w1_create_master_attributes() and w1_destroy_master_attributes().

Timeout unit was changed from jiffies to seconds.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/w1/w1.c     |  188 +++++++++++++++++++++++++++++++++++++++++++++-------
 drivers/w1/w1.h     |    3 
 drivers/w1/w1_int.c |    3 
 3 files changed, 170 insertions(+), 24 deletions(-)


diff -Nru a/drivers/w1/w1.c b/drivers/w1/w1.c
--- a/drivers/w1/w1.c	2004-08-23 11:04:25 -07:00
+++ b/drivers/w1/w1.c	2004-08-23 11:04:25 -07:00
@@ -45,7 +45,7 @@
 MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
 MODULE_DESCRIPTION("Driver for 1-wire Dallas network protocol.");
 
-static int w1_timeout = 5 * HZ;
+static int w1_timeout = 10;
 int w1_max_slave_count = 10;
 
 module_param_named(timeout, w1_timeout, int, 0);
@@ -137,25 +137,95 @@
 	.show = &w1_default_read_name,
 };
 
-static ssize_t w1_master_attribute_show(struct device *dev, char *buf)
+ssize_t w1_master_attribute_show_name(struct device *dev, char *buf)
+{
+	struct w1_master *md = container_of (dev, struct w1_master, dev);
+	ssize_t count;
+	
+	if (down_interruptible (&md->mutex))
+		return -EBUSY;
+
+	count = sprintf(buf, "%s\n", md->name);
+	
+	up(&md->mutex);
+
+	return count;
+}
+
+ssize_t w1_master_attribute_show_pointer(struct device *dev, char *buf)
+{
+	struct w1_master *md = container_of(dev, struct w1_master, dev);
+	ssize_t count;
+	
+	if (down_interruptible(&md->mutex))
+		return -EBUSY;
+
+	count = sprintf(buf, "0x%p\n", md->bus_master);
+	
+	up(&md->mutex);
+	return count;
+}
+
+ssize_t w1_master_attribute_show_timeout(struct device *dev, char *buf)
+{
+	ssize_t count;
+	count = sprintf(buf, "%d\n", w1_timeout);
+	return count;
+}
+
+ssize_t w1_master_attribute_show_max_slave_count(struct device *dev, char *buf)
+{
+	struct w1_master *md = container_of(dev, struct w1_master, dev);
+	ssize_t count;
+	
+	if (down_interruptible(&md->mutex))
+		return -EBUSY;
+
+	count = sprintf(buf, "%d\n", md->max_slave_count);
+	
+	up(&md->mutex);
+	return count;
+}
+
+ssize_t w1_master_attribute_show_attempts(struct device *dev, char *buf)
+{
+	struct w1_master *md = container_of(dev, struct w1_master, dev);
+	ssize_t count;
+	
+	if (down_interruptible(&md->mutex))
+		return -EBUSY;
+
+	count = sprintf(buf, "%lu\n", md->attempts);
+	
+	up(&md->mutex);
+	return count;
+}
+
+ssize_t w1_master_attribute_show_slave_count(struct device *dev, char *buf)
+{
+	struct w1_master *md = container_of(dev, struct w1_master, dev);
+	ssize_t count;
+	
+	if (down_interruptible(&md->mutex))
+		return -EBUSY;
+
+	count = sprintf(buf, "%d\n", md->slave_count);
+	
+	up(&md->mutex);
+	return count;
+}
+
+ssize_t w1_master_attribute_show_slaves(struct device *dev, char *buf)
+
 {
-	return sprintf(buf, "please fix me\n");
-#if 0
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
 	int c = PAGE_SIZE;
 
 	if (down_interruptible(&md->mutex))
 		return -EBUSY;
 
-	c -= snprintf(buf + PAGE_SIZE - c, c, "%s\n", md->name);
-	c -= snprintf(buf + PAGE_SIZE - c, c,
-		       "bus_master=0x%p, timeout=%d, max_slave_count=%d, attempts=%lu\n",
-		       md->bus_master, w1_timeout, md->max_slave_count,
-		       md->attempts);
-	c -= snprintf(buf + PAGE_SIZE - c, c, "%d slaves: ",
-		       md->slave_count);
 	if (md->slave_count == 0)
-		c -= snprintf(buf + PAGE_SIZE - c, c, "no.\n");
+		c -= snprintf(buf + PAGE_SIZE - c, c, "not found.\n");
 	else {
 		struct list_head *ent, *n;
 		struct w1_slave *sl;
@@ -163,25 +233,70 @@
 		list_for_each_safe(ent, n, &md->slist) {
 			sl = list_entry(ent, struct w1_slave, w1_slave_entry);
 
-			c -= snprintf(buf + PAGE_SIZE - c, c, "%s[%p] ",
-				       sl->name, sl);
+ 			c -= snprintf(buf + PAGE_SIZE - c, c, "%s\n", sl->name);
 		}
-		c -= snprintf(buf + PAGE_SIZE - c, c, "\n");
 	}
 
 	up(&md->mutex);
 
 	return PAGE_SIZE - c;
-#endif
 }
 
-struct device_attribute w1_master_attribute = {
+static struct device_attribute w1_master_attribute_slaves = {
 	.attr = {
-			.name = "w1_master_stats",
+ 			.name = "w1_master_slaves",
 			.mode = S_IRUGO,
 			.owner = THIS_MODULE,
 	},
-	.show = &w1_master_attribute_show,
+ 	.show = &w1_master_attribute_show_slaves,
+};
+static struct device_attribute w1_master_attribute_slave_count = {
+	.attr = {
+			.name = "w1_master_slave_count",
+			.mode = S_IRUGO,
+			.owner = THIS_MODULE
+	},
+	.show = &w1_master_attribute_show_slave_count,
+};
+static struct device_attribute w1_master_attribute_attempts = {
+	.attr = {
+			.name = "w1_master_attempts",
+			.mode = S_IRUGO,
+			.owner = THIS_MODULE
+	},
+	.show = &w1_master_attribute_show_attempts,
+};
+static struct device_attribute w1_master_attribute_max_slave_count = {
+	.attr = {
+			.name = "w1_master_max_slave_count",
+			.mode = S_IRUGO,
+			.owner = THIS_MODULE
+	},
+	.show = &w1_master_attribute_show_max_slave_count,
+};
+static struct device_attribute w1_master_attribute_timeout = {
+	.attr = {
+			.name = "w1_master_timeout",
+			.mode = S_IRUGO,
+			.owner = THIS_MODULE
+	},
+	.show = &w1_master_attribute_show_timeout,
+};
+static struct device_attribute w1_master_attribute_pointer = {
+	.attr = {
+			.name = "w1_master_pointer",
+			.mode = S_IRUGO,
+			.owner = THIS_MODULE
+	},
+	.show = &w1_master_attribute_show_pointer,
+};
+static struct device_attribute w1_master_attribute_name = {
+	.attr = {
+			.name = "w1_master_name",
+			.mode = S_IRUGO,
+			.owner = THIS_MODULE
+	},
+	.show = &w1_master_attribute_show_name,
 };
 
 static struct bin_attribute w1_slave_bin_attribute = {
@@ -449,6 +564,32 @@
 	}
 }
 
+int w1_create_master_attributes(struct w1_master *dev)
+{
+	if (	device_create_file(&dev->dev, &w1_master_attribute_slaves) < 0 ||
+		device_create_file(&dev->dev, &w1_master_attribute_slave_count) < 0 ||
+		device_create_file(&dev->dev, &w1_master_attribute_attempts) < 0 ||
+		device_create_file(&dev->dev, &w1_master_attribute_max_slave_count) < 0 ||
+		device_create_file(&dev->dev, &w1_master_attribute_timeout) < 0||
+		device_create_file(&dev->dev, &w1_master_attribute_pointer) < 0||
+		device_create_file(&dev->dev, &w1_master_attribute_name) < 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+void w1_destroy_master_attributes(struct w1_master *dev)
+{
+	device_remove_file(&dev->dev, &w1_master_attribute_slaves);
+	device_remove_file(&dev->dev, &w1_master_attribute_slave_count);
+	device_remove_file(&dev->dev, &w1_master_attribute_attempts);
+	device_remove_file(&dev->dev, &w1_master_attribute_max_slave_count);
+	device_remove_file(&dev->dev, &w1_master_attribute_timeout);
+	device_remove_file(&dev->dev, &w1_master_attribute_pointer);
+	device_remove_file(&dev->dev, &w1_master_attribute_name);
+}
+
+
 int w1_control(void *data)
 {
 	struct w1_slave *sl;
@@ -462,7 +603,7 @@
 	while (!control_needs_exit || have_to_wait) {
 		have_to_wait = 0;
 
-		timeout = w1_timeout;
+		timeout = w1_timeout*HZ;
 		do {
 			timeout = interruptible_sleep_on_timeout(&w1_control_wait, timeout);
 			if (current->flags & PF_FREEZE)
@@ -516,7 +657,7 @@
 					kfree(sl);
 				}
 			}
-			device_remove_file(&dev->dev, &w1_master_attribute);
+			w1_destroy_master_attributes(dev);
 			atomic_dec(&dev->refcnt);
 		}
 	}
@@ -533,7 +674,7 @@
 	allow_signal(SIGTERM);
 
 	while (!dev->need_exit) {
-		timeout = w1_timeout;
+		timeout = w1_timeout*HZ;
 		do {
 			timeout = interruptible_sleep_on_timeout(&dev->kwait, timeout);
 			if (current->flags & PF_FREEZE)
@@ -621,3 +762,6 @@
 
 module_init(w1_init);
 module_exit(w1_fini);
+
+EXPORT_SYMBOL(w1_create_master_attributes);
+EXPORT_SYMBOL(w1_destroy_master_attributes);
diff -Nru a/drivers/w1/w1.h b/drivers/w1/w1.h
--- a/drivers/w1/w1.h	2004-08-23 11:04:25 -07:00
+++ b/drivers/w1/w1.h	2004-08-23 11:04:25 -07:00
@@ -107,6 +107,9 @@
 	struct sock 		*nls;
 };
 
+int w1_create_master_attributes(struct w1_master *);
+void w1_destroy_master_attributes(struct w1_master *);
+
 #endif /* __KERNEL__ */
 
 #endif /* __W1_H */
diff -Nru a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
--- a/drivers/w1/w1_int.c	2004-08-23 11:04:25 -07:00
+++ b/drivers/w1/w1_int.c	2004-08-23 11:04:25 -07:00
@@ -30,7 +30,6 @@
 extern struct device_driver w1_driver;
 extern struct bus_type w1_bus_type;
 extern struct device w1_device;
-extern struct device_attribute w1_master_attribute;
 extern int w1_max_slave_count;
 extern struct list_head w1_masters;
 extern spinlock_t w1_mlock;
@@ -133,7 +132,7 @@
 		goto err_out_free_dev;
 	}
 
-	retval = device_create_file(&dev->dev, &w1_master_attribute);
+	retval =  w1_create_master_attributes(dev);
 	if (retval)
 		goto err_out_kill_thread;
 

