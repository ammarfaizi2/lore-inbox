Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264980AbUIFGYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264980AbUIFGYj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 02:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266808AbUIFGYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 02:24:39 -0400
Received: from holomorphy.com ([207.189.100.168]:10646 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264980AbUIFGYh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 02:24:37 -0400
Date: Sun, 5 Sep 2004 23:24:32 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrey Savochkin <saw@saw.sw.com.sg>, linux-kernel@vger.kernel.org
Subject: Re: Q about pagecache data never written to disk
Message-ID: <20040906062432.GF3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Andrey Savochkin <saw@saw.sw.com.sg>,
	linux-kernel@vger.kernel.org
References: <20040905120147.A9202@castle.nmd.msu.ru> <20040905035233.6a6b5823.akpm@osdl.org> <20040905163344.GC3106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040905163344.GC3106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 05, 2004 at 09:33:44AM -0700, William Lee Irwin III wrote:
> msync(p, sz, MS_ASYNC) only does set_page_dirty() at the moment and
> returns 0 unconditionally AFAICT, so things are stuck blocking and
> waiting for disk to reap the status of the IO at all. Maybe if that
> worked the fault handling wouldn't be as important. Maybe we should be
> reaping AS_EIO and/or AS_ENOSPC in the MS_ASYNC case, or wherever it is
> we stash the fact those IO errors ever happened. I'm also not sure what
> people think would be the right way to kick off IO in the background
> there, as trying to kmalloc() a workqueue element, then doing
> schedule_work() on it has resource management issues, but forcing
> userspace to block on the IO to ensure it's been initiated at all
> defeats the point of it.

And, interestingly, the only user of the result of set_page_dirty() is
redirty_page_for_writepage(), whose results are ignored by all callers.
It appears that something is amiss here, as failed reservations aren't
reported until something attempts background writeback or IO syscalls.
That is, it would seem that checking the results of set_page_dirty(),
also called in the MS_ASYNC case, suffices, however, it does not return
useful results in most (all?) cases, and nothing now checks its result.

The calling convention looks very very odd also; filemap_fdatawait() is
the only apparent way to extract an ENOSPC result without calling the
->writepage() method directly, and this, instead of checking for things
returning -ENOSPC as one would expect, does a rather odd thing, that is
test_and_clear_bit(AS_ENOSPC, &mapping->flags), which will lose all but
one of the results whenever there are multiple concurrent callers of it
on a single inode. Worse yet, that can be legitimate, particularly when
multiple tasks concurrently msync() disjoint subsets of a file's data.


-- wli
