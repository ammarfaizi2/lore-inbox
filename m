Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289356AbSA1T61>; Mon, 28 Jan 2002 14:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289353AbSA1T6E>; Mon, 28 Jan 2002 14:58:04 -0500
Received: from dsl-213-023-039-090.arcor-ip.net ([213.23.39.90]:27781 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289372AbSA1T5c>;
	Mon, 28 Jan 2002 14:57:32 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: Note describing poor dcache utilization under high memory pressure
Date: Mon, 28 Jan 2002 21:01:29 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Josh MacDonald <jmacd@CS.Berkeley.EDU>, <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>, <reiserfs-dev@namesys.com>
In-Reply-To: <Pine.LNX.4.33.0201281005480.1609-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0201281005480.1609-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VHy5-0000Bz-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 28, 2002 07:21 pm, Linus Torvalds wrote:
> On Mon, 28 Jan 2002, Rik van Riel wrote:
> >
> > I'd be interested to know exactly how much overhead -rmap is
> > causing for both page faults and fork   (but I'm sure one of
> > the regular benchmarkers can figure that one out while I fix
> > the RSS limit stuff ;))
> 
> I doubt it is noticeable on page faults (the cost of maintaining the list
> at COW should be basically zero compared to all the other costs), but I've
> seen several people reporting fork() overheads of ~300% or so.
> 
> Which is not that surprising, considering that most of the fork overhead
> by _far_ is the work to copy the page tables, and rmap makes them three
> times larger or so.
> 
> And I agree that COW'ing the page tables may not actually help. But it
> might be worth it even _without_ rmap, so it's worth a look.

True.  I've been working on this question fairly intensively since around 
Christmas.  At that time I came up with the algorithm attached below, which I 
circulated to a number of people, including Alan (who thought it would work) 
and Rik.  (Rik, please be more thorough about quoting your sources ;-).

I've been a little slow to 'publish' this on lkml because I wanted a working 
prototype first, as proof of concept.  My efforts to dragoon one or more of 
the notably capable kernelnewbies crowd into coding it haven't been 
particularly successful, perhaps due to the opacity of the code in question 
(pgtable.h et al).  So I've begun coding it myself, and it's rather slow 
going, again because of the opacity of the code.  Oh, and the difficult 
nature of the problem itself, since it requires understanding pretty much all 
of Unix memory management semantics first, including the bizarre (and useful) 
properties of process forking.

The good news is, the code changes required do fit very cleanly into the 
current design.  Changes are required in three places I've identified so far:

  copy_page_range
    Intead of copying the page tables, just increment their use counts

  zap_page_range:
    If a page table is shared according to its use count, just decrement
    the use count and otherwise leave it alone.

  handle_mm_fault:
    If a page table is shared according to its use count and the faulting 
    instruction is a write, allocate a new page table and do the work that 
    would have normally been done by copy_page_range at fork time.
    Decrement the use count of the (perhaps formerly) shared page table.

I'd cheerfully hand this coding effort off to someone more familiar with this 
particular neck of the kernel woods - you, Davem and Marcelo come to mind, 
but if nobody bites I'll just continue working on it at my own pace.  I 
consider this work a potentially important evolutionary step, since it could 
possibly lead to a breakup of the current VM logjam.

Here's the original writeup I circulated earlier this month:

Lazy page table instantiation algorithm
---------------------------------------

This algorithm implements page table sharing between page directories, with
a view to reducing the amount of work required at fork time for a child to
inherit its parent's memory.  With this algorithm, only a single page (the
page directory) is copied at fork time.

This work is aimed at making Rik's rmap design practical, i.e., by eliminating
the current high cost of creating potentially millions of pte_chain list nodes
at fork time.  However, the usefulness of this approach is not limited to 
rmap -
it should speed up fork in the current vm as well, by copying only one page to
the child (the page directory) instead of all page table pages, and by
instantiating only those page tables that refer to pages the child actually
writes to. 

The algorithm relies on a page table's use count, which specifies how many 
page directories point at it.  A page table can be shared by several page 
directories until one of its non-shared pages is written.  Then the page and 
its page table are 'privatized', i.e., a copy of the page is entered into a 
copy of the page table (and the page's pte_chain is extended).

In this way, instantiation of page tables does not happen at fork time, but
later, when pages referenced by page tables are privatized.  Furthermore,
only page tables that need to be instantiated are instantiated, as opposed
to the current algorithm, which instantiates all page tables at fork time.

Algorithm
---------

On fork:
  - Increment the use counts on all page tables mapped by the page directory
  - Copy the page directory to the child

On page privatize:
  - If the page table has use count greater than one, privatize the page 
    table.  At this time, extend all the pte_chains to include the privatized 
    page table.  Reduce the use count on the original page table by one and 
    set the use count of the new page table to one.

On process termination:
  - Decrement the use counts on all page tables mapped by the page directory;
    free those with zero use count.

With this lazy page table instantiation, a simple reverse-mapping memory
management scheme becomes much more attractive, because the overhead of 
creating reverse links to ptes has been reduced (to only the page tables that 
need it) and is not done at fork time.

--
Daniel
