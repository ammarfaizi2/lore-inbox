Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136658AbREAQp4>; Tue, 1 May 2001 12:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136657AbREAQpr>; Tue, 1 May 2001 12:45:47 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:42509 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S136656AbREAQpe>;
	Tue, 1 May 2001 12:45:34 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200105011644.UAA32621@ms2.inr.ac.ru>
Subject: Re: 2.4.4: Kernel crash, possibly tcp related
To: andrea@suse.de (Andrea Arcangeli)
Date: Tue, 1 May 2001 20:44:52 +0400 (MSK DST)
Cc: davem@redhat.com, ralf@nyren.net, linux-kernel@vger.kernel.org
In-Reply-To: <20010501124756.B805@athlon.random> from "Andrea Arcangeli" at May 1, 1 12:47:56 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> this is the strict fix:

Andrea, you caught the problem!

The fix is not right though (it is equivalent to straight
tp->send_head=NULL, as you noticed. It also corrupts queue in
an opposite manner.) Right fix is appended.

Explanation: in do_fault we must undo effect of enqueueing new segment
in the case the segment remained empty. tp->send_head points to
the first unsent skb in queue and it is NULL when and only when
all the skbs are already sent. (Invariant is: tp->send_head==NULL ||
tp->send_head->seq == tp->snd_nxt)
I crapped this case except for the case when queue is completely empty,
so that the last sent skb was accounted in packets_out twice...

Damn, what a silly mistake was it... shame.

Alexey


--- ../vger3-010426/linux/net/ipv4/tcp.c	Wed Apr 25 21:02:18 2001
+++ linux/net/ipv4/tcp.c	Tue May  1 20:38:44 2001
@@ -1185,7 +1187,7 @@
 	if (skb->len==0) {
 		if (tp->send_head == skb) {
 			tp->send_head = skb->prev;
-			if (tp->send_head == (struct sk_buff*)&sk->write_queue)
+			if (TCP_SKB_CB(skb)->seq == tp->snd_nxt)
 				tp->send_head = NULL;
 		}
 		__skb_unlink(skb, skb->list);
