Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261246AbSJYFxH>; Fri, 25 Oct 2002 01:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261271AbSJYFxG>; Fri, 25 Oct 2002 01:53:06 -0400
Received: from horkos.telenet-ops.be ([195.130.132.45]:6596 "EHLO
	horkos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S261246AbSJYFwr> convert rfc822-to-8bit; Fri, 25 Oct 2002 01:52:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Bart De Schuymer <bart.de.schuymer@pandora.be>
To: "David S. Miller" <davem@redhat.com>
Subject: [PATCH][RFC] bridge-nf -- map IPv4 hooks onto bridge hooks - try 3, vs 2.5.44
Date: Fri, 25 Oct 2002 08:01:16 +0200
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org, Lennert Buytenhek <buytenh@gnu.org>,
       coreteam@netfilter.org
References: <20020911223252.GA12517@erik.ca> <200210210020.37097.bart.de.schuymer@pandora.be> <200210230140.27470.bart.de.schuymer@pandora.be>
In-Reply-To: <200210230140.27470.bart.de.schuymer@pandora.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210250801.16278.bart.de.schuymer@pandora.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David, Harald, others,

The following patch deals with the problems you still had with the earlier one.
Changes:
1. add #if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE) everywhere
2. don't touch ip_tables.c
3. no ipt_physdev.c file yet. I'll try to make it this weekend.

As this ipt_physdev.c module is not essential I propose to already apply this patch.
Harald, should I make this module for patch-o-magic or can I post it directly to David?

The patch is also here:
http://users.pandora.be/bart.de.schuymer/ebtables/br-nf/bridge-nf-0.0.10-dev-pre3-against-2.5.44.diff
An incremental patch vs the previous one is here:
http://users.pandora.be/bart.de.schuymer/ebtables/br-nf/bridge-nf-0.0.10-dev-pre3.001-against-2.5.44.diff

cheers,
Bart

--- linux-2.5.44/include/linux/netfilter.h	Sat Oct 19 06:01:54 2002
+++ linux-2.5.44-brnfpre3/include/linux/netfilter.h	Thu Oct 24 18:32:34 2002
@@ -117,17 +117,23 @@
 /* This is gross, but inline doesn't cut it for avoiding the function
    call in fast path: gcc doesn't inline (needs value tracking?). --RR */
 #ifdef CONFIG_NETFILTER_DEBUG
-#define NF_HOOK nf_hook_slow
+#define NF_HOOK(pf, hook, skb, indev, outdev, okfn)			\
+ nf_hook_slow((pf), (hook), (skb), (indev), (outdev), (okfn), INT_MIN)
+#define NF_HOOK_THRESH nf_hook_slow
 #else
 #define NF_HOOK(pf, hook, skb, indev, outdev, okfn)			\
 (list_empty(&nf_hooks[(pf)][(hook)])					\
  ? (okfn)(skb)								\
- : nf_hook_slow((pf), (hook), (skb), (indev), (outdev), (okfn)))
+ : nf_hook_slow((pf), (hook), (skb), (indev), (outdev), (okfn), INT_MIN))
+#define NF_HOOK_THRESH(pf, hook, skb, indev, outdev, okfn, thresh)	\
+(list_empty(&nf_hooks[(pf)][(hook)])					\
+ ? (okfn)(skb)								\
+ : nf_hook_slow((pf), (hook), (skb), (indev), (outdev), (okfn), (thresh)))
 #endif
 
 int nf_hook_slow(int pf, unsigned int hook, struct sk_buff *skb,
 		 struct net_device *indev, struct net_device *outdev,
-		 int (*okfn)(struct sk_buff *));
+		 int (*okfn)(struct sk_buff *), int thresh);
 
 /* Call setsockopt() */
 int nf_setsockopt(struct sock *sk, int pf, int optval, char *opt, 
--- linux-2.5.44/include/linux/netfilter_ipv4.h	Sat Oct 19 06:02:28 2002
+++ linux-2.5.44-brnfpre3/include/linux/netfilter_ipv4.h	Thu Oct 24 18:32:34 2002
@@ -52,8 +52,10 @@
 enum nf_ip_hook_priorities {
 	NF_IP_PRI_FIRST = INT_MIN,
 	NF_IP_PRI_CONNTRACK = -200,
+	NF_IP_PRI_BRIDGE_SABOTAGE_FORWARD = -175,
 	NF_IP_PRI_MANGLE = -150,
 	NF_IP_PRI_NAT_DST = -100,
+	NF_IP_PRI_BRIDGE_SABOTAGE_LOCAL_OUT = -50,
 	NF_IP_PRI_FILTER = 0,
 	NF_IP_PRI_NAT_SRC = 100,
 	NF_IP_PRI_LAST = INT_MAX,
--- linux-2.5.44/include/linux/netfilter_bridge.h	Sat Oct 19 06:01:57 2002
+++ linux-2.5.44-brnfpre3/include/linux/netfilter_bridge.h	Thu Oct 24 18:32:34 2002
@@ -6,6 +6,7 @@
 
 #include <linux/config.h>
 #include <linux/netfilter.h>
+#include <asm/atomic.h>
 
 /* Bridge Hooks */
 /* After promisc drops, checksum checks. */
@@ -22,14 +23,39 @@
 #define NF_BR_BROUTING		5
 #define NF_BR_NUMHOOKS		6
 
+#define BRNF_PKT_TYPE			0x01
+#define BRNF_BRIDGED_DNAT		0x02
+#define BRNF_DONT_TAKE_PARENT		0x04
+
 enum nf_br_hook_priorities {
 	NF_BR_PRI_FIRST = INT_MIN,
-	NF_BR_PRI_FILTER_BRIDGED = -200,
-	NF_BR_PRI_FILTER_OTHER = 200,
 	NF_BR_PRI_NAT_DST_BRIDGED = -300,
+	NF_BR_PRI_FILTER_BRIDGED = -200,
+	NF_BR_PRI_BRNF = 0,
 	NF_BR_PRI_NAT_DST_OTHER = 100,
+	NF_BR_PRI_FILTER_OTHER = 200,
 	NF_BR_PRI_NAT_SRC = 300,
 	NF_BR_PRI_LAST = INT_MAX,
+};
+
+static inline
+struct nf_bridge_info *nf_bridge_alloc(struct sk_buff *skb)
+{
+	struct nf_bridge_info **nf_bridge = &(skb->nf_bridge);
+
+	if ((*nf_bridge = kmalloc(sizeof(**nf_bridge), GFP_ATOMIC)) != NULL) {
+		atomic_set(&(*nf_bridge)->use, 1);
+		(*nf_bridge)->mask = 0;
+		(*nf_bridge)->physindev = (*nf_bridge)->physoutdev = NULL;
+	}
+
+	return *nf_bridge;
+}
+
+struct bridge_skb_cb {
+	union {
+		__u32 ipv4;
+	} daddr;
 };
 
 #endif
--- linux-2.5.44/include/linux/skbuff.h	Sat Oct 19 06:01:58 2002
+++ linux-2.5.44-brnfpre3/include/linux/skbuff.h	Thu Oct 24 18:32:34 2002
@@ -96,6 +96,17 @@
 struct nf_ct_info {
 	struct nf_conntrack *master;
 };
+
+#if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
+struct nf_bridge_info {
+	atomic_t use;
+	struct net_device *physindev;
+	struct net_device *physoutdev;
+	unsigned int mask;
+	unsigned long hh[16 / sizeof(unsigned long)];
+};
+#endif
+
 #endif
 
 struct sk_buff_head {
@@ -166,6 +177,7 @@
  *	@nfcache: Cache info
  *	@nfct: Associated connection, if any
  *	@nf_debug: Netfilter debugging
+ *	@nf_bridge: Saved data about a bridged frame - see br_netfilter.c
  *	@tc_index: Traffic control index
  */
 
@@ -236,6 +248,9 @@
 #ifdef CONFIG_NETFILTER_DEBUG
         unsigned int		nf_debug;
 #endif
+#if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
+	struct nf_bridge_info	*nf_bridge;
+#endif
 #endif /* CONFIG_NETFILTER */
 #if defined(CONFIG_HIPPI)
 	union {
@@ -1146,6 +1161,20 @@
 	if (nfct)
 		atomic_inc(&nfct->master->use);
 }
+
+#if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
+static inline void nf_bridge_put(struct nf_bridge_info *nf_bridge)
+{
+	if (nf_bridge && atomic_dec_and_test(&nf_bridge->use))
+		kfree(nf_bridge);
+}
+static inline void nf_bridge_get(struct nf_bridge_info *nf_bridge)
+{
+	if (nf_bridge)
+		atomic_inc(&nf_bridge->use);
+}
+#endif
+
 #endif
 
 #endif	/* __KERNEL__ */
--- linux-2.5.44/net/bridge/br.c	Sat Oct 19 06:01:15 2002
+++ linux-2.5.44-brnfpre3/net/bridge/br.c	Thu Oct 24 18:32:34 2002
@@ -45,6 +45,10 @@
 {
 	printk(KERN_INFO "NET4: Ethernet Bridge 008 for NET4.0\n");
 
+#ifdef CONFIG_NETFILTER
+	if (br_netfilter_init())
+		return 1;
+#endif
 	br_handle_frame_hook = br_handle_frame;
 	br_ioctl_hook = br_ioctl_deviceless_stub;
 #if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
@@ -63,6 +67,9 @@
 
 static void __exit br_deinit(void)
 {
+#ifdef CONFIG_NETFILTER
+	br_netfilter_fini();
+#endif
 	unregister_netdevice_notifier(&br_device_notifier);
 	br_call_ioctl_atomic(__br_clear_ioctl_hook);
 
--- linux-2.5.44/net/bridge/br_forward.c	Sat Oct 19 06:01:20 2002
+++ linux-2.5.44-brnfpre3/net/bridge/br_forward.c	Thu Oct 24 18:32:34 2002
@@ -30,18 +30,23 @@
 	return 1;
 }
 
-static int __dev_queue_push_xmit(struct sk_buff *skb)
+int br_dev_queue_push_xmit(struct sk_buff *skb)
 {
+#ifdef CONFIG_NETFILTER
+	if (skb->nf_bridge)
+		memcpy(skb->data - 16, skb->nf_bridge->hh, 16);
+#endif
 	skb_push(skb, ETH_HLEN);
+
 	dev_queue_xmit(skb);
 
 	return 0;
 }
 
-static int __br_forward_finish(struct sk_buff *skb)
+int br_forward_finish(struct sk_buff *skb)
 {
 	NF_HOOK(PF_BRIDGE, NF_BR_POST_ROUTING, skb, NULL, skb->dev,
-			__dev_queue_push_xmit);
+			br_dev_queue_push_xmit);
 
 	return 0;
 }
@@ -53,7 +58,7 @@
 	skb->nf_debug = 0;
 #endif
 	NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_OUT, skb, NULL, skb->dev,
-			__br_forward_finish);
+			br_forward_finish);
 }
 
 static void __br_forward(struct net_bridge_port *to, struct sk_buff *skb)
@@ -64,7 +69,7 @@
 	skb->dev = to->dev;
 
 	NF_HOOK(PF_BRIDGE, NF_BR_FORWARD, skb, indev, skb->dev,
-			__br_forward_finish);
+			br_forward_finish);
 }
 
 /* called under bridge lock */
--- linux-2.5.44/net/bridge/br_input.c	Sat Oct 19 06:01:18 2002
+++ linux-2.5.44-brnfpre3/net/bridge/br_input.c	Thu Oct 24 18:32:34 2002
@@ -49,7 +49,7 @@
 			br_pass_frame_up_finish);
 }
 
-static int br_handle_frame_finish(struct sk_buff *skb)
+int br_handle_frame_finish(struct sk_buff *skb)
 {
 	struct net_bridge *br;
 	unsigned char *dest;
--- linux-2.5.44/net/bridge/br_private.h	Sat Oct 19 06:01:18 2002
+++ linux-2.5.44-brnfpre3/net/bridge/br_private.h	Thu Oct 24 18:32:34 2002
@@ -144,8 +144,10 @@
 /* br_forward.c */
 extern void br_deliver(struct net_bridge_port *to,
 		struct sk_buff *skb);
+extern int br_dev_queue_push_xmit(struct sk_buff *skb);
 extern void br_forward(struct net_bridge_port *to,
 		struct sk_buff *skb);
+extern int br_forward_finish(struct sk_buff *skb);
 extern void br_flood_deliver(struct net_bridge *br,
 		      struct sk_buff *skb,
 		      int clone);
@@ -166,6 +168,7 @@
 			   int *ifindices);
 
 /* br_input.c */
+extern int br_handle_frame_finish(struct sk_buff *skb);
 extern int br_handle_frame(struct sk_buff *skb);
 
 /* br_ioctl.c */
@@ -176,6 +179,10 @@
 	     unsigned long arg1,
 	     unsigned long arg2);
 extern int br_ioctl_deviceless_stub(unsigned long arg);
+
+/* br_netfilter.c */
+extern int br_netfilter_init(void);
+extern void br_netfilter_fini(void);
 
 /* br_stp.c */
 extern int br_is_root_bridge(struct net_bridge *br);
--- linux-2.5.44/net/bridge/Makefile	Sat Oct 19 06:02:32 2002
+++ linux-2.5.44-brnfpre3/net/bridge/Makefile	Thu Oct 24 18:32:34 2002
@@ -9,6 +9,11 @@
 bridge-objs	:= br.o br_device.o br_fdb.o br_forward.o br_if.o br_input.o \
 			br_ioctl.o br_notify.o br_stp.o br_stp_bpdu.o \
 			br_stp_if.o br_stp_timer.o
+
+ifeq ($(CONFIG_NETFILTER),y)
+bridge-objs	+= br_netfilter.o
+endif
+
 obj-$(CONFIG_BRIDGE_NF_EBTABLES) += netfilter/
 
 include $(TOPDIR)/Rules.make
--- linux-2.5.44/net/core/netfilter.c	Sat Oct 19 06:01:53 2002
+++ linux-2.5.44-brnfpre3/net/core/netfilter.c	Thu Oct 24 18:32:34 2002
@@ -342,10 +342,15 @@
 			       const struct net_device *indev,
 			       const struct net_device *outdev,
 			       struct list_head **i,
-			       int (*okfn)(struct sk_buff *))
+			       int (*okfn)(struct sk_buff *),
+			       int hook_thresh)
 {
 	for (*i = (*i)->next; *i != head; *i = (*i)->next) {
 		struct nf_hook_ops *elem = (struct nf_hook_ops *)*i;
+
+		if (hook_thresh > elem->priority)
+			continue;
+
 		switch (elem->hook(hook, skb, indev, outdev, okfn)) {
 		case NF_QUEUE:
 			return NF_QUEUE;
@@ -413,6 +418,10 @@
 {
 	int status;
 	struct nf_info *info;
+#if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
+	struct net_device *physindev = NULL;
+	struct net_device *physoutdev = NULL;
+#endif
 
 	if (!queue_handler[pf].outfn) {
 		kfree_skb(skb);
@@ -435,11 +444,24 @@
 	if (indev) dev_hold(indev);
 	if (outdev) dev_hold(outdev);
 
+#if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
+	if (skb->nf_bridge) {
+		physindev = skb->nf_bridge->physindev;
+		if (physindev) dev_hold(physindev);
+		physoutdev = skb->nf_bridge->physoutdev;
+		if (physoutdev) dev_hold(physoutdev);
+	}
+#endif
+
 	status = queue_handler[pf].outfn(skb, info, queue_handler[pf].data);
 	if (status < 0) {
 		/* James M doesn't say fuck enough. */
 		if (indev) dev_put(indev);
 		if (outdev) dev_put(outdev);
+#if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
+		if (physindev) dev_put(physindev);
+		if (physoutdev) dev_put(physoutdev);
+#endif
 		kfree(info);
 		kfree_skb(skb);
 		return;
@@ -449,7 +471,8 @@
 int nf_hook_slow(int pf, unsigned int hook, struct sk_buff *skb,
 		 struct net_device *indev,
 		 struct net_device *outdev,
-		 int (*okfn)(struct sk_buff *))
+		 int (*okfn)(struct sk_buff *),
+		 int hook_thresh)
 {
 	struct list_head *elem;
 	unsigned int verdict;
@@ -481,7 +504,7 @@
 
 	elem = &nf_hooks[pf][hook];
 	verdict = nf_iterate(&nf_hooks[pf][hook], &skb, hook, indev,
-			     outdev, &elem, okfn);
+			     outdev, &elem, okfn, hook_thresh);
 	if (verdict == NF_QUEUE) {
 		NFDEBUG("nf_hook: Verdict = QUEUE.\n");
 		nf_queue(skb, elem, pf, hook, indev, outdev, okfn);
@@ -530,7 +553,7 @@
 		verdict = nf_iterate(&nf_hooks[info->pf][info->hook],
 				     &skb, info->hook, 
 				     info->indev, info->outdev, &elem,
-				     info->okfn);
+				     info->okfn, INT_MIN);
 	}
 
 	switch (verdict) {
--- linux-2.5.44/net/core/skbuff.c	Sat Oct 19 06:01:17 2002
+++ linux-2.5.44-brnfpre3/net/core/skbuff.c	Thu Oct 24 18:32:34 2002
@@ -248,6 +248,9 @@
 #ifdef CONFIG_NETFILTER_DEBUG
 	skb->nf_debug	  = 0;
 #endif
+#if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
+	skb->nf_bridge	  = NULL;
+#endif
 #endif
 #ifdef CONFIG_NET_SCHED
 	skb->tc_index	  = 0;
@@ -327,6 +330,9 @@
 	}
 #ifdef CONFIG_NETFILTER
 	nf_conntrack_put(skb->nfct);
+#if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
+	nf_bridge_put(skb->nf_bridge);
+#endif
 #endif
 	skb_headerinit(skb, NULL, 0);  /* clean state */
 	kfree_skbmem(skb);
@@ -392,6 +398,9 @@
 #ifdef CONFIG_NETFILTER_DEBUG
 	C(nf_debug);
 #endif
+#if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
+	C(nf_bridge);
+#endif
 #endif /*CONFIG_NETFILTER*/
 #if defined(CONFIG_HIPPI)
 	C(private);
@@ -404,6 +413,9 @@
 	skb->cloned = 1;
 #ifdef CONFIG_NETFILTER
 	nf_conntrack_get(skb->nfct);
+#if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
+	nf_bridge_get(skb->nf_bridge);
+#endif
 #endif
 	return n;
 }
@@ -437,6 +449,10 @@
 	nf_conntrack_get(new->nfct);
 #ifdef CONFIG_NETFILTER_DEBUG
 	new->nf_debug	= old->nf_debug;
+#endif
+#if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
+	new->nf_bridge	= old->nf_bridge;
+	nf_bridge_get(new->nf_bridge);
 #endif
 #endif
 #ifdef CONFIG_NET_SCHED
--- linux-2.5.44/net/ipv4/ip_output.c	Sat Oct 19 06:02:34 2002
+++ linux-2.5.44-brnfpre3/net/ipv4/ip_output.c	Thu Oct 24 18:32:34 2002
@@ -396,6 +396,10 @@
 	/* Connection association is same as pre-frag packet */
 	to->nfct = from->nfct;
 	nf_conntrack_get(to->nfct);
+#if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
+	to->nf_bridge = from->nf_bridge;
+	nf_bridge_get(to->nf_bridge);
+#endif
 #ifdef CONFIG_NETFILTER_DEBUG
 	to->nf_debug = from->nf_debug;
 #endif
--- linux-2.5.44/net/ipv4/netfilter/ipt_LOG.c	Sat Oct 19 06:01:21 2002
+++ linux-2.5.44-brnfpre3/net/ipv4/netfilter/ipt_LOG.c	Thu Oct 24 18:58:08 2002
@@ -289,6 +289,18 @@
 	       loginfo->prefix,
 	       in ? in->name : "",
 	       out ? out->name : "");
+#if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
+	if ((*pskb)->nf_bridge) {
+		struct net_device *physindev = (*pskb)->nf_bridge->physindev;
+		struct net_device *physoutdev = (*pskb)->nf_bridge->physoutdev;
+
+		if (physindev && in != physindev)
+			printk("PHYSIN=%s ", physindev->name);
+		if (physoutdev && out != physoutdev)
+			printk("PHYSOUT=%s ", physoutdev->name);
+	}
+#endif
+
 	if (in && !out) {
 		/* MAC logging for input chain only. */
 		printk("MAC=");
--- /dev/null	Thu Aug 24 11:00:32 2000
+++ linux-2.5.44-brnfpre3/net/bridge/br_netfilter.c	Thu Oct 24 18:32:34 2002
@@ -0,0 +1,614 @@
+/*
+ *	Handle firewalling
+ *	Linux ethernet bridge
+ *
+ *	Authors:
+ *	Lennert Buytenhek               <buytenh@gnu.org>
+ *	Bart De Schuymer		<bart.de.schuymer@pandora.be>
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *
+ *	Lennert dedicates this file to Kerstin Wurdinger.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/ip.h>
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+#include <linux/if_ether.h>
+#include <linux/netfilter_bridge.h>
+#include <linux/netfilter_ipv4.h>
+#include <linux/in_route.h>
+#include <net/ip.h>
+#include <asm/uaccess.h>
+#include <asm/checksum.h>
+#include "br_private.h"
+
+
+#define skb_origaddr(skb)	 (((struct bridge_skb_cb *) \
+				 (skb->cb))->daddr.ipv4)
+#define store_orig_dstaddr(skb)	 (skb_origaddr(skb) = (skb)->nh.iph->daddr)
+#define dnat_took_place(skb)	 (skb_origaddr(skb) != (skb)->nh.iph->daddr)
+#define clear_cb(skb)		 (memset(&skb_origaddr(skb), 0, \
+				 sizeof(struct bridge_skb_cb)))
+
+#define has_bridge_parent(device)	((device)->br_port != NULL)
+#define bridge_parent(device)		(&((device)->br_port->br->dev))
+
+/* We need these fake structures to make netfilter happy --
+ * lots of places assume that skb->dst != NULL, which isn't
+ * all that unreasonable.
+ *
+ * Currently, we fill in the PMTU entry because netfilter
+ * refragmentation needs it, and the rt_flags entry because
+ * ipt_REJECT needs it.  Future netfilter modules might
+ * require us to fill additional fields.
+ */
+static struct net_device __fake_net_device = {
+	hard_header_len:	ETH_HLEN
+};
+
+static struct rtable __fake_rtable = {
+	u: {
+		dst: {
+			__refcnt:		ATOMIC_INIT(1),
+			dev:			&__fake_net_device,
+			pmtu:			1500
+		}
+	},
+
+	rt_flags:	0
+};
+
+
+/* PF_BRIDGE/PRE_ROUTING *********************************************/
+static void __br_dnat_complain(void)
+{
+	static unsigned long last_complaint = 0;
+
+	if (jiffies - last_complaint >= 5 * HZ) {
+		printk(KERN_WARNING "Performing cross-bridge DNAT requires IP "
+			"forwarding to be enabled\n");
+		last_complaint = jiffies;
+	}
+}
+
+
+/* This requires some explaining. If DNAT has taken place,
+ * we will need to fix up the destination Ethernet address,
+ * and this is a tricky process.
+ *
+ * There are two cases to consider:
+ * 1. The packet was DNAT'ed to a device in the same bridge
+ *    port group as it was received on. We can still bridge
+ *    the packet.
+ * 2. The packet was DNAT'ed to a different device, either
+ *    a non-bridged device or another bridge port group.
+ *    The packet will need to be routed.
+ *
+ * The correct way of distinguishing between these two cases is to
+ * call ip_route_input() and to look at skb->dst->dev, which is
+ * changed to the destination device if ip_route_input() succeeds.
+ *
+ * Let us first consider the case that ip_route_input() succeeds:
+ *
+ * If skb->dst->dev equals the logical bridge device the packet
+ * came in on, we can consider this bridging. We then call
+ * skb->dst->output() which will make the packet enter br_nf_local_out()
+ * not much later. In that function it is assured that the iptables
+ * FORWARD chain is traversed for the packet.
+ *
+ * Otherwise, the packet is considered to be routed and we just
+ * change the destination MAC address so that the packet will
+ * later be passed up to the IP stack to be routed.
+ *
+ * Let us now consider the case that ip_route_input() fails:
+ *
+ * After a "echo '0' > /proc/sys/net/ipv4/ip_forward" ip_route_input()
+ * will fail, while ip_route_output() will return success. The source
+ * address for ip_route_output() is set to zero, so ip_route_output()
+ * thinks we're handling a locally generated packet and won't care
+ * if IP forwarding is allowed. We send a warning message to the users's
+ * log telling her to put IP forwarding on.
+ *
+ * ip_route_input() will also fail if there is no route available.
+ * In that case we just drop the packet.
+ *
+ * --Lennert, 20020411
+ * --Bart, 20020416 (updated)
+ * --Bart, 20021007 (updated)
+ */
+
+static int br_nf_pre_routing_finish_bridge(struct sk_buff *skb)
+{
+#ifdef CONFIG_NETFILTER_DEBUG
+	skb->nf_debug |= (1 << NF_BR_PRE_ROUTING) | (1 << NF_BR_FORWARD);
+#endif
+
+	if (skb->pkt_type == PACKET_OTHERHOST) {
+		skb->pkt_type = PACKET_HOST;
+		skb->nf_bridge->mask |= BRNF_PKT_TYPE;
+	}
+
+	skb->dev = bridge_parent(skb->dev);
+	skb->dst->output(skb);
+	return 0;
+}
+
+static int br_nf_pre_routing_finish(struct sk_buff *skb)
+{
+	struct net_device *dev = skb->dev;
+	struct iphdr *iph = skb->nh.iph;
+	struct nf_bridge_info *nf_bridge = skb->nf_bridge;
+
+#ifdef CONFIG_NETFILTER_DEBUG
+	skb->nf_debug ^= (1 << NF_BR_PRE_ROUTING);
+#endif
+
+	if (nf_bridge->mask & BRNF_PKT_TYPE) {
+		skb->pkt_type = PACKET_OTHERHOST;
+		nf_bridge->mask ^= BRNF_PKT_TYPE;
+	}
+
+	if (dnat_took_place(skb)) {
+		if (ip_route_input(skb, iph->daddr, iph->saddr, iph->tos,
+		    dev)) {
+			struct rtable *rt;
+
+			if (!ip_route_output(&rt, iph->daddr, 0, iph->tos, 0)) {
+				/* Bridged-and-DNAT'ed traffic doesn't
+				 * require ip_forwarding.
+				 */
+				if (((struct dst_entry *)rt)->dev == dev) {
+					skb->dst = (struct dst_entry *)rt;
+					goto bridged_dnat;
+				}
+				__br_dnat_complain();
+				dst_release((struct dst_entry *)rt);
+			}
+			kfree_skb(skb);
+			return 0;
+		} else {
+			if (skb->dst->dev == dev) {
+bridged_dnat:
+				/* Tell br_nf_local_out this is a
+				 * bridged frame
+				 */
+				nf_bridge->mask |= BRNF_BRIDGED_DNAT;
+				skb->dev = nf_bridge->physindev;
+				clear_cb(skb);
+				NF_HOOK_THRESH(PF_BRIDGE, NF_BR_PRE_ROUTING,
+					       skb, skb->dev, NULL,
+					       br_nf_pre_routing_finish_bridge,
+					       1);
+				return 0;
+			}
+			memcpy(skb->mac.ethernet->h_dest, dev->dev_addr,
+			       ETH_ALEN);
+		}
+	} else {
+		skb->dst = (struct dst_entry *)&__fake_rtable;
+		dst_hold(skb->dst);
+	}
+
+	clear_cb(skb);
+	skb->dev = nf_bridge->physindev;
+	NF_HOOK_THRESH(PF_BRIDGE, NF_BR_PRE_ROUTING, skb, skb->dev, NULL,
+		       br_handle_frame_finish, 1);
+
+	return 0;
+}
+
+/* Replicate the checks that IPv4 does on packet reception.
+ * Set skb->dev to the bridge device (i.e. parent of the
+ * receiving device) to make netfilter happy, the REDIRECT
+ * target in particular.  Save the original destination IP
+ * address to be able to detect DNAT afterwards.
+ */
+static unsigned int br_nf_pre_routing(unsigned int hook, struct sk_buff **pskb,
+   const struct net_device *in, const struct net_device *out,
+   int (*okfn)(struct sk_buff *))
+{
+	struct iphdr *iph;
+	__u32 len;
+	struct sk_buff *skb;
+	struct nf_bridge_info *nf_bridge;
+
+	if ((*pskb)->protocol != __constant_htons(ETH_P_IP))
+		return NF_ACCEPT;
+
+	if ((skb = skb_share_check(*pskb, GFP_ATOMIC)) == NULL)
+		goto out;
+
+	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
+		goto inhdr_error;
+
+	iph = skb->nh.iph;
+	if (iph->ihl < 5 || iph->version != 4)
+		goto inhdr_error;
+
+	if (!pskb_may_pull(skb, 4*iph->ihl))
+		goto inhdr_error;
+
+	iph = skb->nh.iph;
+	if (ip_fast_csum((__u8 *)iph, iph->ihl) != 0)
+		goto inhdr_error;
+
+	len = ntohs(iph->tot_len);
+	if (skb->len < len || len < 4*iph->ihl)
+		goto inhdr_error;
+
+	if (skb->len > len) {
+		__pskb_trim(skb, len);
+		if (skb->ip_summed == CHECKSUM_HW)
+			skb->ip_summed = CHECKSUM_NONE;
+	}
+
+#ifdef CONFIG_NETFILTER_DEBUG
+	skb->nf_debug ^= (1 << NF_IP_PRE_ROUTING);
+#endif
+ 	if ((nf_bridge = nf_bridge_alloc(skb)) == NULL)
+		return NF_DROP;
+
+	if (skb->pkt_type == PACKET_OTHERHOST) {
+		skb->pkt_type = PACKET_HOST;
+		nf_bridge->mask |= BRNF_PKT_TYPE;
+	}
+
+	nf_bridge->physindev = skb->dev;
+	skb->dev = bridge_parent(skb->dev);
+	store_orig_dstaddr(skb);
+
+	NF_HOOK(PF_INET, NF_IP_PRE_ROUTING, skb, skb->dev, NULL,
+		br_nf_pre_routing_finish);
+
+	return NF_STOLEN;
+
+inhdr_error:
+//	IP_INC_STATS_BH(IpInHdrErrors);
+out:
+	return NF_DROP;
+}
+
+
+/* PF_BRIDGE/LOCAL_IN ************************************************/
+/* The packet is locally destined, which requires a real
+ * dst_entry, so detach the fake one.  On the way up, the
+ * packet would pass through PRE_ROUTING again (which already
+ * took place when the packet entered the bridge), but we
+ * register an IPv4 PRE_ROUTING 'sabotage' hook that will
+ * prevent this from happening.
+ */
+static unsigned int br_nf_local_in(unsigned int hook, struct sk_buff **pskb,
+   const struct net_device *in, const struct net_device *out,
+   int (*okfn)(struct sk_buff *))
+{
+	struct sk_buff *skb = *pskb;
+
+	if (skb->protocol != __constant_htons(ETH_P_IP))
+		return NF_ACCEPT;
+
+	if (skb->dst == (struct dst_entry *)&__fake_rtable) {
+		dst_release(skb->dst);
+		skb->dst = NULL;
+	}
+
+	return NF_ACCEPT;
+}
+
+
+/* PF_BRIDGE/FORWARD *************************************************/
+static int br_nf_forward_finish(struct sk_buff *skb)
+{
+	struct nf_bridge_info *nf_bridge = skb->nf_bridge;
+
+#ifdef CONFIG_NETFILTER_DEBUG
+	skb->nf_debug ^= (1 << NF_BR_FORWARD);
+#endif
+
+	if (nf_bridge->mask & BRNF_PKT_TYPE) {
+		skb->pkt_type = PACKET_OTHERHOST;
+		nf_bridge->mask ^= BRNF_PKT_TYPE;
+	}
+
+	NF_HOOK_THRESH(PF_BRIDGE, NF_BR_FORWARD, skb, nf_bridge->physindev,
+			skb->dev, br_forward_finish, 1);
+
+	return 0;
+}
+
+/* This is the 'purely bridged' case.  We pass the packet to
+ * netfilter with indev and outdev set to the bridge device,
+ * but we are still able to filter on the 'real' indev/outdev
+ * because another bit of the bridge-nf patch overloads the
+ * '-i' and '-o' iptables interface checks to take
+ * skb->phys{in,out}dev into account as well (so both the real
+ * device and the bridge device will match).
+ */
+static unsigned int br_nf_forward(unsigned int hook, struct sk_buff **pskb,
+   const struct net_device *in, const struct net_device *out,
+   int (*okfn)(struct sk_buff *))
+{
+	struct sk_buff *skb = *pskb;
+	struct nf_bridge_info *nf_bridge;
+
+	if (skb->protocol != __constant_htons(ETH_P_IP))
+		return NF_ACCEPT;
+
+#ifdef CONFIG_NETFILTER_DEBUG
+	skb->nf_debug ^= (1 << NF_BR_FORWARD);
+#endif
+
+	nf_bridge = skb->nf_bridge;
+	if (skb->pkt_type == PACKET_OTHERHOST) {
+		skb->pkt_type = PACKET_HOST;
+		nf_bridge->mask |= BRNF_PKT_TYPE;
+	}
+
+	nf_bridge->physoutdev = skb->dev;
+
+	NF_HOOK(PF_INET, NF_IP_FORWARD, skb, bridge_parent(nf_bridge->physindev),
+			bridge_parent(skb->dev), br_nf_forward_finish);
+
+	return NF_STOLEN;
+}
+
+
+/* PF_BRIDGE/LOCAL_OUT ***********************************************/
+static int br_nf_local_out_finish(struct sk_buff *skb)
+{
+#ifdef CONFIG_NETFILTER_DEBUG
+	skb->nf_debug &= ~(1 << NF_BR_LOCAL_OUT);
+#endif
+
+	NF_HOOK_THRESH(PF_BRIDGE, NF_BR_LOCAL_OUT, skb, NULL, skb->dev,
+			br_forward_finish, NF_BR_PRI_FIRST + 1);
+
+	return 0;
+}
+
+
+/* This function sees both locally originated IP packets and forwarded
+ * IP packets (in both cases the destination device is a bridge
+ * device). It also sees bridged-and-DNAT'ed packets.
+ * For the sake of interface transparency (i.e. properly
+ * overloading the '-o' option), we steal packets destined to
+ * a bridge device away from the PF_INET/FORWARD and PF_INET/OUTPUT hook
+ * functions, and give them back later, when we have determined the real
+ * output device. This is done in here.
+ *
+ * If (nf_bridge->mask & BRNF_BRIDGED_DNAT) then the packet is bridged
+ * and we fake the PF_BRIDGE/FORWARD hook. The function br_nf_forward()
+ * will then fake the PF_INET/FORWARD hook. br_nf_local_out() has priority
+ * NF_BR_PRI_FIRST, so no relevant PF_BRIDGE/INPUT functions have been nor
+ * will be executed.
+ * Otherwise, if nf_bridge->physindev is NULL, the bridge-nf code never touched
+ * this packet before, and so the packet was locally originated. We fake
+ * the PF_INET/LOCAL_OUT hook.
+ * Finally, if nf_bridge->physindev isn't NULL, then the packet was IP routed,
+ * so we fake the PF_INET/FORWARD hook. ipv4_sabotage_out() makes sure
+ * even routed packets that didn't arrive on a bridge interface have their
+ * nf_bridge->physindev set.
+ */
+
+static unsigned int br_nf_local_out(unsigned int hook, struct sk_buff **pskb,
+   const struct net_device *in, const struct net_device *out,
+   int (*_okfn)(struct sk_buff *))
+{
+	int (*okfn)(struct sk_buff *skb);
+	struct net_device *realindev;
+	struct sk_buff *skb = *pskb;
+	struct nf_bridge_info *nf_bridge;
+
+	if (skb->protocol != __constant_htons(ETH_P_IP))
+		return NF_ACCEPT;
+
+	/* Sometimes we get packets with NULL ->dst here (for example,
+	 * running a dhcp client daemon triggers this).
+	 */
+	if (skb->dst == NULL)
+		return NF_ACCEPT;
+
+	nf_bridge = skb->nf_bridge;
+	nf_bridge->physoutdev = skb->dev;
+
+	realindev = nf_bridge->physindev;
+
+	/* Bridged, take PF_BRIDGE/FORWARD.
+	 * (see big note in front of br_nf_pre_routing_finish)
+	 */
+	if (nf_bridge->mask & BRNF_BRIDGED_DNAT) {
+		okfn = br_forward_finish;
+
+		if (nf_bridge->mask & BRNF_PKT_TYPE) {
+			skb->pkt_type = PACKET_OTHERHOST;
+			nf_bridge->mask ^= BRNF_PKT_TYPE;
+		}
+
+		NF_HOOK(PF_BRIDGE, NF_BR_FORWARD, skb, realindev,
+			skb->dev, okfn);
+	} else {
+		okfn = br_nf_local_out_finish;
+		/* IP forwarded traffic has a physindev, locally
+		 * generated traffic hasn't.
+		 */
+		if (realindev != NULL) {
+			if (((nf_bridge->mask & BRNF_DONT_TAKE_PARENT) == 0) &&
+			    has_bridge_parent(realindev))
+				realindev = bridge_parent(realindev);
+
+			NF_HOOK_THRESH(PF_INET, NF_IP_FORWARD, skb, realindev,
+				       bridge_parent(skb->dev), okfn,
+				       NF_IP_PRI_BRIDGE_SABOTAGE_FORWARD + 1);
+		} else {
+#ifdef CONFIG_NETFILTER_DEBUG
+			skb->nf_debug ^= (1 << NF_IP_LOCAL_OUT);
+#endif
+
+			NF_HOOK_THRESH(PF_INET, NF_IP_LOCAL_OUT, skb, realindev,
+				       bridge_parent(skb->dev), okfn,
+				       NF_IP_PRI_BRIDGE_SABOTAGE_LOCAL_OUT + 1);
+		}
+	}
+
+	return NF_STOLEN;
+}
+
+
+/* PF_BRIDGE/POST_ROUTING ********************************************/
+static unsigned int br_nf_post_routing(unsigned int hook, struct sk_buff **pskb,
+   const struct net_device *in, const struct net_device *out,
+   int (*okfn)(struct sk_buff *))
+{
+	struct sk_buff *skb = *pskb;
+	struct nf_bridge_info *nf_bridge = (*pskb)->nf_bridge;
+
+	/* Be very paranoid.  */
+	if (skb->mac.raw < skb->head || skb->mac.raw + ETH_HLEN > skb->data) {
+		printk(KERN_CRIT "br_netfilter: Argh!! br_nf_post_routing: "
+				 "bad mac.raw pointer.");
+		if (skb->dev != NULL) {
+			printk("[%s]", skb->dev->name);
+			if (has_bridge_parent(skb->dev))
+				printk("[%s]", bridge_parent(skb->dev)->name);
+		}
+		printk("\n");
+		return NF_ACCEPT;
+	}
+
+	if (skb->protocol != __constant_htons(ETH_P_IP))
+		return NF_ACCEPT;
+
+	/* Sometimes we get packets with NULL ->dst here (for example,
+	 * running a dhcp client daemon triggers this).
+	 */
+	if (skb->dst == NULL)
+		return NF_ACCEPT;
+
+#ifdef CONFIG_NETFILTER_DEBUG
+	skb->nf_debug ^= (1 << NF_IP_POST_ROUTING);
+#endif
+
+	/* We assume any code from br_dev_queue_push_xmit onwards doesn't care
+	 * about the value of skb->pkt_type.
+	 */
+	if (skb->pkt_type == PACKET_OTHERHOST) {
+		skb->pkt_type = PACKET_HOST;
+		nf_bridge->mask |= BRNF_PKT_TYPE;
+	}
+
+	memcpy(nf_bridge->hh, skb->data - 16, 16);
+
+	NF_HOOK(PF_INET, NF_IP_POST_ROUTING, skb, NULL,
+		bridge_parent(skb->dev), br_dev_queue_push_xmit);
+
+	return NF_STOLEN;
+}
+
+
+/* IPv4/SABOTAGE *****************************************************/
+
+/* Don't hand locally destined packets to PF_INET/PRE_ROUTING
+ * for the second time.
+ */
+static unsigned int ipv4_sabotage_in(unsigned int hook, struct sk_buff **pskb,
+   const struct net_device *in, const struct net_device *out,
+   int (*okfn)(struct sk_buff *))
+{
+	if (in->hard_start_xmit == br_dev_xmit &&
+	    okfn != br_nf_pre_routing_finish) {
+		okfn(*pskb);
+		return NF_STOLEN;
+	}
+
+	return NF_ACCEPT;
+}
+
+/* Postpone execution of PF_INET/FORWARD, PF_INET/LOCAL_OUT
+ * and PF_INET/POST_ROUTING until we have done the forwarding
+ * decision in the bridge code and have determined skb->physoutdev.
+ */
+static unsigned int ipv4_sabotage_out(unsigned int hook, struct sk_buff **pskb,
+   const struct net_device *in, const struct net_device *out,
+   int (*okfn)(struct sk_buff *))
+{
+	if (out->hard_start_xmit == br_dev_xmit &&
+	    okfn != br_nf_forward_finish &&
+	    okfn != br_nf_local_out_finish &&
+	    okfn != br_dev_queue_push_xmit) {
+		struct sk_buff *skb = *pskb;
+		struct nf_bridge_info *nf_bridge;
+
+		if (!skb->nf_bridge && !nf_bridge_alloc(skb))
+			return NF_DROP;
+
+		nf_bridge = skb->nf_bridge;
+
+		/* This frame will arrive on PF_BRIDGE/LOCAL_OUT and we
+		 * will need the indev then. For a brouter, the real indev
+		 * can be a bridge port, so we make sure br_nf_local_out()
+		 * doesn't use the bridge parent of the indev by using
+		 * the BRNF_DONT_TAKE_PARENT mask.
+		 */
+		if (hook == NF_IP_FORWARD && nf_bridge->physindev == NULL) {
+			nf_bridge->mask &= BRNF_DONT_TAKE_PARENT;
+			nf_bridge->physindev = (struct net_device *)in;
+		}
+		okfn(skb);
+		return NF_STOLEN;
+	}
+
+	return NF_ACCEPT;
+}
+
+/* For br_nf_local_out we need (prio = NF_BR_PRI_FIRST), to insure that innocent
+ * PF_BRIDGE/NF_BR_LOCAL_OUT functions don't get bridged traffic as input.
+ * For br_nf_post_routing, we need (prio = NF_BR_PRI_LAST), because
+ * ip_refrag() can return NF_STOLEN.
+ */
+static struct nf_hook_ops br_nf_ops[] = {
+	{ { NULL, NULL }, br_nf_pre_routing, PF_BRIDGE, NF_BR_PRE_ROUTING, NF_BR_PRI_BRNF },
+	{ { NULL, NULL }, br_nf_local_in, PF_BRIDGE, NF_BR_LOCAL_IN, NF_BR_PRI_BRNF },
+	{ { NULL, NULL }, br_nf_forward, PF_BRIDGE, NF_BR_FORWARD, NF_BR_PRI_BRNF },
+	{ { NULL, NULL }, br_nf_local_out, PF_BRIDGE, NF_BR_LOCAL_OUT, NF_BR_PRI_FIRST },
+	{ { NULL, NULL }, br_nf_post_routing, PF_BRIDGE, NF_BR_POST_ROUTING, NF_BR_PRI_LAST },
+	{ { NULL, NULL }, ipv4_sabotage_in, PF_INET, NF_IP_PRE_ROUTING, NF_IP_PRI_FIRST },
+	{ { NULL, NULL }, ipv4_sabotage_out, PF_INET, NF_IP_FORWARD, NF_IP_PRI_BRIDGE_SABOTAGE_FORWARD },
+	{ { NULL, NULL }, ipv4_sabotage_out, PF_INET, NF_IP_LOCAL_OUT, NF_IP_PRI_BRIDGE_SABOTAGE_LOCAL_OUT },
+	{ { NULL, NULL }, ipv4_sabotage_out, PF_INET, NF_IP_POST_ROUTING, NF_IP_PRI_FIRST }
+};
+
+#define NUMHOOKS (sizeof(br_nf_ops)/sizeof(br_nf_ops[0]))
+
+int br_netfilter_init(void)
+{
+	int i;
+
+	for (i = 0; i < NUMHOOKS; i++) {
+		int ret;
+
+		if ((ret = nf_register_hook(&br_nf_ops[i])) >= 0)
+			continue;
+
+		while (i--)
+			nf_unregister_hook(&br_nf_ops[i]);
+
+		return ret;
+	}
+
+	printk(KERN_NOTICE "Bridge firewalling registered\n");
+
+	return 0;
+}
+
+void br_netfilter_fini(void)
+{
+	int i;
+
+	for (i = NUMHOOKS - 1; i >= 0; i--)
+		nf_unregister_hook(&br_nf_ops[i]);
+}

