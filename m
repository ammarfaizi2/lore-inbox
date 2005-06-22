Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262720AbVFVFNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbVFVFNR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 01:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbVFVFNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 01:13:17 -0400
Received: from mail.kroah.org ([69.55.234.183]:30871 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262720AbVFVFMN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:12:13 -0400
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] w1: reconnect feature.
In-Reply-To: <11194171281158@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:12:08 -0700
Message-Id: <11194171282338@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] w1: reconnect feature.

I've created reconnect feature - if on start there are no registered families
all new devices will have defailt family, later when driver for appropriate
family is loaded, slaves, which were faound earlier, will still have defult
family instead of right one. Reconnect feature will force control thread to run
through all master devices and all slaves found and search for slaves with
default family id and try to reconnect them.

It does not store newly registered family and does not check only those slaves
which have reg_num.family the same as being registered one - all slaves with
default family are reconnected.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 6adf87bd7b7832105b9c6bc08adf6a4d229f1e79
tree 1c6d17df3c4f4d753021e970a7bb898c1aabeb82
parent 4754639d88e922af451b399af09ac1bb442c35e5
author Evgeniy Polyakov <johnpol@2ka.mipt.ru> Sat, 04 Jun 2005 01:29:25 +0400
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:43:12 -0700

 drivers/w1/ds_w1_bridge.c |    4 +--
 drivers/w1/w1.c           |   70 +++++++++++++++++++++++++++++++++++----------
 drivers/w1/w1.h           |    6 +++-
 drivers/w1/w1_family.c    |    3 +-
 drivers/w1/w1_int.c       |   11 +++----
 5 files changed, 68 insertions(+), 26 deletions(-)

diff --git a/drivers/w1/ds_w1_bridge.c b/drivers/w1/ds_w1_bridge.c
--- a/drivers/w1/ds_w1_bridge.c
+++ b/drivers/w1/ds_w1_bridge.c
@@ -83,11 +83,11 @@ static u8 ds9490r_read_byte(unsigned lon
 	return byte;
 }
 
-static void ds9490r_write_block(unsigned long data, u8 *buf, int len)
+static void ds9490r_write_block(unsigned long data, const u8 *buf, int len)
 {
 	struct ds_device *dev = (struct ds_device *)data;
 
-	ds_write_block(dev, buf, len);
+	ds_write_block(dev, (u8 *)buf, len);
 }
 
 static u8 ds9490r_read_block(unsigned long data, u8 *buf, int len)
diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -469,6 +469,8 @@ static void w1_slave_detach(struct w1_sl
 	device_unregister(&sl->dev);
 	w1_family_put(sl->family);
 
+	sl->master->slave_count--;
+
 	memcpy(&msg.id.id, &sl->reg_num, sizeof(msg.id.id));
 	msg.type = W1_SLAVE_REMOVE;
 	w1_netlink_send(sl->master, &msg);
@@ -492,6 +494,20 @@ static struct w1_master *w1_search_maste
 	return (found)?dev:NULL;
 }
 
+void w1_reconnect_slaves(struct w1_family *f)
+{
+	struct w1_master *dev;
+
+	spin_lock_bh(&w1_mlock);
+	list_for_each_entry(dev, &w1_masters, w1_master_entry) {
+		dev_info(&dev->dev, "Reconnecting slaves in %s into new family %02x.\n",
+				dev->name, f->fid);
+		set_bit(W1_MASTER_NEED_RECONNECT, &dev->flags);
+	}
+	spin_unlock_bh(&w1_mlock);
+}
+
+
 static void w1_slave_found(unsigned long data, u64 rn)
 {
 	int slave_count;
@@ -637,7 +653,7 @@ static int w1_control(void *data)
 			flush_signals(current);
 
 		list_for_each_entry_safe(dev, n, &w1_masters, w1_master_entry) {
-			if (!control_needs_exit && !dev->need_exit)
+			if (!control_needs_exit && !dev->flags)
 				continue;
 			/*
 			 * Little race: we can create thread but not set the flag.
@@ -648,12 +664,8 @@ static int w1_control(void *data)
 				continue;
 			}
 
-			spin_lock_bh(&w1_mlock);
-			list_del(&dev->w1_master_entry);
-			spin_unlock_bh(&w1_mlock);
-
 			if (control_needs_exit) {
-				dev->need_exit = 1;
+				set_bit(W1_MASTER_NEED_EXIT, &dev->flags);
 
 				err = kill_proc(dev->kpid, SIGTERM, 1);
 				if (err)
@@ -662,16 +674,42 @@ static int w1_control(void *data)
 						 dev->kpid);
 			}
 
-			wait_for_completion(&dev->dev_exited);
-
-			list_for_each_entry_safe(sl, sln, &dev->slist, w1_slave_entry) {
-				list_del(&sl->w1_slave_entry);
+			if (test_bit(W1_MASTER_NEED_EXIT, &dev->flags)) {
+				wait_for_completion(&dev->dev_exited);
+				spin_lock_bh(&w1_mlock);
+				list_del(&dev->w1_master_entry);
+				spin_unlock_bh(&w1_mlock);
+
+				list_for_each_entry_safe(sl, sln, &dev->slist, w1_slave_entry) {
+					list_del(&sl->w1_slave_entry);
+
+					w1_slave_detach(sl);
+					kfree(sl);
+				}
+				w1_destroy_master_attributes(dev);
+				atomic_dec(&dev->refcnt);
+				continue;
+			}
 
-				w1_slave_detach(sl);
-				kfree(sl);
+			if (test_bit(W1_MASTER_NEED_RECONNECT, &dev->flags)) {
+				dev_info(&dev->dev, "Reconnecting slaves in device %s.\n", dev->name);
+				down(&dev->mutex);
+				list_for_each_entry(sl, &dev->slist, w1_slave_entry) {
+					if (sl->family->fid == W1_FAMILY_DEFAULT) {
+						struct w1_reg_num rn;
+						list_del(&sl->w1_slave_entry);
+						w1_slave_detach(sl);
+
+						memcpy(&rn, &sl->reg_num, sizeof(rn));
+
+						kfree(sl);
+
+						w1_attach_slave_device(dev, &rn);
+					}
+				}
+				clear_bit(W1_MASTER_NEED_RECONNECT, &dev->flags);
+				up(&dev->mutex);
 			}
-			w1_destroy_master_attributes(dev);
-			atomic_dec(&dev->refcnt);
 		}
 	}
 
@@ -686,14 +724,14 @@ int w1_process(void *data)
 	daemonize("%s", dev->name);
 	allow_signal(SIGTERM);
 
-	while (!dev->need_exit) {
+	while (!test_bit(W1_MASTER_NEED_EXIT, &dev->flags)) {
 		try_to_freeze(PF_FREEZE);
 		msleep_interruptible(w1_timeout * 1000);
 
 		if (signal_pending(current))
 			flush_signals(current);
 
-		if (dev->need_exit)
+		if (test_bit(W1_MASTER_NEED_EXIT, &dev->flags))
 			break;
 
 		if (!dev->initialized)
diff --git a/drivers/w1/w1.h b/drivers/w1/w1.h
--- a/drivers/w1/w1.h
+++ b/drivers/w1/w1.h
@@ -151,6 +151,9 @@ struct w1_bus_master
 	void		(*search)(unsigned long, w1_slave_found_callback);
 };
 
+#define W1_MASTER_NEED_EXIT		0
+#define W1_MASTER_NEED_RECONNECT	1
+
 struct w1_master
 {
 	struct list_head	w1_master_entry;
@@ -169,7 +172,8 @@ struct w1_master
 	void			*priv;
 	int			priv_size;
 
-	int			need_exit;
+	long			flags;
+
 	pid_t			kpid;
 	struct semaphore	mutex;
 
diff --git a/drivers/w1/w1_family.c b/drivers/w1/w1_family.c
--- a/drivers/w1/w1_family.c
+++ b/drivers/w1/w1_family.c
@@ -60,9 +60,10 @@ int w1_register_family(struct w1_family 
 		newf->need_exit = 0;
 		list_add_tail(&newf->family_entry, &w1_families);
 	}
-
 	spin_unlock(&w1_flock);
 
+	w1_reconnect_slaves(newf);
+
 	return ret;
 }
 
diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
--- a/drivers/w1/w1_int.c
+++ b/drivers/w1/w1_int.c
@@ -124,10 +124,9 @@ int w1_add_master_device(struct w1_bus_m
 
         /* validate minimum functionality */
         if (!(master->touch_bit && master->reset_bus) &&
-            !(master->write_bit && master->read_bit))
-        {
-           printk(KERN_ERR "w1_add_master_device: invalid function set\n");
-           return(-EINVAL);
+            !(master->write_bit && master->read_bit)) {
+		printk(KERN_ERR "w1_add_master_device: invalid function set\n");
+		return(-EINVAL);
         }
 
 	dev = w1_alloc_dev(w1_ids++, w1_max_slave_count, w1_max_slave_ttl, &w1_driver, &w1_device);
@@ -163,7 +162,7 @@ int w1_add_master_device(struct w1_bus_m
 	return 0;
 
 err_out_kill_thread:
-	dev->need_exit = 1;
+	set_bit(W1_MASTER_NEED_EXIT, &dev->flags);
 	if (kill_proc(dev->kpid, SIGTERM, 1))
 		dev_err(&dev->dev,
 			 "Failed to send signal to w1 kernel thread %d.\n",
@@ -181,7 +180,7 @@ void __w1_remove_master_device(struct w1
 	int err;
 	struct w1_netlink_msg msg;
 
-	dev->need_exit = 1;
+	set_bit(W1_MASTER_NEED_EXIT, &dev->flags);
 	err = kill_proc(dev->kpid, SIGTERM, 1);
 	if (err)
 		dev_err(&dev->dev,

