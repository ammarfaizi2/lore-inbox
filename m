Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266269AbRGLRGT>; Thu, 12 Jul 2001 13:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266271AbRGLRGL>; Thu, 12 Jul 2001 13:06:11 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:54008 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S266269AbRGLRF4>; Thu, 12 Jul 2001 13:05:56 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107121704.f6CH4d6j027383@webber.adilger.int>
Subject: Re: [lvm-devel] Re: 2x Oracle slowdown from 2.2.16 to 2.4.4
In-Reply-To: <20010712114512.J779@athlon.random> "from Andrea Arcangeli at Jul
 12, 2001 11:45:12 am"
To: Andrea Arcangeli <andrea@suse.de>
Date: Thu, 12 Jul 2001 11:04:39 -0600 (MDT)
CC: lvm-devel@sistina.com, Andi Kleen <ak@suse.de>,
        Lance Larsh <llarsh@oracle.com>,
        Brian Strand <bstrand@switchmanagement.com>,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea writes:
> > Wouldn't a single semaphore be enough BTW to cover both? 
> 
> Actually the _pe_lock is global and it's hold for a short time so it
> can make some sense. And if you look closely you'll see that _pe_lock
> should _definitely_ be a rw_spinlock not a rw_semaphore. I didn't
> changed that though just to keep the patch smaller and to avoid changing
> the semantics of the lock, the only thing that matters for us is to
> never block and to have a fast read fast path which is provided just
> fine by the rwsem (i'll left the s/sem/spinlock/ to the CVS).

Actually, I have already fixed the _pe_lock problem in LVM CVS, so that
it is not acquired on the fast path.  The cases where a PV is being moved
is very rare and only affects the write path, so I check rw == WRITE
and pe_lock_req.lock == LOCK_PE, before getting _pe_lock and re-checking
pe_lock_req.lock.  This does not affect the semantics of the operation.

Note also that the current kernel LVM code holds the _pe_lock for the
entire time it is flushing write requests from the queue, when it does
not need to do so.  My changes (also in LVM CVS) fix this as well.
I have attached the patch which should take beta7 to current CVS in
this regard.  Please take a look.

Note that your current patch is broken by the use of rwsems, because
_pe_lock also protects the _pe_requests list, which you modify under
up_read() (you can't upgrade a read lock to a write lock, AFAIK), so
you always need a write lock whenever you get _pe_lock.  With my changes
there will be very little contention on _pe_lock, as it is off the fast
path and only held for a few asm instructions at a time.

It is also a good thing that you fixed up lv_snapshot_sem, which was
also on the fast path, but at least that was a per-LV semaphore, unlike
_pe_lock which was global.  But I don't think you can complain about it,
because I think you were the one that added it ;-).

Note, how does this all apply to 2.2 kernels?  I don't think rwsems
existed then, nor rwspinlocks, did they?

Cheers, Andreas
======================  lvm-0.9.1b7-queue.diff ============================
diff -u -u -r1.7.2.96 lvm.c
--- kernel/lvm.c	2001/04/11 19:08:58	1.7.2.96
+++ kernel/lvm.c	2001/04/23 12:47:26
@@ -1267,29 +1271,30 @@
 		      rsector_map, stripe_length, stripe_index);
 	}
 
-	/* handle physical extents on the move */
-	down(&_pe_lock);
-	if((pe_lock_req.lock == LOCK_PE) &&
-	   (rdev_map == pe_lock_req.data.pv_dev) &&
-	   (rsector_map >= pe_lock_req.data.pv_offset) &&
-	   (rsector_map < (pe_lock_req.data.pv_offset + vg_this->pe_size)) &&
-#if LINUX_VERSION_CODE >= KERNEL_VERSION ( 2, 4, 0)
-	   (rw == WRITE)) {
-#else
-	   ((rw == WRITE) || (rw == WRITEA))) {
-#endif
-		_queue_io(bh, rw);
-		up(&_pe_lock);
-		up(&lv->lv_snapshot_sem);
-		return 0;
-	}
-	up(&_pe_lock);
+	/*
+	 * Queue writes to physical extents on the move until move completes.
+	 * Don't get _pe_lock until there is a reasonable expectation that
+	 * we need to queue this request, because this is in the fast path.
+	 */
+	if (rw == WRITE) {
+		if (pe_lock_req.lock == LOCK_PE) {
+			down(&_pe_lock);
+			if ((pe_lock_req.lock == LOCK_PE) &&
+			    (rdev_map == pe_lock_req.data.pv_dev) &&
+			    (rsector_map >= pe_lock_req.data.pv_offset) &&
+			    (rsector_map < (pe_lock_req.data.pv_offset +
+					    vg_this->pe_size))) {
+				_queue_io(bh, rw);
+				up(&_pe_lock);
+				up(&lv->lv_snapshot_sem);
+				return 0;
+			}
+			up(&_pe_lock);
+		}
 
-	/* statistic */
-	if (rw == WRITE || rw == WRITEA)
-		lv->lv_current_pe[index].writes++;
-	else
-		lv->lv_current_pe[index].reads++;
+		lv->lv_current_pe[index].writes++;	/* statistic */
+	} else
+		lv->lv_current_pe[index].reads++;	/* statistic */
 
 	/* snapshot volume exception handling on physical device
            address base */
@@ -1430,7 +1435,6 @@
 {
 	pe_lock_req_t new_lock;
 	struct buffer_head *bh;
-	int rw;
 	uint p;
 
 	if (vg_ptr == NULL) return -ENXIO;
@@ -1439,9 +1443,6 @@
 
 	switch (new_lock.lock) {
 	case LOCK_PE:
-		if(pe_lock_req.lock == LOCK_PE)
-			return -EBUSY;
-
 		for (p = 0; p < vg_ptr->pv_max; p++) {
 			if (vg_ptr->pv[p] != NULL &&
 			    new_lock.data.pv_dev == vg_ptr->pv[p]->pv_dev)
@@ -1449,16 +1450,18 @@
 		}
 		if (p == vg_ptr->pv_max) return -ENXIO;
 
-		pe_lock_req = new_lock;
-
-		down(&_pe_lock);
-		pe_lock_req.lock = UNLOCK_PE;
-		up(&_pe_lock);
-
 		fsync_dev(pe_lock_req.data.lv_dev);
 
 		down(&_pe_lock);
+		if (pe_lock_req.lock == LOCK_PE) {
+			up(&_pe_lock);
+			return -EBUSY;
+		}
+		/* Should we do to_kdev_t() on the pv_dev and lv_dev??? */
 		pe_lock_req.lock = LOCK_PE;
+		pe_lock_req.data.lv_dev = new_lock_req.data.lv_dev;
+		pe_lock_req.data.pv_dev = new_lock_req.data.pv_dev;
+		pe_lock_req.data.pv_offset = new_lock_req.data.pv_offset;
 		up(&_pe_lock);
 		break;
 
@@ -1468,17 +1471,11 @@
 		pe_lock_req.data.lv_dev = 0;
 		pe_lock_req.data.pv_dev = 0;
 		pe_lock_req.data.pv_offset = 0;
-		_dequeue_io(&bh, &rw);
+		bh = _dequeue_io();
 		up(&_pe_lock);
 
 		/* handle all deferred io for this PE */
-		while(bh) {
-			/* resubmit this buffer head */
-			generic_make_request(rw, bh);
-			down(&_pe_lock);
-			_dequeue_io(&bh, &rw);
-			up(&_pe_lock);
-		}
+		_flush_io(bh);
 		break;
 
 	default:
@@ -2814,12 +2836,22 @@
 	_pe_requests = bh;
 }
 
-static void _dequeue_io(struct buffer_head **bh, int *rw) {
-	*bh = _pe_requests;
-	*rw = WRITE;
-	if(_pe_requests) {
-		_pe_requests = _pe_requests->b_reqnext;
-		(*bh)->b_reqnext = 0;
+/* Must hold _pe_lock when we dequeue this list of buffers */
+static inline struct buffer_head *_dequeue_io(void)
+{
+	struct buffer_head *bh = _pe_requests;
+	_pe_requests = NULL;
+	return bh;
+}
+
+static inline void _flush_io(struct buffer_head *bh)
+{
+	while (bh) {
+		struct buffer_head *next = bh->b_reqnext;
+		bh->b_reqnext = 0;
+		/* resubmit this buffer head */
+		generic_make_request(WRITE, bh);
+		bh = next;
 	}
 }
 
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
