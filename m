Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133110AbRDZFie>; Thu, 26 Apr 2001 01:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133116AbRDZFiZ>; Thu, 26 Apr 2001 01:38:25 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:5504 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S133110AbRDZFiG>; Thu, 26 Apr 2001 01:38:06 -0400
Date: Thu, 26 Apr 2001 00:38:02 -0500
From: Bob McElrath <rsmcelrath@students.wisc.edu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: it isn't aa's rwsem-generic-6 bug but something else [Re: aa's rwsem-generic-6 bug?  Process stuck in 'R' state.]
Message-ID: <20010426003802.A738@draal.physics.wisc.edu>
In-Reply-To: <20010425223939.A26763@draal.physics.wisc.edu> <20010426061110.A819@athlon.random>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010426061110.A819@athlon.random>; from andrea@suse.de on Thu, Apr 26, 2001 at 06:11:10AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Andrea Arcangeli [andrea@suse.de] wrote:
> On Wed, Apr 25, 2001 at 10:39:39PM -0500, Bob McElrath wrote:
> > Running 2.4.4pre4 with Andrea's rwsem-generic-6 patch, I have just
> > gotten a process stuck in the 'R' state.  According to the ps man page
> > this is: "runnable (on run queue)".  The 'ps aux' output is:
> > USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
> > root      7921  0.8 26.9 91720 68608 ?       R<   00:33  11:20 /usr/X11=
R6/bin/X
> >=20
> > X is niced at -10 and doesn't respond to kill or kill -9.
> >=20
> > alpha 21164 (ev56) architecture.  kernel compiled with:
> > gcc version 2.96 20000731 (Red Hat Linux 7.0)
>=20
> The fact X is also part of the equation makes things even less obvious
> (now we're not even sure it's a kernel bug).

Tell me about it.  But the fact remains that I never see these hangs
with a 2.2 kernel.  I've also futzed with X quite a bit to try and track
this down, to no avail.  I have tracked down some separate X bugs
though.  In the next iteration I'll use the mga driver from XFree86 CVS
(which had some alpha-specific changes, I hear).

During this last hang I tried to get gdb to attach to the X process.
gdb hung after issuing 'attach 7921', and had to be killed.  My naive
interpretation is that this indicates a kernel problem, and nothing to
do with X.

Egad I wish this were more reproducible.  Having a hang once every 3
days sucks for debugging.=20

> generic-rwsem-6 is a very trivial implementation and I'm pretty sure it
> is the _last_ thing that could go wrong in your equation. I mean if it
> goes wrong then it's more likely to be a bug in the spinlocks or
> whatever in the architectural part of the kernel than in the common code
> (rwsem-generic-6 was all common code btw).
>=20
> Furthmore the X server shouldn't really be such an heavy user of the
> rwsemaphores, as first it's not even threaded.

When I posted this bug originally, you came right out and said it was
probably the rwsemaphores.  I really have no idea how the rwsemaphores
work, and don't know myself that they are even the problem.  My
process-table-hang seems consistent with something having a lock on the
process table and not letting go of it.  (Note in this last "hang", the
process table did not hang...that is, ps dumped the entire process list
without a burp)

> You can also press SYSRQ+P and get some EIP so we see a bit more what's
> going on with the X server (assuming such cpu still receives interrupt).

The CPU still receives interrupts, and other than this one X process,
acts normally.  (even in the process-table-hang-case...as long as I
don't run ps, everything is fine)  I had to reboot to get rid of the
hung X process though.  (shutdown proceeded normally)

I'm running a debug X build at this point, and have identified at least
two separate bugs in the X server that were causing hangs.  I've
reported these to the X people.  I didn't get debug info out of the X
server after the process-table-hang because X continued to behave
normally during the process-table-hang.

> BTW, could you also try to compile with egcs 1.1.2 just in case? I
> learnt the hard way that for the alpha gcc 2.95.* isn't going to work
> well (I didn't tried official 95.3 exactly yet, but certainly an older .3
> from the 2_95-branch of gcc cvs definitely miscompiled all my 2.4
> kernels, 2.96 with some houndred of patches [literally] is certainly
> better than 2.95.* on the alpha but egcs is definitely still worth a
> try) (personally I'm using egcs 1.1.2 for the 2.[24] alpha kernels and
> 2.95.4 (2_95-branch of cvs) for the 2.[24] x86 kernels [and gcc 3.1 for
> x86-64 ;])

I have been using egcs 1.1.2 (rh7 kgcc) Only this last hang was with a
2.96-compiled kernel (I forgot to change the makefile to use kgcc
instead of gcc...then figured what the hell)  The rest were with egcs
1.1.2.  I'll use egcs 1.1.2 in the future.

Cheers,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjrntDoACgkQjwioWRGe9K2+OgCaAr8MoJ3WwOM9zjC2qrN7+i2w
FSkAn0DooJ6g2CxrGfn0X832tyHfGg/i
=e/Dg
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
