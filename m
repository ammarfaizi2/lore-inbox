Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbUDKAKa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 20:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUDKAK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 20:10:29 -0400
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:56976 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S262175AbUDKAKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 20:10:11 -0400
Date: Sat, 10 Apr 2004 17:09:57 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: stern@rowland.harvard.edu, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org,
       USB Storage List <usb-storage@lists.one-eyed-alien.net>
Subject: Re: [linux-usb-devel] Patch for usb-storage in 2.4
Message-ID: <20040411000957.GA7523@one-eyed-alien.net>
Mail-Followup-To: Pete Zaitcev <zaitcev@redhat.com>,
	stern@rowland.harvard.edu, linux-usb-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	USB Storage List <usb-storage@lists.one-eyed-alien.net>
References: <20040409195943.0dac2f5a.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <20040409195943.0dac2f5a.zaitcev@redhat.com>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Off the cuff, this doesn't look bad... tho it does a lot.

The reordering of locking in device_reset and bus reset definately looks
good, especially for the corner-cases (yanked device, etc.).

I'm uncertain if your handling of the io_request_lock is right.... but
getting information on how to handle that has been like pulling teeth, so
I'm inclined to trust your wide-scale testing on this.

Was there a reason to add more do-nothing code to host_reset?

Is it really safe to remove the irq_urb_sem?

Also, please make sure everything is CC'ed to the usb-storage list (on this
message).

Matt

On Fri, Apr 09, 2004 at 07:59:43PM -0700, Pete Zaitcev wrote:
> Guys,
>=20
> this works dandy for us in RHL and RHEL, *especially* on bigger SMP boxes.
> It does not fix all the bugs in that code, but I consider it a good start,
> and unless someone speaks up, it goes to Marcelo after 2.4.26 is out.
> Or maybe before, depending how long it takes him to release 2.4.26.
> Please review, test, etc.
>=20
> I am working on two new bugs in usb-storage right now, but I'd like
> to have things going in gradually, in self-contained chunks, Viro style.
> Those two are not fixed yet anyway.
>=20
> -- Pete
>=20
> diff -urN -X dontdiff linux-2.4.26-rc2/drivers/usb/storage/scsiglue.c lin=
ux-2.4.26-rc2-nip/drivers/usb/storage/scsiglue.c
> --- linux-2.4.26-rc2/drivers/usb/storage/scsiglue.c	2004-04-09 17:28:30.0=
00000000 -0700
> +++ linux-2.4.26-rc2-nip/drivers/usb/storage/scsiglue.c	2004-04-09 17:31:=
44.000000000 -0700
> @@ -218,7 +218,14 @@
>  	US_DEBUGP("device_reset() called\n" );
> =20
>  	spin_unlock_irq(&io_request_lock);
> +	down(&(us->dev_semaphore));
> +	if (!us->pusb_dev) {
> +		up(&(us->dev_semaphore));
> +		spin_lock_irq(&io_request_lock);
> +		return SUCCESS;
> +	}
>  	rc =3D us->transport_reset(us);
> +	up(&(us->dev_semaphore));
>  	spin_lock_irq(&io_request_lock);
>  	return rc;
>  }
> @@ -235,27 +242,32 @@
>  	/* we use the usb_reset_device() function to handle this for us */
>  	US_DEBUGP("bus_reset() called\n");
> =20
> +	spin_unlock_irq(&io_request_lock);
> +
> +	down(&(us->dev_semaphore));
> +
>  	/* if the device has been removed, this worked */
>  	if (!us->pusb_dev) {
>  		US_DEBUGP("-- device removed already\n");
> +		up(&(us->dev_semaphore));
> +		spin_lock_irq(&io_request_lock);
>  		return SUCCESS;
>  	}
> =20
> -	spin_unlock_irq(&io_request_lock);
> -
>  	/* release the IRQ, if we have one */
> -	down(&(us->irq_urb_sem));
>  	if (us->irq_urb) {
>  		US_DEBUGP("-- releasing irq URB\n");
>  		result =3D usb_unlink_urb(us->irq_urb);
>  		US_DEBUGP("-- usb_unlink_urb() returned %d\n", result);
>  	}
> -	up(&(us->irq_urb_sem));
> =20
>  	/* attempt to reset the port */
>  	if (usb_reset_device(us->pusb_dev) < 0) {
> -		spin_lock_irq(&io_request_lock);
> -		return FAILED;
> +		/*
> +		 * Do not return errors, or else the error handler might
> +		 * invoke host_reset, which is not implemented.
> +		 */
> +		goto bail_out;
>  	}
> =20
>  	/* FIXME: This needs to lock out driver probing while it's working
> @@ -286,28 +298,36 @@
>  		up(&intf->driver->serialize);
>  	}
> =20
> +bail_out:
>  	/* re-allocate the IRQ URB and submit it to restore connectivity
>  	 * for CBI devices
>  	 */
>  	if (us->protocol =3D=3D US_PR_CBI) {
> -		down(&(us->irq_urb_sem));
>  		us->irq_urb->dev =3D us->pusb_dev;
>  		result =3D usb_submit_urb(us->irq_urb);
>  		US_DEBUGP("usb_submit_urb() returns %d\n", result);
> -		up(&(us->irq_urb_sem));
>  	}
> -=09
> +
> +	up(&(us->dev_semaphore));
> +
>  	spin_lock_irq(&io_request_lock);
> =20
>  	US_DEBUGP("bus_reset() complete\n");
>  	return SUCCESS;
>  }
> =20
> -/* FIXME: This doesn't do anything right now */
>  static int host_reset( Scsi_Cmnd *srb )
>  {
> -	printk(KERN_CRIT "usb-storage: host_reset() requested but not implement=
ed\n" );
> -	return FAILED;
> +	struct us_data *us =3D (struct us_data *)srb->host->hostdata[0];
> +
> +	spin_unlock_irq(&io_request_lock);
> +	down(&(us->dev_semaphore));
> +        printk(KERN_CRIT "usb-storage: host_reset() requested but hardly=
 implemented\n" );
> +	up(&(us->dev_semaphore));
> +	spin_lock_irq(&io_request_lock);
> +	US_DEBUGP("host_reset() complete\n");
> +
> +	return SUCCESS;
>  }
> =20
>  /***********************************************************************
> diff -urN -X dontdiff linux-2.4.26-rc2/drivers/usb/storage/usb.c linux-2.=
4.26-rc2-nip/drivers/usb/storage/usb.c
> --- linux-2.4.26-rc2/drivers/usb/storage/usb.c	2004-02-26 14:09:59.000000=
000 -0800
> +++ linux-2.4.26-rc2-nip/drivers/usb/storage/usb.c	2004-04-09 17:31:45.00=
0000000 -0700
> @@ -501,6 +501,9 @@
>   * strucuture is current.  This includes the ep_int field, which gives us
>   * the endpoint for the interrupt.
>   * Returns non-zero on failure, zero on success
> + *
> + * ss->dev_semaphore is expected taken, except for a newly minted,
> + * unregistered device.
>   */=20
>  static int usb_stor_allocate_irq(struct us_data *ss)
>  {
> @@ -510,13 +513,9 @@
> =20
>  	US_DEBUGP("Allocating IRQ for CBI transport\n");
> =20
> -	/* lock access to the data structure */
> -	down(&(ss->irq_urb_sem));
> -
>  	/* allocate the URB */
>  	ss->irq_urb =3D usb_alloc_urb(0);
>  	if (!ss->irq_urb) {
> -		up(&(ss->irq_urb_sem));
>  		US_DEBUGP("couldn't allocate interrupt URB");
>  		return 1;
>  	}
> @@ -537,12 +536,9 @@
>  	US_DEBUGP("usb_submit_urb() returns %d\n", result);
>  	if (result) {
>  		usb_free_urb(ss->irq_urb);
> -		up(&(ss->irq_urb_sem));
>  		return 2;
>  	}
> =20
> -	/* unlock the data structure and return success */
> -	up(&(ss->irq_urb_sem));
>  	return 0;
>  }
> =20
> @@ -772,7 +768,6 @@
>  		init_completion(&(ss->notify));
>  		init_MUTEX_LOCKED(&(ss->ip_waitq));
>  		spin_lock_init(&(ss->queue_exclusion));
> -		init_MUTEX(&(ss->irq_urb_sem));
>  		init_MUTEX(&(ss->current_urb_sem));
>  		init_MUTEX(&(ss->dev_semaphore));
> =20
> @@ -1063,7 +1058,6 @@
>  	down(&(ss->dev_semaphore));
> =20
>  	/* release the IRQ, if we have one */
> -	down(&(ss->irq_urb_sem));
>  	if (ss->irq_urb) {
>  		US_DEBUGP("-- releasing irq URB\n");
>  		result =3D usb_unlink_urb(ss->irq_urb);
> @@ -1071,7 +1065,6 @@
>  		usb_free_urb(ss->irq_urb);
>  		ss->irq_urb =3D NULL;
>  	}
> -	up(&(ss->irq_urb_sem));
> =20
>  	/* free up the main URB for this device */
>  	US_DEBUGP("-- releasing main URB\n");
> diff -urN -X dontdiff linux-2.4.26-rc2/drivers/usb/storage/usb.h linux-2.=
4.26-rc2-nip/drivers/usb/storage/usb.h
> --- linux-2.4.26-rc2/drivers/usb/storage/usb.h	2003-11-29 19:23:15.000000=
000 -0800
> +++ linux-2.4.26-rc2-nip/drivers/usb/storage/usb.h	2004-04-09 17:51:44.00=
0000000 -0700
> @@ -116,7 +116,7 @@
>  	struct us_data		*next;		 /* next device */
> =20
>  	/* the device we're working with */
> -	struct semaphore	dev_semaphore;	 /* protect pusb_dev */
> +	struct semaphore	dev_semaphore;	 /* protect many things */
>  	struct usb_device	*pusb_dev;	 /* this usb_device */
> =20
>  	unsigned int		flags;		 /* from filter initially */
> @@ -162,7 +162,6 @@
>  	atomic_t		ip_wanted[1];	 /* is an IRQ expected?	 */
> =20
>  	/* interrupt communications data */
> -	struct semaphore	irq_urb_sem;	 /* to protect irq_urb	 */
>  	struct urb		*irq_urb;	 /* for USB int requests */
>  	unsigned char		irqbuf[2];	 /* buffer for USB IRQ	 */
>  	unsigned char		irqdata[2];	 /* data from USB IRQ	 */
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dcli=
ck
> _______________________________________________
> linux-usb-devel@lists.sourceforge.net
> To unsubscribe, use the last form field at:
> https://lists.sourceforge.net/lists/listinfo/linux-usb-devel

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Department of Justice agent.  I have come to purify the flock.
					-- DOJ agent
User Friendly, 5/22/1998

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAeIzVIjReC7bSPZARAnGlAJ9m5C8n1yrKAePw/pZFjuY5Hd5xaQCgkW3W
XSNkat9/saEuANMDypPBAkU=
=sv+9
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
