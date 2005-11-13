Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbVKMWeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbVKMWeR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 17:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVKMWeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 17:34:17 -0500
Received: from smtp04.auna.com ([62.81.186.14]:15797 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S1750782AbVKMWeQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 17:34:16 -0500
Date: Sun, 13 Nov 2005 23:33:55 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: x86 building altivec for raid ?
Message-ID: <20051113233355.0b52876f@werewolf.auna.net>
In-Reply-To: <17271.44949.625740.612801@cse.unsw.edu.au>
References: <20051113220213.55fc6fae@werewolf.auna.net>
	<17271.44949.625740.612801@cse.unsw.edu.au>
X-Mailer: Sylpheed-Claws 1.9.100cvs7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_hH41Lqc.ETF3nYgzfX/gemy";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.218.105] Login:jamagallon@able.es Fecha:Sun, 13 Nov 2005 23:34:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_hH41Lqc.ETF3nYgzfX/gemy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Nov 2005 08:26:45 +1100, Neil Brown <neilb@suse.de> wrote:

> On Sunday November 13, jamagallon@able.es wrote:
> >=20
> > Kernel is 2.6.14-mm2.
> > This is an x86 box, why does it compile raid6altivec*.c ? I suppose it
> > does not generate any code, because of some #ifdef magic, but why does
> > it build them anyways ? Looks a bit strange.
>=20
> It's probably just easier that way.
> I guess you could do the following, but I'm not sure that it is really
> worth it.
>=20
> NeilBrown
>=20
> Signed-off-by: Neil Brown <neilb@suse.de>
>=20
> diff ./drivers/md/Makefile~current~ ./drivers/md/Makefile
> --- ./drivers/md/Makefile~current~	2005-11-14 08:13:43.000000000 +1100
> +++ ./drivers/md/Makefile	2005-11-14 08:23:29.000000000 +1100
> @@ -8,12 +8,15 @@ dm-multipath-objs :=3D dm-hw-handler.o dm-
>  dm-snapshot-objs :=3D dm-snap.o dm-exception-store.o
>  dm-mirror-objs	:=3D dm-log.o dm-raid1.o
>  md-mod-objs     :=3D md.o bitmap.o
> +raid6-$(CONFIG_ALTIVEC) :=3D  \
> +		   raid6altivec1.o raid6altivec2.o raid6altivec4.o \
> +		   raid6altivec8.o
> +raid6-$(CONFIG_X86) :=3D  raid6mmx.o raid6sse1.o
> +raid6-$(CONFIG_X86_64) :=3D raid6sse2.o
>  raid6-objs	:=3D raid6main.o raid6algos.o raid6recov.o raid6tables.o \
>  		   raid6int1.o raid6int2.o raid6int4.o \
>  		   raid6int8.o raid6int16.o raid6int32.o \
> -		   raid6altivec1.o raid6altivec2.o raid6altivec4.o \
> -		   raid6altivec8.o \
> -		   raid6mmx.o raid6sse1.o raid6sse2.o
> +		   $(raid6-y)

Err, if I did not misundertood it, raid6-y would mean 'objects for building
raid6 in kernel', versus 'raid6-m', for objects for build as a module ?
Would not this be better:

--- Makefile.orig	2005-11-13 23:14:48.000000000 +0100
+++ Makefile	2005-11-13 23:28:05.000000000 +0100
@@ -8,12 +8,21 @@
 dm-snapshot-objs :=3D dm-snap.o dm-exception-store.o
 dm-mirror-objs	:=3D dm-log.o dm-raid1.o
 md-mod-objs     :=3D md.o bitmap.o
+
+
+ifeq ($(CONFIG_ALTIVEC),y)
+raid6-vec-objs :=3D \
+		   raid6altivec1.o raid6altivec2.o \
+		   raid6altivec4.o raid6altivec8.o
+endif
+ifeq ($(CONFIG_X86),y)
+raid6-vec-objs :=3D \
+		   raid6mmx.o raid6sse1.o raid6sse2.o
+endif
 raid6-objs	:=3D raid6main.o raid6algos.o raid6recov.o raid6tables.o \
 		   raid6int1.o raid6int2.o raid6int4.o \
 		   raid6int8.o raid6int16.o raid6int32.o \
-		   raid6altivec1.o raid6altivec2.o raid6altivec4.o \
-		   raid6altivec8.o \
-		   raid6mmx.o raid6sse1.o raid6sse2.o
+		   $(raid6-vec-objs)
 hostprogs-y	:=3D mktables
=20
 # Note: link order is important.  All raid personalities



--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.14-jam2 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))

--Sig_hH41Lqc.ETF3nYgzfX/gemy
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDd79TRlIHNEGnKMMRAq0oAKCqq3grZdE1oHqXZrGYpnMPS2k/mACgkIH8
8upN27DXwG1mdV9M6yNDZ+U=
=IhP3
-----END PGP SIGNATURE-----

--Sig_hH41Lqc.ETF3nYgzfX/gemy--
