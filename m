Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319053AbSHMS0z>; Tue, 13 Aug 2002 14:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319104AbSHMS0z>; Tue, 13 Aug 2002 14:26:55 -0400
Received: from asie314yy33z9.bc.hsia.telus.net ([216.232.196.3]:4480 "EHLO
	saurus.asaurus.invalid") by vger.kernel.org with ESMTP
	id <S319053AbSHMS0x>; Tue, 13 Aug 2002 14:26:53 -0400
To: Olaf Dabrunz <Olaf.Dabrunz@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP/IP connection setup using ECN: interaction with firewall problems
References: <20020813021944.A11951@santana.vm.dabrunz.de>
From: Kevin Buhr <buhr@telus.net>
In-Reply-To: <20020813021944.A11951@santana.vm.dabrunz.de>
Message-ID: <87adnq8yly.fsf@saurus.asaurus.invalid>
Date: 13 Aug 2002 11:30:41 -0700
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Dabrunz <Olaf.Dabrunz@gmx.de> writes:
> 
> AFAICS from the kernel ChangeLogs Linux versions 2.4.* and 2.5.* do not
> implement the interoperability features described above. Is that correct?
> Is someone working on a patch that implements these features?

Olaf:

Here's a small patch I put together a while ago and have been using
with some success.  It implements *only* the SYN retransmission in the
"no reply" case (after a user-configurable number of lost SYN packets)
but won't help with the RST case.

It adds a new sysctl variable "tcp_ecn_retries".  The default value of
zero gives the old behaviour.  But, for example:

        echo 3 >/proc/sys/net/ipv4/tcp_ecn_retries

will retry with an ECN-disabled SYN after three unanswered ECN-enabled
SYNs (i.e., after a 20 second delay or so).  Of course, it doesn't
keep track of what hosts need this kluge.  Every new TCP connection to
a naughty host will be negotiated the same way with a long initial
delay.

The following patch is against 2.4.19-pre10-ac2.  I imagine it'll
apply cleanly to more recent kernels except for the index in
"sysctl.h".

I have my doubts about it (in other words, I really don't understand
enough about the network code to do it right), but after I got it
working for myself, I kind of lost interest.

Anyway, hope this helps.

Kevin Buhr <buhr@telus.net>

                        *       *       *

diff -ru linux-2.4.19-pre10-ac2/include/linux/sysctl.h linux-2.4.19-pre10-ac2-local/include/linux/sysctl.h
--- linux-2.4.19-pre10-ac2/include/linux/sysctl.h	Thu Jun  6 15:16:50 2002
+++ linux-2.4.19-pre10-ac2-local/include/linux/sysctl.h	Thu Jun  6 15:51:07 2002
@@ -298,7 +298,8 @@
 	NET_IPV4_NONLOCAL_BIND=88,
 	NET_IPV4_ICMP_RATELIMIT=89,
 	NET_IPV4_ICMP_RATEMASK=90,
-	NET_TCP_TW_REUSE=91
+	NET_TCP_TW_REUSE=91,
+	NET_IPV4_TCP_ECN_RETRIES=92,
 };
 
 enum {
diff -ru linux-2.4.19-pre10-ac2/include/net/tcp.h linux-2.4.19-pre10-ac2-local/include/net/tcp.h
--- linux-2.4.19-pre10-ac2/include/net/tcp.h	Thu Jun  6 15:16:02 2002
+++ linux-2.4.19-pre10-ac2-local/include/net/tcp.h	Thu Jun  6 15:51:08 2002
@@ -454,6 +454,7 @@
 extern int sysctl_tcp_fack;
 extern int sysctl_tcp_reordering;
 extern int sysctl_tcp_ecn;
+extern int sysctl_tcp_ecn_retries;
 extern int sysctl_tcp_dsack;
 extern int sysctl_tcp_mem[3];
 extern int sysctl_tcp_wmem[3];
diff -ru linux-2.4.19-pre10-ac2/include/net/tcp_ecn.h linux-2.4.19-pre10-ac2-local/include/net/tcp_ecn.h
--- linux-2.4.19-pre10-ac2/include/net/tcp_ecn.h	Fri Nov  2 17:43:26 2001
+++ linux-2.4.19-pre10-ac2-local/include/net/tcp_ecn.h	Thu Jun  6 15:42:48 2002
@@ -38,6 +38,12 @@
 }
 
 static __inline__ void
+TCP_ECN_noecn_syn(struct sk_buff *skb)
+{
+	TCP_SKB_CB(skb)->flags &= ~(TCPCB_FLAG_ECE|TCPCB_FLAG_CWR);
+}
+
+static __inline__ void
 TCP_ECN_make_synack(struct open_request *req, struct tcphdr *th)
 {
 	if (req->ecn_ok)
diff -ru linux-2.4.19-pre10-ac2/net/ipv4/sysctl_net_ipv4.c linux-2.4.19-pre10-ac2-local/net/ipv4/sysctl_net_ipv4.c
--- linux-2.4.19-pre10-ac2/net/ipv4/sysctl_net_ipv4.c	Thu Jun  6 15:16:03 2002
+++ linux-2.4.19-pre10-ac2-local/net/ipv4/sysctl_net_ipv4.c	Thu Jun  6 15:42:48 2002
@@ -203,6 +203,8 @@
 	 &sysctl_tcp_reordering, sizeof(int), 0644, NULL, &proc_dointvec},
 	{NET_TCP_ECN, "tcp_ecn",
 	 &sysctl_tcp_ecn, sizeof(int), 0644, NULL, &proc_dointvec},
+	{NET_IPV4_TCP_ECN_RETRIES, "tcp_ecn_retries",
+	 &sysctl_tcp_ecn_retries, sizeof(int), 0644, NULL, &proc_dointvec},
 	{NET_TCP_DSACK, "tcp_dsack",
 	 &sysctl_tcp_dsack, sizeof(int), 0644, NULL, &proc_dointvec},
 	{NET_TCP_MEM, "tcp_mem",
diff -ru linux-2.4.19-pre10-ac2/net/ipv4/tcp_timer.c linux-2.4.19-pre10-ac2-local/net/ipv4/tcp_timer.c
--- linux-2.4.19-pre10-ac2/net/ipv4/tcp_timer.c	Mon Oct  1 09:19:57 2001
+++ linux-2.4.19-pre10-ac2-local/net/ipv4/tcp_timer.c	Tue Aug 13 10:43:07 2002
@@ -30,6 +30,7 @@
 int sysctl_tcp_retries1 = TCP_RETR1;
 int sysctl_tcp_retries2 = TCP_RETR2;
 int sysctl_tcp_orphan_retries;
+int sysctl_tcp_ecn_retries;
 
 static void tcp_write_timer(unsigned long);
 static void tcp_delack_timer(unsigned long);
@@ -373,6 +374,11 @@
 	}
 
 	tcp_enter_loss(sk, 0);
+
+	/* If this is a SYN packet, retry with ECN disabled */
+	if (sk->state == TCP_SYN_SENT
+	    && sysctl_tcp_ecn_retries && tp->retransmits+1 >= sysctl_tcp_ecn_retries)
+		TCP_ECN_noecn_syn(skb_peek(&sk->write_queue));
 
 	if (tcp_retransmit_skb(sk, skb_peek(&sk->write_queue)) > 0) {
 		/* Retransmission failed because of local congestion,
