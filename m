Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263933AbUDPXKZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 19:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263939AbUDPXKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 19:10:24 -0400
Received: from mail.shareable.org ([81.29.64.88]:58274 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263933AbUDPXKP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 19:10:15 -0400
Date: Sat, 17 Apr 2004 00:10:09 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Subject: Re: msync() needed before munmap() when writing to shared mapping?
Message-ID: <20040416231009.GA27775@mail.shareable.org>
References: <20040416220223.GA27084@mail.shareable.org> <20040416154652.7ab27e79.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040416154652.7ab27e79.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jamie Lokier <jamie@shareable.org> wrote:
> > I've followed the logic from do_munmap() and it looks good:
> > unmap_vmas->zap_pte_range->page_remove_rmap->set_page_dirty.
> > 
> > Can someone confirm this is correct, please?
> 
> yup, zap_pte_range() transfers pte dirtiness into pagecache dirtiness when
> tearing down the mapping, leaving the dirty page floating about in
> pagecache for kupdate/kswapd/fsync to catch.  Longstanding behaviour.

Thanks.

A related question.  The comment for MADV_DONTNEED says:

 * NB: This interface discards data rather than pushes it out to swap,
 * as some implementations do.  This has performance implications for
 * applications like large transactional databases which want to discard
 * pages in anonymous maps after committing to backing store the data
 * that was kept in them.  There is no reason to write this data out to
 * the swap area if the application is discarding it.
 *
 * An interface that causes the system to free clean pages and flush
 * dirty pages is already available as msync(MS_INVALIDATE).

MADV_DONTNEED calls zap_page_range().
That propagates dirtiness into the pagecache.

So it *doesn't* "discard data rather than push it out to swap", if the
same dirty data is mapped elsewhere e.g. as a shared anonymous
mapping, does it?

The comment also mentions MS_INVALIDATE, but MS_INVALIDATE doesn't do
what the comment says and doesn't implement anything like POSIX
either.  (Linux's MS_INVALIDATE is practically equivalent to MS_ASYNC).

Is there a call which does what the command about MS_INVALIDATE says,
i.e. free clean pages and flush dirty ones?

Thanks,
-- Jamie
