Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbVJABOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbVJABOQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 21:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbVJABOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 21:14:16 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:11268 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1750707AbVJABOQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 21:14:16 -0400
Date: Sat, 1 Oct 2005 11:13:12 +1000
To: Suzanne Wood <suzannew@cs.pdx.edu>
Cc: paulmck@us.ibm.com, Robert.Olsson@data.slu.se, davem@davemloft.net,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, walpole@cs.pdx.edu
Subject: Re: [RFC][PATCH] identify in_dev_get rcu read-side critical sections
Message-ID: <20051001011312.GA28204@gondor.apana.org.au>
References: <200509300106.j8U16obP021064@rastaban.cs.pdx.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <200509300106.j8U16obP021064@rastaban.cs.pdx.edu>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 29, 2005 at 06:06:50PM -0700, Suzanne Wood wrote:
> 
> Are there three cases then?  RCU protection with refcnt, RCU without refcnt,
> and the bare cast of the dereference? 

Correct.

The following patch renames __in_dev_get() to __in_dev_get_rtnl() and
introduces __in_dev_get_rcu() to cover the second case.

1) RCU with refcnt should use in_dev_get().
2) RCU without refcnt should use __in_dev_get_rcu().
3) All others must hold RTNL and use __in_dev_get_rtnl().

There is one exception in net/ipv4/route.c which is in fact a pre-existing
race condition.  I've marked it as such so that we remember to fix it.

This patch is based on suggestions and prior work by Suzanne Wood and
Paul McKenney.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2776,7 +2776,7 @@ static u32 bond_glean_dev_ip(struct net_
 		return 0;
 
 	rcu_read_lock();
-	idev = __in_dev_get(dev);
+	idev = __in_dev_get_rcu(dev);
 	if (!idev)
 		goto out;
 
diff --git a/drivers/net/wan/sdlamain.c b/drivers/net/wan/sdlamain.c
--- a/drivers/net/wan/sdlamain.c
+++ b/drivers/net/wan/sdlamain.c
@@ -57,6 +57,7 @@
 #include <linux/ioport.h>	/* request_region(), release_region() */
 #include <linux/wanrouter.h>	/* WAN router definitions */
 #include <linux/wanpipe.h>	/* WANPIPE common user API definitions */
+#include <linux/rcupdate.h>
 
 #include <linux/in.h>
 #include <asm/io.h>		/* phys_to_virt() */
@@ -1268,37 +1269,41 @@ unsigned long get_ip_address(struct net_
 	
 	struct in_ifaddr *ifaddr;
 	struct in_device *in_dev;
+	unsigned long addr = 0;
 
-	if ((in_dev = __in_dev_get(dev)) == NULL){
-		return 0;
+	rcu_read_lock();
+	if ((in_dev = __in_dev_get_rcu(dev)) == NULL){
+		goto out;
 	}
 
 	if ((ifaddr = in_dev->ifa_list)== NULL ){
-		return 0;
+		goto out;
 	}
 	
 	switch (option){
 
 	case WAN_LOCAL_IP:
-		return ifaddr->ifa_local;
+		addr = ifaddr->ifa_local;
 		break;
 	
 	case WAN_POINTOPOINT_IP:
-		return ifaddr->ifa_address;
+		addr = ifaddr->ifa_address;
 		break;	
 
 	case WAN_NETMASK_IP:
-		return ifaddr->ifa_mask;
+		addr = ifaddr->ifa_mask;
 		break;
 
 	case WAN_BROADCAST_IP:
-		return ifaddr->ifa_broadcast;
+		addr = ifaddr->ifa_broadcast;
 		break;
 	default:
-		return 0;
+		break;
 	}
 
-	return 0;
+out:
+	rcu_read_unlock();
+	return addr;
 }	
 
 void add_gateway(sdla_t *card, struct net_device *dev)
diff --git a/drivers/net/wan/syncppp.c b/drivers/net/wan/syncppp.c
--- a/drivers/net/wan/syncppp.c
+++ b/drivers/net/wan/syncppp.c
@@ -769,7 +769,7 @@ static void sppp_cisco_input (struct spp
 		u32 addr = 0, mask = ~0; /* FIXME: is the mask correct? */
 #ifdef CONFIG_INET
 		rcu_read_lock();
-		if ((in_dev = __in_dev_get(dev)) != NULL)
+		if ((in_dev = __in_dev_get_rcu(dev)) != NULL)
 		{
 			for (ifa=in_dev->ifa_list; ifa != NULL;
 				ifa=ifa->ifa_next) {
diff --git a/drivers/net/wireless/strip.c b/drivers/net/wireless/strip.c
--- a/drivers/net/wireless/strip.c
+++ b/drivers/net/wireless/strip.c
@@ -1352,7 +1352,7 @@ static unsigned char *strip_make_packet(
 		struct in_device *in_dev;
 
 		rcu_read_lock();
-		in_dev = __in_dev_get(strip_info->dev);
+		in_dev = __in_dev_get_rcu(strip_info->dev);
 		if (in_dev == NULL) {
 			rcu_read_unlock();
 			return NULL;
@@ -1508,7 +1508,7 @@ static void strip_send(struct strip *str
 
 		brd = addr = 0;
 		rcu_read_lock();
-		in_dev = __in_dev_get(strip_info->dev);
+		in_dev = __in_dev_get_rcu(strip_info->dev);
 		if (in_dev) {
 			if (in_dev->ifa_list) {
 				brd = in_dev->ifa_list->ifa_broadcast;
diff --git a/drivers/parisc/led.c b/drivers/parisc/led.c
--- a/drivers/parisc/led.c
+++ b/drivers/parisc/led.c
@@ -37,6 +37,7 @@
 #include <linux/proc_fs.h>
 #include <linux/ctype.h>
 #include <linux/blkdev.h>
+#include <linux/rcupdate.h>
 #include <asm/io.h>
 #include <asm/processor.h>
 #include <asm/hardware.h>
@@ -358,9 +359,10 @@ static __inline__ int led_get_net_activi
 	/* we are running as tasklet, so locking dev_base 
 	 * for reading should be OK */
 	read_lock(&dev_base_lock);
+	rcu_read_lock();
 	for (dev = dev_base; dev; dev = dev->next) {
 	    struct net_device_stats *stats;
-	    struct in_device *in_dev = __in_dev_get(dev);
+	    struct in_device *in_dev = __in_dev_get_rcu(dev);
 	    if (!in_dev || !in_dev->ifa_list)
 		continue;
 	    if (LOOPBACK(in_dev->ifa_list->ifa_local))
@@ -371,6 +373,7 @@ static __inline__ int led_get_net_activi
 	    rx_total += stats->rx_packets;
 	    tx_total += stats->tx_packets;
 	}
+	rcu_read_unlock();
 	read_unlock(&dev_base_lock);
 
 	retval = 0;
diff --git a/drivers/s390/net/qeth_main.c b/drivers/s390/net/qeth_main.c
--- a/drivers/s390/net/qeth_main.c
+++ b/drivers/s390/net/qeth_main.c
@@ -5200,7 +5200,7 @@ qeth_free_vlan_addresses4(struct qeth_ca
 	if (!card->vlangrp)
 		return;
 	rcu_read_lock();
-	in_dev = __in_dev_get(card->vlangrp->vlan_devices[vid]);
+	in_dev = __in_dev_get_rcu(card->vlangrp->vlan_devices[vid]);
 	if (!in_dev)
 		goto out;
 	for (ifa = in_dev->ifa_list; ifa; ifa = ifa->ifa_next) {
@@ -7725,7 +7725,7 @@ qeth_arp_constructor(struct neighbour *n
 		goto out;
 
 	rcu_read_lock();
-	in_dev = rcu_dereference(__in_dev_get(dev));
+	in_dev = __in_dev_get_rcu(dev);
 	if (in_dev == NULL) {
 		rcu_read_unlock();
 		return -EINVAL;
diff --git a/include/linux/inetdevice.h b/include/linux/inetdevice.h
--- a/include/linux/inetdevice.h
+++ b/include/linux/inetdevice.h
@@ -142,13 +142,21 @@ static __inline__ int bad_mask(u32 mask,
 
 #define endfor_ifa(in_dev) }
 
+static inline struct in_device *__in_dev_get_rcu(const struct net_device *dev)
+{
+	struct in_device *in_dev = dev->ip_ptr;
+	if (in_dev)
+		in_dev = rcu_dereference(in_dev);
+	return in_dev;
+}
+
 static __inline__ struct in_device *
 in_dev_get(const struct net_device *dev)
 {
 	struct in_device *in_dev;
 
 	rcu_read_lock();
-	in_dev = dev->ip_ptr;
+	in_dev = __in_dev_get_rcu(dev);
 	if (in_dev)
 		atomic_inc(&in_dev->refcnt);
 	rcu_read_unlock();
@@ -156,7 +164,7 @@ in_dev_get(const struct net_device *dev)
 }
 
 static __inline__ struct in_device *
-__in_dev_get(const struct net_device *dev)
+__in_dev_get_rtnl(const struct net_device *dev)
 {
 	return (struct in_device*)dev->ip_ptr;
 }
diff --git a/net/atm/clip.c b/net/atm/clip.c
--- a/net/atm/clip.c
+++ b/net/atm/clip.c
@@ -310,7 +310,7 @@ static int clip_constructor(struct neigh
 	if (neigh->type != RTN_UNICAST) return -EINVAL;
 
 	rcu_read_lock();
-	in_dev = rcu_dereference(__in_dev_get(dev));
+	in_dev = __in_dev_get_rcu(dev);
 	if (!in_dev) {
 		rcu_read_unlock();
 		return -EINVAL;
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -703,7 +703,7 @@ int netpoll_setup(struct netpoll *np)
 
 	if (!np->local_ip) {
 		rcu_read_lock();
-		in_dev = __in_dev_get(ndev);
+		in_dev = __in_dev_get_rcu(ndev);
 
 		if (!in_dev || !in_dev->ifa_list) {
 			rcu_read_unlock();
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -1667,7 +1667,7 @@ static void pktgen_setup_inject(struct p
 			struct in_device *in_dev; 
 
 			rcu_read_lock();
-			in_dev = __in_dev_get(pkt_dev->odev);
+			in_dev = __in_dev_get_rcu(pkt_dev->odev);
 			if (in_dev) {
 				if (in_dev->ifa_list) {
 					pkt_dev->saddr_min = in_dev->ifa_list->ifa_address;
diff --git a/net/econet/af_econet.c b/net/econet/af_econet.c
--- a/net/econet/af_econet.c
+++ b/net/econet/af_econet.c
@@ -406,7 +406,7 @@ static int econet_sendmsg(struct kiocb *
 		unsigned long network = 0;
 
 		rcu_read_lock();
-		idev = __in_dev_get(dev);
+		idev = __in_dev_get_rcu(dev);
 		if (idev) {
 			if (idev->ifa_list)
 				network = ntohl(idev->ifa_list->ifa_address) & 
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -241,7 +241,7 @@ static int arp_constructor(struct neighb
 	neigh->type = inet_addr_type(addr);
 
 	rcu_read_lock();
-	in_dev = rcu_dereference(__in_dev_get(dev));
+	in_dev = __in_dev_get_rcu(dev);
 	if (in_dev == NULL) {
 		rcu_read_unlock();
 		return -EINVAL;
@@ -990,8 +990,8 @@ static int arp_req_set(struct arpreq *r,
 			ipv4_devconf.proxy_arp = 1;
 			return 0;
 		}
-		if (__in_dev_get(dev)) {
-			__in_dev_get(dev)->cnf.proxy_arp = 1;
+		if (__in_dev_get_rtnl(dev)) {
+			__in_dev_get_rtnl(dev)->cnf.proxy_arp = 1;
 			return 0;
 		}
 		return -ENXIO;
@@ -1096,8 +1096,8 @@ static int arp_req_delete(struct arpreq 
 				ipv4_devconf.proxy_arp = 0;
 				return 0;
 			}
-			if (__in_dev_get(dev)) {
-				__in_dev_get(dev)->cnf.proxy_arp = 0;
+			if (__in_dev_get_rtnl(dev)) {
+				__in_dev_get_rtnl(dev)->cnf.proxy_arp = 0;
 				return 0;
 			}
 			return -ENXIO;
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -351,7 +351,7 @@ static int inet_insert_ifa(struct in_ifa
 
 static int inet_set_ifa(struct net_device *dev, struct in_ifaddr *ifa)
 {
-	struct in_device *in_dev = __in_dev_get(dev);
+	struct in_device *in_dev = __in_dev_get_rtnl(dev);
 
 	ASSERT_RTNL();
 
@@ -449,7 +449,7 @@ static int inet_rtm_newaddr(struct sk_bu
 		goto out;
 
 	rc = -ENOBUFS;
-	if ((in_dev = __in_dev_get(dev)) == NULL) {
+	if ((in_dev = __in_dev_get_rtnl(dev)) == NULL) {
 		in_dev = inetdev_init(dev);
 		if (!in_dev)
 			goto out;
@@ -584,7 +584,7 @@ int devinet_ioctl(unsigned int cmd, void
 	if (colon)
 		*colon = ':';
 
-	if ((in_dev = __in_dev_get(dev)) != NULL) {
+	if ((in_dev = __in_dev_get_rtnl(dev)) != NULL) {
 		if (tryaddrmatch) {
 			/* Matthias Andree */
 			/* compare label and address (4.4BSD style) */
@@ -748,7 +748,7 @@ rarok:
 
 static int inet_gifconf(struct net_device *dev, char __user *buf, int len)
 {
-	struct in_device *in_dev = __in_dev_get(dev);
+	struct in_device *in_dev = __in_dev_get_rtnl(dev);
 	struct in_ifaddr *ifa;
 	struct ifreq ifr;
 	int done = 0;
@@ -791,7 +791,7 @@ u32 inet_select_addr(const struct net_de
 	struct in_device *in_dev;
 
 	rcu_read_lock();
-	in_dev = __in_dev_get(dev);
+	in_dev = __in_dev_get_rcu(dev);
 	if (!in_dev)
 		goto no_in_dev;
 
@@ -818,7 +818,7 @@ no_in_dev:
 	read_lock(&dev_base_lock);
 	rcu_read_lock();
 	for (dev = dev_base; dev; dev = dev->next) {
-		if ((in_dev = __in_dev_get(dev)) == NULL)
+		if ((in_dev = __in_dev_get_rcu(dev)) == NULL)
 			continue;
 
 		for_primary_ifa(in_dev) {
@@ -887,7 +887,7 @@ u32 inet_confirm_addr(const struct net_d
 
 	if (dev) {
 		rcu_read_lock();
-		if ((in_dev = __in_dev_get(dev)))
+		if ((in_dev = __in_dev_get_rcu(dev)))
 			addr = confirm_addr_indev(in_dev, dst, local, scope);
 		rcu_read_unlock();
 
@@ -897,7 +897,7 @@ u32 inet_confirm_addr(const struct net_d
 	read_lock(&dev_base_lock);
 	rcu_read_lock();
 	for (dev = dev_base; dev; dev = dev->next) {
-		if ((in_dev = __in_dev_get(dev))) {
+		if ((in_dev = __in_dev_get_rcu(dev))) {
 			addr = confirm_addr_indev(in_dev, dst, local, scope);
 			if (addr)
 				break;
@@ -957,7 +957,7 @@ static int inetdev_event(struct notifier
 			 void *ptr)
 {
 	struct net_device *dev = ptr;
-	struct in_device *in_dev = __in_dev_get(dev);
+	struct in_device *in_dev = __in_dev_get_rtnl(dev);
 
 	ASSERT_RTNL();
 
@@ -1078,7 +1078,7 @@ static int inet_dump_ifaddr(struct sk_bu
 		if (idx > s_idx)
 			s_ip_idx = 0;
 		rcu_read_lock();
-		if ((in_dev = __in_dev_get(dev)) == NULL) {
+		if ((in_dev = __in_dev_get_rcu(dev)) == NULL) {
 			rcu_read_unlock();
 			continue;
 		}
@@ -1149,7 +1149,7 @@ void inet_forward_change(void)
 	for (dev = dev_base; dev; dev = dev->next) {
 		struct in_device *in_dev;
 		rcu_read_lock();
-		in_dev = __in_dev_get(dev);
+		in_dev = __in_dev_get_rcu(dev);
 		if (in_dev)
 			in_dev->cnf.forwarding = on;
 		rcu_read_unlock();
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -173,7 +173,7 @@ int fib_validate_source(u32 src, u32 dst
 
 	no_addr = rpf = 0;
 	rcu_read_lock();
-	in_dev = __in_dev_get(dev);
+	in_dev = __in_dev_get_rcu(dev);
 	if (in_dev) {
 		no_addr = in_dev->ifa_list == NULL;
 		rpf = IN_DEV_RPFILTER(in_dev);
@@ -607,7 +607,7 @@ static int fib_inetaddr_event(struct not
 static int fib_netdev_event(struct notifier_block *this, unsigned long event, void *ptr)
 {
 	struct net_device *dev = ptr;
-	struct in_device *in_dev = __in_dev_get(dev);
+	struct in_device *in_dev = __in_dev_get_rtnl(dev);
 
 	if (event == NETDEV_UNREGISTER) {
 		fib_disable_ip(dev, 2);
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1087,7 +1087,7 @@ fib_convert_rtentry(int cmd, struct nlms
 		rta->rta_oif = &dev->ifindex;
 		if (colon) {
 			struct in_ifaddr *ifa;
-			struct in_device *in_dev = __in_dev_get(dev);
+			struct in_device *in_dev = __in_dev_get_rtnl(dev);
 			if (!in_dev)
 				return -ENODEV;
 			*colon = ':';
@@ -1268,7 +1268,7 @@ int fib_sync_up(struct net_device *dev)
 			}
 			if (nh->nh_dev == NULL || !(nh->nh_dev->flags&IFF_UP))
 				continue;
-			if (nh->nh_dev != dev || __in_dev_get(dev) == NULL)
+			if (nh->nh_dev != dev || !__in_dev_get_rtnl(dev))
 				continue;
 			alive++;
 			spin_lock_bh(&fib_multipath_lock);
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -1323,7 +1323,7 @@ static struct in_device * ip_mc_find_dev
 	}
 	if (dev) {
 		imr->imr_ifindex = dev->ifindex;
-		idev = __in_dev_get(dev);
+		idev = __in_dev_get_rtnl(dev);
 	}
 	return idev;
 }
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1104,10 +1104,10 @@ static int ipgre_open(struct net_device 
 			return -EADDRNOTAVAIL;
 		dev = rt->u.dst.dev;
 		ip_rt_put(rt);
-		if (__in_dev_get(dev) == NULL)
+		if (__in_dev_get_rtnl(dev) == NULL)
 			return -EADDRNOTAVAIL;
 		t->mlink = dev->ifindex;
-		ip_mc_inc_group(__in_dev_get(dev), t->parms.iph.daddr);
+		ip_mc_inc_group(__in_dev_get_rtnl(dev), t->parms.iph.daddr);
 	}
 	return 0;
 }
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -149,7 +149,7 @@ struct net_device *ipmr_new_tunnel(struc
 		if (err == 0 && (dev = __dev_get_by_name(p.name)) != NULL) {
 			dev->flags |= IFF_MULTICAST;
 
-			in_dev = __in_dev_get(dev);
+			in_dev = __in_dev_get_rtnl(dev);
 			if (in_dev == NULL && (in_dev = inetdev_init(dev)) == NULL)
 				goto failure;
 			in_dev->cnf.rp_filter = 0;
@@ -278,7 +278,7 @@ static int vif_delete(int vifi)
 
 	dev_set_allmulti(dev, -1);
 
-	if ((in_dev = __in_dev_get(dev)) != NULL) {
+	if ((in_dev = __in_dev_get_rtnl(dev)) != NULL) {
 		in_dev->cnf.mc_forwarding--;
 		ip_rt_multicast_event(in_dev);
 	}
@@ -421,7 +421,7 @@ static int vif_add(struct vifctl *vifc, 
 		return -EINVAL;
 	}
 
-	if ((in_dev = __in_dev_get(dev)) == NULL)
+	if ((in_dev = __in_dev_get_rtnl(dev)) == NULL)
 		return -EADDRNOTAVAIL;
 	in_dev->cnf.mc_forwarding++;
 	dev_set_allmulti(dev, +1);
diff --git a/net/ipv4/netfilter/ip_conntrack_netbios_ns.c b/net/ipv4/netfilter/ip_conntrack_netbios_ns.c
--- a/net/ipv4/netfilter/ip_conntrack_netbios_ns.c
+++ b/net/ipv4/netfilter/ip_conntrack_netbios_ns.c
@@ -58,7 +58,7 @@ static int help(struct sk_buff **pskb,
 		goto out;
 
 	rcu_read_lock();
-	in_dev = __in_dev_get(rt->u.dst.dev);
+	in_dev = __in_dev_get_rcu(rt->u.dst.dev);
 	if (in_dev != NULL) {
 		for_primary_ifa(in_dev) {
 			if (ifa->ifa_broadcast == iph->daddr) {
diff --git a/net/ipv4/netfilter/ipt_REDIRECT.c b/net/ipv4/netfilter/ipt_REDIRECT.c
--- a/net/ipv4/netfilter/ipt_REDIRECT.c
+++ b/net/ipv4/netfilter/ipt_REDIRECT.c
@@ -93,7 +93,7 @@ redirect_target(struct sk_buff **pskb,
 		newdst = 0;
 		
 		rcu_read_lock();
-		indev = __in_dev_get((*pskb)->dev);
+		indev = __in_dev_get_rcu((*pskb)->dev);
 		if (indev && (ifa = indev->ifa_list))
 			newdst = ifa->ifa_local;
 		rcu_read_unlock();
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2128,7 +2128,7 @@ int ip_route_input(struct sk_buff *skb, 
 		struct in_device *in_dev;
 
 		rcu_read_lock();
-		if ((in_dev = __in_dev_get(dev)) != NULL) {
+		if ((in_dev = __in_dev_get_rcu(dev)) != NULL) {
 			int our = ip_check_mc(in_dev, daddr, saddr,
 				skb->nh.iph->protocol);
 			if (our
@@ -2443,7 +2443,9 @@ static int ip_route_output_slow(struct r
 		err = -ENODEV;
 		if (dev_out == NULL)
 			goto out;
-		if (__in_dev_get(dev_out) == NULL) {
+
+		/* RACE: Check return value of inet_select_addr instead. */
+		if (__in_dev_get_rtnl(dev_out) == NULL) {
 			dev_put(dev_out);
 			goto out;	/* Wrong error code */
 		}
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1806,7 +1806,7 @@ static void sit_add_v4_addrs(struct inet
 	}
 
         for (dev = dev_base; dev != NULL; dev = dev->next) {
-		struct in_device * in_dev = __in_dev_get(dev);
+		struct in_device * in_dev = __in_dev_get_rtnl(dev);
 		if (in_dev && (dev->flags & IFF_UP)) {
 			struct in_ifaddr * ifa;
 
diff --git a/net/irda/irlan/irlan_eth.c b/net/irda/irlan/irlan_eth.c
--- a/net/irda/irlan/irlan_eth.c
+++ b/net/irda/irlan/irlan_eth.c
@@ -310,7 +310,7 @@ void irlan_eth_send_gratuitous_arp(struc
 #ifdef CONFIG_INET
 	IRDA_DEBUG(4, "IrLAN: Sending gratuitous ARP\n");
 	rcu_read_lock();
-	in_dev = __in_dev_get(dev);
+	in_dev = __in_dev_get_rcu(dev);
 	if (in_dev == NULL)
 		goto out;
 	if (in_dev->ifa_list)
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -147,7 +147,7 @@ static void sctp_v4_copy_addrlist(struct
 	struct sctp_sockaddr_entry *addr;
 
 	rcu_read_lock();
-	if ((in_dev = __in_dev_get(dev)) == NULL) {
+	if ((in_dev = __in_dev_get_rcu(dev)) == NULL) {
 		rcu_read_unlock();
 		return;
 	}

--6c2NcOVqGQ03X4Wi--
