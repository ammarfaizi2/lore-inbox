Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136682AbREASKw>; Tue, 1 May 2001 14:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136683AbREASKo>; Tue, 1 May 2001 14:10:44 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:18190 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S136682AbREASKb>;
	Tue, 1 May 2001 14:10:31 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200105011810.WAA00750@ms2.inr.ac.ru>
Subject: Re: 2.4.4: Kernel crash, possibly tcp related
To: andrea@suse.de (Andrea Arcangeli)
Date: Tue, 1 May 2001 22:10:03 +0400 (MSK DST)
Cc: davem@redhat.com, ralf@nyren.net, linux-kernel@vger.kernel.org
In-Reply-To: <20010501193225.D31373@athlon.random> from "Andrea Arcangeli" at May 1, 1 07:32:25 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> If send_head doesn't point to skb then it is before it (and it cannot
> advance under us of course because we hold the sock lock) and so in such
> case we didn't clobbered the send_head at all in skb_entail, and so we
> don't need to touch send_head in order to undo (we only need to unlink).
> 
> See?

I see! Dave, please, take the second Andrea's patch (appended).
It is really the cleanest one.

Alexey


--- 2.4.4aa3/net/ipv4/tcp.c.~1~	Tue May  1 10:44:57 2001
+++ 2.4.4aa3/net/ipv4/tcp.c	Tue May  1 12:00:25 2001
@@ -1183,11 +1183,8 @@
 
 do_fault:
 	if (skb->len==0) {
-		if (tp->send_head == skb) {
-			tp->send_head = skb->next;
-			if (tp->send_head == (struct sk_buff*)&sk->write_queue)
-				tp->send_head = NULL;
-		}
+		if (tp->send_head == skb)
+			tp->send_head = NULL;
 		__skb_unlink(skb, skb->list);
 		tcp_free_skb(sk, skb);
 	}

