Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbTKCTxP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 14:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbTKCTxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 14:53:15 -0500
Received: from [217.73.128.98] ([217.73.128.98]:21895 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S262592AbTKCTxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 14:53:12 -0500
Date: Mon, 3 Nov 2003 21:53:06 +0200
Message-Id: <200311031953.hA3Jr6vM012874@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: Reiserfs 3.5 disk format and kernel 2.6.0test9
To: linux-kernel@vger.kernel.org
References: <1067869986.4841.4.camel@wathlon>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Jorge P?rez "Burgos (Koke)" <koke@eresmas.net> wrote:
JPrBK>         I have several partitions with 3.5.x reiserfs disk format, when i boot
JPrBK> up with kernel 2.6.0test9, i have these errors in each partition, even
JPrBK> though the system seems to work well:
JPrBK> buffer layer error at fs/buffer.c:431
JPrBK> Call Trace:
JPrBK>  [<c01559f5>] __find_get_block_slow+0x85/0x120

This all looks like this newly discovered problem with 2.6.0-test9 + debian
patchset. Either unapply the part about not doing truncate_inode_pages() in
fs/block_dev.c::kill_bdev()

or apply this patch below which should also help.

Bye,
    Oleg

===== fs/reiserfs/super.c 1.69 vs edited =====
--- 1.69/fs/reiserfs/super.c	Tue Sep 23 07:16:25 2003
+++ edited/fs/reiserfs/super.c	Sun Nov  2 11:11:36 2003
@@ -942,6 +942,7 @@
 {
     struct buffer_head * bh;
     struct reiserfs_super_block * rs;
+    int fs_blocksize;
  
 
     bh = sb_bread (s, offset / s->s_blocksize);
@@ -961,8 +962,9 @@
     //
     // ok, reiserfs signature (old or new) found in at the given offset
     //    
-    sb_set_blocksize (s, sb_blocksize(rs));
+    fs_blocksize = sb_blocksize(rs);
     brelse (bh);
+    sb_set_blocksize (s, fs_blocksize);
     
     bh = sb_bread (s, offset / s->s_blocksize);
     if (!bh) {
