Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265355AbSLMTvN>; Fri, 13 Dec 2002 14:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265361AbSLMTvN>; Fri, 13 Dec 2002 14:51:13 -0500
Received: from packet.digeo.com ([12.110.80.53]:20390 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265355AbSLMTvM>;
	Fri, 13 Dec 2002 14:51:12 -0500
Message-ID: <3DFA3BFC.525D1B3@digeo.com>
Date: Fri, 13 Dec 2002 11:58:52 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@sgi.com>,
       "linux-xfs@oss.sgi.com" <linux-xfs@oss.sgi.com>
CC: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: 2.5.50-mm2
References: <3DF453C8.18B24E66@digeo.com> <20021213175526.C2581@sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Dec 2002 19:58:56.0836 (UTC) FILETIME=[12041040:01C2A2E2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> On Mon, Dec 09, 2002 at 12:26:48AM -0800, Andrew Morton wrote:
> > +remove-PF_SYNC.patch
> >
> >  remove the current->flags:PF_SYNC abomination.  Adds a `sync' arg to
> >  all writepage implementations to tell them whether they are being
> >  called for memory cleansing or for data integrity.
> 
> Any chance you could pass down a struct writeback_control instead of
> just the sync flag?  XFS always used ->writepage similar to the
> ->vm_writeback in older kernel releases because writing out more
> than one page of delalloc space is really needed to be efficient and
> this would allow us to get a few more hints about the VM's intentions.

Yup, no probs.

It would be good to measure how often that codepath actually gets invoked
during testing and use.  It's typically quite rare.  It should be just
MAP_SHARED stuff, although there are probably some highmem-related scenarii
in which it will happen.

I'll add a writeback_control.for_reclaim boolean so we don't have to play
games with PF_MEMALLOC to reverse engineer the calling context.

If XFS is going to writearound extra pages in ->writepage() then it would
be best to set PG_reclaim (if wbc->for_reclaim) so end_page_writeback()
will rotate them.
