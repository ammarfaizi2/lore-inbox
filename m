Return-Path: <linux-kernel-owner+w=401wt.eu-S964810AbXAGWYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbXAGWYG (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 17:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965230AbXAGWYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 17:24:06 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:52777 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964810AbXAGWYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 17:24:03 -0500
Date: Mon, 8 Jan 2007 09:23:41 +1100
From: David Chinner <dgc@sgi.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Sami Farin <7atbggg02@sneakemail.com>, Nathan Scott <nathans@sgi.com>,
       xfs@oss.sgi.com, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: BUG: warning at mm/truncate.c:60/cancel_dirty_page()
Message-ID: <20070107222341.GT33919298@melbourne.sgi.com>
References: <20070106023907.GA7766@m.safari.iki.fi> <Pine.LNX.4.64.0701062051570.24997@blonde.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701062051570.24997@blonde.wat.veritas.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2007 at 09:11:07PM +0000, Hugh Dickins wrote:
> On Sat, 6 Jan 2007, Sami Farin wrote:
> 
> > Linux 2.6.19.1 SMP [2] on Pentium D...
> > I was running dt-15.14 [2] and I ran
> > "cinfo datafile" (it does mincore()).
> > Well it went OK but when I ran "strace cinfo datafile"...:
> > 04:18:48.062466 mincore(0x37f1f000, 2147266560, 
> 
> You rightly noted in a followup that there have been changes to
> mincore, but I doubt they have any bearing on this: I think the
> BUG just happened at the same time as your mincore.
> 
> > ...
> > 2007-01-06 04:19:03.788181500 <4>BUG: warning at mm/truncate.c:60/cancel_dirty_page()
> > 2007-01-06 04:19:03.788221500 <4> [<c0103cfb>] dump_trace+0x215/0x21a
> > 2007-01-06 04:19:03.788223500 <4> [<c0103da3>] show_trace_log_lvl+0x1a/0x30
> > 2007-01-06 04:19:03.788224500 <4> [<c0103dcb>] show_trace+0x12/0x14
> > 2007-01-06 04:19:03.788225500 <4> [<c0103ec8>] dump_stack+0x19/0x1b
> > 2007-01-06 04:19:03.788227500 <4> [<c01546a6>] cancel_dirty_page+0x7e/0x80
> > 2007-01-06 04:19:03.788228500 <4> [<c01546c2>] truncate_complete_page+0x1a/0x47
> > 2007-01-06 04:19:03.788229500 <4> [<c0154854>] truncate_inode_pages_range+0x114/0x2ae
> > 2007-01-06 04:19:03.788245500 <4> [<c0154a08>] truncate_inode_pages+0x1a/0x1c
> > 2007-01-06 04:19:03.788247500 <4> [<c0269244>] fs_flushinval_pages+0x40/0x77
> > 2007-01-06 04:19:03.788248500 <4> [<c026d48c>] xfs_write+0x8c4/0xb68
> > 2007-01-06 04:19:03.788250500 <4> [<c0268b14>] xfs_file_aio_write+0x7e/0x95
> > 2007-01-06 04:19:03.788251500 <4> [<c016d66c>] do_sync_write+0xca/0x119
> > 2007-01-06 04:19:03.788265500 <4> [<c016d842>] vfs_write+0x187/0x18c
> > 2007-01-06 04:19:03.788267500 <4> [<c016d8e8>] sys_write+0x3d/0x64
> > 2007-01-06 04:19:03.788268500 <4> [<c0102e73>] syscall_call+0x7/0xb
> > 2007-01-06 04:19:03.788269500 <4> [<001cf410>] 0x1cf410
> > 2007-01-06 04:19:03.788289500 <4> =======================
> 
> So... XFS uses truncate_inode_pages when serving the write system call.

Only when you are doing direct I/O. XFS does direct writes without
the i_mutex held, so it has to invalidate the range of cached pages
while holding it's own locks to ensure direct I/O cache semantics are
kept.

> That's very inventive,

Not really - been doing it for years.

> and now it looks like Linus' cancel_dirty_page
> and new warning have caught it out.  VM people expect it to be called
> either when freeing an inode no longer in use, or when doing a truncate,
> after ensuring that all pages mapped into userspace have been taken out.

Ok, so we are punching a hole in the middle of the address space
because we are doing direct I/O on it and need to invalidate the
cache.

How are you supposed to invalidate a range of pages in a mapping for
this case, then? invalidate_mapping_pages() would appear to be the
candidate (the generic code uses this), but it _skips_ pages that
are already mapped.  invalidate_mapping_pages() then advises you to
use truncate_inode_pages():

/**
 * invalidate_mapping_pages - Invalidate all the unlocked pages of one inode
 * @mapping: the address_space which holds the pages to invalidate
 * @start: the offset 'from' which to invalidate
 * @end: the offset 'to' which to invalidate (inclusive)
 *
 * This function only removes the unlocked pages, if you want to
 * remove all the pages of one inode, you must call truncate_inode_pages.
 *
 * invalidate_mapping_pages() will not block on IO activity. It will not
 * invalidate pages which are dirty, locked, under writeback or mapped into
 * pagetables.
 */

We want to remove all pages within the range given, so, as directed by
the comment here, we use truncate_inode_pages(). Says nothing about
mappings needing to be removed first so I guess that's where we've
been caught.....

I think we can use invalidate_inode_pages2_range(), but that doesn't
handle partial page invalidations. I think this will be ok, but it's
going to need some serious fsx testing on blocksize != page size
configs.

So, am I correct in assuming we should be calling invalidate_inode_pages2_range()
instead of truncate_inode_pages()?

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
