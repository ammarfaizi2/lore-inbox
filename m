Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268214AbUJTA0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268214AbUJTA0N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 20:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269503AbUJTAZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:25:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:19892 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268069AbUJTATg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:19:36 -0400
Subject: Re: [PATCH] I2C update for 2.6.9
In-Reply-To: <10982315044129@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 19 Oct 2004 17:18:24 -0700
Message-Id: <10982315043649@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1832.73.7, 2004/09/08 13:17:56-07:00, johnpol@2ka.mipt.ru

[PATCH] w1: Added slave->ttl - time to live for the registered slave.

Added slave->ttl - time to live for the registered slave.
When slave was not found we will not remove it immediately but wait until ->ttl attempts were done.
It prevents various debouncing effects(problems with pull-up, power).

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/w1/w1.c     |    9 +++++++--
 drivers/w1/w1.h     |    2 ++
 drivers/w1/w1_int.c |    6 ++++--
 drivers/w1/w1_int.h |    2 +-
 4 files changed, 14 insertions(+), 5 deletions(-)


diff -Nru a/drivers/w1/w1.c b/drivers/w1/w1.c
--- a/drivers/w1/w1.c	2004-10-19 16:55:31 -07:00
+++ b/drivers/w1/w1.c	2004-10-19 16:55:31 -07:00
@@ -47,9 +47,11 @@
 
 static int w1_timeout = 10;
 int w1_max_slave_count = 10;
+int w1_max_slave_ttl = 10;
 
 module_param_named(timeout, w1_timeout, int, 0);
 module_param_named(max_slave_count, w1_max_slave_count, int, 0);
+module_param_named(slave_ttl, w1_max_slave_ttl, int, 0);
 
 spinlock_t w1_mlock = SPIN_LOCK_UNLOCKED;
 LIST_HEAD(w1_masters);
@@ -431,6 +433,7 @@
 		return err;
 	}
 
+	sl->ttl = dev->slave_ttl;
 	dev->slave_count++;
 
 	memcpy(&msg.id.id, rn, sizeof(msg.id.id));
@@ -569,7 +572,7 @@
 		}
 
 		if (slave_count == dev->slave_count &&
-		    ((rn >> 56) & 0xff) == w1_calc_crc8((u8 *)&rn, 7)) {
+			rn && ((rn >> 56) & 0xff) == w1_calc_crc8((u8 *)&rn, 7)) {
 			w1_attach_slave_device(dev, (struct w1_reg_num *) &rn);
 		}
 	}
@@ -718,7 +721,7 @@
 		list_for_each_safe(ent, n, &dev->slist) {
 			sl = list_entry(ent, struct w1_slave, w1_slave_entry);
 
-			if (sl && !test_bit(W1_SLAVE_ACTIVE, (unsigned long *)&sl->flags)) {
+			if (sl && !test_bit(W1_SLAVE_ACTIVE, (unsigned long *)&sl->flags) && !--sl->ttl) {
 				list_del (&sl->w1_slave_entry);
 
 				w1_slave_detach (sl);
@@ -726,6 +729,8 @@
 
 				dev->slave_count--;
 			}
+			else if (test_bit(W1_SLAVE_ACTIVE, (unsigned long *)&sl->flags))
+				sl->ttl = dev->slave_ttl;
 		}
 		up(&dev->mutex);
 	}
diff -Nru a/drivers/w1/w1.h b/drivers/w1/w1.h
--- a/drivers/w1/w1.h	2004-10-19 16:55:31 -07:00
+++ b/drivers/w1/w1.h	2004-10-19 16:55:31 -07:00
@@ -63,6 +63,7 @@
 	atomic_t		refcnt;
 	u8			rom[9];
 	u32			flags;
+	int			ttl;
 
 	struct w1_master	*master;
 	struct w1_family 	*family;
@@ -99,6 +100,7 @@
 	struct list_head	slist;
 	int			max_slave_count, slave_count;
 	unsigned long		attempts;
+	int			slave_ttl;
 	int			initialized;
 	u32			id;
 
diff -Nru a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
--- a/drivers/w1/w1_int.c	2004-10-19 16:55:31 -07:00
+++ b/drivers/w1/w1_int.c	2004-10-19 16:55:31 -07:00
@@ -32,12 +32,13 @@
 extern struct bus_type w1_bus_type;
 extern struct device w1_device;
 extern int w1_max_slave_count;
+extern int w1_max_slave_ttl;
 extern struct list_head w1_masters;
 extern spinlock_t w1_mlock;
 
 extern int w1_process(void *);
 
-struct w1_master * w1_alloc_dev(u32 id, int slave_count,
+struct w1_master * w1_alloc_dev(u32 id, int slave_count, int slave_ttl,
 	      struct device_driver *driver, struct device *device)
 {
 	struct w1_master *dev;
@@ -65,6 +66,7 @@
 	dev->kpid 		= -1;
 	dev->initialized 	= 0;
 	dev->id 		= id;
+	dev->slave_ttl		= slave_ttl;
 
 	atomic_set(&dev->refcnt, 2);
 
@@ -121,7 +123,7 @@
 	int retval = 0;
 	struct w1_netlink_msg msg;
 
-	dev = w1_alloc_dev(w1_ids++, w1_max_slave_count, &w1_driver, &w1_device);
+	dev = w1_alloc_dev(w1_ids++, w1_max_slave_count, w1_max_slave_ttl, &w1_driver, &w1_device);
 	if (!dev)
 		return -ENOMEM;
 
diff -Nru a/drivers/w1/w1_int.h b/drivers/w1/w1_int.h
--- a/drivers/w1/w1_int.h	2004-10-19 16:55:31 -07:00
+++ b/drivers/w1/w1_int.h	2004-10-19 16:55:31 -07:00
@@ -27,7 +27,7 @@
 
 #include "w1.h"
 
-struct w1_master * w1_alloc_dev(int, struct device_driver *, struct device *);
+struct w1_master * w1_alloc_dev(u32, int, int, struct device_driver *, struct device *);
 void w1_free_dev(struct w1_master *dev);
 int w1_add_master_device(struct w1_bus_master *);
 void w1_remove_master_device(struct w1_bus_master *);

