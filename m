Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269019AbUIXWBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269019AbUIXWBz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 18:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269015AbUIXWBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 18:01:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:34512 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269019AbUIXWBv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 18:01:51 -0400
Date: Fri, 24 Sep 2004 15:05:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steven Pratt <slpratt@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] Simplified Readahead
Message-Id: <20040924150523.4853465b.akpm@osdl.org>
In-Reply-To: <41543FE2.5040807@austin.ibm.com>
References: <4152F46D.1060200@austin.ibm.com>
	<20040923194216.1f2b7b05.akpm@osdl.org>
	<41543FE2.5040807@austin.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Pratt <slpratt@austin.ibm.com> wrote:
>
> >
> >The advantage of the current page-at-a-time code is that the readahead code
> >behaves exactly the same, whether the application is doing 256 4k reads or
> >one 1M read.  Plus it fits the old pagefault requirement.
> >  
> >
> Yes, but it accomplishes this by possible making the 1M slower.  And I 
> must admit that I don't know what the "old pagefault requirement" is.  
> Is that something we still need to worry about?

The "old pagefault requirement": the code in there used to perform
readaround at pagefault time as well as readahead at read() time.  Hence it
had to work well for single-page requests.  That requirement isn't there
any more but some of the code to support it is still there, perhaps.

> >>
> >>1. pages already in cache
> >>    
> >>
> >
> >Yes, we need to handle this.  All pages in cache with lots of CPUs
> >hammering the same file is a common case.
> >
> >Maybe not so significant on small x86, but on large power4 with a higher
> >lock-versus-memcpy cost ratio, that extra locking will hurt.
> >  
> >
> Ok, we have some data from larger machines.  I will collect it all and 
> summarize separately.

SDET would be interesting, as well as explicit testing of lots of processes
reading the same fully-cached file.

> >>cache we should just immediately turn off readahead.  What is this 
> >>trigger point?  4 I/Os in a row? 400?
> >>    
> >>
> >
> >Hard call.
> >  
> >
> I know, but we have to come up with something if we really want to avoid 
> the double lookup.

As long as readahead gets fully disabled at some stage, we should be OK.

We should probably compare i_size with mapping->nrpages at open() time,
too.  No point in enabling readahead if it's all cached.  But doing that
would make performance testing harder, so do it later.

> >
> >I do think we should skip the I/O for POSIX_FADV_WILLNEED against a
> >congested queue.  I can't immediately think of a good reason for skipping
> >the I/O for normal readahead.
> >  
> >
> Can you expand on the POSIX_FADV_WILLNEED.

It's an application-specified readahead hint.  It should ideally be
asynchronous so the application can get some I/O underway while it's
crunching on something else.  If the queue is contested then the
application will accidentally block when launching the readahead, which
kinda defeats the purpose.

Yes, the application will block when it does the subsequent read() anyway,
but applications expect to block in read().  Seems saner this way.
