Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312916AbSCZBuv>; Mon, 25 Mar 2002 20:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312917AbSCZBud>; Mon, 25 Mar 2002 20:50:33 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:14527 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S312916AbSCZBuW>; Mon, 25 Mar 2002 20:50:22 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Paul.Clements@steeleye.com
Date: Tue, 26 Mar 2002 12:52:33 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15519.54369.994459.915024@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.18 raid1 - fix SMP locking/interrupt errors, fix
 resync  counter errors
In-Reply-To: message from Paul Clements on Monday March 25
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday March 25, kernel@steeleye.com wrote:
> Neil,
> 
> Thanks for your feedback. Replies below...
> 

ditto :-)

> > 
> > I can believe that there could be extra contention because of the dual
> > use of this spin lock.  Do you have lockmeter numbers at all?
> 
> No, I'm not familiar with that. How do I get those? Is it fairly
> simple?

I've never tried myself, so I don't know of simple it is.  The relevant
home page seems to be:
        http://oss.sgi.com/projects/lockmeter/

> 
> I wasn't so much concerned about extra contention as the (in my mind) 
> logical separation of these two different tasks, and the fact that 
> the lack of separation had led to a deadlock.
> 

Certainly these are logically distinct uses of the same lock, though
there are still closely related.
There is often a tension between splitting a lock to reduce
granularity and keeping the number of spinlocks to a minimum.
In general I would only split a lock if their was either a clear
semantic need, or measureable performance impact.

If a deadlock were a consequence of not splitting, that would be a
strong argument, but I think we can avoid the deadlock by other means.

> 
> > However I cannot see how it would cause a deadlock.  Could you please
> > give details?
> 
> raid1_diskop() calls close_sync() -- close_sync() schedules itself out
> to wait for pending I/O to quiesce so that the resync can end... 
> meanwhile #CPUs (in my case, 2) tasks enter into any of the memory 
> (de)allocation routines and spin on the device_lock forever...

Ahhhh.... Thanks....
close_sync() definately shouldn't be called with a spinlock held.  In
the patch below I have moved it out of the locked region.

> > You are definately right that we should not be calling kmalloc with a
> > spinlock held - my bad.
> > However I don't think your fix is ideal.  The relevant code is
> > "raid1_grow_buffers" which allocates a bunch of buffers and attaches
> > them to the device structure.
> > The lock is only realy needed for the attachment.  A better fix would
> > be to build a separate list, and then just claim the lock while
> > attaching that list to the structure.
> 
> Unfortunately, this won't work, because the segment_lock is also held
> while this code is executing (see raid1_sync_request).
> 

Good point, thanks.  I think this means that the call to
raid1_grow_buffers needs to be moved out from inside the locked
region.  This is done in the following patch.

>  
> > > 
> > > 3) incorrect enabling/disabling of interrupts during locking
> > > 
...
> > 
> > I don't believe that this is true.
> > The save/restore versions are only needed if the code might be called
> > from interrupt context.  However the routines where you made this
> > change: raid1_grow_buffers, raid1_shrink_buffers, close_sync, 
> > are only ever called from process context, with interrupts enabled.
> > Or am I missing something?
> 
> please see my other e-mail reply to Andrew Morton regarding this...

OK, I understand now.  spin_lock_irq is being called while
spin_lock_irq is already in-force.  I think this is best fixed by
moving calls outside of locked regions as mentioned above.


> 
>  
> > > 
> > > 4) incorrect setting of conf->cnt_future and conf->phase resync counters
> > > 
> > > The symptoms of this problem were that, if I/O was occurring when a
> > > resync ended (or was aborted), the resync would hang and never complete.
> > > This eventually would cause all I/O to the md device to hang.
> > 
> > I'll have to look at this one a bit more closely.  I'll let you know 
> > what I think of it.
> 
> OK. If you come up with something better, please let me know.

OK, I've had a look, and I see what the problem is:

	conf->start_future = mddev->sb->size+1;

start_future is in sectors.  sb->size is in Kibibytes :-(
Should be
	conf->start_future = (mddev->sb->size<<1)+1;

This error would explain your symptom.


Below is a patch which I believe should address all of your symptoms
and the bugs that they expose.  If your are able to test it and let me
know how it works for you I would appreciate it.

Thanks
NeilBrown



 ----------- Diffstat output ------------
 ./drivers/md/raid1.c |   54 +++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 40 insertions(+), 14 deletions(-)

--- ./drivers/md/raid1.c	2002/03/25 21:53:59	1.1
+++ ./drivers/md/raid1.c	2002/03/26 01:47:56	1.2
@@ -269,8 +269,9 @@
 static int raid1_grow_buffers (raid1_conf_t *conf, int cnt)
 {
 	int i = 0;
+	struct raid1_bh *head = NULL, **tail;
+	tail = &head;
 
-	md_spin_lock_irq(&conf->device_lock);
 	while (i < cnt) {
 		struct raid1_bh *r1_bh;
 		struct page *page;
@@ -287,10 +288,18 @@
 		memset(r1_bh, 0, sizeof(*r1_bh));
 		r1_bh->bh_req.b_page = page;
 		r1_bh->bh_req.b_data = page_address(page);
-		r1_bh->next_r1 = conf->freebuf;
-		conf->freebuf = r1_bh;
+		*tail = r1_bh;
+		r1_bh->next_r1 = NULL;
+		tail = & r1_bh->next_r1;
 		i++;
 	}
+	/* this lock probably isn't needed, as at the time when
+	 * we are allocating buffers, nobody else will be touching the
+	 * freebuf list.  But it doesn't hurt....
+	 */
+	md_spin_lock_irq(&conf->device_lock);
+	*tail = conf->freebuf;
+	conf->freebuf = head;
 	md_spin_unlock_irq(&conf->device_lock);
 	return i;
 }
@@ -825,7 +834,7 @@
 	conf->start_ready = conf->start_pending;
 	wait_event_lock_irq(conf->wait_ready, !conf->cnt_pending, conf->segment_lock);
 	conf->start_active =conf->start_ready = conf->start_pending = conf->start_future;
-	conf->start_future = mddev->sb->size+1;
+	conf->start_future = (mddev->sb->size<<1)+1;
 	conf->cnt_pending = conf->cnt_future;
 	conf->cnt_future = 0;
 	conf->phase = conf->phase ^1;
@@ -849,6 +858,14 @@
 	mdk_rdev_t *spare_rdev, *failed_rdev;
 
 	print_raid1_conf(conf);
+
+	switch (state) {
+	case DISKOP_SPARE_ACTIVE:
+	case DISKOP_SPARE_INACTIVE:
+		/* need to wait for pending sync io before locking device */
+		close_sync(conf);
+	}
+
 	md_spin_lock_irq(&conf->device_lock);
 	/*
 	 * find the disk ...
@@ -951,7 +968,11 @@
 	 * Deactivate a spare disk:
 	 */
 	case DISKOP_SPARE_INACTIVE:
-		close_sync(conf);
+		if (conf->start_future > 0) {
+			MD_BUG();
+			err = -EBUSY;
+			break;
+		}
 		sdisk = conf->mirrors + spare_disk;
 		sdisk->operational = 0;
 		sdisk->write_only = 0;
@@ -964,7 +985,11 @@
 	 * property)
 	 */
 	case DISKOP_SPARE_ACTIVE:
-		close_sync(conf);
+		if (conf->start_future > 0) {
+			MD_BUG();
+			err = -EBUSY;
+			break;
+		}
 		sdisk = conf->mirrors + spare_disk;
 		fdisk = conf->mirrors + failed_disk;
 
@@ -1328,23 +1353,25 @@
 	int bsize;
 	int disk;
 	int block_nr;
+	int buffs;
 
+	if (!sector_nr) {
+		/* we want enough buffers to hold twice the window of 128*/
+		buffs = 128 *2 / (PAGE_SIZE>>9);
+		buffs = raid1_grow_buffers(conf, buffs);
+		if (buffs < 2)
+			goto nomem;
+		conf->window = buffs*(PAGE_SIZE>>9)/2;
+	}
 	spin_lock_irq(&conf->segment_lock);
 	if (!sector_nr) {
 		/* initialize ...*/
-		int buffs;
 		conf->start_active = 0;
 		conf->start_ready = 0;
 		conf->start_pending = 0;
 		conf->start_future = 0;
 		conf->phase = 0;
-		/* we want enough buffers to hold twice the window of 128*/
-		buffs = 128 *2 / (PAGE_SIZE>>9);
-		buffs = raid1_grow_buffers(conf, buffs);
-		if (buffs < 2)
-			goto nomem;
 		
-		conf->window = buffs*(PAGE_SIZE>>9)/2;
 		conf->cnt_future += conf->cnt_done+conf->cnt_pending;
 		conf->cnt_done = conf->cnt_pending = 0;
 		if (conf->cnt_ready || conf->cnt_active)
@@ -1429,7 +1456,6 @@
 
 nomem:
 	raid1_shrink_buffers(conf);
-	spin_unlock_irq(&conf->segment_lock);
 	return -ENOMEM;
 }
 
