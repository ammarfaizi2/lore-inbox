Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261732AbSKHJrL>; Fri, 8 Nov 2002 04:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261733AbSKHJrK>; Fri, 8 Nov 2002 04:47:10 -0500
Received: from pizda.ninka.net ([216.101.162.242]:17824 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261732AbSKHJqx>;
	Fri, 8 Nov 2002 04:46:53 -0500
Date: Fri, 08 Nov 2002 01:52:30 -0800 (PST)
Message-Id: <20021108.015230.94737520.davem@redhat.com>
To: ahu@ds9a.nl
Cc: mdiehl@dominion.dyndns.org, linux-kernel@vger.kernel.org
Subject: Re: [documentation] Re: [LARTC] IPSEC FIRST LIGHT! (by non-kernel
 developer :-))
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021108094122.GB16512@outpost.ds9a.nl>
References: <20021107130244.GA25032@outpost.ds9a.nl>
	<20021108023926.51B985606@dominion.dyndns.org>
	<20021108094122.GB16512@outpost.ds9a.nl>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: bert hubert <ahu@ds9a.nl>
   Date: Fri, 8 Nov 2002 10:41:22 +0100
   
   Perhaps dave can re-diff?

This is against current BK-2.5

--------------------
1. Expiration of SA's. Some missing updates of counters.
   Question: very strange, rfc defines use_time as time of the first use
   of SA. But kame setkey refers to this as "lastuse".
2. Bug fixes for tunnel mode and forwarding.
3. Fix bugs in per-socket policy: policy entries do not leak but are destroyed,
   when socket is closed, and are cloned on children of listening sockets.
4. Implemented "use" policy: i.e. use ipsec if a SA is available,
   ignore if it is not.
5. Added sysctl to disable in/out policy on some devices.
   It is set on loopback by default.
6. Remove "resolved" reference from template. It is not used,
   but pollutes code.
7. Added all the SASTATE's, now they make sense.

===== include/linux/inetdevice.h 1.4 vs edited =====
--- 1.4/include/linux/inetdevice.h	Wed Mar 20 07:21:45 2002
+++ edited/include/linux/inetdevice.h	Fri Nov  8 05:01:54 2002
@@ -19,6 +19,8 @@
 	int	tag;
 	int     arp_filter;
 	int	medium_id;
+	int	no_xfrm;
+	int	no_policy;
 	void	*sysctl;
 };
 
===== include/linux/sysctl.h 1.35 vs edited =====
--- 1.35/include/linux/sysctl.h	Thu Oct 24 14:50:08 2002
+++ edited/include/linux/sysctl.h	Fri Nov  8 05:01:54 2002
@@ -351,6 +351,8 @@
 	NET_IPV4_CONF_TAG=12,
 	NET_IPV4_CONF_ARPFILTER=13,
 	NET_IPV4_CONF_MEDIUM_ID=14,
+	NET_IPV4_CONF_NOXFRM=15,
+	NET_IPV4_CONF_NOPOLICY=16,
 };
 
 /* /proc/sys/net/ipv6 */
===== include/net/xfrm.h 1.3 vs edited =====
--- 1.3/include/net/xfrm.h	Tue Nov  5 18:17:12 2002
+++ edited/include/net/xfrm.h	Fri Nov  8 05:23:01 2002
@@ -53,8 +53,6 @@
    7. ->share		Sharing mode.
       Q: how to implement private sharing mode? To add struct sock* to
       flow id?
-   8. ->resolved	If template uniquely resolves to a static xfrm_state,
-                        the reference is stores here.
 
    Having this template we search through SAD searching for entries
    with appropriate mode/proto/algo, permitted by selector.
@@ -114,6 +112,8 @@
 	void	*owner;
 };
 
+#define XFRM_INF (~(u64)0)
+
 struct xfrm_lifetime_cfg
 {
 	u64	soft_byte_limit;
@@ -161,9 +161,9 @@
 
 	/* Key manger bits */
 	struct {
-		int		state;
+		u8		state;
+		u8		dying;
 		u32		seq;
-		u64		warn_bytes;
 	} km;
 
 	/* Parameters of this state. */
@@ -195,6 +195,7 @@
 	} stats;
 
 	struct xfrm_lifetime_cur curlft;
+	struct timer_list	timer;
 
 	/* Reference to data common to all the instances of this
 	 * transformer. */
@@ -255,13 +256,13 @@
 /* Sharing mode: unique, this session only, this user only etc. */
 	__u8			share;
 
+/* May skip this transfomration if no SA is found */
+	__u8			optional;
+
 /* Bit mask of algos allowed for acquisition */
 	__u32			aalgos;
 	__u32			ealgos;
 	__u32			calgos;
-
-/* If template statically resolved, hold ref here */
-	struct xfrm_state      *resolved;
 };
 
 #define XFRM_MAX_DEPTH		3
@@ -419,11 +420,35 @@
 		__xfrm_route_forward(skb);
 }
 
+extern int __xfrm_sk_clone_policy(struct sock *sk);
+
+static inline int xfrm_sk_clone_policy(struct sock *sk)
+{
+	if (unlikely(sk->policy[0] || sk->policy[1]))
+		return xfrm_sk_clone_policy(sk);
+	return 0;
+}
+
+extern void __xfrm_sk_free_policy(struct xfrm_policy *);
+
+static inline void xfrm_sk_free_policy(struct sock *sk)
+{
+	if (unlikely(sk->policy[0] != NULL)) {
+		__xfrm_sk_free_policy(sk->policy[0]);
+		sk->policy[0] = NULL;
+	}
+	if (unlikely(sk->policy[1] != NULL)) {
+		__xfrm_sk_free_policy(sk->policy[1]);
+		sk->policy[1] = NULL;
+	}
+}
+
 extern void xfrm_state_init(void);
 extern void xfrm_input_init(void);
 extern int xfrm_state_walk(u8 proto, int (*func)(struct xfrm_state *, int, void*), void *);
 extern struct xfrm_state *xfrm_state_alloc(void);
-extern struct xfrm_state *xfrm_state_find(u32 daddr, struct flowi *fl, struct xfrm_tmpl *tmpl, struct xfrm_policy *pol);
+extern struct xfrm_state *xfrm_state_find(u32 daddr, u32 saddr, struct flowi *fl, struct xfrm_tmpl *tmpl,
+					  struct xfrm_policy *pol, int *err);
 extern int xfrm_state_check_expire(struct xfrm_state *x);
 extern void xfrm_state_insert(struct xfrm_state *x);
 extern int xfrm_state_check_space(struct xfrm_state *x, struct sk_buff *skb);
@@ -437,7 +462,7 @@
 extern int xfrm4_rcv(struct sk_buff *skb);
 extern int xfrm_user_policy(struct sock *sk, int optname, u8 *optval, int optlen);
 
-struct xfrm_policy *xfrm_policy_alloc(void);
+struct xfrm_policy *xfrm_policy_alloc(int gfp);
 extern int xfrm_policy_walk(int (*func)(struct xfrm_policy *, int, int, void*), void *);
 struct xfrm_policy *xfrm_policy_lookup(int dir, struct flowi *fl);
 int xfrm_policy_insert(int dir, struct xfrm_policy *policy, int excl);
@@ -450,6 +475,7 @@
 extern void xfrm_policy_kill(struct xfrm_policy *);
 extern int xfrm_sk_policy_insert(struct sock *sk, int dir, struct xfrm_policy *pol);
 extern struct xfrm_policy *xfrm_sk_policy_lookup(struct sock *sk, int dir, struct flowi *fl);
+extern int xfrm_flush_bundles(struct xfrm_state *x);
 
 extern wait_queue_head_t *km_waitq;
 extern void km_warn_expired(struct xfrm_state *x);
===== net/ipv4/af_inet.c 1.32 vs edited =====
--- 1.32/net/ipv4/af_inet.c	Wed Nov  6 21:38:34 2002
+++ edited/net/ipv4/af_inet.c	Fri Nov  8 05:21:59 2002
@@ -110,6 +110,7 @@
 #include <net/icmp.h>
 #include <net/ipip.h>
 #include <net/inet_common.h>
+#include <net/xfrm.h>
 #ifdef CONFIG_IP_MROUTE
 #include <linux/mroute.h>
 #endif
@@ -195,6 +196,8 @@
 	 */
 
 	sock_orphan(sk);
+
+	xfrm_sk_free_policy(sk);
 
 #ifdef INET_REFCNT_DEBUG
 	if (atomic_read(&sk->refcnt) != 1)
===== net/ipv4/ah.c 1.5 vs edited =====
--- 1.5/net/ipv4/ah.c	Tue Nov  5 22:52:22 2002
+++ edited/net/ipv4/ah.c	Thu Nov  7 23:25:05 2002
@@ -231,6 +231,7 @@
 	skb->nh.raw = skb->data;
 
 	x->curlft.bytes += skb->len;
+	x->curlft.packets++;
 	spin_unlock_bh(&x->lock);
 	if ((skb->dst = dst_pop(dst)) == NULL)
 		goto error;
===== net/ipv4/devinet.c 1.10 vs edited =====
--- 1.10/net/ipv4/devinet.c	Sat Oct  5 06:12:11 2002
+++ edited/net/ipv4/devinet.c	Fri Nov  8 05:01:54 2002
@@ -857,6 +857,8 @@
 				memcpy(ifa->ifa_label, dev->name, IFNAMSIZ);
 				inet_insert_ifa(ifa);
 			}
+			in_dev->cnf.no_xfrm = 1;
+			in_dev->cnf.no_policy = 1;
 		}
 		ip_mc_up(in_dev);
 		break;
@@ -1041,7 +1043,7 @@
 
 static struct devinet_sysctl_table {
 	struct ctl_table_header *sysctl_header;
-	ctl_table		devinet_vars[15];
+	ctl_table		devinet_vars[17];
 	ctl_table		devinet_dev[2];
 	ctl_table		devinet_conf_dir[2];
 	ctl_table		devinet_proto_dir[2];
@@ -1156,6 +1158,22 @@
 			.ctl_name =	NET_IPV4_CONF_ARPFILTER,
 			.procname =	"arp_filter",
 			.data =	&ipv4_devconf.arp_filter,
+			.maxlen =		sizeof(int),
+			.mode =	0644,
+			.proc_handler =&proc_dointvec,
+		},
+		{
+			.ctl_name =	NET_IPV4_CONF_NOXFRM,
+			.procname =	"disable_xfrm",
+			.data =	&ipv4_devconf.no_xfrm,
+			.maxlen =		sizeof(int),
+			.mode =	0644,
+			.proc_handler =&proc_dointvec,
+		},
+		{
+			.ctl_name =	NET_IPV4_CONF_NOPOLICY,
+			.procname =	"disable_policy",
+			.data =	&ipv4_devconf.no_policy,
 			.maxlen =		sizeof(int),
 			.mode =	0644,
 			.proc_handler =&proc_dointvec,
===== net/ipv4/esp.c 1.3 vs edited =====
--- 1.3/net/ipv4/esp.c	Tue Nov  5 22:52:22 2002
+++ edited/net/ipv4/esp.c	Thu Nov  7 23:25:05 2002
@@ -199,7 +199,7 @@
 
 /* Check that skb data bits are writable. If they are not, copy data
  * to newly created private area. If "tailbits" is given, make sure that
- * tailbits bytes beoynd current end of skb are writable.
+ * tailbits bytes beyond current end of skb are writable.
  *
  * Returns amount of elements of scatterlist to load for subsequent
  * transformations and pointer to writable trailer skb.
@@ -433,6 +433,7 @@
 	skb->nh.raw = skb->data;
 
 	x->curlft.bytes += skb->len;
+	x->curlft.packets++;
 	spin_unlock_bh(&x->lock);
 	if ((skb->dst = dst_pop(dst)) == NULL)
 		goto error;
===== net/ipv4/route.c 1.29 vs edited =====
--- 1.29/net/ipv4/route.c	Wed Nov  6 00:56:09 2002
+++ edited/net/ipv4/route.c	Fri Nov  8 05:18:40 2002
@@ -1265,6 +1265,8 @@
 
 	atomic_set(&rth->u.dst.__refcnt, 1);
 	rth->u.dst.flags= DST_HOST;
+	if (in_dev->cnf.no_policy)
+		rth->u.dst.flags |= DST_NOPOLICY;
 	rth->fl.fl4_dst	= daddr;
 	rth->rt_dst	= daddr;
 	rth->fl.fl4_tos	= tos;
@@ -1470,6 +1472,10 @@
 
 	atomic_set(&rth->u.dst.__refcnt, 1);
 	rth->u.dst.flags= DST_HOST;
+	if (in_dev->cnf.no_policy)
+		rth->u.dst.flags |= DST_NOPOLICY;
+	if (in_dev->cnf.no_xfrm)
+		rth->u.dst.flags |= DST_NOXFRM;
 	rth->fl.fl4_dst	= daddr;
 	rth->rt_dst	= daddr;
 	rth->fl.fl4_tos	= tos;
@@ -1547,6 +1553,8 @@
 
 	atomic_set(&rth->u.dst.__refcnt, 1);
 	rth->u.dst.flags= DST_HOST;
+	if (in_dev->cnf.no_policy)
+		rth->u.dst.flags |= DST_NOPOLICY;
 	rth->fl.fl4_dst	= daddr;
 	rth->rt_dst	= daddr;
 	rth->fl.fl4_tos	= tos;
@@ -1719,6 +1727,7 @@
 	unsigned flags = 0;
 	struct rtable *rth;
 	struct net_device *dev_out = NULL;
+	struct in_device *in_dev = NULL;
 	unsigned hash;
 	int free_res = 0;
 	int err;
@@ -1895,6 +1904,10 @@
 	if (dev_out->flags & IFF_LOOPBACK)
 		flags |= RTCF_LOCAL;
 
+	in_dev = in_dev_get(dev_out);
+	if (!in_dev)
+		goto e_inval;
+
 	if (res.type == RTN_BROADCAST) {
 		flags |= RTCF_BROADCAST | RTCF_LOCAL;
 		if (res.fi) {
@@ -1903,11 +1916,8 @@
 		}
 	} else if (res.type == RTN_MULTICAST) {
 		flags |= RTCF_MULTICAST|RTCF_LOCAL;
-		read_lock(&inetdev_lock);
-		if (!__in_dev_get(dev_out) ||
-		    !ip_check_mc(__in_dev_get(dev_out), oldflp->fl4_dst))
+		if (!ip_check_mc(in_dev, oldflp->fl4_dst))
 			flags &= ~RTCF_LOCAL;
-		read_unlock(&inetdev_lock);
 		/* If multicast route do not exist use
 		   default one, but do not gateway in this case.
 		   Yes, it is hack.
@@ -1924,6 +1934,10 @@
 
 	atomic_set(&rth->u.dst.__refcnt, 1);
 	rth->u.dst.flags= DST_HOST;
+	if (in_dev->cnf.no_xfrm)
+		rth->u.dst.flags |= DST_NOXFRM;
+	if (in_dev->cnf.no_policy)
+		rth->u.dst.flags |= DST_NOPOLICY;
 	rth->fl.fl4_dst	= oldflp->fl4_dst;
 	rth->fl.fl4_tos	= tos;
 	rth->fl.fl4_src	= oldflp->fl4_src;
@@ -1959,20 +1973,17 @@
 		}
 #ifdef CONFIG_IP_MROUTE
 		if (res.type == RTN_MULTICAST) {
-			struct in_device *in_dev = in_dev_get(dev_out);
-			if (in_dev) {
-				if (IN_DEV_MFORWARD(in_dev) &&
-				    !LOCAL_MCAST(oldflp->fl4_dst)) {
-					rth->u.dst.input = ip_mr_input;
-					rth->u.dst.output = ip_mc_output;
-				}
-				in_dev_put(in_dev);
+			if (IN_DEV_MFORWARD(in_dev) &&
+			    !LOCAL_MCAST(oldflp->fl4_dst)) {
+				rth->u.dst.input = ip_mr_input;
+				rth->u.dst.output = ip_mc_output;
 			}
 		}
 #endif
 	}
 
 	rt_set_nexthop(rth, &res, 0);
+	
 
 	rth->rt_flags = flags;
 
@@ -1983,6 +1994,8 @@
 		fib_res_put(&res);
 	if (dev_out)
 		dev_put(dev_out);
+	if (in_dev)
+		in_dev_put(in_dev);
 out:	return err;
 
 e_inval:
===== net/ipv4/tcp.c 1.31 vs edited =====
--- 1.31/net/ipv4/tcp.c	Fri Nov  1 15:15:17 2002
+++ edited/net/ipv4/tcp.c	Fri Nov  8 05:20:36 2002
@@ -257,6 +257,7 @@
 
 #include <net/icmp.h>
 #include <net/tcp.h>
+#include <net/xfrm.h>
 
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
@@ -1919,6 +1920,8 @@
 	sk->prot->destroy(sk);
 
 	tcp_kill_sk_queues(sk);
+
+	xfrm_sk_free_policy(sk);
 
 #ifdef INET_REFCNT_DEBUG
 	if (atomic_read(&sk->refcnt) != 1) {
===== net/ipv4/tcp_minisocks.c 1.19 vs edited =====
--- 1.19/net/ipv4/tcp_minisocks.c	Tue Nov  5 13:20:40 2002
+++ edited/net/ipv4/tcp_minisocks.c	Fri Nov  8 05:20:36 2002
@@ -25,6 +25,7 @@
 #include <linux/sysctl.h>
 #include <net/tcp.h>
 #include <net/inet_common.h>
+#include <net/xfrm.h>
 
 #ifdef CONFIG_SYSCTL
 #define SYNC_INIT 0 /* let the user enable it */
@@ -685,6 +686,13 @@
 		if ((filter = newsk->filter) != NULL)
 			sk_filter_charge(newsk, filter);
 #endif
+		if (unlikely(xfrm_sk_clone_policy(newsk))) {
+			/* It is still raw copy of parent, so invalidate
+			 * destructor and make plain sk_free() */
+			newsk->destruct = NULL;
+			sk_free(newsk);
+			return NULL;
+		}
 
 		/* Now setup tcp_opt */
 		newtp = tcp_sk(newsk);
===== net/ipv4/xfrm_input.c 1.2 vs edited =====
--- 1.2/net/ipv4/xfrm_input.c	Tue Nov  5 18:17:12 2002
+++ edited/net/ipv4/xfrm_input.c	Thu Nov  7 23:25:05 2002
@@ -81,6 +81,9 @@
 		if (x->props.replay_window)
 			xfrm_replay_advance(x, seq);
 
+		x->curlft.bytes += skb->len;
+		x->curlft.packets++;
+
 		spin_unlock(&x->lock);
 
 		xfrm_vec[xfrm_nr++] = x;
===== net/ipv4/xfrm_policy.c 1.7 vs edited =====
--- 1.7/net/ipv4/xfrm_policy.c	Thu Nov  7 04:52:11 2002
+++ edited/net/ipv4/xfrm_policy.c	Fri Nov  8 06:06:34 2002
@@ -207,11 +207,11 @@
  * SPD calls.
  */
 
-struct xfrm_policy *xfrm_policy_alloc(void)
+struct xfrm_policy *xfrm_policy_alloc(int gfp)
 {
 	struct xfrm_policy *policy;
 
-	policy = kmalloc(sizeof(struct xfrm_policy), GFP_KERNEL);
+	policy = kmalloc(sizeof(struct xfrm_policy), gfp);
 
 	if (policy) {
 		memset(policy, 0, sizeof(struct xfrm_policy));
@@ -225,16 +225,9 @@
 
 void __xfrm_policy_destroy(struct xfrm_policy *policy)
 {
-	int i;
-
 	if (!policy->dead)
 		BUG();
 
-	for (i=0; i<policy->xfrm_nr; i++) {
-		if (policy->xfrm_vec[i].resolved)
-			BUG();
-	}
-
 	if (policy->bundles)
 		BUG();
 
@@ -248,7 +241,6 @@
 void xfrm_policy_kill(struct xfrm_policy *policy)
 {
 	struct dst_entry *dst;
-	int i;
 
 	write_lock_bh(&policy->lock);
 	if (policy->dead)
@@ -256,13 +248,6 @@
 
 	policy->dead = 1;
 
-	for (i=0; i<policy->xfrm_nr; i++) {
-		if (policy->xfrm_vec[i].resolved) {
-			xfrm_state_put(policy->xfrm_vec[i].resolved);
-			policy->xfrm_vec[i].resolved = NULL;
-		}
-	}
-
 	while ((dst = policy->bundles) != NULL) {
 		policy->bundles = dst->next;
 		dst_free(dst);
@@ -310,6 +295,8 @@
 	*p = policy;
 	xfrm_policy_genid++;
 	policy->index = pol ? pol->index : xfrm_gen_index(dir);
+	policy->curlft.add_time = (unsigned long)xtime.tv_sec;
+	policy->curlft.use_time = 0;
 	write_unlock_bh(&xfrm_policy_lock);
 
 	if (pol) {
@@ -417,13 +404,12 @@
 struct xfrm_policy *xfrm_policy_lookup(int dir, struct flowi *fl)
 {
 	struct xfrm_policy *pol;
-	/* Not now :-) u64 now = (unsigned long)xtime.tv_sec; */
 
 	read_lock(&xfrm_policy_lock);
 	for (pol = xfrm_policy_list[dir]; pol; pol = pol->next) {
 		struct xfrm_selector *sel = &pol->selector;
 
-		if (xfrm4_selector_match(sel, fl) /* XXX && XXX now < pol->validtime */) {
+		if (xfrm4_selector_match(sel, fl)) {
 			atomic_inc(&pol->refcnt);
 			break;
 		}
@@ -435,13 +421,12 @@
 struct xfrm_policy *xfrm_sk_policy_lookup(struct sock *sk, int dir, struct flowi *fl)
 {
 	struct xfrm_policy *pol;
-	/* Not now :-) u64 now = (unsigned long)xtime.tv_sec; */
 
 	read_lock(&xfrm_policy_lock);
 	for (pol = sk->policy[dir]; pol; pol = pol->next) {
 		struct xfrm_selector *sel = &pol->selector;
 
-		if (xfrm4_selector_match(sel, fl) /* XXX && XXX now < pol->validtime */) {
+		if (xfrm4_selector_match(sel, fl)) {
 			atomic_inc(&pol->refcnt);
 			break;
 		}
@@ -466,48 +451,87 @@
 	return 0;
 }
 
+static struct xfrm_policy *clone_policy(struct xfrm_policy *old)
+{
+	struct xfrm_policy *newp = xfrm_policy_alloc(GFP_ATOMIC);
+
+	if (newp) {
+		newp->selector = old->selector;
+		newp->lft = old->lft;
+		newp->curlft = old->curlft;
+		newp->action = old->action;
+		newp->flags = old->flags;
+		newp->xfrm_nr = old->xfrm_nr;
+		memcpy(newp->xfrm_vec, old->xfrm_vec,
+		       newp->xfrm_nr*sizeof(struct xfrm_tmpl));
+	}
+	return newp;
+}
+
+int __xfrm_sk_clone_policy(struct sock *sk)
+{
+	struct xfrm_policy *p0, *p1;
+	p0 = sk->policy[0];
+	p1 = sk->policy[1];
+	sk->policy[0] = NULL;
+	sk->policy[1] = NULL;
+	if (p0 && (sk->policy[0] = clone_policy(p0)) == NULL)
+		return -ENOMEM;
+	if (p1 && (sk->policy[1] = clone_policy(p1)) == NULL)
+		return -ENOMEM;
+	return 0;
+}
+
+void __xfrm_sk_free_policy(struct xfrm_policy *pol)
+{
+	xfrm_policy_kill(pol);
+	xfrm_pol_put(pol);
+}
+
 /* Resolve list of templates for the flow, given policy. */
 
 static int
 xfrm_tmpl_resolve(struct xfrm_policy *policy, struct flowi *fl,
 		  struct xfrm_state **xfrm)
 {
+	int nx;
 	int i, error;
 	u32 daddr = fl->fl4_dst;
+	u32 saddr = fl->fl4_src;
 
-	for (i = 0; i < policy->xfrm_nr; i++) {
+	for (nx=0, i = 0; i < policy->xfrm_nr; i++) {
+		struct xfrm_state *x;
+		u32 remote = daddr;
+		u32 local = saddr;
 		struct xfrm_tmpl *tmpl = &policy->xfrm_vec[i];
-		if (tmpl->mode)
-			daddr = tmpl->id.daddr.xfrm4_addr;
-		if (tmpl->resolved) {
-			if (tmpl->resolved->km.state != XFRM_STATE_VALID) {
-				error = -EINVAL;
-				goto fail;
-			}
-			xfrm[i] = tmpl->resolved;
-			atomic_inc(&tmpl->resolved->refcnt);
-		} else {
-			xfrm[i] = xfrm_state_find(daddr, fl, tmpl, policy);
-			if (xfrm[i] == NULL) {
-				error = -ENOMEM;
-				goto fail;
-			}
-			if (xfrm[i]->km.state == XFRM_STATE_VALID)
-				continue;
 
-			if (xfrm[i]->km.state == XFRM_STATE_ERROR)
-				error = -EINVAL;
-			else
-				error = -EAGAIN;
-			i++;
-			goto fail;
+		if (tmpl->mode) {
+			remote = tmpl->id.daddr.xfrm4_addr;
+			local = tmpl->saddr.xfrm4_addr;
 		}
+
+		x = xfrm_state_find(remote, local, fl, tmpl, policy, &error);
+
+		if (x && x->km.state == XFRM_STATE_VALID) {
+			xfrm[nx++] = x;
+			daddr = remote;
+			saddr = local;
+			continue;
+		}
+		if (x) {
+			error = (x->km.state == XFRM_STATE_ERROR ?
+				 -EINVAL : -EAGAIN);
+			xfrm_state_put(x);
+		}
+
+		if (!tmpl->optional)
+			goto fail;
 	}
-	return 0;
+	return nx;
 
 fail:
-	for (i--; i>=0; i--)
-		xfrm_state_put(xfrm[i]);
+	for (nx--; nx>=0; nx--)
+		xfrm_state_put(xfrm[nx]);
 	return error;
 }
 
@@ -537,7 +561,7 @@
  */
 
 static int
-xfrm_bundle_create(struct xfrm_policy *policy, struct xfrm_state **xfrm,
+xfrm_bundle_create(struct xfrm_policy *policy, struct xfrm_state **xfrm, int nx,
 		   struct flowi *fl, struct dst_entry **dst_p)
 {
 	struct dst_entry *dst, *dst_prev;
@@ -551,7 +575,7 @@
 
 	dst = dst_prev = NULL;
 
-	for (i = 0; i < policy->xfrm_nr; i++) {
+	for (i = 0; i < nx; i++) {
 		struct dst_entry *dst1 = dst_alloc(&xfrm4_dst_ops);
 
 		if (unlikely(dst1 == NULL)) {
@@ -595,6 +619,7 @@
 		dst_prev->dev = rt->u.dst.dev;
 		if (rt->u.dst.dev)
 			dev_hold(rt->u.dst.dev);
+		dst_prev->obsolete	= -1;
 		dst_prev->flags	       |= DST_HOST;
 		dst_prev->lastuse	= jiffies;
 		dst_prev->header_len	= header_len;
@@ -610,7 +635,7 @@
 		x->u.rt.peer = rt->peer;
 		/* Sheit... I remember I did this right. Apparently,
 		 * it was magically lost, so this code needs audit */
-		x->u.rt.rt_flags = rt->rt_flags;
+		x->u.rt.rt_flags = rt0->rt_flags&(RTCF_BROADCAST|RTCF_MULTICAST|RTCF_LOCAL);
 		x->u.rt.rt_type = rt->rt_type;
 		x->u.rt.rt_src = rt0->rt_src;
 		x->u.rt.rt_dst = rt0->rt_dst;
@@ -639,6 +664,7 @@
 	struct xfrm_state *xfrm[XFRM_MAX_DEPTH];
 	struct rtable *rt = (struct rtable*)*dst_p;
 	struct dst_entry *dst;
+	int nx = 0;
 	int err;
 	u32 genid;
 
@@ -661,6 +687,9 @@
 			return 0;
 	}
 
+	if (!policy->curlft.use_time)
+		policy->curlft.use_time = (unsigned long)xtime.tv_sec;
+
 	switch (policy->action) {
 	case XFRM_POLICY_BLOCK:
 		/* Prohibit the flow */
@@ -695,8 +724,9 @@
 		if (dst)
 			break;
 
-		err = xfrm_tmpl_resolve(policy, fl, xfrm);
-		if (unlikely(err)) {
+		nx = xfrm_tmpl_resolve(policy, fl, xfrm);
+		if (unlikely(nx<0)) {
+			err = nx;
 			if (err == -EAGAIN) {
 				struct task_struct *tsk = current;
 				DECLARE_WAITQUEUE(wait, tsk);
@@ -721,15 +751,18 @@
 			}
 			if (err)
 				goto error;
+		} else if (nx == 0) {
+			/* Flow passes not transformed. */
+			xfrm_pol_put(policy);
+			return 0;
 		}
 
 		dst = &rt->u.dst;
-		err = xfrm_bundle_create(policy, xfrm, fl, &dst);
+		err = xfrm_bundle_create(policy, xfrm, nx, fl, &dst);
 		if (unlikely(err)) {
 			int i;
-			for (i=0; i<policy->xfrm_nr; i++)
+			for (i=0; i<nx; i++)
 				xfrm_state_put(xfrm[i]);
-			err = -EPERM;
 			goto error;
 		}
 
@@ -863,6 +896,9 @@
 	if (!pol)
 		return 1;
 
+	if (!pol->curlft.use_time)
+		pol->curlft.use_time = (unsigned long)xtime.tv_sec;
+
 	if (pol->action == XFRM_POLICY_ALLOW) {
 		if (pol->xfrm_nr != 0) {
 			struct sec_path *sp;
@@ -900,10 +936,21 @@
 	return xfrm_lookup(&skb->dst, &fl, NULL, 0) == 0;
 }
 
+/* Optimize later using cookies and generation ids. */
+
 static struct dst_entry *xfrm4_dst_check(struct dst_entry *dst, u32 cookie)
 {
-	dst_release(dst);
-	return NULL;
+	struct dst_entry *child = dst;
+
+	while (child) {
+		if (child->obsolete > 0 ||
+		    (child->xfrm && child->xfrm->km.state != XFRM_STATE_VALID)) {
+			dst_release(dst);
+			return NULL;
+		}
+	}
+
+	return dst;
 }
 
 static void xfrm4_dst_destroy(struct dst_entry *dst)
@@ -958,11 +1005,55 @@
 	while (gc_list) {
 		dst = gc_list;
 		gc_list = dst->next;
-		dst_destroy(dst);
+		dst_free(dst);
 	}
 
 	return (atomic_read(&xfrm4_dst_ops.entries) > xfrm4_dst_ops.gc_thresh*2);
 }
+
+static int bundle_depends_on(struct dst_entry *dst, struct xfrm_state *x)
+{
+	do {
+		if (dst->xfrm == x)
+			return 1;
+	} while ((dst = dst->child) != NULL);
+	return 0;
+}
+
+int xfrm_flush_bundles(struct xfrm_state *x)
+{
+	int i;
+	struct xfrm_policy *pol;
+	struct dst_entry *dst, **dstp, *gc_list = NULL;
+
+	read_lock_bh(&xfrm_policy_lock);
+	for (i=0; i<XFRM_POLICY_MAX; i++) {
+		for (pol = xfrm_policy_list[i]; pol; pol = pol->next) {
+			write_lock(&pol->lock);
+			dstp = &pol->bundles;
+			while ((dst=*dstp) != NULL) {
+				if (bundle_depends_on(dst, x)) {
+					*dstp = dst->next;
+					dst->next = gc_list;
+					gc_list = dst;
+				} else {
+					dstp = &dst->next;
+				}
+			}
+			write_unlock(&pol->lock);
+		}
+	}
+	read_unlock_bh(&xfrm_policy_lock);
+
+	while (gc_list) {
+		dst = gc_list;
+		gc_list = dst->next;
+		dst_free(dst);
+	}
+
+	return 0;
+}
+
 
 static void xfrm4_update_pmtu(struct dst_entry *dst, u32 mtu)
 {
===== net/ipv4/xfrm_state.c 1.4 vs edited =====
--- 1.4/net/ipv4/xfrm_state.c	Wed Nov  6 21:38:34 2002
+++ edited/net/ipv4/xfrm_state.c	Fri Nov  8 07:35:50 2002
@@ -2,16 +2,11 @@
 #include <linux/pfkeyv2.h>
 #include <linux/ipsec.h>
 
-/* Each xfrm_state is linked to three tables:
+/* Each xfrm_state may be linked to two tables:
 
    1. Hash table by (spi,daddr,ah/esp) to find SA by SPI. (input,ctl)
    2. Hash table by daddr to find what SAs exist for given
       destination/tunnel endpoint. (output)
-   3. (optional, NI) Radix tree by _selector_ for the case,
-      when we have to find a tunnel mode SA appropriate for given flow,
-      but do not know tunnel endpoint. At the moment we do
-      not support this and assume that tunnel endpoint is given
-      by policy. (output)
  */
 
 static spinlock_t xfrm_state_lock = SPIN_LOCK_UNLOCKED;
@@ -29,6 +24,82 @@
 
 wait_queue_head_t *km_waitq;
 
+#define ACQ_EXPIRES 30
+
+static void __xfrm_state_delete(struct xfrm_state *x);
+
+unsigned long make_jiffies(long secs)
+{
+	if (secs >= (MAX_SCHEDULE_TIMEOUT-1)/HZ)
+		return MAX_SCHEDULE_TIMEOUT-1;
+	else
+	        return secs*HZ;
+}
+
+static void xfrm_timer_handler(unsigned long data)
+{
+	struct xfrm_state *x = (struct xfrm_state*)data;
+	unsigned long now = (unsigned long)xtime.tv_sec;
+	long next = LONG_MAX;
+	int warn = 0;
+
+	spin_lock(&x->lock);
+	if (x->km.state == XFRM_STATE_DEAD)
+		goto out;
+	if (x->km.state == XFRM_STATE_EXPIRED)
+		goto expired;
+	if (x->lft.hard_add_expires_seconds) {
+		long tmo = x->lft.hard_add_expires_seconds +
+			x->curlft.add_time - now;
+		if (tmo <= 0)
+			goto expired;
+		if (tmo < next)
+			next = tmo;
+	}
+	if (x->lft.hard_use_expires_seconds && x->curlft.use_time) {
+		long tmo = x->lft.hard_use_expires_seconds +
+			x->curlft.use_time - now;
+		if (tmo <= 0)
+			goto expired;
+		if (tmo < next)
+			next = tmo;
+	}
+	if (x->km.dying)
+		goto resched;
+	if (x->lft.soft_add_expires_seconds) {
+		long tmo = x->lft.soft_add_expires_seconds +
+			x->curlft.add_time - now;
+		if (tmo <= 0)
+			warn = 1;
+		else if (tmo < next)
+			next = tmo;
+	}
+	if (x->lft.soft_use_expires_seconds && x->curlft.use_time) {
+		long tmo = x->lft.soft_use_expires_seconds +
+			x->curlft.use_time - now;
+		if (tmo <= 0)
+			warn = 1;
+		else if (tmo < next)
+			next = tmo;
+	}
+
+	if (warn)
+		km_warn_expired(x);
+resched:
+	if (next != LONG_MAX &&
+	    !mod_timer(&x->timer, jiffies + make_jiffies(next)))
+		atomic_inc(&x->refcnt);
+	goto out;
+
+expired:
+	km_expired(x);
+	__xfrm_state_delete(x);
+
+out:
+	spin_unlock(&x->lock);
+	xfrm_state_put(x);
+}
+
 struct xfrm_state *xfrm_state_alloc(void)
 {
 	struct xfrm_state *x;
@@ -40,6 +111,14 @@
 		atomic_set(&x->refcnt, 1);
 		INIT_LIST_HEAD(&x->bydst);
 		INIT_LIST_HEAD(&x->byspi);
+		init_timer(&x->timer);
+		x->timer.function = xfrm_timer_handler;
+		x->timer.data	  = (unsigned long)x;
+		x->curlft.add_time = (unsigned long)xtime.tv_sec;
+		x->lft.soft_byte_limit = XFRM_INF;
+		x->lft.soft_packet_limit = XFRM_INF;
+		x->lft.hard_byte_limit = XFRM_INF;
+		x->lft.hard_packet_limit = XFRM_INF;
 		x->lock = SPIN_LOCK_UNLOCKED;
 	}
 	return x;
@@ -48,6 +127,8 @@
 void __xfrm_state_destroy(struct xfrm_state *x)
 {
 	BUG_TRAP(x->km.state == XFRM_STATE_DEAD);
+	if (del_timer(&x->timer))
+		BUG();
 	if (x->aalg)
 		kfree(x->aalg);
 	if (x->ealg)
@@ -59,11 +140,10 @@
 	kfree(x);
 }
 
-void xfrm_state_delete(struct xfrm_state *x)
+static void __xfrm_state_delete(struct xfrm_state *x)
 {
 	int kill = 0;
 
-	spin_lock_bh(&x->lock);
 	if (x->km.state != XFRM_STATE_DEAD) {
 		x->km.state = XFRM_STATE_DEAD;
 		kill = 1;
@@ -75,14 +155,24 @@
 			atomic_dec(&x->refcnt);
 		}
 		spin_unlock(&xfrm_state_lock);
+		if (del_timer(&x->timer))
+			atomic_dec(&x->refcnt);
+		if (atomic_read(&x->refcnt) != 1)
+			xfrm_flush_bundles(x);
 	}
-	spin_unlock_bh(&x->lock);
 
 	if (kill && x->type)
 		x->type->destructor(x);
 	wake_up(km_waitq);
 }
 
+void xfrm_state_delete(struct xfrm_state *x)
+{
+	spin_lock_bh(&x->lock);
+	__xfrm_state_delete(x);
+	spin_unlock_bh(&x->lock);
+}
+
 void xfrm_state_flush(u8 proto)
 {
 	int i;
@@ -109,18 +199,21 @@
 }
 
 struct xfrm_state *
-xfrm_state_find(u32 daddr, struct flowi *fl, struct xfrm_tmpl *tmpl, struct xfrm_policy *pol)
+xfrm_state_find(u32 daddr, u32 saddr, struct flowi *fl, struct xfrm_tmpl *tmpl,
+		struct xfrm_policy *pol, int *err)
 {
 	unsigned h = ntohl(daddr);
 	struct xfrm_state *x;
 	int acquire_in_progress = 0;
 	int error = 0;
+	struct xfrm_state *best = NULL;
 
 	h = (h ^ (h>>16)) % XFRM_DST_HSIZE;
 
 	spin_lock_bh(&xfrm_state_lock);
 	list_for_each_entry(x, xfrm_state_bydst+h, bydst) {
 		if (daddr == x->id.daddr.xfrm4_addr &&
+		    (saddr == x->props.saddr.xfrm4_addr || !saddr || !x->props.saddr.xfrm4_addr) &&
 		    tmpl->mode == x->props.mode &&
 		    tmpl->id.proto == x->id.proto) {
 			/* Resolution logic:
@@ -139,9 +232,11 @@
 			if (x->km.state == XFRM_STATE_VALID) {
 				if (!xfrm4_selector_match(&x->sel, fl))
 					continue;
-				atomic_inc(&x->refcnt);
-				spin_unlock_bh(&xfrm_state_lock);
-				return x;
+				if (!best ||
+				    best->km.dying > x->km.dying ||
+				    (best->km.dying == x->km.dying &&
+				     best->curlft.add_time < x->curlft.add_time))
+					best = x;
 			} else if (x->km.state == XFRM_STATE_ACQ) {
 				acquire_in_progress = 1;
 			} else if (x->km.state == XFRM_STATE_ERROR ||
@@ -152,6 +247,12 @@
 		}
 	}
 
+	if (best) {
+		atomic_inc(&best->refcnt);
+		spin_unlock_bh(&xfrm_state_lock);
+		return best;
+	}
+
 	x = NULL;
 	if (!error && !acquire_in_progress &&
 	    ((x = xfrm_state_alloc()) != NULL)) {
@@ -172,10 +273,10 @@
 		x->sel.ifindex = fl->oif;
 		x->id = tmpl->id;
 		if (x->id.daddr.xfrm4_addr == 0)
-			x->id.daddr = x->sel.daddr;
+			x->id.daddr.xfrm4_addr = daddr;
 		x->props.saddr = tmpl->saddr;
 		if (x->props.saddr.xfrm4_addr == 0)
-			x->props.saddr = x->sel.saddr;
+			x->props.saddr.xfrm4_addr = saddr;
 		x->props.mode = tmpl->mode;
 
 		if (km_query(x, tmpl, pol) == 0) {
@@ -188,6 +289,9 @@
 				list_add(&x->byspi, xfrm_state_byspi+h);
 				atomic_inc(&x->refcnt);
 			}
+			x->lft.hard_add_expires_seconds = ACQ_EXPIRES;
+			atomic_inc(&x->refcnt);
+			mod_timer(&x->timer, ACQ_EXPIRES*HZ);
 		} else {
 			x->km.state = XFRM_STATE_DEAD;
 			xfrm_state_put(x);
@@ -195,6 +299,8 @@
 		}
 	}
 	spin_unlock_bh(&xfrm_state_lock);
+	if (!x)
+		*err = acquire_in_progress ? -EAGAIN : -ENOMEM;
 	return x;
 }
 
@@ -213,26 +319,33 @@
 	list_add(&x->byspi, xfrm_state_byspi+h);
 	atomic_inc(&x->refcnt);
 
+	if (!mod_timer(&x->timer, jiffies + HZ))
+		atomic_inc(&x->refcnt);
+
 	spin_unlock_bh(&xfrm_state_lock);
 	wake_up(km_waitq);
 }
 
 int xfrm_state_check_expire(struct xfrm_state *x)
 {
+	if (!x->curlft.use_time)
+		x->curlft.use_time = (unsigned long)xtime.tv_sec;
+
 	if (x->km.state != XFRM_STATE_VALID)
 		return -EINVAL;
 
-	if (x->lft.hard_byte_limit &&
-	    x->curlft.bytes >= x->lft.hard_byte_limit) {
+	if (x->curlft.bytes >= x->lft.hard_byte_limit ||
+	    x->curlft.packets >= x->lft.hard_packet_limit) {
 		km_expired(x);
+		if (!mod_timer(&x->timer, jiffies + ACQ_EXPIRES*HZ))
+			atomic_inc(&x->refcnt);
 		return -EINVAL;
 	}
 
-	if (x->km.warn_bytes &&
-	    x->curlft.bytes >= x->km.warn_bytes) {
-		x->km.warn_bytes = 0;
+	if (!x->km.dying &&
+	    (x->curlft.bytes >= x->lft.soft_byte_limit ||
+	     x->curlft.packets >= x->lft.soft_packet_limit))
 		km_warn_expired(x);
-	}
 	return 0;
 }
 
@@ -309,6 +422,9 @@
 		x0->id.proto = proto;
 		x0->props.mode = mode;
 		x0->props.reqid = reqid;
+		x0->lft.hard_add_expires_seconds = ACQ_EXPIRES;
+		atomic_inc(&x0->refcnt);
+		mod_timer(&x0->timer, jiffies + ACQ_EXPIRES*HZ);
 		atomic_inc(&x0->refcnt);
 		list_add_tail(&x0->bydst, xfrm_state_bydst+h);
 		wake_up(km_waitq);
@@ -476,6 +592,7 @@
 {
 	struct xfrm_mgr *km;
 
+	x->km.dying = 1;
 	read_lock(&xfrm_km_lock);
 	list_for_each_entry(km, &xfrm_km_list, list)
 		km->notify(x, 0);
===== net/key/af_key.c 1.6 vs edited =====
--- 1.6/net/key/af_key.c	Thu Nov  7 04:52:11 2002
+++ edited/net/key/af_key.c	Fri Nov  8 07:17:45 2002
@@ -27,6 +27,9 @@
 
 #include <net/sock.h>
 
+#define _X2KEY(x) ((x) == XFRM_INF ? 0 : (x))
+#define _KEY2X(x) ((x) == 0 ? XFRM_INF : (x))
+
 /* List of all pfkey sockets. */
 static struct sock * pfkey_table;
 static DECLARE_WAIT_QUEUE_HEAD(pfkey_table_wait);
@@ -488,7 +491,8 @@
 	case AF_INET:
 		xaddr->xfrm4_addr = 
 			((struct sockaddr_in*)(addr + 1))->sin_addr.s_addr;
-		xaddr->xfrm4_mask = ~0 << (32 - addr->sadb_address_prefixlen);
+		if (addr->sadb_address_prefixlen)
+			xaddr->xfrm4_mask = htonl(~0 << (32 - addr->sadb_address_prefixlen));
 		break;
 	case AF_INET6:
 		memcpy(xaddr->a6, 
@@ -705,9 +709,13 @@
 	sa->sadb_sa_exttype = SADB_EXT_SA;
 	sa->sadb_sa_spi = x->id.spi;
 	sa->sadb_sa_replay = x->props.replay_window;
-	sa->sadb_sa_state = (x->km.state == XFRM_STATE_VALID ?
-			     SADB_SASTATE_MATURE :
-			     SADB_SASTATE_LARVAL);
+	sa->sadb_sa_state = SADB_SASTATE_DYING;
+	if (x->km.state == XFRM_STATE_VALID && !x->km.dying)
+		sa->sadb_sa_state = SADB_SASTATE_MATURE;
+	else if (x->km.state == XFRM_STATE_ACQ)
+		sa->sadb_sa_state = SADB_SASTATE_LARVAL;
+	else if (x->km.state == XFRM_STATE_EXPIRED)
+		sa->sadb_sa_state = SADB_SASTATE_DEAD;
 	sa->sadb_sa_auth = 0;
 	if (x->aalg) {
 		struct algo_desc *a = aalg_get_byname(x->aalg->alg_name);
@@ -727,8 +735,8 @@
 		lifetime->sadb_lifetime_len =
 			sizeof(struct sadb_lifetime)/sizeof(uint64_t);
 		lifetime->sadb_lifetime_exttype = SADB_EXT_LIFETIME_HARD;
-		lifetime->sadb_lifetime_allocations =  x->lft.hard_packet_limit;
-		lifetime->sadb_lifetime_bytes = x->lft.hard_byte_limit;	
+		lifetime->sadb_lifetime_allocations =  _X2KEY(x->lft.hard_packet_limit);
+		lifetime->sadb_lifetime_bytes = _X2KEY(x->lft.hard_byte_limit);
 		lifetime->sadb_lifetime_addtime = x->lft.hard_add_expires_seconds;
 		lifetime->sadb_lifetime_usetime = x->lft.hard_use_expires_seconds;
 	}
@@ -739,13 +747,13 @@
 		lifetime->sadb_lifetime_len =
 			sizeof(struct sadb_lifetime)/sizeof(uint64_t);
 		lifetime->sadb_lifetime_exttype = SADB_EXT_LIFETIME_SOFT;
-		lifetime->sadb_lifetime_allocations =  x->lft.soft_packet_limit;
-		lifetime->sadb_lifetime_bytes = x->lft.soft_byte_limit;
+		lifetime->sadb_lifetime_allocations =  _X2KEY(x->lft.soft_packet_limit);
+		lifetime->sadb_lifetime_bytes = _X2KEY(x->lft.soft_byte_limit);
 		lifetime->sadb_lifetime_addtime = x->lft.soft_add_expires_seconds;
 		lifetime->sadb_lifetime_usetime = x->lft.soft_use_expires_seconds;
 	}
 	/* current time */
-	lifetime = (struct sadb_lifetime *)  skb_put(skb, 
+	lifetime = (struct sadb_lifetime *)  skb_put(skb,
 						     sizeof(struct sadb_lifetime));
 	lifetime->sadb_lifetime_len =
 		sizeof(struct sadb_lifetime)/sizeof(uint64_t);
@@ -870,11 +878,19 @@
 	proto = pfkey_satype2proto(hdr->sadb_msg_satype);
 	if (proto == 0)
 		return ERR_PTR(-EINVAL);
-	/* XXX setkey set SADB_SASTATE_LARVAL here 
-	   if (hdr->sadb_msg_type == SADB_ADD && 
-	   sa->sadb_sa_state != SADB_SASTATE_MATURE) 
-	   return ERR_PTR(-EINVAL);
-	   */
+
+	/* RFC2367:
+
+   Only SADB_SASTATE_MATURE SAs may be submitted in an SADB_ADD message.
+   SADB_SASTATE_LARVAL SAs are created by SADB_GETSPI and it is not
+   sensible to add a new SA in the DYING or SADB_SASTATE_DEAD state.
+   Therefore, the sadb_sa_state field of all submitted SAs MUST be
+   SADB_SASTATE_MATURE and the kernel MUST return an error if this is
+   not true.
+
+           However, KAME setkey always uses SADB_SASTATE_LARVAL.
+	   Hence, we have to _ignore_ sadb_sa_state, which is also reasonable.
+	 */
 	if (sa->sadb_sa_auth > SADB_AALG_MAX ||
 	    sa->sadb_sa_encrypt > SADB_EALG_MAX)
 		return ERR_PTR(-EINVAL);
@@ -899,15 +915,15 @@
 
 	lifetime = (struct sadb_lifetime*) ext_hdrs[SADB_EXT_LIFETIME_HARD-1];
 	if (lifetime != NULL) {
-		x->lft.hard_packet_limit = lifetime->sadb_lifetime_allocations;
-		x->lft.hard_byte_limit = lifetime->sadb_lifetime_bytes;
+		x->lft.hard_packet_limit = _KEY2X(lifetime->sadb_lifetime_allocations);
+		x->lft.hard_byte_limit = _KEY2X(lifetime->sadb_lifetime_bytes);
 		x->lft.hard_add_expires_seconds = lifetime->sadb_lifetime_addtime;
 		x->lft.hard_use_expires_seconds = lifetime->sadb_lifetime_usetime;
 	}
 	lifetime = (struct sadb_lifetime*) ext_hdrs[SADB_EXT_LIFETIME_SOFT-1];
 	if (lifetime != NULL) {
-		x->lft.soft_packet_limit = lifetime->sadb_lifetime_allocations;
-		x->lft.soft_byte_limit = lifetime->sadb_lifetime_bytes;
+		x->lft.soft_packet_limit = _KEY2X(lifetime->sadb_lifetime_allocations);
+		x->lft.soft_byte_limit = _KEY2X(lifetime->sadb_lifetime_bytes);
 		x->lft.soft_add_expires_seconds = lifetime->sadb_lifetime_addtime;
 		x->lft.soft_use_expires_seconds = lifetime->sadb_lifetime_usetime;
 	}
@@ -952,11 +968,9 @@
 	}
 	/* x->algo.flags = sa->sadb_sa_flags; */
 
-	pfkey_sadb_addr2xfrm_addr(
-				  (struct sadb_address *) ext_hdrs[SADB_EXT_ADDRESS_SRC-1], 
+	pfkey_sadb_addr2xfrm_addr((struct sadb_address *) ext_hdrs[SADB_EXT_ADDRESS_SRC-1], 
 				  &x->props.saddr);
-	pfkey_sadb_addr2xfrm_addr(
-				  (struct sadb_address *) ext_hdrs[SADB_EXT_ADDRESS_DST-1], 
+	pfkey_sadb_addr2xfrm_addr((struct sadb_address *) ext_hdrs[SADB_EXT_ADDRESS_DST-1], 
 				  &x->id.daddr);
 
 	if (ext_hdrs[SADB_X_EXT_SA2-1]) {
@@ -967,20 +981,24 @@
 		x->props.reqid = sa2->sadb_x_sa2_reqid;
 	}
 
-	x->sel.saddr = x->props.saddr;
-	x->sel.daddr = x->id.daddr;
+	if (ext_hdrs[SADB_EXT_ADDRESS_PROXY-1]) {
+		struct sadb_address *addr = ext_hdrs[SADB_EXT_ADDRESS_PROXY-1];
+
+		/* Nobody uses this, but we try. */
+		pfkey_sadb_addr2xfrm_addr(addr, &x->sel.saddr);
+		x->sel.prefixlen_s = addr->sadb_address_prefixlen;
+	}
+
 	x->type = xfrm_get_type(proto);
 	if (x->type == NULL)
 		goto out;
 	if (x->type->init_state(x, NULL))
 		goto out;
-	x->curlft.add_time = (unsigned long)xtime.tv_sec;
-	x->km.warn_bytes = x->lft.soft_byte_limit;
 	x->km.seq = hdr->sadb_msg_seq;
 	x->km.state = XFRM_STATE_VALID;
 	return x;
 
-	out:
+out:
 	if (x->aalg)
 		kfree(x->aalg);
 	if (x->ealg)
@@ -1247,7 +1265,7 @@
 			*ap++ = ealg_list[i].desc;
 	}
 
-	out_put_algs:
+out_put_algs:
 	return skb;
 }
 
@@ -1375,7 +1393,8 @@
 
 	t->id.proto = rq->sadb_x_ipsecrequest_proto; /* XXX check proto */
 	t->mode = rq->sadb_x_ipsecrequest_mode-1;
-	t->share = rq->sadb_x_ipsecrequest_level;
+	if (rq->sadb_x_ipsecrequest_level == IPSEC_LEVEL_USE)
+		t->optional = 1;
 	t->reqid = rq->sadb_x_ipsecrequest_reqid;
 	/* addresses present only in tunnel mode */
 	if (t->mode) {
@@ -1471,8 +1490,8 @@
 	lifetime->sadb_lifetime_len =
 		sizeof(struct sadb_lifetime)/sizeof(uint64_t);
 	lifetime->sadb_lifetime_exttype = SADB_EXT_LIFETIME_HARD;
-	lifetime->sadb_lifetime_allocations =  xp->lft.hard_packet_limit;
-	lifetime->sadb_lifetime_bytes = xp->lft.hard_byte_limit;
+	lifetime->sadb_lifetime_allocations =  _X2KEY(xp->lft.hard_packet_limit);
+	lifetime->sadb_lifetime_bytes = _X2KEY(xp->lft.hard_byte_limit);
 	lifetime->sadb_lifetime_addtime = xp->lft.hard_add_expires_seconds;
 	lifetime->sadb_lifetime_usetime = xp->lft.hard_use_expires_seconds;
 	/* soft time */
@@ -1481,8 +1500,8 @@
 	lifetime->sadb_lifetime_len =
 		sizeof(struct sadb_lifetime)/sizeof(uint64_t);
 	lifetime->sadb_lifetime_exttype = SADB_EXT_LIFETIME_SOFT;
-	lifetime->sadb_lifetime_allocations =  xp->lft.soft_packet_limit;
-	lifetime->sadb_lifetime_bytes = xp->lft.soft_byte_limit;
+	lifetime->sadb_lifetime_allocations =  _X2KEY(xp->lft.soft_packet_limit);
+	lifetime->sadb_lifetime_bytes = _X2KEY(xp->lft.soft_byte_limit);
 	lifetime->sadb_lifetime_addtime = xp->lft.soft_add_expires_seconds;
 	lifetime->sadb_lifetime_usetime = xp->lft.soft_use_expires_seconds;
 	/* current time */
@@ -1524,7 +1543,9 @@
 		rq->sadb_x_ipsecrequest_len = req_size;
 		rq->sadb_x_ipsecrequest_proto = t->id.proto;
 		rq->sadb_x_ipsecrequest_mode = t->mode+1;
-		rq->sadb_x_ipsecrequest_level = t->share;
+		rq->sadb_x_ipsecrequest_level = IPSEC_LEVEL_REQUIRE;
+		if (t->optional)
+			rq->sadb_x_ipsecrequest_level = IPSEC_LEVEL_USE;
 		rq->sadb_x_ipsecrequest_reqid = t->reqid;
 		if (t->mode) {
 			sin = (void*)(rq+1);
@@ -1565,7 +1586,7 @@
 	if (!pol->sadb_x_policy_dir || pol->sadb_x_policy_dir >= IPSEC_DIR_MAX)
 		return -EINVAL;
 
-	xp = xfrm_policy_alloc();
+	xp = xfrm_policy_alloc(GFP_KERNEL);
 	if (xp == NULL)
 		return -ENOBUFS;
 
@@ -1594,25 +1615,19 @@
 	if (xp->selector.dport)
 		xp->selector.dport_mask = ~0;
 
-	xp->curlft.add_time = (unsigned long)xtime.tv_sec;
-	xp->curlft.use_time = (unsigned long)xtime.tv_sec;
-	xp->lft.soft_byte_limit = -1;
-	xp->lft.hard_byte_limit = -1;
-	xp->lft.soft_packet_limit = -1;
-	xp->lft.hard_packet_limit = -1;
-	xp->lft.soft_add_expires_seconds = -1;
-	xp->lft.hard_add_expires_seconds = -1;
-	xp->lft.soft_use_expires_seconds = -1;
-	xp->lft.hard_use_expires_seconds = -1;
+	xp->lft.soft_byte_limit = XFRM_INF;
+	xp->lft.hard_byte_limit = XFRM_INF;
+	xp->lft.soft_packet_limit = XFRM_INF;
+	xp->lft.hard_packet_limit = XFRM_INF;
 	if ((lifetime = ext_hdrs[SADB_EXT_LIFETIME_HARD-1]) != NULL) {
-		xp->lft.hard_packet_limit = lifetime->sadb_lifetime_allocations;
-		xp->lft.hard_byte_limit = lifetime->sadb_lifetime_bytes;
+		xp->lft.hard_packet_limit = _KEY2X(lifetime->sadb_lifetime_allocations);
+		xp->lft.hard_byte_limit = _KEY2X(lifetime->sadb_lifetime_bytes);
 		xp->lft.hard_add_expires_seconds = lifetime->sadb_lifetime_addtime;
 		xp->lft.hard_use_expires_seconds = lifetime->sadb_lifetime_usetime;
 	}
 	if ((lifetime = ext_hdrs[SADB_EXT_LIFETIME_SOFT-1]) != NULL) {
-		xp->lft.soft_packet_limit = lifetime->sadb_lifetime_allocations;
-		xp->lft.soft_byte_limit = lifetime->sadb_lifetime_bytes;
+		xp->lft.soft_packet_limit = _KEY2X(lifetime->sadb_lifetime_allocations);
+		xp->lft.soft_byte_limit = _KEY2X(lifetime->sadb_lifetime_bytes);
 		xp->lft.soft_add_expires_seconds = lifetime->sadb_lifetime_addtime;
 		xp->lft.soft_use_expires_seconds = lifetime->sadb_lifetime_usetime;
 	}
@@ -1710,7 +1725,7 @@
 	pfkey_broadcast(out_skb, GFP_ATOMIC, BROADCAST_ALL, sk);
 	err = 0;
 
-	out:
+out:
 	if (xp) {
 		xfrm_policy_kill(xp);
 		xfrm_pol_put(xp);
@@ -1756,7 +1771,7 @@
 	pfkey_broadcast(out_skb, GFP_ATOMIC, BROADCAST_ALL, sk);
 	err = 0;
 
-	out:
+out:
 	if (xp) {
 		if (hdr->sadb_msg_type == SADB_X_SPDDELETE2)
 			xfrm_policy_kill(xp);
@@ -2098,7 +2113,7 @@
 	    (!pol->sadb_x_policy_dir || pol->sadb_x_policy_dir > IPSEC_DIR_OUTBOUND))
 		return NULL;
 
-	xp = xfrm_policy_alloc();
+	xp = xfrm_policy_alloc(GFP_KERNEL);
 	if (xp == NULL) {
 		*dir = -ENOBUFS;
 		return NULL;
@@ -2108,16 +2123,10 @@
 	xp->action = (pol->sadb_x_policy_type == IPSEC_POLICY_DISCARD ?
 		      XFRM_POLICY_BLOCK : XFRM_POLICY_ALLOW);
 
-	xp->curlft.add_time = (unsigned long)xtime.tv_sec;
-	xp->curlft.use_time = (unsigned long)xtime.tv_sec;
-	xp->lft.soft_byte_limit = -1;
-	xp->lft.hard_byte_limit = -1;
-	xp->lft.soft_packet_limit = -1;
-	xp->lft.hard_packet_limit = -1;
-	xp->lft.soft_add_expires_seconds = -1;
-	xp->lft.hard_add_expires_seconds = -1;
-	xp->lft.soft_use_expires_seconds = -1;
-	xp->lft.hard_use_expires_seconds = -1;
+	xp->lft.soft_byte_limit = XFRM_INF;
+	xp->lft.hard_byte_limit = XFRM_INF;
+	xp->lft.soft_packet_limit = XFRM_INF;
+	xp->lft.hard_packet_limit = XFRM_INF;
 
 	xp->xfrm_nr = 0;
 	if (pol->sadb_x_policy_type == IPSEC_POLICY_IPSEC &&
