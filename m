Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbVJ3Ryh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbVJ3Ryh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 12:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbVJ3Ryh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 12:54:37 -0500
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:45275 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S932085AbVJ3Ryg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 12:54:36 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] swsusp: rework swsusp_suspend
Date: Sun, 30 Oct 2005 19:54:00 +0200
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@suse.cz>,
       linux-kernel@vger.kernel.org
References: <200510301637.48842.rjw@sisk.pl> <200510301640.34306.rjw@sisk.pl>
In-Reply-To: <200510301640.34306.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1347539.K1YaU4np6t";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510301854.25637.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1347539.K1YaU4np6t
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Rafael,

On Sunday 30 October 2005 16:40, Rafael J. Wysocki wrote:
> This patch makes only the functions in swsusp.c call functions in snapsho=
t.c
> and not both ways. =A0Basically, it moves the code without changing its
> functionality.
=20
This is not quite true.

>  #else
> -static int save_highmem(void) { return 0; }
> +int save_highmem(void) { return 0; }
>  int restore_highmem(void) { return 0; }
>  #endif /* CONFIG_HIGHMEM */

Here you change code, which will be optimized completely away to
an empty function, which bloats the kernel.

Please put these two functions into a local header like this:

#ifdef CONFIG_HIGHMEM
int save_highmem(void);
int restore_highmem(void);
#else
static inline int save_highmem(void) { return 0; }
static inline int restore_highmem(void) { return 0; }
#endif


That way no having no highmem means, this code is not used at all
and everything using the return code and expecting !=3D 0 is going
to be optimized away.=20

I think everyone CCed will agree here :-)


Many thanks & Regards

Ingo Oeser


--nextPart1347539.K1YaU4np6t
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDZQjRU56oYWuOrkARApInAKCbioOLodIVa3PqOkcKi7HxL19A4QCglaSD
xq0LAQBRoBPzCwmlFty/FsE=
=Sfaw
-----END PGP SIGNATURE-----

--nextPart1347539.K1YaU4np6t--
