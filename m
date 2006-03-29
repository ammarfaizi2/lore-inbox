Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWC2Wz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWC2Wz6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 17:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWC2Wz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 17:55:58 -0500
Received: from [198.78.49.142] ([198.78.49.142]:40965 "EHLO gitlost.site")
	by vger.kernel.org with ESMTP id S1751178AbWC2Ww4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 17:52:56 -0500
From: Chris Leech <christopher.leech@intel.com>
Subject: [PATCH 6/9] [I/OAT] Rename cleanup_rbuf to tcp_cleanup_rbuf and make non-static
Date: Wed, 29 Mar 2006 14:56:00 -0800
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-Id: <20060329225600.25585.82362.stgit@gitlost.site>
In-Reply-To: <20060329225505.25585.30392.stgit@gitlost.site>
References: <20060329225505.25585.30392.stgit@gitlost.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Needed to be able to call tcp_cleanup_rbuf in tcp_input.c for I/OAT

Signed-off-by: Chris Leech <christopher.leech@intel.com>
---

 include/net/tcp.h |    2 ++
 net/ipv4/tcp.c    |   10 +++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 54e4367..ca5bdaf 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -294,6 +294,8 @@ extern int			tcp_rcv_established(struct 
 
 extern void			tcp_rcv_space_adjust(struct sock *sk);
 
+extern void			tcp_cleanup_rbuf(struct sock *sk, int copied);
+
 extern int			tcp_twsk_unique(struct sock *sk,
 						struct sock *sktw, void *twp);
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 87f68e7..b10f78c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -937,7 +937,7 @@ static int tcp_recv_urg(struct sock *sk,
  * calculation of whether or not we must ACK for the sake of
  * a window update.
  */
-static void cleanup_rbuf(struct sock *sk, int copied)
+void tcp_cleanup_rbuf(struct sock *sk, int copied)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	int time_to_ack = 0;
@@ -1086,7 +1086,7 @@ int tcp_read_sock(struct sock *sk, read_
 
 	/* Clean up data we have read: This will do ACK frames. */
 	if (copied)
-		cleanup_rbuf(sk, copied);
+		tcp_cleanup_rbuf(sk, copied);
 	return copied;
 }
 
@@ -1220,7 +1220,7 @@ int tcp_recvmsg(struct kiocb *iocb, stru
 			}
 		}
 
-		cleanup_rbuf(sk, copied);
+		tcp_cleanup_rbuf(sk, copied);
 
 		if (!sysctl_tcp_low_latency && tp->ucopy.task == user_recv) {
 			/* Install new reader */
@@ -1391,7 +1391,7 @@ skip_copy:
 	 */
 
 	/* Clean up data we have read: This will do ACK frames. */
-	cleanup_rbuf(sk, copied);
+	tcp_cleanup_rbuf(sk, copied);
 
 	TCP_CHECK_TIMER(sk);
 	release_sock(sk);
@@ -1853,7 +1853,7 @@ static int do_tcp_setsockopt(struct sock
 			    (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT) &&
 			    inet_csk_ack_scheduled(sk)) {
 				icsk->icsk_ack.pending |= ICSK_ACK_PUSHED;
-				cleanup_rbuf(sk, 1);
+				tcp_cleanup_rbuf(sk, 1);
 				if (!(val & 1))
 					icsk->icsk_ack.pingpong = 1;
 			}

