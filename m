Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbULOBpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbULOBpY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 20:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbULOBoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 20:44:34 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:49166 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261794AbULOB0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 20:26:16 -0500
Date: Wed, 15 Dec 2004 02:26:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/rxrpc/: misc possible cleanups
Message-ID: <20041215012612.GG12937@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains the following possible cleanups:
- make some needlessly global code static
- remove the following unused global function:
  - transport.c: rxrpc_clear_transport
- remove the following unneeded EXPORT_SYMBOL:
  - rxrpc_syms.c: rxrpc_call_flush

Please comment on which of these changes are correct and which conflict
with pending patches.


diffstat output:
 include/rxrpc/call.h      |    5 -----
 include/rxrpc/packet.h    |    2 --
 include/rxrpc/transport.h |    2 --
 net/rxrpc/call.c          |   15 +++++++++------
 net/rxrpc/connection.c    |    4 +++-
 net/rxrpc/internal.h      |    3 ---
 net/rxrpc/peer.c          |    4 +++-
 net/rxrpc/rxrpc_syms.c    |    1 -
 net/rxrpc/transport.c     |   10 ----------
 9 files changed, 15 insertions(+), 31 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc3-mm1-full/include/rxrpc/packet.h.old	2004-12-14 22:24:02.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/rxrpc/packet.h	2004-12-14 22:24:10.000000000 +0100
@@ -124,6 +124,4 @@
 
 } __attribute__((packed));
 
-extern const char *rxrpc_acks[];
-
 #endif /* _LINUX_RXRPC_PACKET_H */
--- linux-2.6.10-rc3-mm1-full/include/rxrpc/call.h.old	2004-12-14 22:25:08.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/rxrpc/call.h	2004-12-14 22:28:41.000000000 +0100
@@ -20,9 +20,6 @@
 #define RXRPC_CALL_ACK_WINDOW_SIZE	16
 
 extern unsigned rxrpc_call_rcv_timeout;		/* receive activity timeout (secs) */
-extern unsigned rxrpc_call_acks_timeout;	/* pending ACK (retransmit) timeout (secs) */
-extern unsigned rxrpc_call_dfr_ack_timeout;	/* deferred ACK timeout (secs) */
-extern unsigned short rxrpc_call_max_resend;		/* maximum consecutive resend count */
 
 /* application call state
  * - only state 0 and ffff are reserved, the state is set to 1 after an opid is received
@@ -210,8 +207,6 @@
 				 int dup_data,
 				 size_t *size_sent);
 
-extern int rxrpc_call_flush(struct rxrpc_call *call);
-
 extern void rxrpc_call_handle_error(struct rxrpc_call *conn, int local, int errno);
 
 #endif /* _LINUX_RXRPC_CALL_H */
--- linux-2.6.10-rc3-mm1-full/net/rxrpc/call.c.old	2004-12-14 22:24:20.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/rxrpc/call.c	2004-12-14 22:28:53.000000000 +0100
@@ -26,10 +26,10 @@
 LIST_HEAD(rxrpc_calls);
 DECLARE_RWSEM(rxrpc_calls_sem);
 
-unsigned rxrpc_call_rcv_timeout		= HZ/3;
-unsigned rxrpc_call_acks_timeout	= HZ/3;
-unsigned rxrpc_call_dfr_ack_timeout	= HZ/20;
-unsigned short rxrpc_call_max_resend	= HZ/10;
+unsigned rxrpc_call_rcv_timeout			= HZ/3;
+static unsigned rxrpc_call_acks_timeout		= HZ/3;
+static unsigned rxrpc_call_dfr_ack_timeout	= HZ/20;
+static unsigned short rxrpc_call_max_resend	= HZ/10;
 
 const char *rxrpc_call_states[] = {
 	"COMPLETE",
@@ -58,7 +58,7 @@
 	"?09", "?10", "?11", "?12", "?13", "?14", "?15"
 };
 
-const char *rxrpc_acks[] = {
+static const char *rxrpc_acks[] = {
 	"---", "REQ", "DUP", "SEQ", "WIN", "MEM", "PNG", "PNR", "DLY", "IDL",
 	"-?-"
 };
@@ -79,6 +79,9 @@
 				 struct rxrpc_message *msg,
 				 rxrpc_seq_t seq,
 				 size_t count);
+
+static int rxrpc_call_flush(struct rxrpc_call *call);
+
 #define _state(call) \
 	_debug("[[[ state %s ]]]", rxrpc_call_states[call->app_call_state]);
 
@@ -2079,7 +2082,7 @@
 /*
  * flush outstanding packets to the network
  */
-int rxrpc_call_flush(struct rxrpc_call *call)
+static int rxrpc_call_flush(struct rxrpc_call *call)
 {
 	struct rxrpc_message *msg;
 	int ret = 0;
--- linux-2.6.10-rc3-mm1-full/net/rxrpc/rxrpc_syms.c.old	2004-12-14 22:28:26.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/rxrpc/rxrpc_syms.c	2004-12-14 22:28:29.000000000 +0100
@@ -23,7 +23,6 @@
 EXPORT_SYMBOL(rxrpc_call_abort);
 EXPORT_SYMBOL(rxrpc_call_read_data);
 EXPORT_SYMBOL(rxrpc_call_write_data);
-EXPORT_SYMBOL(rxrpc_call_flush);
 
 /* connection.c */
 EXPORT_SYMBOL(rxrpc_create_connection);
--- linux-2.6.10-rc3-mm1-full/net/rxrpc/internal.h.old	2004-12-14 22:29:18.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/rxrpc/internal.h	2004-12-14 22:30:16.000000000 +0100
@@ -73,7 +73,6 @@
 extern struct rw_semaphore rxrpc_conns_sem;
 extern unsigned long rxrpc_conn_timeout;
 
-extern void rxrpc_conn_do_timeout(struct rxrpc_connection *conn);
 extern void rxrpc_conn_clearall(struct rxrpc_peer *peer);
 
 /*
@@ -89,8 +88,6 @@
 
 extern void rxrpc_peer_clearall(struct rxrpc_transport *trans);
 
-extern void rxrpc_peer_do_timeout(struct rxrpc_peer *peer);
-
 
 /*
  * proc.c
--- linux-2.6.10-rc3-mm1-full/net/rxrpc/connection.c.old	2004-12-14 22:29:36.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/rxrpc/connection.c	2004-12-14 22:30:00.000000000 +0100
@@ -30,6 +30,8 @@
 DECLARE_RWSEM(rxrpc_conns_sem);
 unsigned long rxrpc_conn_timeout = 60 * 60;
 
+static void rxrpc_conn_do_timeout(struct rxrpc_connection *conn);
+
 static void __rxrpc_conn_timeout(rxrpc_timer_t *timer)
 {
 	struct rxrpc_connection *conn =
@@ -415,7 +417,7 @@
 /*
  * free a connection record
  */
-void rxrpc_conn_do_timeout(struct rxrpc_connection *conn)
+static void rxrpc_conn_do_timeout(struct rxrpc_connection *conn)
 {
 	struct rxrpc_peer *peer;
 
--- linux-2.6.10-rc3-mm1-full/net/rxrpc/peer.c.old	2004-12-14 22:30:23.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/rxrpc/peer.c	2004-12-14 22:30:41.000000000 +0100
@@ -30,6 +30,8 @@
 DECLARE_RWSEM(rxrpc_peers_sem);
 unsigned long rxrpc_peer_timeout = 12 * 60 * 60;
 
+static void rxrpc_peer_do_timeout(struct rxrpc_peer *peer);
+
 static void __rxrpc_peer_timeout(rxrpc_timer_t *timer)
 {
 	struct rxrpc_peer *peer =
@@ -259,7 +261,7 @@
  * handle a peer timing out in the graveyard
  * - called from krxtimod
  */
-void rxrpc_peer_do_timeout(struct rxrpc_peer *peer)
+static void rxrpc_peer_do_timeout(struct rxrpc_peer *peer)
 {
 	struct rxrpc_transport *trans = peer->trans;
 
--- linux-2.6.10-rc3-mm1-full/include/rxrpc/transport.h.old	2004-12-14 22:30:56.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/rxrpc/transport.h	2004-12-14 22:31:03.000000000 +0100
@@ -103,6 +103,4 @@
 				       struct rxrpc_message *msg,
 				       int error);
 
-extern void rxrpc_clear_transport(struct rxrpc_transport *trans);
-
 #endif /* _LINUX_RXRPC_TRANSPORT_H */
--- linux-2.6.10-rc3-mm1-full/net/rxrpc/transport.c.old	2004-12-14 22:31:11.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/rxrpc/transport.c	2004-12-14 22:31:20.000000000 +0100
@@ -150,16 +150,6 @@
 
 /*****************************************************************************/
 /*
- * clear the connections on a transport endpoint
- */
-void rxrpc_clear_transport(struct rxrpc_transport *trans)
-{
-	//struct rxrpc_connection *conn;
-
-} /* end rxrpc_clear_transport() */
-
-/*****************************************************************************/
-/*
  * destroy a transport endpoint
  */
 void rxrpc_put_transport(struct rxrpc_transport *trans)

