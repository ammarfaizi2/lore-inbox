Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286687AbSA2XFH>; Tue, 29 Jan 2002 18:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286413AbSA2XDu>; Tue, 29 Jan 2002 18:03:50 -0500
Received: from waste.org ([209.173.204.2]:10464 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S286207AbSA2XCy>;
	Tue, 29 Jan 2002 18:02:54 -0500
Date: Tue, 29 Jan 2002 17:02:36 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>, <reiserfs-dev@namesys.com>
Subject: Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <E16Vh7y-0000Ac-00@starship.berlin>
Message-ID: <Pine.LNX.4.44.0201291649490.25443-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002, Daniel Phillips wrote:

> > I think it goes something like this:
> >
> > fork:
> >   detach page tables from parent
> >   retain pointer to "backing page tables" in parent and child
> >   update use count in page tables
> >   "prefault" tables for current stack and instruction pages in both parent
> >     and child
> >
> > page fault:
> >   if faulted on page table:
> >     look up backing page tables
> >     if use count > 1: copy, dec use count
> >     else: take ownership
> >
> > > Before you sink a lot of time into it though, you might add up the actual
> > > overhead you're worried about above, and see if it moves the needle in a real
> > > system.
> >
> > I'm pretty sure something like the above does signficantly less work in
> > the fork/exec case, which is the important one.
>
> With fork/exec, for each page table there are two cases:
>
>   - The parent instantiated the page table.  In this case the extra work to
>     set the ptes RO (only for CoW pages) is insignificant.

Marking the page table entries rather than the page directory entries
read-only is a lot of work on a large process. And it doesn't make a lot
of sense for a large process that wants to fork/exec something tiny.  In
fact, I'm slightly worried about the possible growth of the page
directories on really big boxes. Detaching the entire mm is comparatively
cheap and doesn't grow with process size.

>   - The parent is still sharing the page table with its parent and so the
>     ptes are still set RO.

Fork/exec is far and away the most common case, and the fork/fork case is
rare enough that it's not even worth thinking about.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

