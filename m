Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWGRN5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWGRN5l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 09:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWGRN5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 09:57:40 -0400
Received: from orca.ele.uri.edu ([131.128.51.63]:25033 "EHLO orca.ele.uri.edu")
	by vger.kernel.org with ESMTP id S932212AbWGRN5k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 09:57:40 -0400
Date: Tue, 18 Jul 2006 09:58:17 -0400
From: Will Simoneau <simoneau@ele.uri.edu>
To: linux-kernel@vger.kernel.org
Cc: grsecurity@grsecurity.net
Subject: kdeinit causes scheduling while atomic
Message-ID: <20060718135817.GA21666@ele.uri.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
User-Agent: Mutt/1.5.11 [Linux 2.6.17.6-grsec-b0rg i686]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A scheduling while atomic just started showing up in the kernel log on
my machine, which unfortunately is running an odd combination of
non-vanilla patches. Maybe someone who knows at least some of the code
can give me some hints tracking this down? Or maybe the grsecurity folks
have an idea?

Patches applied on top of 2.6.17.6:
grsecurity-2.1.9-2.6.17.4-200607120947
suspend2-2.2.7-for-2.6.17 (without 9920-linus-basic-trace - that plus
grsecurity gives rejects on vmlinux.lds.S)

System is running Gentoo, the compiler is gcc 3.4.6 with pie & ssp
although those features are turned off when compiling a kernel by the
specs file. Userland is compiled with -fstack-protector, and I am using
SEGMEXEC for userland NX support.

I have two different traces and some PaX output, here they all are:
---cut here---
BUG: scheduling while atomic: kdeinit/0x00000002/31816
 <c0345c9c> schedule+0x53e/0x674  <c0346657> schedule_timeout+0x4d/0x9a
 <c0152a12> process_timeout+0x0/0x5  <c0145954> sched_fork+0x51/0x86
 <c01483aa> copy_process+0x614/0xdea  <c0148c66> do_fork+0x75/0x1b2
 <c019864d> vfs_write+0xec/0x16e  <c012dbf5> sys_clone+0x32/0x36
 <c012f057> syscall_call+0x7/0xb  <c012007b> init_script_binfmt+0x6/0xa
---end cut----

---cut here---
BUG: scheduling while atomic: kdeinit/0x00000002/31816
 <c0345c9c> schedule+0x53e/0x674  <c0346657> schedule_timeout+0x4d/0x9a
 <c0152a12> process_timeout+0x0/0x5  <c0145954> sched_fork+0x51/0x86
 <c01483aa> copy_process+0x614/0xdea  <c0148c66> do_fork+0x75/0x1b2
 <c012dbf5> sys_clone+0x32/0x36  <c012f057> syscall_call+0x7/0xb
 <c013007b> irq_entries_start+0xecb/0xef0=20
---end cut----

---cut here---
PAX: execution attempt in: <NULL>, 00000000-00000000 00000000
PAX: terminating task: /usr/kde/3.5/bin/konqueror(konqueror):21177, uid/eui=
d: 1000/1000, PC: 00000010, SP: 5953cf80
PAX: bytes at PC: ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? =
??=20
PAX: bytes at SP-4: 00000010 00000003 5953cfb0 00000000 0000000a 0000001c 4=
0488ef8 0000001d 5618e6e0 40083d30 00000000 00000003 55efdb83 40189c00 5610=
8d92 56b09377 5618e6e0 5953d000 00000006 404eadb8 55f2bef8=20
---end cut----

Call of a null function pointer?

Sometimes konqueror is killed by PaX, sometimes it dies on its own (I
think with a segfault). I can reproduce this 100% of the time by firing
up Konqueror and going to www.wikipedia.org, just before the front page
loads the window dissapears and leave those traces behind. Other sites
seem to work fine. The process either segfaults or is killed by PaX
immediately after causing the scheduling while atomic.

In the terminal where I start konqueror I see this (when PaX does the
killing):

---cut here---
Try to load libthai dynamically...
Error, can't load libthai...
zsh: killed     konqueror
---end cut----

=2E.. which seems to be an old unsolved bug in qt.

Do I or anybody else have any hope of tracking this down? It almost
sounds like an interaction of multiple bugs.

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iD8DBQFEvOj5LYBaX8VDLLURAlvlAJ9sBXxJpgW/f4CThg1k40S0ZdZBFwCfYgpd
wHIKhyEpDw101SkEF0kxl1o=
=QrWC
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
