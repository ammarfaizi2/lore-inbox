Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVBLTug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVBLTug (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 14:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVBLTuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 14:50:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43705 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261195AbVBLTuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 14:50:23 -0500
Date: Sat, 12 Feb 2005 13:54:26 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andi Kleen <ak@muc.de>
Cc: Ray Bryant <raybry@sgi.com>, Ray Bryant <raybry@austin.rr.com>,
       linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview
Message-ID: <20050212155426.GA26714@logos.cnet>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com> <m1vf8yf2nu.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1vf8yf2nu.fsf@muc.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2005 at 12:17:25PM +0100, Andi Kleen wrote:
> Ray Bryant <raybry@sgi.com> writes:
> > set of pages associated with a particular process need to be moved.
> > The kernel interface that we are proposing is the following:
> >
> > page_migrate(pid, va_start, va_end, count, old_nodes, new_nodes);
> 
> [Only commenting on the interface, haven't read your patches at all]
> 
> This is basically mbind() with MPOL_F_STRICT, except that it has a pid 
> argument. I assume that's for the benefit of your batch scheduler.

As far as I understand mbind() is used to set policies to given memory 
regions, not move memory regions?

> But it's not clear to me how and why the batch scheduler should know about
> virtual addresses of different processes anyways. Walking
> /proc/pid/maps? That's all inherently racy when the process is doing
> mmap in parallel. The only way I can think of to do this would be to
> check for changes in maps after a full move and loop, but then you risk
> livelock.

True. 

There is no problem, however, if all threads beloging to the process are stopped, 
as Ray mentions. 

So, there wont be memory mapping changes happening at the same time. 

Note that the memory migration code which sys_page_migrate() uses moves
running processes to other memory zones, handling truncate, etc.

> And you cannot also just specify va_start=0, va_end=~0UL because that
> would make the node arrays grow infinitely. 
> 
> Also is there a good use case why the batch scheduler should only
> move individual areas in a process around, not the full process?

Quoting him:

"In addition to its use by batch schedulers, we also envision that
this facility could be used by a program to re-arrange the allocation
of its own pages on various nodes of the NUMA system, most likely
to optimize performance of the application during different phases
of its computation."

Seems doable. 

Are there any good xamples of optimizations that could be made by 
moving pages around except for NUMA?

Does IRIX has anything similar? 

> I think the only sane way for an external process to move another 
> around is to do it for the whole process. For that you wouldn't need
> most of the arguments, but just a simple move_process_vm call,
> or perhaps just a file in /proc where the new node can be written to.

It seems interesting for a process to move its own vma for optimizations
reasons?

> There may be an argument to do this for individual 
> tmpfs/hugetlbfs/sysv shm segments too, but mbind() already supports
> that (just map them from a different process and change the policy there)
> 
> For process use you could just do it in mbind() or perhaps
> part of the process policy (move page around when touched by process).

Hum, how is that supposed to work ? You want to modify the pagefault handler? 
