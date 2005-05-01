Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVEAAdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVEAAdL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 20:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVEAAdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 20:33:11 -0400
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:38607 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261480AbVEAAc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 20:32:58 -0400
From: Con Kolivas <kernel@kolivas.org>
To: ck@vds.kolivas.org
Subject: Re: [ck] 2.6.11-ck6
Date: Sun, 1 May 2005 10:33:05 +1000
User-Agent: KMail/1.8
Cc: Jens Axboe <axboe@suse.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200505010017.36907.kernel@kolivas.org> <20050430201321.GA8147@suse.de> <200505011014.58883.kernel@kolivas.org>
In-Reply-To: <200505011014.58883.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1858050.FiNhfb3j2m";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505011033.07086.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1858050.FiNhfb3j2m
Content-Type: multipart/mixed;
  boundary="Boundary-01=_BPCdCf+qzVzVshc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_BPCdCf+qzVzVshc
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sun, 1 May 2005 10:14, Con Kolivas wrote:
> On Sun, 1 May 2005 06:13, Jens Axboe wrote:
> > On Sun, May 01 2005, Con Kolivas wrote:
> > > +scsi-dead-device.diff
> > > A fix for a scsi related hang that seems to hit many -ck users
> >
> > This looks strange, like a fix and a half. You should just apply the
> > patch I sent you originally, weeks ago, changing sdev->sdev_lock to
> > &q->__queue_lock.
>
> rarrgh
>
> Thanks for keeping an eye out on for this. Unfortunately you sent more th=
an
> one patch at different times and it looks like I included the wrong one
> then? This is the patch I (tried to) include.

I guess from your description this was the one I should have included... Lo=
oks=20
like a ck7 should come out instead since that other patch was more likely=20
harmful than not :\

Con

--Boundary-01=_BPCdCf+qzVzVshc
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="2.6.11-ck-scsifix.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="2.6.11-ck-scsifix.diff"

=3D=3D=3D=3D=3D drivers/block/ll_rw_blk.c 1.288 vs edited =3D=3D=3D=3D=3D
=2D-- 1.288/drivers/block/ll_rw_blk.c	2005-03-31 12:47:54 +02:00
+++ edited/drivers/block/ll_rw_blk.c	2005-04-07 08:38:01 +02:00
@@ -1714,6 +1711,15 @@ request_queue_t *blk_init_queue(request_
 	if (blk_init_free_list(q))
 		goto out_init;
=20
+	/*
+	 * if caller didn't supply a lock, they get per-queue locking with
+	 * our embedded lock
+	 */
+	if (!lock) {
+		spin_lock_init(&q->__queue_lock);
+		lock =3D &q->__queue_lock;
+	}
+
 	q->request_fn		=3D rfn;
 	q->back_merge_fn       	=3D ll_back_merge_fn;
 	q->front_merge_fn      	=3D ll_front_merge_fn;
=3D=3D=3D=3D=3D drivers/scsi/scsi_lib.c 1.153 vs edited =3D=3D=3D=3D=3D
=2D-- 1.153/drivers/scsi/scsi_lib.c	2005-03-30 21:49:45 +02:00
+++ edited/drivers/scsi/scsi_lib.c	2005-04-07 08:42:30 +02:00
@@ -360,9 +360,9 @@ void scsi_device_unbusy(struct scsi_devi
 		     shost->host_failed))
 		scsi_eh_wakeup(shost);
 	spin_unlock(shost->host_lock);
=2D	spin_lock(&sdev->sdev_lock);
+	spin_lock(sdev->request_queue->queue_lock);
 	sdev->device_busy--;
=2D	spin_unlock_irqrestore(&sdev->sdev_lock, flags);
+	spin_unlock_irqrestore(sdev->request_queue->queue_lock, flags);
 }
=20
 /*
@@ -1425,7 +1425,7 @@ struct request_queue *scsi_alloc_queue(s
 	struct Scsi_Host *shost =3D sdev->host;
 	struct request_queue *q;
=20
=2D	q =3D blk_init_queue(scsi_request_fn, &sdev->sdev_lock);
+	q =3D blk_init_queue(scsi_request_fn, NULL);
 	if (!q)
 		return NULL;
=20
=3D=3D=3D=3D=3D drivers/scsi/scsi_scan.c 1.143 vs edited =3D=3D=3D=3D=3D
=2D-- 1.143/drivers/scsi/scsi_scan.c	2005-03-23 22:58:13 +01:00
+++ edited/drivers/scsi/scsi_scan.c	2005-04-07 08:40:53 +02:00
@@ -249,7 +249,6 @@ static struct scsi_device *scsi_alloc_sd
 	 */
 	sdev->borken =3D 1;
=20
=2D	spin_lock_init(&sdev->sdev_lock);
 	sdev->request_queue =3D scsi_alloc_queue(sdev);
 	if (!sdev->request_queue) {
 		/* release fn is set up in scsi_sysfs_device_initialise, so
=3D=3D=3D=3D=3D include/linux/blkdev.h 1.162 vs edited =3D=3D=3D=3D=3D
=2D-- 1.162/include/linux/blkdev.h	2005-03-29 03:42:37 +02:00
+++ edited/include/linux/blkdev.h	2005-04-07 08:36:06 +02:00
@@ -355,8 +364,11 @@ struct request_queue
 	unsigned long		queue_flags;
=20
 	/*
=2D	 * protects queue structures from reentrancy
+	 * protects queue structures from reentrancy. ->__queue_lock should
+	 * _never_ be used directly, it is queue private. always use
+	 * ->queue_lock.
 	 */
+	spinlock_t		__queue_lock;
 	spinlock_t		*queue_lock;
=20
 	/*
=3D=3D=3D=3D=3D include/scsi/scsi_device.h 1.33 vs edited =3D=3D=3D=3D=3D
=2D-- 1.33/include/scsi/scsi_device.h	2005-03-23 22:58:05 +01:00
+++ edited/include/scsi/scsi_device.h	2005-04-07 08:41:09 +02:00
@@ -44,7 +44,6 @@ struct scsi_device {
 	struct list_head    same_target_siblings; /* just the devices sharing sam=
e target id */
=20
 	volatile unsigned short device_busy;	/* commands actually active on low-l=
evel */
=2D	spinlock_t sdev_lock;           /* also the request queue_lock */
 	spinlock_t list_lock;
 	struct list_head cmd_list;	/* queue of in use SCSI Command structures */
 	struct list_head starved_entry;




--Boundary-01=_BPCdCf+qzVzVshc--

--nextPart1858050.FiNhfb3j2m
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCdCPDZUg7+tp6mRURAq8TAJ4njYgHnmxGKH3+UfvYPaQIVKhxqwCaAuhp
kcuo0PvIILDHyACAdUpT1X8=
=uLZP
-----END PGP SIGNATURE-----

--nextPart1858050.FiNhfb3j2m--
