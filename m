Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422746AbWJLC6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422746AbWJLC6H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 22:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422731AbWJLC6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 22:58:07 -0400
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:40911 "EHLO
	mail6.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1422746AbWJLC6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 22:58:04 -0400
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: akpm@osdl.org
Subject: [PATCH] fdtable: Eradicate fdarray overflow.
Date: Wed, 11 Oct 2006 19:58:03 -0700
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610111958.03238.vlobanov@speakeasy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

If you want it, here is the "actual patch format" fix for the random kernel
bug issue that has been discovered. This patch is functionally identical to
the one you grabbed, but contains comments and sign-offs.

Fix the computation of the length of an allocated fdarray, when we decide to
grow the fdtable. The rationale behind this fix is as follows:
=> The 'nr' variable is the requested fd, so will be one less than the minimum
   allowable fdarray size.
=> Due to the above fact, when we divide 'nr' by a fourth-of-a-page block, we
   will always be exactly one block short of the size we need.
=> Incrementing before the division is wrong, because the division will discard
   a non-zero modulo, possibly leaving us one fourth-of-a-page block short.

Signed-off-by: Vadim Lobanov <vlobanov@speakeasy.net>

diff -Npru old/fs/file.c new/fs/file.c
--- old/fs/file.c	2006-10-10 18:58:21.000000000 -0700
+++ new/fs/file.c	2006-10-11 19:37:23.000000000 -0700
@@ -164,9 +164,8 @@ static struct fdtable * alloc_fdtable(un
 	 * the fdarray into page-sized chunks: starting at a quarter of a page,
 	 * and growing in powers of two from there on.
 	 */
-	nr++;
 	nr /= (PAGE_SIZE / 4 / sizeof(struct file *));
-	nr = roundup_pow_of_two(nr);
+	nr = roundup_pow_of_two(nr + 1);
 	nr *= (PAGE_SIZE / 4 / sizeof(struct file *));
 	if (nr > NR_OPEN)
 		nr = NR_OPEN;
