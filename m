Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbWFUTst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbWFUTst (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932721AbWFUTsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:48:45 -0400
Received: from rrcs-24-227-247-53.sw.biz.rr.com ([24.227.247.53]:1933 "EHLO
	linux.local") by vger.kernel.org with ESMTP id S932504AbWFUTsV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:48:21 -0400
From: Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH 2/2] Core network changes to support network event notification.
Date: Wed, 21 Jun 2006 14:48:21 -0500
To: swise@opengridcomputing.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Message-Id: <20060621194821.4507.70124.stgit@stevo-desktop>
In-Reply-To: <20060621194816.4507.4090.stgit@stevo-desktop>
References: <20060621194816.4507.4090.stgit@stevo-desktop>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds event calls for neighbour change, route update, and
routing redirect events.

TODO: PMTU change events.
---

 net/core/Makefile        |    2 +-
 net/core/neighbour.c     |    8 ++++++++
 net/ipv4/fib_semantics.c |    7 +++++++
 net/ipv4/route.c         |    6 ++++++
 4 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/net/core/Makefile b/net/core/Makefile
index e9bd246..2645ba4 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -7,7 +7,7 @@ obj-y := sock.o request_sock.o skbuff.o 
 
 obj-$(CONFIG_SYSCTL) += sysctl_net_core.o
 
-obj-y		     += dev.o ethtool.o dev_mcast.o dst.o \
+obj-y		     += dev.o ethtool.o dev_mcast.o dst.o netevent.o \
 			neighbour.o rtnetlink.o utils.o link_watch.o filter.o
 
 obj-$(CONFIG_XFRM) += flow.o
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 50a8c73..c637897 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -30,9 +30,11 @@ #include <linux/times.h>
 #include <net/neighbour.h>
 #include <net/dst.h>
 #include <net/sock.h>
+#include <net/netevent.h>
 #include <linux/rtnetlink.h>
 #include <linux/random.h>
 #include <linux/string.h>
+#include <linux/notifier.h>
 
 #define NEIGH_DEBUG 1
 
@@ -755,6 +757,7 @@ #endif
 			neigh->nud_state = NUD_STALE;
 			neigh->updated = jiffies;
 			neigh_suspect(neigh);
+			call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, neigh);
 		}
 	} else if (state & NUD_DELAY) {
 		if (time_before_eq(now, 
@@ -763,6 +766,7 @@ #endif
 			neigh->nud_state = NUD_REACHABLE;
 			neigh->updated = jiffies;
 			neigh_connect(neigh);
+			call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, neigh);
 			next = neigh->confirmed + neigh->parms->reachable_time;
 		} else {
 			NEIGH_PRINTK2("neigh %p is probed.\n", neigh);
@@ -783,6 +787,7 @@ #endif
 		neigh->nud_state = NUD_FAILED;
 		neigh->updated = jiffies;
 		notify = 1;
+		call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, neigh);
 		NEIGH_CACHE_STAT_INC(neigh->tbl, res_failed);
 		NEIGH_PRINTK2("neigh %p is failed.\n", neigh);
 
@@ -1056,6 +1061,9 @@ out:
 			(neigh->flags | NTF_ROUTER) :
 			(neigh->flags & ~NTF_ROUTER);
 	}
+
+	call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, neigh);
+
 	write_unlock_bh(&neigh->lock);
 #ifdef CONFIG_ARPD
 	if (notify && neigh->parms->app_probes)
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 0f4145b..67a30af 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -45,6 +45,7 @@ #include <net/tcp.h>
 #include <net/sock.h>
 #include <net/ip_fib.h>
 #include <net/ip_mp_alg.h>
+#include <net/netevent.h>
 
 #include "fib_lookup.h"
 
@@ -278,9 +279,15 @@ void rtmsg_fib(int event, u32 key, struc
 	       struct nlmsghdr *n, struct netlink_skb_parms *req)
 {
 	struct sk_buff *skb;
+	struct netevent_route_change rev;
+
 	u32 pid = req ? req->pid : n->nlmsg_pid;
 	int size = NLMSG_SPACE(sizeof(struct rtmsg)+256);
 
+	rev.event = event;
+	rev.fib_info = fa->fa_info;
+	call_netevent_notifiers(NETEVENT_ROUTE_UPDATE, &rev);
+
 	skb = alloc_skb(size, GFP_KERNEL);
 	if (!skb)
 		return;
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index cc9423d..e9ba831 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -105,6 +105,7 @@ #include <net/tcp.h>
 #include <net/icmp.h>
 #include <net/xfrm.h>
 #include <net/ip_mp_alg.h>
+#include <net/netevent.h>
 #ifdef CONFIG_SYSCTL
 #include <linux/sysctl.h>
 #endif
@@ -1120,6 +1121,7 @@ void ip_rt_redirect(u32 old_gw, u32 dadd
 	struct rtable *rth, **rthp;
 	u32  skeys[2] = { saddr, 0 };
 	int  ikeys[2] = { dev->ifindex, 0 };
+	struct netevent_redirect netevent;
 
 	if (!in_dev)
 		return;
@@ -1211,6 +1213,10 @@ void ip_rt_redirect(u32 old_gw, u32 dadd
 					rt_drop(rt);
 					goto do_next;
 				}
+				
+				netevent.old = &rth->u.dst;
+				netevent.new = &rt->u.dst;
+				call_netevent_notifiers(NETEVENT_REDIRECT, &netevent);
 
 				rt_del(hash, rth);
 				if (!rt_intern_hash(hash, rt, &rt))
