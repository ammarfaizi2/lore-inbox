Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265361AbSKGJo5>; Thu, 7 Nov 2002 04:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266036AbSKGJo5>; Thu, 7 Nov 2002 04:44:57 -0500
Received: from pizda.ninka.net ([216.101.162.242]:3479 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265361AbSKGJoV> convert rfc822-to-8bit;
	Thu, 7 Nov 2002 04:44:21 -0500
Date: Thu, 07 Nov 2002 01:49:53 -0800 (PST)
Message-Id: <20021107.014953.58440275.davem@redhat.com>
To: ahu@ds9a.nl
Cc: randy.dunlap@verizon.net, linux-kernel@vger.kernel.org
Subject: Re: Silly advise in bridge Configure help
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021107091822.GA21030@outpost.ds9a.nl>
References: <3DC9EA2A.142559AA@verizon.net>
	<20021107.011526.120464470.davem@redhat.com>
	<20021107091822.GA21030@outpost.ds9a.nl>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: bert hubert <ahu@ds9a.nl>
   Date: Thu, 7 Nov 2002 10:18:22 +0100
   
   The one by Lennert is lots better. Dave, I'm about to explode with IPSEC
   anxiety, any hints on where we stand? Should I start looking at Racoon yet
   :-)

If you take Linus's current BK tree, and apply the patch below, you
can begin trying to use the racoon and other KAME tools that we
'ported' at:

	ftp://ftp.inr.ac.ru/ip-routing/ipsec/

I'll be sending this set of changes to him tonight.

Have fun :-)

ChangeSet@1.925.5.1, 2002-11-06 17:20:44-08:00, kuznet@ms2.inr.ac.ru
  [IPSEC]: Semantic fixes with help from Maxim Giryaev.
  - BSD apps want sin_zero cleared in sys_getname.
  - Fix protocol setting in flow descriptor of RAW sockets
  - Wildcard protocol is represented differently in policy
  than for association.
  - Missing update of key manager sequence in xfrm_state entries.

diff -Nru a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
--- a/net/ipv4/af_inet.c	Thu Nov  7 01:49:03 2002
+++ b/net/ipv4/af_inet.c	Thu Nov  7 01:49:03 2002
@@ -722,6 +722,7 @@
 		sin->sin_port = inet->sport;
 		sin->sin_addr.s_addr = addr;
 	}
+	memset(sin->sin_zero, 0, sizeof(sin->sin_zero));
 	*uaddr_len = sizeof(*sin);
 	return 0;
 }
diff -Nru a/net/ipv4/raw.c b/net/ipv4/raw.c
--- a/net/ipv4/raw.c	Thu Nov  7 01:49:03 2002
+++ b/net/ipv4/raw.c	Thu Nov  7 01:49:03 2002
@@ -430,7 +430,7 @@
 					      { .daddr = daddr,
 						.saddr = saddr,
 						.tos = tos } },
-				    .proto = IPPROTO_RAW };
+				    .proto = inet->hdrincl ? IPPROTO_RAW : sk->protocol };
 		err = ip_route_output_flow(&rt, &fl, sk, msg->msg_flags&MSG_DONTWAIT);
 	}
 	if (err)
diff -Nru a/net/ipv4/xfrm_state.c b/net/ipv4/xfrm_state.c
--- a/net/ipv4/xfrm_state.c	Thu Nov  7 01:49:03 2002
+++ b/net/ipv4/xfrm_state.c	Thu Nov  7 01:49:03 2002
@@ -1,5 +1,6 @@
 #include <net/xfrm.h>
 #include <linux/pfkeyv2.h>
+#include <linux/ipsec.h>
 
 /* Each xfrm_state is linked to three tables:
 
@@ -91,7 +92,7 @@
 	for (i = 0; i < XFRM_DST_HSIZE; i++) {
 restart:
 		list_for_each_entry(x, xfrm_state_bydst+i, bydst) {
-			if (!proto || x->id.proto == proto) {
+			if (proto == IPSEC_PROTO_ANY || x->id.proto == proto) {
 				atomic_inc(&x->refcnt);
 				spin_unlock_bh(&xfrm_state_lock);
 
@@ -389,7 +390,7 @@
 	spin_lock_bh(&xfrm_state_lock);
 	for (i = 0; i < XFRM_DST_HSIZE; i++) {
 		list_for_each_entry(x, xfrm_state_bydst+i, bydst) {
-			if (proto == 255 || x->id.proto == proto)
+			if (proto == IPSEC_PROTO_ANY || x->id.proto == proto)
 				count++;
 		}
 	}
@@ -400,7 +401,7 @@
 
 	for (i = 0; i < XFRM_DST_HSIZE; i++) {
 		list_for_each_entry(x, xfrm_state_bydst+i, bydst) {
-			if (proto != 255 && x->id.proto != proto)
+			if (proto != IPSEC_PROTO_ANY && x->id.proto != proto)
 				continue;
 			err = func(x, --count, data);
 			if (err)
diff -Nru a/net/key/af_key.c b/net/key/af_key.c
--- a/net/key/af_key.c	Thu Nov  7 01:49:03 2002
+++ b/net/key/af_key.c	Thu Nov  7 01:49:03 2002
@@ -759,7 +759,10 @@
 		(sizeof(struct sadb_address)+sizeof(struct sockaddr_in))/
 			sizeof(uint64_t);
 	addr->sadb_address_exttype = SADB_EXT_ADDRESS_SRC;
-	addr->sadb_address_proto = 0; /* XXX IPSEC_PROTO_ANY ?? */
+	/* "if the ports are non-zero, then the sadb_address_proto field, 
+	   normally zero, MUST be filled in with the transport 
+	   protocol's number." - RFC2367 */
+	addr->sadb_address_proto = 0; 
 	addr->sadb_address_prefixlen = 32; /* XXX */ 
 	addr->sadb_address_reserved = 0;
 	((struct sockaddr_in*)(addr + 1))->sin_family = AF_INET;
@@ -772,7 +775,7 @@
 		(sizeof(struct sadb_address)+sizeof(struct sockaddr_in))/
 			sizeof(uint64_t);
 	addr->sadb_address_exttype = SADB_EXT_ADDRESS_DST;
-	addr->sadb_address_proto = 0; /* XXX IPSEC_PROTO_ANY ?? */
+	addr->sadb_address_proto = 0; 
 	addr->sadb_address_prefixlen = 32; /* XXX */ 
 	addr->sadb_address_reserved = 0;
 	((struct sockaddr_in*)(addr + 1))->sin_family = AF_INET;
@@ -971,6 +974,7 @@
 		goto out;
 	x->curlft.add_time = (unsigned long)xtime.tv_sec;
 	x->km.warn_bytes = x->lft.soft_byte_limit;
+	x->km.seq = hdr->sadb_msg_seq;
 	x->km.state = XFRM_STATE_VALID;
 	return x;
 
@@ -1001,15 +1005,14 @@
 	u8 proto;
 
 	if (!present_and_same_family(ext_hdrs[SADB_EXT_ADDRESS_SRC-1],
-				     ext_hdrs[SADB_EXT_ADDRESS_DST-1]) ||
-	    !ext_hdrs[SADB_EXT_SPIRANGE-1])
+				     ext_hdrs[SADB_EXT_ADDRESS_DST-1]))
 		return -EINVAL;
 
 	proto = pfkey_satype2proto(hdr->sadb_msg_satype);
 	if (proto == 0)
 		return -EINVAL;
 
-	if ((sa2 = ext_hdrs[SADB_X_EXT_SA2]) != NULL) {
+	if ((sa2 = ext_hdrs[SADB_X_EXT_SA2-1]) != NULL) {
 		mode = sa2->sadb_x_sa2_mode - 1;
 		reqid = sa2->sadb_x_sa2_reqid;
 	} else {
@@ -1017,9 +1020,9 @@
 		reqid = 0;
 	}
 
-	addr = ext_hdrs[SADB_EXT_ADDRESS_SRC];
+	addr = ext_hdrs[SADB_EXT_ADDRESS_SRC-1];
 	saddr = (struct sockaddr_in*)(addr + 1);
-	addr = ext_hdrs[SADB_EXT_ADDRESS_DST];
+	addr = ext_hdrs[SADB_EXT_ADDRESS_DST-1];
 	daddr = (struct sockaddr_in*)(addr + 1);
 
 	x = xfrm_find_acq(mode, reqid, proto, daddr->sin_addr.s_addr,
@@ -1027,12 +1030,21 @@
 	if (x == NULL)
 		return -ENOENT;
 
-	resp_skb = NULL;
+	resp_skb = ERR_PTR(-ENOENT);
 
 	spin_lock_bh(&x->lock);
 	if (x->km.state != XFRM_STATE_DEAD) {
-		struct sadb_spirange *range = ext_hdrs[SADB_EXT_SPIRANGE];
-		xfrm_alloc_spi(x, range->sadb_spirange_min, range->sadb_spirange_max);
+		struct sadb_spirange *range = ext_hdrs[SADB_EXT_SPIRANGE-1];
+		u32 min_spi, max_spi;
+
+		if (range != NULL) {
+			min_spi = range->sadb_spirange_min;
+			max_spi = range->sadb_spirange_max;
+		} else {
+			min_spi = htonl(0x100);
+			max_spi = htonl(0x0fffffff);
+		}
+		xfrm_alloc_spi(x, min_spi, max_spi);
 		if (x->id.spi)
 			resp_skb = pfkey_xfrm_state2msg(x, 0, 3);
 	}
@@ -1113,7 +1125,7 @@
 
 	out_hdr = (struct sadb_msg *) out_skb->data;
 	out_hdr->sadb_msg_version = hdr->sadb_msg_version;
-	out_hdr->sadb_msg_type = SADB_ADD;
+	out_hdr->sadb_msg_type = hdr->sadb_msg_type;
 	out_hdr->sadb_msg_satype = pfkey_proto2satype(x->id.proto);
 	out_hdr->sadb_msg_errno = 0;
 	out_hdr->sadb_msg_reserved = 0;
@@ -1359,14 +1371,17 @@
 	if (rq->sadb_x_ipsecrequest_mode == 0)
 		return -EINVAL;
 
-	t->id.proto = rq->sadb_x_ipsecrequest_proto;
+	t->id.proto = rq->sadb_x_ipsecrequest_proto; /* XXX check proto */
 	t->mode = rq->sadb_x_ipsecrequest_mode-1;
 	t->share = rq->sadb_x_ipsecrequest_level;
 	t->reqid = rq->sadb_x_ipsecrequest_reqid;
-	addr = (void*)(rq+1);
-	t->saddr.xfrm4_addr = addr->sin_addr.s_addr;
-	addr++;
-	t->id.daddr.xfrm4_addr = addr->sin_addr.s_addr;
+	/* addresses present only in tunnel mode */
+	if (t->mode) {
+		addr = (void*)(rq+1);
+		t->saddr.xfrm4_addr = addr->sin_addr.s_addr;
+		addr++;
+		t->id.daddr.xfrm4_addr = addr->sin_addr.s_addr;
+	}
 	/* No way to set this via kame pfkey */
 	t->aalgos = t->ealgos = t->calgos = ~0;
 	xp->xfrm_nr++;
@@ -1396,6 +1411,7 @@
 	struct sadb_address *addr;
 	struct sadb_lifetime *lifetime;
 	struct sadb_x_policy *pol;
+	struct sockaddr_in   *sin;
 	int i;
 	int size;
 
@@ -1414,7 +1430,6 @@
 	/* call should fill header later */
 	hdr = (struct sadb_msg *) skb_put(skb, sizeof(struct sadb_msg));
 	memset(hdr, 0, size);	/* XXX do we need this ? */
-	hdr->sadb_msg_len = size / sizeof(uint64_t);
 
 	/* src address */
 	addr = (struct sadb_address*) skb_put(skb, 
@@ -1426,11 +1441,12 @@
 	addr->sadb_address_proto = pfkey_proto_from_xfrm(xp->selector.proto);
 	addr->sadb_address_prefixlen = xp->selector.prefixlen_s;
 	addr->sadb_address_reserved = 0;
-	((struct sockaddr_in*)(addr + 1))->sin_family = AF_INET;
-	((struct sockaddr_in*)(addr + 1))->sin_addr.s_addr = 
-		xp->selector.saddr.xfrm4_addr;
-	((struct sockaddr_in*)(addr + 1))->sin_port =
-		xp->selector.sport;
+	/* src address */
+	sin = (struct sockaddr_in*)(addr + 1);
+	sin->sin_family = AF_INET;
+	sin->sin_addr.s_addr = xp->selector.saddr.xfrm4_addr;
+	sin->sin_port = xp->selector.sport;
+	memset(sin->sin_zero, 0, sizeof(sin->sin_zero));
 	/* dst address */
 	addr = (struct sadb_address*) skb_put(skb, 
 					      sizeof(struct sadb_address)+sizeof(struct sockaddr_in));
@@ -1441,11 +1457,11 @@
 	addr->sadb_address_proto = pfkey_proto_from_xfrm(xp->selector.proto);
 	addr->sadb_address_prefixlen = xp->selector.prefixlen_d; 
 	addr->sadb_address_reserved = 0;
-	((struct sockaddr_in*)(addr + 1))->sin_family = AF_INET;
-	((struct sockaddr_in*)(addr + 1))->sin_addr.s_addr = 
-		xp->selector.daddr.xfrm4_addr;
-	((struct sockaddr_in*)(addr + 1))->sin_port =
-		xp->selector.dport;
+	sin = (struct sockaddr_in*)(addr + 1);
+	sin->sin_family = AF_INET;
+	sin->sin_addr.s_addr = xp->selector.daddr.xfrm4_addr;
+	sin->sin_port = xp->selector.dport;
+	memset(sin->sin_zero, 0, sizeof(sin->sin_zero));
 
 	/* hard time */
 	lifetime = (struct sadb_lifetime *)  skb_put(skb, 
@@ -1494,25 +1510,34 @@
 	for (i=0; i<xp->xfrm_nr; i++) {
 		struct sadb_x_ipsecrequest *rq;
 		struct xfrm_tmpl *t = xp->xfrm_vec + i;
-		struct sockaddr_in *addr;
+		int req_size;
 
-		size = sizeof(struct sadb_x_ipsecrequest)+2*sizeof(struct sockaddr_in);
-		rq = (void*)skb_put(skb, size);
-		pol->sadb_x_policy_len += size/8;
-		rq->sadb_x_ipsecrequest_len = size;
+		req_size = sizeof(struct sadb_x_ipsecrequest);
+		if (t->mode)
+			req_size += 2*sizeof(struct sockaddr_in);
+		else 
+			size -= 2*sizeof(struct sockaddr_in);
+		rq = (void*)skb_put(skb, req_size);
+		pol->sadb_x_policy_len += req_size/8;
+		rq->sadb_x_ipsecrequest_len = req_size;
 		rq->sadb_x_ipsecrequest_proto = t->id.proto;
 		rq->sadb_x_ipsecrequest_mode = t->mode+1;
 		rq->sadb_x_ipsecrequest_level = t->share;
 		rq->sadb_x_ipsecrequest_reqid = t->reqid;
-		addr = (void*)(rq+1);
-		addr->sin_family = AF_INET;
-		addr->sin_addr.s_addr = t->saddr.xfrm4_addr;
-		addr->sin_port = 0;
-		addr++;
-		addr->sin_family = AF_INET;
-		addr->sin_addr.s_addr = t->id.daddr.xfrm4_addr;
-		addr->sin_port = 0;
+		if (t->mode) {
+			sin = (void*)(rq+1);
+			sin->sin_family = AF_INET;
+			sin->sin_addr.s_addr = t->saddr.xfrm4_addr;
+			sin->sin_port = 0;
+			memset(sin->sin_zero, 0, sizeof(sin->sin_zero));
+			sin++;
+			sin->sin_family = AF_INET;
+			sin->sin_addr.s_addr = t->id.daddr.xfrm4_addr;
+			sin->sin_port = 0;
+			memset(sin->sin_zero, 0, sizeof(sin->sin_zero));
+		}
 	}
+	hdr->sadb_msg_len = size / sizeof(uint64_t);
 	return skb;
 }
 
@@ -2015,7 +2040,7 @@
 		(sizeof(struct sadb_address)+sizeof(struct sockaddr_in))/
 			sizeof(uint64_t);
 	addr->sadb_address_exttype = SADB_EXT_ADDRESS_SRC;
-	addr->sadb_address_proto = 0; /* XXX IPSEC_PROTO_ANY ?? */
+	addr->sadb_address_proto = 0;
 	addr->sadb_address_prefixlen = 32;
 	addr->sadb_address_reserved = 0;
 	((struct sockaddr_in*)(addr + 1))->sin_family = AF_INET;
@@ -2030,7 +2055,7 @@
 		(sizeof(struct sadb_address)+sizeof(struct sockaddr_in))/
 			sizeof(uint64_t);
 	addr->sadb_address_exttype = SADB_EXT_ADDRESS_DST;
-	addr->sadb_address_proto = 0; /* XXX IPSEC_PROTO_ANY ?? */
+	addr->sadb_address_proto = 0;
 	addr->sadb_address_prefixlen = 32; 
 	addr->sadb_address_reserved = 0;
 	((struct sockaddr_in*)(addr + 1))->sin_family = AF_INET;


ChangeSet@1.925.5.2, 2002-11-06 17:28:07-08:00, akpm@digeo.com
  [NET]: Timer init fixes.

diff -Nru a/net/ax25/ax25_dev.c b/net/ax25/ax25_dev.c
--- a/net/ax25/ax25_dev.c	Thu Nov  7 01:49:05 2002
+++ b/net/ax25/ax25_dev.c	Thu Nov  7 01:49:05 2002
@@ -98,6 +98,10 @@
 	ax25_dev->values[AX25_VALUES_PROTOCOL]  = AX25_DEF_PROTOCOL;
 	ax25_dev->values[AX25_VALUES_DS_TIMEOUT]= AX25_DEF_DS_TIMEOUT;
 
+#if defined(CONFIG_AX25_DAMA_SLAVE) || defined(CONFIG_AX25_DAMA_MASTER)
+	init_timer(&ax25_dev->dama.slave_timer);
+#endif
+
 	spin_lock_bh(&ax25_dev_lock);
 	ax25_dev->next = ax25_dev_list;
 	ax25_dev_list  = ax25_dev;
diff -Nru a/net/bridge/br_if.c b/net/bridge/br_if.c
--- a/net/bridge/br_if.c	Thu Nov  7 01:49:05 2002
+++ b/net/bridge/br_if.c	Thu Nov  7 01:49:05 2002
@@ -106,6 +106,8 @@
 	memset(br, 0, sizeof(*br));
 	dev = &br->dev;
 
+	init_timer(&br->tick);
+
 	strncpy(dev->name, name, IFNAMSIZ);
 	dev->priv = br;
 	ether_setup(dev);
diff -Nru a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c	Thu Nov  7 01:49:05 2002
+++ b/net/core/dev.c	Thu Nov  7 01:49:05 2002
@@ -172,7 +172,7 @@
 
 #ifdef OFFLINE_SAMPLE
 static void sample_queue(unsigned long dummy);
-static struct timer_list samp_timer = { function: sample_queue };
+static struct timer_list samp_timer = TIMER_INITIALIZER(sample_queue, 0, 0);
 #endif
 
 #ifdef CONFIG_HOTPLUG
diff -Nru a/net/core/dst.c b/net/core/dst.c
--- a/net/core/dst.c	Thu Nov  7 01:49:05 2002
+++ b/net/core/dst.c	Thu Nov  7 01:49:05 2002
@@ -39,7 +39,7 @@
 static void ___dst_free(struct dst_entry * dst);
 
 static struct timer_list dst_gc_timer =
-	{ data: DST_GC_MIN, function: dst_run_gc };
+	TIMER_INITIALIZER(dst_run_gc, 0, DST_GC_MIN);
 
 static void dst_run_gc(unsigned long dummy)
 {
diff -Nru a/net/core/profile.c b/net/core/profile.c
--- a/net/core/profile.c	Thu Nov  7 01:49:05 2002
+++ b/net/core/profile.c	Thu Nov  7 01:49:05 2002
@@ -34,8 +34,7 @@
 
 static void alpha_tick(unsigned long);
 
-static struct timer_list alpha_timer =
-	{ .function = alpha_tick };
+static struct timer_list alpha_timer = TIMER_INITIALIZER(alpha_tick, 0, 0);
 
 void alpha_tick(unsigned long dummy)
 {
@@ -158,7 +157,7 @@
 int whitehole_init(struct net_device *dev);
 
 static struct timer_list whitehole_timer =
-	{ .function = whitehole_inject };
+		TIMER_INITIALIZER(whitehole_inject, 0, 0);
 
 static struct net_device whitehole_dev = {
 	"whitehole", 0x0, 0x0, 0x0, 0x0, 0, 0, 0, 0, 0, NULL, whitehole_init, };
diff -Nru a/net/decnet/dn_route.c b/net/decnet/dn_route.c
--- a/net/decnet/dn_route.c	Thu Nov  7 01:49:05 2002
+++ b/net/decnet/dn_route.c	Thu Nov  7 01:49:05 2002
@@ -109,7 +109,8 @@
 static unsigned dn_rt_hash_mask;
 
 static struct timer_list dn_route_timer;
-static struct timer_list dn_rt_flush_timer = { .function = dn_run_flush };
+static struct timer_list dn_rt_flush_timer =
+		TIMER_INITIALIZER(dn_run_flush, 0, 0);
 int decnet_dst_gc_interval = 2;
 
 static struct dst_ops dn_dst_ops = {
@@ -1260,6 +1261,7 @@
 	if (!dn_dst_ops.kmem_cachep)
 		panic("DECnet: Failed to allocate dn_dst_cache\n");
 
+	init_timer(&dn_route_timer);
 	dn_route_timer.function = dn_dst_check_expire;
 	dn_route_timer.expires = jiffies + decnet_dst_gc_interval * HZ;
 	add_timer(&dn_route_timer);
diff -Nru a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
--- a/net/ipv6/addrconf.c	Thu Nov  7 01:49:05 2002
+++ b/net/ipv6/addrconf.c	Thu Nov  7 01:49:05 2002
@@ -94,7 +94,8 @@
 
 static void addrconf_verify(unsigned long);
 
-static struct timer_list addr_chk_timer = { .function = addrconf_verify };
+static struct timer_list addr_chk_timer =
+			TIMER_INITIALIZER(addrconf_verify, 0, 0);
 static spinlock_t addrconf_verify_lock = SPIN_LOCK_UNLOCKED;
 
 static int addrconf_ifdown(struct net_device *dev, int how);
diff -Nru a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
--- a/net/ipv6/ip6_fib.c	Thu Nov  7 01:49:05 2002
+++ b/net/ipv6/ip6_fib.c	Thu Nov  7 01:49:05 2002
@@ -93,7 +93,7 @@
 
 static __u32	rt_sernum	= 0;
 
-static struct timer_list ip6_fib_timer = { .function = fib6_run_gc };
+static struct timer_list ip6_fib_timer = TIMER_INITIALIZER(fib6_run_gc, 0, 0);
 
 static struct fib6_walker_t fib6_walker_list = {
 	&fib6_walker_list, &fib6_walker_list, 
diff -Nru a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
--- a/net/ipv6/reassembly.c	Thu Nov  7 01:49:05 2002
+++ b/net/ipv6/reassembly.c	Thu Nov  7 01:49:05 2002
@@ -314,7 +314,7 @@
 	ipv6_addr_copy(&fq->saddr, src);
 	ipv6_addr_copy(&fq->daddr, dst);
 
-	/* init_timer has been done by the memset */
+	init_timer(&fq->timer);
 	fq->timer.function = ip6_frag_expire;
 	fq->timer.data = (long) fq;
 	fq->lock = SPIN_LOCK_UNLOCKED;
diff -Nru a/net/sched/sch_api.c b/net/sched/sch_api.c
--- a/net/sched/sch_api.c	Thu Nov  7 01:49:05 2002
+++ b/net/sched/sch_api.c	Thu Nov  7 01:49:05 2002
@@ -1105,8 +1105,7 @@
 
 static void psched_tick(unsigned long);
 
-static struct timer_list psched_timer =
-	{ function: psched_tick };
+static struct timer_list psched_timer = TIMER_INITIALIZER(psched_tick, 0, 0);
 
 static void psched_tick(unsigned long dummy)
 {
diff -Nru a/net/wanrouter/af_wanpipe.c b/net/wanrouter/af_wanpipe.c
--- a/net/wanrouter/af_wanpipe.c	Thu Nov  7 01:49:05 2002
+++ b/net/wanrouter/af_wanpipe.c	Thu Nov  7 01:49:05 2002
@@ -512,6 +512,7 @@
 
 	/* Use timer to send data to the driver. This will act
          * as a BH handler for sendmsg functions */
+	init_timer(&wan_opt->tx_timer);
 	wan_opt->tx_timer.data	   = (unsigned long)sk;
 	wan_opt->tx_timer.function = wanpipe_delayed_transmit;
 


ChangeSet@1.925.5.3, 2002-11-06 17:46:12-08:00, jmorris@intercode.com.au
  [CRYPTO]: Add SHA256 plus bug fixes.
  - Bugfix in sha1 copyright
  - Add support for SHA256, test vectors and HMAC test vectors
  - Remove obsolete atomic messages.

diff -Nru a/crypto/Kconfig b/crypto/Kconfig
--- a/crypto/Kconfig	Thu Nov  7 01:49:07 2002
+++ b/crypto/Kconfig	Thu Nov  7 01:49:07 2002
@@ -29,10 +29,21 @@
 	  MD5 message digest algorithm (RFC1321).
 
 config CRYPTO_SHA1
-	tristate "SHA-1 digest algorithm"
+	tristate "SHA1 digest algorithm"
 	depends on CRYPTO
 	help
 	  SHA-1 secure hash standard (FIPS 180-1).
+
+config CRYPTO_SHA256
+	tristate "SHA256 digest algorithm"
+	depends on CRYPTO
+	help
+	  SHA256 secure hash standard.
+	  
+	  This version of SHA implements a 256 bit hash with 128 bits of
+	  security against collision attacks.  It is described in:
+	  http://csrc.nist.gov/cryptval/shs/sha256-384-512.pdf
+	  
 
 config CRYPTO_DES
 	tristate "DES and Triple DES EDE cipher algorithms"
diff -Nru a/crypto/Makefile b/crypto/Makefile
--- a/crypto/Makefile	Thu Nov  7 01:49:07 2002
+++ b/crypto/Makefile	Thu Nov  7 01:49:07 2002
@@ -12,6 +12,7 @@
 obj-$(CONFIG_CRYPTO_MD4) += md4.o
 obj-$(CONFIG_CRYPTO_MD5) += md5.o
 obj-$(CONFIG_CRYPTO_SHA1) += sha1.o
+obj-$(CONFIG_CRYPTO_SHA256) += sha256.o
 obj-$(CONFIG_CRYPTO_DES) += des.o
 
 obj-$(CONFIG_CRYPTO_TEST) += tcrypt.o
diff -Nru a/crypto/sha1.c b/crypto/sha1.c
--- a/crypto/sha1.c	Thu Nov  7 01:49:07 2002
+++ b/crypto/sha1.c	Thu Nov  7 01:49:07 2002
@@ -8,7 +8,7 @@
  * implementation written by Steve Raid.
  *
  * Copyright (c) Alan Smithee.
- * Copyright (c) McDonald <andrew@mcdonald.org.uk>
+ * Copyright (c) Andrew McDonald <andrew@mcdonald.org.uk>
  * Copyright (c) Jean-Francois Dive <jef@linuxbe.org>
  *
  * This program is free software; you can redistribute it and/or modify it
diff -Nru a/crypto/tcrypt.c b/crypto/tcrypt.c
--- a/crypto/tcrypt.c	Thu Nov  7 01:49:07 2002
+++ b/crypto/tcrypt.c	Thu Nov  7 01:49:07 2002
@@ -46,7 +46,10 @@
 static char *xbuf;
 static char *tvmem;
 
-static char *check[] = { "des", "md5", "des3_ede", "rot13", "sha1", NULL };
+static char *check[] = {
+	"des", "md5", "des3_ede", "rot13", "sha1", "sha256",
+	 NULL
+};
 
 static void
 hexdump(unsigned char *buf, unsigned int len)
@@ -289,6 +292,66 @@
 out:
 	crypto_free_tfm(tfm);
 }
+
+static void
+test_hmac_sha256(void)
+{
+	char *p;
+	unsigned int i, klen;
+	struct crypto_tfm *tfm;
+	struct hmac_sha256_testvec *hmac_sha256_tv;
+	struct scatterlist sg[2];
+	unsigned int tsize;
+	char result[SHA256_DIGEST_SIZE];
+
+	tfm = crypto_alloc_tfm("sha256", 0);
+	if (tfm == NULL) {
+		printk("failed to load transform for sha256\n");
+		return;
+	}
+
+	printk("\ntesting hmac_sha256\n");
+
+	tsize = sizeof (hmac_sha256_tv_template);
+	if (tsize > TVMEMSIZE) {
+		printk("template (%u) too big for tvmem (%u)\n", tsize,
+		       TVMEMSIZE);
+		goto out;
+	}
+
+	memcpy(tvmem, hmac_sha256_tv_template, tsize);
+	hmac_sha256_tv = (void *) tvmem;
+
+	for (i = 0; i < HMAC_SHA256_TEST_VECTORS; i++) {
+		printk("test %u:\n", i + 1);
+		memset(result, 0, sizeof (result));
+
+		p = hmac_sha256_tv[i].plaintext;
+		sg[0].page = virt_to_page(p);
+		sg[0].offset = ((long) p & ~PAGE_MASK);
+		sg[0].length = strlen(hmac_sha256_tv[i].plaintext);
+
+		klen = strlen(hmac_sha256_tv[i].key);
+	
+		//printk("DS=%u\n", crypto_tfm_alg_digestsize(tfm));
+		
+		//printk("K=");
+		hexdump(hmac_sha256_tv[i].key, strlen(hmac_sha256_tv[i].key));
+		//printk("P=%s\n", hmac_sha256_tv[i].plaintext);
+		
+		crypto_hmac(tfm, hmac_sha256_tv[i].key, &klen, sg, 1, result);
+
+		//printk("H=");
+		hexdump(result, crypto_tfm_alg_digestsize(tfm));
+		printk("%s\n",
+		       memcmp(result, hmac_sha256_tv[i].digest,
+		       crypto_tfm_alg_digestsize(tfm)) ? "fail" : "pass");
+	}
+
+out:
+	crypto_free_tfm(tfm);
+}
+
 #endif	/* CONFIG_CRYPTO_HMAC */
 
 static void
@@ -416,6 +479,82 @@
 	crypto_free_tfm(tfm);
 }
 
+static void
+test_sha256(void)
+{
+	char *p;
+	unsigned int i;
+	struct crypto_tfm *tfm;
+	struct sha256_testvec *sha256_tv;
+	struct scatterlist sg[2];
+	unsigned int tsize;
+	char result[SHA256_DIGEST_SIZE];
+
+	printk("\ntesting sha256\n");
+
+	tsize = sizeof (sha256_tv_template);
+	if (tsize > TVMEMSIZE) {
+		printk("template (%u) too big for tvmem (%u)\n", tsize,
+		       TVMEMSIZE);
+		return;
+	}
+
+	memcpy(tvmem, sha256_tv_template, tsize);
+	sha256_tv = (void *) tvmem;
+
+	tfm = crypto_alloc_tfm("sha256", 0);
+	if (tfm == NULL) {
+		printk("failed to load transform for sha256\n");
+		return;
+	}
+
+	for (i = 0; i < SHA256_TEST_VECTORS; i++) {
+		printk("test %u:\n", i + 1);
+		memset(result, 0, sizeof (result));
+
+		p = sha256_tv[i].plaintext;
+		sg[0].page = virt_to_page(p);
+		sg[0].offset = ((long) p & ~PAGE_MASK);
+		sg[0].length = strlen(sha256_tv[i].plaintext);
+
+		crypto_digest_init(tfm);
+		crypto_digest_update(tfm, sg, 1);
+		crypto_digest_final(tfm, result);
+
+		hexdump(result, crypto_tfm_alg_digestsize(tfm));
+		printk("%s\n",
+		       memcmp(result, sha256_tv[i].digest,
+			      crypto_tfm_alg_digestsize(tfm)) ? "fail" :
+		       "pass");
+	}
+
+	printk("\ntesting sha256 across pages\n");
+
+	/* setup the dummy buffer first */
+	memset(xbuf, 0, sizeof (xbuf));
+	memcpy(&xbuf[IDX1], "abcdbcdecdefdefgefghfghighij", 28);
+	memcpy(&xbuf[IDX2], "hijkijkljklmklmnlmnomnopnopq", 28);
+
+	p = &xbuf[IDX1];
+	sg[0].page = virt_to_page(p);
+	sg[0].offset = ((long) p & ~PAGE_MASK);
+	sg[0].length = 28;
+
+	p = &xbuf[IDX2];
+	sg[1].page = virt_to_page(p);
+	sg[1].offset = ((long) p & ~PAGE_MASK);
+	sg[1].length = 28;
+
+	memset(result, 0, sizeof (result));
+	crypto_digest_digest(tfm, sg, 2, result);
+	hexdump(result, crypto_tfm_alg_digestsize(tfm));
+	printk("%s\n",
+	       memcmp(result, sha256_tv[1].digest,
+		      crypto_tfm_alg_digestsize(tfm)) ? "fail" : "pass");
+		     
+	crypto_free_tfm(tfm);
+}
+
 void
 test_des(void)
 {
@@ -774,7 +913,7 @@
 	hexdump(q, 8);
 	printk("%s\n", memcmp(q, des_tv[i].result + 8, 8) ? "fail" : "pass");
 
-	printk("\ntesting des ecb encryption chunking scenario D (atomic)\n");
+	printk("\ntesting des ecb encryption chunking scenario D\n");
 
 	/*
 	 * Scenario D, torture test, one byte per frag.
@@ -1013,7 +1152,7 @@
 		return;
 	}
 
-	printk("\ntesting des cbc encryption (atomic)\n");
+	printk("\ntesting des cbc encryption\n");
 
 	tsize = sizeof (des_cbc_enc_tv_template);
 	if (tsize > TVMEMSIZE) {
@@ -1368,6 +1507,7 @@
 #ifdef CONFIG_CRYPTO_HMAC
 		test_hmac_md5();
 		test_hmac_sha1();
+		test_hmac_sha256();
 #endif		
 		break;
 
@@ -1390,16 +1530,24 @@
 	case 5:
 		test_md4();
 		break;
+		
+	case 6:
+		test_sha256();
+		break;
 
 #ifdef CONFIG_CRYPTO_HMAC
 	case 100:
 		test_hmac_md5();
 		break;
 		
-		
 	case 101:
 		test_hmac_sha1();
 		break;
+	
+	case 102:
+		test_hmac_sha256();
+		break;
+
 #endif
 
 	case 1000:
diff -Nru a/crypto/tcrypt.h b/crypto/tcrypt.h
--- a/crypto/tcrypt.h	Thu Nov  7 01:49:07 2002
+++ b/crypto/tcrypt.h	Thu Nov  7 01:49:07 2002
@@ -19,6 +19,7 @@
 #define MD5_DIGEST_SIZE		16
 #define MD4_DIGEST_SIZE		16
 #define SHA1_DIGEST_SIZE	20
+#define SHA256_DIGEST_SIZE	32
 
 /*
  * MD4 test vectors from RFC1320
@@ -362,6 +363,186 @@
 
 };
 
+/*
+ * HMAC-SHA256 test vectors from
+ * draft-ietf-ipsec-ciph-sha-256-01.txt
+ */
+#define HMAC_SHA256_TEST_VECTORS	10
+
+struct hmac_sha256_testvec {
+	char key[128];
+	char plaintext[128];
+	char digest[SHA256_DIGEST_SIZE];
+} hmac_sha256_tv_template[] = {
+
+	{
+		{ 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+		  0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10,
+		  0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
+		  0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f, 0x20, 0x00 },
+		  
+	
+		{ "abc" },
+		
+		{ 0xa2, 0x1b, 0x1f, 0x5d, 0x4c, 0xf4, 0xf7, 0x3a,
+		  0x4d, 0xd9, 0x39, 0x75, 0x0f, 0x7a, 0x06, 0x6a,
+		  0x7f, 0x98, 0xcc, 0x13, 0x1c, 0xb1, 0x6a, 0x66,
+		  0x92, 0x75, 0x90, 0x21, 0xcf, 0xab, 0x81, 0x81 },
+
+	},
+	
+	{
+		{ 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+		  0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10,
+		  0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
+		   0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f, 0x20, 0x00 },
+		
+		{ "abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq" },
+		
+		{ 0x10, 0x4f, 0xdc, 0x12, 0x57, 0x32, 0x8f, 0x08,
+		  0x18, 0x4b, 0xa7, 0x31, 0x31, 0xc5, 0x3c, 0xae,
+		  0xe6, 0x98, 0xe3, 0x61, 0x19, 0x42, 0x11, 0x49,
+		  0xea, 0x8c, 0x71, 0x24, 0x56, 0x69, 0x7d, 0x30 }
+	},
+
+	{
+		{ 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+		  0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10,
+		  0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
+		  0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f, 0x20, 0x00 },
+		
+		{ "abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq"
+		  "abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq" },
+		
+		{ 0x47, 0x03, 0x05, 0xfc, 0x7e, 0x40, 0xfe, 0x34,
+		  0xd3, 0xee, 0xb3, 0xe7, 0x73, 0xd9, 0x5a, 0xab,
+		  0x73, 0xac, 0xf0, 0xfd, 0x06, 0x04, 0x47, 0xa5,
+		  0xeb, 0x45, 0x95, 0xbf, 0x33, 0xa9, 0xd1, 0xa3 }
+	},
+
+	{
+		{ 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b,
+		  0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b,
+		  0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b,
+		  0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x00 },
+		
+		{ "Hi There" },
+		
+		{ 0x19, 0x8a, 0x60, 0x7e, 0xb4, 0x4b, 0xfb, 0xc6,
+		  0x99, 0x03, 0xa0, 0xf1, 0xcf, 0x2b, 0xbd, 0xc5,
+		  0xba, 0x0a, 0xa3, 0xf3, 0xd9, 0xae, 0x3c, 0x1c,
+		  0x7a, 0x3b, 0x16, 0x96, 0xa0, 0xb6, 0x8c, 0xf7 }
+	},
+
+	{
+		{ "Jefe" },
+		
+		{ "what do ya want for nothing?" },
+		
+		{ 0x5b, 0xdc, 0xc1, 0x46, 0xbf, 0x60, 0x75, 0x4e,
+		  0x6a, 0x04, 0x24, 0x26, 0x08, 0x95, 0x75, 0xc7,
+		  0x5a, 0x00, 0x3f, 0x08, 0x9d, 0x27, 0x39, 0x83,
+		  0x9d, 0xec, 0x58, 0xb9, 0x64, 0xec, 0x38, 0x43 }
+	},
+
+	{
+		{ 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+		  0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+		  0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+		  0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0x00 },
+		
+		{ 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd,
+		  0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd,
+		  0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd,
+		  0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd,
+		  0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd,
+		  0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd,
+		  0xdd, 0xdd, 0x00 },
+		
+		{ 0xcd, 0xcb, 0x12, 0x20, 0xd1, 0xec, 0xcc, 0xea,
+		  0x91, 0xe5, 0x3a, 0xba, 0x30, 0x92, 0xf9, 0x62,
+		  0xe5, 0x49, 0xfe, 0x6c, 0xe9, 0xed, 0x7f, 0xdc,
+		  0x43, 0x19, 0x1f, 0xbd, 0xe4, 0x5c, 0x30, 0xb0 }
+	},
+
+	{
+		{ 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+		  0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10,
+		  0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
+		  0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f, 0x20,
+		  0x21, 0x22, 0x23, 0x24, 0x25, 0x00 },
+		
+		{ 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd,
+		  0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd,
+		  0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd,
+		  0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd,
+		  0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd,
+		  0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd,
+		  0xcd, 0xcd, 0x00 },
+		
+		{ 0xd4, 0x63, 0x3c, 0x17, 0xf6, 0xfb, 0x8d, 0x74,
+		  0x4c, 0x66, 0xde, 0xe0, 0xf8, 0xf0, 0x74, 0x55,
+		  0x6e, 0xc4, 0xaf, 0x55, 0xef, 0x07, 0x99, 0x85,
+		  0x41, 0x46, 0x8e, 0xb4, 0x9b, 0xd2, 0xe9, 0x17 }
+	},
+
+	{
+		{ 0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c,
+		  0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c,
+		  0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c,
+		  0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x00 },
+		
+		{ "Test With Truncation" },
+		
+		{ 0x75, 0x46, 0xaf, 0x01, 0x84, 0x1f, 0xc0, 0x9b,
+		  0x1a, 0xb9, 0xc3, 0x74, 0x9a, 0x5f, 0x1c, 0x17,
+		  0xd4, 0xf5, 0x89, 0x66, 0x8a, 0x58, 0x7b, 0x27,
+		  0x00, 0xa9, 0xc9, 0x7c, 0x11, 0x93, 0xcf, 0x42 }
+	},
+	
+	{
+		{ 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+		  0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+		  0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+		  0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+		  0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+		  0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+		  0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+		  0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+		  0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+		  0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0x00 },
+		
+		{ "Test Using Larger Than Block-Size Key - Hash Key First" },
+		
+		{ 0x69, 0x53, 0x02, 0x5e, 0xd9, 0x6f, 0x0c, 0x09,
+		  0xf8, 0x0a, 0x96, 0xf7, 0x8e, 0x65, 0x38, 0xdb,
+		  0xe2, 0xe7, 0xb8, 0x20, 0xe3, 0xdd, 0x97, 0x0e,
+		  0x7d, 0xdd, 0x39, 0x09, 0x1b, 0x32, 0x35, 0x2f }
+	},
+
+	{
+		{ 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+		  0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+		  0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+		  0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+		  0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+		  0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+		  0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+		  0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+		  0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+		  0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0x00 },
+		
+		{ "Test Using Larger Than Block-Size Key and Larger Than "
+		  "One Block-Size Data" },
+		
+		{ 0x63, 0x55, 0xac, 0x22, 0xe8, 0x90, 0xd0, 0xa3,
+		  0xc8, 0x48, 0x1a, 0x5c, 0xa4, 0x82, 0x5b, 0xc8,
+		  0x84, 0xd3, 0xe7, 0xa1, 0xff, 0x98, 0xa2, 0xfc,
+		  0x2a, 0xc7, 0xd8, 0xe0, 0x64, 0xc3, 0xb2, 0xe6 }
+	},
+};
+
+
 #endif	/* CONFIG_CRYPTO_HMAC */
 
 /*
@@ -383,6 +564,30 @@
 	  { 0x84, 0x98, 0x3E, 0x44, 0x1C, 0x3B, 0xD2, 0x6E ,0xBA, 0xAE,
 	    0x4A, 0xA1, 0xF9, 0x51, 0x29, 0xE5, 0xE5, 0x46, 0x70, 0xF1 }
 	}
+};
+
+/*
+ * SHA256 test vectors from from NIST
+ */
+#define SHA256_TEST_VECTORS	2
+
+struct sha256_testvec {
+	char plaintext[128];
+	char digest[SHA256_DIGEST_SIZE];
+} sha256_tv_template[] = {
+	{ "abc",
+	  { 0xba, 0x78, 0x16, 0xbf, 0x8f, 0x01, 0xcf, 0xea,
+	    0x41, 0x41, 0x40, 0xde, 0x5d, 0xae, 0x22, 0x23,
+	    0xb0, 0x03, 0x61, 0xa3, 0x96, 0x17, 0x7a, 0x9c,
+	    0xb4, 0x10, 0xff, 0x61, 0xf2, 0x00, 0x15, 0xad }
+	},
+	        	
+	{ "abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq",
+	  { 0x24, 0x8d, 0x6a, 0x61, 0xd2, 0x06, 0x38, 0xb8,
+	    0xe5, 0xc0, 0x26, 0x93, 0x0c, 0x3e, 0x60, 0x39,
+	    0xa3, 0x3c, 0xe4, 0x59, 0x64, 0xff, 0x21, 0x67,
+	    0xf6, 0xec, 0xed, 0xd4, 0x19, 0xdb, 0x06, 0xc1 }
+	},
 };
 
 /*


ChangeSet@1.925.5.4, 2002-11-06 17:49:19-08:00, davem@nuts.ninka.net
  [CRYPTO]: Add in crypto/sha256.c

diff -Nru a/crypto/sha256.c b/crypto/sha256.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/crypto/sha256.c	Thu Nov  7 01:49:09 2002
@@ -0,0 +1,354 @@
+/*
+ * Cryptographic API.
+ *
+ * SHA-256, as specified in
+ * http://csrc.nist.gov/cryptval/shs/sha256-384-512.pdf
+ *
+ * SHA-256 code by Jean-Luc Cooke <jlcooke@certainkey.com>.
+ *
+ * Copyright (c) Jean-Luc Cooke <jlcooke@certainkey.com>
+ * Copyright (c) Andrew McDonald <andrew@mcdonald.org.uk>
+ * Copyright (c) 2002 James Morris <jmorris@intercode.com.au>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option) 
+ * any later version.
+ *
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/crypto.h>
+#include <asm/scatterlist.h>
+#include <asm/byteorder.h>
+
+#define SHA256_DIGEST_SIZE	32
+#define SHA256_HMAC_BLOCK_SIZE	64
+
+struct sha256_ctx {
+	u32 count[2];
+	u32 state[8];
+	u8 buf[128];
+};
+
+#define Ch(x,y,z)   ((x & y) ^ (~x & z))
+#define Maj(x,y,z)  ((x & y) ^ ( x & z) ^ (y & z))
+#define RORu32(x,y) ( ((x) >> (y)) | ((x) << (32-(y))) )
+#define e0(x)       (RORu32(x, 2) ^ RORu32(x,13) ^ RORu32(x,22))
+#define e1(x)       (RORu32(x, 6) ^ RORu32(x,11) ^ RORu32(x,25))
+#define s0(x)       (RORu32(x, 7) ^ RORu32(x,18) ^ (x >> 3))
+#define s1(x)       (RORu32(x,17) ^ RORu32(x,19) ^ (x >> 10))
+
+#define H0         0x6a09e667
+#define H1         0xbb67ae85
+#define H2         0x3c6ef372
+#define H3         0xa54ff53a
+#define H4         0x510e527f
+#define H5         0x9b05688c
+#define H6         0x1f83d9ab
+#define H7         0x5be0cd19
+
+#define LOAD_OP(I)\
+ {\
+  t1  = input[(4*I)  ] & 0xff; t1<<=8;\
+  t1 |= input[(4*I)+1] & 0xff; t1<<=8;\
+  t1 |= input[(4*I)+2] & 0xff; t1<<=8;\
+  t1 |= input[(4*I)+3] & 0xff;\
+  W[I] = t1;\
+ }
+
+#define BLEND_OP(I) W[I] = s1(W[I-2]) + W[I-7] + s0(W[I-15]) + W[I-16];
+
+static void sha256_transform(u32 *state, const u8 *input)
+{
+	u32 a, b, c, d, e, f, g, h, t1, t2;
+	u32 W[64];
+
+	/* load the input */
+	LOAD_OP( 0);  LOAD_OP( 1);  LOAD_OP( 2);  LOAD_OP( 3);
+	LOAD_OP( 4);  LOAD_OP( 5);  LOAD_OP( 6);  LOAD_OP( 7);
+	LOAD_OP( 8);  LOAD_OP( 9);  LOAD_OP(10);  LOAD_OP(11);
+	LOAD_OP(12);  LOAD_OP(13);  LOAD_OP(14);  LOAD_OP(15);
+
+	/* now blend */
+	BLEND_OP(16);  BLEND_OP(17);  BLEND_OP(18);  BLEND_OP(19);
+	BLEND_OP(20);  BLEND_OP(21);  BLEND_OP(22);  BLEND_OP(23);
+	BLEND_OP(24);  BLEND_OP(25);  BLEND_OP(26);  BLEND_OP(27);
+	BLEND_OP(28);  BLEND_OP(29);  BLEND_OP(30);  BLEND_OP(31);
+	BLEND_OP(32);  BLEND_OP(33);  BLEND_OP(34);  BLEND_OP(35);
+	BLEND_OP(36);  BLEND_OP(37);  BLEND_OP(38);  BLEND_OP(39);
+	BLEND_OP(40);  BLEND_OP(41);  BLEND_OP(42);  BLEND_OP(43);
+	BLEND_OP(44);  BLEND_OP(45);  BLEND_OP(46);  BLEND_OP(47);
+	BLEND_OP(48);  BLEND_OP(49);  BLEND_OP(50);  BLEND_OP(51);
+	BLEND_OP(52);  BLEND_OP(53);  BLEND_OP(54);  BLEND_OP(55);
+	BLEND_OP(56);  BLEND_OP(57);  BLEND_OP(58);  BLEND_OP(59);
+	BLEND_OP(60);  BLEND_OP(61);  BLEND_OP(62);  BLEND_OP(63);
+    
+	/* load the state into our registers */
+	a=state[0];  b=state[1];  c=state[2];  d=state[3];
+	e=state[4];  f=state[5];  g=state[6];  h=state[7];
+
+	/* now iterate */
+	t1 = h + e1(e) + Ch(e,f,g) + 0x428a2f98 + W[ 0];
+	t2 = e0(a) + Maj(a,b,c);    d+=t1;    h=t1+t2;
+	t1 = g + e1(d) + Ch(d,e,f) + 0x71374491 + W[ 1];
+	t2 = e0(h) + Maj(h,a,b);    c+=t1;    g=t1+t2;
+	t1 = f + e1(c) + Ch(c,d,e) + 0xb5c0fbcf + W[ 2];
+	t2 = e0(g) + Maj(g,h,a);    b+=t1;    f=t1+t2;
+	t1 = e + e1(b) + Ch(b,c,d) + 0xe9b5dba5 + W[ 3];
+	t2 = e0(f) + Maj(f,g,h);    a+=t1;    e=t1+t2;
+	t1 = d + e1(a) + Ch(a,b,c) + 0x3956c25b + W[ 4];
+	t2 = e0(e) + Maj(e,f,g);    h+=t1;    d=t1+t2;
+	t1 = c + e1(h) + Ch(h,a,b) + 0x59f111f1 + W[ 5];
+	t2 = e0(d) + Maj(d,e,f);    g+=t1;    c=t1+t2;
+	t1 = b + e1(g) + Ch(g,h,a) + 0x923f82a4 + W[ 6];
+	t2 = e0(c) + Maj(c,d,e);    f+=t1;    b=t1+t2;
+	t1 = a + e1(f) + Ch(f,g,h) + 0xab1c5ed5 + W[ 7];
+	t2 = e0(b) + Maj(b,c,d);    e+=t1;    a=t1+t2;
+
+	t1 = h + e1(e) + Ch(e,f,g) + 0xd807aa98 + W[ 8];
+	t2 = e0(a) + Maj(a,b,c);    d+=t1;    h=t1+t2;
+	t1 = g + e1(d) + Ch(d,e,f) + 0x12835b01 + W[ 9];
+	t2 = e0(h) + Maj(h,a,b);    c+=t1;    g=t1+t2;
+	t1 = f + e1(c) + Ch(c,d,e) + 0x243185be + W[10];
+	t2 = e0(g) + Maj(g,h,a);    b+=t1;    f=t1+t2;
+	t1 = e + e1(b) + Ch(b,c,d) + 0x550c7dc3 + W[11];
+	t2 = e0(f) + Maj(f,g,h);    a+=t1;    e=t1+t2;
+	t1 = d + e1(a) + Ch(a,b,c) + 0x72be5d74 + W[12];
+	t2 = e0(e) + Maj(e,f,g);    h+=t1;    d=t1+t2;
+	t1 = c + e1(h) + Ch(h,a,b) + 0x80deb1fe + W[13];
+	t2 = e0(d) + Maj(d,e,f);    g+=t1;    c=t1+t2;
+	t1 = b + e1(g) + Ch(g,h,a) + 0x9bdc06a7 + W[14];
+	t2 = e0(c) + Maj(c,d,e);    f+=t1;    b=t1+t2;
+	t1 = a + e1(f) + Ch(f,g,h) + 0xc19bf174 + W[15];
+	t2 = e0(b) + Maj(b,c,d);    e+=t1;    a=t1+t2;
+
+	t1 = h + e1(e) + Ch(e,f,g) + 0xe49b69c1 + W[16];
+	t2 = e0(a) + Maj(a,b,c);    d+=t1;    h=t1+t2;
+	t1 = g + e1(d) + Ch(d,e,f) + 0xefbe4786 + W[17];
+	t2 = e0(h) + Maj(h,a,b);    c+=t1;    g=t1+t2;
+	t1 = f + e1(c) + Ch(c,d,e) + 0x0fc19dc6 + W[18];
+	t2 = e0(g) + Maj(g,h,a);    b+=t1;    f=t1+t2;
+	t1 = e + e1(b) + Ch(b,c,d) + 0x240ca1cc + W[19];
+	t2 = e0(f) + Maj(f,g,h);    a+=t1;    e=t1+t2;
+	t1 = d + e1(a) + Ch(a,b,c) + 0x2de92c6f + W[20];
+	t2 = e0(e) + Maj(e,f,g);    h+=t1;    d=t1+t2;
+	t1 = c + e1(h) + Ch(h,a,b) + 0x4a7484aa + W[21];
+	t2 = e0(d) + Maj(d,e,f);    g+=t1;    c=t1+t2;
+	t1 = b + e1(g) + Ch(g,h,a) + 0x5cb0a9dc + W[22];
+	t2 = e0(c) + Maj(c,d,e);    f+=t1;    b=t1+t2;
+	t1 = a + e1(f) + Ch(f,g,h) + 0x76f988da + W[23];
+	t2 = e0(b) + Maj(b,c,d);    e+=t1;    a=t1+t2;
+
+	t1 = h + e1(e) + Ch(e,f,g) + 0x983e5152 + W[24];
+	t2 = e0(a) + Maj(a,b,c);    d+=t1;    h=t1+t2;
+	t1 = g + e1(d) + Ch(d,e,f) + 0xa831c66d + W[25];
+	t2 = e0(h) + Maj(h,a,b);    c+=t1;    g=t1+t2;
+	t1 = f + e1(c) + Ch(c,d,e) + 0xb00327c8 + W[26];
+	t2 = e0(g) + Maj(g,h,a);    b+=t1;    f=t1+t2;
+	t1 = e + e1(b) + Ch(b,c,d) + 0xbf597fc7 + W[27];
+	t2 = e0(f) + Maj(f,g,h);    a+=t1;    e=t1+t2;
+	t1 = d + e1(a) + Ch(a,b,c) + 0xc6e00bf3 + W[28];
+	t2 = e0(e) + Maj(e,f,g);    h+=t1;    d=t1+t2;
+	t1 = c + e1(h) + Ch(h,a,b) + 0xd5a79147 + W[29];
+	t2 = e0(d) + Maj(d,e,f);    g+=t1;    c=t1+t2;
+	t1 = b + e1(g) + Ch(g,h,a) + 0x06ca6351 + W[30];
+	t2 = e0(c) + Maj(c,d,e);    f+=t1;    b=t1+t2;
+	t1 = a + e1(f) + Ch(f,g,h) + 0x14292967 + W[31];
+	t2 = e0(b) + Maj(b,c,d);    e+=t1;    a=t1+t2;
+
+	t1 = h + e1(e) + Ch(e,f,g) + 0x27b70a85 + W[32];
+	t2 = e0(a) + Maj(a,b,c);    d+=t1;    h=t1+t2;
+	t1 = g + e1(d) + Ch(d,e,f) + 0x2e1b2138 + W[33];
+	t2 = e0(h) + Maj(h,a,b);    c+=t1;    g=t1+t2;
+	t1 = f + e1(c) + Ch(c,d,e) + 0x4d2c6dfc + W[34];
+	t2 = e0(g) + Maj(g,h,a);    b+=t1;    f=t1+t2;
+	t1 = e + e1(b) + Ch(b,c,d) + 0x53380d13 + W[35];
+	t2 = e0(f) + Maj(f,g,h);    a+=t1;    e=t1+t2;
+	t1 = d + e1(a) + Ch(a,b,c) + 0x650a7354 + W[36];
+	t2 = e0(e) + Maj(e,f,g);    h+=t1;    d=t1+t2;
+	t1 = c + e1(h) + Ch(h,a,b) + 0x766a0abb + W[37];
+	t2 = e0(d) + Maj(d,e,f);    g+=t1;    c=t1+t2;
+	t1 = b + e1(g) + Ch(g,h,a) + 0x81c2c92e + W[38];
+	t2 = e0(c) + Maj(c,d,e);    f+=t1;    b=t1+t2;
+	t1 = a + e1(f) + Ch(f,g,h) + 0x92722c85 + W[39];
+	t2 = e0(b) + Maj(b,c,d);    e+=t1;    a=t1+t2;
+
+	t1 = h + e1(e) + Ch(e,f,g) + 0xa2bfe8a1 + W[40];
+	t2 = e0(a) + Maj(a,b,c);    d+=t1;    h=t1+t2;
+	t1 = g + e1(d) + Ch(d,e,f) + 0xa81a664b + W[41];
+	t2 = e0(h) + Maj(h,a,b);    c+=t1;    g=t1+t2;
+	t1 = f + e1(c) + Ch(c,d,e) + 0xc24b8b70 + W[42];
+	t2 = e0(g) + Maj(g,h,a);    b+=t1;    f=t1+t2;
+	t1 = e + e1(b) + Ch(b,c,d) + 0xc76c51a3 + W[43];
+	t2 = e0(f) + Maj(f,g,h);    a+=t1;    e=t1+t2;
+	t1 = d + e1(a) + Ch(a,b,c) + 0xd192e819 + W[44];
+	t2 = e0(e) + Maj(e,f,g);    h+=t1;    d=t1+t2;
+	t1 = c + e1(h) + Ch(h,a,b) + 0xd6990624 + W[45];
+	t2 = e0(d) + Maj(d,e,f);    g+=t1;    c=t1+t2;
+	t1 = b + e1(g) + Ch(g,h,a) + 0xf40e3585 + W[46];
+	t2 = e0(c) + Maj(c,d,e);    f+=t1;    b=t1+t2;
+	t1 = a + e1(f) + Ch(f,g,h) + 0x106aa070 + W[47];
+	t2 = e0(b) + Maj(b,c,d);    e+=t1;    a=t1+t2;
+
+	t1 = h + e1(e) + Ch(e,f,g) + 0x19a4c116 + W[48];
+	t2 = e0(a) + Maj(a,b,c);    d+=t1;    h=t1+t2;
+	t1 = g + e1(d) + Ch(d,e,f) + 0x1e376c08 + W[49];
+	t2 = e0(h) + Maj(h,a,b);    c+=t1;    g=t1+t2;
+	t1 = f + e1(c) + Ch(c,d,e) + 0x2748774c + W[50];
+	t2 = e0(g) + Maj(g,h,a);    b+=t1;    f=t1+t2;
+	t1 = e + e1(b) + Ch(b,c,d) + 0x34b0bcb5 + W[51];
+	t2 = e0(f) + Maj(f,g,h);    a+=t1;    e=t1+t2;
+	t1 = d + e1(a) + Ch(a,b,c) + 0x391c0cb3 + W[52];
+	t2 = e0(e) + Maj(e,f,g);    h+=t1;    d=t1+t2;
+	t1 = c + e1(h) + Ch(h,a,b) + 0x4ed8aa4a + W[53];
+	t2 = e0(d) + Maj(d,e,f);    g+=t1;    c=t1+t2;
+	t1 = b + e1(g) + Ch(g,h,a) + 0x5b9cca4f + W[54];
+	t2 = e0(c) + Maj(c,d,e);    f+=t1;    b=t1+t2;
+	t1 = a + e1(f) + Ch(f,g,h) + 0x682e6ff3 + W[55];
+	t2 = e0(b) + Maj(b,c,d);    e+=t1;    a=t1+t2;
+
+	t1 = h + e1(e) + Ch(e,f,g) + 0x748f82ee + W[56];
+	t2 = e0(a) + Maj(a,b,c);    d+=t1;    h=t1+t2;
+	t1 = g + e1(d) + Ch(d,e,f) + 0x78a5636f + W[57];
+	t2 = e0(h) + Maj(h,a,b);    c+=t1;    g=t1+t2;
+	t1 = f + e1(c) + Ch(c,d,e) + 0x84c87814 + W[58];
+	t2 = e0(g) + Maj(g,h,a);    b+=t1;    f=t1+t2;
+	t1 = e + e1(b) + Ch(b,c,d) + 0x8cc70208 + W[59];
+	t2 = e0(f) + Maj(f,g,h);    a+=t1;    e=t1+t2;
+	t1 = d + e1(a) + Ch(a,b,c) + 0x90befffa + W[60];
+	t2 = e0(e) + Maj(e,f,g);    h+=t1;    d=t1+t2;
+	t1 = c + e1(h) + Ch(h,a,b) + 0xa4506ceb + W[61];
+	t2 = e0(d) + Maj(d,e,f);    g+=t1;    c=t1+t2;
+	t1 = b + e1(g) + Ch(g,h,a) + 0xbef9a3f7 + W[62];
+	t2 = e0(c) + Maj(c,d,e);    f+=t1;    b=t1+t2;
+	t1 = a + e1(f) + Ch(f,g,h) + 0xc67178f2 + W[63];
+	t2 = e0(b) + Maj(b,c,d);    e+=t1;    a=t1+t2;
+
+	state[0] += a; state[1] += b; state[2] += c; state[3] += d;
+	state[4] += e; state[5] += f; state[6] += g; state[7] += h;
+
+	/* clear any sensitive info... */
+	a = b = c = d = e = f = g = h = t1 = t2 = 0;
+	memset(W, 0, 64 * sizeof(u32));
+}
+
+static void sha256_init(void *ctx)
+{
+	struct sha256_ctx *sctx = ctx;
+	sctx->state[0] = H0;
+	sctx->state[1] = H1;
+	sctx->state[2] = H2;
+	sctx->state[3] = H3;
+	sctx->state[4] = H4;
+	sctx->state[5] = H5;
+	sctx->state[6] = H6;
+	sctx->state[7] = H7;
+	sctx->count[0] = sctx->count[1] = 0;
+	memset(sctx->buf, 0, sizeof(sctx->buf));
+}
+
+static void sha256_update(void *ctx, const u8 *data, unsigned int len)
+{
+	struct sha256_ctx *sctx = ctx;
+	unsigned int i, index, part_len;
+
+	/* Compute number of bytes mod 128 */
+	index = (unsigned int)((sctx->count[0] >> 3) & 0x3f);
+
+	/* Update number of bits */
+	if ((sctx->count[0] += (len << 3)) < (len << 3)) {
+		sctx->count[1]++;
+		sctx->count[1] += (len >> 29);
+	}
+
+	part_len = 64 - index;
+
+	/* Transform as many times as possible. */
+	if (len >= part_len) {
+		memcpy(&sctx->buf[index], data, part_len);
+		sha256_transform(sctx->state, sctx->buf);
+
+		for (i = part_len; i + 63 < len; i += 64)
+			sha256_transform(sctx->state, &data[i]);
+		index = 0;
+	} else {
+		i = 0;
+	}
+	
+	/* Buffer remaining input */
+	memcpy(&sctx->buf[index], &data[i], len-i);
+}
+
+static void sha256_final(void* ctx, u8 *out)
+{
+	struct sha256_ctx *sctx = ctx;
+	u8 bits[8];
+	unsigned int index, pad_len, t;
+	int i, j;
+	const u8 padding[64] = { 0x80, };
+
+	/* Save number of bits */
+	t = sctx->count[0];
+	bits[7] = t; t >>= 8;
+	bits[6] = t; t >>= 8;
+	bits[5] = t; t >>= 8;
+	bits[4] = t;
+	t = sctx->count[1];
+	bits[3] = t; t >>= 8;
+	bits[2] = t; t >>= 8;
+	bits[1] = t; t >>= 8;
+	bits[0] = t;
+
+	/* Pad out to 56 mod 64. */
+	index = (sctx->count[0] >> 3) & 0x3f;
+	pad_len = (index < 56) ? (56 - index) : ((64+56) - index);
+	sha256_update(sctx, padding, pad_len);
+
+	/* Append length (before padding) */
+	sha256_update(sctx, bits, 8);
+
+	/* Store state in digest */
+	for (i = j = 0; i < 8; i++, j += 4) {
+		t = sctx->state[i];
+		out[j+3] = t; t >>= 8;
+		out[j+2] = t; t >>= 8;
+		out[j+1] = t; t >>= 8;
+		out[j  ] = t;
+	}
+
+	/* Zeroize sensitive information. */
+	memset(sctx, 0, sizeof(*sctx));
+}
+
+
+static struct crypto_alg alg = {
+	.cra_name	=	"sha256",
+	.cra_flags	=	CRYPTO_ALG_TYPE_DIGEST,
+	.cra_blocksize	=	SHA256_HMAC_BLOCK_SIZE,
+	.cra_ctxsize	=	sizeof(struct sha256_ctx),
+	.cra_module	=	THIS_MODULE,
+	.cra_list       =       LIST_HEAD_INIT(alg.cra_list),
+	.cra_u		=	{ .digest = {
+	.dia_digestsize	=	SHA256_DIGEST_SIZE,
+	.dia_init   	= 	sha256_init,
+	.dia_update 	=	sha256_update,
+	.dia_final  	=	sha256_final } }
+};
+
+static int __init init(void)
+{
+	return crypto_register_alg(&alg);
+}
+
+static void __exit fini(void)
+{
+	crypto_unregister_alg(&alg);
+}
+
+module_init(init);
+module_exit(fini);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("SHA256 Secure Hash Algorithm");


ChangeSet@1.925.5.5, 2002-11-06 17:54:08-08:00, jmorris@intercode.com.au
  [CRYPTO]: Add blowfish algorithm.

diff -Nru a/Documentation/crypto/api-intro.txt b/Documentation/crypto/api-intro.txt
--- a/Documentation/crypto/api-intro.txt	Thu Nov  7 01:49:12 2002
+++ b/Documentation/crypto/api-intro.txt	Thu Nov  7 01:49:12 2002
@@ -101,6 +101,10 @@
 on a recognized standard and/or have been subjected to appropriate
 peer review.
 
+Also check for any RFCs which may relate to the use of specific algorithms,
+as well as general application notes such as RFC2451 ("The ESP CBC-Mode
+Cipher Algorithms").
+
 
 BUGS
 
@@ -164,6 +168,7 @@
   Andrew Tridgell and Steve French (MD4)
   Colin Plumb (MD5)
   Steve Raid (SHA1)
+  Jean-Luc Cooke (SHA256)
   Kazunori Miyazawa / USAGI (HMAC)
 
 The DES code was subsequently redeveloped by:
@@ -171,6 +176,11 @@
   Raimar Falke
   Gisle Sælensminde
   Niels Möller
+
+The Blowfish code was subsequently redeveloped by:
+  Herbert Valerio Riedel
+  Kyle McMartin
+
 
 Please send any credits updates or corrections to:
 James Morris <jmorris@intercode.com.au>
diff -Nru a/crypto/Kconfig b/crypto/Kconfig
--- a/crypto/Kconfig	Thu Nov  7 01:49:12 2002
+++ b/crypto/Kconfig	Thu Nov  7 01:49:12 2002
@@ -32,24 +32,35 @@
 	tristate "SHA1 digest algorithm"
 	depends on CRYPTO
 	help
-	  SHA-1 secure hash standard (FIPS 180-1).
+	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2).
 
 config CRYPTO_SHA256
 	tristate "SHA256 digest algorithm"
 	depends on CRYPTO
 	help
-	  SHA256 secure hash standard.
+	  SHA256 secure hash standard (DFIPS 180-2).
 	  
 	  This version of SHA implements a 256 bit hash with 128 bits of
-	  security against collision attacks.  It is described in:
-	  http://csrc.nist.gov/cryptval/shs/sha256-384-512.pdf
-	  
+	  security against collision attacks.
 
 config CRYPTO_DES
 	tristate "DES and Triple DES EDE cipher algorithms"
 	depends on CRYPTO
 	help
 	  DES cipher algorithm (FIPS 46-2), and Triple DES EDE (FIPS 46-3).
+
+config CRYPTO_BLOWFISH
+	tristate "Blowfish cipher algorithm"
+	depends on CRYPTO
+	help
+	  Blowfish cipher algorithm, by Bruce Schneier.
+	  
+	  This is a fast cipher which can use variable length key from 32
+	  bits to 448 bits.  It's fast, simple and specifically designed for
+	  use on "large microprocessors".
+	  
+	  See also:
+	  http://www.counterpane.com/blowfish.html
 
 config CRYPTO_TEST
 	tristate "Testing module"
diff -Nru a/crypto/Makefile b/crypto/Makefile
--- a/crypto/Makefile	Thu Nov  7 01:49:12 2002
+++ b/crypto/Makefile	Thu Nov  7 01:49:12 2002
@@ -14,6 +14,7 @@
 obj-$(CONFIG_CRYPTO_SHA1) += sha1.o
 obj-$(CONFIG_CRYPTO_SHA256) += sha256.o
 obj-$(CONFIG_CRYPTO_DES) += des.o
+obj-$(CONFIG_CRYPTO_BLOWFISH) += blowfish.o
 
 obj-$(CONFIG_CRYPTO_TEST) += tcrypt.o
 
diff -Nru a/crypto/api.c b/crypto/api.c
--- a/crypto/api.c	Thu Nov  7 01:49:12 2002
+++ b/crypto/api.c	Thu Nov  7 01:49:12 2002
@@ -262,19 +262,23 @@
 {
 	struct crypto_alg *alg = (struct crypto_alg *)p;
 	
-	seq_printf(m, "name       : %s\n", alg->cra_name);
-	seq_printf(m, "module     : %s\n", alg->cra_module ?
+	seq_printf(m, "name         : %s\n", alg->cra_name);
+	seq_printf(m, "module       : %s\n", alg->cra_module ?
 					alg->cra_module->name : "[static]");
-	seq_printf(m, "blocksize  : %u\n", alg->cra_blocksize);
+	seq_printf(m, "blocksize    : %u\n", alg->cra_blocksize);
 	
 	switch (alg->cra_flags & CRYPTO_ALG_TYPE_MASK) {
 	case CRYPTO_ALG_TYPE_CIPHER:
-		seq_printf(m, "keysize    : %u\n", alg->cra_cipher.cia_keysize);
-		seq_printf(m, "ivsize     : %u\n", alg->cra_cipher.cia_ivsize);
+		seq_printf(m, "min keysize  : %u\n",
+					alg->cra_cipher.cia_min_keysize);
+		seq_printf(m, "max keysize  : %u\n",
+					alg->cra_cipher.cia_max_keysize);
+		seq_printf(m, "ivsize       : %u\n",
+					alg->cra_cipher.cia_ivsize);
 		break;
 		
 	case CRYPTO_ALG_TYPE_DIGEST:
-		seq_printf(m, "digestsize : %u\n",
+		seq_printf(m, "digestsize   : %u\n",
 		           alg->cra_digest.dia_digestsize);
 		break;
 	}
diff -Nru a/crypto/blowfish.c b/crypto/blowfish.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/crypto/blowfish.c	Thu Nov  7 01:49:12 2002
@@ -0,0 +1,479 @@
+/* 
+ * Cryptographic API.
+ *
+ * Blowfish Cipher Algorithm, by Bruce Schneier.
+ * http://www.counterpane.com/blowfish.html
+ * 
+ * Adapated from Kerneli implementation.
+ * 
+ * Copyright (c) Herbert Valerio Riedel <hvr@hvrlab.org>
+ * Copyright (c) Kyle McMartin <kyle@debian.org>
+ * Copyright (c) 2002 James Morris <jmorris@intercode.com.au>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <asm/scatterlist.h>
+#include <linux/crypto.h>
+
+#define BF_BLOCK_SIZE 8
+#define BF_MIN_KEY_SIZE 8
+#define BF_MAX_KEY_SIZE 56
+
+struct bf_ctx {
+	u32 p[18];
+	u32 s[1024];
+};
+
+const static u32 bf_pbox[16 + 2] = {
+	0x243f6a88, 0x85a308d3, 0x13198a2e, 0x03707344,
+	0xa4093822, 0x299f31d0, 0x082efa98, 0xec4e6c89,
+	0x452821e6, 0x38d01377, 0xbe5466cf, 0x34e90c6c,
+	0xc0ac29b7, 0xc97c50dd, 0x3f84d5b5, 0xb5470917,
+	0x9216d5d9, 0x8979fb1b,
+};
+
+const static u32 bf_sbox[256 * 4] = {
+	0xd1310ba6, 0x98dfb5ac, 0x2ffd72db, 0xd01adfb7,
+	0xb8e1afed, 0x6a267e96, 0xba7c9045, 0xf12c7f99,
+	0x24a19947, 0xb3916cf7, 0x0801f2e2, 0x858efc16,
+	0x636920d8, 0x71574e69, 0xa458fea3, 0xf4933d7e,
+	0x0d95748f, 0x728eb658, 0x718bcd58, 0x82154aee,
+	0x7b54a41d, 0xc25a59b5, 0x9c30d539, 0x2af26013,
+	0xc5d1b023, 0x286085f0, 0xca417918, 0xb8db38ef,
+	0x8e79dcb0, 0x603a180e, 0x6c9e0e8b, 0xb01e8a3e,
+	0xd71577c1, 0xbd314b27, 0x78af2fda, 0x55605c60,
+	0xe65525f3, 0xaa55ab94, 0x57489862, 0x63e81440,
+	0x55ca396a, 0x2aab10b6, 0xb4cc5c34, 0x1141e8ce,
+	0xa15486af, 0x7c72e993, 0xb3ee1411, 0x636fbc2a,
+	0x2ba9c55d, 0x741831f6, 0xce5c3e16, 0x9b87931e,
+	0xafd6ba33, 0x6c24cf5c, 0x7a325381, 0x28958677,
+	0x3b8f4898, 0x6b4bb9af, 0xc4bfe81b, 0x66282193,
+	0x61d809cc, 0xfb21a991, 0x487cac60, 0x5dec8032,
+	0xef845d5d, 0xe98575b1, 0xdc262302, 0xeb651b88,
+	0x23893e81, 0xd396acc5, 0x0f6d6ff3, 0x83f44239,
+	0x2e0b4482, 0xa4842004, 0x69c8f04a, 0x9e1f9b5e,
+	0x21c66842, 0xf6e96c9a, 0x670c9c61, 0xabd388f0,
+	0x6a51a0d2, 0xd8542f68, 0x960fa728, 0xab5133a3,
+	0x6eef0b6c, 0x137a3be4, 0xba3bf050, 0x7efb2a98,
+	0xa1f1651d, 0x39af0176, 0x66ca593e, 0x82430e88,
+	0x8cee8619, 0x456f9fb4, 0x7d84a5c3, 0x3b8b5ebe,
+	0xe06f75d8, 0x85c12073, 0x401a449f, 0x56c16aa6,
+	0x4ed3aa62, 0x363f7706, 0x1bfedf72, 0x429b023d,
+	0x37d0d724, 0xd00a1248, 0xdb0fead3, 0x49f1c09b,
+	0x075372c9, 0x80991b7b, 0x25d479d8, 0xf6e8def7,
+	0xe3fe501a, 0xb6794c3b, 0x976ce0bd, 0x04c006ba,
+	0xc1a94fb6, 0x409f60c4, 0x5e5c9ec2, 0x196a2463,
+	0x68fb6faf, 0x3e6c53b5, 0x1339b2eb, 0x3b52ec6f,
+	0x6dfc511f, 0x9b30952c, 0xcc814544, 0xaf5ebd09,
+	0xbee3d004, 0xde334afd, 0x660f2807, 0x192e4bb3,
+	0xc0cba857, 0x45c8740f, 0xd20b5f39, 0xb9d3fbdb,
+	0x5579c0bd, 0x1a60320a, 0xd6a100c6, 0x402c7279,
+	0x679f25fe, 0xfb1fa3cc, 0x8ea5e9f8, 0xdb3222f8,
+	0x3c7516df, 0xfd616b15, 0x2f501ec8, 0xad0552ab,
+	0x323db5fa, 0xfd238760, 0x53317b48, 0x3e00df82,
+	0x9e5c57bb, 0xca6f8ca0, 0x1a87562e, 0xdf1769db,
+	0xd542a8f6, 0x287effc3, 0xac6732c6, 0x8c4f5573,
+	0x695b27b0, 0xbbca58c8, 0xe1ffa35d, 0xb8f011a0,
+	0x10fa3d98, 0xfd2183b8, 0x4afcb56c, 0x2dd1d35b,
+	0x9a53e479, 0xb6f84565, 0xd28e49bc, 0x4bfb9790,
+	0xe1ddf2da, 0xa4cb7e33, 0x62fb1341, 0xcee4c6e8,
+	0xef20cada, 0x36774c01, 0xd07e9efe, 0x2bf11fb4,
+	0x95dbda4d, 0xae909198, 0xeaad8e71, 0x6b93d5a0,
+	0xd08ed1d0, 0xafc725e0, 0x8e3c5b2f, 0x8e7594b7,
+	0x8ff6e2fb, 0xf2122b64, 0x8888b812, 0x900df01c,
+	0x4fad5ea0, 0x688fc31c, 0xd1cff191, 0xb3a8c1ad,
+	0x2f2f2218, 0xbe0e1777, 0xea752dfe, 0x8b021fa1,
+	0xe5a0cc0f, 0xb56f74e8, 0x18acf3d6, 0xce89e299,
+	0xb4a84fe0, 0xfd13e0b7, 0x7cc43b81, 0xd2ada8d9,
+	0x165fa266, 0x80957705, 0x93cc7314, 0x211a1477,
+	0xe6ad2065, 0x77b5fa86, 0xc75442f5, 0xfb9d35cf,
+	0xebcdaf0c, 0x7b3e89a0, 0xd6411bd3, 0xae1e7e49,
+	0x00250e2d, 0x2071b35e, 0x226800bb, 0x57b8e0af,
+	0x2464369b, 0xf009b91e, 0x5563911d, 0x59dfa6aa,
+	0x78c14389, 0xd95a537f, 0x207d5ba2, 0x02e5b9c5,
+	0x83260376, 0x6295cfa9, 0x11c81968, 0x4e734a41,
+	0xb3472dca, 0x7b14a94a, 0x1b510052, 0x9a532915,
+	0xd60f573f, 0xbc9bc6e4, 0x2b60a476, 0x81e67400,
+	0x08ba6fb5, 0x571be91f, 0xf296ec6b, 0x2a0dd915,
+	0xb6636521, 0xe7b9f9b6, 0xff34052e, 0xc5855664,
+	0x53b02d5d, 0xa99f8fa1, 0x08ba4799, 0x6e85076a,
+	0x4b7a70e9, 0xb5b32944, 0xdb75092e, 0xc4192623,
+	0xad6ea6b0, 0x49a7df7d, 0x9cee60b8, 0x8fedb266,
+	0xecaa8c71, 0x699a17ff, 0x5664526c, 0xc2b19ee1,
+	0x193602a5, 0x75094c29, 0xa0591340, 0xe4183a3e,
+	0x3f54989a, 0x5b429d65, 0x6b8fe4d6, 0x99f73fd6,
+	0xa1d29c07, 0xefe830f5, 0x4d2d38e6, 0xf0255dc1,
+	0x4cdd2086, 0x8470eb26, 0x6382e9c6, 0x021ecc5e,
+	0x09686b3f, 0x3ebaefc9, 0x3c971814, 0x6b6a70a1,
+	0x687f3584, 0x52a0e286, 0xb79c5305, 0xaa500737,
+	0x3e07841c, 0x7fdeae5c, 0x8e7d44ec, 0x5716f2b8,
+	0xb03ada37, 0xf0500c0d, 0xf01c1f04, 0x0200b3ff,
+	0xae0cf51a, 0x3cb574b2, 0x25837a58, 0xdc0921bd,
+	0xd19113f9, 0x7ca92ff6, 0x94324773, 0x22f54701,
+	0x3ae5e581, 0x37c2dadc, 0xc8b57634, 0x9af3dda7,
+	0xa9446146, 0x0fd0030e, 0xecc8c73e, 0xa4751e41,
+	0xe238cd99, 0x3bea0e2f, 0x3280bba1, 0x183eb331,
+	0x4e548b38, 0x4f6db908, 0x6f420d03, 0xf60a04bf,
+	0x2cb81290, 0x24977c79, 0x5679b072, 0xbcaf89af,
+	0xde9a771f, 0xd9930810, 0xb38bae12, 0xdccf3f2e,
+	0x5512721f, 0x2e6b7124, 0x501adde6, 0x9f84cd87,
+	0x7a584718, 0x7408da17, 0xbc9f9abc, 0xe94b7d8c,
+	0xec7aec3a, 0xdb851dfa, 0x63094366, 0xc464c3d2,
+	0xef1c1847, 0x3215d908, 0xdd433b37, 0x24c2ba16,
+	0x12a14d43, 0x2a65c451, 0x50940002, 0x133ae4dd,
+	0x71dff89e, 0x10314e55, 0x81ac77d6, 0x5f11199b,
+	0x043556f1, 0xd7a3c76b, 0x3c11183b, 0x5924a509,
+	0xf28fe6ed, 0x97f1fbfa, 0x9ebabf2c, 0x1e153c6e,
+	0x86e34570, 0xeae96fb1, 0x860e5e0a, 0x5a3e2ab3,
+	0x771fe71c, 0x4e3d06fa, 0x2965dcb9, 0x99e71d0f,
+	0x803e89d6, 0x5266c825, 0x2e4cc978, 0x9c10b36a,
+	0xc6150eba, 0x94e2ea78, 0xa5fc3c53, 0x1e0a2df4,
+	0xf2f74ea7, 0x361d2b3d, 0x1939260f, 0x19c27960,
+	0x5223a708, 0xf71312b6, 0xebadfe6e, 0xeac31f66,
+	0xe3bc4595, 0xa67bc883, 0xb17f37d1, 0x018cff28,
+	0xc332ddef, 0xbe6c5aa5, 0x65582185, 0x68ab9802,
+	0xeecea50f, 0xdb2f953b, 0x2aef7dad, 0x5b6e2f84,
+	0x1521b628, 0x29076170, 0xecdd4775, 0x619f1510,
+	0x13cca830, 0xeb61bd96, 0x0334fe1e, 0xaa0363cf,
+	0xb5735c90, 0x4c70a239, 0xd59e9e0b, 0xcbaade14,
+	0xeecc86bc, 0x60622ca7, 0x9cab5cab, 0xb2f3846e,
+	0x648b1eaf, 0x19bdf0ca, 0xa02369b9, 0x655abb50,
+	0x40685a32, 0x3c2ab4b3, 0x319ee9d5, 0xc021b8f7,
+	0x9b540b19, 0x875fa099, 0x95f7997e, 0x623d7da8,
+	0xf837889a, 0x97e32d77, 0x11ed935f, 0x16681281,
+	0x0e358829, 0xc7e61fd6, 0x96dedfa1, 0x7858ba99,
+	0x57f584a5, 0x1b227263, 0x9b83c3ff, 0x1ac24696,
+	0xcdb30aeb, 0x532e3054, 0x8fd948e4, 0x6dbc3128,
+	0x58ebf2ef, 0x34c6ffea, 0xfe28ed61, 0xee7c3c73,
+	0x5d4a14d9, 0xe864b7e3, 0x42105d14, 0x203e13e0,
+	0x45eee2b6, 0xa3aaabea, 0xdb6c4f15, 0xfacb4fd0,
+	0xc742f442, 0xef6abbb5, 0x654f3b1d, 0x41cd2105,
+	0xd81e799e, 0x86854dc7, 0xe44b476a, 0x3d816250,
+	0xcf62a1f2, 0x5b8d2646, 0xfc8883a0, 0xc1c7b6a3,
+	0x7f1524c3, 0x69cb7492, 0x47848a0b, 0x5692b285,
+	0x095bbf00, 0xad19489d, 0x1462b174, 0x23820e00,
+	0x58428d2a, 0x0c55f5ea, 0x1dadf43e, 0x233f7061,
+	0x3372f092, 0x8d937e41, 0xd65fecf1, 0x6c223bdb,
+	0x7cde3759, 0xcbee7460, 0x4085f2a7, 0xce77326e,
+	0xa6078084, 0x19f8509e, 0xe8efd855, 0x61d99735,
+	0xa969a7aa, 0xc50c06c2, 0x5a04abfc, 0x800bcadc,
+	0x9e447a2e, 0xc3453484, 0xfdd56705, 0x0e1e9ec9,
+	0xdb73dbd3, 0x105588cd, 0x675fda79, 0xe3674340,
+	0xc5c43465, 0x713e38d8, 0x3d28f89e, 0xf16dff20,
+	0x153e21e7, 0x8fb03d4a, 0xe6e39f2b, 0xdb83adf7,
+	0xe93d5a68, 0x948140f7, 0xf64c261c, 0x94692934,
+	0x411520f7, 0x7602d4f7, 0xbcf46b2e, 0xd4a20068,
+	0xd4082471, 0x3320f46a, 0x43b7d4b7, 0x500061af,
+	0x1e39f62e, 0x97244546, 0x14214f74, 0xbf8b8840,
+	0x4d95fc1d, 0x96b591af, 0x70f4ddd3, 0x66a02f45,
+	0xbfbc09ec, 0x03bd9785, 0x7fac6dd0, 0x31cb8504,
+	0x96eb27b3, 0x55fd3941, 0xda2547e6, 0xabca0a9a,
+	0x28507825, 0x530429f4, 0x0a2c86da, 0xe9b66dfb,
+	0x68dc1462, 0xd7486900, 0x680ec0a4, 0x27a18dee,
+	0x4f3ffea2, 0xe887ad8c, 0xb58ce006, 0x7af4d6b6,
+	0xaace1e7c, 0xd3375fec, 0xce78a399, 0x406b2a42,
+	0x20fe9e35, 0xd9f385b9, 0xee39d7ab, 0x3b124e8b,
+	0x1dc9faf7, 0x4b6d1856, 0x26a36631, 0xeae397b2,
+	0x3a6efa74, 0xdd5b4332, 0x6841e7f7, 0xca7820fb,
+	0xfb0af54e, 0xd8feb397, 0x454056ac, 0xba489527,
+	0x55533a3a, 0x20838d87, 0xfe6ba9b7, 0xd096954b,
+	0x55a867bc, 0xa1159a58, 0xcca92963, 0x99e1db33,
+	0xa62a4a56, 0x3f3125f9, 0x5ef47e1c, 0x9029317c,
+	0xfdf8e802, 0x04272f70, 0x80bb155c, 0x05282ce3,
+	0x95c11548, 0xe4c66d22, 0x48c1133f, 0xc70f86dc,
+	0x07f9c9ee, 0x41041f0f, 0x404779a4, 0x5d886e17,
+	0x325f51eb, 0xd59bc0d1, 0xf2bcc18f, 0x41113564,
+	0x257b7834, 0x602a9c60, 0xdff8e8a3, 0x1f636c1b,
+	0x0e12b4c2, 0x02e1329e, 0xaf664fd1, 0xcad18115,
+	0x6b2395e0, 0x333e92e1, 0x3b240b62, 0xeebeb922,
+	0x85b2a20e, 0xe6ba0d99, 0xde720c8c, 0x2da2f728,
+	0xd0127845, 0x95b794fd, 0x647d0862, 0xe7ccf5f0,
+	0x5449a36f, 0x877d48fa, 0xc39dfd27, 0xf33e8d1e,
+	0x0a476341, 0x992eff74, 0x3a6f6eab, 0xf4f8fd37,
+	0xa812dc60, 0xa1ebddf8, 0x991be14c, 0xdb6e6b0d,
+	0xc67b5510, 0x6d672c37, 0x2765d43b, 0xdcd0e804,
+	0xf1290dc7, 0xcc00ffa3, 0xb5390f92, 0x690fed0b,
+	0x667b9ffb, 0xcedb7d9c, 0xa091cf0b, 0xd9155ea3,
+	0xbb132f88, 0x515bad24, 0x7b9479bf, 0x763bd6eb,
+	0x37392eb3, 0xcc115979, 0x8026e297, 0xf42e312d,
+	0x6842ada7, 0xc66a2b3b, 0x12754ccc, 0x782ef11c,
+	0x6a124237, 0xb79251e7, 0x06a1bbe6, 0x4bfb6350,
+	0x1a6b1018, 0x11caedfa, 0x3d25bdd8, 0xe2e1c3c9,
+	0x44421659, 0x0a121386, 0xd90cec6e, 0xd5abea2a,
+	0x64af674e, 0xda86a85f, 0xbebfe988, 0x64e4c3fe,
+	0x9dbc8057, 0xf0f7c086, 0x60787bf8, 0x6003604d,
+	0xd1fd8346, 0xf6381fb0, 0x7745ae04, 0xd736fccc,
+	0x83426b33, 0xf01eab71, 0xb0804187, 0x3c005e5f,
+	0x77a057be, 0xbde8ae24, 0x55464299, 0xbf582e61,
+	0x4e58f48f, 0xf2ddfda2, 0xf474ef38, 0x8789bdc2,
+	0x5366f9c3, 0xc8b38e74, 0xb475f255, 0x46fcd9b9,
+	0x7aeb2661, 0x8b1ddf84, 0x846a0e79, 0x915f95e2,
+	0x466e598e, 0x20b45770, 0x8cd55591, 0xc902de4c,
+	0xb90bace1, 0xbb8205d0, 0x11a86248, 0x7574a99e,
+	0xb77f19b6, 0xe0a9dc09, 0x662d09a1, 0xc4324633,
+	0xe85a1f02, 0x09f0be8c, 0x4a99a025, 0x1d6efe10,
+	0x1ab93d1d, 0x0ba5a4df, 0xa186f20f, 0x2868f169,
+	0xdcb7da83, 0x573906fe, 0xa1e2ce9b, 0x4fcd7f52,
+	0x50115e01, 0xa70683fa, 0xa002b5c4, 0x0de6d027,
+	0x9af88c27, 0x773f8641, 0xc3604c06, 0x61a806b5,
+	0xf0177a28, 0xc0f586e0, 0x006058aa, 0x30dc7d62,
+	0x11e69ed7, 0x2338ea63, 0x53c2dd94, 0xc2c21634,
+	0xbbcbee56, 0x90bcb6de, 0xebfc7da1, 0xce591d76,
+	0x6f05e409, 0x4b7c0188, 0x39720a3d, 0x7c927c24,
+	0x86e3725f, 0x724d9db9, 0x1ac15bb4, 0xd39eb8fc,
+	0xed545578, 0x08fca5b5, 0xd83d7cd3, 0x4dad0fc4,
+	0x1e50ef5e, 0xb161e6f8, 0xa28514d9, 0x6c51133c,
+	0x6fd5c7e7, 0x56e14ec4, 0x362abfce, 0xddc6c837,
+	0xd79a3234, 0x92638212, 0x670efa8e, 0x406000e0,
+	0x3a39ce37, 0xd3faf5cf, 0xabc27737, 0x5ac52d1b,
+	0x5cb0679e, 0x4fa33742, 0xd3822740, 0x99bc9bbe,
+	0xd5118e9d, 0xbf0f7315, 0xd62d1c7e, 0xc700c47b,
+	0xb78c1b6b, 0x21a19045, 0xb26eb1be, 0x6a366eb4,
+	0x5748ab2f, 0xbc946e79, 0xc6a376d2, 0x6549c2c8,
+	0x530ff8ee, 0x468dde7d, 0xd5730a1d, 0x4cd04dc6,
+	0x2939bbdb, 0xa9ba4650, 0xac9526e8, 0xbe5ee304,
+	0xa1fad5f0, 0x6a2d519a, 0x63ef8ce2, 0x9a86ee22,
+	0xc089c2b8, 0x43242ef6, 0xa51e03aa, 0x9cf2d0a4,
+	0x83c061ba, 0x9be96a4d, 0x8fe51550, 0xba645bd6,
+	0x2826a2f9, 0xa73a3ae1, 0x4ba99586, 0xef5562e9,
+	0xc72fefd3, 0xf752f7da, 0x3f046f69, 0x77fa0a59,
+	0x80e4a915, 0x87b08601, 0x9b09e6ad, 0x3b3ee593,
+	0xe990fd5a, 0x9e34d797, 0x2cf0b7d9, 0x022b8b51,
+	0x96d5ac3a, 0x017da67d, 0xd1cf3ed6, 0x7c7d2d28,
+	0x1f9f25cf, 0xadf2b89b, 0x5ad6b472, 0x5a88f54c,
+	0xe029ac71, 0xe019a5e6, 0x47b0acfd, 0xed93fa9b,
+	0xe8d3c48d, 0x283b57cc, 0xf8d56629, 0x79132e28,
+	0x785f0191, 0xed756055, 0xf7960e44, 0xe3d35e8c,
+	0x15056dd4, 0x88f46dba, 0x03a16125, 0x0564f0bd,
+	0xc3eb9e15, 0x3c9057a2, 0x97271aec, 0xa93a072a,
+	0x1b3f6d9b, 0x1e6321f5, 0xf59c66fb, 0x26dcf319,
+	0x7533d928, 0xb155fdf5, 0x03563482, 0x8aba3cbb,
+	0x28517711, 0xc20ad9f8, 0xabcc5167, 0xccad925f,
+	0x4de81751, 0x3830dc8e, 0x379d5862, 0x9320f991,
+	0xea7a90c2, 0xfb3e7bce, 0x5121ce64, 0x774fbe32,
+	0xa8b6e37e, 0xc3293d46, 0x48de5369, 0x6413e680,
+	0xa2ae0810, 0xdd6db224, 0x69852dfd, 0x09072166,
+	0xb39a460a, 0x6445c0dd, 0x586cdecf, 0x1c20c8ae,
+	0x5bbef7dd, 0x1b588d40, 0xccd2017f, 0x6bb4e3bb,
+	0xdda26a7e, 0x3a59ff45, 0x3e350a44, 0xbcb4cdd5,
+	0x72eacea8, 0xfa6484bb, 0x8d6612ae, 0xbf3c6f47,
+	0xd29be463, 0x542f5d9e, 0xaec2771b, 0xf64e6370,
+	0x740e0d8d, 0xe75b1357, 0xf8721671, 0xaf537d5d,
+	0x4040cb08, 0x4eb4e2cc, 0x34d2466a, 0x0115af84,
+	0xe1b00428, 0x95983a1d, 0x06b89fb4, 0xce6ea048,
+	0x6f3f3b82, 0x3520ab82, 0x011a1d4b, 0x277227f8,
+	0x611560b1, 0xe7933fdc, 0xbb3a792b, 0x344525bd,
+	0xa08839e1, 0x51ce794b, 0x2f32c9b7, 0xa01fbac9,
+	0xe01cc87e, 0xbcc7d1f6, 0xcf0111c3, 0xa1e8aac7,
+	0x1a908749, 0xd44fbd9a, 0xd0dadecb, 0xd50ada38,
+	0x0339c32a, 0xc6913667, 0x8df9317c, 0xe0b12b4f,
+	0xf79e59b7, 0x43f5bb3a, 0xf2d519ff, 0x27d9459c,
+	0xbf97222c, 0x15e6fc2a, 0x0f91fc71, 0x9b941525,
+	0xfae59361, 0xceb69ceb, 0xc2a86459, 0x12baa8d1,
+	0xb6c1075e, 0xe3056a0c, 0x10d25065, 0xcb03a442,
+	0xe0ec6e0e, 0x1698db3b, 0x4c98a0be, 0x3278e964,
+	0x9f1f9532, 0xe0d392df, 0xd3a0342b, 0x8971f21e,
+	0x1b0a7441, 0x4ba3348c, 0xc5be7120, 0xc37632d8,
+	0xdf359f8d, 0x9b992f2e, 0xe60b6f47, 0x0fe3f11d,
+	0xe54cda54, 0x1edad891, 0xce6279cf, 0xcd3e7e6f,
+	0x1618b166, 0xfd2c1d05, 0x848fd2c5, 0xf6fb2299,
+	0xf523f357, 0xa6327623, 0x93a83531, 0x56cccd02,
+	0xacf08162, 0x5a75ebb5, 0x6e163697, 0x88d273cc,
+	0xde966292, 0x81b949d0, 0x4c50901b, 0x71c65614,
+	0xe6c6c7bd, 0x327a140a, 0x45e1d006, 0xc3f27b9a,
+	0xc9aa53fd, 0x62a80f00, 0xbb25bfe2, 0x35bdd2f6,
+	0x71126905, 0xb2040222, 0xb6cbcf7c, 0xcd769c2b,
+	0x53113ec0, 0x1640e3d3, 0x38abbd60, 0x2547adf0,
+	0xba38209c, 0xf746ce76, 0x77afa1c5, 0x20756060,
+	0x85cbfe4e, 0x8ae88dd8, 0x7aaaf9b0, 0x4cf9aa7e,
+	0x1948c25c, 0x02fb8a8c, 0x01c36ae4, 0xd6ebe1f9,
+	0x90d4f869, 0xa65cdea0, 0x3f09252d, 0xc208e69f,
+	0xb74e6132, 0xce77e25b, 0x578fdfe3, 0x3ac372e6,
+};
+
+/* 
+ * Round loop unrolling macros, S is a pointer to a S-Box array
+ * organized in 4 unsigned longs at a row.
+ */
+#define GET32_3(x) (((x) & 0xff))
+#define GET32_2(x) (((x) >> (8)) & (0xff))
+#define GET32_1(x) (((x) >> (16)) & (0xff))
+#define GET32_0(x) (((x) >> (24)) & (0xff))
+
+#define bf_F(x) (((S[GET32_0(x)] + S[256 + GET32_1(x)]) ^ \
+          S[512 + GET32_2(x)]) + S[768 + GET32_3(x)])
+
+#define ROUND(a, b, n)  b ^= P[n]; a ^= bf_F (b)
+
+/*
+ * The blowfish encipher, processes 64-bit blocks.
+ * NOTE: This function MUSTN'T respect endianess 
+ */
+static inline void encrypt_block(struct bf_ctx *bctx, u32 *dst, u32 *src)
+{
+	const u32 *P = bctx->p;
+	const u32 *S = bctx->s;
+	u32 yl = src[0];
+	u32 yr = src[1];
+
+	ROUND(yr, yl, 0);
+	ROUND(yl, yr, 1);
+	ROUND(yr, yl, 2);
+	ROUND(yl, yr, 3);
+	ROUND(yr, yl, 4);
+	ROUND(yl, yr, 5);
+	ROUND(yr, yl, 6);
+	ROUND(yl, yr, 7);
+	ROUND(yr, yl, 8);
+	ROUND(yl, yr, 9);
+	ROUND(yr, yl, 10);
+	ROUND(yl, yr, 11);
+	ROUND(yr, yl, 12);
+	ROUND(yl, yr, 13);
+	ROUND(yr, yl, 14);
+	ROUND(yl, yr, 15);
+
+	yl ^= P[16];
+	yr ^= P[17];
+
+	dst[0] = yr;
+	dst[1] = yl;
+}
+
+static void bf_encrypt(void *ctx, u8 *dst, const u8 *src)
+{
+	const u32 *in_blk = (const u32 *)src;
+	u32 *const out_blk = (u32 *)dst;
+	u32 in32[2], out32[2];
+
+	in32[0] = be32_to_cpu(in_blk[0]);
+	in32[1] = be32_to_cpu(in_blk[1]);
+	encrypt_block(ctx, out32, in32);
+	out_blk[0] = cpu_to_be32(out32[0]);
+	out_blk[1] = cpu_to_be32(out32[1]);
+}
+
+static void bf_decrypt(void *ctx, u8 *dst, const u8 *src)
+{
+	const u32 *in_blk = (const u32 *)src;
+	u32 *const out_blk = (u32 *)dst;
+	const u32 *P = ((struct bf_ctx *)ctx)->p;
+	const u32 *S = ((struct bf_ctx *)ctx)->s;
+	u32 yl = be32_to_cpu(in_blk[0]);
+	u32 yr = be32_to_cpu(in_blk[1]);
+
+	ROUND(yr, yl, 17);
+	ROUND(yl, yr, 16);
+	ROUND(yr, yl, 15);
+	ROUND(yl, yr, 14);
+	ROUND(yr, yl, 13);
+	ROUND(yl, yr, 12);
+	ROUND(yr, yl, 11);
+	ROUND(yl, yr, 10);
+	ROUND(yr, yl, 9);
+	ROUND(yl, yr, 8);
+	ROUND(yr, yl, 7);
+	ROUND(yl, yr, 6);
+	ROUND(yr, yl, 5);
+	ROUND(yl, yr, 4);
+	ROUND(yr, yl, 3);
+	ROUND(yl, yr, 2);
+
+	yl ^= P[1];
+	yr ^= P[0];
+
+	out_blk[0] = cpu_to_be32(yr);
+	out_blk[1] = cpu_to_be32(yl);
+}
+
+/* 
+ * Calculates the blowfish S and P boxes for encryption and decryption.
+ */
+static int bf_setkey(void *ctx, const u8 *key, unsigned int keylen, u32 *flags)
+{
+	short i, j, count;
+	u32 data[2], temp;
+	u32 *P = ((struct bf_ctx *)ctx)->p;
+	u32 *S = ((struct bf_ctx *)ctx)->s;
+
+	/* Copy the initialization s-boxes */
+	for (i = 0, count = 0; i < 256; i++)
+		for (j = 0; j < 4; j++, count++)
+			S[count] = bf_sbox[count];
+
+	/* Set the p-boxes */
+	for (i = 0; i < 16 + 2; i++)
+		P[i] = bf_pbox[i];
+
+	/* Actual subkey generation */
+	for (j = 0, i = 0; i < 16 + 2; i++) {
+		temp = (((u32 )key[j] << 24) |
+			((u32 )key[(j + 1) % keylen] << 16) |
+			((u32 )key[(j + 2) % keylen] << 8) |
+			((u32 )key[(j + 3) % keylen]));
+
+		P[i] = P[i] ^ temp;
+		j = (j + 4) % keylen;
+	}
+
+	data[0] = 0x00000000;
+	data[1] = 0x00000000;
+
+	for (i = 0; i < 16 + 2; i += 2) {
+		encrypt_block((struct bf_ctx *)ctx, data, data);
+
+		P[i] = data[0];
+		P[i + 1] = data[1];
+	}
+
+	for (i = 0; i < 4; i++) {
+		for (j = 0, count = i * 256; j < 256; j += 2, count += 2) {
+			encrypt_block((struct bf_ctx *)ctx, data, data);
+
+			S[count] = data[0];
+			S[count + 1] = data[1];
+		}
+	}
+	
+	/* Bruce says not to bother with the weak key check. */
+	return 0;
+}
+
+static struct crypto_alg alg = {
+	.cra_name		=	"blowfish",
+	.cra_flags		=	CRYPTO_ALG_TYPE_CIPHER,
+	.cra_blocksize		=	BF_BLOCK_SIZE,
+	.cra_ctxsize		=	sizeof(struct bf_ctx),
+	.cra_module		=	THIS_MODULE,
+	.cra_list		=	LIST_HEAD_INIT(alg.cra_list),
+	.cra_u			=	{ .cipher = {
+	.cia_min_keysize	=	BF_MIN_KEY_SIZE,
+	.cia_max_keysize	=	BF_MAX_KEY_SIZE,
+	.cia_ivsize		=	BF_BLOCK_SIZE,
+	.cia_setkey   		= 	bf_setkey,
+	.cia_encrypt 		=	bf_encrypt,
+	.cia_decrypt  		=	bf_decrypt } }
+};
+
+static int __init init(void)
+{
+	return crypto_register_alg(&alg);
+}
+
+static void __exit fini(void)
+{
+	crypto_unregister_alg(&alg);
+}
+
+module_init(init);
+module_exit(fini);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Blowfish Cipher Algorithm");
diff -Nru a/crypto/cipher.c b/crypto/cipher.c
--- a/crypto/cipher.c	Thu Nov  7 01:49:12 2002
+++ b/crypto/cipher.c	Thu Nov  7 01:49:12 2002
@@ -188,8 +188,14 @@
 
 static int setkey(struct crypto_tfm *tfm, const u8 *key, unsigned int keylen)
 {
-	return tfm->__crt_alg->cra_cipher.cia_setkey(tfm->crt_ctx, key,
-	                                             keylen, &tfm->crt_flags);
+	struct cipher_alg *cia = &tfm->__crt_alg->cra_cipher;
+	
+	if (keylen < cia->cia_min_keysize || keylen > cia->cia_max_keysize) {
+		tfm->crt_flags |= CRYPTO_TFM_RES_BAD_KEY_LEN;
+		return -EINVAL;
+	} else
+		return cia->cia_setkey(tfm->crt_ctx, key, keylen,
+		                       &tfm->crt_flags);
 }
 
 static int ecb_encrypt(struct crypto_tfm *tfm,
diff -Nru a/crypto/des.c b/crypto/des.c
--- a/crypto/des.c	Thu Nov  7 01:49:12 2002
+++ b/crypto/des.c	Thu Nov  7 01:49:12 2002
@@ -1032,11 +1032,6 @@
 	u32 n, w;
 	u8 bits0[56], bits1[56];
 
-	if (keylen != DES_KEY_SIZE) {
-		*flags |= CRYPTO_TFM_RES_BAD_KEY_LEN;
-		return -EINVAL;
-	}
-
 	n  = parity[key[0]]; n <<= 4;
 	n |= parity[key[1]]; n <<= 4;
 	n |= parity[key[2]]; n <<= 4;
@@ -1208,11 +1203,6 @@
 	unsigned int i, off;
 	struct des3_ede_ctx *dctx = ctx;
 
-	if (keylen != DES3_EDE_KEY_SIZE) {
-		*flags |= CRYPTO_TFM_RES_BAD_KEY_LEN;
-		return -EINVAL;
-	}
-
 	if (!(memcmp(key, &key[DES_KEY_SIZE], DES_KEY_SIZE) && 
 	    memcmp(&key[DES_KEY_SIZE], &key[DES_KEY_SIZE * 2],
 	    					DES_KEY_SIZE))) {
@@ -1249,33 +1239,35 @@
 }
 
 static struct crypto_alg des_alg = {
-	.cra_name	=	"des",
-	.cra_flags	=	CRYPTO_ALG_TYPE_CIPHER,
-	.cra_blocksize	=	DES_BLOCK_SIZE,
-	.cra_ctxsize	=	sizeof(struct des_ctx),
-	.cra_module	=	THIS_MODULE,
-	.cra_list	=	LIST_HEAD_INIT(des_alg.cra_list),
-	.cra_u		=	{ .cipher = {
-	.cia_keysize	=	DES_KEY_SIZE,
-	.cia_ivsize	=	DES_BLOCK_SIZE,
-	.cia_setkey   	= 	des_setkey,
-	.cia_encrypt 	=	des_encrypt,
-	.cia_decrypt  	=	des_decrypt } }
+	.cra_name		=	"des",
+	.cra_flags		=	CRYPTO_ALG_TYPE_CIPHER,
+	.cra_blocksize		=	DES_BLOCK_SIZE,
+	.cra_ctxsize		=	sizeof(struct des_ctx),
+	.cra_module		=	THIS_MODULE,
+	.cra_list		=	LIST_HEAD_INIT(des_alg.cra_list),
+	.cra_u			=	{ .cipher = {
+	.cia_min_keysize	=	DES_KEY_SIZE,
+	.cia_max_keysize	=	DES_KEY_SIZE,
+	.cia_ivsize		=	DES_BLOCK_SIZE,
+	.cia_setkey		= 	des_setkey,
+	.cia_encrypt		=	des_encrypt,
+	.cia_decrypt		=	des_decrypt } }
 };
 
 static struct crypto_alg des3_ede_alg = {
-	.cra_name	=	"des3_ede",
-	.cra_flags	=	CRYPTO_ALG_TYPE_CIPHER,
-	.cra_blocksize	=	DES3_EDE_BLOCK_SIZE,
-	.cra_ctxsize	=	sizeof(struct des3_ede_ctx),
-	.cra_module	=	THIS_MODULE,
-	.cra_list	=	LIST_HEAD_INIT(des3_ede_alg.cra_list),
-	.cra_u		=	{ .cipher = {
-	.cia_keysize	=	DES3_EDE_KEY_SIZE,
-	.cia_ivsize	=	DES3_EDE_BLOCK_SIZE,
-	.cia_setkey   	= 	des3_ede_setkey,
-	.cia_encrypt 	=	des3_ede_encrypt,
-	.cia_decrypt  	=	des3_ede_decrypt } }
+	.cra_name		=	"des3_ede",
+	.cra_flags		=	CRYPTO_ALG_TYPE_CIPHER,
+	.cra_blocksize		=	DES3_EDE_BLOCK_SIZE,
+	.cra_ctxsize		=	sizeof(struct des3_ede_ctx),
+	.cra_module		=	THIS_MODULE,
+	.cra_list		=	LIST_HEAD_INIT(des3_ede_alg.cra_list),
+	.cra_u			=	{ .cipher = {
+	.cia_min_keysize	=	DES3_EDE_KEY_SIZE,
+	.cia_max_keysize	=	DES3_EDE_KEY_SIZE,
+	.cia_ivsize		=	DES3_EDE_BLOCK_SIZE,
+	.cia_setkey	   	= 	des3_ede_setkey,
+	.cia_encrypt	 	=	des3_ede_encrypt,
+	.cia_decrypt	  	=	des3_ede_decrypt } }
 };
 
 static int __init init(void)
diff -Nru a/crypto/tcrypt.c b/crypto/tcrypt.c
--- a/crypto/tcrypt.c	Thu Nov  7 01:49:12 2002
+++ b/crypto/tcrypt.c	Thu Nov  7 01:49:12 2002
@@ -47,7 +47,7 @@
 static char *tvmem;
 
 static char *check[] = {
-	"des", "md5", "des3_ede", "rot13", "sha1", "sha256",
+	"des", "md5", "des3_ede", "rot13", "sha1", "sha256", "blowfish",
 	 NULL
 };
 
@@ -1480,6 +1480,210 @@
 	crypto_free_tfm(tfm);
 }
 
+void
+test_blowfish(void)
+{
+	unsigned int ret, i;
+	unsigned int tsize;
+	char *p, *q;
+	struct crypto_tfm *tfm;
+	char *key;
+	struct bf_tv *bf_tv;
+	struct scatterlist sg[1];
+
+	printk("\ntesting blowfish encryption\n");
+
+	tsize = sizeof (bf_enc_tv_template);
+	if (tsize > TVMEMSIZE) {
+		printk("template (%u) too big for tvmem (%u)\n", tsize,
+		       TVMEMSIZE);
+		return;
+	}
+
+	memcpy(tvmem, bf_enc_tv_template, tsize);
+	bf_tv = (void *) tvmem;
+
+	tfm = crypto_alloc_tfm("blowfish", 0);
+	if (tfm == NULL) {
+		printk("failed to load transform for blowfish (default ecb)\n");
+		return;
+	}
+
+	for (i = 0; i < BF_ENC_TEST_VECTORS; i++) {
+		printk("test %u (%d bit key):\n",
+			i + 1, bf_tv[i].keylen * 8);
+		key = bf_tv[i].key;
+
+		ret = crypto_cipher_setkey(tfm, key, bf_tv[i].keylen);
+		if (ret) {
+			printk("setkey() failed flags=%x\n", tfm->crt_flags);
+
+			if (!bf_tv[i].fail)
+				goto out;
+		}
+
+		p = bf_tv[i].plaintext;
+		sg[0].page = virt_to_page(p);
+		sg[0].offset = ((long) p & ~PAGE_MASK);
+		sg[0].length = bf_tv[i].plen;
+		ret = crypto_cipher_encrypt(tfm, sg, 1);
+		if (ret) {
+			printk("encrypt() failed flags=%x\n", tfm->crt_flags);
+			goto out;
+		}
+
+		q = kmap(sg[0].page) + sg[0].offset;
+		hexdump(q, bf_tv[i].rlen);
+
+		printk("%s\n", memcmp(q, bf_tv[i].result, bf_tv[i].rlen) ?
+			"fail" : "pass");
+	}
+
+	printk("\ntesting blowfish decryption\n");
+
+	tsize = sizeof (bf_dec_tv_template);
+	if (tsize > TVMEMSIZE) {
+		printk("template (%u) too big for tvmem (%u)\n", tsize,
+		       TVMEMSIZE);
+		return;
+	}
+
+	memcpy(tvmem, bf_dec_tv_template, tsize);
+	bf_tv = (void *) tvmem;
+
+	for (i = 0; i < BF_DEC_TEST_VECTORS; i++) {
+		printk("test %u (%d bit key):\n",
+			i + 1, bf_tv[i].keylen * 8);
+		key = bf_tv[i].key;
+
+		ret = crypto_cipher_setkey(tfm, key, bf_tv[i].keylen);
+		if (ret) {
+			printk("setkey() failed flags=%x\n", tfm->crt_flags);
+
+			if (!bf_tv[i].fail)
+				goto out;
+		}
+
+		p = bf_tv[i].plaintext;
+		sg[0].page = virt_to_page(p);
+		sg[0].offset = ((long) p & ~PAGE_MASK);
+		sg[0].length = bf_tv[i].plen;
+		ret = crypto_cipher_decrypt(tfm, sg, 1);
+		if (ret) {
+			printk("decrypt() failed flags=%x\n", tfm->crt_flags);
+			goto out;
+		}
+
+		q = kmap(sg[0].page) + sg[0].offset;
+		hexdump(q, bf_tv[i].rlen);
+
+		printk("%s\n", memcmp(q, bf_tv[i].result, bf_tv[i].rlen) ?
+			"fail" : "pass");
+	}
+	
+	crypto_free_tfm(tfm);
+	
+	tfm = crypto_alloc_tfm("blowfish", CRYPTO_TFM_MODE_CBC);
+	if (tfm == NULL) {
+		printk("failed to load transform for blowfish cbc\n");
+		return;
+	}
+
+	printk("\ntesting blowfish cbc encryption\n");
+
+	tsize = sizeof (bf_cbc_enc_tv_template);
+	if (tsize > TVMEMSIZE) {
+		printk("template (%u) too big for tvmem (%u)\n", tsize,
+		       TVMEMSIZE);
+		goto out;
+	}
+	memcpy(tvmem, bf_cbc_enc_tv_template, tsize);
+	bf_tv = (void *) tvmem;
+
+	for (i = 0; i < BF_CBC_ENC_TEST_VECTORS; i++) {
+		printk("test %u (%d bit key):\n",
+			i + 1, bf_tv[i].keylen * 8);
+
+		key = bf_tv[i].key;
+
+		ret = crypto_cipher_setkey(tfm, key, bf_tv[i].keylen);
+		if (ret) {
+			printk("setkey() failed flags=%x\n", tfm->crt_flags);
+			goto out;
+		}
+
+		p = bf_tv[i].plaintext;
+
+		sg[0].page = virt_to_page(p);
+		sg[0].offset = ((long) p & ~PAGE_MASK);
+		sg[0].length =  bf_tv[i].plen;;
+
+		crypto_cipher_set_iv(tfm, bf_tv[i].iv,
+				     crypto_tfm_alg_ivsize(tfm));
+
+		ret = crypto_cipher_encrypt(tfm, sg, 1);
+		if (ret) {
+			printk("blowfish_cbc_encrypt() failed flags=%x\n",
+			       tfm->crt_flags);
+			goto out;
+		}
+
+		q = kmap(sg[0].page) + sg[0].offset;
+		hexdump(q, bf_tv[i].rlen);
+
+		printk("%s\n", memcmp(q, bf_tv[i].result, bf_tv[i].rlen)
+			? "fail" : "pass");
+	}
+
+	printk("\ntesting blowfish cbc decryption\n");
+
+	tsize = sizeof (bf_cbc_dec_tv_template);
+	if (tsize > TVMEMSIZE) {
+		printk("template (%u) too big for tvmem (%u)\n", tsize,
+		       TVMEMSIZE);
+		goto out;
+	}
+	memcpy(tvmem, bf_cbc_dec_tv_template, tsize);
+	bf_tv = (void *) tvmem;
+
+	for (i = 0; i < BF_CBC_ENC_TEST_VECTORS; i++) {
+		printk("test %u (%d bit key):\n",
+			i + 1, bf_tv[i].keylen * 8);
+		key = bf_tv[i].key;
+
+		ret = crypto_cipher_setkey(tfm, key, bf_tv[i].keylen);
+		if (ret) {
+			printk("setkey() failed flags=%x\n", tfm->crt_flags);
+			goto out;
+		}
+
+		p = bf_tv[i].plaintext;
+
+		sg[0].page = virt_to_page(p);
+		sg[0].offset = ((long) p & ~PAGE_MASK);
+		sg[0].length =  bf_tv[i].plen;;
+
+		crypto_cipher_set_iv(tfm, bf_tv[i].iv,
+				     crypto_tfm_alg_ivsize(tfm));
+
+		ret = crypto_cipher_decrypt(tfm, sg, 1);
+		if (ret) {
+			printk("blowfish_cbc_decrypt() failed flags=%x\n",
+			       tfm->crt_flags);
+			goto out;
+		}
+
+		q = kmap(sg[0].page) + sg[0].offset;
+		hexdump(q, bf_tv[i].rlen);
+
+		printk("%s\n", memcmp(q, bf_tv[i].result, bf_tv[i].rlen)
+			? "fail" : "pass");
+	}
+
+out:
+	crypto_free_tfm(tfm);
+}
+
 static void
 test_available(void)
 {
@@ -1504,6 +1708,8 @@
 		test_des();
 		test_des3_ede();
 		test_md4();
+		test_sha256();
+		test_blowfish();
 #ifdef CONFIG_CRYPTO_HMAC
 		test_hmac_md5();
 		test_hmac_sha1();
@@ -1533,6 +1739,10 @@
 		
 	case 6:
 		test_sha256();
+		break;
+	
+	case 7:
+		test_blowfish();
 		break;
 
 #ifdef CONFIG_CRYPTO_HMAC
diff -Nru a/crypto/tcrypt.h b/crypto/tcrypt.h
--- a/crypto/tcrypt.h	Thu Nov  7 01:49:12 2002
+++ b/crypto/tcrypt.h	Thu Nov  7 01:49:12 2002
@@ -591,7 +591,7 @@
 };
 
 /*
- * DES test vectors (also need to test for weak keys etc).
+ * DES test vectors.
  */
 #define DES_ENC_TEST_VECTORS		5
 #define DES_DEC_TEST_VECTORS		2
@@ -972,6 +972,199 @@
 		{ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00  },
 	},
 };
+
+/*
+ * Blowfish test vectors.
+ */
+#define BF_ENC_TEST_VECTORS	6
+#define BF_DEC_TEST_VECTORS	6
+#define BF_CBC_ENC_TEST_VECTORS	1
+#define BF_CBC_DEC_TEST_VECTORS	1
+
+struct bf_tv {
+	unsigned int keylen;
+	unsigned int plen;
+	unsigned int rlen;
+	int fail;
+	char key[56];
+	char iv[8];
+	char plaintext[32];
+	char result[32];
+};
+
+struct bf_tv bf_enc_tv_template[] = {
+
+	/* DES test vectors from OpenSSL */
+	{
+		8, 8, 8, 0,
+		{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },
+		{ 0 },
+		{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
+		{ 0x4E, 0xF9, 0x97, 0x45, 0x61, 0x98, 0xDD, 0x78 },
+	},
 	
-#endif	/* _CRYPTO_TCRYPT_H */
+	{
+		8, 8, 8, 0,
+		{ 0x1F, 0x1F, 0x1F, 0x1F, 0x0E, 0x0E, 0x0E, 0x0E,  },
+		{ 0 },
+		{ 0x01, 0x23, 0x45, 0x67, 0x89, 0xAB, 0xCD, 0xEF },
+		{ 0xA7, 0x90, 0x79, 0x51, 0x08, 0xEA, 0x3C, 0xAE },
+	},
+	
+	{
+		8, 8, 8, 0,
+		{ 0xF0, 0xE1, 0xD2, 0xC3, 0xB4, 0xA5, 0x96, 0x87, },
+		{ 0 },
+		{ 0xFE, 0xDC, 0xBA, 0x98, 0x76, 0x54, 0x32, 0x10 },
+		{ 0xE8, 0x7A, 0x24, 0x4E, 0x2C, 0xC8, 0x5E, 0x82 }
+	},
+	
+	/* Vary the keylength... */
+	
+	{
+		16, 8, 8, 0,
+		{ 0xF0, 0xE1, 0xD2, 0xC3, 0xB4, 0xA5, 0x96, 0x87,
+		  0x78, 0x69, 0x5A, 0x4B, 0x3C, 0x2D, 0x1E, 0x0F },
+		{ 0 },
+		{ 0xFE, 0xDC, 0xBA, 0x98, 0x76, 0x54, 0x32, 0x10 },
+		{ 0x93, 0x14, 0x28, 0x87, 0xEE, 0x3B, 0xE1, 0x5C }
+	},
+	
+	{
+		21, 8, 8, 0,
+		{ 0xF0, 0xE1, 0xD2, 0xC3, 0xB4, 0xA5, 0x96, 0x87,
+		  0x78, 0x69, 0x5A, 0x4B, 0x3C, 0x2D, 0x1E, 0x0F,
+		  0x00, 0x11, 0x22, 0x33, 0x44 },
+		{ 0 },
+		{ 0xFE, 0xDC, 0xBA, 0x98, 0x76, 0x54, 0x32, 0x10 },
+		{ 0xE6, 0xF5, 0x1E, 0xD7, 0x9B, 0x9D, 0xB2, 0x1F }
+	},
+	
+	/* Generated with bf488 */
+	{
+		56, 8, 8, 0,
+		{ 0xF0, 0xE1, 0xD2, 0xC3, 0xB4, 0xA5, 0x96, 0x87,
+		  0x78, 0x69, 0x5A, 0x4B, 0x3C, 0x2D, 0x1E, 0x0F,
+		  0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
+		  0x04, 0x68, 0x91, 0x04, 0xC2, 0xFD, 0x3B, 0x2F, 
+		  0x58, 0x40, 0x23, 0x64, 0x1A, 0xBA, 0x61, 0x76, 
+		  0x1F, 0x1F, 0x1F, 0x1F, 0x0E, 0x0E, 0x0E, 0x0E, 
+		  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF },
+		  { 0 },
+		  { 0xFE, 0xDC, 0xBA, 0x98, 0x76, 0x54, 0x32, 0x10 },
+		  { 0xc0, 0x45, 0x04, 0x01, 0x2e, 0x4e, 0x1f, 0x53 }
+	}
+	
+};
+
+struct bf_tv bf_dec_tv_template[] = {
 
+	/* DES test vectors from OpenSSL */
+	{
+		8, 8, 8, 0,
+		{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },
+		{ 0 },
+		{ 0x4E, 0xF9, 0x97, 0x45, 0x61, 0x98, 0xDD, 0x78 },
+		{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 }
+	},
+	
+	{
+		8, 8, 8, 0,
+		{ 0x1F, 0x1F, 0x1F, 0x1F, 0x0E, 0x0E, 0x0E, 0x0E,  },
+		{ 0 },
+		{ 0xA7, 0x90, 0x79, 0x51, 0x08, 0xEA, 0x3C, 0xAE },
+		{ 0x01, 0x23, 0x45, 0x67, 0x89, 0xAB, 0xCD, 0xEF }
+	},
+	
+	{
+		8, 8, 8, 0,
+		{ 0xF0, 0xE1, 0xD2, 0xC3, 0xB4, 0xA5, 0x96, 0x87, },
+		{ 0 },
+		{ 0xE8, 0x7A, 0x24, 0x4E, 0x2C, 0xC8, 0x5E, 0x82 },
+		{ 0xFE, 0xDC, 0xBA, 0x98, 0x76, 0x54, 0x32, 0x10 }
+	},
+	
+	/* Vary the keylength... */
+	
+	{
+		16, 8, 8, 0,
+		{ 0xF0, 0xE1, 0xD2, 0xC3, 0xB4, 0xA5, 0x96, 0x87,
+		  0x78, 0x69, 0x5A, 0x4B, 0x3C, 0x2D, 0x1E, 0x0F },
+		{ 0 },
+		{ 0x93, 0x14, 0x28, 0x87, 0xEE, 0x3B, 0xE1, 0x5C },
+		{ 0xFE, 0xDC, 0xBA, 0x98, 0x76, 0x54, 0x32, 0x10 }
+	},
+	
+	{
+		21, 8, 8, 0,
+		{ 0xF0, 0xE1, 0xD2, 0xC3, 0xB4, 0xA5, 0x96, 0x87,
+		  0x78, 0x69, 0x5A, 0x4B, 0x3C, 0x2D, 0x1E, 0x0F,
+		  0x00, 0x11, 0x22, 0x33, 0x44 },
+		{ 0 },
+		{ 0xE6, 0xF5, 0x1E, 0xD7, 0x9B, 0x9D, 0xB2, 0x1F },
+		{ 0xFE, 0xDC, 0xBA, 0x98, 0x76, 0x54, 0x32, 0x10 }
+	},
+	
+	/* Generated with bf488, using OpenSSL, Libgcrypt and Nettle */
+	{
+		56, 8, 8, 0,
+		{ 0xF0, 0xE1, 0xD2, 0xC3, 0xB4, 0xA5, 0x96, 0x87,
+		  0x78, 0x69, 0x5A, 0x4B, 0x3C, 0x2D, 0x1E, 0x0F,
+		  0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
+		  0x04, 0x68, 0x91, 0x04, 0xC2, 0xFD, 0x3B, 0x2F, 
+		  0x58, 0x40, 0x23, 0x64, 0x1A, 0xBA, 0x61, 0x76, 
+		  0x1F, 0x1F, 0x1F, 0x1F, 0x0E, 0x0E, 0x0E, 0x0E, 
+		  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF },
+		{ 0 },
+		{ 0xc0, 0x45, 0x04, 0x01, 0x2e, 0x4e, 0x1f, 0x53 },
+		{ 0xFE, 0xDC, 0xBA, 0x98, 0x76, 0x54, 0x32, 0x10 }
+	}
+};
+
+struct bf_tv bf_cbc_enc_tv_template[] = {
+
+	/* From OpenSSL */
+	{
+		16, 32, 32, 0,
+		
+		{ 0x01, 0x23, 0x45, 0x67, 0x89, 0xAB, 0xCD, 0xEF,
+		  0xF0, 0xE1, 0xD2, 0xC3, 0xB4, 0xA5, 0x96, 0x87 },
+		  
+		{ 0xFE, 0xDC, 0xBA, 0x98, 0x76, 0x54, 0x32, 0x10 },
+		
+		{ 0x37, 0x36, 0x35, 0x34, 0x33, 0x32, 0x31, 0x20,
+		  0x4E, 0x6F, 0x77, 0x20, 0x69, 0x73, 0x20, 0x74,
+		  0x68, 0x65, 0x20, 0x74, 0x69, 0x6D, 0x65, 0x20,
+		  0x66, 0x6F, 0x72, 0x20, 0x00, 0x00, 0x00, 0x00 },
+		  
+		{ 0x6B, 0x77, 0xB4, 0xD6, 0x30, 0x06, 0xDE, 0xE6,
+		  0x05, 0xB1, 0x56, 0xE2, 0x74, 0x03, 0x97, 0x93,
+		  0x58, 0xDE, 0xB9, 0xE7, 0x15, 0x46, 0x16, 0xD9,
+		  0x59, 0xF1, 0x65, 0x2B, 0xD5, 0xFF, 0x92, 0xCC }
+	},
+};
+
+struct bf_tv bf_cbc_dec_tv_template[] = {
+
+	/* From OpenSSL */
+	{
+		16, 32, 32, 0,
+		
+		{ 0x01, 0x23, 0x45, 0x67, 0x89, 0xAB, 0xCD, 0xEF,
+		  0xF0, 0xE1, 0xD2, 0xC3, 0xB4, 0xA5, 0x96, 0x87 },
+		  
+		{ 0xFE, 0xDC, 0xBA, 0x98, 0x76, 0x54, 0x32, 0x10 },
+		
+		{ 0x6B, 0x77, 0xB4, 0xD6, 0x30, 0x06, 0xDE, 0xE6,
+		  0x05, 0xB1, 0x56, 0xE2, 0x74, 0x03, 0x97, 0x93,
+		  0x58, 0xDE, 0xB9, 0xE7, 0x15, 0x46, 0x16, 0xD9,
+		  0x59, 0xF1, 0x65, 0x2B, 0xD5, 0xFF, 0x92, 0xCC },
+		  
+		{ 0x37, 0x36, 0x35, 0x34, 0x33, 0x32, 0x31, 0x20,
+		  0x4E, 0x6F, 0x77, 0x20, 0x69, 0x73, 0x20, 0x74,
+		  0x68, 0x65, 0x20, 0x74, 0x69, 0x6D, 0x65, 0x20,
+		  0x66, 0x6F, 0x72, 0x20, 0x00, 0x00, 0x00, 0x00 }
+	},
+};
+
+#endif	/* _CRYPTO_TCRYPT_H */
diff -Nru a/include/linux/crypto.h b/include/linux/crypto.h
--- a/include/linux/crypto.h	Thu Nov  7 01:49:12 2002
+++ b/include/linux/crypto.h	Thu Nov  7 01:49:12 2002
@@ -67,7 +67,8 @@
  * via crypto_register_alg() and crypto_unregister_alg().
  */
 struct cipher_alg {
-	unsigned int cia_keysize;
+	unsigned int cia_min_keysize;
+	unsigned int cia_max_keysize;
 	unsigned int cia_ivsize;
 	int (*cia_setkey)(void *ctx, const u8 *key,
 	                  unsigned int keylen, u32 *flags);
@@ -208,9 +209,14 @@
 	return tfm->__crt_alg->cra_flags & CRYPTO_ALG_TYPE_MASK;
 }
 
-static inline unsigned int crypto_tfm_alg_keysize(struct crypto_tfm *tfm)
+static inline unsigned int crypto_tfm_alg_min_keysize(struct crypto_tfm *tfm)
 {
-	return tfm->__crt_alg->cra_cipher.cia_keysize;
+	return tfm->__crt_alg->cra_cipher.cia_min_keysize;
+}
+
+static inline unsigned int crypto_tfm_alg_max_keysize(struct crypto_tfm *tfm)
+{
+	return tfm->__crt_alg->cra_cipher.cia_max_keysize;
 }
 
 static inline unsigned int crypto_tfm_alg_ivsize(struct crypto_tfm *tfm)


ChangeSet@1.925.5.6, 2002-11-06 18:34:01-08:00, kuznet@ms2.inr.ac.ru
  [IPSEC]: Few changes to keep racoon ISAKMP daemon happy.

diff -Nru a/net/ipv4/xfrm_policy.c b/net/ipv4/xfrm_policy.c
--- a/net/ipv4/xfrm_policy.c	Thu Nov  7 01:49:14 2002
+++ b/net/ipv4/xfrm_policy.c	Thu Nov  7 01:49:14 2002
@@ -272,6 +272,25 @@
 	write_unlock_bh(&policy->lock);
 }
 
+/* Generate new index... KAME seems to generate them ordered by cost
+ * of an absolute inpredictability of ordering of rules. This will not pass. */
+static u32 xfrm_gen_index(int dir)
+{
+	u32 idx;
+	struct xfrm_policy *p;
+	static u32 pol_id;
+
+	for (;;) {
+		idx = (++pol_id ? : ++pol_id);
+		for (p = xfrm_policy_list[dir]; p; p = p->next) {
+			if (p->index == idx)
+				break;
+		}
+		if (!p)
+			return idx;
+	}
+}
+
 int xfrm_policy_insert(int dir, struct xfrm_policy *policy, int excl)
 {
 	struct xfrm_policy *pol, **p;
@@ -290,6 +309,7 @@
 	policy->next = pol ? pol->next : NULL;
 	*p = policy;
 	xfrm_policy_genid++;
+	policy->index = pol ? pol->index : xfrm_gen_index(dir);
 	write_unlock_bh(&xfrm_policy_lock);
 
 	if (pol) {
diff -Nru a/net/key/af_key.c b/net/key/af_key.c
--- a/net/key/af_key.c	Thu Nov  7 01:49:14 2002
+++ b/net/key/af_key.c	Thu Nov  7 01:49:14 2002
@@ -274,13 +274,13 @@
 	*new = *orig;
 }
 
-static void pfkey_error(struct sadb_msg *orig, int err)
+static int pfkey_error(struct sadb_msg *orig, int err, struct sock *sk)
 {
 	struct sk_buff *skb = alloc_skb(sizeof(struct sadb_msg) + 16, GFP_KERNEL);
 	struct sadb_msg *hdr;
 
 	if (!skb)
-		return;
+		return -ENOBUFS;
 
 	/* Woe be to the platform trying to support PFKEY yet
 	 * having normal errnos outside the 1-255 range, inclusive.
@@ -301,7 +301,9 @@
 	hdr->sadb_msg_len = (sizeof(struct sadb_msg) /
 			     sizeof(uint64_t));
 
-	pfkey_broadcast(skb, GFP_KERNEL, BROADCAST_ALL, NULL);
+	pfkey_broadcast(skb, GFP_KERNEL, BROADCAST_ONE, sk);
+
+	return 0;
 }
 
 static u8 sadb_ext_min_len[] = {
@@ -716,7 +718,7 @@
 		struct algo_desc *a = ealg_get_byname(x->ealg->alg_name);
 		sa->sadb_sa_encrypt = a ? a->desc.sadb_alg_id : 0;
 	}
-	sa->sadb_sa_flags = SADB_SAFLAGS_PFS;
+	sa->sadb_sa_flags = 0;
 
 	/* hard time */
 	if (hsc & 2) {
@@ -1538,6 +1540,7 @@
 		}
 	}
 	hdr->sadb_msg_len = size / sizeof(uint64_t);
+	hdr->sadb_msg_reserved = atomic_read(&xp->refcnt);
 	return skb;
 }
 
@@ -1638,7 +1641,6 @@
 	out_hdr->sadb_msg_type = hdr->sadb_msg_type;
 	out_hdr->sadb_msg_satype = 0;
 	out_hdr->sadb_msg_errno = 0;
-	out_hdr->sadb_msg_reserved = 0;
 	out_hdr->sadb_msg_seq = hdr->sadb_msg_seq;
 	out_hdr->sadb_msg_pid = hdr->sadb_msg_pid;
 	pfkey_broadcast(out_skb, GFP_ATOMIC, BROADCAST_ALL, sk);
@@ -1703,7 +1705,6 @@
 	out_hdr->sadb_msg_type = SADB_X_SPDDELETE;
 	out_hdr->sadb_msg_satype = 0;
 	out_hdr->sadb_msg_errno = 0;
-	out_hdr->sadb_msg_reserved = 0;
 	out_hdr->sadb_msg_seq = hdr->sadb_msg_seq;
 	out_hdr->sadb_msg_pid = hdr->sadb_msg_pid;
 	pfkey_broadcast(out_skb, GFP_ATOMIC, BROADCAST_ALL, sk);
@@ -1750,7 +1751,6 @@
 	out_hdr->sadb_msg_type = hdr->sadb_msg_type;
 	out_hdr->sadb_msg_satype = 0;
 	out_hdr->sadb_msg_errno = 0;
-	out_hdr->sadb_msg_reserved = 0;
 	out_hdr->sadb_msg_seq = hdr->sadb_msg_seq;
 	out_hdr->sadb_msg_pid = hdr->sadb_msg_pid;
 	pfkey_broadcast(out_skb, GFP_ATOMIC, BROADCAST_ALL, sk);
@@ -1780,7 +1780,6 @@
 	out_hdr->sadb_msg_type = SADB_X_SPDDUMP;
 	out_hdr->sadb_msg_satype = SADB_SATYPE_UNSPEC;
 	out_hdr->sadb_msg_errno = 0;
-	out_hdr->sadb_msg_reserved = 0;
 	out_hdr->sadb_msg_seq = count;
 	out_hdr->sadb_msg_pid = data->hdr->sadb_msg_pid;
 	pfkey_broadcast(out_skb, GFP_ATOMIC, BROADCAST_ONE, data->sk);
@@ -1995,7 +1994,7 @@
 	out_hdr->sadb_msg_seq = 0;
 	out_hdr->sadb_msg_pid = 0;
 
-	pfkey_broadcast(out_skb, GFP_KERNEL, BROADCAST_REGISTERED, NULL);
+	pfkey_broadcast(out_skb, GFP_ATOMIC, BROADCAST_REGISTERED, NULL);
 	return 0;
 }
 
@@ -2166,8 +2165,8 @@
 	err = pfkey_process(sk, skb, hdr);
 
 out:
-	if (err && hdr)
-		pfkey_error(hdr, err);
+	if (err && hdr && pfkey_error(hdr, err, sk) == 0)
+		err = 0;
 	if (skb)
 		kfree_skb(skb);
 


ChangeSet@1.925.5.7, 2002-11-06 21:57:07-08:00, davem@nuts.ninka.net
  [CRYPTO]: Make sha256.c more palatable to GCCs optimizers.

diff -Nru a/crypto/sha256.c b/crypto/sha256.c
--- a/crypto/sha256.c	Thu Nov  7 01:49:16 2002
+++ b/crypto/sha256.c	Thu Nov  7 01:49:16 2002
@@ -32,9 +32,21 @@
 	u8 buf[128];
 };
 
-#define Ch(x,y,z)   ((x & y) ^ (~x & z))
-#define Maj(x,y,z)  ((x & y) ^ ( x & z) ^ (y & z))
-#define RORu32(x,y) ( ((x) >> (y)) | ((x) << (32-(y))) )
+static inline u32 Ch(u32 x, u32 y, u32 z)
+{
+	return ((x & y) ^ (~x & z));
+}
+
+static inline u32 Maj(u32 x, u32 y, u32 z)
+{
+	return ((x & y) ^ (x & z) ^ (y & z));
+}
+
+static inline u32 RORu32(u32 x, u32 y)
+{
+	return (x >> y) | (x << (32 - y));
+}
+
 #define e0(x)       (RORu32(x, 2) ^ RORu32(x,13) ^ RORu32(x,22))
 #define e1(x)       (RORu32(x, 6) ^ RORu32(x,11) ^ RORu32(x,25))
 #define s0(x)       (RORu32(x, 7) ^ RORu32(x,18) ^ (x >> 3))
@@ -49,41 +61,37 @@
 #define H6         0x1f83d9ab
 #define H7         0x5be0cd19
 
-#define LOAD_OP(I)\
- {\
-  t1  = input[(4*I)  ] & 0xff; t1<<=8;\
-  t1 |= input[(4*I)+1] & 0xff; t1<<=8;\
-  t1 |= input[(4*I)+2] & 0xff; t1<<=8;\
-  t1 |= input[(4*I)+3] & 0xff;\
-  W[I] = t1;\
- }
+static inline void LOAD_OP(int I, u32 *W, const u8 *input)
+{
+	u32 t1 = input[(4 * I)] & 0xff;
+
+	t1 <<= 8;
+	t1 |= input[(4 * I) + 1] & 0xff;
+	t1 <<= 8;
+	t1 |= input[(4 * I) + 2] & 0xff;
+	t1 <<= 8;
+	t1 |= input[(4 * I) + 3] & 0xff;
+	W[I] = t1;
+}
 
-#define BLEND_OP(I) W[I] = s1(W[I-2]) + W[I-7] + s0(W[I-15]) + W[I-16];
+static inline void BLEND_OP(int I, u32 *W)
+{
+	W[I] = s1(W[I-2]) + W[I-7] + s0(W[I-15]) + W[I-16];
+}
 
 static void sha256_transform(u32 *state, const u8 *input)
 {
 	u32 a, b, c, d, e, f, g, h, t1, t2;
 	u32 W[64];
+	int i;
 
 	/* load the input */
-	LOAD_OP( 0);  LOAD_OP( 1);  LOAD_OP( 2);  LOAD_OP( 3);
-	LOAD_OP( 4);  LOAD_OP( 5);  LOAD_OP( 6);  LOAD_OP( 7);
-	LOAD_OP( 8);  LOAD_OP( 9);  LOAD_OP(10);  LOAD_OP(11);
-	LOAD_OP(12);  LOAD_OP(13);  LOAD_OP(14);  LOAD_OP(15);
+	for (i = 0; i < 16; i++)
+		LOAD_OP(i, W, input);
 
 	/* now blend */
-	BLEND_OP(16);  BLEND_OP(17);  BLEND_OP(18);  BLEND_OP(19);
-	BLEND_OP(20);  BLEND_OP(21);  BLEND_OP(22);  BLEND_OP(23);
-	BLEND_OP(24);  BLEND_OP(25);  BLEND_OP(26);  BLEND_OP(27);
-	BLEND_OP(28);  BLEND_OP(29);  BLEND_OP(30);  BLEND_OP(31);
-	BLEND_OP(32);  BLEND_OP(33);  BLEND_OP(34);  BLEND_OP(35);
-	BLEND_OP(36);  BLEND_OP(37);  BLEND_OP(38);  BLEND_OP(39);
-	BLEND_OP(40);  BLEND_OP(41);  BLEND_OP(42);  BLEND_OP(43);
-	BLEND_OP(44);  BLEND_OP(45);  BLEND_OP(46);  BLEND_OP(47);
-	BLEND_OP(48);  BLEND_OP(49);  BLEND_OP(50);  BLEND_OP(51);
-	BLEND_OP(52);  BLEND_OP(53);  BLEND_OP(54);  BLEND_OP(55);
-	BLEND_OP(56);  BLEND_OP(57);  BLEND_OP(58);  BLEND_OP(59);
-	BLEND_OP(60);  BLEND_OP(61);  BLEND_OP(62);  BLEND_OP(63);
+	for (i = 16; i < 64; i++)
+		BLEND_OP(i, W);
     
 	/* load the state into our registers */
 	a=state[0];  b=state[1];  c=state[2];  d=state[3];


ChangeSet@1.925.5.8, 2002-11-07 00:38:49-08:00, jmorris@intercode.com.au
  [CRYPTO]: minor updates
  - Fixed min keysize bug for Blowfish (it is 32, not 64).
  - Documentation updates.

diff -Nru a/Documentation/crypto/api-intro.txt b/Documentation/crypto/api-intro.txt
--- a/Documentation/crypto/api-intro.txt	Thu Nov  7 01:49:18 2002
+++ b/Documentation/crypto/api-intro.txt	Thu Nov  7 01:49:18 2002
@@ -105,6 +105,10 @@
 as well as general application notes such as RFC2451 ("The ESP CBC-Mode
 Cipher Algorithms").
 
+It's a good idea to avoid using lots of macros and use inlined functions
+instead, as gcc does a good job with inlining, while excessive use of
+macros can cause compilation problems on some platforms.
+
 
 BUGS
 
@@ -167,7 +171,7 @@
   Dana L. How (DES)
   Andrew Tridgell and Steve French (MD4)
   Colin Plumb (MD5)
-  Steve Raid (SHA1)
+  Steve Reid (SHA1)
   Jean-Luc Cooke (SHA256)
   Kazunori Miyazawa / USAGI (HMAC)
 
diff -Nru a/crypto/Kconfig b/crypto/Kconfig
--- a/crypto/Kconfig	Thu Nov  7 01:49:18 2002
+++ b/crypto/Kconfig	Thu Nov  7 01:49:18 2002
@@ -55,9 +55,9 @@
 	help
 	  Blowfish cipher algorithm, by Bruce Schneier.
 	  
-	  This is a fast cipher which can use variable length key from 32
-	  bits to 448 bits.  It's fast, simple and specifically designed for
-	  use on "large microprocessors".
+	  This is a variable key length cipher which can use keys from 32
+	  bits to 448 bits in length.  It's fast, simple and specifically
+	  designed for use on "large microprocessors".
 	  
 	  See also:
 	  http://www.counterpane.com/blowfish.html
diff -Nru a/crypto/blowfish.c b/crypto/blowfish.c
--- a/crypto/blowfish.c	Thu Nov  7 01:49:18 2002
+++ b/crypto/blowfish.c	Thu Nov  7 01:49:18 2002
@@ -23,7 +23,7 @@
 #include <linux/crypto.h>
 
 #define BF_BLOCK_SIZE 8
-#define BF_MIN_KEY_SIZE 8
+#define BF_MIN_KEY_SIZE 4
 #define BF_MAX_KEY_SIZE 56
 
 struct bf_ctx {
diff -Nru a/crypto/sha1.c b/crypto/sha1.c
--- a/crypto/sha1.c	Thu Nov  7 01:49:18 2002
+++ b/crypto/sha1.c	Thu Nov  7 01:49:18 2002
@@ -5,7 +5,7 @@
  *
  * Derived from cryptoapi implementation, adapted for in-place
  * scatterlist interface.  Originally based on the public domain
- * implementation written by Steve Raid.
+ * implementation written by Steve Reid.
  *
  * Copyright (c) Alan Smithee.
  * Copyright (c) Andrew McDonald <andrew@mcdonald.org.uk>


ChangeSet@1.925.5.9, 2002-11-07 01:16:09-08:00, bart.de.schuyer@pandora.be
  [BRIDGE]: Fix help docs.
diff -Nru a/net/Kconfig b/net/Kconfig
--- a/net/Kconfig	Thu Nov  7 01:49:20 2002
+++ b/net/Kconfig	Thu Nov  7 01:49:20 2002
@@ -391,10 +391,10 @@
 	  for location. Please read the Bridge mini-HOWTO for more
 	  information.
 
-	  Note that if your box acts as a bridge, it probably contains several
-	  Ethernet devices, but the kernel is not able to recognize more than
-	  one at boot time without help; for details read the Ethernet-HOWTO,
-	  available from in <http://www.linuxdoc.org/docs.html#howto>.
+	  If you enable iptables support along with the bridge support then you
+	  turn your bridge into a bridging firewall.
+	  iptables will then see the IP packets being bridged, so you need to
+	  take this into account when setting up your firewall rules.
 
 	  If you want to compile this code as a module ( = code which can be
 	  inserted in and removed from the running kernel whenever you want),


