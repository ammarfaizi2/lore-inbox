Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284467AbRLMRZQ>; Thu, 13 Dec 2001 12:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284464AbRLMRZH>; Thu, 13 Dec 2001 12:25:07 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:20386 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S284445AbRLMRY6>; Thu, 13 Dec 2001 12:24:58 -0500
Date: Thu, 13 Dec 2001 10:24:52 -0700
Message-Id: <200112131724.fBDHOqu27735@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: "David C. Hansen" <haveblue@us.ibm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Change locking in block_dev.c:do_open()
In-Reply-To: <Pine.GSO.4.21.0112122101350.17470-100000@weyl.math.psu.edu>
In-Reply-To: <3C17F8B2.6080700@us.ibm.com>
	<Pine.GSO.4.21.0112122101350.17470-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> 
> On Wed, 12 Dec 2001, David C. Hansen wrote:
> 
> > I've been looking at how the BKL is used throughout the kernel.  My end
> > goal is to eliminate the BKL, but I don't have any fanciful ideas that I
> > can get rid of it myself, or do it in a short period of time.  Right
> > now, I'm looking for interesting BKL uses and examining alternatives.
> > 
> > Lately, I've been examining do_open() in block_dev.c.  This particular
> > nugget of code uses the BKL for a couple of things.  First,
> > get_blkfops() can call request_module(), which requires the BKL.
> > Secondly, there needs to be protection so that the module isn't removed
> > between the get_blkfops() and the __MOD_INC_USE_COUNT().  Lastly, the
> > bd_op->open() calls expect the BKL to be held while they are called.  Is
> > this it?  Anybody know of more reasons?
> 
> Sigh...  First of all, the right thing to do is to call
> try_inc_mod_count() _in_ get_blkfops().  No need to reinvent the
> wheel.  But real problem with that area is not BKL.  It's *!@& damn
> devfs=only mess and code that does direct assignment of ->bd_op
> before calling blkdev_get().  Until it's solved (and the only decent
> way I see is to remove this misfeature) I'd seriously recommend to
> leave the damn thing as is.

Al, I came up with a proposed solution for this race days ago. After
switching to try_inc_mod_count() (based on your first comments), you
haven't responded with whether you still see a problem with this
approach (your first message implied there were multiple problems).

So instead of flaming, please explain where (if) there are remaining
problems in this area.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
