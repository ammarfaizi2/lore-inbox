Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWERWMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWERWMV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 18:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWERWMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 18:12:21 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:2019 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750725AbWERWMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 18:12:20 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 18 May 2006 23:12:03 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andreas Dilger <adilger@clusterfs.com>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sector_t overflow in block layer
In-Reply-To: <Pine.LNX.4.64.0605181403550.10823@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0605182307540.16178@hermes-1.csi.cam.ac.uk>
References: <1147849273.16827.27.camel@localhost.localdomain>
 <m3odxxukcp.fsf@bzzz.home.net> <1147884610.16827.44.camel@localhost.localdomain>
 <m34pzo36d4.fsf@bzzz.home.net> <1147888715.12067.38.camel@dyn9047017100.beaverton.ibm.com>
 <m364k4zfor.fsf@bzzz.home.net> <20060517235804.GA5731@schatzie.adilger.int>
 <1147947803.5464.19.camel@sisko.sctweedie.blueyonder.co.uk>
 <20060518185955.GK5964@schatzie.adilger.int> <Pine.LNX.4.64.0605181403550.10823@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 May 2006, Linus Torvalds wrote:
> On Thu, 18 May 2006, Andreas Dilger wrote:
> >  	struct bio *bio;
> > +	unsigned long long sector;
> >  	int ret = 0;
> >  
> >  	BUG_ON(!buffer_locked(bh));
> >  	BUG_ON(!buffer_mapped(bh));
> >  	BUG_ON(!bh->b_end_io);
> >  
> > +	/* Check if we overflow sector_t when computing the sector offset.  */
> > +	sector = (unsigned long long)bh->b_blocknr * (bh->b_size >> 9);
> 
> Ok so far, looks fine.
> 
> But what the heck is this:
> 
> > +#if !defined(CONFIG_LBD) && BITS_PER_LONG == 32
> > +	if (unlikely(sector != (sector_t)sector))
> > +#else
> > +	if (unlikely(((bh->b_blocknr >> 32) * (bh->b_size >> 9)) >=
> > +		     0xffffffff00000000ULL))
> > +#endif
> 
> I don't understand the #ifdef at all.
> 
> Why isn't that just a 
> 
> 	if (unlikely(sector != (sector_t)sector))
> 
> and that's it? What does this have to do with CONFIG_LBD or BITS_PER_LONG, 
> or anything at all?
> 
> If the sector number fits in a sector_t, we're all good.

I think you missed that Andrewas said he is worried about 64-bit overflows 
as well.  And you would not catch those with the sector != 
(sector_t)sector test because you would be comparing two 64-bit values 
together so they always match...

Hence why he shifts the value right by 32 bits then multiplies and tests 
the result for overflowing 32-bits which if it does it means it would 
overflow the 64-bit multiplication, too therefor your "sector" is 
truncated.

Makes sense to me in a some very convoluted sickening way...  (-;

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/
