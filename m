Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262609AbVHDPuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbVHDPuy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 11:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262620AbVHDPuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 11:50:35 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:19651 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S262613AbVHDPtv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 11:49:51 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Dave Jones <davej@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Saripalli, Venkata Ramanamurthy (STSD)" <saripalli@hp.com>,
       linux-scsi@vger.kernel.org, axboe@suse.de
Subject: Re: [PATCH 1/2] cpqfc: fix for "Using too much stach" in 2.6 kernel
Date: Thu, 4 Aug 2005 17:56:14 +0200
User-Agent: KMail/1.8.1
References: <4221C1B21C20854291E185D1243EA8F302623BCC@bgeexc04.asiapacific.cpqcorp.net> <200508041138.38216@bilbo.math.uni-mannheim.de> <20050804154023.GA22886@redhat.com>
In-Reply-To: <20050804154023.GA22886@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4067299.zUI2PIYtZU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508041756.23611@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4067299.zUI2PIYtZU
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Donnerstag, 4. August 2005 17:40 schrieb Dave Jones:
>On Thu, Aug 04, 2005 at 11:38:30AM +0200, Rolf Eike Beer wrote:
> > >+	  ulFibreFrame =3D kmalloc((2048/4), GFP_KERNEL);
> >
> > The size bug was already found by Dave Jones. This never should be
> > written this way (not your fault). The array should have been
> > [2048/sizeof(ULONG)].
>
>wasteful. We only ever use 2048 bytes of this array, so doubling
>its size on 64bit is pointless, unless you make changes later on
>in the driver. (Which I think don't make sense, as we just copy
>32 64byte chunks).

No, this is how it should have been before. This way it would have been cle=
ar=20
where the magic 4 came from.

>Ermm, actually this looks totally bogus..
>CpqTsGetSFQEntry() ...
>
>    if( total_bytes <=3D 2048 )
>    {
>      memcpy( ulDestPtr,
>              &fcChip->SFQ->QEntry[consumerIndex],
>              64 );  // each SFQ entry is 64 bytes
>      ulDestPtr +=3D 16;   // advance pointer to next 64 byte block
>    }
>
>we're trashing the last 48 bytes of every copy we make.
>Does this driver even work ?

No, ulDestPtr ist ULONG* so we increase it by sizeof(ULONG)*16 which is 64.=
=20
This is one of the places I was talking about where people might miss what'=
s=20
going on. ;) IMHO it makes absolutely no sense to use a ULONG* at this plac=
e.

Eike

--nextPart4067299.zUI2PIYtZU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBC8jqnXKSJPmm5/E4RAl0jAJ4lhshRFqO8h7pNU7yy8U2gjBnQtwCfWHGr
iHvTKn9UUdUEirqTWe/xOms=
=G1sE
-----END PGP SIGNATURE-----

--nextPart4067299.zUI2PIYtZU--
