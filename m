Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752298AbWCKC1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298AbWCKC1e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 21:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752304AbWCKC1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 21:27:18 -0500
Received: from [198.78.49.142] ([198.78.49.142]:1029 "EHLO gitlost.site")
	by vger.kernel.org with ESMTP id S1752300AbWCKC1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 21:27:08 -0500
From: Chris Leech <christopher.leech@intel.com>
Subject: [PATCH 6/8] [I/OAT] Rename cleanup_rbuf to tcp_cleanup_rbuf and make non-static
Date: Fri, 10 Mar 2006 18:29:31 -0800
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-Id: <20060311022931.3950.41115.stgit@gitlost.site>
In-Reply-To: <20060311022759.3950.58788.stgit@gitlost.site>
References: <20060311022759.3950.58788.stgit@gitlost.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Needed to be able to call tcp_cleanup_rbuf in tcp_input.c for I/OAT

Signed-off-by: Chris Leech <christopher.leech@intel.com>
---

 include/net/tcp.h |    2 ++
 net/ipv4/tcp.c    |   10 +++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 610f66b..afc4b8a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -296,6 +296,8 @@ extern int			tcp_rcv_established(struct 
 
 extern void			tcp_rcv_space_adjust(struct sock *sk);
 
+extern void			tcp_cleanup_rbuf(struct sock *sk, int copied);
+
 extern int			tcp_twsk_unique(struct sock *sk,
 						struct sock *sktw, void *twp);
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 4b0272c..9122520 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -936,7 +936,7 @@ static int tcp_recv_urg(struct sock *sk,
  * calculation of whether or not we must ACK for the sake of
  * a window update.
  */
-static void cleanup_rbuf(struct sock *sk, int copied)
+void tcp_cleanup_rbuf(struct sock *sk, int copied)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	int time_to_ack = 0;
@@ -1085,7 +1085,7 @@ int tcp_read_sock(struct sock *sk, read_
 
 	/* Clean up data we have read: This will do ACK frames. */
 	if (copied)
-		cleanup_rbuf(sk, copied);
+		tcp_cleanup_rbuf(sk, copied);
 	return copied;
 }
 
@@ -1219,7 +1219,7 @@ int tcp_recvmsg(struct kiocb *iocb, stru
 			}
 		}
 
-		cleanup_rbuf(sk, copied);
+		tcp_cleanup_rbuf(sk, copied);
 
 		if (!sysctl_tcp_low_latency && tp->ucopy.task == user_recv) {
 			/* Install new reader */
@@ -1390,7 +1390,7 @@ skip_copy:
 	 */
 
 	/* Clean up data we have read: This will do ACK frames. */
-	cleanup_rbuf(sk, copied);
+	tcp_cleanup_rbuf(sk, copied);
 
 	TCP_CHECK_TIMER(sk);
 	release_sock(sk);
@@ -1852,7 +1852,7 @@ static int do_tcp_setsockopt(struct sock
 			    (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT) &&
 			    inet_csk_ack_scheduled(sk)) {
 				icsk->icsk_ack.pending |= ICSK_ACK_PUSHED;
-				cleanup_rbuf(sk, 1);
+				tcp_cleanup_rbuf(sk, 1);
 				if (!(val & 1))
 					icsk->icsk_ack.pingpong = 1;
 			}

