Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262199AbVHFHPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262199AbVHFHPi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 03:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbVHFHPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 03:15:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:13547 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262199AbVHFHP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 03:15:29 -0400
X-Authenticated: #1700068
From: Torsten Foertsch <torsten.foertsch@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Problem with smaps in 2.6.13-rc4-mm1
Date: Sat, 6 Aug 2005 09:15:22 +0200
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2173216.pICEB9ziFq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508060915.28277.torsten.foertsch@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2173216.pICEB9ziFq
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

when trying out smaps I have encountered the following problem:

> cat /proc/$P/smaps | diff - /proc/$P/smaps
239,241c239,241
< bfbaf000-bfbc4000 rw-p bfbaf000 00:00 0          [stack]
< Size:                84 kB
< Rss:                 24 kB
=2D--
> b7fc4000-b7fc6000 rwxp 00015000 08:02 12558      /lib/ld-2.3.4.so
> Size:                 8 kB
> Rss:                  8 kB
245c245
< Private_Dirty:       24 kB
=2D--
> Private_Dirty:        8 kB

=46urther investigation shows that diff reads /proc/$P/smaps in 1 kB blocks=
 as=20
do cat if stdout is a terminal. But if stdout is a pipe cat reads the file =
in=20
128 kB blocks.

The culprit is probably fs/proc/task_mmu.c:m_start(). I think it doesn't=20
properly convert the current file position.

Reading in blocks up to 3700 bytes yields the correct result. Higher block=
=20
sizes are wrong.

Is that a known problem?

Torsten

--nextPart2173216.pICEB9ziFq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBC9GOQwicyCTir8T4RAgy4AJ9jSzXqbCymYuLJSNy/KS2aobZK1gCfRpl4
H4ySr/t0JqFEINKLkB+olnc=
=qMZk
-----END PGP SIGNATURE-----

--nextPart2173216.pICEB9ziFq--
