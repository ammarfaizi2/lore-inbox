Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265159AbUEYWHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265159AbUEYWHh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 18:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265158AbUEYWHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 18:07:36 -0400
Received: from null.rsn.bth.se ([194.47.142.3]:12732 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S265141AbUEYWCT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 18:02:19 -0400
Subject: Re: [PATCH 3/4] Consolidate sys32_select
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, ultralinux@vger.kernel.org
In-Reply-To: <200404161805.55224.arnd@arndb.de>
References: <200404161800.22367.arnd@arndb.de>
	 <200404161805.55224.arnd@arndb.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-HFNHQ274hDOAivtaNVv6"
Message-Id: <1085522532.969.91.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 26 May 2004 00:02:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HFNHQ274hDOAivtaNVv6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-04-16 at 18:05, Arnd Bergmann wrote:

Hi Arnd.

> sys32_select has seven mostly but not exactly identical versions,
> so consolidate them as compat_sys_select. Based on the ppc64
> implementation, which most closely resembles sys_select.
> One bug that was not caught by LTP has been fixed since the
> first version of this patch.
>=20
> tested x86_64, ia64 and s390.

This breaks sparc64. rsync -> select() -> compat_sys_select() with a
user pointer that has bit (1<<32) set.
I came to this conclusion after having added lots of debug printk's.
Here's the debug printk:

compat_sys_select: before verify_area 00000001efff6468

The address printed is the address of the tvp argument.
The only weird thing with it is the (1<<32) bit, otherwise it looks like
the other pointers (this doesn't happen for all select()'s but I have a
testcase with rsync that reproduces it every time in exactly the same
way)

When this happens __get_user() generates a pagefault and we somehow get
stuck in a pagefault loop, we livelock.
(verify_area() is a noop on sparc64)

How it used to look in arch/sparc64/kernel/sys_sparc32.c

> -asmlinkage int sys32_select(int n, u32 *inp, u32 *outp, u32 *exp, u32 tv=
p_x)
> -{
> -	fd_set_bits fds;
> -	struct compat_timeval *tvp =3D (struct compat_timeval *)AA(tvp_x);
[snip]
> -		if ((ret =3D verify_area(VERIFY_READ, tvp, sizeof(*tvp)))
> -		    || (ret =3D __get_user(sec, &tvp->tv_sec))
> -		    || (ret =3D __get_user(usec, &tvp->tv_usec)))
> -			goto out_nofds;

What it looks like now:

asmlinkage long
compat_sys_select(int n, compat_ulong_t __user *inp, compat_ulong_t __user =
*outp,
		compat_ulong_t __user *exp, struct compat_timeval __user *tvp)
{
[snip]
		time_t sec, usec;

		if ((ret =3D verify_area(VERIFY_READ, tvp, sizeof(*tvp)))
		    || (ret =3D __get_user(sec, &tvp->tv_sec))
		    || (ret =3D __get_user(usec, &tvp->tv_usec)))
			goto out_nofds;


This combined with this comment from arch/sparc64/kernel/sys_sparc32.c

/* Things to consider: the low-level assembly stub does
   srl x, 0, x for first four arguments, so if you have
   pointer to something in the first four arguments, just
   declare it as a pointer, not u32. On the other side,
   arguments from 5th onwards should be declared as u32
   for pointers, and need AA() around each usage.


I added some simple casting to get rid of the high-bit and now rsync
works just fine and we don't livelock.

Do you have any ideas how to cleanly get this working again?
Masking argument five and onwards with 0xffffffffUL ?

On a related note, a quick look through fs/compat.c indicates that we
have the same problem with these compat functions as well:

compat_sys_io_getevent
compat_sys_mount

--=20
/Martin

--=-HFNHQ274hDOAivtaNVv6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAs8JkWm2vlfa207ERAoO1AJ0eCxPM3sktmHbdr7/kf8hYtMpP1ACfQAzU
jD4JXZsaPW5yNYE5RVyF+YM=
=m3H2
-----END PGP SIGNATURE-----

--=-HFNHQ274hDOAivtaNVv6--
