Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261945AbUKCWyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbUKCWyf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 17:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbUKCWw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 17:52:29 -0500
Received: from [203.2.177.22] ([203.2.177.22]:30982 "EHLO pinot.tusc.com.au")
	by vger.kernel.org with ESMTP id S261890AbUKCWsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 17:48:11 -0500
Subject: [PATCH] 2.6 X.25: When receiving a call, check listening sockets
	for matching call user data.
From: Andrew Hendry <ahendry@tusc.com.au>
To: linux-x25@vger.kernel.org, eis@baty.hanse.de
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1099521940.3060.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 04 Nov 2004 09:45:40 +1100
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Nov 2004 22:47:58.0337 (UTC) FILETIME=[2A438F10:01C4C1F7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If a listening socket sets call user data, ensure it only receives 
calls with matching call user data. Also ensure incoming calls with
matching call user data dont go to another listening socket.

Signed-off-by: Andrew Hendry <ahendry@tusc.com.au>


diff -uprN -X dontdiff linux-2.6.8.1-vanilla/include/net/x25.h linux-2.6.8.1/include/net/x25.h
--- linux-2.6.8.1-vanilla/include/net/x25.h	2004-08-14 20:55:35.000000000 +1000
+++ linux-2.6.8.1/include/net/x25.h	2004-11-03 08:32:53.000000000 +1100
@@ -243,6 +243,7 @@ extern int  x25_validate_nr(struct sock 
 extern void x25_write_internal(struct sock *, int);
 extern int  x25_decode(struct sock *, struct sk_buff *, int *, int *, int *, int *, int *);
 extern void x25_disconnect(struct sock *, int, unsigned char, unsigned char);
+extern int x25_check_calluserdata(struct x25_calluserdata *,struct x25_calluserdata *);
 
 /* x25_timer.c */
 extern void x25_start_heartbeat(struct sock *);
diff -uprN -X dontdiff linux-2.6.8.1-vanilla/net/x25/af_x25.c linux-2.6.8.1/net/x25/af_x25.c
--- linux-2.6.8.1-vanilla/net/x25/af_x25.c	2004-08-14 20:56:22.000000000 +1000
+++ linux-2.6.8.1/net/x25/af_x25.c	2004-11-04 09:25:44.205889168 +1100
@@ -223,14 +223,19 @@ static void x25_insert_socket(struct soc
 
 /*
  *	Find a socket that wants to accept the Call Request we just
- *	received.
+ *	received. Check the full list for an address/cud match.
+ *	If no cuds match return the next_best thing, an address match.
+ *	Note: if a listening socket has cud set it must only get calls
+ *	with matching cud.
  */
-static struct sock *x25_find_listener(struct x25_address *addr)
+static struct sock *x25_find_listener(struct x25_address *addr, struct x25_calluserdata *calluserdata)
 {
 	struct sock *s;
+	struct sock *next_best;
 	struct hlist_node *node;
 
 	read_lock_bh(&x25_list_lock);
+	next_best = NULL;
 
 	sk_for_each(s, node, &x25_list)
 		if ((!strcmp(addr->x25_addr,
@@ -238,9 +243,24 @@ static struct sock *x25_find_listener(st
 		     !strcmp(addr->x25_addr,
 			     null_x25_address.x25_addr)) &&
 		     s->sk_state == TCP_LISTEN) {
-			sock_hold(s);
-			goto found;
+
+			/*
+			 * Found a listening socket, now check the incoming
+			 * call user data vs this sockets call user data
+			 */
+			if (x25_check_calluserdata(&x25_sk(s)->calluserdata, calluserdata)) {
+				sock_hold(s);
+				goto found;
+			}
+			if (x25_sk(s)->calluserdata.cudlength == 0) {
+				next_best = s;
+			}
 		}
+	if (next_best) {
+		s = next_best;
+		sock_hold(s);
+		goto found;
+	}
 	s = NULL;
 found:
 	read_unlock_bh(&x25_list_lock);
@@ -814,6 +834,7 @@ int x25_rx_call_request(struct sk_buff *
 	struct x25_opt *makex25;
 	struct x25_address source_addr, dest_addr;
 	struct x25_facilities facilities;
+	struct x25_calluserdata calluserdata;
 	int len, rc;
 
 	/*
@@ -828,9 +849,27 @@ int x25_rx_call_request(struct sk_buff *
 	skb_pull(skb, x25_addr_ntoa(skb->data, &source_addr, &dest_addr));
 
 	/*
-	 *	Find a listener for the particular address.
+	 *	Get the length of the facilities, skip past them for the moment
+	 *	get the call user data because this is needed to determine
+	 *	the correct listener
+	 */
+	len = skb->data[0] + 1;
+	skb_pull(skb,len);
+
+	/*
+	 *	Incoming Call User Data.
+	 */
+	if (skb->len >= 0) {
+		memcpy(calluserdata.cuddata, skb->data, skb->len);
+		calluserdata.cudlength = skb->len;
+	}
+
+	skb_push(skb,len);
+
+	/*
+	 *	Find a listener for the particular address/cud pair.
 	 */
-	sk = x25_find_listener(&source_addr);
+	sk = x25_find_listener(&source_addr,&calluserdata);
 
 	/*
 	 *	We can't accept the Call Request.
@@ -859,7 +898,7 @@ int x25_rx_call_request(struct sk_buff *
 		goto out_sock_put;
 
 	/*
-	 *	Remove the facilities, leaving any Call User Data.
+	 *	Remove the facilities
 	 */
 	skb_pull(skb, len);
 
@@ -873,17 +912,10 @@ int x25_rx_call_request(struct sk_buff *
 	makex25->neighbour     = nb;
 	makex25->facilities    = facilities;
 	makex25->vc_facil_mask = x25_sk(sk)->vc_facil_mask;
+	makex25->calluserdata  = calluserdata;
 
 	x25_write_internal(make, X25_CALL_ACCEPTED);
 
-	/*
-	 *	Incoming Call User Data.
-	 */
-	if (skb->len >= 0) {
-		memcpy(makex25->calluserdata.cuddata, skb->data, skb->len);
-		makex25->calluserdata.cudlength = skb->len;
-	}
-
 	makex25->state = X25_STATE_3;
 
 	sk->sk_ack_backlog++;
diff -uprN -X dontdiff linux-2.6.8.1-vanilla/net/x25/x25_subr.c linux-2.6.8.1/net/x25/x25_subr.c
--- linux-2.6.8.1-vanilla/net/x25/x25_subr.c	2004-08-14 20:54:52.000000000 +1000
+++ linux-2.6.8.1/net/x25/x25_subr.c	2004-11-04 09:19:55.929835176 +1100
@@ -367,3 +367,22 @@ void x25_check_rbuf(struct sock *sk)
 		x25_stop_timer(sk);
 	}
 }
+
+/*
+ * Compare 2 calluserdata structures, used to find correct listening sockets
+ * when call user data is used.
+ */
+int x25_check_calluserdata(struct x25_calluserdata *ours, struct x25_calluserdata *theirs)
+{
+	int i;
+	if (ours->cudlength != theirs->cudlength)
+		return 0;
+
+	for (i=0;i<ours->cudlength;i++) {
+		if (ours->cuddata[i] != theirs->cuddata[i]) {
+			return 0;
+		}
+	}
+	return 1;
+}
+


