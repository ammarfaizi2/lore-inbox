Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288221AbSACGKt>; Thu, 3 Jan 2002 01:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288220AbSACGKj>; Thu, 3 Jan 2002 01:10:39 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:28576 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S288221AbSACGK0>; Thu, 3 Jan 2002 01:10:26 -0500
Date: Thu, 3 Jan 2002 08:06:53 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix loop BIO breakage (memory corruption)
Message-ID: <Pine.LNX.4.33.0201030803570.20656-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,
	I've tracked down what seems to be a case of array out of bounds.
Doing the following command "mount /dev/cdrom /cdrom -o loop" hard locks
my machine on 2.5.2-pre5 and no the BUG() check doesn't get displayed on
neither my serial console or the box's monitor. Now it all makes sense
that the BUG() check was triggered in 2.5.2-pre2 when we did indeed
spin_lock_init all the lo devices its because we were exceeding our array
limits! The only reason why mount /dev/fd0 /floppy -o loop doesn't trigger
this is because its minor is 0 whilst my cdrom's minor is 64. So we
weren't sending the loop device's minor but the underlying block device
due to the bio parameter we passed. Of course once this bug is fixed,
there still is the ll_rw_blk.c:1365 BUG too which hits straight afterwards
;)

Box: 192M UP with HIGHMEM(64G) SMP Kernel (spinlock debugging on)


Box: 192M UP with HIGHMEM(64G) SMP Kernel (spinlock debugging on)

loop.c:loop_init
<snip>
	for (i = 0; i < max_loop; i++) {
		struct loop_device *lo = &loop_dev[i];
		memset(lo, 0, sizeof(struct loop_device));
		<snip>
		lo->lo_number = i;
		spin_lock_init(&lo->lo_lock);
		printk(KERN_CRIT __FUNCTION__": lo=%p lo%d->lo_lock = {%d, %#x}\n", lo, lo->lo_number,
			lo->lo_lock.lock, lo->lo_lock.magic);
	}
<snip>

loop.c:loop_add_bio
<snip>
static void loop_add_bio(struct loop_device *lo, struct bio *bio)
{
	unsigned long flags;
	printk(KERN_CRIT __FUNCTION__": lo=%p\n", lo);
	spin_lock_irqsave(&lo->lo_lock, flags); <=== we'll send garbage
here
<snip>

loop.c
static int loop_end_io_transfer(struct bio *bio, int nr_sectors)
{
	struct loop_device *lo = &loop_dev[MINOR(bio->bi_dev)]; <=== XXX
	int uptodate = test_bit(BIO_UPTODATE, &bio->bi_flags);
	<snip>
	} else {
		printk(KERN_CRIT __FUNCTION__": lo=%p MINOR(bio->bi_dev)=%d\n", lo,
			MINOR(bio->bi_dev));
		for (i=0; i < max_loop; i++)
			printk(KERN_CRIT __FUNCTION__": &loop_dev[%d]=%p\n", i, &loop_dev[i]);
		loop_add_bio(lo, bio);
	}
	return 0;
}

[root@mondecino linux]#modprobe loop
loop_init: lo=cb6bd000 lo0->lo_lock = {1, 0xdead4ead}
loop_init: lo=cb6bd12c lo1->lo_lock = {1, 0xdead4ead}
loop_init: lo=cb6bd258 lo2->lo_lock = {1, 0xdead4ead}
loop_init: lo=cb6bd384 lo3->lo_lock = {1, 0xdead4ead}
loop_init: lo=cb6bd4b0 lo4->lo_lock = {1, 0xdead4ead}
loop_init: lo=cb6bd5dc lo5->lo_lock = {1, 0xdead4ead}
loop_init: lo=cb6bd708 lo6->lo_lock = {1, 0xdead4ead}
loop_init: lo=cb6bd834 lo7->lo_lock = {1, 0xdead4ead}

all looks good our locks are properly initialised. BUT....

[root@mondecino linux]# mount /dev/cdrom /cdrom -o loop
loop_end_io_transfer: lo=cb6c1b00 MINOR(bio->bi_dev)=64 <== wrong block
dev
loop_end_io_transfer: &loop_dev[0]=cb6bd000
loop_end_io_transfer: &loop_dev[1]=cb6bd12c
loop_end_io_transfer: &loop_dev[2]=cb6bd258
loop_end_io_transfer: &loop_dev[3]=cb6bd384
loop_end_io_transfer: &loop_dev[4]=cb6bd4b0
loop_end_io_transfer: &loop_dev[5]=cb6bd5dc
loop_end_io_transfer: &loop_dev[6]=cb6bd708
loop_end_io_transfer: &loop_dev[7]=cb6bd834
loop_add_bio: lo=cb6c1b00 <=== woah!! indexing loop_dev[64]!
<--BUG() check should be here-->
<---HARD Lock from here on no sysrq keys--->

Patch tested with read/write losetup type mounts, plain file backed mounts
and block backed mounts (these fail in ll_rw_blk:1365 BUG check now)

--- linux-2.5.2-pre5/drivers/block/loop.c.orig	Sun Dec 31 02:40:17 2000
+++ linux-2.5.2-pre5/drivers/block/loop.c	Sun Dec 31 02:05:59 2000
@@ -386,12 +386,11 @@
  */
 static int loop_end_io_transfer(struct bio *bio, int nr_sectors)
 {
-	struct loop_device *lo = &loop_dev[MINOR(bio->bi_dev)];
+	struct bio *rbh = bio->bi_private;
+	struct loop_device *lo = &loop_dev[MINOR(rbh->bi_dev)];
 	int uptodate = test_bit(BIO_UPTODATE, &bio->bi_flags);

 	if (!uptodate || bio_rw(bio) == WRITE) {
-		struct bio *rbh = bio->bi_private;
-
 		bio_endio(rbh, uptodate, nr_sectors);
 		if (atomic_dec_and_test(&lo->lo_pending))
 			up(&lo->lo_bh_mutex);




Oh and Happy New Year!!

Best Regards.
	Zwane Mwaikambo


