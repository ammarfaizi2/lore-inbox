Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287287AbSA1Wf2>; Mon, 28 Jan 2002 17:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287279AbSA1WfS>; Mon, 28 Jan 2002 17:35:18 -0500
Received: from quark.didntduck.org ([216.43.55.190]:53002 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S287287AbSA1WfD>; Mon, 28 Jan 2002 17:35:03 -0500
Message-ID: <3C55D210.BC8A50F7@didntduck.org>
Date: Mon, 28 Jan 2002 17:34:56 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Rick Stevens <rstevens@vitalstream.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <Pine.LNX.4.33.0201281005480.1609-100000@penguin.transmeta.com> <E16VHy5-0000Bz-00@starship.berlin> <3C55C39A.8040203@vitalstream.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick Stevens wrote:
> 
> Daniel Phillips wrote:
> [snip]
> 
> > I've been a little slow to 'publish' this on lkml because I wanted a working
> > prototype first, as proof of concept.  My efforts to dragoon one or more of
> > the notably capable kernelnewbies crowd into coding it haven't been
> > particularly successful, perhaps due to the opacity of the code in question
> > (pgtable.h et al).  So I've begun coding it myself, and it's rather slow
> > going, again because of the opacity of the code.  Oh, and the difficult
> > nature of the problem itself, since it requires understanding pretty much all
> > of Unix memory management semantics first, including the bizarre (and useful)
> > properties of process forking.
> >
> > The good news is, the code changes required do fit very cleanly into the
> > current design.  Changes are required in three places I've identified so far:
> >
> >   copy_page_range
> >     Intead of copying the page tables, just increment their use counts
> >
> >   zap_page_range:
> >     If a page table is shared according to its use count, just decrement
> >     the use count and otherwise leave it alone.
> >
> >   handle_mm_fault:
> >     If a page table is shared according to its use count and the faulting
> >     instruction is a write, allocate a new page table and do the work that
> >     would have normally been done by copy_page_range at fork time.
> >     Decrement the use count of the (perhaps formerly) shared page table.
> 
> Perhaps I'm missing this, but I read that as the child gets a reference
> to the parent's memory.  If the child attempts a write, then new memory
> is allocated, data copied and the write occurs to this new memory.  As
> I read this, it's only invoked on a child write.
> 
> Would this not leave a hole where the parent could write and, since the
> child shares that memory, the new data would be read by the child?  Sort
> of a hidden shm segment?  If so, I think we've got problems brewing.
> Now, if a parent write causes the same behaviour as a child write, then
> my point is moot.
> 
> Could you clarify this for me?  I'm probably way off base here.

Fortunately, the kernel's page mappings are shared by all processes
(except the top level), so if you mark the page containing the user page
table as read-only from the child, it will also be read-only in the
parent.

--

				Brian Gerst
