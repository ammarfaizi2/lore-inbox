Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVDUH5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVDUH5h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 03:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVDUH5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 03:57:36 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:49847 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261445AbVDUHaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 03:30:17 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: sensors@Stimpy.netroedge.com
Subject: [RFC/PATCH 9/22] W1: drop custom hotplug over netlink notification
Date: Thu, 21 Apr 2005 02:16:15 -0500
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
Message-Id: <200504210216.15392.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

W1: drop custom-made hotplug over netlink notification
    from w1 core. Standard hotplug mechanism should work
    just fine (patch will follow).

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/w1/w1_netlink.c  |   66 -----------------------------------------------
 drivers/w1/w1_netlink.h  |   57 ----------------------------------------
 dtor/drivers/w1/Makefile |    2 -
 dtor/drivers/w1/w1.c     |   36 -------------------------
 dtor/drivers/w1/w1.h     |    3 --
 5 files changed, 1 insertion(+), 163 deletions(-)

Index: dtor/drivers/w1/w1_netlink.h
===================================================================
--- dtor.orig/drivers/w1/w1_netlink.h
+++ /dev/null
@@ -1,57 +0,0 @@
-/*
- * w1_netlink.h
- *
- * Copyright (c) 2003 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- *
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
-#ifndef __W1_NETLINK_H
-#define __W1_NETLINK_H
-
-#include <asm/types.h>
-
-#include "w1.h"
-
-enum w1_netlink_message_types {
-	W1_SLAVE_ADD = 0,
-	W1_SLAVE_REMOVE,
-	W1_MASTER_ADD,
-	W1_MASTER_REMOVE,
-};
-
-struct w1_netlink_msg
-{
-	__u8				type;
-	__u8				reserved[3];
-	union
-	{
-		struct w1_reg_num	id;
-		__u64			w1_id;
-		struct
-		{
-			__u32		id;
-			__u32		pid;
-		} mst;
-	} id;
-};
-
-#ifdef __KERNEL__
-
-void w1_netlink_send(struct w1_master *, struct w1_netlink_msg *);
-
-#endif /* __KERNEL__ */
-#endif /* __W1_NETLINK_H */
Index: dtor/drivers/w1/w1.c
===================================================================
--- dtor.orig/drivers/w1/w1.c
+++ dtor/drivers/w1/w1.c
@@ -37,7 +37,6 @@
 #include "w1_io.h"
 #include "w1_log.h"
 #include "w1_family.h"
-#include "w1_netlink.h"
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
@@ -395,7 +394,6 @@ static int w1_attach_slave_device(struct
 	struct w1_slave *sl;
 	struct w1_family *f;
 	int err;
-	struct w1_netlink_msg msg;
 
 	sl = kmalloc(sizeof(struct w1_slave), GFP_KERNEL);
 	if (!sl) {
@@ -442,17 +440,11 @@ static int w1_attach_slave_device(struct
 	sl->ttl = dev->slave_ttl;
 	dev->slave_count++;
 
-	memcpy(&msg.id.id, rn, sizeof(msg.id.id));
-	msg.type = W1_SLAVE_ADD;
-	w1_netlink_send(dev, &msg);
-
 	return 0;
 }
 
 static void w1_slave_detach(struct w1_slave *sl)
 {
-	struct w1_netlink_msg msg;
-
 	dev_info(&sl->dev, "%s: detaching %s.\n", __func__, sl->name);
 
 	while (atomic_read(&sl->refcnt)) {
@@ -469,10 +461,6 @@ static void w1_slave_detach(struct w1_sl
 	device_remove_file(&sl->dev, &sl->attr_val);
 	device_unregister(&sl->dev);
 	w1_family_put(sl->family);
-
-	memcpy(&msg.id.id, &sl->reg_num, sizeof(msg.id.id));
-	msg.type = W1_SLAVE_REMOVE;
-	w1_netlink_send(sl->master, &msg);
 }
 
 static void w1_slave_found(struct w1_master *dev, u64 rn)
@@ -746,29 +734,16 @@ struct w1_master *w1_allocate_master_dev
 static void w1_free_dev(struct w1_master *dev)
 {
 	device_unregister(&dev->dev);
-	if (dev->nls && dev->nls->sk_socket)
-		sock_release(dev->nls->sk_socket);
-	memset(dev, 0, sizeof(struct w1_master));
 	kfree(dev);
 }
 
 int w1_add_master_device(struct w1_master *dev)
 {
 	int error;
-	struct w1_netlink_msg msg;
-
-	dev->nls = netlink_kernel_create(NETLINK_NFLOG, NULL);
-	if (!dev->nls) {
-		printk(KERN_ERR "Failed to create new netlink socket(%u) for w1 master %s.\n",
-			NETLINK_NFLOG, dev->dev.bus_id);
-		return -1;
-	}
 
 	error = device_register(&dev->dev);
 	if (error) {
 		printk(KERN_ERR "Failed to register master device. err=%d\n", error);
-		if (dev->nls && dev->nls->sk_socket)
-			sock_release(dev->nls->sk_socket);
 		return error;
 	}
 
@@ -791,11 +766,6 @@ int w1_add_master_device(struct w1_maste
 	list_add(&dev->node, &w1_masters);
 	spin_unlock(&w1_mlock);
 
-	msg.id.mst.id = dev->id;
-	msg.id.mst.pid = dev->kpid;
-	msg.type = W1_MASTER_ADD;
-	w1_netlink_send(dev, &msg);
-
 	return 0;
 
 err_out_kill_thread:
@@ -815,7 +785,6 @@ err_out_free_dev:
 void w1_remove_master_device(struct w1_master *dev)
 {
 	int err;
-	struct w1_netlink_msg msg;
 
 	dev->need_exit = 1;
 	err = kill_proc(dev->kpid, SIGTERM, 1);
@@ -832,11 +801,6 @@ void w1_remove_master_device(struct w1_m
 			flush_signals(current);
 	}
 
-	msg.id.mst.id = dev->id;
-	msg.id.mst.pid = dev->kpid;
-	msg.type = W1_MASTER_REMOVE;
-	w1_netlink_send(dev, &msg);
-
 	w1_free_dev(dev);
 }
 
Index: dtor/drivers/w1/w1_netlink.c
===================================================================
--- dtor.orig/drivers/w1/w1_netlink.c
+++ /dev/null
@@ -1,66 +0,0 @@
-/*
- * w1_netlink.c
- *
- * Copyright (c) 2003 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- *
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
-#include <linux/skbuff.h>
-#include <linux/netlink.h>
-
-#include "w1.h"
-#include "w1_log.h"
-#include "w1_netlink.h"
-
-#ifndef NETLINK_DISABLED
-void w1_netlink_send(struct w1_master *dev, struct w1_netlink_msg *msg)
-{
-	unsigned int size;
-	struct sk_buff *skb;
-	struct w1_netlink_msg *data;
-	struct nlmsghdr *nlh;
-
-	if (!dev->nls)
-		return;
-
-	size = NLMSG_SPACE(sizeof(struct w1_netlink_msg));
-
-	skb = alloc_skb(size, GFP_ATOMIC);
-	if (!skb) {
-		dev_err(&dev->dev, "skb_alloc() failed.\n");
-		return;
-	}
-
-	nlh = NLMSG_PUT(skb, 0, dev->seq++, NLMSG_DONE, size - sizeof(*nlh));
-
-	data = (struct w1_netlink_msg *)NLMSG_DATA(nlh);
-
-	memcpy(data, msg, sizeof(struct w1_netlink_msg));
-
-	NETLINK_CB(skb).dst_groups = dev->groups;
-	netlink_broadcast(dev->nls, skb, 0, dev->groups, GFP_ATOMIC);
-
-nlmsg_failure:
-	return;
-}
-#else
-#warning Netlink support is disabled. Please compile with NET support enabled.
-
-void w1_netlink_send(struct w1_master *dev, struct w1_netlink_msg *msg)
-{
-}
-#endif
Index: dtor/drivers/w1/w1.h
===================================================================
--- dtor.orig/drivers/w1/w1.h
+++ dtor/drivers/w1/w1.h
@@ -42,8 +42,6 @@ struct w1_reg_num
 #include <linux/completion.h>
 #include <linux/device.h>
 
-#include <net/sock.h>
-
 #include <asm/semaphore.h>
 
 #include "w1_family.h"
@@ -130,7 +128,6 @@ struct w1_master
 	struct w1_bus_ops	*bus_ops;
 
 	u32			seq, groups;
-	struct sock		*nls;
 };
 
 struct w1_master *w1_allocate_master_device(void);
Index: dtor/drivers/w1/Makefile
===================================================================
--- dtor.orig/drivers/w1/Makefile
+++ dtor/drivers/w1/Makefile
@@ -7,7 +7,7 @@ EXTRA_CFLAGS	+= -DNETLINK_DISABLED
 endif
 
 obj-$(CONFIG_W1)	+= wire.o
-wire-objs		:= w1.o w1_family.o w1_netlink.o w1_io.o
+wire-objs		:= w1.o w1_family.o w1_io.o
 
 obj-$(CONFIG_W1_MATROX)		+= matrox_w1.o
 obj-$(CONFIG_W1_THERM)		+= w1_therm.o
