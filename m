Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVDUHqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVDUHqy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 03:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVDUHoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 03:44:03 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:43703 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261437AbVDUHaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 03:30:12 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: sensors@Stimpy.netroedge.com
Subject: [RFC/PATCH 5/22] W1: list handling cleanup
Date: Thu, 21 Apr 2005 02:11:52 -0500
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
Message-Id: <200504210211.53134.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

W1: list handling cleanup. Most of the list_for_each_safe users
    don't need *_safe variant, *_entry variant is better suited
    in most places. Also, checking retrieved list element for
    null is a bit pointless...

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 w1.c     |  131 +++++++++++++++++++++++----------------------------------------
 w1.h     |    6 +-
 w1_int.c |   23 +++--------
 3 files changed, 58 insertions(+), 102 deletions(-)

Index: dtor/drivers/w1/w1.c
===================================================================
--- dtor.orig/drivers/w1/w1.c
+++ dtor/drivers/w1/w1.c
@@ -184,6 +184,7 @@ static ssize_t w1_master_attribute_show_
 
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
+	struct w1_slave *slave;
 	int c = PAGE_SIZE;
 
 	if (down_interruptible(&md->mutex))
@@ -191,16 +192,9 @@ static ssize_t w1_master_attribute_show_
 
 	if (md->slave_count == 0)
 		c -= snprintf(buf + PAGE_SIZE - c, c, "not found.\n");
-	else {
-		struct list_head *ent, *n;
-		struct w1_slave *sl;
-
-		list_for_each_safe(ent, n, &md->slist) {
-			sl = list_entry(ent, struct w1_slave, w1_slave_entry);
-
-			c -= snprintf(buf + PAGE_SIZE - c, c, "%s\n", sl->name);
-		}
-	}
+	else
+		list_for_each_entry(slave, &md->slist, node)
+			c -= snprintf(buf + PAGE_SIZE - c, c, "%s\n", slave->name);
 
 	up(&md->mutex);
 
@@ -391,7 +385,7 @@ static int __w1_attach_slave_device(stru
 		return err;
 	}
 
-	list_add_tail(&sl->w1_slave_entry, &sl->master->slist);
+	list_add_tail(&sl->node, &sl->master->slist);
 
 	return 0;
 }
@@ -415,7 +409,7 @@ static int w1_attach_slave_device(struct
 
 	sl->owner = THIS_MODULE;
 	sl->master = dev;
-	set_bit(W1_SLAVE_ACTIVE, (long *)&sl->flags);
+	set_bit(W1_SLAVE_ACTIVE, &sl->flags);
 
 	memcpy(&sl->reg_num, rn, sizeof(sl->reg_num));
 	atomic_set(&sl->refcnt, 0);
@@ -484,29 +478,27 @@ static void w1_slave_detach(struct w1_sl
 
 static struct w1_master *w1_search_master(unsigned long data)
 {
-	struct w1_master *dev;
+	struct w1_master *master;
 	int found = 0;
 
 	spin_lock_irq(&w1_mlock);
-	list_for_each_entry(dev, &w1_masters, w1_master_entry) {
-		if (dev->bus_master->data == data) {
+	list_for_each_entry(master, &w1_masters, node) {
+		if (master->bus_master->data == data) {
 			found = 1;
-			atomic_inc(&dev->refcnt);
+			atomic_inc(&master->refcnt);
 			break;
 		}
 	}
 	spin_unlock_irq(&w1_mlock);
 
-	return (found)?dev:NULL;
+	return found ? master : NULL;
 }
 
 void w1_slave_found(unsigned long data, u64 rn)
 {
 	int slave_count;
-	struct w1_slave *sl;
-	struct list_head *ent;
+	struct w1_slave *slave;
 	struct w1_reg_num *tmp;
-	int family_found = 0;
 	struct w1_master *dev;
 
 	dev = w1_search_master(data);
@@ -519,20 +511,14 @@ void w1_slave_found(unsigned long data, 
 	tmp = (struct w1_reg_num *) &rn;
 
 	slave_count = 0;
-	list_for_each(ent, &dev->slist) {
+	list_for_each_entry(slave, &dev->slist, node) {
 
-		sl = list_entry(ent, struct w1_slave, w1_slave_entry);
-
-		if (sl->reg_num.family == tmp->family &&
-		    sl->reg_num.id == tmp->id &&
-		    sl->reg_num.crc == tmp->crc) {
-			set_bit(W1_SLAVE_ACTIVE, (long *)&sl->flags);
-			break;
-		} else if (sl->reg_num.family == tmp->family) {
-			family_found = 1;
+		if (slave->reg_num.family == tmp->family &&
+		    slave->reg_num.id == tmp->id &&
+		    slave->reg_num.crc == tmp->crc) {
+			set_bit(W1_SLAVE_ACTIVE, &slave->flags);
 			break;
 		}
-
 		slave_count++;
 	}
 
@@ -635,9 +621,8 @@ void w1_search(struct w1_master *dev)
 
 int w1_control(void *data)
 {
-	struct w1_slave *sl;
-	struct w1_master *dev;
-	struct list_head *ent, *ment, *n, *mn;
+	struct w1_slave *slave, *nexts;
+	struct w1_master *master, *nextm;
 	int err, have_to_wait = 0;
 
 	daemonize("w1_control");
@@ -652,52 +637,42 @@ int w1_control(void *data)
 		if (signal_pending(current))
 			flush_signals(current);
 
-		list_for_each_safe(ment, mn, &w1_masters) {
-			dev = list_entry(ment, struct w1_master, w1_master_entry);
+		list_for_each_entry_safe(master, nextm, &w1_masters, node) {
 
-			if (!control_needs_exit && !dev->need_exit)
+			if (!control_needs_exit && !master->need_exit)
 				continue;
 			/*
 			 * Little race: we can create thread but not set the flag.
 			 * Get a chance for external process to set flag up.
 			 */
-			if (!dev->initialized) {
+			if (!master->initialized) {
 				have_to_wait = 1;
 				continue;
 			}
 
 			spin_lock(&w1_mlock);
-			list_del(&dev->w1_master_entry);
+			list_del(&master->node);
 			spin_unlock(&w1_mlock);
 
 			if (control_needs_exit) {
-				dev->need_exit = 1;
+				master->need_exit = 1;
 
-				err = kill_proc(dev->kpid, SIGTERM, 1);
+				err = kill_proc(master->kpid, SIGTERM, 1);
 				if (err)
-					dev_err(&dev->dev,
+					dev_err(&master->dev,
 						 "Failed to send signal to w1 kernel thread %d.\n",
-						 dev->kpid);
+						 master->kpid);
 			}
 
-			wait_for_completion(&dev->dev_exited);
+			wait_for_completion(&master->dev_exited);
 
-			list_for_each_safe(ent, n, &dev->slist) {
-				sl = list_entry(ent, struct w1_slave, w1_slave_entry);
-
-				if (!sl)
-					dev_warn(&dev->dev,
-						  "%s: slave entry is NULL.\n",
-						  __func__);
-				else {
-					list_del(&sl->w1_slave_entry);
-
-					w1_slave_detach(sl);
-					kfree(sl);
-				}
+			list_for_each_entry_safe(slave, nexts, &master->slist, node) {
+				list_del(&slave->node);
+				w1_slave_detach(slave);
+				kfree(slave);
 			}
-			w1_destroy_master_attributes(dev);
-			atomic_dec(&dev->refcnt);
+			w1_destroy_master_attributes(master);
+			atomic_dec(&master->refcnt);
 		}
 	}
 
@@ -707,8 +682,7 @@ int w1_control(void *data)
 int w1_process(void *data)
 {
 	struct w1_master *dev = (struct w1_master *) data;
-	struct list_head *ent, *n;
-	struct w1_slave *sl;
+	struct w1_slave *slave, *next;
 
 	daemonize("%s", dev->name);
 	allow_signal(SIGTERM);
@@ -729,27 +703,21 @@ int w1_process(void *data)
 		if (down_interruptible(&dev->mutex))
 			continue;
 
-		list_for_each_safe(ent, n, &dev->slist) {
-			sl = list_entry(ent, struct w1_slave, w1_slave_entry);
-
-			if (sl)
-				clear_bit(W1_SLAVE_ACTIVE, (long *)&sl->flags);
-		}
+		list_for_each_entry(slave, &dev->slist, node)
+			clear_bit(W1_SLAVE_ACTIVE, &slave->flags);
 
 		w1_search_devices(dev, w1_slave_found);
 
-		list_for_each_safe(ent, n, &dev->slist) {
-			sl = list_entry(ent, struct w1_slave, w1_slave_entry);
-
-			if (sl && !test_bit(W1_SLAVE_ACTIVE, (unsigned long *)&sl->flags) && !--sl->ttl) {
-				list_del (&sl->w1_slave_entry);
-
-				w1_slave_detach (sl);
-				kfree (sl);
+		list_for_each_entry_safe(slave, next, &dev->slist, node) {
 
+			if (test_bit(W1_SLAVE_ACTIVE, &slave->flags))
+				slave->ttl = dev->slave_ttl;
+			else if (!--slave->ttl) {
+				list_del(&slave->node);
+				w1_slave_detach(slave);
+				kfree(slave);
 				dev->slave_count--;
-			} else if (test_bit(W1_SLAVE_ACTIVE, (unsigned long *)&sl->flags))
-				sl->ttl = dev->slave_ttl;
+			}
 		}
 		up(&dev->mutex);
 	}
@@ -802,13 +770,10 @@ err_out_exit_init:
 
 void w1_fini(void)
 {
-	struct w1_master *dev;
-	struct list_head *ent, *n;
+	struct w1_master *master, *next;
 
-	list_for_each_safe(ent, n, &w1_masters) {
-		dev = list_entry(ent, struct w1_master, w1_master_entry);
-		__w1_remove_master_device(dev);
-	}
+	list_for_each_entry_safe(master, next, &w1_masters, node)
+		__w1_remove_master_device(master);
 
 	control_needs_exit = 1;
 
Index: dtor/drivers/w1/w1.h
===================================================================
--- dtor.orig/drivers/w1/w1.h
+++ dtor/drivers/w1/w1.h
@@ -66,11 +66,11 @@ struct w1_slave
 {
 	struct module		*owner;
 	unsigned char		name[W1_MAXNAMELEN];
-	struct list_head	w1_slave_entry;
+	struct list_head	node;
 	struct w1_reg_num	reg_num;
 	atomic_t		refcnt;
 	u8			rom[9];
-	u32			flags;
+	unsigned long		flags;
 	int			ttl;
 
 	struct w1_master	*master;
@@ -107,7 +107,7 @@ struct w1_bus_master
 
 struct w1_master
 {
-	struct list_head	w1_master_entry;
+	struct list_head	node;
 	struct module		*owner;
 	unsigned char		name[W1_MAXNAMELEN];
 	struct list_head	slist;
Index: dtor/drivers/w1/w1_int.c
===================================================================
--- dtor.orig/drivers/w1/w1_int.c
+++ dtor/drivers/w1/w1_int.c
@@ -142,7 +142,7 @@ int w1_add_master_device(struct w1_bus_m
 	dev->initialized = 1;
 
 	spin_lock(&w1_mlock);
-	list_add(&dev->w1_master_entry, &w1_masters);
+	list_add(&dev->node, &w1_masters);
 	spin_unlock(&w1_mlock);
 
 	msg.id.mst.id = dev->id;
@@ -196,24 +196,15 @@ void __w1_remove_master_device(struct w1
 
 void w1_remove_master_device(struct w1_bus_master *bm)
 {
-	struct w1_master *dev = NULL;
-	struct list_head *ent, *n;
+	struct w1_master *dev;
 
-	list_for_each_safe(ent, n, &w1_masters) {
-		dev = list_entry(ent, struct w1_master, w1_master_entry);
-		if (!dev->initialized)
-			continue;
-
-		if (dev->bus_master->data == bm->data)
+	list_for_each_entry(dev, &w1_masters, node)
+		if (dev->initialized && dev->bus_master->data == bm->data) {
+			__w1_remove_master_device(dev);
 			break;
-	}
-
-	if (!dev) {
-		printk(KERN_ERR "Device doesn't exist.\n");
-		return;
-	}
+		}
 
-	__w1_remove_master_device(dev);
+	printk(KERN_ERR "Device doesn't exist.\n");
 }
 
 EXPORT_SYMBOL(w1_add_master_device);
