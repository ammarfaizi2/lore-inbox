Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262357AbVAOXGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbVAOXGh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 18:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbVAOXGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 18:06:34 -0500
Received: from ip18.tpack.net ([213.173.228.18]:30226 "HELO mail.tpack.net")
	by vger.kernel.org with SMTP id S262355AbVAOXGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 18:06:30 -0500
Message-ID: <41E9A25E.3010902@tpack.net>
Date: Sun, 16 Jan 2005 00:08:14 +0100
From: Tommy Christensen <tommy.christensen@tpack.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jmorris@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] audit: fixes in audit_log_drain()
Content-Type: multipart/mixed;
 boundary="------------040609020506010409040906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040609020506010409040906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Would this be for you, James?

o Fix skb leak
o Don't send shared skb's to netlink_unicast

Signed-off-by: Tommy S. Christensen <tommy.christensen@tpack.net>

-Tommy

--------------040609020506010409040906
Content-Type: text/plain;
 name="audit.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="audit.c.patch"

--- linux-2.6.11-rc1-bk3/kernel/audit.c	2005-01-12 14:54:15.000000000 +0100
+++ linux-2.6.11-work/kernel/audit.c	2005-01-15 23:51:25.399453674 +0100
@@ -483,6 +483,7 @@
 
 	while ((skb = skb_dequeue(&ab->sklist))) {
 		int retval = 0;
+		struct sk_buff *nskb;
 
 		if (audit_pid) {
 			if (ab->nlh) {
@@ -492,13 +493,17 @@
 				ab->nlh->nlmsg_seq   = 0;
 				ab->nlh->nlmsg_pid   = ab->pid;
 			}
-			skb_get(skb); /* because netlink_* frees */
-			retval = netlink_unicast(audit_sock, skb, audit_pid,
-						 MSG_DONTWAIT);
+			retval = -ENOMEM;
+			nskb = skb_clone(skb);
+			if (nskb)
+				retval = netlink_unicast(audit_sock, nskb,
+							 audit_pid,
+							 MSG_DONTWAIT);
 		}
 		if (retval == -EAGAIN && ab->count < 5) {
 			++ab->count;
 			audit_log_end_irq(ab);
+			kfree_skb(skb);
 			return 1;
 		}
 		if (retval < 0) {

--------------040609020506010409040906--
