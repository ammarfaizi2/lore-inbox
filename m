Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751126AbWFENov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWFENov (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 09:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWFENov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 09:44:51 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:61589 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751113AbWFENou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 09:44:50 -0400
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug, take 2
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, Jens Axboe <axboe@suse.de>,
        Dave Miller <davem@redhat.com>, bzolnier@gmail.com,
        james.steward@dynamicratings.com, jgarzik@pobox.com,
        mattjreimer@gmail.com, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org
In-Reply-To: <20060604204444.GF4484@flint.arm.linux.org.uk>
References: <1149392479501-git-send-email-htejun@gmail.com>
	 <20060604204444.GF4484@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 08:43:52 -0500
Message-Id: <1149515032.3489.4.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-04 at 21:44 +0100, Russell King wrote:
> > I tried to implement flush_anon_page() too but didn't know what to
> do
> > with anon_vma object.
> 
> I'm not sure what this is about...

This was for fuse on parisc.  It should have no bearing on the current
IDE problem.  What it's trying to solve is the fact that
flush_dcache_page() doesn't necessarily flush anonymous pages (because
of the way the mappings list works).  However, in order to make an
anonymous page in user space visible via the kernel address, we have to
have it flushed (this is what fuse does to transfer data into pages).
So this API was introduced into the right places to permit that to
happen.   Most VIPT architectures are CAM based, so flush_dcache_page()
actually sweeps up all the anon pages as well.  However, if the
implementation (like parisc's) has to loop over page_mapping(page) then
it will likely need to implement flush_anon_page() for fuse to work.

James


