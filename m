Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268030AbTBWErR>; Sat, 22 Feb 2003 23:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268032AbTBWErR>; Sat, 22 Feb 2003 23:47:17 -0500
Received: from asie314yy33z9.bc.hsia.telus.net ([216.232.196.3]:13187 "EHLO
	saurus.asaurus.invalid") by vger.kernel.org with ESMTP
	id <S268030AbTBWErP>; Sat, 22 Feb 2003 23:47:15 -0500
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC3168, section 6.1.1.1 - ECN and retransmit of SYN
References: <fa.lnpabmu.5sd1q@ifi.uio.no>
From: Kevin Buhr <buhr@telus.net>
In-Reply-To: <200302212013.h1LKD6Cu014437@turing-police.cc.vt.edu>
Date: 22 Feb 2003 20:57:22 -0800
Message-ID: <87lm07h9vx.fsf@saurus.asaurus.invalid>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu writes:
> 
> Supporting this would make using ECN a lot less painful - currently, if
> I want to use ECN by default, I get to turn it off anytime I find an ECN-hostile
> site that I'd like to communicate with.

You'll never get anyone to put anything "official" in the kernel, but
this is the patch I've been using against 2.4.{18,19,20} for a while.
It just adds a sysctl value that gives the number of SYNs to try
before clearing the ECN flags.  It doesn't memorize which hosts are
screwed up, so every connection to such a host results in a noticeable
delay.  Note that it will *not* work for those extremely braindead
firewalls that send back a RST in response to an ECN-enabled SYN
packet.

I combine this patch with an ECN blacklist of known bad hosts (using
straightforward netfilter mangling), and it works well for my
purposes.

The patch is against 2.4.20, and you'll need to echo a nonzero number
to tcp_ecn_retries, like so:

        echo 3 >/proc/sys/net/ipv4/tcp_ecn_retries

The 3 indicates that three ECN SYNs will be tried before the ECN flags
are cleared for the fourth SYN.  That gives a startup delay of about
30 seconds for every TCP connection to a screwed up host.

If your netfilter mark-and-mangle technique works, though, you may
find that more flexible.

Kevin Buhr <buhr@telus.net>

                        *       *       *

diff -ruN --exclude=*~ --exclude=*.orig linux-2.4.20-local/include/linux/sysctl.h linux-2.4.20-localx/include/linux/sysctl.h
--- linux-2.4.20-local/include/linux/sysctl.h	Fri Feb 21 16:19:41 2003
+++ linux-2.4.20-localx/include/linux/sysctl.h	Fri Feb 21 16:29:01 2003
@@ -292,7 +292,8 @@
 	NET_IPV4_NONLOCAL_BIND=88,
 	NET_IPV4_ICMP_RATELIMIT=89,
 	NET_IPV4_ICMP_RATEMASK=90,
-	NET_TCP_TW_REUSE=91
+	NET_TCP_TW_REUSE=91,
+	NET_IPV4_TCP_ECN_RETRIES=92
 };
 
 enum {
diff -ruN --exclude=*~ --exclude=*.orig linux-2.4.20-local/include/net/tcp.h linux-2.4.20-localx/include/net/tcp.h
--- linux-2.4.20-local/include/net/tcp.h	Fri Feb 21 16:19:41 2003
+++ linux-2.4.20-localx/include/net/tcp.h	Fri Feb 21 16:29:01 2003
@@ -453,6 +453,7 @@
 extern int sysctl_tcp_fack;
 extern int sysctl_tcp_reordering;
 extern int sysctl_tcp_ecn;
+extern int sysctl_tcp_ecn_retries;
 extern int sysctl_tcp_dsack;
 extern int sysctl_tcp_mem[3];
 extern int sysctl_tcp_wmem[3];
diff -ruN --exclude=*~ --exclude=*.orig linux-2.4.20-local/include/net/tcp_ecn.h linux-2.4.20-localx/include/net/tcp_ecn.h
--- linux-2.4.20-local/include/net/tcp_ecn.h	Fri Nov  2 17:43:26 2001
+++ linux-2.4.20-localx/include/net/tcp_ecn.h	Fri Feb 21 16:29:01 2003
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
diff -ruN --exclude=*~ --exclude=*.orig linux-2.4.20-local/net/ipv4/sysctl_net_ipv4.c linux-2.4.20-localx/net/ipv4/sysctl_net_ipv4.c
--- linux-2.4.20-local/net/ipv4/sysctl_net_ipv4.c	Thu Sep 12 12:19:11 2002
+++ linux-2.4.20-localx/net/ipv4/sysctl_net_ipv4.c	Fri Feb 21 16:29:01 2003
@@ -203,6 +203,8 @@
 	 &sysctl_tcp_reordering, sizeof(int), 0644, NULL, &proc_dointvec},
 	{NET_TCP_ECN, "tcp_ecn",
 	 &sysctl_tcp_ecn, sizeof(int), 0644, NULL, &proc_dointvec},
+	{NET_IPV4_TCP_ECN_RETRIES, "tcp_ecn_retries",
+	 &sysctl_tcp_ecn_retries, sizeof(int), 0644, NULL, &proc_dointvec},
 	{NET_TCP_DSACK, "tcp_dsack",
 	 &sysctl_tcp_dsack, sizeof(int), 0644, NULL, &proc_dointvec},
 	{NET_TCP_MEM, "tcp_mem",
diff -ruN --exclude=*~ --exclude=*.orig linux-2.4.20-local/net/ipv4/tcp_timer.c linux-2.4.20-localx/net/ipv4/tcp_timer.c
--- linux-2.4.20-local/net/ipv4/tcp_timer.c	Mon Oct  1 09:19:57 2001
+++ linux-2.4.20-localx/net/ipv4/tcp_timer.c	Fri Feb 21 16:29:01 2003
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
