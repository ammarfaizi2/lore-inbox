Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286692AbSA2XUE>; Tue, 29 Jan 2002 18:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286411AbSA2XSs>; Tue, 29 Jan 2002 18:18:48 -0500
Received: from dsl-213-023-043-145.arcor-ip.net ([213.23.43.145]:2953 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S286723AbSA2XRh>;
	Tue, 29 Jan 2002 18:17:37 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Oliver Xymoron <oxymoron@waste.org>
Subject: Re: Note describing poor dcache utilization under high memory pressure
Date: Wed, 30 Jan 2002 00:21:47 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>, <reiserfs-dev@namesys.com>
In-Reply-To: <Pine.LNX.4.44.0201291649490.25443-100000@waste.org>
In-Reply-To: <Pine.LNX.4.44.0201291649490.25443-100000@waste.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VhZT-0000Am-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 30, 2002 12:02 am, Oliver Xymoron wrote:
> On Tue, 29 Jan 2002, Daniel Phillips wrote:
> > With fork/exec, for each page table there are two cases:
> >
> >   - The parent instantiated the page table.  In this case the extra work
> >     to set the ptes RO (only for CoW pages) is insignificant.
> 
> Marking the page table entries rather than the page directory entries
> read-only is a lot of work on a large process.

I'm still missing your point.  When the parent's page table was instantiated 
we took a fault.  Later, we walk through up to 1024 ptes setting them RO, if 
they are not already (which they probably are).  Don't you think the cost of 
the former dwarves the latter?  In fact, if we are worried about this, we can 
keep a flag on the page table telling us all the ptes are still set RO so we 
don't have to do it again.

> And it doesn't make a lot
> of sense for a large process that wants to fork/exec something tiny.
>
> In
> fact, I'm slightly worried about the possible growth of the page
> directories on really big boxes. Detaching the entire mm is comparatively
> cheap and doesn't grow with process size.
> 
> >   - The parent is still sharing the page table with its parent and so the
> >     ptes are still set RO.
> 
> Fork/exec is far and away the most common case, and the fork/fork case is
> rare enough that it's not even worth thinking about.

I'm not sure I agree with this.  I matters a lot if that rare case happens to 
be the application your using all the time, and then it becomes the common 
case.

-- 
Daniel
