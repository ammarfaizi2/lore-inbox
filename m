Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266688AbSKZUGO>; Tue, 26 Nov 2002 15:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266690AbSKZUGO>; Tue, 26 Nov 2002 15:06:14 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:41134 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S266688AbSKZUGJ>; Tue, 26 Nov 2002 15:06:09 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@digeo.com>
Date: Wed, 27 Nov 2002 07:13:09 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15843.54741.609413.371274@notabene.cse.unsw.edu.au>
Cc: Srihari Vijayaraghavan <harisri@bigpond.com>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.49: kernel BUG at drivers/block/ll_rw_blk.c:1950!
In-Reply-To: message from Andrew Morton on Tuesday November 26
References: <200211262203.20088.harisri@bigpond.com>
	<3DE3D1D1.BE5B30ED@digeo.com>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday November 26, akpm@digeo.com wrote:
> Srihari Vijayaraghavan wrote:
> > 
> > [1.] One line summary of the problem:
> > kernel BUG at drivers/block/ll_rw_blk.c:1950!
> 
> That's BIO_BUG_ON(!bio->bi_size);
> 
> > Software RAID 0.
> 
> Yes, there have been a few reports of this.  The pagecache code
> does bio_add_page() against a new BIO and it doesn't work.  We
> end up submitting an empty BIO and boom.
> 
> I've seen various RAID patches floating about which address this,
> but either they weren't merged or they didn't work right.
> 
> Jens, what is the policy here?  Should bio_add_page() for an
> empty bio "always succeed"?  (Bearing in mind that pages can
> be 64k...).    I guess -EIO would be better than a BUG.
> 
> Are there more RAID fixes pending?

The patch that was supposed to fix this was in 2.4.29.
The only way it should still be able to happen is with an IO request
that isn't aligned nicely, and the case in question is using ext3
which I am sure always does nicely aligned requests.

Srihari, could you possibly try with the following patch please to see
if it gives more useful information. 

Thanks,
NeilBrown


 ----------- Diffstat output ------------
 ./fs/bio.c |    4 ++++
 1 files changed, 4 insertions(+)

diff ./fs/bio.c~current~ ./fs/bio.c
--- ./fs/bio.c~current~	2002-11-27 07:09:01.000000000 +1100
+++ ./fs/bio.c	2002-11-27 07:11:47.000000000 +1100
@@ -432,6 +432,10 @@ retry_segments:
 		 * at this offset
 		 */
 		if (q->merge_bvec_fn(q, bio, bvec) < len) {
+			if (bio->bi_size == 0) {
+				printk(KERN_ERR "bio_add_page: want to add %d at %llu but only allowed %d - prepare to oops...\n",
+				       len, (unsigned long long)bio->bi_sector,  q->merge_bvec_fn(q, bio, bvec));
+			}
 			bvec->bv_page = NULL;
 			bvec->bv_len = 0;
 			bvec->bv_offset = 0;
