Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289882AbSA2VB0>; Tue, 29 Jan 2002 16:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289886AbSA2VBJ>; Tue, 29 Jan 2002 16:01:09 -0500
Received: from waste.org ([209.173.204.2]:39383 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S289882AbSA2VAt>;
	Tue, 29 Jan 2002 16:00:49 -0500
Date: Tue, 29 Jan 2002 15:00:29 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>, <reiserfs-dev@namesys.com>
Subject: Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <E16VfBX-0000AN-00@starship.berlin>
Message-ID: <Pine.LNX.4.44.0201291446460.25443-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002, Daniel Phillips wrote:

> On January 29, 2002 06:25 pm, Rik van Riel wrote:
> > On Tue, 29 Jan 2002, Oliver Xymoron wrote:
> >
> > > Daniel's approach seems to be workable (once he's spelled out all the
> > > details) but it misses the big performance win for fork/exec, which is
> > > surely the common case. Given that exec will be throwing away all these
> > > mappings, we can safely assume that we will not be inheriting many shared
> > > mappings from parents of parents so Daniel's approach also still ends up
> > > marking most of the pages RO still.
> >
> > It gets worse.  His approach also needs to adjust the reference
> > counts on all pages (and swap pages).
>
> Well, Rik, time to present your algorithm.  I assume it won't reference
> counts on pages, and will do some kind of traversal of the mm tree.  Note
> however, that I did investigate the class of algorithm you are interested in,
> and found only nasty, complex solutions there, with challenging locking
> problems.  (I also looked at a number of possible improvements to virtual
> scanning, as you know, and likewise only found ugly or inadequate solutions.)

I think it goes something like this:

fork:
  detach page tables from parent
  retain pointer to "backing page tables" in parent and child
  update use count in page tables
  "prefault" tables for current stack and instruction pages in both parent
    and child

page fault:
  if faulted on page table:
    look up backing page tables
    if use count > 1: copy, dec use count
    else: take ownership

> Before you sink a lot of time into it though, you might add up the actual
> overhead you're worried about above, and see if it moves the needle in a real
> system.

I'm pretty sure something like the above does signficantly less work in
the fork/exec case, which is the important one.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

