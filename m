Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287487AbSA1XJn>; Mon, 28 Jan 2002 18:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287502AbSA1XJe>; Mon, 28 Jan 2002 18:09:34 -0500
Received: from dsl-213-023-039-090.arcor-ip.net ([213.23.39.90]:16775 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287487AbSA1XJV>;
	Mon, 28 Jan 2002 18:09:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Brian Gerst <bgerst@didntduck.org>,
        Rick Stevens <rstevens@vitalstream.com>
Subject: Re: Note describing poor dcache utilization under high memory pressure
Date: Tue, 29 Jan 2002 00:08:27 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201281005480.1609-100000@penguin.transmeta.com> <3C55C39A.8040203@vitalstream.com> <3C55D210.BC8A50F7@didntduck.org>
In-Reply-To: <3C55D210.BC8A50F7@didntduck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VKt2-0000DV-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 28, 2002 11:34 pm, Brian Gerst wrote:
> Rick Stevens wrote:
> > 
> > Daniel Phillips wrote:
> > [snip]
> > 
> > > I've been a little slow to 'publish' this on lkml because I wanted a working
> > > prototype first, as proof of concept.  My efforts to dragoon one or more of
> > > the notably capable kernelnewbies crowd into coding it haven't been
> > > particularly successful, perhaps due to the opacity of the code in question
> > > (pgtable.h et al).  So I've begun coding it myself, and it's rather slow
> > > going, again because of the opacity of the code.  Oh, and the difficult
> > > nature of the problem itself, since it requires understanding pretty much all
> > > of Unix memory management semantics first, including the bizarre (and useful)
> > > properties of process forking.
> > >
> > > The good news is, the code changes required do fit very cleanly into the
> > > current design.  Changes are required in three places I've identified so far:
> > >
> > >   copy_page_range
> > >     Intead of copying the page tables, just increment their use counts
> > >
> > >   zap_page_range:
> > >     If a page table is shared according to its use count, just decrement
> > >     the use count and otherwise leave it alone.
> > >
> > >   handle_mm_fault:
> > >     If a page table is shared according to its use count and the faulting
> > >     instruction is a write, allocate a new page table and do the work that
> > >     would have normally been done by copy_page_range at fork time.
> > >     Decrement the use count of the (perhaps formerly) shared page table.
> > 
> > Perhaps I'm missing this, but I read that as the child gets a reference
> > to the parent's memory.  If the child attempts a write, then new memory
> > is allocated, data copied and the write occurs to this new memory.  As
> > I read this, it's only invoked on a child write.
> > 
> > Would this not leave a hole where the parent could write and, since the
> > child shares that memory, the new data would be read by the child?  Sort
> > of a hidden shm segment?  If so, I think we've got problems brewing.
> > Now, if a parent write causes the same behaviour as a child write, then
> > my point is moot.
> > 
> > Could you clarify this for me?  I'm probably way off base here.
> 
> Fortunately, the kernel's page mappings are shared by all processes
> (except the top level), so if you mark the page containing the user page
> table as read-only from the child, it will also be read-only in the
> parent.

Actually, the page tables don't even have to be marked read-only.  It's
done with use counts instead: use count > 1 -> shared.

We don't have to take faults on page tables themselves since we are
always servicing a fault, or we are carrying out some explicit VM
operation when we encounter the page table.  That means we are already
in control and don't have to get clever.  Or as it's been expressed
here before, we don't have to 'play stupid fault tricks', which would
be far less efficient and likely more complex to code.

-- 
Daniel
