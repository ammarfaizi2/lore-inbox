Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbSI0JHk>; Fri, 27 Sep 2002 05:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261646AbSI0JHk>; Fri, 27 Sep 2002 05:07:40 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:18187 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S261645AbSI0JHi>; Fri, 27 Sep 2002 05:07:38 -0400
Date: Fri, 27 Sep 2002 18:12:56 +0900 (JST)
Message-Id: <20020927.181256.112824147.yoshfuji@linux-ipv6.org>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
CC: usagi@linux-ipv6.org
Subject: [PATCH] IPv6: Refine IPv6 Address Validation Timer
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

Current IPv6 address validation timer is rough and
timing of address validation is not precise.
This patch refines timing of address validation timer.

Following patch is against linux-2.4.19.

Thank you in advance.

-------------------------------------------------------------------
Patch-Name: Refine IPv6 Address Validation Timer
Patch-Id: FIX_2_4_19_ADDRCONF_TIMER-20020905
Patch-Author: YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
Credit: YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
Reference: RFC2462
-------------------------------------------------------------------
Index: net/ipv6/addrconf.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv6/addrconf.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.4.3
diff -u -r1.1.1.1 -r1.1.1.1.4.3
--- net/ipv6/addrconf.c	2002/08/20 09:47:02	1.1.1.1
+++ net/ipv6/addrconf.c	2002/09/26 06:58:20	1.1.1.1.4.3
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
@@ -1626,24 +1635,32 @@
 		for (ifp=inet6_addr_lst[i]; ifp; ifp=ifp->lst_next) {
 			unsigned long age;
 
-			if (ifp->flags & IFA_F_PERMANENT)
+			spin_lock(&ifp->lock);
+			if (ifp->flags & IFA_F_PERMANENT) {
+				spin_unlock(&ifp->lock);
 				continue;
+			}
 
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
@@ -1654,12 +1671,24 @@
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
@@ -2033,8 +2062,7 @@
 	proc_net_create("if_inet6", 0, iface_proc_info);
 #endif
 	
-	addr_chk_timer.expires = jiffies + ADDR_CHECK_FREQUENCY;
-	add_timer(&addr_chk_timer);
+	addrconf_verify(0);
 	rtnetlink_links[PF_INET6] = inet6_rtnetlink_table;
 #ifdef CONFIG_SYSCTL
 	addrconf_sysctl.sysctl_header =
