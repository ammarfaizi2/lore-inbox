Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316768AbSHTKOC>; Tue, 20 Aug 2002 06:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316770AbSHTKOC>; Tue, 20 Aug 2002 06:14:02 -0400
Received: from reload.namesys.com ([212.16.7.75]:2176 "EHLO reload.namesys.com")
	by vger.kernel.org with ESMTP id <S316768AbSHTKOB>;
	Tue, 20 Aug 2002 06:14:01 -0400
From: Hans Reiser <reiser@namesys.com>
To: marcelo@conectiva.com.br
Cc: reiser@namesys.com, green@namesys.com, linux-kernel@vger.kernel.org
Subject: [bk] Reiserfs patch 1 of 1 for 2.4.20
Message-Id: <20020820101802.3FB42A8C27@reload.namesys.com>
Date: Tue, 20 Aug 2002 14:18:02 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

    Credit to Oleg Drokin.  This changeset enables preallocation of blocks
    on reiserfs filesystems by default.  Prevents excessive
    interleaving of file layouts and excessive calls to the allocator
    that can hurt performance, especially on multiprocess workloads.
    This simply restores the default to what was in 2.4.19 but using the new
    allocator code.  Please apply.  You can get it from
    bk://thebsh.namesys.com/bk/reiser3-linux-2.4

Diffstat:
 fs/reiserfs/bitmap.c        |    3 +--
 fs/reiserfs/super.c         |    4 ++++
 include/linux/reiserfs_fs.h |    2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

Plain text patch:
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.587   -> 1.588  
#	include/linux/reiserfs_fs.h	1.21    -> 1.22   
#	 fs/reiserfs/super.c	1.21    -> 1.22   
#	fs/reiserfs/bitmap.c	1.15    -> 1.16   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/20	green@angband.namesys.com	1.588
# Turn on blocks preallocation by default for reiserfs.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/bitmap.c b/fs/reiserfs/bitmap.c
--- a/fs/reiserfs/bitmap.c	Tue Aug 20 13:43:25 2002
+++ b/fs/reiserfs/bitmap.c	Tue Aug 20 13:43:25 2002
@@ -15,7 +15,7 @@
 #include <linux/reiserfs_fs_sb.h>
 #include <linux/reiserfs_fs_i.h>
 
-#define PREALLOCATION_SIZE 8
+#define PREALLOCATION_SIZE 9
 
 #define INODE_INFO(inode) (&(inode)->u.reiserfs_i)
 
@@ -397,7 +397,6 @@
 {
     char * this_char, * value;
 
-    s->u.reiserfs_sb.s_alloc_options.preallocmin = 4;
     s->u.reiserfs_sb.s_alloc_options.bits = 0; /* clear default settings */
 
     for (this_char = strtok (options, ":"); this_char != NULL; this_char = strtok (NULL, ":")) {
diff -Nru a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Tue Aug 20 13:43:25 2002
+++ b/fs/reiserfs/super.c	Tue Aug 20 13:43:25 2002
@@ -1117,6 +1117,10 @@
     s->u.reiserfs_sb.s_mount_opt = ( 1 << REISERFS_SMALLTAIL );
     /* default block allocator option: skip_busy */
     s->u.reiserfs_sb.s_alloc_options.bits = ( 1 << 5);
+    /* If file grew past 4 blocks, start preallocation blocks for it. */
+    s->u.reiserfs_sb.s_alloc_options.preallocmin = 4;
+    /* Preallocate by 8 blocks (9-1) at once */
+    s->u.reiserfs_sb.s_alloc_options.preallocsize = 9;
 
     if (reiserfs_parse_options (s, (char *) data, &(s->u.reiserfs_sb.s_mount_opt), &blocks) == 0) {
 	return NULL;
diff -Nru a/include/linux/reiserfs_fs.h b/include/linux/reiserfs_fs.h
--- a/include/linux/reiserfs_fs.h	Tue Aug 20 13:43:25 2002
+++ b/include/linux/reiserfs_fs.h	Tue Aug 20 13:43:25 2002
@@ -56,7 +56,7 @@
 
 #define REISERFS_PREALLOCATE
 #define DISPLACE_NEW_PACKING_LOCALITIES
-#define PREALLOCATION_SIZE 8
+#define PREALLOCATION_SIZE 9
 
 /* n must be power of 2 */
 #define _ROUND_UP(x,n) (((x)+(n)-1u) & ~((n)-1u))
