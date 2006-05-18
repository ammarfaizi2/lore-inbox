Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWERXX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWERXX0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 19:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbWERXX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 19:23:26 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:1224 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1750960AbWERXX0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 19:23:26 -0400
Date: Thu, 18 May 2006 17:23:24 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sector_t overflow in block layer
Message-ID: <20060518232324.GW5964@schatzie.adilger.int>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	"ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <1147884610.16827.44.camel@localhost.localdomain> <m34pzo36d4.fsf@bzzz.home.net> <1147888715.12067.38.camel@dyn9047017100.beaverton.ibm.com> <m364k4zfor.fsf@bzzz.home.net> <20060517235804.GA5731@schatzie.adilger.int> <1147947803.5464.19.camel@sisko.sctweedie.blueyonder.co.uk> <20060518185955.GK5964@schatzie.adilger.int> <Pine.LNX.4.64.0605181403550.10823@g5.osdl.org> <Pine.LNX.4.64.0605182307540.16178@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.64.0605181526240.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605181526240.10823@g5.osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 18, 2006  15:41 -0700, Linus Torvalds wrote:
> On Thu, 18 May 2006, Anton Altaparmakov wrote:
> > I think you missed that Andreas said he is worried about 64-bit overflows 
> > as well.
> 
> Ahh. Ok. However, then the test _really_ should be something like
> 
> 	sector_t maxsector, sector;
> 	int sector_shift = get_sector_shift(bh->b_size);
> 
> 	maxsector = (~(sector_t)0) >> sector_shift;
> 	if (unshifted_value > maxsector)
> 		return -EIO;
> 	sector = (sector_t) unshifted_value << sector_shift;
> 
> which is a lot clearer, and likely faster too, with a proper 
> get_sector_shift.

I looked at that also, but it isn't clear from the use of "b_size" here
that there is any constraint that b_size is a power of two, only that it
is a multiple of 512.  Granted, I don't know whether there are any users
of such a crazy thing, but the fact that this is in bytes instead of a
shift made me think twice.

> Something like this:
> 
> 	/*
> 	 * What it the shift required to turn a bh of size
> 	 * "size" into a 512-byte sector count?
> 	 */
> 	static inline int get_sector_shift(unsigned int size)
> 	{
> 		int shift = -1;
> 		unsigned int n = 256;
> 
> 		do {
> 			shift++;
> 		} while ((n += n) < size);
> 		return shift;
> 	}
> 
> which should generate good code on just about any architecture (it avoids 
> actually using shifts on purpose), and I think the end result will end up 
> being more readable (I'm not claiming that the "get_sector_shift()" 
> implementation is readable, I'm claiming that the _users_ will be more 
> readable).

This in fact exists virtually identically in blkdev.h::blksize_bits()
which I had a look at, but worried a bit about b_size != 2^n and also
the fact that this has branches and/or loop unwinding vs. the fixed
shift operations.

> Of course, even better would be to not have "b_size" at all, but use 
> "b_shift", but we don't have that.

I was thinking exactly the same thing myself.

> And the sector shift calculation might be fast enough that it's even
> a win (turning a 64-bit multiply into a shift _tends_ to be better)

My thought was that the gratuitous 64-bit multiply in the 32-bit case
was offset by the fact that the comparison is easy.  In the 64-bit case
we are already doing a 64-bit multiply so the goal is to make the
comparison as cheap as possible.

In the end, I don't really care about the exact mechanics of the check...

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

