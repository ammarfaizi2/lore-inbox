Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130446AbRDJRjO>; Tue, 10 Apr 2001 13:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130485AbRDJRjA>; Tue, 10 Apr 2001 13:39:00 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:47632 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S130446AbRDJRiy>;
	Tue, 10 Apr 2001 13:38:54 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200104101738.VAA21467@ms2.inr.ac.ru>
Subject: Re: Bug report: tcp staled when send-q != 0, timers == 0.
To: berd@elf.ihep.su (Eugene B. Berdnikov)
Date: Tue, 10 Apr 2001 21:38:43 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org, davem@redhat.com (Dave Miller)
In-Reply-To: <20010409184338.B1396@elf.ihep.su> from "Eugene B. Berdnikov" at Apr 9, 1 06:43:38 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>  In brief: a stale state of the tcp send queue was observed for 2.2.17
>  while send-q counter and connection window sizes are not zero: 

I think I pinned down this. The patch is appended.


>  diagnostic, I'll try to get it. In any case, I plan to run something through
>  this connection in hope to reproduce this state again.

If my guess is right, you can easily put this socket to funny state
just catting a large file and kill -STOP'ing ssh. ssh will close window,
but sshd will not send zero probes. Any socket with keepalives enabled
enters this state after the first keepalive is sent.
[ Note, that it is not Butenko's problem, it is still to be discovered. 8) ]

I think you will not able to reproduce full problem: socket will revive
after the first received ACK. It is another bug and its probability is
astronomically low.

Alexey


--- linux/net/ipv4/tcp_input.c.orig	Mon Apr  9 22:46:56 2001
+++ linux/net/ipv4/tcp_input.c	Tue Apr 10 21:23:33 2001
@@ -733,8 +733,6 @@
 	if (tp->retransmits) {
 		if (tp->packets_out == 0) {
 			tp->retransmits = 0;
-			tp->fackets_out = 0;
-			tp->retrans_out = 0;
 			tp->backoff = 0;
 			tcp_set_rto(tp);
 		} else {
@@ -781,8 +779,10 @@
 	if(sk->zapped)
 		return(1);	/* Dead, can't ack any more so why bother */
 
-	if (tp->pending == TIME_KEEPOPEN)
+	if (tp->pending == TIME_KEEPOPEN) {
 	  	tp->probes_out = 0;
+		tp->pending = 0;
+	}
 
 	tp->rcv_tstamp = tcp_time_stamp;
 
@@ -850,8 +850,6 @@
 		if (tp->retransmits) {
 			if (tp->packets_out == 0) {
 				tp->retransmits = 0;
-				tp->fackets_out = 0;
-				tp->retrans_out = 0;
 			}
 		} else {
 			/* We don't have a timestamp. Can only use
@@ -878,6 +876,8 @@
 			tcp_ack_packets_out(sk, tp);
 	} else {
 		tcp_clear_xmit_timer(sk, TIME_RETRANS);
+		tp->fackets_out = 0;
+		tp->retrans_out = 0;
 	}
 
 	flag &= (FLAG_DATA | FLAG_WIN_UPDATE);
--- linux/net/ipv4/tcp_output.c.orig	Mon Apr  9 22:47:06 2001
+++ linux/net/ipv4/tcp_output.c	Tue Apr 10 21:23:33 2001
@@ -546,6 +546,8 @@
 		 */
 		kfree_skb(next_skb);
 		sk->tp_pinfo.af_tcp.packets_out--;
+		if (sk->tp_pinfo.af_tcp.fackets_out)
+			sk->tp_pinfo.af_tcp.fackets_out--;
 	}
 }
 
