Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319053AbSIJGkl>; Tue, 10 Sep 2002 02:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319055AbSIJGkl>; Tue, 10 Sep 2002 02:40:41 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:5204 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S319053AbSIJGki>; Tue, 10 Sep 2002 02:40:38 -0400
Date: Tue, 10 Sep 2002 08:45:36 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: ltp directio test causes oops on 2.4.20pre5aa2
Message-ID: <20020910064536.GE17868@dualathlon.random>
References: <20020909210236.GA3023@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020909210236.GA3023@rushmore>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

while merging the new nfs stuff with nfs-o_direct this bit was left out:

> diff -u --recursive --new-file linux-2.4.18-pathconf/mm/filemap.c linux-2.4.18-odirect/mm/filemap.c
> --- linux-2.4.18-pathconf/mm/filemap.c	Wed Feb 20 17:14:28 2002
> +++ linux-2.4.18-odirect/mm/filemap.c	Wed Feb 20 17:17:19 2002
> @@ -1515,7 +1515,7 @@
594a592,606
> --- 2.4.19pre3aa1/fs/reiserfs/inode.c.~1~	Tue Mar 12 00:07:18 2002
> +++ 2.4.19pre3aa1/fs/reiserfs/inode.c	Tue Mar 12 01:24:21 2002
> @@ -2161,10 +2161,11 @@
>  	}
>  }
>  
> -static int reiserfs_direct_io(int rw, struct inode *inode, 
> +static int reiserfs_direct_io(int rw, struct file * filp,
>                                struct kiobuf *iobuf, unsigned long blocknr,
>  			      int blocksize) 
>  {
> +    struct inode * inode = filp->f_dentry->d_inode->i_mapping->host;
>      return generic_direct_IO(rw, inode, iobuf, blocknr, blocksize,
>                               reiserfs_get_block_direct_io) ;
>  }

Trond could you include the reiserfs part in your nfs-o_direct too?
(ext3 has o_direct in -aa only so you don't need it) I'll keep them in
separate files so they won't be forgotten again.  In the meantime you
can test with this incremental fix:

--- 2.4.19pre3aa1/fs/reiserfs/inode.c.~1~	Tue Mar 12 00:07:18 2002
+++ 2.4.19pre3aa1/fs/reiserfs/inode.c	Tue Mar 12 01:24:21 2002
@@ -2161,10 +2161,11 @@
 	}
 }
 
-static int reiserfs_direct_io(int rw, struct inode *inode, 
+static int reiserfs_direct_io(int rw, struct file * filp,
                               struct kiobuf *iobuf, unsigned long blocknr,
 			      int blocksize) 
 {
+    struct inode * inode = filp->f_dentry->d_inode->i_mapping->host;
     return generic_direct_IO(rw, inode, iobuf, blocknr, blocksize,
                              reiserfs_get_block_direct_io) ;
 }
--- 2.4.20pre5aa2/fs/ext3/inode.c.~1~	Mon Sep  9 02:38:08 2002
+++ 2.4.20pre5aa2/fs/ext3/inode.c	Tue Sep 10 05:22:18 2002
@@ -1385,9 +1385,10 @@ static int ext3_releasepage(struct page 
 }
 
 static int
-ext3_direct_IO(int rw, struct inode *inode, struct kiobuf *iobuf,
+ext3_direct_IO(int rw, struct file * filp, struct kiobuf *iobuf,
 		unsigned long blocknr, int blocksize)
 {
+	struct inode * inode = filp->f_dentry->d_inode->i_mapping->host;
 	struct ext3_inode_info *ei = EXT3_I(inode);
 	handle_t *handle = NULL;
 	int ret;

thanks for the as usual accurate report,

Andrea

PS. Later I'll make sure the new sched can't introduce starvation, then
    I'll upload a new -aa with these few bits.
