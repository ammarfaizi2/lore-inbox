Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265256AbUFMTnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265256AbUFMTnA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 15:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265257AbUFMTnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 15:43:00 -0400
Received: from [130.192.48.24] ([130.192.48.24]:29643 "EHLO assi.polito.it")
	by vger.kernel.org with ESMTP id S265256AbUFMTm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 15:42:57 -0400
From: Riccardo Scarsi <rscarsi@penguin.polito.it>
Date: Sun, 13 Jun 2004 21:42:40 +0200
To: cap@di.fc.ul.pt
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] multicast mroute
Message-ID: <20040613194240.GA32069@assi.polito.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch permits to add a multicast routing rule in the kernel that
specify an entire subnet for the multicast packets and not anly a
specific source address.



--- linux-2.4.24.vanilla/include/linux/mroute.h	2001-11-22 20:47:48.000000000 +0100
+++ linux-2.4.24/include/linux/mroute.h	2004-02-10 15:15:26.000000000 +0100
@@ -25,6 +25,7 @@
 #define MRT_VERSION	(MRT_BASE+6)	/* Get the kernel multicast version	*/
 #define MRT_ASSERT	(MRT_BASE+7)	/* Activate PIM assert mode		*/
 #define MRT_PIM		(MRT_BASE+8)	/* enable PIM code	*/
+#define MRT_ADD_MFC_NM	(MRT_BASE+9)	/* Add a multicast forwarding entry	*/
 
 #define SIOCGETVIFCNT	SIOCPROTOPRIVATE	/* IP protocol privates */
 #define SIOCGETSGCNT	(SIOCPROTOPRIVATE+1)
@@ -78,6 +79,8 @@
 	unsigned int mfcc_byte_cnt;
 	unsigned int mfcc_wrong_if;
 	int	     mfcc_expire;
+	struct in_addr mfcc_origin_netmask;	/* Netmask of the origin 
+						of mcast	*/
 };
 
 /* 
@@ -169,6 +172,7 @@
 			unsigned char ttls[MAXVIFS];	/* TTL thresholds		*/
 		} res;
 	} mfc_un;
+	__u32 mfc_origin_netmask;			/* Netmask of source of packet 		*/
 };
 
 #define MFC_STATIC		1
--- linux-2.4.24.vanilla/net/ipv4/ipmr.c	2003-11-28 19:26:21.000000000 +0100
+++ linux-2.4.24/net/ipv4/ipmr.c	2004-02-10 15:03:47.000000000 +0100
@@ -450,6 +450,18 @@
 	return 0;
 }
 
+static struct mfc_cache *ipmr_cache_find_netmask(__u32 origin, __u32 mcastgrp)
+{
+	int line=MFC_HASH(mcastgrp,origin);
+	struct mfc_cache *c;
+
+	for (c=mfc_cache_array[line]; c; c = c->next) {
+		if ((c->mfc_origin & c->mfc_origin_netmask)==(origin & c->mfc_origin_netmask) && c->mfc_mcastgrp==mcastgrp)
+			break;
+	}
+	return c;
+}
+
 static struct mfc_cache *ipmr_cache_find(__u32 origin, __u32 mcastgrp)
 {
 	int line=MFC_HASH(mcastgrp,origin);
@@ -901,6 +913,7 @@
 		 *	Manipulate the forwarding caches. These live
 		 *	in a sort of kernel/user symbiosis.
 		 */
+		case MRT_ADD_MFC_NM:
 		case MRT_ADD_MFC:
 		case MRT_DEL_MFC:
 			if(optlen!=sizeof(mfc))
@@ -908,6 +921,8 @@
 			if (copy_from_user(&mfc,optval, sizeof(mfc)))
 				return -EFAULT;
 			rtnl_lock();
+			if (optname==MRT_ADD_MFC)
+				mfc.mfcc_origin_netmask.s_addr = 0xffffffff;
 			if (optname==MRT_DEL_MFC)
 				ret = ipmr_mfc_delete(&mfc);
 			else
@@ -1336,7 +1351,7 @@
 	}
 
 	read_lock(&mrt_lock);
-	cache = ipmr_cache_find(skb->nh.iph->saddr, skb->nh.iph->daddr);
+	cache = ipmr_cache_find_netmask(skb->nh.iph->saddr, skb->nh.iph->daddr);
 
 	/*
 	 *	No usable cache entry

