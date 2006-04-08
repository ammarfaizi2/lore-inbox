Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964922AbWDHLn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbWDHLn3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 07:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWDHLn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 07:43:29 -0400
Received: from imf24aec.mail.bellsouth.net ([205.152.59.72]:40930 "EHLO
	imf24aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S964922AbWDHLn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 07:43:28 -0400
Subject: [PATCH 2.4.33-pre2] 2.4 nfs cache consistency problem with mmap'ed
	files
From: Jeff Layton <jtlayton@poochiereds.net>
To: nfs@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Content-Type: text/plain
Date: Sat, 08 Apr 2006 07:43:29 -0400
Message-Id: <1144496609.5573.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A customer of Red Hat reported a problem with cache invalidation when
using mmapped files over NFS with the 2.4 kernel. The steps to reproduce
this are a bit convoluted, so hopefully I'm explaining this well enough.
Let me know if you need clarification:

1) on a server create a file in an exported directory with some data in
it:

$ echo 1 > testfile

2) on an NFS client have a program mmap the file and access the data via
the mmap (effectively loading the pagecache with data from the server),
then have the program go to sleep indefinitely.

3) on the server, make a change to the file:

$ echo 2 > testfile

4) on the client, have another process cause a read:

$ cat /nfs/mounted/directory/testfile

You'll get the originally cached data (the 1), since the file is still
mmap'ed. This is expected.

5) on the client, kill the program that has the file mmap'ed and cat the
file again. You will still get the original file contents (the "1"
here).

The file is no longer mmap'ed, the data in the file and the mtime has
changed since the last on the wire read, but the client will not
invalidate the cache for subsequent reads.

What's happening is that in step 4, the __nfs_refresh_inode function
updates NFS_CACHE_MTIME. But, because the file is still mmap'ed,
invalidate_inode_pages is not completely successful. So on the next pass
through, it assumes the cached data is up to date when it isn't.

This patch fixes this by checking whether the clean_pages list
for the inode is empty after invalidate_inode_pages is called. If it's
not then we set a flag so on the next pass through it automatically
flags the data as invalid.

Signed-off-by: Jeff Layton <jtlayton@poochiereds.net>

--- linux-2.4/fs/nfs/inode.c.nfs-cache-fix
+++ linux-2.4/fs/nfs/inode.c
@@ -1047,6 +1047,13 @@ __nfs_refresh_inode(struct inode *inode,
 		invalid = 0;
 	}
 
+	/* set the invalid flag if the last attempt at invalidating
+	 * the inode didn't empty the clean_pages list */
+	if ( NFS_FLAGS(inode) & NFS_INO_MAPPED) {
+		NFS_FLAGS(inode) &= ~NFS_INO_MAPPED;
+		invalid = 1;
+	}
+
 	/*
 	 * If we have pending writebacks, things can get
 	 * messy.
@@ -1092,6 +1099,12 @@ __nfs_refresh_inode(struct inode *inode,
 		NFS_ATTRTIMEO(inode) = NFS_MINATTRTIMEO(inode);
 		NFS_ATTRTIMEO_UPDATE(inode) = jiffies;
 		invalidate_inode_pages(inode);
+		if (! list_empty(&inode->i_mapping->clean_pages)) {
+			dfprintk(PAGECACHE,
+				 "NFS: clean_pages for %x/%d is not empty\n",
+				 inode->i_dev, inode->i_ino);
+			NFS_FLAGS(inode) |= NFS_INO_MAPPED;
+		}
 		memset(NFS_COOKIEVERF(inode), 0, sizeof(NFS_COOKIEVERF(inode)));
 	} else if (time_after(jiffies, NFS_ATTRTIMEO_UPDATE(inode)+NFS_ATTRTIMEO(inode))) {
 		if ((NFS_ATTRTIMEO(inode) <<= 1) > NFS_MAXATTRTIMEO(inode))
--- linux-2.4/include/linux/nfs_fs_i.h.nfs-cache-fix
+++ linux-2.4/include/linux/nfs_fs_i.h
@@ -85,6 +85,7 @@ struct nfs_inode_info {
 #define NFS_INO_REVALIDATING	0x0004		/* revalidating attrs */
 #define NFS_IS_SNAPSHOT		0x0010		/* a snapshot file */
 #define NFS_INO_FLUSH		0x0020		/* inode is due for flushing */
+#define NFS_INO_MAPPED		0x0040		/* page invalidation failed */
 
 /*
  * NFS lock info


