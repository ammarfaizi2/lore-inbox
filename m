Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262733AbSI1GOl>; Sat, 28 Sep 2002 02:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262734AbSI1GOl>; Sat, 28 Sep 2002 02:14:41 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:11278 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S262733AbSI1GOk>; Sat, 28 Sep 2002 02:14:40 -0400
Date: Sat, 28 Sep 2002 15:19:59 +0900 (JST)
Message-Id: <20020928.151959.131438421.yoshfuji@linux-ipv6.org>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
CC: usagi@linux-ipv6.org
Subject: [PATCH] IPv6: Default Route Support on Router
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

Hello.

When a Linux box is configured as a router (forwarding=1), 
it does not recognize default routes. 

We can't understand why Linux forbid to hold IPv6 default route
other than RA. We think IPv6 routers which use as edge router, not
backbone core router should accept IPv6 default route as default.
Because an edge router which doesn't speak BGP4+ may not have IPv6
full routes.

This patch changes the behavior and respects IPv6 default routes.

Following patch is against linux-2.4.19.

Thank you in advance.

-------------------------------------------------------------------
Patch-Name: Default Route Support on Router
Patch-Id: FIX_2_4_19_RTR_DEFROUTE-20020912
Patch-Author: YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
Credit: Yuji SEKIYA / USAGI Project <sekiya@linux-ipv6.org>
-------------------------------------------------------------------
Index: net/ipv6/ip6_fib.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv6/ip6_fib.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.10.1
diff -u -r1.1.1.1 -r1.1.1.1.10.1
--- net/ipv6/ip6_fib.c	2002/08/20 09:47:02	1.1.1.1
+++ net/ipv6/ip6_fib.c	2002/09/12 01:49:00	1.1.1.1.10.1
@@ -13,6 +13,12 @@
  *      2 of the License, or (at your option) any later version.
  */
 
+/*
+ * 	Changes:
+ * 	Yuji SEKIYA @USAGI:	Support default route on router node;
+ * 				remove ip6_null_entry from the top of
+ * 				routing table.
+ */
 #include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/types.h>
@@ -248,9 +254,6 @@
 
 	fn = root;
 
-	if (plen == 0)
-		return fn;
-
 	do {
 		key = (struct rt6key *)((u8 *)fn->leaf + offset);
 
@@ -427,6 +430,17 @@
 
 	ins = &fn->leaf;
 
+	if (fn->fn_flags&RTN_TL_ROOT &&
+	    fn->leaf == &ip6_null_entry &&
+	    !(rt->rt6i_flags & (RTF_DEFAULT | RTF_ADDRCONF | RTF_ALLONLINK)) ){
+		/*
+		 * The top fib of ip6 routing table includes ip6_null_entry.
+		 */
+		fn->leaf = rt;
+		rt->u.next = NULL;
+		goto out;
+	}
+
 	for (iter = fn->leaf; iter; iter=iter->u.next) {
 		/*
 		 *	Search for duplicates
@@ -462,6 +476,7 @@
 	 *	insert node
 	 */
 
+out:
 	rt->u.next = iter;
 	*ins = rt;
 	rt->rt6i_node = fn;
@@ -675,7 +690,7 @@
 
 	fn = fib6_lookup_1(root, args);
 
-	if (fn == NULL)
+	if (fn == NULL || fn->fn_flags & RTN_TL_ROOT)
 		fn = root;
 
 	return fn;
@@ -896,6 +911,9 @@
 	read_unlock(&fib6_walker_lock);
 
 	rt->u.next = NULL;
+
+	if (fn->leaf == NULL && fn->fn_flags&RTN_TL_ROOT)
+		fn->leaf = &ip6_null_entry;
 
 	/* If it was last route, expunge its radix tree node */
 	if (fn->leaf == NULL) {
