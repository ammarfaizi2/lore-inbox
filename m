Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316595AbSHBSg6>; Fri, 2 Aug 2002 14:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316615AbSHBSg6>; Fri, 2 Aug 2002 14:36:58 -0400
Received: from zeus.kernel.org ([204.152.189.113]:42483 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S316595AbSHBSg5>;
	Fri, 2 Aug 2002 14:36:57 -0400
Date: Fri, 2 Aug 2002 20:34:53 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Steve Lord <lord@sgi.com>
cc: Jens Axboe <axboe@suse.de>, <martin@dalecki.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A new ide warning message
In-Reply-To: <1028296255.30192.9.camel@jen.americas.sgi.com>
Message-ID: <Pine.SOL.4.30.0208022018010.29467-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jens, I think bio segment boundary code is dead wrong :-).

include/linux/bio.h:
#define BIOVEC_SEG_BOUNDARY(q, b1, b2) \
	(((addr1) | (mask)) == (((addr2) - 1) | (mask)))
#define BIOVEC_SEG_BOUNDARY(q, b1, b2) \
	__BIO_SEG_BOUNDARY(bvec_to_phys((b1)), bvec_to_phys((b2)) +
(b2)->bv_len, (q)->seg_boundary_mask)

With this code we are getting new hw segment for each bio vector... :\

On 2 Aug 2002, Steve Lord wrote:

> On Fri, 2002-08-02 at 07:41, Jens Axboe wrote:
> >
> > Yeah it's a request for data, what else could it be? That's the only
> > place where we call blk_rq_map_sg().
> >
> > Stephen, please provoke with this patch applied. I hope it works, it's
> > untested :-)
> >
>
> Consider it provoked, I added a trace to the submit_bio call in XFS
> as well, dumping sector number, bio length in bytes and number of
> vector elements submitted:
>
> submit_bio(READ, sector 0x414870, len 65536 vec_len 16
> submit_bio(READ, sector 0x4148f0, len 65536 vec_len 16
> pcidma: build 2 segments, supplied 1/16, sectors 128/8
> bio 0: phys 1, hw 16
> segment 0: phys 69599232, size 4096
> segment 1: phys 69603328, size 4096
> segment 2: phys 69607424, size 4096
> segment 3: phys 69611520, size 4096
> segment 4: phys 69615616, size 4096
> segment 5: phys 69619712, size 4096
> segment 6: phys 69623808, size 4096
> segment 7: phys 69627904, size 4096
> segment 8: phys 69632000, size 4096
> segment 9: phys 69636096, size 4096
> segment 10: phys 69640192, size 4096
> segment 11: phys 69644288, size 4096
> segment 12: phys 69648384, size 4096
> segment 13: phys 69652480, size 4096
> segment 14: phys 69656576, size 4096
> segment 15: phys 69660672, size 4096
> pcidma: build 2 segments, supplied 1/16, sectors 128/8
> bio 0: phys 1, hw 16
> segment 0: phys 69664768, size 4096
> segment 1: phys 69668864, size 4096
> segment 2: phys 69672960, size 4096
> segment 3: phys 69677056, size 4096
> segment 4: phys 69681152, size 4096
> segment 5: phys 69685248, size 4096
> segment 6: phys 69689344, size 4096
> segment 7: phys 69693440, size 4096
> segment 8: phys 69697536, size 4096
> segment 9: phys 69701632, size 4096
> segment 10: phys 69705728, size 4096
> segment 11: phys 69709824, size 4096
> segment 12: phys 69713920, size 4096
> segment 13: phys 69718016, size 4096
> segment 14: phys 69722112, size 4096
> segment 15: phys 69726208, size 4096
>
> And so on.....
>
> The bio size being used is based purely on the BIO_MAX_SECTORS
> constant, same code as ll_rw_kio. Looks like the direct I/O
> path uses similar math.
>
> Steve
>
> --
>
> Steve Lord                                      voice: +1-651-683-3511
> Principal Engineer, Filesystem Software         email: lord@sgi.com

