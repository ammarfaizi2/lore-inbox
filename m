Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262140AbUKDJIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbUKDJIl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 04:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbUKDJIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 04:08:41 -0500
Received: from spc1-leed3-6-0-cust18.seac.broadband.ntl.com ([80.7.68.18]:15867
	"EHLO fentible.pjc.net") by vger.kernel.org with ESMTP
	id S262140AbUKDJIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 04:08:30 -0500
Date: Thu, 4 Nov 2004 09:08:28 +0000
From: Patrick Caulfield <pcaulfie@redhat.com>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] DECnet return codes
Message-ID: <20041104090828.GE26743@tykepenguin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the return codes from sendmsg/recvmsg when a signal happens.
Instead of always returning ERESTARTSYS (which confuses X11 rather badly) it
should return EINTR for non-blocking operations.

Signed-off-by: Patrick Caulfield <patrick@tykepenguin.com>

===== include/net/dn_nsp.h 1.6 vs edited =====
--- 1.6/include/net/dn_nsp.h	2004-02-18 21:15:52 +00:00
+++ edited/include/net/dn_nsp.h	2004-10-28 15:40:47 +01:00
@@ -37,7 +37,7 @@
 extern int dn_nsp_backlog_rcv(struct sock *sk, struct sk_buff *skb);
 
 extern struct sk_buff *dn_alloc_skb(struct sock *sk, int size, int pri);
-extern struct sk_buff *dn_alloc_send_skb(struct sock *sk, size_t *size, int noblock, int *err);
+extern struct sk_buff *dn_alloc_send_skb(struct sock *sk, size_t *size, int noblock, long timeo, int *err);
 
 #define NSP_REASON_OK 0		/* No error */
 #define NSP_REASON_NR 1		/* No resources */
===== net/decnet/af_decnet.c 1.44 vs edited =====
--- 1.44/net/decnet/af_decnet.c	2004-06-05 23:55:10 +01:00
+++ edited/net/decnet/af_decnet.c	2004-10-28 15:40:46 +01:00
@@ -1723,7 +1723,7 @@
 			goto out;
 
 		if (signal_pending(current)) {
-			rv = -ERESTARTSYS;
+			rv = sock_intr_errno(timeo);
 			goto out;
 		}
 
@@ -1957,7 +1957,7 @@
 			goto out;
 
 		if (signal_pending(current)) {
-			err = -ERESTARTSYS;
+			err = sock_intr_errno(timeo);
 			goto out;
 		}
 
@@ -1992,7 +1992,7 @@
 		/*
 		 * Get a suitably sized skb.
 		 */
-		skb = dn_alloc_send_skb(sk, &len, flags & MSG_DONTWAIT, &err);
+		skb = dn_alloc_send_skb(sk, &len, flags & MSG_DONTWAIT, timeo, &err);
 
 		if (err)
 			break;
===== net/decnet/dn_nsp_out.c 1.11 vs edited =====
--- 1.11/net/decnet/dn_nsp_out.c	2004-02-18 21:15:52 +00:00
+++ edited/net/decnet/dn_nsp_out.c	2004-10-28 15:40:46 +01:00
@@ -141,7 +141,7 @@
  * whole size thats been asked for (plus 11 bytes of header). If this
  * fails, then we try for any size over 16 bytes for SOCK_STREAMS.
  */
-struct sk_buff *dn_alloc_send_skb(struct sock *sk, size_t *size, int noblock, int *err)
+struct sk_buff *dn_alloc_send_skb(struct sock *sk, size_t *size, int noblock, long timeo, int *err)
 {
 	int space;
 	int len;
@@ -151,7 +151,7 @@
 
 	while(skb == NULL) {
 		if (signal_pending(current)) {
-			*err = ERESTARTSYS;
+			*err = sock_intr_errno(timeo);
 			break;
 		}
 
