Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261421AbREXLJd>; Thu, 24 May 2001 07:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261434AbREXLJY>; Thu, 24 May 2001 07:09:24 -0400
Received: from zeus.kernel.org ([209.10.41.242]:14773 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261421AbREXLJM>;
	Thu, 24 May 2001 07:09:12 -0400
Date: Thu, 24 May 2001 08:03:49 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH] Re: Linux 2.4.4-ac10
In-Reply-To: <Pine.LNX.4.33.0105241123510.489-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.33.0105240800020.10469-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 May 2001, Mike Galbraith wrote:
> On Thu, 24 May 2001, Rik van Riel wrote:
> > On Thu, 24 May 2001, Mike Galbraith wrote:
> > > On Sun, 20 May 2001, Rik van Riel wrote:
> > >
> > > > Remember that inactive_clean pages are always immediately
> > > > reclaimable by __alloc_pages(), if you measured a performance
> > > > difference by freeing pages in a different way I'm pretty sure
> > > > it's a side effect of something else.  What that something
> > > > else is I'm curious to find out, but I'm pretty convinced that
> > > > throwing away data early isn't the way to go.
> > >
> > > OK.. let's forget about throughput for a moment and consider
> > > those annoying reports of 0 order allocations failing :)
> >
> > Those are ok.  All failing 0 order allocations are either
> > atomic allocations or GFP_BUFFER allocations.  I guess we
> > should just remove the printk()  ;)
>
> Hmm.  The guy who's box locks up on him after a burst of these
> probably doesn't think these failures are very OK ;-)  I don't
> think order 0 failing is cool at all.. ever.

You may not think it's cool, but it's needed in order to
prevent deadlocks. Just because an allocation cannot do
disk IO or sleep, that's no reason to loop around like
crazy in __alloc_pages() and hang the machine ... ;)

> A (long) while back, Linus specifically mentioned worrying
> about atomic allocation reliability.

That's a separate issue.  That was, IIRC, about the
failure of atomic allocations causing packet loss on
Linux routers and, because of that, poor performance.

This is something we still need to look into, but
basically this problem is about too high latency and
NOT about "pre-freeing" more pages (like your patch
attempts).  If this problem is still an issue, it's
quite likely that the VM is holding locks for too
long so that it cannot react fast enough to free up
some inactive_clean pages.

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

