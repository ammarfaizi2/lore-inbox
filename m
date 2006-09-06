Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbWIFNjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbWIFNjI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 09:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbWIFNjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 09:39:00 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:60405 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750907AbWIFNih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 09:38:37 -0400
Message-Id: <20060906133956.702168000@chello.nl>
References: <20060906131630.793619000@chello.nl>>
User-Agent: quilt/0.45-1
Date: Wed, 06 Sep 2006 15:16:51 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Mike Christie <michaelc@cs.wisc.edu>
Subject: [PATCH 21/21] iscsi: support for swapping over iSCSI.
Content-Disposition: inline; filename=iscsi_vmio.patch
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

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Mike Christie <michaelc@cs.wisc.edu>
---
 drivers/infiniband/ulp/iser/iscsi_iser.c |    2 
 drivers/scsi/iscsi_tcp.c                 |   93 ++++++++++++++++++++++++++++---
 drivers/scsi/libiscsi.c                  |   12 ++--
 drivers/scsi/scsi_transport_iscsi.c      |   41 ++++++++++---
 include/scsi/libiscsi.h                  |    5 +
 include/scsi/scsi_transport_iscsi.h      |    6 +-
 6 files changed, 129 insertions(+), 30 deletions(-)

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
 
@@ -436,6 +437,7 @@ iscsi_tcp_hdr_recv(struct iscsi_conn *co
 	struct iscsi_session *session = conn->session;
 	struct iscsi_tcp_conn *tcp_conn = conn->dd_data;
 	uint32_t cdgst, rdgst = 0, itt;
+	gfp_t gfp_mask = iscsi_gfp(tcp_conn->sock->sk->sk_allocation);
 
 	hdr = tcp_conn->in.hdr;
 
@@ -506,7 +508,7 @@ iscsi_tcp_hdr_recv(struct iscsi_conn *co
 			goto copy_hdr;
 
 		spin_lock(&session->lock);
-		rc = __iscsi_complete_pdu(conn, hdr, NULL, 0);
+		rc = __iscsi_complete_pdu(conn, hdr, NULL, 0, gfp_mask);
 		spin_unlock(&session->lock);
 		break;
 	case ISCSI_OP_R2T:
@@ -544,7 +546,7 @@ iscsi_tcp_hdr_recv(struct iscsi_conn *co
 	case ISCSI_OP_LOGOUT_RSP:
 	case ISCSI_OP_NOOP_IN:
 	case ISCSI_OP_SCSI_TMFUNC_RSP:
-		rc = iscsi_complete_pdu(conn, hdr, NULL, 0);
+		rc = iscsi_complete_pdu(conn, hdr, NULL, 0, gfp_mask);
 		break;
 	default:
 		rc = ISCSI_ERR_BAD_OPCODE;
@@ -705,6 +707,7 @@ static int iscsi_scsi_data_in(struct isc
 	struct scsi_cmnd *sc = ctask->sc;
 	struct scatterlist *sg;
 	int i, offset, rc = 0;
+	gfp_t gfp_mask = iscsi_gfp(tcp_conn->sock->sk->sk_allocation);
 
 	BUG_ON((void*)ctask != sc->SCp.ptr);
 
@@ -786,7 +789,7 @@ done:
 			   (long)sc, sc->result, ctask->itt,
 			   tcp_conn->in.hdr->flags);
 		spin_lock(&conn->session->lock);
-		__iscsi_complete_pdu(conn, tcp_conn->in.hdr, NULL, 0);
+		__iscsi_complete_pdu(conn, tcp_conn->in.hdr, NULL, 0, gfp_mask);
 		spin_unlock(&conn->session->lock);
 	}
 
@@ -798,6 +801,7 @@ iscsi_data_recv(struct iscsi_conn *conn)
 {
 	struct iscsi_tcp_conn *tcp_conn = conn->dd_data;
 	int rc = 0, opcode;
+	gfp_t gfp_mask = iscsi_gfp(tcp_conn->sock->sk->sk_allocation);
 
 	opcode = tcp_conn->in.hdr->opcode & ISCSI_OPCODE_MASK;
 	switch (opcode) {
@@ -819,7 +823,7 @@ iscsi_data_recv(struct iscsi_conn *conn)
 		}
 
 		rc = iscsi_complete_pdu(conn, tcp_conn->in.hdr, conn->data,
-					tcp_conn->in.datalen);
+					tcp_conn->in.datalen, gfp_mask);
 		if (!rc && conn->datadgst_en && opcode != ISCSI_OP_LOGIN_RSP)
 			iscsi_recv_digest_update(tcp_conn, conn->data,
 			  			tcp_conn->in.datalen);
@@ -1735,14 +1739,26 @@ iscsi_tcp_ep_connect(struct iscsi_cls_se
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
+	sock->sk->sk_allocation = GFP_ATOMIC; /* used from interrupt context */
+
 /*
 	rc = sock->ops->setsockopt(sock, IPPROTO_TCP, TCP_NODELAY,
 				   (char __user *)&arg, sizeof(arg));
@@ -1766,6 +1782,9 @@ iscsi_tcp_ep_connect(struct iscsi_cls_se
 		goto release_sock;
 	}
 
+	if (swapper)
+		sk_set_vmio(sock->sk);
+
 	/* TODO we cannot block here */
 	rc = sock->ops->connect(sock, (struct sockaddr *)dst_addr, size,
 				0 /*O_NONBLOCK*/);
@@ -1780,11 +1799,14 @@ iscsi_tcp_ep_connect(struct iscsi_cls_se
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
@@ -1926,10 +1948,11 @@ iscsi_tcp_conn_bind(struct iscsi_cls_ses
 	sk = sock->sk;
 	sk->sk_reuse = 1;
 	sk->sk_sndtimeo = 15 * HZ; /* FIXME: make it configurable */
-	sk->sk_allocation = GFP_ATOMIC;
 
 	/* FIXME: disable Nagle's algorithm */
 
+	BUG_ON(!sk_is_vmio(sk) && conn->session->swapper);
+
 	/*
 	 * Intercept TCP callbacks for sendfile like receive
 	 * processing.
@@ -2187,6 +2210,56 @@ static void iscsi_tcp_session_destroy(st
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
@@ -2199,6 +2272,7 @@ static struct scsi_host_template iscsi_s
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
@@ -297,9 +298,9 @@ extern void iscsi_prep_unsolicit_data_pd
 extern int iscsi_conn_send_pdu(struct iscsi_cls_conn *, struct iscsi_hdr *,
 				char *, uint32_t);
 extern int iscsi_complete_pdu(struct iscsi_conn *, struct iscsi_hdr *,
-			      char *, int);
+			      char *, int, gfp_t);
 extern int __iscsi_complete_pdu(struct iscsi_conn *, struct iscsi_hdr *,
-				char *, int);
+				char *, int, gfp_t);
 extern int iscsi_verify_itt(struct iscsi_conn *, struct iscsi_hdr *,
 			    uint32_t *);
 
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
@@ -527,7 +534,7 @@ iscsi_unicast_skb(struct sk_buff *skb, i
 }
 
 int iscsi_recv_pdu(struct iscsi_cls_conn *conn, struct iscsi_hdr *hdr,
-		   char *data, uint32_t data_size)
+		   char *data, uint32_t data_size, gfp_t gfp_mask)
 {
 	struct nlmsghdr	*nlh;
 	struct sk_buff *skb;
@@ -541,7 +548,7 @@ int iscsi_recv_pdu(struct iscsi_cls_conn
 	if (!priv)
 		return -EINVAL;
 
-	skb = alloc_skb(len, GFP_ATOMIC);
+	skb = alloc_skb(len, gfp_mask);
 	if (!skb) {
 		iscsi_conn_error(conn, ISCSI_ERR_CONN_FAILED);
 		dev_printk(KERN_ERR, &conn->dev, "iscsi: can not deliver "
@@ -576,7 +583,7 @@ void iscsi_conn_error(struct iscsi_cls_c
 	if (!priv)
 		return;
 
-	skb = alloc_skb(len, GFP_ATOMIC);
+	skb = alloc_skb(len, iscsi_gfp(nls->sk_allocation));
 	if (!skb) {
 		dev_printk(KERN_ERR, &conn->dev, "iscsi: gracefully ignored "
 			  "conn error (%d)\n", error);
@@ -591,7 +598,7 @@ void iscsi_conn_error(struct iscsi_cls_c
 	ev->r.connerror.cid = conn->cid;
 	ev->r.connerror.sid = iscsi_conn_get_sid(conn);
 
-	iscsi_broadcast_skb(skb, GFP_ATOMIC);
+	iscsi_broadcast_skb(skb, iscsi_gfp(nls->sk_allocation));
 
 	dev_printk(KERN_INFO, &conn->dev, "iscsi: detected conn error (%d)\n",
 		   error);
@@ -608,7 +615,7 @@ iscsi_if_send_reply(int pid, int seq, in
 	int flags = multi ? NLM_F_MULTI : 0;
 	int t = done ? NLMSG_DONE : type;
 
-	skb = alloc_skb(len, GFP_KERNEL);
+	skb = alloc_skb(len, iscsi_gfp(nls->sk_allocation));
 	/*
 	 * FIXME:
 	 * user is supposed to react on iferror == -ENOMEM;
@@ -649,7 +656,7 @@ iscsi_if_get_stats(struct iscsi_transpor
 	do {
 		int actual_size;
 
-		skbstat = alloc_skb(len, GFP_KERNEL);
+		skbstat = alloc_skb(len, iscsi_gfp(nls->sk_allocation));
 		if (!skbstat) {
 			dev_printk(KERN_ERR, &conn->dev, "iscsi: can not "
 				   "deliver stats: OOM\n");
@@ -711,7 +718,7 @@ int iscsi_if_destroy_session_done(struct
 	session = iscsi_dev_to_session(conn->dev.parent);
 	shost = iscsi_session_to_shost(session);
 
-	skb = alloc_skb(len, GFP_KERNEL);
+	skb = alloc_skb(len, iscsi_gfp(nls->sk_allocation));
 	if (!skb) {
 		dev_printk(KERN_ERR, &conn->dev, "Cannot notify userspace of "
 			  "session creation event\n");
@@ -729,7 +736,7 @@ int iscsi_if_destroy_session_done(struct
 	 * this will occur if the daemon is not up, so we just warn
 	 * the user and when the daemon is restarted it will handle it
 	 */
-	rc = iscsi_broadcast_skb(skb, GFP_KERNEL);
+	rc = iscsi_broadcast_skb(skb, iscsi_gfp(nls->sk_allocation));
 	if (rc < 0)
 		dev_printk(KERN_ERR, &conn->dev, "Cannot notify userspace of "
 			  "session destruction event. Check iscsi daemon\n");
@@ -772,7 +779,7 @@ int iscsi_if_create_session_done(struct 
 	session = iscsi_dev_to_session(conn->dev.parent);
 	shost = iscsi_session_to_shost(session);
 
-	skb = alloc_skb(len, GFP_KERNEL);
+	skb = alloc_skb(len, iscsi_gfp(nls->sk_allocation));
 	if (!skb) {
 		dev_printk(KERN_ERR, &conn->dev, "Cannot notify userspace of "
 			  "session creation event\n");
@@ -790,7 +797,7 @@ int iscsi_if_create_session_done(struct 
 	 * this will occur if the daemon is not up, so we just warn
 	 * the user and when the daemon is restarted it will handle it
 	 */
-	rc = iscsi_broadcast_skb(skb, GFP_KERNEL);
+	rc = iscsi_broadcast_skb(skb, iscsi_gfp(nls->sk_allocation));
 	if (rc < 0)
 		dev_printk(KERN_ERR, &conn->dev, "Cannot notify userspace of "
 			  "session creation event. Check iscsi daemon\n");
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
+		if (sk_is_vmio(nls)) {
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
 
+			if (sk_is_vmio(sk))
+				current->flags |= PF_MEM_NOWAIT;
 			err = iscsi_if_recv_msg(skb, nlh);
+			current->flags &= ~PF_MEM_NOWAIT;
 			if (err) {
 				ev->type = ISCSI_KEVENT_IF_ERROR;
 				ev->iferror = err;
Index: linux-2.6/drivers/scsi/libiscsi.c
===================================================================
--- linux-2.6.orig/drivers/scsi/libiscsi.c
+++ linux-2.6/drivers/scsi/libiscsi.c
@@ -359,7 +359,7 @@ static int iscsi_handle_reject(struct is
  * itt must have been called.
  */
 int __iscsi_complete_pdu(struct iscsi_conn *conn, struct iscsi_hdr *hdr,
-			 char *data, int datalen)
+			 char *data, int datalen, gfp_t gfp_mask)
 {
 	struct iscsi_session *session = conn->session;
 	int opcode = hdr->opcode & ISCSI_OPCODE_MASK, rc = 0;
@@ -424,7 +424,7 @@ int __iscsi_complete_pdu(struct iscsi_co
 			 * login related PDU's exp_statsn is handled in
 			 * userspace
 			 */
-			if (iscsi_recv_pdu(conn->cls_conn, hdr, data, datalen))
+			if (iscsi_recv_pdu(conn->cls_conn, hdr, data, datalen, gfp_mask))
 				rc = ISCSI_ERR_CONN_FAILED;
 			list_del(&mtask->running);
 			if (conn->login_mtask != mtask)
@@ -446,7 +446,7 @@ int __iscsi_complete_pdu(struct iscsi_co
 			}
 			conn->exp_statsn = be32_to_cpu(hdr->statsn) + 1;
 
-			if (iscsi_recv_pdu(conn->cls_conn, hdr, data, datalen))
+			if (iscsi_recv_pdu(conn->cls_conn, hdr, data, datalen, gfp_mask))
 				rc = ISCSI_ERR_CONN_FAILED;
 			list_del(&mtask->running);
 			if (conn->login_mtask != mtask)
@@ -473,7 +473,7 @@ int __iscsi_complete_pdu(struct iscsi_co
 			if (hdr->ttt == ISCSI_RESERVED_TAG)
 				break;
 
-			if (iscsi_recv_pdu(conn->cls_conn, hdr, NULL, 0))
+			if (iscsi_recv_pdu(conn->cls_conn, hdr, NULL, 0, gfp_mask))
 				rc = ISCSI_ERR_CONN_FAILED;
 			break;
 		case ISCSI_OP_REJECT:
@@ -497,12 +497,12 @@ done:
 EXPORT_SYMBOL_GPL(__iscsi_complete_pdu);
 
 int iscsi_complete_pdu(struct iscsi_conn *conn, struct iscsi_hdr *hdr,
-		       char *data, int datalen)
+		       char *data, int datalen, gfp_t gfp_mask)
 {
 	int rc;
 
 	spin_lock(&conn->session->lock);
-	rc = __iscsi_complete_pdu(conn, hdr, data, datalen);
+	rc = __iscsi_complete_pdu(conn, hdr, data, datalen, gfp_mask);
 	spin_unlock(&conn->session->lock);
 	return rc;
 }
Index: linux-2.6/include/scsi/scsi_transport_iscsi.h
===================================================================
--- linux-2.6.orig/include/scsi/scsi_transport_iscsi.h
+++ linux-2.6/include/scsi/scsi_transport_iscsi.h
@@ -140,7 +140,7 @@ extern int iscsi_unregister_transport(st
  */
 extern void iscsi_conn_error(struct iscsi_cls_conn *conn, enum iscsi_err error);
 extern int iscsi_recv_pdu(struct iscsi_cls_conn *conn, struct iscsi_hdr *hdr,
-			  char *data, uint32_t data_size);
+			  char *data, uint32_t data_size, gfp_t gfp_mask);
 
 
 /* Connection's states */
@@ -218,8 +218,12 @@ extern int iscsi_destroy_session(struct 
 extern struct iscsi_cls_conn *iscsi_create_conn(struct iscsi_cls_session *sess,
 					    uint32_t cid);
 extern int iscsi_destroy_conn(struct iscsi_cls_conn *conn);
+extern int iscsi_if_daemon_pid(struct iscsi_transport *tt);
 extern void iscsi_unblock_session(struct iscsi_cls_session *session);
 extern void iscsi_block_session(struct iscsi_cls_session *session);
 
+#define iscsi_gfp(gfp_mask) \
+	((in_interrupt() ? GFP_ATOMIC : GFP_NOIO) | \
+	 (gfp_mask & __GFP_EMERGENCY))
 
 #endif
Index: linux-2.6/drivers/infiniband/ulp/iser/iscsi_iser.c
===================================================================
--- linux-2.6.orig/drivers/infiniband/ulp/iser/iscsi_iser.c
+++ linux-2.6/drivers/infiniband/ulp/iser/iscsi_iser.c
@@ -114,7 +114,7 @@ iscsi_iser_recv(struct iscsi_conn *conn,
 	rc = iscsi_verify_itt(conn, hdr, &ret_itt);
 
 	if (!rc)
-		rc = iscsi_complete_pdu(conn, hdr, rx_data, rx_data_len);
+		rc = iscsi_complete_pdu(conn, hdr, rx_data, rx_data_len, GFP_NOIO);
 
 	if (rc && rc != ISCSI_ERR_NO_SCSI_CMD)
 		goto error;

--
