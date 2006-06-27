Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161270AbWF0UOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161270AbWF0UOT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 16:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161272AbWF0UOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 16:14:19 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:35200 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1161278AbWF0UOQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 16:14:16 -0400
Message-Id: <20060627201151.581322000@sous-sol.org>
References: <20060627200745.771284000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 27 Jun 2006 00:00:09 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       David Miller <davem@davemloft.net>, Neil Horman <nhorman@tuxdriver.com>,
       Sridhar Samudrala <sri@us.ibm.com>
Subject: [PATCH 09/25] SCTP: Fix persistent slowdown in sctp when a gap ack consumes rx buffer.
Content-Disposition: inline; filename=sctp-fix-persistent-slowdown-in-sctp-when-a-gap-ack-consumes-rx-buffer.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Neil Horman <nhorman@tuxdriver.com>

In the event that our entire receive buffer is full with a series of
chunks that represent a single gap-ack, and then we accept a chunk
(or chunks) that fill in the gap between the ctsn and the first gap,
we renege chunks from the end of the buffer, which effectively does
nothing but move our gap to the end of our received tsn stream. This
does little but move our missing tsns down stream a little, and, if the
sender is sending sufficiently large retransmit frames, the result is a
perpetual slowdown which can never be recovered from, since the only
chunk that can be accepted to allow progress in the tsn stream necessitates
that a new gap be created to make room for it. This leads to a constant
need for retransmits, and subsequent receiver stalls. The fix I've come up
with is to deliver the frame without reneging if we have a full receive
buffer and the receiving sockets sk_receive_queue is empty(indicating that
the receive buffer is being blocked by a missing tsn).

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: Sridhar Samudrala <sri@us.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 net/sctp/sm_statefuns.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- linux-2.6.17.1.orig/net/sctp/sm_statefuns.c
+++ linux-2.6.17.1/net/sctp/sm_statefuns.c
@@ -5293,10 +5293,18 @@ static int sctp_eat_data(const struct sc
 	 * seems a bit troublesome in that frag_point varies based on
 	 * PMTU.  In cases, such as loopback, this might be a rather
 	 * large spill over.
+	 * NOTE: If we have a full receive buffer here, we only renege if
+	 * our receiver can still make progress without the tsn being
+	 * received. We do this because in the event that the associations
+	 * receive queue is empty we are filling a leading gap, and since
+	 * reneging moves the gap to the end of the tsn stream, we are likely
+	 * to stall again very shortly. Avoiding the renege when we fill a
+	 * leading gap is a good heuristic for avoiding such steady state
+	 * stalls.
 	 */
 	if (!asoc->rwnd || asoc->rwnd_over ||
 	    (datalen > asoc->rwnd + asoc->frag_point) ||
-	    rcvbuf_over) {
+	    (rcvbuf_over && (!skb_queue_len(&sk->sk_receive_queue)))) {
 
 		/* If this is the next TSN, consider reneging to make
 		 * room.   Note: Playing nice with a confused sender.  A

--
