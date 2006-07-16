Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbWGPNRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbWGPNRQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 09:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbWGPNRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 09:17:16 -0400
Received: from smtp-out4.iol.cz ([194.228.2.92]:19594 "EHLO smtp-out4.iol.cz")
	by vger.kernel.org with ESMTP id S1030257AbWGPNRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 09:17:16 -0400
Message-ID: <44BA3C58.5080708@firma.seznam.cz>
Date: Sun, 16 Jul 2006 15:17:12 +0200
From: Michal Feix <michal.feix@firma.seznam.cz>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Paul.Clements@steeleye.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] nbd: Abort request on data reception failure
Content-Type: multipart/mixed;
 boundary="------------050402020102020109080201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050402020102020109080201
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

When reading from nbd device, we need to receive all the data after
receiving reply packet from the server - otherwise such request will
never be ended.

If socket is closed right after accepting reply control packet and in
the middle of waiting for read data, nbd_read_stat() returns NULL and
nbd_end_request() is not called.

This patch fixes it.

Signed-off-by: Michal Feix <michal@feix.cz>
---


--------------050402020102020109080201
Content-Type: text/plain;
 name="nbd.c.always-end-request.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nbd.c.always-end-request.diff"

diff -upr 2.6.18-rc2.orig/drivers/block/nbd.c 2.6.18-rc2/drivers/block/nbd.c
--- 2.6.18-rc2.orig/drivers/block/nbd.c	2006-07-16 15:08:07.866293000 +0200
+++ 2.6.18-rc2/drivers/block/nbd.c	2006-07-16 15:08:55.361261250 +0200
@@ -339,7 +339,8 @@ static struct request *nbd_read_stat(str
 					printk(KERN_ERR "%s: Receive data failed (result %d)\n",
 							lo->disk->disk_name,
 							result);
-					goto harderror;
+					req->errors++;
+					return req;
 				}
 				dprintk(DBG_RX, "%s: request %p: got %d bytes data\n",
 					lo->disk->disk_name, req, bvec->bv_len);

--------------050402020102020109080201--
