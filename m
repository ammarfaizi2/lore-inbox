Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312790AbSCVSbd>; Fri, 22 Mar 2002 13:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312793AbSCVSbL>; Fri, 22 Mar 2002 13:31:11 -0500
Received: from stat8.steeleye.com ([63.113.59.41]:40965 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id <S312790AbSCVSaJ>; Fri, 22 Mar 2002 13:30:09 -0500
Message-ID: <3C9B77D8.ACD68643@SteelEye.com>
Date: Fri, 22 Mar 2002 13:28:40 -0500
From: Paul Clements <Paul.Clements@SteelEye.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: neilb@cse.unsw.edu.au, marcelo@conectiva.com.br
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.18 raid1 - fix SMP locking/interrupt errors, fix resync 
 counter errors
Content-Type: multipart/mixed;
 boundary="------------E4C96339DC1BB78C0950FEFF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E4C96339DC1BB78C0950FEFF
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


The following patch addresses several critical problems in the raid1
driver. Please apply. We've tested these patches pretty thoroughly
against the 2.4.9-21 Red Hat kernel. The source for raid1 is nearly
identical from 2.4.9-21 to 2.4.18. The patch is against 2.4.18. If you
have any questions, concerns, or comments, please send them to me.

Thanks,
Paul

--
Paul Clements
SteelEye Technology
Paul.Clements@SteelEye.com
--

The problems are, briefly:

1) overuse of device_lock spin lock 

The device_lock was being used for two separate, unrelated purposes.
This was causing too much contention and caused a deadlock in one case.
The device_lock will be split into two separate locks by introducing a
new spin lock, "memory_lock".

2) non-atomic memory allocation

Due to use of GFP_KERNEL rather than GFP_ATOMIC, certain threads of the
raid1 driver were scheduled out while holding a spin lock, causing a
deadlock to occur. Memory allocation during critical sections where a
spin lock is held will be changed to atomic allocations.

3) incorrect enabling/disabling of interrupts during locking

In several cases, the wrong spin_lock* macros were being used. There
were a few cases where the irqsave/irqrestore versions of the macros
were needed, but were not used. The symptom of these problems was that
interrupts were enabled or disabled at inappropriate times, resulting in
deadlocks.

4) incorrect setting of conf->cnt_future and conf->phase resync counters

The symptoms of this problem were that, if I/O was occurring when a
resync ended (or was aborted), the resync would hang and never complete.
This eventually would cause all I/O to the md device to hang.
--------------E4C96339DC1BB78C0950FEFF
Content-Type: text/plain; charset=iso-8859-1;
 name="raid1_2_4_18_official_patch.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="raid1_2_4_18_official_patch.diff"

diff -urN linux-2.4.18.PRISTINE/drivers/md/raid1.c linux-2.4.18/drivers/m=
d/raid1.c
--- linux-2.4.18.PRISTINE/drivers/md/raid1.c	Fri Mar 22 12:53:32 2002
+++ linux-2.4.18/drivers/md/raid1.c	Fri Mar 22 13:05:05 2002
@@ -11,6 +11,8 @@
  *
  * Fixes to reconstruction by Jakob =D8stergaard" <jakob@ostenfeld.dk>
  * Various fixes by Neil Brown <neilb@cse.unsw.edu.au>
+ * Various fixes by Paul Clements <Paul.Clements@SteelEye.com> and
+ *                  James Bottomley <James.Bottomley@SteelEye.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -64,7 +66,7 @@
 =

 	while(cnt) {
 		struct buffer_head *t;
-		md_spin_lock_irq(&conf->device_lock);
+		md_spin_lock_irq(&conf->memory_lock);
 		if (!conf->freebh_blocked && conf->freebh_cnt >=3D cnt)
 			while (cnt) {
 				t =3D conf->freebh;
@@ -75,7 +77,7 @@
 				conf->freebh_cnt--;
 				cnt--;
 			}
-		md_spin_unlock_irq(&conf->device_lock);
+		md_spin_unlock_irq(&conf->memory_lock);
 		if (cnt =3D=3D 0)
 			break;
 		t =3D kmem_cache_alloc(bh_cachep, SLAB_NOIO);
@@ -98,7 +100,7 @@
 static inline void raid1_free_bh(raid1_conf_t *conf, struct buffer_head =
*bh)
 {
 	unsigned long flags;
-	spin_lock_irqsave(&conf->device_lock, flags);
+	spin_lock_irqsave(&conf->memory_lock, flags);
 	while (bh) {
 		struct buffer_head *t =3D bh;
 		bh=3Dbh->b_next;
@@ -110,7 +112,7 @@
 			conf->freebh_cnt++;
 		}
 	}
-	spin_unlock_irqrestore(&conf->device_lock, flags);
+	spin_unlock_irqrestore(&conf->memory_lock, flags);
 	wake_up(&conf->wait_buffer);
 }
 =

@@ -124,12 +126,12 @@
 		bh =3D kmem_cache_alloc(bh_cachep, SLAB_KERNEL);
 		if (!bh) break;
 =

-		md_spin_lock_irq(&conf->device_lock);
+		md_spin_lock_irq(&conf->memory_lock);
 		bh->b_pprev =3D &conf->freebh;
 		bh->b_next =3D conf->freebh;
 		conf->freebh =3D bh;
 		conf->freebh_cnt++;
-		md_spin_unlock_irq(&conf->device_lock);
+		md_spin_unlock_irq(&conf->memory_lock);
 =

 		i++;
 	}
@@ -140,14 +142,14 @@
 {
 	/* discard all buffer_heads */
 =

-	md_spin_lock_irq(&conf->device_lock);
+	md_spin_lock_irq(&conf->memory_lock);
 	while (conf->freebh) {
 		struct buffer_head *bh =3D conf->freebh;
 		conf->freebh =3D bh->b_next;
 		kmem_cache_free(bh_cachep, bh);
 		conf->freebh_cnt--;
 	}
-	md_spin_unlock_irq(&conf->device_lock);
+	md_spin_unlock_irq(&conf->memory_lock);
 }
 		=

 =

@@ -156,7 +158,7 @@
 	struct raid1_bh *r1_bh =3D NULL;
 =

 	do {
-		md_spin_lock_irq(&conf->device_lock);
+		md_spin_lock_irq(&conf->memory_lock);
 		if (!conf->freer1_blocked && conf->freer1) {
 			r1_bh =3D conf->freer1;
 			conf->freer1 =3D r1_bh->next_r1;
@@ -165,7 +167,7 @@
 			r1_bh->state =3D (1 << R1BH_PreAlloc);
 			r1_bh->bh_req.b_state =3D 0;
 		}
-		md_spin_unlock_irq(&conf->device_lock);
+		md_spin_unlock_irq(&conf->memory_lock);
 		if (r1_bh)
 			return r1_bh;
 		r1_bh =3D (struct raid1_bh *) kmalloc(sizeof(struct raid1_bh), GFP_NOI=
O);
@@ -191,11 +193,11 @@
 =

 	if (test_bit(R1BH_PreAlloc, &r1_bh->state)) {
 		unsigned long flags;
-		spin_lock_irqsave(&conf->device_lock, flags);
+		spin_lock_irqsave(&conf->memory_lock, flags);
 		r1_bh->next_r1 =3D conf->freer1;
 		conf->freer1 =3D r1_bh;
 		conf->freer1_cnt++;
-		spin_unlock_irqrestore(&conf->device_lock, flags);
+		spin_unlock_irqrestore(&conf->memory_lock, flags);
 		/* don't need to wakeup wait_buffer because
 		 *  raid1_free_bh below will do that
 		 */
@@ -226,14 +228,14 @@
 =

 static void raid1_shrink_r1bh(raid1_conf_t *conf)
 {
-	md_spin_lock_irq(&conf->device_lock);
+	md_spin_lock_irq(&conf->memory_lock);
 	while (conf->freer1) {
 		struct raid1_bh *r1_bh =3D conf->freer1;
 		conf->freer1 =3D r1_bh->next_r1;
 		conf->freer1_cnt--;
 		kfree(r1_bh);
 	}
-	md_spin_unlock_irq(&conf->device_lock);
+	md_spin_unlock_irq(&conf->memory_lock);
 }
 =

 =

@@ -245,10 +247,10 @@
 	raid1_conf_t *conf =3D mddev_to_conf(r1_bh->mddev);
 	r1_bh->mirror_bh_list =3D NULL;
 	=

-	spin_lock_irqsave(&conf->device_lock, flags);
+	spin_lock_irqsave(&conf->memory_lock, flags);
 	r1_bh->next_r1 =3D conf->freebuf;
 	conf->freebuf =3D r1_bh;
-	spin_unlock_irqrestore(&conf->device_lock, flags);
+	spin_unlock_irqrestore(&conf->memory_lock, flags);
 	raid1_free_bh(conf, bh);
 }
 =

@@ -256,12 +258,12 @@
 {
 	struct raid1_bh *r1_bh;
 =

-	md_spin_lock_irq(&conf->device_lock);
-	wait_event_lock_irq(conf->wait_buffer, conf->freebuf, conf->device_lock=
);
+	md_spin_lock_irq(&conf->memory_lock);
+	wait_event_lock_irq(conf->wait_buffer, conf->freebuf, conf->memory_lock=
);
 	r1_bh =3D conf->freebuf;
 	conf->freebuf =3D r1_bh->next_r1;
 	r1_bh->next_r1=3D NULL;
-	md_spin_unlock_irq(&conf->device_lock);
+	md_spin_unlock_irq(&conf->memory_lock);
 =

 	return r1_bh;
 }
@@ -269,17 +271,18 @@
 static int raid1_grow_buffers (raid1_conf_t *conf, int cnt)
 {
 	int i =3D 0;
+	unsigned long flags;
 =

-	md_spin_lock_irq(&conf->device_lock);
+	md_spin_lock_irqsave(&conf->memory_lock, flags);
 	while (i < cnt) {
 		struct raid1_bh *r1_bh;
 		struct page *page;
 =

-		page =3D alloc_page(GFP_KERNEL);
+		page =3D alloc_page(GFP_ATOMIC);
 		if (!page)
 			break;
 =

-		r1_bh =3D (struct raid1_bh *) kmalloc(sizeof(*r1_bh), GFP_KERNEL);
+		r1_bh =3D (struct raid1_bh *) kmalloc(sizeof(*r1_bh), GFP_ATOMIC);
 		if (!r1_bh) {
 			__free_page(page);
 			break;
@@ -291,20 +294,21 @@
 		conf->freebuf =3D r1_bh;
 		i++;
 	}
-	md_spin_unlock_irq(&conf->device_lock);
+	md_spin_unlock_irqrestore(&conf->memory_lock, flags);
 	return i;
 }
 =

 static void raid1_shrink_buffers (raid1_conf_t *conf)
 {
-	md_spin_lock_irq(&conf->device_lock);
+	unsigned long flags;
+	md_spin_lock_irqsave(&conf->memory_lock, flags);
 	while (conf->freebuf) {
 		struct raid1_bh *r1_bh =3D conf->freebuf;
 		conf->freebuf =3D r1_bh->next_r1;
 		__free_page(r1_bh->bh_req.b_page);
 		kfree(r1_bh);
 	}
-	md_spin_unlock_irq(&conf->device_lock);
+	md_spin_unlock_irqrestore(&conf->memory_lock, flags);
 }
 =

 static int raid1_map (mddev_t *mddev, kdev_t *rdev)
@@ -723,7 +727,7 @@
 =

 #define DISK_FAILED KERN_ALERT \
 "raid1: Disk failure on %s, disabling device. \n" \
-"	Operation continuing on %d devices\n"
+"        Operation continuing on %d devices\n"
 =

 #define START_SYNCING KERN_ALERT \
 "raid1: start syncing spare disk.\n"
@@ -815,26 +819,33 @@
 static void close_sync(raid1_conf_t *conf)
 {
 	mddev_t *mddev =3D conf->mddev;
+	unsigned long flags;
 	/* If reconstruction was interrupted, we need to close the "active" and=
 "pending"
 	 * holes.
 	 * we know that there are no active rebuild requests, os cnt_active =3D=
=3D cnt_ready =3D=3D0
 	 */
 	/* this is really needed when recovery stops too... */
-	spin_lock_irq(&conf->segment_lock);
+	spin_lock_irqsave(&conf->segment_lock, flags);
 	conf->start_active =3D conf->start_pending;
 	conf->start_ready =3D conf->start_pending;
 	wait_event_lock_irq(conf->wait_ready, !conf->cnt_pending, conf->segment=
_lock);
-	conf->start_active =3Dconf->start_ready =3D conf->start_pending =3D con=
f->start_future;
-	conf->start_future =3D mddev->sb->size+1;
-	conf->cnt_pending =3D conf->cnt_future;
-	conf->cnt_future =3D 0;
-	conf->phase =3D conf->phase ^1;
-	wait_event_lock_irq(conf->wait_ready, !conf->cnt_pending, conf->segment=
_lock);
+	/* have to be careful here - we want phase to go to 0 (although,
+	 * this isn't really necessary since it's just a toggle) - but we
+	 * cannot be sure of the current phase value */
+	if (conf->phase) {
+		/* close the future window and wait for pending I/O to finish */
+		conf->start_active =3D conf->start_ready =3D conf->start_pending =3D c=
onf->start_future;
+		conf->start_future =3D mddev->sb->size+1;
+		conf->cnt_pending =3D conf->cnt_future;
+		conf->cnt_future =3D 0;
+		conf->phase =3D conf->phase ^1;
+		wait_event_lock_irq(conf->wait_ready, !conf->cnt_pending, conf->segmen=
t_lock);
+	}
+	/* open the future window across the whole device, closing the others *=
/
 	conf->start_active =3D conf->start_ready =3D conf->start_pending =3D co=
nf->start_future =3D 0;
-	conf->phase =3D 0;
-	conf->cnt_future =3D conf->cnt_done;;
+	conf->cnt_future +=3D conf->cnt_done;
 	conf->cnt_done =3D 0;
-	spin_unlock_irq(&conf->segment_lock);
+	spin_unlock_irqrestore(&conf->segment_lock, flags);
 	wake_up(&conf->wait_done);
 }
 =

@@ -1347,6 +1358,7 @@
 		conf->window =3D buffs*(PAGE_SIZE>>9)/2;
 		conf->cnt_future +=3D conf->cnt_done+conf->cnt_pending;
 		conf->cnt_done =3D conf->cnt_pending =3D 0;
+		wake_up(&conf->wait_ready);
 		if (conf->cnt_ready || conf->cnt_active)
 			MD_BUG();
 	}
@@ -1614,7 +1626,7 @@
 	conf->nr_disks =3D sb->nr_disks;
 	conf->mddev =3D mddev;
 	conf->device_lock =3D MD_SPIN_LOCK_UNLOCKED;
-
+	conf->memory_lock =3D MD_SPIN_LOCK_UNLOCKED;
 	conf->segment_lock =3D MD_SPIN_LOCK_UNLOCKED;
 	init_waitqueue_head(&conf->wait_buffer);
 	init_waitqueue_head(&conf->wait_done);
diff -urN linux-2.4.18.PRISTINE/include/linux/raid/raid1.h linux-2.4.18/i=
nclude/linux/raid/raid1.h
--- linux-2.4.18.PRISTINE/include/linux/raid/raid1.h	Sun Aug 12 15:39:02 =
2001
+++ linux-2.4.18/include/linux/raid/raid1.h	Fri Mar 22 13:03:53 2002
@@ -33,6 +33,9 @@
 	int			resync_mirrors;
 	struct mirror_info	*spare;
 	md_spinlock_t		device_lock;
+	md_spinlock_t		memory_lock;/* use this to protect =

+					     * memory (de)allocations instead
+					     * of using the device_lock */
 =

 	/* buffer pool */
 	/* buffer_heads that we have pre-allocated have b_pprev -> &freebh

--------------E4C96339DC1BB78C0950FEFF--

