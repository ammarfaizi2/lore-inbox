Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266883AbUHOU2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266883AbUHOU2D (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 16:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266879AbUHOU2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 16:28:03 -0400
Received: from ctb-mesg2.saix.net ([196.25.240.74]:41159 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S266883AbUHOUY4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 16:24:56 -0400
Subject: Re: PATCH: fixup incomplete ident blocks on ITE raid volumes
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Alan Cox <alan@redhat.com>
Cc: linux-ide@vger.kernel.org,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <20040815144527.GA7983@devserv.devel.redhat.com>
References: <20040815144527.GA7983@devserv.devel.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-dhWDKlvdPfQ+FxJ5hUBW"
Message-Id: <1092601693.8976.140.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 15 Aug 2004 22:28:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dhWDKlvdPfQ+FxJ5hUBW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-08-15 at 16:45, Alan Cox wrote:
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vani=
lla-2.6.8-rc3/drivers/ide/ide-probe.c linux-2.6.8-rc3/drivers/ide/ide-probe=
.c
> --- linux.vanilla-2.6.8-rc3/drivers/ide/ide-probe.c	2004-08-09 15:51:00.0=
00000000 +0100
> +++ linux-2.6.8-rc3/drivers/ide/ide-probe.c	2004-08-14 21:03:03.000000000=
 +0100
> @@ -542,7 +542,51 @@
>  }
> =20
>  /**
> - *	probe_for_drives	-	upper level drive probe
> + *	ident_quirks	-	drive ident mangler
> + *	@drive: drive to check
> + *
> + *	Take the returned ident block for the drive and see if it
> + *	is one of the broken ones. We still broken ident fixups in
> + *	multiple places, we should migrate some of the others here.
> + */
> +static void ident_quirks(ide_drive_t *drive)
> +{
> +	struct hd_driveid *id =3D drive->id;
> +	u16 *idbits =3D (u16 *)id;
> +=09
> +	if(strstr(id->model, "Integrated Technology Express"))
> +	{
> +		/* IT821x raid volume with bogus ident block */
> +		if(id->lba_capacity >=3D 0x200000)
> +		{
> +			id->sectors =3D 63;
> +			id->heads =3D 255;
> +		}
> +		else
> +		{
> +			id->sectors =3D 32;
> +			id->heads =3D 64;
> +		}
> +		id->cyls =3D 1 + id->lba_capacity_2 / (id->heads * id->sectors);
> +		/* LBA28 is ok, DMA is ok, UDMA data is valid */
> +		id->capability |=3D 3;
> +		id->field_valid |=3D 7;
> +		/* LBA48 is ok */
> +		id->command_set_2 |=3D 0x0400;
> +		id->cfs_enable_2 |=3D 0x0400;
> +		/* Flush is ok */
> +		id->cfs_enable_2 |=3D 0x3000;
> +		printk(KERN_WARNING "%s: IT8212 %sRAID %d volume",
> +			drive->name,
> +			idbits[147] ? "Bootable ":"",
> +			idbits[129]);
> +		if(idbits[129] !=3D 1)
> +			printk("(%dK stripe)", idbits[146]);
> +		printk(".\n");
> +	}	=09
> +}
> +/**
> + *	probe_for_drive	-	upper level drive probe
>   *	@drive: drive to probe for
>   *
>   *	probe_for_drive() tests for existence of a given drive using do_probe=
()
> @@ -553,7 +597,7 @@
>   *			   still be 0)
>   */
>  =20
> -static inline u8 probe_for_drive (ide_drive_t *drive)
> +static u8 probe_for_drive(ide_drive_t *drive)
>  {
>  	/*
>  	 *	In order to keep things simple we have an id
> @@ -602,6 +646,7 @@
>  				drive->present =3D 0;
>  			}
>  		}
> +		ident_quirks(drive);
>  		/* drive was found */
>  	}
>  	if(!drive->present)
>=20
>=20
> Signed-off-by: Alan Cox
>=20

This one is cause this:

---
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x6ef1f): In function `ident_quirks':
: undefined reference to `__udivdi3'
make: *** [.tmp_vmlinux1] Error 1
---


Regards,

--=20
Martin Schlemmer

--=-dhWDKlvdPfQ+FxJ5hUBW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBH8ddqburzKaJYLYRAuwQAJ9zExPUITiIkz5Ej746h6YJfmyo+gCglUlW
mz6FxZKuSp+A8eIFwRb0AsA=
=bJIR
-----END PGP SIGNATURE-----

--=-dhWDKlvdPfQ+FxJ5hUBW--

