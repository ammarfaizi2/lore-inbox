Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268142AbUIKNF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268142AbUIKNF2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 09:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268141AbUIKNF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 09:05:28 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:2762 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S268145AbUIKNEt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 09:04:49 -0400
Date: Sat, 11 Sep 2004 15:03:24 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: swsusp: progress in percent
Message-ID: <20040911130324.GB14771@thundrix.ch>
References: <20040910084704.GB12751@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
In-Reply-To: <20040910084704.GB12751@elf.ucw.cz>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Fri, Sep 10, 2004 at 10:47:04AM +0200, Pavel Machek wrote:
> --- clean-mm/kernel/power/disk.c	2004-09-07 21:12:33.000000000 +0200
> +++ linux-mm/kernel/power/disk.c	2004-09-08 22:47:41.000000000 +0200
> @@ -91,10 +91,20 @@
> =20
>  static void free_some_memory(void)
>  {
> -	printk("Freeing memory: ");
> -	while (shrink_all_memory(10000))
> -		printk(".");
> -	printk("|\n");
> +	unsigned int i =3D 0;
> +	unsigned int tmp;
> +	unsigned long pages =3D 0;
> +	char *p =3D "-\\|/";
> +=09
> +	printk("Freeing memory...  ");
> +	while ((tmp =3D shrink_all_memory(10000))) {
> +		pages +=3D tmp;
		printk("\b%c", p[(i++)%4]);	?
> +	}
> +	printk("\bdone (%li pages freed)\n", pages);
>  }
> =20
> =20
> --- clean-mm/kernel/power/swsusp.c	2004-09-07 21:12:33.000000000 +0200
> +++ linux-mm/kernel/power/swsusp.c	2004-09-09 08:56:20.000000000 +0200
> @@ -296,15 +292,19 @@
>  {
>  	int error =3D 0;
>  	int i;
> -
> -	printk( "Writing data to swap (%d pages): ", nr_copy_pages );
> +	unsigned int mod =3D nr_copy_pages / 100;
> +=09
> +	if (!mod)
> +		mod =3D 1;
> +=09
> +	printk( "Writing data to swap (%d pages)...     ", nr_copy_pages );
>  	for (i =3D 0; i < nr_copy_pages && !error; i++) {
> -		if (!(i%100))
> -			printk( "." );
> +		if (!(i%mod))
> +			printk( "\b\b\b\b%3d%%", i / mod );
>  		error =3D write_page((pagedir_nosave+i)->address,
>  					  &((pagedir_nosave+i)->swap_address));
>  	}
> -	printk(" %d Pages done.\n",i);
> +	printk("\b\b\b\bdone\n");

Didn't we say we want the page count here?

>  	return error;
>  }
> =20
> @@ -1153,14 +1120,18 @@
>  	struct pbe * p;
>  	int error;
>  	int i;
> -
> +	int mod =3D nr_copy_pages / 100;
> +=09
> +	if (!mod)
> +		mod =3D 1;
> +=09
>  	if ((error =3D swsusp_pagedir_relocate()))
>  		return error;
> =20
> -	printk( "Reading image data (%d pages): ", nr_copy_pages );
> +	printk( "Reading image data (%d pages):     ", nr_copy_pages );
>  	for(i =3D 0, p =3D pagedir_nosave; i < nr_copy_pages && !error; i++, p+=
+) {
> -		if (!(i%100))
> -			printk( "." );
> +		if (!(i%mod))
> +			printk( "\b\b\b\b%3d%%", i / mod );
>  		error =3D bio_read_page(swp_offset(p->swap_address),
>  				  (void *)p->address);
>  	}
>=20
>=20

Thanks for enlightenment.

			Tonnerre

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBQvec/4bL7ovhw40RAtazAKCozYTqcs2AYOdX7s05M4nXmphYvgCeKn2E
VNIft++uPT0Noy00Lvqlg2w=
=I+NB
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
