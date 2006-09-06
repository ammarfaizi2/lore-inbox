Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbWIFNkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbWIFNkK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 09:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWIFNjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 09:39:54 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:14964 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750917AbWIFNif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 09:38:35 -0400
Message-Id: <20060906133955.513364000@chello.nl>
References: <20060906131630.793619000@chello.nl>>
User-Agent: quilt/0.45-1
Date: Wed, 06 Sep 2006 15:16:45 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       Mike Christie <michaelc@cs.wisc.edu>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 15/21] iscsi: kernel side tcp connect
Content-Disposition: inline; filename=iscsi_ep_connect.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move tcp connection code from user-space into kernel-space.
This makes it possible to reconnect deadlock free.

(This patch requires userspace changes too)

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 drivers/scsi/iscsi_tcp.c            |  128 +++++++++++++++++++++++-------------
 drivers/scsi/iscsi_tcp.h            |    2 
 drivers/scsi/libiscsi.c             |    6 -
 drivers/scsi/scsi_transport_iscsi.c |    4 -
 include/scsi/libiscsi.h             |    4 -
 include/scsi/scsi_transport_iscsi.h |    2 
 6 files changed, 93 insertions(+), 53 deletions(-)

Index: linux-2.6/drivers/scsi/iscsi_tcp.c
===================================================================
--- linux-2.6.orig/drivers/scsi/iscsi_tcp.c
+++ linux-2.6/drivers/scsi/iscsi_tcp.c
@@ -904,7 +904,7 @@ more:
 				goto again;
 			iscsi_conn_failure(conn, ISCSI_ERR_CONN_FAILED);
 			return 0;
-		}
+		}
 
 		memcpy(&recv_digest, conn->data, sizeof(uint32_t));
 		if (recv_digest != tcp_conn->in.datadgst) {
@@ -1062,21 +1062,6 @@ iscsi_conn_set_callbacks(struct iscsi_co
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
@@ -1304,7 +1289,7 @@ iscsi_tcp_cmd_init(struct iscsi_cmd_task
 		debug_scsi("cmd [itt 0x%x total %d imm_data %d "
 			   "unsol count %d, unsol offset %d]\n",
 			   ctask->itt, ctask->total_length, ctask->imm_count,
-			   ctask->unsol_count, ctask->unsol_offset);
+			   ctask->unsol_count, ctask->unsol_offset);
 	} else
 		tcp_ctask->xmstate = XMSTATE_R_HDR;
 
@@ -1455,7 +1440,7 @@ iscsi_send_padding(struct iscsi_conn *co
 	tcp_ctask->xmstate &= ~XMSTATE_W_PAD;
 	tcp_ctask->xmstate &= ~XMSTATE_W_RESEND_PAD;
 	debug_scsi("sending %d pad bytes for itt 0x%x\n",
-		   tcp_ctask->pad_count, ctask->itt);
+		   tcp_ctask->pad_count, ctask->itt);
 	rc = iscsi_sendpage(conn, &tcp_ctask->sendbuf, &tcp_ctask->pad_count,
 			   &sent);
 	if (rc) {
@@ -1484,7 +1469,7 @@ iscsi_send_digest(struct iscsi_conn *con
 		iscsi_buf_init_iov(buf, (char*)digest, 4);
 	}
 	tcp_ctask->xmstate &= ~XMSTATE_W_RESEND_DATA_DIGEST;
-
+
 	rc = iscsi_sendpage(conn, buf, &tcp_ctask->digest_count, &sent);
 	if (!rc)
 		debug_scsi("sent digest 0x%x for itt 0x%x\n", *digest,
@@ -1593,7 +1578,7 @@ send_hdr:
 		int start = tcp_ctask->sent;
 
 		rc = iscsi_send_data(ctask, &tcp_ctask->sendbuf, &tcp_ctask->sg,
-				     &tcp_ctask->sent, &ctask->data_count,
+				     &tcp_ctask->sent, &ctask->data_count,
 				     &dtask->digestbuf, &dtask->digest);
 		ctask->unsol_count -= tcp_ctask->sent - start;
 		if (rc)
@@ -1741,6 +1726,79 @@ iscsi_tcp_ctask_xmit(struct iscsi_conn *
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
+	*ep_handle = (uint64_t)(unsigned long)sock;
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
+	struct socket *sock;
+
+	sock = (struct socket *)(unsigned long)ep_handle;
+	if (!sock)
+		return;
+	sock_release(sock);
+}
+
 static struct iscsi_cls_conn *
 iscsi_tcp_conn_create(struct iscsi_cls_session *cls_session, uint32_t conn_idx)
 {
@@ -1788,23 +1846,6 @@ tcp_conn_alloc_fail:
 }
 
 static void
-iscsi_tcp_release_conn(struct iscsi_conn *conn)
-{
-	struct iscsi_tcp_conn *tcp_conn = conn->dd_data;
-
-	if (!tcp_conn->sock)
-		return;
-
-	sock_hold(tcp_conn->sock->sk);
-	iscsi_conn_restore_callbacks(tcp_conn);
-	sock_put(tcp_conn->sock->sk);
-
-	sock_release(tcp_conn->sock);
-	tcp_conn->sock = NULL;
-	conn->recv_lock = NULL;
-}
-
-static void
 iscsi_tcp_conn_destroy(struct iscsi_cls_conn *cls_conn)
 {
 	struct iscsi_conn *conn = cls_conn->dd_data;
@@ -1814,7 +1855,6 @@ iscsi_tcp_conn_destroy(struct iscsi_cls_
 	if (conn->hdrdgst_en || conn->datadgst_en)
 		digest = 1;
 
-	iscsi_tcp_release_conn(conn);
 	iscsi_conn_teardown(cls_conn);
 
 	/* now free tcp_conn */
@@ -1835,7 +1875,6 @@ iscsi_tcp_conn_stop(struct iscsi_cls_con
 	struct iscsi_tcp_conn *tcp_conn = conn->dd_data;
 
 	iscsi_conn_stop(cls_conn, flag);
-	iscsi_tcp_release_conn(conn);
 	tcp_conn->hdr_size = sizeof(struct iscsi_hdr);
 }
 
@@ -2041,13 +2080,11 @@ iscsi_tcp_conn_get_param(struct iscsi_cl
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
@@ -2185,6 +2222,9 @@ static struct iscsi_transport iscsi_tcp_
 	.get_session_param	= iscsi_session_get_param,
 	.start_conn		= iscsi_conn_start,
 	.stop_conn		= iscsi_tcp_conn_stop,
+	.ep_connect		= iscsi_tcp_ep_connect,
+	.ep_poll		= iscsi_tcp_ep_poll,
+	.ep_disconnect		= iscsi_tcp_ep_disconnect,
 	/* IO */
 	.send_pdu		= iscsi_conn_send_pdu,
 	.get_stats		= iscsi_conn_get_stats,
Index: linux-2.6/drivers/scsi/libiscsi.c
===================================================================
--- linux-2.6.orig/drivers/scsi/libiscsi.c
+++ linux-2.6/drivers/scsi/libiscsi.c
 struct iscsi_session *
 class_to_transport_session(struct iscsi_cls_session *cls_session)
@@ -1609,7 +1609,7 @@ int iscsi_conn_start(struct iscsi_cls_co
 		return -EPERM;
 	}
 
-	if ((session->imm_data_en || !session->initial_r2t_en) &&
+	if ((session->imm_data_en || !session->initial_r2t_en) &&
 	     session->first_burst > session->max_burst) {
 		printk("iscsi: invalid burst lengths: "
 		       "first_burst %d max_burst %d\n",
Index: linux-2.6/include/scsi/libiscsi.h
===================================================================
--- linux-2.6.orig/include/scsi/libiscsi.h
+++ linux-2.6/include/scsi/libiscsi.h
@@ -76,7 +76,7 @@ struct iscsi_mgmt_task {
 	 * Becuae LLDs allocate their hdr differently, this is a pointer to
 	 * that storage. It must be setup at session creation time.
 	 */
-	struct iscsi_hdr	*hdr;
+	struct iscsi_hdr	*hdr;
 	char			*data;		/* mgmt payload */
 	int			data_count;	/* counts data to be sent */
 	uint32_t		itt;		/* this ITT */

--
