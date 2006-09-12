Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030231AbWILPvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbWILPvb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 11:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbWILPvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 11:51:25 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:824 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751445AbWILPvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 11:51:17 -0400
Message-Id: <20060912144905.201160000@chello.nl>
References: <20060912143049.278065000@chello.nl>
User-Agent: quilt/0.45-1
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       David Miller <davem@davemloft.net>, Rik van Riel <riel@redhat.com>,
       Daniel Phillips <phillips@google.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Mike Christie <michaelc@cs.wisc.edu>
Subject: [PATCH 20/20] iscsi: support for swapping over iSCSI.
Content-Disposition: inline; filename=iscsi_vmio.patch
Date: Tue, 12 Sep 2006 17:25:49 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement sht->swapdev() for iSCSI. This method takes care of reserving
the extra memory needed and marking all relevant sockets with SOCK_VMIO.

When used for swapping, TCP socket creation is done under GFP_MEMALLOC and
the TCP connect is done with SOCK_VMIO to ensure their success. Also the
netlink userspace interface is marked SOCK_VMIO, this will ensure that even
under pressure we can still communicate with the daemon (which runs as
mlockall() and needs no additional memory to operate).

Netlink requests are handled under the new PF_MEM_NOWAIT when a swapper is
present. This ensures that the netlink socket will not block. User-space will
need to retry failed requests.

The TCP receive path is handled under PF_MEMALLOC for SOCK_VMIO sockets.
This makes sure we do not block the critical socket, and that we do not
fail to process incomming data.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Mike Christie <michaelc@cs.wisc.edu>
---
 drivers/scsi/iscsi_tcp.c            |  103 +++++++++++++++++++++++++++++++-----
 drivers/scsi/scsi_transport_iscsi.c |   23 +++++++-
 include/scsi/libiscsi.h             |    1 
 include/scsi/scsi_transport_iscsi.h |    2 
 4 files changed, 113 insertions(+), 16 deletions(-)

Index: linux-2.6/drivers/scsi/iscsi_tcp.c
===================================================================
--- linux-2.6.orig/drivers/scsi/iscsi_tcp.c
+++ linux-2.6/drivers/scsi/iscsi_tcp.c
@@ -42,6 +42,7 @@
 #include <scsi/scsi_host.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_transport_iscsi.h>
+#include <scsi/scsi_device.h>
 
 #include "iscsi_tcp.h"
 
@@ -845,9 +846,13 @@ iscsi_tcp_data_recv(read_descriptor_t *r
 	int rc;
 	struct iscsi_conn *conn = rd_desc->arg.data;
 	struct iscsi_tcp_conn *tcp_conn = conn->dd_data;
-	int processed;
+	int processed = 0;
 	char pad[ISCSI_PAD_LEN];
 	struct scatterlist sg;
+	unsigned long pflags = current->flags;
+
+	if (sk_has_vmio(tcp_conn->sock->sk))
+		current->flags |= PF_MEMALLOC;
 
 	/*
 	 * Save current SKB and its offset in the corresponding
@@ -866,7 +871,7 @@ more:
 
 	if (unlikely(conn->suspend_rx)) {
 		debug_tcp("conn %d Rx suspended!\n", conn->id);
-		return 0;
+		goto out;
 	}
 
 	if (tcp_conn->in_progress == IN_PROGRESS_WAIT_HEADER ||
@@ -877,7 +882,7 @@ more:
 				goto nomore;
 		       else {
 				iscsi_conn_failure(conn, ISCSI_ERR_CONN_FAILED);
-				return 0;
+				goto out;
 		       }
 		}
 
@@ -891,7 +896,7 @@ more:
 			tcp_conn->in_progress = IN_PROGRESS_DATA_RECV;
 		} else if (rc) {
 			iscsi_conn_failure(conn, rc);
-			return 0;
+			goto out;
 		}
 	}
 
@@ -905,7 +910,7 @@ more:
 			if (rc == -EAGAIN)
 				goto again;
 			iscsi_conn_failure(conn, ISCSI_ERR_CONN_FAILED);
-			return 0;
+			goto out;
 		}
 
 		memcpy(&recv_digest, conn->data, sizeof(uint32_t));
@@ -914,7 +919,7 @@ more:
 				  "0x%x != 0x%x\n", recv_digest,
 				  tcp_conn->in.datadgst);
 			iscsi_conn_failure(conn, ISCSI_ERR_DATA_DGST);
-			return 0;
+			goto out;
 		} else {
 			debug_tcp("iscsi_tcp: data digest match!"
 				  "0x%x == 0x%x\n", recv_digest,
@@ -934,7 +939,7 @@ more:
 			if (rc == -EAGAIN)
 				goto again;
 			iscsi_conn_failure(conn, ISCSI_ERR_CONN_FAILED);
-			return 0;
+			goto out;
 		}
 		tcp_conn->in.copy -= tcp_conn->in.padding;
 		tcp_conn->in.offset += tcp_conn->in.padding;
@@ -969,6 +974,8 @@ more:
 nomore:
 	processed = tcp_conn->in.offset - offset;
 	BUG_ON(processed == 0);
+out:
+	current->flags = pflags;
 	return processed;
 
 again:
@@ -979,7 +986,7 @@ again:
 	BUG_ON(processed > len);
 
 	conn->rxdata_octets += processed;
-	return processed;
+	goto out;
 }
 
 static void
@@ -1735,14 +1742,26 @@ iscsi_tcp_ep_connect(struct iscsi_cls_se
 {
 	struct socket *sock;
 	int rc, size, arg = 1, window = 524288;
+	int swapper = 0;
+	unsigned long pflags = current->flags;
+
+	if (cls_session) {
+		struct iscsi_session *session;
+		session = class_to_transport_session(cls_session);
+		swapper = session->swapper;
+	}
+
+	if (swapper)
+		pflags |= PF_MEMALLOC;
 
 	rc = sock_create_kern(dst_addr->sa_family, SOCK_STREAM, IPPROTO_TCP,
 			      &sock);
 	if (rc < 0) {
 		printk(KERN_ERR "Could not create socket %d.\n", rc);
-		return rc;
+		goto out;
 	}
-	sock->sk->sk_allocation = GFP_ATOMIC;
+	sock->sk->sk_allocation = GFP_NOIO; // XXX GFP_ATOMIC;
+
 /*
 	rc = sock->ops->setsockopt(sock, IPPROTO_TCP, TCP_NODELAY,
 				   (char __user *)&arg, sizeof(arg));
@@ -1766,6 +1785,9 @@ iscsi_tcp_ep_connect(struct iscsi_cls_se
 		goto release_sock;
 	}
 
+	if (swapper)
+		sk_set_vmio(sock->sk);
+
 	/* TODO we cannot block here */
 	rc = sock->ops->connect(sock, (struct sockaddr *)dst_addr, size,
 				0 /*O_NONBLOCK*/);
@@ -1780,11 +1802,14 @@ iscsi_tcp_ep_connect(struct iscsi_cls_se
 	if (rc < 0)
 		goto release_sock;
 	*ep_handle = (uint64_t)rc;
-	return 0;
+	rc = 0;
+out:
+	current->flags = pflags;
+	return rc;
 
 release_sock:
 	sock_release(sock);
-	return rc;
+	goto out;
 }
 
 static int
@@ -1926,10 +1951,11 @@ iscsi_tcp_conn_bind(struct iscsi_cls_ses
 	sk = sock->sk;
 	sk->sk_reuse = 1;
 	sk->sk_sndtimeo = 15 * HZ; /* FIXME: make it configurable */
-	sk->sk_allocation = GFP_ATOMIC;
 
 	/* FIXME: disable Nagle's algorithm */
 
+	BUG_ON(!sk_has_vmio(sk) && conn->session->swapper);
+
 	/*
 	 * Intercept TCP callbacks for sendfile like receive
 	 * processing.
@@ -2187,6 +2213,56 @@ static void iscsi_tcp_session_destroy(st
 	iscsi_session_teardown(cls_session);
 }
 
+#define NETLINK_RESERVE_PAGES	(5 + 2 * (5 + 31))
+#define ISCSI_RESERVE_PAGES	(NETLINK_RESERVE_PAGES + TX_RESERVE_PAGES)
+
+static int iscsi_swapdev(struct scsi_device *sdev, int enable)
+{
+	int error = 0;
+	struct Scsi_Host *host;
+	struct iscsi_session *session;
+	struct iscsi_conn *conn;
+	struct sock *sk;
+	int daemon_pid;
+
+	host = sdev->host;
+	session = iscsi_hostdata(host->hostdata);
+	session->swapper = !!enable;
+	daemon_pid = iscsi_if_daemon_pid(session->tt);
+
+	if (enable) {
+		sk_adjust_memalloc(1, ISCSI_RESERVE_PAGES);
+		sk = netlink_lookup(NETLINK_ISCSI, 0);
+		if (sk)
+			sk_set_vmio(sk);
+		sk = netlink_lookup(NETLINK_ISCSI, daemon_pid);
+		if (sk)
+			sk_set_vmio(sk);
+	}
+
+	spin_lock(&session->lock);
+	list_for_each_entry(conn, &session->connections, item) {
+		struct iscsi_tcp_conn *tcp_conn = conn->dd_data;
+		if (enable)
+			sk_set_vmio(tcp_conn->sock->sk);
+		else
+			sk_clear_vmio(tcp_conn->sock->sk);
+	}
+	spin_unlock(&session->lock);
+
+	if (!enable) {
+		sk = netlink_lookup(NETLINK_ISCSI, daemon_pid);
+		if (sk)
+			sk_clear_vmio(sk);
+		sk = netlink_lookup(NETLINK_ISCSI, 0);
+		if (sk)
+			sk_clear_vmio(sk);
+		sk_adjust_memalloc(-1, -ISCSI_RESERVE_PAGES);
+	}
+
+	return error;
+}
+
 static struct scsi_host_template iscsi_sht = {
 	.name			= "iSCSI Initiator over TCP/IP",
 	.queuecommand           = iscsi_queuecommand,
@@ -2199,6 +2275,7 @@ static struct scsi_host_template iscsi_s
 	.use_clustering         = DISABLE_CLUSTERING,
 	.proc_name		= "iscsi_tcp",
 	.this_id		= -1,
+	.swapdev		= iscsi_swapdev,
 };
 
 static struct iscsi_transport iscsi_tcp_transport = {
Index: linux-2.6/include/scsi/libiscsi.h
===================================================================
--- linux-2.6.orig/include/scsi/libiscsi.h
+++ linux-2.6/include/scsi/libiscsi.h
@@ -245,6 +245,7 @@ struct iscsi_session {
 	int			mgmtpool_max;	/* size of mgmt array */
 	struct iscsi_mgmt_task	**mgmt_cmds;	/* Original mgmt arr */
 	struct iscsi_queue	mgmtpool;	/* Mgmt PDU's pool */
+	int			swapper;	/* we are used to swap on */
 };
 
 /*
Index: linux-2.6/drivers/scsi/scsi_transport_iscsi.c
===================================================================
--- linux-2.6.orig/drivers/scsi/scsi_transport_iscsi.c
+++ linux-2.6/drivers/scsi/scsi_transport_iscsi.c
@@ -496,6 +496,13 @@ iscsi_if_transport_lookup(struct iscsi_t
 	return NULL;
 }
 
+int iscsi_if_daemon_pid(struct iscsi_transport *tt)
+{
+	return iscsi_if_transport_lookup(tt)->daemon_pid;
+}
+
+EXPORT_SYMBOL_GPL(iscsi_if_daemon_pid);
+
 static int
 iscsi_broadcast_skb(struct sk_buff *skb, gfp_t gfp)
 {
@@ -608,7 +615,7 @@ iscsi_if_send_reply(int pid, int seq, in
 	int flags = multi ? NLM_F_MULTI : 0;
 	int t = done ? NLMSG_DONE : type;
 
-	skb = alloc_skb(len, GFP_KERNEL);
+	skb = alloc_skb(len, nls->sk_allocation);
 	/*
 	 * FIXME:
 	 * user is supposed to react on iferror == -ENOMEM;
@@ -970,6 +977,7 @@ iscsi_if_recv_msg(struct sk_buff *skb, s
 	struct iscsi_cls_session *session;
 	struct iscsi_cls_conn *conn;
 	unsigned long flags;
+	int pid;
 
 	priv = iscsi_if_transport_lookup(iscsi_ptr(ev->transport_handle));
 	if (!priv)
@@ -979,7 +987,15 @@ iscsi_if_recv_msg(struct sk_buff *skb, s
 	if (!try_module_get(transport->owner))
 		return -EINVAL;
 
-	priv->daemon_pid = NETLINK_CREDS(skb)->pid;
+	pid = NETLINK_CREDS(skb)->pid;
+	if (priv->daemon_pid > 0 && priv->daemon_pid != pid) {
+		if (sk_has_vmio(nls)) {
+			struct sock * sk = netlink_lookup(NETLINK_ISCSI, pid);
+			BUG_ON(!sk);
+			WARN_ON(!sk_set_vmio(sk));
+		}
+	}
+	priv->daemon_pid = pid;
 
 	switch (nlh->nlmsg_type) {
 	case ISCSI_UEVENT_CREATE_SESSION:
@@ -1094,7 +1110,10 @@ iscsi_if_rx(struct sock *sk, int len)
 			if (rlen > skb->len)
 				rlen = skb->len;
 
+			if (sk_has_vmio(sk))
+				current->flags |= PF_MEM_NOWAIT;
 			err = iscsi_if_recv_msg(skb, nlh);
+			current->flags &= ~PF_MEM_NOWAIT;
 			if (err) {
 				ev->type = ISCSI_KEVENT_IF_ERROR;
 				ev->iferror = err;
Index: linux-2.6/include/scsi/scsi_transport_iscsi.h
===================================================================
--- linux-2.6.orig/include/scsi/scsi_transport_iscsi.h
+++ linux-2.6/include/scsi/scsi_transport_iscsi.h
@@ -218,8 +218,8 @@ extern int iscsi_destroy_session(struct 
 extern struct iscsi_cls_conn *iscsi_create_conn(struct iscsi_cls_session *sess,
 					    uint32_t cid);
 extern int iscsi_destroy_conn(struct iscsi_cls_conn *conn);
+extern int iscsi_if_daemon_pid(struct iscsi_transport *tt);
 extern void iscsi_unblock_session(struct iscsi_cls_session *session);
 extern void iscsi_block_session(struct iscsi_cls_session *session);
 
-
 #endif

--

