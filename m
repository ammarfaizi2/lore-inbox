Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316833AbSFQGyj>; Mon, 17 Jun 2002 02:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316777AbSFQGwp>; Mon, 17 Jun 2002 02:52:45 -0400
Received: from [195.223.140.120] ([195.223.140.120]:35616 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316778AbSFQGwK>; Mon, 17 Jun 2002 02:52:10 -0400
Date: Mon, 17 Jun 2002 08:53:06 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andi Kleen <ak@suse.de>, Benjamin LaHaise <bcrl@redhat.com>,
       linux-kernel@vger.kernel.org, Richard Brunner <richard.brunner@amd.com>,
       mark.langsdorf@amd.com
Subject: Re: another new version of pageattr caching conflict fix for 2.4
Message-ID: <20020617065306.GD2187@dualathlon.random>
References: <20020614062754.A11232@wotan.suse.de> <20020614112849.A22888@redhat.com> <20020614181328.A18643@wotan.suse.de> <20020614173133.GH2314@inspiron.paqnet.com> <20020614200537.A5418@wotan.suse.de> <m17kkzv8lq.fsf@frodo.biederman.org> <20020616184801.A15227@wotan.suse.de> <m13cvnun7o.fsf@frodo.biederman.org> <20020616204305.A32022@wotan.suse.de> <m1y9dft2t8.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1y9dft2t8.fsf@frodo.biederman.org>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 16, 2002 at 01:56:51PM -0600, Eric W. Biederman wrote:
> Andi Kleen <ak@suse.de> writes:
> 
> > On Sun, Jun 16, 2002 at 11:50:51AM -0600, Eric W. Biederman wrote:
> > > Andi Kleen <ak@suse.de> writes:
> > > 
> > > > On Sun, Jun 16, 2002 at 04:08:49AM -0600, Eric W. Biederman wrote:
> > > > > 
> > > > > Don't allow the change_page_attr if page->count > 1 is an easy solution,
> > > > > and it probably suffices.  Beyond that anything mmaped can be found
> > > > 
> > > > Erm, what should it do then? Fail the AGP map ?
> > > 
> > > Why not.  If user-space has already mapped the memory one way, turning
> > > around and using it another way is a problem.  If the memory is
> > > dynamically allocated for AGP I don't even see how this case
> > > could occur.
> > 
> > It's a random error. AGP randomly gets some page that is already mapped
> > by /dev/mem somewhere. There is nothing that it can do to avoid this.
> > As /dev/mem is root only and root can already cause much damage it is
> > probably not worth avoiding the particular breakage.
> 
> Sorry my confusion I thought mmapping /dev/mem increased the page count,
> in which case it would be easy to detect, and avoid.  I just looked
> and it doesn't so there appears no trivial way to detect or handle
> that case.

yep, because remap_page_range is used to work on things that doesn't
have a page structure in the first place too. We cannot trap /dev/mem,
unless additional infrastructure is developed for it. I would ignore it,
/dev/mem should be necessary only to non-ram pages, and so it should
never be a problem. If it's a problem it falls into Al's category of the
"doctor it hurts".

> My preferred fix is to use PAT, to override the buggy mtrrs.  Which
> brings up the same aliasing issues.  Which makes it related but
> outside the scope of the problem.

I don't see why you keep wondering about cacheability attributes. We
simply need to avoid the aliasing, then you don't care about the cache
attributes. It is a matter of the agp code if it wants write-back
write-combining or uncached then. the corruption happens because of the
physical aliases, if you remove the physical aliases in the cache then
you don't need to care about the cache-type.

So my suggestion, besides changing the API to the device drivers so that
the arch returns an array of pages ready to handle physical aliasing (so
moving the allocation/freeing in the arch/ section), is to mark the pte
of the aliased 4k pages as invalid. No need to care about cacheability
then. Just mark the pte invalid, flush the tlb, and flush the caches.
When you drop pages from the aperture, drop the agp mapping, flush the
tlb for the agp mapping, flush caches and reeanble the original
pagetable possibly making it again a largepage. No need to care about
mtrr or pte cacheability attributes this way, and even better this way
we'll oops any bogus user that is trying to access the page via the
kernel direct mapping while there's a physical alias, such guy should
use the agp virtual mapping instead, not the kernel direct mapping.
Marking the pte invalid is's even simpler than marking it uncacheable,
so it's very simple to change Andi's patch that way.

Andrea
