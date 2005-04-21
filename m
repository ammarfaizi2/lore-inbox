Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbVDUIF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVDUIF4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 04:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVDUIEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 04:04:06 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:53431 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261449AbVDUHaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 03:30:17 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: sensors@Stimpy.netroedge.com
Subject: [RFC/PATCH 12/22] W1: drop unneeded master attributes
Date: Thu, 21 Apr 2005 02:19:13 -0500
User-Agent: KMail/1.8
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>
References: <200504210207.02421.dtor_core@ameritech.net>
In-Reply-To: <200504210207.02421.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504210219.13734.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

W1: get rid of unneeded master device attributes:
    - 'pointer' and 'attempts' are meaningless for userspace;
    - information provided by 'slaves' and 'slave_count' can be
      gathered from other sysfs bits;
    - w1_slave_found has to be rearranged now that slave_count
      field is gone.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 w1.c    |  108 ++++++++--------------------------------------------------------
 w1.h    |    3 -
 w1_io.c |    1 
 3 files changed, 16 insertions(+), 96 deletions(-)

Index: dtor/drivers/w1/w1.c
===================================================================
--- dtor.orig/drivers/w1/w1.c
+++ dtor/drivers/w1/w1.c
@@ -110,20 +110,6 @@ static ssize_t w1_master_attribute_show_
 	return count;
 }
 
-static ssize_t w1_master_attribute_show_pointer(struct device *dev, char *buf)
-{
-	struct w1_master *md = container_of(dev, struct w1_master, dev);
-	ssize_t count;
-
-	if (down_interruptible(&md->mutex))
-		return -EBUSY;
-
-	count = sprintf(buf, "0x%p\n", md->private);
-
-	up(&md->mutex);
-	return count;
-}
-
 static ssize_t w1_master_attribute_show_timeout(struct device *dev, char *buf)
 {
 	ssize_t count;
@@ -145,76 +131,19 @@ static ssize_t w1_master_attribute_show_
 	return count;
 }
 
-static ssize_t w1_master_attribute_show_attempts(struct device *dev, char *buf)
-{
-	struct w1_master *md = container_of(dev, struct w1_master, dev);
-	ssize_t count;
-
-	if (down_interruptible(&md->mutex))
-		return -EBUSY;
-
-	count = sprintf(buf, "%lu\n", md->attempts);
-
-	up(&md->mutex);
-	return count;
-}
-
-static ssize_t w1_master_attribute_show_slave_count(struct device *dev, char *buf)
-{
-	struct w1_master *md = container_of(dev, struct w1_master, dev);
-	ssize_t count;
-
-	if (down_interruptible(&md->mutex))
-		return -EBUSY;
-
-	count = sprintf(buf, "%d\n", md->slave_count);
-
-	up(&md->mutex);
-	return count;
-}
-
-static ssize_t w1_master_attribute_show_slaves(struct device *dev, char *buf)
-
-{
-	struct w1_master *md = container_of(dev, struct w1_master, dev);
-	struct w1_slave *slave;
-	int c = PAGE_SIZE;
-
-	if (down_interruptible(&md->mutex))
-		return -EBUSY;
-
-	if (md->slave_count == 0)
-		c -= snprintf(buf + PAGE_SIZE - c, c, "not found.\n");
-	else
-		list_for_each_entry(slave, &md->slist, node)
-			c -= snprintf(buf + PAGE_SIZE - c, c, "%s\n", slave->name);
-
-	up(&md->mutex);
-
-	return PAGE_SIZE - c;
-}
-
 #define W1_MASTER_ATTR_RO(_name, _mode)				\
 	struct device_attribute w1_master_attribute_##_name =	\
 		__ATTR(w1_master_##_name, _mode,		\
 		       w1_master_attribute_show_##_name, NULL)
 
 static W1_MASTER_ATTR_RO(name, S_IRUGO);
-static W1_MASTER_ATTR_RO(slaves, S_IRUGO);
-static W1_MASTER_ATTR_RO(slave_count, S_IRUGO);
 static W1_MASTER_ATTR_RO(max_slave_count, S_IRUGO);
-static W1_MASTER_ATTR_RO(attempts, S_IRUGO);
 static W1_MASTER_ATTR_RO(timeout, S_IRUGO);
-static W1_MASTER_ATTR_RO(pointer, S_IRUGO);
 
 static struct attribute *w1_master_default_attrs[] = {
 	&w1_master_attribute_name.attr,
-	&w1_master_attribute_slaves.attr,
-	&w1_master_attribute_slave_count.attr,
 	&w1_master_attribute_max_slave_count.attr,
-	&w1_master_attribute_attempts.attr,
 	&w1_master_attribute_timeout.attr,
-	&w1_master_attribute_pointer.attr,
 	NULL
 };
 
@@ -432,7 +361,6 @@ static int w1_attach_slave_device(struct
 	}
 
 	sl->ttl = dev->slave_ttl;
-	dev->slave_count++;
 
 	return 0;
 }
@@ -459,33 +387,29 @@ static void w1_slave_detach(struct w1_sl
 
 static void w1_slave_found(struct w1_master *dev, u64 rn)
 {
-	int slave_count;
 	struct w1_slave *slave;
-	struct w1_reg_num *tmp;
+	struct w1_reg_num *reg_num;
+	u64 le_rn;
 
-	atomic_inc(&dev->refcnt);
+	if (!rn)
+		return;
 
-	tmp = (struct w1_reg_num *) &rn;
+	reg_num = (struct w1_reg_num *) &rn;
+	le_rn = cpu_to_le64(rn);
+	if (w1_calc_crc8((u8 *)&le_rn, 7) != reg_num->crc)
+		return; /* bad CRC */
 
-	slave_count = 0;
 	list_for_each_entry(slave, &dev->slist, node) {
 
-		if (slave->reg_num.family == tmp->family &&
-		    slave->reg_num.id == tmp->id &&
-		    slave->reg_num.crc == tmp->crc) {
+		if (slave->reg_num.family == reg_num->family &&
+		    slave->reg_num.id == reg_num->id) {
 			set_bit(W1_SLAVE_ACTIVE, &slave->flags);
-			break;
+			slave->ttl = dev->slave_ttl;
+			return;
 		}
-		slave_count++;
 	}
 
-	if (slave_count == dev->slave_count && rn) {
-		tmp = cpu_to_le64(rn);
-		if (((rn >> 56) & 0xff) == w1_calc_crc8((u8 *)&tmp, 7))
-			w1_attach_slave_device(dev, (struct w1_reg_num *) &rn);
-	}
-
-	atomic_dec(&dev->refcnt);
+	w1_attach_slave_device(dev, reg_num);
 }
 
 
@@ -520,13 +444,11 @@ static int w1_process(void *data)
 
 		list_for_each_entry_safe(slave, next, &dev->slist, node) {
 
-			if (test_bit(W1_SLAVE_ACTIVE, &slave->flags))
-				slave->ttl = dev->slave_ttl;
-			else if (!--slave->ttl) {
+			if (!test_bit(W1_SLAVE_ACTIVE, &slave->flags) &&
+			    !--slave->ttl) {
 				list_del(&slave->node);
 				w1_slave_detach(slave);
 				kfree(slave);
-				dev->slave_count--;
 			}
 		}
 		up(&dev->mutex);
Index: dtor/drivers/w1/w1_io.c
===================================================================
--- dtor.orig/drivers/w1/w1_io.c
+++ dtor/drivers/w1/w1_io.c
@@ -267,7 +267,6 @@ static void w1_search(struct w1_master *
 
 void w1_search_devices(struct w1_master *dev, w1_slave_found_callback cb)
 {
-	dev->attempts++;
 	if (dev->bus_ops->search)
 		dev->bus_ops->search(dev, cb);
 	else
Index: dtor/drivers/w1/w1.h
===================================================================
--- dtor.orig/drivers/w1/w1.h
+++ dtor/drivers/w1/w1.h
@@ -105,8 +105,7 @@ struct w1_master
 {
 	unsigned char		name[W1_MAXNAMELEN];
 	struct list_head	slist;
-	int			max_slave_count, slave_count;
-	unsigned long		attempts;
+	int			max_slave_count;
 	int			slave_ttl;
 	int			initialized;
 	u32			id;
