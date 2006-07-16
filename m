Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751585AbWGPNGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbWGPNGq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 09:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbWGPNGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 09:06:46 -0400
Received: from smtp-out4.iol.cz ([194.228.2.92]:7302 "EHLO smtp-out4.iol.cz")
	by vger.kernel.org with ESMTP id S1751269AbWGPNGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 09:06:45 -0400
Message-ID: <44BA39E5.7060002@feix.cz>
Date: Sun, 16 Jul 2006 15:06:45 +0200
From: Michal Feix <michal@feix.cz>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Paul.Clements@steeleye.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] nbd: Check magic before doing anything else
Content-Type: multipart/mixed;
 boundary="------------080406000500020205020803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080406000500020205020803
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

We should check magic sequence in reply packet before trying to find
request with it's request handle. This also solves the problem with
"Unexpected reply" message beeing logged, when packet with invalid magic
is received.

Signed-off-by: Michal Feix <michal@feix.cz>

---


--------------080406000500020205020803
Content-Type: text/plain;
 name="nbd.c.magic-check.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nbd.c.magic-check.diff"

diff -upr 2.6.18-rc2.orig/drivers/block/nbd.c 2.6.18-rc2/drivers/block/nbd.c
--- 2.6.18-rc2.orig/drivers/block/nbd.c	2006-07-16 14:34:09.106878500 +0200
+++ 2.6.18-rc2/drivers/block/nbd.c	2006-07-16 14:48:59.000000000 +0200
@@ -300,6 +300,15 @@ static struct request *nbd_read_stat(str
 				lo->disk->disk_name, result);
 		goto harderror;
 	}
+
+	if (ntohl(reply.magic) != NBD_REPLY_MAGIC) {
+		printk(KERN_ERR "%s: Wrong magic (0x%lx)\n",
+				lo->disk->disk_name,
+				(unsigned long)ntohl(reply.magic));
+		result = -EPROTO;
+		goto harderror;
+	}
+
 	req = nbd_find_request(lo, reply.handle);
 	if (unlikely(IS_ERR(req))) {
 		result = PTR_ERR(req);
@@ -312,13 +321,6 @@ static struct request *nbd_read_stat(str
 		goto harderror;
 	}
 
-	if (ntohl(reply.magic) != NBD_REPLY_MAGIC) {
-		printk(KERN_ERR "%s: Wrong magic (0x%lx)\n",
-				lo->disk->disk_name,
-				(unsigned long)ntohl(reply.magic));
-		result = -EPROTO;
-		goto harderror;
-	}
 	if (ntohl(reply.error)) {
 		printk(KERN_ERR "%s: Other side returned error (%d)\n",
 				lo->disk->disk_name, ntohl(reply.error));

--------------080406000500020205020803--
