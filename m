Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbTIHIyg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 04:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbTIHIyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 04:54:35 -0400
Received: from angband.namesys.com ([212.16.7.85]:3524 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S262112AbTIHIye
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 04:54:34 -0400
Date: Mon, 8 Sep 2003 12:54:33 +0400
From: Oleg Drokin <green@namesys.com>
To: Alexander Vodomerov <alex@sectorb.msk.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sync crashed with segfault on 2.6.0-test4 (reiserfs partition)
Message-ID: <20030908085433.GB17718@namesys.com>
References: <200309051424.48834.alex@sectorb.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309051424.48834.alex@sectorb.msk.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Sep 05, 2003 at 02:24:48PM +0400, Alexander Vodomerov wrote:
> Yesterday I've tried 2.6.0-test4 kernel. It works fine about 17 hours, but
> suddenly sync command causes a segfault. I've made sync many times
> Sep  4 16:43:36 lorien kernel: EIP:    0060:[mpage_writepages+301/688]  
> Sep  4 16:43:36 lorien kernel:  [reiserfs_writepage+0/64] reiserfs_writepage+0x0/0x40
> Sep  4 16:43:36 lorien kernel:  [do_writepages+54/64] do_writepages+0x36/0x40
> Sep  4 16:43:36 lorien kernel:  [__sync_single_inode+169/496] __sync_single_inode+0xa9/0x1f0
> Sep  4 16:43:36 lorien kernel:  [sync_sb_inodes+396/560] sync_sb_inodes+0x18c/0x230
> Sep  4 16:43:36 lorien kernel:  [sync_inodes_sb+119/144] sync_inodes_sb+0x77/0x90
> Sep  4 16:43:36 lorien kernel:  [sync_inodes+43/160] sync_inodes+0x2b/0xa0
> Sep  4 16:43:36 lorien kernel:  [do_sync+35/112] do_sync+0x23/0x70
> Sep  4 16:43:36 lorien kernel:  [sys_sync+15/32] sys_sync+0xf/0x20
> Sep  4 16:43:36 lorien kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

This is fixed in current bk tree/current -mm tree.
The following patch should do the trick.

Bye,
    Oleg

diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Mon Sep  8 12:54:12 2003
+++ b/fs/reiserfs/inode.c	Mon Sep  8 12:54:12 2003
@@ -2048,8 +2048,8 @@
         last_offset = inode->i_size & (PAGE_CACHE_SIZE - 1) ;
 	/* no file contents in this page */
 	if (page->index >= end_index + 1 || !last_offset) {
-	    error = 0 ;
-	    goto done ;
+    	    unlock_page(page);
+	    return 0;
 	}
 	kaddr = kmap_atomic(page, KM_USER0);
 	memset(kaddr + last_offset, 0, PAGE_CACHE_SIZE-last_offset) ;
