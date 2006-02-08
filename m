Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161000AbWBHHwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161000AbWBHHwa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 02:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161065AbWBHHw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 02:52:29 -0500
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:21690 "EHLO
	smtprelay03.ispgateway.de") by vger.kernel.org with ESMTP
	id S1161000AbWBHHw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 02:52:29 -0500
From: Ingo Oeser <ingo@oeser-vu.de>
To: Robert Love <rml@novell.com>
Subject: Re: [PATCH] inotify: fix one-shot support
Date: Wed, 8 Feb 2006 08:52:04 +0100
User-Agent: KMail/1.7.2
References: <200602080105.k1815her002647@hera.kernel.org>
In-Reply-To: <200602080105.k1815her002647@hera.kernel.org>
Cc: John McCutchan <ttb@tentacle.dhs.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7448104.ErZdCL93S0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602080852.18179.ingo@oeser-vu.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart7448104.ErZdCL93S0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Robert,
hi John,

just saw this commit.

On Wednesday 08 February 2006 02:05, you wrote:
> tree 5b5af4e03e627b66a9f37d25dd370a145ec72438
> parent 8e08b756869eeb08ace17ad64c2a8cb97b18e856
> author Robert Love <rml@novell.com> Wed, 08 Feb 2006 04:58:45 -0800
> committer Linus Torvalds <torvalds@g5.osdl.org> Wed, 08 Feb 2006 08:12:33=
 -0800
>=20
> [PATCH] inotify: fix one-shot support
>=20
> Fix one-shot support in inotify.  We currently drop the IN_ONESHOT flag
> during watch addition.  Fix is to not do that.
=20
Yes, but now you can add a watch without any event attached.=20
This would revert the original sense of the test.

> Signed-off-by: Robert Love <rml@novell.com>
> Cc: John McCutchan <ttb@tentacle.dhs.org>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>
>=20
>  fs/inotify.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/inotify.c b/fs/inotify.c
> index 878ccca..3041503 100644
> --- a/fs/inotify.c
> +++ b/fs/inotify.c
> @@ -967,7 +967,7 @@ asmlinkage long sys_inotify_add_watch(in
>  		mask_add =3D 1;
> =20
>  	/* don't let user-space set invalid bits: we don't want flags set */
> -	mask &=3D IN_ALL_EVENTS;
> +	mask &=3D IN_ALL_EVENTS | IN_ONESHOT;
>  	if (unlikely(!mask)) {
>  		ret =3D -EINVAL;
>  		goto out;

See, now you can just pass IN_ONESHOT behavior flag without any
events to shoot at, which you couldn't do before. But this makes only
sense, if we would like to set a multi-shot mask to one-shot now.

Does this transition (multi shot to single shot)makes sense at all?=20
Is it race-free to allow this?.

So my suggested fix instead of yours would be:

/* don't let user-space set invalid bits: we don't want flags set */
mask &=3D IN_ALL_EVENTS | IN_ONESHOT;
if (unlikely((mask & IN_ALL_EVENTS) =3D=3D 0 && !mask_add)) {
	ret =3D -EINVAL;
	goto out;
}

Would you like a patch on top of the one submitted by you?


Regards

Ingo Oeser


--nextPart7448104.ErZdCL93S0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD6aMyU56oYWuOrkARAg1ZAJ9RafuQ4Bc7XtK8R0HMYruqt4Cc7QCfdk40
r0LvIfAoF0NMzXIZdO3/TqI=
=prNV
-----END PGP SIGNATURE-----

--nextPart7448104.ErZdCL93S0--
