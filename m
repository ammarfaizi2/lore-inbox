Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVEAAPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVEAAPG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 20:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVEAAPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 20:15:06 -0400
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:10898 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261477AbVEAAOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 20:14:55 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [ck] 2.6.11-ck6
Date: Sun, 1 May 2005 10:14:56 +1000
User-Agent: KMail/1.8
Cc: ck@vds.kolivas.org,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200505010017.36907.kernel@kolivas.org> <20050430201321.GA8147@suse.de>
In-Reply-To: <20050430201321.GA8147@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1236941.CYrVtbJzWn";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505011014.58883.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1236941.CYrVtbJzWn
Content-Type: multipart/mixed;
  boundary="Boundary-01=_B+BdCfJG2b1R8b8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_B+BdCfJG2b1R8b8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sun, 1 May 2005 06:13, Jens Axboe wrote:
> On Sun, May 01 2005, Con Kolivas wrote:
> > +scsi-dead-device.diff
> > A fix for a scsi related hang that seems to hit many -ck users
>
> This looks strange, like a fix and a half. You should just apply the
> patch I sent you originally, weeks ago, changing sdev->sdev_lock to
> &q->__queue_lock.

rarrgh

Thanks for keeping an eye out on for this. Unfortunately you sent more than=
=20
one patch at different times and it looks like I included the wrong one the=
n?=20
This is the patch I (tried to) include.

Con

--Boundary-01=_B+BdCfJG2b1R8b8
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="scsi-dead-device"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="scsi-dead-device"

=3D=3D=3D=3D=3D drivers/scsi/scsi_lib.c 1.151 vs edited =3D=3D=3D=3D=3D
=2D-- 1.151/drivers/scsi/scsi_lib.c	2005-02-17 20:17:22 +01:00
+++ edited/drivers/scsi/scsi_lib.c	2005-03-18 12:33:09 +01:00
@@ -1233,6 +1233,22 @@ static inline int scsi_host_queue_ready(
 }
=20
 /*
+ * Kill requests for a dead device
+ */
+static void scsi_kill_requests(request_queue_t *q)
+{
+	struct request *req;
+
+	while ((req =3D elv_next_request(q)) !=3D NULL) {
+		blkdev_dequeue_request(req);
+		req->flags |=3D REQ_QUIET;
+		while (end_that_request_first(req, 0, req->nr_sectors))
+			;
+		end_that_request_last(req);
+	}
+}
+
+/*
  * Function:    scsi_request_fn()
  *
  * Purpose:     Main strategy routine for SCSI.
@@ -1246,10 +1262,16 @@ static inline int scsi_host_queue_ready(
 static void scsi_request_fn(struct request_queue *q)
 {
 	struct scsi_device *sdev =3D q->queuedata;
=2D	struct Scsi_Host *shost =3D sdev->host;
+	struct Scsi_Host *shost;
 	struct scsi_cmnd *cmd;
 	struct request *req;
=20
+	if (!sdev) {
+		printk("scsi: killing requests for dead queue\n");
+		scsi_kill_requests(q);
+		return;
+	}
+
 	if(!get_device(&sdev->sdev_gendev))
 		/* We must be tearing the block queue down already */
 		return;
@@ -1258,6 +1280,7 @@ static void scsi_request_fn(struct reque
 	 * To start with, we keep looping until the queue is empty, or until
 	 * the host is no longer able to accept any more requests.
 	 */
+	shost =3D sdev->host;
 	while (!blk_queue_plugged(q)) {
 		int rtn;
 		/*
=3D=3D=3D=3D=3D drivers/scsi/scsi_sysfs.c 1.69 vs edited =3D=3D=3D=3D=3D
=2D-- 1.69/drivers/scsi/scsi_sysfs.c	2005-02-17 02:05:37 +01:00
+++ edited/drivers/scsi/scsi_sysfs.c	2005-03-18 12:32:57 +01:00
@@ -168,8 +168,10 @@ void scsi_device_dev_release(struct devi
 	list_del(&sdev->starved_entry);
 	spin_unlock_irqrestore(sdev->host->host_lock, flags);
=20
=2D	if (sdev->request_queue)
+	if (sdev->request_queue) {
+		sdev->request_queue->queuedata =3D NULL;
 		scsi_free_queue(sdev->request_queue);
+	}
=20
 	scsi_target_reap(scsi_target(sdev));
=20

--Boundary-01=_B+BdCfJG2b1R8b8--

--nextPart1236941.CYrVtbJzWn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCdB+CZUg7+tp6mRURAo+eAJ457UIbOYTVGa1YjHwG4uTAoK+oAgCcDrNl
ncTAruQGUnJeqKNRtOH9zos=
=7Lcp
-----END PGP SIGNATURE-----

--nextPart1236941.CYrVtbJzWn--
