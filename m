Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264481AbTEJTlQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 15:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264484AbTEJTlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 15:41:16 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:36257 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S264481AbTEJTlO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 15:41:14 -0400
Date: Sat, 10 May 2003 22:53:20 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Yoav Weiss <ml-lkml@unpatched.org>
Cc: arjanv@redhat.com, masud@googgun.com, linux-kernel@vger.kernel.org
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030510195320.GG1053@actcom.co.il>
References: <Pine.LNX.4.44.0305102217300.1163-100000@marcellos.corky.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z9ECzHErBrwFF8sy"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305102217300.1163-100000@marcellos.corky.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--z9ECzHErBrwFF8sy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2003 at 10:18:34PM +0300, Yoav Weiss wrote:

> Masud, your delay-based solutions won't work because an attack code can
> just keep running in a loop until it gets the timing right.  Once is
> enough.  Even if it could work, it would have impact on the whole system.
> Afaik, you can't really yield the CPU for very short time slices so you'll
> have to busy-loop instead, and its not acceptable.  I believe the below
> solution is the right one.  Arjan, please correct me if I'm wrong.
>=20
> The solution is to have only ONE REAL copy, done by the wrapper.  The
> original syscall will copy from a kernel ptr, unknowingly.  Consider
> the following modified pseudo-code:
>=20
> long your_wrapped_syscall(char *userfilename)
> {
>     char kernelpointer[something];
>     copy_from_user(kernelpointer, usefilename, ...);
>     audit_log(kernelpointer);
>     old_fs =3D get_fs();
>     set_fs(KERNEL_DS);
>     ret =3D original_syscall(kernelpointer);
>     set_fs(old_fs);
>     return ret;
> }
>=20
> userfilename is only copied once.  original_syscall just copies
> kernelpointer again, to another kernel pointer.  No race.

This approach, while it would solve this particular problem, has a
grave flow. Consider the case where the first copy in the
original_syscall is to copy a user space structure, which has embedded
user space pointers... The set_fs() will cause future
copy_from_user/copy_to_user in original_syscall() calls to succeed
even if the user  supplied pointer is in kernel space.=20

> Removing this symbol will not really get in the way for the bad guys
> because it'll always be possible to find and intercept it anyway (see my
> previous post in this thread), but it'll increase the learning curve for
> kernel newbies.  Do we really want that ?

Hear hear.=20
--=20
Muli Ben-Yehuda
http://www.mulix.org


--z9ECzHErBrwFF8sy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+vViwKRs727/VN8sRAoHjAJ9GCweHBvllLXvFZZk1l1tHCH3tnwCeP1UD
LiRFJRq1EJ8nKUsMZbNNBeY=
=Rfoo
-----END PGP SIGNATURE-----

--z9ECzHErBrwFF8sy--
