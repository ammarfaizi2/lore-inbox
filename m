Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWCBUlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWCBUlY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 15:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbWCBUlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 15:41:24 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:49954 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932281AbWCBUlX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 15:41:23 -0500
Date: Thu, 2 Mar 2006 21:40:37 +0100
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Dave Miller <davem@redhat.com>, bzolnier@gmail.com,
       james.steward@dynamicratings.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, mattjreimer@gmail.com,
       rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug
Message-ID: <20060302204037.GY4329@suse.de>
References: <11371658562541-git-send-email-htejun@gmail.com> <1137167419.3365.5.camel@mulgrave> <20060113182035.GC25849@flint.arm.linux.org.uk> <1137177324.3365.67.camel@mulgrave> <20060113190613.GD25849@flint.arm.linux.org.uk> <20060222082732.GA24320@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222082732.GA24320@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22 2006, Tejun Heo wrote:
> On Fri, Jan 13, 2006 at 07:06:14PM +0000, Russell King wrote:
> > On Fri, Jan 13, 2006 at 12:35:24PM -0600, James Bottomley wrote:
> > > Perhaps we should take this to linux-arch ... the audience there is well
> > > versed in these arcane problems?
> > 
> > I think you need to wait for Dave Miller to reply and give a definitive
> > statement on how his cache coherency model is supposed to work in this
> > regard.
> > 
> 
> Hello, all.
> 
> This thread has been dead for quite some time mainly because I didn't
> know what to do.  As it is a real outstanding bug bugging people and
> Matt Reimer thankfully reminded me[1], I'm giving another shot at
> resolving this.
> 
> People seem to agree that it is the responsibility of the driver to
> make sure read data gets to the page cache page (or whatever kernel
> page).  Only driver knows how and when.
> 
> The objection raised by James Bottomley is that although syncing the
> kernel page is the responsbility of the driver, syncing user page is
> not; thus, use of flush_dcache_page() is excessive.  James suggested
> use of flush_kernel_dcache_page().
> 
> I also asked similar question[2] on lkml and Russell replied that
> depending on arch implementation it shouldn't be much of a problem[3].
> Another thing to consider is that all other drivers which currently
> manage cache coherency use flush_dcache_page().
> 
> So, the questions are...
> 
> q1. James, besides from the use of flush_dcache_page(), do you agree
>     with the block layer kmap/kunmap API?
> 
> 2. Is flush_kernel_dcache_page() the correct one?
> 
> Whether or not flush_kernel_dcache_page() is the one or not, I think
> we should first go with flush_dcache_page() as that's what drivers
> have been doing upto this point.  Switching from flush_dcache_page()
> to flush_kernel_dcache_page() is very easy and should be done in a
> separate patch anyway.  No?

Fully agree. The API is the right one in my opinion, just simple
wrapping of the mapping and flushing when appropriate.

> Another thing mind is that this problem is not limited block drivers.
> All the codes that perform writes to kmap'ed pages take care of
> synchronization themselves and the popular choice seems to be
> flush_dcache_page().

It's probably not widely seen outside of IDE, I would guess.

> IMHO, kmap API should have a flag or something to tell it how the page
> is being used such that kmap API can take care of synchronization like
> dma mapping API does rather than scattering sync code all over the
> kernel.  And if that's the right thing to do, some of blk kmap
> wrappers can/should be removed.
> 
> What do you guys think?

Might be even better. Shove regular eg kmap_atomic() into
__kmap_atomic() and add kmap_atomic() just calling that and
kmap_atomic_io() with an added flag for direction. Or an even easier
'hack' - use a separate KM type for these types of mappings and flush
always. Might need both IRQ and non-IRQ version, so probably not the
best idea. I'm inclined to vote for the first suggestion.

The point of it all is that there's no point in making this too fancy or
optimized, it would be a waste of time for an utterly slow and CPU
intensive path anyways.

-- 
Jens Axboe

