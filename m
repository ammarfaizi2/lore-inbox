Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbTDDXxb (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 18:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbTDDXxa (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 18:53:30 -0500
Received: from mail-6.tiscali.it ([195.130.225.152]:56455 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id S261488AbTDDXx0 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 18:53:26 -0500
Date: Sat, 5 Apr 2003 02:03:52 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Ingo Molnar <mingo@elte.hu>, hugh@veritas.com, dmccr@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030405000352.GF16293@dualathlon.random>
References: <Pine.LNX.4.44.0304041453160.1708-100000@localhost.localdomain> <20030404105417.3a8c22cc.akpm@digeo.com> <20030404214547.GB16293@dualathlon.random> <20030404150744.7e213331.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030404150744.7e213331.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 03:07:44PM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > On Fri, Apr 04, 2003 at 10:54:17AM -0800, Andrew Morton wrote:
> > > Hugh Dickins <hugh@veritas.com> wrote:
> > > >
> > > > Truncating a sys_remap_file_pages file?  You're the first to
> > > > begin to consider such an absurd possibility: vmtruncate_list
> > > > still believes vm_pgoff tells it what needs to be done.
> > > 
> > > Well I knew mincore() was bust for nonlinear mappings.  Never thought about
> > > truncate.
> > 
> > IMHO sys_remap_file_pages and the nonlinear mapping is an hack and
> > should be dropped eventually.
> 
> It has created exceptional situations which are rather tying our hands in
> other areas.
> 
> > I mean it's not too bad but it's a mere
> > workaround for:
> > 
> > 1) lack of 64bit address space that will be fixed
> > 2) lack of O(log(N)) mmap, that will be fixed too
> 
> Yes, mmap() overhead due to the linear search, VMA space consumption,
> additional TLB invalidations and additional faults.  The latter could be
> fixed up via MAP_PREFAULT and are independent of nonlinearity.
> 
> Here's Ingo's original summary:
> 
> - really complex remappings (used by databases or virtualizing
>   applications) create a *huge* amount of vmas - and vma's are per-process
>   which puts a really big load on kernel memory allocations, especially on
>   32-bit systems. I've seen applications that had a mapping setup that
>   generated 128 *thousand* vmas per process, causing lots of problems.

the current max map count is 64k so I'm not sure how can he have seen 128k,
I've to assume the kernel was hacked for it.

> 
> - setting up separate mappings is expensive, causes one pagefault per page
>   and also causes TLB flushes.
> 
> - even on 64-bit systems, when mapping really large (terabyte size) and
>   really sparse files, sparse mappings can be a disadvantage - in the
>   worst-case there can be as much as 1 more pagetable page allocated for
					      ^^^^^^^^^
>   every file page that is mapped in.

he certainly means 1 vma, not 1 pagetable.

> > 1) and 2) are the only reason why there's huge interest in such syscall
> > right now. So I don't like it too much and I'm not convinced it was
> > right to merge it in 2.5 given 2) is a software problem and I've the
> > design to fix it with a rbtree extension, and 1) is an hardware problem
> > that will be fixed very soon. the API is not too bad but there is a
> > reason we have the vma for all other mappings.
> > 
> > Maybe I'm missing something, I'm curious to hear what you think and what
> > other cases needs this syscall even after 1) and 2) are fixed.
> 
> I think that's right - the system call is very specialised and is targeted at
> solving problems which have been encountered in a small number of
> applications, but important ones.
> 
> Right now, I do not feel that we are going to be able to come up with an
> acceptably simple VM which has both nonlinear mappings and objrmap.

that's basically my point. if you allocate the regular rmap then you
could allocate the vma. and I while some of those apps are important,
the important ones are solved by the 64bit address space. The others
would better be fixed so that they don't eat all those vmas. Also I'm
aware of one single critical app that uses thousand vmas not for the
same purpose of the ones that will be fixed definitely with the 64bit
address space.  But such an important app is hurted badly by
get_unmapped_area only, not at all by the rest of the vma load and
rbtree lookups. And with remap_file_pages you _lose_ completely the
get_unmapped_area feature. If you are ok with the remap_file_pages, then
you could as well use MAP_FIXED and your mmap would just run O(log(N))
dropping completely the get_unmapped_area load that is the only real
offender.  The problem is they don't want that, they use
get_unmapped_area today, and what they want IMHO, is my new design for
the O(log(N)) mmap w/o MAP_FIXED and w/o addr-hint, _not_
remap_file_pages. So they can still use get_unmapped_area and it'll run
as fast as MAP_FIXED, we could completely avoid any additional lookup on
the rbtree and just use the single lookup checkpoint that also the
MAP_FIXED just is using to verify and insert in a single walk of the
tree. This is technically doable as far as I can tell, and I'm going to
implement it.

So I definitely vote to drop remap_file_pages. I don't have ready right
now the O(log(N)) get_unmapped_area, that will be tricky, but it's
definitely doable and it's the next thing I'll work on for 2.5 from my
part. In the meantime people could use MAP_FIXED (or at least the hint),
if they can't use MAP_FIXED they can't use remap_file_pages either,
period. Infact using MAP_FIXED is an order of magnitude simpler.

the worst part IMHO is that it screwup the vma making the vma->vm_file
totally wrong for the pages in the vma. The only way to leave it is:

1) to allow it only in a special vma called VM_NONLINEAR allocated via
   mmap previously

2) such a magic vma will have a null vm_file and it will be
   totally ignored by the VM

3) the remap_file_pages would then need to be enabled via a sysctl for
   security reasons (can pin indefinite amounts of ram)

4) no issue with sigbus

5) if a truncate happens in a file, just leave the page mapped, the
   reference count will leave it allocated and outside the pagecache,
   and the possibly dirty page will be freed during the zap_pages_ranges
   of the munmap done on the VM_NONLINAER vm

In the current form it seems totally broken and at the very least the
above should be done to fix it but I vote to drop it enterely since it
doesn't worth the complexity IMHO.

>From my part I will do all I can to make 64bit to run so much faster
than whatever remap_file_pages that people won't want to use
remap_file_pages anyways.

Andrea
