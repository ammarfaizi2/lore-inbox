Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbUL3I75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbUL3I75 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 03:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbUL3I4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 03:56:15 -0500
Received: from smtp.knology.net ([24.214.63.101]:31114 "HELO smtp.knology.net")
	by vger.kernel.org with SMTP id S261581AbUL3Ish (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 03:48:37 -0500
Date: Thu, 30 Dec 2004 03:48:36 -0500
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, dave@thedillows.org
From: David Dillow <dave@thedillows.org>
Subject: [RFC 2.6.10 9/22] AH: Split header initialization from zeroing of mutable fields
Message-Id: <20041230035000.18@ori.thedillows.org>
References: <20041230035000.17@ori.thedillows.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/12/30 00:42:33-05:00 dave@thedillows.org 
#   Seperate AH header initialization from the zeroing of mutable
#   IP header fields in preparation for offloading the crypto
#   processing of the packet.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
# net/ipv4/ah4.c
#   2004/12/30 00:42:15-05:00 dave@thedillows.org +18 -12
#   Seperate AH header initialization from the zeroing of mutable
#   IP header fields in preparation for offloading the crypto
#   processing of the packet.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
diff -Nru a/net/ipv4/ah4.c b/net/ipv4/ah4.c
--- a/net/ipv4/ah4.c	2004-12-30 01:10:27 -05:00
+++ b/net/ipv4/ah4.c	2004-12-30 01:10:27 -05:00
@@ -69,6 +69,20 @@
 	top_iph = skb->nh.iph;
 	iph = &tmp_iph.iph;
 
+	ah = (struct ip_auth_hdr *)((char *)top_iph+top_iph->ihl*4);
+	ah->nexthdr = top_iph->protocol;
+
+	top_iph->tot_len = htons(skb->len);
+	top_iph->protocol = IPPROTO_AH;
+
+	ahp = x->data;
+	ah->hdrlen  = (XFRM_ALIGN8(sizeof(struct ip_auth_hdr) + 
+				   ahp->icv_trunc_len) >> 2) - 2;
+
+	ah->reserved = 0;
+	ah->spi = x->id.spi;
+	ah->seq_no = htonl(x->replay.oseq + 1);
+
 	iph->tos = top_iph->tos;
 	iph->ttl = top_iph->ttl;
 	iph->frag_off = top_iph->frag_off;
@@ -81,23 +95,11 @@
 			goto error;
 	}
 
-	ah = (struct ip_auth_hdr *)((char *)top_iph+top_iph->ihl*4);
-	ah->nexthdr = top_iph->protocol;
-
 	top_iph->tos = 0;
-	top_iph->tot_len = htons(skb->len);
 	top_iph->frag_off = 0;
 	top_iph->ttl = 0;
-	top_iph->protocol = IPPROTO_AH;
 	top_iph->check = 0;
 
-	ahp = x->data;
-	ah->hdrlen  = (XFRM_ALIGN8(sizeof(struct ip_auth_hdr) + 
-				   ahp->icv_trunc_len) >> 2) - 2;
-
-	ah->reserved = 0;
-	ah->spi = x->id.spi;
-	ah->seq_no = htonl(++x->replay.oseq);
 	ahp->icv(ahp, skb, ah->auth_data);
 
 	top_iph->tos = iph->tos;
@@ -108,6 +110,10 @@
 		memcpy(top_iph+1, iph+1, top_iph->ihl*4 - sizeof(struct iphdr));
 	}
 
+	/* Delay incrementing the replay sequence until we know we're going
+	 * to send this packet to prevent gaps.
+	 */
+	x->replay.oseq++;
 	ip_send_check(top_iph);
 
 	err = 0;
