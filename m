Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317885AbSGKTqi>; Thu, 11 Jul 2002 15:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317887AbSGKTqg>; Thu, 11 Jul 2002 15:46:36 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:10196 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S317885AbSGKTqS>; Thu, 11 Jul 2002 15:46:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: fdavis@si.rr.com
Subject: Re: [PATCH] 2.5.25 : tr_source_route fix
Date: Thu, 11 Jul 2002 23:47:31 +0200
User-Agent: KMail/1.4.2
Cc: linux-kernel@vger.kernel.org, Trivial Patches <trivial@rustcorp.com.au>
References: <Pine.LNX.4.44.0207101011580.873-100000@localhost.localdomain> <200207111134.34672.arnd@bergmann-dalldorf.de> <3D2D8F84.5070107@si.rr.com>
In-Reply-To: <3D2D8F84.5070107@si.rr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207112341.50975.arnd@bergmann-dalldorf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 July 2002 16:00, Frank Davis wrote:
>     Please post the 'correct' diff for inclusion. Thanks.

Ok, here it is, diffed against latest bk and double checked.

	Arnd <><

D: make Token Ring networking compile with LLC
===== include/linux/trdevice.h 1.2 vs edited =====
--- 1.2/include/linux/trdevice.h	Tue Feb  5 08:38:37 2002
+++ edited/include/linux/trdevice.h	Thu Jul 11 23:00:23 2002
@@ -33,6 +33,9 @@
 				   void *saddr, unsigned len);
 extern int		tr_rebuild_header(struct sk_buff *skb);
 extern unsigned short	tr_type_trans(struct sk_buff *skb, struct net_device 
*dev);
+extern void		tr_source_route(struct sk_buff *skb, 
+					struct trh_hdr *trh,
+					struct net_device *dev);
 extern struct net_device *init_trdev(struct net_device *dev, int 
sizeof_priv);
 extern struct net_device *alloc_trdev(int sizeof_priv);
 extern int register_trdev(struct net_device *dev);
===== net/802/tr.c 1.2 vs edited =====
--- 1.2/net/802/tr.c	Wed May 22 20:16:37 2002
+++ edited/net/802/tr.c	Thu Jul 11 23:00:24 2002
@@ -36,7 +36,6 @@
 #include <linux/init.h>
 #include <net/arp.h>
 
-static void tr_source_route(struct sk_buff *skb, struct trh_hdr *trh, struct 
net_device *dev);
 static void tr_add_rif_info(struct trh_hdr *trh, struct net_device *dev);
 static void rif_check_expire(unsigned long dummy);
 
@@ -230,7 +229,7 @@
  *	We try to do source routing... 
  */
 
-static void tr_source_route(struct sk_buff *skb,struct trh_hdr *trh,struct 
net_device *dev) 
+void tr_source_route(struct sk_buff *skb,struct trh_hdr *trh,struct 
net_device *dev) 
 {
 	int i, slack;
 	unsigned int hash;
===== net/llc/llc_mac.c 1.1 vs edited =====
--- 1.1/net/llc/llc_mac.c	Fri May 31 02:35:09 2002
+++ edited/net/llc/llc_mac.c	Thu Jul 11 23:01:00 2002
@@ -15,6 +15,7 @@
 #include <linux/if_arp.h>
 #include <linux/if_tr.h>
 #include <linux/rtnetlink.h>
+#include <linux/trdevice.h>
 #include <net/llc_if.h>
 #include <net/llc_mac.h>
 #include <net/llc_pdu.h>
@@ -25,10 +26,7 @@
 #include <net/llc_evnt.h>
 #include <net/llc_c_ev.h>
 #include <net/llc_s_ev.h>
-#ifdef CONFIG_TR
-extern void tr_source_route(struct sk_buff *skb, struct trh_hdr *trh,
-			    struct net_device *dev);
-#endif
+
 /* function prototypes */
 static void fix_up_incoming_skb(struct sk_buff *skb);
 


