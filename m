Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262028AbSI3Ltv>; Mon, 30 Sep 2002 07:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262029AbSI3Ltv>; Mon, 30 Sep 2002 07:49:51 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:15803 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262028AbSI3Ltq>;
	Mon, 30 Sep 2002 07:49:46 -0400
Date: Mon, 30 Sep 2002 13:54:21 +0200
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, james <jdickens@ameritech.net>,
       Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@pobox.com>,
       Larry Kessler <kessler@us.ibm.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Richard J Moore <richardj_moore@uk.ibm.com>
Subject: Re: v2.6 vs v3.0
Message-ID: <20020930115421.GA979@suse.de>
References: <20020930075625.GH1014@suse.de> <Pine.LNX.4.10.10209300235480.13669-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10209300235480.13669-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30 2002, Andre Hedrick wrote:
> On Mon, 30 Sep 2002, Jens Axboe wrote:
> 
> > On Sun, Sep 29 2002, Alan Cox wrote:
> > > On Sun, 2002-09-29 at 18:42, Linus Torvalds wrote:
> > > > I can say that the IDE code is the same code that is in 2.4.x, so if 
> > > > you're comfortable with 2.4.x wrt IDE, then you should be comfy with 
> > > > 2.5.x too.
> > > 
> > > *NO*
> > > 
> > > The IDE code is the experimental code in 2.4-ac. It is _NOT_ the IDE
> > > code in 2.4 and its a lot less tested. I don't think it has any
> > > corruption bugs but it is most definitely not the base 2.4 code and has
> > > plenty of non corruption bugs (PCMCIA hang, taskfile write hang, irq
> > > blocking performance problems)
> > 
> > 2.5 at least does not have the taskfile hang, because I killed taskfile
> > io.
> 
> Great :-/  Now that you have restored the "rq->wrq" aka working copy of

Make taskfile io work 2.4-ac, and it will work in 2.5 as well. The only
sensible thing to do right now was to disable it in 2.5, imo, and so I
did.

> the request which in its past life under PIO only updated to block when
> the entire request was completed.  So there are no partial completions
> possible given the old method in the legacy path.

I haven't restored anything. 2.4-ac (your base) uses ->wrq copy, so does
2.5.

> One of the issues Linus kick my can over was the "requirement" of partial
> completeions.  What I need rom block is a way to know how much is
> completed of the original total request.  So whatever value is the
> original rq->nr_sectors assigned to "TF.2/HF.2" or nsector_offset(s),
> needs to be carried in block and updated to reflect how much more is
> remaining of this CDB task.

Now that the block layer really can do partial completions properly, I
patched ide-disk to do just that. It's not very well tested, just did it
last week as proof-of-concept.

This breaks the typical offset rules, ie

current_segment_offset = rq->hard_cur_sectors - rq->current_nr_sectors;
total_offset = rq->hard_nr_sectors - rq->nr_sectors;

Haven't though too much about that yet.

> I do not care if you call it "rq->dumbass_accounting_for_andre", but
> provide this dummy accounting variable in "struct request" and I will be
> happy.  This has nothing to do with bio or bh segments from the kernel.
> It is everything about device side accounting carried by block; whereas,
> the ll_driver can use it to determine what or if there is to be another
> interrupt.

What you ask for is already there, but requires that you massage
current_nr_sectors and nr_sectors like ide has always done.

> Why are we getting lost interrupts?
> 
> Because there is a beautiful "data-block completion" v/s "immediate
> interrupt assertion" race between the device and the kernel.  So please
> provide a counter which can be used to determine where the interrupt
> driven partial completion model the driver is wrt the device/request.
> 
> Jens, not asking for much.

Indeed, you are asking for stuff we've had for years.

===== drivers/ide/ide-disk.c 1.16 vs edited =====
--- 1.16/drivers/ide/ide-disk.c	Sat Sep 21 02:32:22 2002
+++ edited/drivers/ide/ide-disk.c	Mon Sep 23 17:18:48 2002
@@ -139,8 +139,8 @@
  */
 static ide_startstop_t read_intr (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-	int i = 0, nsect	= 0, msect = drive->mult_count;
+	ide_hwif_t *hwif = HWIF(drive);
+	int nsect = 0, msect = drive->mult_count;
 	struct request *rq;
 	unsigned long flags;
 	u8 stat;
@@ -174,25 +174,24 @@
 		(unsigned long) rq->buffer+(nsect<<9), rq->nr_sectors-nsect);
 #endif
 	ide_unmap_buffer(rq, to, &flags);
-	rq->sector += nsect;
-	rq->errors = 0;
-	i = (rq->nr_sectors -= nsect);
-	if (((long)(rq->current_nr_sectors -= nsect)) <= 0)
-		ide_end_request(drive, 1, rq->hard_cur_sectors);
+
+	/*
+	 * all done
+	 */
+	if (!ide_end_request(drive, 1, nsect))
+		return ide_stopped;
+
 	/*
 	 * Another BH Page walker and DATA INTERGRITY Questioned on ERROR.
 	 * If passed back up on multimode read, BAD DATA could be ACKED
 	 * to FILE SYSTEMS above ...
 	 */
-	if (i > 0) {
-		if (msect)
-			goto read_next;
-		if (HWGROUP(drive)->handler != NULL)
-			BUG();
-		ide_set_handler(drive, &read_intr, WAIT_CMD, NULL);
-                return ide_started;
-	}
-        return ide_stopped;
+	if (msect)
+		goto read_next;
+	if (HWGROUP(drive)->handler != NULL)
+		BUG();
+	ide_set_handler(drive, &read_intr, WAIT_CMD, NULL);
+	return ide_started;
 }
 
 /*
@@ -203,7 +202,6 @@
 	ide_hwgroup_t *hwgroup	= HWGROUP(drive);
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct request *rq	= hwgroup->rq;
-	int i = 0;
 	u8 stat;
 
 	if (!OK_STAT(stat = hwif->INB(IDE_STATUS_REG),
@@ -217,23 +215,19 @@
 			rq->nr_sectors-1);
 #endif
 		if ((rq->nr_sectors == 1) ^ ((stat & DRQ_STAT) != 0)) {
-			rq->sector++;
-			rq->errors = 0;
-			i = --rq->nr_sectors;
-			--rq->current_nr_sectors;
-			if (((long)rq->current_nr_sectors) <= 0)
-				ide_end_request(drive, 1, rq->hard_cur_sectors);
-			if (i > 0) {
-				unsigned long flags;
-				char *to = ide_map_buffer(rq, &flags);
-				taskfile_output_data(drive, to, SECTOR_WORDS);
-				ide_unmap_buffer(rq, to, &flags);
-				if (HWGROUP(drive)->handler != NULL)
-					BUG();
-				ide_set_handler(drive, &write_intr, WAIT_CMD, NULL);
-                                return ide_started;
-			}
-                        return ide_stopped;
+			unsigned long flags;
+			char *to;
+
+			if (!ide_end_request(drive, 1, 1))
+				return ide_stopped;
+
+			to = ide_map_buffer(rq, &flags);
+			taskfile_output_data(drive, to, SECTOR_WORDS);
+			ide_unmap_buffer(rq, to, &flags);
+			if (HWGROUP(drive)->handler != NULL)
+				BUG();
+			ide_set_handler(drive, &write_intr, WAIT_CMD, NULL);
+			return ide_started;
 		}
 		/* the original code did this here (?) */
 		return ide_stopped;
===== drivers/ide/ide-taskfile.c 1.4 vs edited =====
--- 1.4/drivers/ide/ide-taskfile.c	Fri Sep 20 00:13:51 2002
+++ edited/drivers/ide/ide-taskfile.c	Mon Sep 23 17:04:47 2002
@@ -611,9 +611,8 @@
 	 * BH walking or segment can only be updated after we have a good
 	 * hwif->INB(IDE_STATUS_REG); return.
 	 */
-	if (--rq->current_nr_sectors <= 0)
-		if (!DRIVER(drive)->end_request(drive, 1, 0))
-			return ide_stopped;
+	if (!DRIVER(drive)->end_request(drive, 1, 1))
+		return ide_stopped;
 	/*
 	 * ERM, it is techincally legal to leave/exit here but it makes
 	 * a mess of the code ...
@@ -669,7 +668,6 @@
 		taskfile_input_data(drive, pBuf, nsect * SECTOR_WORDS);
 		task_unmap_rq(rq, pBuf, &flags);
 		rq->errors = 0;
-		rq->current_nr_sectors -= nsect;
 		msect -= nsect;
 		/*
 		 * FIXME :: We really can not legally get a new page/bh
@@ -677,10 +675,8 @@
 		 * BH walking or segment can only be updated after we have a
 		 * good hwif->INB(IDE_STATUS_REG); return.
 		 */
-		if (!rq->current_nr_sectors) {
-			if (!DRIVER(drive)->end_request(drive, 1, 0))
-				return ide_stopped;
-		}
+		if (!DRIVER(drive)->end_request(drive, 1, 1))
+			return ide_stopped;
 	} while (msect);
 	if (HWGROUP(drive)->handler == NULL)
 		ide_set_handler(drive, &task_mulin_intr, WAIT_WORSTCASE, NULL);
@@ -740,9 +736,9 @@
 	 * Safe to update request for partial completions.
 	 * We have a good STATUS CHECK!!!
 	 */
-	if (!rq->current_nr_sectors)
-		if (!DRIVER(drive)->end_request(drive, 1, 0))
-			return ide_stopped;
+	if (!DRIVER(drive)->end_request(drive, 1, 1))
+		return ide_stopped;
+
 	if ((rq->current_nr_sectors==1) ^ (stat & DRQ_STAT)) {
 		rq = HWGROUP(drive)->rq;
 		pBuf = task_map_rq(rq, &flags);
@@ -802,13 +798,10 @@
 		msect -= nsect;
 		taskfile_output_data(drive, pBuf, nsect * SECTOR_WORDS);
 		task_unmap_rq(rq, pBuf, &flags);
-		rq->current_nr_sectors -= nsect;
-		if (!rq->current_nr_sectors) {
-			if (!DRIVER(drive)->end_request(drive, 1, 0))
-				if (!rq->bio) {
-					stat = hwif->INB(IDE_STATUS_REG);
-					return ide_stopped;
-				}
+		if (!DRIVER(drive)->end_request(drive, 1, 1)) {
+			/* stat for...? */
+			stat = hwif->INB(IDE_STATUS_REG);
+			return ide_stopped;
 		}
 	} while (msect);
 	rq->errors = 0;
@@ -922,18 +915,14 @@
 		msect -= nsect;
 		taskfile_output_data(drive, pBuf, nsect * SECTOR_WORDS);
 		task_unmap_rq(rq, pBuf, &flags);
-		rq->current_nr_sectors -= nsect;
 		/*
 		 * FIXME :: We really can not legally get a new page/bh
 		 * regardless, if this is the end of our segment.
 		 * BH walking or segment can only be updated after we
 		 * have a good  hwif->INB(IDE_STATUS_REG); return.
 		 */
-		if (!rq->current_nr_sectors) {
-			if (!DRIVER(drive)->end_request(drive, 1, 0))
-				if (!rq->bio)
-					return ide_stopped;
-		}
+		if (!DRIVER(drive)->end_request(drive, 1, 1))
+			return ide_stopped;
 	} while (msect);
 	rq->errors = 0;
 	if (HWGROUP(drive)->handler == NULL)

-- 
Jens Axboe

