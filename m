Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWC3ISs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWC3ISs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWC3IRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:17:47 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:46163 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932103AbWC3IRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:17:42 -0500
Message-Id: <20060330081730.880049000@localhost.localdomain>
References: <20060330081605.085383000@localhost.localdomain>
Date: Thu, 30 Mar 2006 16:16:11 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, David Howells <dhowells@redhat.com>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 6/8] net/rxrpc: use list_move()
Content-Disposition: inline; filename=list-move-net.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts the combination of list_del(A) and list_add(A, B)
to list_move(A, B) under net/rxrpc.

CC: David Howells <dhowells@redhat.com>
Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 net/rxrpc/call.c       |    3 +--
 net/rxrpc/connection.c |    3 +--
 net/rxrpc/krxsecd.c    |    3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

Index: 2.6-git/net/rxrpc/call.c
===================================================================
--- 2.6-git.orig/net/rxrpc/call.c
+++ 2.6-git/net/rxrpc/call.c
@@ -1098,8 +1098,7 @@ static void rxrpc_call_receive_data_pack
 
 		call->app_ready_seq = pmsg->seq;
 		call->app_ready_qty += pmsg->dsize;
-		list_del_init(&pmsg->link);
-		list_add_tail(&pmsg->link, &call->app_readyq);
+		list_move_tail(&pmsg->link, &call->app_readyq);
 	}
 
 	/* see if we've got the last packet yet */
Index: 2.6-git/net/rxrpc/connection.c
===================================================================
--- 2.6-git.orig/net/rxrpc/connection.c
+++ 2.6-git/net/rxrpc/connection.c
@@ -402,8 +402,7 @@ void rxrpc_put_connection(struct rxrpc_c
 
 	/* move to graveyard queue */
 	_debug("burying connection: {%08x}", ntohl(conn->conn_id));
-	list_del(&conn->link);
-	list_add_tail(&conn->link, &peer->conn_graveyard);
+	list_move_tail(&conn->link, &peer->conn_graveyard);
 
 	rxrpc_krxtimod_add_timer(&conn->timeout, rxrpc_conn_timeout * HZ);
 
Index: 2.6-git/net/rxrpc/krxsecd.c
===================================================================
--- 2.6-git.orig/net/rxrpc/krxsecd.c
+++ 2.6-git/net/rxrpc/krxsecd.c
@@ -160,8 +160,7 @@ void rxrpc_krxsecd_clear_transport(struc
 	list_for_each_safe(_p, _n, &rxrpc_krxsecd_initmsgq) {
 		msg = list_entry(_p, struct rxrpc_message, link);
 		if (msg->trans == trans) {
-			list_del(&msg->link);
-			list_add_tail(&msg->link, &tmp);
+			list_move_tail(&msg->link, &tmp);
 			atomic_dec(&rxrpc_krxsecd_qcount);
 		}
 	}

--
