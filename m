Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWESVGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWESVGQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 17:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWESVGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 17:06:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57770 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750944AbWESVGO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 17:06:14 -0400
Subject: Re: [PATCH] sector_t overflow in block layer
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andreas Dilger <adilger@clusterfs.com>, Linus Torvalds <torvalds@osdl.org>,
       Anton Altaparmakov <aia21@cam.ac.uk>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20060519131130.71c390d9.akpm@osdl.org>
References: <1147884610.16827.44.camel@localhost.localdomain>
	 <m34pzo36d4.fsf@bzzz.home.net>
	 <1147888715.12067.38.camel@dyn9047017100.beaverton.ibm.com>
	 <m364k4zfor.fsf@bzzz.home.net> <20060517235804.GA5731@schatzie.adilger.int>
	 <1147947803.5464.19.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20060518185955.GK5964@schatzie.adilger.int>
	 <Pine.LNX.4.64.0605181403550.10823@g5.osdl.org>
	 <Pine.LNX.4.64.0605182307540.16178@hermes-1.csi.cam.ac.uk>
	 <Pine.LNX.4.64.0605181526240.10823@g5.osdl.org>
	 <20060518232324.GW5964@schatzie.adilger.int>
	 <1148067412.5156.65.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20060519131130.71c390d9.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 19 May 2006 22:05:47 +0100
Message-Id: <1148072747.5156.97.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-05-19 at 13:11 -0700, Andrew Morton wrote:

> btw, it seems odd to me that we're trying to handle the
> device-too-large-for-sector_t problem at the submit_bh() level.  What
> happens if someone uses submit_bio()?

The initial code we were trying to protect was the 

	bio->bi_sector = bh->b_blocknr * (bh->b_size >> 9);

in submit_bh(), which can take a blocknr that fits within 2^32 and
multiply it such that it overflows sector_t.  That specific case doesn't
happen for submit_bio() simply because we're already taking input
counted in sectors in that case.

So for submit_bio(), we can't do it at IO time (at least not within the
block layer.)  But...

> Isn't it something we can check at
> mount time, or partition parsing, or...?

Yes, we could and we should --- the recent ext2-devel >32-bit
discussions have already identified mount and resize as needing this
sort of attention.  It's not just for >32-bit filesystems, either --- an
existing 31-bit ext3 filesystem can be up to 8TB with 4k blocks, and
that easily exceeds the addressing limit of sector_t on 32-bit hosts
without CONFIG_LBD.

I don't think we should be doing it at partition check time.  We don't
want to unnecessarily hurt the user who created a LUN just a little
larger than 2TB and formatted a filesystem onto it that does actually
fit; or who has a <2TB filesystem, tries to lvextend it, and then finds
that the fs itself won't grow beyond 2TB.  As long as the filesystem
itself fits into sector_t we should just allow access, so it's really
mount time, not partition time, when we need to check all of this.

--Stephen


