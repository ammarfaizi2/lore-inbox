Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311752AbSECPSC>; Fri, 3 May 2002 11:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314275AbSECPSB>; Fri, 3 May 2002 11:18:01 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:50600 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S311752AbSECPSA>; Fri, 3 May 2002 11:18:00 -0400
Date: Fri, 03 May 2002 08:17:23 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: William Lee Irwin III <wli@holomorphy.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Virtual address space exhaustion (was  Discontigmem virt_to_page() )
Message-ID: <4055279713.1020413842@[10.10.2.3]>
In-Reply-To: <20020503103813.K11414@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, May 02, 2002 at 11:33:43PM -0700, Martin J. Bligh wrote:
>> into kernel address space for ever. That's a fundamental scalability
>> problem for a 32 bit machine, and I think we need to fix it. If we
>> map only the pages the process is using into the user-kernel address
>> space area, rather than the global KVA, we get rid of some of these
>> problems. Not that that plan doesn't have its own problems, but ... ;-)
> 
> :) As said every workaround has a significant drawback at this point.
> Starting flooding the tlb with invlpg and pagetable walking every time
> we need to do a set_bit or clear_bit test_bit or an unlock_page is both
> overkill at runtime and overcomplex on the software side too to manage
> those kernel pools in user memory.

Whilst I take your point in principle, and acknowledge that there is
some cost to pay, I don't believe that the working set of one task is
all that dynamic (see also second para below). Some stuff really is 
global data, that's used by a lot of processes, but lots of other 
things really are per task. If only one process has a given file open, that's the only process that needs to see the pagecache control 
structures for that file. 

We don't have to tlb flush every time we map something in, only when
we delete it. For the sake of illustration, imagine a huge kmap pool
for each task, we just map things in as we need them (say some pagecache
structures when we open a file that's already partly in cache), and
use lazy TLB flushing to tear down those structures for free when we
context switch. If we run out of virtual space, yes, we'll have to 
flush, but I suspect that won't be too bad (for most workloads) if
we careful how we flush.
 
> just assume we do that and that you're ok to pay for the hit in general
> purpose usage, then the next year how will you plan to workaround the
> limitation of 64G of physical ram,

;-) No, I agree we're pushing the limits here, and I don't want to be
fighting this too much longer. The next generation of machines will 
all have larger virtual address spaces, and I'll be happy when they
arrive. For now, we have to deal with what we have, and support the
machines that are in the marketplace, and ia32 is (to my mind) still
faster than ia64. 

I'm really looking forward to AMD's Hammer architecture, but it's 
simply not here right now, and even when it is, there will be these 
older 32 bit machines in the field for a few years yet to come, and
we have to cope with them as best we can.


> Ah, and of course you could also use 2M pagetables by default to make it
> more usable but still you would run in some huge ram wastage in certain
> usages with small files, huge pageins and reads swapout and swapins,
> plus it wouldn't be guaranteed to be transparent to the userspace
> binaries (for istance mmap offset fields would break backwards
> compatibility on the required alignment, that's probably the last
> problem though). Despite its also significant drawbacks and the
> complexity of the change, probably the 4M pagetables would be the saner
> approch to manage more efficiently 64G with only a 800M kernel window.

Though that'd reduce the size of some of the structures, I'd still
have other concerns (such as tlb size, which is something stupid
like 4 pages, IIRC), and the space wastage you mentioned. Page 
clustering is probably a more useful technique - letting the existing
control structures control groups of pages. For example, one struct
page could control aligned groups of 4 4K pages, giving us an 
effective page size of 16K from the management overhead point of
view (swap in and out in 4 page chunks, etc).

>> Bear in mind that we've sucessfully used 64Gb of ram in a 32 bit 
>> virtual addr space a long time ago with Dynix/PTX.
> 
> You can use 64G "sucessfully" just now too with 2.4.19pre8 too, as said

I said *used*, not *booted* ;-) There's a whole host of problems
we still have to fix yet, and some tradeoffs to be made - we just
have to make those without affecting the people that don't need
them. It won't be easy, but I don't think it'll be impossible either.

>> Bufferheads are another huge problem right now. For a P4 machine, they
>> round off to 128 bytes per data structure. I was just looking at a 16Gb
>> machine that had completely wedged itself by filling ZONE_NORMAL with 
> 
> Go ahead, use -aa or the vm-33 update, I fixed that problem a few days
> after hearing about it the first time (with the due credit to Rik in a
> comment for showing me such problem btw, I never noticed it before).

Thanks - I'll have a close look at that ... I didn't know you'd
already fixed that one.

M.

