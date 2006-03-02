Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751670AbWCBSrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbWCBSrZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 13:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751671AbWCBSrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 13:47:25 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:53683 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751669AbWCBSrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 13:47:25 -0500
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Tejun Heo <htejun@gmail.com>
Cc: Dave Miller <davem@redhat.com>, axboe@suse.de, bzolnier@gmail.com,
       james.steward@dynamicratings.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, mattjreimer@gmail.com,
       rmk+lkml@arm.linux.org.uk
In-Reply-To: <20060222082732.GA24320@htj.dyndns.org>
References: <11371658562541-git-send-email-htejun@gmail.com>
	 <1137167419.3365.5.camel@mulgrave>
	 <20060113182035.GC25849@flint.arm.linux.org.uk>
	 <1137177324.3365.67.camel@mulgrave>
	 <20060113190613.GD25849@flint.arm.linux.org.uk>
	 <20060222082732.GA24320@htj.dyndns.org>
Content-Type: text/plain
Date: Thu, 02 Mar 2006 12:46:28 -0600
Message-Id: <1141325189.3238.37.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-22 at 17:27 +0900, Tejun Heo wrote:
> The objection raised by James Bottomley is that although syncing the
> kernel page is the responsbility of the driver, syncing user page is
> not; thus, use of flush_dcache_page() is excessive.  James suggested
> use of flush_kernel_dcache_page().

The problem is that it's not only excessive, it would entangle us with
mm locking.  Basically, all you want to ensure is that the underlying
memory has the information after you've done (rather than the CPU
cache), flush_kernel_dcache_page() will achieve this.  The block layer
itself takes care of user space coherency.

> I also asked similar question[2] on lkml and Russell replied that
> depending on arch implementation it shouldn't be much of a problem[3].
> Another thing to consider is that all other drivers which currently
> manage cache coherency use flush_dcache_page().
> 
> So, the questions are...
> 
> q1. James, besides from the use of flush_dcache_page(), do you agree
>     with the block layer kmap/kunmap API?

Yes.

> 2. Is flush_kernel_dcache_page() the correct one?

Yes.

> Whether or not flush_kernel_dcache_page() is the one or not, I think
> we should first go with flush_dcache_page() as that's what drivers
> have been doing upto this point.  Switching from flush_dcache_page()
> to flush_kernel_dcache_page() is very easy and should be done in a
> separate patch anyway.  No?

No. On parisc flush_dcache_mm_lock is a write_lock_irq ... that will
enable interrupts after it's done (don't ask me why ... I think Hugh did
this). a lot of kmap API callers seem to be in interrupt context and may
have irqs off, so re-enabling would be impolite.

> Another thing mind is that this problem is not limited block drivers.
> All the codes that perform writes to kmap'ed pages take care of
> synchronization themselves and the popular choice seems to be
> flush_dcache_page().
> 
> IMHO, kmap API should have a flag or something to tell it how the page
> is being used such that kmap API can take care of synchronization like
> dma mapping API does rather than scattering sync code all over the
> kernel.  And if that's the right thing to do, some of blk kmap
> wrappers can/should be removed.

you mean something like kmap_to_device/cpu (or perhaps
kmap_for_read/write?)

James


