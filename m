Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267251AbUJRSd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267251AbUJRSd7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 14:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267415AbUJRSa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 14:30:28 -0400
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:24983 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S267251AbUJRS16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 14:27:58 -0400
Subject: NFS4 client deadlock with 2.6.9-rc3-mm4 based kernel
From: Christophe Saout <christophe@saout.de>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-NxSsi72WqiTWttrlABLN"
Date: Mon, 18 Oct 2004 20:27:46 +0200
Message-Id: <1098124066.13075.5.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NxSsi72WqiTWttrlABLN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I've managed to lock up the nfs4 client code in an nfs4 chroot
environment.

I'm not sure but it seems that __rpc_execute has a problem when called
recursively...?

The kernel is mostly a 2.6.9-rc3-mm4, but Ingo's BKL-semaphore patch has
been omitted. This kernel hasn't shown any other lockups since -rc3-mm4
was released on several machines (all UP, PREEMPT) so I'm assuming it's
not my fault, please tell me if I'm wrong.

This is SysRq-T trace of all processes involved in the lockup:

rpciod/0      D C986C000     0 14500      5                 722 (L-TLB)
c986dcfc 00000046 00000000 c986c000 00000000 cfcc6a00 00000282 c041abd4=20
00000000 cf8334c0 cfcc6ad0 00000000 04d1a300 000f4406 c57f51b0 cf8334c0=20
c986dd48 cf83354c c986dd74 c041b225 ca0ca780 00000000 ca0cab00 c986c000=20
Call Trace:
[<c041b225>] __rpc_execute+0x1b5/0x460
[<c0416af7>] rpc_call_sync+0x87/0xa0
[<c02299d7>] _nfs4_do_close+0xb7/0xf0
[<c0229a63>] nfs4_do_close+0x53/0x90
[<c023688a>] nfs4_close_state+0x15a/0x170
[<c0219e2c>] put_nfs_open_context+0x3c/0x50
[<c021d8aa>] nfs_release_request+0x2a/0x50
[<c021f66e>] nfs_readpage_release+0x2e/0xb0
[<c021fe72>] nfs_readpage_result_full+0xc2/0x120
[<c021ff4c>] nfs_readpage_result+0x7c/0xf0
[<c041b3c1>] __rpc_execute+0x351/0x460
[<c012ed8b>] worker_thread+0x19b/0x260
[<c0132dea>] kthread+0x8a/0xd0
[<c01042b5>] kernel_thread_helper+0x5/0x10

emerge        D C049DBD0     0 18162  14532 19786               (L-TLB)
c5d1bd80 00200046 c1020000 c049dbd0 00200082 c049dc70 ffffffff c049db84=20
a309d21d 000f441a cde8c060 000f4240 a95de000 000f441a cd9121b0 c9ffbb50=20
00200246 c5d1a000 c5d1bdbc c042cc9a c9ffbb58 cd912060 00000001 cd912060=20
Call Trace:
[<c042cc9a>] __down+0x7a/0x110
[<c042ce7f>] __down_failed+0xb/0x14
[<c023717e>] .text.lock.nfs4state+0x13/0x65
[<c0219e2c>] put_nfs_open_context+0x3c/0x50
[<c022bc73>] nfs4_proc_file_release+0x13/0x30
[<c02179c5>] nfs_file_release+0x15/0x20
[<c015c4d7>] __fput+0x107/0x140
[<c014de15>] remove_vm_struct+0x65/0xa0
[<c014fe8f>] exit_mmap+0x10f/0x140
[<c011d705>] mmput+0x35/0xa0
[<c0121f47>] do_exit+0x107/0x430
[<c01222f6>] do_group_exit+0x36/0xa0
[<c012adc6>] get_signal_to_deliver+0x206/0x390
[<c0105e08>] do_signal+0x68/0x120
[<c0105ef9>] do_notify_resume+0x39/0x3c
[<c0106076>] work_notifysig+0x13/0x15

sh            D C049DBD0     0 19786  18162 19787               (L-TLB)
c1705d80 00200046 c1020000 c049dbd0 00200082 c049dc70 ffffffff c049db84=20
c049db84 c11b1dc0 c1704000 00000000 a95de000 000f441a cde8c1b0 c9ffbb50=20
00200246 c1704000 c1705dbc c042cc9a c9ffbb58 cde8c060 00000001 cde8c060=20
Call Trace:
[<c042cc9a>] __down+0x7a/0x110
[<c042ce7f>] __down_failed+0xb/0x14
[<c023717e>] .text.lock.nfs4state+0x13/0x65
[<c0219e2c>] put_nfs_open_context+0x3c/0x50
[<c022bc73>] nfs4_proc_file_release+0x13/0x30
[<c02179c5>] nfs_file_release+0x15/0x20
[<c015c4d7>] __fput+0x107/0x140
[<c014de15>] remove_vm_struct+0x65/0xa0
[<c014fe8f>] exit_mmap+0x10f/0x140
[<c011d705>] mmput+0x35/0xa0
[<c0121f47>] do_exit+0x107/0x430
[<c01222f6>] do_group_exit+0x36/0xa0
[<c012adc6>] get_signal_to_deliver+0x206/0x390
[<c0105e08>] do_signal+0x68/0x120
[<c0105ef9>] do_notify_resume+0x39/0x3c
[<c0106076>] work_notifysig+0x13/0x15

ldconfig      D 0000000E     0 19787  19786                     (NOTLB)
c6e4bdc0 00200086 00200082 0000000e cfcbda00 c6e4be34 c09ac894 c6e4bd9c=20
c612d580 c6e4bd9c c6e4bd9c 00000000 04484ec0 000f4406 c9963bf0 c6e4be1c=20
c6e4be24 c11ff318 c6e4bdc8 c042d84e c6e4bdd0 c013d4b5 c6e4bdec c042db28=20
Call Trace:
[<c042d84e>] io_schedule+0xe/0x20
[<c013d4b5>] sync_page+0x35/0x60
[<c042db28>] __wait_on_bit_lock+0x48/0x70
[<c013dbf7>] __lock_page+0x87/0xa0
[<c013ed1b>] filemap_nopage+0x27b/0x320
[<c014cd90>] do_no_page+0xa0/0x2b0
[<c014d1f2>] handle_mm_fault+0x152/0x1a0
[<c011a4a5>] do_page_fault+0x435/0x5f1
[<c0106a35>] error_code+0x2d/0x38

ls            D CA34E000     0 19801      1         19803 14886 (NOTLB)
ca34fcb4 00200082 00000000 ca34e000 00000000 cfcc6a00 00200286 c041abd4=20
00000000 cf833dc0 cfcc6ad0 00000000 97c10c00 000f440b cd292750 cf833dc0=20
ca34fd00 cf833e4c ca34fd2c c041b225 00000000 cd292600 c01332e0 ca34e000=20
Call Trace:
[<c041b225>] __rpc_execute+0x1b5/0x460
[<c0416af7>] rpc_call_sync+0x87/0xa0
[<c022a483>] _nfs4_proc_access+0x93/0x100
[<c022a519>] nfs4_proc_access+0x29/0x50
[<c021772c>] nfs_do_access+0x4c/0x90
[<c0217857>] nfs_permission+0xe7/0x180
[<c016893b>] permission+0x3b/0x50
[<c0169217>] link_path_walk+0x397/0xd70
[<c016c46f>] vfs_follow_link+0x2f/0x1a0
[<c01690e2>] link_path_walk+0x262/0xd70
[<c0169e89>] path_lookup+0x89/0x1a0
[<c016a0fd>] __user_walk+0x2d/0x70
[<c0164e5d>] vfs_lstat+0x1d/0x60
[<c0165464>] sys_lstat64+0x14/0x30
[<c0105fd9>] sysenter_past_esp+0x52/0x71


--=-NxSsi72WqiTWttrlABLN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBdAsiZCYBcts5dM0RAvU1AJ0RhuHV68k0RNSY9XmeF89rKlNkuQCfVv0Q
6aJGkpDZ6m1fQiA7Si/IGEo=
=QGRp
-----END PGP SIGNATURE-----

--=-NxSsi72WqiTWttrlABLN--

