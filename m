Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262917AbVAQWHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262917AbVAQWHb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 17:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262916AbVAQWHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 17:07:02 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:64722 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262917AbVAQVt1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 16:49:27 -0500
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] w1: add ->search() method.
In-Reply-To: <20050117214727.GC28400@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 17 Jan 2005 13:48:02 -0800
Message-Id: <1105998482642@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2329.2.1, 2005/01/14 15:01:17-08:00, johnpol@2ka.mipt.ru

[PATCH] w1: add ->search() method.

Patch allows w1_search() to be overwritten by bus_master drivers.
It is very usefull for several devices, like found in iPaq w1 bus master,
which does not support bit operations but has hardware implemented
search algorithm.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/w1/w1.c    |  105 ++++++++++++++++++++++++++++++++++-------------------
 drivers/w1/w1.h    |    5 ++
 drivers/w1/w1_io.c |   10 +++++
 drivers/w1/w1_io.h |    1 
 4 files changed, 85 insertions(+), 36 deletions(-)


diff -Nru a/drivers/w1/w1.c b/drivers/w1/w1.c
--- a/drivers/w1/w1.c	2005-01-17 12:17:49 -08:00
+++ b/drivers/w1/w1.c	2005-01-17 12:17:49 -08:00
@@ -468,17 +468,75 @@
 	w1_netlink_send(sl->master, &msg);
 }
 
-static void w1_search(struct w1_master *dev)
+static struct w1_master *w1_search_master(unsigned long data)
 {
-	u64 last, rn, tmp;
-	int i, count = 0, slave_count;
-	int last_family_desc, last_zero, last_device;
-	int search_bit, id_bit, comp_bit, desc_bit;
-	struct list_head *ent;
+	struct w1_master *dev;
+	int found = 0;
+	
+	spin_lock_irq(&w1_mlock);
+	list_for_each_entry(dev, &w1_masters, w1_master_entry) {
+		if (dev->bus_master->data == data) {
+			found = 1;
+			atomic_inc(&dev->refcnt);
+			break;
+		}
+	}
+	spin_unlock_irq(&w1_mlock);
+
+	return (found)?dev:NULL;
+}
+
+void w1_slave_found(unsigned long data, u64 rn)
+{
+	int slave_count;
 	struct w1_slave *sl;
+	struct list_head *ent;
+	struct w1_reg_num *tmp;
 	int family_found = 0;
+	struct w1_master *dev;
+
+	dev = w1_search_master(data);
+	if (!dev) {
+		printk(KERN_ERR "Failed to find w1 master device for data %08lx, it is impossible.\n",
+				data);
+		return;
+	}
+	
+	tmp = (struct w1_reg_num *) &rn;
+
+	slave_count = 0;
+	list_for_each(ent, &dev->slist) {
+
+		sl = list_entry(ent, struct w1_slave, w1_slave_entry);
 
-	dev->attempts++;
+		if (sl->reg_num.family == tmp->family &&
+		    sl->reg_num.id == tmp->id &&
+		    sl->reg_num.crc == tmp->crc) {
+			set_bit(W1_SLAVE_ACTIVE, (long *)&sl->flags);
+			break;
+		}
+		else if (sl->reg_num.family == tmp->family) {
+			family_found = 1;
+			break;
+		}
+
+		slave_count++;
+	}
+
+	if (slave_count == dev->slave_count &&
+		rn && ((rn >> 56) & 0xff) == w1_calc_crc8((u8 *)&rn, 7)) {
+		w1_attach_slave_device(dev, (struct w1_reg_num *) &rn);
+	}
+			
+	atomic_dec(&dev->refcnt);
+}
+
+void w1_search(struct w1_master *dev)
+{
+	u64 last, rn, tmp;
+	int i, count = 0;
+	int last_family_desc, last_zero, last_device;
+	int search_bit, id_bit, comp_bit, desc_bit;
 
 	search_bit = id_bit = comp_bit = 0;
 	rn = tmp = last = 0;
@@ -556,33 +614,8 @@
 			last_device = 1;
 
 		desc_bit = last_zero;
-
-		slave_count = 0;
-		list_for_each(ent, &dev->slist) {
-			struct w1_reg_num *tmp;
-
-			tmp = (struct w1_reg_num *) &rn;
-
-			sl = list_entry(ent, struct w1_slave, w1_slave_entry);
-
-			if (sl->reg_num.family == tmp->family &&
-			    sl->reg_num.id == tmp->id &&
-			    sl->reg_num.crc == tmp->crc) {
-				set_bit(W1_SLAVE_ACTIVE, (long *)&sl->flags);
-				break;
-			}
-			else if (sl->reg_num.family == tmp->family) {
-				family_found = 1;
-				break;
-			}
-
-			slave_count++;
-		}
-
-		if (slave_count == dev->slave_count &&
-			rn && ((rn >> 56) & 0xff) == w1_calc_crc8((u8 *)&rn, 7)) {
-			w1_attach_slave_device(dev, (struct w1_reg_num *) &rn);
-		}
+	
+		w1_slave_found(dev->bus_master->data, rn);
 	}
 }
 
@@ -724,8 +757,8 @@
 				clear_bit(W1_SLAVE_ACTIVE, (long *)&sl->flags);
 		}
 		
-      		w1_search(dev);
-		
+		w1_search_devices(dev, w1_slave_found);
+
 		list_for_each_safe(ent, n, &dev->slist) {
 			sl = list_entry(ent, struct w1_slave, w1_slave_entry);
 
diff -Nru a/drivers/w1/w1.h b/drivers/w1/w1.h
--- a/drivers/w1/w1.h	2005-01-17 12:17:49 -08:00
+++ b/drivers/w1/w1.h	2005-01-17 12:17:49 -08:00
@@ -74,6 +74,8 @@
 	struct device_attribute	attr_name, attr_val;
 };
 
+typedef void (* w1_slave_found_callback)(unsigned long, u64);
+
 struct w1_bus_master
 {
 	unsigned long		data;
@@ -90,6 +92,8 @@
   	u8			(*touch_bit)(unsigned long, u8);
   
   	u8			(*reset_bus)(unsigned long);
+
+	void			(*search)(unsigned long, w1_slave_found_callback);
 };
 
 struct w1_master
@@ -127,6 +131,7 @@
 
 int w1_create_master_attributes(struct w1_master *);
 void w1_destroy_master_attributes(struct w1_master *);
+void w1_search(struct w1_master *dev);
 
 #endif /* __KERNEL__ */
 
diff -Nru a/drivers/w1/w1_io.c b/drivers/w1/w1_io.c
--- a/drivers/w1/w1_io.c	2005-01-17 12:17:49 -08:00
+++ b/drivers/w1/w1_io.c	2005-01-17 12:17:49 -08:00
@@ -174,6 +174,15 @@
 	return crc;
 }
 
+void w1_search_devices(struct w1_master *dev, w1_slave_found_callback cb)
+{
+	dev->attempts++;
+	if (dev->bus_master->search)
+		dev->bus_master->search(dev->bus_master->data, cb);
+	else
+		w1_search(dev);
+}
+
 EXPORT_SYMBOL(w1_write_bit);
 EXPORT_SYMBOL(w1_write_8);
 EXPORT_SYMBOL(w1_read_bit);
@@ -183,3 +192,4 @@
 EXPORT_SYMBOL(w1_delay);
 EXPORT_SYMBOL(w1_read_block);
 EXPORT_SYMBOL(w1_write_block);
+EXPORT_SYMBOL(w1_search_devices);
diff -Nru a/drivers/w1/w1_io.h b/drivers/w1/w1_io.h
--- a/drivers/w1/w1_io.h	2005-01-17 12:17:49 -08:00
+++ b/drivers/w1/w1_io.h	2005-01-17 12:17:49 -08:00
@@ -34,5 +34,6 @@
 u8 w1_calc_crc8(u8 *, int);
 void w1_write_block(struct w1_master *, u8 *, int);
 u8 w1_read_block(struct w1_master *, u8 *, int);
+void w1_search_devices(struct w1_master *dev, w1_slave_found_callback cb);
 
 #endif /* __W1_IO_H */

