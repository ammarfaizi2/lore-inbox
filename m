Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932689AbVLHWgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932689AbVLHWgh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 17:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684AbVLHWgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 17:36:24 -0500
Received: from uproxy.gmail.com ([66.249.92.196]:20082 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932687AbVLHWgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 17:36:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=ixWcW9DE5EEP4YJ5zhnB6zAC1t5T6Ib6tUowkM7Y8kgU2zREvTcokkm4I6tozbbcUM0JMS/0ffpwHufmlU+JBIsnky/Lrz59jq3QnPPjuLgCm4MBXjODNzAS3DUoZs5iSwt20sTd5pPzhmMyyAR7Pf+c7oujZ0rpuA/MzK8+WWk=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Decrease number of pointer derefs in connection.c
Date: Thu, 8 Dec 2005 23:36:36 +0100
User-Agent: KMail/1.9
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200512082336.36527.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a small patch to decrease the number of pointer derefs in
net/rxrpc/connection.c

Benefits of the patch:
 - Fewer pointer dereferences should make the code slightly faster.
 - Size of generated code is smaller
 - improved readability

Please consider applying.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 net/rxrpc/connection.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

orig:
   text    data     bss     dec     hex filename
   7146      40       4    7190    1c16 net/rxrpc/connection.o

patched:
   text    data     bss     dec     hex filename
   7140      40       4    7184    1c10 net/rxrpc/connection.o

--- linux-2.6.15-rc5-git1-orig/net/rxrpc/connection.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc5-git1/net/rxrpc/connection.c	2005-12-08 20:29:15.000000000 +0100
@@ -220,6 +220,7 @@ int rxrpc_connection_lookup(struct rxrpc
 {
 	struct rxrpc_connection *conn, *candidate = NULL;
 	struct list_head *_p;
+	struct sk_buff *pkt = msg->pkt;
 	int ret, fresh = 0;
 	__be32 x_epoch, x_connid;
 	__be16 x_port, x_servid;
@@ -229,10 +230,10 @@ int rxrpc_connection_lookup(struct rxrpc
 	_enter("%p{{%hu}},%u,%hu",
 	       peer,
 	       peer->trans->port,
-	       ntohs(msg->pkt->h.uh->source),
+	       ntohs(pkt->h.uh->source),
 	       ntohs(msg->hdr.serviceId));
 
-	x_port		= msg->pkt->h.uh->source;
+	x_port		= pkt->h.uh->source;
 	x_epoch		= msg->hdr.epoch;
 	x_clflag	= msg->hdr.flags & RXRPC_CLIENT_INITIATED;
 	x_connid	= htonl(ntohl(msg->hdr.cid) & RXRPC_CIDMASK);
@@ -267,7 +268,7 @@ int rxrpc_connection_lookup(struct rxrpc
 		/* fill in the specifics */
 		candidate->addr.sin_family	= AF_INET;
 		candidate->addr.sin_port	= x_port;
-		candidate->addr.sin_addr.s_addr = msg->pkt->nh.iph->saddr;
+		candidate->addr.sin_addr.s_addr = pkt->nh.iph->saddr;
 		candidate->in_epoch		= x_epoch;
 		candidate->out_epoch		= x_epoch;
 		candidate->in_clientflag	= RXRPC_CLIENT_INITIATED;
@@ -675,6 +676,7 @@ int rxrpc_conn_receive_call_packet(struc
 				   struct rxrpc_message *msg)
 {
 	struct rxrpc_message *pmsg;
+	struct dst_entry *dst;
 	struct list_head *_p;
 	unsigned cix, seq;
 	int ret = 0;
@@ -710,10 +712,10 @@ int rxrpc_conn_receive_call_packet(struc
 
 	call->pkt_rcv_count++;
 
-	if (msg->pkt->dst && msg->pkt->dst->dev)
+	dst = msg->pkt->dst;
+	if (dst && dst->dev)
 		conn->peer->if_mtu =
-			msg->pkt->dst->dev->mtu -
-			msg->pkt->dst->dev->hard_header_len;
+			dst->dev->mtu - dst->dev->hard_header_len;
 
 	/* queue on the call in seq order */
 	rxrpc_get_message(msg);


