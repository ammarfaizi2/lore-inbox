Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284522AbRLJWPh>; Mon, 10 Dec 2001 17:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284516AbRLJWPZ>; Mon, 10 Dec 2001 17:15:25 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:35375 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S284506AbRLJWPL> convert rfc822-to-8bit; Mon, 10 Dec 2001 17:15:11 -0500
Date: Mon, 10 Dec 2001 20:21:21 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Jens Axboe <axboe@suse.de>
cc: "Justin T. Gibbs" <gibbs@scsiguy.com>, LBJM <LB33JM16@yahoo.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: highmem, aic7xxx, and vfat: too few segs for dma mapping
In-Reply-To: <20011210200302.GA13498@suse.de>
Message-ID: <20011210194953.L2225-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Dec 2001, Jens Axboe wrote:

> On Mon, Dec 10 2001, Justin T. Gibbs wrote:

> > You will never cross a 4GB boundary on a machine with only 2GB of
> > physical memory.  This report and another I have received are for
>
> Of course not.
>
> > configurations with 2GB or less memory.  This is not the cause of the
> > problem.  Further, after this code was written, David Miller made the
> > comment that an I/O that crosses a 4GB boundary will never be generated
> > for the exact same reason that this check is included in the aic7xxx
> > driver - you can't cross a 4GB page in a single PCI DAC transaction.
> > I should go verify that this is really the case in recent 2.4.X kernels.
>
> Right, we decided against ever doing that. In fact I added the very code
> to do this in the block-highmem series -- however, this assumption
> breaks down in the current 2.4 afair on 64-bit archs.

By the way, the DAC capable Symbios chips donnot support scatter entry
that crosses a 4GB boundary by *design*. In fact they seem to be
internally 32 bit addressing based with some additionnal logic for DAC to
be possible, but they don't look like true 64 bit engine.

And since these devices have had some ISA ancestors, they also have some
16 MB limit in some place. This applies to the max length that can be
DAMed by scatter entry. And since everything has bugs, some errata
applying to some early chip versions have some relationship with scatter
entry crossing a 16 MB or 32 MB boundary...

As a result, for Symbios devices, I want to ask upper layers not to
provide low-level drivers with scatter entries that cross a 16 MB boundary
and obviously not larger than 16 MB but it is a consequence. If Linux does
not allow this, they I can do nothing clean to fix the issue.

Btw, a 16 MB boundary limitation would have no significant impact on
performance and would have the goodness of avoiding some hardware bugs not
only on a few Symbios devices in my opinion. As we know, numerous modern
cores still have rests of the ISA epoch in their guts. So, in my opinion,
the 16 MB boundary limitation should be the default on systems where
reliability is the primary goal.

> > Saying that AHC_NSEG and the segment count exported to the mid-layer are
> > too differnt things is true to some extent, but if the 4GB rule is not
> > honored by the mid-layer implicitly, I would have to tell the mid-layer
> > I can only handle half the number of segments I really can.  This isn't
> > good for the memory footprint of the driver.  The test was added to
> > protect against a situation that I don't believe can now happen in Linux.
>
> > In truth, the solution to these kinds of problems is to export alignment,
> > boundary, and range restrictions on memory mappings from the device
> > driver to the layer creating the mappings.  This is the only way to
> > generically allow a device driver to export a true segment limit.
>
> I agree, and that is why I've already included code to do just that in
> 2.5.

This shouldn't have been missed, in my opinion. :)

  Gérard.


