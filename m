Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293238AbSBWWhN>; Sat, 23 Feb 2002 17:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293237AbSBWWg7>; Sat, 23 Feb 2002 17:36:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13316 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293236AbSBWWgS>;
	Sat, 23 Feb 2002 17:36:18 -0500
Message-ID: <3C781909.F69D8791@zip.com.au>
Date: Sat, 23 Feb 2002 14:34:49 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephen Lord <lord@sgi.com>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] only irq-safe atomic ops
In-Reply-To: <3C773C02.93C7753E@zip.com.au.suse.lists.linux.kernel> <1014444810.1003.53.camel@phantasy.suse.lists.linux.kernel> <3C773C02.93C7753E@zip.com.au.suse.lists.linux.kernel> <1014449389.1003.149.camel@phantasy.suse.lists.linux.kernel> <3C774AC8.5E0848A2@zip.com.au.suse.lists.linux.kernel> <3C77F503.1060005@sgi.com.suse.lists.linux.kernel> <3C77FB35.16844FE7@zip.com.au.suse.lists.linux.kernel>,		Andrew Morton's message of "23 Feb 2002 21:36:17 +0100" <p73y9hjq5mw.fsf@oldwotan.suse.de> <3C78045C.668AB945@zip.com.au> <3C780702.9060109@sgi.com> <3C780CDA.FEAF9CB4@zip.com.au> <3C781362.7070103@sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Lord wrote:
> 
> ...
> As I was plumbing in a sink ;-) the thought also occurred that you could
> have allocate and free counters per cpu. The fix up code could do leveling between
> them.

yup.  If fixup code is needed.

> Are you sure you only want to look at the actual value infrequently though?
> Every time you put a page into delalloc state you need to do something similar to
> balance_dirty(),

balance_dirty_pages() :)

> if you only poll the value periodically then it could get way out of
> balance before you noticed. It is very easy to dirty memory this way,
> cat /dev/zero > xxxx runs very quickly.

At present, I'm calling balance_dirty_pages() once per 32 pages within
generic_file_write().  And also once on the way out of generic_file_write().
Even if a zillion threads were writing at the same time, someone will do
an allocation and the VM will then send a pdflush thread off to perform
some writeback.   I think this is all OK.

One possible wart with delayed allocate is that we need to go off
and instantiate disk mappings at writepage() time, which may cause
extra memory squeezes.  I'm not particularly fussed about that at
this time.  It's a VM problem...

balance_dirty_pages does:

	if (dirty_pages > sync_threshold)
		sync_writeback();
	else if (dirty_pages > async_threshold)
		async_writeback();
	else if (dirty_pages > background_threshold)
		tell_a_pdflush_thread_to_do_some_writeback();

Current code is at http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.5/,
but I haven't released it yet :)

That code is presently shoving half-megabyte BIOs direct from
pagecache into the block layer.  There are no buffer_heads used
at all in the write(2) path.  One such BIO saves 128 buffer_head
allocations, 128 bio_allocs and a ton of request merging.

Unfortunately I seem to have found a bug in existing ext2, a bug
in existing block_write_full_page, a probable bug in the aic7xxx
driver, and an oops in the aic7xxx driver.  So progress has slowed
down a bit :(


> 
> I would almost say you need to get a 'reservation' of a delalloc page
> before you
> grab the memory. There are extra memory costs associated with getting the
> page out of this state, and if you do not hold threads back from
> dirtying pages
> you can end up in a situation where you cannot clean up again.
> 

I reserve the space in the filesystem at ->prepare_write() time.  If
there's no space, I force a writeback to cause all the outstanding
worst-case reservations to be collapsed into real disk mappings.  If
there's still no space, prepare_write returns -ENOSPC.

I terms of memory use, I think balance_dirty_pages takes care of
everything.  If there are too many dirty pages, the caller of
write(2) performs synchronous writeout, just as happens with the
legacy buffer_head-based writeout.

Early days yet.

-
