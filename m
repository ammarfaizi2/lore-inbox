Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267467AbTA1SjN>; Tue, 28 Jan 2003 13:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267629AbTA1SjN>; Tue, 28 Jan 2003 13:39:13 -0500
Received: from pizda.ninka.net ([216.101.162.242]:62360 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267467AbTA1SjM>;
	Tue, 28 Jan 2003 13:39:12 -0500
Date: Tue, 28 Jan 2003 10:35:34 -0800 (PST)
Message-Id: <20030128.103534.115458142.davem@redhat.com>
To: kuznet@ms2.inr.ac.ru
Cc: benoit-lists@fb12.de, dada1@cosmosbay.com, cgf@redhat.com, andersg@0x63.nu,
       lkernel2003@tuxers.net, linux-kernel@vger.kernel.org, tobi@tobi.nu
Subject: Re: [TEST FIX] Re: SSH Hangs in 2.5.59 and 2.5.55 but not 2.4.x,
 through Cisco PIX
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200301281409.RAA28740@sex.inr.ac.ru>
References: <20030128133606.A21796@turing.fb12.de>
	<200301281409.RAA28740@sex.inr.ac.ru>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: kuznet@ms2.inr.ac.ru
   Date: Tue, 28 Jan 2003 17:09:09 +0300 (MSK)

   We apparently have segment of zero length in queue. :-)
   
   Well, that chunk cannot be responsible for this directly, I am afraid
   we somewhat arrived to attempt to retransmit already acked segment.

Hmmm, it is one of few places where sequence numbers of already
sent packet are mangled. :-)

Good set of debug checks would be the following:

--- net/ipv4/tcp_output.c.~1~	Mon Jan 27 14:46:33 2003
+++ net/ipv4/tcp_output.c	Tue Jan 28 10:47:08 2003
@@ -441,6 +441,9 @@
 	TCP_SKB_CB(buff)->end_seq = TCP_SKB_CB(skb)->end_seq;
 	TCP_SKB_CB(skb)->end_seq = TCP_SKB_CB(buff)->seq;
 
+	BUG_TRAP(TCP_SKB_CB(buff)->seq != TCP_SKB_CB(buff)->end_seq);
+	BUG_TRAP(TCP_SKB_CB(skb)->seq != TCP_SKB_CB(skb)->end_seq);
+
 	/* PSH and FIN should only be set in the second packet. */
 	flags = TCP_SKB_CB(skb)->flags;
 	TCP_SKB_CB(skb)->flags = flags & ~(TCPCB_FLAG_FIN|TCPCB_FLAG_PSH);
@@ -524,6 +527,7 @@
 	}
 
 	TCP_SKB_CB(skb)->seq += len;
+	BUG_TRAP(TCP_SKB_CB(skb)->seq != TCP_SKB_CB(skb)->end_seq);
 	skb->ip_summed = CHECKSUM_HW;
 	return 0;
 }
@@ -796,6 +800,7 @@
 
 		/* Update sequence range on original skb. */
 		TCP_SKB_CB(skb)->end_seq = TCP_SKB_CB(next_skb)->end_seq;
+		BUG_TRAP(TCP_SKB_CB(skb)->seq != TCP_SKB_CB(skb)->end_seq);
 
 		/* Merge over control information. */
 		flags |= TCP_SKB_CB(next_skb)->flags; /* This moves PSH/FIN etc. over */
