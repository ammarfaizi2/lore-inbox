Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266218AbSKUA3q>; Wed, 20 Nov 2002 19:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266224AbSKUA3q>; Wed, 20 Nov 2002 19:29:46 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:63400 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S266218AbSKUA3n>; Wed, 20 Nov 2002 19:29:43 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: =?iso-8859-1?Q?Thorbj=F8rn_Lind?= <mtl@slowbone.net>
Date: Thu, 21 Nov 2002 11:36:25 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15836.10889.114478.779210@notabene.cse.unsw.edu.au>
Cc: "Andrew Morton" <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.5.48-bk, md raid0 fix
In-Reply-To: message from =?ISO-8859-1?Q?Thorbj=F8rn?= Lind on Wednesday November 20
References: <3DDAE54F.4010808@slowbone.net>
	<3DDB353F.33D826C8@digeo.com>
	<009101c29067$d470f900$0201a8c0@mtl>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday November 20, mtl@slowbone.net wrote:
> > The mod operator on a 64-bit quantity won't work with
> > CONFIG_LBD=y, will it?
> 
> Ohh.. there is such a thing.. let's use & :)
> 

Here is my version which does the 'right' thing w.r.t. large sector
addresses etc.

I just sent it to Linus for the third time.  Hopefully it wont be
dropped again :-(

NeilBrown
--------------------------------------------------------
Fix *_mergeable_bvec routines for linear/raid0.

They take the length of the passed bvec into account, which is wrong.



 ----------- Diffstat output ------------
 ./drivers/md/linear.c |    7 ++-----
 ./drivers/md/raid0.c  |   16 ++++++++--------
 2 files changed, 10 insertions(+), 13 deletions(-)

diff ./drivers/md/linear.c~current~ ./drivers/md/linear.c
--- ./drivers/md/linear.c~current~	2002-11-21 09:41:47.000000000 +1100
+++ ./drivers/md/linear.c	2002-11-21 09:41:47.000000000 +1100
@@ -58,15 +58,12 @@ static int linear_mergeable_bvec(request
 {
 	mddev_t *mddev = q->queuedata;
 	dev_info_t *dev0;
-	int maxsectors, bio_sectors = (bio->bi_size + biovec->bv_len) >> 9;
+	unsigned long maxsectors, bio_sectors = bio->bi_size >> 9;
 
 	dev0 = which_dev(mddev, bio->bi_sector);
 	maxsectors = (dev0->size << 1) - (bio->bi_sector - (dev0->offset<<1));
 
-	if (bio_sectors <= maxsectors)
-		return biovec->bv_len;
-
-	return (maxsectors << 9) - bio->bi_size;
+	return (maxsectors - bio_sectors) << 9;
 }
 
 static int linear_run (mddev_t *mddev)

diff ./drivers/md/raid0.c~current~ ./drivers/md/raid0.c
--- ./drivers/md/raid0.c~current~	2002-11-21 09:41:47.000000000 +1100
+++ ./drivers/md/raid0.c	2002-11-21 09:41:47.000000000 +1100
@@ -173,15 +173,15 @@ static int create_strip_zones (mddev_t *
 static int raid0_mergeable_bvec(request_queue_t *q, struct bio *bio, struct bio_vec *biovec)
 {
 	mddev_t *mddev = q->queuedata;
-	sector_t block;
-	unsigned int chunk_size;
-	unsigned int bio_sz;
+	sector_t sector;
+	unsigned int chunk_sectors;
+	unsigned int bio_sectors;
+
+	chunk_sectors = mddev->chunk_size >> 9;
+	sector = bio->bi_sector;
+	bio_sectors = bio->bi_size >> 9;
 
-	chunk_size = mddev->chunk_size >> 10;
-	block = bio->bi_sector >> 1;
-	bio_sz = (bio->bi_size + biovec->bv_len) >> 10;
-
-	return (chunk_size - ((block & (chunk_size - 1)) + bio_sz)) << 10;
+	return (chunk_sectors - ((sector & (chunk_sectors - 1)) + bio_sectors)) << 9;
 }
 
 static int raid0_run (mddev_t *mddev)
