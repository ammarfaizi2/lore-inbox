Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135413AbRDMGwR>; Fri, 13 Apr 2001 02:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135426AbRDMGwH>; Fri, 13 Apr 2001 02:52:07 -0400
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:5303 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S135413AbRDMGvt>; Fri, 13 Apr 2001 02:51:49 -0400
Date: Fri, 13 Apr 2001 02:51:43 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: zaitcev@redhat.com
Subject: sk->state_chage is not called for listening sockets
Message-ID: <20010413025143.A24741@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

Suppose for a moment, that I have an in-kernel daemon, listening
on a TCP socket, and that the said daemon is interested to
know when connection becomes established. To that end it
puts something into sk->state_change. However, when connection
is established, state_chenge is not called (in 2.4.3).

With that in mind, would the following chage have any ill effects?
It does not seem to break anything obvious, but I am worried about
a performance degradation for some retarded benchmark.

diff -u -U 4 linux-2.4.3/net/ipv4/tcp_input.c linux-2.4.3-nfs/net/ipv4/tcp_input.c
--- linux-2.4.3/net/ipv4/tcp_input.c	Fri Feb  9 11:34:13 2001
+++ linux-2.4.3-nfs/net/ipv4/tcp_input.c	Thu Apr 12 23:23:59 2001
@@ -3712,16 +3712,16 @@
 			if (acceptable) {
 				tp->copied_seq = tp->rcv_nxt;
 				mb();
 				tcp_set_state(sk, TCP_ESTABLISHED);
+				sk->state_change(sk);
 
 				/* Note, that this wakeup is only for marginal
 				 * crossed SYN case. Passively open sockets
 				 * are not waked up, because sk->sleep == NULL
 				 * and sk->socket == NULL.
 				 */
 				if (sk->socket) {
-					sk->state_change(sk);
 					sk_wake_async(sk,0,POLL_OUT);
 				}
 
 				tp->snd_una = TCP_SKB_CB(skb)->ack_seq;


Thanks,
-- Pete
