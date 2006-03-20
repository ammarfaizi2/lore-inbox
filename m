Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965197AbWCTQsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965197AbWCTQsH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965867AbWCTQsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:48:06 -0500
Received: from xenotime.net ([66.160.160.81]:25580 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965197AbWCTQsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 11:48:05 -0500
Date: Mon, 20 Mar 2006 08:50:08 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: htejun@gmail.com, davem@redhat.com, axboe@suse.de, bzolnier@gmail.com,
       james.steward@dynamicratings.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, mattjreimer@gmail.com,
       rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug
Message-Id: <20060320085008.d13dd57e.rdunlap@xenotime.net>
In-Reply-To: <1142871172.3283.17.camel@mulgrave.il.steeleye.com>
References: <11371658562541-git-send-email-htejun@gmail.com>
	<1137167419.3365.5.camel@mulgrave>
	<20060113182035.GC25849@flint.arm.linux.org.uk>
	<1137177324.3365.67.camel@mulgrave>
	<20060113190613.GD25849@flint.arm.linux.org.uk>
	<20060222082732.GA24320@htj.dyndns.org>
	<1142871172.3283.17.camel@mulgrave.il.steeleye.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2006 10:12:51 -0600 James Bottomley wrote:

> On Wed, 2006-02-22 at 17:27 +0900, Tejun Heo wrote:
> > \This thread has been dead for quite some time mainly because I didn't
> > know what to do.  As it is a real outstanding bug bugging people and
> > Matt Reimer thankfully reminded me[1], I'm giving another shot at
> > resolving this.
> > 
> > People seem to agree that it is the responsibility of the driver to
> > make sure read data gets to the page cache page (or whatever kernel
> > page).  Only driver knows how and when.
> > 
> > The objection raised by James Bottomley is that although syncing the
> > kernel page is the responsbility of the driver, syncing user page is
> > not; thus, use of flush_dcache_page() is excessive.  James suggested
> > use of flush_kernel_dcache_page().
> > 
> > I also asked similar question[2] on lkml and Russell replied that
> > depending on arch implementation it shouldn't be much of a problem[3].
> > Another thing to consider is that all other drivers which currently
> > manage cache coherency use flush_dcache_page().
> > 
> > So, the questions are...
> > 
> > q1. James, besides from the use of flush_dcache_page(), do you agree
> >     with the block layer kmap/kunmap API?
> > 
> > 2. Is flush_kernel_dcache_page() the correct one?
> > 
> > Whether or not flush_kernel_dcache_page() is the one or not, I think
> > we should first go with flush_dcache_page() as that's what drivers
> > have been doing upto this point.  Switching from flush_dcache_page()
> > to flush_kernel_dcache_page() is very easy and should be done in a
> > separate patch anyway.  No?
> > 
> > Another thing mind is that this problem is not limited block drivers.
> > All the codes that perform writes to kmap'ed pages take care of
> > synchronization themselves and the popular choice seems to be
> > flush_dcache_page().
> > 
> > IMHO, kmap API should have a flag or something to tell it how the page
> > is being used such that kmap API can take care of synchronization like
> > dma mapping API does rather than scattering sync code all over the
> > kernel.  And if that's the right thing to do, some of blk kmap
> > wrappers can/should be removed.
> > 
> > What do you guys think?
> 
> Here's my proposal to break this logjam.
> 
> I'm proposing introducing a new memory coherency API:
> 
> flush_kernel_dcache_page()
> 
> Which would be tasked with bringing cache coherency back to the kernel's
> image of a user page after the kernel has modified it.  On parisc this
> will be a simple flush through the kernel cache.
> 
> I think on arm this should be implemented as
> 
> __cpuc_flush_dcache_page(page_address(page))
> 
> but you can implement this as flush_dcache_page() if you wish (I warn
> you now that you have the same flush_dcache_mmap_lock problem that we
> have on parisc, so if you do this, you'll return from
> flush_dcache_page() with interrupts enabled, but at least this will no
> longer be a parisc problem).
> 
> If everyone's happy with this approach, I'll take it over to linux-arch.

why is that the right place for it?

---
~Randy
