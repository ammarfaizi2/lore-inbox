Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030338AbWFVSbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030338AbWFVSbp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbWFVSbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:31:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:55230 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030350AbWFVSas (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:30:48 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 7/14] [PATCH] w1: Use mutexes instead of semaphores.
Reply-To: Greg KH <greg@kroah.com>
Date: Thu, 22 Jun 2006 11:27:11 -0700
Message-Id: <11510008623474-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11510008583492-git-send-email-greg@kroah.com>
References: <20060622182645.GB5668@kroah.com> <11510008381000-git-send-email-greg@kroah.com> <11510008413045-git-send-email-greg@kroah.com> <11510008461301-git-send-email-greg@kroah.com> <11510008522327-git-send-email-greg@kroah.com> <11510008553417-git-send-email-greg@kroah.com> <11510008583492-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

Use mutexes instead of semaphores.
Patch tested on x86_64 and i386 with test bus master driver.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/w1/masters/ds2482.c   |   24 ++++-----
 drivers/w1/masters/ds2490.c   |   10 ++--
 drivers/w1/slaves/w1_ds2433.c |   20 +------
 drivers/w1/slaves/w1_therm.c  |   12 +---
 drivers/w1/w1.c               |  114 ++++++++++++++---------------------------
 drivers/w1/w1.h               |    5 +-
 drivers/w1/w1_int.c           |    8 +--
 drivers/w1/w1_netlink.c       |    4 +
 8 files changed, 70 insertions(+), 127 deletions(-)

diff --git a/drivers/w1/masters/ds2482.c b/drivers/w1/masters/ds2482.c
index d1cacd2..af492cc 100644
--- a/drivers/w1/masters/ds2482.c
+++ b/drivers/w1/masters/ds2482.c
@@ -125,7 +125,7 @@ struct ds2482_w1_chan {
 
 struct ds2482_data {
 	struct i2c_client	client;
-	struct semaphore	access_lock;
+	struct mutex		access_lock;
 
 	/* 1-wire interface(s) */
 	int			w1_count;	/* 1 or 8 */
@@ -265,7 +265,7 @@ static u8 ds2482_w1_touch_bit(void *data
 	struct ds2482_data    *pdev = pchan->pdev;
 	int status = -1;
 
-	down(&pdev->access_lock);
+	mutex_lock(&pdev->access_lock);
 
 	/* Select the channel */
 	ds2482_wait_1wire_idle(pdev);
@@ -277,7 +277,7 @@ static u8 ds2482_w1_touch_bit(void *data
 				  bit ? 0xFF : 0))
 		status = ds2482_wait_1wire_idle(pdev);
 
-	up(&pdev->access_lock);
+	mutex_unlock(&pdev->access_lock);
 
 	return (status & DS2482_REG_STS_SBR) ? 1 : 0;
 }
@@ -297,7 +297,7 @@ static u8 ds2482_w1_triplet(void *data, 
 	struct ds2482_data    *pdev = pchan->pdev;
 	int status = (3 << 5);
 
-	down(&pdev->access_lock);
+	mutex_lock(&pdev->access_lock);
 
 	/* Select the channel */
 	ds2482_wait_1wire_idle(pdev);
@@ -309,7 +309,7 @@ static u8 ds2482_w1_triplet(void *data, 
 				  dbit ? 0xFF : 0))
 		status = ds2482_wait_1wire_idle(pdev);
 
-	up(&pdev->access_lock);
+	mutex_unlock(&pdev->access_lock);
 
 	/* Decode the status */
 	return (status >> 5);
@@ -326,7 +326,7 @@ static void ds2482_w1_write_byte(void *d
 	struct ds2482_w1_chan *pchan = data;
 	struct ds2482_data    *pdev = pchan->pdev;
 
-	down(&pdev->access_lock);
+	mutex_lock(&pdev->access_lock);
 
 	/* Select the channel */
 	ds2482_wait_1wire_idle(pdev);
@@ -336,7 +336,7 @@ static void ds2482_w1_write_byte(void *d
 	/* Send the write byte command */
 	ds2482_send_cmd_data(pdev, DS2482_CMD_1WIRE_WRITE_BYTE, byte);
 
-	up(&pdev->access_lock);
+	mutex_unlock(&pdev->access_lock);
 }
 
 /**
@@ -351,7 +351,7 @@ static u8 ds2482_w1_read_byte(void *data
 	struct ds2482_data    *pdev = pchan->pdev;
 	int result;
 
-	down(&pdev->access_lock);
+	mutex_lock(&pdev->access_lock);
 
 	/* Select the channel */
 	ds2482_wait_1wire_idle(pdev);
@@ -370,7 +370,7 @@ static u8 ds2482_w1_read_byte(void *data
 	/* Read the data byte */
 	result = i2c_smbus_read_byte(&pdev->client);
 
-	up(&pdev->access_lock);
+	mutex_unlock(&pdev->access_lock);
 
 	return result;
 }
@@ -389,7 +389,7 @@ static u8 ds2482_w1_reset_bus(void *data
 	int err;
 	u8 retval = 1;
 
-	down(&pdev->access_lock);
+	mutex_lock(&pdev->access_lock);
 
 	/* Select the channel */
 	ds2482_wait_1wire_idle(pdev);
@@ -409,7 +409,7 @@ static u8 ds2482_w1_reset_bus(void *data
 					     0xF0);
 	}
 
-	up(&pdev->access_lock);
+	mutex_unlock(&pdev->access_lock);
 
 	return retval;
 }
@@ -482,7 +482,7 @@ static int ds2482_detect(struct i2c_adap
 	snprintf(new_client->name, sizeof(new_client->name), "ds2482-%d00",
 		 data->w1_count);
 
-	init_MUTEX(&data->access_lock);
+	mutex_init(&data->access_lock);
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
diff --git a/drivers/w1/masters/ds2490.c b/drivers/w1/masters/ds2490.c
index 6376778..299e274 100644
--- a/drivers/w1/masters/ds2490.c
+++ b/drivers/w1/masters/ds2490.c
@@ -169,7 +169,7 @@ static int ds_send_control(struct ds_dev
 static int ds_send_control_cmd(struct ds_device *, u16, u16);
 
 static LIST_HEAD(ds_devices);
-static DECLARE_MUTEX(ds_mutex);
+static DEFINE_MUTEX(ds_mutex);
 
 static struct usb_driver ds_driver = {
 	.name =		"DS9490R",
@@ -887,9 +887,9 @@ #endif
 	if (err)
 		goto err_out_clear;
 
-	down(&ds_mutex);
+	mutex_lock(&ds_mutex);
 	list_add_tail(&dev->ds_entry, &ds_devices);
-	up(&ds_mutex);
+	mutex_unlock(&ds_mutex);
 
 	return 0;
 
@@ -909,9 +909,9 @@ static void ds_disconnect(struct usb_int
 	if (!dev)
 		return;
 
-	down(&ds_mutex);
+	mutex_lock(&ds_mutex);
 	list_del(&dev->ds_entry);
-	up(&ds_mutex);
+	mutex_unlock(&ds_mutex);
 
 	ds_w1_fini(dev);
 
diff --git a/drivers/w1/slaves/w1_ds2433.c b/drivers/w1/slaves/w1_ds2433.c
index ddd01e6..2ac238f 100644
--- a/drivers/w1/slaves/w1_ds2433.c
+++ b/drivers/w1/slaves/w1_ds2433.c
@@ -105,11 +105,7 @@ #endif
 	if ((count = w1_f23_fix_count(off, count, W1_EEPROM_SIZE)) == 0)
 		return 0;
 
-	atomic_inc(&sl->refcnt);
-	if (down_interruptible(&sl->master->mutex)) {
-		count = 0;
-		goto out_dec;
-	}
+	mutex_lock(&sl->master->mutex);
 
 #ifdef CONFIG_W1_F23_CRC
 
@@ -140,9 +136,7 @@ #else 	/* CONFIG_W1_F23_CRC */
 #endif	/* CONFIG_W1_F23_CRC */
 
 out_up:
-	up(&sl->master->mutex);
-out_dec:
-	atomic_dec(&sl->refcnt);
+	mutex_unlock(&sl->master->mutex);
 
 	return count;
 }
@@ -231,11 +225,7 @@ #ifdef CONFIG_W1_F23_CRC
 	}
 #endif	/* CONFIG_W1_F23_CRC */
 
-	atomic_inc(&sl->refcnt);
-	if (down_interruptible(&sl->master->mutex)) {
-		count = 0;
-		goto out_dec;
-	}
+	mutex_lock(&sl->master->mutex);
 
 	/* Can only write data to one page at a time */
 	idx = 0;
@@ -253,9 +243,7 @@ #endif	/* CONFIG_W1_F23_CRC */
 	}
 
 out_up:
-	up(&sl->master->mutex);
-out_dec:
-	atomic_dec(&sl->refcnt);
+	mutex_unlock(&sl->master->mutex);
 
 	return count;
 }
diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 44afdff..5372cfc 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -165,12 +165,7 @@ static ssize_t w1_therm_read_bin(struct 
 	u8 rom[9], crc, verdict;
 	int i, max_trying = 10;
 
-	atomic_inc(&sl->refcnt);
-	smp_mb__after_atomic_inc();
-	if (down_interruptible(&sl->master->mutex)) {
-		count = 0;
-		goto out_dec;
-	}
+	mutex_lock(&sl->master->mutex);
 
 	if (off > W1_SLAVE_DATA_SIZE) {
 		count = 0;
@@ -233,10 +228,7 @@ static ssize_t w1_therm_read_bin(struct 
 
 	count += sprintf(buf + count, "t=%d\n", w1_convert_temp(rom, sl->family->fid));
 out:
-	up(&dev->mutex);
-out_dec:
-	smp_mb__before_atomic_inc();
-	atomic_dec(&sl->refcnt);
+	mutex_unlock(&dev->mutex);
 
 	return count;
 }
diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 32d8de8..420be14 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -54,7 +54,7 @@ module_param_named(control_timeout, w1_c
 module_param_named(max_slave_count, w1_max_slave_count, int, 0);
 module_param_named(slave_ttl, w1_max_slave_ttl, int, 0);
 
-DECLARE_MUTEX(w1_mlock);
+DEFINE_MUTEX(w1_mlock);
 LIST_HEAD(w1_masters);
 
 static struct task_struct *w1_control_thread;
@@ -139,11 +139,7 @@ static ssize_t w1_default_write(struct k
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
 
-	if (down_interruptible(&sl->master->mutex)) {
-		count = 0;
-		goto out;
-	}
-
+	mutex_lock(&sl->master->mutex);
 	if (w1_reset_select_slave(sl)) {
 		count = 0;
 		goto out_up;
@@ -152,8 +148,7 @@ static ssize_t w1_default_write(struct k
 	w1_write_block(sl->master, buf, count);
 
 out_up:
-	up(&sl->master->mutex);
-out:
+	mutex_unlock(&sl->master->mutex);
 	return count;
 }
 
@@ -161,15 +156,9 @@ static ssize_t w1_default_read(struct ko
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
 
-	if (down_interruptible(&sl->master->mutex)) {
-		count = 0;
-		goto out;
-	}
-
+	mutex_lock(&sl->master->mutex);
 	w1_read_block(sl->master, buf, count);
-
-	up(&sl->master->mutex);
-out:
+	mutex_unlock(&sl->master->mutex);
 	return count;
 }
 
@@ -243,12 +232,9 @@ static ssize_t w1_master_attribute_show_
 	struct w1_master *md = dev_to_w1_master(dev);
 	ssize_t count;
 
-	if (down_interruptible (&md->mutex))
-		return -EBUSY;
-
+	mutex_lock(&md->mutex);
 	count = sprintf(buf, "%s\n", md->name);
-
-	up(&md->mutex);
+	mutex_unlock(&md->mutex);
 
 	return count;
 }
@@ -259,12 +245,9 @@ static ssize_t w1_master_attribute_store
 {
 	struct w1_master *md = dev_to_w1_master(dev);
 
-	if (down_interruptible (&md->mutex))
-		return -EBUSY;
-
+	mutex_lock(&md->mutex);
 	md->search_count = simple_strtol(buf, NULL, 0);
-
-	up(&md->mutex);
+	mutex_unlock(&md->mutex);
 
 	return count;
 }
@@ -276,12 +259,9 @@ static ssize_t w1_master_attribute_show_
 	struct w1_master *md = dev_to_w1_master(dev);
 	ssize_t count;
 
-	if (down_interruptible (&md->mutex))
-		return -EBUSY;
-
+	mutex_lock(&md->mutex);
 	count = sprintf(buf, "%d\n", md->search_count);
-
-	up(&md->mutex);
+	mutex_unlock(&md->mutex);
 
 	return count;
 }
@@ -291,12 +271,9 @@ static ssize_t w1_master_attribute_show_
 	struct w1_master *md = dev_to_w1_master(dev);
 	ssize_t count;
 
-	if (down_interruptible(&md->mutex))
-		return -EBUSY;
-
+	mutex_lock(&md->mutex);
 	count = sprintf(buf, "0x%p\n", md->bus_master);
-
-	up(&md->mutex);
+	mutex_unlock(&md->mutex);
 	return count;
 }
 
@@ -312,12 +289,9 @@ static ssize_t w1_master_attribute_show_
 	struct w1_master *md = dev_to_w1_master(dev);
 	ssize_t count;
 
-	if (down_interruptible(&md->mutex))
-		return -EBUSY;
-
+	mutex_lock(&md->mutex);
 	count = sprintf(buf, "%d\n", md->max_slave_count);
-
-	up(&md->mutex);
+	mutex_unlock(&md->mutex);
 	return count;
 }
 
@@ -326,12 +300,9 @@ static ssize_t w1_master_attribute_show_
 	struct w1_master *md = dev_to_w1_master(dev);
 	ssize_t count;
 
-	if (down_interruptible(&md->mutex))
-		return -EBUSY;
-
+	mutex_lock(&md->mutex);
 	count = sprintf(buf, "%lu\n", md->attempts);
-
-	up(&md->mutex);
+	mutex_unlock(&md->mutex);
 	return count;
 }
 
@@ -340,12 +311,9 @@ static ssize_t w1_master_attribute_show_
 	struct w1_master *md = dev_to_w1_master(dev);
 	ssize_t count;
 
-	if (down_interruptible(&md->mutex))
-		return -EBUSY;
-
+	mutex_lock(&md->mutex);
 	count = sprintf(buf, "%d\n", md->slave_count);
-
-	up(&md->mutex);
+	mutex_unlock(&md->mutex);
 	return count;
 }
 
@@ -354,8 +322,7 @@ static ssize_t w1_master_attribute_show_
 	struct w1_master *md = dev_to_w1_master(dev);
 	int c = PAGE_SIZE;
 
-	if (down_interruptible(&md->mutex))
-		return -EBUSY;
+	mutex_lock(&md->mutex);
 
 	if (md->slave_count == 0)
 		c -= snprintf(buf + PAGE_SIZE - c, c, "not found.\n");
@@ -370,7 +337,7 @@ static ssize_t w1_master_attribute_show_
 		}
 	}
 
-	up(&md->mutex);
+	mutex_unlock(&md->mutex);
 
 	return PAGE_SIZE - c;
 }
@@ -620,7 +587,7 @@ static struct w1_master *w1_search_maste
 	struct w1_master *dev;
 	int found = 0;
 
-	down(&w1_mlock);
+	mutex_lock(&w1_mlock);
 	list_for_each_entry(dev, &w1_masters, w1_master_entry) {
 		if (dev->bus_master->data == data) {
 			found = 1;
@@ -628,7 +595,7 @@ static struct w1_master *w1_search_maste
 			break;
 		}
 	}
-	up(&w1_mlock);
+	mutex_unlock(&w1_mlock);
 
 	return (found)?dev:NULL;
 }
@@ -638,7 +605,7 @@ struct w1_master *w1_search_master_id(u3
 	struct w1_master *dev;
 	int found = 0;
 
-	down(&w1_mlock);
+	mutex_lock(&w1_mlock);
 	list_for_each_entry(dev, &w1_masters, w1_master_entry) {
 		if (dev->id == id) {
 			found = 1;
@@ -646,7 +613,7 @@ struct w1_master *w1_search_master_id(u3
 			break;
 		}
 	}
-	up(&w1_mlock);
+	mutex_unlock(&w1_mlock);
 
 	return (found)?dev:NULL;
 }
@@ -657,9 +624,9 @@ struct w1_slave *w1_search_slave(struct 
 	struct w1_slave *sl = NULL;
 	int found = 0;
 
-	down(&w1_mlock);
+	mutex_lock(&w1_mlock);
 	list_for_each_entry(dev, &w1_masters, w1_master_entry) {
-		down(&dev->mutex);
+		mutex_lock(&dev->mutex);
 		list_for_each_entry(sl, &dev->slist, w1_slave_entry) {
 			if (sl->reg_num.family == id->family &&
 					sl->reg_num.id == id->id &&
@@ -670,12 +637,12 @@ struct w1_slave *w1_search_slave(struct 
 				break;
 			}
 		}
-		up(&dev->mutex);
+		mutex_unlock(&dev->mutex);
 
 		if (found)
 			break;
 	}
-	up(&w1_mlock);
+	mutex_unlock(&w1_mlock);
 
 	return (found)?sl:NULL;
 }
@@ -684,13 +651,13 @@ void w1_reconnect_slaves(struct w1_famil
 {
 	struct w1_master *dev;
 
-	down(&w1_mlock);
+	mutex_lock(&w1_mlock);
 	list_for_each_entry(dev, &w1_masters, w1_master_entry) {
 		dev_dbg(&dev->dev, "Reconnecting slaves in %s into new family %02x.\n",
 				dev->name, f->fid);
 		set_bit(W1_MASTER_NEED_RECONNECT, &dev->flags);
 	}
-	up(&w1_mlock);
+	mutex_unlock(&w1_mlock);
 }
 
 static void w1_slave_found(void *data, u64 rn)
@@ -845,23 +812,23 @@ static int w1_control(void *data)
 			if (kthread_should_stop() || test_bit(W1_MASTER_NEED_EXIT, &dev->flags)) {
 				set_bit(W1_MASTER_NEED_EXIT, &dev->flags);
 
-				down(&w1_mlock);
+				mutex_lock(&w1_mlock);
 				list_del(&dev->w1_master_entry);
-				up(&w1_mlock);
+				mutex_unlock(&w1_mlock);
 
-				down(&dev->mutex);
+				mutex_lock(&dev->mutex);
 				list_for_each_entry_safe(sl, sln, &dev->slist, w1_slave_entry) {
 					w1_slave_detach(sl);
 				}
 				w1_destroy_master_attributes(dev);
-				up(&dev->mutex);
+				mutex_unlock(&dev->mutex);
 				atomic_dec(&dev->refcnt);
 				continue;
 			}
 
 			if (test_bit(W1_MASTER_NEED_RECONNECT, &dev->flags)) {
 				dev_dbg(&dev->dev, "Reconnecting slaves in device %s.\n", dev->name);
-				down(&dev->mutex);
+				mutex_lock(&dev->mutex);
 				list_for_each_entry_safe(sl, sln, &dev->slist, w1_slave_entry) {
 					if (sl->family->fid == W1_FAMILY_DEFAULT) {
 						struct w1_reg_num rn;
@@ -874,7 +841,7 @@ static int w1_control(void *data)
 				}
 				dev_dbg(&dev->dev, "Reconnecting slaves in device %s has been finished.\n", dev->name);
 				clear_bit(W1_MASTER_NEED_RECONNECT, &dev->flags);
-				up(&dev->mutex);
+				mutex_unlock(&dev->mutex);
 			}
 		}
 	}
@@ -921,12 +888,9 @@ int w1_process(void *data)
 		if (dev->search_count == 0)
 			continue;
 
-		if (down_interruptible(&dev->mutex))
-			continue;
-
+		mutex_lock(&dev->mutex);
 		w1_search_process(dev, W1_SEARCH);
-
-		up(&dev->mutex);
+		mutex_unlock(&dev->mutex);
 	}
 
 	atomic_dec(&dev->refcnt);
diff --git a/drivers/w1/w1.h b/drivers/w1/w1.h
index e8c96e6..6caccfc 100644
--- a/drivers/w1/w1.h
+++ b/drivers/w1/w1.h
@@ -41,8 +41,7 @@ #ifdef __KERNEL__
 
 #include <linux/completion.h>
 #include <linux/device.h>
-
-#include <asm/semaphore.h>
+#include <linux/mutex.h>
 
 #include "w1_family.h"
 
@@ -171,7 +170,7 @@ struct w1_master
 	long			flags;
 
 	struct task_struct	*thread;
-	struct semaphore	mutex;
+	struct mutex		mutex;
 
 	struct device_driver	*driver;
 	struct device		dev;
diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
index ae78473..24e7c10 100644
--- a/drivers/w1/w1_int.c
+++ b/drivers/w1/w1_int.c
@@ -36,7 +36,7 @@ extern struct device w1_master_device;
 extern int w1_max_slave_count;
 extern int w1_max_slave_ttl;
 extern struct list_head w1_masters;
-extern struct semaphore w1_mlock;
+extern struct mutex w1_mlock;
 
 extern int w1_process(void *);
 
@@ -74,7 +74,7 @@ static struct w1_master * w1_alloc_dev(u
 	atomic_set(&dev->refcnt, 2);
 
 	INIT_LIST_HEAD(&dev->slist);
-	init_MUTEX(&dev->mutex);
+	mutex_init(&dev->mutex);
 
 	memcpy(&dev->dev, device, sizeof(struct device));
 	snprintf(dev->dev.bus_id, sizeof(dev->dev.bus_id),
@@ -135,9 +135,9 @@ int w1_add_master_device(struct w1_bus_m
 
 	dev->initialized = 1;
 
-	down(&w1_mlock);
+	mutex_lock(&w1_mlock);
 	list_add(&dev->w1_master_entry, &w1_masters);
-	up(&w1_mlock);
+	mutex_unlock(&w1_mlock);
 
 	memset(&msg, 0, sizeof(msg));
 	msg.id.mst.id = dev->id;
diff --git a/drivers/w1/w1_netlink.c b/drivers/w1/w1_netlink.c
index d539e09..65c5ebd 100644
--- a/drivers/w1/w1_netlink.c
+++ b/drivers/w1/w1_netlink.c
@@ -171,7 +171,7 @@ #endif
 			goto out_cont;
 		}
 
-		down(&dev->mutex);
+		mutex_lock(&dev->mutex);
 
 		if (sl && w1_reset_select_slave(sl)) {
 			err = -ENODEV;
@@ -198,7 +198,7 @@ out_up:
 		atomic_dec(&dev->refcnt);
 		if (sl)
 			atomic_dec(&sl->refcnt);
-		up(&dev->mutex);
+		mutex_unlock(&dev->mutex);
 out_cont:
 		msg->len -= sizeof(struct w1_netlink_msg) + m->len;
 		m = (struct w1_netlink_msg *)(((u8 *)m) + sizeof(struct w1_netlink_msg) + m->len);
-- 
1.4.0

