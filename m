Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbTJXQac (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 12:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbTJXQac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 12:30:32 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:43716 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S262288AbTJXQaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 12:30:30 -0400
Date: Fri, 24 Oct 2003 18:29:59 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, grof@dragon.cz
Subject: possible bug in tcp_input.c
Message-ID: <20031024162959.GB11154@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

We came up with the attached patch during a hectic oops tracing session
that got started by our sysadmin writing down an oops using the pen & paper
method, no less.  The crashing machine has been a firewall running a very
unusual NAT + QoS configuration, however we believe that we might have
discovered a real bug in 2.4's tcp_input.c.  Since our insight into the
internals of the tcp/ip stack is far from even basic, we are seeking your
opinion on whether we are correct.

The static inline function skb_peek() as defined in include/linux/skbuff.h
returns a pointer to a sk_buff, or NULL when its argument is an empty list
or a pointer to the head element.  Since this is documented behavior, it is
not surprising that all segments of code within tcp_input.c dealing with
a return from skb_peek() take care not to dereference the returned pointer
if it happens to be NULL.  There is an exception, though:

/* tcp_input.c, line 1138 */
static inline int tcp_head_timedout(struct sock *sk, struct tcp_opt *tp)
{
  return tp->packets_out && tcp_skb_timedout(tp, skb_peek(&sk->write_queue));
}

The passed NULL (and yes, this is where we are getting one) is dereferenced
immediately in:

/* tcp_input.c, line 1133 */
static inline int tcp_skb_timedout(struct tcp_opt *tp, struct sk_buff *skb)
{
  return (tcp_time_stamp - TCP_SKB_CB(skb)->when > tp->rto);
}

with TCP_SKB_CB that is defined as

/* tcp.h, line 1034 */
#define TCP_SKB_CB(__skb)	((struct tcp_skb_cb *)&((__skb)->cb[0]))

We are proposing to cure the problem by adding a simple check in
tcp_head_timedout(), but are not sure whether this is the right
thing to do, because as a friend put it, we seem to be fixing
a leaking faucet in a god damn power plant.

Thanks for any help,
-- 
Tomas Szepe <szepe@pinerecords.com>


diff -urN a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
--- a/net/ipv4/tcp_input.c	2003-06-13 16:51:39 +0200
+++ b/net/ipv4/tcp_input.c	2003-10-24 17:41:19 +0200
@@ -1138,7 +1138,11 @@
 
 static inline int tcp_head_timedout(struct sock *sk, struct tcp_opt *tp)
 {
-	return tp->packets_out && tcp_skb_timedout(tp, skb_peek(&sk->write_queue));
+	struct sk_buff *skb = skb_peek(&sk->write_queue);
+	if (skb == NULL)
+		return 1;
+
+	return tp->packets_out && tcp_skb_timedout(tp, skb);
 }
 
 /* Linux NewReno/SACK/FACK/ECN state machine.
