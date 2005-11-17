Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161102AbVKQCLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161102AbVKQCLs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 21:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161103AbVKQCLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 21:11:48 -0500
Received: from send.forptr.21cn.com ([202.105.45.49]:8419 "HELO 21cn.com")
	by vger.kernel.org with SMTP id S1161102AbVKQCLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 21:11:47 -0500
Message-ID: <437BE773.6010007@21cn.com>
Date: Thu, 17 Nov 2005 10:14:11 +0800
From: Yan Zheng <yanzheng@21cn.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@vger.kernel.org
CC: linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: [PATCH]IPv6: Acquire addrconf_hash_lock for reading instead of writing
 in addrconf_verify(...)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AIMC-AUTH: yanzheng
X-AIMC-MAILFROM: yanzheng@21cn.com
X-AIMC-Msg-ID: 5k4R9cOB
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

addrconf_verify(...) only traverse address hash table when addrconf_hash_lock is held
for writing, and it may hold addrconf_hash_lock for a long time. So I think it's better
to acquire addrconf_hash_lock for reading instead of  writing

Signed-off-by: Yan Zheng <yanzheng@21cn.com>

============================================================
--- a/net/ipv6/addrconf.c	2005-11-17 09:27:54.000000000 +0800
+++ b/net/ipv6/addrconf.c	2005-11-17 09:25:42.000000000 +0800
@@ -2627,7 +2627,7 @@ static void addrconf_verify(unsigned lon
 	for (i=0; i < IN6_ADDR_HSIZE; i++) {
 
 restart:
-		write_lock(&addrconf_hash_lock);
+		read_lock(&addrconf_hash_lock);
 		for (ifp=inet6_addr_lst[i]; ifp; ifp=ifp->lst_next) {
 			unsigned long age;
 #ifdef CONFIG_IPV6_PRIVACY
@@ -2649,7 +2649,7 @@ restart:
 			if (age >= ifp->valid_lft) {
 				spin_unlock(&ifp->lock);
 				in6_ifa_hold(ifp);
-				write_unlock(&addrconf_hash_lock);
+				read_unlock(&addrconf_hash_lock);
 				ipv6_del_addr(ifp);
 				goto restart;
 			} else if (age >= ifp->prefered_lft) {
@@ -2668,7 +2668,7 @@ restart:
 
 				if (deprecate) {
 					in6_ifa_hold(ifp);
-					write_unlock(&addrconf_hash_lock);
+					read_unlock(&addrconf_hash_lock);
 
 					ipv6_ifa_notify(0, ifp);
 					in6_ifa_put(ifp);
@@ -2686,7 +2686,7 @@ restart:
 						in6_ifa_hold(ifp);
 						in6_ifa_hold(ifpub);
 						spin_unlock(&ifp->lock);
-						write_unlock(&addrconf_hash_lock);
+						read_unlock(&addrconf_hash_lock);
 						ipv6_create_tempaddr(ifpub, ifp);
 						in6_ifa_put(ifpub);
 						in6_ifa_put(ifp);
@@ -2703,7 +2703,7 @@ restart:
 				spin_unlock(&ifp->lock);
 			}
 		}
-		write_unlock(&addrconf_hash_lock);
+		read_unlock(&addrconf_hash_lock);
 	}
 
 	addr_chk_timer.expires = time_before(next, jiffies + HZ) ? jiffies + HZ : next;
