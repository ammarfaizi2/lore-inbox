Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWBZNIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWBZNIL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 08:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWBZNIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 08:08:11 -0500
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:61924 "EHLO
	smtprelay04.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751105AbWBZNIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 08:08:10 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Drastic Slowdown of 'fseek()' Calls From 2.4 to 2.6 -- VMM Change?
Date: Sun, 26 Feb 2006 14:07:18 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Marr <marr@flex.com>,
       reiserfs-dev@namesys.com
References: <200602241522.48725.marr@flex.com> <20060224211650.569248d0.akpm@osdl.org>
In-Reply-To: <20060224211650.569248d0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1174484.iinH1vAGvU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602261407.33262.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1174484.iinH1vAGvU
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday, 25. February 2006 06:16, Andrew Morton wrote:
> runs like a dog on 2.6's reiserfs.  libc is doing a (probably) 128k read
> on every fseek.

Thats the bug. If I seek, I never like to have an read issued.
seek should just return whether the result is a valid offset=20
in the underlying object.=20

It is perfectly valid to have a real time device which produces data=20
very fast and where you are allowed to skip without reading anything.

This device coul be a pipe, which just allows forward seeking for exactly
this (implemented by me some years ago).

> - fseek is a pretty dumb function anyway - you're better off with
>   stateless functions like pread() - half the number of syscalls, don't
>   have to track where the file pointer is at.  I don't know if there's a
>   pread()-like function in stdio though?

pread and anything else not using RELATIVE descriptor offsets are not
very useful for pipe like interfaces that can seek, but just forward.

There are even cases, where you can seek forward and backward, but=20
only with relative offsets ever, because you have a circular buffer indexed=
 by time.
If you like to get the last N minutes, the relative index is always stable,=
=20
but the absolute offset jumps.

So I hope glibc will fix fseek to work as advertised.

But for the simple file case all your answers are valid.

Regards

Ingo Oeser

--nextPart1174484.iinH1vAGvU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBEAagVU56oYWuOrkARAlpfAKCiWxhWXFgIIC9KeSdTWhKyH9bCpACbBF7k
WbfC6SjhW39e+m5eVg765os=
=qOsl
-----END PGP SIGNATURE-----

--nextPart1174484.iinH1vAGvU--
