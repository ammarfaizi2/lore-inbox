Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbUDYKuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbUDYKuZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 06:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbUDYKuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 06:50:25 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:22171 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S261439AbUDYKuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 06:50:10 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Bastian Blank <waldi@debian.org>
Subject: Re: page allocation failures with 2.6.5 on s390
Date: Sun, 25 Apr 2004 12:49:30 +0200
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_6e5iAKL7oce4rR0";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404251249.30368.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_6e5iAKL7oce4rR0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Bastian Blank <bastian@waldi.eu.org> wrote:
> On Sat, Apr 24, 2004 at 01:21:59PM -0700, Andrew Morton wrote:
> > Bastian Blank <bastian@waldi.eu.org> wrote:
> > > Today I see the following error message in the logs of two machines
> > > with 2.6.5 on s390, both 31 and 64 bit.
> > This is pretty much unavoidable - the kernel is looking for four
> > physically-contiguous free pages at interrupt time, and there aren't an=
y.
> > You can reduce its frequency by increasing /proc/sys/vm/min_free_kbytes.
> > The best fix would be to alter the driver to use order-0 pages if that's
> > possible.
>=20
> The pages are 4KiB large, so it allocates 16KiB at once. So the problem i=
s =3D
> rather clear:
> | 3: eth0: <BROADCAST,MULTICAST,UP> mtu 8192 qdisc pfifo_fast qlen 100

Is this the vanilla kernel? Note that 2.6.6-rc2 contains a different qeth
driver (the same that you get if you apply the 2.6.5 patches from=20
http://www10.software.ibm.com/developerworks/opensource/linux390), which
might help you here.
Getting the mtu size below 7500 could also give you relief if that causes
order-1 allocations instead of order-2

> I'm currently not sure if this was the problem causing D process. I
> reread the logs and found the following:
> | Unable to handle kernel pointer dereference at virtual kernel address 0=
00=3D
> 0000000000000

Since this is the pdflush thread that was killed, it's just a matter of time
until everything hangs.

> | Oops: 0004 [#1]
> | CPU:    0    Not tainted
> | Process pdflush (pid: 33, task: 000000000fa58e90, ksp: 000000000fa53b98)
> | Krnl PSW : 0700200180000000 00000000001022b0 (nfs3_request_init+0x34/0x=
50)
> | Krnl GPRS: 0000000000000000 0000000000000001 0000000000000000 000000000=
0000028
> |            0000000000000001 0000000000000000 0000000000001000 000000000=
672f548
> |            0000000000403620 000000000dceb600 0000000000000000 000000000=
0823020
> |            00000000061bfd00 000000000029afb8 00000000001022a0 000000000=
fa53178
> | Krnl Code: ba 54 30 00 a7 44 ff fc e3 20 c0 30 00 24 e3 40 f1 10 00 04

ba 54 30 00 means 'cs %r5,%r4,0(%r3)' and accessing %r3 failed (it contains
0x28, as you can see).

In the corresponding code (from fs/nfs/nfs3proc.c), you can see what this
means:=20
void nfs3_request_init(struct nfs_page *req, struct file *filp)
{
	req->wb_cred =3D get_rpccred(nfs_cred(req->wb_inode, filp));
}
nfs_cread(...) returns NULL, and get_rpccred(...) accesses this at
offset 0x28 with atomic_inc (aka cs).
Someone familiar with nfs needs to look into how this can happen,
but it does not appear to be s390 specific.

> | Call Trace:
> |  [nfs_create_request+216/312] nfs_create_request+0xd8/0x138
> |  [nfs_update_request+678/1236] nfs_update_request+0x2a6/0x4d4
> |  [nfs_writepage_async+44/264] nfs_writepage_async+0x2c/0x108
> |  [nfs_writepage+466/476] nfs_writepage+0x1d2/0x1dc
> |  [mpage_writepages+796/1084] mpage_writepages+0x31c/0x43c
> |  [nfs_writepages+56/196] nfs_writepages+0x38/0xc4
> |  [do_writepages+46/76] do_writepages+0x2e/0x4c
> |  [__sync_single_inode+200/744] __sync_single_inode+0xc8/0x2e8
> |  [__writeback_single_inode+246/260] __writeback_single_inode+0xf6/0x104
> |  [sync_sb_inodes+472/792] sync_sb_inodes+0x1d8/0x318
> |  [writeback_inodes+144/248] writeback_inodes+0x90/0xf8
> |  [wb_kupdate+182/324] wb_kupdate+0xb6/0x144
> |  [__pdflush+430/700] __pdflush+0x1ae/0x2bc
> |  [pdflush+46/60] pdflush+0x2e/0x3c
> |  [kthread+228/236] kthread+0xe4/0xec
> |  [kernel_thread_starter+20/28] kernel_thread_starter+0x14/0x1c

	Arnd <><

--Boundary-02=_6e5iAKL7oce4rR0
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAi5e65t5GS2LDRf4RAnCAAJ4qiEF+rwHX7ywEjtD8aaaSvKcSZwCeKCfN
U6rxtezHnHlutMuuf7KjzEM=
=vjaf
-----END PGP SIGNATURE-----

--Boundary-02=_6e5iAKL7oce4rR0--
