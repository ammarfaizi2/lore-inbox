Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVBHUkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVBHUkW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 15:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVBHUkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 15:40:22 -0500
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:55211 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S261539AbVBHUkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 15:40:05 -0500
Date: Tue, 8 Feb 2005 21:39:50 +0100
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: swsusp logic error?
Message-ID: <20050208203950.GA21623@cirrus.madduck.net>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
X-OS: Debian GNU/Linux 3.1 kernel 2.6.10-1-k7 i686
X-Mailer: Mutt 1.5.6+20040907i (CVS)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I am trying to get swsusp working on a 2.6.10 Debian kernel
(2.6.10-1-686, custom compile, enabling only CONFIG_SOFTWARE_SUSPEND
and leaving CONFIG_PM_STD_PARTITION empty) on this Sony Vaio Z1RSP
Centrino 1.7 Pentium M laptop... without much success. Whenever
I enter swsusp mode, the kernel reports that it cannot find the swap
space and aborts.

I checked the code and found the following problem:

swsusp_swap_check() calls is_resume_device(..), which compares the
device specified in CONFIG_PM_STD_PARTITION and overridden by the
'resume' kernel boot parameter with the list of available swap
partitions.

IMHO, the problem is not with the swap partitions, but rather with
the handling of the resume_file variable. A dev_t is just an
integer, and to compare the devices, is_resume_device(..) converts
the device node of each swap file to a dev_t, using the MKDEV(..)
macro. For me, the swap partition is hda2, and MKDEV correctly
returns the dev_t for 3:2.

However, in is_resume_device, the resume_device variable is 0, which
translates to the 0:0 device. On inspection, this is no surprise:

resume_device is a static in swsusp.c. However, it is only ever
written once: in swsusp_read(), which is called to restore a memory
image from swap. That image can never be created because
is_resume_device(..) will always fail due to the comparison against
the (uninitialised) static resume_device.

I tried to rectify the situation by duplicating the line

  resume_device =3D name_to_dev_t(resume_file);

to the beginning of the swsusp_swap_check() function, so that it
gets set to the dev_t corresponding to the device identified in
resume_file before is_resume_device(..) is called.=20

However, name_to_dev_t(..) does more than converting a name to the
dev_t structure... in particular, it crashes the kernel when called
=66rom swsusp_swap_check(). If I execute

  echo platform >| disk; echo disk >| state

=66rom the shell (zsh), then the kernel will report a crash in the zsh
process, the top of the trace is

  [<c0134780>] swsusp_swap_check+0x30/0x100

and the corresponding disassembly is available from

  http://rafb.net/paste/results/HV8eCI97.txt

The Code at the bottom of the crash dump is 2.5 lines of 'cc cc
=2E..', and I am being told that

  <6>zsh[6632] exited with preempt_count 1.

The machine is then pretty much dead. The network interface reports
too much work at the interrupt, and I can still switch virtual
consoles, but I cannot type, and sysrq does not work.

Anyway, I have no more time to work on this, unfortunately.
Hopefully my analysis helps to solve that problem.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
spamtraps: madduck.bogus@madduck.net
=20
"there are two major products that come out of berkeley: lsd and unix.
 we don't believe this to be a coincidence."
                                                 -- jeremy s. anderson

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCCSOWIgvIgzMMSnURAr37AKCwK3u+3E7gp7Wy2M1PWFDEVF09tgCfQ8oV
JCyZll9ssW0ZKR2AW+mILaE=
=QzU+
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
