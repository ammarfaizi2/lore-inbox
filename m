Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314546AbSFQP4L>; Mon, 17 Jun 2002 11:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314548AbSFQP4K>; Mon, 17 Jun 2002 11:56:10 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49256 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S314546AbSFQP4I>; Mon, 17 Jun 2002 11:56:08 -0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andi Kleen <ak@suse.de>, Benjamin LaHaise <bcrl@redhat.com>,
       linux-kernel@vger.kernel.org, Richard Brunner <richard.brunner@amd.com>,
       mark.langsdorf@amd.com
Subject: Re: another new version of pageattr caching conflict fix for 2.4
References: <20020614062754.A11232@wotan.suse.de>
	<20020614112849.A22888@redhat.com>
	<20020614181328.A18643@wotan.suse.de>
	<20020614173133.GH2314@inspiron.paqnet.com>
	<20020614200537.A5418@wotan.suse.de>
	<m17kkzv8lq.fsf@frodo.biederman.org>
	<20020616184801.A15227@wotan.suse.de>
	<m13cvnun7o.fsf@frodo.biederman.org>
	<20020616204305.A32022@wotan.suse.de>
	<m1y9dft2t8.fsf@frodo.biederman.org>
	<20020617065306.GD2187@dualathlon.random>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Jun 2002 09:46:03 -0600
In-Reply-To: <20020617065306.GD2187@dualathlon.random>
Message-ID: <m1ptypucw4.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:

> On Sun, Jun 16, 2002 at 01:56:51PM -0600, Eric W. Biederman wrote:
> > Andi Kleen <ak@suse.de> writes:
> > 
> > > On Sun, Jun 16, 2002 at 11:50:51AM -0600, Eric W. Biederman wrote:
> > > > Andi Kleen <ak@suse.de> writes:
> > > > 
> > > > > On Sun, Jun 16, 2002 at 04:08:49AM -0600, Eric W. Biederman wrote:
> > > > > > 
> > > > > > Don't allow the change_page_attr if page->count > 1 is an easy
> solution,
> 
> > > > > > and it probably suffices.  Beyond that anything mmaped can be found
> > > > > 
> > > > > Erm, what should it do then? Fail the AGP map ?
> > > > 
> > > > Why not.  If user-space has already mapped the memory one way, turning
> > > > around and using it another way is a problem.  If the memory is
> > > > dynamically allocated for AGP I don't even see how this case
> > > > could occur.
> > > 
> > > It's a random error. AGP randomly gets some page that is already mapped
> > > by /dev/mem somewhere. There is nothing that it can do to avoid this.
> > > As /dev/mem is root only and root can already cause much damage it is
> > > probably not worth avoiding the particular breakage.
> > 
> > Sorry my confusion I thought mmapping /dev/mem increased the page count,
> > in which case it would be easy to detect, and avoid.  I just looked
> > and it doesn't so there appears no trivial way to detect or handle
> > that case.
> 
> yep, because remap_page_range is used to work on things that doesn't
> have a page structure in the first place too. We cannot trap /dev/mem,
> unless additional infrastructure is developed for it. I would ignore it,
> /dev/mem should be necessary only to non-ram pages, and so it should
> never be a problem. If it's a problem it falls into Al's category of the
> "doctor it hurts".

Which is fine as long as we recognize it will hurt if we use it.  
 
> > My preferred fix is to use PAT, to override the buggy mtrrs.  Which
> > brings up the same aliasing issues.  Which makes it related but
> > outside the scope of the problem.
> 
> I don't see why you keep wondering about cacheability attributes. 

Because this patch is nipping on the edge of a more general problem,
and the practical purpose I can serve is to stir up ideas.  

If the mtrrs we a good flexible general purpose solution we could just
mark all of the affected memory as uncacheable, in the mtrrs, and not
even modify the page tables.  As it is this case is one of several
proofs that the mtrrs are significantly flexibility impaired.

Beyond that having cacheability attributes in the page table is not
limited to x86, and we are coming close to building the infrastructure 
needed to handle this in general.  Not that I advocate we do anything
except consider the case at this juncture, but having had the
conversation now it lays the foundation for developing code that
handles the cache of virtual aliases having the same cacheability attributes.

> We
> simply need to avoid the aliasing, then you don't care about the cache
> attributes. 

That we should avoid physical aliasing I agree.  That is the real
problem even though the summary provided by AMD a little while ago
got this wrong.

> It is a matter of the agp code if it wants write-back
> write-combining or uncached then. the corruption happens because of the
> physical aliases, if you remove the physical aliases in the cache then
> you don't need to care about the cache-type.

Potentially.  If you start caching the data it will only work if the
agp controller participates in the cache-consistency protocol.
 
> So my suggestion, besides changing the API to the device drivers so that
> the arch returns an array of pages ready to handle physical aliasing (so
> moving the allocation/freeing in the arch/ section), is to mark the pte
> of the aliased 4k pages as invalid. No need to care about cacheability
> then. Just mark the pte invalid, flush the tlb, and flush the caches.
> When you drop pages from the aperture, drop the agp mapping, flush the
> tlb for the agp mapping, flush caches and reeanble the original
> pagetable possibly making it again a largepage. No need to care about
> mtrr or pte cacheability attributes this way, and even better this way
> we'll oops any bogus user that is trying to access the page via the
> kernel direct mapping while there's a physical alias, such guy should
> use the agp virtual mapping instead, not the kernel direct mapping.
> Marking the pte invalid is's even simpler than marking it uncacheable,
> so it's very simple to change Andi's patch that way.

A relatively simple hook into the /dev/mem infrastructure would
probably be worth it as well.  If you are going to oops the kernel,
giving user space an error is polite.

Eric



