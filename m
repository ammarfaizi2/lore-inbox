Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262291AbTC3MZv>; Sun, 30 Mar 2003 07:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262611AbTC3MZv>; Sun, 30 Mar 2003 07:25:51 -0500
Received: from vsmtp4.tin.it ([212.216.176.224]:6030 "EHLO smtp4.cp.tin.it")
	by vger.kernel.org with ESMTP id <S262291AbTC3MZs>;
	Sun, 30 Mar 2003 07:25:48 -0500
Date: Sun, 30 Mar 2003 14:27:05 +0200
From: Simone Piunno <pioppo@ferrara.linux.it>
To: netdev@oss.sgi.com, usagi-users@linux-ipv6.org
Cc: linux-kernel@vger.kernel.org, ds6-devel@deepspace6.net
Subject: IPv6 duplicate address bugfix
Message-ID: <20030330122705.GA18283@ferrara.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: Ferrara LUG
X-Operating-System: Linux 2.4.20-skas3
X-Message: GnuPG/PGP5 are welcome
X-Key-ID: 860314FC/C09E842C
X-Key-FP: 9C15F0D3E3093593AC952C92A0CD52B4860314FC
X-Key-URL: http://members.ferrara.linux.it/pioppo/mykey.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

When adding an IPv6 address to a given interface, I'm allowed to
add that address multiple time, e.g.:

[root@abulafia root]# ip addr add 3ffe:4242:4242::1 dev eth0
[root@abulafia root]# ip addr add 3ffe:4242:4242::1 dev eth0
[root@abulafia root]# ip addr add 3ffe:4242:4242::1 dev eth0
[root@abulafia root]# ip addr show dev eth0
2: eth0: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 100
    link/ether 00:48:54:1b:25:30 brd ff:ff:ff:ff:ff:ff
    inet6 3ffe:4242:4242::1/128 scope global 
    inet6 3ffe:4242:4242::1/128 scope global 
    inet6 3ffe:4242:4242::1/128 scope global 
    inet6 fe80::248:54ff:fe1b:2530/10 scope link

Apparently, this is not a stability problem, because I'm allowed to 
delete 3 times that address before receving a "not found" error,
but there's no reason to allow multiple instances of the same address 
on the same interface, so this is a bug nonetheless.

Bug is confirmed on:
  - 2.4.20
  - 2.5.66
  - latest -usagi

Following is a patch attempting to fix this bug.
It's for 2.4.20 but sould apply cleanly on 2.5 too.

Credits:
  Chad N. Tindel  - discovered the bug and showed it to me
  Peter Bieringer - confirmed it's a bug
  Mauro Tortonesi - suggested sending a patch to this list.

Regards,
  Simone Piunno


--- net/ipv6/addrconf.c.orig	2003-03-25 21:33:55.000000000 +0100
+++ net/ipv6/addrconf.c	2003-03-30 13:48:23.000000000 +0200
@@ -89,6 +89,8 @@
 static struct inet6_ifaddr		*inet6_addr_lst[IN6_ADDR_HSIZE];
 static rwlock_t	addrconf_hash_lock = RW_LOCK_UNLOCKED;
 
+static spinlock_t addrconf_add_lock = SPIN_LOCK_UNLOCKED;
+
 /* Protects inet6 devices */
 rwlock_t addrconf_lock = RW_LOCK_UNLOCKED;
 
@@ -621,6 +623,24 @@
 	return ifp != NULL;
 }
 
+static struct inet6_ifaddr *
+ipv6_addr_already_present(struct in6_addr *addr, struct net_device *dev)
+{
+	struct inet6_ifaddr *ifp;
+	u8 hash = ipv6_addr_hash(addr);
+	
+	read_lock_bh(&addrconf_hash_lock);
+	for (ifp = inet6_addr_lst[hash]; ifp; ifp = ifp->lst_next) {
+		if (ipv6_addr_cmp(&ifp->addr, addr) == 0 && ifp->idev->dev == dev) {
+			read_unlock_bh(&addrconf_hash_lock);
+			return ifp;
+		}
+	}
+	read_unlock_bh(&addrconf_hash_lock);
+	return NULL;
+}
+
+
 struct inet6_ifaddr * ipv6_get_ifaddr(struct in6_addr *addr, struct net_device *dev)
 {
 	struct inet6_ifaddr * ifp;
@@ -908,7 +928,7 @@
 		return;
 
 ok:
-
+		spin_lock_bh(&addrconf_add_lock);
 		ifp = ipv6_get_ifaddr(&addr, dev);
 
 		if (ifp == NULL && valid_lft) {
@@ -920,12 +940,14 @@
 						    addr_type&IPV6_ADDR_SCOPE_MASK, 0);
 
 			if (ifp == NULL) {
+				spin_unlock_bh(&addrconf_add_lock);
 				in6_dev_put(in6_dev);
 				return;
 			}
 
 			addrconf_dad_start(ifp);
 		}
+		spin_unlock_bh(&addrconf_add_lock);
 
 		if (ifp && valid_lft == 0) {
 			ipv6_del_addr(ifp);
@@ -1033,11 +1055,19 @@
 
 	scope = ipv6_addr_scope(pfx);
 
+	spin_lock_bh(&addrconf_add_lock);
+	if (ipv6_addr_already_present(pfx, dev)) {
+		spin_unlock_bh(&addrconf_add_lock);
+		return -EEXIST;
+	}
+
 	if ((ifp = ipv6_add_addr(idev, pfx, plen, scope, IFA_F_PERMANENT)) != NULL) {
+		spin_unlock_bh(&addrconf_add_lock);
 		addrconf_dad_start(ifp);
 		in6_ifa_put(ifp);
 		return 0;
 	}
+	spin_unlock_bh(&addrconf_add_lock);
 
 	return -ENOBUFS;
 }
-- 
 Simone Piunno -- http://members.ferrara.linux.it/pioppo 
.-------  Adde parvum parvo magnus acervus erit  -------.
 Ferrara Linux Users Group - http://www.ferrara.linux.it 
 Deep Space 6, IPv6 on Linux - http://www.deepspace6.net 
 GNU Mailman, Mailing List Manager - http://www.list.org 
`-------------------------------------------------------'
