Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbUCUWub (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 17:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbUCUWub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 17:50:31 -0500
Received: from av7-2-sn1.fre.skanova.net ([81.228.11.114]:9944 "EHLO
	av7-2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261430AbUCUWu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 17:50:28 -0500
To: Linus Torvalds <torvalds@osdl.org>,
       Ben Fennema <bfennema@falcon.csc.calpoly.edu>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.5-rc1
References: <Pine.LNX.4.58.0403152154070.19853@ppc970.osdl.org>
From: Peter Osterlund <petero2@telia.com>
Date: 21 Mar 2004 23:50:22 +0100
In-Reply-To: <Pine.LNX.4.58.0403152154070.19853@ppc970.osdl.org>
Message-ID: <m2d675vmq9.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

>   o UDF filesystem update

For some reason I don't understand, this makes the UDF filesystem lock
up when I write a bunch of mp3 files to a CDRW using the packet
writing patch. Both "cp" and pdflush get stuck in __down. Reverting
the semaphore changes as in the patch below makes the problem go away,
but it's probably not the right solution to re-introduce lock_kernel()
calls.

diff -puN fs/udf/file.c~udf fs/udf/file.c
--- linux/fs/udf/file.c~udf	2004-03-21 23:25:26.000000000 +0100
+++ linux-petero/fs/udf/file.c	2004-03-21 23:26:46.000000000 +0100
@@ -247,9 +247,9 @@ static int udf_release_file(struct inode
 {
 	if (filp->f_mode & FMODE_WRITE)
 	{
-		down(&inode->i_sem);
+		lock_kernel();
 		udf_discard_prealloc(inode);
-		up(&inode->i_sem);
+		unlock_kernel();
 	}
 	return 0;
 }
diff -puN fs/udf/inode.c~udf fs/udf/inode.c
--- linux/fs/udf/inode.c~udf	2004-03-21 23:25:53.000000000 +0100
+++ linux-petero/fs/udf/inode.c	2004-03-21 23:26:21.000000000 +0100
@@ -84,9 +84,9 @@ void udf_put_inode(struct inode * inode)
 {
 	if (!(inode->i_sb->s_flags & MS_RDONLY))
 	{
-		down(&inode->i_sem);
+		lock_kernel();
 		udf_discard_prealloc(inode);
-		up(&inode->i_sem);
+		unlock_kernel();
 	}
 }
 

pdflush       D CA33461B  5504     6      3             8     5 (L-TLB)
c5f2bd68 00000046 c3ee2740 ca33461b 0000009f c5f2be8c c5f2bd40 c5478c3c 
       c10822a8 c5478cf8 ca33461b 0000009f c3ee2740 00097523 ca33461b 0000009f 
       c5f2d8e0 c5f2dad0 c5478cbc c5f2a000 00000286 c5f2bdc4 c0106303 00000000 
Call Trace:
 [<c0106303>] __down+0x143/0x360
 [<ca8d6710>] udf_writepage+0x0/0x30 [udf]
 [<c011a360>] default_wake_function+0x0/0x20
 [<c0106a27>] __down_failed+0xb/0x14
 [<ca8db8b5>] .text.lock.inode+0x5/0x20 [udf]
 [<c019cce6>] iput+0x76/0x90
 [<c01a677f>] sync_sb_inodes+0x26f/0x420
 [<ca8e0a98>] udf_write_super+0x178/0x1d0 [udf]
 [<c01a6acb>] writeback_inodes+0x19b/0x4b0
 [<c014e1eb>] wb_kupdate+0x10b/0x190
 [<c014e0e0>] wb_kupdate+0x0/0x190
 [<c014ebdc>] __pdflush+0x24c/0x660
 [<c0119ddb>] schedule+0x3cb/0x900
 [<c014f001>] pdflush+0x11/0x20
 [<c014e0e0>] wb_kupdate+0x0/0x190
 [<c013ceda>] kthread+0xaa/0xb0
 [<c014eff0>] pdflush+0x0/0x20
 [<c013ce30>] kthread+0x0/0xb0
 [<c0105455>] kernel_thread_helper+0x5/0x10

cp            D C10573C8  3988  1701   1083                     (NOTLB)
c1783b54 00000082 4419442a c10573c8 07d4103c 12171503 0d390f23 c5478c3c 
       07d4103c 12171503 440f442a c1783b40 07d4103c 0001d27c e17f96d9 0000009a 
       c1856ca0 c1856e90 c5478cbc c1782000 00000286 c1783bb0 c0106303 c1783b90 
Call Trace:
 [<c0106303>] __down+0x143/0x360
 [<ca8d9883>] udf_write_inode+0xa3/0x1c0 [udf]
 [<ca8d6710>] udf_writepage+0x0/0x30 [udf]
 [<c011a360>] default_wake_function+0x0/0x20
 [<c0106a27>] __down_failed+0xb/0x14
 [<ca8db8b5>] .text.lock.inode+0x5/0x20 [udf]
 [<c019cce6>] iput+0x76/0x90
 [<c01a677f>] sync_sb_inodes+0x26f/0x420
 [<c0200000>] nfs_release+0xc0/0x200
 [<c01a6acb>] writeback_inodes+0x19b/0x4b0
 [<c014cfc9>] get_page_state+0x19/0x20
 [<c014dcc4>] get_dirty_limits+0x14/0xd0
 [<c014de56>] balance_dirty_pages+0xd6/0x190
 [<c01498c4>] generic_file_aio_write_nolock+0x564/0xbf0
 [<c0147fbf>] do_generic_mapping_read+0x1bf/0x3e0
 [<c0148542>] generic_file_aio_read+0x52/0x70
 [<c0149fc8>] generic_file_write_nolock+0x78/0x90
 [<c01fd737>] nfs_file_read+0xb7/0x110
 [<c0173657>] do_sync_read+0x87/0xc0
 [<c014a0d5>] generic_file_write+0x55/0x70
 [<ca8d5b44>] udf_file_write+0x44/0x180 [udf]
 [<c017391f>] vfs_write+0xaf/0x120
 [<c0173a2f>] sys_write+0x3f/0x60
 [<c010835b>] syscall_call+0x7/0xb

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
