Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbWJNX2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWJNX2x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 19:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751920AbWJNX2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 19:28:53 -0400
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:62649 "EHLO
	mail2.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751057AbWJNX2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 19:28:53 -0400
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: akpm@osdl.org
Subject: [PATCH 1/2] fdtable: Bound minimum allocation size.
Date: Sat, 14 Oct 2006 16:28:52 -0700
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610141628.52372.vlobanov@speakeasy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies the fdtable minimum allocation unit, setting it to a fixed
size of 1024 bytes instead of basing it on the architecture page size. This
leaves the algorithm heuristics unchanged for the common 4K page size, but
does rebalance the "memory wasted versus number of reallocations" tradeoff for
architectures with larger page sizes (like 64K).

Signed-off-by: Vadim Lobanov <vlobanov@speakeasy.net>

diff -Npru old/fs/file.c new/fs/file.c
--- old/fs/file.c	2006-10-11 19:55:51.000000000 -0700
+++ new/fs/file.c	2006-10-14 15:20:05.000000000 -0700
@@ -161,12 +161,12 @@ static struct fdtable * alloc_fdtable(un
 	 * Figure out how many fds we actually want to support in this fdtable.
 	 * Allocation steps are keyed to the size of the fdarray, since it
 	 * grows far faster than any of the other dynamic data. We try to fit
-	 * the fdarray into page-sized chunks: starting at a quarter of a page,
+	 * the fdarray into comfortable page-tuned chunks: starting at 1024B
 	 * and growing in powers of two from there on.
 	 */
-	nr /= (PAGE_SIZE / 4 / sizeof(struct file *));
+	nr /= (1024 / sizeof(struct file *));
 	nr = roundup_pow_of_two(nr + 1);
-	nr *= (PAGE_SIZE / 4 / sizeof(struct file *));
+	nr *= (1024 / sizeof(struct file *));
 	if (nr > NR_OPEN)
 		nr = NR_OPEN;
 
