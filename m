Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265772AbUFTKdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265772AbUFTKdl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 06:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265865AbUFTKdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 06:33:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6105 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265772AbUFTKdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 06:33:20 -0400
Subject: Re: page allocation failure. order:0, mode:0x20
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
In-Reply-To: <40D565FE.1050903@yahoo.com.au>
References: <Pine.GSO.4.58.0406201115470.23356@waterleaf.sonytel.be>
	 <40D565FE.1050903@yahoo.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-p930bG6WrZJgD4Pta34K"
Organization: Red Hat UK
Message-Id: <1087727591.2805.8.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 20 Jun 2004 12:33:11 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-p930bG6WrZJgD4Pta34K
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-06-20 at 12:25, Nick Piggin wrote:
> >=20
> > | # free
> > |              total       used       free     shared    buffers     ca=
ched
> > | Mem:         10260       9844        416          0        240       =
5004
> > | -/+ buffers/cache:       4600       5660
> > | Swap:        33256       3796      29460
> >=20
>=20
> Not even atomic allocations memory are allowed to consume all memory.
> A small amount is reserved for memory freeing (which sometimes
> requires initial memory allocations).
>=20
> The message should be harmless.

Since atomic allocations by definition need to be able to cope with
failure, how about a patch like this to not warn for this common and
legit case?

diff -urNp linux-1130/include/linux/gfp.h
linux-10000/include/linux/gfp.h
--- linux-1130/include/linux/gfp.h
+++ linux-10000/include/linux/gfp.h
@@ -46,7 +46,7 @@ struct vm_area_struct;
                        __GFP_COLD|__GFP_NOWARN|__GFP_REPEAT| \
                      =20
__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP)
                                                                           =
                                       =20
-#define GFP_ATOMIC     (__GFP_HIGH)
+#define GFP_ATOMIC     (__GFP_HIGH | __GFP_NOWARN)
 #define GFP_NOIO       (__GFP_WAIT)
 #define GFP_NOFS       (__GFP_WAIT | __GFP_IO)
 #define GFP_KERNEL     (__GFP_WAIT | __GFP_IO | __GFP_FS)


--=-p930bG6WrZJgD4Pta34K
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA1WfnxULwo51rQBIRAjXAAKCg1lJ/ZyzFxzZ/RYRlMWMCWONEngCfRa4L
vIIvoCCcVzMuUF7TpygGcio=
=pus0
-----END PGP SIGNATURE-----

--=-p930bG6WrZJgD4Pta34K--

