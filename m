Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbTDECLa (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 21:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbTDECLa (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 21:11:30 -0500
Received: from mail-7.tiscali.it ([195.130.225.153]:37989 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id S261760AbTDECL2 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 21:11:28 -0500
Date: Sat, 5 Apr 2003 04:22:50 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Andrew Morton <akpm@digeo.com>, mingo@elte.hu, hugh@veritas.com,
       dmccr@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030405022250.GM16293@dualathlon.random>
References: <Pine.LNX.4.44.0304041453160.1708-100000@localhost.localdomain> <20030404105417.3a8c22cc.akpm@digeo.com> <20030404214547.GB16293@dualathlon.random> <20030404150744.7e213331.akpm@digeo.com> <20030405000352.GF16293@dualathlon.random> <20030404163154.77f19d9e.akpm@digeo.com> <20030405013143.GJ16293@dualathlon.random> <20030404205248.C21819@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030404205248.C21819@redhat.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 08:52:48PM -0500, Benjamin LaHaise wrote:
> On Sat, Apr 05, 2003 at 03:31:43AM +0200, Andrea Arcangeli wrote:
> > Also consider this significant factor: the larger the shmfs the smaller
> > the nonlinear 1G window will be and the higher the trashing. With 32G of
> > bigpages the remap_file_pages will trash like crazy generating an order
> > of mangnitude more of "window misses". I mean 32bit are just pushed at
> > the limit today regardless the lack of remap_file_pages. Example, if
> > you don't use largepages going past 16G of shm is going to be derimental.
> > The cost of the mmap doesn't sounds like the showstopper.
> 
> You're guessing here.  At least for oracle, that behaviour is dependant on 
> the locality of accesses.  Given that each user has their own process you 
> can bet there is a fair amount of locality to their transactions.
> 

I'm definitely not guessing about the largepage factor, you'd better
drop some ram and run with largepages. I've to guess about
remap_file_pages only because that's not backported yet (thankfully due
its insane api).  But if largepages makes such an huge difference, mmap
can't be the big cost under such a tlb trashing scenarios. largepages
shouldn't affect the mmap frequency at all.

Sure the locality exists, but if you wouldn't need a moving window you
wouldn't need the vlm and with 32G shm vs 512M window, your trashing
will be an order of magnitude higher than with a 1G shm, obviously.

I'm guessing but I'm guessing based on non-guesses.

However I'm not questioning that remap_file_pages will help, it will
obviously, I just don't think it's worthwhile enough and I don't see
mmap as the big cost, the big cost is the pagetable mangling and tlb
flushing that will have to happen anyways, regardless if you overwrite
the vma with an mmap or if you call remap_file_pages.

> > you could try to avoid the need of the sysctl by teaching the vm to
> > unmap such vma, but I don't think it worth and I'm sure those apps
> > prefers to have the stuff pinned anyways w/o the risk of sigbus and w/o
> > the need of mlock and it looks cleaner to me to avoid any mess with the
> > vm and long term nobody will care about this sysctl since 64bit will run
> > so much fatster w/o any remap_file_pages and tlb flush running at all
> 
> It is still useful for things outside of the pure databases on 32 bits 
> realm.  Consider a fast bochs running 32 bit apps on a 64 bit machine -- 
> should it have to deal with the overhead of zillions of vmas for emulating 
> page tables?

I can't understand this very well so it maybe my fault, but it doesn't
make any sense to me. I don't know how bochs works but for certain you
won't get any help from the API of remap_file_pages implemented in
2.5.66 in a 64bit arch.

If you think you can get any benefit, then I tell you, rather than using
remap_file_pages, just go ahead mmap the whole file for me, as large as
it is, likely you're dealing with a 32bit address space so it will be
a mere 4G. I doubt you're dealing with 1 terabytes files with bochs that
is by definintion a 32bit thing.

map it all with mmap, and access it sparse. Then you have
remap_file_pages in the 64bit archs, for free w/o special syscalls and
w/o any sigbus handling, the kernel will do the paging for you to the
swap and back into the right place in ram w/o passing through a slower
userspace signal.

I can't see any useful application of the current API of
remap_file_pages in a 64bit arch, but it's possible I'm missing
something. And no, I don't mind to waste 3.8G of address space in the
bochs process, since I still have some petabyte of it unused.

> If anything, I think we should be moving in the direction of doing more 
> along the lines of remap_file_pages: things like executables might as well 
> keep their state in page tables since we never discard them and instead 
> toss the vma out the window.

I'm sorry, but I don't understand very well this, sorry. Could you
elaborate? What state do you want to put in the pagetables? Are you
talking about the pagetables of the cpu or a simulated one in userspace?

Andrea
