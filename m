Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbUKNAIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbUKNAIG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 19:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbUKNAIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 19:08:06 -0500
Received: from ctb-mesg3.saix.net ([196.25.240.75]:57268 "EHLO
	ctb-mesg3.saix.net") by vger.kernel.org with ESMTP id S261215AbUKNAH4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 19:07:56 -0500
Subject: Re: 2.6.10-rc1-mm5 [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       Ingo Molnar <mingo@elte.hu>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
In-Reply-To: <20041113152457.6cb0fedb.akpm@osdl.org>
References: <20041111012333.1b529478.akpm@osdl.org>
	 <1100368553.12239.3.camel@nosferatu.lan>
	 <1100380593.12663.1.camel@nosferatu.lan>
	 <20041113132232.5c201000.akpm@osdl.org>
	 <1100384533.12195.3.camel@nosferatu.lan>
	 <20041113152457.6cb0fedb.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-QiMwf5lkOsr7HAfQDgB2"
Date: Sun, 14 Nov 2004 02:07:49 +0200
Message-Id: <1100390869.12195.8.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QiMwf5lkOsr7HAfQDgB2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-11-13 at 15:24 -0800, Andrew Morton wrote:
> "Martin Schlemmer [c]" <azarah@nosferatu.za.org> wrote:
> >
> >  > Could you please try:
> >  >=20
> >  > wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2=
.6.10-rc1/2.6.10-rc1-mm5/broken-out/futex_wait-fix.patch
> >  > patch -R -p1 < futex_wait-fix.patch
> >  >=20
> >  > the retest?
> >=20
> >  Yep, this seems to fix it (usually one thread at least have already hu=
ng
> >  at start for evo, now fine after a few mail fetches).
>=20
> OK, thanks.
>=20
> >  Is this a regression, or as in the other thread an issue with evolutio=
n
> >  that should be fixed ?  (Note:  gnome-btdownload also seemed to hang
> >  overnight with -mm[45], but I do not know if its related)
>=20
> Don't know.  It's hard to see why that patch would cause gross misbehavio=
ur
> in evolution and apache.  We may have to just revert it and take another
> look at the problem which it fixes.
>=20

I will be honest that I know next to nothing about relevant code, but
this looks fishy:

------
@@ -486,6 +486,8 @@
        if (unlikely(ret !=3D 0))
                goto out_release_sem;

-       queue_me(&q, -1, NULL);
-
        /*
         * Access the page after the futex is queued.
         * We hold the mmap semaphore, so the mapping cannot have changed
------

The 'queue_me(&q, -1, NULL);' gets moved down, but just below where it
was we have a comment before a get_user() ... it is not possible that
because the patch cause the get_user() to be before queue_me(), that
we can have two (or more?) get_user()'s for the same futex at relatively
the same time?


> One thing I do note which is unrelated to this problem is that futex_wait=
()
> does get_user() inside down_read(mmap_sem).  But a fault will do a second
> down_read().  And doing down_read() twice from within the same thread is =
a
> bug, because an intervening down_write() from another thread will cause
> deadlock.
>=20

I will rather leave this to somebody that now something about this =3D)


Thanks,

--=20
Martin Schlemmer


--=-QiMwf5lkOsr7HAfQDgB2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBlqHVqburzKaJYLYRAo4FAJ9gTat/SYbmNJBd2u8aIoArLt7/ZwCfePoD
azw3cxrjhxwCn2DwUmuAeiM=
=U8ho
-----END PGP SIGNATURE-----

--=-QiMwf5lkOsr7HAfQDgB2--

