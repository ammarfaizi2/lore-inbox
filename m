Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbUAIPj4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 10:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbUAIPj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 10:39:56 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:32883 "EHLO
	thoron.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261837AbUAIPjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 10:39:04 -0500
Date: Fri, 9 Jan 2004 10:38:59 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>,
       <selinux@tycho.nsa.gov>
Subject: [PATCH][SELINUX] 2/7 Add netif controls
In-Reply-To: <Xine.LNX.4.44.0401091009440.21309@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0401091012460.21309-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.1-mm2 adds netif access controls for SELinux, which 
allows network traffic to be controlled on the basis of associated 
network interface.

Similar functionality was present in earlier SELinux implementations; this
is a rework within the constraints of the LSM hooks present in the
mainline kernel.

Please apply.

 Makefile         |    4 
 hooks.c          |  165 +++++++++++++++++++++++++++++++++++++
 include/netif.h  |   30 ++++++
 include/objsec.h |    7 +
 netif.c          |  239 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 444 insertions(+), 1 deletion(-)

diff -urN -X dontdiff linux-2.6.1-rc2.pending/security/selinux/hooks.c linux-2.6.1-rc2.w1/security/selinux/hooks.c
--- linux-2.6.1-rc2.pending/security/selinux/hooks.c	2004-01-07 13:25:53.430125920 -0500
+++ linux-2.6.1-rc2.w1/security/selinux/hooks.c	2004-01-07 13:27:19.281074592 -0500
@@ -44,6 +44,7 @@
 #include <linux/ext2_fs.h>
 #include <linux/proc_fs.h>
 #include <linux/kd.h>
+#include <linux/netfilter_ipv4.h>
 #include <net/icmp.h>
 #include <net/ip.h>		/* for sysctl_local_port_range[] */
 #include <net/tcp.h>		/* struct or_callable used in sock_rcv_skb */
@@ -61,6 +62,7 @@
 
 #include "avc.h"
 #include "objsec.h"
+#include "netif.h"
 
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
 int selinux_enforcing = 0;
@@ -2663,7 +2665,137 @@
 	return 0;
 }
 
-#endif
+static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
+{
+	int err = 0;
+	u32 netif_perm;
+	struct socket *sock;
+	struct inode *inode;
+	struct net_device *dev;
+	struct sel_netif *netif;
+	struct netif_security_struct *nsec;
+	struct inode_security_struct *isec;
+	struct avc_audit_data ad;
+
+	/* Only IPv4 is supported here at this stage */
+	if (sk->sk_family != PF_INET)
+		goto out;
+
+	sock = sk->sk_socket;
+	
+	/* TCP control messages don't always have a socket. */
+	if (!sock)
+		goto out;
+
+	inode = SOCK_INODE(sock);
+	if (!inode)
+		goto out;
+
+	dev = skb->dev;
+	if (!dev)
+		goto out;
+
+	netif = sel_netif_lookup(dev);
+	if (IS_ERR(netif)) {
+		err = PTR_ERR(netif);
+		goto out;
+	}
+	
+	nsec = &netif->nsec;
+	isec = inode->i_security;
+
+	switch (isec->sclass) {
+	case SECCLASS_UDP_SOCKET:
+		netif_perm = NETIF__UDP_RECV;
+		break;
+	
+	case SECCLASS_TCP_SOCKET:
+		netif_perm = NETIF__TCP_RECV;
+		break;
+	
+	default:
+		netif_perm = NETIF__RAWIP_RECV;
+		break;
+	}
+
+	AVC_AUDIT_DATA_INIT(&ad, NET);
+	ad.u.net.netif = dev->name;
+	ad.u.net.skb = skb;
+
+	err = avc_has_perm(isec->sid, nsec->if_sid, SECCLASS_NETIF,
+	                   netif_perm, &nsec->avcr, &ad);
+
+	sel_netif_put(netif);
+out:	
+	return err;
+}
+
+#ifdef CONFIG_NETFILTER
+static unsigned int selinux_ip_postroute_last(unsigned int hooknum,
+                                              struct sk_buff **pskb,
+                                              const struct net_device *in,
+                                              const struct net_device *out,
+                                              int (*okfn)(struct sk_buff *))
+{
+	int err = NF_ACCEPT;
+	u32 netif_perm;
+	struct socket *sock;
+	struct inode *inode;
+	struct sel_netif *netif;
+	struct sk_buff *skb = *pskb;
+	struct netif_security_struct *nsec;
+	struct inode_security_struct *isec;
+	struct avc_audit_data ad;
+	struct net_device *dev = (struct net_device *)out;
+	
+	if (!skb->sk)
+		goto out;
+		
+	sock = skb->sk->sk_socket;
+	if (!sock)
+		goto out;
+		
+	inode = SOCK_INODE(sock);
+	if (!inode)
+		goto out;
+
+	netif = sel_netif_lookup(dev);
+	if (IS_ERR(netif)) {
+		err = NF_DROP;
+		goto out;
+	}
+	
+	nsec = &netif->nsec;
+	isec = inode->i_security;
+	
+	switch (isec->sclass) {
+	case SECCLASS_UDP_SOCKET:
+		netif_perm = NETIF__UDP_SEND;
+		break;
+	
+	case SECCLASS_TCP_SOCKET:
+		netif_perm = NETIF__TCP_SEND;
+		break;
+	
+	default:
+		netif_perm = NETIF__RAWIP_SEND;
+		break;
+	}
+
+	AVC_AUDIT_DATA_INIT(&ad, NET);
+	ad.u.net.netif = dev->name;
+	ad.u.net.skb = skb;
+
+	err = avc_has_perm(isec->sid, nsec->if_sid, SECCLASS_NETIF,
+	                   netif_perm, &nsec->avcr, &ad) ? NF_DROP : NF_ACCEPT;
+
+	sel_netif_put(netif);
+out:
+	return err;
+}
+#endif	/* CONFIG_NETFILTER */
+
+#endif	/* CONFIG_SECURITY_NETWORK */
 
 static int ipc_alloc_security(struct task_struct *task,
 			      struct kern_ipc_perm *perm,
@@ -3398,6 +3530,7 @@
 	.socket_getsockopt =		selinux_socket_getsockopt,
 	.socket_setsockopt =		selinux_socket_setsockopt,
 	.socket_shutdown =		selinux_socket_shutdown,
+	.socket_sock_rcv_skb =		selinux_socket_sock_rcv_skb,
 #endif
 };
 
@@ -3467,3 +3600,33 @@
    all processes and objects when they are created. */
 security_initcall(selinux_init);
 
+#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_NETFILTER)
+
+static struct nf_hook_ops selinux_ip_ops[] = {
+	{ .hook =	selinux_ip_postroute_last,
+	  .owner =	THIS_MODULE,
+	  .pf =		PF_INET, 
+	  .hooknum =	NF_IP_POST_ROUTING, 
+	  .priority =	NF_IP_PRI_SELINUX_LAST, },
+};
+
+static int __init selinux_nf_ip_init(void)
+{
+	int err = 0;
+
+	if (!selinux_enabled)
+		goto out;
+		
+	printk(KERN_INFO "SELinux:  Registering netfilter hooks\n");
+	
+	err = nf_register_hook(&selinux_ip_ops[0]);
+	if (err)
+		panic("SELinux: nf_register_hook 0 error %d\n", err);
+
+out:
+	return err;
+}
+
+__initcall(selinux_nf_ip_init);
+
+#endif /* CONFIG_SECURITY_NETWORK && CONFIG_NETFILTER */
diff -urN -X dontdiff linux-2.6.1-rc2.pending/security/selinux/include/netif.h linux-2.6.1-rc2.w1/security/selinux/include/netif.h
--- linux-2.6.1-rc2.pending/security/selinux/include/netif.h	2004-01-07 13:25:53.440124400 -0500
+++ linux-2.6.1-rc2.w1/security/selinux/include/netif.h	2004-01-07 13:26:07.263023000 -0500
@@ -0,0 +1,30 @@
+/*
+ * Network interface table.
+ *
+ * Network interfaces (devices) do not have a security field, so we
+ * maintain a table associating each interface with a SID.
+ *
+ * Author: James Morris <jmorris@redhat.com>
+ *
+ * Copyright (C) 2003 Red Hat, Inc., James Morris <jmorris@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2,
+ * as published by the Free Software Foundation.
+ */
+#ifndef _SELINUX_NETIF_H_
+#define _SELINUX_NETIF_H_
+
+struct sel_netif
+{
+	struct list_head list;
+	atomic_t users;
+	struct netif_security_struct nsec;
+	struct rcu_head rcu_head;
+};
+
+struct sel_netif *sel_netif_lookup(struct net_device *dev);
+void sel_netif_put(struct sel_netif *netif);
+
+#endif	/* _SELINUX_NETIF_H_ */
+
diff -urN -X dontdiff linux-2.6.1-rc2.pending/security/selinux/include/objsec.h linux-2.6.1-rc2.w1/security/selinux/include/objsec.h
--- linux-2.6.1-rc2.pending/security/selinux/include/objsec.h	2004-01-07 13:25:53.441124248 -0500
+++ linux-2.6.1-rc2.w1/security/selinux/include/objsec.h	2004-01-07 13:26:07.264022848 -0500
@@ -93,6 +93,13 @@
 	unsigned char set;
 };
 
+struct netif_security_struct {
+	struct net_device *dev;		/* back pointer */
+	u32 if_sid;			/* SID for this interface */
+	u32 msg_sid;			/* default SID for messages received on this interface */
+	struct avc_entry_ref avcr;	/* reference to permissions */
+};
+
 extern int inode_security_set_sid(struct inode *inode, u32 sid);
 
 #endif /* _SELINUX_OBJSEC_H_ */
diff -urN -X dontdiff linux-2.6.1-rc2.pending/security/selinux/Makefile linux-2.6.1-rc2.w1/security/selinux/Makefile
--- linux-2.6.1-rc2.pending/security/selinux/Makefile	2004-01-07 13:25:53.441124248 -0500
+++ linux-2.6.1-rc2.w1/security/selinux/Makefile	2004-01-07 13:26:07.264022848 -0500
@@ -6,5 +6,9 @@
 
 selinux-objs := avc.o hooks.o selinuxfs.o
 
+ifeq ($(CONFIG_SECURITY_NETWORK),y)
+	selinux-objs += netif.o
+endif
+
 EXTRA_CFLAGS += -Isecurity/selinux/include
 
diff -urN -X dontdiff linux-2.6.1-rc2.pending/security/selinux/netif.c linux-2.6.1-rc2.w1/security/selinux/netif.c
--- linux-2.6.1-rc2.pending/security/selinux/netif.c	2004-01-07 13:25:53.443123944 -0500
+++ linux-2.6.1-rc2.w1/security/selinux/netif.c	2004-01-07 13:27:19.283074288 -0500
@@ -0,0 +1,239 @@
+/*
+ * Network interface table.
+ *
+ * Network interfaces (devices) do not have a security field, so we
+ * maintain a table associating each interface with a SID.
+ *
+ * Author: James Morris <jmorris@redhat.com>
+ *
+ * Copyright (C) 2003 Red Hat, Inc., James Morris <jmorris@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2,
+ * as published by the Free Software Foundation.
+ */
+#include <linux/types.h>
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/notifier.h>
+#include <linux/netdevice.h>
+#include <linux/rcupdate.h>
+
+#include "security.h"
+#include "objsec.h"
+#include "netif.h"
+
+#define SEL_NETIF_HASH_SIZE	64
+#define SEL_NETIF_HASH_MAX	1024
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DEBUGP printk
+#else
+#define DEBUGP(format, args...)
+#endif
+
+static u32 sel_netif_total;
+static LIST_HEAD(sel_netif_list);
+static spinlock_t sel_netif_lock = SPIN_LOCK_UNLOCKED;
+static struct sel_netif sel_netif_hash[SEL_NETIF_HASH_SIZE];
+
+static inline u32 sel_netif_hasfn(struct net_device *dev)
+{
+	return (dev->ifindex & (SEL_NETIF_HASH_SIZE - 1));
+}
+
+/*
+ * All of the devices should normally fit in the hash, so we optimize
+ * for that case.
+ */
+static struct sel_netif *sel_netif_find(struct net_device *dev)
+{
+	struct list_head *pos;
+	int idx = sel_netif_hasfn(dev);
+
+	__list_for_each_rcu(pos, &sel_netif_hash[idx].list) {
+		struct sel_netif *netif = list_entry(pos,
+		                                     struct sel_netif, list);
+		if (likely(netif->nsec.dev == dev))
+			return netif;
+	}
+	return NULL;
+}
+
+static int sel_netif_insert(struct sel_netif *netif)
+{
+	int idx, ret = 0;
+	
+	if (sel_netif_total >= SEL_NETIF_HASH_MAX) {
+		ret = -ENOSPC;
+		goto out;
+	}
+	
+	idx = sel_netif_hasfn(netif->nsec.dev);
+	list_add_rcu(&netif->list, &sel_netif_hash[idx].list);
+	atomic_set(&netif->users, 1);
+	sel_netif_total++;
+out:
+	return ret;
+}
+
+struct sel_netif *sel_netif_lookup(struct net_device *dev)
+{
+	int ret;
+	struct sel_netif *netif, *new;
+	struct netif_security_struct *nsec;
+
+	rcu_read_lock();
+	netif = sel_netif_find(dev);
+	rcu_read_unlock();
+	
+	if (likely(netif != NULL))
+		goto out_hold;
+	
+	new = kmalloc(sizeof(*new), GFP_ATOMIC);
+	if (!new) {
+		netif = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+	
+	memset(new, 0, sizeof(*new));
+	nsec = &new->nsec;
+
+	ret = security_netif_sid(dev->name, &nsec->if_sid, &nsec->msg_sid);
+	if (ret < 0) {
+		kfree(new);
+		netif = ERR_PTR(ret);
+		goto out;
+	}
+
+	nsec->dev = dev;
+	
+	spin_lock_bh(&sel_netif_lock);
+	
+	netif = sel_netif_find(dev);
+	if (netif) {
+		spin_unlock_bh(&sel_netif_lock);
+		kfree(new);
+		goto out_hold;
+	}
+	
+	sel_netif_insert(new);
+	spin_unlock_bh(&sel_netif_lock);
+	
+	netif = new;
+	
+	DEBUGP("new: ifindex=%u name=%s if_sid=%u msg_sid=%u\n", dev->ifindex, dev->name,
+	        nsec->if_sid, nsec->msg_sid);
+out_hold:
+	atomic_inc(&netif->users);
+out:
+	return netif;
+}
+
+static void sel_netif_free(void *p)
+{
+	struct sel_netif *netif = p;
+	
+	DEBUGP("%s: %s\n", __FUNCTION__, netif->nsec.dev->name);
+	kfree(netif);
+}
+
+static void sel_netif_destroy(struct sel_netif *netif)
+{
+	DEBUGP("%s: %s\n", __FUNCTION__, netif->nsec.dev->name);
+	
+	spin_lock_bh(&sel_netif_lock);
+	list_del_rcu(&netif->list);
+	sel_netif_total--;
+	spin_unlock_bh(&sel_netif_lock);
+
+	call_rcu(&netif->rcu_head, sel_netif_free, netif);
+}
+
+void sel_netif_put(struct sel_netif *netif)
+{
+	if (atomic_dec_and_test(&netif->users))
+		sel_netif_destroy(netif);
+}
+
+static void sel_netif_kill(struct net_device *dev)
+{
+	struct sel_netif *netif;
+	
+	rcu_read_lock();
+	netif = sel_netif_find(dev);
+	rcu_read_unlock();
+
+	/* Drop internal reference */
+	if (netif)
+		sel_netif_put(netif);
+}
+
+static void sel_netif_flush(void)
+{
+	int idx;
+
+	for (idx = 0; idx < SEL_NETIF_HASH_SIZE; idx++) {
+		struct list_head *pos;
+		
+		list_for_each_rcu(pos, &sel_netif_hash[idx].list) {
+			struct sel_netif *netif;
+			
+			netif = list_entry(pos, struct sel_netif, list);
+			if (netif)
+				sel_netif_put(netif);
+		}
+	}
+}
+
+static int sel_netif_avc_callback(u32 event, u32 ssid, u32 tsid,
+                                  u16 class, u32 perms, u32 *retained)
+{
+	if (event == AVC_CALLBACK_RESET) {
+		sel_netif_flush();
+		synchronize_net();
+	}
+	return 0;
+}
+
+static int sel_netif_netdev_notifier_handler(struct notifier_block *this,
+                                             unsigned long event, void *ptr)
+{
+	struct net_device *dev = ptr;
+
+	if (event == NETDEV_DOWN)
+		sel_netif_kill(dev);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block sel_netif_netdev_notifier = {
+	.notifier_call = sel_netif_netdev_notifier_handler,
+};
+
+static __init int sel_netif_init(void)
+{
+	int i, err = 0;
+	
+	if (!selinux_enabled)
+		goto out;
+
+	for (i = 0; i < SEL_NETIF_HASH_SIZE; i++)
+		INIT_LIST_HEAD(&sel_netif_hash[i].list);
+
+	register_netdevice_notifier(&sel_netif_netdev_notifier);
+	
+	err = avc_add_callback(sel_netif_avc_callback, AVC_CALLBACK_RESET,
+	                       SECSID_NULL, SECSID_NULL, SECCLASS_NULL, 0);
+	if (err)
+		panic("avc_add_callback() failed, error %d\n", err);
+
+out:
+	return err;
+}
+
+__initcall(sel_netif_init);
+


