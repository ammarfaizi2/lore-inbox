Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268890AbRG0RLU>; Fri, 27 Jul 2001 13:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268889AbRG0RLL>; Fri, 27 Jul 2001 13:11:11 -0400
Received: from e24.nc.us.ibm.com ([32.97.136.230]:14275 "EHLO
	e24.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267984AbRG0RLC>; Fri, 27 Jul 2001 13:11:02 -0400
Date: Fri, 27 Jul 2001 10:10:22 -0700 (PDT)
From: Sridhar Samudrala <samudrala@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        lartc@mailman.ds9a.nl, diffserv-general@lists.sourceforge.net,
        kuznet@ms2.inr.ac.ru, rusty@rustcorp.com.au
cc: samudrala@us.ibm.com
Subject: [PATCH] Inbound Connection Control mechanism: Prioritized Accept
 Queue
Message-ID: <Pine.LNX.4.21.0107270946420.14246-100000@w-sridhar2.des.sequent.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

The following patch provides a mechanism called Prioritized Accept Queues(PAQ)
to prioritize incoming connection requests on a socket based on the source/dest
ip addreses and ports.

For example, this feature can be used to guarantee low delay and high throughput
to preferred clients on a web server by assigning higher priority to connection
requests whose source ip address matches the ip address of the preferred clients.
It can also be used on a server hosting multiple websites each identified by its
own ip address. In this case the prioritization can be done based on the 
destination ip address of the connection requests.

The documentation on HOWTO use this patch and the test results which show an
improvement in connection rate for higher priority classes can be found at our
project website.
        http://oss.software.ibm.com/qos

We would appreciate any comments or suggestions.

Thanks
Sridhar

---------------------------
Sridhar Samudrala
IBM Linux Technology Centre
samudrala@us.ibm.com

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
diff -urN -X dontdiff linux-2.4.6/Documentation/Configure.help linux-2.4.6-paq/Documentation/Configure.help
--- linux-2.4.6/Documentation/Configure.help	Mon Jul  2 14:07:55 2001
+++ linux-2.4.6-paq/Documentation/Configure.help	Thu Jul  5 16:34:05 2001
@@ -1955,6 +1955,14 @@
   If you want to compile it as a module, say M here and read
   Documentation/modules.txt.  If unsure, say `N'.
 
+Prioritized Accept Queue (EXPERIMENTAL)
+CONFIG_PRIO_ACCEPTQ
+  When enabled, this option allows you to set priorities to incoming
+  connection requests using the rules created by the iptables MARK target
+  option. The nfmark field set by the rules is used as a priority value
+  when the connection is added to accept queue. The priority value can 
+  range between 0-7 with 0 being the highest priority and 7 the lowest. 
+  
 Packet filtering
 CONFIG_IP_NF_FILTER
   Packet filtering defines a table `filter', which has a series of
diff -urN -X dontdiff linux-2.4.6/include/net/sock.h linux-2.4.6-paq/include/net/sock.h
--- linux-2.4.6/include/net/sock.h	Tue Jul  3 15:44:12 2001
+++ linux-2.4.6-paq/include/net/sock.h	Thu Jul  5 16:45:31 2001
@@ -239,6 +239,11 @@
 #define pppoe_relay	proto.pppoe.relay
 #endif
 
+#ifdef CONFIG_PRIO_ACCEPTQ
+/* Priorities range from 0-7 */
+#define MAX_ACCEPTQ_PRIO        7
+#endif
+
 /* This defines a selective acknowledgement block. */
 struct tcp_sack_block {
 	__u32	start_seq;
@@ -409,7 +414,11 @@
 
 	/* FIFO of established children */
 	struct open_request	*accept_queue;
+#ifdef CONFIG_PRIO_ACCEPTQ
+	struct open_request     *accept_queue_tail[MAX_ACCEPTQ_PRIO];
+#else
 	struct open_request	*accept_queue_tail;
+#endif
 
 	int			write_pending;	/* A write to socket waits to start. */
 
diff -urN -X dontdiff linux-2.4.6/include/net/tcp.h linux-2.4.6-paq/include/net/tcp.h
--- linux-2.4.6/include/net/tcp.h	Tue Jul  3 15:44:20 2001
+++ linux-2.4.6-paq/include/net/tcp.h	Thu Jul  5 16:49:18 2001
@@ -519,6 +519,9 @@
 		struct tcp_v6_open_req v6_req;
 #endif
 	} af;
+#ifdef CONFIG_PRIO_ACCEPTQ
+	int acceptq_prio;
+#endif
 };
 
 /* SLAB cache for open requests. */
@@ -1566,10 +1569,33 @@
 					 struct sock *child)
 {
 	struct tcp_opt *tp = &sk->tp_pinfo.af_tcp;
+#ifdef CONFIG_PRIO_ACCEPTQ
+	int prio = req->acceptq_prio;
+	int prev_prio;
+#endif
 
 	req->sk = child;
 	tcp_acceptq_added(sk);
 
+#ifdef CONFIG_PRIO_ACCEPTQ
+	if (!tp->accept_queue_tail[prio]) {
+		for (prev_prio = prio - 1; prev_prio >= 0; prev_prio--)
+			if (tp->accept_queue_tail[prev_prio])
+				break;
+		tp->accept_queue_tail[prio] = req;
+		if (prev_prio >= 0) {
+			req->dl_next = tp->accept_queue_tail[prev_prio]->dl_next;
+			tp->accept_queue_tail[prev_prio]->dl_next = req; 
+		} else {
+			req->dl_next = tp->accept_queue;
+			tp->accept_queue = req;
+		}
+	} else {
+		req->dl_next = tp->accept_queue_tail[prio]->dl_next;
+		tp->accept_queue_tail[prio]->dl_next = req;
+		tp->accept_queue_tail[prio] = req;
+	}
+#else
 	if (!tp->accept_queue_tail) {
 		tp->accept_queue = req;
 	} else {
@@ -1577,6 +1603,7 @@
 	}
 	tp->accept_queue_tail = req;
 	req->dl_next = NULL;
+#endif
 }
 
 struct tcp_listen_opt
@@ -1643,6 +1670,10 @@
 					struct tcp_opt *tp,
 					struct sk_buff *skb)
 {
+#ifdef CONFIG_PRIO_ACCEPTQ
+	int nfmark = (int)skb->nfmark;
+#endif
+
 	req->rcv_wnd = 0;		/* So that tcp_send_synack() knows! */
 	req->rcv_isn = TCP_SKB_CB(skb)->seq;
 	req->mss = tp->mss_clamp;
@@ -1654,6 +1685,9 @@
 	req->acked = 0;
 	req->ecn_ok = 0;
 	req->rmt_port = skb->h.th->source;
+#ifdef CONFIG_PRIO_ACCEPTQ
+	req->acceptq_prio = (nfmark < 0) ? 0 : ((nfmark > MAX_ACCEPTQ_PRIO) ? MAX_ACCEPTQ_PRIO : nfmark);
+#endif
 }
 
 #define TCP_MEM_QUANTUM	((int)PAGE_SIZE)
diff -urN -X dontdiff linux-2.4.6/net/ipv4/netfilter/Config.in linux-2.4.6-paq/net/ipv4/netfilter/Config.in
--- linux-2.4.6/net/ipv4/netfilter/Config.in	Tue Mar  6 22:44:16 2001
+++ linux-2.4.6-paq/net/ipv4/netfilter/Config.in	Thu Jul  5 16:34:05 2001
@@ -27,6 +27,7 @@
   if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
     dep_tristate '  Unclean match support (EXPERIMENTAL)' CONFIG_IP_NF_MATCH_UNCLEAN $CONFIG_IP_NF_IPTABLES
     dep_tristate '  Owner match support (EXPERIMENTAL)' CONFIG_IP_NF_MATCH_OWNER $CONFIG_IP_NF_IPTABLES
+    bool '  Prioritized Accept Queues (EXPERIMENTAL)' CONFIG_PRIO_ACCEPTQ
   fi
 # The targets
   dep_tristate '  Packet filtering' CONFIG_IP_NF_FILTER $CONFIG_IP_NF_IPTABLES 
diff -urN -X dontdiff linux-2.4.6/net/ipv4/tcp.c linux-2.4.6-paq/net/ipv4/tcp.c
--- linux-2.4.6/net/ipv4/tcp.c	Wed May 16 10:31:27 2001
+++ linux-2.4.6-paq/net/ipv4/tcp.c	Thu Jul  5 16:34:05 2001
@@ -529,7 +529,12 @@
 
 	sk->max_ack_backlog = 0;
 	sk->ack_backlog = 0;
+#ifdef CONFIG_PRIO_ACCEPTQ
+	tp->accept_queue = NULL;
+	memset(tp->accept_queue_tail, 0, (sizeof(struct open_request *) * (MAX_ACCEPTQ_PRIO + 1)));
+#else
 	tp->accept_queue = tp->accept_queue_tail = NULL;
+#endif
 	tp->syn_wait_lock = RW_LOCK_UNLOCKED;
 	tcp_delack_init(tp);
 
@@ -588,7 +593,12 @@
 	write_lock_bh(&tp->syn_wait_lock);
 	tp->listen_opt =NULL;
 	write_unlock_bh(&tp->syn_wait_lock);
+#ifdef CONFIG_PRIO_ACCEPTQ
+	tp->accept_queue = NULL;
+	memset(tp->accept_queue_tail, 0, (sizeof(struct open_request *) * (MAX_ACCEPTQ_PRIO + 1)));
+#else
 	tp->accept_queue = tp->accept_queue_tail = NULL;
+#endif
 
 	if (lopt->qlen) {
 		for (i=0; i<TCP_SYNQ_HSIZE; i++) {
@@ -2109,6 +2119,9 @@
 	struct open_request *req;
 	struct sock *newsk;
 	int error;
+#ifdef CONFIG_PRIO_ACCEPTQ
+	int prio;
+#endif
 
 	lock_sock(sk); 
 
@@ -2134,8 +2147,17 @@
 	}
 
 	req = tp->accept_queue;
+#ifdef CONFIG_PRIO_ACCEPTQ
+	tp->accept_queue = req->dl_next;
+	for (prio = 0; prio <= MAX_ACCEPTQ_PRIO; prio++)
+		if (req == tp->accept_queue_tail[prio]) {
+			tp->accept_queue_tail[prio] = NULL;
+			break;
+		}
+#else
 	if ((tp->accept_queue = req->dl_next) == NULL)
 		tp->accept_queue_tail = NULL;
+#endif
 
  	newsk = req->sk;
 	tcp_acceptq_removed(sk);
diff -urN -X dontdiff linux-2.4.6/net/ipv4/tcp_minisocks.c linux-2.4.6-paq/net/ipv4/tcp_minisocks.c
--- linux-2.4.6/net/ipv4/tcp_minisocks.c	Thu Apr 12 12:11:39 2001
+++ linux-2.4.6-paq/net/ipv4/tcp_minisocks.c	Thu Jul  5 16:34:05 2001
@@ -733,7 +733,12 @@
 		newtp->num_sacks = 0;
 		newtp->urg_data = 0;
 		newtp->listen_opt = NULL;
+#ifdef CONFIG_PRIO_ACCEPTQ
+		newtp->accept_queue = NULL;
+		memset(newtp->accept_queue_tail, 0, (sizeof(struct open_request *) * (MAX_ACCEPTQ_PRIO + 1)));
+#else
 		newtp->accept_queue = newtp->accept_queue_tail = NULL;
+#endif
 		/* Deinitialize syn_wait_lock to trap illegal accesses. */
 		memset(&newtp->syn_wait_lock, 0, sizeof(newtp->syn_wait_lock));
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

