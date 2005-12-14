Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbVLNJMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbVLNJMy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 04:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbVLNJMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 04:12:53 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:1216 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932242AbVLNJMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 04:12:46 -0500
Date: Wed, 14 Dec 2005 01:12:45 -0800 (PST)
From: Sridhar Samudrala <sri@us.ibm.com>
X-X-Sender: sridhar@w-sridhar.beaverton.ibm.com
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 2/3] TCP/IP Critical socket communication mechanism
Message-ID: <Pine.LNX.4.58.0512140049140.31720@w-sridhar.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When 'system_in_emergency' flag is set, drop any incoming packets that belong
to non-critical sockets as soon as can determine the destination socket. This
is necessary to prevent incoming non-critical packets to consume memory from
critical page pool.
-----------------------------------------------------------------------------

 include/net/sock.h  |   14 ++++++++++++++
 net/dccp/ipv4.c     |    4 ++++
 net/ipv4/tcp_ipv4.c |    3 +++
 net/ipv4/udp.c      |    9 ++++++++-
 net/ipv6/tcp_ipv6.c |    3 +++
 net/sctp/input.c    |    3 +++
 6 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 982b4ec..8de8a8b 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1391,4 +1391,18 @@ extern int sysctl_optmem_max;
 extern __u32 sysctl_wmem_default;
 extern __u32 sysctl_rmem_default;

+extern int system_in_emergency;
+
+static inline int emergency_check(struct sock *sk, struct sk_buff *skb)
+{
+	if (system_in_emergency && !(sk->sk_allocation & __GFP_CRITICAL)) {
+		if (net_ratelimit())
+			printk("discarding skb:%p len:%d sk:%p protocol:%d\n",
+                        	skb, skb->len, sk, sk->sk_protocol);
+		return 0;
+	}
+
+	return 1;
+}
+
 #endif	/* _SOCK_H */
diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index ca03521..405cdf8 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -1130,6 +1130,10 @@ int dccp_v4_rcv(struct sk_buff *skb)
 		goto no_dccp_socket;
 	}

+	if (!emergency_check(sk, skb)) {
+		goto discard_and_relse;
+	}
+
 	/*
 	 * Step 2:
 	 * 	... or S.state == TIMEWAIT,
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 4d5021e..acfb9a1 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1232,6 +1232,9 @@ int tcp_v4_rcv(struct sk_buff *skb)
 	if (!sk)
 		goto no_tcp_socket;

+	if (!emergency_check(sk, skb))
+		goto discard_and_relse;
+
 process:
 	if (sk->sk_state == TCP_TIME_WAIT)
 		goto do_time_wait;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 2422a5f..f79cbfd 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1150,7 +1150,14 @@ int udp_rcv(struct sk_buff *skb)
 	sk = udp_v4_lookup(saddr, uh->source, daddr, uh->dest, skb->dev->ifindex);

 	if (sk != NULL) {
-		int ret = udp_queue_rcv_skb(sk, skb);
+		int ret;
+
+		if (!emergency_check(sk, skb)) {
+			sock_put(sk);
+			goto drop;
+		} else
+			ret = udp_queue_rcv_skb(sk, skb);
+
 		sock_put(sk);

 		/* a return value > 0 means to resubmit the input, but
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 62c0e5b..d017181 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1592,6 +1592,9 @@ static int tcp_v6_rcv(struct sk_buff **p
 	if (!sk)
 		goto no_tcp_socket;

+	if (!emergency_check(sk, skb))
+		goto discard_and_relse;
+
 process:
 	if (sk->sk_state == TCP_TIME_WAIT)
 		goto do_time_wait;
diff --git a/net/sctp/input.c b/net/sctp/input.c
index b24ff2c..553365b 100644
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -181,6 +181,9 @@ int sctp_rcv(struct sk_buff *skb)
 	rcvr = asoc ? &asoc->base : &ep->base;
 	sk = rcvr->sk;

+	if (!emergency_check(sk, skb))
+		goto discard_it;
+
 	/*
 	 * If a frame arrives on an interface and the receiving socket is
 	 * bound to another interface, via SO_BINDTODEVICE, treat it as OOTB
