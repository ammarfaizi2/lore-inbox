Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266164AbRF2TmS>; Fri, 29 Jun 2001 15:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266166AbRF2TmI>; Fri, 29 Jun 2001 15:42:08 -0400
Received: from [216.44.69.131] ([216.44.69.131]:55291 "EHLO jetcar.qnz.org")
	by vger.kernel.org with ESMTP id <S266164AbRF2TmF>;
	Fri, 29 Jun 2001 15:42:05 -0400
To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk, davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] bad TCP checksums in tcp_retrans_try_collapse 2.4.5pre5 (at least)
From: Todd Sabin <tas@webspan.net>
Date: 29 Jun 2001 15:40:32 -0400
Message-ID: <m3pubnoz0v.fsf@jetcar.qnz.org>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

We've been pulling our hair out lately trying to figure out why
certain connections of ours have been just stalling and dying.  It
turns out that the problem occurs when tcp segments are lost and then
coalesced into a single segment for retransmission.  When that
happens, a bad checksum is computed, and then the connection dies
while one end continually retransmits the same packet with a bad
checksum.

Here's a patch against 2.4.5pre5 which should fix it:

--- tcp_output.c~	Thu Apr 12 15:11:39 2001
+++ tcp_output.c	Fri Jun 29 13:58:31 2001
@@ -722,7 +722,7 @@
 
 		if (skb->ip_summed != CHECKSUM_HW) {
 			memcpy(skb_put(skb, next_skb_size), next_skb->data, next_skb_size);
-			skb->csum = csum_block_add(skb->csum, next_skb->csum, skb->len);
+			skb->csum = csum_block_add(skb->csum, next_skb->csum, skb_size);
 		}
 
 		/* Update sequence range on original skb. */


Hopefully the problem is obvious in retrospect.  skb_put(skb,...)
modifies skb->len, and the new value was being used in csum_block_add
instead of the original len.  We're testing the patch now, but it
seems fairly obvious and apparently other people have been reporting
similar problems so I wanted to get this out there...


Todd

p.s.  If there's followup, please Cc me directly, as I'm not
subscribed to lkml.

-- 
Todd Sabin                                               <tas@webspan.net>
BindView RAZOR Team                            <tsabin@razor.bindview.com>
