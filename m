Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbTDEBUh (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 20:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbTDEBUh (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 20:20:37 -0500
Received: from mail-6.tiscali.it ([195.130.225.152]:58306 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id S261697AbTDEBUc (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 20:20:32 -0500
Date: Sat, 5 Apr 2003 03:31:43 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030405013143.GJ16293@dualathlon.random>
References: <Pine.LNX.4.44.0304041453160.1708-100000@localhost.localdomain> <20030404105417.3a8c22cc.akpm@digeo.com> <20030404214547.GB16293@dualathlon.random> <20030404150744.7e213331.akpm@digeo.com> <20030405000352.GF16293@dualathlon.random> <20030404163154.77f19d9e.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030404163154.77f19d9e.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 04:31:54PM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > the worst part IMHO is that it screwup the vma making the vma->vm_file
> > totally wrong for the pages in the vma.
> 
> Not sure what you mean here.  All pages in the vma are backed by the file at
> vm_file.  It is vm_pgoff which is meaningless.

vm_pgoff sure. But thanks for pointing this out, that's one more reason
to change the API so you can as well map from different files. Quite
frankly I thought it was just the case, I thought it was the most useful
thing for the non-workaround 32bit case. Some app even has different
segments of shm.  If you've 64bit you can do an huge mmap of an huge
file and touch only what you need.  You don't need to mmap sparse, you
just need to mmap it all and touch it sparse. At the light of this the
current API sounds totally useless on a 64bit arch, not just for the
most important apps.  this only saves address space basically, not vmas.
You can save vmas if you can map more than one as I expected. so IMHO a
"fd" descriptor should be passed to the syscall. I think the important
app using get_unmapped_area is using different files. If it's not using
different files 64bit can't have any advantage from remap_file_pages
anyways, infact remap_file_pages is a waseful additional syscall on a
64bit archs where saving address space is worthless.

> As for your other concerns: yes, I hear you.  I suspect something will have
> to give.  Ingo has a better feel for the problems which this code is solving
> and hopefully he can comment.
> 
> Perhaps it is useful to itemise the prblems which we're trying to solve here:
> 
> - ZONE_NORMAL consumption by pte_chains
> 
>   Solved by objrmap and presumably page clustering.

yes, but this has nothing to do with remap_file_pages IMHO.

> - ZONE_NORMAL consumption by VMAs
> 
>   Solved by remap_file_pages.  Neither objrmap nor page clustering will
>   help here.

this is not significant for 64bit apps, and even today with my tree you
can do as much as 32G of shm for a database on a 32bit arch. With
all shm bigpages. (note: the original bigpages patch was buggy and
crashes over 4G of bigpages and I debugged and fixed it)

But of course it'll run  faster w/o any vma at all. But the point is
that with such amount of tlb and pagetable trashing, that isn't going to
work too well anyways and 64G has other problems that may be addressed
on 2.7. (and during 2.7 we'll do the softpagesize more to decrease the
frequencly of page faults for 64bit archs than for 32bit archs)

> - pte_chain setup and teardown CPU cost.
> 
>   objrmap does not seem to help.  Page clustering might, but is unlikely to
>   be enabled on the machines which actually care about the overhead.

Again, this has nothing to do with this.

basically you're saying "we benchmark with the database and running the
database slow or failing with oom is a showstopper so rather than
dropping the rmap waste, we just workaround rmap so it won't hurt in the
critical app". So what? and all the other poor apps using mmap? what are
you doing for them? still let them suffer from rmap? are you going to
port all the userspace to nonlinear vmas so you won't suffer from rmap?

I mean, I can't buy in any way rmap related arguments about
remap_file_pages. rmap (note not objrmap) is a waste  and those apps
just shows it more.  claiming that you need rmap_file_pages to hide the
rmap waste sounds pointless to me.

> - get_unmapped_area() search complexity.
> 
>   Solved by remap_file_pages and by as-yet unimplemented algorithmic rework.

what is this "yet unimplemented algorithmic rework". I never heard of
this. this sounds like reinventing the wheel and making it fast for
remap_file_pages and not for mmap. my future get_unmapped_area will work
for regular mmap, not just for remap_file_pages.

I think remap_file_pages if it stays, should obey to all the rules in my
previous email plus two new ones that I forgotten:

6) pass a file descriptor so it makes some minor sense on a 64bit arch
7) all MM syscalls but mmap and munmap, must return -EINVAL if they're
   deal with a VM_NONLINEAR vma

 7) was implicit of course.

if rmap_file_pages stays, it has to be a kind of bypass to setup
pagetables from userspace with the vm-paging disabled in the kernel.
only mmap and munmap must work on the nonlinear vma, all other
operations must refuse to work returning -EINVAL.  Nothing more. Any
attempt to make it smart sounds overdesign. The "yet unimplemented
algorithmic rework" has to be in userspace, not kernel space. so make it
a userspace library if something. The whole point of remap_user_pages is
to let userspace control the pagetables, so it has as well to manage
them completely, that should be faster too by avoding entering kernel.
making life easier to the remap_file_pages users doesn't make sense to
me.

> - pagefault frequency and TLB invalidation cost.
> 
>   Solved by MAP_POPULATE, could also be solved by MAP_PREFAULT (but it's
>   not really a demonstrated problem).

the real issues are with the shmfs and with shmfs we need largepages
anyways. Largepages do prefaulting by design ;)

Also consider this significant factor: the larger the shmfs the smaller
the nonlinear 1G window will be and the higher the trashing. With 32G of
bigpages the remap_file_pages will trash like crazy generating an order
of mangnitude more of "window misses". I mean 32bit are just pushed at
the limit today regardless the lack of remap_file_pages. Example, if
you don't use largepages going past 16G of shm is going to be derimental.
The cost of the mmap doesn't sounds like the showstopper.

> Anything else?
> 
> 
> So looking at the above, remap_file_pages() actually has pretty good
> coverage.

If it is changed according to my 7 points then I can live with it but
still I vote for removing it. I perfectly know where it is needed in the
32bit archs today, it will be visible in the benchmarks, but it
shouldn't make an order of magnitude of difference and it's unlikely you
will get an huge benefit in the 32G case because of the tlb trashing.
Infact I suspect largepages makes difference there because it'll walk
only 2 levels also, not only for the larger tlb.  here all the points
for clarity:


1) to allow remap_file_pages to work only inside a special vma called
   VM_NONLINEAR allocated via mmap previously

2) such a magic vma will have a null vm_file and null vm_pgoff and it
   will be totally ignored by the VM paging algorithm

3) the remap_file_pages would then need to be enabled via a sysctl for
   security reasons (can pin indefinite amounts of ram)
   (both mmap(VM_NONLINEAR) and remap_file_pages have to return -EPERM
   or -EINVAL at your option, if the sysctl isn't set to 1)

4) no issue with sigbus, all ram will be pinned hard in the pagetables

5) if a truncate happens in a file, just leave the page mapped, the
   reference count will leave it allocated and outside the pagecache,
   and the possibly dirty page will be freed during the zap_pages_ranges
   of the munmap done on the VM_NONLINAER vm

6) pass a file descriptor to remap_file_pages too, so it makes some
   minor sense on a 64bit arch

7) all MM syscalls but mmap and munmap, must return -EINVAL if they're
   dealing in any way with a VM_NONLINEAR vma 


you could try to avoid the need of the sysctl by teaching the vm to
unmap such vma, but I don't think it worth and I'm sure those apps
prefers to have the stuff pinned anyways w/o the risk of sigbus and w/o
the need of mlock and it looks cleaner to me to avoid any mess with the
vm and long term nobody will care about this sysctl since 64bit will run
so much fatster w/o any remap_file_pages and tlb flush running at all

If you're ok with the above 7 points then it will look sane
speedup-hack, even if it still not worthwhile IMHO. I'm not going to
implement the 7 points, if it was me to have to do the work I would
delete it for now, and I would finish the the O(log(N)) mmap before
thinking at reintroducing remap_file_pages.

Andrea
