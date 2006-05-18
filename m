Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWERWnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWERWnK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 18:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbWERWnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 18:43:10 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:3985 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1751036AbWERWnI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 18:43:08 -0400
Date: Thu, 18 May 2006 16:43:06 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sector_t overflow in block layer
Message-ID: <20060518224306.GT5964@schatzie.adilger.int>
Mail-Followup-To: Anton Altaparmakov <aia21@cam.ac.uk>,
	Linus Torvalds <torvalds@osdl.org>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	"ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <m3odxxukcp.fsf@bzzz.home.net> <1147884610.16827.44.camel@localhost.localdomain> <m34pzo36d4.fsf@bzzz.home.net> <1147888715.12067.38.camel@dyn9047017100.beaverton.ibm.com> <m364k4zfor.fsf@bzzz.home.net> <20060517235804.GA5731@schatzie.adilger.int> <1147947803.5464.19.camel@sisko.sctweedie.blueyonder.co.uk> <20060518185955.GK5964@schatzie.adilger.int> <Pine.LNX.4.64.0605181403550.10823@g5.osdl.org> <Pine.LNX.4.64.0605182307540.16178@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605182307540.16178@hermes-1.csi.cam.ac.uk>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 18, 2006  23:12 +0100, Anton Altaparmakov wrote:
> On Thu, 18 May 2006, Linus Torvalds wrote:
> > On Thu, 18 May 2006, Andreas Dilger wrote:
> > > +	/* Check if we overflow sector_t when computing the sector offset.  */
> > > +	sector = (unsigned long long)bh->b_blocknr * (bh->b_size >> 9);
> > 
> > Ok so far, looks fine.
> > 
> > But what the heck is this:
> > 
> > > +#if !defined(CONFIG_LBD) && BITS_PER_LONG == 32
> > > +	if (unlikely(sector != (sector_t)sector))
> > > +#else
> > > +	if (unlikely(((bh->b_blocknr >> 32) * (bh->b_size >> 9)) >=
> > > +		     0xffffffff00000000ULL))
> > > +#endif
> > 
> > I don't understand the #ifdef at all.
> > 
> > Why isn't that just a 
> > 
> > 	if (unlikely(sector != (sector_t)sector))
> >
> > and that's it? What does this have to do with CONFIG_LBD or BITS_PER_LONG, 
> > or anything at all?
> > 
> > If the sector number fits in a sector_t, we're all good.
> 
> I think you missed that Andreas said he is worried about 64-bit overflows 
> as well.  And you would not catch those with the sector != 
> (sector_t)sector test because you would be comparing two 64-bit values 
> together so they always match...
> 
> Hence why he shifts the value right by 32 bits then multiplies and tests 
> the result for overflowing 32-bits which if it does it means it would 
> overflow the 64-bit multiplication, too therefor your "sector" is 
> truncated.

Yes, this is exactly correct.  At various times while writing this I had 
more comments to explain everything, but then removed them as too wordy.
The actual implementation isn't what I care about - the resulting corruption
is more important and I thought it better to at least get some attention
on it instead of worrying over the details.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

