Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315702AbSECUt5>; Fri, 3 May 2002 16:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315703AbSECUt4>; Fri, 3 May 2002 16:49:56 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:47036 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315702AbSECUtx>;
	Fri, 3 May 2002 16:49:53 -0400
Message-ID: <3CD2E940.D421185F@vnet.ibm.com>
Date: Fri, 03 May 2002 14:47:12 -0500
From: Dave Engebretsen <engebret@vnet.ibm.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: William Lee Irwin III <wli@holomorphy.com>,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <E173Pe0-0002Bw-00@starship> <20020503000500.GP32767@holomorphy.com> <E173RjF-0002Ch-00@starship>
X-MIMETrack: Itemize by SMTP Server on d27ml101/27/M/IBM(Release 5.0.10 |March 22, 2002) at
 05/03/2002 03:48:37 PM,
	Serialize by Router on d27ml101/27/M/IBM(Release 5.0.10 |March 22, 2002) at
 05/03/2002 03:48:39 PM,
	Serialize complete at 05/03/2002 03:48:39 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> The boot loader must have provided at least some contiguous physical
> memory in order to load the kernel, the compressed disk image and give
> us a little working memory.  (For practical purposes, we're most likely to
> have been provided with a full gig, or whatever is appropriate according
> to the mem= command line setting, but lets pretend it's a lot less than
> that.)  Now, the first thing we need to do is fill in enough of the
...
> 
> Naturally, during initialization of the hash table, we want to be sure
> not to perform and phys_to_logical translations, as would be required to
> read values from the page tables during swap-out for example.  Probably
> there's already no possibility of that, but it needs a comment at least.
> 
> I can't provide any more details than that, because I'm not familiar
> with the way the iseries boots.  Anton is the man there.

The way it works on iSeries is the HV provides a 64MB physicaly
contiguous load area.  The kernel & working storage, including the
logical->physical (or absolute in our terms) must fit in this space. 
Even with a 256KB chunk size and a simple array for translation, the
memory consumption is not excessive.  Each array entry is 32bits,
allowing a 32+12(page offset) = 44b of physical addessability and a 1MB
array allows 32GB of translations.

We don't need the reverse translation on iSeries as the kernel never
knows about the actual hardware address, other than when putting an
entry in the hardware page tables (processor and I/O).  One other thing
to not is that Linux _always_ runs with relocation enabled on iSeries so
there is never a point, other than way I mention above, when the
hardware address matters.

> We ought to have some clue about the maximum number of physical memory
> chunks available to us.  I doubt *every* partition is going to be
> provided 256 GB of memory.  In fact, the real amount we need will be
> considerably less, and the phys_to_logical table will be smaller than
> 16 MB, say, 1 MB.  Just allocate the whole thing and be done with it.

... 

> 
> > How do you know what
> > the size of the table should be if the number of chunks varies
> > dramatically?
> 
> The most obvious and practical approach is to have the boot loader tell
> us, we allocate the maximum size needed, and won't worry about that
> again.
> 

Yes, we do know the maximum memory possible, both system wide, and more
importantly within a partition.  In fact the way it works today, a
partition is defined to the hypervisor with a current memory size to use
and a max memory size.  The max is required because the hardware page
table for PowerPC is allocated to the max size before the partition
boots.  Becuase the page table must be physically contiguous, it is
allocated for the partition when the system boots.  The size of the
Linux translation tables is a similar issue where the worst case should
just be considered and allocated at Linux boot time.

Dave Engebretsen
