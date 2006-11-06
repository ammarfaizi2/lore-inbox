Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753844AbWKFVuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844AbWKFVuI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 16:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753843AbWKFVuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 16:50:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21990 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1753785AbWKFVuF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 16:50:05 -0500
Message-ID: <454FAE0A.3070409@redhat.com>
Date: Mon, 06 Nov 2006 15:50:02 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
CC: Theodore Tso <tytso@mit.edu>
Subject: [RFC/PATCH] - revert generic_fillattr stat->blksize to PAGE_CACHE_SIZE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The inode diet patches first did this to generic_fillattr():

-	stat->blksize = inode->i_blksize;
+	stat->blksize = PAGE_CACHE_SIZE;

but by 2.6.19-rc3 this was changed again:

-	stat->blksize = PAGE_CACHE_SIZE;
+	stat->blksize = (1 << inode->i_blkbits);

I can't find for sure why this was done; perhaps because it exposed a bug
in cifs[1]

However, if we are going to pick a default for generic_fillattr, it should probably
be what most filesystems were using before, and let filesystems which need something
else re-set it to according to their needs.  As it stands today, doing readdirs and
the like in block-sized chunks rather than page sized will probably not be the
best thing for performance.

A bit of quick parsing of the original inode diet patch shows that by far most
filesystems were using the page size:

(count) (line which sets i_blksize)
      1 cifs_inode->vfs_inode.i_blksize = CIFS_MAX_MSGSIZE;
      1 i->i_blksize = 512;
      1 inode->i_blksize = attr->va_blocksize;
      1 inode->i_blksize = befs_sb->block_size;
      1 inode->i_blksize = HFSPLUS_SB(inode->i_sb).alloc_blksz;
      1 inode->i_blksize = HFSPLUS_SB(sb).alloc_blksz;
      1 inode->i_blksize = HFS_SB(inode->i_sb)->alloc_blksz;
      1 inode->i_blksize = HFS_SB(sb)->alloc_blksz;
      1 inode->i_blksize = HPAGE_SIZE;
      1 inode->i_blksize = NCP_BLOCK_SIZE;
      1 inode->i_blksize = QNX4_DIR_ENTRY_SIZE;
      1 inode->i_blksize = (u32)osb->s_clustersize;
      1 inode->i_blksize = xfs_preferred_iosize(mp);
      1 ino->i_blksize = i_blksize;
      1 ino->i_blksize = proc_ino->i_blksize;
      1 ip->i_blksize = ip->i_sb->s_blocksize;
      1 ip->i_blksize = PAGE_SIZE;
      2 inode->i_blksize = fattr->du.nfs2.blocksize;
      2 inode->i_blksize = inode->i_sb->s_blocksize;
      2 inode->i_blksize = reiserfs_default_io_size;
      2 inode->i_blksize = sbi->cluster_size;
      2 vi->i_blksize = PAGE_CACHE_SIZE;
      3 inode->i_blksize = sb->s_blocksize;
      3 ret->i_blksize = PAGE_CACHE_SIZE;
      5 inode->i_blksize = 1024;
      7 inode->i_blksize = 0;
     12 inode->i_blksize = PAGE_SIZE;
     22 inode->i_blksize = PAGE_CACHE_SIZE;

so I would propose the following patch to make PAGE_CACHE_SIZE the default (again), 
and let filesystems which need something -else- do that on their own.

[1] http://lists.samba.org/archive/linux-cifs-client/2006-September/001481.html

Thanks,
-Eric

Signed-off-by: Eric Sandeen <sandeen@redhat.com>

--- linux.orig/fs/stat.c	2006-11-05 23:27:04.962482569 -0600
+++ linux/fs/stat.c	2006-11-05 23:27:29.394396050 -0600
@@ -33,7 +33,7 @@
  	stat->ctime = inode->i_ctime;
  	stat->size = i_size_read(inode);
  	stat->blocks = inode->i_blocks;
-	stat->blksize = (1 << inode->i_blkbits);
+	stat->blksize = PAGE_CACHE_SIZE;
  }

  EXPORT_SYMBOL(generic_fillattr);

