Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264291AbUAYPZi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 10:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264351AbUAYPZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 10:25:38 -0500
Received: from mail.contactel.cz ([212.65.193.9]:6056 "EHLO mail.contactel.cz")
	by vger.kernel.org with ESMTP id S264291AbUAYPY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 10:24:58 -0500
Date: Sun, 25 Jan 2004 16:24:19 +0100
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com
Subject: [RFC/PATCH] IMQ port to 2.6
Message-ID: <20040125152419.GA3208@penguin.localdomain>
Mail-Followup-To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: sebek64@post.cz (Marcel Sebek)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have ported IMQ driver from 2.4 to 2.6.2-rc1.

Original version was from http://trash.net/~kaber/imq/.


diff -urN linux-2.6.orig/drivers/net/Kconfig linux-2.6.new/drivers/net/Kconfig
--- linux-2.6.orig/drivers/net/Kconfig	2004-01-21 19:33:36.000000000 +0100
+++ linux-2.6.new/drivers/net/Kconfig	2004-01-25 15:08:20.000000000 +0100
@@ -85,6 +85,20 @@
 	  To compile this driver as a module, choose M here: the module
 	  will be called eql.  If unsure, say N.
 
+config IMQ
+	tristate "IMQ (intermediate queueing device) support"
+	depends on NETDEVICES && NETFILTER
+	---help---
+	  The imq device(s) is used as placeholder for QoS queueing disciplines.
+	  Every packet entering/leaving the ip stack can be directed through
+	  the imq device where it's enqueued/dequeued to the attached qdisc.
+	  This allows you to treat network devices as classes and distribute
+	  bandwidth among them. Iptables is used to specify through which imq
+	  device, if any, packets travel.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called imq.  If unsure, say N.
+
 config TUN
 	tristate "Universal TUN/TAP device driver support"
 	depends on NETDEVICES
diff -urN linux-2.6.orig/drivers/net/Makefile linux-2.6.new/drivers/net/Makefile
--- linux-2.6.orig/drivers/net/Makefile	2004-01-21 19:33:36.000000000 +0100
+++ linux-2.6.new/drivers/net/Makefile	2004-01-25 15:08:20.000000000 +0100
@@ -110,6 +110,7 @@
 endif
 
 obj-$(CONFIG_DUMMY) += dummy.o
+obj-$(CONFIG_IMQ) += imq.o
 obj-$(CONFIG_DE600) += de600.o
 obj-$(CONFIG_DE620) += de620.o
 obj-$(CONFIG_AT1500) += lance.o
diff -urN linux-2.6.orig/drivers/net/imq.c linux-2.6.new/drivers/net/imq.c
--- linux-2.6.orig/drivers/net/imq.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.new/drivers/net/imq.c	2004-01-25 15:08:51.000000000 +0100
@@ -0,0 +1,323 @@
+/*
+ *             Pseudo-driver for the intermediate queue device.
+ *
+ *             This program is free software; you can redistribute it and/or
+ *             modify it under the terms of the GNU General Public License
+ *             as published by the Free Software Foundation; either version
+ *             2 of the License, or (at your option) any later version.
+ *
+ * Authors:    Patrick McHardy, <kaber@trash.net>
+ *
+ * 	       The first version was written by Martin Devera, <devik@cdi.cz>
+ *
+ * Credits:    Jan Rafaj <imq2t@cedric.vabo.cz>
+ *              - Update patch to 2.4.21
+ *             Sebastian Strollo <sstrollo@nortelnetworks.com>
+ *              - Fix "Dead-loop on netdevice imq"-issue
+ *             Marcel Sebek <sebek64@post.cz>
+ *              - Update to 2.6.2-rc1
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/moduleparam.h>
+#include <linux/skbuff.h>
+#include <linux/netdevice.h>
+#include <linux/rtnetlink.h>
+#include <linux/if_arp.h>
+#include <linux/netfilter.h>
+#include <linux/netfilter_ipv4.h>
+#if defined(CONFIG_IPV6) || defined (CONFIG_IPV6_MODULE)
+#include <linux/netfilter_ipv6.h>
+#endif
+#include <linux/imq.h>
+#include <net/pkt_sched.h>
+
+static nf_hookfn imq_nf_hook;
+
+static struct nf_hook_ops imq_ingress_ipv4 = {
+	.hook		= imq_nf_hook,
+	.owner		= THIS_MODULE,
+	.pf		= PF_INET,
+	.hooknum	= NF_IP_PRE_ROUTING,
+	.priority	= NF_IP_PRI_MANGLE + 1
+};
+
+static struct nf_hook_ops imq_egress_ipv4 = {
+	.hook		= imq_nf_hook,
+	.owner		= THIS_MODULE,
+	.pf		= PF_INET,
+	.hooknum	= NF_IP_POST_ROUTING,
+	.priority	= NF_IP_PRI_LAST
+};
+
+#if defined(CONFIG_IPV6) || defined (CONFIG_IPV6_MODULE)
+static struct nf_hook_ops imq_ingress_ipv6 = {
+	.hook		= imq_nf_hook,
+	.owner		= THIS_MODULE,
+	.pf		= PF_INET6,
+	.hooknum	= NF_IP6_PRE_ROUTING,
+	.priority	= NF_IP6_PRI_MANGLE + 1
+};
+
+static struct nf_hook_ops imq_egress_ipv6 = {
+	.hook		= imq_nf_hook,
+	.owner		= THIS_MODULE,
+	.pf		= PF_INET6,
+	.hooknum	= NF_IP6_POST_ROUTING,
+	.priority	= NF_IP6_PRI_LAST
+};
+#endif
+
+static unsigned int numdevs = 2;
+
+module_param(numdevs, int, 0);
+
+static struct net_device *imq_devs;
+
+
+static struct net_device_stats *imq_get_stats(struct net_device *dev)
+{
+	return (struct net_device_stats *)dev->priv;
+}
+
+/* called for packets kfree'd in qdiscs at places other than enqueue */
+static void imq_skb_destructor(struct sk_buff *skb)
+{
+	struct nf_info *info = skb->nf_info;
+
+	if (info) {
+		if (info->indev)
+			dev_put(info->indev);
+		if (info->outdev)
+			dev_put(info->outdev);
+		kfree(info);
+	}
+}
+
+static int imq_dev_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct net_device_stats *stats = (struct net_device_stats*) dev->priv;
+
+	stats->tx_bytes += skb->len;
+	stats->tx_packets++;
+
+	skb->imq_flags = 0;
+	skb->destructor = NULL;
+
+	dev->trans_start = jiffies;
+	nf_reinject(skb, skb->nf_info, NF_ACCEPT);
+	return 0;
+}
+
+static int imq_nf_queue(struct sk_buff *skb, struct nf_info *info,
+			void *data)
+{
+	struct net_device *dev;
+	struct net_device_stats *stats;
+	struct sk_buff *skb2 = NULL;
+	struct Qdisc *q;
+	unsigned int index = skb->imq_flags&IMQ_F_IFMASK;
+	int ret = -1;
+
+	if (index > numdevs) 
+		return -1;
+
+	dev = imq_devs + index;
+	if (!(dev->flags & IFF_UP)) {
+		skb->imq_flags = 0;
+		nf_reinject(skb, info, NF_ACCEPT);
+		return 0;
+	}
+	dev->last_rx = jiffies;
+
+	if (skb->destructor) {
+		skb2 = skb;
+		skb = skb_clone(skb, GFP_ATOMIC);
+		if (!skb)
+			return -1;
+	}
+	skb->nf_info = info;
+
+	stats = (struct net_device_stats *)dev->priv;
+	stats->rx_bytes+= skb->len;
+	stats->rx_packets++;
+
+	spin_lock_bh(&dev->queue_lock);
+	q = dev->qdisc;
+	if (q->enqueue) {
+		q->enqueue(skb_get(skb), q);
+		if (skb_shared(skb)) {
+			skb->destructor = imq_skb_destructor;
+			kfree_skb(skb);
+			ret = 0;
+		}
+	}
+	if (spin_is_locked(&dev->xmit_lock))
+		netif_schedule(dev);
+	else
+		qdisc_run(dev);
+	spin_unlock_bh(&dev->queue_lock);
+
+	if (skb2)
+		kfree_skb(ret ? skb : skb2);
+
+	return ret;
+}
+
+static unsigned int imq_nf_hook(unsigned int hook, struct sk_buff **pskb,
+		   const struct net_device *indev,
+		   const struct net_device *outdev,
+		   int (*okfn)(struct sk_buff *))
+{
+	if ((*pskb)->imq_flags & IMQ_F_ENQUEUE)
+		return NF_QUEUE;
+
+	return NF_ACCEPT;
+}
+
+
+static int __init imq_init_hooks(void)
+{
+	int err;
+
+	if ((err = nf_register_queue_handler(PF_INET, imq_nf_queue, NULL)))
+		goto err1;
+	if ((err = nf_register_hook(&imq_ingress_ipv4)))
+		goto err2;
+	if ((err = nf_register_hook(&imq_egress_ipv4)))
+		goto err3;
+#if defined(CONFIG_IPV6) || defined (CONFIG_IPV6_MODULE)
+	if ((err = nf_register_queue_handler(PF_INET6, imq_nf_queue, NULL)))
+		goto err4;
+	if ((err = nf_register_hook(&imq_ingress_ipv6)))
+		goto err5;
+	if ((err = nf_register_hook(&imq_egress_ipv6)))
+		goto err6;
+#endif
+
+	return 0;
+
+#if defined(CONFIG_IPV6) || defined (CONFIG_IPV6_MODULE)
+err6:
+	nf_unregister_hook(&imq_ingress_ipv6);
+err5:
+	nf_unregister_queue_handler(PF_INET6);
+err4:
+	nf_unregister_hook(&imq_egress_ipv4);
+#endif
+err3:
+	nf_unregister_hook(&imq_ingress_ipv4);
+err2:
+	nf_unregister_queue_handler(PF_INET);
+err1:
+	return err;
+}
+
+static void __exit imq_unhook(void)
+{
+	nf_unregister_hook(&imq_ingress_ipv4);
+	nf_unregister_hook(&imq_egress_ipv4);
+	nf_unregister_queue_handler(PF_INET);
+#if defined(CONFIG_IPV6) || defined (CONFIG_IPV6_MODULE)
+	nf_unregister_hook(&imq_ingress_ipv6);
+	nf_unregister_hook(&imq_egress_ipv6);
+	nf_unregister_queue_handler(PF_INET6);
+#endif
+}
+
+static int __init imq_dev_init(struct net_device *dev)
+{
+	dev->hard_start_xmit	= imq_dev_xmit;
+	dev->type		= ARPHRD_VOID;
+	dev->mtu		= 1500;
+	dev->tx_queue_len	= 30;
+	dev->flags		= IFF_NOARP;
+	dev->priv = kmalloc(sizeof(struct net_device_stats), GFP_KERNEL);
+	if (dev->priv == NULL)
+		return -ENOMEM;
+	memset(dev->priv, 0, sizeof(struct net_device_stats));
+	dev->get_stats		= imq_get_stats;
+
+	return 0;
+}
+
+static void imq_dev_uninit(struct net_device *dev)
+{
+	kfree(dev->priv);
+}
+
+static int __init imq_init_devs(void)
+{
+	struct net_device *dev;
+	int i;
+
+	if (!numdevs || numdevs > IMQ_MAX_DEVS) {
+		printk(KERN_ERR "numdevs has to be betweed 1 and %u\n",
+		       IMQ_MAX_DEVS);
+		return -EINVAL;
+	}
+
+	imq_devs = kmalloc(sizeof(struct net_device) * numdevs, GFP_KERNEL);
+	if (!imq_devs)
+		return -ENOMEM;
+	memset(imq_devs, 0, sizeof(struct net_device) * numdevs);
+
+	/* we start counting at zero */
+	numdevs--;
+
+	for (i = 0, dev = imq_devs; i <= numdevs; i++, dev++) {
+		SET_MODULE_OWNER(dev);
+		strcpy(dev->name, "imq%d");
+		dev->init   = imq_dev_init;
+		dev->uninit = imq_dev_uninit;
+
+		if (register_netdev(dev) < 0)
+			goto err_register;
+	}
+	return 0;
+
+err_register:
+	for (; i; i--)
+		unregister_netdev(--dev);
+	kfree(imq_devs);
+	return -EIO;
+}
+
+static void imq_cleanup_devs(void)
+{
+	int i;
+	struct net_device *dev = imq_devs;
+
+	for (i = 0; i <= numdevs; i++)
+		unregister_netdev(dev++);
+
+	kfree(imq_devs);
+}
+
+static int __init imq_init_module(void)
+{
+	int err;
+
+	if ((err = imq_init_devs()))
+		return err;
+	if ((err = imq_init_hooks())) {
+		imq_cleanup_devs();
+		return err;
+	}
+
+	printk(KERN_INFO "imq driver loaded.\n");
+
+	return 0;
+}
+
+static void __exit imq_cleanup_module(void)
+{
+	imq_unhook();
+	imq_cleanup_devs();
+}
+
+module_init(imq_init_module);
+module_exit(imq_cleanup_module);
+MODULE_LICENSE("GPL");
diff -urN linux-2.6.orig/include/linux/imq.h linux-2.6.new/include/linux/imq.h
--- linux-2.6.orig/include/linux/imq.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.new/include/linux/imq.h	2004-01-25 15:08:20.000000000 +0100
@@ -0,0 +1,9 @@
+#ifndef _IMQ_H
+#define _IMQ_H
+
+#define IMQ_MAX_DEVS   16
+
+#define IMQ_F_IFMASK   0x7f
+#define IMQ_F_ENQUEUE  0x80
+
+#endif /* _IMQ_H */
diff -urN linux-2.6.orig/include/linux/netfilter_ipv4/ipt_IMQ.h linux-2.6.new/include/linux/netfilter_ipv4/ipt_IMQ.h
--- linux-2.6.orig/include/linux/netfilter_ipv4/ipt_IMQ.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.new/include/linux/netfilter_ipv4/ipt_IMQ.h	2004-01-25 15:08:20.000000000 +0100
@@ -0,0 +1,8 @@
+#ifndef _IPT_IMQ_H
+#define _IPT_IMQ_H
+
+struct ipt_imq_info {
+	unsigned int todev;	/* target imq device */
+};
+
+#endif /* _IPT_IMQ_H */
diff -urN linux-2.6.orig/include/linux/netfilter_ipv6/ip6t_IMQ.h linux-2.6.new/include/linux/netfilter_ipv6/ip6t_IMQ.h
--- linux-2.6.orig/include/linux/netfilter_ipv6/ip6t_IMQ.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.new/include/linux/netfilter_ipv6/ip6t_IMQ.h	2004-01-25 15:08:20.000000000 +0100
@@ -0,0 +1,8 @@
+#ifndef _IP6T_IMQ_H
+#define _IP6T_IMQ_H
+
+struct ip6t_imq_info {
+	unsigned int todev;	/* target imq device */
+};
+
+#endif /* _IP6T_IMQ_H */
diff -urN linux-2.6.orig/include/linux/skbuff.h linux-2.6.new/include/linux/skbuff.h
--- linux-2.6.orig/include/linux/skbuff.h	2004-01-10 14:02:40.000000000 +0100
+++ linux-2.6.new/include/linux/skbuff.h	2004-01-25 15:08:20.000000000 +0100
@@ -98,6 +98,10 @@
 	struct nf_conntrack *master;
 };
 
+#if defined(CONFIG_IMQ) || defined(CONFIG_IMQ_MODULE)
+struct nf_info;
+#endif
+
 #ifdef CONFIG_BRIDGE_NETFILTER
 struct nf_bridge_info {
 	atomic_t use;
@@ -246,6 +250,10 @@
         unsigned long		nfmark;
 	__u32			nfcache;
 	struct nf_ct_info	*nfct;
+#if defined(CONFIG_IMQ) || defined(CONFIG_IMQ_MODULE)
+	unsigned char		imq_flags;
+	struct nf_info		*nf_info;
+#endif
 #ifdef CONFIG_NETFILTER_DEBUG
         unsigned int		nf_debug;
 #endif
diff -urN linux-2.6.orig/net/core/skbuff.c linux-2.6.new/net/core/skbuff.c
--- linux-2.6.orig/net/core/skbuff.c	2003-11-25 16:58:45.000000000 +0100
+++ linux-2.6.new/net/core/skbuff.c	2004-01-25 15:08:20.000000000 +0100
@@ -313,6 +313,10 @@
 #ifdef CONFIG_NET_SCHED
 	C(tc_index);
 #endif
+#if defined(CONFIG_IMQ) || defined(CONFIG_IMQ_MODULE)
+	C(imq_flags);
+	C(nf_info);
+#endif
 	C(truesize);
 	atomic_set(&n->users, 1);
 	C(head);
@@ -357,6 +361,10 @@
 	new->nfcache	= old->nfcache;
 	new->nfct	= old->nfct;
 	nf_conntrack_get(old->nfct);
+#if defined(CONFIG_IMQ) || defined(CONFIG_IMQ_MODULE)
+	new->imq_flags	= old->imq_flags;
+	new->nf_info	= old->nf_info;
+#endif
 #ifdef CONFIG_NETFILTER_DEBUG
 	new->nf_debug	= old->nf_debug;
 #endif
diff -urN linux-2.6.orig/net/ipv4/netfilter/Kconfig linux-2.6.new/net/ipv4/netfilter/Kconfig
--- linux-2.6.orig/net/ipv4/netfilter/Kconfig	2004-01-21 19:34:33.000000000 +0100
+++ linux-2.6.new/net/ipv4/netfilter/Kconfig	2004-01-25 15:08:20.000000000 +0100
@@ -478,6 +478,15 @@
 
 	  To compile it as a module, choose M here.  If unsure, say N.
 
+config IP_NF_TARGET_IMQ
+	tristate "IMQ target support"
+	depends on IP_NF_MANGLE
+	help
+	  This option adds a `IMQ' target which is used to specify if and
+	  to which imq device packets should get enqueued/dequeued.
+
+	  To compile it as a module, choose M here.  If unsure, say N.
+
 config IP_NF_TARGET_LOG
 	tristate "LOG target support"
 	depends on IP_NF_IPTABLES
diff -urN linux-2.6.orig/net/ipv4/netfilter/Makefile linux-2.6.new/net/ipv4/netfilter/Makefile
--- linux-2.6.orig/net/ipv4/netfilter/Makefile	2003-09-10 16:09:48.000000000 +0200
+++ linux-2.6.new/net/ipv4/netfilter/Makefile	2004-01-25 15:08:21.000000000 +0100
@@ -72,6 +72,7 @@
 obj-$(CONFIG_IP_NF_TARGET_ECN) += ipt_ECN.o
 obj-$(CONFIG_IP_NF_TARGET_DSCP) += ipt_DSCP.o
 obj-$(CONFIG_IP_NF_TARGET_MARK) += ipt_MARK.o
+obj-$(CONFIG_IP_NF_TARGET_IMQ) += ipt_IMQ.o
 obj-$(CONFIG_IP_NF_TARGET_MASQUERADE) += ipt_MASQUERADE.o
 obj-$(CONFIG_IP_NF_TARGET_REDIRECT) += ipt_REDIRECT.o
 obj-$(CONFIG_IP_NF_TARGET_NETMAP) += ipt_NETMAP.o
diff -urN linux-2.6.orig/net/ipv4/netfilter/ipt_IMQ.c linux-2.6.new/net/ipv4/netfilter/ipt_IMQ.c
--- linux-2.6.orig/net/ipv4/netfilter/ipt_IMQ.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.new/net/ipv4/netfilter/ipt_IMQ.c	2004-01-25 15:08:21.000000000 +0100
@@ -0,0 +1,78 @@
+/*
+ * This target marks packets to be enqueued to an imq device
+ */
+#include <linux/module.h>
+#include <linux/skbuff.h>
+#include <linux/netfilter_ipv4/ip_tables.h>
+#include <linux/netfilter_ipv4/ipt_IMQ.h>
+#include <linux/imq.h>
+
+static unsigned int imq_target(struct sk_buff **pskb,
+			       const struct net_device *in,
+			       const struct net_device *out,
+			       unsigned int hooknum,
+			       const void *targinfo,
+			       void *userdata)
+{
+	struct ipt_imq_info *mr = (struct ipt_imq_info*)targinfo;
+
+	(*pskb)->imq_flags = mr->todev | IMQ_F_ENQUEUE;
+	(*pskb)->nfcache |= NFC_ALTERED;
+
+	return IPT_CONTINUE;
+}
+
+static int imq_checkentry(const char *tablename,
+			  const struct ipt_entry *e,
+			  void *targinfo,
+			  unsigned int targinfosize,
+			  unsigned int hook_mask)
+{
+	struct ipt_imq_info *mr;
+
+	if (targinfosize != IPT_ALIGN(sizeof(struct ipt_imq_info))) {
+		printk(KERN_WARNING "IMQ: invalid targinfosize\n");
+		return 0;
+	}
+	mr = (struct ipt_imq_info*)targinfo;
+
+	if (strcmp(tablename, "mangle") != 0) {
+		printk(KERN_WARNING
+		       "IMQ: IMQ can only be called from \"mangle\" table, not \"%s\"\n",
+		       tablename);
+		return 0;
+	}
+
+	if (mr->todev > IMQ_MAX_DEVS) {
+		printk(KERN_WARNING
+		       "IMQ: invalid device specified, highest is %u\n",
+		       IMQ_MAX_DEVS);
+		return 0;
+	}
+
+	return 1;
+}
+
+static struct ipt_target ipt_imq_reg = {
+	.name		= "IMQ",
+	.target		= imq_target,
+	.checkentry	= imq_checkentry,
+	.me		= THIS_MODULE
+};
+
+static int __init init(void)
+{
+	if (ipt_register_target(&ipt_imq_reg))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void __exit fini(void)
+{
+	ipt_unregister_target(&ipt_imq_reg);
+}
+
+module_init(init);
+module_exit(fini);
+MODULE_LICENSE("GPL");
diff -urN linux-2.6.orig/net/ipv6/netfilter/Kconfig linux-2.6.new/net/ipv6/netfilter/Kconfig
--- linux-2.6.orig/net/ipv6/netfilter/Kconfig	2003-09-28 10:43:59.000000000 +0200
+++ linux-2.6.new/net/ipv6/netfilter/Kconfig	2004-01-25 15:08:21.000000000 +0100
@@ -217,6 +217,15 @@
 
 	  To compile it as a module, choose M here.  If unsure, say N.
 
+config IP6_NF_TARGET_IMQ
+	tristate "IMQ target support"
+	depends on IP6_NF_MANGLE
+	help
+	  This option adds a `IMQ' target which is used to specify if and
+	  to which imq device packets should get enqueued/dequeued.
+
+	  To compile it as a module, choose M here.  If unsure, say N.
+
 #dep_tristate '  LOG target support' CONFIG_IP6_NF_TARGET_LOG $CONFIG_IP6_NF_IPTABLES
 endmenu
 
diff -urN linux-2.6.orig/net/ipv6/netfilter/Makefile linux-2.6.new/net/ipv6/netfilter/Makefile
--- linux-2.6.orig/net/ipv6/netfilter/Makefile	2003-05-05 01:53:32.000000000 +0200
+++ linux-2.6.new/net/ipv6/netfilter/Makefile	2004-01-25 15:08:21.000000000 +0100
@@ -19,6 +19,7 @@
 obj-$(CONFIG_IP6_NF_FILTER) += ip6table_filter.o
 obj-$(CONFIG_IP6_NF_MANGLE) += ip6table_mangle.o
 obj-$(CONFIG_IP6_NF_TARGET_MARK) += ip6t_MARK.o
+obj-$(CONFIG_IP6_NF_TARGET_IMQ) += ip6t_IMQ.o
 obj-$(CONFIG_IP6_NF_QUEUE) += ip6_queue.o
 obj-$(CONFIG_IP6_NF_TARGET_LOG) += ip6t_LOG.o
 obj-$(CONFIG_IP6_NF_MATCH_HL) += ip6t_hl.o
diff -urN linux-2.6.orig/net/ipv6/netfilter/ip6t_IMQ.c linux-2.6.new/net/ipv6/netfilter/ip6t_IMQ.c
--- linux-2.6.orig/net/ipv6/netfilter/ip6t_IMQ.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.new/net/ipv6/netfilter/ip6t_IMQ.c	2004-01-25 15:08:21.000000000 +0100
@@ -0,0 +1,78 @@
+/*
+ * This target marks packets to be enqueued to an imq device
+ */
+#include <linux/module.h>
+#include <linux/skbuff.h>
+#include <linux/netfilter_ipv6/ip6_tables.h>
+#include <linux/netfilter_ipv6/ip6t_IMQ.h>
+#include <linux/imq.h>
+
+static unsigned int imq_target(struct sk_buff **pskb,
+			       unsigned int hooknum,
+			       const struct net_device *in,
+			       const struct net_device *out,
+			       const void *targinfo,
+			       void *userdata)
+{
+	struct ip6t_imq_info *mr = (struct ip6t_imq_info*)targinfo;
+
+	(*pskb)->imq_flags = mr->todev | IMQ_F_ENQUEUE;
+	(*pskb)->nfcache |= NFC_ALTERED;
+
+	return IP6T_CONTINUE;
+}
+
+static int imq_checkentry(const char *tablename,
+			  const struct ip6t_entry *e,
+			  void *targinfo,
+			  unsigned int targinfosize,
+			  unsigned int hook_mask)
+{
+	struct ip6t_imq_info *mr;
+
+	if (targinfosize != IP6T_ALIGN(sizeof(struct ip6t_imq_info))) {
+		printk(KERN_WARNING "IMQ: invalid targinfosize\n");
+		return 0;
+	}
+	mr = (struct ip6t_imq_info*)targinfo;
+
+	if (strcmp(tablename, "mangle") != 0) {
+		printk(KERN_WARNING
+		       "IMQ: IMQ can only be called from \"mangle\" table, not \"%s\"\n",
+		       tablename);
+		return 0;
+	}
+
+	if (mr->todev > IMQ_MAX_DEVS) {
+		printk(KERN_WARNING
+		       "IMQ: invalid device specified, highest is %u\n",
+		       IMQ_MAX_DEVS);
+		return 0;
+	}
+
+	return 1;
+}
+
+static struct ip6t_target ip6t_imq_reg = {
+	.name		= "IMQ",
+	.target		= imq_target,
+	.checkentry	= imq_checkentry,
+	.me		= THIS_MODULE
+};
+
+static int __init init(void)
+{
+	if (ip6t_register_target(&ip6t_imq_reg))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void __exit fini(void)
+{
+	ip6t_unregister_target(&ip6t_imq_reg);
+}
+
+module_init(init);
+module_exit(fini);
+MODULE_LICENSE("GPL");
diff -urN linux-2.6.orig/net/sched/sch_generic.c linux-2.6.new/net/sched/sch_generic.c
--- linux-2.6.orig/net/sched/sch_generic.c	2003-11-25 16:58:47.000000000 +0100
+++ linux-2.6.new/net/sched/sch_generic.c	2004-01-25 15:08:21.000000000 +0100
@@ -30,6 +30,9 @@
 #include <linux/skbuff.h>
 #include <linux/rtnetlink.h>
 #include <linux/init.h>
+#if defined(CONFIG_IMQ) || defined(CONFIG_IMQ_MODULE)
+#include <linux/imq.h>
+#endif
 #include <net/sock.h>
 #include <net/pkt_sched.h>
 
@@ -90,7 +93,11 @@
 			spin_unlock(&dev->queue_lock);
 
 			if (!netif_queue_stopped(dev)) {
-				if (netdev_nit)
+				if (netdev_nit
+#if defined(CONFIG_IMQ) || defined(CONFIG_IMQ_MODULE)
+				   && !(skb->imq_flags & IMQ_F_ENQUEUE)
+#endif
+				   )
 					dev_queue_xmit_nit(skb, dev);
 
 				if (dev->hard_start_xmit(skb, dev) == 0) {

-- 
Marcel Sebek
jabber: sebek@jabber.cz                     ICQ: 279852819
linux user number: 307850                 GPG ID: 5F88735E
GPG FP: 0F01 BAB8 3148 94DB B95D  1FCA 8B63 CA06 5F88 735E

