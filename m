Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275126AbRJNNPE>; Sun, 14 Oct 2001 09:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275139AbRJNNOz>; Sun, 14 Oct 2001 09:14:55 -0400
Received: from cs181088.pp.htv.fi ([213.243.181.88]:5248 "EHLO
	cs181088.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S275126AbRJNNOf>; Sun, 14 Oct 2001 09:14:35 -0400
Message-ID: <3BC98FB6.50CF8815@welho.com>
Date: Sun, 14 Oct 2001 16:14:30 +0300
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        kuznet@ms2.inr.ac.ru
Subject: [PATCH] TCP acking too fast
In-Reply-To: <3BC94F3A.7F842182@welho.com> <20011014.020326.18308527.davem@redhat.com> <k2zo6uiney.fsf@zero.aec.at> <20011014.023948.95894368.davem@redhat.com> <20011014133004.34133@colin.muc.de>
Content-Type: multipart/mixed;
 boundary="------------F0707066924DAB5FAD9E81F0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F0707066924DAB5FAD9E81F0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Ok, here's the patch against 2.4.10-ac10. This seems to produce
acceptable behaviour in the cases I tested, at least. Someone with one
of those "ridiculously small MTU" links might give it a go to check that
the rcv_mss estimation still works as expected. It should, though, as I
didn't really make any changes to it.

Andi Kleen wrote:
> The only special case for PSH in RX left I can is in rcv_mss estimation,
> where is assumes that a packet with PSH set is not full sized.  On further
> look the 2.4 tcp_measure_rcv_mss will never update rcv_mss for packets
> which do have PSH set and in this case cause random ack behaviour depending
> on the initial rcv_mss guess.

A too low rcv_mss estimate isn't a problem, as the estimate is
immediately increased when the first larger segment arrives. A too high
estimate can be difficult to adjust down, though, if the sender suddenly
starts sending smalls segments with PSH set.

> Not very nice; definitely violates the "be conservative what you accept"
> rule. I'm not sure how to fix it, adding a fallback to every-two-packet-add
> would pollute the fast path a bit.

Hopefully a bit more conservative now. I didn't implement the fall back
to ack-every-two-packets, though, as I had the exact opposite problem.
:)

Regards,

	MikaL
--------------F0707066924DAB5FAD9E81F0
Content-Type: text/plain; charset=us-ascii;
 name="over_ack.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="over_ack.patch"

--- tcp_input.c.org	Sat Oct 13 23:24:38 2001
+++ tcp_input.c	Sun Oct 14 15:47:10 2001
@@ -126,24 +126,25 @@
 	 * sends good full-sized frames.
 	 */
 	len = skb->len;
+
 	if (len >= tp->ack.rcv_mss) {
 		tp->ack.rcv_mss = len;
-		/* Dubious? Rather, it is final cut. 8) */
-		if (tcp_flag_word(skb->h.th)&TCP_REMNANT)
-			tp->ack.pending |= TCP_ACK_PUSHED;
 	} else {
-		/* Otherwise, we make more careful check taking into account,
-		 * that SACKs block is variable.
+		/* If PSH is not set, packet should be full sized, assuming
+		 * that the peer implements Nagle correctly.
+		 * This observation (if it is correct 8)) allows
+		 * to handle super-low mtu links fairly.
 		 *
-		 * "len" is invariant segment length, including TCP header.
+		 * However, If sender sets TCP_NODELAY, this could effectively
+		 * turn receiver side SWS algorithms off. TCP_MIN_MSS guards
+		 * against a ridiculously small rcv_mss estimate.
+		 *
+		 * We also have to be careful checking the header size, since
+		 * the SACK option is variable length. "len" is the invariant
+		 * segment length, including TCP header.
 		 */
 		len += skb->data - skb->h.raw;
 		if (len >= TCP_MIN_RCVMSS + sizeof(struct tcphdr) ||
-		    /* If PSH is not set, packet should be
-		     * full sized, provided peer TCP is not badly broken.
-		     * This observation (if it is correct 8)) allows
-		     * to handle super-low mtu links fairly.
-		     */
 		    (len >= TCP_MIN_MSS + sizeof(struct tcphdr) &&
 		     !(tcp_flag_word(skb->h.th)&TCP_REMNANT))) {
 			/* Subtract also invariant (if peer is RFC compliant),
@@ -152,12 +153,9 @@
 			 */
 			len -= tp->tcp_header_len;
 			tp->ack.last_seg_size = len;
-			if (len == lss) {
+			if (len == lss)
 				tp->ack.rcv_mss = len;
-				return;
-			}
 		}
-		tp->ack.pending |= TCP_ACK_PUSHED;
 	}
 }
 

--------------F0707066924DAB5FAD9E81F0--

