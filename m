Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262182AbVDFMKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbVDFMKs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 08:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVDFMKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 08:10:46 -0400
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:61099 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S262182AbVDFMGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 08:06:12 -0400
Subject: Re: [BUG mm] "fixed" i386 memcpy inlining buggy
From: Christophe Saout <christophe@saout.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: gcc@gcc.gnu.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jakub@redhat.com, Gerold Jury <gerold.ml@inode.at>,
       Jan Hubicka <hubicka@ucw.cz>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200504061314.27740.vda@port.imtp.ilyichevsk.odessa.ua>
References: <200503291542.j2TFg4ER027715@earth.phy.uc.edu>
	 <200504021526.53990.vda@ilport.com.ua>
	 <1112718844.22591.15.camel@leto.cs.pocnet.net>
	 <200504061314.27740.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-HhsM7w4G+CUjSaq46PV4"
Date: Wed, 06 Apr 2005 14:05:57 +0200
Message-Id: <1112789157.32279.13.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HhsM7w4G+CUjSaq46PV4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Mittwoch, den 06.04.2005, 13:14 +0300 schrieb Denis Vlasenko:

> Oh shit. I was trying to be too clever. I still run with this patch,
> so it must be happening very rarely.

Yes, that's right, it happened with code that's not in the mainline tree
but could have happened anywhere.

> Does this one compile ok?

Yes, the case that failed is now okay. I changed it slightly to assign
esi and edi directy on top of the functions, no asm section needed here.
The compiler will make sure that they have the correct values when
needed.

In the case above the compiler now uses %ebx to save the loop counter
instead of %esi.

In drivers/cdrom/cdrom.c I'm observing one very strange thing though.

It appears that the compiler decided to put the local variable edi on
the stack for some unexplicable reason (or possibly there is?). Since
the asm sections are memory barriers the compiler then saves the value
of %edi on the stack before entering the next assembler section.

    1f1c:       a5                      movsl  %ds:(%esi),%es:(%edi)
    1f1d:       89 7d 84                mov    %edi,0xffffff84(%ebp)
    1f20:       a5                      movsl  %ds:(%esi),%es:(%edi)
    1f21:       89 7d 84                mov    %edi,0xffffff84(%ebp)
    1f24:       66 a5                   movsw  %ds:(%esi),%es:(%edi)

(this is a constant 10 byte memcpy)

The only thing that would avoid this is to either tell the compiler to
never put esi/edi in memory (which I think is not possibly across
different versions of gcc) or to always generate a single asm section
for all the different cases.


--=-HhsM7w4G+CUjSaq46PV4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCU9ClZCYBcts5dM0RArAYAJ901CzqlqphTGQ9A5PGi5aMneSE3ACfQZFR
kN0zdfdOEoT4BLh1N87Wny4=
=J4WR
-----END PGP SIGNATURE-----

--=-HhsM7w4G+CUjSaq46PV4--

