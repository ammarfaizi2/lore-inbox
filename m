Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264920AbTBYCOv>; Mon, 24 Feb 2003 21:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264940AbTBYCOv>; Mon, 24 Feb 2003 21:14:51 -0500
Received: from ool-182f525d.dyn.optonline.net ([24.47.82.93]:21475 "EHLO
	j0nah.ath.cx") by vger.kernel.org with ESMTP id <S264920AbTBYCOr>;
	Mon, 24 Feb 2003 21:14:47 -0500
Date: Mon, 24 Feb 2003 16:25:30 -0500
From: Jonah Sherman <jsherman@stuy.edu>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] 2.5.63 - NULL pointer dereference in loop device
Message-ID: <20030224212530.GA631@j0nah.ath.cx>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--K8nIJk4ghYZn606h
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have come across a bug in the loop driver.  To reproduce this bug,
simply do:
losetup /dev/loop0 /dev/[sh]da(some unused partition)
dd if=3D/dev/zero of=3D/dev/loop0
If you use the count/bs args for dd, or just wait for it to write alot
with the above command, you will notice that once it writes more
than the free amount of RAM, you will get the following oops.
The strange thing is, this ONLY occurs when attaching the loop device=20
to another block device(well, I only tested with an unused partition);=20
this bug does NOT occur if the loop target is a regular file on the
filesystem.  I'm a very newbie kernel hacker, so I am not able to create
a patch to fix this.  However, I did trace the oops to
drivers/block/loop.c:loop_get_buffer(): (kernel 2.5.63, however same
bug is in 2.5.62, I don't know when it was first introduced)

bio=3Dbio_copy(rbh,GFP_NOIO,rbh->bi_rw & WRITE); // This returns NULL
bio->bi_end_io =3D loop_end_io_transfer; // Making this crash

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=oops
Content-Transfer-Encoding: quoted-printable

Unable to handle kernel NULL pointer dereference at virtual address 00000028
 printing eip:
c02298bb
*pde =3D 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c02298bb>]    Not tainted
EFLAGS: 00010282
EIP is at loop_get_buffer+0x5b/0x70
eax: 00000000   ebx: c0511160   ecx: c0511120   edx: c7fec910
esi: c114a000   edi: c114a110   ebp: c5af7a2c   esp: c5af7a18
ds: 007b   es: 007b   ss: 0068
Process dd (pid: 221, threadinfo=3Dc5af6000 task=3Dc748a6c0)
Stack: c0511160 00000010 00000001 c114a000 00000001 c5af7a50 c0229b06 c114a=
000=20
       c0511160 c7feee20 00000000 c7ed13c0 00000001 c114a110 c5af7a84 c021d=
83d=20
       c114a110 c0511160 00000010 00000001 c5af7a6c 00000000 c61fc460 00005=
13b=20
Call Trace:
 [<c0229b06>] loop_make_request+0xd6/0x170
 [<c021d83d>] generic_make_request+0x13d/0x1d0
 [<c021d90d>] submit_bio+0x3d/0x80
 [<c01529c7>] __block_write_full_page+0x207/0x3e0
 [<c0154125>] block_write_full_page+0xd5/0xe0
 [<c0156d20>] blkdev_get_block+0x0/0x60
 [<c0156e80>] blkdev_writepage+0x20/0x30
 [<c0156d20>] blkdev_get_block+0x0/0x60
 [<c013e86c>] shrink_list+0x3cc/0x610
 [<c0124815>] add_timer+0x95/0xb0
 [<c013d679>] __pagevec_release+0x29/0x40
 [<c013ec0a>] shrink_cache+0x15a/0x2d0
 [<c013f39e>] shrink_caches+0x9e/0xc0
 [<c013f435>] try_to_free_pages+0x75/0xe0
 [<c0138f28>] __alloc_pages+0x1b8/0x2c0
 [<c0137b03>] __grab_cache_page+0x43/0xa1
 [<c0137018>] generic_file_aio_write_nolock+0x228/0x7b0
 [<c021bd58>] blk_rq_map_sg+0xf8/0x170
 [<c02464a9>] __ide_dma_begin+0x39/0x50
 [<c0137618>] generic_file_write_nolock+0x78/0x90
 [<c012d1d8>] rcu_process_callbacks+0xe8/0x110
 [<c01212e6>] tasklet_action+0x46/0x70
 [<c010bce8>] do_IRQ+0x108/0x130
 [<c010a6e0>] common_interrupt+0x18/0x20
 [<c0157ea3>] blkdev_file_write+0x33/0x40
 [<c014fb3f>] vfs_write+0xaf/0x120
 [<c014fc4c>] sys_write+0x3c/0x60
 [<c010a573>] syscall_call+0x7/0xb

Code: c7 40 28 d0 97 22 c0 89 c2 89 58 30 eb b1 8d b4 26 00 00 00=20

--17pEHd4RhPHOinZp--

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+Wo3KflGtzWCyItURAlmmAJ45gqBvxMkefOMFjXaQM4i16M+C5wCgxPHi
FKkX64TKgC5YO6lYC6tRXLk=
=oWAU
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--
