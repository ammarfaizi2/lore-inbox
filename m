Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936337AbWK3MTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936337AbWK3MTt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936333AbWK3MT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:19:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45707 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936329AbWK3MTL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:19:11 -0500
Subject: [DLM] Add support for tcp communications [38/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Patrick Caulfield <pcaulfie@redhat.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:19:08 +0000
Message-Id: <1164889148.3752.381.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From fdda387f73947e6ae511ec601f5b3c6fbb582aac Mon Sep 17 00:00:00 2001
From: Patrick Caulfield <pcaulfie@redhat.com>
Date: Thu, 2 Nov 2006 11:19:21 -0500
Subject: [PATCH] [DLM] Add support for tcp communications

The following patch adds a TCP based communications layer
to the DLM which is compile time selectable. The existing SCTP
layer gives the advantage of allowing multihoming, whereas
the TCP layer has been heavily tested in previous versions of
the DLM and is known to be robust and therefore can be used as
a baseline for performance testing.

Signed-off-by: Patrick Caulfield <pcaulfie@redhat.com>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/dlm/Kconfig         |   17 +
 fs/dlm/Makefile        |    4 
 fs/dlm/lowcomms-sctp.c | 1239 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/dlm/lowcomms-tcp.c  | 1263 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/dlm/lowcomms.c      | 1239 -----------------------------------------------
 5 files changed, 2522 insertions(+), 1240 deletions(-)

diff --git a/fs/dlm/Kconfig b/fs/dlm/Kconfig
index 81b2c64..c5985b8 100644
--- a/fs/dlm/Kconfig
+++ b/fs/dlm/Kconfig
@@ -9,6 +9,23 @@ config DLM
 	A general purpose distributed lock manager for kernel or userspace
 	applications.
 
+choice
+	prompt "Select DLM communications protocol"
+	depends on DLM
+	default DLM_TCP
+	help
+	The DLM Can use TCP or SCTP for it's network communications.
+	SCTP supports multi-homed operations whereas TCP doesn't.
+	However, SCTP seems to have stability problems at the moment.
+
+config DLM_TCP
+	bool "TCP/IP"
+
+config DLM_SCTP
+	bool "SCTP"
+
+endchoice
+
 config DLM_DEBUG
 	bool "DLM debugging"
 	depends on DLM
diff --git a/fs/dlm/Makefile b/fs/dlm/Makefile
index 1832e02..6538894 100644
--- a/fs/dlm/Makefile
+++ b/fs/dlm/Makefile
@@ -4,7 +4,6 @@ dlm-y :=			ast.o \
 				dir.o \
 				lock.o \
 				lockspace.o \
-				lowcomms.o \
 				main.o \
 				member.o \
 				memory.o \
@@ -17,3 +16,6 @@ dlm-y :=			ast.o \
 				util.o
 dlm-$(CONFIG_DLM_DEBUG) +=	debug_fs.o
 
+dlm-$(CONFIG_DLM_TCP)   += lowcomms-tcp.o
+
+dlm-$(CONFIG_DLM_SCTP)  += lowcomms-sctp.o
\ No newline at end of file
diff --git a/fs/dlm/lowcomms-sctp.c b/fs/dlm/lowcomms-sctp.c
new file mode 100644
index 0000000..6da6b14
--- /dev/null
+++ b/fs/dlm/lowcomms-sctp.c
@@ -0,0 +1,1239 @@
+/******************************************************************************
+*******************************************************************************
+**
+**  Copyright (C) Sistina Software, Inc.  1997-2003  All rights reserved.
+**  Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+**
+**  This copyrighted material is made available to anyone wishing to use,
+**  modify, copy, or redistribute it subject to the terms and conditions
+**  of the GNU General Public License v.2.
+**
+*******************************************************************************
+******************************************************************************/
+
+/*
+ * lowcomms.c
+ *
+ * This is the "low-level" comms layer.
+ *
+ * It is responsible for sending/receiving messages
+ * from other nodes in the cluster.
+ *
+ * Cluster nodes are referred to by their nodeids. nodeids are
+ * simply 32 bit numbers to the locking module - if they need to
+ * be expanded for the cluster infrastructure then that is it's
+ * responsibility. It is this layer's
+ * responsibility to resolve these into IP address or
+ * whatever it needs for inter-node communication.
+ *
+ * The comms level is two kernel threads that deal mainly with
+ * the receiving of messages from other nodes and passing them
+ * up to the mid-level comms layer (which understands the
+ * message format) for execution by the locking core, and
+ * a send thread which does all the setting up of connections
+ * to remote nodes and the sending of data. Threads are not allowed
+ * to send their own data because it may cause them to wait in times
+ * of high load. Also, this way, the sending thread can collect together
+ * messages bound for one node and send them in one block.
+ *
+ * I don't see any problem with the recv thread executing the locking
+ * code on behalf of remote processes as the locking code is
+ * short, efficient and never (well, hardly ever) waits.
+ *
+ */
+
+#include <asm/ioctls.h>
+#include <net/sock.h>
+#include <net/tcp.h>
+#include <net/sctp/user.h>
+#include <linux/pagemap.h>
+#include <linux/socket.h>
+#include <linux/idr.h>
+
+#include "dlm_internal.h"
+#include "lowcomms.h"
+#include "config.h"
+#include "midcomms.h"
+
+static struct sockaddr_storage *dlm_local_addr[DLM_MAX_ADDR_COUNT];
+static int			dlm_local_count;
+static int			dlm_local_nodeid;
+
+/* One of these per connected node */
+
+#define NI_INIT_PENDING 1
+#define NI_WRITE_PENDING 2
+
+struct nodeinfo {
+	spinlock_t		lock;
+	sctp_assoc_t		assoc_id;
+	unsigned long		flags;
+	struct list_head	write_list; /* nodes with pending writes */
+	struct list_head	writequeue; /* outgoing writequeue_entries */
+	spinlock_t		writequeue_lock;
+	int			nodeid;
+};
+
+static DEFINE_IDR(nodeinfo_idr);
+static struct rw_semaphore	nodeinfo_lock;
+static int			max_nodeid;
+
+struct cbuf {
+	unsigned		base;
+	unsigned		len;
+	unsigned		mask;
+};
+
+/* Just the one of these, now. But this struct keeps
+   the connection-specific variables together */
+
+#define CF_READ_PENDING 1
+
+struct connection {
+	struct socket          *sock;
+	unsigned long		flags;
+	struct page            *rx_page;
+	atomic_t		waiting_requests;
+	struct cbuf		cb;
+	int                     eagain_flag;
+};
+
+/* An entry waiting to be sent */
+
+struct writequeue_entry {
+	struct list_head	list;
+	struct page            *page;
+	int			offset;
+	int			len;
+	int			end;
+	int			users;
+	struct nodeinfo        *ni;
+};
+
+#define CBUF_ADD(cb, n) do { (cb)->len += n; } while(0)
+#define CBUF_EMPTY(cb) ((cb)->len == 0)
+#define CBUF_MAY_ADD(cb, n) (((cb)->len + (n)) < ((cb)->mask + 1))
+#define CBUF_DATA(cb) (((cb)->base + (cb)->len) & (cb)->mask)
+
+#define CBUF_INIT(cb, size) \
+do { \
+	(cb)->base = (cb)->len = 0; \
+	(cb)->mask = ((size)-1); \
+} while(0)
+
+#define CBUF_EAT(cb, n) \
+do { \
+	(cb)->len  -= (n); \
+	(cb)->base += (n); \
+	(cb)->base &= (cb)->mask; \
+} while(0)
+
+
+/* List of nodes which have writes pending */
+static struct list_head write_nodes;
+static spinlock_t write_nodes_lock;
+
+/* Maximum number of incoming messages to process before
+ * doing a schedule()
+ */
+#define MAX_RX_MSG_COUNT 25
+
+/* Manage daemons */
+static struct task_struct *recv_task;
+static struct task_struct *send_task;
+static wait_queue_head_t lowcomms_recv_wait;
+static atomic_t accepting;
+
+/* The SCTP connection */
+static struct connection sctp_con;
+
+
+static int nodeid_to_addr(int nodeid, struct sockaddr *retaddr)
+{
+	struct sockaddr_storage addr;
+	int error;
+
+	if (!dlm_local_count)
+		return -1;
+
+	error = dlm_nodeid_to_addr(nodeid, &addr);
+	if (error)
+		return error;
+
+	if (dlm_local_addr[0]->ss_family == AF_INET) {
+	        struct sockaddr_in *in4  = (struct sockaddr_in *) &addr;
+		struct sockaddr_in *ret4 = (struct sockaddr_in *) retaddr;
+		ret4->sin_addr.s_addr = in4->sin_addr.s_addr;
+	} else {
+	        struct sockaddr_in6 *in6  = (struct sockaddr_in6 *) &addr;
+		struct sockaddr_in6 *ret6 = (struct sockaddr_in6 *) retaddr;
+		memcpy(&ret6->sin6_addr, &in6->sin6_addr,
+		       sizeof(in6->sin6_addr));
+	}
+
+	return 0;
+}
+
+static struct nodeinfo *nodeid2nodeinfo(int nodeid, gfp_t alloc)
+{
+	struct nodeinfo *ni;
+	int r;
+	int n;
+
+	down_read(&nodeinfo_lock);
+	ni = idr_find(&nodeinfo_idr, nodeid);
+	up_read(&nodeinfo_lock);
+
+	if (!ni && alloc) {
+		down_write(&nodeinfo_lock);
+
+		ni = idr_find(&nodeinfo_idr, nodeid);
+		if (ni)
+			goto out_up;
+
+		r = idr_pre_get(&nodeinfo_idr, alloc);
+		if (!r)
+			goto out_up;
+
+		ni = kmalloc(sizeof(struct nodeinfo), alloc);
+		if (!ni)
+			goto out_up;
+
+		r = idr_get_new_above(&nodeinfo_idr, ni, nodeid, &n);
+		if (r) {
+			kfree(ni);
+			ni = NULL;
+			goto out_up;
+		}
+		if (n != nodeid) {
+			idr_remove(&nodeinfo_idr, n);
+			kfree(ni);
+			ni = NULL;
+			goto out_up;
+		}
+		memset(ni, 0, sizeof(struct nodeinfo));
+		spin_lock_init(&ni->lock);
+		INIT_LIST_HEAD(&ni->writequeue);
+		spin_lock_init(&ni->writequeue_lock);
+		ni->nodeid = nodeid;
+
+		if (nodeid > max_nodeid)
+			max_nodeid = nodeid;
+	out_up:
+		up_write(&nodeinfo_lock);
+	}
+
+	return ni;
+}
+
+/* Don't call this too often... */
+static struct nodeinfo *assoc2nodeinfo(sctp_assoc_t assoc)
+{
+	int i;
+	struct nodeinfo *ni;
+
+	for (i=1; i<=max_nodeid; i++) {
+		ni = nodeid2nodeinfo(i, 0);
+		if (ni && ni->assoc_id == assoc)
+			return ni;
+	}
+	return NULL;
+}
+
+/* Data or notification available on socket */
+static void lowcomms_data_ready(struct sock *sk, int count_unused)
+{
+	atomic_inc(&sctp_con.waiting_requests);
+	if (test_and_set_bit(CF_READ_PENDING, &sctp_con.flags))
+		return;
+
+	wake_up_interruptible(&lowcomms_recv_wait);
+}
+
+
+/* Add the port number to an IP6 or 4 sockaddr and return the address length.
+   Also padd out the struct with zeros to make comparisons meaningful */
+
+static void make_sockaddr(struct sockaddr_storage *saddr, uint16_t port,
+			  int *addr_len)
+{
+	struct sockaddr_in *local4_addr;
+	struct sockaddr_in6 *local6_addr;
+
+	if (!dlm_local_count)
+		return;
+
+	if (!port) {
+		if (dlm_local_addr[0]->ss_family == AF_INET) {
+			local4_addr = (struct sockaddr_in *)dlm_local_addr[0];
+			port = be16_to_cpu(local4_addr->sin_port);
+		} else {
+			local6_addr = (struct sockaddr_in6 *)dlm_local_addr[0];
+			port = be16_to_cpu(local6_addr->sin6_port);
+		}
+	}
+
+	saddr->ss_family = dlm_local_addr[0]->ss_family;
+	if (dlm_local_addr[0]->ss_family == AF_INET) {
+		struct sockaddr_in *in4_addr = (struct sockaddr_in *)saddr;
+		in4_addr->sin_port = cpu_to_be16(port);
+		memset(&in4_addr->sin_zero, 0, sizeof(in4_addr->sin_zero));
+		memset(in4_addr+1, 0, sizeof(struct sockaddr_storage) -
+				      sizeof(struct sockaddr_in));
+		*addr_len = sizeof(struct sockaddr_in);
+	} else {
+		struct sockaddr_in6 *in6_addr = (struct sockaddr_in6 *)saddr;
+		in6_addr->sin6_port = cpu_to_be16(port);
+		memset(in6_addr+1, 0, sizeof(struct sockaddr_storage) -
+				      sizeof(struct sockaddr_in6));
+		*addr_len = sizeof(struct sockaddr_in6);
+	}
+}
+
+/* Close the connection and tidy up */
+static void close_connection(void)
+{
+	if (sctp_con.sock) {
+		sock_release(sctp_con.sock);
+		sctp_con.sock = NULL;
+	}
+
+	if (sctp_con.rx_page) {
+		__free_page(sctp_con.rx_page);
+		sctp_con.rx_page = NULL;
+	}
+}
+
+/* We only send shutdown messages to nodes that are not part of the cluster */
+static void send_shutdown(sctp_assoc_t associd)
+{
+	static char outcmsg[CMSG_SPACE(sizeof(struct sctp_sndrcvinfo))];
+	struct msghdr outmessage;
+	struct cmsghdr *cmsg;
+	struct sctp_sndrcvinfo *sinfo;
+	int ret;
+
+	outmessage.msg_name = NULL;
+	outmessage.msg_namelen = 0;
+	outmessage.msg_control = outcmsg;
+	outmessage.msg_controllen = sizeof(outcmsg);
+	outmessage.msg_flags = MSG_EOR;
+
+	cmsg = CMSG_FIRSTHDR(&outmessage);
+	cmsg->cmsg_level = IPPROTO_SCTP;
+	cmsg->cmsg_type = SCTP_SNDRCV;
+	cmsg->cmsg_len = CMSG_LEN(sizeof(struct sctp_sndrcvinfo));
+	outmessage.msg_controllen = cmsg->cmsg_len;
+	sinfo = (struct sctp_sndrcvinfo *)CMSG_DATA(cmsg);
+	memset(sinfo, 0x00, sizeof(struct sctp_sndrcvinfo));
+
+	sinfo->sinfo_flags |= MSG_EOF;
+	sinfo->sinfo_assoc_id = associd;
+
+	ret = kernel_sendmsg(sctp_con.sock, &outmessage, NULL, 0, 0);
+
+	if (ret != 0)
+		log_print("send EOF to node failed: %d", ret);
+}
+
+
+/* INIT failed but we don't know which node...
+   restart INIT on all pending nodes */
+static void init_failed(void)
+{
+	int i;
+	struct nodeinfo *ni;
+
+	for (i=1; i<=max_nodeid; i++) {
+		ni = nodeid2nodeinfo(i, 0);
+		if (!ni)
+			continue;
+
+		if (test_and_clear_bit(NI_INIT_PENDING, &ni->flags)) {
+			ni->assoc_id = 0;
+			if (!test_and_set_bit(NI_WRITE_PENDING, &ni->flags)) {
+				spin_lock_bh(&write_nodes_lock);
+				list_add_tail(&ni->write_list, &write_nodes);
+				spin_unlock_bh(&write_nodes_lock);
+			}
+		}
+	}
+	wake_up_process(send_task);
+}
+
+/* Something happened to an association */
+static void process_sctp_notification(struct msghdr *msg, char *buf)
+{
+	union sctp_notification *sn = (union sctp_notification *)buf;
+
+	if (sn->sn_header.sn_type == SCTP_ASSOC_CHANGE) {
+		switch (sn->sn_assoc_change.sac_state) {
+
+		case SCTP_COMM_UP:
+		case SCTP_RESTART:
+		{
+			/* Check that the new node is in the lockspace */
+			struct sctp_prim prim;
+			mm_segment_t fs;
+			int nodeid;
+			int prim_len, ret;
+			int addr_len;
+			struct nodeinfo *ni;
+
+			/* This seems to happen when we received a connection
+			 * too early... or something...  anyway, it happens but
+			 * we always seem to get a real message too, see
+			 * receive_from_sock */
+
+			if ((int)sn->sn_assoc_change.sac_assoc_id <= 0) {
+				log_print("COMM_UP for invalid assoc ID %d",
+					 (int)sn->sn_assoc_change.sac_assoc_id);
+				init_failed();
+				return;
+			}
+			memset(&prim, 0, sizeof(struct sctp_prim));
+			prim_len = sizeof(struct sctp_prim);
+			prim.ssp_assoc_id = sn->sn_assoc_change.sac_assoc_id;
+
+			fs = get_fs();
+			set_fs(get_ds());
+			ret = sctp_con.sock->ops->getsockopt(sctp_con.sock,
+						IPPROTO_SCTP, SCTP_PRIMARY_ADDR,
+						(char*)&prim, &prim_len);
+			set_fs(fs);
+			if (ret < 0) {
+				struct nodeinfo *ni;
+
+				log_print("getsockopt/sctp_primary_addr on "
+					  "new assoc %d failed : %d",
+				    (int)sn->sn_assoc_change.sac_assoc_id, ret);
+
+				/* Retry INIT later */
+				ni = assoc2nodeinfo(sn->sn_assoc_change.sac_assoc_id);
+				if (ni)
+					clear_bit(NI_INIT_PENDING, &ni->flags);
+				return;
+			}
+			make_sockaddr(&prim.ssp_addr, 0, &addr_len);
+			if (dlm_addr_to_nodeid(&prim.ssp_addr, &nodeid)) {
+				log_print("reject connect from unknown addr");
+				send_shutdown(prim.ssp_assoc_id);
+				return;
+			}
+
+			ni = nodeid2nodeinfo(nodeid, GFP_KERNEL);
+			if (!ni)
+				return;
+
+			/* Save the assoc ID */
+			spin_lock(&ni->lock);
+			ni->assoc_id = sn->sn_assoc_change.sac_assoc_id;
+			spin_unlock(&ni->lock);
+
+			log_print("got new/restarted association %d nodeid %d",
+			       (int)sn->sn_assoc_change.sac_assoc_id, nodeid);
+
+			/* Send any pending writes */
+			clear_bit(NI_INIT_PENDING, &ni->flags);
+			if (!test_and_set_bit(NI_WRITE_PENDING, &ni->flags)) {
+				spin_lock_bh(&write_nodes_lock);
+				list_add_tail(&ni->write_list, &write_nodes);
+				spin_unlock_bh(&write_nodes_lock);
+			}
+			wake_up_process(send_task);
+		}
+		break;
+
+		case SCTP_COMM_LOST:
+		case SCTP_SHUTDOWN_COMP:
+		{
+			struct nodeinfo *ni;
+
+			ni = assoc2nodeinfo(sn->sn_assoc_change.sac_assoc_id);
+			if (ni) {
+				spin_lock(&ni->lock);
+				ni->assoc_id = 0;
+				spin_unlock(&ni->lock);
+			}
+		}
+		break;
+
+		/* We don't know which INIT failed, so clear the PENDING flags
+		 * on them all.  if assoc_id is zero then it will then try
+		 * again */
+
+		case SCTP_CANT_STR_ASSOC:
+		{
+			log_print("Can't start SCTP association - retrying");
+			init_failed();
+		}
+		break;
+
+		default:
+			log_print("unexpected SCTP assoc change id=%d state=%d",
+				  (int)sn->sn_assoc_change.sac_assoc_id,
+				  sn->sn_assoc_change.sac_state);
+		}
+	}
+}
+
+/* Data received from remote end */
+static int receive_from_sock(void)
+{
+	int ret = 0;
+	struct msghdr msg;
+	struct kvec iov[2];
+	unsigned len;
+	int r;
+	struct sctp_sndrcvinfo *sinfo;
+	struct cmsghdr *cmsg;
+	struct nodeinfo *ni;
+
+	/* These two are marginally too big for stack allocation, but this
+	 * function is (currently) only called by dlm_recvd so static should be
+	 * OK.
+	 */
+	static struct sockaddr_storage msgname;
+	static char incmsg[CMSG_SPACE(sizeof(struct sctp_sndrcvinfo))];
+
+	if (sctp_con.sock == NULL)
+		goto out;
+
+	if (sctp_con.rx_page == NULL) {
+		/*
+		 * This doesn't need to be atomic, but I think it should
+		 * improve performance if it is.
+		 */
+		sctp_con.rx_page = alloc_page(GFP_ATOMIC);
+		if (sctp_con.rx_page == NULL)
+			goto out_resched;
+		CBUF_INIT(&sctp_con.cb, PAGE_CACHE_SIZE);
+	}
+
+	memset(&incmsg, 0, sizeof(incmsg));
+	memset(&msgname, 0, sizeof(msgname));
+
+	memset(incmsg, 0, sizeof(incmsg));
+	msg.msg_name = &msgname;
+	msg.msg_namelen = sizeof(msgname);
+	msg.msg_flags = 0;
+	msg.msg_control = incmsg;
+	msg.msg_controllen = sizeof(incmsg);
+	msg.msg_iovlen = 1;
+
+	/* I don't see why this circular buffer stuff is necessary for SCTP
+	 * which is a packet-based protocol, but the whole thing breaks under
+	 * load without it! The overhead is minimal (and is in the TCP lowcomms
+	 * anyway, of course) so I'll leave it in until I can figure out what's
+	 * really happening.
+	 */
+
+	/*
+	 * iov[0] is the bit of the circular buffer between the current end
+	 * point (cb.base + cb.len) and the end of the buffer.
+	 */
+	iov[0].iov_len = sctp_con.cb.base - CBUF_DATA(&sctp_con.cb);
+	iov[0].iov_base = page_address(sctp_con.rx_page) +
+			  CBUF_DATA(&sctp_con.cb);
+	iov[1].iov_len = 0;
+
+	/*
+	 * iov[1] is the bit of the circular buffer between the start of the
+	 * buffer and the start of the currently used section (cb.base)
+	 */
+	if (CBUF_DATA(&sctp_con.cb) >= sctp_con.cb.base) {
+		iov[0].iov_len = PAGE_CACHE_SIZE - CBUF_DATA(&sctp_con.cb);
+		iov[1].iov_len = sctp_con.cb.base;
+		iov[1].iov_base = page_address(sctp_con.rx_page);
+		msg.msg_iovlen = 2;
+	}
+	len = iov[0].iov_len + iov[1].iov_len;
+
+	r = ret = kernel_recvmsg(sctp_con.sock, &msg, iov, msg.msg_iovlen, len,
+				 MSG_NOSIGNAL | MSG_DONTWAIT);
+	if (ret <= 0)
+		goto out_close;
+
+	msg.msg_control = incmsg;
+	msg.msg_controllen = sizeof(incmsg);
+	cmsg = CMSG_FIRSTHDR(&msg);
+	sinfo = (struct sctp_sndrcvinfo *)CMSG_DATA(cmsg);
+
+	if (msg.msg_flags & MSG_NOTIFICATION) {
+		process_sctp_notification(&msg, page_address(sctp_con.rx_page));
+		return 0;
+	}
+
+	/* Is this a new association ? */
+	ni = nodeid2nodeinfo(le32_to_cpu(sinfo->sinfo_ppid), GFP_KERNEL);
+	if (ni) {
+		ni->assoc_id = sinfo->sinfo_assoc_id;
+		if (test_and_clear_bit(NI_INIT_PENDING, &ni->flags)) {
+
+			if (!test_and_set_bit(NI_WRITE_PENDING, &ni->flags)) {
+				spin_lock_bh(&write_nodes_lock);
+				list_add_tail(&ni->write_list, &write_nodes);
+				spin_unlock_bh(&write_nodes_lock);
+			}
+			wake_up_process(send_task);
+		}
+	}
+
+	/* INIT sends a message with length of 1 - ignore it */
+	if (r == 1)
+		return 0;
+
+	CBUF_ADD(&sctp_con.cb, ret);
+	ret = dlm_process_incoming_buffer(cpu_to_le32(sinfo->sinfo_ppid),
+					  page_address(sctp_con.rx_page),
+					  sctp_con.cb.base, sctp_con.cb.len,
+					  PAGE_CACHE_SIZE);
+	if (ret < 0)
+		goto out_close;
+	CBUF_EAT(&sctp_con.cb, ret);
+
+      out:
+	ret = 0;
+	goto out_ret;
+
+      out_resched:
+	lowcomms_data_ready(sctp_con.sock->sk, 0);
+	ret = 0;
+	schedule();
+	goto out_ret;
+
+      out_close:
+	if (ret != -EAGAIN)
+		log_print("error reading from sctp socket: %d", ret);
+      out_ret:
+	return ret;
+}
+
+/* Bind to an IP address. SCTP allows multiple address so it can do multi-homing */
+static int add_bind_addr(struct sockaddr_storage *addr, int addr_len, int num)
+{
+	mm_segment_t fs;
+	int result = 0;
+
+	fs = get_fs();
+	set_fs(get_ds());
+	if (num == 1)
+		result = sctp_con.sock->ops->bind(sctp_con.sock,
+					(struct sockaddr *) addr, addr_len);
+	else
+		result = sctp_con.sock->ops->setsockopt(sctp_con.sock, SOL_SCTP,
+				SCTP_SOCKOPT_BINDX_ADD, (char *)addr, addr_len);
+	set_fs(fs);
+
+	if (result < 0)
+		log_print("Can't bind to port %d addr number %d",
+			  dlm_config.tcp_port, num);
+
+	return result;
+}
+
+static void init_local(void)
+{
+	struct sockaddr_storage sas, *addr;
+	int i;
+
+	dlm_local_nodeid = dlm_our_nodeid();
+
+	for (i = 0; i < DLM_MAX_ADDR_COUNT - 1; i++) {
+		if (dlm_our_addr(&sas, i))
+			break;
+
+		addr = kmalloc(sizeof(*addr), GFP_KERNEL);
+		if (!addr)
+			break;
+		memcpy(addr, &sas, sizeof(*addr));
+		dlm_local_addr[dlm_local_count++] = addr;
+	}
+}
+
+/* Initialise SCTP socket and bind to all interfaces */
+static int init_sock(void)
+{
+	mm_segment_t fs;
+	struct socket *sock = NULL;
+	struct sockaddr_storage localaddr;
+	struct sctp_event_subscribe subscribe;
+	int result = -EINVAL, num = 1, i, addr_len;
+
+	if (!dlm_local_count) {
+		init_local();
+		if (!dlm_local_count) {
+			log_print("no local IP address has been set");
+			goto out;
+		}
+	}
+
+	result = sock_create_kern(dlm_local_addr[0]->ss_family, SOCK_SEQPACKET,
+				  IPPROTO_SCTP, &sock);
+	if (result < 0) {
+		log_print("Can't create comms socket, check SCTP is loaded");
+		goto out;
+	}
+
+	/* Listen for events */
+	memset(&subscribe, 0, sizeof(subscribe));
+	subscribe.sctp_data_io_event = 1;
+	subscribe.sctp_association_event = 1;
+	subscribe.sctp_send_failure_event = 1;
+	subscribe.sctp_shutdown_event = 1;
+	subscribe.sctp_partial_delivery_event = 1;
+
+	fs = get_fs();
+	set_fs(get_ds());
+	result = sock->ops->setsockopt(sock, SOL_SCTP, SCTP_EVENTS,
+				       (char *)&subscribe, sizeof(subscribe));
+	set_fs(fs);
+
+	if (result < 0) {
+		log_print("Failed to set SCTP_EVENTS on socket: result=%d",
+			  result);
+		goto create_delsock;
+	}
+
+	/* Init con struct */
+	sock->sk->sk_user_data = &sctp_con;
+	sctp_con.sock = sock;
+	sctp_con.sock->sk->sk_data_ready = lowcomms_data_ready;
+
+	/* Bind to all interfaces. */
+	for (i = 0; i < dlm_local_count; i++) {
+		memcpy(&localaddr, dlm_local_addr[i], sizeof(localaddr));
+		make_sockaddr(&localaddr, dlm_config.tcp_port, &addr_len);
+
+		result = add_bind_addr(&localaddr, addr_len, num);
+		if (result)
+			goto create_delsock;
+		++num;
+	}
+
+	result = sock->ops->listen(sock, 5);
+	if (result < 0) {
+		log_print("Can't set socket listening");
+		goto create_delsock;
+	}
+
+	return 0;
+
+ create_delsock:
+	sock_release(sock);
+	sctp_con.sock = NULL;
+ out:
+	return result;
+}
+
+
+static struct writequeue_entry *new_writequeue_entry(gfp_t allocation)
+{
+	struct writequeue_entry *entry;
+
+	entry = kmalloc(sizeof(struct writequeue_entry), allocation);
+	if (!entry)
+		return NULL;
+
+	entry->page = alloc_page(allocation);
+	if (!entry->page) {
+		kfree(entry);
+		return NULL;
+	}
+
+	entry->offset = 0;
+	entry->len = 0;
+	entry->end = 0;
+	entry->users = 0;
+
+	return entry;
+}
+
+void *dlm_lowcomms_get_buffer(int nodeid, int len, gfp_t allocation, char **ppc)
+{
+	struct writequeue_entry *e;
+	int offset = 0;
+	int users = 0;
+	struct nodeinfo *ni;
+
+	if (!atomic_read(&accepting))
+		return NULL;
+
+	ni = nodeid2nodeinfo(nodeid, allocation);
+	if (!ni)
+		return NULL;
+
+	spin_lock(&ni->writequeue_lock);
+	e = list_entry(ni->writequeue.prev, struct writequeue_entry, list);
+	if (((struct list_head *) e == &ni->writequeue) ||
+	    (PAGE_CACHE_SIZE - e->end < len)) {
+		e = NULL;
+	} else {
+		offset = e->end;
+		e->end += len;
+		users = e->users++;
+	}
+	spin_unlock(&ni->writequeue_lock);
+
+	if (e) {
+	      got_one:
+		if (users == 0)
+			kmap(e->page);
+		*ppc = page_address(e->page) + offset;
+		return e;
+	}
+
+	e = new_writequeue_entry(allocation);
+	if (e) {
+		spin_lock(&ni->writequeue_lock);
+		offset = e->end;
+		e->end += len;
+		e->ni = ni;
+		users = e->users++;
+		list_add_tail(&e->list, &ni->writequeue);
+		spin_unlock(&ni->writequeue_lock);
+		goto got_one;
+	}
+	return NULL;
+}
+
+void dlm_lowcomms_commit_buffer(void *arg)
+{
+	struct writequeue_entry *e = (struct writequeue_entry *) arg;
+	int users;
+	struct nodeinfo *ni = e->ni;
+
+	if (!atomic_read(&accepting))
+		return;
+
+	spin_lock(&ni->writequeue_lock);
+	users = --e->users;
+	if (users)
+		goto out;
+	e->len = e->end - e->offset;
+	kunmap(e->page);
+	spin_unlock(&ni->writequeue_lock);
+
+	if (!test_and_set_bit(NI_WRITE_PENDING, &ni->flags)) {
+		spin_lock_bh(&write_nodes_lock);
+		list_add_tail(&ni->write_list, &write_nodes);
+		spin_unlock_bh(&write_nodes_lock);
+		wake_up_process(send_task);
+	}
+	return;
+
+      out:
+	spin_unlock(&ni->writequeue_lock);
+	return;
+}
+
+static void free_entry(struct writequeue_entry *e)
+{
+	__free_page(e->page);
+	kfree(e);
+}
+
+/* Initiate an SCTP association. In theory we could just use sendmsg() on
+   the first IP address and it should work, but this allows us to set up the
+   association before sending any valuable data that we can't afford to lose.
+   It also keeps the send path clean as it can now always use the association ID */
+static void initiate_association(int nodeid)
+{
+	struct sockaddr_storage rem_addr;
+	static char outcmsg[CMSG_SPACE(sizeof(struct sctp_sndrcvinfo))];
+	struct msghdr outmessage;
+	struct cmsghdr *cmsg;
+	struct sctp_sndrcvinfo *sinfo;
+	int ret;
+	int addrlen;
+	char buf[1];
+	struct kvec iov[1];
+	struct nodeinfo *ni;
+
+	log_print("Initiating association with node %d", nodeid);
+
+	ni = nodeid2nodeinfo(nodeid, GFP_KERNEL);
+	if (!ni)
+		return;
+
+	if (nodeid_to_addr(nodeid, (struct sockaddr *)&rem_addr)) {
+		log_print("no address for nodeid %d", nodeid);
+		return;
+	}
+
+	make_sockaddr(&rem_addr, dlm_config.tcp_port, &addrlen);
+
+	outmessage.msg_name = &rem_addr;
+	outmessage.msg_namelen = addrlen;
+	outmessage.msg_control = outcmsg;
+	outmessage.msg_controllen = sizeof(outcmsg);
+	outmessage.msg_flags = MSG_EOR;
+
+	iov[0].iov_base = buf;
+	iov[0].iov_len = 1;
+
+	/* Real INIT messages seem to cause trouble. Just send a 1 byte message
+	   we can afford to lose */
+	cmsg = CMSG_FIRSTHDR(&outmessage);
+	cmsg->cmsg_level = IPPROTO_SCTP;
+	cmsg->cmsg_type = SCTP_SNDRCV;
+	cmsg->cmsg_len = CMSG_LEN(sizeof(struct sctp_sndrcvinfo));
+	sinfo = (struct sctp_sndrcvinfo *)CMSG_DATA(cmsg);
+	memset(sinfo, 0x00, sizeof(struct sctp_sndrcvinfo));
+	sinfo->sinfo_ppid = cpu_to_le32(dlm_local_nodeid);
+
+	outmessage.msg_controllen = cmsg->cmsg_len;
+	ret = kernel_sendmsg(sctp_con.sock, &outmessage, iov, 1, 1);
+	if (ret < 0) {
+		log_print("send INIT to node failed: %d", ret);
+		/* Try again later */
+		clear_bit(NI_INIT_PENDING, &ni->flags);
+	}
+}
+
+/* Send a message */
+static int send_to_sock(struct nodeinfo *ni)
+{
+	int ret = 0;
+	struct writequeue_entry *e;
+	int len, offset;
+	struct msghdr outmsg;
+	static char outcmsg[CMSG_SPACE(sizeof(struct sctp_sndrcvinfo))];
+	struct cmsghdr *cmsg;
+	struct sctp_sndrcvinfo *sinfo;
+	struct kvec iov;
+
+        /* See if we need to init an association before we start
+	   sending precious messages */
+	spin_lock(&ni->lock);
+	if (!ni->assoc_id && !test_and_set_bit(NI_INIT_PENDING, &ni->flags)) {
+		spin_unlock(&ni->lock);
+		initiate_association(ni->nodeid);
+		return 0;
+	}
+	spin_unlock(&ni->lock);
+
+	outmsg.msg_name = NULL; /* We use assoc_id */
+	outmsg.msg_namelen = 0;
+	outmsg.msg_control = outcmsg;
+	outmsg.msg_controllen = sizeof(outcmsg);
+	outmsg.msg_flags = MSG_DONTWAIT | MSG_NOSIGNAL | MSG_EOR;
+
+	cmsg = CMSG_FIRSTHDR(&outmsg);
+	cmsg->cmsg_level = IPPROTO_SCTP;
+	cmsg->cmsg_type = SCTP_SNDRCV;
+	cmsg->cmsg_len = CMSG_LEN(sizeof(struct sctp_sndrcvinfo));
+	sinfo = (struct sctp_sndrcvinfo *)CMSG_DATA(cmsg);
+	memset(sinfo, 0x00, sizeof(struct sctp_sndrcvinfo));
+	sinfo->sinfo_ppid = cpu_to_le32(dlm_local_nodeid);
+	sinfo->sinfo_assoc_id = ni->assoc_id;
+	outmsg.msg_controllen = cmsg->cmsg_len;
+
+	spin_lock(&ni->writequeue_lock);
+	for (;;) {
+		if (list_empty(&ni->writequeue))
+			break;
+		e = list_entry(ni->writequeue.next, struct writequeue_entry,
+			       list);
+		len = e->len;
+		offset = e->offset;
+		BUG_ON(len == 0 && e->users == 0);
+		spin_unlock(&ni->writequeue_lock);
+		kmap(e->page);
+
+		ret = 0;
+		if (len) {
+			iov.iov_base = page_address(e->page)+offset;
+			iov.iov_len = len;
+
+			ret = kernel_sendmsg(sctp_con.sock, &outmsg, &iov, 1,
+					     len);
+			if (ret == -EAGAIN) {
+				sctp_con.eagain_flag = 1;
+				goto out;
+			} else if (ret < 0)
+				goto send_error;
+		} else {
+			/* Don't starve people filling buffers */
+			schedule();
+		}
+
+		spin_lock(&ni->writequeue_lock);
+		e->offset += ret;
+		e->len -= ret;
+
+		if (e->len == 0 && e->users == 0) {
+			list_del(&e->list);
+			free_entry(e);
+			continue;
+		}
+	}
+	spin_unlock(&ni->writequeue_lock);
+ out:
+	return ret;
+
+ send_error:
+	log_print("Error sending to node %d %d", ni->nodeid, ret);
+	spin_lock(&ni->lock);
+	if (!test_and_set_bit(NI_INIT_PENDING, &ni->flags)) {
+		ni->assoc_id = 0;
+		spin_unlock(&ni->lock);
+		initiate_association(ni->nodeid);
+	} else
+		spin_unlock(&ni->lock);
+
+	return ret;
+}
+
+/* Try to send any messages that are pending */
+static void process_output_queue(void)
+{
+	struct list_head *list;
+	struct list_head *temp;
+
+	spin_lock_bh(&write_nodes_lock);
+	list_for_each_safe(list, temp, &write_nodes) {
+		struct nodeinfo *ni =
+		    list_entry(list, struct nodeinfo, write_list);
+		clear_bit(NI_WRITE_PENDING, &ni->flags);
+		list_del(&ni->write_list);
+
+		spin_unlock_bh(&write_nodes_lock);
+
+		send_to_sock(ni);
+		spin_lock_bh(&write_nodes_lock);
+	}
+	spin_unlock_bh(&write_nodes_lock);
+}
+
+/* Called after we've had -EAGAIN and been woken up */
+static void refill_write_queue(void)
+{
+	int i;
+
+	for (i=1; i<=max_nodeid; i++) {
+		struct nodeinfo *ni = nodeid2nodeinfo(i, 0);
+
+		if (ni) {
+			if (!test_and_set_bit(NI_WRITE_PENDING, &ni->flags)) {
+				spin_lock_bh(&write_nodes_lock);
+				list_add_tail(&ni->write_list, &write_nodes);
+				spin_unlock_bh(&write_nodes_lock);
+			}
+		}
+	}
+}
+
+static void clean_one_writequeue(struct nodeinfo *ni)
+{
+	struct list_head *list;
+	struct list_head *temp;
+
+	spin_lock(&ni->writequeue_lock);
+	list_for_each_safe(list, temp, &ni->writequeue) {
+		struct writequeue_entry *e =
+			list_entry(list, struct writequeue_entry, list);
+		list_del(&e->list);
+		free_entry(e);
+	}
+	spin_unlock(&ni->writequeue_lock);
+}
+
+static void clean_writequeues(void)
+{
+	int i;
+
+	for (i=1; i<=max_nodeid; i++) {
+		struct nodeinfo *ni = nodeid2nodeinfo(i, 0);
+		if (ni)
+			clean_one_writequeue(ni);
+	}
+}
+
+
+static void dealloc_nodeinfo(void)
+{
+	int i;
+
+	for (i=1; i<=max_nodeid; i++) {
+		struct nodeinfo *ni = nodeid2nodeinfo(i, 0);
+		if (ni) {
+			idr_remove(&nodeinfo_idr, i);
+			kfree(ni);
+		}
+	}
+}
+
+int dlm_lowcomms_close(int nodeid)
+{
+	struct nodeinfo *ni;
+
+	ni = nodeid2nodeinfo(nodeid, 0);
+	if (!ni)
+		return -1;
+
+	spin_lock(&ni->lock);
+	if (ni->assoc_id) {
+		ni->assoc_id = 0;
+		/* Don't send shutdown here, sctp will just queue it
+		   till the node comes back up! */
+	}
+	spin_unlock(&ni->lock);
+
+	clean_one_writequeue(ni);
+	clear_bit(NI_INIT_PENDING, &ni->flags);
+	return 0;
+}
+
+static int write_list_empty(void)
+{
+	int status;
+
+	spin_lock_bh(&write_nodes_lock);
+	status = list_empty(&write_nodes);
+	spin_unlock_bh(&write_nodes_lock);
+
+	return status;
+}
+
+static int dlm_recvd(void *data)
+{
+	DECLARE_WAITQUEUE(wait, current);
+
+	while (!kthread_should_stop()) {
+		int count = 0;
+
+		set_current_state(TASK_INTERRUPTIBLE);
+		add_wait_queue(&lowcomms_recv_wait, &wait);
+		if (!test_bit(CF_READ_PENDING, &sctp_con.flags))
+			schedule();
+		remove_wait_queue(&lowcomms_recv_wait, &wait);
+		set_current_state(TASK_RUNNING);
+
+		if (test_and_clear_bit(CF_READ_PENDING, &sctp_con.flags)) {
+			int ret;
+
+			do {
+				ret = receive_from_sock();
+
+				/* Don't starve out everyone else */
+				if (++count >= MAX_RX_MSG_COUNT) {
+					schedule();
+					count = 0;
+				}
+			} while (!kthread_should_stop() && ret >=0);
+		}
+		schedule();
+	}
+
+	return 0;
+}
+
+static int dlm_sendd(void *data)
+{
+	DECLARE_WAITQUEUE(wait, current);
+
+	add_wait_queue(sctp_con.sock->sk->sk_sleep, &wait);
+
+	while (!kthread_should_stop()) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (write_list_empty())
+			schedule();
+		set_current_state(TASK_RUNNING);
+
+		if (sctp_con.eagain_flag) {
+			sctp_con.eagain_flag = 0;
+			refill_write_queue();
+		}
+		process_output_queue();
+	}
+
+	remove_wait_queue(sctp_con.sock->sk->sk_sleep, &wait);
+
+	return 0;
+}
+
+static void daemons_stop(void)
+{
+	kthread_stop(recv_task);
+	kthread_stop(send_task);
+}
+
+static int daemons_start(void)
+{
+	struct task_struct *p;
+	int error;
+
+	p = kthread_run(dlm_recvd, NULL, "dlm_recvd");
+	error = IS_ERR(p);
+       	if (error) {
+		log_print("can't start dlm_recvd %d", error);
+		return error;
+	}
+	recv_task = p;
+
+	p = kthread_run(dlm_sendd, NULL, "dlm_sendd");
+	error = IS_ERR(p);
+       	if (error) {
+		log_print("can't start dlm_sendd %d", error);
+		kthread_stop(recv_task);
+		return error;
+	}
+	send_task = p;
+
+	return 0;
+}
+
+/*
+ * This is quite likely to sleep...
+ */
+int dlm_lowcomms_start(void)
+{
+	int error;
+
+	error = init_sock();
+	if (error)
+		goto fail_sock;
+	error = daemons_start();
+	if (error)
+		goto fail_sock;
+	atomic_set(&accepting, 1);
+	return 0;
+
+ fail_sock:
+	close_connection();
+	return error;
+}
+
+/* Set all the activity flags to prevent any socket activity. */
+
+void dlm_lowcomms_stop(void)
+{
+	atomic_set(&accepting, 0);
+	sctp_con.flags = 0x7;
+	daemons_stop();
+	clean_writequeues();
+	close_connection();
+	dealloc_nodeinfo();
+	max_nodeid = 0;
+}
+
+int dlm_lowcomms_init(void)
+{
+	init_waitqueue_head(&lowcomms_recv_wait);
+	spin_lock_init(&write_nodes_lock);
+	INIT_LIST_HEAD(&write_nodes);
+	init_rwsem(&nodeinfo_lock);
+	return 0;
+}
+
+void dlm_lowcomms_exit(void)
+{
+	int i;
+
+	for (i = 0; i < dlm_local_count; i++)
+		kfree(dlm_local_addr[i]);
+	dlm_local_count = 0;
+	dlm_local_nodeid = 0;
+}
+
diff --git a/fs/dlm/lowcomms-tcp.c b/fs/dlm/lowcomms-tcp.c
new file mode 100644
index 0000000..7289e59
--- /dev/null
+++ b/fs/dlm/lowcomms-tcp.c
@@ -0,0 +1,1263 @@
+/******************************************************************************
+*******************************************************************************
+**
+**  Copyright (C) Sistina Software, Inc.  1997-2003  All rights reserved.
+**  Copyright (C) 2004-2006 Red Hat, Inc.  All rights reserved.
+**
+**  This copyrighted material is made available to anyone wishing to use,
+**  modify, copy, or redistribute it subject to the terms and conditions
+**  of the GNU General Public License v.2.
+**
+*******************************************************************************
+******************************************************************************/
+
+/*
+ * lowcomms.c
+ *
+ * This is the "low-level" comms layer.
+ *
+ * It is responsible for sending/receiving messages
+ * from other nodes in the cluster.
+ *
+ * Cluster nodes are referred to by their nodeids. nodeids are
+ * simply 32 bit numbers to the locking module - if they need to
+ * be expanded for the cluster infrastructure then that is it's
+ * responsibility. It is this layer's
+ * responsibility to resolve these into IP address or
+ * whatever it needs for inter-node communication.
+ *
+ * The comms level is two kernel threads that deal mainly with
+ * the receiving of messages from other nodes and passing them
+ * up to the mid-level comms layer (which understands the
+ * message format) for execution by the locking core, and
+ * a send thread which does all the setting up of connections
+ * to remote nodes and the sending of data. Threads are not allowed
+ * to send their own data because it may cause them to wait in times
+ * of high load. Also, this way, the sending thread can collect together
+ * messages bound for one node and send them in one block.
+ *
+ * I don't see any problem with the recv thread executing the locking
+ * code on behalf of remote processes as the locking code is
+ * short, efficient and never waits.
+ *
+ */
+
+
+#include <asm/ioctls.h>
+#include <net/sock.h>
+#include <net/tcp.h>
+#include <linux/pagemap.h>
+
+#include "dlm_internal.h"
+#include "lowcomms.h"
+#include "midcomms.h"
+#include "config.h"
+
+struct cbuf {
+	unsigned base;
+	unsigned len;
+	unsigned mask;
+};
+
+#ifndef FALSE
+#define FALSE 0
+#define TRUE 1
+#endif
+#define NODE_INCREMENT 32
+
+#define CBUF_INIT(cb, size) do { (cb)->base = (cb)->len = 0; (cb)->mask = ((size)-1); } while(0)
+#define CBUF_ADD(cb, n) do { (cb)->len += n; } while(0)
+#define CBUF_EMPTY(cb) ((cb)->len == 0)
+#define CBUF_MAY_ADD(cb, n) (((cb)->len + (n)) < ((cb)->mask + 1))
+#define CBUF_EAT(cb, n) do { (cb)->len  -= (n); \
+                             (cb)->base += (n); (cb)->base &= (cb)->mask; } while(0)
+#define CBUF_DATA(cb) (((cb)->base + (cb)->len) & (cb)->mask)
+
+/* Maximum number of incoming messages to process before
+   doing a schedule()
+*/
+#define MAX_RX_MSG_COUNT 25
+
+struct connection {
+	struct socket *sock;	/* NULL if not connected */
+	uint32_t nodeid;	/* So we know who we are in the list */
+	struct rw_semaphore sock_sem;	/* Stop connect races */
+	struct list_head read_list;	/* On this list when ready for reading */
+	struct list_head write_list;	/* On this list when ready for writing */
+	struct list_head state_list;	/* On this list when ready to connect */
+	unsigned long flags;	/* bit 1,2 = We are on the read/write lists */
+#define CF_READ_PENDING 1
+#define CF_WRITE_PENDING 2
+#define CF_CONNECT_PENDING 3
+#define CF_IS_OTHERCON 4
+	struct list_head writequeue;	/* List of outgoing writequeue_entries */
+	struct list_head listenlist;    /* List of allocated listening sockets */
+	spinlock_t writequeue_lock;
+	int (*rx_action) (struct connection *);	/* What to do when active */
+	struct page *rx_page;
+	struct cbuf cb;
+	int retries;
+	atomic_t waiting_requests;
+#define MAX_CONNECT_RETRIES 3
+	struct connection *othercon;
+};
+#define sock2con(x) ((struct connection *)(x)->sk_user_data)
+
+/* An entry waiting to be sent */
+struct writequeue_entry {
+	struct list_head list;
+	struct page *page;
+	int offset;
+	int len;
+	int end;
+	int users;
+	struct connection *con;
+};
+
+static struct sockaddr_storage dlm_local_addr;
+
+/* Manage daemons */
+static struct task_struct *recv_task;
+static struct task_struct *send_task;
+
+static wait_queue_t lowcomms_send_waitq_head;
+static wait_queue_head_t lowcomms_send_waitq;
+static wait_queue_t lowcomms_recv_waitq_head;
+static wait_queue_head_t lowcomms_recv_waitq;
+
+/* An array of pointers to connections, indexed by NODEID */
+static struct connection **connections;
+static struct semaphore connections_lock;
+static kmem_cache_t *con_cache;
+static int conn_array_size;
+static atomic_t accepting;
+
+/* List of sockets that have reads pending */
+static struct list_head read_sockets;
+static spinlock_t read_sockets_lock;
+
+/* List of sockets which have writes pending */
+static struct list_head write_sockets;
+static spinlock_t write_sockets_lock;
+
+/* List of sockets which have connects pending */
+static struct list_head state_sockets;
+static spinlock_t state_sockets_lock;
+
+static struct connection *nodeid2con(int nodeid, gfp_t allocation)
+{
+	struct connection *con = NULL;
+
+	down(&connections_lock);
+	if (nodeid >= conn_array_size) {
+		int new_size = nodeid + NODE_INCREMENT;
+		struct connection **new_conns;
+
+		new_conns = kmalloc(sizeof(struct connection *) *
+				    new_size, allocation);
+		if (!new_conns)
+			goto finish;
+
+		memset(new_conns, 0, sizeof(struct connection *) * new_size);
+		memcpy(new_conns, connections,  sizeof(struct connection *) * conn_array_size);
+		conn_array_size = new_size;
+		kfree(connections);
+		connections = new_conns;
+
+	}
+
+	con = connections[nodeid];
+	if (con == NULL && allocation) {
+		con = kmem_cache_alloc(con_cache, allocation);
+		if (!con)
+			goto finish;
+
+		memset(con, 0, sizeof(*con));
+		con->nodeid = nodeid;
+		init_rwsem(&con->sock_sem);
+		INIT_LIST_HEAD(&con->writequeue);
+		spin_lock_init(&con->writequeue_lock);
+
+		connections[nodeid] = con;
+	}
+
+ finish:
+	up(&connections_lock);
+	return con;
+}
+
+/* Data available on socket or listen socket received a connect */
+static void lowcomms_data_ready(struct sock *sk, int count_unused)
+{
+	struct connection *con = sock2con(sk);
+
+	atomic_inc(&con->waiting_requests);
+	if (test_and_set_bit(CF_READ_PENDING, &con->flags))
+		return;
+
+	spin_lock_bh(&read_sockets_lock);
+	list_add_tail(&con->read_list, &read_sockets);
+	spin_unlock_bh(&read_sockets_lock);
+
+	wake_up_interruptible(&lowcomms_recv_waitq);
+}
+
+static void lowcomms_write_space(struct sock *sk)
+{
+	struct connection *con = sock2con(sk);
+
+	if (test_and_set_bit(CF_WRITE_PENDING, &con->flags))
+		return;
+
+	spin_lock_bh(&write_sockets_lock);
+	list_add_tail(&con->write_list, &write_sockets);
+	spin_unlock_bh(&write_sockets_lock);
+
+	wake_up_interruptible(&lowcomms_send_waitq);
+}
+
+static inline void lowcomms_connect_sock(struct connection *con)
+{
+	if (test_and_set_bit(CF_CONNECT_PENDING, &con->flags))
+		return;
+	if (!atomic_read(&accepting))
+		return;
+
+	spin_lock_bh(&state_sockets_lock);
+	list_add_tail(&con->state_list, &state_sockets);
+	spin_unlock_bh(&state_sockets_lock);
+
+	wake_up_interruptible(&lowcomms_send_waitq);
+}
+
+static void lowcomms_state_change(struct sock *sk)
+{
+/*	struct connection *con = sock2con(sk); */
+
+	switch (sk->sk_state) {
+	case TCP_ESTABLISHED:
+		lowcomms_write_space(sk);
+		break;
+
+	case TCP_FIN_WAIT1:
+	case TCP_FIN_WAIT2:
+	case TCP_TIME_WAIT:
+	case TCP_CLOSE:
+	case TCP_CLOSE_WAIT:
+	case TCP_LAST_ACK:
+	case TCP_CLOSING:
+		/* FIXME: I think this causes more trouble than it solves.
+		   lowcomms wil reconnect anyway when there is something to
+		   send. This just attempts reconnection if a node goes down!
+		*/
+		/* lowcomms_connect_sock(con); */
+		break;
+
+	default:
+		printk("dlm: lowcomms_state_change: state=%d\n", sk->sk_state);
+		break;
+	}
+}
+
+/* Make a socket active */
+static int add_sock(struct socket *sock, struct connection *con)
+{
+	con->sock = sock;
+
+	/* Install a data_ready callback */
+	con->sock->sk->sk_data_ready = lowcomms_data_ready;
+	con->sock->sk->sk_write_space = lowcomms_write_space;
+	con->sock->sk->sk_state_change = lowcomms_state_change;
+
+	return 0;
+}
+
+/* Add the port number to an IP6 or 4 sockaddr and return the address
+   length */
+static void make_sockaddr(struct sockaddr_storage *saddr, uint16_t port,
+			  int *addr_len)
+{
+        saddr->ss_family =  dlm_local_addr.ss_family;
+        if (saddr->ss_family == AF_INET) {
+		struct sockaddr_in *in4_addr = (struct sockaddr_in *)saddr;
+		in4_addr->sin_port = cpu_to_be16(port);
+		*addr_len = sizeof(struct sockaddr_in);
+	}
+	else {
+		struct sockaddr_in6 *in6_addr = (struct sockaddr_in6 *)saddr;
+		in6_addr->sin6_port = cpu_to_be16(port);
+		*addr_len = sizeof(struct sockaddr_in6);
+	}
+}
+
+/* Close a remote connection and tidy up */
+static void close_connection(struct connection *con, int and_other)
+{
+	down_write(&con->sock_sem);
+
+	if (con->sock) {
+		sock_release(con->sock);
+		con->sock = NULL;
+	}
+	if (con->othercon && and_other) {
+		/* Argh! recursion in kernel code!
+		   Actually, this isn't a list so it
+		   will only re-enter once.
+		*/
+		close_connection(con->othercon, FALSE);
+	}
+	if (con->rx_page) {
+		__free_page(con->rx_page);
+		con->rx_page = NULL;
+	}
+	con->retries = 0;
+	up_write(&con->sock_sem);
+}
+
+/* Data received from remote end */
+static int receive_from_sock(struct connection *con)
+{
+	int ret = 0;
+	struct msghdr msg;
+	struct iovec iov[2];
+	mm_segment_t fs;
+	unsigned len;
+	int r;
+	int call_again_soon = 0;
+
+	down_read(&con->sock_sem);
+
+	if (con->sock == NULL)
+		goto out;
+	if (con->rx_page == NULL) {
+		/*
+		 * This doesn't need to be atomic, but I think it should
+		 * improve performance if it is.
+		 */
+		con->rx_page = alloc_page(GFP_ATOMIC);
+		if (con->rx_page == NULL)
+			goto out_resched;
+		CBUF_INIT(&con->cb, PAGE_CACHE_SIZE);
+	}
+
+	msg.msg_control = NULL;
+	msg.msg_controllen = 0;
+	msg.msg_iovlen = 1;
+	msg.msg_iov = iov;
+	msg.msg_name = NULL;
+	msg.msg_namelen = 0;
+	msg.msg_flags = 0;
+
+	/*
+	 * iov[0] is the bit of the circular buffer between the current end
+	 * point (cb.base + cb.len) and the end of the buffer.
+	 */
+	iov[0].iov_len = con->cb.base - CBUF_DATA(&con->cb);
+	iov[0].iov_base = page_address(con->rx_page) + CBUF_DATA(&con->cb);
+	iov[1].iov_len = 0;
+
+	/*
+	 * iov[1] is the bit of the circular buffer between the start of the
+	 * buffer and the start of the currently used section (cb.base)
+	 */
+	if (CBUF_DATA(&con->cb) >= con->cb.base) {
+		iov[0].iov_len = PAGE_CACHE_SIZE - CBUF_DATA(&con->cb);
+		iov[1].iov_len = con->cb.base;
+		iov[1].iov_base = page_address(con->rx_page);
+		msg.msg_iovlen = 2;
+	}
+	len = iov[0].iov_len + iov[1].iov_len;
+
+	fs = get_fs();
+	set_fs(get_ds());
+	r = ret = sock_recvmsg(con->sock, &msg, len,
+			       MSG_DONTWAIT | MSG_NOSIGNAL);
+	set_fs(fs);
+
+	if (ret <= 0)
+		goto out_close;
+	if (ret == len)
+		call_again_soon = 1;
+	CBUF_ADD(&con->cb, ret);
+	ret = dlm_process_incoming_buffer(con->nodeid,
+					  page_address(con->rx_page),
+					  con->cb.base, con->cb.len,
+					  PAGE_CACHE_SIZE);
+	if (ret == -EBADMSG) {
+		printk(KERN_INFO "dlm: lowcomms: addr=%p, base=%u, len=%u, "
+		       "iov_len=%u, iov_base[0]=%p, read=%d\n",
+		       page_address(con->rx_page), con->cb.base, con->cb.len,
+		       len, iov[0].iov_base, r);
+	}
+	if (ret < 0)
+		goto out_close;
+	CBUF_EAT(&con->cb, ret);
+
+	if (CBUF_EMPTY(&con->cb) && !call_again_soon) {
+		__free_page(con->rx_page);
+		con->rx_page = NULL;
+	}
+
+      out:
+	if (call_again_soon)
+		goto out_resched;
+	up_read(&con->sock_sem);
+	ret = 0;
+	goto out_ret;
+
+      out_resched:
+	lowcomms_data_ready(con->sock->sk, 0);
+	up_read(&con->sock_sem);
+	ret = 0;
+	schedule();
+	goto out_ret;
+
+      out_close:
+	up_read(&con->sock_sem);
+	if (ret != -EAGAIN && !test_bit(CF_IS_OTHERCON, &con->flags)) {
+		close_connection(con, FALSE);
+		/* Reconnect when there is something to send */
+	}
+
+      out_ret:
+	return ret;
+}
+
+/* Listening socket is busy, accept a connection */
+static int accept_from_sock(struct connection *con)
+{
+	int result;
+	struct sockaddr_storage peeraddr;
+	struct socket *newsock;
+	int len;
+	int nodeid;
+	struct connection *newcon;
+
+	memset(&peeraddr, 0, sizeof(peeraddr));
+	result = sock_create_kern(dlm_local_addr.ss_family, SOCK_STREAM, IPPROTO_TCP, &newsock);
+	if (result < 0)
+		return -ENOMEM;
+
+	down_read(&con->sock_sem);
+
+	result = -ENOTCONN;
+	if (con->sock == NULL)
+		goto accept_err;
+
+	newsock->type = con->sock->type;
+	newsock->ops = con->sock->ops;
+
+	result = con->sock->ops->accept(con->sock, newsock, O_NONBLOCK);
+	if (result < 0)
+		goto accept_err;
+
+	/* Get the connected socket's peer */
+	memset(&peeraddr, 0, sizeof(peeraddr));
+	if (newsock->ops->getname(newsock, (struct sockaddr *)&peeraddr,
+				  &len, 2)) {
+		result = -ECONNABORTED;
+		goto accept_err;
+	}
+
+	/* Get the new node's NODEID */
+	make_sockaddr(&peeraddr, 0, &len);
+	if (dlm_addr_to_nodeid(&peeraddr, &nodeid)) {
+	    	printk("dlm: connect from non cluster node\n");
+		sock_release(newsock);
+		up_read(&con->sock_sem);
+		return -1;
+	}
+
+	log_print("got connection from %d", nodeid);
+
+	/*  Check to see if we already have a connection to this node. This
+	 *  could happen if the two nodes initiate a connection at roughly
+	 *  the same time and the connections cross on the wire.
+	 * TEMPORARY FIX:
+	 *  In this case we store the incoming one in "othercon"
+	 */
+	newcon = nodeid2con(nodeid, GFP_KERNEL);
+	if (!newcon) {
+		result = -ENOMEM;
+		goto accept_err;
+	}
+	down_write(&newcon->sock_sem);
+	if (newcon->sock) {
+	        struct connection *othercon = newcon->othercon;
+
+		if (!othercon) {
+			othercon = kmem_cache_alloc(con_cache, GFP_KERNEL);
+			if (!othercon) {
+				printk("dlm: failed to allocate incoming socket\n");
+				up_write(&newcon->sock_sem);
+				result = -ENOMEM;
+				goto accept_err;
+			}
+			memset(othercon, 0, sizeof(*othercon));
+			othercon->nodeid = nodeid;
+			othercon->rx_action = receive_from_sock;
+			init_rwsem(&othercon->sock_sem);
+			set_bit(CF_IS_OTHERCON, &othercon->flags);
+			newcon->othercon = othercon;
+		}
+		othercon->sock = newsock;
+		newsock->sk->sk_user_data = othercon;
+		add_sock(newsock, othercon);
+	}
+	else {
+		newsock->sk->sk_user_data = newcon;
+		newcon->rx_action = receive_from_sock;
+		add_sock(newsock, newcon);
+
+	}
+
+	up_write(&newcon->sock_sem);
+
+	/*
+	 * Add it to the active queue in case we got data
+	 * beween processing the accept adding the socket
+	 * to the read_sockets list
+	 */
+	lowcomms_data_ready(newsock->sk, 0);
+	up_read(&con->sock_sem);
+
+	return 0;
+
+      accept_err:
+	up_read(&con->sock_sem);
+	sock_release(newsock);
+
+	if (result != -EAGAIN)
+		printk("dlm: error accepting connection from node: %d\n", result);
+	return result;
+}
+
+/* Connect a new socket to its peer */
+static int connect_to_sock(struct connection *con)
+{
+	int result = -EHOSTUNREACH;
+	struct sockaddr_storage saddr;
+	int addr_len;
+	struct socket *sock;
+
+	if (con->nodeid == 0) {
+		log_print("attempt to connect sock 0 foiled");
+		return 0;
+	}
+
+	down_write(&con->sock_sem);
+	if (con->retries++ > MAX_CONNECT_RETRIES)
+		goto out;
+
+	/* Some odd races can cause double-connects, ignore them */
+	if (con->sock) {
+		result = 0;
+		goto out;
+	}
+
+	/* Create a socket to communicate with */
+	result = sock_create_kern(dlm_local_addr.ss_family, SOCK_STREAM, IPPROTO_TCP, &sock);
+	if (result < 0)
+		goto out_err;
+
+	memset(&saddr, 0, sizeof(saddr));
+	if (dlm_nodeid_to_addr(con->nodeid, &saddr))
+	        goto out_err;
+
+	sock->sk->sk_user_data = con;
+	con->rx_action = receive_from_sock;
+
+	make_sockaddr(&saddr, dlm_config.tcp_port, &addr_len);
+
+	add_sock(sock, con);
+
+	log_print("connecting to %d", con->nodeid);
+	result =
+		sock->ops->connect(sock, (struct sockaddr *)&saddr, addr_len,
+			       O_NONBLOCK);
+	if (result == -EINPROGRESS)
+		result = 0;
+	if (result != 0)
+		goto out_err;
+
+      out:
+	up_write(&con->sock_sem);
+	/*
+	 * Returning an error here means we've given up trying to connect to
+	 * a remote node, otherwise we return 0 and reschedule the connetion
+	 * attempt
+	 */
+	return result;
+
+      out_err:
+	if (con->sock) {
+		sock_release(con->sock);
+		con->sock = NULL;
+	}
+	/*
+	 * Some errors are fatal and this list might need adjusting. For other
+	 * errors we try again until the max number of retries is reached.
+	 */
+	if (result != -EHOSTUNREACH && result != -ENETUNREACH &&
+	    result != -ENETDOWN && result != EINVAL
+	    && result != -EPROTONOSUPPORT) {
+		lowcomms_connect_sock(con);
+		result = 0;
+	}
+	goto out;
+}
+
+static struct socket *create_listen_sock(struct connection *con, struct sockaddr_storage *saddr)
+{
+        struct socket *sock = NULL;
+	mm_segment_t fs;
+	int result = 0;
+	int one = 1;
+	int addr_len;
+
+	if (dlm_local_addr.ss_family == AF_INET)
+		addr_len = sizeof(struct sockaddr_in);
+	else
+		addr_len = sizeof(struct sockaddr_in6);
+
+	/* Create a socket to communicate with */
+	result = sock_create_kern(dlm_local_addr.ss_family, SOCK_STREAM, IPPROTO_TCP, &sock);
+	if (result < 0) {
+		printk("dlm: Can't create listening comms socket\n");
+		goto create_out;
+	}
+
+	fs = get_fs();
+	set_fs(get_ds());
+	result = sock_setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, (char *)&one, sizeof(one));
+	set_fs(fs);
+	if (result < 0) {
+		printk("dlm: Failed to set SO_REUSEADDR on socket: result=%d\n",result);
+	}
+	sock->sk->sk_user_data = con;
+	con->rx_action = accept_from_sock;
+	con->sock = sock;
+
+	/* Bind to our port */
+	make_sockaddr(saddr, dlm_config.tcp_port, &addr_len);
+	result = sock->ops->bind(sock, (struct sockaddr *) saddr, addr_len);
+	if (result < 0) {
+		printk("dlm: Can't bind to port %d\n", dlm_config.tcp_port);
+		sock_release(sock);
+		sock = NULL;
+		con->sock = NULL;
+		goto create_out;
+	}
+
+	fs = get_fs();
+	set_fs(get_ds());
+
+	result = sock_setsockopt(sock, SOL_SOCKET, SO_KEEPALIVE, (char *)&one, sizeof(one));
+	set_fs(fs);
+	if (result < 0) {
+		printk("dlm: Set keepalive failed: %d\n", result);
+	}
+
+	result = sock->ops->listen(sock, 5);
+	if (result < 0) {
+		printk("dlm: Can't listen on port %d\n", dlm_config.tcp_port);
+		sock_release(sock);
+		sock = NULL;
+		goto create_out;
+	}
+
+      create_out:
+	return sock;
+}
+
+
+/* Listen on all interfaces */
+static int listen_for_all(void)
+{
+	struct socket *sock = NULL;
+	struct connection *con = nodeid2con(0, GFP_KERNEL);
+	int result = -EINVAL;
+
+	/* We don't support multi-homed hosts */
+	memset(con, 0, sizeof(*con));
+	init_rwsem(&con->sock_sem);
+	spin_lock_init(&con->writequeue_lock);
+	INIT_LIST_HEAD(&con->writequeue);
+	set_bit(CF_IS_OTHERCON, &con->flags);
+
+	sock = create_listen_sock(con, &dlm_local_addr);
+	if (sock) {
+		add_sock(sock, con);
+		result = 0;
+	}
+	else {
+		result = -EADDRINUSE;
+	}
+
+	return result;
+}
+
+
+
+static struct writequeue_entry *new_writequeue_entry(struct connection *con,
+						     gfp_t allocation)
+{
+	struct writequeue_entry *entry;
+
+	entry = kmalloc(sizeof(struct writequeue_entry), allocation);
+	if (!entry)
+		return NULL;
+
+	entry->page = alloc_page(allocation);
+	if (!entry->page) {
+		kfree(entry);
+		return NULL;
+	}
+
+	entry->offset = 0;
+	entry->len = 0;
+	entry->end = 0;
+	entry->users = 0;
+	entry->con = con;
+
+	return entry;
+}
+
+void *dlm_lowcomms_get_buffer(int nodeid, int len,
+			      gfp_t allocation, char **ppc)
+{
+	struct connection *con;
+	struct writequeue_entry *e;
+	int offset = 0;
+	int users = 0;
+
+	if (!atomic_read(&accepting))
+		return NULL;
+
+	con = nodeid2con(nodeid, allocation);
+	if (!con)
+		return NULL;
+
+	spin_lock(&con->writequeue_lock);
+	e = list_entry(con->writequeue.prev, struct writequeue_entry, list);
+	if (((struct list_head *) e == &con->writequeue) ||
+	    (PAGE_CACHE_SIZE - e->end < len)) {
+		e = NULL;
+	} else {
+		offset = e->end;
+		e->end += len;
+		users = e->users++;
+	}
+	spin_unlock(&con->writequeue_lock);
+
+	if (e) {
+	      got_one:
+		if (users == 0)
+			kmap(e->page);
+		*ppc = page_address(e->page) + offset;
+		return e;
+	}
+
+	e = new_writequeue_entry(con, allocation);
+	if (e) {
+		spin_lock(&con->writequeue_lock);
+		offset = e->end;
+		e->end += len;
+		users = e->users++;
+		list_add_tail(&e->list, &con->writequeue);
+		spin_unlock(&con->writequeue_lock);
+		goto got_one;
+	}
+	return NULL;
+}
+
+void dlm_lowcomms_commit_buffer(void *mh)
+{
+	struct writequeue_entry *e = (struct writequeue_entry *)mh;
+	struct connection *con = e->con;
+	int users;
+
+	if (!atomic_read(&accepting))
+		return;
+
+	spin_lock(&con->writequeue_lock);
+	users = --e->users;
+	if (users)
+		goto out;
+	e->len = e->end - e->offset;
+	kunmap(e->page);
+	spin_unlock(&con->writequeue_lock);
+
+	if (test_and_set_bit(CF_WRITE_PENDING, &con->flags) == 0) {
+		spin_lock_bh(&write_sockets_lock);
+		list_add_tail(&con->write_list, &write_sockets);
+		spin_unlock_bh(&write_sockets_lock);
+
+		wake_up_interruptible(&lowcomms_send_waitq);
+	}
+	return;
+
+      out:
+	spin_unlock(&con->writequeue_lock);
+	return;
+}
+
+static void free_entry(struct writequeue_entry *e)
+{
+	__free_page(e->page);
+	kfree(e);
+}
+
+/* Send a message */
+static int send_to_sock(struct connection *con)
+{
+	int ret = 0;
+	ssize_t(*sendpage) (struct socket *, struct page *, int, size_t, int);
+	const int msg_flags = MSG_DONTWAIT | MSG_NOSIGNAL;
+	struct writequeue_entry *e;
+	int len, offset;
+
+	down_read(&con->sock_sem);
+	if (con->sock == NULL)
+		goto out_connect;
+
+	sendpage = con->sock->ops->sendpage;
+
+	spin_lock(&con->writequeue_lock);
+	for (;;) {
+		e = list_entry(con->writequeue.next, struct writequeue_entry,
+			       list);
+		if ((struct list_head *) e == &con->writequeue)
+			break;
+
+		len = e->len;
+		offset = e->offset;
+		BUG_ON(len == 0 && e->users == 0);
+		spin_unlock(&con->writequeue_lock);
+
+		ret = 0;
+		if (len) {
+			ret = sendpage(con->sock, e->page, offset, len,
+				       msg_flags);
+			if (ret == -EAGAIN || ret == 0)
+				goto out;
+			if (ret <= 0)
+				goto send_error;
+		}
+		else {
+			/* Don't starve people filling buffers */
+			schedule();
+		}
+
+		spin_lock(&con->writequeue_lock);
+		e->offset += ret;
+		e->len -= ret;
+
+		if (e->len == 0 && e->users == 0) {
+			list_del(&e->list);
+			free_entry(e);
+			continue;
+		}
+	}
+	spin_unlock(&con->writequeue_lock);
+      out:
+	up_read(&con->sock_sem);
+	return ret;
+
+      send_error:
+	up_read(&con->sock_sem);
+	close_connection(con, FALSE);
+	lowcomms_connect_sock(con);
+	return ret;
+
+      out_connect:
+	up_read(&con->sock_sem);
+	lowcomms_connect_sock(con);
+	return 0;
+}
+
+static void clean_one_writequeue(struct connection *con)
+{
+	struct list_head *list;
+	struct list_head *temp;
+
+	spin_lock(&con->writequeue_lock);
+	list_for_each_safe(list, temp, &con->writequeue) {
+		struct writequeue_entry *e =
+			list_entry(list, struct writequeue_entry, list);
+		list_del(&e->list);
+		free_entry(e);
+	}
+	spin_unlock(&con->writequeue_lock);
+}
+
+/* Called from recovery when it knows that a node has
+   left the cluster */
+int dlm_lowcomms_close(int nodeid)
+{
+	struct connection *con;
+
+	if (!connections)
+		goto out;
+
+	log_print("closing connection to node %d", nodeid);
+	con = nodeid2con(nodeid, 0);
+	if (con) {
+		clean_one_writequeue(con);
+		close_connection(con, TRUE);
+		atomic_set(&con->waiting_requests, 0);
+	}
+	return 0;
+
+      out:
+	return -1;
+}
+
+/* API send message call, may queue the request */
+/* N.B. This is the old interface - use the new one for new calls */
+int lowcomms_send_message(int nodeid, char *buf, int len, gfp_t allocation)
+{
+	struct writequeue_entry *e;
+	char *b;
+
+	e = dlm_lowcomms_get_buffer(nodeid, len, allocation, &b);
+	if (e) {
+		memcpy(b, buf, len);
+		dlm_lowcomms_commit_buffer(e);
+		return 0;
+	}
+	return -ENOBUFS;
+}
+
+/* Look for activity on active sockets */
+static void process_sockets(void)
+{
+	struct list_head *list;
+	struct list_head *temp;
+	int count = 0;
+
+	spin_lock_bh(&read_sockets_lock);
+	list_for_each_safe(list, temp, &read_sockets) {
+
+		struct connection *con =
+		    list_entry(list, struct connection, read_list);
+		list_del(&con->read_list);
+		clear_bit(CF_READ_PENDING, &con->flags);
+
+		spin_unlock_bh(&read_sockets_lock);
+
+		/* This can reach zero if we are processing requests
+		 * as they come in.
+		 */
+		if (atomic_read(&con->waiting_requests) == 0) {
+			spin_lock_bh(&read_sockets_lock);
+			continue;
+		}
+
+		do {
+			con->rx_action(con);
+
+			/* Don't starve out everyone else */
+			if (++count >= MAX_RX_MSG_COUNT) {
+				schedule();
+				count = 0;
+			}
+
+		} while (!atomic_dec_and_test(&con->waiting_requests) &&
+			 !kthread_should_stop());
+
+		spin_lock_bh(&read_sockets_lock);
+	}
+	spin_unlock_bh(&read_sockets_lock);
+}
+
+/* Try to send any messages that are pending
+ */
+static void process_output_queue(void)
+{
+	struct list_head *list;
+	struct list_head *temp;
+	int ret;
+
+	spin_lock_bh(&write_sockets_lock);
+	list_for_each_safe(list, temp, &write_sockets) {
+		struct connection *con =
+		    list_entry(list, struct connection, write_list);
+		clear_bit(CF_WRITE_PENDING, &con->flags);
+		list_del(&con->write_list);
+
+		spin_unlock_bh(&write_sockets_lock);
+
+		ret = send_to_sock(con);
+		if (ret < 0) {
+		}
+		spin_lock_bh(&write_sockets_lock);
+	}
+	spin_unlock_bh(&write_sockets_lock);
+}
+
+static void process_state_queue(void)
+{
+	struct list_head *list;
+	struct list_head *temp;
+	int ret;
+
+	spin_lock_bh(&state_sockets_lock);
+	list_for_each_safe(list, temp, &state_sockets) {
+		struct connection *con =
+		    list_entry(list, struct connection, state_list);
+		list_del(&con->state_list);
+		clear_bit(CF_CONNECT_PENDING, &con->flags);
+		spin_unlock_bh(&state_sockets_lock);
+
+		ret = connect_to_sock(con);
+		if (ret < 0) {
+		}
+		spin_lock_bh(&state_sockets_lock);
+	}
+	spin_unlock_bh(&state_sockets_lock);
+}
+
+
+/* Discard all entries on the write queues */
+static void clean_writequeues(void)
+{
+	int nodeid;
+
+	for (nodeid = 1; nodeid < conn_array_size; nodeid++) {
+		struct connection *con = nodeid2con(nodeid, 0);
+
+		if (con)
+			clean_one_writequeue(con);
+	}
+}
+
+static int read_list_empty(void)
+{
+	int status;
+
+	spin_lock_bh(&read_sockets_lock);
+	status = list_empty(&read_sockets);
+	spin_unlock_bh(&read_sockets_lock);
+
+	return status;
+}
+
+/* DLM Transport comms receive daemon */
+static int dlm_recvd(void *data)
+{
+	init_waitqueue_head(&lowcomms_recv_waitq);
+	init_waitqueue_entry(&lowcomms_recv_waitq_head, current);
+	add_wait_queue(&lowcomms_recv_waitq, &lowcomms_recv_waitq_head);
+
+	while (!kthread_should_stop()) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (read_list_empty())
+			schedule();
+		set_current_state(TASK_RUNNING);
+
+		process_sockets();
+	}
+
+	return 0;
+}
+
+static int write_and_state_lists_empty(void)
+{
+	int status;
+
+	spin_lock_bh(&write_sockets_lock);
+	status = list_empty(&write_sockets);
+	spin_unlock_bh(&write_sockets_lock);
+
+	spin_lock_bh(&state_sockets_lock);
+	if (list_empty(&state_sockets) == 0)
+		status = 0;
+	spin_unlock_bh(&state_sockets_lock);
+
+	return status;
+}
+
+/* DLM Transport send daemon */
+static int dlm_sendd(void *data)
+{
+	init_waitqueue_head(&lowcomms_send_waitq);
+	init_waitqueue_entry(&lowcomms_send_waitq_head, current);
+	add_wait_queue(&lowcomms_send_waitq, &lowcomms_send_waitq_head);
+
+	while (!kthread_should_stop()) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (write_and_state_lists_empty())
+			schedule();
+		set_current_state(TASK_RUNNING);
+
+		process_state_queue();
+		process_output_queue();
+	}
+
+	return 0;
+}
+
+static void daemons_stop(void)
+{
+	kthread_stop(recv_task);
+	kthread_stop(send_task);
+}
+
+static int daemons_start(void)
+{
+	struct task_struct *p;
+	int error;
+
+	p = kthread_run(dlm_recvd, NULL, "dlm_recvd");
+	error = IS_ERR(p);
+       	if (error) {
+		log_print("can't start dlm_recvd %d", error);
+		return error;
+	}
+	recv_task = p;
+
+	p = kthread_run(dlm_sendd, NULL, "dlm_sendd");
+	error = IS_ERR(p);
+       	if (error) {
+		log_print("can't start dlm_sendd %d", error);
+		kthread_stop(recv_task);
+		return error;
+	}
+	send_task = p;
+
+	return 0;
+}
+
+/*
+ * Return the largest buffer size we can cope with.
+ */
+int lowcomms_max_buffer_size(void)
+{
+	return PAGE_CACHE_SIZE;
+}
+
+void dlm_lowcomms_stop(void)
+{
+	int i;
+
+	atomic_set(&accepting, 0);
+
+	/* Set all the activity flags to prevent any
+	   socket activity.
+	*/
+	for (i = 0; i < conn_array_size; i++) {
+		if (connections[i])
+			connections[i]->flags |= 0x7;
+	}
+	daemons_stop();
+	clean_writequeues();
+
+	for (i = 0; i < conn_array_size; i++) {
+		if (connections[i]) {
+			close_connection(connections[i], TRUE);
+			if (connections[i]->othercon)
+				kmem_cache_free(con_cache, connections[i]->othercon);
+			kmem_cache_free(con_cache, connections[i]);
+		}
+	}
+
+	kfree(connections);
+	connections = NULL;
+
+	kmem_cache_destroy(con_cache);
+}
+
+/* This is quite likely to sleep... */
+int dlm_lowcomms_start(void)
+{
+	int error = 0;
+
+	error = -ENOTCONN;
+
+	/*
+	 * Temporarily initialise the waitq head so that lowcomms_send_message
+	 * doesn't crash if it gets called before the thread is fully
+	 * initialised
+	 */
+	init_waitqueue_head(&lowcomms_send_waitq);
+
+	error = -ENOMEM;
+	connections = kmalloc(sizeof(struct connection *) *
+			      NODE_INCREMENT, GFP_KERNEL);
+	if (!connections)
+		goto out;
+
+	memset(connections, 0,
+	       sizeof(struct connection *) * NODE_INCREMENT);
+
+	conn_array_size = NODE_INCREMENT;
+
+	if (dlm_our_addr(&dlm_local_addr, 0)) {
+		log_print("no local IP address has been set");
+		goto fail_free_conn;
+	}
+	if (!dlm_our_addr(&dlm_local_addr, 1)) {
+		log_print("This dlm comms module does not support multi-homed clustering");
+		goto fail_free_conn;
+	}
+
+	con_cache = kmem_cache_create("dlm_conn", sizeof(struct connection),
+				      __alignof__(struct connection), 0, NULL, NULL);
+	if (!con_cache)
+		goto fail_free_conn;
+
+
+	/* Start listening */
+	error = listen_for_all();
+	if (error)
+		goto fail_unlisten;
+
+	error = daemons_start();
+	if (error)
+		goto fail_unlisten;
+
+	atomic_set(&accepting, 1);
+
+	return 0;
+
+      fail_unlisten:
+	close_connection(connections[0], 0);
+	kmem_cache_free(con_cache, connections[0]);
+	kmem_cache_destroy(con_cache);
+
+      fail_free_conn:
+	kfree(connections);
+
+      out:
+	return error;
+}
+
+int dlm_lowcomms_init(void)
+{
+	INIT_LIST_HEAD(&read_sockets);
+	INIT_LIST_HEAD(&write_sockets);
+	INIT_LIST_HEAD(&state_sockets);
+
+	spin_lock_init(&read_sockets_lock);
+	spin_lock_init(&write_sockets_lock);
+	spin_lock_init(&state_sockets_lock);
+	init_MUTEX(&connections_lock);
+
+	return 0;
+}
+
+void dlm_lowcomms_exit(void)
+{
+}
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
deleted file mode 100644
index 6da6b14..0000000
--- a/fs/dlm/lowcomms.c
+++ /dev/null
@@ -1,1239 +0,0 @@
-/******************************************************************************
-*******************************************************************************
-**
-**  Copyright (C) Sistina Software, Inc.  1997-2003  All rights reserved.
-**  Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
-**
-**  This copyrighted material is made available to anyone wishing to use,
-**  modify, copy, or redistribute it subject to the terms and conditions
-**  of the GNU General Public License v.2.
-**
-*******************************************************************************
-******************************************************************************/
-
-/*
- * lowcomms.c
- *
- * This is the "low-level" comms layer.
- *
- * It is responsible for sending/receiving messages
- * from other nodes in the cluster.
- *
- * Cluster nodes are referred to by their nodeids. nodeids are
- * simply 32 bit numbers to the locking module - if they need to
- * be expanded for the cluster infrastructure then that is it's
- * responsibility. It is this layer's
- * responsibility to resolve these into IP address or
- * whatever it needs for inter-node communication.
- *
- * The comms level is two kernel threads that deal mainly with
- * the receiving of messages from other nodes and passing them
- * up to the mid-level comms layer (which understands the
- * message format) for execution by the locking core, and
- * a send thread which does all the setting up of connections
- * to remote nodes and the sending of data. Threads are not allowed
- * to send their own data because it may cause them to wait in times
- * of high load. Also, this way, the sending thread can collect together
- * messages bound for one node and send them in one block.
- *
- * I don't see any problem with the recv thread executing the locking
- * code on behalf of remote processes as the locking code is
- * short, efficient and never (well, hardly ever) waits.
- *
- */
-
-#include <asm/ioctls.h>
-#include <net/sock.h>
-#include <net/tcp.h>
-#include <net/sctp/user.h>
-#include <linux/pagemap.h>
-#include <linux/socket.h>
-#include <linux/idr.h>
-
-#include "dlm_internal.h"
-#include "lowcomms.h"
-#include "config.h"
-#include "midcomms.h"
-
-static struct sockaddr_storage *dlm_local_addr[DLM_MAX_ADDR_COUNT];
-static int			dlm_local_count;
-static int			dlm_local_nodeid;
-
-/* One of these per connected node */
-
-#define NI_INIT_PENDING 1
-#define NI_WRITE_PENDING 2
-
-struct nodeinfo {
-	spinlock_t		lock;
-	sctp_assoc_t		assoc_id;
-	unsigned long		flags;
-	struct list_head	write_list; /* nodes with pending writes */
-	struct list_head	writequeue; /* outgoing writequeue_entries */
-	spinlock_t		writequeue_lock;
-	int			nodeid;
-};
-
-static DEFINE_IDR(nodeinfo_idr);
-static struct rw_semaphore	nodeinfo_lock;
-static int			max_nodeid;
-
-struct cbuf {
-	unsigned		base;
-	unsigned		len;
-	unsigned		mask;
-};
-
-/* Just the one of these, now. But this struct keeps
-   the connection-specific variables together */
-
-#define CF_READ_PENDING 1
-
-struct connection {
-	struct socket          *sock;
-	unsigned long		flags;
-	struct page            *rx_page;
-	atomic_t		waiting_requests;
-	struct cbuf		cb;
-	int                     eagain_flag;
-};
-
-/* An entry waiting to be sent */
-
-struct writequeue_entry {
-	struct list_head	list;
-	struct page            *page;
-	int			offset;
-	int			len;
-	int			end;
-	int			users;
-	struct nodeinfo        *ni;
-};
-
-#define CBUF_ADD(cb, n) do { (cb)->len += n; } while(0)
-#define CBUF_EMPTY(cb) ((cb)->len == 0)
-#define CBUF_MAY_ADD(cb, n) (((cb)->len + (n)) < ((cb)->mask + 1))
-#define CBUF_DATA(cb) (((cb)->base + (cb)->len) & (cb)->mask)
-
-#define CBUF_INIT(cb, size) \
-do { \
-	(cb)->base = (cb)->len = 0; \
-	(cb)->mask = ((size)-1); \
-} while(0)
-
-#define CBUF_EAT(cb, n) \
-do { \
-	(cb)->len  -= (n); \
-	(cb)->base += (n); \
-	(cb)->base &= (cb)->mask; \
-} while(0)
-
-
-/* List of nodes which have writes pending */
-static struct list_head write_nodes;
-static spinlock_t write_nodes_lock;
-
-/* Maximum number of incoming messages to process before
- * doing a schedule()
- */
-#define MAX_RX_MSG_COUNT 25
-
-/* Manage daemons */
-static struct task_struct *recv_task;
-static struct task_struct *send_task;
-static wait_queue_head_t lowcomms_recv_wait;
-static atomic_t accepting;
-
-/* The SCTP connection */
-static struct connection sctp_con;
-
-
-static int nodeid_to_addr(int nodeid, struct sockaddr *retaddr)
-{
-	struct sockaddr_storage addr;
-	int error;
-
-	if (!dlm_local_count)
-		return -1;
-
-	error = dlm_nodeid_to_addr(nodeid, &addr);
-	if (error)
-		return error;
-
-	if (dlm_local_addr[0]->ss_family == AF_INET) {
-	        struct sockaddr_in *in4  = (struct sockaddr_in *) &addr;
-		struct sockaddr_in *ret4 = (struct sockaddr_in *) retaddr;
-		ret4->sin_addr.s_addr = in4->sin_addr.s_addr;
-	} else {
-	        struct sockaddr_in6 *in6  = (struct sockaddr_in6 *) &addr;
-		struct sockaddr_in6 *ret6 = (struct sockaddr_in6 *) retaddr;
-		memcpy(&ret6->sin6_addr, &in6->sin6_addr,
-		       sizeof(in6->sin6_addr));
-	}
-
-	return 0;
-}
-
-static struct nodeinfo *nodeid2nodeinfo(int nodeid, gfp_t alloc)
-{
-	struct nodeinfo *ni;
-	int r;
-	int n;
-
-	down_read(&nodeinfo_lock);
-	ni = idr_find(&nodeinfo_idr, nodeid);
-	up_read(&nodeinfo_lock);
-
-	if (!ni && alloc) {
-		down_write(&nodeinfo_lock);
-
-		ni = idr_find(&nodeinfo_idr, nodeid);
-		if (ni)
-			goto out_up;
-
-		r = idr_pre_get(&nodeinfo_idr, alloc);
-		if (!r)
-			goto out_up;
-
-		ni = kmalloc(sizeof(struct nodeinfo), alloc);
-		if (!ni)
-			goto out_up;
-
-		r = idr_get_new_above(&nodeinfo_idr, ni, nodeid, &n);
-		if (r) {
-			kfree(ni);
-			ni = NULL;
-			goto out_up;
-		}
-		if (n != nodeid) {
-			idr_remove(&nodeinfo_idr, n);
-			kfree(ni);
-			ni = NULL;
-			goto out_up;
-		}
-		memset(ni, 0, sizeof(struct nodeinfo));
-		spin_lock_init(&ni->lock);
-		INIT_LIST_HEAD(&ni->writequeue);
-		spin_lock_init(&ni->writequeue_lock);
-		ni->nodeid = nodeid;
-
-		if (nodeid > max_nodeid)
-			max_nodeid = nodeid;
-	out_up:
-		up_write(&nodeinfo_lock);
-	}
-
-	return ni;
-}
-
-/* Don't call this too often... */
-static struct nodeinfo *assoc2nodeinfo(sctp_assoc_t assoc)
-{
-	int i;
-	struct nodeinfo *ni;
-
-	for (i=1; i<=max_nodeid; i++) {
-		ni = nodeid2nodeinfo(i, 0);
-		if (ni && ni->assoc_id == assoc)
-			return ni;
-	}
-	return NULL;
-}
-
-/* Data or notification available on socket */
-static void lowcomms_data_ready(struct sock *sk, int count_unused)
-{
-	atomic_inc(&sctp_con.waiting_requests);
-	if (test_and_set_bit(CF_READ_PENDING, &sctp_con.flags))
-		return;
-
-	wake_up_interruptible(&lowcomms_recv_wait);
-}
-
-
-/* Add the port number to an IP6 or 4 sockaddr and return the address length.
-   Also padd out the struct with zeros to make comparisons meaningful */
-
-static void make_sockaddr(struct sockaddr_storage *saddr, uint16_t port,
-			  int *addr_len)
-{
-	struct sockaddr_in *local4_addr;
-	struct sockaddr_in6 *local6_addr;
-
-	if (!dlm_local_count)
-		return;
-
-	if (!port) {
-		if (dlm_local_addr[0]->ss_family == AF_INET) {
-			local4_addr = (struct sockaddr_in *)dlm_local_addr[0];
-			port = be16_to_cpu(local4_addr->sin_port);
-		} else {
-			local6_addr = (struct sockaddr_in6 *)dlm_local_addr[0];
-			port = be16_to_cpu(local6_addr->sin6_port);
-		}
-	}
-
-	saddr->ss_family = dlm_local_addr[0]->ss_family;
-	if (dlm_local_addr[0]->ss_family == AF_INET) {
-		struct sockaddr_in *in4_addr = (struct sockaddr_in *)saddr;
-		in4_addr->sin_port = cpu_to_be16(port);
-		memset(&in4_addr->sin_zero, 0, sizeof(in4_addr->sin_zero));
-		memset(in4_addr+1, 0, sizeof(struct sockaddr_storage) -
-				      sizeof(struct sockaddr_in));
-		*addr_len = sizeof(struct sockaddr_in);
-	} else {
-		struct sockaddr_in6 *in6_addr = (struct sockaddr_in6 *)saddr;
-		in6_addr->sin6_port = cpu_to_be16(port);
-		memset(in6_addr+1, 0, sizeof(struct sockaddr_storage) -
-				      sizeof(struct sockaddr_in6));
-		*addr_len = sizeof(struct sockaddr_in6);
-	}
-}
-
-/* Close the connection and tidy up */
-static void close_connection(void)
-{
-	if (sctp_con.sock) {
-		sock_release(sctp_con.sock);
-		sctp_con.sock = NULL;
-	}
-
-	if (sctp_con.rx_page) {
-		__free_page(sctp_con.rx_page);
-		sctp_con.rx_page = NULL;
-	}
-}
-
-/* We only send shutdown messages to nodes that are not part of the cluster */
-static void send_shutdown(sctp_assoc_t associd)
-{
-	static char outcmsg[CMSG_SPACE(sizeof(struct sctp_sndrcvinfo))];
-	struct msghdr outmessage;
-	struct cmsghdr *cmsg;
-	struct sctp_sndrcvinfo *sinfo;
-	int ret;
-
-	outmessage.msg_name = NULL;
-	outmessage.msg_namelen = 0;
-	outmessage.msg_control = outcmsg;
-	outmessage.msg_controllen = sizeof(outcmsg);
-	outmessage.msg_flags = MSG_EOR;
-
-	cmsg = CMSG_FIRSTHDR(&outmessage);
-	cmsg->cmsg_level = IPPROTO_SCTP;
-	cmsg->cmsg_type = SCTP_SNDRCV;
-	cmsg->cmsg_len = CMSG_LEN(sizeof(struct sctp_sndrcvinfo));
-	outmessage.msg_controllen = cmsg->cmsg_len;
-	sinfo = (struct sctp_sndrcvinfo *)CMSG_DATA(cmsg);
-	memset(sinfo, 0x00, sizeof(struct sctp_sndrcvinfo));
-
-	sinfo->sinfo_flags |= MSG_EOF;
-	sinfo->sinfo_assoc_id = associd;
-
-	ret = kernel_sendmsg(sctp_con.sock, &outmessage, NULL, 0, 0);
-
-	if (ret != 0)
-		log_print("send EOF to node failed: %d", ret);
-}
-
-
-/* INIT failed but we don't know which node...
-   restart INIT on all pending nodes */
-static void init_failed(void)
-{
-	int i;
-	struct nodeinfo *ni;
-
-	for (i=1; i<=max_nodeid; i++) {
-		ni = nodeid2nodeinfo(i, 0);
-		if (!ni)
-			continue;
-
-		if (test_and_clear_bit(NI_INIT_PENDING, &ni->flags)) {
-			ni->assoc_id = 0;
-			if (!test_and_set_bit(NI_WRITE_PENDING, &ni->flags)) {
-				spin_lock_bh(&write_nodes_lock);
-				list_add_tail(&ni->write_list, &write_nodes);
-				spin_unlock_bh(&write_nodes_lock);
-			}
-		}
-	}
-	wake_up_process(send_task);
-}
-
-/* Something happened to an association */
-static void process_sctp_notification(struct msghdr *msg, char *buf)
-{
-	union sctp_notification *sn = (union sctp_notification *)buf;
-
-	if (sn->sn_header.sn_type == SCTP_ASSOC_CHANGE) {
-		switch (sn->sn_assoc_change.sac_state) {
-
-		case SCTP_COMM_UP:
-		case SCTP_RESTART:
-		{
-			/* Check that the new node is in the lockspace */
-			struct sctp_prim prim;
-			mm_segment_t fs;
-			int nodeid;
-			int prim_len, ret;
-			int addr_len;
-			struct nodeinfo *ni;
-
-			/* This seems to happen when we received a connection
-			 * too early... or something...  anyway, it happens but
-			 * we always seem to get a real message too, see
-			 * receive_from_sock */
-
-			if ((int)sn->sn_assoc_change.sac_assoc_id <= 0) {
-				log_print("COMM_UP for invalid assoc ID %d",
-					 (int)sn->sn_assoc_change.sac_assoc_id);
-				init_failed();
-				return;
-			}
-			memset(&prim, 0, sizeof(struct sctp_prim));
-			prim_len = sizeof(struct sctp_prim);
-			prim.ssp_assoc_id = sn->sn_assoc_change.sac_assoc_id;
-
-			fs = get_fs();
-			set_fs(get_ds());
-			ret = sctp_con.sock->ops->getsockopt(sctp_con.sock,
-						IPPROTO_SCTP, SCTP_PRIMARY_ADDR,
-						(char*)&prim, &prim_len);
-			set_fs(fs);
-			if (ret < 0) {
-				struct nodeinfo *ni;
-
-				log_print("getsockopt/sctp_primary_addr on "
-					  "new assoc %d failed : %d",
-				    (int)sn->sn_assoc_change.sac_assoc_id, ret);
-
-				/* Retry INIT later */
-				ni = assoc2nodeinfo(sn->sn_assoc_change.sac_assoc_id);
-				if (ni)
-					clear_bit(NI_INIT_PENDING, &ni->flags);
-				return;
-			}
-			make_sockaddr(&prim.ssp_addr, 0, &addr_len);
-			if (dlm_addr_to_nodeid(&prim.ssp_addr, &nodeid)) {
-				log_print("reject connect from unknown addr");
-				send_shutdown(prim.ssp_assoc_id);
-				return;
-			}
-
-			ni = nodeid2nodeinfo(nodeid, GFP_KERNEL);
-			if (!ni)
-				return;
-
-			/* Save the assoc ID */
-			spin_lock(&ni->lock);
-			ni->assoc_id = sn->sn_assoc_change.sac_assoc_id;
-			spin_unlock(&ni->lock);
-
-			log_print("got new/restarted association %d nodeid %d",
-			       (int)sn->sn_assoc_change.sac_assoc_id, nodeid);
-
-			/* Send any pending writes */
-			clear_bit(NI_INIT_PENDING, &ni->flags);
-			if (!test_and_set_bit(NI_WRITE_PENDING, &ni->flags)) {
-				spin_lock_bh(&write_nodes_lock);
-				list_add_tail(&ni->write_list, &write_nodes);
-				spin_unlock_bh(&write_nodes_lock);
-			}
-			wake_up_process(send_task);
-		}
-		break;
-
-		case SCTP_COMM_LOST:
-		case SCTP_SHUTDOWN_COMP:
-		{
-			struct nodeinfo *ni;
-
-			ni = assoc2nodeinfo(sn->sn_assoc_change.sac_assoc_id);
-			if (ni) {
-				spin_lock(&ni->lock);
-				ni->assoc_id = 0;
-				spin_unlock(&ni->lock);
-			}
-		}
-		break;
-
-		/* We don't know which INIT failed, so clear the PENDING flags
-		 * on them all.  if assoc_id is zero then it will then try
-		 * again */
-
-		case SCTP_CANT_STR_ASSOC:
-		{
-			log_print("Can't start SCTP association - retrying");
-			init_failed();
-		}
-		break;
-
-		default:
-			log_print("unexpected SCTP assoc change id=%d state=%d",
-				  (int)sn->sn_assoc_change.sac_assoc_id,
-				  sn->sn_assoc_change.sac_state);
-		}
-	}
-}
-
-/* Data received from remote end */
-static int receive_from_sock(void)
-{
-	int ret = 0;
-	struct msghdr msg;
-	struct kvec iov[2];
-	unsigned len;
-	int r;
-	struct sctp_sndrcvinfo *sinfo;
-	struct cmsghdr *cmsg;
-	struct nodeinfo *ni;
-
-	/* These two are marginally too big for stack allocation, but this
-	 * function is (currently) only called by dlm_recvd so static should be
-	 * OK.
-	 */
-	static struct sockaddr_storage msgname;
-	static char incmsg[CMSG_SPACE(sizeof(struct sctp_sndrcvinfo))];
-
-	if (sctp_con.sock == NULL)
-		goto out;
-
-	if (sctp_con.rx_page == NULL) {
-		/*
-		 * This doesn't need to be atomic, but I think it should
-		 * improve performance if it is.
-		 */
-		sctp_con.rx_page = alloc_page(GFP_ATOMIC);
-		if (sctp_con.rx_page == NULL)
-			goto out_resched;
-		CBUF_INIT(&sctp_con.cb, PAGE_CACHE_SIZE);
-	}
-
-	memset(&incmsg, 0, sizeof(incmsg));
-	memset(&msgname, 0, sizeof(msgname));
-
-	memset(incmsg, 0, sizeof(incmsg));
-	msg.msg_name = &msgname;
-	msg.msg_namelen = sizeof(msgname);
-	msg.msg_flags = 0;
-	msg.msg_control = incmsg;
-	msg.msg_controllen = sizeof(incmsg);
-	msg.msg_iovlen = 1;
-
-	/* I don't see why this circular buffer stuff is necessary for SCTP
-	 * which is a packet-based protocol, but the whole thing breaks under
-	 * load without it! The overhead is minimal (and is in the TCP lowcomms
-	 * anyway, of course) so I'll leave it in until I can figure out what's
-	 * really happening.
-	 */
-
-	/*
-	 * iov[0] is the bit of the circular buffer between the current end
-	 * point (cb.base + cb.len) and the end of the buffer.
-	 */
-	iov[0].iov_len = sctp_con.cb.base - CBUF_DATA(&sctp_con.cb);
-	iov[0].iov_base = page_address(sctp_con.rx_page) +
-			  CBUF_DATA(&sctp_con.cb);
-	iov[1].iov_len = 0;
-
-	/*
-	 * iov[1] is the bit of the circular buffer between the start of the
-	 * buffer and the start of the currently used section (cb.base)
-	 */
-	if (CBUF_DATA(&sctp_con.cb) >= sctp_con.cb.base) {
-		iov[0].iov_len = PAGE_CACHE_SIZE - CBUF_DATA(&sctp_con.cb);
-		iov[1].iov_len = sctp_con.cb.base;
-		iov[1].iov_base = page_address(sctp_con.rx_page);
-		msg.msg_iovlen = 2;
-	}
-	len = iov[0].iov_len + iov[1].iov_len;
-
-	r = ret = kernel_recvmsg(sctp_con.sock, &msg, iov, msg.msg_iovlen, len,
-				 MSG_NOSIGNAL | MSG_DONTWAIT);
-	if (ret <= 0)
-		goto out_close;
-
-	msg.msg_control = incmsg;
-	msg.msg_controllen = sizeof(incmsg);
-	cmsg = CMSG_FIRSTHDR(&msg);
-	sinfo = (struct sctp_sndrcvinfo *)CMSG_DATA(cmsg);
-
-	if (msg.msg_flags & MSG_NOTIFICATION) {
-		process_sctp_notification(&msg, page_address(sctp_con.rx_page));
-		return 0;
-	}
-
-	/* Is this a new association ? */
-	ni = nodeid2nodeinfo(le32_to_cpu(sinfo->sinfo_ppid), GFP_KERNEL);
-	if (ni) {
-		ni->assoc_id = sinfo->sinfo_assoc_id;
-		if (test_and_clear_bit(NI_INIT_PENDING, &ni->flags)) {
-
-			if (!test_and_set_bit(NI_WRITE_PENDING, &ni->flags)) {
-				spin_lock_bh(&write_nodes_lock);
-				list_add_tail(&ni->write_list, &write_nodes);
-				spin_unlock_bh(&write_nodes_lock);
-			}
-			wake_up_process(send_task);
-		}
-	}
-
-	/* INIT sends a message with length of 1 - ignore it */
-	if (r == 1)
-		return 0;
-
-	CBUF_ADD(&sctp_con.cb, ret);
-	ret = dlm_process_incoming_buffer(cpu_to_le32(sinfo->sinfo_ppid),
-					  page_address(sctp_con.rx_page),
-					  sctp_con.cb.base, sctp_con.cb.len,
-					  PAGE_CACHE_SIZE);
-	if (ret < 0)
-		goto out_close;
-	CBUF_EAT(&sctp_con.cb, ret);
-
-      out:
-	ret = 0;
-	goto out_ret;
-
-      out_resched:
-	lowcomms_data_ready(sctp_con.sock->sk, 0);
-	ret = 0;
-	schedule();
-	goto out_ret;
-
-      out_close:
-	if (ret != -EAGAIN)
-		log_print("error reading from sctp socket: %d", ret);
-      out_ret:
-	return ret;
-}
-
-/* Bind to an IP address. SCTP allows multiple address so it can do multi-homing */
-static int add_bind_addr(struct sockaddr_storage *addr, int addr_len, int num)
-{
-	mm_segment_t fs;
-	int result = 0;
-
-	fs = get_fs();
-	set_fs(get_ds());
-	if (num == 1)
-		result = sctp_con.sock->ops->bind(sctp_con.sock,
-					(struct sockaddr *) addr, addr_len);
-	else
-		result = sctp_con.sock->ops->setsockopt(sctp_con.sock, SOL_SCTP,
-				SCTP_SOCKOPT_BINDX_ADD, (char *)addr, addr_len);
-	set_fs(fs);
-
-	if (result < 0)
-		log_print("Can't bind to port %d addr number %d",
-			  dlm_config.tcp_port, num);
-
-	return result;
-}
-
-static void init_local(void)
-{
-	struct sockaddr_storage sas, *addr;
-	int i;
-
-	dlm_local_nodeid = dlm_our_nodeid();
-
-	for (i = 0; i < DLM_MAX_ADDR_COUNT - 1; i++) {
-		if (dlm_our_addr(&sas, i))
-			break;
-
-		addr = kmalloc(sizeof(*addr), GFP_KERNEL);
-		if (!addr)
-			break;
-		memcpy(addr, &sas, sizeof(*addr));
-		dlm_local_addr[dlm_local_count++] = addr;
-	}
-}
-
-/* Initialise SCTP socket and bind to all interfaces */
-static int init_sock(void)
-{
-	mm_segment_t fs;
-	struct socket *sock = NULL;
-	struct sockaddr_storage localaddr;
-	struct sctp_event_subscribe subscribe;
-	int result = -EINVAL, num = 1, i, addr_len;
-
-	if (!dlm_local_count) {
-		init_local();
-		if (!dlm_local_count) {
-			log_print("no local IP address has been set");
-			goto out;
-		}
-	}
-
-	result = sock_create_kern(dlm_local_addr[0]->ss_family, SOCK_SEQPACKET,
-				  IPPROTO_SCTP, &sock);
-	if (result < 0) {
-		log_print("Can't create comms socket, check SCTP is loaded");
-		goto out;
-	}
-
-	/* Listen for events */
-	memset(&subscribe, 0, sizeof(subscribe));
-	subscribe.sctp_data_io_event = 1;
-	subscribe.sctp_association_event = 1;
-	subscribe.sctp_send_failure_event = 1;
-	subscribe.sctp_shutdown_event = 1;
-	subscribe.sctp_partial_delivery_event = 1;
-
-	fs = get_fs();
-	set_fs(get_ds());
-	result = sock->ops->setsockopt(sock, SOL_SCTP, SCTP_EVENTS,
-				       (char *)&subscribe, sizeof(subscribe));
-	set_fs(fs);
-
-	if (result < 0) {
-		log_print("Failed to set SCTP_EVENTS on socket: result=%d",
-			  result);
-		goto create_delsock;
-	}
-
-	/* Init con struct */
-	sock->sk->sk_user_data = &sctp_con;
-	sctp_con.sock = sock;
-	sctp_con.sock->sk->sk_data_ready = lowcomms_data_ready;
-
-	/* Bind to all interfaces. */
-	for (i = 0; i < dlm_local_count; i++) {
-		memcpy(&localaddr, dlm_local_addr[i], sizeof(localaddr));
-		make_sockaddr(&localaddr, dlm_config.tcp_port, &addr_len);
-
-		result = add_bind_addr(&localaddr, addr_len, num);
-		if (result)
-			goto create_delsock;
-		++num;
-	}
-
-	result = sock->ops->listen(sock, 5);
-	if (result < 0) {
-		log_print("Can't set socket listening");
-		goto create_delsock;
-	}
-
-	return 0;
-
- create_delsock:
-	sock_release(sock);
-	sctp_con.sock = NULL;
- out:
-	return result;
-}
-
-
-static struct writequeue_entry *new_writequeue_entry(gfp_t allocation)
-{
-	struct writequeue_entry *entry;
-
-	entry = kmalloc(sizeof(struct writequeue_entry), allocation);
-	if (!entry)
-		return NULL;
-
-	entry->page = alloc_page(allocation);
-	if (!entry->page) {
-		kfree(entry);
-		return NULL;
-	}
-
-	entry->offset = 0;
-	entry->len = 0;
-	entry->end = 0;
-	entry->users = 0;
-
-	return entry;
-}
-
-void *dlm_lowcomms_get_buffer(int nodeid, int len, gfp_t allocation, char **ppc)
-{
-	struct writequeue_entry *e;
-	int offset = 0;
-	int users = 0;
-	struct nodeinfo *ni;
-
-	if (!atomic_read(&accepting))
-		return NULL;
-
-	ni = nodeid2nodeinfo(nodeid, allocation);
-	if (!ni)
-		return NULL;
-
-	spin_lock(&ni->writequeue_lock);
-	e = list_entry(ni->writequeue.prev, struct writequeue_entry, list);
-	if (((struct list_head *) e == &ni->writequeue) ||
-	    (PAGE_CACHE_SIZE - e->end < len)) {
-		e = NULL;
-	} else {
-		offset = e->end;
-		e->end += len;
-		users = e->users++;
-	}
-	spin_unlock(&ni->writequeue_lock);
-
-	if (e) {
-	      got_one:
-		if (users == 0)
-			kmap(e->page);
-		*ppc = page_address(e->page) + offset;
-		return e;
-	}
-
-	e = new_writequeue_entry(allocation);
-	if (e) {
-		spin_lock(&ni->writequeue_lock);
-		offset = e->end;
-		e->end += len;
-		e->ni = ni;
-		users = e->users++;
-		list_add_tail(&e->list, &ni->writequeue);
-		spin_unlock(&ni->writequeue_lock);
-		goto got_one;
-	}
-	return NULL;
-}
-
-void dlm_lowcomms_commit_buffer(void *arg)
-{
-	struct writequeue_entry *e = (struct writequeue_entry *) arg;
-	int users;
-	struct nodeinfo *ni = e->ni;
-
-	if (!atomic_read(&accepting))
-		return;
-
-	spin_lock(&ni->writequeue_lock);
-	users = --e->users;
-	if (users)
-		goto out;
-	e->len = e->end - e->offset;
-	kunmap(e->page);
-	spin_unlock(&ni->writequeue_lock);
-
-	if (!test_and_set_bit(NI_WRITE_PENDING, &ni->flags)) {
-		spin_lock_bh(&write_nodes_lock);
-		list_add_tail(&ni->write_list, &write_nodes);
-		spin_unlock_bh(&write_nodes_lock);
-		wake_up_process(send_task);
-	}
-	return;
-
-      out:
-	spin_unlock(&ni->writequeue_lock);
-	return;
-}
-
-static void free_entry(struct writequeue_entry *e)
-{
-	__free_page(e->page);
-	kfree(e);
-}
-
-/* Initiate an SCTP association. In theory we could just use sendmsg() on
-   the first IP address and it should work, but this allows us to set up the
-   association before sending any valuable data that we can't afford to lose.
-   It also keeps the send path clean as it can now always use the association ID */
-static void initiate_association(int nodeid)
-{
-	struct sockaddr_storage rem_addr;
-	static char outcmsg[CMSG_SPACE(sizeof(struct sctp_sndrcvinfo))];
-	struct msghdr outmessage;
-	struct cmsghdr *cmsg;
-	struct sctp_sndrcvinfo *sinfo;
-	int ret;
-	int addrlen;
-	char buf[1];
-	struct kvec iov[1];
-	struct nodeinfo *ni;
-
-	log_print("Initiating association with node %d", nodeid);
-
-	ni = nodeid2nodeinfo(nodeid, GFP_KERNEL);
-	if (!ni)
-		return;
-
-	if (nodeid_to_addr(nodeid, (struct sockaddr *)&rem_addr)) {
-		log_print("no address for nodeid %d", nodeid);
-		return;
-	}
-
-	make_sockaddr(&rem_addr, dlm_config.tcp_port, &addrlen);
-
-	outmessage.msg_name = &rem_addr;
-	outmessage.msg_namelen = addrlen;
-	outmessage.msg_control = outcmsg;
-	outmessage.msg_controllen = sizeof(outcmsg);
-	outmessage.msg_flags = MSG_EOR;
-
-	iov[0].iov_base = buf;
-	iov[0].iov_len = 1;
-
-	/* Real INIT messages seem to cause trouble. Just send a 1 byte message
-	   we can afford to lose */
-	cmsg = CMSG_FIRSTHDR(&outmessage);
-	cmsg->cmsg_level = IPPROTO_SCTP;
-	cmsg->cmsg_type = SCTP_SNDRCV;
-	cmsg->cmsg_len = CMSG_LEN(sizeof(struct sctp_sndrcvinfo));
-	sinfo = (struct sctp_sndrcvinfo *)CMSG_DATA(cmsg);
-	memset(sinfo, 0x00, sizeof(struct sctp_sndrcvinfo));
-	sinfo->sinfo_ppid = cpu_to_le32(dlm_local_nodeid);
-
-	outmessage.msg_controllen = cmsg->cmsg_len;
-	ret = kernel_sendmsg(sctp_con.sock, &outmessage, iov, 1, 1);
-	if (ret < 0) {
-		log_print("send INIT to node failed: %d", ret);
-		/* Try again later */
-		clear_bit(NI_INIT_PENDING, &ni->flags);
-	}
-}
-
-/* Send a message */
-static int send_to_sock(struct nodeinfo *ni)
-{
-	int ret = 0;
-	struct writequeue_entry *e;
-	int len, offset;
-	struct msghdr outmsg;
-	static char outcmsg[CMSG_SPACE(sizeof(struct sctp_sndrcvinfo))];
-	struct cmsghdr *cmsg;
-	struct sctp_sndrcvinfo *sinfo;
-	struct kvec iov;
-
-        /* See if we need to init an association before we start
-	   sending precious messages */
-	spin_lock(&ni->lock);
-	if (!ni->assoc_id && !test_and_set_bit(NI_INIT_PENDING, &ni->flags)) {
-		spin_unlock(&ni->lock);
-		initiate_association(ni->nodeid);
-		return 0;
-	}
-	spin_unlock(&ni->lock);
-
-	outmsg.msg_name = NULL; /* We use assoc_id */
-	outmsg.msg_namelen = 0;
-	outmsg.msg_control = outcmsg;
-	outmsg.msg_controllen = sizeof(outcmsg);
-	outmsg.msg_flags = MSG_DONTWAIT | MSG_NOSIGNAL | MSG_EOR;
-
-	cmsg = CMSG_FIRSTHDR(&outmsg);
-	cmsg->cmsg_level = IPPROTO_SCTP;
-	cmsg->cmsg_type = SCTP_SNDRCV;
-	cmsg->cmsg_len = CMSG_LEN(sizeof(struct sctp_sndrcvinfo));
-	sinfo = (struct sctp_sndrcvinfo *)CMSG_DATA(cmsg);
-	memset(sinfo, 0x00, sizeof(struct sctp_sndrcvinfo));
-	sinfo->sinfo_ppid = cpu_to_le32(dlm_local_nodeid);
-	sinfo->sinfo_assoc_id = ni->assoc_id;
-	outmsg.msg_controllen = cmsg->cmsg_len;
-
-	spin_lock(&ni->writequeue_lock);
-	for (;;) {
-		if (list_empty(&ni->writequeue))
-			break;
-		e = list_entry(ni->writequeue.next, struct writequeue_entry,
-			       list);
-		len = e->len;
-		offset = e->offset;
-		BUG_ON(len == 0 && e->users == 0);
-		spin_unlock(&ni->writequeue_lock);
-		kmap(e->page);
-
-		ret = 0;
-		if (len) {
-			iov.iov_base = page_address(e->page)+offset;
-			iov.iov_len = len;
-
-			ret = kernel_sendmsg(sctp_con.sock, &outmsg, &iov, 1,
-					     len);
-			if (ret == -EAGAIN) {
-				sctp_con.eagain_flag = 1;
-				goto out;
-			} else if (ret < 0)
-				goto send_error;
-		} else {
-			/* Don't starve people filling buffers */
-			schedule();
-		}
-
-		spin_lock(&ni->writequeue_lock);
-		e->offset += ret;
-		e->len -= ret;
-
-		if (e->len == 0 && e->users == 0) {
-			list_del(&e->list);
-			free_entry(e);
-			continue;
-		}
-	}
-	spin_unlock(&ni->writequeue_lock);
- out:
-	return ret;
-
- send_error:
-	log_print("Error sending to node %d %d", ni->nodeid, ret);
-	spin_lock(&ni->lock);
-	if (!test_and_set_bit(NI_INIT_PENDING, &ni->flags)) {
-		ni->assoc_id = 0;
-		spin_unlock(&ni->lock);
-		initiate_association(ni->nodeid);
-	} else
-		spin_unlock(&ni->lock);
-
-	return ret;
-}
-
-/* Try to send any messages that are pending */
-static void process_output_queue(void)
-{
-	struct list_head *list;
-	struct list_head *temp;
-
-	spin_lock_bh(&write_nodes_lock);
-	list_for_each_safe(list, temp, &write_nodes) {
-		struct nodeinfo *ni =
-		    list_entry(list, struct nodeinfo, write_list);
-		clear_bit(NI_WRITE_PENDING, &ni->flags);
-		list_del(&ni->write_list);
-
-		spin_unlock_bh(&write_nodes_lock);
-
-		send_to_sock(ni);
-		spin_lock_bh(&write_nodes_lock);
-	}
-	spin_unlock_bh(&write_nodes_lock);
-}
-
-/* Called after we've had -EAGAIN and been woken up */
-static void refill_write_queue(void)
-{
-	int i;
-
-	for (i=1; i<=max_nodeid; i++) {
-		struct nodeinfo *ni = nodeid2nodeinfo(i, 0);
-
-		if (ni) {
-			if (!test_and_set_bit(NI_WRITE_PENDING, &ni->flags)) {
-				spin_lock_bh(&write_nodes_lock);
-				list_add_tail(&ni->write_list, &write_nodes);
-				spin_unlock_bh(&write_nodes_lock);
-			}
-		}
-	}
-}
-
-static void clean_one_writequeue(struct nodeinfo *ni)
-{
-	struct list_head *list;
-	struct list_head *temp;
-
-	spin_lock(&ni->writequeue_lock);
-	list_for_each_safe(list, temp, &ni->writequeue) {
-		struct writequeue_entry *e =
-			list_entry(list, struct writequeue_entry, list);
-		list_del(&e->list);
-		free_entry(e);
-	}
-	spin_unlock(&ni->writequeue_lock);
-}
-
-static void clean_writequeues(void)
-{
-	int i;
-
-	for (i=1; i<=max_nodeid; i++) {
-		struct nodeinfo *ni = nodeid2nodeinfo(i, 0);
-		if (ni)
-			clean_one_writequeue(ni);
-	}
-}
-
-
-static void dealloc_nodeinfo(void)
-{
-	int i;
-
-	for (i=1; i<=max_nodeid; i++) {
-		struct nodeinfo *ni = nodeid2nodeinfo(i, 0);
-		if (ni) {
-			idr_remove(&nodeinfo_idr, i);
-			kfree(ni);
-		}
-	}
-}
-
-int dlm_lowcomms_close(int nodeid)
-{
-	struct nodeinfo *ni;
-
-	ni = nodeid2nodeinfo(nodeid, 0);
-	if (!ni)
-		return -1;
-
-	spin_lock(&ni->lock);
-	if (ni->assoc_id) {
-		ni->assoc_id = 0;
-		/* Don't send shutdown here, sctp will just queue it
-		   till the node comes back up! */
-	}
-	spin_unlock(&ni->lock);
-
-	clean_one_writequeue(ni);
-	clear_bit(NI_INIT_PENDING, &ni->flags);
-	return 0;
-}
-
-static int write_list_empty(void)
-{
-	int status;
-
-	spin_lock_bh(&write_nodes_lock);
-	status = list_empty(&write_nodes);
-	spin_unlock_bh(&write_nodes_lock);
-
-	return status;
-}
-
-static int dlm_recvd(void *data)
-{
-	DECLARE_WAITQUEUE(wait, current);
-
-	while (!kthread_should_stop()) {
-		int count = 0;
-
-		set_current_state(TASK_INTERRUPTIBLE);
-		add_wait_queue(&lowcomms_recv_wait, &wait);
-		if (!test_bit(CF_READ_PENDING, &sctp_con.flags))
-			schedule();
-		remove_wait_queue(&lowcomms_recv_wait, &wait);
-		set_current_state(TASK_RUNNING);
-
-		if (test_and_clear_bit(CF_READ_PENDING, &sctp_con.flags)) {
-			int ret;
-
-			do {
-				ret = receive_from_sock();
-
-				/* Don't starve out everyone else */
-				if (++count >= MAX_RX_MSG_COUNT) {
-					schedule();
-					count = 0;
-				}
-			} while (!kthread_should_stop() && ret >=0);
-		}
-		schedule();
-	}
-
-	return 0;
-}
-
-static int dlm_sendd(void *data)
-{
-	DECLARE_WAITQUEUE(wait, current);
-
-	add_wait_queue(sctp_con.sock->sk->sk_sleep, &wait);
-
-	while (!kthread_should_stop()) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (write_list_empty())
-			schedule();
-		set_current_state(TASK_RUNNING);
-
-		if (sctp_con.eagain_flag) {
-			sctp_con.eagain_flag = 0;
-			refill_write_queue();
-		}
-		process_output_queue();
-	}
-
-	remove_wait_queue(sctp_con.sock->sk->sk_sleep, &wait);
-
-	return 0;
-}
-
-static void daemons_stop(void)
-{
-	kthread_stop(recv_task);
-	kthread_stop(send_task);
-}
-
-static int daemons_start(void)
-{
-	struct task_struct *p;
-	int error;
-
-	p = kthread_run(dlm_recvd, NULL, "dlm_recvd");
-	error = IS_ERR(p);
-       	if (error) {
-		log_print("can't start dlm_recvd %d", error);
-		return error;
-	}
-	recv_task = p;
-
-	p = kthread_run(dlm_sendd, NULL, "dlm_sendd");
-	error = IS_ERR(p);
-       	if (error) {
-		log_print("can't start dlm_sendd %d", error);
-		kthread_stop(recv_task);
-		return error;
-	}
-	send_task = p;
-
-	return 0;
-}
-
-/*
- * This is quite likely to sleep...
- */
-int dlm_lowcomms_start(void)
-{
-	int error;
-
-	error = init_sock();
-	if (error)
-		goto fail_sock;
-	error = daemons_start();
-	if (error)
-		goto fail_sock;
-	atomic_set(&accepting, 1);
-	return 0;
-
- fail_sock:
-	close_connection();
-	return error;
-}
-
-/* Set all the activity flags to prevent any socket activity. */
-
-void dlm_lowcomms_stop(void)
-{
-	atomic_set(&accepting, 0);
-	sctp_con.flags = 0x7;
-	daemons_stop();
-	clean_writequeues();
-	close_connection();
-	dealloc_nodeinfo();
-	max_nodeid = 0;
-}
-
-int dlm_lowcomms_init(void)
-{
-	init_waitqueue_head(&lowcomms_recv_wait);
-	spin_lock_init(&write_nodes_lock);
-	INIT_LIST_HEAD(&write_nodes);
-	init_rwsem(&nodeinfo_lock);
-	return 0;
-}
-
-void dlm_lowcomms_exit(void)
-{
-	int i;
-
-	for (i = 0; i < dlm_local_count; i++)
-		kfree(dlm_local_addr[i]);
-	dlm_local_count = 0;
-	dlm_local_nodeid = 0;
-}
-
-- 
1.4.1



