Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752808AbWKCKKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808AbWKCKKN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 05:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752809AbWKCKKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 05:10:13 -0500
Received: from mail.cvg.de ([62.153.82.30]:6035 "EHLO mail.cvg.de")
	by vger.kernel.org with ESMTP id S1752808AbWKCKKL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 05:10:11 -0500
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, rpurdie@rpsys.net
Subject: [ARM] Corrupted .got section with 2.6.18 and JFFS2 (solved)
References: <ly1wozcr1d.fsf@ensc-pc.intern.sigma-chemnitz.de>
	<ly64dyt7de.fsf@ensc-pc.intern.sigma-chemnitz.de>
	<1162497112.12781.51.camel@localhost.localdomain>
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Date: Fri, 03 Nov 2006 11:09:35 +0100
In-Reply-To: <1162497112.12781.51.camel@localhost.localdomain> (Richard Purdie's message of "Thu, 02 Nov 2006 19:51:51 +0000")
Message-ID: <lywt6cc04g.fsf_-_@ensc-pc.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Spam-Score: -2.6
X-Spam-Tests: AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

[CC lkml; original issue at
 http://article.gmane.org/gmane.linux.ports.arm.kernel/28068]

rpurdie@rpsys.net (Richard Purdie) writes:

>> > I have a problem with JFFS2 filesystem and kernel 2.6.18. When
>> > starting a program which uses a certain library (libutil.so.1 in
>> > my case), the .got section of the library can be initialized
>> > wrongly when the used memory is uninitialized.
>>=20
>> Problem seems to be caused by
>>=20
>> | [PATCH] zlib_inflate: Upgrade library code to a recent version
>>=20
>> (4f3865fb57a04db7cca068fed1c15badc064a302)
>>=20
>> After reverting this (and related patches), things seem to work.
>>=20
>> I don't have an idea yet, which changes in this complex patch are
>> really responsible....
>
> I'm the author of the above change. I just ran your test program
> on a device (ARM PXA255 with 2.6.19-rc4 kernel, 2.3.5ish glibc,
> gcc 3.4.4, libraries on jffs2) and I can't reproduce the
> problem.

I can reproduce it 100% with:

$ git checkout -b test v2.6.17.14
$ git-am -3 tmp/000[1-8]*
  (see https://www.cvg.de/people/ensc/libutil/ for patches and
   used .config (config.txt); the physmap patches are from 2.6.18)
$ make tftp

=2D-> 'fillmem ; test' sequences work without errors


$ git-cherry-pick 4f3865fb57a04db7cca068fed1c15badc064a302
$ make tftp

=2D-> 'fillmem ; test' sequences stop with a segfault

I compiled kernel both with gcc-3.4.6 and gcc-4.1.1 and got same
results.


Same results when using recent 2.6.18.1 kernel and reverting all
patches which modified lib/zlib_*.

I see segfaults too with 2.6.19-rc4 but did not checked yet
whether removal of zlib patch solved them.


Things are getting yet more strange when using the glibc-2.5
dynamic loader:

| # ... copying ld-2.5.so and libc-2.5.so ...
| # LD_LIBRARY_PATH=3D`pwd` ./ld-2.5.so /bin/test2
| Inconsistency detected by ld.so: dynamic-link.h: 169: elf_get_dynamic_inf=
o: Assertion `info[19]->d_un.d_val =3D=3D sizeof (Elf32_Rel)' failed!
| # LD_LIBRARY_PATH=3D`pwd` ./ld-2.5.so /bin/test2
| Segmentation fault
| # LD_LIBRARY_PATH=3D`pwd` ./ld-2.5.so /bin/test2
| #


> You mentioned elsewhere that reading the lib from flash gives
> consistent md5sums. There is only one inflation code path and
> if the md5sum is always consistent, I can't see how the the
> inflation code is at fault. I therefore strongly suspect this
> is some userspace issue when handling the got.

Issue:

* seems to be triggered by the zlib kernel patch
* seems to be triggered by my 'libutil.so' (I can not see it with
  other libraries)
* can be reproduced on two different PXA270 platforms (same
  userspace, but different module vendors and different memory
  timing setups)


I see the following reasons:

* new zlib code has sideeffects (overflows?)
* new zlib code is so fast that it triggers a race somewhere else
* libutil.so's .init section is buggy (likely, but why does the
  error not occur when libutil.so is on tmpfs or NFS?)
* new zlib code requires more/less memory bandwidth, changes
  power consumption of CPU/memory which is causing random errors
  (unlikely because only same part of .got table is affected and
  it happens on two different platforms)
* some DCACHE issue


> Which other related patches did you remove?

For 2.6.18 tests, I reverted only the patches which changed
lib/zlib_* after 2.6.17:

| 31925c8857ba17c11129b766a980ff7c87780301 [PATCH] Fix ppc32 zImage inflate
| b762450e84e20a179ee5993b065caaad99a65fbf [PATCH] zlib inflate: fix functi=
on definitions
| 0ecbf4b5fc38479ba29149455d56c11a23b131c0 move acknowledgment for Mark Adl=
er to CREDITS
| 4f3865fb57a04db7cca068fed1c15badc064a302 [PATCH] zlib_inflate: Upgrade li=
brary code to a recent version




Enrico

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQEVAwUARUsVaAc3PX/XHFA7AQr7Dwf/bhIaevehd36LDXrsL7mOZ+alfyRWfHDL
867csUOFGU1yScuE5I+EKpDFoOQQGZrNTn5l1yDvoQVYDRFM7MynR+PCf2P9Dh8G
tkOyjZhgRpzdILT0oQcoKBrJLYBLHT7Kn6kCoq0oYdLQSL9MsH2DXGo8riUGpqI9
0PXRdqUMgfuFaTr2a/UlfjcwFpDgHjopXnGGPANrX0Z090yyk9W9ySWRol2sAsrZ
EYPM2LaFYtntUXBvdkZH4Loj4at3dzw5ehkoQ4qDyIM9/A2rRxK7PyL153kns56e
2zYXns6v22MeTUNGs3mJhZOujae6h/irutCestn5x18ApQ6XRE/Vqw==
=Tp7g
-----END PGP SIGNATURE-----
--=-=-=--
