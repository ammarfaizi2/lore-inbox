Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751020AbWERWmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWERWmS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 18:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWERWmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 18:42:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35248 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751019AbWERWmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 18:42:17 -0400
Date: Thu, 18 May 2006 15:41:57 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Andreas Dilger <adilger@clusterfs.com>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sector_t overflow in block layer
In-Reply-To: <Pine.LNX.4.64.0605182307540.16178@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0605181526240.10823@g5.osdl.org>
References: <1147849273.16827.27.camel@localhost.localdomain>
 <m3odxxukcp.fsf@bzzz.home.net> <1147884610.16827.44.camel@localhost.localdomain>
 <m34pzo36d4.fsf@bzzz.home.net> <1147888715.12067.38.camel@dyn9047017100.beaverton.ibm.com>
 <m364k4zfor.fsf@bzzz.home.net> <20060517235804.GA5731@schatzie.adilger.int>
 <1147947803.5464.19.camel@sisko.sctweedie.blueyonder.co.uk>
 <20060518185955.GK5964@schatzie.adilger.int> <Pine.LNX.4.64.0605181403550.10823@g5.osdl.org>
 <Pine.LNX.4.64.0605182307540.16178@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 May 2006, Anton Altaparmakov wrote:
> 
> I think you missed that Andrewas said he is worried about 64-bit overflows 
> as well.

Ahh. Ok. However, then the test _really_ should be something like

	sector_t maxsector, sector;
	int sector_shift = get_sector_shift(bh->b_size);

	maxsector = (~(sector_t)0) >> sector_shift;
	if (unshifted_value > maxsector)
		return -EIO;
	sector = (sector_t) unshifted_value << sector_shift;

which is a lot clearer, and likely faster too, with a proper 
get_sector_shift. Something like this:

	/*
	 * What it the shift required to turn a bh of size
	 * "size" into a 512-byte sector count?
	 */
	static inline int get_sector_shift(unsigned int size)
	{
		int shift = -1;
		unsigned int n = 256;

		do {
			shift++;
		} while ((n += n) < size);
		return shift;
	}

which should generate good code on just about any architecture (it avoids 
actually using shifts on purpose), and I think the end result will end up 
being more readable (I'm not claiming that the "get_sector_shift()" 
implementation is readable, I'm claiming that the _users_ will be more 
readable).

Of course, even better would be to not have "b_size" at all, but use 
"b_shift", but we don't have that. And the sector shift calculation might 
be fast enough that it's even a win (turning a 64-bit multiply into a 
shift _tends_ to be better)

		Linus
