Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbWILP5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbWILP5M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 11:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWILP4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 11:56:13 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:36217 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751426AbWILPu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 11:50:59 -0400
Message-Id: <20060912144904.631458000@chello.nl>
References: <20060912143049.278065000@chello.nl>
User-Agent: quilt/0.45-1
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       David Miller <davem@davemloft.net>, Rik van Riel <riel@redhat.com>,
       Daniel Phillips <phillips@google.com>,
       Mike Christie <michaelc@cs.wisc.edu>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 15/20] iscsi: kernel side tcp connect
Content-Disposition: inline; filename=iscsi_ep_connect.patch
Date: Tue, 12 Sep 2006 17:25:49 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move tcp connection code from user- into kernel-space.
This makes it possible to do TCP reconnect deadlock free.

(This patch requires userspace changes too)

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 drivers/scsi/iscsi_tcp.c |  108 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 83 insertions(+), 25 deletions(-)

Index: linux-2.6/drivers/scsi/iscsi_tcp.c
===================================================================
--- linux-2.6.orig/drivers/scsi/iscsi_tcp.c	2006-09-07 16:00:16.000000000 +0200
+++ linux-2.6/drivers/scsi/iscsi_tcp.c	2006-09-07 19:32:56.000000000 +0200
@@ -35,6 +35,8 @@
 #include <linux/kfifo.h>
 #include <linux/scatterlist.h>
 #include <linux/mutex.h>
+#include <linux/syscalls.h>
+#include <linux/file.h>
 #include <net/tcp.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_host.h>
@@ -1062,21 +1064,6 @@ iscsi_conn_set_callbacks(struct iscsi_co
 	write_unlock_bh(&sk->sk_callback_lock);
 }
 
-static void
-iscsi_conn_restore_callbacks(struct iscsi_tcp_conn *tcp_conn)
-{
-	struct sock *sk = tcp_conn->sock->sk;
-
-	/* restore socket callbacks, see also: iscsi_conn_set_callbacks() */
-	write_lock_bh(&sk->sk_callback_lock);
-	sk->sk_user_data    = NULL;
-	sk->sk_data_ready   = tcp_conn->old_data_ready;
-	sk->sk_state_change = tcp_conn->old_state_change;
-	sk->sk_write_space  = tcp_conn->old_write_space;
-	sk->sk_no_check	 = 0;
-	write_unlock_bh(&sk->sk_callback_lock);
-}
-
 /**
  * iscsi_send - generic send routine
  * @sk: kernel's socket
@@ -1741,6 +1728,77 @@ iscsi_tcp_ctask_xmit(struct iscsi_conn *
 	return rc;
 }
 
+static int
+iscsi_tcp_ep_connect(struct sockaddr *dst_addr, int non_blocking,
+		     uint64_t *ep_handle)
+{
+	struct socket *sock;
+	int rc, size, arg = 1, window = 524288;
+
+	rc = sock_create_kern(dst_addr->sa_family, SOCK_STREAM, IPPROTO_TCP,
+			      &sock);
+	if (rc < 0) {
+		printk(KERN_ERR "Could not create socket %d.\n", rc);
+		return rc;
+	}
+	sock->sk->sk_allocation = GFP_ATOMIC;
+/*
+	rc = sock->ops->setsockopt(sock, IPPROTO_TCP, TCP_NODELAY,
+				   (char __user *)&arg, sizeof(arg));
+	if (rc) {
+		printk(KERN_ERR "Could not set TCP_NODELAY %d\n", rc);
+		goto release_sock;
+	}
+*/
+	/* should set like nfs */
+	sock_setsockopt(sock, SOL_SOCKET, SO_RCVBUF,
+			(char __user *)&window, sizeof(window));
+	sock_setsockopt(sock, SOL_SOCKET, SO_SNDBUF,
+			(char __user *)&window, sizeof(window));
+
+	if (dst_addr->sa_family == PF_INET)
+		size = sizeof(struct sockaddr_in);
+	else if (dst_addr->sa_family == PF_INET6)
+		size = sizeof(struct sockaddr_in6);
+	else {
+		rc = -EINVAL;
+		goto release_sock;
+	}
+
+	/* TODO we cannot block here */
+	rc = sock->ops->connect(sock, (struct sockaddr *)dst_addr, size,
+				0 /*O_NONBLOCK*/);
+	if (rc == -EINPROGRESS)
+		rc = 0;
+	else if (rc) {
+		printk(KERN_ERR "Could not connect %d\n", rc);
+		goto release_sock;
+	}
+
+	rc = sock_map_fd(sock);
+	if (rc < 0)
+		goto release_sock;
+	*ep_handle = (uint64_t)rc;
+	return 0;
+
+release_sock:
+	sock_release(sock);
+	return rc;
+}
+
+static int
+iscsi_tcp_ep_poll(uint64_t ep_handle, int timeout_ms)
+{
+	/* we cheated and blocked on the connect (TODO must fix) */
+	return 1;
+}
+
+static void
+iscsi_tcp_ep_disconnect(uint64_t ep_handle)
+{
+	sys_close(ep_handle);
+}
+
 static struct iscsi_cls_conn *
 iscsi_tcp_conn_create(struct iscsi_cls_session *cls_session, uint32_t conn_idx)
 {
@@ -1795,11 +1853,7 @@ iscsi_tcp_release_conn(struct iscsi_conn
 	if (!tcp_conn->sock)
 		return;
 
-	sock_hold(tcp_conn->sock->sk);
-	iscsi_conn_restore_callbacks(tcp_conn);
-	sock_put(tcp_conn->sock->sk);
-
-	sock_release(tcp_conn->sock);
+	fput(tcp_conn->sock->file);
 	tcp_conn->sock = NULL;
 	conn->recv_lock = NULL;
 }
@@ -1856,10 +1910,13 @@ iscsi_tcp_conn_bind(struct iscsi_cls_ses
 		printk(KERN_ERR "iscsi_tcp: sockfd_lookup failed %d\n", err);
 		return -EEXIST;
 	}
+	get_file(sock->file);
 
 	err = iscsi_conn_bind(cls_session, cls_conn, is_leading);
-	if (err)
+	if (err) {
+		fput(sock->file);
 		return err;
+	}
 
 	/* bind iSCSI connection and socket */
 	tcp_conn->sock = sock;
@@ -2041,13 +2098,11 @@ iscsi_tcp_conn_get_param(struct iscsi_cl
 		sk = tcp_conn->sock->sk;
 		if (sk->sk_family == PF_INET) {
 			inet = inet_sk(sk);
-			len = sprintf(buf, "%u.%u.%u.%u\n",
+			len = sprintf(buf, NIPQUAD_FMT "\n",
 				      NIPQUAD(inet->daddr));
 		} else {
 			np = inet6_sk(sk);
-			len = sprintf(buf,
-				"%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x\n",
-				NIP6(np->daddr));
+			len = sprintf(buf, NIP6_FMT "\n", NIP6(np->daddr));
 		}
 		mutex_unlock(&conn->xmitmutex);
 		break;
@@ -2185,6 +2240,9 @@ static struct iscsi_transport iscsi_tcp_
 	.get_session_param	= iscsi_session_get_param,
 	.start_conn		= iscsi_conn_start,
 	.stop_conn		= iscsi_tcp_conn_stop,
+	.ep_connect		= iscsi_tcp_ep_connect,
+	.ep_poll		= iscsi_tcp_ep_poll,
+	.ep_disconnect		= iscsi_tcp_ep_disconnect,
 	/* IO */
 	.send_pdu		= iscsi_conn_send_pdu,
 	.get_stats		= iscsi_conn_get_stats,

--

