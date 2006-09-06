Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbWIFNkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbWIFNkK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 09:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbWIFNj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 09:39:56 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:51506 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750911AbWIFNif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 09:38:35 -0400
Message-Id: <20060906133955.730919000@chello.nl>
References: <20060906131630.793619000@chello.nl>>
User-Agent: quilt/0.45-1
Date: Wed, 06 Sep 2006 15:16:46 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Mike Christie <michaelc@cs.wisc.edu>
Subject: [PATCH 16/21] iscsi: fixup of the ep_connect patch
Content-Disposition: inline; filename=iscsi_ep_connect_fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Never hand out kernel pointers, and really never ever ask them back.
Also, iscsi_tcp_conn_bind expects it to be a valid file descriptor.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Mike Christie <michaelc@cs.wisc.edu>
---
 drivers/scsi/iscsi_tcp.c |   34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

Index: linux-2.6/drivers/scsi/iscsi_tcp.c
===================================================================
--- linux-2.6.orig/drivers/scsi/iscsi_tcp.c
+++ linux-2.6/drivers/scsi/iscsi_tcp.c
@@ -35,6 +35,8 @@
 #include <linux/kfifo.h>
 #include <linux/scatterlist.h>
 #include <linux/mutex.h>
+#include <linux/syscalls.h>
+#include <linux/file.h>
 #include <net/tcp.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_host.h>
@@ -1773,7 +1775,10 @@ iscsi_tcp_ep_connect(struct sockaddr *ds
 		goto release_sock;
 	}
 
-	*ep_handle = (uint64_t)(unsigned long)sock;
+	rc = sock_map_fd(sock);
+	if (rc < 0)
+		goto release_sock;
+	*ep_handle = (uint64_t)rc;
 	return 0;
 
 release_sock:
@@ -1791,12 +1796,7 @@ iscsi_tcp_ep_poll(uint64_t ep_handle, in
 static void
 iscsi_tcp_ep_disconnect(uint64_t ep_handle)
 {
-	struct socket *sock;
-
-	sock = (struct socket *)(unsigned long)ep_handle;
-	if (!sock)
-		return;
-	sock_release(sock);
+	sys_close(ep_handle);
 }
 
 static struct iscsi_cls_conn *
@@ -1846,6 +1846,19 @@ tcp_conn_alloc_fail:
 }
 
 static void
+iscsi_tcp_release_conn(struct iscsi_conn *conn)
+{
+	struct iscsi_tcp_conn *tcp_conn = conn->dd_data;
+
+	if (!tcp_conn->sock)
+		return;
+
+	fput(tcp_conn->sock->file);
+	tcp_conn->sock = NULL;
+	conn->recv_lock = NULL;
+}
+
+static void
 iscsi_tcp_conn_destroy(struct iscsi_cls_conn *cls_conn)
 {
 	struct iscsi_conn *conn = cls_conn->dd_data;
@@ -1855,6 +1868,7 @@ iscsi_tcp_conn_destroy(struct iscsi_cls_
 	if (conn->hdrdgst_en || conn->datadgst_en)
 		digest = 1;
 
+	iscsi_tcp_release_conn(conn);
 	iscsi_conn_teardown(cls_conn);
 
 	/* now free tcp_conn */
@@ -1875,6 +1889,7 @@ iscsi_tcp_conn_stop(struct iscsi_cls_con
 	struct iscsi_tcp_conn *tcp_conn = conn->dd_data;
 
 	iscsi_conn_stop(cls_conn, flag);
+	iscsi_tcp_release_conn(conn);
 	tcp_conn->hdr_size = sizeof(struct iscsi_hdr);
 }
 
@@ -1895,10 +1910,13 @@ iscsi_tcp_conn_bind(struct iscsi_cls_ses
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

--
