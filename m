Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267523AbSLNJad>; Sat, 14 Dec 2002 04:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267535AbSLNJad>; Sat, 14 Dec 2002 04:30:33 -0500
Received: from packet.digeo.com ([12.110.80.53]:17590 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267523AbSLNJab>;
	Sat, 14 Dec 2002 04:30:31 -0500
Message-ID: <3DFAFC07.DB5BB0FD@digeo.com>
Date: Sat, 14 Dec 2002 01:38:15 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul P Komkoff Jr <i@stingr.net>, ext2-devel@lists.sourceforge.net
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] 2.5.51-mm2
References: <20021213181155.GB2496@stingr.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Dec 2002 09:38:16.0454 (UTC) FILETIME=[876E7A60:01C2A354]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul P Komkoff Jr wrote:
> 
> This is very funny.

Actually it's very bad.  Thanks for reporting this.

> mke2fs -j -O dir_index -J size=192 -T news -N 1000100
> atest3 1000000
>  (creat & write 1 byte to 1000000 files)
> 
> free space on device became 0 and voila
> 
> Unable to handle kernel paging request at virtual address 5a5a5b9e


Here's a fix:



If ext3_add_nondir() fails it will do an iput() of the inode.  But we
continue to run ext3_mark_inode_dirty() against the potentially-freed
inode.  This oopses when slab poisoning is enabled.

Fix it so that we only run ext3_mark_inode_dirty() if the inode was
successfully instantiated.



 fs/ext3/namei.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

--- 25/fs/ext3/namei.c~ext3-use-after-free	Sat Dec 14 01:25:03 2002
+++ 25-akpm/fs/ext3/namei.c	Sat Dec 14 01:25:53 2002
@@ -1566,8 +1566,11 @@ static int ext3_add_nondir(handle_t *han
 {
 	int err = ext3_add_entry(handle, dentry, inode);
 	if (!err) {
-		d_instantiate(dentry, inode);
-		return 0;
+		err = ext3_mark_inode_dirty(handle, inode);
+		if (!err) {
+			d_instantiate(dentry, inode);
+			return 0;
+		}
 	}
 	ext3_dec_count(handle, inode);
 	iput(inode);
@@ -1609,7 +1612,6 @@ static int ext3_create (struct inode * d
 		else
 			inode->i_mapping->a_ops = &ext3_aops;
 		err = ext3_add_nondir(handle, dentry, inode);
-		ext3_mark_inode_dirty(handle, inode);
 	}
 	ext3_journal_stop(handle, dir);
 	unlock_kernel();
@@ -1642,7 +1644,6 @@ static int ext3_mknod (struct inode * di
 		inode->i_op = &ext3_special_inode_operations;
 #endif
 		err = ext3_add_nondir(handle, dentry, inode);
-		ext3_mark_inode_dirty(handle, inode);
 	}
 	ext3_journal_stop(handle, dir);
 	unlock_kernel();
@@ -2105,7 +2106,6 @@ static int ext3_symlink (struct inode * 
 	}
 	EXT3_I(inode)->i_disksize = inode->i_size;
 	err = ext3_add_nondir(handle, dentry, inode);
-	ext3_mark_inode_dirty(handle, inode);
 out_stop:
 	ext3_journal_stop(handle, dir);
 	unlock_kernel();
@@ -2140,7 +2140,6 @@ static int ext3_link (struct dentry * ol
 	atomic_inc(&inode->i_count);
 
 	err = ext3_add_nondir(handle, dentry, inode);
-	ext3_mark_inode_dirty(handle, inode);
 	ext3_journal_stop(handle, dir);
 	unlock_kernel();
 	return err;

_
