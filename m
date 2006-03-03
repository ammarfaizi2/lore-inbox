Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751558AbWCCVkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbWCCVkq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 16:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751523AbWCCVkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 16:40:32 -0500
Received: from [198.78.49.142] ([198.78.49.142]:52228 "EHLO gitlost.site")
	by vger.kernel.org with ESMTP id S1751510AbWCCVkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 16:40:24 -0500
From: Chris Leech <christopher.leech@intel.com>
Subject: [PATCH 6/8] [I/OAT] Rename cleanup_rbuf to tcp_cleanup_rbuf and make non-static
Date: Fri, 03 Mar 2006 13:42:32 -0800
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-Id: <20060303214231.11908.41047.stgit@gitlost.site>
In-Reply-To: <20060303214036.11908.10499.stgit@gitlost.site>
References: <20060303214036.11908.10499.stgit@gitlost.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Needed to be able to call tcp_cleanup_rbuf in tcp_input.c for I/OAT

Signed-off-by: Chris Leech <christopher.leech@intel.com>
---

 include/net/tcp.h |    2 ++
 net/ipv4/tcp.c    |   10 +++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index fd7c3e4..2fc7f05 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -295,6 +295,8 @@ extern int			tcp_rcv_established(struct 
 
 extern void			tcp_rcv_space_adjust(struct sock *sk);
 
+extern void			tcp_cleanup_rbuf(struct sock *sk, int copied);
+
 extern int			tcp_twsk_unique(struct sock *sk,
 						struct sock *sktw, void *twp);
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 00aa80e..13abfa2 100644
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
@@ -1856,7 +1856,7 @@ int tcp_setsockopt(struct sock *sk, int 
 			    (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT) &&
 			    inet_csk_ack_scheduled(sk)) {
 				icsk->icsk_ack.pending |= ICSK_ACK_PUSHED;
-				cleanup_rbuf(sk, 1);
+				tcp_cleanup_rbuf(sk, 1);
 				if (!(val & 1))
 					icsk->icsk_ack.pingpong = 1;
 			}

