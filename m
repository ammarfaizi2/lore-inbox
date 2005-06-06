Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVFFJGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVFFJGf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 05:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVFFJGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 05:06:35 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:4261 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S261234AbVFFJGb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 05:06:31 -0400
In-Reply-To: <20050603115512.1dc23cab.akpm@osdl.org>
Subject: Re: [patch] broken fault_in_pages_readable call in generic_file_buffered_write.
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Build V651_12042003 December 04, 2003
Message-ID: <OFC52C2646.A435B869-ONC1257018.002DBE48-C1257018.00320990@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Mon, 6 Jun 2005 11:06:32 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 06/06/2005 11:06:28
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote on 06/03/2005 08:55:12 PM:

> > This is caused by an invalid size on the fault_in_pages_readable call
> > in generic_file_buffered_write. The length of the passed buffer needs
> > to be clipped to the maximum size of the current iov.
>
> Gad that code has become opaque - I need to stare at it for half an hour.

Ask me, I had to find that stupid bug..

> Can you explain the bug a bit more completely?  AFACIT, `bytes' here was
> always in the range 0 ..  PAGE_CACHE_SIZE, so how can it have caused large
> amounts of the stack segment to have been faulted in?

Sure. If you have a small iov at the end of a vma followed by a large iov
somewhere else then the bytes variable is the number of bytes between the
current file position and the end of the page cache page. That offset is
used in the fault_in_pages_readable call which now will span TWO pages.
For the small iov only one page may get accessed. The second page lies
after the end of the vma. If that vma happens to be the last one before
the stack and the stack size is unlimited then VM_GROWSDOWN will create
a big stack vma. In our case later memory allocations failed because
there wasn't enough virtual address space.

> > While looking at this I wondered
> > about another potential issue, fault_in_pages_readable faults the
> > pages of the iov into memory by using __get_user(). Nobody has made
> > sure that the page really stays in memory. While it is unlikely that
> > it gets removed before generic_file_buffered_write has done its jobs,
> > in theory on a virtual system that runs under extreme memory pressure
> > it can happen that the page is reclaimed immediatly.  So the race that
> > is mentioned in the comment is not really fixed...
> >
>
> yup, that's a "well known" problem and we've never come up with an adequate
> solution.  It is possible, rarely, to cause that page to get unmapped in
> the window which you identify.  It is much harder to cause the page to
> actually be reclaimed.  And it is much harder still to cause a mmap/write
> deadlock once the page has been reclaimed.  We've been admiring this
> problem on and off for four or five years...

Ok, now there is one admirer more ..

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH


