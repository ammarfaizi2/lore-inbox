Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbULTPMC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbULTPMC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 10:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbULTPMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 10:12:01 -0500
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:42882 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S261519AbULTPIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 10:08:55 -0500
Message-ID: <41C6EB04.7080306@einar-lueck.de>
Date: Mon, 20 Dec 2004 16:08:52 +0100
From: =?ISO-8859-1?Q?Einar_L=FCck?= <lkml@einar-lueck.de>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick McHardy <kaber@trash.net>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH 1/2] ipv4 routing: splitting of ip_route_[in|out]put_slow,
 2.6.10-rc3
References: <41C6B3D4.6060207@einar-lueck.de> <41C6DB68.30607@trash.net>
In-Reply-To: <41C6DB68.30607@trash.net>
Content-Type: multipart/mixed;
 boundary="------------010809070706070601060701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010809070706070601060701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Patrick McHardy wrote:
> Your patches have once again been made unreadable by
> your email-client. Please send them again as attachments.
> 
> Regards
> Patrick


Thank you for the hint!

Regards
Einar

--------------010809070706070601060701
Content-Type: text/plain;
 name="routingsplit_rc3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="routingsplit_rc3.diff"

diff -ruN linux-2.6.9/net/ipv4/route.c linux-2.6.9.split/net/ipv4/route.c
--- linux-2.6.9/net/ipv4/route.c	2004-12-15 12:03:59.000000000 +0100
+++ linux-2.6.9.split/net/ipv4/route.c	2004-12-15 12:05:32.000000000 +0100
@@ -104,6 +104,9 @@
 #include <linux/sysctl.h>
 #endif
 
+#define RT_FL_TOS(oldflp) \
+    ((u32)(oldflp->fl4_tos & (IPTOS_RT_MASK | RTO_ONLINK)))
+
 #define IP_MAX_MTU	0xFFF0
 
 #define RT_GC_TIMEOUT (300*HZ)
@@ -143,6 +146,7 @@
 static void		 ipv4_link_failure(struct sk_buff *skb);
 static void		 ip_rt_update_pmtu(struct dst_entry *dst, u32 mtu);
 static int rt_garbage_collect(void);
+static inline int compare_keys(struct flowi *fl1, struct flowi *fl2);
 
 
 static struct dst_ops ipv4_dst_ops = {
@@ -1533,6 +1537,169 @@
 	return -EINVAL;
 }
 
+
+static void ip_handle_martian_source(struct net_device *dev,
+				     struct in_device *in_dev,
+				     struct sk_buff *skb,
+				     u32 daddr,
+				     u32 saddr) 
+{
+	RT_CACHE_STAT_INC(in_martian_src);
+#ifdef CONFIG_IP_ROUTE_VERBOSE
+	if (IN_DEV_LOG_MARTIANS(in_dev) && net_ratelimit()) {
+		/*
+		 *	RFC1812 recommendation, if source is martian,
+		 *	the only hint is MAC header.
+		 */
+		printk(KERN_WARNING "martian source %u.%u.%u.%u from "
+			"%u.%u.%u.%u, on dev %s\n",
+			NIPQUAD(daddr), NIPQUAD(saddr), dev->name);
+		if (dev->hard_header_len) {
+			int i;
+			unsigned char *p = skb->mac.raw;
+			printk(KERN_WARNING "ll header: ");
+			for (i = 0; i < dev->hard_header_len; i++, p++) {
+				printk("%02x", *p);
+				if (i < (dev->hard_header_len - 1))
+					printk(":");
+			}
+			printk("\n");
+		}
+	}
+#endif
+}
+
+static inline int __mkroute_input(struct sk_buff *skb, 
+				  struct fib_result* res, 
+				  struct in_device *in_dev, 
+				  u32 daddr, u32 saddr, u32 tos, 
+				  struct rtable **result) 
+{
+
+	struct rtable *rth;
+	int err;
+	struct in_device *out_dev;
+	unsigned flags = 0;
+	u32 spec_dst, itag;
+
+	/* get a working reference to the output device */
+	out_dev = in_dev_get(FIB_RES_DEV(*res));
+	if (out_dev == NULL) {
+		if (net_ratelimit())
+			printk(KERN_CRIT "Bug in ip_route_input" \
+			       "_slow(). Please, report\n");
+		return -EINVAL;
+	}
+
+
+	err = fib_validate_source(saddr, daddr, tos, FIB_RES_OIF(*res), 
+				  in_dev->dev, &spec_dst, &itag);
+	if (err < 0) {
+		ip_handle_martian_source(in_dev->dev, in_dev, skb, daddr, 
+					 saddr);
+		
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+	if (err)
+		flags |= RTCF_DIRECTSRC;
+
+	if (out_dev == in_dev && err && !(flags & (RTCF_NAT | RTCF_MASQ)) &&
+	    (IN_DEV_SHARED_MEDIA(out_dev) ||
+	     inet_addr_onlink(out_dev, saddr, FIB_RES_GW(*res))))
+		flags |= RTCF_DOREDIRECT;
+
+	if (skb->protocol != htons(ETH_P_IP)) {
+		/* Not IP (i.e. ARP). Do not create route, if it is
+		 * invalid for proxy arp. DNAT routes are always valid.
+		 */
+		if (out_dev == in_dev && !(flags & RTCF_DNAT)) {
+			err = -EINVAL;
+			goto cleanup;
+		}
+	}
+
+
+	rth = dst_alloc(&ipv4_dst_ops);
+	if (!rth) {
+		err = -ENOBUFS;
+		goto cleanup;
+	}
+
+	rth->u.dst.flags= DST_HOST;
+	if (in_dev->cnf.no_policy)
+		rth->u.dst.flags |= DST_NOPOLICY;
+	if (in_dev->cnf.no_xfrm)
+		rth->u.dst.flags |= DST_NOXFRM;
+	rth->fl.fl4_dst	= daddr;
+	rth->rt_dst	= daddr;
+	rth->fl.fl4_tos	= tos;
+#ifdef CONFIG_IP_ROUTE_FWMARK
+	rth->fl.fl4_fwmark= skb->nfmark;
+#endif
+	rth->fl.fl4_src	= saddr;
+	rth->rt_src	= saddr;
+	rth->rt_gateway	= daddr;
+	rth->rt_iif 	=
+		rth->fl.iif	= in_dev->dev->ifindex;
+	rth->u.dst.dev	= (out_dev)->dev;
+	dev_hold(rth->u.dst.dev);
+	rth->idev	= in_dev_get(rth->u.dst.dev);
+	rth->fl.oif 	= 0;
+	rth->rt_spec_dst= spec_dst;
+
+	rth->u.dst.input = ip_forward;
+	rth->u.dst.output = ip_output;
+
+	rt_set_nexthop(rth, res, itag);
+
+	rth->rt_flags = flags;
+
+	*result = rth;
+	err = 0;
+ cleanup:
+	/* release the working reference to the output device */
+	in_dev_put(out_dev);
+	return err;
+}						
+
+static inline int ip_mkroute_input_def(struct sk_buff *skb, 
+				       struct fib_result* res, 
+				       const struct flowi *fl,
+				       struct in_device *in_dev,
+				       u32 daddr, u32 saddr, u32 tos)
+{
+	struct rtable* rth;
+	int err;
+	unsigned hash;
+
+#ifdef CONFIG_IP_ROUTE_MULTIPATH
+	if (res->fi->fib_nhs > 1 && fl->oif == 0)
+		fib_select_multipath(fl, res);
+#endif
+
+	/* create a routing cache entry */
+	err = __mkroute_input( skb, res, in_dev, daddr, saddr, tos, &rth );
+	if ( err )
+		return err;
+	atomic_set(&rth->u.dst.__refcnt, 1);
+
+	/* put it into the cache */
+	hash = rt_hash_code(daddr, saddr ^ (fl->iif << 5), tos);
+	return rt_intern_hash(hash, rth, (struct rtable**)&skb->dst);	
+}
+
+static inline int ip_mkroute_input(struct sk_buff *skb, 
+				   struct fib_result* res, 
+				   const struct flowi *fl,
+				   struct in_device *in_dev,
+				   u32 daddr, u32 saddr, u32 tos)
+{
+	return ip_mkroute_input_def(skb, res, fl, in_dev, daddr, saddr, tos);
+}
+
+
 /*
  *	NOTE. We drop all the packets that has local source
  *	addresses, because every properly looped back packet
@@ -1544,11 +1711,10 @@
  */
 
 static int ip_route_input_slow(struct sk_buff *skb, u32 daddr, u32 saddr,
-			u8 tos, struct net_device *dev)
+			       u8 tos, struct net_device *dev)
 {
 	struct fib_result res;
 	struct in_device *in_dev = in_dev_get(dev);
-	struct in_device *out_dev = NULL;
 	struct flowi fl = { .nl_u = { .ip4_u =
 				      { .daddr = daddr,
 					.saddr = saddr,
@@ -1572,8 +1738,6 @@
 	if (!in_dev)
 		goto out;
 
-	hash = rt_hash_code(daddr, saddr ^ (fl.iif << 5), tos);
-
 	/* Check for the most weird martians, which can be not detected
 	   by fib_lookup.
 	 */
@@ -1626,79 +1790,14 @@
 	if (res.type != RTN_UNICAST)
 		goto martian_destination;
 
-#ifdef CONFIG_IP_ROUTE_MULTIPATH
-	if (res.fi->fib_nhs > 1 && fl.oif == 0)
-		fib_select_multipath(&fl, &res);
-#endif
-	out_dev = in_dev_get(FIB_RES_DEV(res));
-	if (out_dev == NULL) {
-		if (net_ratelimit())
-			printk(KERN_CRIT "Bug in ip_route_input_slow(). "
-					 "Please, report\n");
-		goto e_inval;
-	}
-
-	err = fib_validate_source(saddr, daddr, tos, FIB_RES_OIF(res), dev,
-				  &spec_dst, &itag);
-	if (err < 0)
-		goto martian_source;
-
-	if (err)
-		flags |= RTCF_DIRECTSRC;
-
-	if (out_dev == in_dev && err && !(flags & (RTCF_NAT | RTCF_MASQ)) &&
-	    (IN_DEV_SHARED_MEDIA(out_dev) ||
-	     inet_addr_onlink(out_dev, saddr, FIB_RES_GW(res))))
-		flags |= RTCF_DOREDIRECT;
-
-	if (skb->protocol != htons(ETH_P_IP)) {
-		/* Not IP (i.e. ARP). Do not create route, if it is
-		 * invalid for proxy arp. DNAT routes are always valid.
-		 */
-		if (out_dev == in_dev && !(flags & RTCF_DNAT))
-			goto e_inval;
-	}
-
-	rth = dst_alloc(&ipv4_dst_ops);
-	if (!rth)
+	err = ip_mkroute_input(skb, &res, &fl, in_dev, daddr, saddr, tos);
+	if ( err == -ENOBUFS )
 		goto e_nobufs;
-
-	atomic_set(&rth->u.dst.__refcnt, 1);
-	rth->u.dst.flags= DST_HOST;
-	if (in_dev->cnf.no_policy)
-		rth->u.dst.flags |= DST_NOPOLICY;
-	if (in_dev->cnf.no_xfrm)
-		rth->u.dst.flags |= DST_NOXFRM;
-	rth->fl.fl4_dst	= daddr;
-	rth->rt_dst	= daddr;
-	rth->fl.fl4_tos	= tos;
-#ifdef CONFIG_IP_ROUTE_FWMARK
-	rth->fl.fl4_fwmark= skb->nfmark;
-#endif
-	rth->fl.fl4_src	= saddr;
-	rth->rt_src	= saddr;
-	rth->rt_gateway	= daddr;
-	rth->rt_iif 	=
-	rth->fl.iif	= dev->ifindex;
-	rth->u.dst.dev	= out_dev->dev;
-	dev_hold(rth->u.dst.dev);
-	rth->idev	= in_dev_get(rth->u.dst.dev);
-	rth->fl.oif 	= 0;
-	rth->rt_spec_dst= spec_dst;
-
-	rth->u.dst.input = ip_forward;
-	rth->u.dst.output = ip_output;
-
-	rt_set_nexthop(rth, &res, itag);
-
-	rth->rt_flags = flags;
-
-intern:
-	err = rt_intern_hash(hash, rth, (struct rtable**)&skb->dst);
+	if ( err == -EINVAL )
+		goto e_inval;
+	
 done:
 	in_dev_put(in_dev);
-	if (out_dev)
-		in_dev_put(out_dev);
 	if (free_res)
 		fib_res_put(&res);
 out:	return err;
@@ -1758,7 +1857,9 @@
 		rth->rt_flags 	&= ~RTCF_LOCAL;
 	}
 	rth->rt_type	= res.type;
-	goto intern;
+	hash = rt_hash_code(daddr, saddr ^ (fl.iif << 5), tos);
+	err = rt_intern_hash(hash, rth, (struct rtable**)&skb->dst);
+	goto done;
 
 no_route:
 	RT_CACHE_STAT_INC(in_no_route);
@@ -1786,30 +1887,7 @@
 	goto done;
 
 martian_source:
-
-	RT_CACHE_STAT_INC(in_martian_src);
-#ifdef CONFIG_IP_ROUTE_VERBOSE
-	if (IN_DEV_LOG_MARTIANS(in_dev) && net_ratelimit()) {
-		/*
-		 *	RFC1812 recommendation, if source is martian,
-		 *	the only hint is MAC header.
-		 */
-		printk(KERN_WARNING "martian source %u.%u.%u.%u from "
-			"%u.%u.%u.%u, on dev %s\n",
-			NIPQUAD(daddr), NIPQUAD(saddr), dev->name);
-		if (dev->hard_header_len) {
-			int i;
-			unsigned char *p = skb->mac.raw;
-			printk(KERN_WARNING "ll header: ");
-			for (i = 0; i < dev->hard_header_len; i++, p++) {
-				printk("%02x", *p);
-				if (i < (dev->hard_header_len - 1))
-					printk(":");
-			}
-			printk("\n");
-		}
-	}
-#endif
+	ip_handle_martian_source(dev, in_dev, skb, daddr, saddr);
 	goto e_inval;
 }
 
@@ -1880,13 +1958,166 @@
 	return ip_route_input_slow(skb, daddr, saddr, tos, dev);
 }
 
+static inline int __mkroute_output(struct rtable **result,
+				   struct fib_result* res, 
+				   const struct flowi *fl,
+				   const struct flowi *oldflp, 
+				   struct net_device *dev_out, 
+				   unsigned flags) 
+{
+	struct rtable *rth;
+	struct in_device *in_dev;
+	u32 tos = RT_FL_TOS(oldflp);
+	int err = 0;
+
+	if (LOOPBACK(fl->fl4_src) && !(dev_out->flags&IFF_LOOPBACK))
+		return -EINVAL;
+
+	if (fl->fl4_dst == 0xFFFFFFFF)
+		res->type = RTN_BROADCAST;
+	else if (MULTICAST(fl->fl4_dst))
+		res->type = RTN_MULTICAST;
+	else if (BADCLASS(fl->fl4_dst) || ZERONET(fl->fl4_dst))
+		return -EINVAL;
+
+	if (dev_out->flags & IFF_LOOPBACK)
+		flags |= RTCF_LOCAL;
+
+	/* get work reference to inet device */
+	in_dev = in_dev_get(dev_out);
+	if (!in_dev)
+		return -EINVAL;
+
+	if (res->type == RTN_BROADCAST) {
+		flags |= RTCF_BROADCAST | RTCF_LOCAL;
+		if (res->fi) {
+			fib_info_put(res->fi);
+			res->fi = NULL;
+		}
+	} else if (res->type == RTN_MULTICAST) {
+		flags |= RTCF_MULTICAST|RTCF_LOCAL;
+		if (!ip_check_mc(in_dev, oldflp->fl4_dst, oldflp->fl4_src, 
+				 oldflp->proto))
+			flags &= ~RTCF_LOCAL;
+		/* If multicast route do not exist use
+		   default one, but do not gateway in this case.
+		   Yes, it is hack.
+		 */
+		if (res->fi && res->prefixlen < 4) {
+			fib_info_put(res->fi);
+			res->fi = NULL;
+		}
+	}
+
+
+	rth = dst_alloc(&ipv4_dst_ops);
+	if (!rth) {
+		err = -ENOBUFS;
+		goto cleanup;
+	}		
+
+	rth->u.dst.flags= DST_HOST;
+	if (in_dev->cnf.no_xfrm)
+		rth->u.dst.flags |= DST_NOXFRM;
+	if (in_dev->cnf.no_policy)
+		rth->u.dst.flags |= DST_NOPOLICY;
+
+	rth->fl.fl4_dst	= oldflp->fl4_dst;
+	rth->fl.fl4_tos	= tos;
+	rth->fl.fl4_src	= oldflp->fl4_src;
+	rth->fl.oif	= oldflp->oif;
+#ifdef CONFIG_IP_ROUTE_FWMARK
+	rth->fl.fl4_fwmark= oldflp->fl4_fwmark;
+#endif
+	rth->rt_dst	= fl->fl4_dst;
+	rth->rt_src	= fl->fl4_src;
+	rth->rt_iif	= oldflp->oif ? : dev_out->ifindex;
+	/* get references to the devices that are to be hold by the routing 
+	   cache entry */
+	rth->u.dst.dev	= dev_out;
+	dev_hold(dev_out);
+	rth->idev	= in_dev_get(dev_out);
+	rth->rt_gateway = fl->fl4_dst;
+	rth->rt_spec_dst= fl->fl4_src;
+
+	rth->u.dst.output=ip_output;
+
+	RT_CACHE_STAT_INC(out_slow_tot);
+
+	if (flags & RTCF_LOCAL) {
+		rth->u.dst.input = ip_local_deliver;
+		rth->rt_spec_dst = fl->fl4_dst;
+	}
+	if (flags & (RTCF_BROADCAST | RTCF_MULTICAST)) {
+		rth->rt_spec_dst = fl->fl4_src;
+		if (flags & RTCF_LOCAL && 
+		    !(dev_out->flags & IFF_LOOPBACK)) {
+			rth->u.dst.output = ip_mc_output;
+			RT_CACHE_STAT_INC(out_slow_mc);
+		}
+#ifdef CONFIG_IP_MROUTE
+		if (res->type == RTN_MULTICAST) {
+			if (IN_DEV_MFORWARD(in_dev) &&
+			    !LOCAL_MCAST(oldflp->fl4_dst)) {
+				rth->u.dst.input = ip_mr_input;
+				rth->u.dst.output = ip_mc_output;
+			}
+		}
+#endif
+	}
+
+	rt_set_nexthop(rth, res, 0);
+
+	rth->rt_flags = flags;
+
+	*result = rth;
+ cleanup:
+	/* release work reference to inet device */
+	in_dev_put(in_dev);
+
+	return err;
+}
+
+static inline int ip_mkroute_output_def(struct rtable **rp,
+					struct fib_result* res,
+					const struct flowi *fl,
+					const struct flowi *oldflp,
+					struct net_device *dev_out,
+					unsigned flags)
+{
+	struct rtable *rth;
+	int err = __mkroute_output(&rth, res, fl, oldflp, dev_out, flags);
+	unsigned hash;
+	if ( err == 0 ) {
+		u32 tos = RT_FL_TOS(oldflp);
+
+		atomic_set(&rth->u.dst.__refcnt, 1);
+		
+		hash = rt_hash_code(oldflp->fl4_dst, 
+				    oldflp->fl4_src ^ (oldflp->oif << 5), tos);
+		err = rt_intern_hash(hash, rth, rp);
+	}
+	
+	return err;
+}
+
+static inline int ip_mkroute_output(struct rtable** rp,
+				    struct fib_result* res,
+				    const struct flowi *fl,
+				    const struct flowi *oldflp,
+				    struct net_device *dev_out,
+				    unsigned flags)
+{
+	return ip_mkroute_output_def(rp, res, fl, oldflp, dev_out, flags);
+}
+
 /*
  * Major route resolver routine.
  */
 
 static int ip_route_output_slow(struct rtable **rp, const struct flowi *oldflp)
 {
-	u32 tos	= oldflp->fl4_tos & (IPTOS_RT_MASK | RTO_ONLINK);
+	u32 tos	= RT_FL_TOS(oldflp);
 	struct flowi fl = { .nl_u = { .ip4_u =
 				      { .daddr = oldflp->fl4_dst,
 					.saddr = oldflp->fl4_src,
@@ -1902,10 +2133,7 @@
 			    .oif = oldflp->oif };
 	struct fib_result res;
 	unsigned flags = 0;
-	struct rtable *rth;
 	struct net_device *dev_out = NULL;
-	struct in_device *in_dev = NULL;
-	unsigned hash;
 	int free_res = 0;
 	int err;
 
@@ -2065,116 +2293,13 @@
 	fl.oif = dev_out->ifindex;
 
 make_route:
-	if (LOOPBACK(fl.fl4_src) && !(dev_out->flags&IFF_LOOPBACK))
-		goto e_inval;
+	err = ip_mkroute_output(rp, &res, &fl, oldflp, dev_out, flags);
 
-	if (fl.fl4_dst == 0xFFFFFFFF)
-		res.type = RTN_BROADCAST;
-	else if (MULTICAST(fl.fl4_dst))
-		res.type = RTN_MULTICAST;
-	else if (BADCLASS(fl.fl4_dst) || ZERONET(fl.fl4_dst))
-		goto e_inval;
-
-	if (dev_out->flags & IFF_LOOPBACK)
-		flags |= RTCF_LOCAL;
-
-	in_dev = in_dev_get(dev_out);
-	if (!in_dev)
-		goto e_inval;
-
-	if (res.type == RTN_BROADCAST) {
-		flags |= RTCF_BROADCAST | RTCF_LOCAL;
-		if (res.fi) {
-			fib_info_put(res.fi);
-			res.fi = NULL;
-		}
-	} else if (res.type == RTN_MULTICAST) {
-		flags |= RTCF_MULTICAST|RTCF_LOCAL;
-		if (!ip_check_mc(in_dev, oldflp->fl4_dst, oldflp->fl4_src, oldflp->proto))
-			flags &= ~RTCF_LOCAL;
-		/* If multicast route do not exist use
-		   default one, but do not gateway in this case.
-		   Yes, it is hack.
-		 */
-		if (res.fi && res.prefixlen < 4) {
-			fib_info_put(res.fi);
-			res.fi = NULL;
-		}
-	}
-
-	rth = dst_alloc(&ipv4_dst_ops);
-	if (!rth)
-		goto e_nobufs;
-
-	atomic_set(&rth->u.dst.__refcnt, 1);
-	rth->u.dst.flags= DST_HOST;
-	if (in_dev->cnf.no_xfrm)
-		rth->u.dst.flags |= DST_NOXFRM;
-	if (in_dev->cnf.no_policy)
-		rth->u.dst.flags |= DST_NOPOLICY;
-	rth->fl.fl4_dst	= oldflp->fl4_dst;
-	rth->fl.fl4_tos	= tos;
-	rth->fl.fl4_src	= oldflp->fl4_src;
-	rth->fl.oif	= oldflp->oif;
-#ifdef CONFIG_IP_ROUTE_FWMARK
-	rth->fl.fl4_fwmark= oldflp->fl4_fwmark;
-#endif
-	rth->rt_dst	= fl.fl4_dst;
-	rth->rt_src	= fl.fl4_src;
-	rth->rt_iif	= oldflp->oif ? : dev_out->ifindex;
-	rth->u.dst.dev	= dev_out;
-	dev_hold(dev_out);
-	rth->idev	= in_dev_get(dev_out);
-	rth->rt_gateway = fl.fl4_dst;
-	rth->rt_spec_dst= fl.fl4_src;
-
-	rth->u.dst.output=ip_output;
-
-	RT_CACHE_STAT_INC(out_slow_tot);
-
-	if (flags & RTCF_LOCAL) {
-		rth->u.dst.input = ip_local_deliver;
-		rth->rt_spec_dst = fl.fl4_dst;
-	}
-	if (flags & (RTCF_BROADCAST | RTCF_MULTICAST)) {
-		rth->rt_spec_dst = fl.fl4_src;
-		if (flags & RTCF_LOCAL && !(dev_out->flags & IFF_LOOPBACK)) {
-			rth->u.dst.output = ip_mc_output;
-			RT_CACHE_STAT_INC(out_slow_mc);
-		}
-#ifdef CONFIG_IP_MROUTE
-		if (res.type == RTN_MULTICAST) {
-			if (IN_DEV_MFORWARD(in_dev) &&
-			    !LOCAL_MCAST(oldflp->fl4_dst)) {
-				rth->u.dst.input = ip_mr_input;
-				rth->u.dst.output = ip_mc_output;
-			}
-		}
-#endif
-	}
-
-	rt_set_nexthop(rth, &res, 0);
-	
-
-	rth->rt_flags = flags;
-
-	hash = rt_hash_code(oldflp->fl4_dst, oldflp->fl4_src ^ (oldflp->oif << 5), tos);
-	err = rt_intern_hash(hash, rth, rp);
-done:
 	if (free_res)
 		fib_res_put(&res);
 	if (dev_out)
 		dev_put(dev_out);
-	if (in_dev)
-		in_dev_put(in_dev);
 out:	return err;
-
-e_inval:
-	err = -EINVAL;
-	goto done;
-e_nobufs:
-	err = -ENOBUFS;
-	goto done;
 }
 
 int __ip_route_output_key(struct rtable **rp, const struct flowi *flp)

--------------010809070706070601060701--
