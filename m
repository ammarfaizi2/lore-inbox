Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263128AbTDVNJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 09:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbTDVNJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 09:09:27 -0400
Received: from holomorphy.com ([66.224.33.161]:6298 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263128AbTDVNJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 09:09:22 -0400
Date: Tue, 22 Apr 2003 06:20:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@digeo.com>,
       mbligh@aracnet.com, mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030422132013.GF8931@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Ingo Molnar <mingo@redhat.com>,
	Andrew Morton <akpm@digeo.com>, mbligh@aracnet.com, mingo@elte.hu,
	hugh@veritas.com, dmccr@us.ibm.com,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030405143138.27003289.akpm@digeo.com> <Pine.LNX.4.44.0304220618190.24063-100000@devserv.devel.redhat.com> <20030422123719.GH23320@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030422123719.GH23320@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22, 2003 at 07:00:05AM -0400, Ingo Molnar wrote:
>> If the O(N^2) can be optimized away then i'm all for it. If not, then i
>> dont really understand how the same people who call sys_remap_file_pages()
>> a 'hack' [i believe they are not understanding the current state of the

On Tue, Apr 22, 2003 at 02:37:19PM +0200, Andrea Arcangeli wrote:
> it's an hack primarly because you're mixing linear with non linear,
> incidentally that as well breaks truncate. In the current state truncate
> is malfunctioning. To make truncate working in the current state you
> would need to check all pages->indexes for every page pointed by the
> pagetables belonging to each vma linked in the objrmap.
> I don't think anybody wants to slowdown truncate like that (I mean, with
> partial truncates and huge vmas).
> Fixing it so truncate works still at a the current speed (when you don't
> use sys_remap_file_pages) means changing the API to be sane and at the
> very least to stop mixing linaer with nonlinaer vmas.

The truncate() issues are a relatively major outstanding issue in -mm,
and IIRC hugh was the first to raise them.


On Tue, Apr 22, 2003 at 02:37:19PM +0200, Andrea Arcangeli wrote:
> And I found very unclean anyways that you can mangle a linaer vma, and
> to have it partly linear and partly nonlinear. nonlinear vmas are
> special, if they would not be special we would not break anything with
> the nonlinear behaviour inside a linear vma.
> At the very least you need a mmap(VM_NONLINEAR) to allocate the
> nonlinaer virtual space, and to have sys_remap_file_pages working only
> inside this space.
> This was one of my first points to consider sys_remap_file_pages a stay
> in the kernel as a sane API. The other points are lower prio actually.

I don't know that it's unclean; AFAICT tagging at any level should
suffice. The arrangement as it stands is (of course) oopsable.


On Tue, Apr 22, 2003 at 02:37:19PM +0200, Andrea Arcangeli wrote:
> As for the other points I still think the whole purpose of
> sys_remap_file_pages is to bypass the VM enterely so it should have the
> least possible hardware cost associated with it. It is meant only to
> mangle pagetables from userspace. And sys_remap_file_pages has nothing
> to do with rmap or objrmap btw (that is an issue for everything, not
> just this). But since the whole purpose of sys_remap_file_pages is to
> bypass the VM enterely and to make it as fast as possible, we should as
> well turn off the paging to allow people to get the biggest advantage
> out of sys_remap_file_pages and to allow to pass the filedescriptor as
> well to sys_remap_file_pages, so that you can map multiple files in the
> same vma. I think allowing multiple files makes perfect sense and the
> lack of this additional important feature is a concern to me.
> Also sys_remap_file_pages should as well try to use largepages to map
> the pagecache, as far as the alignment and the largepage pool allows it.
> That makes perfect sense. 

I've already been tagged to implement sys_remap_file_pages() for
hugetlbfs. For implicit API's (which are arguably superior) there are
fewer issues than meet the eye so long as memory remains locked. Making
things aware of large pages at various levels of the VM, VFS, and block
io subsystem looks very attractive from a number of POV's, but more
research is needed to understand its effectiveness.


On Tue, Apr 22, 2003 at 02:37:19PM +0200, Andrea Arcangeli wrote:
> As for bochs it will have no problem in enabling a system wide sysctl
> before running, that's much cleaner than loading two kernel modules.
> Overall trying to make nonlinear a usable by default generic API looks
> wrong to me, sys_remap_file_pages has to be a VM bypass or it has to go.
> If you want it to stay as a possibly default generic API then drop the
> vma enterely and have mmap() and mprotect and mlock not generating any
> vma overhead, but have them generating nonlinare stuff inside a single
> whole vma for the whole address space. If you can do everything
> generically (as you seem to want to reach) with sys_remap_file_pages,
> then do it with the current API w/o generating a new non standard API.
> It's a matter of functionalty inside the kernel, if you can do
> everything w/o vma, then dorp the vma from mmap, that's all.
> sys_remap_file_pages is equivalent to a mmap(MAP_FIXED) anyways.

I'm hard-pressed to comment on API's. Someone with more understanding of
userspaces' needs will have to deliver a more adequate response.


On Tue, Apr 22, 2003 at 02:37:19PM +0200, Andrea Arcangeli wrote:
> I'm not against making mmap faster or whatever, but sys_remap_file_pages
> makes sense to me only as a VM bypass, something that will always be
> faster than the regular mmap or whatever by bypassing the VM. If you
> don't bypass the VM you should make mmap run as fast as
> sys_remap_file_pages instead IMHO.

Well, AFAICT the question wrt. sys_remap_file_pages() is not speed, but
space. Speeding up mmap() is of course worthy of merging given the
usual mergeability criteria.

On this point I must make a concession: k-d trees as formulated by
Bentley et al have space consumption issues that may well render them
inappropriate for kernel usage. I still believe it's worth an empirical
investigation once descriptions of on-line algorithms for their
maintenance are recovered, as well as other 2D+ spatial algorithms, esp.
those with better space behavior.

Specifically, k-d trees require internal nodes to partition spaces that
are not related to leaf nodes (i.e. data points), and not all
rebalancing policies are guaranteed to recover space.


-- wli
