Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751920AbWJNX3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbWJNX3V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 19:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752230AbWJNX3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 19:29:21 -0400
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:11231 "EHLO
	mail7.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1750892AbWJNX3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 19:29:20 -0400
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: akpm@osdl.org
Subject: [PATCH 2/2] fdtable: Avoid fdset cacheline ping-pong.
Date: Sat, 14 Oct 2006 16:29:19 -0700
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610141629.19522.vlobanov@speakeasy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a performance optimization for the fdtable code. When expanding the
fdtable for a task, we want to allocate at least L1_CACHE_BYTES for the new
fdset memory -- this will ensure that the fdsets of two different tasks will
not share the same cacheline, causing lots of cacheline ping-pongs.

Signed-off-by: Vadim Lobanov <vlobanov@speakeasy.net>

diff -Npru old/fs/file.c new/fs/file.c
--- old/fs/file.c	2006-10-14 15:40:12.000000000 -0700
+++ new/fs/file.c	2006-10-14 15:50:00.000000000 -0700
@@ -178,7 +178,8 @@ static struct fdtable * alloc_fdtable(un
 	if (!data)
 		goto out_fdt;
 	fdt->fd = (struct file **)data;
-	data = alloc_fdmem(2 * nr / BITS_PER_BYTE);
+	data = alloc_fdmem(max_t(unsigned int,
+				 2 * nr / BITS_PER_BYTE, L1_CACHE_BYTES));
 	if (!data)
 		goto out_arr;
 	fdt->open_fds = (fd_set *)data;
