Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261701AbTA2BUi>; Tue, 28 Jan 2003 20:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261847AbTA2BUi>; Tue, 28 Jan 2003 20:20:38 -0500
Received: from pizda.ninka.net ([216.101.162.242]:411 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261701AbTA2BUh>;
	Tue, 28 Jan 2003 20:20:37 -0500
Date: Tue, 28 Jan 2003 16:08:06 -0800 (PST)
Message-Id: <20030128.160806.13210372.davem@redhat.com>
To: kuznet@ms2.inr.ac.ru
Cc: benoit-lists@fb12.de, dada1@cosmosbay.com, cgf@redhat.com, andersg@0x63.nu,
       lkernel2003@tuxers.net, linux-kernel@vger.kernel.org, tobi@tobi.nu
Subject: Re: [TEST FIX] Re: SSH Hangs in 2.5.59 and 2.5.55 but not 2.4.x,
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200301282356.CAA30301@sex.inr.ac.ru>
References: <20030128.123413.51821993.davem@redhat.com>
	<200301282356.CAA30301@sex.inr.ac.ru>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: kuznet@ms2.inr.ac.ru
   Date: Wed, 29 Jan 2003 02:56:41 +0300 (MSK)

   Hey! Interesting thing has just happened, it is the first time when I found
   the bug formulating a senstence while writing e-mail not while peering
   to code. :-)
   
Congratulations :-)

   Shheit, look into tcp_retrans_try_collapse():
   
                   if (skb->ip_summed != CHECKSUM_HW) {
                           memcpy(skb_put(skb, next_skb_size), next_skb->data, nex$                        skb->csum = csum_block_add(skb->csum, next_skb->csum, s$                }
    
   
   WHERE IS skb_put and copy when skb->ip_summed==CHECKSUM_HW??!!
   
   So, the fix is move of memcpy() line out of if clause.
   
Indeed, this bug exists in 2.4 as well of course.

This bug is 2.4.3 vintage :-)  It got added as part of initial
zerocopy merge in fact.

Here is 2.4.x version of fix, 2.5.x is identicaly sans some line
number differences.  I will push this all to Linus/Marcelo.

BTW, Alexey, please please explain to me how that trick made
by tcp_trim_head() works. :-)  I am talking about how it is
setting ip_summed to CHECKSUM_HARDWARE blindly and not even
bothering to set skb->csum correctly.

--- net/ipv4/tcp_output.c.~1~	Tue Jan 28 16:12:39 2003
+++ net/ipv4/tcp_output.c	Tue Jan 28 16:14:18 2003
@@ -721,10 +721,9 @@
 		if (next_skb->ip_summed == CHECKSUM_HW)
 			skb->ip_summed = CHECKSUM_HW;
 
-		if (skb->ip_summed != CHECKSUM_HW) {
-			memcpy(skb_put(skb, next_skb_size), next_skb->data, next_skb_size);
+		memcpy(skb_put(skb, next_skb_size), next_skb->data, next_skb_size);
+		if (skb->ip_summed != CHECKSUM_HW)
 			skb->csum = csum_block_add(skb->csum, next_skb->csum, skb_size);
-		}
 
 		/* Update sequence range on original skb. */
 		TCP_SKB_CB(skb)->end_seq = TCP_SKB_CB(next_skb)->end_seq;
