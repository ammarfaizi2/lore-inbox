Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316477AbSFPSAv>; Sun, 16 Jun 2002 14:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316490AbSFPSAu>; Sun, 16 Jun 2002 14:00:50 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36966 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S316477AbSFPSAt>; Sun, 16 Jun 2002 14:00:49 -0400
To: Andi Kleen <ak@suse.de>
Cc: Andrea Arcangeli <andrea@suse.de>, Benjamin LaHaise <bcrl@redhat.com>,
       linux-kernel@vger.kernel.org, Richard Brunner <richard.brunner@amd.com>,
       mark.langsdorf@amd.com
Subject: Re: another new version of pageattr caching conflict fix for 2.4
References: <20020614032429.A19018@wotan.suse.de>
	<20020613213724.C21542@redhat.com>
	<20020614040025.GA2093@inspiron.birch.net>
	<20020614001726.D21542@redhat.com>
	<20020614062754.A11232@wotan.suse.de>
	<20020614112849.A22888@redhat.com>
	<20020614181328.A18643@wotan.suse.de>
	<20020614173133.GH2314@inspiron.paqnet.com>
	<20020614200537.A5418@wotan.suse.de>
	<m17kkzv8lq.fsf@frodo.biederman.org>
	<20020616184801.A15227@wotan.suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Jun 2002 11:50:51 -0600
In-Reply-To: <20020616184801.A15227@wotan.suse.de>
Message-ID: <m13cvnun7o.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Sun, Jun 16, 2002 at 04:08:49AM -0600, Eric W. Biederman wrote:
> > 
> > Don't allow the change_page_attr if page->count > 1 is an easy solution,
> > and it probably suffices.  Beyond that anything mmaped can be found
> 
> Erm, what should it do then? Fail the AGP map ?

Why not.  If user-space has already mapped the memory one way, turning
around and using it another way is a problem.  If the memory is
dynamically allocated for AGP I don't even see how this case
could occur.

But the mmap case still has to apply the general cache ability of the
page from the kernel page tables (or where ever it is cached), if you
do the operation in the opposite order.
 
> > by walking into the backing address space, and then through the
> > vm_area_structs found with i_mmap && i_mmap_shared.  Of course the
> > vm_area_structs may possibly need to break because of the multiple
> > page protections.
> 
> I know that, but it seems rather racy expensive and complicated.
> 
> > 
> > > > > +int change_page_attr(struct page *page, int numpages, pgprot_t prot)
> > > > > +{
> > > > 
> > > > this API not the best, again I would recommend something on these lines:
> > > 
> > > Hmm: i would really prefer to do the allocation in the caller.
> > > If you want your API you could do  just do it as a simple wrapper to
> > > the existing function (with the new numpages it would be even 
> > > efficient) 
> > 
> > Using pgprot_t to convey the cacheablity of a page appears to be an
> > abuse.  At the very least we need a PAGE_CACHE_MASK, to find just
> > the cacheability attributes.
> 
> change_page_attr is more than just cachability. You can use it e.g.
> to write protect kernel pages not (if you wanted to do that for some
> reason) 
> The current one is fine with PAGE_KERNEL_NOCACHE, you could eventually
> define PAGE_KERNEL_WRITECOMBINING too if you wanted.
> 

Combining different operations like modifying cacheability and the
page protections worries me.  Unless we name the operations something
like change_kernel_page_attr() in which case we are only worrying
about a subset of the problem.  Which it appears that we are.
 
> > And we should really consider using the other cacheability page
> > attributes on x86, not just cache enable/disable.  Using just mtrr's
> > is limiting in that you don't always have enough of them, and that
> > sometimes valid ram is mapped uncacheable, because of the mtrr
> > alignment restrictions. 
> 
> Exposing it to user space in a more general way is tricky because
> you need to avoid aliases with different caching attributes and also
> change the kernel map as needed (would be surely an interesting 
> project, but definitely requires more work) 

The kernel already exposes through /proc/mtrr the ability to
arbitrarily change the caching of pages.  And since this is a case
of physical aliasing we need to make certain the mtrr's don't
conflict.  So much of this is already exposed to user space already.

> You can already use WT. DRM does that already in fact. 
> Newer Intel/AMD CPUs allow to set up a more general PAT table with some
> more modis, but to be honest I don't see the point in most of them,
> except perhaps WC. Unfortunately there is no 'weak ordering like alpha/sparc64'
> mode that could be used in the kernel :-)

With the PAT table only write-back, write-combining, uncached interest
me.  Given the number of BIOS's that don't set all of RAM to
write-back and the major performance penalty of running on uncached
RAM having the kernel fix it, would reduce a lot of headaches long
term. 

Primarily I'm brining up the connections because it may be worth
considering them.  For 2.4.19 unless the implementation is trivial it
probably isn't wise to try for more that what is needed.  For later
kernels 2.4.x, 2.4.20+ it is almost certainly worth doing something.

Eric
