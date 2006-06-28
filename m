Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbWF1Q7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWF1Q7W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 12:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWF1Qym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:54:42 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33540 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751429AbWF1Qyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:54:31 -0400
Date: Wed, 28 Jun 2006 18:54:30 +0200
From: Adrian Bunk <bunk@stusta.de>
To: acme@mandriva.com
Cc: dccp@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [2.6 patch] net/dccp/: possible cleanups
Message-ID: <20060628165430.GM13915@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- sysctl.c: the Kconfig rules already disallow CONFIG_SYSCTL=n,
            there's no need for an additional check
- proper extern declarations for some variables in dccp.h
- make the following needlessly global function static:
  - ipv4.c: dccp_v4_checksum()
- #if 0 the following unused functions:
  - ackvec.c: dccp_ackvector_print()
  - ackvec.c: dccp_ackvec_print()
  - output.c: dccp_send_delayed_ack()

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 net/dccp/ackvec.c |    4 ++--
 net/dccp/dccp.h   |   11 +++++++----
 net/dccp/ipv4.c   |    9 +++++----
 net/dccp/output.c |    2 ++
 net/dccp/sysctl.c |   11 +----------
 5 files changed, 17 insertions(+), 20 deletions(-)

--- linux-2.6.17-mm2-full/net/dccp/ackvec.c.old	2006-06-27 03:39:45.000000000 +0200
+++ linux-2.6.17-mm2-full/net/dccp/ackvec.c	2006-06-27 03:40:26.000000000 +0200
@@ -320,7 +320,7 @@
 	return -EILSEQ;
 }
 
-#ifdef CONFIG_IP_DCCP_DEBUG
+#if 0
 void dccp_ackvector_print(const u64 ackno, const unsigned char *vector, int len)
 {
 	if (!dccp_debug)
@@ -346,7 +346,7 @@
 			     av->dccpav_buf + av->dccpav_buf_head,
 			     av->dccpav_vec_len);
 }
-#endif
+#endif  /*  0  */
 
 static void dccp_ackvec_throw_record(struct dccp_ackvec *av,
 				     struct dccp_ackvec_record *avr)
--- linux-2.6.17-mm2-full/net/dccp/dccp.h.old	2006-06-27 03:42:17.000000000 +0200
+++ linux-2.6.17-mm2-full/net/dccp/dccp.h	2006-06-27 03:45:06.000000000 +0200
@@ -33,6 +33,13 @@
 #define dccp_pr_debug_cat(format, a...)
 #endif
 
+extern int dccp_feat_default_sequence_window;
+extern int dccp_feat_default_rx_ccid;
+extern int dccp_feat_default_tx_ccid;
+extern int dccp_feat_default_ack_ratio;
+extern int dccp_feat_default_send_ack_vector;
+extern int dccp_feat_default_send_ndp_count;
+
 extern struct inet_hashinfo dccp_hashinfo;
 
 extern atomic_t dccp_orphan_count;
@@ -119,7 +126,6 @@
 extern int  dccp_retransmit_skb(struct sock *sk, struct sk_buff *skb);
 
 extern void dccp_send_ack(struct sock *sk);
-extern void dccp_send_delayed_ack(struct sock *sk);
 extern void dccp_send_sync(struct sock *sk, const u64 seq,
 			   const enum dccp_pkt_type pkt_type);
 
@@ -215,9 +221,6 @@
 extern int	   dccp_v4_connect(struct sock *sk, struct sockaddr *uaddr,
 				   int addr_len);
 
-extern int	   dccp_v4_checksum(const struct sk_buff *skb,
-				    const __be32 saddr, const __be32 daddr);
-
 extern int	   dccp_send_reset(struct sock *sk, enum dccp_reset_codes code);
 extern void	   dccp_send_close(struct sock *sk, const int active);
 extern int	   dccp_invalid_packet(struct sk_buff *skb);
--- linux-2.6.17-mm2-full/net/dccp/sysctl.c.old	2006-06-27 03:40:57.000000000 +0200
+++ linux-2.6.17-mm2-full/net/dccp/sysctl.c	2006-06-27 03:42:55.000000000 +0200
@@ -13,16 +13,7 @@
 #include <linux/mm.h>
 #include <linux/sysctl.h>
 
-#ifndef CONFIG_SYSCTL
-#error This file should not be compiled without CONFIG_SYSCTL defined
-#endif
-
-extern int dccp_feat_default_sequence_window;
-extern int dccp_feat_default_rx_ccid;
-extern int dccp_feat_default_tx_ccid;
-extern int dccp_feat_default_ack_ratio;
-extern int dccp_feat_default_send_ack_vector;
-extern int dccp_feat_default_send_ndp_count;
+#include "dccp.h"
 
 static struct ctl_table dccp_default_table[] = {
 	{
--- linux-2.6.17-mm2-full/net/dccp/ipv4.c.old	2006-06-27 03:43:27.000000000 +0200
+++ linux-2.6.17-mm2-full/net/dccp/ipv4.c	2006-06-27 03:44:50.000000000 +0200
@@ -39,6 +39,9 @@
  */
 static struct socket *dccp_v4_ctl_socket;
 
+static int dccp_v4_checksum(const struct sk_buff *skb, const __be32 saddr,
+			    const __be32 daddr);
+
 static int dccp_v4_get_port(struct sock *sk, const unsigned short snum)
 {
 	return inet_csk_get_port(&dccp_hashinfo, sk, snum,
@@ -623,8 +626,8 @@
 	return sk;
 }
 
-int dccp_v4_checksum(const struct sk_buff *skb, const __be32 saddr,
-		     const __be32 daddr)
+static int dccp_v4_checksum(const struct sk_buff *skb, const __be32 saddr,
+			    const __be32 daddr)
 {
 	const struct dccp_hdr* dh = dccp_hdr(skb);
 	int checksum_len;
@@ -643,8 +646,6 @@
 				 IPPROTO_DCCP, tmp);
 }
 
-EXPORT_SYMBOL_GPL(dccp_v4_checksum);
-
 static int dccp_v4_verify_checksum(struct sk_buff *skb,
 				   const __be32 saddr, const __be32 daddr)
 {
--- linux-2.6.17-mm2-full/net/dccp/output.c.old	2006-06-27 03:45:13.000000000 +0200
+++ linux-2.6.17-mm2-full/net/dccp/output.c	2006-06-27 03:45:28.000000000 +0200
@@ -484,6 +484,7 @@
 
 EXPORT_SYMBOL_GPL(dccp_send_ack);
 
+#if 0
 void dccp_send_delayed_ack(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
@@ -513,6 +514,7 @@
 	icsk->icsk_ack.timeout = timeout;
 	sk_reset_timer(sk, &icsk->icsk_delack_timer, timeout);
 }
+#endif  /*  0  */
 
 void dccp_send_sync(struct sock *sk, const u64 seq,
 		    const enum dccp_pkt_type pkt_type)

