Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267287AbTAGDx5>; Mon, 6 Jan 2003 22:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267289AbTAGDx5>; Mon, 6 Jan 2003 22:53:57 -0500
Received: from zns001-0m9001.yokogawa.co.jp ([203.174.79.138]:31372 "EHLO
	zns001-0m9001.yokogawa.co.jp") by vger.kernel.org with ESMTP
	id <S267287AbTAGDxl>; Mon, 6 Jan 2003 22:53:41 -0500
Date: Tue, 7 Jan 2003 13:00:50 +0900
From: Kazunori Miyazawa <Kazunori.Miyazawa@jp.yokogawa.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Cc: usagi-core@linux-ipv6.org
Subject: [PATCH] IPsec Configuration Extension for IPv6
Message-Id: <20030107130050.0903bf59.Kazunori.Miyazawa@jp.yokogawa.com>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Jan 2003 04:02:03.0631 (UTC) FILETIME=[8967F7F0:01C2B601]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A happy new year!

This patch is simple extension of PF_KEY to support IPv6;
to accept IPv6 IPsec configurations.

{SAs, Policies} for both IPv4 and IPv6 are maintained in a
single {SA, Policy} database because of its simplicity.
At a performance view point, we would get enough performance
with separating caches.

However this patch does not contain any codes to process the packets 
in IPv6 stack because we wonder how we should implement it:

1. The building packet codes of datagram (ip_append_data()) is 
   very different from ip6_build_xmit(). And I guess you will
   change ip6_build_xmit() to ip6_append_data().

2. How should we implement to process destination option header 
   which is inside of AH and/or ESP?  There seems two options. 
   One is to process IPsec on parsing extension headers.
   The other is to process IPsec as upper layer protocol and 
   we always check the destination option header when we finish 
   to process AH or ESP.

We will be glad to hear your preferences, plans or a better way 
to implementation.

This patch is against 2.5.54.

Thanks in advance.

-------------------------------------------------------------------
Patch-Name: IPsec Configuration Extension for IPv6
Patch-Id: IPSEC_2_5_54_PFKEY_IPV6-20030107
Patch-Author: MIYAZAWA Kazunori / USAGI Project <miyazawa@linux-ipv6.org>
Credit: MIYAZAWA Kazunori / USAGI Project <miyazawa@linux-ipv6.org>
        YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
-------------------------------------------------------------------
Index: include/net/xfrm.h
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/include/net/xfrm.h,v
retrieving revision 1.1.1.4
retrieving revision 1.1.1.4.2.1
diff -u -r1.1.1.4 -r1.1.1.4.2.1
--- include/net/xfrm.h	23 Nov 2002 11:09:21 -0000	1.1.1.4
+++ include/net/xfrm.h	6 Jan 2003 15:40:10 -0000	1.1.1.4.2.1
@@ -4,9 +4,11 @@
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
 #include <linux/crypto.h>
+#include <linux/in6.h>
 
 #include <net/dst.h>
 #include <net/route.h>
+#include <net/ip6_fib.h>
 
 extern struct semaphore xfrm_cfg_sem;
 
@@ -259,6 +261,21 @@
 		!((fl->fl4_src^sel->saddr.xfrm4_addr)&sel->saddr.xfrm4_mask);
 }
 
+static inline int
+xfrm6_selector_match(struct xfrm_selector *sel, struct flowi *fl)
+{
+	return  memcmp(fl->fl6_dst,
+		 &sel->daddr,
+		 sizeof(struct in6_addr)) &&
+		memcmp(fl->fl6_src,
+		 &sel->saddr,
+		 sizeof(struct in6_addr)) &&
+		!((fl->uli_u.ports.dport^sel->dport)&sel->dport_mask) &&
+		!((fl->uli_u.ports.sport^sel->sport)&sel->sport_mask) &&
+		(fl->proto == sel->proto || !sel->proto) &&
+		(fl->oif == sel->ifindex || !sel->ifindex);
+}
+
 /* A struct encoding bundle of transformations to apply to some set of flow.
  *
  * dst->child points to the next element of bundle.
@@ -276,6 +293,7 @@
 		struct xfrm_dst		*next;
 		struct dst_entry	dst;
 		struct rtable		rt;
+		struct rt6_info		rt6;
 	} u;
 };
 
@@ -315,6 +333,18 @@
 		__xfrm_policy_check(sk, dir, skb);
 }
 
+extern int __xfrm6_policy_check(struct sock *, int dir, struct sk_buff *skb);
+
+static inline int xfrm6_policy_check(struct sock *sk, int dir, struct sk_buff *skb)
+{
+	if (sk && sk->policy[XFRM_POLICY_IN])
+		return __xfrm6_policy_check(sk, dir, skb);
+		
+	return	!xfrm_policy_list[dir] ||
+		(skb->dst->flags & DST_NOPOLICY) ||
+		__xfrm6_policy_check(sk, dir, skb);
+}
+
 extern int __xfrm_route_forward(struct sk_buff *skb);
 
 static inline int xfrm_route_forward(struct sk_buff *skb)
@@ -353,10 +383,14 @@
 extern struct xfrm_state *xfrm_state_alloc(void);
 extern struct xfrm_state *xfrm_state_find(u32 daddr, u32 saddr, struct flowi *fl, struct xfrm_tmpl *tmpl,
 					  struct xfrm_policy *pol, int *err);
+extern struct xfrm_state *xfrm6_state_find(struct in6_addr *daddr, struct in6_addr *saddr,
+					  struct flowi *fl, struct xfrm_tmpl *tmpl,
+					  struct xfrm_policy *pol, int *err);
 extern int xfrm_state_check_expire(struct xfrm_state *x);
 extern void xfrm_state_insert(struct xfrm_state *x);
 extern int xfrm_state_check_space(struct xfrm_state *x, struct sk_buff *skb);
 extern struct xfrm_state *xfrm_state_lookup(u32 daddr, u32 spi, u8 proto);
+extern struct xfrm_state *xfrm6_state_lookup(struct in6_addr *daddr, u32 spi, u8 proto);
 extern struct xfrm_state *xfrm_find_acq_byseq(u32 seq);
 extern void xfrm_state_delete(struct xfrm_state *x);
 extern void xfrm_state_flush(u8 proto);
@@ -374,7 +408,10 @@
 struct xfrm_policy *xfrm_policy_byid(int dir, u32 id, int delete);
 void xfrm_policy_flush(void);
 void xfrm_alloc_spi(struct xfrm_state *x, u32 minspi, u32 maxspi);
+void xfrm6_alloc_spi(struct xfrm_state *x, u32 minspi, u32 maxspi);
 struct xfrm_state * xfrm_find_acq(u8 mode, u16 reqid, u8 proto, u32 daddr, u32 saddr, int create);
+struct xfrm_state * xfrm6_find_acq(u8 mode, u16 reqid, u8 proto, struct in6_addr *daddr,
+				   struct in6_addr *saddr, int create);
 extern void xfrm_policy_flush(void);
 extern void xfrm_policy_kill(struct xfrm_policy *);
 extern int xfrm_sk_policy_insert(struct sock *sk, int dir, struct xfrm_policy *pol);
Index: net/netsyms.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/net/netsyms.c,v
retrieving revision 1.1.1.8
retrieving revision 1.1.1.8.2.2
diff -u -r1.1.1.8 -r1.1.1.8.2.2
--- net/netsyms.c	10 Dec 2002 07:09:33 -0000	1.1.1.8
+++ net/netsyms.c	7 Jan 2003 02:13:58 -0000	1.1.1.8.2.2
@@ -322,7 +322,10 @@
 EXPORT_SYMBOL(xfrm_policy_flush);
 EXPORT_SYMBOL(xfrm_policy_byid);
 EXPORT_SYMBOL(xfrm_policy_list);
-
+EXPORT_SYMBOL(xfrm6_state_find);
+EXPORT_SYMBOL(xfrm6_state_lookup);
+EXPORT_SYMBOL(xfrm6_find_acq);
+EXPORT_SYMBOL(xfrm6_alloc_spi);
 
 #if defined (CONFIG_IPV6_MODULE) || defined (CONFIG_IP_SCTP_MODULE)
 /* inet functions common to v4 and v6 */
Index: net/ipv4/xfrm_state.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/net/ipv4/xfrm_state.c,v
retrieving revision 1.1.1.4
retrieving revision 1.1.1.4.2.1
diff -u -r1.1.1.4 -r1.1.1.4.2.1
--- net/ipv4/xfrm_state.c	23 Nov 2002 11:09:42 -0000	1.1.1.4
+++ net/ipv4/xfrm_state.c	6 Jan 2003 15:40:11 -0000	1.1.1.4.2.1
@@ -1,6 +1,15 @@
+/*
+ *
+ * Changes:
+ *
+ *	MIYAZAWA Kazunori @USAGI	:	support IPv6 IPsec
+ *
+ */
+
 #include <net/xfrm.h>
 #include <linux/pfkeyv2.h>
 #include <linux/ipsec.h>
+#include <net/ipv6.h>
 
 /* Each xfrm_state may be linked to two tables:
 
@@ -219,7 +228,8 @@
 
 	spin_lock_bh(&xfrm_state_lock);
 	list_for_each_entry(x, xfrm_state_bydst+h, bydst) {
-		if (daddr == x->id.daddr.xfrm4_addr &&
+		if (x->props.family == AF_INET && 
+		    daddr == x->id.daddr.xfrm4_addr &&
 		    x->props.reqid == tmpl->reqid &&
 		    (saddr == x->props.saddr.xfrm4_addr || !saddr || !x->props.saddr.xfrm4_addr) &&
 		    tmpl->mode == x->props.mode &&
@@ -287,6 +297,7 @@
 			x->props.saddr.xfrm4_addr = saddr;
 		x->props.mode = tmpl->mode;
 		x->props.reqid = tmpl->reqid;
+		x->props.family = AF_INET;
 
 		if (km_query(x, tmpl, pol) == 0) {
 			x->km.state = XFRM_STATE_ACQ;
@@ -315,9 +326,130 @@
 	return x;
 }
 
+struct xfrm_state *
+xfrm6_state_find(struct in6_addr *daddr, struct in6_addr *saddr, struct flowi *fl, struct xfrm_tmpl *tmpl,
+		struct xfrm_policy *pol, int *err)
+{
+	unsigned h = ntohl(daddr->s6_addr32[3]);
+	struct xfrm_state *x = NULL;
+	int acquire_in_progress = 0;
+	int error = 0;
+	struct xfrm_state *best = NULL;
+
+	h = (h ^ (h>>16)) % XFRM_DST_HSIZE;
+
+	spin_lock_bh(&xfrm_state_lock);
+	list_for_each_entry(x, xfrm_state_bydst+h, bydst) {
+		if (x->props.family == AF_INET6&&
+		    !memcmp(daddr, &x->id.daddr, sizeof(*daddr)) &&
+		    x->props.reqid == tmpl->reqid &&
+		    (!memcmp(saddr, &x->props.saddr, sizeof(*saddr))|| ipv6_addr_any(saddr)) &&
+		    tmpl->mode == x->props.mode &&
+		    tmpl->id.proto == x->id.proto) {
+			/* Resolution logic:
+			   1. There is a valid state with matching selector.
+			      Done.
+			   2. Valid state with inappropriate selector. Skip.
+
+			   Entering area of "sysdeps".
+
+			   3. If state is not valid, selector is temporary,
+			      it selects only session which triggered
+			      previous resolution. Key manager will do
+			      something to install a state with proper
+			      selector.
+			 */
+			if (x->km.state == XFRM_STATE_VALID) {
+				if (!xfrm6_selector_match(&x->sel, fl))
+					continue;
+				if (!best ||
+				    best->km.dying > x->km.dying ||
+				    (best->km.dying == x->km.dying &&
+				     best->curlft.add_time < x->curlft.add_time))
+					best = x;
+			} else if (x->km.state == XFRM_STATE_ACQ) {
+				acquire_in_progress = 1;
+			} else if (x->km.state == XFRM_STATE_ERROR ||
+				   x->km.state == XFRM_STATE_EXPIRED) {
+				if (xfrm6_selector_match(&x->sel, fl))
+					error = 1;
+			}
+		}
+	}
+
+	if (best) {
+		atomic_inc(&best->refcnt);
+		spin_unlock_bh(&xfrm_state_lock);
+		return best;
+	}
+	x = NULL;
+	if (!error && !acquire_in_progress &&
+	    ((x = xfrm_state_alloc()) != NULL)) {
+		/* Initialize temporary selector matching only
+		 * to current session. */
+		memcpy(&x->sel.daddr, fl->fl6_dst, sizeof(struct in6_addr));
+		memcpy(&x->sel.saddr, fl->fl6_src, sizeof(struct in6_addr));
+		x->sel.dport = fl->uli_u.ports.dport;
+		x->sel.dport_mask = ~0;
+		x->sel.sport = fl->uli_u.ports.sport;
+		x->sel.sport_mask = ~0;
+		x->sel.prefixlen_d = 128;
+		x->sel.prefixlen_s = 128;
+		x->sel.proto = fl->proto;
+		x->sel.ifindex = fl->oif;
+		x->id = tmpl->id;
+		if (ipv6_addr_any((struct in6_addr*)&x->id.daddr))
+			memcpy(&x->id.daddr, daddr, sizeof(x->sel.daddr));
+		memcpy(&x->props.saddr, &tmpl->saddr, sizeof(x->props.saddr));
+		if (ipv6_addr_any((struct in6_addr*)&x->props.saddr))
+			memcpy(&x->props.saddr, &saddr, sizeof(x->sel.saddr));
+		x->props.mode = tmpl->mode;
+		x->props.reqid = tmpl->reqid;
+		x->props.family = AF_INET6;
+
+		if (km_query(x, tmpl, pol) == 0) {
+			x->km.state = XFRM_STATE_ACQ;
+			list_add_tail(&x->bydst, xfrm_state_bydst+h);
+			atomic_inc(&x->refcnt);
+			if (x->id.spi) {
+				struct in6_addr *addr = (struct in6_addr*)&x->id.daddr;
+				h = ntohl((addr->s6_addr32[3])^x->id.spi^x->id.proto);
+				h = (h ^ (h>>10) ^ (h>>20)) % XFRM_DST_HSIZE;
+				list_add(&x->byspi, xfrm_state_byspi+h);
+				atomic_inc(&x->refcnt);
+			}
+			x->lft.hard_add_expires_seconds = ACQ_EXPIRES;
+			atomic_inc(&x->refcnt);
+			mod_timer(&x->timer, ACQ_EXPIRES*HZ);
+		} else {
+			x->km.state = XFRM_STATE_DEAD;
+			xfrm_state_put(x);
+			x = NULL;
+			error = 1;
+		}
+	}
+	spin_unlock_bh(&xfrm_state_lock);
+	if (!x)
+		*err = acquire_in_progress ? -EAGAIN :
+			(error ? -ESRCH : -ENOMEM);
+	return x;
+}
+
 void xfrm_state_insert(struct xfrm_state *x)
 {
-	unsigned h = ntohl(x->id.daddr.xfrm4_addr);
+	unsigned h = 0;
+	switch(x->props.family) {
+	case AF_INET:
+		h = ntohl(x->id.daddr.xfrm4_addr);
+		break;
+	case AF_INET6:
+	{
+		struct in6_addr *addr = (struct in6_addr*)&x->id.daddr;
+		h = ntohl(addr->s6_addr32[3]);
+		break;
+	}
+	default:
+	}
 
 	h = (h ^ (h>>16)) % XFRM_DST_HSIZE;
 
@@ -325,7 +457,18 @@
 	list_add(&x->bydst, xfrm_state_bydst+h);
 	atomic_inc(&x->refcnt);
 
-	h = ntohl(x->id.daddr.xfrm4_addr^x->id.spi^x->id.proto);
+	switch(x->props.family) {
+	case AF_INET:
+		h = ntohl(x->id.daddr.xfrm4_addr^x->id.spi^x->id.proto);
+		break;
+	case AF_INET6:
+	{
+		struct in6_addr *addr = (struct in6_addr*)&x->id.daddr;
+		h = ntohl((addr->s6_addr32[3])^x->id.spi^x->id.proto);
+		break;
+	}
+	default:
+	}
 	h = (h ^ (h>>10) ^ (h>>20)) % XFRM_DST_HSIZE;
 	list_add(&x->byspi, xfrm_state_byspi+h);
 	atomic_inc(&x->refcnt);
@@ -382,7 +525,8 @@
 
 	spin_lock_bh(&xfrm_state_lock);
 	list_for_each_entry(x, xfrm_state_byspi+h, byspi) {
-		if (spi == x->id.spi &&
+		if (x->props.family == AF_INET &&
+		    spi == x->id.spi &&
 		    daddr == x->id.daddr.xfrm4_addr &&
 		    proto == x->id.proto) {
 			atomic_inc(&x->refcnt);
@@ -395,6 +539,29 @@
 }
 
 struct xfrm_state *
+xfrm6_state_lookup(struct in6_addr *daddr, u32 spi, u8 proto)
+{
+	unsigned h = ntohl(daddr->s6_addr32[3]^spi^proto);
+	struct xfrm_state *x;
+
+	h = (h ^ (h>>10) ^ (h>>20)) % XFRM_DST_HSIZE;
+
+	spin_lock_bh(&xfrm_state_lock);
+	list_for_each_entry(x, xfrm_state_byspi+h, byspi) {
+		if (x->props.family == AF_INET6 &&
+		    spi == x->id.spi &&
+		    proto == x->id.proto &&
+		    !memcmp(daddr, &x->id.daddr, sizeof(*daddr))) {
+			atomic_inc(&x->refcnt);
+			spin_unlock_bh(&xfrm_state_lock);
+			return x;
+		}
+	}
+	spin_unlock_bh(&xfrm_state_lock);
+	return NULL;
+}
+
+struct xfrm_state *
 xfrm_find_acq(u8 mode, u16 reqid, u8 proto, u32 daddr, u32 saddr, int create)
 {
 	struct xfrm_state *x, *x0;
@@ -405,7 +572,8 @@
 
 	spin_lock_bh(&xfrm_state_lock);
 	list_for_each_entry(x, xfrm_state_bydst+h, bydst) {
-		if (daddr == x->id.daddr.xfrm4_addr &&
+		if (x->props.family == AF_INET &&
+		    daddr == x->id.daddr.xfrm4_addr &&
 		    mode == x->props.mode &&
 		    proto == x->id.proto &&
 		    saddr == x->props.saddr.xfrm4_addr &&
@@ -434,6 +602,58 @@
 		x0->id.proto = proto;
 		x0->props.mode = mode;
 		x0->props.reqid = reqid;
+		x0->props.family = AF_INET;
+		x0->lft.hard_add_expires_seconds = ACQ_EXPIRES;
+		atomic_inc(&x0->refcnt);
+		mod_timer(&x0->timer, jiffies + ACQ_EXPIRES*HZ);
+		atomic_inc(&x0->refcnt);
+		list_add_tail(&x0->bydst, xfrm_state_bydst+h);
+		wake_up(&km_waitq);
+	}
+	spin_unlock_bh(&xfrm_state_lock);
+	return x0;
+}
+
+struct xfrm_state *
+xfrm6_find_acq(u8 mode, u16 reqid, u8 proto, struct in6_addr *daddr, struct in6_addr *saddr, int create)
+{
+	struct xfrm_state *x, *x0;
+	unsigned h = ntohl(daddr->s6_addr32[3]);
+
+	h = (h ^ (h>>16)) % XFRM_DST_HSIZE;
+	x0 = NULL;
+
+	spin_lock_bh(&xfrm_state_lock);
+	list_for_each_entry(x, xfrm_state_bydst+h, bydst) {
+		if (x->props.family == AF_INET6 &&
+		    !memcmp(daddr, &x->id.daddr, sizeof(*daddr)) &&
+		    mode == x->props.mode &&
+		    proto == x->id.proto &&
+		    !memcmp(saddr, &x->props.saddr, sizeof(*saddr)) &&
+		    reqid == x->props.reqid &&
+		    x->km.state == XFRM_STATE_ACQ) {
+			    if (!x0)
+				    x0 = x;
+			    if (x->id.spi)
+				    continue;
+			    x0 = x;
+			    break;
+		    }
+	}
+	if (x0) {
+		atomic_inc(&x0->refcnt);
+	} else if (create && (x0 = xfrm_state_alloc()) != NULL) {
+		memcpy(&x0->sel.daddr, daddr, sizeof(x0->sel.daddr));
+		memcpy(&x0->sel.saddr, saddr, sizeof(x0->sel.saddr));
+		x0->sel.prefixlen_d = 128;
+		x0->sel.prefixlen_s = 128;
+		memcpy(&x0->props.saddr, saddr, sizeof(x0->props.saddr));
+		x0->km.state = XFRM_STATE_ACQ;
+		memcpy(&x0->id.daddr, daddr, sizeof(x0->id.daddr));
+		x0->id.proto = proto;
+		x0->props.mode = mode;
+		x0->props.reqid = reqid;
+		x0->props.family = AF_INET6;
 		x0->lft.hard_add_expires_seconds = ACQ_EXPIRES;
 		atomic_inc(&x0->refcnt);
 		mod_timer(&x0->timer, jiffies + ACQ_EXPIRES*HZ);
@@ -507,6 +727,47 @@
 	}
 }
 
+void
+xfrm6_alloc_spi(struct xfrm_state *x, u32 minspi, u32 maxspi)
+{
+	u32 h;
+	struct xfrm_state *x0;
+
+	if (x->id.spi)
+		return;
+
+	if (minspi == maxspi) {
+		x0 = xfrm6_state_lookup((struct in6_addr*)&x->id.daddr, minspi, x->id.proto);
+		if (x0) {
+			xfrm_state_put(x0);
+			return;
+		}
+		x->id.spi = minspi;
+	} else {
+		u32 spi = 0;
+		minspi = ntohl(minspi);
+		maxspi = ntohl(maxspi);
+		for (h=0; h<maxspi-minspi+1; h++) {
+			spi = minspi + net_random()%(maxspi-minspi+1);
+			x0 = xfrm6_state_lookup((struct in6_addr*)&x->id.daddr, htonl(spi), x->id.proto);
+			if (x0 == NULL)
+				break;
+			xfrm_state_put(x0);
+		}
+		x->id.spi = htonl(spi);
+	}
+	if (x->id.spi) {
+		struct in6_addr *addr = (struct in6_addr*)&x->id.daddr;
+		spin_lock_bh(&xfrm_state_lock);
+		h = ntohl((addr->s6_addr32[3])^x->id.spi^x->id.proto);
+		h = (h ^ (h>>10) ^ (h>>20)) % XFRM_DST_HSIZE;
+		list_add(&x->byspi, xfrm_state_byspi+h);
+		atomic_inc(&x->refcnt);
+		spin_unlock_bh(&xfrm_state_lock);
+		wake_up(&km_waitq);
+	}
+}
+
 int xfrm_state_walk(u8 proto, int (*func)(struct xfrm_state *, int, void*),
 		    void *data)
 {
@@ -591,7 +852,9 @@
 	int i;
 
 	for (i=0; i<n; i++) {
-		if (!xfrm4_selector_match(&x[i]->sel, fl))
+		if (x[i]->props.family == AF_INET && !xfrm4_selector_match(&x[i]->sel, fl))
+			return -EINVAL;
+		if (x[i]->props.family == AF_INET6 && !xfrm6_selector_match(&x[i]->sel, fl))
 			return -EINVAL;
 	}
 	return 0;
Index: net/key/af_key.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/net/key/Attic/af_key.c,v
retrieving revision 1.1.1.4
retrieving revision 1.1.1.4.2.5
diff -u -r1.1.1.4 -r1.1.1.4.2.5
--- net/key/af_key.c	24 Dec 2002 05:57:49 -0000	1.1.1.4
+++ net/key/af_key.c	6 Jan 2003 16:32:18 -0000	1.1.1.4.2.5
@@ -9,6 +9,11 @@
  * Authors:	Maxim Giryaev	<gem@asplinux.ru>
  *		David S. Miller	<davem@redhat.com>
  *		Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
+ *
+ * Changes:
+ *		MIYAZAWA Kazunori <miyazawa@linux-ipv6.org> @USAGI,
+ *		YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org> @USAGI:
+ *			IPv6 Support
  */
 
 #include <linux/config.h>
@@ -400,7 +405,7 @@
 	d_addr = (struct sockaddr *)(dst + 1);
 	if (s_addr->sa_family != d_addr->sa_family)
 		return 0;
-	if (s_addr->sa_family != AF_INET)
+	if (s_addr->sa_family != AF_INET && s_addr->sa_family != AF_INET6)
 		return 0;
 
 	return 1;
@@ -497,8 +502,8 @@
 	return (proto ? proto : IPSEC_PROTO_ANY);
 }
 
-static xfrm_address_t *pfkey_sadb_addr2xfrm_addr(struct sadb_address *addr,
-						 xfrm_address_t *xaddr)
+static int pfkey_sadb_addr2xfrm_addr(struct sadb_address *addr,
+				     xfrm_address_t *xaddr)
 {
 	switch (((struct sockaddr*)(addr + 1))->sa_family) {
 	case AF_INET:
@@ -506,16 +511,18 @@
 			((struct sockaddr_in*)(addr + 1))->sin_addr.s_addr;
 		if (addr->sadb_address_prefixlen)
 			xaddr->xfrm4_mask = htonl(~0 << (32 - addr->sadb_address_prefixlen));
+		return AF_INET;
 		break;
 	case AF_INET6:
 		memcpy(xaddr->a6, 
 		       &((struct sockaddr_in6*)(addr + 1))->sin6_addr,
 		       sizeof(xaddr->a6));
+		return AF_INET6;
+		break;
 	default:
-		return NULL;
 	}
 
-	return xaddr;
+	return 0;
 }
 
 static struct  xfrm_state *pfkey_xfrm_state_lookup(struct sadb_msg *hdr, void **ext_hdrs)
@@ -544,7 +551,9 @@
 				      sa->sadb_sa_spi, proto);
 		break;
 	case AF_INET6:
-		/* XXX handle IPv6 */
+		x = xfrm6_state_lookup(&((struct sockaddr_in6*)(addr + 1))->sin6_addr,
+				       sa->sadb_sa_spi, proto);
+		break;
 	default:
 		x = NULL;
 		break;
@@ -672,7 +681,7 @@
 	struct sadb_msg *hdr;
 	struct sadb_sa *sa;
 	struct sadb_lifetime *lifetime;
-	struct sadb_address *addr;
+	struct sadb_address *addr = NULL;
 	struct sadb_key *key;
 	struct sadb_x_sa2 *sa2;
 	int size;
@@ -685,14 +694,20 @@
 		sizeof(struct sadb_lifetime) +
 		((hsc & 1) ? sizeof(struct sadb_lifetime) : 0) +
 		((hsc & 2) ? sizeof(struct sadb_lifetime) : 0) +
-			sizeof(struct sadb_address)*2 + 
-				sizeof(struct sockaddr_in)*2 + /* XXX */
 					sizeof(struct sadb_x_sa2);
-	/* XXX identity & sensitivity */
 
-	if (x->sel.saddr.xfrm4_addr != x->props.saddr.xfrm4_addr)
-		size += sizeof(struct sadb_address) + 
-			sizeof(struct sockaddr_in); /* XXX */
+	/* XXX identity & sensitivity */
+	if (x->props.family == AF_INET) {
+		size += (sizeof(struct sadb_address) + sizeof(struct sockaddr_in)) *2;
+		if (x->sel.saddr.xfrm4_addr != x->props.saddr.xfrm4_addr)
+			size += sizeof(struct sadb_address) + 
+				sizeof(struct sockaddr_in);
+	} else if (x->props.family == AF_INET6) {
+		size += (sizeof(struct sadb_address) + ((sizeof(struct sockaddr_in6) + 7) & ~7)) *2;
+		if (memcmp(&x->sel.saddr, &x->props.saddr, sizeof(x->sel.saddr)))
+			size += sizeof(struct sadb_address) +
+				((sizeof(struct sockaddr_in6) + 7) & ~7);
+	}
 
 	if (add_keys) {
 		if (x->aalg && x->aalg->alg_key_len) {
@@ -774,51 +789,98 @@
 	lifetime->sadb_lifetime_bytes = x->curlft.bytes;
 	lifetime->sadb_lifetime_addtime = x->curlft.add_time;
 	lifetime->sadb_lifetime_usetime = x->curlft.use_time;
-	/* src address */
-	addr = (struct sadb_address*) skb_put(skb, 
-					      sizeof(struct sadb_address)+sizeof(struct sockaddr_in));
-	addr->sadb_address_len = 
-		(sizeof(struct sadb_address)+sizeof(struct sockaddr_in))/
-			sizeof(uint64_t);
-	addr->sadb_address_exttype = SADB_EXT_ADDRESS_SRC;
-	/* "if the ports are non-zero, then the sadb_address_proto field, 
-	   normally zero, MUST be filled in with the transport 
-	   protocol's number." - RFC2367 */
-	addr->sadb_address_proto = 0; 
-	addr->sadb_address_prefixlen = 32; /* XXX */ 
-	addr->sadb_address_reserved = 0;
-	((struct sockaddr_in*)(addr + 1))->sin_family = AF_INET;
-	((struct sockaddr_in*)(addr + 1))->sin_addr.s_addr = 
-		x->props.saddr.xfrm4_addr;
-	/* dst address */
-	addr = (struct sadb_address*) skb_put(skb, 
-					      sizeof(struct sadb_address)+sizeof(struct sockaddr_in));
-	addr->sadb_address_len = 
-		(sizeof(struct sadb_address)+sizeof(struct sockaddr_in))/
-			sizeof(uint64_t);
-	addr->sadb_address_exttype = SADB_EXT_ADDRESS_DST;
-	addr->sadb_address_proto = 0; 
-	addr->sadb_address_prefixlen = 32; /* XXX */ 
-	addr->sadb_address_reserved = 0;
-	((struct sockaddr_in*)(addr + 1))->sin_family = AF_INET;
-	((struct sockaddr_in*)(addr + 1))->sin_addr.s_addr = 
-		x->id.daddr.xfrm4_addr;
 
-	if (x->sel.saddr.xfrm4_addr != x->props.saddr.xfrm4_addr) {
+	if (x->props.family == AF_INET) {
+		/* src address */
 		addr = (struct sadb_address*) skb_put(skb, 
 						      sizeof(struct sadb_address)+sizeof(struct sockaddr_in));
 		addr->sadb_address_len = 
 			(sizeof(struct sadb_address)+sizeof(struct sockaddr_in))/
 				sizeof(uint64_t);
-		addr->sadb_address_exttype = SADB_EXT_ADDRESS_PROXY;
-		addr->sadb_address_proto = pfkey_proto_from_xfrm(x->sel.proto);
-		addr->sadb_address_prefixlen = x->sel.prefixlen_s;
+		addr->sadb_address_exttype = SADB_EXT_ADDRESS_SRC;
+		/* "if the ports are non-zero, then the sadb_address_proto field, 
+		   normally zero, MUST be filled in with the transport 
+		   protocol's number." - RFC2367 */
+		addr->sadb_address_proto = 0; 
+		addr->sadb_address_prefixlen = 32; /* XXX */ 
 		addr->sadb_address_reserved = 0;
 		((struct sockaddr_in*)(addr + 1))->sin_family = AF_INET;
 		((struct sockaddr_in*)(addr + 1))->sin_addr.s_addr = 
-			x->sel.saddr.xfrm4_addr;
-		((struct sockaddr_in*)(addr + 1))->sin_port = 
-			x->sel.sport;
+			x->props.saddr.xfrm4_addr;
+		/* dst address */
+		addr = (struct sadb_address*) skb_put(skb, 
+						      sizeof(struct sadb_address)+sizeof(struct sockaddr_in));
+		addr->sadb_address_len = 
+			(sizeof(struct sadb_address)+sizeof(struct sockaddr_in))/
+				sizeof(uint64_t);
+		addr->sadb_address_exttype = SADB_EXT_ADDRESS_DST;
+		addr->sadb_address_proto = 0; 
+		addr->sadb_address_prefixlen = 32; /* XXX */ 
+		addr->sadb_address_reserved = 0;
+		((struct sockaddr_in*)(addr + 1))->sin_family = AF_INET;
+		((struct sockaddr_in*)(addr + 1))->sin_addr.s_addr = 
+			x->id.daddr.xfrm4_addr;
+
+		if (x->sel.saddr.xfrm4_addr != x->props.saddr.xfrm4_addr) {
+			addr = (struct sadb_address*) skb_put(skb, 
+							      sizeof(struct sadb_address)+sizeof(struct sockaddr_in));
+			addr->sadb_address_len = 
+				(sizeof(struct sadb_address)+sizeof(struct sockaddr_in))/
+					sizeof(uint64_t);
+			addr->sadb_address_exttype = SADB_EXT_ADDRESS_PROXY;
+			addr->sadb_address_proto = pfkey_proto_from_xfrm(x->sel.proto);
+			addr->sadb_address_prefixlen = x->sel.prefixlen_s;
+			addr->sadb_address_reserved = 0;
+			((struct sockaddr_in*)(addr + 1))->sin_family = AF_INET;
+			((struct sockaddr_in*)(addr + 1))->sin_addr.s_addr = 
+				x->sel.saddr.xfrm4_addr;
+			((struct sockaddr_in*)(addr + 1))->sin_port = 
+				x->sel.sport;
+		}
+	} else if (x->props.family == AF_INET6) {
+		/* src address */
+		addr = (struct sadb_address*) skb_put(skb, 
+						      sizeof(struct sadb_address)+
+						      ((sizeof(struct sockaddr_in6) + 7) & ~7));
+		addr->sadb_address_len = 
+			(sizeof(struct sadb_address)+((sizeof(struct sockaddr_in6) + 7) & ~7))/
+				sizeof(uint64_t);
+		addr->sadb_address_exttype = SADB_EXT_ADDRESS_SRC;
+		addr->sadb_address_proto = 0; 
+		addr->sadb_address_prefixlen = 128; /* XXX */ 
+		addr->sadb_address_reserved = 0;
+		((struct sockaddr_in6*)(addr + 1))->sin6_family = AF_INET6;
+		memcpy(&((struct sockaddr_in6*)(addr + 1))->sin6_addr, &x->props.saddr, sizeof(struct in6_addr));
+		/* dst address */
+		addr = (struct sadb_address*) skb_put(skb, 
+						      sizeof(struct sadb_address)+
+						      ((sizeof(struct sockaddr_in6) + 7) & ~7));
+		addr->sadb_address_len = 
+			(sizeof(struct sadb_address)+((sizeof(struct sockaddr_in6) + 7) & ~7))/
+				sizeof(uint64_t);
+		addr->sadb_address_exttype = SADB_EXT_ADDRESS_DST;
+		addr->sadb_address_proto = 0; 
+		addr->sadb_address_prefixlen = 128; /* XXX */ 
+		addr->sadb_address_reserved = 0;
+		((struct sockaddr_in6*)(addr + 1))->sin6_family = AF_INET6;
+		memcpy(&((struct sockaddr_in6*)(addr + 1))->sin6_addr, &x->id.daddr, sizeof(struct in6_addr));
+
+		if (memcmp(&x->sel.saddr, &x->props.saddr, sizeof(x->sel.saddr))) {
+			addr = (struct sadb_address*) skb_put(skb, 
+						      sizeof(struct sadb_address)+
+						      ((sizeof(struct sockaddr_in6) + 7) & ~7));
+			addr->sadb_address_len = 
+				(sizeof(struct sadb_address)+((sizeof(struct sockaddr_in6) + 7) & ~7))/
+					sizeof(uint64_t);
+			addr->sadb_address_exttype = SADB_EXT_ADDRESS_PROXY;
+			addr->sadb_address_proto = pfkey_proto_from_xfrm(x->sel.proto);
+			addr->sadb_address_prefixlen = x->sel.prefixlen_s;
+			addr->sadb_address_reserved = 0;
+			((struct sockaddr_in6*)(addr + 1))->sin6_family = AF_INET6;
+			((struct sockaddr_in6*)(addr + 1))->sin6_port = 
+				x->sel.sport;
+			memcpy(&((struct sockaddr_in6*)(addr + 1))->sin6_addr, &x->sel.saddr, sizeof(struct in6_addr));
+		}
 	}
 
 	/* auth key */
@@ -976,7 +1038,7 @@
 	}
 	/* x->algo.flags = sa->sadb_sa_flags; */
 
-	pfkey_sadb_addr2xfrm_addr((struct sadb_address *) ext_hdrs[SADB_EXT_ADDRESS_SRC-1], 
+	x->props.family = pfkey_sadb_addr2xfrm_addr((struct sadb_address *) ext_hdrs[SADB_EXT_ADDRESS_SRC-1], 
 				  &x->props.saddr);
 	pfkey_sadb_addr2xfrm_addr((struct sadb_address *) ext_hdrs[SADB_EXT_ADDRESS_DST-1], 
 				  &x->id.daddr);
@@ -1138,12 +1200,24 @@
 	/* XXX there is race condition */
 	x1 = pfkey_xfrm_state_lookup(hdr, ext_hdrs);
 	if (!x1) {
-		x1 = xfrm_find_acq(x->props.mode, x->props.reqid, x->id.proto,
-				   x->id.daddr.xfrm4_addr,
-				   x->props.saddr.xfrm4_addr, 0);
-		if (x1 && x1->id.spi != x->id.spi && x1->id.spi) {
-			xfrm_state_put(x1);
-			x1 = NULL;
+		struct sadb_address *addr
+			 = (struct sadb_address *) ext_hdrs[SADB_EXT_ADDRESS_DST-1];
+		switch (((struct sockaddr*)(addr + 1))->sa_family) {
+		case AF_INET:
+			x1 = xfrm_find_acq(x->props.mode, x->props.reqid, x->id.proto,
+					   x->id.daddr.xfrm4_addr,
+					   x->props.saddr.xfrm4_addr, 0);
+			if (x1 && x1->id.spi != x->id.spi && x1->id.spi) {
+				xfrm_state_put(x1);
+				x1 = NULL;
+			}
+			break;
+		case AF_INET6:
+			x1 = xfrm6_find_acq(x->props.mode, x->props.reqid, x->id.proto,
+					    (struct in6_addr*)&x->id.daddr,
+					    (struct in6_addr*)&x->props.saddr, 0);
+			break;
+		default:
 		}
 	}
 
@@ -1490,16 +1564,23 @@
 	struct sadb_lifetime *lifetime;
 	struct sadb_x_policy *pol;
 	struct sockaddr_in   *sin;
+	struct sockaddr_in6  *sin6;
 	int i;
 	int size;
 
-	size = sizeof(struct sadb_msg) +
-		sizeof(struct sadb_lifetime) * 3 +
-			sizeof(struct sadb_address)*2 + 
-				sizeof(struct sockaddr_in)*2 + /* XXX */
-					sizeof(struct sadb_x_policy) +
-						xp->xfrm_nr*(sizeof(struct sadb_x_ipsecrequest) +
-							     sizeof(struct sockaddr_in)*2);
+	size = sizeof(struct sadb_msg) + sizeof(struct sadb_lifetime) * 3;
+
+	if (xp->family == AF_INET) {
+		size += (sizeof(struct sadb_address) + sizeof(struct sockaddr_in))*2+
+				sizeof(struct sadb_x_policy) +
+					xp->xfrm_nr*(sizeof(struct sadb_x_ipsecrequest) +
+						     sizeof(struct sockaddr_in)*2);
+	} else if (xp->family == AF_INET6) {
+		size += (sizeof(struct sadb_address) + ((sizeof(struct sockaddr_in6)+7)&~7))*2+
+				sizeof(struct sadb_x_policy) +
+					xp->xfrm_nr*(sizeof(struct sadb_x_ipsecrequest) +
+						((sizeof(struct sockaddr_in6)+7)&~7)*2);
+	}
 
 	skb =  alloc_skb(size + 16, GFP_ATOMIC);
 	if (skb == NULL)
@@ -1509,37 +1590,70 @@
 	hdr = (struct sadb_msg *) skb_put(skb, sizeof(struct sadb_msg));
 	memset(hdr, 0, size);	/* XXX do we need this ? */
 
-	/* src address */
-	addr = (struct sadb_address*) skb_put(skb, 
-					      sizeof(struct sadb_address)+sizeof(struct sockaddr_in));
-	addr->sadb_address_len = 
-		(sizeof(struct sadb_address)+sizeof(struct sockaddr_in))/
-			sizeof(uint64_t);
-	addr->sadb_address_exttype = SADB_EXT_ADDRESS_SRC;
-	addr->sadb_address_proto = pfkey_proto_from_xfrm(xp->selector.proto);
-	addr->sadb_address_prefixlen = xp->selector.prefixlen_s;
-	addr->sadb_address_reserved = 0;
-	/* src address */
-	sin = (struct sockaddr_in*)(addr + 1);
-	sin->sin_family = AF_INET;
-	sin->sin_addr.s_addr = xp->selector.saddr.xfrm4_addr;
-	sin->sin_port = xp->selector.sport;
-	memset(sin->sin_zero, 0, sizeof(sin->sin_zero));
-	/* dst address */
-	addr = (struct sadb_address*) skb_put(skb, 
-					      sizeof(struct sadb_address)+sizeof(struct sockaddr_in));
-	addr->sadb_address_len =
-		(sizeof(struct sadb_address)+sizeof(struct sockaddr_in))/
-			sizeof(uint64_t);
-	addr->sadb_address_exttype = SADB_EXT_ADDRESS_DST;
-	addr->sadb_address_proto = pfkey_proto_from_xfrm(xp->selector.proto);
-	addr->sadb_address_prefixlen = xp->selector.prefixlen_d; 
-	addr->sadb_address_reserved = 0;
-	sin = (struct sockaddr_in*)(addr + 1);
-	sin->sin_family = AF_INET;
-	sin->sin_addr.s_addr = xp->selector.daddr.xfrm4_addr;
-	sin->sin_port = xp->selector.dport;
-	memset(sin->sin_zero, 0, sizeof(sin->sin_zero));
+	if (xp->family == AF_INET) {
+		/* src address */
+		addr = (struct sadb_address*) skb_put(skb, 
+						      sizeof(struct sadb_address)+sizeof(struct sockaddr_in));
+		addr->sadb_address_len = 
+			(sizeof(struct sadb_address)+sizeof(struct sockaddr_in))/
+				sizeof(uint64_t);
+		/* src address */
+		sin = (struct sockaddr_in*)(addr + 1);
+		sin->sin_family = AF_INET;
+		sin->sin_addr.s_addr = xp->selector.saddr.xfrm4_addr;
+		sin->sin_port = xp->selector.sport;
+		memset(sin->sin_zero, 0, sizeof(sin->sin_zero));
+		addr->sadb_address_exttype = SADB_EXT_ADDRESS_SRC;
+		addr->sadb_address_proto = pfkey_proto_from_xfrm(xp->selector.proto);
+		addr->sadb_address_prefixlen = xp->selector.prefixlen_s;
+		addr->sadb_address_reserved = 0;
+		/* dst address */
+		addr = (struct sadb_address*) skb_put(skb, 
+						      sizeof(struct sadb_address)+sizeof(struct sockaddr_in));
+		addr->sadb_address_len =
+			(sizeof(struct sadb_address)+sizeof(struct sockaddr_in))/
+				sizeof(uint64_t);
+		addr->sadb_address_exttype = SADB_EXT_ADDRESS_DST;
+		addr->sadb_address_proto = pfkey_proto_from_xfrm(xp->selector.proto);
+		addr->sadb_address_prefixlen = xp->selector.prefixlen_d; 
+		addr->sadb_address_reserved = 0;
+		sin = (struct sockaddr_in*)(addr + 1);
+		sin->sin_family = AF_INET;
+		sin->sin_addr.s_addr = xp->selector.daddr.xfrm4_addr;
+		sin->sin_port = xp->selector.dport;
+		memset(sin->sin_zero, 0, sizeof(sin->sin_zero));
+	} else if (xp->family == AF_INET6) {
+		/* src address */
+		addr = (struct sadb_address*) skb_put(skb,
+						      sizeof(struct sadb_address)
+						      +((sizeof(struct sockaddr_in6) +7) & ~7));
+		addr->sadb_address_len =
+			(sizeof(struct sadb_address)+((sizeof(struct sockaddr_in6) + 7) & ~7))/
+				sizeof(uint64_t);
+		sin6 = (struct sockaddr_in6*)(addr + 1);
+		sin6->sin6_family = AF_INET6;
+		sin6->sin6_port = xp->selector.sport;
+		memcpy(&sin6->sin6_addr, &xp->selector.saddr, sizeof(sin6->sin6_addr));
+		addr->sadb_address_exttype = SADB_EXT_ADDRESS_SRC;
+		addr->sadb_address_proto = pfkey_proto_from_xfrm(xp->selector.proto);
+		addr->sadb_address_prefixlen = xp->selector.prefixlen_s;
+		addr->sadb_address_reserved = 0;
+		/* dst address */
+		addr = (struct sadb_address*) skb_put(skb,
+						      sizeof(struct sadb_address)
+						      +((sizeof(struct sockaddr_in6) +7) & ~7));
+		addr->sadb_address_len =
+			(sizeof(struct sadb_address)+((sizeof(struct sockaddr_in6) + 7) & ~7))/
+				sizeof(uint64_t);
+		sin6 = (struct sockaddr_in6*)(addr + 1);
+		sin6->sin6_family = AF_INET6;
+		sin6->sin6_port = xp->selector.dport;
+		memcpy(&sin6->sin6_addr, &xp->selector.daddr, sizeof(sin6->sin6_addr));
+		addr->sadb_address_exttype = SADB_EXT_ADDRESS_DST;
+		addr->sadb_address_proto = pfkey_proto_from_xfrm(xp->selector.proto);
+		addr->sadb_address_prefixlen = xp->selector.prefixlen_d;
+		addr->sadb_address_reserved = 0;
+	}
 
 	/* hard time */
 	lifetime = (struct sadb_lifetime *)  skb_put(skb, 
@@ -1591,10 +1705,17 @@
 		int req_size;
 
 		req_size = sizeof(struct sadb_x_ipsecrequest);
-		if (t->mode)
-			req_size += 2*sizeof(struct sockaddr_in);
-		else 
-			size -= 2*sizeof(struct sockaddr_in);
+		if (t->mode) {
+			if (xp->family == AF_INET)
+				req_size += 2*sizeof(struct sockaddr_in);
+			else if (xp->family == AF_INET6)
+				req_size += 2*((sizeof(struct sockaddr_in6) + 7) & ~7);
+		} else  {
+			if (xp->family == AF_INET) 
+				size -= 2*sizeof(struct sockaddr_in);
+			else if (xp->family == AF_INET6)
+				size -= 2*((sizeof(struct sockaddr_in6) + 7) & ~7);
+		}
 		rq = (void*)skb_put(skb, req_size);
 		pol->sadb_x_policy_len += req_size/8;
 		rq->sadb_x_ipsecrequest_len = req_size;
@@ -1607,16 +1728,27 @@
 			rq->sadb_x_ipsecrequest_level = IPSEC_LEVEL_USE;
 		rq->sadb_x_ipsecrequest_reqid = t->reqid;
 		if (t->mode) {
-			sin = (void*)(rq+1);
-			sin->sin_family = AF_INET;
-			sin->sin_addr.s_addr = t->saddr.xfrm4_addr;
-			sin->sin_port = 0;
-			memset(sin->sin_zero, 0, sizeof(sin->sin_zero));
-			sin++;
-			sin->sin_family = AF_INET;
-			sin->sin_addr.s_addr = t->id.daddr.xfrm4_addr;
-			sin->sin_port = 0;
-			memset(sin->sin_zero, 0, sizeof(sin->sin_zero));
+			if (xp->family == AF_INET) {
+				sin = (void*)(rq+1);
+				sin->sin_family = AF_INET;
+				sin->sin_addr.s_addr = t->saddr.xfrm4_addr;
+				sin->sin_port = 0;
+				memset(sin->sin_zero, 0, sizeof(sin->sin_zero));
+				sin++;
+				sin->sin_family = AF_INET;
+				sin->sin_addr.s_addr = t->id.daddr.xfrm4_addr;
+				sin->sin_port = 0;
+				memset(sin->sin_zero, 0, sizeof(sin->sin_zero));
+			} else if (xp->family == AF_INET6) {
+				sin6 = (void*)(rq+1);
+				sin6->sin6_family = AF_INET;
+				sin6->sin6_port = 0;
+				memcpy(&sin6->sin6_addr, &t->saddr, sizeof(sin6->sin6_addr));
+				sin6++;
+				sin6->sin6_family = AF_INET6;
+				sin6->sin6_port = 0;
+				memcpy(&sin6->sin6_addr, &t->id.daddr, sizeof(sin6->sin6_addr));
+			}
 		}
 	}
 	hdr->sadb_msg_len = size / sizeof(uint64_t);
@@ -1661,7 +1793,9 @@
 		xp->selector.sport_mask = ~0;
 
 	sa = ext_hdrs[SADB_EXT_ADDRESS_DST-1], 
-	pfkey_sadb_addr2xfrm_addr(sa, &xp->selector.daddr);
+	xp->family = pfkey_sadb_addr2xfrm_addr(sa, &xp->selector.daddr);
+	if (xp->family != AF_INET && xp->family != AF_INET6)
+		return -EINVAL;
 	xp->selector.prefixlen_d = sa->sadb_address_prefixlen;
 
 	/* Amusing, we set this twice.  KAME apps appear to set same value
@@ -2086,10 +2220,20 @@
 	struct sadb_address *addr;
 	struct sadb_x_policy *pol;
 	int size;
-	
+	int salen, plen;
+
+	if (x->props.family == AF_INET) {
+		salen = sizeof(struct sockaddr_in);
+		plen = 32;
+	} else if (x->props.family == AF_INET6) {
+		salen = (sizeof(struct sockaddr_in6) + 7) & ~7;
+		plen = 128;
+	} else
+		return -EINVAL;
+
 	size = sizeof(struct sadb_msg) +
 		sizeof(struct sadb_address)*2 + 
-			sizeof(struct sockaddr_in)*2 +   /* XXX */
+			salen*2 + 
 				sizeof(struct sadb_x_policy);
 	
 	if (x->id.proto == IPPROTO_AH)
@@ -2113,33 +2257,47 @@
 
 	/* src address */
 	addr = (struct sadb_address*) skb_put(skb, 
-					      sizeof(struct sadb_address)+sizeof(struct sockaddr_in));
+					      sizeof(struct sadb_address)+salen);
 	addr->sadb_address_len = 
-		(sizeof(struct sadb_address)+sizeof(struct sockaddr_in))/
+		(sizeof(struct sadb_address)+salen)/
 			sizeof(uint64_t);
 	addr->sadb_address_exttype = SADB_EXT_ADDRESS_SRC;
 	addr->sadb_address_proto = 0;
-	addr->sadb_address_prefixlen = 32;
+	addr->sadb_address_prefixlen = plen;
 	addr->sadb_address_reserved = 0;
-	((struct sockaddr_in*)(addr + 1))->sin_family = AF_INET;
-	((struct sockaddr_in*)(addr + 1))->sin_addr.s_addr = 
-		x->props.saddr.xfrm4_addr;
-	((struct sockaddr_in*)(addr + 1))->sin_port = 0;
+	if (x->props.family == AF_INET) {
+		((struct sockaddr_in*)(addr + 1))->sin_family = AF_INET;
+		((struct sockaddr_in*)(addr + 1))->sin_addr.s_addr = 
+			x->props.saddr.xfrm4_addr;
+		((struct sockaddr_in*)(addr + 1))->sin_port = 0;
+	} else {
+		((struct sockaddr_in6*)(addr + 1))->sin6_family = AF_INET6;
+		memcpy(&((struct sockaddr_in6*)(addr + 1))->sin6_addr, 
+		       x->props.saddr.a6, sizeof(x->props.saddr.a6));
+		((struct sockaddr_in6*)(addr + 1))->sin6_port = 0;
+	}
 	
 	/* dst address */
 	addr = (struct sadb_address*) skb_put(skb, 
-					      sizeof(struct sadb_address)+sizeof(struct sockaddr_in));
+					      sizeof(struct sadb_address)+salen);
 	addr->sadb_address_len =
-		(sizeof(struct sadb_address)+sizeof(struct sockaddr_in))/
+		(sizeof(struct sadb_address)+salen)/
 			sizeof(uint64_t);
 	addr->sadb_address_exttype = SADB_EXT_ADDRESS_DST;
 	addr->sadb_address_proto = 0;
-	addr->sadb_address_prefixlen = 32; 
+	addr->sadb_address_prefixlen = plen; 
 	addr->sadb_address_reserved = 0;
-	((struct sockaddr_in*)(addr + 1))->sin_family = AF_INET;
-	((struct sockaddr_in*)(addr + 1))->sin_addr.s_addr = 
-		x->id.daddr.xfrm4_addr;
-	((struct sockaddr_in*)(addr + 1))->sin_port = 0;
+	if (x->props.family == AF_INET) {
+		((struct sockaddr_in*)(addr + 1))->sin_family = AF_INET;
+		((struct sockaddr_in*)(addr + 1))->sin_addr.s_addr = 
+			x->id.daddr.xfrm4_addr;
+		((struct sockaddr_in*)(addr + 1))->sin_port = 0;
+	} else {
+		((struct sockaddr_in6*)(addr + 1))->sin6_family = AF_INET6;
+		memcpy(&((struct sockaddr_in6*)(addr + 1))->sin6_addr,
+		       x->id.daddr.a6, sizeof(x->id.daddr.a6));
+		((struct sockaddr_in6*)(addr + 1))->sin6_port = 0;
+	}
 
 	pol = (struct sadb_x_policy *)  skb_put(skb, sizeof(struct sadb_x_policy));
 	pol->sadb_x_policy_len = sizeof(struct sadb_x_policy)/sizeof(uint64_t);


--Kazunori Miyazawa (Yokogawa Electric Corporation)
