Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbTDVMZm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 08:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbTDVMZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 08:25:41 -0400
Received: from mail-8.tiscali.it ([195.130.225.154]:30436 "EHLO
	mail-8.tiscali.it") by vger.kernel.org with ESMTP id S261595AbTDVMZj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 08:25:39 -0400
Date: Tue, 22 Apr 2003 14:37:19 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@redhat.com>
Cc: Andrew Morton <akpm@digeo.com>, mbligh@aracnet.com, mingo@elte.hu,
       hugh@veritas.com, dmccr@us.ibm.com,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030422123719.GH23320@dualathlon.random>
References: <20030405143138.27003289.akpm@digeo.com> <Pine.LNX.4.44.0304220618190.24063-100000@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304220618190.24063-100000@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22, 2003 at 07:00:05AM -0400, Ingo Molnar wrote:
> 
> On Sat, 5 Apr 2003, Andrew Morton wrote:
> 
> > Andrea Arcangeli <andrea@suse.de> wrote:
> > >
> > > I see what you mean, you're right. That's because all the 10,000 vma
> > > belongs to the same inode.
> > 
> > I see two problems with objrmap - this search, and the complexity of the
> > interworking with nonlinear mappings.
> > 
> > There is talk going around about implementing some more sophisticated
> > search structure thatn a linear list.
> > 
> > And treating the nonlinear mappings as being mlocked is a great
> > simplification - I'd be interested in Ingo's views on that.
> 
> i believe the right direction is the one that is currently happening: to
> make nonlinear mappings more generic. sys_remap_file_pages() started off
> as a special hack mostly usable for locked down pages. Now it's directly
> encoded in the pte and thus swappable, and uses up a fraction of the vma
> cost for finegrained mappings.
> 
> (i believe the next step should be to encode permission bits into the pte
> as well, and thus enable eg. mprotect() to work without splitting up vmas.  
> On 32-bit ptes this is not relistic due to the file size limit imposed,
> but once 64-bit ptes become commonplace it's a step worth taking i
> believe.)
> 
> the O(N^2) property of objrmap where N is the 'inode sharing factor' is a
> serious design problem i believe. 100 mappings in 100 contexts on the same
> inode is not uncommon at all - still it totally DoS-es the VM's scanning
> code, if it uses objrmap. Sure, rmap is O(N) - after all we do have 100
> users of that mapping.
> 
> If the O(N^2) can be optimized away then i'm all for it. If not, then i
> dont really understand how the same people who call sys_remap_file_pages()
> a 'hack' [i believe they are not understanding the current state of the

it's an hack primarly because you're mixing linear with non linear,
incidentally that as well breaks truncate. In the current state truncate
is malfunctioning. To make truncate working in the current state you
would need to check all pages->indexes for every page pointed by the
pagetables belonging to each vma linked in the objrmap.

I don't think anybody wants to slowdown truncate like that (I mean, with
partial truncates and huge vmas).

Fixing it so truncate works still at a the current speed (when you don't
use sys_remap_file_pages) means changing the API to be sane and at the
very least to stop mixing linaer with nonlinaer vmas.

And I found very unclean anyways that you can mangle a linaer vma, and
to have it partly linear and partly nonlinear. nonlinear vmas are
special, if they would not be special we would not break anything with
the nonlinear behaviour inside a linear vma.

At the very least you need a mmap(VM_NONLINEAR) to allocate the
nonlinaer virtual space, and to have sys_remap_file_pages working only
inside this space.

This was one of my first points to consider sys_remap_file_pages a stay
in the kernel as a sane API. The other points are lower prio actually.

As for the other points I still think the whole purpose of
sys_remap_file_pages is to bypass the VM enterely so it should have the
least possible hardware cost associated with it. It is meant only to
mangle pagetables from userspace. And sys_remap_file_pages has nothing
to do with rmap or objrmap btw (that is an issue for everything, not
just this). But since the whole purpose of sys_remap_file_pages is to
bypass the VM enterely and to make it as fast as possible, we should as
well turn off the paging to allow people to get the biggest advantage
out of sys_remap_file_pages and to allow to pass the filedescriptor as
well to sys_remap_file_pages, so that you can map multiple files in the
same vma. I think allowing multiple files makes perfect sense and the
lack of this additional important feature is a concern to me.

Also sys_remap_file_pages should as well try to use largepages to map
the pagecache, as far as the alignment and the largepage pool allows it.
That makes perfect sense. 

As for bochs it will have no problem in enabling a system wide sysctl
before running, that's much cleaner than loading two kernel modules.

Overall trying to make nonlinear a usable by default generic API looks
wrong to me, sys_remap_file_pages has to be a VM bypass or it has to go.
If you want it to stay as a possibly default generic API then drop the
vma enterely and have mmap() and mprotect and mlock not generating any
vma overhead, but have them generating nonlinare stuff inside a single
whole vma for the whole address space. If you can do everything
generically (as you seem to want to reach) with sys_remap_file_pages,
then do it with the current API w/o generating a new non standard API.
It's a matter of functionalty inside the kernel, if you can do
everything w/o vma, then dorp the vma from mmap, that's all.
sys_remap_file_pages is equivalent to a mmap(MAP_FIXED) anyways.

I'm not against making mmap faster or whatever, but sys_remap_file_pages
makes sense to me only as a VM bypass, something that will always be
faster than the regular mmap or whatever by bypassing the VM. If you
don't bypass the VM you should make mmap run as fast as
sys_remap_file_pages instead IMHO.

Andrea
