Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265369AbSKEXhp>; Tue, 5 Nov 2002 18:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265362AbSKEXhp>; Tue, 5 Nov 2002 18:37:45 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:55251 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S265361AbSKEXhj>; Tue, 5 Nov 2002 18:37:39 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: David Mansfield <lkml@dm.cobite.com>, Jens Axboe <axboe@suse.de>
Date: Wed, 6 Nov 2002 10:43:55 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15816.22459.739536.572418@notabene.cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [BUG] raw over raid5: BUG at drivers/block/ll_rw_blk.c:1967
In-Reply-To: message from Neil Brown on Tuesday October 15
References: <Pine.LNX.4.44.0210141627360.2876-100000@admin>
	<15787.47236.823202.578662@notabene.cse.unsw.edu.au>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday October 15, neilb@cse.unsw.edu.au wrote:
> On Monday October 14, lkml@dm.cobite.com wrote:
> > 
> > Hi everyone,
> > 
> > I haven't been able to run raw over raid5 since 2.5.30 or so, but every
> > time I'm about to report it, a new kernel comes out and the problem
> > changes completely :-( Now I'm finally going to start getting out the info
> > it the hopes someone can fix it.  The oops was triggered by attempting to 
> > read from /dev/raw/raw1 (bound to /dev/md0) using dd.  System info 
> > follows oops:
> > 
> > ------------[ cut here ]------------
> > kernel BUG at drivers/block/ll_rw_blk.c:1967!
> > invalid operand: 0000
> >  
> 
> You are not alone in reporting this BUG...
> 
> I blame the Scsi/bio  layer.
> Jens Axboe blames raid5.
> :-)
> 

Just for the record, Jens was right. :-)
Here is the patch which will be winging it's way to Linus shortly.

NeilBrown
-----------------------------
Fix bug in raid5

When analysing a stripe in handle_stripe we set bits
 R5_Wantread or R5_Wantwrite
to indicate if a read or write is needed.  We don't actually schedule the
IO immediately as this is done under a spinlock (sh->lock) and 
generic_make_request can block.  Instead we check these bits after
the lock has been lifted and then schedule the IO.

But once the lock has been lifted we aren't safe against multiple
access, and it is possible that the IO will be scheduled never, or twice.

So, we use test_and_clear to check and potentially schedule the IO.

This wasn't a problem in 2.4 because the equivalent information was
stored on the stack instead of in the stripe.

We also make sure bi_io_vec[0] has correct values as a previous
call to generic_make_request may have changed them.

 ----------- Diffstat output ------------
 ./drivers/md/raid5.c |   92 +++++++++++++++++++++++++++------------------------
 1 file changed, 51 insertions(+), 43 deletions(-)

--- ./drivers/md/raid5.c	2002/11/05 23:31:25	1.1
+++ ./drivers/md/raid5.c	2002/11/05 23:39:15	1.2
@@ -851,8 +851,6 @@ static void handle_stripe(struct stripe_
 	for (i=disks; i--; ) {
 		mdk_rdev_t *rdev;
 		dev = &sh->dev[i];
-		clear_bit(R5_Wantread, &dev->flags);
-		clear_bit(R5_Wantwrite, &dev->flags);
 		clear_bit(R5_Insync, &dev->flags);
 		clear_bit(R5_Syncio, &dev->flags);
 
@@ -1160,48 +1158,56 @@ static void handle_stripe(struct stripe_
 		bi->bi_size = 0;
 		bi->bi_end_io(bi, bytes, 0);
 	}
-	for (i=disks; i-- ;) 
-		if (sh->dev[i].flags & ((1<<R5_Wantwrite)|(1<<R5_Wantread))) {
-			struct bio *bi = &sh->dev[i].req;
-			mdk_rdev_t *rdev ;
-
-			bi->bi_rw = 0;
-			if (test_bit(R5_Wantread, &sh->dev[i].flags))
-				bi->bi_end_io = raid5_end_read_request;
-			else {
-				bi->bi_end_io = raid5_end_write_request;
-				bi->bi_rw = 1;
-			}
-
-			spin_lock_irq(&conf->device_lock);
-			rdev = conf->disks[i].rdev;
-			if (rdev && rdev->faulty)
-				rdev = NULL;
-			if (rdev)
-				atomic_inc(&rdev->nr_pending);
-			spin_unlock_irq(&conf->device_lock);
-
-			if (rdev) {
-				if (test_bit(R5_Syncio, &sh->dev[i].flags))
-					md_sync_acct(rdev, STRIPE_SECTORS);
-
-				bi->bi_bdev = rdev->bdev;
-				PRINTK("for %llu schedule op %ld on disc %d\n", (unsigned long long)sh->sector, bi->bi_rw, i);
-				atomic_inc(&sh->count);
-				bi->bi_sector = sh->sector;
-				bi->bi_flags = 1 << BIO_UPTODATE;
-				bi->bi_vcnt = 1;	
-				bi->bi_idx = 0;
-				bi->bi_io_vec = &sh->dev[i].vec;
-				bi->bi_size = STRIPE_SIZE;
-				bi->bi_next = NULL;
-				generic_make_request(bi);
-			} else {
-				PRINTK("skip op %ld on disc %d for sector %llu\n", bi->bi_rw, i, (unsigned long long)sh->sector);
-				clear_bit(R5_LOCKED, &dev->flags);
-				set_bit(STRIPE_HANDLE, &sh->state);
-			}
+	for (i=disks; i-- ;) {
+		int rw;
+		struct bio *bi;
+		mdk_rdev_t *rdev;
+		if (test_and_clear_bit(R5_Wantwrite, &sh->dev[i].flags))
+			rw = 1;
+		else if (test_and_clear_bit(R5_Wantread, &sh->dev[i].flags))
+			rw = 0;
+		else
+			continue;
+ 
+		bi = &sh->dev[i].req;
+ 
+		bi->bi_rw = rw;
+		if (rw)
+			bi->bi_end_io = raid5_end_write_request;
+		else
+			bi->bi_end_io = raid5_end_read_request;
+ 
+		spin_lock_irq(&conf->device_lock);
+		rdev = conf->disks[i].rdev;
+		if (rdev && rdev->faulty)
+			rdev = NULL;
+		if (rdev)
+			atomic_inc(&rdev->nr_pending);
+		spin_unlock_irq(&conf->device_lock);
+ 
+		if (rdev) {
+			if (test_bit(R5_Syncio, &sh->dev[i].flags))
+				md_sync_acct(rdev, STRIPE_SECTORS);
+
+			bi->bi_bdev = rdev->bdev;
+			PRINTK("for %llu schedule op %ld on disc %d\n", (unsigned long long)sh->sector, bi->bi_rw, i);
+			atomic_inc(&sh->count);
+			bi->bi_sector = sh->sector;
+			bi->bi_flags = 1 << BIO_UPTODATE;
+			bi->bi_vcnt = 1;	
+			bi->bi_idx = 0;
+			bi->bi_io_vec = &sh->dev[i].vec;
+			bi->bi_io_vec[0].bv_len = STRIPE_SIZE;
+			bi->bi_io_vec[0].bv_offset = 0;
+			bi->bi_size = STRIPE_SIZE;
+			bi->bi_next = NULL;
+			generic_make_request(bi);
+		} else {
+			PRINTK("skip op %ld on disc %d for sector %llu\n", bi->bi_rw, i, (unsigned long long)sh->sector);
+			clear_bit(R5_LOCKED, &dev->flags);
+			set_bit(STRIPE_HANDLE, &sh->state);
 		}
+	}
 }
 
 static inline void raid5_activate_delayed(raid5_conf_t *conf)
