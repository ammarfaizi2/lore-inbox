Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267416AbUIUAdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267416AbUIUAdI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 20:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267417AbUIUAdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 20:33:08 -0400
Received: from almesberger.net ([63.105.73.238]:38930 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S267416AbUIUAdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 20:33:03 -0400
Date: Mon, 20 Sep 2004 21:32:54 -0300
From: Werner Almesberger <werner@almesberger.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][2.6.7] round log buffer size to power of two
Message-ID: <20040920213254.B2093@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If setting the printk log buffer (with the boot command line
option "log_buf_len") to a value that's not a power of two, the 
index calculations go wrong and yield confusing results.

This patch rounds the size to the next higher power of two. 
It'll yield garbage for sizes > INT_MAX bytes.

The patch is for 2.6.7, but should apply equally to 2.6.9-rc2,
since the code in question hasn't changed.

- Werner

---------------------------------- cut here -----------------------------------

Signed-off-by: Werner Almesberger <werner@almesberger.net>

--- linux-2.6.7/kernel/printk.c.orig	Mon Sep 20 20:49:02 2004
+++ linux-2.6.7/kernel/printk.c	Mon Sep 20 21:26:09 2004
@@ -30,6 +30,7 @@
 #include <linux/smp.h>
 #include <linux/security.h>
 #include <linux/bootmem.h>
+#include <linux/bitops.h>
 
 #include <asm/uaccess.h>
 
@@ -192,6 +193,8 @@
 	unsigned long size = memparse(str, &str);
 	unsigned long flags;
 
+	if (size)
+		size = 1 << fls(size-1); /* round up to power of two */
 	if (size > log_buf_len) {
 		unsigned long start, dest_idx, offset;
 		char * new_log_buf;

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
