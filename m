Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbUJ1Os0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbUJ1Os0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 10:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbUJ1Os0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 10:48:26 -0400
Received: from 208.177.141.226.ptr.us.xo.net ([208.177.141.226]:10620 "EHLO
	ash.lnxi.com") by vger.kernel.org with ESMTP id S261677AbUJ1Opz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 10:45:55 -0400
Subject: Re: chicken/egg between pipefs and initramfs/hotplug
From: Thayne Harbaugh <tharbaugh@lnxi.com>
Reply-To: tharbaugh@lnxi.com
To: Andrew Morton <akpm@osdl.org>
Cc: klibc@zytor.com, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
In-Reply-To: <20041026162922.0e9f7f88.akpm@osdl.org>
References: <1098729008.19348.80.camel@tubarao>
	 <20041026162922.0e9f7f88.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-cu0WpYr4qFnG2NaD4TCj"
Organization: Linux Networx
Date: Thu, 28 Oct 2004 08:23:46 -0600
Message-Id: <1098973426.1432.41.camel@tubarao>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cu0WpYr4qFnG2NaD4TCj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Sorry to take so long to reply.

On Tue, 2004-10-26 at 16:29 -0700, Andrew Morton wrote:
> Thayne Harbaugh <tharbaugh@lnxi.com> wrote:
> >
> > It appears that linux/init/main.c:init() has a chicken/egg problem.
> > Apparently modprobe and other programs need a pipe and pipefs isn't
> > mounted until later on in do_basic_setup()/do_initcalls().  That means
> > that linux/fs/pipe.c:static struct vfsmount *pipe_mnt;  isn't
> > initialized and blows up when it's derefernced in
> > linux/fs/pipe.c:get_pipe_inode().
>=20
> That's a bit sad.  Does this fix it?
>=20
> --- 25/fs/pipe.c~a	Tue Oct 26 16:28:44 2004
> +++ 25-akpm/fs/pipe.c	Tue Oct 26 16:28:52 2004
> @@ -718,5 +718,5 @@ static void __exit exit_pipe_fs(void)
>  	mntput(pipe_mnt);
>  }
> =20
> -module_init(init_pipe_fs)
> +fs_initcall(init_pipe_fs)
>  module_exit(exit_pipe_fs)
> _

Works great, other than the omitted ';' for the fs_initcall():

--- fs/pipe.c.orig      2004-10-28 08:59:47.383192448 -0600
+++ fs/pipe.c   2004-10-28 08:57:07.746460920 -0600
@@ -718,5 +718,5 @@
        mntput(pipe_mnt);
 }

-module_init(init_pipe_fs)
+fs_initcall(init_pipe_fs);
 module_exit(exit_pipe_fs)

Thanks.

--=20
Thayne Harbaugh
Linux Networx

--=-cu0WpYr4qFnG2NaD4TCj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBgQDysYFQl3A+qS0RAnRlAJ9F9n8XMSoL76DS9abHYwcCofM1nwCeOtK7
IGQmN1RXYcNgp/P/5RJkJ3I=
=NSYs
-----END PGP SIGNATURE-----

--=-cu0WpYr4qFnG2NaD4TCj--

