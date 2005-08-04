Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262448AbVHDJcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbVHDJcM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 05:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbVHDJcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 05:32:11 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:17810 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S262405AbVHDJcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 05:32:09 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] cpqfc: fix for "Using too much stach" in 2.6 kernel
Date: Thu, 4 Aug 2005 11:38:30 +0200
User-Agent: KMail/1.8.1
Cc: "Saripalli, Venkata Ramanamurthy (STSD)" <saripalli@hp.com>,
       linux-scsi@vger.kernel.org, axboe@suse.de
References: <4221C1B21C20854291E185D1243EA8F302623BCC@bgeexc04.asiapacific.cpqcorp.net>
In-Reply-To: <4221C1B21C20854291E185D1243EA8F302623BCC@bgeexc04.asiapacific.cpqcorp.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3670994.FAo0KsVKFx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508041138.38216@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3670994.FAo0KsVKFx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Saripalli, Venkata Ramanamurthy (STSD) wrote:
>Patch 1 of 2
>
>This patch fixes the "#error this is too much stack" in 2.6 kernel.
>Using kmalloc to allocate memory to ulFibreFrame.

Good idea.

>Please consider this for inclusion

Your patch is line-wrapped and can't be applied. Your second patch is also=
=20
line wrapped. And it touches this file in a different way so they can't be=
=20
applied cleanly over each other.

>diff -burpN old/drivers/scsi/cpqfcTScontrol.c
>new/drivers/scsi/cpqfcTScontrol.c
>--- old/drivers/scsi/cpqfcTScontrol.c	2005-07-12 22:52:29.000000000
>+0530
>+++ new/drivers/scsi/cpqfcTScontrol.c	2005-07-18 22:19:54.229947176
>+0530
>@@ -606,22 +606,25 @@ static int PeekIMQEntry( PTACHYON fcChip
>         if( (fcChip->IMQ->QEntry[CI].type & 0x1FF) =3D=3D 0x104 )
>         {
>           TachFCHDR_GCMND* fchs;
>-#error This is too much stack
>-          ULONG ulFibreFrame[2048/4];  // max DWORDS in incoming FC
>Frame
>+          ULONG *ulFibreFrame;  // max DWORDS in incoming FC Frame
> 	  USHORT SFQpi =3D (USHORT)(fcChip->IMQ->QEntry[CI].word[0] &
>0x0fffL);

Why not use a void* here as type for the buffer? Or even better: remove thi=
s=20
at all and directly use fchs as target, because this is the only place wher=
e=20
this buffer goes to?

>+	  ulFibreFrame =3D kmalloc((2048/4), GFP_KERNEL);

The size bug was already found by Dave Jones. This never should be written=
=20
this way (not your fault). The array should have been [2048/sizeof(ULONG)].

> 	  CpqTsGetSFQEntry( fcChip,
>             SFQpi,        // SFQ producer ndx
> 	    ulFibreFrame, // contiguous dest. buffer
> 	    FALSE);       // DON'T update chip--this is a "lookahead"

CpqTsGetSFQEntry() should be modified to take a void* as third argument IMH=
O.

>-	  fchs =3D (TachFCHDR_GCMND*)&ulFibreFrame;
>+	  fchs =3D (TachFCHDR_GCMND*)ulFibreFrame;
>           if( fchs->pl[0] =3D=3D ELS_LILP_FRAME)
> 	  {
>+	    kfree(ulFibreFrame);
>             return 1; // found the LILP frame!
> 	  }
> 	  else
> 	  {
>+	    kfree(ulFibreFrame);
> 	    // keep looking...
> 	  }
> 	}

What a ...

I would prefer if someone goes and really cleans up this driver.

=2Dread Documentation/Codingstyle
=2Dgo through Lindent.
=2Dkill this ULONG stuff. If you want __u32 use it.
=2Duse void* for "just a buffer"
=2Ddon't use hardcoded type sizes. Use sizeof(type) to make clear what kind=
 of=20
magic is going on.
=2Dthis is C, not C++. No C++ comments, use fewer uppercase letters.

The way it is is very likely to cause people missing what's really going on=
 at=20
some places, which will cause errors afterwards.

Eike

--nextPart3670994.FAo0KsVKFx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBC8eIeXKSJPmm5/E4RAtkMAKCSFuC/yhne0lNSSX0jRAJJXP3TeACfcytd
HvrI/NzzJwK/aLqn1H2aAfs=
=Lp1X
-----END PGP SIGNATURE-----

--nextPart3670994.FAo0KsVKFx--
