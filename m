Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964949AbVIHRNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbVIHRNr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 13:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbVIHRNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 13:13:47 -0400
Received: from mournblade.cat.pdx.edu ([131.252.208.27]:30943 "EHLO
	mournblade.cat.pdx.edu") by vger.kernel.org with ESMTP
	id S964949AbVIHRNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 13:13:46 -0400
Date: Thu, 8 Sep 2005 10:12:52 -0700 (PDT)
From: Suzanne Wood <suzannew@cs.pdx.edu>
Message-Id: <200509081712.j88HCqke013162@rastaban.cs.pdx.edu>
To: linux-kernel@vger.kernel.org
Cc: Robert.Olsson@data.slu.se, paulmck@us.ibm.com, suzannew@cs.pdx.edu,
       walpole@cs.pdx.edu
Subject: [RFC][PATCH] identify in_dev_get rcu read-side critical sections
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please consider this request for suggestions on an attempt at a partial patch 
based on the assumptions below to identify rcu read-side critical sections 
for in_dev_get() defined in inetdevice.h.  Thank you.

drivers/s390/net/lcs.c		|	 2 ++
drivers/s390/net/qeth_main.c	|	 4 ++++
include/linux/inetdevice.h	|	 2 +-
net/ipv4/arp.c			|	17 +++++++++++------
net/ipv4/devinet.c		|	 6 +++++-
net/ipv4/icmp.c			|	 4 ++--
net/ipv4/igmp.c			|	22 ++++++++++++++++++----
net/ipv4/ip_gre.c 		|	 1 +
net/ipv4/ip_input.c 		| 	 6 ++++--
net/ipv4/route.c		| 	41 ++++++++++++++++++++++++++++-------------
10 files changed, 76 insertions(+), 29 deletions(-)

---------------------------------------------------

Assumptions made in this patch development:

1. Programmer who inserts rcu_lock/unlock around an in_dev_get or
   __in_dev_get expects the protection of deferred destruction.

2. The marking of an rcu read-side critical section done by
   the calling function has the vision of the extent of use of the
   protected dereference.

3. Pairings of in_dev_get/in_dev_put and __in_dev_get/__in_dev_put
   indicate the need to balance increment/decrement of refcnt, 
   so __in_dev_get which does not increment is likely paired in 
   error with __in_dev_put which decrements (unless in_dev_hold 
   or similar is in the path).  

4. If programmer chooses __in_dev_get rather than in_dev_get, 
   the refcnt is not desired.

5. If a function returns an rcu protected pointer, the rcu_read_lock
   is in place, so the rcu_read_unlock occurs in the caller.

Questions/Suggestions:

   A pairing of in_dev_get with in_dev_put may indicate the addition
   in the in_dev_put conditional of something like 
   call_rcu(&idev->rcu_head, in_dev->rcu_put)
   after in_dev_finish_destroy or replace the latter with a call like
   inetdev_destroy().

   Differences between inetdevice.h in kernel 2.5.60 and linux-2.6.13-rc6
   include the replacement in in_dev_get() of read_lock(&inetdev_lock)/unlock 
   with rcu_read_lock/unlock and the addition of the rcu_head to the 
   in_ifaddr struct.

   In net/ipv4/route.c, consider __mkroute_output and follow the
   three refcnt increments done to out_dev by dev_hold and in_dev_get, 
   then one decrement to in_dev.  Correct refcnt may also be an issue in
   xfrm4_policy.c to allow the atomic_dec_and_test in in_dev_put
   to appropriately recognize the condition to free the in_device.

   In net/ipv4/arp.c, arp_req_set() includes the following where,
   with possible update, might this be risky to test the deref and
   deref again: 
                if (__in_dev_get(dev)) {
                        __in_dev_get(dev)->cnf.proxy_arp = 1;
                        return 0;
                }
   and similarly in arp_req_delete?  While the vast majority of uses
   of __in_dev_get indicate rcu protection, the above may be the exception
   that breaks the rule.  It seems reasonable to have both in_dev_get
   and __in_dev_get use rcu_dereference and have the difference between
   them be the refcnt.  For now, I'll submit a patch addressing only
   in_dev_get and hope for feedback on patching __in_dev_get.  Because
   one way or another, there are __in_dev_get uses that probably need 
   to be addressed.

While this is a subjective attempt to understand programmer intent,
with your help and suggestions, the plan is to build an automated
checker.  Thank you.

------------------------------------------------------------------

diff -urpNa -X dontdiff /mnt/shared/linuxKernel2_6/linux-2.6.13-rc6/drivers/s390/net/lcs.c linux-2.6.13-rc6/drivers/s390/net/lcs.c
--- /mnt/shared/linuxKernel2_6/linux-2.6.13-rc6/drivers/s390/net/lcs.c	2005-08-07 11:18:56.000000000 -0700
+++ linux-2.6.13-rc6/drivers/s390/net/lcs.c	2005-09-07 21:37:41.000000000 -0700
@@ -1270,6 +1270,7 @@ lcs_register_mc_addresses(void *data)
 		return 0;
 	LCS_DBF_TEXT(4, trace, "regmulti");
 
+	rcu_read_lock();
 	in4_dev = in_dev_get(card->dev);
 	if (in4_dev == NULL)
 		goto out;
@@ -1278,6 +1279,7 @@ lcs_register_mc_addresses(void *data)
 	lcs_set_mc_addresses(card, in4_dev);
 	read_unlock(&in4_dev->mc_list_lock);
 	in_dev_put(in4_dev);
+	rcu_read_unlock();
 
 	lcs_fix_multicast_list(card);
 out:
diff -urpNa -X dontdiff /mnt/shared/linuxKernel2_6/linux-2.6.13-rc6/drivers/s390/net/qeth_main.c linux-2.6.13-rc6/drivers/s390/net/qeth_main.c
--- /mnt/shared/linuxKernel2_6/linux-2.6.13-rc6/drivers/s390/net/qeth_main.c	2005-08-07 11:18:56.000000000 -0700
+++ linux-2.6.13-rc6/drivers/s390/net/qeth_main.c	2005-09-07 22:22:10.000000000 -0700
@@ -5441,6 +5441,7 @@ qeth_add_vlan_mc(struct qeth_card *card)
 		if (vg->vlan_devices[i] == NULL ||
 		    !(vg->vlan_devices[i]->flags & IFF_UP))
 			continue;
+		rcu_read_lock();
 		in_dev = in_dev_get(vg->vlan_devices[i]);
 		if (!in_dev)
 			continue;
@@ -5448,6 +5449,7 @@ qeth_add_vlan_mc(struct qeth_card *card)
 		qeth_add_mc(card,in_dev);
 		read_unlock(&in_dev->mc_list_lock);
 		in_dev_put(in_dev);
+		rcu_read_unlock();
 	}
 #endif
 }
@@ -5458,6 +5460,7 @@ qeth_add_multicast_ipv4(struct qeth_card
 	struct in_device *in4_dev;
 
 	QETH_DBF_TEXT(trace,4,"chkmcv4");
+	rcu_read_lock();
 	in4_dev = in_dev_get(card->dev);
 	if (in4_dev == NULL)
 		return;
@@ -5466,6 +5469,7 @@ qeth_add_multicast_ipv4(struct qeth_card
 	qeth_add_vlan_mc(card);
 	read_unlock(&in4_dev->mc_list_lock);
 	in_dev_put(in4_dev);
+	rcu_read_unlock();
 }
 
 #ifdef CONFIG_QETH_IPV6
diff -urpNa -X dontdiff /mnt/shared/linuxKernel2_6/linux-2.6.13-rc6/include/linux/inetdevice.h linux-2.6.13-rc6/include/linux/inetdevice.h
--- /mnt/shared/linuxKernel2_6/linux-2.6.13-rc6/include/linux/inetdevice.h	2005-08-07 11:18:56.000000000 -0700
+++ linux-2.6.13-rc6/include/linux/inetdevice.h	2005-08-19 14:27:02.000000000 -0700
@@ -148,7 +148,7 @@ in_dev_get(const struct net_device *dev)
 	struct in_device *in_dev;
 
 	rcu_read_lock();
-	in_dev = dev->ip_ptr;
+	in_dev = rcu_dereference(dev->ip_ptr);
 	if (in_dev)
 		atomic_inc(&in_dev->refcnt);
 	rcu_read_unlock();
diff -urpNa -X dontdiff /mnt/shared/linuxKernel2_6/linux-2.6.13-rc6/net/ipv4/arp.c linux-2.6.13-rc6/net/ipv4/arp.c
--- /mnt/shared/linuxKernel2_6/linux-2.6.13-rc6/net/ipv4/arp.c	2005-08-07 11:18:56.000000000 -0700
+++ linux-2.6.13-rc6/net/ipv4/arp.c	2005-09-07 22:49:09.000000000 -0700
@@ -334,9 +334,10 @@ static void arp_solicit(struct neighbour
 	struct net_device *dev = neigh->dev;
 	u32 target = *(u32*)neigh->primary_key;
 	int probes = atomic_read(&neigh->probes);
-	struct in_device *in_dev = in_dev_get(dev);
+	struct in_device *in_dev;
 
-	if (!in_dev)
+	rcu_read_lock();
+	if ((in_dev = in_dev_get(dev)) == NULL)
 		return;
 
 	switch (IN_DEV_ARP_ANNOUNCE(in_dev)) {
@@ -362,6 +363,8 @@ static void arp_solicit(struct neighbour
 
 	if (in_dev)
 		in_dev_put(in_dev);
+	rcu_read_unlock();
+
 	if (!saddr)
 		saddr = inet_select_addr(dev, target, RT_SCOPE_LINK);
 
@@ -543,11 +546,12 @@ static inline int arp_fwd_proxy(struct i
 		return 0;
 
 	/* place to check for proxy_arp for routes */
-
+	rcu_read_lock();
 	if ((out_dev = in_dev_get(rt->u.dst.dev)) != NULL) {
 		omi = IN_DEV_MEDIUM_ID(out_dev);
 		in_dev_put(out_dev);
 	}
+	rcu_read_unlock();
 	return (omi != imi && omi != -1);
 }
 
@@ -710,7 +714,7 @@ static void parp_redo(struct sk_buff *sk
 static int arp_process(struct sk_buff *skb)
 {
 	struct net_device *dev = skb->dev;
-	struct in_device *in_dev = in_dev_get(dev);
+	struct in_device *in_dev;
 	struct arphdr *arp;
 	unsigned char *arp_ptr;
 	struct rtable *rt;
@@ -723,8 +727,8 @@ static int arp_process(struct sk_buff *s
 	/* arp_rcv below verifies the ARP header and verifies the device
 	 * is ARP'able.
 	 */
-
-	if (in_dev == NULL)
+	rcu_read_lock();
+	if ((in_dev = in_dev_get(dev)) == NULL)
 		goto out;
 
 	arp = skb->nh.arph;
@@ -918,6 +922,7 @@ static int arp_process(struct sk_buff *s
 out:
 	if (in_dev)
 		in_dev_put(in_dev);
+	rcu_read_unlock();
 	kfree_skb(skb);
 	return 0;
 }
diff -urpNa -X dontdiff /mnt/shared/linuxKernel2_6/linux-2.6.13-rc6/net/ipv4/devinet.c linux-2.6.13-rc6/net/ipv4/devinet.c
--- /mnt/shared/linuxKernel2_6/linux-2.6.13-rc6/net/ipv4/devinet.c	2005-08-07 11:18:56.000000000 -0700
+++ linux-2.6.13-rc6/net/ipv4/devinet.c	2005-09-08 00:38:01.000000000 -0700
@@ -372,12 +372,15 @@ static int inet_set_ifa(struct net_devic
 	return inet_insert_ifa(ifa);
 }
 
+/* returns with rcu read-critical section open, so rcu_read_unlock() in caller */
+
 struct in_device *inetdev_by_index(int ifindex)
 {
 	struct net_device *dev;
 	struct in_device *in_dev = NULL;
 	read_lock(&dev_base_lock);
 	dev = __dev_get_by_index(ifindex);
+	rcu_read_lock();
 	if (dev)
 		in_dev = in_dev_get(dev);
 	read_unlock(&dev_base_lock);
@@ -409,7 +412,8 @@ static int inet_rtm_deladdr(struct sk_bu
 
 	if ((in_dev = inetdev_by_index(ifm->ifa_index)) == NULL)
 		goto out;
-	__in_dev_put(in_dev);
+	in_dev_put(in_dev);
+	rcu_read_unlock();
 
 	for (ifap = &in_dev->ifa_list; (ifa = *ifap) != NULL;
 	     ifap = &ifa->ifa_next) {
diff -urpNa -X dontdiff /mnt/shared/linuxKernel2_6/linux-2.6.13-rc6/net/ipv4/icmp.c linux-2.6.13-rc6/net/ipv4/icmp.c
--- /mnt/shared/linuxKernel2_6/linux-2.6.13-rc6/net/ipv4/icmp.c	2005-08-07 11:18:56.000000000 -0700
+++ linux-2.6.13-rc6/net/ipv4/icmp.c	2005-09-07 23:37:08.000000000 -0700
@@ -890,10 +890,10 @@ static void icmp_address_reply(struct sk
 	if (skb->len < 4 || !(rt->rt_flags&RTCF_DIRECTSRC))
 		goto out;
 
+	rcu_read_lock();
 	in_dev = in_dev_get(dev);
 	if (!in_dev)
 		goto out;
-	rcu_read_lock();
 	if (in_dev->ifa_list &&
 	    IN_DEV_LOG_MARTIANS(in_dev) &&
 	    IN_DEV_FORWARD(in_dev)) {
@@ -913,8 +913,8 @@ static void icmp_address_reply(struct sk
 			       NIPQUAD(*mp), dev->name, NIPQUAD(rt->rt_src));
 		}
 	}
-	rcu_read_unlock();
 	in_dev_put(in_dev);
+	rcu_read_unlock();
 out:;
 }
 
diff -urpNa -X dontdiff /mnt/shared/linuxKernel2_6/linux-2.6.13-rc6/net/ipv4/igmp.c linux-2.6.13-rc6/net/ipv4/igmp.c
--- /mnt/shared/linuxKernel2_6/linux-2.6.13-rc6/net/ipv4/igmp.c	2005-08-07 11:18:56.000000000 -0700
+++ linux-2.6.13-rc6/net/ipv4/igmp.c	2005-09-08 00:35:52.000000000 -0700
@@ -864,10 +864,12 @@ int igmp_rcv(struct sk_buff *skb)
 {
 	/* This basically follows the spec line by line -- see RFC1112 */
 	struct igmphdr *ih;
-	struct in_device *in_dev = in_dev_get(skb->dev);
+	struct in_device *in_dev;
 	int len = skb->len;
 
-	if (in_dev==NULL) {
+	rcu_read_lock();
+	if ((in_dev = in_dev_get(skb->dev) == NULL) {
+		rcu_read_unlock();
 		kfree_skb(skb);
 		return 0;
 	}
@@ -875,6 +877,7 @@ int igmp_rcv(struct sk_buff *skb)
 	if (!pskb_may_pull(skb, sizeof(struct igmphdr)) || 
 	    (u16)csum_fold(skb_checksum(skb, 0, len, 0))) {
 		in_dev_put(in_dev);
+		rcu_read_unlock();
 		kfree_skb(skb);
 		return 0;
 	}
@@ -907,6 +910,7 @@ int igmp_rcv(struct sk_buff *skb)
 		NETDEBUG(printk(KERN_DEBUG "New IGMP type=%d, why we do not know about it?\n", ih->type));
 	}
 	in_dev_put(in_dev);
+	rcu_read_unlock();
 	kfree_skb(skb);
 	return 0;
 }
@@ -1307,8 +1311,8 @@ static struct in_device * ip_mc_find_dev
 	if (imr->imr_ifindex) {
 		idev = inetdev_by_index(imr->imr_ifindex);
 		if (idev)
-			__in_dev_put(idev);
-		return idev;
+			__in_dev_put(idev); /* decrement before return? */
+		return idev; /* caller should rcu_read_unlock */
 	}
 	if (imr->imr_address.s_addr) {
 		dev = ip_dev_find(imr->imr_address.s_addr);
@@ -2098,6 +2102,7 @@ void ip_mc_drop_socket(struct sock *sk)
 			(void) ip_mc_leave_src(sk, iml, in_dev);
 			ip_mc_dec_group(in_dev, iml->multi.imr_multiaddr.s_addr);
 			in_dev_put(in_dev);
+			rcu_read_unlock();
 		}
 		sock_kfree_s(sk, iml, sizeof(*iml));
 
@@ -2154,6 +2159,7 @@ static inline struct ip_mc_list *igmp_mc
 	     state->dev; 
 	     state->dev = state->dev->next) {
 		struct in_device *in_dev;
+		rcu_read_lock();
 		in_dev = in_dev_get(state->dev);
 		if (!in_dev)
 			continue;
@@ -2165,6 +2171,7 @@ static inline struct ip_mc_list *igmp_mc
 		}
 		read_unlock(&in_dev->mc_list_lock);
 		in_dev_put(in_dev);
+		rcu_read_unlock();
 	}
 	return im;
 }
@@ -2183,11 +2190,13 @@ static struct ip_mc_list *igmp_mc_get_ne
 			state->in_dev = NULL;
 			break;
 		}
+		rcu_read_lock();
 		state->in_dev = in_dev_get(state->dev);
 		if (!state->in_dev)
 			continue;
 		read_lock(&state->in_dev->mc_list_lock);
 		im = state->in_dev->mc_list;
+		rcu_read_unlock();
 	}
 	return im;
 }
@@ -2317,6 +2326,7 @@ static inline struct ip_sf_list *igmp_mc
 	     state->dev; 
 	     state->dev = state->dev->next) {
 		struct in_device *idev;
+		rcu_read_lock();
 		idev = in_dev_get(state->dev);
 		if (unlikely(idev == NULL))
 			continue;
@@ -2334,6 +2344,7 @@ static inline struct ip_sf_list *igmp_mc
 		}
 		read_unlock(&idev->mc_list_lock);
 		in_dev_put(idev);
+		rcu_read_unlock();
 	}
 	return psf;
 }
@@ -2356,11 +2367,14 @@ static struct ip_sf_list *igmp_mcf_get_n
 				state->idev = NULL;
 				goto out;
 			}
+			rcu_read_lock();
 			state->idev = in_dev_get(state->dev);
 			if (!state->idev)
+				rcu_read_unlock();
 				continue;
 			read_lock(&state->idev->mc_list_lock);
 			state->im = state->idev->mc_list;
+			rcu_read_unlock();
 		}
 		if (!state->im)
 			break;
diff -urpNa -X dontdiff /mnt/shared/linuxKernel2_6/linux-2.6.13-rc6/net/ipv4/ip_gre.c linux-2.6.13-rc6/net/ipv4/ip_gre.c
--- /mnt/shared/linuxKernel2_6/linux-2.6.13-rc6/net/ipv4/ip_gre.c	2005-08-07 11:18:56.000000000 -0700
+++ linux-2.6.13-rc6/net/ipv4/ip_gre.c	2005-09-08 00:42:38.000000000 -0700
@@ -1121,6 +1121,7 @@ static int ipgre_close(struct net_device
 			ip_mc_dec_group(in_dev, t->parms.iph.daddr);
 			in_dev_put(in_dev);
 		}
+		rcu_read_unlock();
 	}
 	return 0;
 }
diff -urpNa -X dontdiff /mnt/shared/linuxKernel2_6/linux-2.6.13-rc6/net/ipv4/ip_input.c linux-2.6.13-rc6/net/ipv4/ip_input.c
--- /mnt/shared/linuxKernel2_6/linux-2.6.13-rc6/net/ipv4/ip_input.c	2005-08-07 11:18:56.000000000 -0700
+++ linux-2.6.13-rc6/net/ipv4/ip_input.c	2005-09-08 00:45:42.000000000 -0700
@@ -330,8 +330,9 @@ static inline int ip_rcv_finish(struct s
 
 		opt = &(IPCB(skb)->opt);
 		if (opt->srr) {
-			struct in_device *in_dev = in_dev_get(dev);
-			if (in_dev) {
+			struct in_device *in_dev;
+			rcu_read_lock();
+			if ((in_dev = in_dev_get(dev)) != NULL) {
 				if (!IN_DEV_SOURCE_ROUTE(in_dev)) {
 					if (IN_DEV_LOG_MARTIANS(in_dev) && net_ratelimit())
 						printk(KERN_INFO "source route option %u.%u.%u.%u -> %u.%u.%u.%u\n",
@@ -341,6 +342,7 @@ static inline int ip_rcv_finish(struct s
 				}
 				in_dev_put(in_dev);
 			}
+			rcu_read_unlock();
 			if (ip_options_rcv_srr(skb))
 				goto drop;
 		}
diff -urpNa -X dontdiff /mnt/shared/linuxKernel2_6/linux-2.6.13-rc6/net/ipv4/route.c linux-2.6.13-rc6/net/ipv4/route.c
--- /mnt/shared/linuxKernel2_6/linux-2.6.13-rc6/net/ipv4/route.c	2005-08-07 11:18:56.000000000 -0700
+++ linux-2.6.13-rc6/net/ipv4/route.c	2005-09-08 08:39:01.000000000 -0700
@@ -1112,14 +1112,15 @@ void ip_rt_redirect(u32 old_gw, u32 dadd
 		    u32 saddr, u8 tos, struct net_device *dev)
 {
 	int i, k;
-	struct in_device *in_dev = in_dev_get(dev);
+	struct in_device *in_dev;
 	struct rtable *rth, **rthp;
 	u32  skeys[2] = { saddr, 0 };
 	int  ikeys[2] = { dev->ifindex, 0 };
 
 	tos &= IPTOS_RT_MASK;
 
-	if (!in_dev)
+	rcu_read_lock();
+	if ((in_dev = in_dev_get(dev)) == NULL)
 		return;
 
 	if (new_gw == old_gw || !IN_DEV_RX_REDIRECTS(in_dev)
@@ -1171,6 +1172,7 @@ void ip_rt_redirect(u32 old_gw, u32 dadd
 				if (rt == NULL) {
 					ip_rt_put(rth);
 					in_dev_put(in_dev);
+					rcu_read_unlock();
 					return;
 				}
 
@@ -1223,6 +1225,7 @@ void ip_rt_redirect(u32 old_gw, u32 dadd
 		}
 	}
 	in_dev_put(in_dev);
+	rcu_read_unlock();
 	return;
 
 reject_redirect:
@@ -1236,6 +1239,7 @@ reject_redirect:
 		       NIPQUAD(saddr), NIPQUAD(daddr), tos);
 #endif
 	in_dev_put(in_dev);
+	rcu_read_unlock();
 }
 
 static struct dst_entry *ipv4_negative_advice(struct dst_entry *dst)
@@ -1284,9 +1288,9 @@ static struct dst_entry *ipv4_negative_a
 void ip_rt_send_redirect(struct sk_buff *skb)
 {
 	struct rtable *rt = (struct rtable*)skb->dst;
-	struct in_device *in_dev = in_dev_get(rt->u.dst.dev);
-
-	if (!in_dev)
+	struct in_device *in_dev;
+	rcu_read_lock();
+	if ((in_dev = in_dev_get(rt->u.dst.dev)) == NULL)
 		return;
 
 	if (!IN_DEV_TX_REDIRECTS(in_dev))
@@ -1327,6 +1331,7 @@ void ip_rt_send_redirect(struct sk_buff 
 	}
 out:
         in_dev_put(in_dev);
+	rcu_read_unlock();
 }
 
 static int ip_error(struct sk_buff *skb)
@@ -1482,10 +1487,12 @@ static void ipv4_dst_ifdown(struct dst_e
 	struct rtable *rt = (struct rtable *) dst;
 	struct in_device *idev = rt->idev;
 	if (dev != &loopback_dev && idev && idev->dev == dev) {
-		struct in_device *loopback_idev = in_dev_get(&loopback_dev);
-		if (loopback_idev) {
+		struct in_device *loopback_idev;
+		rcu_read_lock();
+		if (loopback_idev = in_dev_get(&loopback_dev) != NULL) {
 			rt->idev = loopback_idev;
 			in_dev_put(idev);
+			rcu_read_unlock();
 		}
 	}
 }
@@ -1593,12 +1600,12 @@ static int ip_route_input_mc(struct sk_b
 	unsigned hash;
 	struct rtable *rth;
 	u32 spec_dst;
-	struct in_device *in_dev = in_dev_get(dev);
+	struct in_device *in_dev;
 	u32 itag = 0;
 
 	/* Primary sanity checks. */
-
-	if (in_dev == NULL)
+	rcu_read_lock();
+	if ((in_dev = in_dev_get(dev)) == NULL)
 		return -EINVAL;
 
 	if (MULTICAST(saddr) || BADCLASS(saddr) || LOOPBACK(saddr) ||
@@ -1656,15 +1663,18 @@ static int ip_route_input_mc(struct sk_b
 	RT_CACHE_STAT_INC(in_slow_mc);
 
 	in_dev_put(in_dev);
+	rcu_read_unlock();
 	hash = rt_hash_code(daddr, saddr ^ (dev->ifindex << 5), tos);
 	return rt_intern_hash(hash, rth, (struct rtable**) &skb->dst);
 
 e_nobufs:
 	in_dev_put(in_dev);
+	rcu_read_unlock();
 	return -ENOBUFS;
 
 e_inval:
 	in_dev_put(in_dev);
+	rcu_read_unlock();
 	return -EINVAL;
 }
 
@@ -1714,6 +1724,7 @@ static inline int __mkroute_input(struct
 	u32 spec_dst, itag;
 
 	/* get a working reference to the output device */
+	rcu_read_lock()
 	out_dev = in_dev_get(FIB_RES_DEV(*res));
 	if (out_dev == NULL) {
 		if (net_ratelimit())
@@ -1796,6 +1807,7 @@ static inline int __mkroute_input(struct
  cleanup:
 	/* release the working reference to the output device */
 	in_dev_put(out_dev);
+	rcu_read_unlock();
 	return err;
 }						
 
@@ -1899,7 +1911,7 @@ static int ip_route_input_slow(struct sk
 			       u8 tos, struct net_device *dev)
 {
 	struct fib_result res;
-	struct in_device *in_dev = in_dev_get(dev);
+	struct in_device *in_dev;
 	struct flowi fl = { .nl_u = { .ip4_u =
 				      { .daddr = daddr,
 					.saddr = saddr,
@@ -1919,8 +1931,8 @@ static int ip_route_input_slow(struct sk
 	int		free_res = 0;
 
 	/* IP on this device is disabled. */
-
-	if (!in_dev)
+	rcu_read_lock();
+	if ((in_dev = in_dev_get(dev)) == NULL)
 		goto out;
 
 	/* Check for the most weird martians, which can be not detected
@@ -1983,6 +1995,7 @@ static int ip_route_input_slow(struct sk
 	
 done:
 	in_dev_put(in_dev);
+	rcu_read_unlock();
 	if (free_res)
 		fib_res_put(&res);
 out:	return err;
@@ -2174,6 +2187,7 @@ static inline int __mkroute_output(struc
 		flags |= RTCF_LOCAL;
 
 	/* get work reference to inet device */
+	rcu_read_lock();
 	in_dev = in_dev_get(dev_out);
 	if (!in_dev)
 		return -EINVAL;
@@ -2270,6 +2284,7 @@ static inline int __mkroute_output(struc
 	*result = rth;
  cleanup:
 	/* release work reference to inet device */
+	rcu_read_unlock();
 	in_dev_put(in_dev);
 
 	return err;
