Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136603AbREAKtC>; Tue, 1 May 2001 06:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136607AbREAKsn>; Tue, 1 May 2001 06:48:43 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:28690 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S136603AbREAKsb>; Tue, 1 May 2001 06:48:31 -0400
Date: Tue, 1 May 2001 12:47:56 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: kuznet@ms2.inr.ac.ru
Cc: "David S. Miller" <davem@redhat.com>, ralf@nyren.net,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.4: Kernel crash, possibly tcp related
Message-ID: <20010501124756.B805@athlon.random>
In-Reply-To: <15084.62398.56283.772414@pizda.ninka.net> <200104301700.VAA18188@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200104301700.VAA18188@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Mon, Apr 30, 2001 at 09:00:09PM +0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2001 at 09:00:09PM +0400, kuznet@ms2.inr.ac.ru wrote:
> Hello!
> 
> > My current theory is that tcpblast does something erratic when the
> > error occurs.
> 
> It has buffer size of 32K, so that it faults at enough large chunk sizes.
> 
> Erratic errno is because this applet prints errno on partial write.
> 
> Oops is apparently because I did something wrong in do_fault yet.
> Seems, you were right telling that this place looks dubious. 8)

this is the strict fix:

diff -urN z/net/ipv4/tcp.c z1/net/ipv4/tcp.c
--- z/net/ipv4/tcp.c	Tue May  1 12:14:14 2001
+++ z1/net/ipv4/tcp.c	Tue May  1 12:12:35 2001
@@ -1184,7 +1184,7 @@
 do_fault:
 	if (skb->len==0) {
 		if (tp->send_head == skb) {
-			tp->send_head = skb->prev;
+			tp->send_head = skb->next;
 			if (tp->send_head == (struct sk_buff*)&sk->write_queue)
 				tp->send_head = NULL;
 		}


really the logic can be implemented more efficiently this way:

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

Andrea
