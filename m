Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWDYUU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWDYUU2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 16:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWDYUU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 16:20:28 -0400
Received: from smtp05.auna.com ([62.81.186.15]:5057 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S1751209AbWDYUU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 16:20:28 -0400
Date: Tue, 25 Apr 2006 22:20:26 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Xavier Bestel <xavier.bestel@free.fr>,
       "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: C++ pushback
Message-ID: <20060425222026.2137dac0@werewolf.auna.net>
In-Reply-To: <1145956952.596.212.camel@capoeira>
References: <4024F493-F668-4F03-9EB7-B334F312A558@iomega.com>
	<mj+md-20060424.201044.18351.atrey@ucw.cz>
	<444D44F2.8090300@wolfmountaingroup.com>
	<1145915533.1635.60.camel@localhost.localdomain>
	<20060425001617.0a536488@werewolf.auna.net>
	<1145952948.596.130.camel@capoeira>
	<444DE0F0.8060706@argo.co.il>
	<mj+md-20060425.085030.25134.atrey@ucw.cz>
	<444DE539.4000804@argo.co.il>
	<mj+md-20060425.090134.27024.atrey@ucw.cz>
	<444DE829.2000101@argo.co.il>
	<1145956952.596.212.camel@capoeira>
X-Mailer: Sylpheed-Claws 2.1.1cvs28 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_AnM0dogJ8KlXWALkEN2B_/d";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.210.119] Login:jamagallon@able.es Fecha:Tue, 25 Apr 2006 22:20:26 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_AnM0dogJ8KlXWALkEN2B_/d
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Apr 2006 11:22:32 +0200, Xavier Bestel <xavier.bestel@free.fr> w=
rote:

>=20
> Yes, "if". With straight C, it's immediatly obvious the kmalloc() is the
> only function with side-effects and special requirements - an
> experienced hacker won't even look it up. With C++ those may be hidden
> behind each object or object member, that's the philosophy of the
> language.=20
> The problem is that in kernel mode you must know precisely when and how
> you allocate memory.
>=20

Don't mix allocation with initialization.
Well, lets see:

  struct xxx {
    struct yyy* y;
    int z;
  }
 =20
  xxx_init(struct xxx* x)
  {
     z =3D 0;
     y =3D kmalloc(GPF_KERNEL,sizeof(struct yyy));
     yyy_init(y);
  }

Now, if on other source file you read:
  ...
  struct xxx* x;
  x =3D kmallloc(GPF_KERNEL,sizeof(struct xxx));
  xxx_init(x);
  ..
  struct xxx  x2;
  xxx_init(&x2);

How do you know what xxx_init() does without looking at it ?
Cay you have just the allocation without init ? What happens if you forget =
it ?
What happens if you cut'n'paste from other driver and let something like

  struct xxx* x;
  x =3D kmallloc(GPF_KERNEL,sizeof(struct qqqqq));
  xxx_init(x);

The only difference it that
  x =3D new(GPF_KERNEL) XXX;

always does what it has to do correctly. What does XXX() constructor ?
You have to look at it, same as xxx_init().

As I said in other answer: I'm not advocating to include C++ support in
current kernel. I just say that the only valid argument is that
'KERNEL IS C', and interfacing C with C++ just would add bloat and errors.
There is no technical argument to reject to write an OS kernel in C++.
It would not be slower nor more complicated, and it will be probably safer
because it leaves less things (from thost you always _must_ do) to
programmers memories.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.16-jam9 (gcc 4.1.1 20060330 (prerelease)) #1 SMP PREEMPT Tue

--Sig_AnM0dogJ8KlXWALkEN2B_/d
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEToSKRlIHNEGnKMMRAm8AAJ9TQMVJrVHX+ZO+Jt1kpn+KGobNAgCdE7ST
9lF/uM+CyJhezvRyUQ3f1E0=
=+sSb
-----END PGP SIGNATURE-----

--Sig_AnM0dogJ8KlXWALkEN2B_/d--
