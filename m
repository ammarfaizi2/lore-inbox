Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267402AbTHERs5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 13:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267317AbTHERs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 13:48:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:16789 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269237AbTHERsh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 13:48:37 -0400
Date: Tue, 5 Aug 2003 10:50:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: i_blksize
Message-Id: <20030805105006.2769e44a.akpm@osdl.org>
In-Reply-To: <UTC200308051627.h75GR7J08241.aeb@smtp.cwi.nl>
References: <UTC200308051627.h75GR7J08241.aeb@smtp.cwi.nl>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
>
> > Looks like I got myself confused
> 
> Yes. But nevertheless, now that you brought this up,
> we might consider throwing out i_blksize.
> 
> I am not aware of anybody who actually uses this to give
> per-file advice. So, it could be in the superblock.

I suppose so.  reiserfs plays with it.

I can't really see that anyone would want to set the I/O size hint on a
per-inode basis, especially as the readahead and writebehind code will
cheerfully ignore it.

> Any objections?

I don't think it's worth fiddling with at this time, really.

> If sizeof(struct inode) decreases by 1% then we can keep 1% more inodes.
>
> That reminds me - I threw out i_dev and i_cdev, but Al reintroduced i_cdev.
> We should do as some comment says and make a union with i_bdev and i_pipe.
> Another 8 bytes gone.

Well all the inode slab caches are using SLAB_HWCACHE_ALIGN at present, so
it's a little moot.  Especially on a pentium4-compiled kernel.

But I expect most distributed 2.6 kernels will be pII or pIII-compiled. 
Let's look:

SMP:
	sizeof(struct ext2_inode_info) = 0x1d0
	sizeof(struct ext3_inode_info) = 0x1e0

Both of these pack eight-per-page.  Need to get them to 0x1c4 (and remove
SLAB_HWCACHE_ALIGN) to get to nine-per-page.

UP:
	sizeof(struct ext3_inode_info) = 0x1c4		(whew!)
	sizeof(struct ext2_inode_info) = 0x1b4

So for these filesystems at least, we need to remove SLAB_HWCACHE_ALIGN and
we will get a 12% improvement in packing density on uniprocessor.

unionification of i_[bcp]dev sounds like a good idea to give us a little
margin there.

