Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283034AbRK1Ngv>; Wed, 28 Nov 2001 08:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283043AbRK1Ngn>; Wed, 28 Nov 2001 08:36:43 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:34062 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283039AbRK1NgX>;
	Wed, 28 Nov 2001 08:36:23 -0500
Date: Wed, 28 Nov 2001 14:35:51 +0100
From: Jens Axboe <axboe@suse.de>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        jmerkey@timpanogas.org
Subject: Re: Block I/O Enchancements, 2.5.1-pre2
Message-ID: <20011128143551.U23858@suse.de>
In-Reply-To: <15364.3457.368582.994067@gargle.gargle.HOWL> <Pine.LNX.4.33.0111271701140.1629-100000@penguin.transmeta.com> <20011127183418.A812@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011127183418.A812@vger.timpanogas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27 2001, Jeff V. Merkey wrote:
> On Tue, Nov 27, 2001 at 05:04:46PM -0800, Linus Torvalds wrote:
> > 
> > On Wed, 28 Nov 2001, Paul Mackerras wrote:
> > >
> > > Is there a description of the new block layer and its interface to
> > > block device drivers somewhere?  That would be helpful, since Ben
> > > Herrenschmidt and I are going to have to convert several
> > > powermac-specific drivers.
> > 
> > Jens has something written up, which he sent to me as an introduction to
> > the patch. I'll send that out unless he does a cleaned-up version, but I'd
> > actually prefer for him to do the sending. Jens?
> > 
> > 		Linus
> > 
> 
> 
> Linus/Jens,
> 
> I've just completed my review of submit_bio and the changes to 
> generic_make_request and I have some questions for whomever
> can answer.
> 
> 1.  The changes made to submit_bh indicate I can now send long 
> chains of variable block size requests to the I/O layer similiar
> to the capability of Windows 2000 and NetWare I/O subsystems.

Yes, you can build generically a single I/O unit that spans up to 256
pages. If you bypass the bio_alloc/bvec_alloc mechanism, the sky is the
limit. Beware that a really big bio may need to be split up in the end
for devices that can't handle them that big.

> 2.  The elevator layer is merging these requests, and making a 
> single sweep request for contiguous sector runs.

Like always, yes.

> 3.  In theory, I should be able to support page cache capability
> for NWFS and possibly NTFS in Linux the way these wierd non-Unix 
> OS's work.

Maybe :-)

> 4.  This interface may **NOT** support non-block aligned requests
> across all the drivers.  I also need to be able to submit a 
> request chain 512-2048-512-1024-4096 where the first IO requested
> may by on a non-block aligned boundry.  i.e.  Device is configured
> for 1024 byte blocks, I start the request as 512 @ LBA 1 -> 1024 @ LBA 2, 
> etc.  The code looks like it will work.

As long as the smallest unit above is at least the size of the hardware
sector on the target, it should be ok.

> I would love to test this wonderful code and will hopefully this evening,
> however, all the SCSI drivers appear to be broken, as well as the 
> 3Ware. :-)

Well not all, but many. I only converted stuff I could personally test,
basically, plus a bit more. Usually converting a SCSI driver is not a
lot of work, please see the changes to sym/sym2 etc in the pre2 patch.

-- 
Jens Axboe

