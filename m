Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbTEAUoR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 16:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbTEAUoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 16:44:17 -0400
Received: from gw.chygwyn.com ([62.172.158.50]:63247 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id S262478AbTEAUoC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 16:44:02 -0400
From: Steven Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200305012057.VAA19347@gw.chygwyn.com>
Subject: Re: Remains of seq_file conversion for DECnet, plus fixes (part 3)
To: davem@redhat.com (David S. Miller)
Date: Thu, 1 May 2003 21:57:45 +0100 (BST)
Cc: linux-decnet-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20030501.060909.26990580.davem@redhat.com> from "David S. Miller" at May 01, 2003 06:09:09 AM
Organization: ChyGywn Limited
X-RegisteredOffice: 7, New Yatt Road, Witney, Oxfordshire. OX28 1NU England
X-RegisteredNumber: 03887683
Reply-To: Steve Whitehouse <Steve@ChyGwyn.com>
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is part 3 (stands alone) with the following feature:

  o Added netfilter subdir for decnet and add the routing grabulator

Steve.


------------------------------------------------------------------------------

diff -Nru linux-2.5.68-bk10/net/decnet/Makefile linux/net/decnet/Makefile
--- linux-2.5.68-bk10/net/decnet/Makefile	Wed Jan  1 19:21:18 2003
+++ linux/net/decnet/Makefile	Wed Apr 23 10:27:53 2003
@@ -1,7 +1,10 @@
 
 obj-$(CONFIG_DECNET) += decnet.o
 
-decnet-y := af_decnet.o dn_nsp_in.o dn_nsp_out.o dn_route.o dn_dev.o dn_neigh.o dn_timer.o
+decnet-y := af_decnet.o dn_nsp_in.o dn_nsp_out.o \
+	    dn_route.o dn_dev.o dn_neigh.o dn_timer.o
 decnet-$(CONFIG_DECNET_ROUTER) += dn_fib.o dn_rules.o dn_table.o
-decnet-$(CONFIG_DECNET_FW) += dn_fw.o
 decnet-y += sysctl_net_decnet.o
+
+obj-$(CONFIG_NETFILTER) += netfilter/
+
diff -Nru linux-2.5.68-bk10/net/decnet/Kconfig linux/net/decnet/Kconfig
--- linux-2.5.68-bk10/net/decnet/Kconfig	Wed Jan  1 19:23:15 2003
+++ linux/net/decnet/Kconfig	Wed Apr 23 10:29:31 2003
@@ -17,11 +17,11 @@
 	depends on DECNET && EXPERIMENTAL
 	---help---
 	  Add support for turning your DECnet Endnode into a level 1 or 2
-	  router.  This is an unfinished option for developers only.  If you
+	  router.  This is an experimental, but functional option.  If you
 	  do say Y here, then make sure that you also say Y to "Kernel/User
 	  network link driver", "Routing messages" and "Network packet
 	  filtering".  The first two are required to allow configuration via
-	  rtnetlink (currently you need Alexey Kuznetsov's iproute2 package
+	  rtnetlink (you will need Alexey Kuznetsov's iproute2 package
 	  from <ftp://ftp.inr.ac.ru/>). The "Network packet filtering" option
 	  will be required for the forthcoming routing daemon to work.
 
@@ -34,4 +34,6 @@
 	  If you say Y here, you will be able to specify different routes for
 	  packets with different FWMARK ("firewalling mark") values
 	  (see ipchains(8), "-m" argument).
+
+source "net/decnet/netfilter/Kconfig"
 
diff -Nru linux-2.5.68-bk10/net/decnet/netfilter/Kconfig linux/net/decnet/netfilter/Kconfig
--- linux-2.5.68-bk10/net/decnet/netfilter/Kconfig	Wed Dec 31 16:00:00 1969
+++ linux/net/decnet/netfilter/Kconfig	Wed Apr 23 13:02:25 2003
@@ -0,0 +1,15 @@
+#
+# DECnet netfilter configuration
+#
+
+menu "DECnet: Netfilter Configuration"
+	depends on DECNET && NETFILTER && EXPERIMENTAL
+
+config DECNET_NF_GRABULATOR
+	tristate "Routing message grabulator (for userland routing daemon)"
+	help
+	  Enable this module if you want to use the userland DECnet routing
+	  daemon. You will also need to enable routing support for DECnet
+	  unless you just want to monitor routing messages from other nodes.
+
+endmenu
diff -Nru linux-2.5.68-bk10/net/decnet/netfilter/Makefile linux/net/decnet/netfilter/Makefile
--- linux-2.5.68-bk10/net/decnet/netfilter/Makefile	Wed Dec 31 16:00:00 1969
+++ linux/net/decnet/netfilter/Makefile	Wed Apr 23 10:25:21 2003
@@ -0,0 +1,6 @@
+#
+# Makefile for DECnet netfilter modules
+#
+
+obj-$(CONFIG_DECNET_NF_GRABULATOR) += dn_rtmsg.o
+
diff -Nru linux-2.5.68-bk10/net/decnet/netfilter/dn_rtmsg.c linux/net/decnet/netfilter/dn_rtmsg.c
--- linux-2.5.68-bk10/net/decnet/netfilter/dn_rtmsg.c	Wed Dec 31 16:00:00 1969
+++ linux/net/decnet/netfilter/dn_rtmsg.c	Wed Apr 23 14:05:10 2003
@@ -0,0 +1,167 @@
+/*
+ * DECnet       An implementation of the DECnet protocol suite for the LINUX
+ *              operating system.  DECnet is implemented using the  BSD Socket
+ *              interface as the means of communication with the user level.
+ *
+ *              DECnet Routing Message Grabulator
+ *
+ *              (C) 2000 ChyGwyn Limited  -  http://www.chygwyn.com/
+ *              This code may be copied under the GPL v.2 or at your option
+ *              any later version.
+ *
+ * Author:      Steven Whitehouse <steve@chygwyn.com>
+ *
+ */
+#include <linux/module.h>
+#include <linux/skbuff.h>
+#include <linux/init.h>
+#include <linux/netdevice.h>
+#include <linux/netfilter.h>
+#include <linux/spinlock.h>
+#include <linux/netlink.h>
+
+#include <net/sock.h>
+#include <net/flow.h>
+#include <net/dn.h>
+#include <net/dn_route.h>
+
+#include <linux/netfilter_decnet.h>
+
+static struct sock *dnrmg = NULL;
+
+
+static struct sk_buff *dnrmg_build_message(struct sk_buff *rt_skb, int *errp)
+{
+	struct sk_buff *skb = NULL;
+	size_t size;
+	unsigned char *old_tail;
+	struct nlmsghdr *nlh;
+	unsigned char *ptr;
+	struct nf_dn_rtmsg *rtm;
+
+	size = NLMSG_SPACE(rt_skb->len);
+	size += NLMSG_ALIGN(sizeof(struct nf_dn_rtmsg));
+	skb = alloc_skb(size, GFP_ATOMIC);
+	if (!skb)
+		goto nlmsg_failure;
+	old_tail = skb->tail;
+	nlh = NLMSG_PUT(skb, 0, 0, 0, size - sizeof(*nlh));
+	rtm = (struct nf_dn_rtmsg *)NLMSG_DATA(nlh);
+	rtm->nfdn_ifindex = rt_skb->dev->ifindex;
+	ptr = NFDN_RTMSG(rtm);
+	memcpy(ptr, rt_skb->data, rt_skb->len);
+	nlh->nlmsg_len = skb->tail - old_tail;
+	return skb;
+
+nlmsg_failure:
+	if (skb)
+		kfree(skb);
+	*errp = -ENOMEM;
+	if (net_ratelimit())
+		printk(KERN_ERR "dn_rtmsg: error creating netlink message\n");
+	return NULL;
+}
+
+static void dnrmg_send_peer(struct sk_buff *skb)
+{
+	struct sk_buff *skb2;
+	int status = 0;
+	int group = 0;
+	unsigned char flags = *skb->data;
+
+	switch(flags & DN_RT_CNTL_MSK) {
+		case DN_RT_PKT_L1RT:
+			group = DNRMG_L1_GROUP;
+			break;
+		case DN_RT_PKT_L2RT:
+			group = DNRMG_L2_GROUP;
+			break;
+		default:
+			return;
+	}
+
+	skb2 = dnrmg_build_message(skb, &status);
+	if (skb2 == NULL)
+		return;
+	NETLINK_CB(skb2).dst_groups = group;
+	netlink_broadcast(dnrmg, skb2, 0, group, GFP_ATOMIC);
+}
+
+
+static unsigned int dnrmg_hook(unsigned int hook,
+			struct sk_buff **pskb,
+			const struct net_device *in,
+			const struct net_device *out,
+			int (*okfn)(struct sk_buff *))
+{
+	dnrmg_send_peer(*pskb);
+	return NF_ACCEPT;
+}
+
+
+#define RCV_SKB_FAIL(err) do { netlink_ack(skb, nlh, (err)); return; } while (0)
+
+static inline void dnrmg_receive_user_skb(struct sk_buff *skb)
+{
+	struct nlmsghdr *nlh = (struct nlmsghdr *)skb->data;
+
+	if (nlh->nlmsg_len < sizeof(*nlh) || skb->len < nlh->nlmsg_len)
+		return;
+
+	if (!cap_raised(NETLINK_CB(skb).eff_cap, CAP_NET_ADMIN))
+		RCV_SKB_FAIL(-EPERM);
+
+	/* Eventually we might send routing messages too */
+
+	RCV_SKB_FAIL(-EINVAL);
+}
+
+static void dnrmg_receive_user_sk(struct sock *sk, int len)
+{
+	struct sk_buff *skb;
+
+	while((skb = skb_dequeue(&sk->receive_queue)) != NULL) {
+		dnrmg_receive_user_skb(skb);
+		kfree_skb(skb);
+	}
+}
+
+static struct nf_hook_ops dnrmg_ops = {
+	.hook		= dnrmg_hook,
+	.pf		= PF_DECnet,
+	.hooknum	= NF_DN_ROUTE,
+	.priority	= NF_DN_PRI_DNRTMSG,
+};
+
+static int __init init(void)
+{
+	int rv = 0;
+
+	dnrmg = netlink_kernel_create(NETLINK_DNRTMSG, dnrmg_receive_user_sk);
+	if (dnrmg == NULL) {
+		printk(KERN_ERR "dn_rtmsg: Cannot create netlink socket");
+		return -ENOMEM;
+	}
+
+	rv = nf_register_hook(&dnrmg_ops);
+	if (rv) {
+		sock_release(dnrmg->socket);
+	}
+
+	return rv;
+}
+
+static void __exit fini(void)
+{
+	nf_unregister_hook(&dnrmg_ops);
+	sock_release(dnrmg->socket);
+}
+
+
+MODULE_DESCRIPTION("DECnet Routing Message Grabulator");
+MODULE_AUTHOR("Steven Whitehouse <steve@chygwyn.com>");
+MODULE_LICENSE("GPL");
+
+module_init(init);
+module_exit(fini);
+
