Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268097AbUIFPNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268097AbUIFPNG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 11:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268100AbUIFPNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 11:13:06 -0400
Received: from holomorphy.com ([207.189.100.168]:30361 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268097AbUIFPNA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 11:13:00 -0400
Date: Mon, 6 Sep 2004 08:12:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: saw@saw.sw.com.sg, linux-kernel@vger.kernel.org
Subject: Re: Q about pagecache data never written to disk
Message-ID: <20040906151252.GG3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, saw@saw.sw.com.sg,
	linux-kernel@vger.kernel.org
References: <20040905120147.A9202@castle.nmd.msu.ru> <20040905035233.6a6b5823.akpm@osdl.org> <20040905163344.GC3106@holomorphy.com> <20040906062432.GF3106@holomorphy.com> <20040906000254.71f03470.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040906000254.71f03470.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> And, interestingly, the only user of the result of set_page_dirty() is
>> redirty_page_for_writepage(), whose results are ignored by all callers.
>> It appears that something is amiss here, as failed reservations aren't
>> reported until something attempts background writeback or IO syscalls.
>> That is, it would seem that checking the results of set_page_dirty(),
>> also called in the MS_ASYNC case, suffices, however, it does not return
>> useful results in most (all?) cases, and nothing now checks its result.

On Mon, Sep 06, 2004 at 12:02:54AM -0700, Andrew Morton wrote:
> Yes, the non-void return value from set_page_dirty() is a holdover from my
> very early allocate-on-flush patches, wherein set_page_dirty() did indeed
> reserve space in the filesystem.

Supposing one maintained upper and lower bounds on reserved space the
best it appears to be able to do is a check on the lower bound and
opportunistically add to the upper bound, as it's nonblocking. If the
callers could be given hints to back out of their locks and retry
reservations while blocking, that may do. filemap_fdatawait() can, but
there are a lot of bizarre callers, e.g. fs/hfsplus/bnode.c, and no one
maintains that kind of information.


William Lee Irwin III <wli@holomorphy.com> wrote:
>> The calling convention looks very very odd also; filemap_fdatawait() is
>> the only apparent way to extract an ENOSPC result without calling the
>> ->writepage() method directly, and this, instead of checking for things
>> returning -ENOSPC as one would expect, does a rather odd thing, that is
>> test_and_clear_bit(AS_ENOSPC, &mapping->flags), which will lose all but
>> one of the results whenever there are multiple concurrent callers of it
>> on a single inode. Worse yet, that can be legitimate, particularly when
>> multiple tasks concurrently msync() disjoint subsets of a file's data.

On Mon, Sep 06, 2004 at 12:02:54AM -0700, Andrew Morton wrote:
> Yes.  But at least _someone_ gets told that there was an ENOSPC/EIO.  What
> are the alternatives?

It seems more like a property of the sb, so referring things to ->i_sb
and flagging the condition in there may make some sense. But a worse
problem with all this is that the wrong one may catch the error. e.g.
one process doing mmap() IO writes to a hole on a full fs, one process
doing mmap() IO writes to already-allocated blocks, both block,
AS_ENOSPC is set on behalf of the writer to the hole, and the writer to
the already-allocated blocks reaps it. The only IO codepath that runs out
of context from the submitting processes without alternative methods of
returning the error is vmscan.c, so in principle returning errors to
callers should work. But converting fs drivers to doing something for
set_page_dirty() et al to report or even propagating -ENOSPC back from
all of the ->writepage() and ->writepages() callsites looks painful. And
supposing one moved the ENOSPC flag to the sb the events that would
clear it aren't now trapped by anything.

Hmm. More questions than answers, again. Let me know if there are any
fs/ or mm/ sweeps you want done for ENOSPC-relevant things (not
necessarily any of the above).


-- wli
