Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267519AbUHSXaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267519AbUHSXaO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 19:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267527AbUHSXaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 19:30:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:48012 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267519AbUHSXaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 19:30:04 -0400
Date: Thu, 19 Aug 2004 16:33:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: filemap_fdatawait() wait_on_page_writeback_range(mapping, 0,
 -1)?
Message-Id: <20040819163336.0ab74691.akpm@osdl.org>
In-Reply-To: <20040819221304.GD5278@logos.cnet>
References: <20040819201729.GC5278@logos.cnet>
	<20040819144947.7ad18256.akpm@osdl.org>
	<20040819221304.GD5278@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> On Thu, Aug 19, 2004 at 02:49:47PM -0700, Andrew Morton wrote:
> > Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> > >
> > > Hi Andrew,
> > > 
> > > I dont understand why we do call wait_on_page_writeback_range() with -1 
> > > as the "end" argument.
> > 
> > "every page in the file".
> > 
> > > -1 sounds pretty stupid at first, it does unnecessary calls to 
> > > the radix lookup code.
> > 
> > I guess it could cause one extra call into the lookup code.  There's an
> > additional check in -mm's wait_on_page_writeback_range() which would prevent
> > that.
> 
> this? 
> 
> +                       /* until radix tree lookup accepts end_index */
> +                       if (page->index > end)
> +                               continue;

No, I'm being thick.  Please ignore.

> What I'm trying to do is make wait_on_page_writeback_range() do reverse
> search instead ascending. Since we write pages in ascending order, doing 
> the wait on reverse order makes sense and will avoid possibly tons of 
> wakeups.

Yes, that's probably the low-hanging-fruit wrt CPU consumption in there.

> Naive me tried to implement that using pagevec_lookup_tag(), but I'm
> convinced we need pagevec_reverse_lookup_tag() do reverse search
> on the radix tree. I'll try getting that done on the weekend.

Yes, a descending-order gang lookup would be needed.

It'd be tricky to implement.  Probably you could get just as much benefit
by simply waiting on the highest-index page prior to doing the full-range
walk.  Certainly that'd be interesting as a first step: run some tests, see
what impact it has on context switch totals.

Bear in mind that while waiting on the pages in ascending-offset-order
does incur extra context switches, it also yields lowest latency.  Because it
pipelines the inspection of each page with the ongoing I/O.

