Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291075AbSBGCeb>; Wed, 6 Feb 2002 21:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291080AbSBGCeW>; Wed, 6 Feb 2002 21:34:22 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:21722 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S291075AbSBGCeE>; Wed, 6 Feb 2002 21:34:04 -0500
Date: Thu, 7 Feb 2002 03:33:42 +0100
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix page cache limit wrapping in filesystems
Message-ID: <20020207033342.A2032@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Several file systems in tree that nominally support files >2GB set their
s_maxbytes value to ~0ULL. This has the nasty side effect on 32bit machines
that when a file write reaches the page cache limit (e.g. 2^43) it'll silently
wrap and destroy data at the beginning of the file.

This patch changes the file systems in question to fill in a proper limit. 

I also have an alternate patch that adds a check for this generically
in super.c, but preliminary comments from Al suggested that he prefered
to do it in the file systems, so it is done this way way.

Patch for 2.5.4pre1. Please consider applying.

-Andi


--- linux-2.5.4pre1-work/fs/nfs/inode.c-MAXLFS	Thu Feb  7 01:44:22 2002
+++ linux-2.5.4pre1-work/fs/nfs/inode.c	Thu Feb  7 02:11:24 2002
@@ -455,6 +455,8 @@
                 server->namelen = maxlen;
 
 	sb->s_maxbytes = fsinfo.maxfilesize;
+	if (sb->s_maxbytes > MAX_LFS_FILESIZE) 
+		sb->s_maxbytes = MAX_LFS_FILESIZE; 
 
 	/* Fire up the writeback cache */
 	if (nfs_reqlist_alloc(server) < 0) {
--- linux-2.5.4pre1-work/fs/ntfs/fs.c-MAXLFS	Wed Jan 30 22:38:09 2002
+++ linux-2.5.4pre1-work/fs/ntfs/fs.c	Thu Feb  7 02:11:24 2002
@@ -1130,7 +1130,7 @@
 	/* Inform the kernel about which super operations are available. */
 	sb->s_op = &ntfs_super_operations;
 	sb->s_magic = NTFS_SUPER_MAGIC;
-	sb->s_maxbytes = ~0ULL >> 1;
+	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	ntfs_debug(DEBUG_OTHER, "Reading special files\n");
 	if (ntfs_load_special_files(vol)) {
 		ntfs_error("Error loading special files\n");
--- linux-2.5.4pre1-work/fs/udf/super.c-MAXLFS	Wed Jan 30 22:38:09 2002
+++ linux-2.5.4pre1-work/fs/udf/super.c	Thu Feb  7 02:11:24 2002
@@ -1544,7 +1544,7 @@
 		iput(inode);
 		goto error_out;
 	}
-	sb->s_maxbytes = ~0ULL;
+	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	return sb;
 
 error_out:
--- linux-2.5.4pre1-work/include/linux/fs.h-MAXLFS	Thu Feb  7 02:09:02 2002
+++ linux-2.5.4pre1-work/include/linux/fs.h	Thu Feb  7 02:11:24 2002
@@ -508,6 +508,14 @@
 
 #define	MAX_NON_LFS	((1UL<<31) - 1)
 
+/* Page cache limit. The filesystems should put that into their s_maxbytes 
+   limits, otherwise bad things can happen in VM. */ 
+#if BITS_PER_LONG==32
+#define MAX_LFS_FILESIZE	(((u64)PAGE_CACHE_SIZE << (BITS_PER_LONG-1))-1) 
+#elif BITS_PER_LONG==64
+#define MAX_LFS_FILESIZE 	0x7fffffffffffffff
+#endif
+
 #define FL_POSIX	1
 #define FL_FLOCK	2
 #define FL_BROKEN	4	/* broken flock() emulation */
