Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265139AbSJaDjC>; Wed, 30 Oct 2002 22:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265166AbSJaDjC>; Wed, 30 Oct 2002 22:39:02 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:56076 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S265139AbSJaDim>; Wed, 30 Oct 2002 22:38:42 -0500
Date: Thu, 31 Oct 2002 12:44:59 +0900 (JST)
Message-Id: <20021031.124459.66300488.yoshfuji@linux-ipv6.org>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
CC: davem@redhat.com, kuznet@ms2.inr.ac.ru, usagi@linux-ipv6.org
Subject: [PATCH] IPv6: Privacy Extensions for Stateless Address
 Autoconfiguration in IPv6
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: ,!^C1nUj;HDn\o}#MDnZW<|oj*]iIB/>/Rj|xZ=D=hBIY#)lQ,$n#kJvDg7at|p;w0^8&4_
 OS17ezZP7m/LlFJYPF}FdcGx!,qBM:w{Ub2#M8_@n^nYT%?u+bwTsqni(z5
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Nodes use IPv6 stateless address autoconfiguration to generate addresses.
They are formed by combining network prefixes with an interface identifier.
On interfaces such as ethernet, interface identifier is derived from
static embedded IEEE Identifies. and eavesdroppers and other information
collectors may identify the address is actually correspond to the same
node.
Privacy Extensions (RFC3041) is designed to make it difficult for
eavesdroppers and other information collectors to identify actually
correspond to the same node by changing the interface identifier
periodically.

This patch is against linux-2.5.44+bk2 snapshot.

Thanks in advance.

-------------------------------------------------------------------
Patch-Name: Privacy Extensions for Stateless Address Autoconfiguration in IPv6
Patch-Id: FIX_2_5_44+bk2_ADDRCONF_PRIVACY-20021031
Patch-Author: YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
Credit: YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
-------------------------------------------------------------------
Index: Documentation/networking/ip-sysctl.txt
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/Documentation/networking/ip-sysctl.txt,v
retrieving revision 1.1.1.3
retrieving revision 1.1.1.3.6.1
diff -u -r1.1.1.3 -r1.1.1.3.6.1
--- Documentation/networking/ip-sysctl.txt	30 Oct 2002 09:43:01 -0000	1.1.1.3
+++ Documentation/networking/ip-sysctl.txt	30 Oct 2002 18:15:04 -0000	1.1.1.3.6.1
@@ -611,6 +611,37 @@
 	0 to disable any limiting, otherwise the maximal rate in jiffies(1)
 	Default: 100
 
+use_tempaddr - INTEGER
+	Preference for Privacy Extensions (RFC3041).
+	  <= 0 : disable Privacy Extensions
+	  == 1 : enable Privacy Extensions, but prefer public
+	         addresses over temporary addresses.
+	  >  1 : enable Privacy Extensions and prefer temporary
+	         addresses over public addresses.
+	Default: 1 (for most devices)
+		 0 (for point-to-point devices and loopback devices)
+
+temp_valid_lft - INTEGER
+	valid lifetime (in seconds) for temporary addresses.
+	Default: 604800 (7 days)
+
+temp_prefered_lft - INTEGER
+	Preferred lifetime (in seconds) for temorary addresses.
+	Default: 86400 (1 day)
+
+max_desync_factor - INTEGER
+	Maximum value for DESYNC_FACTOR, which is a random value
+	that ensures that clients don't synchronize with each 
+	other and generage new addresses at exactly the same time.
+	value is in seconds.
+	Default: 600
+	
+regen_max_retry - INTEGER
+	Number of attempts before give up attempting to generate
+	valid temporary addresses.
+	Default: 5
+
+
 IPv6 Update by:
 Pekka Savola <pekkas@netcore.fi>
 YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
Index: include/linux/rtnetlink.h
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/include/linux/rtnetlink.h,v
retrieving revision 1.1.1.2
retrieving revision 1.1.1.2.6.1
diff -u -r1.1.1.2 -r1.1.1.2.6.1
--- include/linux/rtnetlink.h	30 Oct 2002 09:43:04 -0000	1.1.1.2
+++ include/linux/rtnetlink.h	30 Oct 2002 18:15:04 -0000	1.1.1.2.6.1
@@ -335,6 +335,7 @@
 /* ifa_flags */
 
 #define IFA_F_SECONDARY		0x01
+#define IFA_F_TEMPORARY		IFA_F_SECONDARY
 
 #define IFA_F_DEPRECATED	0x20
 #define IFA_F_TENTATIVE		0x40
Index: include/linux/sysctl.h
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/include/linux/sysctl.h,v
retrieving revision 1.1.1.3
retrieving revision 1.1.1.3.6.1
diff -u -r1.1.1.3 -r1.1.1.3.6.1
--- include/linux/sysctl.h	30 Oct 2002 09:43:03 -0000	1.1.1.3
+++ include/linux/sysctl.h	30 Oct 2002 18:15:04 -0000	1.1.1.3.6.1
@@ -384,7 +384,12 @@
 	NET_IPV6_DAD_TRANSMITS=7,
 	NET_IPV6_RTR_SOLICITS=8,
 	NET_IPV6_RTR_SOLICIT_INTERVAL=9,
-	NET_IPV6_RTR_SOLICIT_DELAY=10
+	NET_IPV6_RTR_SOLICIT_DELAY=10,
+	NET_IPV6_USE_TEMPADDR=11,
+	NET_IPV6_TEMP_VALID_LFT=12,
+	NET_IPV6_TEMP_PREFERED_LFT=13,
+	NET_IPV6_REGEN_MAX_RETRY=14,
+	NET_IPV6_MAX_DESYNC_FACTOR=15
 };
 
 /* /proc/sys/net/ipv6/icmp */
Index: include/net/addrconf.h
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/include/net/addrconf.h,v
retrieving revision 1.1.1.2
retrieving revision 1.1.1.2.8.1
diff -u -r1.1.1.2 -r1.1.1.2.8.1
--- include/net/addrconf.h	19 Oct 2002 05:51:09 -0000	1.1.1.2
+++ include/net/addrconf.h	30 Oct 2002 18:15:04 -0000	1.1.1.2.8.1
@@ -6,6 +6,11 @@
 #define MAX_RTR_SOLICITATIONS		3
 #define RTR_SOLICITATION_INTERVAL	(4*HZ)
 
+#define TEMP_VALID_LIFETIME		(7*86400)
+#define TEMP_PREFERRED_LIFETIME		(86400)
+#define REGEN_MAX_RETRY			(5)
+#define MAX_DESYNC_FACTOR		(600)
+
 #define ADDR_CHECK_FREQUENCY		(120*HZ)
 
 struct prefix_info {
Index: include/net/if_inet6.h
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/include/net/if_inet6.h,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.16.1
diff -u -r1.1.1.1 -r1.1.1.1.16.1
--- include/net/if_inet6.h	7 Oct 2002 10:22:46 -0000	1.1.1.1
+++ include/net/if_inet6.h	30 Oct 2002 18:15:04 -0000	1.1.1.1.16.1
@@ -43,6 +43,12 @@
 	struct inet6_ifaddr	*lst_next;      /* next addr in addr_lst */
 	struct inet6_ifaddr	*if_next;       /* next addr in inet6_dev */
 
+#ifdef CONFIG_IPV6_PRIVACY
+	struct inet6_ifaddr	*tmp_next;	/* next addr in tempaddr_lst */
+	struct inet6_ifaddr	*ifpub;
+	int			regen_count;
+#endif
+
 	int			dead;
 };
 
@@ -86,7 +92,13 @@
 	int		rtr_solicits;
 	int		rtr_solicit_interval;
 	int		rtr_solicit_delay;
-
+#ifdef CONFIG_IPV6_PRIVACY
+	int		use_tempaddr;
+	int		temp_valid_lft;
+	int		temp_prefered_lft;
+	int		regen_max_retry;
+	int		max_desync_factor;
+#endif
 	void		*sysctl;
 };
 
@@ -100,6 +112,13 @@
 	atomic_t		refcnt;
 	__u32			if_flags;
 	int			dead;
+
+#ifdef CONFIG_IPV6_PRIVACY
+	u8			rndid[8];
+	u8			entropy[8];
+	struct timer_list	regen_timer;
+	struct inet6_ifaddr	*tempaddr_list;
+#endif
 
 	struct neigh_parms	*nd_parms;
 	struct inet6_dev	*next;
Index: net/ipv6/Config.help
===================================================================
RCS file: net/ipv6/Config.help
diff -N net/ipv6/Config.help
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ net/ipv6/Config.help	30 Oct 2002 18:15:04 -0000	1.1.12.1
@@ -0,0 +1,12 @@
+IPv6: Privacy Extensions (RFC 3041) support
+CONFIG_IPV6_PRIVACY
+  Privacy Extensions for Stateless Address Autoconfiguration in IPv6
+  support.  With this option, additional periodically-alter 
+  pseudo-random global-scope unicast address(es) will assigned to
+  your interface(s).
+
+  By default, kernel generates temporary addresses but it won't use 
+  them unless application explicitly bind them.  To prefer temporary 
+  address, do
+
+	echo 2 >/proc/sys/net/ipv6/conf/all/use_tempaddr 
Index: net/ipv6/Config.in
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/net/ipv6/Config.in,v
retrieving revision 1.1.1.2
retrieving revision 1.1.1.2.10.1
diff -u -r1.1.1.2 -r1.1.1.2.10.1
--- net/ipv6/Config.in	16 Oct 2002 04:23:08 -0000	1.1.1.2
+++ net/ipv6/Config.in	30 Oct 2002 18:15:04 -0000	1.1.1.2.10.1
@@ -2,6 +2,8 @@
 # IPv6 configuration
 # 
 
+bool '    IPv6: Privacy Extentions (RFC 3041) support' CONFIG_IPV6_PRIVACY
+
 if [ "$CONFIG_NETFILTER" != "n" ]; then
    source net/ipv6/netfilter/Config.in
 fi
Index: net/ipv6/addrconf.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/net/ipv6/addrconf.c,v
retrieving revision 1.1.1.4
retrieving revision 1.1.1.4.6.1
diff -u -r1.1.1.4 -r1.1.1.4.6.1
--- net/ipv6/addrconf.c	30 Oct 2002 09:43:18 -0000	1.1.1.4
+++ net/ipv6/addrconf.c	30 Oct 2002 18:15:04 -0000	1.1.1.4.6.1
@@ -62,6 +62,12 @@
 #include <linux/if_tunnel.h>
 #include <linux/rtnetlink.h>
 
+#ifdef CONFIG_IPV6_PRIVACY
+#include <linux/random.h>
+#include <linux/crypto.h>
+#include <asm/scatterlist.h>
+#endif
+
 #include <asm/uaccess.h>
 
 #define IPV6_MAX_ADDRESSES 16
@@ -83,6 +89,16 @@
 int inet6_dev_count;
 int inet6_ifa_count;
 
+#ifdef CONFIG_IPV6_PRIVACY
+static int __ipv6_regen_rndid(struct inet6_dev *idev);
+static int __ipv6_try_regen_rndid(struct inet6_dev *idev, struct in6_addr *tmpaddr); 
+static void ipv6_regen_rndid(unsigned long data);
+
+static int desync_factor = MAX_DESYNC_FACTOR * HZ;
+#endif
+
+int ipv6_count_addresses(struct inet6_dev *idev);
+
 /*
  *	Configured unicast address hash table
  */
@@ -119,6 +135,13 @@
 	MAX_RTR_SOLICITATIONS,		/* router solicits	*/
 	RTR_SOLICITATION_INTERVAL,	/* rtr solicit interval	*/
 	MAX_RTR_SOLICITATION_DELAY,	/* rtr solicit delay	*/
+#ifdef CONFIG_IPV6_PRIVACY
+	.use_tempaddr 			= 1,
+	.temp_valid_lft			= TEMP_VALID_LIFETIME,
+	.temp_prefered_lft		= TEMP_PREFERRED_LIFETIME,
+	.regen_max_retry		= REGEN_MAX_RETRY,
+	.max_desync_factor		= MAX_DESYNC_FACTOR,
+#endif
 };
 
 static struct ipv6_devconf ipv6_devconf_dflt =
@@ -133,6 +156,13 @@
 	MAX_RTR_SOLICITATIONS,		/* router solicits	*/
 	RTR_SOLICITATION_INTERVAL,	/* rtr solicit interval	*/
 	MAX_RTR_SOLICITATION_DELAY,	/* rtr solicit delay	*/
+#ifdef CONFIG_IPV6_PRIVACY
+	.use_tempaddr			= 1,
+	.temp_valid_lft			= TEMP_VALID_LIFETIME,
+	.temp_prefered_lft		= TEMP_PREFERRED_LIFETIME,
+	.regen_max_retry		= REGEN_MAX_RETRY,
+	.max_desync_factor		= MAX_DESYNC_FACTOR,
+#endif
 };
 
 int ipv6_addr_type(struct in6_addr *addr)
@@ -272,6 +302,24 @@
 		/* We refer to the device */
 		dev_hold(dev);
 
+#ifdef CONFIG_IPV6_PRIVACY
+		get_random_bytes(ndev->rndid, sizeof(ndev->rndid));
+		get_random_bytes(ndev->entropy, sizeof(ndev->entropy));
+		init_timer(&ndev->regen_timer);
+		ndev->regen_timer.function = ipv6_regen_rndid;
+		ndev->regen_timer.data = (unsigned long) ndev;
+		if ((dev->flags&IFF_LOOPBACK) ||
+		    dev->type == ARPHRD_TUNNEL ||
+		    dev->type == ARPHRD_SIT) {
+			printk(KERN_INFO
+				"Disabled Privacy Extensions on device %p(%s)\n",
+				dev, dev->name);
+			ndev->cnf.use_tempaddr = -1;
+		} else {
+			__ipv6_regen_rndid(ndev);
+		}
+#endif
+
 		write_lock_bh(&addrconf_lock);
 		dev->ip6_ptr = ndev;
 		/* One reference from device */
@@ -396,6 +444,18 @@
 	/* Add to inet6_dev unicast addr list. */
 	ifa->if_next = idev->addr_list;
 	idev->addr_list = ifa;
+
+#ifdef CONFIG_IPV6_PRIVACY
+	ifa->regen_count = 0;
+	if (ifa->flags&IFA_F_TEMPORARY) {
+		ifa->tmp_next = idev->tempaddr_list;
+		idev->tempaddr_list = ifa;
+		in6_ifa_hold(ifa);
+	} else {
+		ifa->tmp_next = NULL;
+	}
+#endif
+
 	in6_ifa_hold(ifa);
 	write_unlock_bh(&idev->lock);
 	read_unlock(&addrconf_lock);
@@ -417,6 +477,15 @@
 
 	ifp->dead = 1;
 
+#ifdef CONFIG_IPV6_PRIVACY
+	spin_lock_bh(&ifp->lock);
+	if (ifp->ifpub) {
+		__in6_ifa_put(ifp->ifpub);
+		ifp->ifpub = NULL;
+	}
+	spin_unlock_bh(&ifp->lock);
+#endif
+
 	write_lock_bh(&addrconf_hash_lock);
 	for (ifap = &inet6_addr_lst[hash]; (ifa=*ifap) != NULL;
 	     ifap = &ifa->lst_next) {
@@ -430,6 +499,24 @@
 	write_unlock_bh(&addrconf_hash_lock);
 
 	write_lock_bh(&idev->lock);
+#ifdef CONFIG_IPV6_PRIVACY
+	if (ifp->flags&IFA_F_TEMPORARY) {
+		for (ifap = &idev->tempaddr_list; (ifa=*ifap) != NULL;
+		     ifap = &ifa->tmp_next) {
+			if (ifa == ifp) {
+				*ifap = ifa->tmp_next;
+				if (ifp->ifpub) {
+					__in6_ifa_put(ifp->ifpub);
+					ifp->ifpub = NULL;
+				}
+				__in6_ifa_put(ifp);
+				ifa->tmp_next = NULL;
+				break;
+			}
+		}
+	}
+#endif
+
 	for (ifap = &idev->addr_list; (ifa=*ifap) != NULL;
 	     ifap = &ifa->if_next) {
 		if (ifa == ifp) {
@@ -450,6 +537,96 @@
 	in6_ifa_put(ifp);
 }
 
+#ifdef CONFIG_IPV6_PRIVACY
+static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, struct inet6_ifaddr *ift)
+{
+	struct inet6_dev *idev;
+	struct in6_addr addr, *tmpaddr;
+	unsigned long tmp_prefered_lft, tmp_valid_lft;
+	int tmp_plen;
+	int ret = 0;
+
+	if (ift) {
+		spin_lock_bh(&ift->lock);
+		memcpy(&addr.s6_addr[8], &ift->addr.s6_addr[8], 8);
+		spin_unlock_bh(&ift->lock);
+		tmpaddr = &addr;
+	} else {
+		tmpaddr = NULL;
+	}
+retry:
+	spin_lock_bh(&ifp->lock);
+	in6_ifa_hold(ifp);
+	idev = ifp->idev;
+	in6_dev_hold(idev);
+	memcpy(addr.s6_addr, ifp->addr.s6_addr, 8);
+	write_lock(&idev->lock);
+	if (idev->cnf.use_tempaddr <= 0) {
+		write_unlock(&idev->lock);
+		spin_unlock_bh(&ifp->lock);
+		printk(KERN_INFO
+			"ipv6_create_tempaddr(): use_tempaddr is disabled.\n");
+		in6_dev_put(idev);
+		in6_ifa_put(ifp);
+		ret = -1;
+		goto out;
+	}
+	if (ifp->regen_count++ >= idev->cnf.regen_max_retry) {
+		idev->cnf.use_tempaddr = -1;	/*XXX*/
+		write_unlock(&idev->lock);
+		spin_unlock_bh(&ifp->lock);
+		printk(KERN_WARNING
+			"ipv6_create_tempaddr(): regeneration time exceeded. disabled temporary address support.\n");
+		in6_dev_put(idev);
+		in6_ifa_put(ifp);
+		ret = -1;
+		goto out;
+	}
+	if (__ipv6_try_regen_rndid(idev, tmpaddr) < 0) {
+		write_unlock(&idev->lock);
+		spin_unlock_bh(&ifp->lock);
+		printk(KERN_WARNING
+			"ipv6_create_tempaddr(): regeneration of randomized interface id failed.\n");
+		in6_dev_put(idev);
+		in6_ifa_put(ifp);
+		ret = -1;
+		goto out;
+	}
+	memcpy(&addr.s6_addr[8], idev->rndid, 8);
+	tmp_valid_lft = min_t(__u32,
+			      ifp->valid_lft,
+			      idev->cnf.temp_valid_lft);
+	tmp_prefered_lft = min_t(__u32, 
+				 ifp->prefered_lft, 
+				 idev->cnf.temp_prefered_lft - desync_factor / HZ);
+	tmp_plen = ifp->prefix_len;
+	write_unlock(&idev->lock);
+	spin_unlock_bh(&ifp->lock);
+	ift = ipv6_count_addresses(idev) < IPV6_MAX_ADDRESSES ?
+		ipv6_add_addr(idev, &addr, tmp_plen,
+			      ipv6_addr_type(&addr)&IPV6_ADDR_SCOPE_MASK, IFA_F_TEMPORARY) : 0;
+	if (!ift) {
+		in6_dev_put(idev);
+		in6_ifa_put(ifp);
+		printk(KERN_INFO
+			"ipv6_create_tempaddr(): retry temporary address regeneration.\n");
+		tmpaddr = &addr;
+		goto retry;
+	}
+	spin_lock_bh(&ift->lock);
+	ift->ifpub = ifp;
+	ift->valid_lft = tmp_valid_lft;
+	ift->prefered_lft = tmp_prefered_lft;
+	ift->tstamp = ifp->tstamp;
+	spin_unlock_bh(&ift->lock);
+	addrconf_dad_start(ift);
+	in6_ifa_put(ift);
+	in6_dev_put(idev);
+out:
+	return ret;
+}
+#endif
+
 /*
  *	Choose an apropriate source address
  *	should do:
@@ -458,6 +635,22 @@
  *		an address of the attached interface 
  *	iii)	don't use deprecated addresses
  */
+static int inline ipv6_saddr_pref(const struct inet6_ifaddr *ifp, u8 invpref)
+{
+	int pref;
+	pref = ifp->flags&IFA_F_DEPRECATED ? 0 : 2;
+#ifdef CONFIG_IPV6_PRIVACY
+	pref |= (ifp->flags^invpref)&IFA_F_TEMPORARY ? 0 : 1;
+#endif
+	return pref;
+}
+
+#ifdef CONFIG_IPV6_PRIVACY
+#define IPV6_GET_SADDR_MAXSCORE(score)	((score) == 3)
+#else
+#define IPV6_GET_SADDR_MAXSCORE(score)	(score)
+#endif
+
 int ipv6_get_saddr(struct dst_entry *dst,
 		   struct in6_addr *daddr, struct in6_addr *saddr)
 {
@@ -468,6 +661,7 @@
 	struct inet6_dev *idev;
 	struct rt6_info *rt;
 	int err;
+	int hiscore = -1, score;
 
 	rt = (struct rt6_info *) dst;
 	if (rt)
@@ -497,17 +691,27 @@
 			read_lock_bh(&idev->lock);
 			for (ifp=idev->addr_list; ifp; ifp=ifp->if_next) {
 				if (ifp->scope == scope) {
-					if (!(ifp->flags & (IFA_F_DEPRECATED|IFA_F_TENTATIVE))) {
-						in6_ifa_hold(ifp);
+					if (ifp->flags&IFA_F_TENTATIVE)
+						continue;
+#ifdef CONFIG_IPV6_PRIVACY
+					score = ipv6_saddr_pref(ifp, idev->cnf.use_tempaddr > 1 ? IFA_F_TEMPORARY : 0);
+#else
+					score = ipv6_saddr_pref(ifp, 0);
+#endif
+					if (score <= hiscore)
+						continue;
+
+					if (match)
+						in6_ifa_put(match);
+					match = ifp;
+					hiscore = score;
+					in6_ifa_hold(ifp);
+
+					if (IPV6_GET_SADDR_MAXSCORE(score)) {
 						read_unlock_bh(&idev->lock);
 						read_unlock(&addrconf_lock);
 						goto out;
 					}
-
-					if (!match && !(ifp->flags & IFA_F_TENTATIVE)) {
-						match = ifp;
-						in6_ifa_hold(ifp);
-					}
 				}
 			}
 			read_unlock_bh(&idev->lock);
@@ -530,16 +734,26 @@
 			read_lock_bh(&idev->lock);
 			for (ifp=idev->addr_list; ifp; ifp=ifp->if_next) {
 				if (ifp->scope == scope) {
-					if (!(ifp->flags&(IFA_F_DEPRECATED|IFA_F_TENTATIVE))) {
-						in6_ifa_hold(ifp);
+					if (ifp->flags&IFA_F_TENTATIVE)
+						continue;
+#ifdef CONFIG_IPV6_PRIVACY
+					score = ipv6_saddr_pref(ifp, idev->cnf.use_tempaddr > 1 ? IFA_F_TEMPORARY : 0);
+#else
+					score = ipv6_saddr_pref(ifp, 0);
+#endif
+					if (score <= hiscore)
+						continue;
+
+					if (match)
+						in6_ifa_put(match);
+					match = ifp;
+					hiscore = score;
+					in6_ifa_hold(ifp);
+
+					if (IPV6_GET_SADDR_MAXSCORE(score)) {
 						read_unlock_bh(&idev->lock);
 						goto out_unlock_base;
 					}
-
-					if (!match && !(ifp->flags&IFA_F_TENTATIVE)) {
-						match = ifp;
-						in6_ifa_hold(ifp);
-					}
 				}
 			}
 			read_unlock_bh(&idev->lock);
@@ -551,19 +765,12 @@
 	read_unlock(&dev_base_lock);
 
 out:
-	if (ifp == NULL) {
-		ifp = match;
-		match = NULL;
-	}
-
 	err = -EADDRNOTAVAIL;
-	if (ifp) {
-		ipv6_addr_copy(saddr, &ifp->addr);
+	if (match) {
+		ipv6_addr_copy(saddr, &match->addr);
 		err = 0;
-		in6_ifa_put(ifp);
-	}
-	if (match)
 		in6_ifa_put(match);
+	}
 
 	return err;
 }
@@ -653,6 +860,21 @@
 		ifp->flags |= IFA_F_TENTATIVE;
 		spin_unlock_bh(&ifp->lock);
 		in6_ifa_put(ifp);
+#ifdef CONFIG_IPV6_PRIVACY
+	} else if (ifp->flags&IFA_F_TEMPORARY) {
+		struct inet6_ifaddr *ifpub;
+		spin_lock_bh(&ifp->lock);
+		ifpub = ifp->ifpub;
+		if (ifpub) {
+			in6_ifa_hold(ifpub);
+			spin_unlock_bh(&ifp->lock);
+			ipv6_create_tempaddr(ifpub, ifp);
+			in6_ifa_put(ifpub);
+		} else {
+			spin_unlock_bh(&ifp->lock);
+		}
+		ipv6_del_addr(ifp);
+#endif
 	} else
 		ipv6_del_addr(ifp);
 }
@@ -718,6 +940,108 @@
 	return err;
 }
 
+#ifdef CONFIG_IPV6_PRIVACY
+/* (re)generation of randomized interface identifier (RFC 3041 3.2, 3.5) */
+static int __ipv6_regen_rndid(struct inet6_dev *idev)
+{
+	struct net_device *dev;
+	u8 eui64[8];
+	u8 digest[16];
+	struct crypto_tfm *tfm;
+	struct scatterlist sg[2];
+
+	sg[0].page = virt_to_page(idev->entropy);
+	sg[0].offset = ((long) idev->entropy & ~PAGE_MASK);
+	sg[0].length = 8;
+	sg[1].page = virt_to_page(eui64);
+	sg[1].offset = ((long) eui64 & ~PAGE_MASK);
+	sg[1].length = 8;
+
+	if (!del_timer(&idev->regen_timer))
+		in6_dev_hold(idev);
+
+	dev = idev->dev;
+
+	if (ipv6_generate_eui64(eui64, dev)) {
+		printk(KERN_INFO
+			"__ipv6_regen_rndid(idev=%p): cannot get EUI64 identifier; use random bytes.\n",
+			idev);
+		get_random_bytes(eui64, sizeof(eui64));
+	}
+regen:
+	tfm = crypto_alloc_tfm("md5", 0);
+	if (tfm == NULL) {
+		if (net_ratelimit())
+			printk(KERN_WARNING
+				"failed to load transform for md5\n");
+		in6_dev_put(idev);
+		return -1;
+	}
+	crypto_digest_init(tfm);
+	crypto_digest_update(tfm, sg, 2);
+	crypto_digest_final(tfm, digest);
+	crypto_free_tfm(tfm);
+
+	memcpy(idev->rndid, &digest[0], 8);
+	idev->rndid[0] &= ~0x02;
+	memcpy(idev->entropy, &digest[8], 8);
+
+	/*
+	 * <draft-ietf-ipngwg-temp-addresses-v2-00.txt>:
+	 * check if generated address is not inappropriate
+	 *
+	 *  - Reserved subnet anycast (RFC 2526)
+	 *	11111101 11....11 1xxxxxxx
+	 *  - ISATAP (draft-ietf-ngtrans-isatap-01.txt) 4.3
+	 *	00-00-5E-FE-xx-xx-xx-xx
+	 *  - value 0
+	 *  - XXX: already assigned to an address on the device
+	 */
+	if (idev->rndid[0] == 0xfd && 
+	    (idev->rndid[1]&idev->rndid[2]&idev->rndid[3]&idev->rndid[4]&idev->rndid[5]&idev->rndid[6]) &&
+	    (idev->rndid[7]&0x80))
+		goto regen;
+	if ((idev->rndid[0]|idev->rndid[1]) == 0) {
+		if (idev->rndid[2] == 0x5e && idev->rndid[3] == 0xfe)
+			goto regen;
+		if ((idev->rndid[2]|idev->rndid[3]|idev->rndid[4]|idev->rndid[5]|idev->rndid[6]|idev->rndid[7]) == 0x00)
+			goto regen;
+	}
+	
+	if (time_before(idev->regen_timer.expires, jiffies)) {
+		idev->regen_timer.expires = 0;
+		printk(KERN_WARNING
+			"__ipv6_regen_rndid(): too short regeneration interval; timer diabled for %s.\n",
+			idev->dev->name);
+		in6_dev_put(idev);
+		return -1;
+	}
+
+	add_timer(&idev->regen_timer);
+	return 0;
+}
+
+static void ipv6_regen_rndid(unsigned long data)
+{
+	struct inet6_dev *idev = (struct inet6_dev *) data;
+
+	read_lock_bh(&addrconf_lock);
+	write_lock_bh(&idev->lock);
+	if (!idev->dead)
+		__ipv6_regen_rndid(idev);
+	write_unlock_bh(&idev->lock);
+	read_unlock_bh(&addrconf_lock);
+}
+
+static int __ipv6_try_regen_rndid(struct inet6_dev *idev, struct in6_addr *tmpaddr) {
+	int ret = 0;
+
+	if (tmpaddr && memcmp(idev->rndid, &tmpaddr->s6_addr[8], 8) == 0)
+		ret = __ipv6_regen_rndid(idev);
+	return ret;
+}
+#endif
+
 /*
  *	Add prefix route.
  */
@@ -889,6 +1213,7 @@
 		struct inet6_ifaddr * ifp;
 		struct in6_addr addr;
 		int plen;
+		int create = 0;
 
 		plen = pinfo->prefix_len >> 3;
 
@@ -924,6 +1249,7 @@
 				return;
 			}
 
+			create = 1;
 			addrconf_dad_start(ifp);
 		}
 
@@ -934,6 +1260,9 @@
 
 		if (ifp) {
 			int flags;
+#ifdef CONFIG_IPV6_PRIVACY
+			struct inet6_ifaddr *ift;
+#endif
 
 			spin_lock(&ifp->lock);
 			ifp->valid_lft = valid_lft;
@@ -946,6 +1275,42 @@
 			if (!(flags&IFA_F_TENTATIVE))
 				ipv6_ifa_notify((flags&IFA_F_DEPRECATED) ?
 						0 : RTM_NEWADDR, ifp);
+
+#ifdef CONFIG_IPV6_PRIVACY
+			read_lock_bh(&in6_dev->lock);
+			/* update all temporary addresses in the list */
+			for (ift=in6_dev->tempaddr_list; ift; ift=ift->tmp_next) {
+				/*
+				 * When adjusting the lifetimes of an existing
+				 * temporary address, only lower the lifetimes.
+				 * Implementations must not increase the
+				 * lifetimes of an existing temporary address
+				 * when processing a Prefix Information Option.
+				 */
+				spin_lock(&ift->lock);
+				flags = ift->flags;
+				if (ift->valid_lft > valid_lft &&
+				    ift->valid_lft - valid_lft > (jiffies - ift->tstamp) / HZ)
+					ift->valid_lft = valid_lft + (jiffies - ift->tstamp) / HZ;
+				if (ift->prefered_lft > prefered_lft &&
+				    ift->prefered_lft - prefered_lft > (jiffies - ift->tstamp) / HZ)
+					ift->prefered_lft = prefered_lft + (jiffies - ift->tstamp) / HZ;
+				spin_unlock(&ift->lock);
+				if (!(flags&IFA_F_TENTATIVE))
+					ipv6_ifa_notify(0, ift);
+			}
+
+			if (create && in6_dev->cnf.use_tempaddr > 0) {
+				/*
+				 * When a new public address is created as described in [ADDRCONF],
+				 * also create a new temporary address.
+				 */
+				read_unlock_bh(&in6_dev->lock); 
+				ipv6_create_tempaddr(ifp, NULL);
+			} else {
+				read_unlock_bh(&in6_dev->lock);
+			}
+#endif
 			in6_ifa_put(ifp);
 			addrconf_verify(0);
 		}
@@ -1910,7 +2275,7 @@
 static struct addrconf_sysctl_table
 {
 	struct ctl_table_header *sysctl_header;
-	ctl_table addrconf_vars[11];
+	ctl_table addrconf_vars[16];
 	ctl_table addrconf_dev[2];
 	ctl_table addrconf_conf_dir[2];
 	ctl_table addrconf_proto_dir[2];
@@ -1957,6 +2322,28 @@
          &ipv6_devconf.rtr_solicit_delay, sizeof(int), 0644, NULL,
          &proc_dointvec_jiffies},
 
+#ifdef CONFIG_IPV6_PRIVACY
+	{NET_IPV6_USE_TEMPADDR, "use_tempaddr",
+	 &ipv6_devconf.use_tempaddr, sizeof(int), 0644, NULL,
+	 &proc_dointvec},
+
+	{NET_IPV6_TEMP_VALID_LFT, "temp_valid_lft",
+	 &ipv6_devconf.temp_valid_lft, sizeof(int), 0644, NULL,
+	 &proc_dointvec},
+
+	{NET_IPV6_TEMP_PREFERED_LFT, "temp_prefered_lft",
+	 &ipv6_devconf.temp_prefered_lft, sizeof(int), 0644, NULL,
+	 &proc_dointvec},
+
+	{NET_IPV6_REGEN_MAX_RETRY, "regen_max_retry",
+	 &ipv6_devconf.regen_max_retry, sizeof(int), 0644, NULL,
+	 &proc_dointvec},
+
+	{NET_IPV6_MAX_DESYNC_FACTOR, "max_desync_factor",
+	 &ipv6_devconf.max_desync_factor, sizeof(int), 0644, NULL,
+	 &proc_dointvec},
+#endif
+
 	{0}},
 
 	{{NET_PROTO_CONF_ALL, "all", NULL, 0, 0555, addrconf_sysctl.addrconf_vars},{0}},
@@ -1975,7 +2362,7 @@
 	if (t == NULL)
 		return;
 	memcpy(t, &addrconf_sysctl, sizeof(*t));
-	for (i=0; i<sizeof(t->addrconf_vars)/sizeof(t->addrconf_vars[0])-1; i++) {
+	for (i=0; t->addrconf_vars[i].data; i++) {
 		t->addrconf_vars[i].data += (char*)p - (char*)&ipv6_devconf;
 		t->addrconf_vars[i].de = NULL;
 	}
