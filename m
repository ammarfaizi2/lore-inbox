Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbTCMW3z>; Thu, 13 Mar 2003 17:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262579AbTCMW3t>; Thu, 13 Mar 2003 17:29:49 -0500
Received: from air-2.osdl.org ([65.172.181.6]:55978 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262571AbTCMW3W>;
	Thu, 13 Mar 2003 17:29:22 -0500
Subject: [PATCH] (3/5) Remove brlock from bridge
From: Stephen Hemminger <shemminger@osdl.org>
To: Andrew Morton <akpm@digeo.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1047595202.3136.102.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 13 Mar 2003 14:40:03 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove brlock dependency from bridge code.

Changed from earlier version to use RCU for list of bridges and use deferred
free for deletion of bridge ports.  This avoids the possible race where a receive
frame is in process on a bridge port and port is deleted.

Fixed some existing race conditions in the ioctl() processing path where bridge
data was referenced without a lock.

This code still needs more testing before final 2.5 inclusion.

diff -urN -X dontdiff linux-2.5.64/net/bridge/br.c linux-2.5-nobrlock/net/bridge/br.c
--- linux-2.5.64/net/bridge/br.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/bridge/br.c	2003-03-12 14:52:43.000000000 -0800
@@ -21,7 +21,6 @@
 #include <linux/etherdevice.h>
 #include <linux/init.h>
 #include <linux/if_bridge.h>
-#include <linux/brlock.h>
 #include <asm/uaccess.h>
 #include "br_private.h"
 
@@ -73,14 +72,15 @@
 	unregister_netdevice_notifier(&br_device_notifier);
 	br_call_ioctl_atomic(__br_clear_ioctl_hook);
 
-	br_write_lock_bh(BR_NETPROTO_LOCK);
 	br_handle_frame_hook = NULL;
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
 
 #if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
 	br_fdb_get_hook = NULL;
 	br_fdb_put_hook = NULL;
 #endif
+
+	/* netif_receive_skb uses RCU */
+	synchronize_kernel();
 }
 
 EXPORT_SYMBOL(br_should_route_hook);
diff -urN -X dontdiff linux-2.5.64/net/bridge/br_if.c linux-2.5-nobrlock/net/bridge/br_if.c
--- linux-2.5.64/net/bridge/br_if.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/bridge/br_if.c	2003-03-13 13:54:16.000000000 -0800
@@ -18,11 +18,11 @@
 #include <linux/if_bridge.h>
 #include <linux/inetdevice.h>
 #include <linux/rtnetlink.h>
-#include <linux/brlock.h>
 #include <asm/uaccess.h>
 #include "br_private.h"
 
-static struct net_bridge *bridge_list;
+static LIST_HEAD(bridge_head);
+static spinlock_t bridge_head_lock = SPIN_LOCK_UNLOCKED;
 
 static int br_initial_port_cost(struct net_device *dev)
 {
@@ -38,61 +38,53 @@
 	return 100;
 }
 
-/* called under BR_NETPROTO_LOCK and bridge lock */
-static int __br_del_if(struct net_bridge *br, struct net_device *dev)
-{
-	struct net_bridge_port *p;
-	struct net_bridge_port **pptr;
 
-	if ((p = dev->br_port) == NULL)
-		return -EINVAL;
+/* called under write bridge lock */
+static void __br_del_if(struct net_bridge_port *p)
+{
+	struct net_device *dev = p->dev;
 
 	br_stp_disable_port(p);
 
+	/* break association used during frame receive */
 	dev_set_promiscuity(dev, -1);
 	dev->br_port = NULL;
+	smp_wmb();
 
-	pptr = &br->port_list;
-	while (*pptr != NULL) {
-		if (*pptr == p) {
-			*pptr = p->next;
-			break;
-		}
-
-		pptr = &((*pptr)->next);
-	}
+	br_fdb_delete_by_port(p->br, p);
 
-	br_fdb_delete_by_port(br, p);
-	kfree(p);
-	dev_put(dev);
-
-	return 0;
+	/* defer actual free till after receive BH has completed */
+	call_rcu(&p->rcu, (void (*)(void *)) kfree, p);
 }
 
-static struct net_bridge **__find_br(char *name)
+/* called with bridge_head_lock */
+static struct net_bridge *__find_br(const char *name)
 {
-	struct net_bridge **b;
-	struct net_bridge *br;
+	struct list_head *elem;
+	struct net_bridge *br = NULL;
 
-	b = &bridge_list;
-	while ((br = *b) != NULL) {
+	list_for_each(elem, &bridge_head) {
+		br = list_entry(elem, struct net_bridge, bridge_list);
 		if (!strncmp(br->dev.name, name, IFNAMSIZ))
-			return b;
-
-		b = &(br->next);
+			break;
 	}
 
-	return NULL;
+	return br;
 }
 
 static void del_ifs(struct net_bridge *br)
 {
-	br_write_lock_bh(BR_NETPROTO_LOCK);
-	write_lock(&br->lock);
-	while (br->port_list != NULL)
-		__br_del_if(br, br->port_list->dev);
-	write_unlock(&br->lock);
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	struct net_bridge_port *p, *nxt;
+
+	write_lock_bh(&br->lock);
+	p = br->port_list; 
+	br->port_list = NULL;
+	while (p != NULL) {
+		nxt = p->next;
+		__br_del_if(p);
+		p = nxt;
+	}
+	write_unlock_bh(&br->lock);
 }
 
 static struct net_bridge *new_nb(char *name)
@@ -115,6 +107,7 @@
 
 	br->lock = RW_LOCK_UNLOCKED;
 	br->hash_lock = RW_LOCK_UNLOCKED;
+	br->port_list = NULL;
 
 	br->bridge_id.prio[0] = 0x80;
 	br->bridge_id.prio[1] = 0x00;
@@ -179,45 +172,51 @@
 int br_add_bridge(char *name)
 {
 	struct net_bridge *br;
+	int ret = 0;
 
-	if ((br = new_nb(name)) == NULL)
-		return -ENOMEM;
-
-	if (__dev_get_by_name(name) != NULL) {
+	spin_lock(&bridge_head_lock);
+	if ((br = new_nb(name)) == NULL) 
+		ret = -ENOMEM;
+	else if (__dev_get_by_name(name) != NULL) {
 		kfree(br);
-		return -EEXIST;
-	}
-
-	br->next = bridge_list;
-	bridge_list = br;
+		ret = -EEXIST;
+	} else {
+		br_inc_use_count();
+		register_netdev(&br->dev);
 
-	br_inc_use_count();
-	register_netdev(&br->dev);
+		list_add(&br->bridge_list, &bridge_head);
+	}
+	spin_unlock(&bridge_head_lock);
 
-	return 0;
+	return ret;;
 }
 
 int br_del_bridge(char *name)
 {
-	struct net_bridge **b;
 	struct net_bridge *br;
 
-	if ((b = __find_br(name)) == NULL)
-		return -ENXIO;
-
-	br = *b;
+	spin_lock(&bridge_head_lock);
+	if ((br = __find_br(name)) == NULL) {
+		spin_unlock(&bridge_head_lock);
+		return  -ENXIO;
+	}
 
-	if (br->dev.flags & IFF_UP)
+	else if (br->dev.flags & IFF_UP) {
+		spin_unlock(&bridge_head_lock);
 		return -EBUSY;
+		
+	}
+
+	list_del(&br->bridge_list);
+	spin_unlock(&bridge_head_lock);
 
 	del_ifs(br);
 
-	*b = br->next;
+	synchronize_kernel();
 
 	unregister_netdev(&br->dev);
 	kfree(br);
 	br_dec_use_count();
-
 	return 0;
 }
 
@@ -255,43 +254,54 @@
 
 int br_del_if(struct net_bridge *br, struct net_device *dev)
 {
-	int retval;
+	struct net_bridge_port *p, **pp;
+	int retval = -EINVAL;
 
-	br_write_lock_bh(BR_NETPROTO_LOCK);
-	write_lock(&br->lock);
-	retval = __br_del_if(br, dev);
-	br_stp_recalculate_bridge_id(br);
-	write_unlock(&br->lock);
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	write_lock_bh(&br->lock);
+	pp = &br->port_list;
+	while ( (p = *pp) != NULL) {
+		if (p == dev->br_port) {
+			*pp = p->next;
+			__br_del_if(p);
+			br_stp_recalculate_bridge_id(br);
+			retval = 0;
+			break;
+		}
+		pp = &p->next;
+	}
+	write_unlock_bh(&br->lock);
 
 	return retval;
 }
 
+/* called under ioctl_mutex */
 int br_get_bridge_ifindices(int *indices, int num)
 {
-	struct net_bridge *br;
-	int i;
+	const struct list_head *elem;
+	int i = 0;
 
-	br = bridge_list;
-	for (i=0;i<num;i++) {
-		if (br == NULL)
-			break;
-
-		indices[i] = br->dev.ifindex;
-		br = br->next;
+	rcu_read_lock();
+	list_for_each_rcu(elem, &bridge_head) {
+		const struct net_bridge *br 
+			= list_entry(elem, const struct net_bridge, bridge_list);
+		indices[i++] = br->dev.ifindex;
 	}
+	rcu_read_unlock();
 
 	return i;
 }
 
-/* called under ioctl_lock */
+/* called under ioctl_mutex */
 void br_get_port_ifindices(struct net_bridge *br, int *ifindices)
 {
 	struct net_bridge_port *p;
 
+	read_lock(&br->lock);
 	p = br->port_list;
 	while (p != NULL) {
 		ifindices[p->port_no] = p->dev->ifindex;
 		p = p->next;
 	}
+	read_unlock(&br->lock);
 }
+
diff -urN -X dontdiff linux-2.5.64/net/bridge/br_input.c linux-2.5-nobrlock/net/bridge/br_input.c
--- linux-2.5.64/net/bridge/br_input.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/bridge/br_input.c	2003-03-13 12:04:51.000000000 -0800
@@ -149,7 +149,10 @@
 		goto handle_special_frame;
 
 	if (p->state == BR_STATE_FORWARDING) {
-		if (br_should_route_hook && br_should_route_hook(&skb)) {
+		int (*curhook)(struct sk_buff **) = br_should_route_hook;
+
+		barrier();	/* prevent compiler RCU problems */
+		if (curhook && curhook(&skb)) {
 			read_unlock(&br->lock);
 			return -1;
 		}
diff -urN -X dontdiff linux-2.5.64/net/bridge/br_ioctl.c linux-2.5-nobrlock/net/bridge/br_ioctl.c
--- linux-2.5.64/net/bridge/br_ioctl.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/bridge/br_ioctl.c	2003-03-13 11:08:31.000000000 -0800
@@ -126,8 +126,10 @@
 		struct __port_info p;
 		struct net_bridge_port *pt;
 
+		read_lock(&br->lock);
 		if ((pt = br_get_port(br, arg1)) == NULL)
 			return -EINVAL;
+		read_unlock(&br->lock);
 
 		memset(&p, 0, sizeof(struct __port_info));
 		memcpy(&p.designated_root, &pt->designated_root, 8);
@@ -161,9 +163,14 @@
 	{
 		struct net_bridge_port *p;
 
-		if ((p = br_get_port(br, arg0)) == NULL)
+		read_lock(&br->lock);
+		if ((p = br_get_port(br, arg0)) == NULL) {
+			read_unlock(&br->lock);
 			return -EINVAL;
+
+		}
 		br_stp_set_port_priority(p, arg1);
+		read_unlock(&br->lock);
 		return 0;
 	}
 
@@ -171,9 +178,13 @@
 	{
 		struct net_bridge_port *p;
 
-		if ((p = br_get_port(br, arg0)) == NULL)
+		read_lock(&br->lock);
+		if ((p = br_get_port(br, arg0)) == NULL) {
+			read_unlock(&br->lock);
 			return -EINVAL;
+		}
 		br_stp_set_path_cost(p, arg1);
+		read_unlock(&br->lock);
 		return 0;
 	}
 
diff -urN -X dontdiff linux-2.5.64/net/bridge/br_private.h linux-2.5-nobrlock/net/bridge/br_private.h
--- linux-2.5.64/net/bridge/br_private.h	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/bridge/br_private.h	2003-03-13 13:55:25.000000000 -0800
@@ -75,11 +75,12 @@
 	struct br_timer			forward_delay_timer;
 	struct br_timer			hold_timer;
 	struct br_timer			message_age_timer;
+	struct rcu_head			rcu;
 };
 
 struct net_bridge
 {
-	struct net_bridge		*next;
+	struct list_head		bridge_list;
 	rwlock_t			lock;
 	struct net_bridge_port		*port_list;
 	struct net_device		dev;
diff -urN -X dontdiff linux-2.5.64/net/bridge/netfilter/ebtable_broute.c linux-2.5-nobrlock/net/bridge/netfilter/ebtable_broute.c
--- linux-2.5.64/net/bridge/netfilter/ebtable_broute.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/bridge/netfilter/ebtable_broute.c	2003-03-12 14:52:42.000000000 -0800
@@ -14,7 +14,6 @@
 #include <linux/netfilter_bridge/ebtables.h>
 #include <linux/module.h>
 #include <linux/if_bridge.h>
-#include <linux/brlock.h>
 
 // EBT_ACCEPT means the frame will be bridged
 // EBT_DROP means the frame will be routed
@@ -68,18 +67,17 @@
 	ret = ebt_register_table(&broute_table);
 	if (ret < 0)
 		return ret;
-	br_write_lock_bh(BR_NETPROTO_LOCK);
 	// see br_input.c
 	br_should_route_hook = ebt_broute;
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	synchronize_kernel();
+
 	return ret;
 }
 
 static void __exit fini(void)
 {
-	br_write_lock_bh(BR_NETPROTO_LOCK);
 	br_should_route_hook = NULL;
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	synchronize_kernel();
 	ebt_unregister_table(&broute_table);
 }
 



