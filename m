Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbVILSqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbVILSqX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 14:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbVILSqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 14:46:23 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:62435 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932133AbVILSqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 14:46:22 -0400
Message-Id: <200509121846.j8CIk5YE025124@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Assar <assar@permabit.com>
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH] nfs client, kernel 2.4.31: readlink result overflow 
In-Reply-To: Your message of "Mon, 12 Sep 2005 09:26:28 EDT."
             <78irx6wh6j.fsf@sober-counsel.permabit.com> 
From: Valdis.Kletnieks@vt.edu
References: <78irx6wh6j.fsf@sober-counsel.permabit.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1126550764_2852P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Sep 2005 14:46:05 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1126550764_2852P
Content-Type: text/plain; charset=us-ascii

On Mon, 12 Sep 2005 09:26:28 EDT, Assar said:
> In 2.4.31, the v2/3 nfs readlink accepts too long symlinks.
> I have tested this by having a server return long symlinks.
> 2.6.13 does not to my reading have this problem.

Odd, as it has similar code - 2.6.13-mm1 nfs2xdr.c has:
        /* Convert length of symlink */
        len = ntohl(*p++);
        if (len >= rcvbuf->page_len || len <= 0) {

Is there some *other* code in 2.6 that prevents this from being a problem,
if it's a problem on 2.4?

> diff -u linux-2.4.31.orig/fs/nfs/nfs2xdr.c linux-2.4.31/fs/nfs/nfs2xdr.c
> --- linux-2.4.31.orig/fs/nfs/nfs2xdr.c	2002-11-28 18:53:15.000000000 -0500
> +++ linux-2.4.31/fs/nfs/nfs2xdr.c	2005-09-07 17:36:04.000000000 -0400
> @@ -571,8 +571,8 @@
>  	strlen = (u32*)kmap(rcvbuf->pages[0]);
>  	/* Convert length of symlink */
>  	len = ntohl(*strlen);
> -	if (len > rcvbuf->page_len)
> -		len = rcvbuf->page_len;
> +	if (len > rcvbuf->page_len - 1 - 4)
> +		len = rcvbuf->page_len - 1 - 4;

Am I the only one who finds an uncommented "-1 -4" construct scary beyond belief?


--==_Exmh_1126550764_2852P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDJczscC3lWbTT17ARAnwZAJoDyAhVHTm9PWi8sJo+2mT1CDapywCgovZ4
bFhXOuUAuVvoGWaUUINp/nw=
=6HYA
-----END PGP SIGNATURE-----

--==_Exmh_1126550764_2852P--
