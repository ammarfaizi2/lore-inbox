Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318169AbSIAXjW>; Sun, 1 Sep 2002 19:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318166AbSIAXjW>; Sun, 1 Sep 2002 19:39:22 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:52440 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S318165AbSIAXjU>; Sun, 1 Sep 2002 19:39:20 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>
Date: Mon, 2 Sep 2002 09:43:33 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15730.42533.481161.627180@notabene.cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: PATCH - change to blkdev->queue calling triggers BUG in md.c
X-Mailer: VM 7.07 under Emacs 21.2.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Changeset 1.573 (just prior to 2.5.33 release) changed the calling
sequence for blk_dev[major].queue so that it is now called before the 
bd_op->open function is called.
This triggers a BUG in md.c which checked that the device was open
whenever ->queue was called.  Patch below removes the BUG.

I'm actually a little disappointed by this change.  I was hoping that
the ->queue might get changed to be passed a 'struct block_device *'
instead of a 'kdev_t' so that the device driver would only have to
interpret the device number in one place: the open.  But now that
->queue is called before ->open, that wouldn't help.

I don't suppose it would make sense to do the default:
	if (!bdev->bd_queue) {
		struct blk_dev_struct *p = blk_dev + major(dev);
		bdev->bd_queue = &p->request_queue;
	}
bit where it is now, and leave the:
		if (p->queue)
			bdev->bd_queue =  p->queue(dev);

bit until after the open?  It would keep floppy happy, and make me
happy too, but I'm not sure that it is actually 'right'...

Anyway, here is the patch that stops md from BUGging out.

NeilBrown

### Comments for ChangeSet
Remove BUG in md.c that change in 2.5.33 triggers.

Since 2.5.33, the blk_dev[].queue is called without
the device open, so md_queue_proc can no-longer assume
that the device is open.


 ----------- Diffstat output ------------
 ./drivers/md/md.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

--- ./drivers/md/md.c	2002/09/01 23:27:10	1.1
+++ ./drivers/md/md.c	2002/09/01 23:28:27	1.2
@@ -3157,11 +3157,11 @@ request_queue_t * md_queue_proc(kdev_t d
 {
 	mddev_t *mddev = mddev_find(minor(dev));
 	request_queue_t *q = BLK_DEFAULT_QUEUE(MAJOR_NR);
-	if (!mddev || atomic_read(&mddev->active)<2)
-		BUG();
-	if (mddev->pers)
-		q = &mddev->queue;
-	mddev_put(mddev); /* the caller must hold a reference... */
+	if (mddev) {
+		if (mddev->pers)
+			q = &mddev->queue;
+		mddev_put(mddev);
+	}
 	return q;
 }
 
