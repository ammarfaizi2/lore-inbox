Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131576AbRBASyL>; Thu, 1 Feb 2001 13:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131635AbRBASyD>; Thu, 1 Feb 2001 13:54:03 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:22027 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S131632AbRBASxo>;
	Thu, 1 Feb 2001 13:53:44 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200102011853.VAA21071@ms2.inr.ac.ru>
Subject: Re: PROBLEM: small socket send/receive buffers on TCP stream result in data not being transferred
To: ntd1@cs.waikato.ac.NZ (Nicholas Daley)
Date: Thu, 1 Feb 2001 21:53:14 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A792872.4030306@cs.waikato.ac.nz> from "Nicholas Daley" at Feb 1, 1 12:15:01 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> 1. small socket send/receive buffers result in data not being transferred

I know why your test does not work in 2.4 (sort of bug, fix is appended).

But I have no idea, why it does not work with 2.2. Please, make
tcpdump in this case.


> and SO_RCVBUF (see small attached programs), I found that given small
> enough buffers, data would stop being sent, although more was available.

No doubts. If you think that tcp must work like gun no matter
what silly things application makes, you are mistaken.
TCP works like gun when application does not try to interlope. 8)

You have made two capital mistakes:

1. RCVBUF/SNDBUF are not arbibrary numbers. Of course, kernel tries
   to adjust them to something reasonable, when user asks something
   wicked (like your case), but it cannot do this in all the cases.
2. Playing with buffer sizes after connection is established
   is very bad idea, tcp is defenceless in this case.

> This behaviour may depend on the speed of the system, on mine I can

Surely, it is not.


> usually get it to happen with buffer sizes around 100

Advice: do not play with these sockopts. Kernel does this better,
than any application.

Application may set them, when it wants to set large values.
Values, selected by kernel by default, are minimal ones in fact.

Alexey


--- ../vger3-010130/linux/include/net/tcp.h	Wed Dec 13 22:37:49 2000
+++ linux/include/net/tcp.h	Thu Feb  1 21:08:45 2001
@@ -1304,7 +1305,8 @@
 	struct tcp_opt *tp = &sk->tp_pinfo.af_tcp;
 
 	if (tp->ucopy.task) {
-		if ((tp->ucopy.memory += skb->truesize) <= (sk->rcvbuf<<1)) {
+		if (tp->ucopy.memory < (sk->rcvbuf<<1)) {
+			tp->ucopy.memory += skb->truesize;
 			__skb_queue_tail(&tp->ucopy.prequeue, skb);
 			if (skb_queue_len(&tp->ucopy.prequeue) == 1) {
 				wake_up_interruptible(sk->sleep);
@@ -1313,7 +1315,6 @@
 			}
 		} else {
 			NET_INC_STATS_BH(TCPPrequeueDropped);
-			tp->ucopy.memory -= skb->truesize;
 			__kfree_skb(skb);
 		}
 		return 1;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
