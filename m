Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263961AbUCZITX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 03:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263968AbUCZITX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 03:19:23 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:6566 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263961AbUCZITO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 03:19:14 -0500
Date: Fri, 26 Mar 2004 09:19:10 +0100
From: Jens Axboe <axboe@suse.de>
To: Shawn Lindberg <slindber@uiuc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Problem]: "access beyond end" of DVD-R
Message-ID: <20040326081909.GX3377@suse.de>
References: <61db4321.26d1c342.8185f00@expms3.cites.uiuc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61db4321.26d1c342.8185f00@expms3.cites.uiuc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25 2004, Shawn Lindberg wrote:
> Jens Axboe wrote:
> > On Wed, Mar 24 2004, Shawn Lindberg wrote:
> > 
> >>Jens Axboe wrote:
> >>
> >>>On Mon, Mar 22 2004, slindber@uiuc.edu wrote:
> >>>
> >>>
> >>>>attempt to access beyond end of device
> >>>>hdc: rw=0, want=8174536, limit=8123200
> >>>>Buffer I/O error on device hdc, logical block 2043633
> >>>>
> >>>>There are more attempt to "access beyond end of device" messages, but
> >>>>they are similar so I've snipped them.
> >>>
> >>>Does this make a difference for you (2.6 patch)?
> >>
> >>I made that one line change to my 2.6.3 kernel from gentoo and it
> >>fixed the problem for both the ISO/UDF and UDF discs (I couldn't try
> >>the ISO only disc since I don't have it anymore).  I also tried a few
> >>CDs to get a rough check for whether it introduced new errors, but
> >>they were fine also.  Please let me know if I should do any further
> >>testing, and THANKS!
> > 
> > 
> > If you could do one more test to see how they differ that would be
> > great. Attaching a patch for that, apply that instead of the other one
> > (or just manually paste the added printk in there).
> > 
> > ===== drivers/ide/ide-cd.c 1.75 vs edited =====
> > --- 1.75/drivers/ide/ide-cd.c	Tue Mar 16 09:39:41 2004
> > +++ edited/drivers/ide/ide-cd.c	Thu Mar 25 07:55:14 2004
> > @@ -2372,7 +2372,8 @@
> >  
> >  	/* Now try to get the total cdrom capacity. */
> >  	stat = cdrom_get_last_written(cdi, &last_written);
> > -	if (!stat && last_written) {
> > +	if (!stat && (last_written > toc->capacity)) {
> > +		printk("old cap %lu, new cap %lu\n", toc->capacity, last_written);
> >  		toc->capacity = last_written;
> >  		set_capacity(drive->disk, toc->capacity * sectors_per_frame);
> >  	}
> > 
> 
> First I made the above patch.  I saw no change in the output (there was no instance of the new printk in the output - but reading the disc worked).  Then I made this patch:
> 
> --- /usr/src/linux/drivers/ide/ide-cd.c.pre-patch	2004-03-24 08:32:50.000000000 -0600
> +++ /usr/src/linux/drivers/ide/ide-cd.c	2004-03-25 16:30:37.000000000 -0600
> @@ -2420,6 +2420,7 @@
>  	/* Now try to get the total cdrom capacity. */
>  	stat = cdrom_get_last_written(cdi, &last_written);
>  	if (!stat && last_written) {
> +		printk("cdrom: old cap %lu, new cap %lu\n", toc->capacity, last_written);
>  		toc->capacity = last_written;
>  		set_capacity(drive->disk, toc->capacity * sectors_per_frame);
>  	}
> 
> and I got this as output:
> 
> cdrom: old cap 2227408, new cap 2030800

Yes of course, otherwise it would not trigger :-). Thanks for testing,
I'll get this one comitted right away.

-- 
Jens Axboe

