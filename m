Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbVCUA71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVCUA71 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 19:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVCUA71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 19:59:27 -0500
Received: from fire.osdl.org ([65.172.181.4]:44167 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261419AbVCUA7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 19:59:21 -0500
Date: Sun, 20 Mar 2005 16:59:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Function stack size usage (was [PATCH][1/2] SquashFS)
Message-Id: <20050320165902.10d99417.akpm@osdl.org>
In-Reply-To: <423E032C.4020103@lougher.demon.co.uk>
References: <4235BAC0.6020001@lougher.demon.co.uk>
	<20050314165117.1c5068b7.akpm@osdl.org>
	<423E032C.4020103@lougher.demon.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Lougher <phillip@lougher.demon.co.uk> wrote:
>
> Andrew Morton wrote:
> > Phillip Lougher <phillip@lougher.demon.co.uk> wrote:
> >>
> >>+static struct inode *squashfs_iget(struct super_block *s, squashfs_inode inode)
> >>+{
> >>+	struct inode *i;
> >>+	squashfs_sb_info *msBlk = (squashfs_sb_info *)s->s_fs_info;
> >>+	squashfs_super_block *sBlk = &msBlk->sBlk;
> >>+	unsigned int block = SQUASHFS_INODE_BLK(inode) +
> >>+		sBlk->inode_table_start;
> >>+	unsigned int offset = SQUASHFS_INODE_OFFSET(inode);
> >>+	unsigned int ino = SQUASHFS_MK_VFS_INODE(block
> >>+		- sBlk->inode_table_start, offset);
> >>+	unsigned int next_block, next_offset;
> >>+	squashfs_base_inode_header inodeb;
> > 
> > 
> > How much stack space is being used here?  Perhaps you should run
> > scripts/checkstack.pl across the whole thing.
> > 
> 
> A lot of the functions use a fair amount of stack (I never thought it 
> was excessive)...  This is the result of running checkstack.pl against 
> the code on Intel.
> 
> 0x00003a3c get_dir_index_using_name:                    596
> 0x00000d80 squashfs_iget:                               488
> 0x000044d8 squashfs_lookup:                             380
> 0x00003d00 squashfs_readdir:                            372
> 0x000020fe squashfs_fill_super:                         316
> 0x000031b8 squashfs_readpage:                           308
> 0x00002f5c read_blocklist:                              296
> 0x00003634 squashfs_readpage4K:                         284
> 
> A couple of these functions show a fair amount of stack use.  What is 
> the maximum acceptable usage,

There's no hard-and-fast rule.  The conditions running up to a stack
overrun are necessarily complex, and rare.  But you can see that for a
twenty or thirty function deep call stack, 500 bytes is a big bite out of
4k.

> i.e. do any of the above functions need 
> work to reduce their stack usage?

I'd say so, yes.  If at all possible.
