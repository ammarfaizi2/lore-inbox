Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272599AbTHEJUV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 05:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272626AbTHEJUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 05:20:21 -0400
Received: from hera.cwi.nl ([192.16.191.8]:23739 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S272599AbTHEJUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 05:20:06 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 5 Aug 2003 11:20:02 +0200 (MEST)
Message-Id: <UTC200308050920.h759K2n21546.aeb@smtp.cwi.nl>
To: aebr@win.tue.nl, akpm@osdl.org
Subject: Re: i_blksize
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Andrew Morton <akpm@osdl.org>

    >  You propose to remove i_blksize.
    >  It is used in stat only, so we have to produce some value for stat.
    >  Do you want to replace
    >      inode->i_blksize
    >  by
    >      inode->i_sb->s_optimal_io_size
    >  ?

    No, that's different.  You are referring to stat.st_blksize.  That is a
    different animal, and we can leave that alone.

    inode->i_blksize is equal to (1 << inode->i_blkbits) always, all the time. 
    It is just duplicated nonsense and usually leads to poorer code -
    multiplications instead of shifts.

    It should be a pretty easy incremental set of patches to ease i_blksize out
    of the kernel.

Hmm. Let me first read stat.c.

generic_fillattr():
	stat->blksize = inode->i_blksize;
vfs_getattr():
	generic_fillattr(inode, stat);
	if (!stat->blksize)
		stat->blksize = s->s_blocksize;
cp_new_stat64():
	tmp.st_blksize = stat->blksize;
	copy_to_user(statbuf, &tmp, sizeof(tmp));

So really, if inode->i_blksize has a nonzero value,
this value is returned in stat.st_blksize.

Remains your other claim: inode->i_blksize == (1 << inode->i_blkbits).
I don't see any code that would enforce that.

Andries

[and there are lots of comments around:
	inode->i_blksize = PAGE_SIZE;   /* This is the optimal IO size ... */
]

Maybe also a good candidate for renaming if it is not eliminated?
