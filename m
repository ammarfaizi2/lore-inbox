Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264704AbSIWJaD>; Mon, 23 Sep 2002 05:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265259AbSIWJaC>; Mon, 23 Sep 2002 05:30:02 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:45704 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264704AbSIWJaB>;
	Mon, 23 Sep 2002 05:30:01 -0400
Date: Mon, 23 Sep 2002 11:35:00 +0200
From: Jens Axboe <axboe@suse.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pdc4030.c doesn't compile in 2.5.38
Message-ID: <20020923093500.GC25682@suse.de>
References: <Pine.NEB.4.44.0209221522290.18211-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.NEB.4.44.0209221522290.18211-100000@mimas.fachschaften.tu-muenchen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22 2002, Adrian Bunk wrote:
> 
> FYI:
> 
> <--  snip  -->
> 
> ...
>   gcc -Wp,-MD,./.pdc4030.o.d -D__KERNEL__
> -I/home/bunk/linux/kernel-2.5/linux-2.5.38-full/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=k6 -I/home/bunk/linux/kernel-2.5/linux-2.5.38-full/arch/i386/mach-generic
> -nostdinc -iwithprefix include  -I../  -DKBUILD_BASENAME=pdc4030   -c -o
> pdc4030.o pdc4030.c
> pdc4030.c: In function `promise_read_intr':
> pdc4030.c:465: too few arguments to function
> pdc4030.c: In function `promise_complete_pollfunc':
> pdc4030.c:542: too few arguments to function
> pdc4030.c: In function `promise_multwrite':
> pdc4030.c:587: structure has no member named `bh'
> pdc4030.c:593: structure has no member named `bh'
> pdc4030.c:594: dereferencing pointer to incomplete type
> pdc4030.c:596: dereferencing pointer to incomplete type
> pdc4030.c: In function `do_pdc4030_io':
> pdc4030.c:738: switch quantity not an integer
> pdc4030.c:793: warning: int format, pointer arg (arg 3)
> pdc4030.c:794: too few arguments to function
> pdc4030.c:741: warning: unreachable code at beginning of switch statement
> make[3]: *** [pdc4030.o] Error 1
> make[3]: Leaving directory `/home/bunk/linux/kernel-2.5/linux-2.5.38-full/drivers/ide/legacy'

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.600   -> 1.601  
#	drivers/ide/legacy/pdc4030.c	1.3     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/23	axboe@burns.home.kernel.dk	1.601
# make pdc4030 work
# --------------------------------------------
#
diff -Nru a/drivers/ide/legacy/pdc4030.c b/drivers/ide/legacy/pdc4030.c
--- a/drivers/ide/legacy/pdc4030.c	Mon Sep 23 11:34:33 2002
+++ b/drivers/ide/legacy/pdc4030.c	Mon Sep 23 11:34:33 2002
@@ -462,7 +462,7 @@
 	rq->nr_sectors -= nsect;
 	total_remaining = rq->nr_sectors;
 	if ((rq->current_nr_sectors -= nsect) <= 0) {
-		DRIVER(drive)->end_request(drive, 1);
+		DRIVER(drive)->end_request(drive, 1, 0);
 	}
 /*
  * Now the data has been read in, do the following:
@@ -539,7 +539,7 @@
 #endif /* DEBUG_WRITE */
 	for (i = rq->nr_sectors; i > 0; ) {
 		i -= rq->current_nr_sectors;
-		DRIVER(drive)->end_request(drive, 1);
+		DRIVER(drive)->end_request(drive, 1, 0);
 	}
 	return ide_stopped;
 }
@@ -584,16 +584,24 @@
 
 		/* Do we move to the next bh after this? */
 		if (!rq->current_nr_sectors) {
-			struct buffer_head *bh = rq->bh->b_reqnext;
+			struct bio *bio = rq->bio;
+
+			/*
+			 * only move to next bio, when we have processed
+			 * all bvecs in this one.
+			 */
+			if (++bio->bi_idx >= bio->bi_vcnt) {
+				bio->bi_idx = 0;
+				bio = bio->bi_next;
+			}
 
 			/* end early early we ran out of requests */
-			if (!bh) {
+			if (!bio) {
 				mcount = 0;
 			} else {
-				rq->bh			= bh;
-				rq->current_nr_sectors	= bh->b_size >> 9;
+				rq->bio = bio;
+				rq->current_nr_sectors = bio_iovec(bio)->bv_len >> 9;
 				rq->hard_cur_sectors = rq->current_nr_sectors;
-				rq->buffer		= bh->b_data;
 			}
 		}
 
@@ -720,6 +728,12 @@
 	unsigned long timeout;
 	u8 stat = 0;
 
+	if (!blk_fs_request(rq)) {
+		blk_dump_rq_flags(rq, "do_pdc4030_io - bad command");
+		DRIVER(drive)->end_request(drive, 0, 0);
+		return ide_stopped;
+	}
+
 #ifdef CONFIG_IDE_TASKFILE_IO
 	if (IDE_CONTROL_REG)
 		HWIF(drive)->OUTB(drive->ctl, IDE_CONTROL_REG);	/* clear nIEN */
@@ -735,8 +749,7 @@
 	HWIF(drive)->OUTB(taskfile->command, IDE_COMMAND_REG);
 #endif /* CONFIG_IDE_TASKFILE_IO */
 
-	switch(rq->cmd) {
-	case READ:
+	if (rq_data_dir(rq) == READ) {
 #ifndef CONFIG_IDE_TASKFILE_IO
 		HWIF(drive)->OUTB(PROMISE_READ, IDE_COMMAND_REG);
 #endif /* CONFIG_IDE_TASKFILE_IO */
@@ -774,7 +787,7 @@
 		printk(KERN_ERR "%s: reading: No DRQ and not "
 				"waiting - Odd!\n", drive->name);
 		return ide_stopped;
-	case WRITE:
+	} else {
 #ifndef CONFIG_IDE_TASKFILE_IO
 		HWIF(drive)->OUTB(PROMISE_WRITE, IDE_COMMAND_REG);
 #endif /* CONFIG_IDE_TASKFILE_IO */
@@ -788,11 +801,6 @@
 			local_irq_disable();
 		HWGROUP(drive)->wrq = *rq; /* scratchpad */
 		return promise_write(drive);
-	default:
-		printk("KERN_WARNING %s: bad command: %d\n",
-			drive->name, rq->cmd);
-		DRIVER(drive)->end_request(drive, 0);
-		return ide_stopped;
 	}
 }
 

-- 
Jens Axboe

