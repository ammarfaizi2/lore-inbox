Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287145AbSALQPs>; Sat, 12 Jan 2002 11:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287148AbSALQPi>; Sat, 12 Jan 2002 11:15:38 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:2922 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S287145AbSALQPe>; Sat, 12 Jan 2002 11:15:34 -0500
Date: Sat, 12 Jan 2002 17:14:53 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        Manfred Spraul <manfreds@colorfullife.com>
Subject: Re: Q: behaviour of mlockall(MCL_FUTURE) and VM_GROWSDOWN segments
Message-ID: <20020112171453.O1482@inspiron.school.suse.de>
In-Reply-To: <3C3F3C7F.76CCAF76@colorfullife.com.suse.lists.linux.kernel> <3C3F4FC6.97A6A66D@zip.com.au.suse.lists.linux.kernel> <p73r8ow4dd7.fsf@oldwotan.suse.de> <20020112163332.M1482@inspiron.school.suse.de> <20020112165443.A13179@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20020112165443.A13179@wotan.suse.de>; from ak@suse.de on Sat, Jan 12, 2002 at 04:54:43PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2002 at 04:54:43PM +0100, Andi Kleen wrote:
> On Sat, Jan 12, 2002 at 04:33:32PM +0100, Andrea Arcangeli wrote:
> > it doesn't (of course depends "what's the right thing"), and that's why
> 
> I think it does. Allocating all possible in future allocated pages
> is just not possible for VM_GROWSDOWN, because the stack has really 
> no suitable limit (other than rlimits, which are far too big to
> mlock them) 

the user asked for VM_LOCKED vma, if he asks for that and he faults too
low on the stack with big holes in between that's his mistake. And
anyways ptrace just faults in all the intermediate pages just now, so
it is definitely possible (we provide different userspace API from
ptrace/map_user_kiobuf and page-fault at the moment).

> 
> BTW expand_stack seems to have a small bug: it adds to mm->locked_vm
> the complete offset from last vm_start; if it covers more than one page
> the locked_vm value will be too large. 
> 
> > What the current kernel is doing with page faults, is to fault in only
> > the touched pages, not the pages in between as well, this isn't a
> > security concern because the faulted in pages won't be swapped out, but
> > it may matter for some RT app, OTOH the RT apps would better memset the
> > whole stack they need before assuming they won't get page faults, first
> > of all because of all other kernels out there (this is what I mean with
> > a matter of API).
> 
> For the stack they can get minor faults anyways when they allocate new
> stack space below ESP. There is no good way to fix that from the kernel; the 

the only case here is when the app knows how much stack it will need to
use, without faulting in the holes, it will have to memset the whole
region of stack the it wants to be atomic. If instead the kernel also
fault-in the holes (like map_user_kiobuf/ptrace/get_user_pages just does
in 2.4) the app will only need to touch the lowest virtual address of
stack it needs as atomic.

I don't see any real problem either ways, it must be simply a well
defined API.

Then the user will know if he can touch one byte and the kernel fills
the holes automatically, or if he has to do the whole memset.

> application has to preallocate its memory on stack. I think it's reasonable
> if it does the same for holes on the stack. 
> 
> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Andrea
