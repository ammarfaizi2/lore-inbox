Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbUDYISu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbUDYISu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 04:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262962AbUDYISu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 04:18:50 -0400
Received: from wavehammer.waldi.eu.org ([82.139.196.55]:36507 "EHLO
	extern.mail.waldi.eu.org") by vger.kernel.org with ESMTP
	id S261865AbUDYISr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 04:18:47 -0400
Date: Sun, 25 Apr 2004 10:18:45 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Re: page allocation failures with 2.6.5 on s390
Message-ID: <20040425081845.GE28032@wavehammer.waldi.eu.org>
Mail-Followup-To: Bastian Blank <bastian@waldi.eu.org>,
	linux-kernel@vger.kernel.org
References: <20040424183711.GC28032@wavehammer.waldi.eu.org> <20040424132159.7cae4f54.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5xSkJheCpeK0RUEJ"
Content-Disposition: inline
In-Reply-To: <20040424132159.7cae4f54.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5xSkJheCpeK0RUEJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 24, 2004 at 01:21:59PM -0700, Andrew Morton wrote:
> Bastian Blank <bastian@waldi.eu.org> wrote:
> > Today I see the following error message in the logs of two machines
> > with 2.6.5 on s390, both 31 and 64 bit.
> This is pretty much unavoidable - the kernel is looking for four
> physically-contiguous free pages at interrupt time, and there aren't any.
> You can reduce its frequency by increasing /proc/sys/vm/min_free_kbytes.
> The best fix would be to alter the driver to use order-0 pages if that's
> possible.

The pages are 4KiB large, so it allocates 16KiB at once. So the problem is =
rather clear:
| 3: eth0: <BROADCAST,MULTICAST,UP> mtu 8192 qdisc pfifo_fast qlen 100

> > It causes a lot of state-D processes on one machine.
> This should not happen.  If it happens again, try to capture an all-task
> backtrace into the logs with
> 	echo t > /proc/sysrq-trigger

I'm currently not sure if this was the problem causing D process. I
reread the logs and found the following:
| Unable to handle kernel pointer dereference at virtual kernel address 000=
0000000000000
| Oops: 0004 [#1]
| CPU:    0    Not tainted
| Process pdflush (pid: 33, task: 000000000fa58e90, ksp: 000000000fa53b98)
| Krnl PSW : 0700200180000000 00000000001022b0 (nfs3_request_init+0x34/0x50)
| Krnl GPRS: 0000000000000000 0000000000000001 0000000000000000 00000000000=
00028
|            0000000000000001 0000000000000000 0000000000001000 00000000067=
2f548
|            0000000000403620 000000000dceb600 0000000000000000 00000000008=
23020
|            00000000061bfd00 000000000029afb8 00000000001022a0 000000000fa=
53178
| Krnl Code: ba 54 30 00 a7 44 ff fc e3 20 c0 30 00 24 e3 40 f1 10 00 04
| Call Trace:
|  [nfs_create_request+216/312] nfs_create_request+0xd8/0x138
|  [nfs_update_request+678/1236] nfs_update_request+0x2a6/0x4d4
|  [nfs_writepage_async+44/264] nfs_writepage_async+0x2c/0x108
|  [nfs_writepage+466/476] nfs_writepage+0x1d2/0x1dc
|  [mpage_writepages+796/1084] mpage_writepages+0x31c/0x43c
|  [nfs_writepages+56/196] nfs_writepages+0x38/0xc4
|  [do_writepages+46/76] do_writepages+0x2e/0x4c
|  [__sync_single_inode+200/744] __sync_single_inode+0xc8/0x2e8
|  [__writeback_single_inode+246/260] __writeback_single_inode+0xf6/0x104
|  [sync_sb_inodes+472/792] sync_sb_inodes+0x1d8/0x318
|  [writeback_inodes+144/248] writeback_inodes+0x90/0xf8
|  [wb_kupdate+182/324] wb_kupdate+0xb6/0x144
|  [__pdflush+430/700] __pdflush+0x1ae/0x2bc
|  [pdflush+46/60] pdflush+0x2e/0x3c
|  [kthread+228/236] kthread+0xe4/0xec
|  [kernel_thread_starter+20/28] kernel_thread_starter+0x14/0x1c

Bastian

--=20
Insults are effective only where emotion is present.
		-- Spock, "Who Mourns for Adonais?"  stardate 3468.1

--5xSkJheCpeK0RUEJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iEYEARECAAYFAkCLdGUACgkQnw66O/MvCNHktACfblJZz252VXQp+NM3pZ3TVvHl
fRsAnAvOQ+NculgzsSBQVEB4Shm5oWJ/
=YEJA
-----END PGP SIGNATURE-----

--5xSkJheCpeK0RUEJ--
