Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267478AbUIXASR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267478AbUIXASR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 20:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267566AbUIXAQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 20:16:18 -0400
Received: from ctb-mesg2.saix.net ([196.25.240.74]:61400 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S267612AbUIXAKJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 20:10:09 -0400
Subject: Re: [PATCH 2.6.9-rc2-mm1] Add missing del_timer_sync in
	ub_disconnect	(was Re: [2.6.9-rc2-mm1] BUG at kernel/timer.c:414) [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Sahara Workshop <workshop@cpt.sahara.co.za>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20040923130359.072f5109@lembas.zaitcev.lan>
References: <1095933627.9757.45.camel@workshop.saharacpt.lan>
	 <20040923031152.33ac4674.akpm@osdl.org>
	 <1095950199.15654.8.camel@workshop.saharacpt.lan>
	 <20040923081817.4c29519b@lembas.zaitcev.lan>
	 <1095967414.15654.53.camel@workshop.saharacpt.lan>
	 <20040923130359.072f5109@lembas.zaitcev.lan>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Ursn8mcgLZXR6UpPRQ84"
Date: Fri, 24 Sep 2004 02:09:19 +0200
Message-Id: <1095984559.13473.4.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Ursn8mcgLZXR6UpPRQ84
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-09-23 at 13:03 -0700, Pete Zaitcev wrote:
> On Thu, 23 Sep 2004 21:23:33 +0200
> Sahara Workshop <workshop@cpt.sahara.co.za> wrote:
>=20
> > Wild chance I am taking, but what about this (not tested):
>=20
> > @@ -849,6 +849,7 @@ static void ub_scsi_action(unsigned long
> >  	spin_lock_irqsave(&sc->lock, flags);
> >  	ub_scsi_dispatch(sc);
> >  	spin_unlock_irqrestore(&sc->lock, flags);
> > +	del_timer_sync(&sc->work_timer);
> >  }
>=20
> I'm not too sure about using del_timer_sync here. It does not sleep
> overtly, so it should be safe. But why bother. Please try the
> attached.
>=20
> -- Pete
>=20
> P.S. Can you do anything about those offensive disclaimers?
>=20
> diff -urp -X dontdiff linux-2.6.9-rc2-mm1/drivers/block/ub.c linux-2.6.9-=
rc2-mm1-ub/drivers/block/ub.c
> --- linux-2.6.9-rc2-mm1/drivers/block/ub.c	2004-09-17 23:04:27.000000000 =
-0700
> +++ linux-2.6.9-rc2-mm1-ub/drivers/block/ub.c	2004-09-23 10:39:03.4155487=
36 -0700
> @@ -25,6 +25,7 @@
>   *  -- prune comments, they are too volumnous
>   *  -- Exterminate P3 printks
>   *  -- Resove XXX's
> + *  -- Redo "benh's retries", perhaps have spin-up code to handle them. =
V:D=3D?
>   */
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -157,7 +158,8 @@ struct ub_scsi_cmd {
>  	struct ub_scsi_cmd *next;
> =20
>  	int error;			/* Return code - valid upon done */
> -	int act_len;			/* Return size */
> +	unsigned int act_len;		/* Return size */
> +	unsigned char key, asc, ascq;	/* May be valid if error=3D=3D-EIO */
> =20
>  	int stat_count;			/* Retries getting status. */
> =20
> @@ -673,9 +675,12 @@ static inline int ub_bd_rq_fn_1(request_
> =20
>  	/*
>  	 * build the command
> +	 *
> +	 * The call to blk_queue_hardsect_size() guarantees that request
> +	 * is aligned, but it is given in terms of 512 byte units, always.
>  	 */
> -	block =3D rq->sector;
> -	nblks =3D rq->nr_sectors;
> +	block =3D rq->sector >> sc->capacity.bshift;
> +	nblks =3D rq->nr_sectors >> sc->capacity.bshift;
> =20
>  	memset(cmd, 0, sizeof(struct ub_scsi_cmd));
>  	cmd->cdb[0] =3D (ub_dir =3D=3D UB_DIR_READ)? READ_10: WRITE_10;
> @@ -690,7 +695,7 @@ static inline int ub_bd_rq_fn_1(request_
>  	cmd->dir =3D ub_dir;
>  	cmd->state =3D UB_CMDST_INIT;
>  	cmd->data =3D rq->buffer;
> -	cmd->len =3D nblks * 512;
> +	cmd->len =3D rq->nr_sectors * 512;
>  	cmd->done =3D ub_rw_cmd_done;
>  	cmd->back =3D rq;
> =20
> @@ -837,6 +842,7 @@ static void ub_urb_complete(struct urb *
>  {
>  	struct ub_dev *sc =3D urb->context;
> =20
> +	del_timer(&sc->work_timer);
>  	ub_complete(&sc->work_done);
>  	tasklet_schedule(&sc->tasklet);
>  }
> @@ -1141,16 +1147,8 @@ static void ub_scsi_urb_compl(struct ub_
>  		(*cmd->done)(sc, cmd);
> =20
>  	} else if (cmd->state =3D=3D UB_CMDST_SENSE) {
> -		/*=20
> -		 * We do not look at sense, because even if there was no sense,
> -		 * we get into UB_CMDST_SENSE from a STALL or CSW FAIL only.
> -		 * We request sense because we want to clear CHECK CONDITION
> -		 * on devices with delusions of SCSI, and not because we
> -		 * are curious in any way about the sense itself.
> -		 */
> -		/* if ((cmd->top_sense[2] & 0x0F) =3D=3D NO_SENSE) { foo } */
> -
>  		ub_state_done(sc, cmd, -EIO);
> +
>  	} else {
>  		printk(KERN_WARNING "%s: "
>  		    "wrong command state %d on device %u\n",
> @@ -1309,6 +1307,10 @@ static void ub_top_sense_done(struct ub_
>  	 */
>  	ub_cmdtr_sense(sc, scmd, sense);
> =20
> +	/*
> +	 * Find the command which triggered the unit attention or a check,
> +	 * save the sense into it, and advance its state machine.
> +	 */
>  	if ((cmd =3D ub_cmdq_peek(sc)) =3D=3D NULL) {
>  		printk(KERN_WARNING "%s: sense done while idle\n", sc->name);
>  		return;
> @@ -1326,6 +1328,10 @@ static void ub_top_sense_done(struct ub_
>  		return;
>  	}
> =20
> +	cmd->key =3D sense[2] & 0x0F;
> +	cmd->asc =3D sense[12];
> +	cmd->ascq =3D sense[13];
> +
>  	ub_scsi_urb_compl(sc, cmd);
>  }
> =20
> @@ -1377,6 +1383,18 @@ static void ub_revalidate(struct ub_dev=20
>  	 * XXX sd.c sets capacity to zero in such case. However, it doesn't
>  	 * work for us. In case of zero capacity, block layer refuses to
>  	 * have the /dev/uba opened (why?) Set capacity to some random value.
> +
> +(4/14/2004 about 2.6.9-rc1-mm4)
> +<jejb> viro: actually because there was a check on size =3D=3D 0 before =
assigning f_ops so you can never open a zero size device to revalidate it
> +<viro> jejb: ah, I remember
> +<jejb> viro: I'm still seeing on scsi that I need to issue two BLKRRPART=
s to get the partition table read
> +<viro> jejb: there was a very odd API for issuing commands on absent dev=
ice
> +<viro> jejb: IIRC, cciss, ida or DAC960
> +<zaitcev> jejb: I had that problem with a zero size device which I "solv=
ed" by setting the size to some random number (50KB).
> +<hch> viro: DAC960 allowed to issue ioctls when opened with O_NONBLOCK
> +* viro really ought to dig out the 2.7 projects and do some triage
> +<jejb> zaitcev: yes, we do that in SCSI.  However, putting bogus sizes i=
n is rather silly
> +
>  	 */
>  	sc->capacity.nsec =3D 50;
>  	sc->capacity.bsize =3D 512;
> @@ -1519,7 +1537,7 @@ static int ub_bd_revalidate(struct gendi
>  	    sc->name, sc->dev->devnum, sc->capacity.nsec, sc->capacity.bsize);
> =20
>  	/* XXX Support sector size switching like in sr.c */
> -	// blk_queue_hardsect_size(q, sc->capacity.bsize);
> +	blk_queue_hardsect_size(disk->queue, sc->capacity.bsize);
>  	set_capacity(disk, sc->capacity.nsec);
>  	// set_disk_ro(sdkp->disk, sc->readonly);
> =20
> @@ -1621,6 +1639,9 @@ static int ub_sync_tur(struct ub_dev *sc
> =20
>  	rc =3D cmd->error;
> =20
> +	if (rc =3D=3D -EIO && cmd->key !=3D 0)	/* Retries for benh's key */
> +		rc =3D cmd->key;
> +
>  err_submit:
>  	kfree(cmd);
>  err_alloc:
> @@ -1836,6 +1857,7 @@ static int ub_probe(struct usb_interface
>  	request_queue_t *q;
>  	struct gendisk *disk;
>  	int rc;
> +	int i;
> =20
>  	rc =3D -ENOMEM;
>  	if ((sc =3D kmalloc(sizeof(struct ub_dev), GFP_KERNEL)) =3D=3D NULL)
> @@ -1902,7 +1924,11 @@ static int ub_probe(struct usb_interface
>  	 * has to succeed, so we clear checks with an additional one here.
>  	 * In any case it's not our business how revaliadation is implemented.
>  	 */
> -	ub_sync_tur(sc);
> +	for (i =3D 0; i < 3; i++) {	/* Retries for benh's key */
> +		if ((rc =3D ub_sync_tur(sc)) <=3D 0) break;
> +		if (rc !=3D 0x6) break;
> +		msleep(10);
> +	}
> =20
>  	sc->removable =3D 1;		/* XXX Query this from the device */
> =20
> @@ -1938,7 +1964,7 @@ static int ub_probe(struct usb_interface
>  	blk_queue_max_phys_segments(q, UB_MAX_REQ_SG);
>  	// blk_queue_segment_boundary(q, CARM_SG_BOUNDARY);
>  	blk_queue_max_sectors(q, UB_MAX_SECTORS);
> -	// blk_queue_hardsect_size(q, xxxxx);
> +	blk_queue_hardsect_size(q, sc->capacity.bsize);
> =20
>  	/*
>  	 * This is a serious infraction, caused by a deficiency in the
> @@ -2047,6 +2073,13 @@ static void ub_disconnect(struct usb_int
>  	spin_unlock_irqrestore(&sc->lock, flags);
> =20
>  	/*
> +	 * There is virtually no chance that other CPU runs times so long
> +	 * after ub_urb_complete should have called del_timer, but only if HCD
> +	 * didn't forget to deliver a callback on unlink.
> +	 */
> +	del_timer_sync(&sc->work_timer);
> +
> +	/*
>  	 * At this point there must be no commands coming from anyone
>  	 * and no URBs left in transit.
>  	 */

Seems to work fine here at home.  I will fiddle with it some more over
the weekend, but will only be back at work on Monday.


Thanks,

--=20
Martin Schlemmer

--=-Ursn8mcgLZXR6UpPRQ84
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBU2WvqburzKaJYLYRAmLgAJ9TBfrFC35+NUGVLtNtp9z22RWi8gCgm6g4
HtKje6lDpSvQI3SKuY4WjsQ=
=c7wc
-----END PGP SIGNATURE-----

--=-Ursn8mcgLZXR6UpPRQ84--

