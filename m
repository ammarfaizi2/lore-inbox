Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbVCGHQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbVCGHQV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 02:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbVCGHQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 02:16:20 -0500
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:21073 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261660AbVCGHFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 02:05:25 -0500
Message-ID: <422BFD13.1060908@yahoo.com>
Date: Sun, 06 Mar 2005 23:04:51 -0800
From: Alex Aizman <itn780@yahoo.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b) Gecko/20050217
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE 1/6] Open-iSCSI High-Performance Initiator for Linux
Content-Type: multipart/mixed;
 boundary="------------030602010001040304000502"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030602010001040304000502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

          SCSI LLDD consists of 3 files:
         - iscsi_if.c (iSCSI open interface over netlink);
         - iscsi_tcp.[ch] (iSCSI transport over TCP/IP).

         Signed-off-by: Alex Aizman <itn780@yahoo.com>
         Signed-off-by: Dmitry Yusupov <dmitry_yus@yahoo.com>








--------------030602010001040304000502
Content-Type: text/plain;
 name="open-iscsi-scsi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="open-iscsi-scsi.patch"

diff -Nru --exclude Kconfig --exclude Makefile linux-2.6.11.orig/drivers/scsi/iscsi_if.c linux-2.6.11.dima/drivers/scsi/iscsi_if.c
--- linux-2.6.11.orig/drivers/scsi/iscsi_if.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.11.dima/drivers/scsi/iscsi_if.c	2005-03-04 17:50:11.130414609 -0800
@@ -0,0 +1,257 @@
+/*
+ * iSCSI Initiator Kernel/User Interface
+ *
+ * Copyright (C) 2004 Dmitry Yusupov, Alex Aizman
+ * maintained by open-iscsi@googlegroups.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * See the file COPYING included with this distribution for more details.
+ */
+
+#include <linux/module.h>
+#include <net/tcp.h>
+#include <scsi/iscsi_if.h>
+#include <scsi/iscsi_ifev.h>
+
+MODULE_AUTHOR("Dmitry Yusupov <dmitry_yus@yahoo.com>, "
+	      "Alex Aizman <itn780@yahoo.com>");
+MODULE_DESCRIPTION("iSCSI Open Interface");
+MODULE_LICENSE("GPL");
+
+static struct iscsi_transport *transport_table[ISCSI_TRANSPORT_MAX];
+static struct sock *nls;
+static int daemon_pid;
+
+int
+iscsi_control_recv_pdu(iscsi_cnx_h cp_cnx, struct iscsi_hdr *hdr,
+				char *data, uint32_t data_size)
+{
+	struct nlmsghdr	*nlh;
+	struct sk_buff	*skb;
+	struct iscsi_uevent *ev;
+	char *pdu;
+	int len = NLMSG_SPACE(sizeof(*ev) + sizeof(struct iscsi_hdr) +
+			      data_size);
+
+	skb = alloc_skb(len, gfp_any());
+	if (!skb) {
+		return -ENOMEM;
+	}
+
+	nlh = __nlmsg_put(skb, daemon_pid, 0, 0, (len - sizeof(*nlh)));
+	ev = NLMSG_DATA(nlh);
+	memset(ev, 0, sizeof(*ev));
+	ev->transport_id = 0;
+	ev->type = ISCSI_KEVENT_RECV_PDU;
+	ev->r.recv_req.cnx_handle = cp_cnx;
+	pdu = (char*)ev + sizeof(*ev);
+	memcpy(pdu, hdr, sizeof(struct iscsi_hdr));
+	memcpy(pdu + sizeof(struct iscsi_hdr), data, data_size);
+	skb_get(skb);
+	netlink_unicast(nls, skb, daemon_pid, MSG_DONTWAIT);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iscsi_control_recv_pdu);
+
+void
+iscsi_control_cnx_error(iscsi_cnx_h cp_cnx, iscsi_err_e error)
+{
+	struct nlmsghdr	*nlh;
+	struct sk_buff	*skb;
+	struct iscsi_uevent *ev;
+	int len = NLMSG_SPACE(sizeof(*ev));
+
+	skb = alloc_skb(len, gfp_any());
+	if (!skb) {
+		return;
+	}
+
+	nlh = __nlmsg_put(skb, daemon_pid, 0, 0, (len - sizeof(*nlh)));
+	ev = NLMSG_DATA(nlh);
+	ev->transport_id = 0;
+	ev->type = ISCSI_KEVENT_CNX_ERROR;
+	ev->r.cnxerror.error = error;
+	ev->r.cnxerror.cnx_handle = cp_cnx;
+	skb_get(skb);
+	netlink_unicast(nls, skb, daemon_pid, MSG_DONTWAIT);
+}
+EXPORT_SYMBOL_GPL(iscsi_control_cnx_error);
+
+static struct iscsi_transport*
+iscsi_if_transport_lookup(int id)
+{
+	/* FIXME: implement transport's container */
+	if (id != 0)
+		return NULL;
+	return transport_table[id];
+}
+
+static int
+iscsi_if_send_reply(int pid, int seq, int type, int done, int multi,
+		      void *payload, int size)
+{
+	struct sk_buff	*skb;
+	struct nlmsghdr	*nlh;
+	int len = NLMSG_SPACE(size);
+	int flags = multi ? NLM_F_MULTI : 0;
+	int t = done ? NLMSG_DONE  : type;
+
+	skb = alloc_skb(len, GFP_KERNEL);
+	if (!skb) {
+		return -ENOMEM;
+	}
+
+	nlh = __nlmsg_put(skb, pid, seq, t, (len - sizeof(*nlh)));
+	nlh->nlmsg_flags = flags;
+	memcpy(NLMSG_DATA(nlh), payload, size);
+	netlink_unicast(nls, skb, pid, MSG_DONTWAIT);
+	return 0;
+}
+
+static int
+iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
+{
+	int err = 0;
+	struct iscsi_transport *transport;
+	struct iscsi_uevent *ev = NLMSG_DATA(nlh);
+
+	if ((transport = iscsi_if_transport_lookup(ev->transport_id)) == NULL)
+		return -EEXIST;
+
+	daemon_pid = NETLINK_CREDS(skb)->pid;
+
+	switch (nlh->nlmsg_type) {
+	case ISCSI_UEVENT_CREATE_SESSION:
+		ev->r.c_session_ret.handle = transport->create_session(
+		       ev->u.c_session.session_handle,
+		       ev->u.c_session.initial_cmdsn, &ev->r.c_session_ret.sid);
+		break;
+	case ISCSI_UEVENT_DESTROY_SESSION:
+		transport->destroy_session(
+			ev->u.d_session.session_handle);
+		break;
+	case ISCSI_UEVENT_CREATE_CNX:
+		ev->r.handle = transport->create_cnx(
+			ev->u.c_cnx.session_handle,
+			ev->u.c_cnx.cnx_handle,
+			ev->u.c_cnx.cid);
+		break;
+	case ISCSI_UEVENT_DESTROY_CNX:
+		transport->destroy_cnx(ev->u.d_cnx.cnx_handle);
+		break;
+	case ISCSI_UEVENT_BIND_CNX:
+		ev->r.retcode = transport->bind_cnx(
+			ev->u.b_cnx.session_handle,
+			ev->u.b_cnx.cnx_handle,
+			ev->u.b_cnx.transport_fd,
+			ev->u.b_cnx.is_leading);
+		break;
+	case ISCSI_UEVENT_SET_PARAM:
+		ev->r.retcode = transport->set_param(
+			ev->u.set_param.cnx_handle,
+			ev->u.set_param.param, ev->u.set_param.value);
+		break;
+	case ISCSI_UEVENT_START_CNX:
+		ev->r.retcode = transport->start_cnx(
+			ev->u.start_cnx.cnx_handle);
+		break;
+	case ISCSI_UEVENT_STOP_CNX:
+		transport->stop_cnx(
+			ev->u.stop_cnx.cnx_handle);
+		break;
+	case ISCSI_UEVENT_SEND_PDU:
+		ev->r.retcode = transport->send_pdu(
+		       ev->u.send_pdu.cnx_handle,
+		       (struct iscsi_hdr*)((char*)ev + sizeof(*ev)),
+		       (char*)ev + sizeof(*ev) + ev->u.send_pdu.hdr_size,
+			ev->u.send_pdu.data_size);
+		break;
+	default:
+		err = -EINVAL;
+		break;
+	}
+
+	return err;
+}
+
+/* Get message from skb (based on rtnetlink_rcv_skb).  Each message is
+ * processed by iscsi_if_recv_msg.  Malformed skbs with wrong length are
+ * discarded silently.  */
+static void
+iscsi_if_rx(struct sock *sk, int len)
+{
+	struct sk_buff *skb;
+	while ((skb = skb_dequeue(&sk->sk_receive_queue)) != NULL) {
+		while (skb->len >= NLMSG_SPACE(0)) {
+			int err;
+			uint32_t rlen;
+			struct nlmsghdr	*nlh;
+
+			nlh = (struct nlmsghdr *)skb->data;
+			if (nlh->nlmsg_len < sizeof(*nlh) ||
+			    skb->len < nlh->nlmsg_len) {
+				break;
+			}
+			rlen = NLMSG_ALIGN(nlh->nlmsg_len);
+			if (rlen > skb->len)
+				rlen = skb->len;
+			err = iscsi_if_recv_msg(skb, nlh);
+			if (err) {
+				netlink_ack(skb, nlh, -err);
+			} else {
+				u32 seq  = nlh->nlmsg_seq;
+				u32 pid  = NETLINK_CREDS(skb)->pid;
+				struct iscsi_uevent *ev = NLMSG_DATA(nlh);
+				err = iscsi_if_send_reply(pid, seq,
+					nlh->nlmsg_type, 0, 0, ev, sizeof(*ev));
+				if (err)
+					netlink_ack(skb, nlh, -err);
+			}
+			skb_pull(skb, rlen);
+		}
+		kfree_skb(skb);
+	}
+}
+
+int iscsi_register_transport(struct iscsi_transport *ops, int id)
+{
+	transport_table[id] = ops;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iscsi_register_transport);
+
+void iscsi_unregister_transport(int id)
+{
+	transport_table[id] = NULL;
+}
+EXPORT_SYMBOL_GPL(iscsi_unregister_transport);
+
+int __init iscsi_if_init(void)
+{
+	printk(KERN_INFO "Open-iSCSI Interface, version "
+			ISCSI_VERSION_STR " variant (" ISCSI_DATE_STR ")\n");
+
+	nls = netlink_kernel_create(NETLINK_ISCSI, iscsi_if_rx);
+	if (nls == NULL)
+		return -ENOBUFS;
+
+	return 0;
+}
+
+static void __exit
+iscsi_if_exit(void)
+{
+	sock_release(nls->sk_socket);
+}
+
+module_init(iscsi_if_init);
+module_exit(iscsi_if_exit);
diff -Nru --exclude Kconfig --exclude Makefile linux-2.6.11.orig/drivers/scsi/iscsi_tcp.c linux-2.6.11.dima/drivers/scsi/iscsi_tcp.c
--- linux-2.6.11.orig/drivers/scsi/iscsi_tcp.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.11.dima/drivers/scsi/iscsi_tcp.c	2005-03-04 17:50:11.131414493 -0800
@@ -0,0 +1,2669 @@
+/*
+ * iSCSI Initiator over TCP/IP Data-Path
+ *
+ * Copyright (C) 2004 Dmitry Yusupov, Alex Aizman
+ * maintained by open-iscsi@googlegroups.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * See the file COPYING included with this distribution for more details.
+ *
+ * Credits:
+ * Christoph Hellwig	: For reviewing the code, for comments and suggestions.
+ * Mike Christie	: For reviewing the code, for comments and suggestions.
+ */
+
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/inet.h>
+#include <linux/blkdev.h>
+#include <linux/crypto.h>
+#include <linux/delay.h>
+#include <linux/kfifo.h>
+#include <linux/scatterlist.h>
+#include <net/tcp.h>
+#include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_device.h>
+#include <scsi/scsi_eh.h>
+#include <scsi/scsi_request.h>
+#include <scsi/scsi_tcq.h>
+#include <scsi/scsi_host.h>
+#include <scsi/scsi.h>
+
+#include "iscsi_tcp.h"
+
+MODULE_AUTHOR("Dmitry Yusupov <dmitry_yus@yahoo.com>, "
+	      "Alex Aizman <itn780@yahoo.com>");
+MODULE_DESCRIPTION("iSCSI/TCP data-path");
+MODULE_LICENSE("GPL");
+
+/* #define DEBUG_TCP */
+/* #define DEBUG_SCSI */
+/* #define DEBUG_ASSERT */
+
+#ifdef DEBUG_TCP
+#define debug_tcp(fmt...) printk("tcp: " fmt)
+#else
+#define debug_tcp(fmt...)
+#endif
+
+#ifdef DEBUG_SCSI
+#define debug_scsi(fmt...) printk("scsi: " fmt)
+#else
+#define debug_scsi(fmt...)
+#endif
+
+#ifndef DEBUG_ASSERT
+#ifdef BUG_ON
+#undef BUG_ON
+#endif
+#define BUG_ON(expr)
+#endif
+
+/* global data */
+static kmem_cache_t *taskcache;
+
+static inline void
+iscsi_buf_init_virt(struct iscsi_buf *ibuf, char *vbuf, int size)
+{
+	sg_init_one(&ibuf->sg, (u8 *)vbuf, size);
+	ibuf->sent = 0;
+}
+
+static inline void
+iscsi_buf_init_sg(struct iscsi_buf *ibuf, struct scatterlist *sg)
+{
+	ibuf->sg.page = sg->page;
+	ibuf->sg.offset = sg->offset;
+	ibuf->sg.length = sg->length;
+	ibuf->sent = 0;
+}
+
+static inline int
+iscsi_buf_left(struct iscsi_buf *ibuf)
+{
+	int rc;
+
+	rc = ibuf->sg.length - ibuf->sent;
+	BUG_ON(rc < 0);
+	return rc;
+}
+
+static inline void
+iscsi_buf_init_hdr(struct iscsi_conn *conn, struct iscsi_buf *ibuf,
+		   char *vbuf, u8 *crc)
+{
+	iscsi_buf_init_virt(ibuf, vbuf, sizeof(struct iscsi_hdr));
+	if (conn->hdrdgst_en) {
+		crypto_digest_init(conn->tx_tfm);
+		crypto_digest_update(conn->tx_tfm, &ibuf->sg, 1);
+		crypto_digest_final(conn->tx_tfm, crc);
+		ibuf->sg.length += sizeof(uint32_t);
+	}
+}
+
+#define iscsi_conn_get(rdd) (struct iscsi_conn*)(rdd)->arg.data
+#define iscsi_conn_set(rdd, conn) (rdd)->arg.data = conn
+
+static int
+iscsi_hdr_extract(struct iscsi_conn *conn)
+{
+	struct sk_buff *skb = conn->in.skb;
+
+	if (conn->in.copy >= conn->hdr_size &&
+	    conn->in_progress != IN_PROGRESS_HEADER_GATHER) {
+		/*
+		 * Zero-copy PDU Header: using connection context
+		 * to store header pointer.
+		 */
+		if (skb_shinfo(skb)->frag_list == NULL &&
+		    !skb_shinfo(skb)->nr_frags) {
+			conn->in.hdr = (struct iscsi_hdr *)
+				((char*)skb->data + conn->in.offset);
+		} else {
+			/* ignoring return code since we checked
+			 * in.copy before */
+			skb_copy_bits(skb, conn->in.offset,
+				&conn->hdr, conn->hdr_size);
+			conn->in.hdr = &conn->hdr;
+		}
+		conn->in.offset += conn->hdr_size;
+		conn->in.copy -= conn->hdr_size;
+		conn->in.hdr_offset = 0;
+	} else {
+		int copylen;
+
+		/*
+		 * PDU header scattered accross SKB's,
+		 * copying it... This'll happen quite rarely.
+		 */
+		if (conn->in_progress == IN_PROGRESS_WAIT_HEADER) {
+			skb_copy_bits(skb, conn->in.offset,
+				&conn->hdr, conn->in.copy);
+			conn->in_progress = IN_PROGRESS_HEADER_GATHER;
+			conn->in.hdr_offset = conn->in.copy;
+			conn->in.offset += conn->in.copy;
+			conn->in.copy = 0;
+			debug_tcp("PDU gather #1 %d bytes!\n",
+			       conn->in.hdr_offset);
+			return -EAGAIN;
+		}
+
+		copylen = conn->hdr_size - conn->in.hdr_offset;
+		if (copylen > conn->in.copy) {
+			printk("iSCSI: PDU gather failed! "
+			       "copylen %d conn->in.copy %d\n",
+			       copylen, conn->in.copy);
+			iscsi_control_cnx_error(conn->handle,
+						ISCSI_ERR_CNX_FAILED);
+			return 0;
+		}
+		debug_tcp("PDU gather #2 %d bytes!\n", copylen);
+
+		skb_copy_bits(skb, conn->in.offset,
+		    (char*)&conn->hdr + conn->in.hdr_offset, copylen);
+		conn->in.offset += copylen;
+		conn->in.copy -= copylen;
+		conn->in.hdr_offset = 0;
+		conn->in.hdr = &conn->hdr;
+		conn->in_progress = IN_PROGRESS_WAIT_HEADER;
+	}
+
+	return 0;
+}
+
+static void
+iscsi_ctask_cleanup(struct iscsi_conn *conn, struct iscsi_cmd_task *ctask)
+{
+	struct scsi_cmnd *sc = ctask->sc;
+	struct iscsi_session *session = conn->session;
+
+	spin_lock(&session->lock);
+	if (ctask->in_progress == IN_PROGRESS_IDLE) {
+		spin_unlock(&session->lock);
+		return;
+	}
+	if (sc->sc_data_direction == DMA_TO_DEVICE) {
+		struct iscsi_data_task *dtask, *n;
+		/* WRITE: cleanup Data-Out's if any */
+		spin_lock(&conn->lock);
+		list_for_each_entry_safe(dtask, n, &ctask->dataqueue, item) {
+			list_del(&dtask->item);
+			mempool_free(dtask, ctask->datapool);
+		}
+		spin_unlock(&conn->lock);
+	}
+	ctask->in_progress = IN_PROGRESS_IDLE;
+	__kfifo_put(session->cmdpool.queue, (void*)&ctask, sizeof(void*));
+	spin_unlock(&session->lock);
+}
+
+/*
+ * SCSI Command Response processing
+ */
+static int
+iscsi_cmd_rsp(struct iscsi_conn *conn, struct iscsi_cmd_task *ctask)
+{
+	int rc = 0;
+	struct iscsi_cmd_rsp *rhdr = (struct iscsi_cmd_rsp *)conn->in.hdr;
+	struct iscsi_session *session = conn->session;
+	struct scsi_cmnd *sc = ctask->sc;
+	int max_cmdsn = ntohl(rhdr->max_cmdsn);
+	int exp_cmdsn = ntohl(rhdr->exp_cmdsn);
+
+	if (max_cmdsn < exp_cmdsn - 1) {
+		rc = ISCSI_ERR_MAX_CMDSN;
+		sc->result = (DID_ERROR << 16);
+		goto fault;
+	}
+	session->max_cmdsn = max_cmdsn;
+	session->exp_cmdsn = exp_cmdsn;
+	conn->exp_statsn = ntohl(rhdr->statsn) + 1;
+
+	sc->result = (DID_OK << 16) | rhdr->cmd_status;
+
+	if (rhdr->response == ISCSI_STATUS_CMD_COMPLETED) {
+		if (rhdr->cmd_status == SAM_STAT_CHECK_CONDITION &&
+		    conn->senselen) {
+			int sensecopy = min(conn->senselen,
+					    SCSI_SENSE_BUFFERSIZE);
+			memcpy(sc->sense_buffer, conn->data + 2, sensecopy);
+			debug_scsi("copied %d bytes of sense\n", sensecopy);
+		}
+
+		if (sc->sc_data_direction != DMA_TO_DEVICE ) {
+			if (rhdr->flags & ISCSI_FLAG_CMD_UNDERFLOW) {
+				int res_count = ntohl(rhdr->residual_count);
+				if (res_count > 0 &&
+				    res_count <= sc->request_bufflen) {
+					sc->resid = res_count;
+				} else {
+					sc->result = (DID_BAD_TARGET << 16) |
+						     rhdr->cmd_status;
+					rc = ISCSI_ERR_BAD_TARGET;
+					goto fault;
+				}
+			} else if (rhdr->flags& ISCSI_FLAG_CMD_BIDI_UNDERFLOW) {
+				sc->result = (DID_BAD_TARGET << 16) |
+					     rhdr->cmd_status;
+				rc = ISCSI_ERR_BAD_TARGET;
+				goto fault;
+			} else if (rhdr->flags & ISCSI_FLAG_CMD_OVERFLOW) {
+				sc->resid = ntohl(rhdr->residual_count);
+			}
+		}
+	} else {
+		sc->result = (DID_ERROR << 16);
+		rc = ISCSI_ERR_BAD_TARGET;
+		goto fault;
+	}
+
+fault:
+	debug_scsi("done [sc %lx res %d itt 0x%x]\n",
+		   (long)sc, sc->result, ctask->itt);
+	iscsi_ctask_cleanup(conn, ctask);
+	sc->scsi_done(sc);
+	return rc;
+}
+
+/*
+ * SCSI Data-In Response processing
+ */
+static int
+iscsi_data_rsp(struct iscsi_conn *conn, struct iscsi_cmd_task *ctask)
+{
+	struct iscsi_data_rsp *rhdr = (struct iscsi_data_rsp *)conn->in.hdr;
+	struct iscsi_session *session = conn->session;
+	int datasn = ntohl(rhdr->datasn);
+	int max_cmdsn = ntohl(rhdr->max_cmdsn);
+	int exp_cmdsn = ntohl(rhdr->exp_cmdsn);
+
+	/*
+	 * setup Data-In byte counter (gets decremented..)
+	 */
+	ctask->data_count = conn->in.datalen;
+
+	if (conn->in.datalen == 0)
+		return 0;
+
+	if (max_cmdsn < exp_cmdsn -1)
+		return ISCSI_ERR_MAX_CMDSN;
+
+	session->max_cmdsn = max_cmdsn;
+	session->exp_cmdsn = exp_cmdsn;
+
+	if (ctask->datasn != datasn)
+		return ISCSI_ERR_DATASN;
+
+	ctask->datasn++;
+
+	ctask->data_offset = ntohl(rhdr->offset);
+	if (ctask->data_offset + conn->in.datalen > ctask->total_length) {
+		return ISCSI_ERR_DATA_OFFSET;
+	}
+
+	if (rhdr->flags & ISCSI_FLAG_DATA_STATUS) {
+		struct scsi_cmnd *sc = ctask->sc;
+		conn->exp_statsn = ntohl(rhdr->statsn) + 1;
+		if (rhdr->flags & ISCSI_FLAG_CMD_UNDERFLOW) {
+			int res_count = ntohl(rhdr->residual_count);
+			if (res_count > 0 &&
+			    res_count <= sc->request_bufflen) {
+				sc->resid = res_count;
+			} else {
+				sc->result = (DID_BAD_TARGET << 16) |
+					rhdr->cmd_status;
+				return ISCSI_ERR_BAD_TARGET;
+			}
+		} else if (rhdr->flags& ISCSI_FLAG_CMD_BIDI_UNDERFLOW) {
+			sc->result = (DID_BAD_TARGET << 16) |
+				rhdr->cmd_status;
+			return ISCSI_ERR_BAD_TARGET;
+		} else if (rhdr->flags & ISCSI_FLAG_CMD_OVERFLOW) {
+			sc->resid = ntohl(rhdr->residual_count);
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * iscsi_solicit_data_init - initialize first Data-Out
+ *
+ * Initialize first Data-Out within this R2T sequence and finds
+ * proper data_offset within this SCSI command.
+ *
+ * This function is called with connection lock taken.
+ */
+static void
+iscsi_solicit_data_init(struct iscsi_conn *conn, struct iscsi_cmd_task *ctask,
+			struct iscsi_r2t_info *r2t)
+{
+	struct iscsi_data *hdr;
+	struct iscsi_data_task *dtask;
+	struct scsi_cmnd *sc = ctask->sc;
+
+	dtask = mempool_alloc(ctask->datapool, GFP_ATOMIC);
+	hdr = &dtask->hdr;
+	hdr->rsvd2[0] = hdr->rsvd2[1] = hdr->rsvd3 =
+		hdr->rsvd4 = hdr->rsvd5 = hdr->rsvd6 = 0;
+	hdr->ttt = r2t->ttt;
+	hdr->datasn = htonl(r2t->solicit_datasn);
+	r2t->solicit_datasn++;
+	hdr->opcode = ISCSI_OP_SCSI_DATA_OUT;
+	memset(hdr->lun, 0, 8);
+	hdr->lun[1] = ctask->hdr.lun[1];
+	hdr->itt = ctask->hdr.itt;
+	hdr->exp_statsn = r2t->exp_statsn;
+	hdr->offset = htonl(r2t->data_offset);
+	if (r2t->data_length > conn->max_xmit_dlength) {
+		hton24(hdr->dlength, conn->max_xmit_dlength);
+		r2t->data_count = conn->max_xmit_dlength;
+		hdr->flags = 0;
+	} else {
+		hton24(hdr->dlength, r2t->data_length);
+		r2t->data_count = r2t->data_length;
+		hdr->flags = ISCSI_FLAG_CMD_FINAL;
+	}
+
+	r2t->sent = 0;
+
+	iscsi_buf_init_hdr(conn, &r2t->headbuf, (char*)hdr,
+			   (u8 *)dtask->hdrext);
+
+	if (sc->use_sg) {
+		int i, sg_count = 0;
+		struct scatterlist *sg = sc->request_buffer;
+
+		r2t->sg = NULL;
+		for (i = 0; i < sc->use_sg; i++, sg += 1) {
+			/* FIXME: prefetch ? */
+			if (sg_count + sg->length > r2t->data_offset) {
+				int page_offset;
+
+				/* sg page found! */
+
+				/* offset within this page */
+				page_offset = r2t->data_offset - sg_count;
+
+				/* fill in this buffer */
+				iscsi_buf_init_sg(&r2t->sendbuf, sg);
+				r2t->sendbuf.sg.offset += page_offset;
+				r2t->sendbuf.sg.length -= page_offset;
+
+				/* xmit logic will continue with next one */
+				r2t->sg = sg + 1;
+				break;
+			}
+			sg_count += sg->length;
+		}
+		BUG_ON(r2t->sg == NULL);
+	} else {
+		iscsi_buf_init_virt(&ctask->sendbuf,
+			    (char*)sc->request_buffer + r2t->data_offset,
+			    r2t->data_count);
+	}
+
+	list_add(&dtask->item, &ctask->dataqueue);
+}
+
+/*
+ * iSCSI R2T Response processing
+ */
+static int
+iscsi_r2t_rsp(struct iscsi_conn *conn, struct iscsi_cmd_task *ctask)
+{
+	struct iscsi_r2t_info *r2t;
+	struct iscsi_session *session = conn->session;
+	struct iscsi_r2t_rsp *rhdr = (struct iscsi_r2t_rsp *)conn->in.hdr;
+	uint32_t max_cmdsn = ntohl(rhdr->max_cmdsn);
+	uint32_t exp_cmdsn = ntohl(rhdr->exp_cmdsn);
+	int r2tsn = ntohl(rhdr->r2tsn);
+
+	if (conn->in.ahslen)
+		return ISCSI_ERR_AHSLEN;
+
+	if (conn->in.datalen)
+		return ISCSI_ERR_DATALEN;
+
+	if (ctask->exp_r2tsn && ctask->exp_r2tsn != r2tsn)
+		return ISCSI_ERR_R2TSN;
+
+	if (max_cmdsn < exp_cmdsn - 1)
+		return ISCSI_ERR_MAX_CMDSN;
+
+	session->max_cmdsn = max_cmdsn;
+	session->exp_cmdsn = exp_cmdsn;
+
+	/* FIXME: use R2TSN to detect missing R2T */
+
+	/* fill-in new R2T associated with the task */
+	if (!__kfifo_get(ctask->r2tpool.queue, (void*)&r2t, sizeof(void*))) {
+		return ISCSI_ERR_PROTO;
+	}
+	r2t->exp_statsn = rhdr->statsn;
+	r2t->data_length = ntohl(rhdr->data_length);
+	if (r2t->data_length == 0 ||
+	    r2t->data_length > session->max_burst) {
+		return ISCSI_ERR_DATALEN;
+	}
+	if (ctask->hdr.lun[1] != rhdr->lun[1]) {
+		return ISCSI_ERR_LUN;
+	}
+	r2t->data_offset = ntohl(rhdr->data_offset);
+	if (r2t->data_offset + r2t->data_length > ctask->total_length) {
+		return ISCSI_ERR_DATALEN;
+	}
+	r2t->ttt = rhdr->ttt; /* no flip */
+	r2t->solicit_datasn = 0;
+
+	iscsi_solicit_data_init(conn, ctask, r2t);
+
+	ctask->exp_r2tsn = r2tsn + 1;
+	ctask->xmstate |= XMSTATE_SOL_HDR;
+	__kfifo_put(ctask->r2tqueue, (void*)&r2t, sizeof(void*));
+	__kfifo_put(conn->writequeue, (void*)&ctask, sizeof(void*));
+
+	schedule_work(&conn->xmitwork);
+	return 0;
+}
+
+static int
+iscsi_hdr_recv(struct iscsi_conn *conn)
+{
+	int rc = 0;
+	struct iscsi_hdr *hdr;
+	struct iscsi_cmd_task *ctask;
+	struct iscsi_session *session = conn->session;
+	uint32_t cdgst, rdgst = 0;
+
+	hdr = conn->in.hdr;
+
+	/* verify PDU length */
+	conn->in.datalen = ntoh24(hdr->dlength);
+	if (conn->in.datalen > conn->max_recv_dlength) {
+		printk("iSCSI: datalen %d > %d\n", conn->in.datalen,
+		       conn->max_recv_dlength);
+		iscsi_control_cnx_error(conn->handle, ISCSI_ERR_CNX_FAILED);
+		return 0;
+	}
+	conn->data_copied = 0;
+
+	/* read AHS */
+	conn->in.ahslen = hdr->hlength*(4*sizeof(__u16));
+	conn->in.offset += conn->in.ahslen;
+	conn->in.copy -= conn->in.ahslen;
+	if (conn->in.copy < 0) {
+		printk("iSCSI: can't handle AHS with length %d bytes\n",
+		       conn->in.ahslen);
+		iscsi_control_cnx_error(conn->handle, ISCSI_ERR_CNX_FAILED);
+		return 0;
+	}
+
+	/* calculate padding */
+	conn->in.padding = conn->in.datalen & (ISCSI_PAD_LEN-1);
+	if (conn->in.padding) {
+		conn->in.padding = ISCSI_PAD_LEN - conn->in.padding;
+		debug_scsi("padding %d bytes\n", conn->in.padding);
+	}
+
+	if (conn->hdrdgst_en) {
+		struct scatterlist sg;
+
+		sg_init_one(&sg, (u8 *)hdr,
+			    sizeof(struct iscsi_hdr) + conn->in.ahslen);
+		crypto_digest_init(conn->rx_tfm);
+		crypto_digest_update(conn->rx_tfm, &sg, 1);
+		crypto_digest_final(conn->rx_tfm, (u8 *)&cdgst);
+		rdgst = *(uint32_t*)((char*)hdr + sizeof(struct iscsi_hdr) +
+				     conn->in.ahslen);
+	}
+
+	/* save opcode & itt for later */
+	conn->in.opcode = hdr->opcode;
+	conn->in.itt = ntohl(hdr->itt);
+
+	debug_tcp("opcode 0x%x offset %d copy %d ahslen %d datalen %d\n",
+		  hdr->opcode, conn->in.offset, conn->in.copy,
+		  conn->in.ahslen, conn->in.datalen);
+
+	if (conn->in.itt < session->cmds_max) {
+		if (conn->hdrdgst_en && cdgst != rdgst) {
+			printk("iSCSI: itt %x: hdrdgst error recv 0x%x "
+			       "calc 0x%x\n", conn->in.itt, rdgst, cdgst);
+			iscsi_control_cnx_error(conn->handle,
+						ISCSI_ERR_HDR_DGST);
+			return 0;
+		}
+
+		ctask = (struct iscsi_cmd_task *)session->cmds[conn->in.itt];
+		BUG_ON(ctask != (void*)ctask->sc->SCp.ptr);
+		conn->in.ctask = ctask;
+
+		debug_scsi("rsp [op 0x%x cid %d sc %lx itt 0x%x len %d]\n",
+			   hdr->opcode, conn->id, (long)ctask->sc, ctask->itt,
+			   conn->in.datalen);
+
+		switch(conn->in.opcode) {
+		case ISCSI_OP_SCSI_CMD_RSP:
+			if (ctask->in_progress == IN_PROGRESS_READ) {
+				if (!conn->in.datalen) {
+					rc = iscsi_cmd_rsp(conn, ctask);
+				} else {
+					/* got sense or response data;
+					 * copying PDU Header to the
+					 * connection's header
+					 * placeholder */
+					memcpy(&conn->hdr, hdr,
+					       sizeof(struct iscsi_hdr));
+				}
+			} else if (ctask->in_progress == IN_PROGRESS_WRITE) {
+				rc = iscsi_cmd_rsp(conn, ctask);
+			}
+			break;
+		case ISCSI_OP_SCSI_DATA_IN:
+			/* save flags for non-exceptional status */
+			conn->in.flags = hdr->flags;
+			/* save cmd_status for sense data */
+			conn->in.cmd_status =
+				((struct iscsi_data_rsp*)hdr)->cmd_status;
+			rc = iscsi_data_rsp(conn, ctask);
+			break;
+		case ISCSI_OP_R2T:
+			rc = iscsi_r2t_rsp(conn, ctask);
+			break;
+		case ISCSI_OP_NOOP_IN:
+		case ISCSI_OP_TEXT_RSP:
+		case ISCSI_OP_LOGOUT_RSP:
+		case ISCSI_OP_ASYNC_EVENT:
+		case ISCSI_OP_REJECT:
+			/* update ExpStatSN */
+			conn->exp_statsn = ntohl(hdr->statsn) + 1;
+			if (!conn->in.datalen) {
+				struct iscsi_mgmt_task *mtask;
+
+				rc = iscsi_control_recv_pdu(
+					conn->handle, hdr, NULL, 0);
+				mtask = (struct iscsi_mgmt_task *)
+					session->imm_cmds[conn->in.itt -
+						ISCSI_IMM_ITT_OFFSET];
+				if (conn->login_mtask != mtask) {
+					spin_lock(&session->lock);
+					__kfifo_put(session->immpool.queue,
+					    (void*)&mtask, sizeof(void*));
+					spin_unlock(&session->lock);
+				}
+			}
+			break;
+		default:
+			rc = ISCSI_ERR_BAD_OPCODE;
+			break;
+		}
+	} else if (conn->in.itt >= ISCSI_IMM_ITT_OFFSET &&
+		   conn->in.itt < ISCSI_IMM_ITT_OFFSET +
+					session->imm_max) {
+		struct iscsi_mgmt_task *mtask = (struct iscsi_mgmt_task *)
+					session->imm_cmds[conn->in.itt -
+						ISCSI_IMM_ITT_OFFSET];
+
+		debug_scsi("immrsp [op 0x%x cid %d itt 0x%x len %d]\n",
+			   conn->in.opcode, conn->id, mtask->itt,
+			   conn->in.datalen);
+
+		switch(conn->in.opcode) {
+		case ISCSI_OP_LOGIN_RSP:
+		case ISCSI_OP_TEXT_RSP:
+			if (!conn->in.datalen) {
+				rc = iscsi_control_recv_pdu(
+					conn->handle, hdr, NULL, 0);
+				if (conn->login_mtask != mtask) {
+					spin_lock(&session->lock);
+					__kfifo_put(session->immpool.queue,
+					    (void*)&mtask, sizeof(void*));
+					spin_unlock(&session->lock);
+				}
+			}
+			break;
+		case ISCSI_OP_SCSI_TMFUNC_RSP:
+			if (conn->in.datalen || conn->in.ahslen) {
+				rc = ISCSI_ERR_PROTO;
+				break;
+			}
+			spin_lock(&session->lock);
+			__kfifo_put(session->immpool.queue, (void*)&mtask,
+				    sizeof(void*));
+			spin_unlock(&session->lock);
+			del_timer_sync(&conn->tmabort_timer);
+			conn->tmabort_state = ((struct iscsi_tm_rsp *)hdr)->
+				response == SCSI_TCP_TM_RESP_COMPLETE ?
+					TMABORT_SUCCESS : TMABORT_FAILED;
+			wake_up(&conn->ehwait);
+			break;
+		default:
+			rc = ISCSI_ERR_BAD_OPCODE;
+			break;
+		}
+	} else if (conn->in.itt == ISCSI_RESERVED_TAG) {
+		if (conn->in.opcode == ISCSI_OP_NOOP_IN &&
+		    !conn->in.datalen) {
+			rc = iscsi_control_recv_pdu(
+					conn->handle, hdr, NULL, 0);
+		} else {
+			rc = ISCSI_ERR_BAD_OPCODE;
+		}
+	} else {
+		rc = ISCSI_ERR_BAD_ITT;
+	}
+
+	return rc;
+}
+
+/*
+ * iscsi_ctask_copy - copy skb bits to the destanation cmd task
+ *
+ * The function calls skb_copy_bits() and updates per-connection and
+ * per-cmd byte counters.
+ */
+static inline int
+iscsi_ctask_copy(struct iscsi_conn *conn, struct iscsi_cmd_task *ctask,
+		void *buf, int buf_size)
+{
+	int buf_left = buf_size - conn->data_copied;
+	int size = min(conn->in.copy, buf_left);
+	int rc;
+
+	/*
+	 * Read counters (in bytes):
+	 *
+	 *	conn->in.offset		offset within in progress SKB
+	 *	conn->in.copy		left to copy from in progress SKB
+	 *				including padding
+	 *	conn->in.copied		copied already from in progress SKB
+	 *	conn->data_copied	copied already from in progress buffer
+	 *	ctask->sent		total bytes sent up to the MidLayer
+	 *	ctask->data_count	left to copy from in progress Data-In
+	 *	buf_left		left to copy from in progress buffer
+	 */
+
+	size = min(size, ctask->data_count);
+
+	debug_tcp("ctask_copy %d bytes at offset %d copied %d\n",
+	       size, conn->in.offset, conn->in.copied);
+
+	BUG_ON(size <= 0);
+	BUG_ON(ctask->sent + size > ctask->total_length);
+
+	rc = skb_copy_bits(conn->in.skb, conn->in.offset,
+			   (char*)buf + conn->data_copied, size);
+	/* must fit into skb->len */
+	BUG_ON(rc);
+
+	conn->in.offset += size;
+	conn->in.copy -= size;
+	conn->in.copied += size;
+	conn->data_copied += size;
+	ctask->sent += size;
+	ctask->data_count -= size;
+
+	BUG_ON(conn->in.copy < 0);
+	BUG_ON(ctask->data_count < 0);
+
+	if (buf_size != conn->data_copied) {
+		if (!ctask->data_count) {
+			BUG_ON(buf_size - conn->data_copied < 0);
+			/* done with this PDU */
+			return buf_size - conn->data_copied;
+		}
+		return -EAGAIN;
+	}
+
+	/* done with this buffer or with both - PDU and buffer */
+	conn->data_copied = 0;
+	return 0;
+}
+
+/*
+ * iscsi_tcp_copy - copy skb bits to the destanation buffer
+ *
+ * The function calls skb_copy_bits() and updates per-connection byte counters.
+ */
+static inline int
+iscsi_tcp_copy(struct iscsi_conn *conn, void *buf, int buf_size)
+{
+	int buf_left = buf_size - conn->data_copied;
+	int size = min(conn->in.copy, buf_left);
+	int rc;
+
+	debug_tcp("tcp_copy %d bytes at offset %d copied %d\n",
+	       size, conn->in.offset, conn->data_copied);
+	BUG_ON(size <= 0);
+
+	rc = skb_copy_bits(conn->in.skb, conn->in.offset,
+			   (char*)buf + conn->data_copied, size);
+	BUG_ON(rc);
+
+	conn->in.offset += size;
+	conn->in.copy -= size;
+	conn->in.copied += size;
+	conn->data_copied += size;
+
+	if (buf_size != conn->data_copied)
+		return -EAGAIN;
+
+	return 0;
+}
+
+static int
+iscsi_data_recv(struct iscsi_conn *conn)
+{
+	struct iscsi_session *session = conn->session;
+	int rc = 0;
+
+	switch(conn->in.opcode) {
+	case ISCSI_OP_SCSI_DATA_IN: {
+	    struct iscsi_cmd_task *ctask = conn->in.ctask;
+	    struct scsi_cmnd *sc = ctask->sc;
+	    BUG_ON(!(ctask->in_progress & IN_PROGRESS_READ &&
+		     conn->in_progress == IN_PROGRESS_DATA_RECV));
+	    BUG_ON(ctask != (void*)sc->SCp.ptr);
+
+	    /*
+	     * copying Data-In into the Scsi_Cmnd
+	     */
+	    if (sc->use_sg) {
+		int i;
+		struct scatterlist *sg = sc->request_buffer;
+
+		for (i = ctask->sg_count; i < sc->use_sg; i++) {
+			char *dest;
+
+			dest = kmap_atomic(sg[i].page, KM_USER0);
+			rc = iscsi_ctask_copy(conn, ctask, dest + sg[i].offset,
+					      sg->length);
+			kunmap_atomic(dest, KM_USER0);
+			if (rc == -EAGAIN) {
+				/* continue with the next SKB/PDU */
+				goto exit;
+			}
+			if (!rc) {
+				ctask->sg_count++;
+			}
+			if (!ctask->data_count) {
+				rc = 0;
+				break;
+			}
+			if (!conn->in.copy) {
+				rc = -EAGAIN;
+				goto exit;
+			}
+		}
+	    } else {
+		rc = iscsi_ctask_copy(conn, ctask, sc->request_buffer,
+				      sc->request_bufflen);
+		if (rc == -EAGAIN)
+			goto exit;
+		rc = 0;
+	    }
+
+	    /* check for non-exceptional status */
+	    if (conn->in.flags & ISCSI_FLAG_DATA_STATUS) {
+		    debug_scsi("done [sc %lx res %d itt 0x%x]\n",
+			       (long)sc, sc->result, ctask->itt);
+		    iscsi_ctask_cleanup(conn, ctask);
+		    sc->result = conn->in.cmd_status;
+		    sc->scsi_done(sc);
+	    }
+	}
+	break;
+	case ISCSI_OP_SCSI_CMD_RSP: {
+		/*
+		 * SCSI Sense Data:
+		 * copying the entire Data Segment.
+		 */
+		if (iscsi_tcp_copy(conn, conn->data, conn->in.datalen)) {
+			rc = -EAGAIN;
+			goto exit;
+		}
+
+		/*
+		 * check for sense
+		 */
+		conn->in.hdr = &conn->hdr;
+		conn->senselen = (conn->data[0] << 8) | conn->data[1];
+		rc = iscsi_cmd_rsp(conn, conn->in.ctask);
+	}
+	break;
+	case ISCSI_OP_TEXT_RSP:
+	case ISCSI_OP_LOGIN_RSP:
+	case ISCSI_OP_NOOP_IN: {
+		struct iscsi_mgmt_task *mtask = NULL;
+
+		if (conn->in.itt != ISCSI_RESERVED_TAG) {
+			mtask = (struct iscsi_mgmt_task *)
+				session->imm_cmds[conn->in.itt -
+					ISCSI_IMM_ITT_OFFSET];
+		}
+
+		/*
+		 * Collect data segment to the connection's data
+		 * placeholder
+		 */
+		if (iscsi_tcp_copy(conn, conn->data, conn->in.datalen)) {
+			rc = -EAGAIN;
+			goto exit;
+		}
+
+		rc = iscsi_control_recv_pdu(conn->handle,
+				conn->in.hdr, conn->data, conn->in.datalen);
+
+		if (mtask && conn->login_mtask != mtask) {
+			spin_lock(&session->lock);
+			__kfifo_put(session->immpool.queue, (void*)&mtask,
+				    sizeof(void*));
+			spin_unlock(&session->lock);
+		}
+	}
+	break;
+	default:
+		BUG_ON(1);
+	}
+exit:
+	return rc;
+}
+
+/*
+ * TCP receive
+ */
+static int
+iscsi_tcp_data_recv(read_descriptor_t *rd_desc, struct sk_buff *skb,
+		unsigned int offset, size_t len)
+{
+	int rc;
+	struct iscsi_conn *conn = iscsi_conn_get(rd_desc);
+	int start = skb_headlen(skb);
+
+	/*
+	 * Save current SKB and its offset in the corresponding
+	 * connection context.
+	 */
+	conn->in.copy = start - offset;
+	conn->in.offset = offset;
+	conn->in.skb = skb;
+	conn->in.len = conn->in.copy;
+	BUG_ON(conn->in.copy <= 0);
+	debug_tcp("in %d bytes\n", conn->in.copy);
+
+more:
+	conn->in.copied = 0;
+	rc = 0;
+
+	if (conn->in_progress == IN_PROGRESS_WAIT_HEADER ||
+	    conn->in_progress == IN_PROGRESS_HEADER_GATHER) {
+		rc = iscsi_hdr_extract(conn);
+		if (rc == -EAGAIN)
+			goto nomore;
+
+		/*
+		 * Verify and process incoming PDU header.
+		 */
+		rc = iscsi_hdr_recv(conn);
+		if (!rc && conn->in.datalen) {
+			conn->in_progress = IN_PROGRESS_DATA_RECV;
+		} else if (rc) {
+			printk("iSCSI: bad hdr rc (%d)\n", rc);
+			iscsi_control_cnx_error(conn->handle, rc);
+			return 0;
+		}
+	}
+
+	if (conn->in_progress == IN_PROGRESS_DATA_RECV &&
+	    conn->in.copy) {
+
+		debug_tcp("data_recv offset %d copy %d\n",
+		       conn->in.offset, conn->in.copy);
+
+		rc = iscsi_data_recv(conn);
+		if (rc) {
+			if (rc == -EAGAIN) {
+				rd_desc->count = conn->in.datalen -
+							conn->in.ctask->sent;
+				goto again;
+			}
+			printk("iSCSI: bad data rc (%d)\n", rc);
+			iscsi_control_cnx_error(conn->handle, rc);
+			return 0;
+		}
+		conn->in.copy -= conn->in.padding;
+		conn->in.offset += conn->in.padding;
+		conn->in_progress = IN_PROGRESS_WAIT_HEADER;
+	}
+
+	debug_tcp("f, processed %d from out of %d padding %d\n",
+	       conn->in.offset - offset, len, conn->in.padding);
+	BUG_ON(conn->in.offset - offset > len);
+
+	if (conn->in.offset - offset != len) {
+		debug_tcp("continue to process %d bytes\n",
+		       len - (conn->in.offset - offset));
+		goto more;
+	}
+
+nomore:
+	BUG_ON(conn->in.offset - offset == 0);
+	return conn->in.offset - offset;
+
+again:
+	debug_tcp("c, processed %d from out of %d rd_desc_cnt %d\n",
+	          conn->in.offset - offset, len, rd_desc->count);
+	BUG_ON(conn->in.offset - offset == 0);
+	BUG_ON(conn->in.offset - offset > len);
+
+	return conn->in.offset - offset;
+}
+
+static void
+iscsi_tcp_data_ready(struct sock *sk, int flag)
+{
+	struct iscsi_conn *conn = (struct iscsi_conn*)sk->sk_user_data;
+	read_descriptor_t rd_desc;
+
+	read_lock(&sk->sk_callback_lock);
+
+	/* use rd_desc to pass 'conn' to iscsi_tcp_data_recv */
+	iscsi_conn_set(&rd_desc, conn);
+	rd_desc.count = 0;
+	tcp_read_sock(sk, &rd_desc, iscsi_tcp_data_recv);
+
+	read_unlock(&sk->sk_callback_lock);
+}
+
+static void
+iscsi_tcp_state_change(struct sock *sk)
+{
+	struct iscsi_conn *conn = (struct iscsi_conn*)sk->sk_user_data;
+	struct iscsi_session *session = conn->session;
+
+	if (sk->sk_state == TCP_CLOSE_WAIT ||
+	    sk->sk_state == TCP_CLOSE) {
+		debug_tcp("iscsi_tcp_state_change: TCP_CLOSE\n");
+		conn->c_stage = ISCSI_CNX_CLEANUP_WAIT;
+		spin_lock_bh(&session->conn_lock);
+		if (session->conn_cnt == 1 ||
+		    session->leadconn == conn) {
+			session->state = ISCSI_STATE_FAILED;
+		}
+		spin_unlock_bh(&session->conn_lock);
+		iscsi_control_cnx_error(conn->handle, ISCSI_ERR_CNX_FAILED);
+	}
+	conn->old_state_change(sk);
+}
+
+/*
+ * Called when more output buffer space is available for this socket.
+ */
+static void
+iscsi_write_space(struct sock *sk)
+{
+	struct iscsi_conn *conn = (struct iscsi_conn*)sk->sk_user_data;
+	conn->old_write_space(sk);
+	debug_tcp("iscsi_write_space: cid %d\n", conn->id);
+	conn->suspend = 0; wmb();
+	schedule_work(&conn->xmitwork);
+}
+
+static void
+iscsi_conn_set_callbacks(struct iscsi_conn *conn)
+{
+	struct sock *sk = conn->sock->sk;
+
+	/* assign new callbacks */
+	write_lock_bh(&sk->sk_callback_lock);
+	sk->sk_user_data = conn;
+	conn->old_data_ready = sk->sk_data_ready;
+	conn->old_state_change = sk->sk_state_change;
+	conn->old_write_space = sk->sk_write_space;
+	sk->sk_data_ready = iscsi_tcp_data_ready;
+	sk->sk_state_change = iscsi_tcp_state_change;
+	sk->sk_write_space = iscsi_write_space;
+	write_unlock_bh(&sk->sk_callback_lock);
+}
+
+static void
+iscsi_conn_restore_callbacks(struct iscsi_conn *conn)
+{
+	struct sock *sk = conn->sock->sk;
+
+	/* restore socket callbacks, see also: iscsi_conn_set_callbacks() */
+	write_lock_bh(&sk->sk_callback_lock);
+	sk->sk_user_data    = NULL;
+	sk->sk_data_ready   = conn->old_data_ready;
+	sk->sk_state_change = conn->old_state_change;
+	sk->sk_write_space  = conn->old_write_space;
+	sk->sk_no_check	 = 0;
+	write_unlock_bh(&sk->sk_callback_lock);
+}
+
+/*
+ * iscsi_sendhdr - send PDU Header via tcp_sendpage()
+ * (Tx, Fast Path)
+ */
+static inline int
+iscsi_sendhdr(struct iscsi_conn *conn, struct iscsi_buf *buf)
+{
+	struct socket *sk = conn->sock;
+	int flags = 0; /* MSG_DONTWAIT; */
+	int res, offset, size;
+
+	offset = buf->sg.offset + buf->sent;
+	size = buf->sg.length - buf->sent;
+	BUG_ON(buf->sent + size > buf->sg.length);
+	if (buf->sent + size != buf->sg.length) {
+		flags |= MSG_MORE;
+	}
+
+	/* sendpage */
+	res = sk->ops->sendpage(sk, buf->sg.page, offset, size, flags);
+	debug_tcp("sendhdr %lx %d bytes at offset %d sent %d res %d\n",
+		(long)page_address(buf->sg.page), size, offset, buf->sent, res);
+	if (res >= 0) {
+		buf->sent += res;
+		if (size != res)
+			return -EAGAIN;
+		return 0;
+	} else if (res == -EAGAIN) {
+		conn->suspend = 1;
+	} else if (res == -EPIPE) {
+		conn->suspend = 1;
+		iscsi_control_cnx_error(conn->handle, ISCSI_ERR_CNX_FAILED);
+	}
+
+	return res;
+}
+
+/*
+ * iscsi_sendpage - send one page of iSCSI Data-Out.
+ * (Tx, Fast Path)
+ */
+static inline int
+iscsi_sendpage(struct iscsi_conn *conn, struct iscsi_buf *buf,
+	       int *count, int *sent)
+{
+	ssize_t (*sendpage)(struct socket *, struct page *, int, size_t, int);
+	struct socket *sk = conn->sock;
+	int flags = 0; /* MSG_DONTWAIT; */
+	int res, offset, size;
+
+	size = buf->sg.length - buf->sent;
+	BUG_ON(buf->sent + size > buf->sg.length);
+	if (size > *count) {
+		size = *count;
+	}
+	if (buf->sent + size != buf->sg.length) {
+		flags |= MSG_MORE;
+	}
+
+	offset = buf->sg.offset + buf->sent;
+
+	/* tcp_sendpage */
+	sendpage = sk->ops->sendpage ? : sock_no_sendpage;
+
+	res = sendpage(sk, buf->sg.page, offset, size, flags);
+	debug_tcp("sendpage %lx %d bytes, boff %d bsent %d "
+		  "left %d sent %d res %d\n",
+		  (long)page_address(buf->sg.page), size, offset,
+		  buf->sent, *count, *sent, res);
+	if (res >= 0) {
+		buf->sent += res;
+		*count -= res;
+		*sent += res;
+		if (size != res)
+			return -EAGAIN;
+		return 0;
+	} else if (res == -EAGAIN) {
+		conn->suspend = 1;
+	} else if (res == -EPIPE) {
+		conn->suspend = 1;
+		iscsi_control_cnx_error(conn->handle, ISCSI_ERR_CNX_FAILED);
+	}
+
+	return res;
+}
+
+/*
+ * iscsi_solicit_data_cont - initialize next Data-Out
+ *
+ * Initialize next Data-Out within this R2T sequence and continue
+ * to process next Scatter-Gather element(if any) of this SCSI command.
+ *
+ * Called under connection lock.
+ */
+static void
+iscsi_solicit_data_cont(struct iscsi_conn *conn, struct iscsi_cmd_task *ctask,
+			struct iscsi_r2t_info *r2t, int left)
+{
+	struct iscsi_data *hdr;
+	struct iscsi_data_task *dtask;
+	struct scsi_cmnd *sc = ctask->sc;
+	int new_offset;
+
+	dtask = mempool_alloc(ctask->datapool, GFP_ATOMIC);
+	hdr = &dtask->hdr;
+	hdr->flags = 0;
+	hdr->rsvd2[0] = hdr->rsvd2[1] = hdr->rsvd3 =
+		hdr->rsvd4 = hdr->rsvd5 = hdr->rsvd6 = 0;
+	hdr->ttt = r2t->ttt;
+	hdr->datasn = htonl(r2t->solicit_datasn);
+	r2t->solicit_datasn++;
+	hdr->opcode = ISCSI_OP_SCSI_DATA_OUT;
+	memset(hdr->lun, 0, 8);
+	hdr->lun[1] = ctask->hdr.lun[1];
+	hdr->itt = ctask->hdr.itt;
+	hdr->exp_statsn = r2t->exp_statsn;
+	new_offset = r2t->data_offset + r2t->sent;
+	hdr->offset = htonl(new_offset);
+	if (left > conn->max_xmit_dlength) {
+		hton24(hdr->dlength, conn->max_xmit_dlength);
+		r2t->data_count = conn->max_xmit_dlength;
+	} else {
+		hton24(hdr->dlength, left);
+		r2t->data_count = left;
+		hdr->flags = ISCSI_FLAG_CMD_FINAL;
+	}
+
+	iscsi_buf_init_hdr(conn, &r2t->headbuf, (char*)hdr,
+			   (u8 *)dtask->hdrext);
+
+	if (sc->use_sg) {
+		BUG_ON(ctask->bad_sg == r2t->sg);
+		if (!iscsi_buf_left(&r2t->sendbuf)) {
+			iscsi_buf_init_sg(&r2t->sendbuf, r2t->sg);
+			r2t->sg += 1;
+		}
+	} else {
+		iscsi_buf_init_virt(&ctask->sendbuf,
+			    (char*)sc->request_buffer + new_offset,
+			    r2t->data_count);
+	}
+
+	list_add(&dtask->item, &ctask->dataqueue);
+}
+
+static void
+iscsi_unsolicit_data_init(struct iscsi_conn *conn, struct iscsi_cmd_task *ctask)
+{
+	struct iscsi_data *hdr;
+	struct iscsi_data_task *dtask;
+
+	dtask = mempool_alloc(ctask->datapool, GFP_ATOMIC);
+	hdr = &dtask->hdr;
+	hdr->rsvd2[0] = hdr->rsvd2[1] = hdr->rsvd3 =
+		hdr->rsvd4 = hdr->rsvd5 = hdr->rsvd6 = 0;
+	hdr->ttt = ISCSI_RESERVED_TAG;
+	hdr->datasn = htonl(ctask->unsol_datasn);
+	ctask->unsol_datasn++;
+	hdr->opcode = ISCSI_OP_SCSI_DATA_OUT;
+	memset(hdr->lun, 0, 8);
+	hdr->lun[1] = ctask->hdr.lun[1];
+	hdr->itt = ctask->hdr.itt;
+	hdr->exp_statsn = htonl(conn->exp_statsn);
+	hdr->offset = htonl(ctask->total_length - ctask->r2t_data_count -
+			    ctask->unsol_count);
+	if (ctask->unsol_count > conn->max_xmit_dlength) {
+		hton24(hdr->dlength, conn->max_xmit_dlength);
+		ctask->data_count = conn->max_xmit_dlength;
+		hdr->flags = 0;
+	} else {
+		hton24(hdr->dlength, ctask->unsol_count);
+		ctask->data_count = ctask->unsol_count;
+		hdr->flags = ISCSI_FLAG_CMD_FINAL;
+	}
+
+	iscsi_buf_init_hdr(conn, &ctask->headbuf, (char*)hdr,
+			   (u8 *)dtask->hdrext);
+
+	list_add(&dtask->item, &ctask->dataqueue);
+}
+
+/*
+ * Initialize iSCSI SCSI_READ or SCSI_WRITE commands
+ */
+static void
+iscsi_cmd_init(struct iscsi_conn *conn, struct iscsi_cmd_task *ctask,
+		struct scsi_cmnd *sc)
+{
+	struct iscsi_session *session = conn->session;
+
+	ctask->sc = sc;
+	ctask->conn = conn;
+	ctask->hdr.opcode = ISCSI_OP_SCSI_CMD;
+	ctask->hdr.flags = ISCSI_ATTR_SIMPLE;
+	ctask->hdr.lun[1] = sc->device->lun;
+	ctask->hdr.itt = htonl(ctask->itt);
+	ctask->hdr.data_length = htonl(sc->request_bufflen);
+	ctask->hdr.cmdsn = htonl(session->cmdsn); session->cmdsn++;
+	ctask->hdr.exp_statsn = htonl(conn->exp_statsn);
+	memcpy(ctask->hdr.cdb, sc->cmnd, sc->cmd_len);
+	memset(&ctask->hdr.cdb[sc->cmd_len], 0, MAX_COMMAND_SIZE - sc->cmd_len);
+
+	ctask->in_progress = IN_PROGRESS_IDLE;
+	ctask->sent = 0;
+	ctask->sg_count = 0;
+
+	ctask->total_length = sc->request_bufflen;
+
+	if (sc->sc_data_direction == DMA_TO_DEVICE) {
+		ctask->exp_r2tsn = 0;
+		ctask->hdr.flags |= ISCSI_FLAG_CMD_WRITE;
+		ctask->in_progress = IN_PROGRESS_WRITE;
+		BUG_ON(ctask->total_length == 0);
+		if (sc->use_sg) {
+			struct scatterlist *sg = sc->request_buffer;
+
+			iscsi_buf_init_sg(&ctask->sendbuf, &sg[0]);
+			ctask->sg = sg + 1;
+			ctask->bad_sg = sg + sc->use_sg;
+		} else {
+			iscsi_buf_init_virt(&ctask->sendbuf, sc->request_buffer,
+					sc->request_bufflen);
+			BUG_ON(sc->request_bufflen > PAGE_SIZE);
+		}
+
+		/*
+		 * Write counters:
+		 *
+		 *	imm_count	bytes to be sent right after
+		 *			SCSI PDU Header
+		 *
+		 *	unsol_count	bytes(as Data-Out) to be sent
+		 *			without	R2T ack right after
+		 *			immediate data
+		 *
+		 *	r2t_data_count	bytes to be sent via R2T ack's
+		 */
+		ctask->imm_count = 0;
+		ctask->unsol_count = 0;
+		ctask->unsol_datasn = 0;
+		ctask->xmstate = XMSTATE_W_HDR;
+		if (session->imm_data_en) {
+			if (ctask->total_length >= session->first_burst) {
+				ctask->imm_count = min(session->first_burst,
+							conn->max_xmit_dlength);
+			} else {
+				ctask->imm_count = min(ctask->total_length,
+							conn->max_xmit_dlength);
+			}
+			hton24(ctask->hdr.dlength, ctask->imm_count);
+			ctask->xmstate |= XMSTATE_IMM_DATA;
+		} else {
+			zero_data(ctask->hdr.dlength);
+		}
+		if (!session->initial_r2t_en) {
+			ctask->unsol_count=min(session->first_burst,
+				ctask->total_length) - ctask->imm_count;
+		}
+		if (!ctask->unsol_count) {
+			/* No unsolicit Data-Out's */
+			ctask->hdr.flags |= ISCSI_FLAG_CMD_FINAL;
+		} else {
+			ctask->xmstate |= XMSTATE_UNS_HDR | XMSTATE_UNS_INIT;
+		}
+		ctask->r2t_data_count = ctask->total_length -
+				    ctask->imm_count -
+				    ctask->unsol_count;
+
+		debug_scsi("cmd [itt %x total %d imm %d imm_data %d "
+			   "r2t_data %d]\n",
+			   ctask->itt, ctask->total_length, ctask->imm_count,
+			   ctask->unsol_count, ctask->r2t_data_count);
+	} else {
+		ctask->hdr.flags |= ISCSI_FLAG_CMD_FINAL;
+		if (sc->sc_data_direction == DMA_FROM_DEVICE)
+			ctask->hdr.flags |= ISCSI_FLAG_CMD_READ;
+		ctask->datasn = 0;
+		ctask->in_progress = IN_PROGRESS_READ;
+		ctask->xmstate = XMSTATE_R_HDR;
+		zero_data(ctask->hdr.dlength);
+	}
+
+	iscsi_buf_init_hdr(conn, &ctask->headbuf, (char*)&ctask->hdr,
+			    (u8 *)ctask->hdrext);
+}
+
+/*
+ * iscsi_mtask_xmit - xmit management(immediate) task
+ *
+ * The function can return -EAGAIN in which case caller must
+ * call it again later, or recover. '0' return code means successful
+ * xmit.
+ *
+ * Management xmit state machine consists of two states:
+ *	IN_PROGRESS_IMM_HEAD - PDU Header xmit in progress
+ *	IN_PROGRESS_IMM_DATA - PDU Data xmit in progress
+ */
+static int
+iscsi_mtask_xmit(struct iscsi_conn *conn, struct iscsi_mgmt_task *mtask)
+{
+
+	debug_scsi("mtask deq [cid %d state %x itt 0x%x]\n",
+		conn->id, mtask->xmstate, mtask->itt);
+
+	if (mtask->xmstate & XMSTATE_IMM_HDR) {
+		mtask->xmstate &= ~XMSTATE_IMM_HDR;
+		if (mtask->data_count)
+			mtask->xmstate |= XMSTATE_IMM_DATA;
+		if (iscsi_sendhdr(conn, &mtask->headbuf)) {
+			mtask->xmstate |= XMSTATE_IMM_HDR;
+			if (mtask->data_count)
+				mtask->xmstate &= ~XMSTATE_IMM_DATA;
+			return -EAGAIN;
+		}
+	}
+
+	if (mtask->xmstate & XMSTATE_IMM_DATA) {
+		BUG_ON(!mtask->data_count);
+		mtask->xmstate &= ~XMSTATE_IMM_DATA;
+		/* FIXME: implement.
+		 * Virtual buffer could be spreaded accross multiple pages...
+		 */
+		do {
+			if (iscsi_sendpage(conn, &mtask->sendbuf,
+				   &mtask->data_count, &mtask->sent)) {
+				mtask->xmstate |= XMSTATE_IMM_DATA;
+				return -EAGAIN;
+			}
+		} while (mtask->data_count);
+	}
+
+	BUG_ON(mtask->xmstate != XMSTATE_IDLE);
+	return 0;
+}
+
+static int
+iscsi_ctask_xmit(struct iscsi_conn *conn, struct iscsi_cmd_task *ctask)
+{
+	struct iscsi_r2t_info *r2t = NULL;
+
+	debug_scsi("ctask deq [cid %d state %x itt 0x%x]\n",
+		conn->id, ctask->xmstate, ctask->itt);
+
+	if (ctask->xmstate & XMSTATE_R_HDR) {
+		ctask->xmstate &= ~XMSTATE_R_HDR;
+		if (!iscsi_sendhdr(conn, &ctask->headbuf)) {
+			BUG_ON(ctask->xmstate != XMSTATE_IDLE);
+			return 0; /* wait for Data-In */
+		}
+		ctask->xmstate |= XMSTATE_R_HDR;
+		return -EAGAIN;
+	}
+
+	if (ctask->xmstate & XMSTATE_W_HDR) {
+		ctask->xmstate &= ~XMSTATE_W_HDR;
+		if (iscsi_sendhdr(conn, &ctask->headbuf)) {
+			ctask->xmstate |= XMSTATE_W_HDR;
+			return -EAGAIN;
+		}
+	}
+
+	if (ctask->xmstate & XMSTATE_IMM_DATA) {
+		BUG_ON(!ctask->imm_count);
+		ctask->xmstate &= ~XMSTATE_IMM_DATA;
+		while (1) {
+			if (iscsi_sendpage(conn, &ctask->sendbuf,
+					   &ctask->imm_count, &ctask->sent)) {
+				ctask->xmstate |= XMSTATE_IMM_DATA;
+				return -EAGAIN;
+			}
+			if (!ctask->imm_count)
+				break;
+			iscsi_buf_init_sg(&ctask->sendbuf,
+					  &ctask->sg[ctask->sg_count++]);
+		}
+	}
+
+	if (ctask->xmstate & XMSTATE_UNS_HDR) {
+		BUG_ON(!ctask->unsol_count);
+		ctask->xmstate &= ~XMSTATE_UNS_HDR;
+_unsolicit_head_again:
+		ctask->xmstate |= XMSTATE_UNS_DATA;
+		if (ctask->xmstate & XMSTATE_UNS_INIT) {
+			iscsi_unsolicit_data_init(conn, ctask);
+			ctask->xmstate &= ~XMSTATE_UNS_INIT;
+		}
+		if (iscsi_sendhdr(conn, &ctask->headbuf)) {
+			ctask->xmstate &= ~XMSTATE_UNS_DATA;
+			ctask->xmstate |= XMSTATE_UNS_HDR;
+			return -EAGAIN;
+		}
+
+		debug_scsi("uns dout [itt 0x%x dlen %d sent %d]\n",
+			ctask->itt, ctask->unsol_count, ctask->sent);
+	}
+
+	if (ctask->xmstate & XMSTATE_UNS_DATA) {
+		BUG_ON(!ctask->data_count);
+		ctask->xmstate &= ~XMSTATE_UNS_DATA;
+		while (1) {
+			int start = ctask->sent;
+			if (iscsi_sendpage(conn, &ctask->sendbuf,
+					   &ctask->data_count,
+					   &ctask->sent)) {
+				ctask->unsol_count -= ctask->sent - start;
+				ctask->xmstate |= XMSTATE_UNS_DATA;
+				/* will continue with this ctask later.. */
+				return -EAGAIN;
+			}
+			BUG_ON(ctask->sent > ctask->total_length);
+			ctask->unsol_count -= ctask->sent - start;
+			if (!ctask->data_count)
+				break;
+			iscsi_buf_init_sg(&ctask->sendbuf,
+					  &ctask->sg[ctask->sg_count++]);
+		}
+		BUG_ON(ctask->unsol_count < 0);
+
+		/*
+		 * Done with the Data-Out. Next, check if we need
+		 * to send another unsolicited Data-Out.
+		 */
+		if (ctask->unsol_count) {
+			ctask->xmstate |= XMSTATE_UNS_INIT;
+			goto _unsolicit_head_again;
+		}
+
+		BUG_ON(ctask->xmstate != XMSTATE_IDLE);
+		return 0;
+	}
+
+	if (ctask->xmstate & XMSTATE_SOL_HDR) {
+		ctask->xmstate &= ~XMSTATE_SOL_HDR;
+		ctask->xmstate |= XMSTATE_SOL_DATA;
+		if (!ctask->r2t) {
+			__kfifo_get(ctask->r2tqueue, (void*)&r2t,
+				    sizeof(void*));
+			ctask->r2t = r2t;
+		}
+_solicit_head_again:
+		BUG_ON(r2t == NULL);
+		if (iscsi_sendhdr(conn, &r2t->headbuf)) {
+			ctask->xmstate &= ~XMSTATE_SOL_DATA;
+			ctask->xmstate |= XMSTATE_SOL_HDR;
+			return -EAGAIN;
+		}
+
+		debug_scsi("sol dout [dsn %d itt 0x%x dlen %d sent %d]\n",
+			r2t->solicit_datasn - 1, ctask->itt, r2t->data_count,
+			r2t->sent);
+	}
+
+	if (ctask->xmstate & XMSTATE_SOL_DATA) {
+		int left;
+
+		ctask->xmstate &= ~XMSTATE_SOL_DATA;
+		r2t = ctask->r2t;
+_solicit_again:
+		/*
+		 * send Data-Out whitnin this R2T sequence.
+		 */
+		if (r2t->data_count) {
+			if (iscsi_sendpage(conn, &r2t->sendbuf,
+					   &r2t->data_count,
+					   &r2t->sent)) {
+				ctask->xmstate |= XMSTATE_SOL_DATA;
+				/* will continue with this ctask later.. */
+				return -EAGAIN;
+			}
+			BUG_ON(r2t->data_count < 0);
+			if (r2t->data_count) {
+				BUG_ON(ctask->bad_sg == r2t->sg);
+				BUG_ON(ctask->sc->use_sg == 0);
+				if (!iscsi_buf_left(&r2t->sendbuf)) {
+					iscsi_buf_init_sg(&r2t->sendbuf,
+							  r2t->sg);
+					r2t->sg += 1;
+				}
+				goto _solicit_again;
+			}
+		}
+
+		/*
+		 * Done with this Data-Out. Next, check if we have
+		 * to send another Data-Out for this R2T.
+		 */
+		BUG_ON(r2t->data_length - r2t->sent < 0);
+		left = r2t->data_length - r2t->sent;
+		if (left) {
+			iscsi_solicit_data_cont(conn, ctask, r2t, left);
+			ctask->xmstate |= XMSTATE_SOL_DATA;
+			goto _solicit_head_again;
+		}
+
+		/*
+		 * Done with this R2T. Check if there are more
+		 * outstanding R2Ts ready to be processed.
+		 */
+		BUG_ON(ctask->r2t_data_count - r2t->data_length < 0);
+		ctask->r2t_data_count -= r2t->data_length;
+		ctask->r2t = NULL;
+		__kfifo_put(ctask->r2tpool.queue, (void*)&r2t, sizeof(void*));
+		if (__kfifo_get(ctask->r2tqueue, (void*)&r2t, sizeof(void*))) {
+			ctask->r2t = r2t;
+			ctask->xmstate |= XMSTATE_SOL_DATA;
+			goto _solicit_head_again;
+		}
+	}
+
+	BUG_ON(ctask->xmstate != XMSTATE_IDLE);
+	return 0;
+}
+
+/*
+ * iscsi_data_xmit - xmit any command into the scheduled connection
+ *
+ * The function can return -EAGAIN in which case the caller must
+ * re-schedule it again later or recover. '0' return code means successful
+ * xmit.
+ *
+ * Common data xmit state machine consists of two states:
+ *	IN_PROGRESS_XMIT_IMM - xmit of Immediate PDU in progress
+ *	IN_PROGRESS_XMIT_SCSI - xmit of SCSI command PDU in progress
+ */
+static int
+iscsi_data_xmit(struct iscsi_conn *conn)
+{
+	/*
+	 * Transmit in the following order:
+	 *
+	 * 1) in progress task
+	 * 2) write responses, if any
+	 * 3) new read/write requests
+	 */
+
+	/* process non-immediate(command) queue */
+	while (conn->in_progress_xmit == IN_PROGRESS_XMIT_SCSI &&
+	       (conn->ctask ||
+		__kfifo_get(conn->writequeue, (void*)&conn->ctask,
+			    sizeof(void*)) ||
+		__kfifo_get(conn->xmitqueue, (void*)&conn->ctask,
+			    sizeof(void*)))) {
+
+		if (iscsi_ctask_xmit(conn, conn->ctask))
+			return -EAGAIN;
+
+		/* done with this in progress ctask */
+		conn->ctask = NULL;
+
+		/* check if we have something for immediate delivery */
+		if (__kfifo_len(conn->immqueue))
+			break;
+	}
+
+	/* process immediate queue */
+	while (conn->mtask || __kfifo_get(conn->immqueue, (void*)&conn->mtask,
+			   sizeof(void*))) {
+		struct iscsi_session *session = conn->session;
+
+		conn->in_progress_xmit = IN_PROGRESS_XMIT_IMM;
+
+		if (iscsi_mtask_xmit(conn, conn->mtask))
+			return -EAGAIN;
+
+		if (conn->mtask->hdr.itt == ISCSI_RESERVED_TAG) {
+			spin_lock_bh(&session->lock);
+			__kfifo_put(session->immpool.queue, (void*)&conn->mtask,
+				    sizeof(void*));
+			spin_unlock_bh(&session->lock);
+		}
+
+		/* done with the current mtask */
+		conn->mtask = NULL;
+
+		if (__kfifo_len(conn->xmitqueue) ||
+		    __kfifo_len(conn->writequeue)) {
+			/* re-schedule xmitqueue. have to do that in case
+			 * when immediate PDU interrupts xmitqueue loop */
+			schedule_work(&conn->xmitwork);
+		}
+	}
+
+	conn->in_progress_xmit = IN_PROGRESS_XMIT_SCSI;
+
+	return 0;
+}
+
+static void
+iscsi_xmitworker(void *data)
+{
+	struct iscsi_conn *conn = data;
+
+	/*
+	 * serialize Xmit worker on a per-connection basis.
+	 */
+	down(&conn->xmitsema);
+	if (conn->suspend)
+		goto out;
+	if (iscsi_data_xmit(conn)) {
+		if (conn->c_stage == ISCSI_CNX_CLEANUP_WAIT ||
+		    conn->c_stage == ISCSI_CNX_STOPPED ||
+		    conn->suspend)
+			goto out;
+		/* re-schedule in case of -EAGAIN (out of socket buffer) */
+		schedule_work(&conn->xmitwork);
+	}
+out:
+	up(&conn->xmitsema);
+}
+
+#define FAILURE_BAD_HOST		1
+#define FAILURE_SESSION_FAILED		2
+#define FAILURE_SESSION_FREED		3
+#define FAILURE_WINDOW_CLOSED		4
+#define FAILURE_SESSION_TERMINATE	5
+
+int
+iscsi_queuecommand(struct scsi_cmnd *sc, void (*done)(struct scsi_cmnd *))
+{
+	struct Scsi_Host *host;
+	int reason = 0;
+	struct iscsi_session *session;
+	struct iscsi_conn *conn = NULL;
+	struct iscsi_cmd_task *ctask = NULL;
+
+	sc->scsi_done = done;
+	sc->result = 0;
+
+	host = sc->device->host;
+	session = (struct iscsi_session*)host->hostdata;
+	BUG_ON(host->host_no != session->id);
+
+	spin_lock(&session->lock);
+
+	if (session->state != ISCSI_STATE_LOGGED_IN) {
+		if (session->state == ISCSI_STATE_FAILED) {
+			reason = FAILURE_SESSION_FAILED;
+			goto fault;
+		} else if (session->state == ISCSI_STATE_TERMINATE) {
+			reason = FAILURE_SESSION_TERMINATE;
+			goto fault;
+		}
+		reason = FAILURE_SESSION_FREED;
+		goto fault;
+	}
+
+	/*
+	 * Check for iSCSI window and take care of CmdSN wrap-around
+	 */
+	if ((int)(session->max_cmdsn - session->cmdsn) < 0) {
+		reason = FAILURE_WINDOW_CLOSED;
+		goto reject;
+	}
+
+	if (session->conn_cnt > 1) {
+		struct iscsi_conn *cnx;
+		int cpu = smp_processor_id();
+
+		spin_lock(&session->conn_lock);
+		list_for_each_entry(cnx, &session->connections, item) {
+			if (cnx->busy) {
+				conn = cnx;
+				conn->busy--;
+				break;
+			}
+			if (cnx->cpu == cpu && cpu_online(cpu) && !cnx->busy) {
+				conn = cnx;
+				conn->busy = 16;
+				break;
+			}
+		}
+		spin_unlock(&session->conn_lock);
+		if (conn == NULL)
+			conn = session->leadconn;
+	} else {
+		conn = session->leadconn;
+	}
+
+	__kfifo_get(session->cmdpool.queue, (void*)&ctask, sizeof(void*));
+	spin_unlock(&session->lock);
+
+	BUG_ON(!ctask);
+	BUG_ON(ctask->in_progress = IN_PROGRESS_IDLE);
+
+	sc->SCp.ptr = (char*)ctask;
+	iscsi_cmd_init(conn, ctask, sc);
+
+	__kfifo_put(conn->xmitqueue, (void*)&ctask, sizeof(void*));
+	debug_scsi(
+		"queued [%s cid %d sc %lx itt 0x%x len %d cmdsn %d win %d]\n",
+		sc->sc_data_direction == DMA_TO_DEVICE ? "write" : "read",
+		conn->id, (long)sc, ctask->itt, sc->request_bufflen,
+		session->cmdsn, session->max_cmdsn - session->exp_cmdsn + 1);
+
+	schedule_work(&conn->xmitwork);
+
+	return 0;
+
+reject:
+	spin_unlock(&session->lock);
+	debug_scsi("cmd 0x%x rejected (%d)\n", sc->cmnd[0], reason);
+	return SCSI_MLQUEUE_HOST_BUSY;
+
+fault:
+	spin_unlock(&session->lock);
+	printk("iSCSI: cmd 0x%x is not queued (%d)\n", sc->cmnd[0], reason);
+	sc->sense_buffer[0] = 0x70;
+	sc->sense_buffer[2] = NOT_READY;
+	sc->sense_buffer[7] = 0x6;
+	sc->sense_buffer[12] = 0x08;
+	sc->sense_buffer[13] = 0x00;
+	sc->result = (DID_NO_CONNECT << 16);
+	switch (sc->cmnd[0]) {
+	case INQUIRY:
+	case REQUEST_SENSE:
+		sc->resid = sc->cmnd[4];
+	case REPORT_LUNS:
+		sc->resid = sc->cmnd[6] << 24;
+		sc->resid |= sc->cmnd[7] << 16;
+		sc->resid |= sc->cmnd[8] << 8;
+		sc->resid |= sc->cmnd[9];
+	default:
+		sc->resid = sc->request_bufflen;
+	}
+	sc->scsi_done(sc);
+	return 0;
+}
+
+static int
+iscsi_pool_init(struct iscsi_queue *q, int max, void ***items, int item_size)
+{
+	int i;
+
+	*items = kmalloc(max * sizeof(void*), GFP_KERNEL);
+	if (*items == NULL)
+		return -ENOMEM;
+
+	q->max = max;
+	q->pool = kmalloc(max * sizeof(void*), GFP_KERNEL);
+	if (q->pool == NULL) {
+		kfree(*items);
+		return -ENOMEM;
+	}
+
+	q->queue = kfifo_init((void*)q->pool, max * sizeof(void*),
+			      GFP_KERNEL, NULL);
+	if (q->queue == ERR_PTR(-ENOMEM)) {
+		kfree(q->pool);
+		kfree(*items);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < max; i++) {
+		q->pool[i] = kmalloc(item_size, GFP_KERNEL);
+		if (q->pool[i] == NULL) {
+			int j;
+			for (j = 0; j < i; j++) {
+				kfree(q->pool[j]);
+			}
+			kfifo_free(q->queue);
+			kfree(q->pool);
+			kfree(*items);
+			return -ENOMEM;
+		}
+		memset(q->pool[i], 0, item_size);
+		(*items)[i] = q->pool[i];
+		__kfifo_put(q->queue, (void*)&q->pool[i], sizeof(void*));
+	}
+	return 0;
+}
+
+static void
+iscsi_pool_free(struct iscsi_queue *q, void **items)
+{
+	int i;
+
+	for (i = 0; i < q->max; i++)
+		kfree(items[i]);
+	kfree(q->pool);
+	kfree(items);
+}
+
+/*
+ * Allocate a new connection within the session and bind it to
+ * the given socket.
+ */
+static iscsi_cnx_h
+iscsi_conn_create(iscsi_snx_h snxh, iscsi_cnx_h handle,
+			 uint32_t conn_idx)
+{
+	struct iscsi_session *session = iscsi_ptr(snxh);
+	struct iscsi_conn *conn = NULL;
+
+	conn = kmalloc(sizeof(struct iscsi_conn), GFP_KERNEL);
+	if (conn == NULL)
+		goto conn_alloc_fault;
+	memset(conn, 0, sizeof(struct iscsi_conn));
+
+	conn->c_stage = ISCSI_CNX_INITIAL_STAGE;
+	conn->in_progress = IN_PROGRESS_WAIT_HEADER;
+	conn->in_progress_xmit = IN_PROGRESS_XMIT_SCSI;
+	conn->id = conn_idx;
+	conn->exp_statsn = 0;
+	conn->handle = handle;
+	conn->tmabort_state = TMABORT_INITIAL;
+
+	/* initial operational parameters */
+	conn->hdr_size = sizeof(struct iscsi_hdr);
+	conn->max_recv_dlength = DEFAULT_MAX_RECV_DATA_SEGMENT_LENGTH;
+
+	spin_lock_init(&conn->lock);
+
+	/* initialize general xmit PDU commands queue */
+	conn->xmitqueue = kfifo_alloc(session->cmds_max * sizeof(void*),
+					GFP_KERNEL, NULL);
+	if (conn->xmitqueue == ERR_PTR(-ENOMEM))
+		goto xmitqueue_alloc_fault;
+
+	/* initialize write response PDU commands queue */
+	conn->writequeue = kfifo_alloc(session->cmds_max * sizeof(void*),
+					GFP_KERNEL, NULL);
+	if (conn->writequeue == ERR_PTR(-ENOMEM))
+		goto writequeue_alloc_fault;
+
+	/* initialize general immediate PDU commands queue */
+	conn->immqueue = kfifo_alloc(session->imm_max * sizeof(void*),
+					GFP_KERNEL, NULL);
+	if (conn->immqueue == ERR_PTR(-ENOMEM))
+		goto immqueue_alloc_fault;
+	INIT_WORK(&conn->xmitwork, iscsi_xmitworker, conn);
+
+	/* allocate login_mtask used for initial login/text sequence */
+	spin_lock_bh(&session->lock);
+	if (!__kfifo_get(session->immpool.queue, (void*)&conn->login_mtask,
+			 sizeof(void*))) {
+		spin_unlock_bh(&session->lock);
+		goto login_mtask_alloc_fault;
+	}
+	spin_unlock_bh(&session->lock);
+
+	/* allocate initial PDU receive place holder */
+	if (conn->max_recv_dlength <= PAGE_SIZE)
+		conn->data = kmalloc(conn->max_recv_dlength, GFP_KERNEL);
+	else
+		conn->data = (void*)__get_free_pages(GFP_KERNEL,
+					get_order(conn->max_recv_dlength));
+	if (!conn->data)
+		goto max_recv_dlenght_alloc_fault;
+
+	init_timer(&conn->tmabort_timer);
+	init_MUTEX(&conn->xmitsema);
+	init_waitqueue_head(&conn->ehwait);
+
+	return iscsi_handle(conn);
+
+max_recv_dlenght_alloc_fault:
+	spin_lock_bh(&session->lock);
+	__kfifo_put(session->immpool.queue, (void*)&conn->login_mtask,
+		    sizeof(void*));
+	spin_unlock_bh(&session->lock);
+login_mtask_alloc_fault:
+	kfifo_free(conn->immqueue);
+immqueue_alloc_fault:
+	kfifo_free(conn->writequeue);
+writequeue_alloc_fault:
+	kfifo_free(conn->xmitqueue);
+xmitqueue_alloc_fault:
+	kfree(conn);
+conn_alloc_fault:
+	return iscsi_handle(NULL);
+}
+
+/*
+ * Terminate connection queues, free all associated resources.
+ */
+static void
+iscsi_conn_destroy(iscsi_cnx_h cnxh)
+{
+	struct iscsi_conn *conn = iscsi_ptr(cnxh);
+	struct iscsi_session *session = conn->session;
+
+	BUG_ON(conn->sock == NULL);
+
+	sock_hold(conn->sock->sk);
+	iscsi_conn_restore_callbacks(conn);
+	sock_put(conn->sock->sk);
+	sock_release(conn->sock);
+
+	del_timer_sync(&conn->tmabort_timer);
+	if (session->leadconn == conn) {
+		/*
+		 * Control plane decided to destroy leading connection?
+		 * Its a signal for us to give up on recovery.
+		 */
+		session->state = ISCSI_STATE_TERMINATE;
+		wake_up(&conn->ehwait);
+	}
+
+	/*
+	 * Block control plane caller (a thread coming from
+	 * a user space) until all the in-progress commands for this connection
+	 * time out or fail.
+	 * We must serialize with xmitwork recv pathes.
+	 */
+	down(&conn->xmitsema);
+	conn->c_stage = ISCSI_CNX_CLEANUP_WAIT;
+	while (1) {
+		spin_lock_bh(&conn->lock);
+		if (!session->host->host_busy) { /* OK for ERL == 0 */
+			spin_unlock_bh(&conn->lock);
+			break;
+		}
+		spin_unlock_bh(&conn->lock);
+		msleep_interruptible(500);
+	}
+	up(&conn->xmitsema);
+
+	/* now free crypto */
+	if (conn->hdrdgst_en || conn->datadgst_en) {
+		if (conn->tx_tfm)
+			crypto_free_tfm(conn->tx_tfm);
+		if (conn->rx_tfm)
+			crypto_free_tfm(conn->rx_tfm);
+	}
+
+	/* free conn->data, size = MaxRecvDataSegmentLength */
+	if (conn->max_recv_dlength <= PAGE_SIZE)
+		kfree(conn->data);
+	else
+		free_pages((unsigned long)conn->data,
+					get_order(conn->max_recv_dlength));
+
+	spin_lock_bh(&session->lock);
+	__kfifo_put(session->immpool.queue, (void*)&conn->login_mtask,
+		    sizeof(void*));
+	spin_unlock_bh(&session->lock);
+
+	kfifo_free(conn->xmitqueue);
+	kfifo_free(conn->writequeue);
+	kfifo_free(conn->immqueue);
+
+	spin_lock_bh(&session->conn_lock);
+	list_del(&conn->item);
+	if (list_empty(&session->connections))
+		session->leadconn = NULL;
+	if (session->leadconn && session->leadconn == conn)
+		session->leadconn = container_of(session->connections.next,
+			struct iscsi_conn, item);
+	spin_unlock_bh(&session->conn_lock);
+
+	if (session->leadconn == NULL) {
+		/* non connections exits.. reset sequencing */
+		session->cmdsn = session->max_cmdsn = session->exp_cmdsn = 1;
+	}
+
+	kfree(conn);
+}
+
+static int
+iscsi_conn_bind(iscsi_snx_h snxh, iscsi_cnx_h cnxh, uint32_t transport_fd,
+		int is_leading)
+{
+	struct iscsi_session *session = iscsi_ptr(snxh);
+	struct iscsi_conn *conn = iscsi_ptr(cnxh);
+	struct sock *sk;
+	struct socket *sock;
+	int err;
+
+	if (!(sock = sockfd_lookup(transport_fd, &err))) {
+		printk("iSCSI: sockfd_lookup failed %d\n", err);
+		return -EEXIST;
+	}
+
+	/* bind iSCSI connection and socket */
+	conn->sock = sock;
+
+	/* setup Socket parameters */
+	sk = sock->sk;
+	sk->sk_reuse = 1;
+	sk->sk_sndtimeo = 15 * HZ; /* FIXME: make it configurable */
+	sk->sk_allocation = GFP_ATOMIC;
+
+	/* FIXME: disable Nagle's algorithm */
+
+	/* Intercept TCP callbacks for sendfile like receive processing. */
+	iscsi_conn_set_callbacks(conn);
+
+	/*
+	 * bind new iSCSI connection to session
+	 */
+	conn->session = session;
+
+	spin_lock_bh(&session->conn_lock);
+	list_add(&conn->item, &session->connections);
+	spin_unlock_bh(&session->conn_lock);
+
+	if (is_leading)
+		session->leadconn = conn;
+
+	return 0;
+}
+
+static int
+iscsi_conn_start(iscsi_cnx_h cnxh)
+{
+	struct iscsi_conn *conn = iscsi_ptr(cnxh);
+	struct iscsi_session *session = conn->session;
+
+	if (session == NULL) {
+		printk("iSCSI: can't start not-binded connection\n");
+		return -EPERM;
+	}
+
+	if (session->state == ISCSI_STATE_LOGGED_IN &&
+	    session->leadconn == conn) {
+		scsi_scan_host(session->host);
+	}
+
+	spin_lock_bh(&session->lock);
+	conn->c_stage = ISCSI_CNX_STARTED;
+	conn->cpu = session->conn_cnt % num_online_cpus();
+	session->state = ISCSI_STATE_LOGGED_IN;
+	session->conn_cnt++;
+	spin_unlock_bh(&session->lock);
+
+	return 0;
+}
+
+static void
+iscsi_conn_stop(iscsi_cnx_h cnxh)
+{
+	struct iscsi_conn *conn = iscsi_ptr(cnxh);
+	struct iscsi_session *session = conn->session;
+
+	spin_lock_bh(&session->lock);
+	conn->c_stage = ISCSI_CNX_STOPPED;
+	conn->suspend = 1;
+	session->conn_cnt--;
+
+	if (session->conn_cnt == 0 ||
+	    session->leadconn == conn) {
+		session->state = ISCSI_STATE_FAILED;
+	}
+	spin_unlock_bh(&session->lock);
+}
+
+static int
+iscsi_send_pdu(iscsi_cnx_h cnxh, struct iscsi_hdr *hdr, char *data,
+		  uint32_t data_size)
+{
+	struct iscsi_conn *conn = iscsi_ptr(cnxh);
+	struct iscsi_session *session = conn->session;
+	struct iscsi_mgmt_task *mtask;
+	char *pdu_data = NULL;
+
+	/* FIXME: non-immediate control commands are not supported yet */
+	BUG_ON(!(hdr->opcode & ISCSI_OP_IMMEDIATE));
+
+	if (data_size) {
+		pdu_data = kmalloc(data_size, GFP_KERNEL);
+		if (!pdu_data)
+			return -ENOMEM;
+	}
+
+	spin_lock_bh(&session->lock);
+	if (conn->c_stage != ISCSI_CNX_INITIAL_STAGE) {
+		int exp_statsn;
+
+		if (!__kfifo_get(session->immpool.queue, (void*)&mtask,
+				 sizeof(void*))) {
+			spin_unlock_bh(&session->lock);
+			return -ENOSPC;
+		}
+
+		/*
+		 * Check previous ExpStatSN. Free associated resources.
+		 */
+		exp_statsn = ((struct iscsi_nopout*)&mtask->hdr)->exp_statsn;
+		if ((int)(conn->exp_statsn - exp_statsn) <= 0) {
+			if (mtask->data) {
+				kfree(mtask->data);
+				mtask->data = NULL;
+				mtask->data_count = 0;
+			}
+		}
+	} else {
+		/*
+		 * Preserve ITT for all requests within this
+		 * login or text negotiation sequence. Note that mtask is
+		 * preallocated at cnx_create() and will be released
+		 * at cnx_start() or cnx_destroy().
+		 */
+		mtask = conn->login_mtask;
+	}
+
+	/*
+	 * pre-format CmdSN and ExpStatSN for outgoing PDU.
+	 */
+	if (hdr->itt != ISCSI_RESERVED_TAG) {
+		hdr->itt = htonl(mtask->itt);
+		((struct iscsi_nopout*)hdr)->cmdsn = htonl(session->cmdsn);
+		if (conn->c_stage == ISCSI_CNX_STARTED) {
+			session->cmdsn++;
+		}
+	} else {
+		/* do not advance CmdSN */
+		((struct iscsi_nopout*)hdr)->cmdsn = htonl(session->cmdsn);
+	}
+	((struct iscsi_nopout*)hdr)->exp_statsn = htonl(conn->exp_statsn);
+
+	memcpy(&mtask->hdr, hdr, sizeof(struct iscsi_hdr));
+
+	if (conn->c_stage != ISCSI_CNX_INITIAL_STAGE) {
+		iscsi_buf_init_hdr(conn, &mtask->headbuf, (char*)&mtask->hdr,
+				    (u8 *)mtask->hdrext);
+	} else {
+		iscsi_buf_init_virt(&mtask->headbuf, (char*)&mtask->hdr,
+				    sizeof(struct iscsi_hdr));
+	}
+	spin_unlock_bh(&session->lock);
+
+	if (mtask->data) {
+		kfree(mtask->data);
+		mtask->data = NULL;
+		mtask->data_count = 0;
+	}
+
+	if (data_size) {
+		memcpy(pdu_data, data, data_size);
+		mtask->data = pdu_data;
+		mtask->data_count = data_size;
+	}
+
+	mtask->xmstate = XMSTATE_IMM_HDR;
+
+	if (mtask->data_count) {
+		iscsi_buf_init_virt(&mtask->sendbuf, (char*)mtask->data,
+				    mtask->data_count);
+		/* FIXME: implement: convertion of mtask->data into 1st
+		 *        mtask->sendbuf. Keep in mind that virtual buffer
+		 *        could be spreaded accross multiple pages... */
+		if(mtask->sendbuf.sg.offset + mtask->data_count > PAGE_SIZE) {
+			if (conn->c_stage == ISCSI_CNX_STARTED) {
+				spin_lock_bh(&session->lock);
+				__kfifo_put(session->immpool.queue,
+					    (void*)&mtask, sizeof(void*));
+				spin_unlock_bh(&session->lock);
+			}
+			return -ENOMEM;
+		}
+	}
+
+	debug_scsi("immpdu [op 0x%x itt 0x%x datalen %d]\n",
+		   hdr->opcode, ntohl(hdr->itt), data_size);
+
+	__kfifo_put(conn->immqueue, (void*)&mtask, sizeof(void*));
+	schedule_work(&conn->xmitwork);
+
+	return 0;
+}
+
+static void
+iscsi_tmabort_timedout(unsigned long data)
+{
+	struct iscsi_cmd_task *ctask = (struct iscsi_cmd_task *)data;
+	struct iscsi_conn *conn = ctask->conn;
+
+	conn->tmabort_state = TMABORT_TIMEDOUT;
+	debug_scsi("tmabort timedout [sc %lx itt 0x%x]\n", (long)ctask->sc,
+		   ctask->itt);
+}
+
+static int
+iscsi_eh_abort(struct scsi_cmnd *sc)
+{
+	int rc;
+	struct iscsi_cmd_task *ctask = (struct iscsi_cmd_task *)sc->SCp.ptr;
+	struct iscsi_conn *conn = ctask->conn;
+	struct iscsi_session *session = conn->session;
+
+	spin_unlock_irq(session->host->host_lock);
+
+	debug_scsi("aborting [sc %lx itt 0x%x]\n", (long)sc, ctask->itt);
+
+	/*
+	 * two cases for ERL=0 here:
+	 *
+	 * 1) connection-level failure;
+	 * 2) recovery due protocol error;
+	 */
+	if (session->state != ISCSI_STATE_LOGGED_IN) {
+		if (session->state == ISCSI_STATE_TERMINATE)
+			goto failed;
+	} else {
+		struct iscsi_tm *hdr = &conn->tmhdr;
+
+		/*
+		 * ctask timed out but session is OK
+		 * ERL=0 requires task mgmt abort to be issued on each
+		 * failed command. requests must be serialized.
+		 */
+		memset(hdr, 0, sizeof(struct iscsi_tm));
+		hdr->opcode = ISCSI_OP_SCSI_TMFUNC | ISCSI_OP_IMMEDIATE;
+		hdr->flags = ISCSI_TM_FUNC_ABORT_TASK;
+		hdr->flags |= ISCSI_FLAG_CMD_FINAL;
+		memcpy(hdr->lun, ctask->hdr.lun, 8);
+		hdr->rtt = ctask->hdr.itt;
+		hdr->refcmdsn = ctask->hdr.cmdsn;
+
+		conn->tmabort_state = TMABORT_INITIAL;
+
+		rc = iscsi_send_pdu(iscsi_handle(conn),
+			    (struct iscsi_hdr *)hdr, NULL, 0);
+		if (rc) {
+			session->state = ISCSI_STATE_FAILED;
+			iscsi_control_cnx_error(conn->handle,
+				ISCSI_ERR_CNX_FAILED);
+			debug_scsi("abort sent failure [itt 0x%x]", ctask->itt);
+		} else {
+			conn->tmabort_timer.expires = 3*HZ + jiffies; /*3 secs*/
+			conn->tmabort_timer.function = iscsi_tmabort_timedout;
+			conn->tmabort_timer.data = (unsigned long)ctask;
+			add_timer(&conn->tmabort_timer);
+			debug_scsi("abort sent [itt 0x%x]", ctask->itt);
+		}
+	}
+
+
+	/*
+	 * block eh thread until:
+	 *
+	 * 1) abort response;
+	 * 2) abort timeout;
+	 * 3) session re-opened;
+	 * 4) session terminated;
+	 */
+	while (1) {
+		int p_state = session->state;
+		rc = wait_event_interruptible(conn->ehwait,
+			(p_state == ISCSI_STATE_LOGGED_IN ?
+			 (session->state == ISCSI_STATE_TERMINATE ||
+			  conn->tmabort_state != TMABORT_INITIAL) :
+			 (session->state == ISCSI_STATE_TERMINATE ||
+			  session->state == ISCSI_STATE_LOGGED_IN)));
+		if (rc) {
+			/* shutdown.. */
+			session->state = ISCSI_STATE_TERMINATE;
+			goto failed;
+		}
+
+		if (signal_pending(current))
+			flush_signals(current);
+
+		if (session->state == ISCSI_STATE_TERMINATE)
+			goto failed;
+
+		if (conn->tmabort_state == TMABORT_TIMEDOUT ||
+		    conn->tmabort_state == TMABORT_FAILED) {
+			conn->tmabort_state = TMABORT_INITIAL;
+			session->state = ISCSI_STATE_FAILED;
+			iscsi_control_cnx_error(conn->handle,
+				ISCSI_ERR_CNX_FAILED);
+			continue;
+		}
+
+		break;
+	}
+
+	debug_scsi("abort success [sc %lx itt 0x%x]\n", (long)sc, ctask->itt);
+	BUG_ON(session->state != ISCSI_STATE_LOGGED_IN);
+	spin_lock_irq(session->host->host_lock);
+	return SUCCESS;
+failed:
+	iscsi_ctask_cleanup(conn, ctask);
+	debug_scsi("abort failed [sc %lx itt 0x%x]\n", (long)sc, ctask->itt);
+	spin_lock_irq(session->host->host_lock);
+	return FAILED;
+}
+
+static int
+iscsi_r2tpool_alloc(struct iscsi_session *session)
+{
+	int i;
+	int cmd_i;
+
+	/*
+	 * initialize per-task: R2T pool and xmit queue
+	 */
+	for (cmd_i = 0; cmd_i < session->cmds_max; cmd_i++) {
+	        struct iscsi_cmd_task *ctask = session->cmds[cmd_i];
+
+		/* R2T pool */
+		if (iscsi_pool_init(&ctask->r2tpool, session->max_r2t,
+			(void***)&ctask->r2ts, sizeof(struct iscsi_r2t_info))) {
+			goto r2t_alloc_fault;
+		}
+
+		/* R2T xmit queue */
+		ctask->r2tqueue = kfifo_alloc(session->max_r2t * sizeof(void*),
+						GFP_KERNEL, NULL);
+		if (ctask->r2tqueue == ERR_PTR(-ENOMEM)) {
+			iscsi_pool_free(&ctask->r2tpool, (void**)ctask->r2ts);
+			goto r2t_alloc_fault;
+		}
+
+		/*
+		 * number of
+		 * Data-Out PDU's within R2T-sequence can be quite big;
+		 * using mempool
+		 */
+		ctask->datapool = mempool_create(ISCSI_DTASK_DEFAULT_MAX,
+						 mempool_alloc_slab,
+						 mempool_free_slab,
+						 taskcache);
+		if (ctask->datapool == NULL) {
+			kfifo_free(ctask->r2tqueue);
+			iscsi_pool_free(&ctask->r2tpool, (void**)ctask->r2ts);
+			goto r2t_alloc_fault;
+		}
+		INIT_LIST_HEAD(&ctask->dataqueue);
+	}
+
+	return 0;
+
+r2t_alloc_fault:
+	for (i = 0; i < cmd_i; i++) {
+		mempool_destroy(session->cmds[i]->datapool);
+		kfifo_free(session->cmds[i]->r2tqueue);
+		iscsi_pool_free(&session->cmds[i]->r2tpool,
+				(void**)session->cmds[i]->r2ts);
+	}
+	return -ENOMEM;
+}
+
+static void
+iscsi_r2tpool_free(struct iscsi_session *session)
+{
+	int i;
+
+	for (i = 0; i < session->cmds_max; i++) {
+		mempool_destroy(session->cmds[i]->datapool);
+		kfifo_free(session->cmds[i]->r2tqueue);
+		iscsi_pool_free(&session->cmds[i]->r2tpool,
+				(void**)session->cmds[i]->r2ts);
+	}
+}
+
+static struct scsi_host_template iscsi_sht = {
+	.name			= "iSCSI Initiator over TCP/IP, v."
+				  ISCSI_DRV_VERSION,
+        .queuecommand           = iscsi_queuecommand,
+	.can_queue		= ISCSI_XMIT_CMDS_MAX - 1,
+	.sg_tablesize		= ISCSI_SG_TABLESIZE,
+	.cmd_per_lun		= ISCSI_CMD_PER_LUN,
+        .eh_abort_handler       = iscsi_eh_abort,
+        .use_clustering         = DISABLE_CLUSTERING,
+	.proc_name		= "iscsi_tcp",
+	.this_id		= -1,
+};
+
+static iscsi_snx_h
+iscsi_session_create(iscsi_snx_h handle, uint32_t initial_cmdsn,
+		     uint32_t *host_no)
+{
+	int cmd_i;
+	struct iscsi_session *session;
+	struct Scsi_Host *host;
+	int res;
+
+	/* FIXME: verify "unique-ness" of the session's handle */
+
+	host = scsi_host_alloc(&iscsi_sht, sizeof(struct iscsi_session));
+	if (host == NULL) {
+		printk("can not allocate SCSI host for session %p\n",
+			iscsi_ptr(handle));
+		goto host_alloc_fault;
+	}
+	host->max_id = 1;
+	host->max_channel = 0;
+	session = (struct iscsi_session *)host->hostdata;
+
+	memset(session, 0, sizeof(struct iscsi_session));
+	*host_no = session->id = host->host_no;
+	session->host = host;
+	session->state = ISCSI_STATE_LOGGED_IN;
+	session->imm_max = ISCSI_IMM_CMDS_MAX;
+	session->cmds_max = ISCSI_XMIT_CMDS_MAX;
+	session->cmdsn = initial_cmdsn;
+	session->exp_cmdsn = initial_cmdsn + 1;
+	session->max_cmdsn = initial_cmdsn + 1;
+	session->handle = handle;
+	session->max_r2t = 1;
+
+	/* initialize SCSI PDU commands pool */
+	if (iscsi_pool_init(&session->cmdpool, session->cmds_max,
+		(void***)&session->cmds, sizeof(struct iscsi_cmd_task))) {
+		goto cmdpool_alloc_fault;
+	}
+	/* pre-format cmds pool with ITT */
+	for (cmd_i = 0; cmd_i < session->cmds_max; cmd_i++) {
+		session->cmds[cmd_i]->itt = cmd_i;
+	}
+
+	spin_lock_init(&session->lock);
+	spin_lock_init(&session->conn_lock);
+	INIT_LIST_HEAD(&session->connections);
+
+	/* initialize immediate command pool */
+	if (iscsi_pool_init(&session->immpool, session->imm_max,
+		(void***)&session->imm_cmds, sizeof(struct iscsi_mgmt_task))) {
+		goto immpool_alloc_fault;
+	}
+	/* pre-format immediate cmds pool with ITT */
+	for (cmd_i = 0; cmd_i < session->imm_max; cmd_i++) {
+		session->imm_cmds[cmd_i]->itt = ISCSI_IMM_ITT_OFFSET + cmd_i;
+	}
+
+	if (iscsi_r2tpool_alloc(session))
+		goto r2tpool_alloc_fault;
+
+	res = scsi_add_host(host, NULL);
+	if (res) {
+		printk("can not add host_no %d (%d)\n", *host_no, res);
+		goto add_host_fault;
+	}
+
+	return iscsi_handle(session);
+
+add_host_fault:
+	iscsi_r2tpool_free(session);
+r2tpool_alloc_fault:
+	iscsi_pool_free(&session->immpool, (void**)session->imm_cmds);
+immpool_alloc_fault:
+	iscsi_pool_free(&session->cmdpool, (void**)session->cmds);
+cmdpool_alloc_fault:
+	scsi_host_put(host);
+host_alloc_fault:
+	*host_no = -1;
+	return iscsi_handle(NULL);
+}
+
+static void
+iscsi_session_destroy(iscsi_snx_h snxh)
+{
+	int cmd_i;
+	struct iscsi_data_task *dtask, *n;
+	struct iscsi_session *session = iscsi_ptr(snxh);
+
+	scsi_remove_host(session->host);
+
+	for (cmd_i = 0; cmd_i < session->cmds_max; cmd_i++) {
+		struct iscsi_cmd_task *ctask = session->cmds[cmd_i];
+		list_for_each_entry_safe(dtask, n, &ctask->dataqueue, item) {
+			list_del(&dtask->item);
+			mempool_free(dtask, ctask->datapool);
+		}
+	}
+
+	for (cmd_i = 0; cmd_i < session->imm_max; cmd_i++) {
+		if (session->imm_cmds[cmd_i]->data)
+			kfree(session->imm_cmds[cmd_i]->data);
+	}
+
+	iscsi_r2tpool_free(session);
+	iscsi_pool_free(&session->immpool, (void**)session->imm_cmds);
+	iscsi_pool_free(&session->cmdpool, (void**)session->cmds);
+	scsi_host_put(session->host);
+}
+
+static int
+iscsi_set_param(iscsi_cnx_h cnxh, iscsi_param_e param, uint32_t value)
+{
+	struct iscsi_conn *conn = iscsi_ptr(cnxh);
+	struct iscsi_session *session = conn->session;
+
+	if (conn->c_stage == ISCSI_CNX_INITIAL_STAGE) {
+		switch(param) {
+		case ISCSI_PARAM_MAX_RECV_DLENGTH: {
+			char *saveptr = conn->data;
+
+			if (value <= PAGE_SIZE)
+				conn->data = kmalloc(value, GFP_KERNEL);
+			else
+				conn->data = (void*)__get_free_pages(GFP_KERNEL,
+					get_order(value));
+			if (conn->data == NULL) {
+				conn->data = saveptr;
+				return -ENOMEM;
+			}
+			if (conn->max_recv_dlength <= PAGE_SIZE)
+				kfree(saveptr);
+			else
+				free_pages((unsigned long)saveptr,
+					get_order(conn->max_recv_dlength));
+			conn->max_recv_dlength = value;
+		}
+		break;
+		case ISCSI_PARAM_MAX_XMIT_DLENGTH:
+			conn->max_xmit_dlength = value;
+			break;
+		case ISCSI_PARAM_HDRDGST_EN:
+			conn->hdrdgst_en = value;
+			conn->hdr_size = sizeof(struct iscsi_hdr);
+			if (conn->hdrdgst_en) {
+				conn->hdr_size += sizeof(__u32);
+				if (!conn->tx_tfm)
+					conn->tx_tfm =
+						crypto_alloc_tfm("crc32c", 0);
+				if (!conn->tx_tfm)
+					return -ENOMEM;
+				if (!conn->rx_tfm)
+					conn->rx_tfm =
+						crypto_alloc_tfm("crc32c", 0);
+				if (!conn->rx_tfm) {
+					crypto_free_tfm(conn->tx_tfm);
+					return -ENOMEM;
+				}
+			} else {
+				if (conn->tx_tfm)
+					crypto_free_tfm(conn->tx_tfm);
+				if (conn->rx_tfm)
+					crypto_free_tfm(conn->rx_tfm);
+			}
+			break;
+		case ISCSI_PARAM_DATADGST_EN:
+			if (conn->datadgst_en)
+				return -EPERM;
+			conn->datadgst_en = value;
+			break;
+		case ISCSI_PARAM_INITIAL_R2T_EN:
+			session->initial_r2t_en = value;
+			break;
+		case ISCSI_PARAM_MAX_R2T:
+			iscsi_r2tpool_free(session);
+			session->max_r2t = value;
+			if (session->max_r2t & (session->max_r2t - 1)) {
+				session->max_r2t =
+					roundup_pow_of_two(session->max_r2t);
+			}
+			if (iscsi_r2tpool_alloc(session))
+				return -ENOMEM;
+			break;
+		case ISCSI_PARAM_IMM_DATA_EN:
+			session->imm_data_en = value;
+			break;
+		case ISCSI_PARAM_FIRST_BURST:
+			session->first_burst = value;
+			break;
+		case ISCSI_PARAM_MAX_BURST:
+			session->max_burst = value;
+			break;
+		case ISCSI_PARAM_PDU_INORDER_EN:
+			session->pdu_inorder_en = value;
+			break;
+		case ISCSI_PARAM_DATASEQ_INORDER_EN:
+			session->dataseq_inorder_en = value;
+			break;
+		case ISCSI_PARAM_ERL:
+			session->erl = value;
+			break;
+		case ISCSI_PARAM_IFMARKER_EN:
+			session->ifmarker_en = value;
+			break;
+		case ISCSI_PARAM_OFMARKER_EN:
+			session->ifmarker_en = value;
+			break;
+		default:
+			break;
+		}
+	} else {
+		printk("iSCSI: can not change parameter [%d]\n", param);
+	}
+
+	return 0;
+}
+
+struct iscsi_transport iscsi_tcp_transport = {
+	.name                   = "tcp",
+	.caps                   = CAP_RECOVERY_L0 | CAP_MULTI_R2T,
+	.create_session         = iscsi_session_create,
+	.destroy_session        = iscsi_session_destroy,
+	.create_cnx             = iscsi_conn_create,
+	.bind_cnx               = iscsi_conn_bind,
+	.destroy_cnx            = iscsi_conn_destroy,
+	.set_param              = iscsi_set_param,
+	.start_cnx              = iscsi_conn_start,
+	.stop_cnx               = iscsi_conn_stop,
+	.send_pdu               = iscsi_send_pdu,
+};
+
+static int __init
+iscsi_tcp_init(void)
+{
+	int error;
+
+	taskcache = kmem_cache_create("iscsi_taskcache",
+			sizeof(struct iscsi_data_task), 0, 0, NULL, NULL);
+	if (!taskcache)
+		return -ENOMEM;
+
+	error = iscsi_register_transport(&iscsi_tcp_transport, 0);
+	if (error)
+		kmem_cache_destroy(taskcache);
+
+	return error;
+}
+
+static void __exit
+iscsi_tcp_exit(void)
+{
+	iscsi_unregister_transport(0);
+	kmem_cache_destroy(taskcache);
+}
+
+module_init(iscsi_tcp_init);
+module_exit(iscsi_tcp_exit);
diff -Nru --exclude Kconfig --exclude Makefile linux-2.6.11.orig/drivers/scsi/iscsi_tcp.h linux-2.6.11.dima/drivers/scsi/iscsi_tcp.h
--- linux-2.6.11.orig/drivers/scsi/iscsi_tcp.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.11.dima/drivers/scsi/iscsi_tcp.h	2005-03-04 17:50:11.134414145 -0800
@@ -0,0 +1,283 @@
+/*
+ * iSCSI Initiator TCP Transport
+ * Copyright (C) 2004 Dmitry Yusupov, Alex Aizman
+ * maintained by open-iscsi@@googlegroups.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * See the file COPYING included with this distribution for more details.
+ */
+
+#ifndef ISCSI_TCP_H
+#define ISCSI_TCP_H
+
+#include <scsi/iscsi_if.h>
+
+/* Session's states */
+#define ISCSI_STATE_FREE	1
+#define ISCSI_STATE_LOGGED_IN	2
+#define ISCSI_STATE_FAILED	3
+#define ISCSI_STATE_TERMINATE	4
+
+/* Connection's states */
+#define ISCSI_CNX_INITIAL_STAGE		0
+#define ISCSI_CNX_STARTED		1
+#define ISCSI_CNX_STOPPED		2
+#define ISCSI_CNX_CLEANUP_WAIT		3
+
+/* Socket's Receive state machine */
+#define IN_PROGRESS_WAIT_HEADER		0x0
+#define IN_PROGRESS_HEADER_GATHER	0x1
+#define IN_PROGRESS_DATA_RECV		0x2
+
+/* Socket's Xmit state machine */
+#define IN_PROGRESS_XMIT_IMM		0x0
+#define IN_PROGRESS_XMIT_SCSI		0x1
+
+/* Task Mgmt states */
+#define	TMABORT_INITIAL			0x0
+#define	TMABORT_SUCCESS			0x1
+#define	TMABORT_FAILED			0x2
+#define	TMABORT_TIMEDOUT		0x3
+
+/* iSCSI Task Command's state machine */
+#define IN_PROGRESS_IDLE		0x0
+#define IN_PROGRESS_READ		0x1
+#define IN_PROGRESS_WRITE		0x2
+
+/* xmit state machine */
+#define	XMSTATE_IDLE			0x0
+#define	XMSTATE_R_HDR			0x1
+#define	XMSTATE_W_HDR			0x2
+#define	XMSTATE_IMM_HDR			0x4
+#define	XMSTATE_IMM_DATA		0x8
+#define	XMSTATE_UNS_INIT		0x10
+#define	XMSTATE_UNS_HDR			0x20
+#define	XMSTATE_UNS_DATA		0x40
+#define	XMSTATE_SOL_HDR			0x80
+#define	XMSTATE_SOL_DATA		0x100
+
+#define ISCSI_DRV_VERSION	"0.1"
+#define ISCSI_DEFAULT_PORT	3260
+#define ISCSI_STRING_MAX	255
+#define ISCSI_NODE_NAME_MAX	255
+#define ISCSI_NODE_PORTAL_MAX	32
+#define ISCSI_ALIAS_NAME_MAX	255
+#define ISCSI_CONN_MAX		1
+#define ISCSI_PORTAL_MAX	1
+#define ISCSI_CONN_RCVBUF_MIN	262144
+#define ISCSI_CONN_SNDBUF_MIN	262144
+#define ISCSI_TEXT_SEPARATOR	'='
+#define ISCSI_PAD_LEN		4
+#define ISCSI_DRAFT20_VERSION	0x00
+#define ISCSI_R2T_MAX		16
+#define ISCSI_XMIT_CMDS_MAX	64		/* must be power of 2 */
+#define ISCSI_IMM_CMDS_MAX	32		/* must be power of 2 */
+#define ISCSI_IMM_ITT_OFFSET	0x1000
+#define ISCSI_SG_TABLESIZE	128
+#define ISCSI_CMD_PER_LUN	128
+
+struct iscsi_queue {
+	struct kfifo		*queue;		/* FIFO Queue */
+	void			**pool;		/* Pool of elements */
+	int			max;		/* Max number of elements */
+};
+
+struct iscsi_session;
+struct iscsi_cmd_task;
+struct iscsi_mgmt_task;
+
+/* Socket connection recieve helper */
+struct iscsi_tcp_recv {
+	struct iscsi_hdr	*hdr;
+	struct sk_buff		*skb;
+	int			offset;
+	int			len;
+	int			hdr_offset;
+	int			copy;
+	int			copied;
+	int			padding;
+	struct iscsi_cmd_task	*ctask;		/* current cmd in progress */
+
+	/* copied and flipped values */
+	int			opcode;
+	int			flags;
+	int			cmd_status;
+	int			ahslen;
+	int			datalen;
+	uint32_t		itt;
+};
+
+struct iscsi_conn {
+	struct iscsi_hdr	hdr;		/* Header placeholder */
+	char			hdrext[4*sizeof(__u16) +
+				    sizeof(__u32)];
+	char			*data;		/* Data placeholder */
+	int			data_copied;
+
+	/* iSCSI connection-wide sequencing */
+	uint32_t		exp_statsn;
+	int			hdr_size;	/* PDU Header size pre-calc. */
+
+	/* control data */
+	int			senselen;	/* is data has sense? */
+	int			cpu;		/* binded CPU */
+	int			busy;
+	int			id;		/* iSCSI CID */
+	struct iscsi_tcp_recv	in;		/* TCP receive context */
+	int			in_progress;	/* Connection state machine */
+	int			in_progress_xmit; /* xmit state machine */
+	struct socket           *sock;          /* BSD socket layer */
+	struct iscsi_session	*session;	/* Parent session */
+	struct list_head	item;		/* item's list of connections */
+	struct kfifo		*writequeue;	/* Write response xmit queue */
+	struct kfifo		*immqueue;	/* Immediate xmit queue */
+	struct kfifo		*xmitqueue;	/* Data-path queue */
+	struct work_struct	xmitwork;	/* per-conn. xmit workqueue */
+	volatile int		c_stage;	/* Connection state */
+	iscsi_cnx_h		handle;		/* CP connection handle */
+	struct iscsi_mgmt_task	*login_mtask;	/* mtask used for login/text */
+	spinlock_t		lock;		/* general connection lock */
+	volatile int		suspend;	/* connection suspended */
+	struct crypto_tfm	*tx_tfm;
+	struct crypto_tfm	*rx_tfm;
+	struct iscsi_mgmt_task	*mtask;		/* xmit mtask in progress */
+	struct iscsi_cmd_task	*ctask;		/* xmit ctask in progress */
+	struct semaphore	xmitsema;
+	wait_queue_head_t	ehwait;
+	struct iscsi_tm		tmhdr;
+	volatile int		tmabort_state;
+	struct timer_list	tmabort_timer;
+
+	/* configuration */
+	int			max_recv_dlength;
+	int			max_xmit_dlength;
+	int			hdrdgst_en;
+	int			datadgst_en;
+
+	/* old values for socket callbacks */
+	void			(*old_data_ready)(struct sock *, int);
+	void			(*old_state_change)(struct sock *);
+	void			(*old_write_space)(struct sock *);
+};
+
+struct iscsi_session {
+	/* iSCSI session-wide sequencing */
+	uint32_t		cmdsn;
+	uint32_t		exp_cmdsn;
+	uint32_t		max_cmdsn;
+
+	/* configuration */
+	int			initial_r2t_en;
+	int			max_r2t;
+	int			imm_data_en;
+	int			first_burst;
+	int			max_burst;
+	int			time2wait;
+	int			time2retain;
+	int			pdu_inorder_en;
+	int			dataseq_inorder_en;
+	int			erl;
+	int			ifmarker_en;
+	int			ofmarker_en;
+
+	/* control data */
+	struct Scsi_Host	*host;
+	int			id;
+	struct iscsi_conn	*leadconn;	/* Leading Conn. */
+	spinlock_t		conn_lock;
+	spinlock_t		lock;
+	volatile int		state;
+	struct list_head	item;
+	void			*auth_client;
+	iscsi_snx_h		handle;		/* CP session handle */
+	int			conn_cnt;
+
+	struct list_head	connections;	/* list of connects. */
+	int			cmds_max;	/* size of cmds array */
+	struct iscsi_cmd_task	**cmds;		/* Original Cmds arr */
+	struct iscsi_queue	cmdpool;	/* PDU's pool */
+	int			imm_max;	/* size of Imm array */
+	struct iscsi_mgmt_task	**imm_cmds;	/* Original Imm arr */
+	struct iscsi_queue	immpool;	/* Imm PDU's pool */
+};
+
+struct iscsi_buf {
+	struct scatterlist	sg;
+	unsigned int		sent;
+};
+
+struct iscsi_data_task {
+	struct iscsi_data	hdr;			/* PDU */
+	char			hdrext[sizeof(__u32)];	/* Header-Digest */
+	struct list_head	item;			/* data queue item */
+};
+#define ISCSI_DTASK_DEFAULT_MAX	ISCSI_SG_TABLESIZE * PAGE_SIZE / 512
+
+struct iscsi_mgmt_task {
+	struct iscsi_hdr hdr;			/* mgmt. PDU */
+	char		hdrext[sizeof(__u32)];	/* Header-Digest */
+	char		*data;			/* mgmt payload */
+	volatile int	xmstate;		/* mgmt xmit progress */
+	int		data_count;		/* counts data to be sent */
+	struct iscsi_buf headbuf;		/* Header Buffer */
+	struct iscsi_buf sendbuf;		/* in progress buffer */
+	int		sent;
+	uint32_t	itt;			/* this ITT */
+};
+
+struct iscsi_r2t_info {
+	uint32_t		ttt;		/* copied from R2T */
+	uint32_t		exp_statsn;	/* copeid and incr. from R2T */
+	int			data_length;	/* copied from R2T */
+	int			data_offset;	/* copied from R2T */
+	struct iscsi_buf	headbuf;	/* Data-Out Header Buffer */
+	struct iscsi_buf	sendbuf;	/* Data-Out in progress buffer*/
+	int			sent;		/* R2T sequence progress */
+	int			data_count;	/* DATA-Out payload progress */
+	struct scatterlist	*sg;		/* per-R2T SG list */
+	int			solicit_datasn;
+};
+
+struct iscsi_cmd_task {
+	struct iscsi_cmd	hdr;			/* orig. SCSI PDU */
+	char			hdrext[4*sizeof(__u16)+	/* one AHS */
+				    sizeof(__u32)];	/* Header-Digest */
+	int			itt;			/* this ITT */
+	int			datasn;			/* DataSN numbering */
+	struct iscsi_buf	headbuf;		/* Header Buffer */
+	struct iscsi_buf	sendbuf;		/* in progress buffer */
+	int			sent;
+	struct scatterlist	*sg;			/* per-cmd SG list */
+	struct scatterlist	*bad_sg;		/* assert statement */
+	int			sg_count;		/* SG's to process */
+	uint32_t		unsol_datasn;
+	uint32_t		exp_r2tsn;
+	volatile int		in_progress;		/* State machine */
+	volatile int		xmstate;		/* Xmit State machine */
+	int			imm_count;		/* Imm-Data bytes */
+	int			unsol_count;		/* Imm-Data-Out bytes */
+	int			r2t_data_count;		/* R2T Data-Out bytes */
+	int			data_count;		/* Remaining Data-Out */
+	struct scsi_cmnd	*sc;			/* Assoc. SCSI cmnd */
+	int			total_length;
+	int			data_offset;
+	struct iscsi_conn	*conn;			/* used connection */
+
+	struct iscsi_r2t_info	*r2t;			/* in progress R2T */
+	struct iscsi_queue	r2tpool;
+	struct kfifo		*r2tqueue;
+	struct iscsi_r2t_info	**r2ts;
+	struct list_head	dataqueue;		/* Data-Out dataqueue */
+	mempool_t		*datapool;
+};
+
+#endif /* ISCSI_H */










--------------030602010001040304000502--
