Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbTEHSRM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 14:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbTEHSRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 14:17:12 -0400
Received: from pizda.ninka.net ([216.101.162.242]:59532 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261852AbTEHSRK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 14:17:10 -0400
Date: Thu, 08 May 2003 10:21:55 -0700 (PDT)
Message-Id: <20030508.102155.132908119.davem@redhat.com>
To: wli@holomorphy.com
Cc: helgehaf@aitel.hist.no, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       akpm@digeo.com
Subject: Re: 2.5.69-mm2 Kernel panic, possibly network related
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030508013854.GW8931@holomorphy.com>
References: <20030507.064010.42794250.davem@redhat.com>
	<20030507215430.GA1109@hh.idb.hist.no>
	<20030508013854.GW8931@holomorphy.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: William Lee Irwin III <wli@holomorphy.com>
   Date: Wed, 7 May 2003 18:38:54 -0700
   
   Can you try one kernel with the netfilter cset backed out, and another
   with the re-slabification patch backed out? (But not with both backed
   out simultaneously).

Not needed, this should cure the problem:

--- net/ipv4/netfilter/ip_nat_core.c.~1~	Thu May  8 11:23:22 2003
+++ net/ipv4/netfilter/ip_nat_core.c	Thu May  8 11:25:56 2003
@@ -861,6 +861,7 @@
 	} *inside;
 	unsigned int i;
 	struct ip_nat_info *info = &conntrack->nat.info;
+	int hdrlen;
 
 	if (!skb_ip_make_writable(pskb,(*pskb)->nh.iph->ihl*4+sizeof(*inside)))
 		return 0;
@@ -868,10 +869,12 @@
 
 	/* We're actually going to mangle it beyond trivial checksum
 	   adjustment, so make sure the current checksum is correct. */
-	if ((*pskb)->ip_summed != CHECKSUM_UNNECESSARY
-	    && (u16)csum_fold(skb_checksum(*pskb, (*pskb)->nh.iph->ihl*4,
-					   (*pskb)->len, 0)))
-		return 0;
+	if ((*pskb)->ip_summed != CHECKSUM_UNNECESSARY) {
+		hdrlen = (*pskb)->nh.iph->ihl * 4;
+		if ((u16)csum_fold(skb_checksum(*pskb, hdrlen,
+						(*pskb)->len - hdrlen, 0)))
+			return 0;
+	}
 
 	/* Must be RELATED */
 	IP_NF_ASSERT((*pskb)->nfct
@@ -948,10 +951,12 @@
 	}
 	READ_UNLOCK(&ip_nat_lock);
 
+	hdrlen = (*pskb)->nh.iph->ihl * 4;
+
 	inside->icmp.checksum = 0;
-	inside->icmp.checksum = csum_fold(skb_checksum(*pskb,
-						       (*pskb)->nh.iph->ihl*4,
-						       (*pskb)->len, 0));
+	inside->icmp.checksum = csum_fold(skb_checksum(*pskb, hdrlen,
+						       (*pskb)->len - hdrlen,
+						       0));
 	return 1;
 
  unlock_fail:
