Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbWILPwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbWILPwq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 11:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWILPva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 11:51:30 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:38639 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751423AbWILPvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 11:51:16 -0400
Message-Id: <20060912144904.733945000@chello.nl>
References: <20060912143049.278065000@chello.nl>
User-Agent: quilt/0.45-1
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       David Miller <davem@davemloft.net>, Rik van Riel <riel@redhat.com>,
       Daniel Phillips <phillips@google.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Mike Christie <michaelc@cs.wisc.edu>
Subject: [PATCH 16/20] iscsi: add session context to ep_connect
Content-Disposition: inline; filename=iscsi_ep_connect_session.patch
Date: Tue, 12 Sep 2006 17:25:49 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order to do a proper reconnect we need to know if we're a swapper.
Only the session context can tell us that.

(This patch breaks the NETLINK_ISCSI ABI, userspace also needs a change)

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Mike Christie <michaelc@cs.wisc.edu>
---
 drivers/infiniband/ulp/iser/iscsi_iser.c |    3 ++-
 drivers/scsi/iscsi_tcp.c                 |    3 ++-
 drivers/scsi/scsi_transport_iscsi.c      |    4 +++-
 include/scsi/iscsi_if.h                  |    1 +
 include/scsi/scsi_transport_iscsi.h      |    3 ++-
 5 files changed, 10 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/scsi/iscsi_tcp.c
===================================================================
--- linux-2.6.orig/drivers/scsi/iscsi_tcp.c	2006-09-07 19:32:56.000000000 +0200
+++ linux-2.6/drivers/scsi/iscsi_tcp.c	2006-09-07 19:34:07.000000000 +0200
@@ -1729,7 +1729,8 @@ iscsi_tcp_ctask_xmit(struct iscsi_conn *
 }
 
 static int
-iscsi_tcp_ep_connect(struct sockaddr *dst_addr, int non_blocking,
+iscsi_tcp_ep_connect(struct iscsi_cls_session *cls_session,
+		     struct sockaddr *dst_addr, int non_blocking,
 		     uint64_t *ep_handle)
 {
 	struct socket *sock;
Index: linux-2.6/drivers/scsi/scsi_transport_iscsi.c
===================================================================
--- linux-2.6.orig/drivers/scsi/scsi_transport_iscsi.c	2006-09-07 19:32:37.000000000 +0200
+++ linux-2.6/drivers/scsi/scsi_transport_iscsi.c	2006-09-07 19:34:07.000000000 +0200
@@ -914,6 +914,7 @@ iscsi_if_transport_ep(struct iscsi_trans
 		      struct iscsi_uevent *ev, int msg_type)
 {
 	struct sockaddr *dst_addr;
+	struct iscsi_cls_session *session;
 	int rc = 0;
 
 	switch (msg_type) {
@@ -922,7 +923,8 @@ iscsi_if_transport_ep(struct iscsi_trans
 			return -EINVAL;
 
 		dst_addr = (struct sockaddr *)((char*)ev + sizeof(*ev));
-		rc = transport->ep_connect(dst_addr,
+		session = iscsi_session_lookup(ev->u.ep_connect.sid);
+		rc = transport->ep_connect(session, dst_addr,
 					   ev->u.ep_connect.non_blocking,
 					   &ev->r.ep_connect_ret.handle);
 		break;
Index: linux-2.6/include/scsi/iscsi_if.h
===================================================================
--- linux-2.6.orig/include/scsi/iscsi_if.h	2006-09-07 19:32:37.000000000 +0200
+++ linux-2.6/include/scsi/iscsi_if.h	2006-09-07 19:34:07.000000000 +0200
@@ -117,6 +117,7 @@ struct iscsi_uevent {
 		} get_stats;
 		struct msg_transport_connect {
 			uint32_t	non_blocking;
+			uint32_t	sid;
 		} ep_connect;
 		struct msg_transport_poll {
 			uint64_t	ep_handle;
Index: linux-2.6/include/scsi/scsi_transport_iscsi.h
===================================================================
--- linux-2.6.orig/include/scsi/scsi_transport_iscsi.h	2006-09-07 19:32:37.000000000 +0200
+++ linux-2.6/include/scsi/scsi_transport_iscsi.h	2006-09-07 19:34:07.000000000 +0200
@@ -120,7 +120,8 @@ struct iscsi_transport {
 	int (*xmit_mgmt_task) (struct iscsi_conn *conn,
 			       struct iscsi_mgmt_task *mtask);
 	void (*session_recovery_timedout) (struct iscsi_cls_session *session);
-	int (*ep_connect) (struct sockaddr *dst_addr, int non_blocking,
+	int (*ep_connect) (struct iscsi_cls_session *session,
+			   struct sockaddr *dst_addr, int non_blocking,
 			   uint64_t *ep_handle);
 	int (*ep_poll) (uint64_t ep_handle, int timeout_ms);
 	void (*ep_disconnect) (uint64_t ep_handle);
Index: linux-2.6/drivers/infiniband/ulp/iser/iscsi_iser.c
===================================================================
--- linux-2.6.orig/drivers/infiniband/ulp/iser/iscsi_iser.c	2006-09-07 19:32:37.000000000 +0200
+++ linux-2.6/drivers/infiniband/ulp/iser/iscsi_iser.c	2006-09-07 19:34:07.000000000 +0200
@@ -490,7 +490,8 @@ iscsi_iser_conn_get_stats(struct iscsi_c
 }
 
 static int
-iscsi_iser_ep_connect(struct sockaddr *dst_addr, int non_blocking,
+iscsi_iser_ep_connect(struct iscsi_cls_session *cls_session,
+		      struct sockaddr *dst_addr, int non_blocking,
 		      __u64 *ep_handle)
 {
 	int err;

--

