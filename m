Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268003AbTBYPbs>; Tue, 25 Feb 2003 10:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268004AbTBYPbs>; Tue, 25 Feb 2003 10:31:48 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:51204 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S268003AbTBYPbq>; Tue, 25 Feb 2003 10:31:46 -0500
Date: Wed, 26 Feb 2003 00:41:55 +0900 (JST)
Message-Id: <20030226.004155.71903869.yoshfuji@linux-ipv6.org>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, kuznet@ms2.inr.ac.ru,
       pekkas@netcore.fi, usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Privacy Extensions for Stateless Address
 Autoconfiguration in IPv6
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20030223.223114.65976206.davem@redhat.com>
References: <Pine.LNX.4.44.0210311021560.19356-100000@netcore.fi>
	<20021101.174832.44646503.yoshfuji@linux-ipv6.org>
	<20030223.223114.65976206.davem@redhat.com>
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

Hi,

In article <20030223.223114.65976206.davem@redhat.com> (at Sun, 23 Feb 2003 22:31:14 -0800 (PST)), "David S. Miller" <davem@redhat.com> says:

>    From: YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>
>    Date: Fri, 01 Nov 2002 17:48:32 +0900 (JST)
> 
>    Ok, here's revised one.
>    
>     - sync with linux-2.5.45.
>     - change default value for use_tempaddr sysctl to 0 
>       (don't generate and use temprary addresses by default)
>    
> It is applied.

Thanks.

Well, I've found a bug that a temporary addresses were not
re-generated properly.  Here's the patch for linux-2.5.63.
(Patch I've sent for linux-2.4.x contains this change.)

Thanks in advance.

Index: net/ipv6/addrconf.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/net/ipv6/addrconf.c,v
retrieving revision 1.1.1.6
retrieving revision 1.1.1.6.2.1
diff -u -r1.1.1.6 -r1.1.1.6.2.1
--- net/ipv6/addrconf.c	25 Feb 2003 05:33:26 -0000	1.1.1.6
+++ net/ipv6/addrconf.c	25 Feb 2003 07:30:32 -0000	1.1.1.6.2.1
@@ -2015,6 +2015,9 @@
 		write_lock(&addrconf_hash_lock);
 		for (ifp=inet6_addr_lst[i]; ifp; ifp=ifp->lst_next) {
 			unsigned long age;
+#ifdef CONFIG_IPV6_PRIVACY
+			unsigned long regen_advance;
+#endif
 
 			if (ifp->flags & IFA_F_PERMANENT)
 				continue;
@@ -2022,6 +2025,12 @@
 			spin_lock(&ifp->lock);
 			age = (now - ifp->tstamp) / HZ;
 
+#ifdef CONFIG_IPV6_PRIVACY
+			regen_advance = ifp->idev->cnf.regen_max_retry * 
+					ifp->idev->cnf.dad_transmits * 
+					ifp->idev->nd_parms->retrans_time / HZ;
+#endif
+
 			if (age >= ifp->valid_lft) {
 				spin_unlock(&ifp->lock);
 				in6_ifa_hold(ifp);
@@ -2050,6 +2059,28 @@
 					in6_ifa_put(ifp);
 					goto restart;
 				}
+#ifdef CONFIG_IPV6_PRIVACY
+			} else if ((ifp->flags&IFA_F_TEMPORARY) &&
+				   !(ifp->flags&IFA_F_TENTATIVE)) {
+				if (age >= ifp->prefered_lft - regen_advance) {
+					struct inet6_ifaddr *ifpub = ifp->ifpub;
+					if (time_before(ifp->tstamp + ifp->prefered_lft * HZ, next))
+						next = ifp->tstamp + ifp->prefered_lft * HZ;
+					if (!ifp->regen_count && ifpub) {
+						ifp->regen_count++;
+						in6_ifa_hold(ifp);
+						in6_ifa_hold(ifpub);
+						spin_unlock(&ifp->lock);
+						write_unlock(&addrconf_hash_lock);
+						ipv6_create_tempaddr(ifpub, ifp);
+						in6_ifa_put(ifpub);
+						in6_ifa_put(ifp);
+						goto restart;
+					}
+				} else if (time_before(ifp->tstamp + ifp->prefered_lft * HZ - regen_advance * HZ, next))
+					next = ifp->tstamp + ifp->prefered_lft * HZ - regen_advance * HZ;
+				spin_unlock(&ifp->lock);
+#endif
 			} else {
 				/* ifp->prefered_lft <= ifp->valid_lft */
 				if (time_before(ifp->tstamp + ifp->prefered_lft * HZ, next))

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
