Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287112AbSALPeo>; Sat, 12 Jan 2002 10:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287115AbSALPed>; Sat, 12 Jan 2002 10:34:33 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:22882 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S287112AbSALPeX>; Sat, 12 Jan 2002 10:34:23 -0500
Date: Sat, 12 Jan 2002 16:33:32 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        Manfred Spraul <manfreds@colorfullife.com>
Subject: Re: Q: behaviour of mlockall(MCL_FUTURE) and VM_GROWSDOWN segments
Message-ID: <20020112163332.M1482@inspiron.school.suse.de>
In-Reply-To: <3C3F3C7F.76CCAF76@colorfullife.com.suse.lists.linux.kernel> <3C3F4FC6.97A6A66D@zip.com.au.suse.lists.linux.kernel> <p73r8ow4dd7.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <p73r8ow4dd7.fsf@oldwotan.suse.de>; from ak@suse.de on Sat, Jan 12, 2002 at 01:33:24AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2002 at 01:33:24AM +0100, Andi Kleen wrote:
> Andrew Morton <akpm@zip.com.au> writes:
> 
> > So in this case, the behaviour I would prefer is MCL_FUTURE for
> > all vma's *except* the stack.   Stack pages should be locked
> > only when they are faulted in.   Hard call.
> 
> There is just one problem: linuxthread stacks are just ordinary mappings
> and they are in no way special to the kernel; they aren't VM_GROWSDOWN. 
> You would need to add a way to the kernel first to tag the linux thread 
> stacks in a way that is recognizable to mlockall and then do that 
> from linuxthreads. 
> 
> I think for the normal stack - real VM_GROWSDOWN segments - mlockall
> already does the right thing.

it doesn't (of course depends "what's the right thing"), and that's why
Manfred is asking after I asked him if he was really sure the API was
the right one, but as said to him, something is wrong with the kernel
too somehow, either we remove mark_page_present from find_extend_vma, or
we add it to the page fault handler too.

What the current kernel is doing with page faults, is to fault in only
the touched pages, not the pages in between as well, this isn't a
security concern because the faulted in pages won't be swapped out, but
it may matter for some RT app, OTOH the RT apps would better memset the
whole stack they need before assuming they won't get page faults, first
of all because of all other kernels out there (this is what I mean with
a matter of API).

I guess it is cleaner if a VM_LOCKED vma has all its pages allocated
between vm_start and vm_end, so I guess adding the mark_page_present in
do_page_fault as suggested by Manfred is ok.

Andrea
