Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263859AbUDFO6w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 10:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263856AbUDFO5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 10:57:35 -0400
Received: from gemini.rz.uni-ulm.de ([134.60.246.16]:57587 "EHLO
	mail.rz.uni-ulm.de") by vger.kernel.org with ESMTP id S263852AbUDFOzm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 10:55:42 -0400
Date: Tue, 6 Apr 2004 16:47:09 +0200
From: Juergen Salk <juergen.salk@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Strip whitespace from EXTRAVERSION?
Message-ID: <20040406144709.GC16564@oest181.str.klinik.uni-ulm.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-DCC-RollaNet-Metrics: gemini 1004; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I am wondering if it makes sense to strip whitespace
characters from $(EXTRAVERSION) if they exist.

Especially trailing whitespace can easily be introduced
(and overlooked) by mistake by someone who edits
this value in the Makefile.

This is not only a show stopper when it comes to
=BBmake modules_install=AB but it may also cause data
loss under certain circumstances. E.g. if you
maintain an - admittedly non-standard - directory
tree named /kernel on your system, this tree will be
deleted when you invoke =BBmake modules_install=AB with
trailing whitespace in $(EXTRAVERSION) (and thus
in $(MODLIB) as well):

=2EPHONY: modules_install
modules_install: _modinst_ $(patsubst %, _modinst_%, $(SUBDIRS))
_modinst_post

=2EPHONY: _modinst_
_modinst_:
    @rm -rf $(MODLIB)/kernel
    @rm -f $(MODLIB)/build
    @mkdir -p $(MODLIB)/kernel
    @ln -s $(TOPDIR) $(MODLIB)/build

Similar arguments may hold true for other macros
as well (like $(VERSION), $(PATCHLEVEL) etc.), but
these are much less likely touched by an ordinary
user who just wants to recompile his kernel.

After all, this is not a big issue, but I would like to
know what others think about it.

Just in case, there is a trivial one-liner against
2.4.25 below to remove whitespace from $(EXTRAVERSION) before it
is used elsewhere. Note that there is a space and a tab
inside the sed braces.

(One could also think about proper quoting to allow whitespace
in $(EXTRAVERSION), but I'm not so sure if whitespace makes
much sense in it, anyway.)

Regards - Juergen Salk


--- Makefile-orig       Tue Apr  6 14:13:06 2004
+++ Makefile    Tue Apr  6 14:45:29 2004
@@ -3,6 +3,7 @@
 SUBLEVEL =3D 25
 EXTRAVERSION =3D

+EXTRAVERSION:=3D$(shell echo $(EXTRAVERSION) | sed -e 's/[ 	]//g')
 KERNELRELEASE=3D$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)

 ARCH :=3D $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ -e s/=
arm.*/arm/ -e s/sa110/arm/)

--=20
GPG A997BA7A | 87FC DA31 5F00 C885 0DC3  E28F BD0D 4B33 A997 BA7A

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAcsLtvQ1LM6mXunoRAkqsAJ49MJPYdx1UGrgQCF15zACFqUHutQCeIcm1
DjWY7Y6JTCcjIBaREuB7CI0=
=Y/92
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
