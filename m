Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263733AbUFNSPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263733AbUFNSPX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 14:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbUFNSPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 14:15:22 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:47100 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263733AbUFNSPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 14:15:04 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] DM 3/5: dm-io: Error handling
Date: Mon, 14 Jun 2004 13:18:09 +0000
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200406141309.31127.kevcorry@us.ibm.com>
In-Reply-To: <200406141309.31127.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406141318.09070.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dm-io: Proper error handling when someone is trying to read from multiple
regions.

Signed-off-by: Kevin Corry <kevcorry@us.ibm.com>

--- diff/drivers/md/dm-io.c	2004-06-14 10:46:31.944583472 +0000
+++ source/drivers/md/dm-io.c	2004-06-14 10:47:10.568711712 +0000
@@ -537,7 +537,10 @@
 {
 	struct io io;
 
-	BUG_ON(num_regions > 1 && rw != WRITE);
+	if (num_regions > 1 && rw != WRITE) {
+		WARN_ON(1);
+		return -EIO;
+	}
 
 	io.error = 0;
 	atomic_set(&io.count, 1); /* see dispatch_io() */
@@ -565,8 +568,15 @@
 static int async_io(unsigned int num_regions, struct io_region *where, int rw,
 	     struct dpages *dp, io_notify_fn fn, void *context)
 {
-	struct io *io = mempool_alloc(_io_pool, GFP_NOIO);
+	struct io *io;
+
+	if (num_regions > 1 && rw != WRITE) {
+		WARN_ON(1);
+		fn(1, context);
+		return -EIO;
+	}
 
+	io = mempool_alloc(_io_pool, GFP_NOIO);
 	io->error = 0;
 	atomic_set(&io->count, 1); /* see dispatch_io() */
 	io->sleeper = NULL;
