Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261709AbSI0PL3>; Fri, 27 Sep 2002 11:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261711AbSI0PL3>; Fri, 27 Sep 2002 11:11:29 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:64779 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S261709AbSI0PL1>; Fri, 27 Sep 2002 11:11:27 -0400
Date: Sat, 28 Sep 2002 00:16:17 +0900 (JST)
Message-Id: <20020928.001617.91124319.yoshfuji@linux-ipv6.org>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, usagi@linux-ipv6.org,
       kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] IPv6: Refine IPv6 Address Validation Timer
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20020927.022515.78074730.davem@redhat.com>
References: <20020927.181256.112824147.yoshfuji@linux-ipv6.org>
	<20020927.022515.78074730.davem@redhat.com>
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

In article <20020927.022515.78074730.davem@redhat.com> (at Fri, 27 Sep 2002 02:25:15 -0700 (PDT)), "David S. Miller" <davem@redhat.com> says:

>    @@ -1626,24 +1635,32 @@
>     		for (ifp=inet6_addr_lst[i]; ifp; ifp=ifp->lst_next) {
>     			unsigned long age;
>     
>    -			if (ifp->flags & IFA_F_PERMANENT)
>    +			spin_lock(&ifp->lock);
>    +			if (ifp->flags & IFA_F_PERMANENT) {
>    +				spin_unlock(&ifp->lock);
>     				continue;
>    +			}
> 
> This is completely unnecessary.  Nobody modifies the
> IFA_F_PERMANENT flag after the addr entry has been added
> to the hash table and this runs under the addrconf hash
> lock already.

Thanks for comment.
So, is this reasonable?

Index: net/ipv6/addrconf.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv6/addrconf.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.4.4
diff -u -r1.1.1.1 -r1.1.1.1.4.4
--- net/ipv6/addrconf.c	2002/08/20 09:47:02	1.1.1.1
+++ net/ipv6/addrconf.c	2002/09/27 15:02:57	1.1.1.1.4.4
@@ -26,6 +26,8 @@
  *						packets.
  *	yoshfuji@USAGI			:       Fixed interval between DAD
  *						packets.
+ *	YOSHIFUJI Hideaki @USAGI	:	improved accuracy of
+ *						address validation timer.
  */
 
 #include <linux/config.h>
@@ -93,6 +95,7 @@
 void addrconf_verify(unsigned long);
 
 static struct timer_list addr_chk_timer = { function: addrconf_verify };
+static spinlock_t addrconf_verify_lock = SPIN_LOCK_UNLOCKED;
 
 static int addrconf_ifdown(struct net_device *dev, int how);
 
@@ -1616,9 +1619,15 @@
 void addrconf_verify(unsigned long foo)
 {
 	struct inet6_ifaddr *ifp;
-	unsigned long now = jiffies;
+	unsigned long now, next;
 	int i;
 
+	spin_lock_bh(&addrconf_verify_lock);
+	now = jiffies;
+	next = now + ADDR_CHECK_FREQUENCY;
+
+	del_timer(&addr_chk_timer);
+
 	for (i=0; i < IN6_ADDR_HSIZE; i++) {
 
 restart:
@@ -1629,21 +1638,27 @@
 			if (ifp->flags & IFA_F_PERMANENT)
 				continue;
 
+			spin_lock(&ifp->lock);
 			age = (now - ifp->tstamp) / HZ;
 
-			if (age > ifp->valid_lft) {
+			if (age >= ifp->valid_lft) {
+				spin_unlock(&ifp->lock);
 				in6_ifa_hold(ifp);
 				write_unlock(&addrconf_hash_lock);
 				ipv6_del_addr(ifp);
 				goto restart;
-			} else if (age > ifp->prefered_lft) {
+			} else if (age >= ifp->prefered_lft) {
+				/* jiffies - ifp->tsamp > age >= ifp->prefered_lft */
 				int deprecate = 0;
 
-				spin_lock(&ifp->lock);
 				if (!(ifp->flags&IFA_F_DEPRECATED)) {
 					deprecate = 1;
 					ifp->flags |= IFA_F_DEPRECATED;
 				}
+
+				if (time_before(ifp->tstamp + ifp->valid_lft * HZ, next))
+					next = ifp->tstamp + ifp->valid_lft * HZ;
+
 				spin_unlock(&ifp->lock);
 
 				if (deprecate) {
@@ -1654,12 +1669,24 @@
 					in6_ifa_put(ifp);
 					goto restart;
 				}
+			} else {
+				/* ifp->prefered_lft <= ifp->valid_lft */
+				if (time_before(ifp->tstamp + ifp->prefered_lft * HZ, next))
+					next = ifp->tstamp + ifp->prefered_lft * HZ;
+				spin_unlock(&ifp->lock);
 			}
 		}
 		write_unlock(&addrconf_hash_lock);
 	}
 
-	mod_timer(&addr_chk_timer, jiffies + ADDR_CHECK_FREQUENCY);
+	if (time_before(now + HZ/2, jiffies)) {
+		ADBG((KERN_WARNING 
+		      "addrconf_verify(): too slow; jiffies - now = %ld\n",
+		      (long)jiffies - (long)now));
+	}
+	addr_chk_timer.expires = time_before(next, jiffies + HZ) ? jiffies + HZ : next;
+	add_timer(&addr_chk_timer);
+	spin_unlock_bh(&addrconf_verify_lock);
 }
 
 static int
@@ -2033,8 +2060,7 @@
 	proc_net_create("if_inet6", 0, iface_proc_info);
 #endif
 	
-	addr_chk_timer.expires = jiffies + ADDR_CHECK_FREQUENCY;
-	add_timer(&addr_chk_timer);
+	addrconf_verify(0);
 	rtnetlink_links[PF_INET6] = inet6_rtnetlink_table;
 #ifdef CONFIG_SYSCTL
 	addrconf_sysctl.sysctl_header =
