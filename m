Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131131AbRAPFAB>; Tue, 16 Jan 2001 00:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131045AbRAPE7v>; Mon, 15 Jan 2001 23:59:51 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:30716 "EHLO
	dhcp046.distro.conectiva") by vger.kernel.org with ESMTP
	id <S131131AbRAPE7r>; Mon, 15 Jan 2001 23:59:47 -0500
Date: Tue, 16 Jan 2001 02:58:48 -0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org, <linux-mm@kvack.org>
Subject: Re: Caches, page coloring, virtual indexed caches, and more
Message-ID: <20010116025848.B908@bacchus.dhis.org>
In-Reply-To: <Pine.LNX.4.10.10101101100001.4457-100000@penguin.transmeta.com> <E14GR38-0000nM-00@the-village.bc.nu> <20010111005657.B2243@khan.acc.umu.se> <20010112035620.B1254@bacchus.dhis.org> <m17l40hhtd.fsf@frodo.biederman.org> <20010115005315.D1656@bacchus.dhis.org> <m1snmlfbrx.fsf_-_@frodo.biederman.org> <20010115095432.A14351@bacchus.dhis.org> <m1ofx8g2gm.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m1ofx8g2gm.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Mon, Jan 15, 2001 at 10:16:57AM -0700
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2001 at 10:16:57AM -0700, Eric W. Biederman wrote:

> Heck if we wanted to we could even lie about PAGE_SIZE, and say it was huge.
> I'd have to have a clear example before I give it up that easily.
> mmap has never allowed totally arbitrary offsets, and mmap(MAP_FIXED)
> is highly discouraged so I'd like to see it.
> 
> And on architectures that don't need this it should compile out with
> no overhead.

> > > sysv shared memory is exactly the same as shared mmap.  Except instead
> > > of a file offset you have an offset into the sysv segment.
> > 
> > No, it's simpler in the MIPS case.  The ABI guys were nice and did define
> > that the virtual addresses have to be multiple of 256kbyte which is
> > more than sufficient to kill the problem.
> 
> If VIRT_INDEX_BITS == 18 and because you can only map starting at
> the beginning of a sysv shared memory segment this is exactly what
> my code boils down to.

> > > kmap is a little different.  using VIRT_INDEX_BITS is a little
> > > subtle but should work.  Currently kmap is used only with the page
> > > cache so we can take advantage of the page->index field.  From
> > > page->index we can compute the logical offset of the page and make
> > > certain the page mapped with all VIRT_INDEX_BITS the same as a mmap
> > > alias.
> > 
> > Yup.  It gets somewhat tricker due to the page cache being in in KSEG0,
> > an memory area which is essentially like a 512mb page that is hardwired
> > in the CPU.  It's preferable to stick with since it means we never take
> > any TLB faults for pages in the page cache on MIPS.
> 
> Good.  Then we don't need (at least for mips) to worry about this case.
> I was just thinking through the general case.  

Not that good.  Think of mmaping a file, then write(2)ing to it, then reading
from it's mapping.  Same for a mmap(2), read(2) sequence followed by a read
from the memory. This might result in aliases between the page cache and
the userspace.

A solution would be to use a kmap mapping outside KSEG0 for accessing the
pagecache of all data that is also mapped to userspace, if aliases might
occur.

> I totally agree.  Larger pages don't suck but are unnecessary.  At least
> I haven't been convinced otherwise yet.

The big iron guys actually love LARGE pages; I think IRIX on Origins uses
something lie 64kb pages or so and may make use of even larger pages in
it's page tables and mappings to get the TLB fault rate down.  There are
Usenix papers from HP and SGI about the issue; the performance increase
they report for certain apps are impressive.

> > If both mappings are immediately created accessible you'll directly endup
> > with aliases.  There is no choice, if the pagesize is only 4kb an R4x00
> > will create aliases in the case.  Bad.
> 
> If MAP_FIXED isn't being used, I allocate them 256K apart. (Totally legal)
> If MAP_FIXED is being used I fail the second(legal), or I lie and say that 
> PAGE_SIZE is 256K while I'm at it, so it falls out naturally.

MIPS ABI says larger page size is ok; it's just that on Linux a page size
of only 4kb (and 8kb for Alpha) has been hardcoded in tons of places.  Oh
well, let's break what's broken.  Luckily the IA64 guys are already doing
alot of the required fixing.

> > At least for sparc it's already supported.  Right now I don't feel like
> > looking into the 2.4 solution but checkout srmmu_vac_update_mmu_cache in
> > the 2.2 kernel.
> 
> Hmm.  I see.  At least as of 2.2.12 (most recent I have on hand) the idea 
> looks o.k. (Though the code itself looks broken).  It's kind of an
> expensive idea though.

Indeed - which is why I never was able to get myself a barf bag and
implement the same for MIPS ;-)

> Even if we had reverse page tables, it's extra work every page fault.

It's only going to impact pages which actually have aliases.  IRIX for
example uses a dual strategy.  They don't restrict addresses for MAP_FIXED
but try hard to use non-conflicting addresses whereever possible.  The
part with the reverse mappings which I just explained is only the last
alternative when a user actualy enforced the creation of mappings at
conflicting addresses.

Jamie Lokier's posting already mentioned it - mapping the same address
space twice as in the code snipet I gave is a nice way of implementing
circular buffers; I've already seen such code ...  on Intel boxen.

> > Virtual aliases are the kind of harmful collision that must be avoid or
> > data corruption will result.  We just happen to be lucky that there are
> > only very few applications which will actually suffer from this problem.
> > (Which is why we don't handle it correctly for all MIPSes ...)
> 
> Exactly.  So we must handle this.  If you could comment on which apps
> break with my solution, I'd like to hear about it. 

The problem with simply ignoring the problem is that it results in silent
data corruption.  So even if your solution is breaking more code I like it
more - a syscall error return is a obvious problem which application people
know how to handle.

The know application which breaks due to aliases is the lock manager of
some database product running on Cobalt's MIPS boxen.

  Ralf
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
