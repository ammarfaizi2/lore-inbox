Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262133AbULLVZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbULLVZr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 16:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbULLVYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 16:24:36 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:27655 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262133AbULLVX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 16:23:28 -0500
Date: Sun, 12 Dec 2004 22:23:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: eis@baty.hanse.de
Cc: linux-x25@vger.kernel.org, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/x25/: some cleanups
Message-ID: <20041212212318.GB22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below includes the following cleanups:
- make some needlessly global code static
- remove the following unused global functions:
  - net/x25/x25_dev.c: x25_llc_receive_frame
  - net/x25/x25_link.c: x25_transmit_diagnostic

Please review this patch.


diffstat output:
 include/net/x25.h  |    5 -----
 net/x25/af_x25.c   |    8 ++++----
 net/x25/x25_dev.c  |   23 -----------------------
 net/x25/x25_link.c |   33 +++++----------------------------
 net/x25/x25_proc.c |    4 ++--
 5 files changed, 11 insertions(+), 62 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/include/net/x25.h.old	2004-12-12 19:39:30.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/net/x25.h	2004-12-12 19:41:08.000000000 +0100
@@ -162,7 +162,6 @@
 			  struct x25_address *);
 extern int  x25_addr_aton(unsigned char *, struct x25_address *,
 			  struct x25_address *);
-extern unsigned int x25_new_lci(struct x25_neigh *);
 extern struct sock *x25_find_socket(unsigned int, struct x25_neigh *);
 extern void x25_destroy_socket(struct sock *);
 extern int  x25_rx_call_request(struct sk_buff *, struct x25_neigh *, unsigned int);
@@ -171,7 +170,6 @@
 /* x25_dev.c */
 extern void x25_send_frame(struct sk_buff *, struct x25_neigh *);
 extern int  x25_lapb_receive_frame(struct sk_buff *, struct net_device *, struct packet_type *);
-extern int  x25_llc_receive_frame(struct sk_buff *, struct net_device *, struct packet_type *);
 extern void x25_establish_link(struct x25_neigh *);
 extern void x25_terminate_link(struct x25_neigh *);
 
@@ -191,9 +189,6 @@
 extern void x25_link_device_down(struct net_device *);
 extern void x25_link_established(struct x25_neigh *);
 extern void x25_link_terminated(struct x25_neigh *);
-extern void x25_transmit_restart_request(struct x25_neigh *);
-extern void x25_transmit_restart_confirmation(struct x25_neigh *);
-extern void x25_transmit_diagnostic(struct x25_neigh *, unsigned char);
 extern void x25_transmit_clear_request(struct x25_neigh *, unsigned int, unsigned char);
 extern void x25_transmit_link(struct sk_buff *, struct x25_neigh *);
 extern int  x25_subscr_ioctl(unsigned int, void __user *);
--- linux-2.6.10-rc2-mm4-full/net/x25/af_x25.c.old	2004-12-12 19:38:22.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/x25/af_x25.c	2004-12-12 19:39:17.000000000 +0100
@@ -261,7 +261,7 @@
 /*
  *	Find a connected X.25 socket given my LCI and neighbour.
  */
-struct sock *__x25_find_socket(unsigned int lci, struct x25_neigh *nb)
+static struct sock *__x25_find_socket(unsigned int lci, struct x25_neigh *nb)
 {
 	struct sock *s;
 	struct hlist_node *node;
@@ -289,7 +289,7 @@
 /*
  *	Find a unique LCI for a given device.
  */
-unsigned int x25_new_lci(struct x25_neigh *nb)
+static unsigned int x25_new_lci(struct x25_neigh *nb)
 {
 	unsigned int lci = 1;
 	struct sock *sk;
@@ -1336,7 +1336,7 @@
 	return rc;
 }
 
-struct net_proto_family x25_family_ops = {
+static struct net_proto_family x25_family_ops = {
 	.family =	AF_X25,
 	.create =	x25_create,
 	.owner	=	THIS_MODULE,
@@ -1371,7 +1371,7 @@
 	.func =	x25_lapb_receive_frame,
 };
 
-struct notifier_block x25_dev_notifier = {
+static struct notifier_block x25_dev_notifier = {
 	.notifier_call = x25_device_event,
 };
 
--- linux-2.6.10-rc2-mm4-full/net/x25/x25_dev.c.old	2004-12-12 19:39:54.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/x25/x25_dev.c	2004-12-12 19:40:00.000000000 +0100
@@ -123,29 +123,6 @@
 	return 0;
 }
 
-int x25_llc_receive_frame(struct sk_buff *skb, struct net_device *dev,
-			  struct packet_type *ptype)
-{
-	struct x25_neigh *nb;
-	int rc = 0;
-
-	skb->sk = NULL;
-
-	/*
-	 * Packet received from unrecognised device, throw it away.
-	 */
-	nb = x25_get_neigh(dev);
-	if (!nb) {
-		printk(KERN_DEBUG "X.25: unknown_neighbour - %s\n", dev->name);
-		kfree_skb(skb);
-	} else {
-		rc = x25_receive_data(skb, nb);
-		x25_neigh_put(nb);
-	}
-
-	return rc;
-}
-
 void x25_establish_link(struct x25_neigh *nb)
 {
 	struct sk_buff *skb;
--- linux-2.6.10-rc2-mm4-full/net/x25/x25_link.c.old	2004-12-12 19:40:20.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/x25/x25_link.c	2004-12-12 19:41:23.000000000 +0100
@@ -35,6 +35,9 @@
 
 static void x25_t20timer_expiry(unsigned long);
 
+static void x25_transmit_restart_confirmation(struct x25_neigh *nb);
+static void x25_transmit_restart_request(struct x25_neigh *nb);
+
 /*
  *	Linux set/reset timer routines
  */
@@ -106,7 +109,7 @@
 /*
  *	This routine is called when a Restart Request is needed
  */
-void x25_transmit_restart_request(struct x25_neigh *nb)
+static void x25_transmit_restart_request(struct x25_neigh *nb)
 {
 	unsigned char *dptr;
 	int len = X25_MAX_L2_LEN + X25_STD_MIN_LEN + 2;
@@ -133,7 +136,7 @@
 /*
  * This routine is called when a Restart Confirmation is needed
  */
-void x25_transmit_restart_confirmation(struct x25_neigh *nb)
+static void x25_transmit_restart_confirmation(struct x25_neigh *nb)
 {
 	unsigned char *dptr;
 	int len = X25_MAX_L2_LEN + X25_STD_MIN_LEN;
@@ -156,32 +159,6 @@
 }
 
 /*
- * This routine is called when a Diagnostic is required.
- */
-void x25_transmit_diagnostic(struct x25_neigh *nb, unsigned char diag)
-{
-	unsigned char *dptr;
-	int len = X25_MAX_L2_LEN + X25_STD_MIN_LEN + 1;
-	struct sk_buff *skb = alloc_skb(len, GFP_ATOMIC);
-
-	if (!skb)
-		return;
-
-	skb_reserve(skb, X25_MAX_L2_LEN);
-
-	dptr = skb_put(skb, X25_STD_MIN_LEN + 1);
-
-	*dptr++ = nb->extended ? X25_GFI_EXTSEQ : X25_GFI_STDSEQ;
-	*dptr++ = 0x00;
-	*dptr++ = X25_DIAGNOSTIC;
-	*dptr++ = diag;
-
-	skb->sk = NULL;
-
-	x25_send_frame(skb, nb);
-}
-
-/*
  *	This routine is called when a Clear Request is needed outside of the context
  *	of a connected socket.
  */
--- linux-2.6.10-rc2-mm4-full/net/x25/x25_proc.c.old	2004-12-12 19:41:36.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/x25/x25_proc.c	2004-12-12 19:41:52.000000000 +0100
@@ -166,14 +166,14 @@
 	return 0;
 } 
 
-struct seq_operations x25_seq_route_ops = {
+static struct seq_operations x25_seq_route_ops = {
 	.start  = x25_seq_route_start,
 	.next   = x25_seq_route_next,
 	.stop   = x25_seq_route_stop,
 	.show   = x25_seq_route_show,
 };
 
-struct seq_operations x25_seq_socket_ops = {
+static struct seq_operations x25_seq_socket_ops = {
 	.start  = x25_seq_socket_start,
 	.next   = x25_seq_socket_next,
 	.stop   = x25_seq_socket_stop,

