Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVEILZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVEILZS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 07:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVEILZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 07:25:17 -0400
Received: from nysv.org ([213.157.66.145]:14227 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S261251AbVEILY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 07:24:57 -0400
Date: Mon, 9 May 2005 14:24:46 +0300
To: linux-kernel@vger.kernel.org
Cc: ck@vds.kolivas.org, Ingo Molnar <mingo@elte.hu>,
       AndrewMorton <akpm@osdl.org>, Carlos Carvalho <carlos@fisica.ufpr.br>
Subject: Re: [PATCH] implement nice support across physical cpus on SMP
Message-ID: <20050509112446.GZ1399@nysv.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mdGUb96ZZNqpHCXz"
Content-Disposition: inline
In-Reply-To: <200505072342.32997.kernel@kolivas.org>
User-Agent: Mutt/1.5.6+20040907i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mdGUb96ZZNqpHCXz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I beg to differ with Mr. Carvalho's assesment with this patch;
it works like a charm, and then some.

The rest of the message is just my analysis of the situation
ran on a Dell PowerEdge 2850, dual hyperthread Xeon EM64Ts, with
Debian Pure64 Sarge installed.

Mr. Carvalho, is the program you tested a failure with open, or
is it possible for me to have the code and try to reproduce this
nevertheless?

My two cents say this is going in :)

And on replying, anyone, please keep me in the Cc, as I'm not
subscribed.

The rest of this message is just the "raw" data on my experiment.

$ cat load.sh
#!/bin/sh

if [ $1 ] && [ -n $1 ]; then
  count=3D$1
else
  count=3D1
fi

cur=3D0
while [ $cur -lt $count ]; do
  cur=3D$[ $cur + 1 ]
  if [ $cur -eq $[ $count-1 ] ] || [ $cur -eq $count ]; then
    nice -n 19 load_base.sh &
  else
    load_base.sh &
  fi
done

$ cat load_base.sh=20
#!/bin/sh

while true; do a=3D1; done


$ ./load.sh 5
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND       =
    =20
 3918 mjt       34   0  5660 1136  936 R 99.9  0.0   1:34.30 load_base.sh  =
    =20
 3917 mjt       35   0  5660 1136  936 R 99.5  0.0   1:34.30 load_base.sh  =
    =20
 3916 mjt       34   0  5660 1136  936 R 59.7  0.0   0:53.16 load_base.sh  =
    =20
 3919 mjt       39  19  5660 1136  936 R  6.0  0.0   0:05.97 load_base.sh  =
    =20
 3920 mjt       39  19  5660 1136  936 R  3.0  0.0   0:02.62 load_base.sh

  PID USER      PR  NI  VIRT  SHR S %CPU %MEM    TIME+  #C COMMAND         =
    =20
 3917 mjt       26   0  5660  936 R 99.9  0.0   3:37.61  0 load_base.sh    =
    =20
 3918 mjt       25   0  5660  936 R 99.9  0.0   3:37.60  3 load_base.sh    =
    =20
 3916 mjt       26   0  5660  936 R 52.7  0.0   2:02.37  2 load_base.sh    =
    =20
 3919 mjt       39  19  5660  936 R  7.0  0.0   0:13.80  1 load_base.sh    =
    =20
 3920 mjt       39  19  5660  936 R  3.0  0.0   0:06.05  2 load_base.sh

top - 11:09:24 up 15:30,  2 users,  load average: 4.99, 3.55, 1.63
  PID USER      PR  NI  VIRT  SHR S %CPU %MEM    TIME+  #C COMMAND         =
    =20
 3917 mjt       25   0  5660  936 R 99.6  0.0   6:11.35  0 load_base.sh    =
    =20
 3918 mjt       24   0  5660  936 R 99.6  0.0   6:11.34  3 load_base.sh    =
    =20
 3916 mjt       39   0  5660  936 R 65.7  0.0   3:28.95  2 load_base.sh    =
    =20
 3919 mjt       39  19  5660  936 R  7.0  0.0   0:23.54  1 load_base.sh    =
    =20
 3920 mjt       39  19  5660  936 R  3.0  0.0   0:10.33  2 load_base.sh

top - 11:10:57 up 15:32,  2 users,  load average: 4.99, 3.94, 1.95
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND       =
    =20
 3917 mjt       22   0  5660 1136  936 R 99.5  0.0   7:51.62 load_base.sh  =
    =20
 3918 mjt       21   0  5660 1136  936 R 99.5  0.0   7:51.61 load_base.sh  =
    =20
 3916 mjt       39   0  5660 1136  936 R 53.7  0.0   4:25.26 load_base.sh  =
    =20
 3919 mjt       39  19  5660 1136  936 R  7.0  0.0   0:29.92 load_base.sh  =
    =20
 3920 mjt       39  19  5660 1136  936 R  3.0  0.0   0:13.13 load_base.sh

top - 11:12:32 up 15:33,  2 users,  load average: 4.99, 4.22, 2.24
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  #C COMMAND    =
    =20
 3917 mjt       35   0  5660 1136  936 R 99.9  0.0   9:28.56  0 load_base.s=
h   =20
 3918 mjt       34   0  5660 1136  936 R 99.5  0.0   9:28.54  3 load_base.s=
h   =20
 3916 mjt       35   0  5660 1136  936 R 61.7  0.0   5:19.77  2 load_base.s=
h   =20
 3919 mjt       39  19  5660 1136  936 R  6.0  0.0   0:36.07  1 load_base.s=
h   =20
 3920 mjt       39  19  5660 1136  936 R  3.0  0.0   0:15.82  2 load_base.sh

$ ./load.sh 7
top - 11:13:49 up 15:35,  2 users,  load average: 5.17, 4.40, 2.45
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  #C COMMAND    =
    =20
 3952 mjt       29   0  5660 1140  936 R 99.9  0.0   0:33.53  2 load_base.s=
h   =20
 3950 mjt       31   0  5660 1140  936 R 99.5  0.0   0:33.33  1 load_base.s=
h   =20
 3953 mjt       30   0  5660 1140  936 R 55.7  0.0   0:16.82  3 load_base.s=
h   =20
 3951 mjt       39   0  5660 1140  936 R 43.8  0.0   0:16.70  3 load_base.s=
h   =20
 3949 mjt       39   0  5660 1140  936 R 23.9  0.0   0:13.18  0 load_base.s=
h   =20
 3954 mjt       39  19  5660 1140  936 R  2.0  0.0   0:00.64  0 load_base.s=
h   =20
 3955 mjt       39  19  5660 1140  936 R  2.0  0.0   0:00.64  0 load_base.s=
h   =20

top - 11:14:53 up 15:36,  2 users,  load average: 6.38, 4.91, 2.76
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  #C COMMAND    =
    =20
 3950 mjt       23   0  5660 1140  936 R 99.9  0.0   1:39.67  1 load_base.s=
h   =20
 3952 mjt       21   0  5660 1140  936 R 99.9  0.0   1:39.87  2 load_base.s=
h   =20
 3951 mjt       39   0  5660 1140  936 R 52.7  0.0   0:49.91  3 load_base.s=
h   =20
 3953 mjt       22   0  5660 1140  936 R 47.8  0.0   0:49.95  3 load_base.s=
h   =20
 3949 mjt       39   0  5660 1140  936 R 43.8  0.0   0:38.70  0 load_base.s=
h   =20
 3954 mjt       39  19  5660 1140  936 R  2.0  0.0   0:01.90  0 load_base.s=
h   =20
 3955 mjt       39  19  5660 1140  936 R  2.0  0.0   0:01.90  0 load_base.sh

--=20
mjt


--mdGUb96ZZNqpHCXz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCf0h+IqNMpVm8OhwRAluaAJ0afGc2Bf/v/W3Tp9ALMhwzf6McFwCgiToy
nbnTVOdZqjvyai1aMwP9Jlg=
=kpvg
-----END PGP SIGNATURE-----

--mdGUb96ZZNqpHCXz--
