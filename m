Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268247AbRG3Ajb>; Sun, 29 Jul 2001 20:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268248AbRG3AjW>; Sun, 29 Jul 2001 20:39:22 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:20542 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S268247AbRG3AjH>; Sun, 29 Jul 2001 20:39:07 -0400
Date: Mon, 30 Jul 2001 02:38:04 +0200
From: Kurt Garloff <garloff@suse.de>
To: Evan Parker <nave@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu
Subject: Re: [CHECKER] null-deref errors for 2.4.7
Message-ID: <20010730023804.H25964@pckurt.casa-etp.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Evan Parker <nave@stanford.edu>, linux-kernel@vger.kernel.org,
	mc@cs.stanford.edu
In-Reply-To: <Pine.GSO.4.31.0107241528560.20515-100000@myth8.Stanford.EDU>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FxavXfDenm+F7xE/"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.31.0107241528560.20515-100000@myth8.Stanford.EDU>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.7-SMP i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--FxavXfDenm+F7xE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Evan,

thanks for your report!

On Tue, Jul 24, 2001 at 03:31:26PM -0700, Evan Parker wrote:
> Enclosed are 100 bugs found by an automatic checker that checks
> the internal consistency of code with respect to pointer dereferences and
> comparisons to NULL.
[...]
> The most common pattern the checker found was when a pointer is
> dereferenced in a declaration initialization, and then immidately checked
> against NULL.  The following code, one example of this pattern, was found
> copied and pasted almost verbatim in over 20 different locations.

[...]

> Overall, this checker is pretty robust, with a very low false positive
> rate.  On kernel 2.4.7, it found 146 possible errors, of which 100 were
> obvious bugs, 18 were false positives, and the rest were unknown (usually
> because the dereference and the check happened too far apart).
> Furthermore, the majority of the false positives were triggered by macro
> expansions that included checks against NULL.
>=20
>=20
> # Summary for 2.4.7
> #  Total Errors				  =3D 100
> # BUGs	|	File Name
[...]
> 2	|	drivers/scsi/tmscsim.c/
[...]
> [BUG]
> drivers/scsi/tmscsim.c:2571:dc390_set_info: ERROR:INTERNAL_NULL2:2557:257=
1: Checked "pos" against null AFTER dereferencing it! [nbytes =3D 1]  [dist=
ance=3D25]
>   int dum =3D 0;
>   char dev;
>   PDCB pDCB =3D pACB->pLinkDCB;
>   DC390_IFLAGS
>   DC390_AFLAGS
> Start --->
>   pos[length] =3D 0;
>=20
>   DC390_LOCK_IO;
>   DC390_LOCK_ACB;
>   /* UPPERCASE */
>   /* Don't use kernel toupper, because of 2.0.x bug: ctmp unexported */
>   while (*pos)
>     { if (*pos >=3D'a' && *pos <=3D 'z') *pos =3D *pos + 'A' - 'a'; pos++=
; };
>=20
>   /* We should protect __strtok ! */
>   /* spin_lock (strtok_lock); */
>=20
>   /* Remove WS */
>   pos =3D strtok (buffer, " \t:\n=3D,;");
> Error --->
>   if (!pos) goto ok;
>=20
>  next:
>   if (!memcmp (pos, "RESET", 5)) goto reset;
> ---------------------------------------------------------
> [BUG]
> drivers/scsi/tmscsim.c:2658:dc390_set_info: ERROR:INTERNAL_NULL2:2653:265=
8: Checked "pos" against null AFTER passing it to "simple_strtoul"! [nbytes=
 =3D 1]  [distance=3D26]
> 	  if (!pos) goto ok;
> 	  /* decimal */
> 	  if (pos-1 =3D=3D pdec)
> 	     {
> 		int dumold =3D dum;
> Start --->
> 		dum =3D simple_strtoul (pos, &p0, 10) * 10;
> 		for (; p0-pos > 1; p0--) dum /=3D 10;
> 		pDCB->NegoPeriod =3D (100000/(100*dumold + dum)) >> 2;
> 		if (pDCB->NegoPeriod < 19) pDCB->NegoPeriod =3D 19;
> 		pos =3D strtok (0, " \t\n:=3D,;");
> Error --->
> 		if (!pos) goto ok;
> 	     };
> 	  if (*pos =3D=3D 'M') pos =3D strtok (0, " \t\n:=3D,;");
> 	  if (pDCB->NegoPeriod !=3D olddevmode) needs_inquiry++;
> ---------------------------------------------------------

Both places look correct to me, as the check is after a token has been
searched for with strtok ().
Please contradict if you think I'm wrong.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, DE                                SCSI, Security

--FxavXfDenm+F7xE/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7ZKxsxmLh6hyYd04RAi21AJwLP0IhvflN6V0SvXb+zwG4ikHQKQCgjPw1
Larxtv+QdvZowE4TXQPKoco=
=G2LH
-----END PGP SIGNATURE-----

--FxavXfDenm+F7xE/--
