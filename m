Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbTKBHbr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 02:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbTKBHbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 02:31:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:53228 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261539AbTKBHbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 02:31:46 -0500
Date: Sat, 1 Nov 2003 23:33:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: green@linuxhacker.ru, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0test9 Reiserfs boot time "buffer layer error at
 fs/buffer.c:431"
Message-Id: <20031101233354.1f566c80.akpm@osdl.org>
In-Reply-To: <E1AGCUJ-00016g-00@gondolin.me.apana.org.au>
References: <20031029141931.6c4ebdb5.akpm@osdl.org>
	<E1AGCUJ-00016g-00@gondolin.me.apana.org.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> Andrew Morton <akpm@osdl.org> wrote:
> > 
> >> (These buffers are there because reiserfs first reads that offset (in bytes)
> >> with whatever current blocksize is, except they should have been invalidated of
> >> course).
> >> Even if invalidate_bdev() -> invalidate_inode_pages() have not cleaned
> >> everything, truncate_inode_pages() should have done this.
> > 
> > yup.
> 
> The person who had the problem is actually using the Debian tree which
> carried over a patch from 2.4 that removed the truncate_inode_pages
> call in set_blocksize.  So I appologise for the noise.

aargh.  I thought Debian's 2.6 kernels were unmodified.  Are they carrying
any other changes?

> However, may I ask what is preventing us from achieving the goal that
> the page cache backed buffer heads can be resized without throwing away
> the pages?

That _should_ work.  The pagecache pages should be in such a state that all
buffers are freeable and yes, we can leave the pagecache there.  But this
could cause problems if the device was repartitioned in between, or if it
was hotswapped.  I don't think we shoot down pagecache anywhere else for
this.



truncate_inode_pages() will unconditionally remove the pages from
pagecache: they're gone.  So if some poorly behaved piece of code
(reiserfs's read_super_block()) holds a reference against a buffer, that
piece of code ends up owning the page - the VFS has lost interest in it.

This is almost always very bad - if truncate_inode_pages() against a
blockdev fails to cleanly remove all pages then it often means memory
leakage or data corruption.  I would like to have a warning which detects
this case but I never got around to it.

