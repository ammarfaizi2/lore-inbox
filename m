Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292336AbSBBSVP>; Sat, 2 Feb 2002 13:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292340AbSBBSVE>; Sat, 2 Feb 2002 13:21:04 -0500
Received: from 216-42-72-147.ppp.netsville.net ([216.42.72.147]:62627 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S292336AbSBBSU6>; Sat, 2 Feb 2002 13:20:58 -0500
Date: Sat, 02 Feb 2002 13:20:08 -0500
From: Chris Mason <mason@suse.com>
To: Chris Wedgwood <cw@f00f.org>, Steve Lord <lord@sgi.com>
cc: Andrew Morton <akpm@zip.com.au>, Ricardo Galli <gallir@uib.es>,
        Linux Kernel <linux-kernel@vger.kernel.org>, andrea@suse.de
Subject: Re: O_DIRECT fails in some kernel and FS
Message-ID: <234710000.1012674008@tiny>
In-Reply-To: <20020202093554.GA7207@tapu.f00f.org>
In-Reply-To: <E16WkQj-0005By-00@antoli.uib.es> <3C5AFE2D.95A3C02E@zip.com.au> <1012597538.26363.443.camel@jen.americas.sgi.com> <20020202093554.GA7207@tapu.f00f.org>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, the tricky part of direct io on reiserfs is the tails.  But, 
since direct io isn't allowed on non-page aligned file sizes, we'll
never have direct io onto a normal file tail.

< 2.4.18 reiserfs versions allowed expanding truncates to set i_size
without creating the corresponding metadata, so we still have to deal
with that.  It means we could have a packed tail on any file size,
including those bigger than the 16k limit after which we don't create
tails any more.

Chris and I had initially decided to unpack the tails on file open
if O_DIRECT is used, but it seems cleaner to add a 
reiserfs_get_block_direct_io, and have it return -EINVAL if a read
went to a tail.  writes that happen to a tail will trigger tail
conversion.

Anyway, this patch is very lightly tested, I'll try all the corner
cases on sunday.

-chris

# against 2.4.18-pe7
#
--- temp.1/fs/reiserfs/inode.c Mon, 28 Jan 2002 09:51:50 -0500 
+++ temp.1(w)/fs/reiserfs/inode.c Sat, 02 Feb 2002 12:26:50 -0500 
@@ -445,6 +445,20 @@
     return reiserfs_get_block(inode, block, bh_result, GET_BLOCK_NO_HOLE) ;
 }
 
+static int reiserfs_get_block_direct_io (struct inode * inode, long block,
+			struct buffer_head * bh_result, int create) {
+    int ret ;
+
+    ret = reiserfs_get_block(inode, block, bh_result, create) ;
+
+    /* don't allow direct io onto tail pages */
+    if (ret == 0 && buffer_mapped(bh_result) && bh_result->b_blocknr == 0) {
+        ret = -EINVAL ;
+    }
+    return ret ;
+}
+
+
 /*
 ** helper function for when reiserfs_get_block is called for a hole
 ** but the file tail is still in a direct item
@@ -2050,11 +2064,20 @@
     return ret ;
 }
 
+static int reiserfs_direct_io(int rw, struct inode *inode, 
+                              struct kiobuf *iobuf, unsigned long blocknr,
+			      int blocksize) 
+{
+    return generic_direct_IO(rw, inode, iobuf, blocknr, blocksize,
+                             reiserfs_get_block_direct_io) ;
+}
+
 struct address_space_operations reiserfs_address_space_operations = {
     writepage: reiserfs_writepage,
     readpage: reiserfs_readpage, 
     sync_page: block_sync_page,
     prepare_write: reiserfs_prepare_write,
     commit_write: reiserfs_commit_write,
-    bmap: reiserfs_aop_bmap
+    bmap: reiserfs_aop_bmap,
+    direct_IO: reiserfs_direct_io,
 } ;

