Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261711AbSI0PMe>; Fri, 27 Sep 2002 11:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261724AbSI0PMe>; Fri, 27 Sep 2002 11:12:34 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:1548 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S261711AbSI0PMY>; Fri, 27 Sep 2002 11:12:24 -0400
Date: Sat, 28 Sep 2002 00:17:42 +0900 (JST)
Message-Id: <20020928.001742.125874265.yoshfuji@linux-ipv6.org>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
CC: usagi@linux-ipv6.org
Subject: [PATCH] IPv6: Improvement of Source Address Selection
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This patch supports standard default source address selection
algorithm.  It takes status, address/prefix itself (prefer same address,
prefer longest matching prefix) into consideration.
Note: Even though matching label is not implemented yet,
      this is better than current one.

Following patch is against linux-2.4.19.

Thank you in advance.

-------------------------------------------------------------------
Patch-Name: Improvement of Source Address Selection
Patch-Id: FIX_2_4_19_SADDRSELECT-20020906
Patch-Author: YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
Credit: YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
Reference: draft-ietf-ipv6-default-addr-select-09.txt
-------------------------------------------------------------------
Index: include/net/addrconf.h
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/include/net/addrconf.h,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.6.1
diff -u -r1.1.1.1 -r1.1.1.1.6.1
--- include/net/addrconf.h	2002/08/20 09:46:45	1.1.1.1
+++ include/net/addrconf.h	2002/09/26 19:15:15	1.1.1.1.6.1
@@ -55,6 +55,9 @@
 					      struct net_device *dev);
 extern struct inet6_ifaddr *	ipv6_get_ifaddr(struct in6_addr *addr,
 						struct net_device *dev);
+extern int			ipv6_dev_get_saddr(struct net_device *ddev,
+						   struct in6_addr *daddr,
+						   struct in6_addr *saddr);
 extern int			ipv6_get_saddr(struct dst_entry *dst, 
 					       struct in6_addr *daddr,
 					       struct in6_addr *saddr);
Index: net/ipv6/addrconf.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv6/addrconf.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.6.4
diff -u -r1.1.1.1 -r1.1.1.1.6.4
--- net/ipv6/addrconf.c	2002/08/20 09:47:02	1.1.1.1
+++ net/ipv6/addrconf.c	2002/09/26 19:28:13	1.1.1.1.6.4
@@ -26,6 +26,10 @@
  *						packets.
  *	yoshfuji@USAGI			:       Fixed interval between DAD
  *						packets.
+ *	YOSHIFUJI Hideaki @USAGI	:	improved source address
+ *						selection; consider scope,
+ *						status etc.
+ *
  */
 
 #include <linux/config.h>
@@ -188,6 +192,99 @@
 	return IPV6_ADDR_RESERVED;
 }
 
+#ifndef IPV6_ADDR_MC_SCOPE
+#define IPV6_ADDR_MC_SCOPE(a)	\
+	((a)->s6_addr[1] & 0x0f)	/* XXX nonstandard */
+#define __IPV6_ADDR_SCOPE_RESERVED	-2
+#define __IPV6_ADDR_SCOPE_ANY		-1
+#define IPV6_ADDR_SCOPE_NODELOCAL	0x01
+#define IPV6_ADDR_SCOPE_LINKLOCAL	0x02
+#define IPV6_ADDR_SCOPE_SITELOCAL	0x05
+#define IPV6_ADDR_SCOPE_ORGLOCAL	0x08
+#define IPV6_ADDR_SCOPE_GLOBAL		0x0e
+#endif
+
+int ipv6_addrselect_scope(const struct in6_addr *addr)
+{
+	u32 st;
+
+	st = addr->s6_addr32[0];
+
+	if ((st & __constant_htonl(0xE0000000)) != __constant_htonl(0x00000000) &&
+	    (st & __constant_htonl(0xE0000000)) != __constant_htonl(0xE0000000))
+		return IPV6_ADDR_SCOPE_GLOBAL;
+
+	if ((st & __constant_htonl(0xFF000000)) == __constant_htonl(0xFF000000))
+		return IPV6_ADDR_MC_SCOPE(addr);
+        
+	if ((st & __constant_htonl(0xFFC00000)) == __constant_htonl(0xFE800000))
+		return IPV6_ADDR_SCOPE_LINKLOCAL;
+
+	if ((st & __constant_htonl(0xFFC00000)) == __constant_htonl(0xFEC00000))
+		return IPV6_ADDR_SCOPE_SITELOCAL;
+
+	if ((st | addr->s6_addr32[1]) == 0) {
+		if (addr->s6_addr32[2] == 0) {
+			if (addr->s6_addr32[3] == 0)
+				return __IPV6_ADDR_SCOPE_ANY;
+
+			if (addr->s6_addr32[3] == __constant_htonl(0x00000001))
+				return IPV6_ADDR_SCOPE_LINKLOCAL;	/* section 2.4 */
+
+			return IPV6_ADDR_SCOPE_GLOBAL;			/* section 2.3 */
+		}
+
+		if (addr->s6_addr32[2] == __constant_htonl(0x0000FFFF)) {
+			if (addr->s6_addr32[3] == __constant_htonl(0xA9FF0000))
+				return IPV6_ADDR_SCOPE_LINKLOCAL;	/* section 2.2 */
+			if (addr->s6_addr32[3] == __constant_htonl(0xAC000000)) {
+				if (addr->s6_addr32[3] == __constant_htonl(0xAC100000))
+					return IPV6_ADDR_SCOPE_SITELOCAL;	/* section 2.2 */
+
+				return IPV6_ADDR_SCOPE_LINKLOCAL;	/* section 2.2 */
+			}
+			if (addr->s6_addr32[3] == __constant_htonl(0x0A000000))
+				return IPV6_ADDR_SCOPE_SITELOCAL;	/* section 2.2 */
+			if (addr->s6_addr32[3] == __constant_htonl(0xC0A80000))
+				return IPV6_ADDR_SCOPE_SITELOCAL;	/* section 2.2 */
+
+                        return IPV6_ADDR_SCOPE_GLOBAL;                  /* section 2.2 */
+		}
+	}
+
+	return __IPV6_ADDR_SCOPE_RESERVED;
+}
+
+/* find 1st bit in difference between the 2 addrs */
+static inline int addr_diff(const void *__a1, const void *__a2, int addrlen)
+{
+	/* find 1st bit in difference between the 2 addrs.
+	 * bit may be an invalid value,
+	 * but if it is >= plen, the value is ignored in any case.
+	 */
+	const u32 *a1 = __a1;
+	const u32 *a2 = __a2;
+	int i;
+
+	addrlen >>= 2;
+	for (i = 0; i < addrlen; i++) {
+		u32 xb = a1[i] ^ a2[i];
+		if (xb) {
+			int j = 31;
+			xb = ntohl(xb);
+			while ((xb & (1 << j)) == 0)
+				j--;
+			return (i * 32 + 31 - j);
+		}
+	}
+	return addrlen<<5;
+}
+
+static inline int ipv6_addr_diff(const struct in6_addr *a1, const struct in6_addr *a2)
+{
+	 return addr_diff(a1->s6_addr, a2->s6_addr, sizeof(struct in6_addr));
+}
+
 static void addrconf_del_timer(struct inet6_ifaddr *ifp)
 {
 	if (del_timer(&ifp->timer))
@@ -449,120 +546,137 @@
 
 /*
  *	Choose an apropriate source address
- *	should do:
- *	i)	get an address with an apropriate scope
- *	ii)	see if there is a specific route for the destination and use
- *		an address of the attached interface 
- *	iii)	don't use deprecated addresses
+ *	draft-ietf-ipngwg-default-addr-select-09.txt
  */
-int ipv6_get_saddr(struct dst_entry *dst,
-		   struct in6_addr *daddr, struct in6_addr *saddr)
+struct addrselect_attrs {
+	struct inet6_ifaddr *ifp;
+	int	match;
+	int	deprecated;
+	int	home;
+	int	temporary;
+	int	device;
+	int	scope;
+	int	label;
+	int	matchlen;
+};
+
+int ipv6_dev_get_saddr(struct net_device *daddr_dev,
+		       struct in6_addr *daddr, struct in6_addr *saddr)
 {
-	int scope;
-	struct inet6_ifaddr *ifp = NULL;
-	struct inet6_ifaddr *match = NULL;
-	struct net_device *dev = NULL;
+	int daddr_scope;
+	struct inet6_ifaddr *ifp0, *ifp = NULL;
+	struct net_device *dev;
 	struct inet6_dev *idev;
-	struct rt6_info *rt;
-	int err;
 
-	rt = (struct rt6_info *) dst;
-	if (rt)
-		dev = rt->rt6i_dev;
-
-	scope = ipv6_addr_scope(daddr);
-	if (rt && (rt->rt6i_flags & RTF_ALLONLINK)) {
-		/*
-		 *	route for the "all destinations on link" rule
-		 *	when no routers are present
-		 */
-		scope = IFA_LINK;
-	}
-
-	/*
-	 *	known dev
-	 *	search dev and walk through dev addresses
-	 */
+	int err;
+	int update;
+	struct addrselect_attrs candidate = {NULL,0,0,0,0,0,0,0,0};
 
-	if (dev) {
-		if (dev->flags & IFF_LOOPBACK)
-			scope = IFA_HOST;
+	daddr_scope = ipv6_addrselect_scope(daddr);
 
-		read_lock(&addrconf_lock);
+	read_lock(&dev_base_lock);
+	read_lock(&addrconf_lock);
+	for (dev = dev_base; dev; dev=dev->next) {
 		idev = __in6_dev_get(dev);
-		if (idev) {
-			read_lock_bh(&idev->lock);
-			for (ifp=idev->addr_list; ifp; ifp=ifp->if_next) {
-				if (ifp->scope == scope) {
-					if (!(ifp->flags & (IFA_F_DEPRECATED|IFA_F_TENTATIVE))) {
-						in6_ifa_hold(ifp);
-						read_unlock_bh(&idev->lock);
-						read_unlock(&addrconf_lock);
-						goto out;
-					}
-
-					if (!match && !(ifp->flags & IFA_F_TENTATIVE)) {
-						match = ifp;
-						in6_ifa_hold(ifp);
-					}
+
+		if (!idev)
+			continue;
+
+		read_lock_bh(&idev->lock);
+		ifp0 = idev->addr_list;
+		for (ifp=ifp0; ifp; ifp=ifp->if_next) {
+			struct addrselect_attrs temp = {NULL,0,0,0,0,0,0,0,0};
+			update = 0;
+
+			/* Rule 1: Prefer same address */
+			temp.match = ipv6_addr_cmp(&ifp->addr, daddr) == 0;
+			if (!update)
+				update = temp.match - candidate.match;
+			if (update < 0) {
+				continue;
+			}
+
+			/* Rule 2: Prefer appropriate scope */
+			temp.scope = ipv6_addrselect_scope(&ifp->addr);
+			if (!update) {
+				update = temp.scope - candidate.scope;
+				if (update > 0) {
+					update = candidate.scope < daddr_scope ? 1 : -1;
+				} else if (update < 0) {
+					update = temp.scope < daddr_scope ? -1 : 1;
 				}
 			}
-			read_unlock_bh(&idev->lock);
-		}
-		read_unlock(&addrconf_lock);
-	}
+			if (update < 0) {
+				continue;
+			}
 
-	if (scope == IFA_LINK)
-		goto out;
+			/* Rule 3: Avoid deprecated address */
+			temp.deprecated = ifp->flags & IFA_F_DEPRECATED;
+			if (!update)
+				update = candidate.deprecated - temp.deprecated;
+			if (update < 0) {
+				continue;
+			}
 
-	/*
-	 *	dev == NULL or search failed for specified dev
-	 */
+			/* XXX: Rule 4: Prefer home address */
 
-	read_lock(&dev_base_lock);
-	read_lock(&addrconf_lock);
-	for (dev = dev_base; dev; dev=dev->next) {
-		idev = __in6_dev_get(dev);
-		if (idev) {
-			read_lock_bh(&idev->lock);
-			for (ifp=idev->addr_list; ifp; ifp=ifp->if_next) {
-				if (ifp->scope == scope) {
-					if (!(ifp->flags&(IFA_F_DEPRECATED|IFA_F_TENTATIVE))) {
-						in6_ifa_hold(ifp);
-						read_unlock_bh(&idev->lock);
-						goto out_unlock_base;
-					}
-
-					if (!match && !(ifp->flags&IFA_F_TENTATIVE)) {
-						match = ifp;
-						in6_ifa_hold(ifp);
-					}
-				}
+			/* Rule 5: Prefer outgoing interface */
+			temp.device = daddr_dev ? daddr_dev == (ifp->idev ? ifp->idev->dev : daddr_dev) : 0;
+			if (!update)
+				update = temp.device - candidate.device;
+			if (update < 0) {
+				continue;
+			}
+
+			/* XXX: Rule 6: Prefer matching label */
+			temp.label = 0;
+			if (!update)
+				update = temp.label - candidate.label;
+			if (update < 0) {
+				continue;
 			}
-			read_unlock_bh(&idev->lock);
+
+			/* XXX: Rule 7: Prefer public address */
+
+			/* Rule 8: Use longest matching prefix */
+			temp.matchlen = ipv6_addr_diff(&ifp->addr, daddr);
+			if (!update)
+				update = temp.matchlen - candidate.matchlen;
+			if (update < 0) {
+				continue;
+			}
+
+			/* Final Rule */
+			if (update <= 0)
+				continue;
+
+			/* update candidate */
+			temp.ifp = ifp;
+			in6_ifa_hold(ifp);
+			if (candidate.ifp)
+				in6_ifa_put(candidate.ifp);
+			candidate = temp;
 		}
+		read_unlock_bh(&idev->lock);
 	}
-
-out_unlock_base:
 	read_unlock(&addrconf_lock);
 	read_unlock(&dev_base_lock);
-
-out:
-	if (ifp == NULL) {
-		ifp = match;
-		match = NULL;
-	}
 
-	err = -EADDRNOTAVAIL;
-	if (ifp) {
-		ipv6_addr_copy(saddr, &ifp->addr);
+	if (candidate.ifp) {
+		ipv6_addr_copy(saddr, &candidate.ifp->addr);
+		in6_ifa_put(candidate.ifp);
 		err = 0;
-		in6_ifa_put(ifp);
+	} else {
+		err = -EADDRNOTAVAIL;
 	}
-	if (match)
-		in6_ifa_put(match);
-
 	return err;
+}
+
+int ipv6_get_saddr(struct dst_entry *dst,
+		   struct in6_addr *daddr, struct in6_addr *saddr)
+{
+	return ipv6_dev_get_saddr(dst ? ((struct rt6_info *)dst)->rt6i_dev : NULL,
+				  daddr, saddr);
 }
 
 int ipv6_get_lladdr(struct net_device *dev, struct in6_addr *addr)
