Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261346AbTCaBXy>; Sun, 30 Mar 2003 20:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261351AbTCaBXy>; Sun, 30 Mar 2003 20:23:54 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:25355 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S261346AbTCaBXv>; Sun, 30 Mar 2003 20:23:51 -0500
Date: Mon, 31 Mar 2003 10:34:51 +0900 (JST)
Message-Id: <20030331.103451.118020141.yoshfuji@linux-ipv6.org>
To: davem@redhat.com, kuznet@ms2.inr.ac.ru
CC: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, usagi@linux-ipv6.org,
       pioppo@ferrara.linux.it
Subject: Re: [PATCH] IPv6: Don't assign a same IPv6 address on a same
 interface
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20030331.033524.114862210.yoshfuji@linux-ipv6.org>
References: <20030330.235809.70243437.yoshfuji@linux-ipv6.org>
	<20030330163656.GA18645@ferrara.linux.it>
	<20030331.033524.114862210.yoshfuji@linux-ipv6.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030331.033524.114862210.yoshfuji@linux-ipv6.org> (at Mon, 31 Mar 2003 03:35:24 +0900 (JST)), YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> says:

> In article <20030330163656.GA18645@ferrara.linux.it> (at Sun, 30 Mar 2003 18:36:56 +0200), Simone Piunno <pioppo@ferrara.linux.it> says:
> 
> >  - locking inside ipv6_add_addr() is simpler and more linear but
> >    semantically wrong because you're unable to tell the user why his 
> >    "ip addr add" failed.  E.g. you answer ENOBUFS instead of EEXIST.
> 
> We don't want to create duplicate address in any case.
> ipv6_add_addr() IS right place.
> And, we can return error code by using IS_ERR() etc.
> I'll fix this.

Here's the revised patch.
Thank you.

Index: net/ipv6/addrconf.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/net/ipv6/addrconf.c,v
retrieving revision 1.1.1.9
retrieving revision 1.1.1.9.2.6
diff -u -r1.1.1.9 -r1.1.1.9.2.6
--- net/ipv6/addrconf.c	25 Mar 2003 04:33:45 -0000	1.1.1.9
+++ net/ipv6/addrconf.c	30 Mar 2003 18:51:29 -0000	1.1.1.9.2.6
@@ -30,6 +30,8 @@
  *						address validation timer.
  *	YOSHIFUJI Hideaki @USAGI	:	Privacy Extensions (RFC3041)
  *						support.
+ *	Yuji SEKIYA @USAGI		:	Don't assign a same IPv6
+ *						address on a same interface.
  */
 
 #include <linux/config.h>
@@ -126,6 +128,8 @@
 static void addrconf_rs_timer(unsigned long data);
 static void ipv6_ifa_notify(int event, struct inet6_ifaddr *ifa);
 
+static int ipv6_chk_same_addr(const struct in6_addr *addr, struct net_device *dev);
+
 static struct notifier_block *inet6addr_chain;
 
 struct ipv6_devconf ipv6_devconf =
@@ -492,12 +496,23 @@
 {
 	struct inet6_ifaddr *ifa;
 	int hash;
+	static spinlock_t lock = SPIN_LOCK_UNLOCKED;
+
+	spin_lock_bh(&lock);
+
+	/* Ignore adding duplicate addresses on an interface */
+	if (ipv6_chk_same_addr(addr, idev->dev)) {
+		spin_unlock_bh(&lock);
+		ADBG(("ipv6_add_addr: already assigned\n"));
+		return ERR_PTR(-EEXIST);
+	}
 
 	ifa = kmalloc(sizeof(struct inet6_ifaddr), GFP_ATOMIC);
 
 	if (ifa == NULL) {
+		spin_unlock_bh(&lock);
 		ADBG(("ipv6_add_addr: malloc failed\n"));
-		return NULL;
+		return ERR_PTR(-ENOBUFS);
 	}
 
 	memset(ifa, 0, sizeof(struct inet6_ifaddr));
@@ -513,8 +528,9 @@
 	read_lock(&addrconf_lock);
 	if (idev->dead) {
 		read_unlock(&addrconf_lock);
+		spin_unlock_bh(&lock);
 		kfree(ifa);
-		return NULL;
+		return ERR_PTR(-ENODEV);	/*XXX*/
 	}
 
 	inet6_ifa_count++;
@@ -551,6 +567,7 @@
 	in6_ifa_hold(ifa);
 	write_unlock_bh(&idev->lock);
 	read_unlock(&addrconf_lock);
+	spin_unlock_bh(&lock);
 
 	notifier_call_chain(&inet6addr_chain,NETDEV_UP,ifa);
 
@@ -697,7 +714,7 @@
 	ift = ipv6_count_addresses(idev) < IPV6_MAX_ADDRESSES ?
 		ipv6_add_addr(idev, &addr, tmp_plen,
 			      ipv6_addr_type(&addr)&IPV6_ADDR_SCOPE_MASK, IFA_F_TEMPORARY) : 0;
-	if (!ift) {
+	if (IS_ERR(ift)) {
 		in6_dev_put(idev);
 		in6_ifa_put(ifp);
 		printk(KERN_INFO
@@ -928,6 +945,23 @@
 	return ifp != NULL;
 }
 
+static
+int ipv6_chk_same_addr(const struct in6_addr *addr, struct net_device *dev)
+{
+	struct inet6_ifaddr * ifp;
+	u8 hash = ipv6_addr_hash(addr);
+
+	read_lock_bh(&addrconf_hash_lock);
+	for(ifp = inet6_addr_lst[hash]; ifp; ifp=ifp->lst_next) {
+		if (ipv6_addr_cmp(&ifp->addr, addr) == 0) {
+			if (dev == NULL || ifp->idev->dev == dev)
+				break;
+		}
+	}
+	read_unlock_bh(&addrconf_hash_lock);
+	return ifp != NULL;
+}
+
 struct inet6_ifaddr * ipv6_get_ifaddr(struct in6_addr *addr, struct net_device *dev)
 {
 	struct inet6_ifaddr * ifp;
@@ -1344,7 +1378,7 @@
 				ifp = ipv6_add_addr(in6_dev, &addr, pinfo->prefix_len,
 						    addr_type&IPV6_ADDR_SCOPE_MASK, 0);
 
-			if (ifp == NULL) {
+			if (IS_ERR(ifp)) {
 				in6_dev_put(in6_dev);
 				return;
 			}
@@ -1499,13 +1533,14 @@
 
 	scope = ipv6_addr_scope(pfx);
 
-	if ((ifp = ipv6_add_addr(idev, pfx, plen, scope, IFA_F_PERMANENT)) != NULL) {
+	ifp = ipv6_add_addr(idev, pfx, plen, scope, IFA_F_PERMANENT);
+	if (!IS_ERR(ifp)) {
 		addrconf_dad_start(ifp);
 		in6_ifa_put(ifp);
 		return 0;
 	}
 
-	return -ENOBUFS;
+	return PTR_ERR(ifp);
 }
 
 static int inet6_addr_del(int ifindex, struct in6_addr *pfx, int plen)
@@ -1597,7 +1632,7 @@
 
 	if (addr.s6_addr32[3]) {
 		ifp = ipv6_add_addr(idev, &addr, 128, scope, IFA_F_PERMANENT);
-		if (ifp) {
+		if (!IS_ERR(ifp)) {
 			spin_lock_bh(&ifp->lock);
 			ifp->flags &= ~IFA_F_TENTATIVE;
 			spin_unlock_bh(&ifp->lock);
@@ -1633,7 +1668,7 @@
 
 				ifp = ipv6_add_addr(idev, &addr, plen, flag,
 						    IFA_F_PERMANENT);
-				if (ifp) {
+				if (!IS_ERR(ifp)) {
 					spin_lock_bh(&ifp->lock);
 					ifp->flags &= ~IFA_F_TENTATIVE;
 					spin_unlock_bh(&ifp->lock);
@@ -1660,7 +1695,7 @@
 	}
 
 	ifp = ipv6_add_addr(idev, &in6addr_loopback, 128, IFA_HOST, IFA_F_PERMANENT);
-	if (ifp) {
+	if (!IS_ERR(ifp)) {
 		spin_lock_bh(&ifp->lock);
 		ifp->flags &= ~IFA_F_TENTATIVE;
 		spin_unlock_bh(&ifp->lock);
@@ -1674,7 +1709,7 @@
 	struct inet6_ifaddr * ifp;
 
 	ifp = ipv6_add_addr(idev, addr, 64, IFA_LINK, IFA_F_PERMANENT);
-	if (ifp) {
+	if (!IS_ERR(ifp)) {
 		addrconf_dad_start(ifp);
 		in6_ifa_put(ifp);
 	}

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
