Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317761AbSGPGWA>; Tue, 16 Jul 2002 02:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317762AbSGPGV7>; Tue, 16 Jul 2002 02:21:59 -0400
Received: from holomorphy.com ([66.224.33.161]:24449 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317761AbSGPGV6>;
	Tue, 16 Jul 2002 02:21:58 -0400
Date: Mon, 15 Jul 2002 23:24:53 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG] loop.c oopses
Message-ID: <20020716062453.GK1022@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

loop.c oopses when bio_copy() returns NULL. This was encountered while
running dbench 16 on a loopback-mounted reiserfs filesystem.

It still gets buffer layer errors with this patch, but they appear to
be non-fatal.

Backtrace from buffer layer errors:

Trace; c013ec00 <try_to_free_buffers+158/228>
Trace; c01bbbea <reiserfs_releasepage+66/90>
Trace; c013d727 <try_to_release_page+3f/54>
Trace; c013192d <shrink_cache+241/3d4>
Trace; c0131c57 <shrink_caches+5f/94>
Trace; c0131cac <try_to_free_pages+20/44>
Trace; c0132800 <balance_classzone+40/188>
Trace; c01bbb0d <reiserfs_commit_write+f1/168>
Trace; c0132a9b <__alloc_pages+153/1a0>
Trace; c01327b9 <_alloc_pages+19/20>
Trace; c012dac8 <generic_file_write+458/648>
Trace; c013b2af <vfs_write+9b/120>
Trace; c013b39e <sys_write+2a/40>
Trace; c010899b <syscall_call+7/b>


If what I've done is proper, it may be necessary to allow
try_to_free_buffers() to fail if (!was_uptodate && PageUptodate(page))

Below is the attempt I made to fix this (be gentle, I'm no block io expert):


Cheers,
Bill


===== drivers/block/loop.c 1.51 vs edited =====
--- 1.51/drivers/block/loop.c	Sun Jun 16 15:50:19 2002
+++ edited/drivers/block/loop.c	Tue Jul 16 00:02:22 2002
@@ -458,6 +458,9 @@
 
 	bio = bio_copy(rbh, GFP_NOIO, rbh->bi_rw & WRITE);
 
+	if (!bio)
+		return NULL;
+
 	bio->bi_end_io = loop_end_io_transfer;
 	bio->bi_private = rbh;
 
@@ -477,6 +480,9 @@
 	struct bio_vec *from_bvec, *to_bvec;
 	char *vto, *vfrom;
 	int ret = 0, i;
+
+	if (!to_bio)
+		return -ENOMEM;
 
 	__bio_for_each_segment(from_bvec, from_bio, i, 0) {
 		to_bvec = &to_bio->bi_io_vec[i];
