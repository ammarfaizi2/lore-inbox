Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266892AbUHXAjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266892AbUHXAjZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 20:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266898AbUHWThk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:37:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:56003 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266892AbUHWSgc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:32 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <1093286087164@kroah.com>
Date: Mon, 23 Aug 2004 11:34:47 -0700
Message-Id: <10932860871097@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.28, 2004/08/06 15:31:43-07:00, johnpol@2ka.mipt.ru

[PATCH] w1: Netlink update - changed event generating/processing.

Added following self-explanatory netlink events.

        W1_SLAVE_ADD = 0,
        W1_SLAVE_REMOVE,
        W1_MASTER_ADD,
        W1_MASTER_REMOVE,

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/w1/w1.c         |   21 ++++++++++++---------
 drivers/w1/w1_int.c     |   13 +++++++++++++
 drivers/w1/w1_netlink.h |   15 ++++++++++++++-
 3 files changed, 39 insertions(+), 10 deletions(-)


diff -Nru a/drivers/w1/w1.c b/drivers/w1/w1.c
--- a/drivers/w1/w1.c	2004-08-23 11:03:57 -07:00
+++ b/drivers/w1/w1.c	2004-08-23 11:03:57 -07:00
@@ -383,6 +383,7 @@
 	struct w1_slave *sl;
 	struct w1_family *f;
 	int err;
+	struct w1_netlink_msg msg;
 
 	sl = kmalloc(sizeof(struct w1_slave), GFP_KERNEL);
 	if (!sl) {
@@ -427,11 +428,17 @@
 
 	dev->slave_count++;
 
+	msg.id.id = *rn;
+	msg.type = W1_SLAVE_ADD;
+	w1_netlink_send(dev, &msg);
+
 	return 0;
 }
 
 static void w1_slave_detach(struct w1_slave *sl)
 {
+	struct w1_netlink_msg msg;
+	
 	dev_info(&sl->dev, "%s: detaching %s.\n", __func__, sl->name);
 
 	while (atomic_read(&sl->refcnt))
@@ -441,6 +448,10 @@
 	device_remove_file(&sl->dev, &w1_slave_attribute);
 	device_unregister(&sl->dev);
 	w1_family_put(sl->family);
+
+	msg.id.id = sl->reg_num;
+	msg.type = W1_SLAVE_REMOVE;
+	w1_netlink_send(sl->master, &msg);
 }
 
 static void w1_search(struct w1_master *dev)
@@ -452,12 +463,9 @@
 	struct list_head *ent;
 	struct w1_slave *sl;
 	int family_found = 0;
-	struct w1_netlink_msg msg;
 
 	dev->attempts++;
 
-	memset(&msg, 0, sizeof(msg));
-
 	search_bit = id_bit = comp_bit = 0;
 	rn = tmp = last = 0;
 	last_device = last_zero = last_family_desc = 0;
@@ -483,8 +491,6 @@
 		}
 
 #if 1
-		memset(&msg, 0, sizeof(msg));
-
 		w1_write_8(dev, W1_SEARCH);
 		for (i = 0; i < 64; ++i) {
 			/*
@@ -528,9 +534,6 @@
 
 		}
 #endif
-		msg.id.w1_id = rn;
-		msg.val = w1_calc_crc8((u8 *) & rn, 7);
-		w1_netlink_send(dev, &msg);
 
 		if (desc_bit == last_zero)
 			last_device = 1;
@@ -558,7 +561,7 @@
 		}
 
 		if (slave_count == dev->slave_count &&
-		    msg.val && (*((__u8 *) & msg.val) == msg.id.id.crc)) {
+		    ((rn >> 56) & 0xff) == w1_calc_crc8((u8 *)&rn, 7)) {
 			w1_attach_slave_device(dev, (struct w1_reg_num *) &rn);
 		}
 	}
diff -Nru a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
--- a/drivers/w1/w1_int.c	2004-08-23 11:03:57 -07:00
+++ b/drivers/w1/w1_int.c	2004-08-23 11:03:57 -07:00
@@ -24,6 +24,7 @@
 
 #include "w1.h"
 #include "w1_log.h"
+#include "w1_netlink.h"
 
 static u32 w1_ids = 1;
 
@@ -118,6 +119,7 @@
 {
 	struct w1_master *dev;
 	int retval = 0;
+	struct w1_netlink_msg msg;
 
 	dev = w1_alloc_dev(w1_ids++, w1_max_slave_count, &w1_driver, &w1_device);
 	if (!dev)
@@ -144,6 +146,11 @@
 	list_add(&dev->w1_master_entry, &w1_masters);
 	spin_unlock(&w1_mlock);
 
+	msg.id.mst.id = dev->id;
+	msg.id.mst.pid = dev->kpid;
+	msg.type = W1_MASTER_ADD;
+	w1_netlink_send(dev, &msg);
+
 	return 0;
 
 err_out_kill_thread:
@@ -163,6 +170,7 @@
 void __w1_remove_master_device(struct w1_master *dev)
 {
 	int err;
+	struct w1_netlink_msg msg;
 
 	dev->need_exit = 1;
 	err = kill_proc(dev->kpid, SIGTERM, 1);
@@ -173,6 +181,11 @@
 
 	while (atomic_read(&dev->refcnt))
 		schedule_timeout(10);
+
+	msg.id.mst.id = dev->id;
+	msg.id.mst.pid = dev->kpid;
+	msg.type = W1_MASTER_REMOVE;
+	w1_netlink_send(dev, &msg);
 
 	w1_free_dev(dev);
 }
diff -Nru a/drivers/w1/w1_netlink.h b/drivers/w1/w1_netlink.h
--- a/drivers/w1/w1_netlink.h	2004-08-23 11:03:57 -07:00
+++ b/drivers/w1/w1_netlink.h	2004-08-23 11:03:57 -07:00
@@ -26,14 +26,27 @@
 
 #include "w1.h"
 
+enum w1_netlink_message_types {
+	W1_SLAVE_ADD = 0,
+	W1_SLAVE_REMOVE,
+	W1_MASTER_ADD,
+	W1_MASTER_REMOVE,
+};
+
 struct w1_netlink_msg 
 {
+	__u8				type;
+	__u8				reserved[3];
 	union
 	{
 		struct w1_reg_num 	id;
 		__u64			w1_id;
+		struct
+		{
+			__u32		id;
+			__u32		pid;
+		} mst;
 	} id;
-	__u64				val;
 };
 
 #ifdef __KERNEL__

