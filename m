Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263267AbSJ1K7W>; Mon, 28 Oct 2002 05:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263270AbSJ1K7W>; Mon, 28 Oct 2002 05:59:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:6891 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263267AbSJ1K7V>;
	Mon, 28 Oct 2002 05:59:21 -0500
Date: Mon, 28 Oct 2002 12:04:27 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Fix file-corrupting bug, kernels 2.5.41 to 2.5.44
Message-ID: <20021028110427.GD844@suse.de>
References: <3DBCB904.FA9CC188@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DBCB904.FA9CC188@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27 2002, Andrew Morton wrote:
> 
> 
> This patch fixes a filesystem corrupting bug, present in 2.5.41 through
> 2.5.44.  It can cause ext2 indirect blocks to not be written out.  A
> fsck will fix it up.
> 
> Under heavy memory pressure a PF_MEMALLOC task attemtps to write out a
> blockdev page whose buffers are already under writeback and which were
> dirtied while under writeback.

Nasty, it's odd how noone else seems to have noticed this?

> The writepage call returns -EAGAIN but because the caller is
> PF_MEMALLOC, the page was not being marked dirty again.
> 
> The page sits on mapping->clean_pages for ever and it not written out.
> 
> The fix is to mark that page dirty again for all callers, regardless of
> PF_MEMALLOC state.

I can confirm that this fixes my 'loosing data under vm pressure' bug,
both for O_DIRECT case and sgio. It passed 1 iteration of both tests, it
would not even get past the 10% mark before. Thanks!

BTW, 2.5.44-mm6 showed some funnies and corrupted data in other
interesting ways. I'm hesitant to report this as a bug right now, as it
may just have been that the target fs had not been fsck'ed after being
run under one of the buggy kernels. But it did crash in the end, dumping
lots of hot/cold warnings. The above verification was run under 2.5.44 +
sgio patches + your standalone __set_page_dirty() fix.

-- 
Jens Axboe

