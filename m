Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbTJZGz2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 01:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262898AbTJZGz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 01:55:28 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:1756 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S262884AbTJZGzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 01:55:25 -0500
Date: Sun, 26 Oct 2003 07:55:19 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, grof@dragon.cz,
       volf@dragon.cz
Subject: Re: possible bug in tcp_input.c
Message-ID: <20031026065519.GC28035@louise.pinerecords.com>
References: <20031024162959.GB11154@louise.pinerecords.com> <20031024193034.30f1caed.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031024193034.30f1caed.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct-24 2003, Fri, 19:30 -0700
David S. Miller <davem@redhat.com> wrote:

> > The passed NULL (and yes, this is where we are getting one) is dereferenced
> > immediately in:
> > 
> > /* tcp_input.c, line 1133 */
> > static inline int tcp_skb_timedout(struct tcp_opt *tp, struct sk_buff *skb)
> > {
> >   return (tcp_time_stamp - TCP_SKB_CB(skb)->when > tp->rto);
> > }
> 
> If tp->packets_out is non-zero (which by definition it is
> in your case else the right hand side of the "&&" would not be
> evaluated) then we _MUST_ have some packets in sk->write_queue.
> 
> Something is being fiercely corrupted.  Probably some piece of
> netfilter is freeing up an SKB one too many times thus corrupting
> the TCP write queue list pointers.

Dave, we've been thinking about this some more and have concluded
that since the problem is a relatively non-fatal one, the kernel
should just print out an "assertion failed" error similar to the
one in tcp_input.c, line 1323 [BUG_TRAP(cnt <= tp->packets_out);]
and maybe fix things up a little rather than oops on a NULL pointer
dereference;  The state in question, although invalid, is possible
and should IMHO be checked for as in all the other "if (skb != NULL)
..." places).

What do you think?  We keep on trying to locate which code is causing
the corruption, meanwhile the affected system has been running crash-lessly
with the attached patch.

Thanks,
-- 
Tomas Szepe <szepe@pinerecords.com>

diff -urN a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
--- a/net/ipv4/tcp_input.c	2003-06-13 16:51:39 +0200
+++ b/net/ipv4/tcp_input.c	2003-10-26 07:29:11 +0100
@@ -1138,7 +1138,19 @@
 
 static inline int tcp_head_timedout(struct sock *sk, struct tcp_opt *tp)
 {
-	return tp->packets_out && tcp_skb_timedout(tp, skb_peek(&sk->write_queue));
+	struct sk_buff *skb = skb_peek(&sk->write_queue);
+
+	if (skb == NULL) {
+		if (tp->packets_out) {
+			printk("KERNEL: assertion (%s) failed at %s(%d)\n",
+				"skb == NULL && tp->packets_out",
+				__FILE__, __LINE__);
+			tp->packets_out = 0;
+		}
+		return 0;
+	} else {
+		return tp->packets_out && tcp_skb_timedout(tp, skb);
+	}
 }
 
 /* Linux NewReno/SACK/FACK/ECN state machine.
