Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129953AbRAOTPn>; Mon, 15 Jan 2001 14:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130877AbRAOTPd>; Mon, 15 Jan 2001 14:15:33 -0500
Received: from slc1419.modem.xmission.com ([166.70.13.149]:15373 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129953AbRAOTPT>; Mon, 15 Jan 2001 14:15:19 -0500
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: ebiederm@xmission.com (Eric W. Biederman), linux-kernel@vger.kernel.org,
        <linux-mm@kvack.org>
Subject: Re: Caches, page coloring, virtual indexed caches, and more
In-Reply-To: <Pine.LNX.4.10.10101101100001.4457-100000@penguin.transmeta.com> <E14GR38-0000nM-00@the-village.bc.nu> <20010111005657.B2243@khan.acc.umu.se> <20010112035620.B1254@bacchus.dhis.org> <m17l40hhtd.fsf@frodo.biederman.org> <20010115005315.D1656@bacchus.dhis.org> <m1snmlfbrx.fsf_-_@frodo.biederman.org> <20010115095432.A14351@bacchus.dhis.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 15 Jan 2001 10:16:57 -0700
In-Reply-To: Ralf Baechle's message of "Mon, 15 Jan 2001 09:54:32 -0200"
Message-ID: <m1ofx8g2gm.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Baechle <ralf@uni-koblenz.de> writes:

> On Mon, Jan 15, 2001 at 01:41:06AM -0700, Eric W. Biederman wrote:
> 
> (Cc list truncated since probably not so many people do care ...)
> 
> > shared mmap.  This is the important one.  Since we have a logical
> > backing store this is easy to handle.  We just enforce that the
> > virtual address in a process that we mmap something to must match the
> > logical address to VIRT_INDEX_BITS.  The effect is the same as a
> > larger page size with virtually no overhead.
> 
> I'm told this is going to break software.  Bad since it's otherwise it'd
> be such a nice silver bullet solution.

Heck if we wanted to we could even lie about PAGE_SIZE, and say it was huge.
I'd have to have a clear example before I give it up that easily.
mmap has never allowed totally arbitrary offsets, and mmap(MAP_FIXED)
is highly discouraged so I'd like to see it.

And on architectures that don't need this it should compile out with
no overhead.

> 
> > sysv shared memory is exactly the same as shared mmap.  Except instead
> > of a file offset you have an offset into the sysv segment.
> 
> No, it's simpler in the MIPS case.  The ABI guys were nice and did define
> that the virtual addresses have to be multiple of 256kbyte which is
> more than sufficient to kill the problem.

If VIRT_INDEX_BITS == 18 and because you can only map starting at
the beginning of a sysv shared memory segment this is exactly what
my code boils down to.

> 
> > mremap.  Linux specific but pretty much the same as mmap, but easier.
> > We just enforce that the virtual address of the source of mremap,
> > and the destination of mremap match on VIRT_INDEX_BITS.
> 
> Correct and as mremap doesn't take any address argument we won't break
> any expecations on the properties of the returned address in mmap.
> 
> > kmap is a little different.  using VIRT_INDEX_BITS is a little
> > subtle but should work.  Currently kmap is used only with the page
> > cache so we can take advantage of the page->index field.  From page->index 
> > we can compute the logical offset of the page and make certain the
> > page mapped with all VIRT_INDEX_BITS the same as a mmap alias.
> 
> Yup.  It gets somewhat tricker due to the page cache being in in KSEG0,
> an memory area which is essentially like a 512mb page that is hardwired
> in the CPU.  It's preferable to stick with since it means we never take
> any TLB faults for pages in the page cache on MIPS.

Good.  Then we don't need (at least for mips) to worry about this case.
I was just thinking through the general case.  

> > kmap and the swap cache are a little different.  Since index holds
> > the location of a page on the swap file we'd have to make that index
> > be the same for VIRT_INDEX_BITS as well.
> 
> > > That's a possible solution; I'm not clear how bad the overhead would be.
> > > Right now a virtual alias is a relativly rare event and we don't want the
> > > common case of no virtual alias to make pay a high price.  Or?
> > 
> > I guess the question is how big would these logical pages need to be?
> 
> Depending of the CPU 8kb to 32kb; the hardware supports page sizes 4kb, 16kb,
> 64kb ... 16mb.

If all you need is 32kb that is better than the 256K number I had in my head.
Still as far as an application is concerned the results are the same as
my silver bullet above.

> > Answer big enough to turn your virtually indexed cache into a
> > physically indexed cache.  Which means they would have to be cache
> > size.  
> 
> For above mentioned CPU versions which have 8kb rsp. 16kb per primary cache
> we want 32kb as mentioned.
> 
> > Increasing PAGE_SIZE a few bits shouldn't be bad but going up two
> > orders of magnitude would likely skewer your swapping, and memory
> > management performance.  You'd just have way to few pages.
> > 
> > But I have a better suggestion so see above.
> 
> > O.k. this is scratched off my list of possible good ideas.  Duh.  This
> > fails for exactly the same reason as increasing as increasing page
> > size.  at 256K cache and 4K PAGE_SIZE you'd need 256/4 = 64 different
> > types of pages, fairly nasty.
> 
> You say it; yet it seems like it could be part of a good solution.  Just
> forcefully allocating a single page by splitting a large page and before
> that even swapping until we can actually allocate a higher order page is
> bad.

I totally agree.  Larger pages don't suck but are unnecessary.  At least
I haven't been convinced otherwise yet.


> > Hmm.  This doesn't sound right.  And this sounds like a silly way to
> > use reverse mappings anyway, since you can do it up front in mmap and
> > their kin.  Which means you don't have to slow any of the page fault
> > logic up.
> 
> Then how do you handle something like:
> 
>   fd = open(TESTFILE, O_RDWR | O_CREAT, 664);
>   res = write(fd, one, 4096);
>   mmap(addr            , PAGE_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
>   mmap(addr + PAGE_SIZE, PAGE_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
> 
> If both mappings are immediately created accessible you'll directly endup
> with aliases.  There is no choice, if the pagesize is only 4kb an R4x00
> will create aliases in the case.  Bad.

If MAP_FIXED isn't being used, I allocate them 256K apart. (Totally legal)
If MAP_FIXED is being used I fail the second(legal), or I lie and say that 
PAGE_SIZE is 256K while I'm at it, so it falls out naturally.

> > Hmm.  Correct.  If you have the page aliases appropriately colored across
> > address spaces you will always hit the same cache block, and since you
> > do virtual to physical before the tag compare a false hit won't hurt
> > either.
> 
> As above example shows you may even get aliases in a single address space.

Right.  I had thought through that case, and by just catching it at mmap
time is sufficient.  And again if we lie about PAGE_SIZE to the application
it must work.

> > Well virtually indexed caches look like worth supporting in the kernel
> > since it is easy to do, and can be compiled out on architectures that
> > don't support it.
> 
> At least for sparc it's already supported.  Right now I don't feel like
> looking into the 2.4 solution but checkout srmmu_vac_update_mmu_cache in
> the 2.2 kernel.

Hmm.  I see.  At least as of 2.2.12 (most recent I have on hand) the idea 
looks o.k. (Though the code itself looks broken).  It's kind of an
expensive idea though.  Even if we had reverse page tables, it's extra
work every page fault.


> > For keeping cache collisions down I think we probably do a decent job
> > already.  All we need to do is to continuously cycle through cache
> > aliases.
> >
> > For not ensuring too many cache collisions I think we probably do a
> > decent job already.
> 
> Virtual aliases are the kind of harmful collision that must be avoid or
> data corruption will result.  We just happen to be lucky that there are
> only very few applications which will actually suffer from this problem.
> (Which is why we don't handle it correctly for all MIPSes ...)

Exactly.  So we must handle this.  If you could comment on which apps
break with my solution, I'd like to hear about it. 

> 
> >                       Only the least significant bits are significant.
> > And virtual addresses matter not at all.  In the buddy system where we
> > walk backward linearly through memory it feels o.k.  Only profiling
> > would tell if we were helping of if we could even help with that.
> 
> Other Unices have choosen this implementation; of course they probably
> already had the reverse mapping facilities present and didn't implement
> them just for this purpose.

Different issue here.  I was thinking to about performance optimization by
avoiding cache contention.  

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
