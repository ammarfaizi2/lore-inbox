Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269122AbUINCNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269122AbUINCNf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 22:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269116AbUINCMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 22:12:34 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:36009
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269106AbUINCKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 22:10:48 -0400
Date: Mon, 13 Sep 2004 19:08:58 -0700
From: "David S. Miller" <davem@davemloft.net>
To: James Morris <jmorris@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.6.9-rc1-mm5: TCP oopses
Message-Id: <20040913190858.12544431.davem@davemloft.net>
In-Reply-To: <Xine.LNX.4.44.0409132019170.22477-200000@thoron.boston.redhat.com>
References: <20040913015003.5406abae.akpm@osdl.org>
	<Xine.LNX.4.44.0409132019170.22477-200000@thoron.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2004 20:25:38 -0400 (EDT)
James Morris <jmorris@redhat.com> wrote:

> I'm experiencing TCP related oopses with this kernel (not seen in -mm4), 
> .config file attached.
> 
> Here are two backtraces, the first happened a few seconds after logging 
> in via ssh, the second happened soon after boot (using selinux=0, just to 
> make sure).

I think I fixed this one yesterday.  Callers of tcp_fragment()
in tcp_output.c were not accounting packets correctly.  I
believe this is what will fix it, and this is in Linus's
tree already.

I guess you have an e1000 in this box? :)
(either that or some other card whose driver
enables TSO by default)

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/09/10 15:21:43-07:00 davem@nuts.davemloft.net 
#   [TCP]: Fix packet counting when fragmenting already sent packets.
#   
#   Calls to tcp_fragment() change the tso_factor of
#   an SKB, so we need to deal with that.
#   
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
# net/ipv4/tcp_output.c
#   2004/09/10 15:21:13-07:00 davem@nuts.davemloft.net +12 -2
#   [TCP]: Fix packet counting when fragmenting already sent packets.
#   
#   Calls to tcp_fragment() change the tso_factor of
#   an SKB, so we need to deal with that.
#   
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
diff -Nru a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
--- a/net/ipv4/tcp_output.c	2004-09-13 18:51:38 -07:00
+++ b/net/ipv4/tcp_output.c	2004-09-13 18:51:38 -07:00
@@ -681,8 +681,12 @@
 			TCP_SKB_CB(skb)->when = tcp_time_stamp;
 			if (tcp_transmit_skb(sk, skb_clone(skb, GFP_ATOMIC)))
 				break;
-			/* Advance the send_head.  This one is sent out. */
+
+			/* Advance the send_head.  This one is sent out.
+			 * This call will increment packets_out.
+			 */
 			update_send_head(sk, tp, skb);
+
 			tcp_minshall_update(tp, mss_now, skb);
 			sent_pkts = 1;
 		}
@@ -968,11 +972,17 @@
 		return -EAGAIN;
 
 	if (skb->len > cur_mss) {
+		int old_factor = TCP_SKB_CB(skb)->tso_factor;
+		int new_factor;
+
 		if (tcp_fragment(sk, skb, cur_mss))
 			return -ENOMEM; /* We'll try again later. */
 
 		/* New SKB created, account for it. */
-		tcp_inc_pcount(&tp->packets_out, skb);
+		new_factor = TCP_SKB_CB(skb)->tso_factor;
+		tcp_dec_pcount_explicit(&tp->packets_out,
+					new_factor - old_factor);
+		tcp_inc_pcount(&tp->packets_out, skb->next);
 	}
 
 	/* Collapse two adjacent packets if worthwhile and we can. */
