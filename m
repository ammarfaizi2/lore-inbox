Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285060AbSA1KiB>; Mon, 28 Jan 2002 05:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286687AbSA1Khw>; Mon, 28 Jan 2002 05:37:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26127 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S285060AbSA1Khk>;
	Mon, 28 Jan 2002 05:37:40 -0500
Message-ID: <3C55282C.7D607CFB@zip.com.au>
Date: Mon, 28 Jan 2002 02:30:04 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] syscall latency improvement #1
In-Reply-To: <18993.1011984842@warthog.cambridge.redhat.com> <Pine.LNX.4.33.0201251626490.2042-100000@penguin.transmeta.com> <3C51FF0C.D3B1E2F7@zip.com.au>,
		<3C51FF0C.D3B1E2F7@zip.com.au> <200201281018.g0SAIIE22462@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> 
> > <thinks of another>
> >
> >       s/inline//g
> 
> I like this.

Well, it's a fairly small optimisation, but it's easy.

I did a patch a while back:  http://www.zip.com.au/~akpm/linux/2.4/2.4.17-pre1/inline.patch
This is purely against core kernel files:

 drivers/block/ll_rw_blk.c |   18 ++-------------
 fs/binfmt_elf.c           |    4 +--
 fs/block_dev.c            |    2 -
 fs/dcache.c               |    8 +++---
 fs/inode.c                |    6 ++---
 fs/locks.c                |    8 +++---
 fs/namei.c                |   14 ++++++------
 fs/namespace.c            |   42 ++++++++++++++++++++++++++++++++++++
 fs/open.c                 |    4 +--
 fs/read_write.c           |    2 -
 fs/stat.c                 |    2 -
 fs/super.c                |    2 -
 include/linux/fs_struct.h |   53 +++-------------------------------------------
 kernel/exit.c             |   10 ++++----
 kernel/fork.c             |    4 +--
 kernel/module.c           |    2 -
 kernel/sched.c            |    6 ++---
 kernel/signal.c           |    3 --
 kernel/sys.c              |    2 -
 kernel/timer.c            |    2 -
 lib/rwsem.c               |    4 +--
 mm/filemap.c              |    4 +--
 mm/highmem.c              |    2 -
 mm/memory.c               |    2 -
 mm/mmap.c                 |    4 +--
 mm/slab.c                 |   14 ++++++------

And it reduces the kernel image by 11 kbytes.  That's not much
RAM, but it's a lot of cache.  It's almost all hot-path stuff.

> ...
> * replace those with big_inline
> * #define it to 'inline' or to '' (nothing) and compare kernel sizes
> * make it CONFIG_xxx option if it worth the trouble

The first patch should be against Documentation/CodingStyle.
What are we trying to achieve here?  What are the guidelines
for when-to and when-to-not?  I'd say:

- If a function has a single call site and is static then it
  is always correct to inline.

- If a function is very small (20-30 bytes) then inlining
  is correct even if it has many call sites.

- If a function is less-small, and has only one or two
  *commonly called* call sites, then inlining is OK.

- If a function is a leaf function, then it is more inlinable
  than a function which makes another function call.

fs/inode.c:__sync_one() violates all the above quite
outrageously :)

-
