Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbVCYT1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbVCYT1V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 14:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbVCYT1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 14:27:21 -0500
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:58573 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261754AbVCYT0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 14:26:37 -0500
Subject: x86-64 preemption fix from IRQ and BKL in 2.6.12-rc1-mm2
From: Christophe Saout <christophe@saout.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20050324044114.5aa5b166.akpm@osdl.org>
References: <20050324044114.5aa5b166.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-H0R3Fri7anjoDKTk0a7F"
Date: Fri, 25 Mar 2005 20:26:25 +0100
Message-Id: <1111778785.14840.13.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-H0R3Fri7anjoDKTk0a7F
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

> +x86_64-fix-config_preempt.patch
>
> x86_64-fix-config_preempt.patch
>   x86_64: Fix CONFIG_PREEMPT

Has this one been stress-tested?

I've got the impression that things have become a lot worse.

I've been seeing things like these:

Mar 25 01:00:48 websrv2 REISERFS: panic (device dm-1): clm-6000: do_balance=
, fs generation has changed
Mar 25 01:00:48 websrv2
Mar 25 01:00:48 websrv2 ----------- [cut here ] --------- [please bite here=
 ] ---------
Mar 25 01:00:48 websrv2 Kernel BUG at prints:362
Mar 25 01:00:48 websrv2 invalid operand: 0000 [1] PREEMPT
Mar 25 01:00:48 websrv2 CPU 0
Mar 25 01:00:48 websrv2 Modules linked in: iptable_nat ipt_MARK iptable_man=
gle ipt_LOG ipt_multiport ipt_owner ipt_mark ipt_state ipt_REJECT iptable_f=
ilter ip_tables twofish serpent blowfish ext3 jbd reiser4 sha256 aes dm_cry=
pt ip_conntrack_irc ip_conntrack_ftp ip_conntrack via_rhine 8139too crc32
Mar 25 01:00:48 websrv2 Pid: 25172, comm: rm Not tainted 2.6.12-rc1-cs1
Mar 25 01:00:48 websrv2 RIP: 0010:[<ffffffff801cfe13>] <ffffffff801cfe13>{r=
eiserfs_panic+211}
Mar 25 01:00:48 websrv2 RSP: 0018:ffff81001efe37b8  EFLAGS: 00010292
Mar 25 01:00:48 websrv2 RAX: 0000000000000059 RBX: ffffffff803fbcac RCX: 00=
000000c0000100
Mar 25 01:00:48 websrv2 RDX: 0000000000000000 RSI: ffff81007d0b31f0 RDI: 00=
000000ffffffff
Mar 25 01:00:48 websrv2 RBP: ffff81004f960060 R08: ffff81001efe2000 R09: 00=
00000000000002
Mar 25 01:00:48 websrv2 R10: 00000000ffffffff R11: ffffffff80340ef0 R12: ff=
ff81007f850230
Mar 25 01:00:48 websrv2 R13: ffff81007f850000 R14: 0000000000000000 R15: ff=
ff81004f9565d0
Mar 25 01:00:48 websrv2 FS:  00002aaaaaabaae0(0000) GS:ffffffff805be800(000=
0) knlGS:0000000055563dc0
Mar 25 01:00:48 websrv2 CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Mar 25 01:00:48 websrv2 CR2: 00002aaaaaaff008 CR3: 000000001ebbd000 CR4: 00=
000000000006e0
Mar 25 01:00:48 websrv2 Process rm (pid: 25172, threadinfo ffff81001efe2000=
, task ffff81007d0b31f0)
Mar 25 01:00:48 websrv2 Stack: 0000003000000010 ffff81001efe38a8 ffff81001e=
fe37d8 ffff81001c041530
Mar 25 01:00:48 websrv2 ffff81001efe39d8 ffffffff801d4e42 ffff81007e659a00 =
0000000000000063
Mar 25 01:00:48 websrv2 0000000000000063 0000000000000000
Mar 25 01:00:48 websrv2 Call Trace:<ffffffff801d4e42>{pathrelse_and_restore=
+66} <ffffffff8010efe6>{retint_kernel+46}
Mar 25 01:00:48 websrv2 <ffffffff801bb847>{do_balance+39} <ffffffff801bd315=
>{do_balance+6901}
Mar 25 01:00:48 websrv2 <ffffffff801cbd90>{unfix_nodes+128} <ffffffff801be1=
5b>{do_balance+10555}
Mar 25 01:00:48 websrv2 <ffffffff801d7bf9>{reiserfs_cut_from_item+1673} <ff=
ffffff801bfcfa>{reiserfs_unlink+362}
Mar 25 01:00:48 websrv2 <ffffffff801873ae>{vfs_unlink+462} <ffffffff801874f=
9>{sys_unlink+233}
Mar 25 01:00:48 websrv2 <ffffffff8018a268>{sys_getdents+232} <ffffffff8010f=
221>{error_exit+0}
Mar 25 01:00:48 websrv2 <ffffffff8010e906>{system_call+126}
Mar 25 01:00:48 websrv2
Mar 25 01:00:48 websrv2 Code: 0f 0b b8 c1 3f 80 ff ff ff ff 6a 01 4d 85 ed =
48 c7 c2 40 ba
Mar 25 01:00:48 websrv2 RIP <ffffffff801cfe13>{reiserfs_panic+211} RSP <fff=
f81001efe37b8>

or

Mar 25 16:39:21 websrv2 VFS: brelse: Trying to free free buffer
Mar 25 16:39:21 websrv2 Badness in __brelse at fs/buffer.c:1295
Mar 25 16:39:21 websrv2
Mar 25 16:39:21 websrv2 Call Trace:<ffffffff8017787f>{__find_get_block+479}=
 <ffffffff8017a175>{__getblk+37}
Mar 25 16:39:21 websrv2 <ffffffff801de3d5>{do_journal_end+2181} <ffffffff80=
147d70>{keventd_create_kthread+0}
Mar 25 16:39:21 websrv2 <ffffffff801cbf50>{reiserfs_sync_fs+64} <ffffffff80=
17c0b3>{sync_supers+211}
Mar 25 16:39:21 websrv2 <ffffffff8015a22a>{wb_kupdate+42} <ffffffff8015ae8f=
>{pdflush+399}
Mar 25 16:39:21 websrv2 <ffffffff8015a200>{wb_kupdate+0} <ffffffff80147d70>=
{keventd_create_kthread+0}
Mar 25 16:39:21 websrv2 <ffffffff8015ad00>{pdflush+0} <ffffffff80147d2d>{kt=
hread+205}
Mar 25 16:39:21 websrv2 <ffffffff8010f3d7>{child_rip+8} <ffffffff80147d70>{=
keventd_create_kthread+0}
Mar 25 16:39:21 websrv2 <ffffffff80147c60>{kthread+0} <ffffffff8010f3cf>{ch=
ild_rip+0}

Fortunately the kernel locked up and there was no data corruption.

I've got PREEMPT and PREEMPT_BKL enabled under UP.

I just took a look at the change and found this:

x86-64 does this (in entry.S):

        bt   $9,EFLAGS-ARGOFFSET(%rsp)  /* interrupts off? */
        jnc   retint_restore_args
        movl $PREEMPT_ACTIVE,threadinfo_preempt_count(%rcx)
        sti
        call schedule
        cli
        GET_THREAD_INFO(%rcx)
        movl $0,threadinfo_preempt_count(%rcx)
        jmp exit_intr

while i386 does this:

        testl $IF_MASK,EFLAGS(%esp)     # interrupts off (exception path) ?
        jz restore_all
        call preempt_schedule_irq
        jmp need_resched

preempt_schedule_irq is not an i386 specific function and seems to take
special care of BKL preemption and since reiserfs does use the BKL to do
certain things I think this actually might be the problem...?

I'm not saying that this fix is wrong (it is obviously the right fix)
but it causes another problem to show up.

Unfortunately I don't have a amd64 machine to play with, so can somebody
please check this?


--=-H0R3Fri7anjoDKTk0a7F
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCRGXhZCYBcts5dM0RApiFAKCJ46GwQpY9h9uqF9eIHhgxQbMa6wCfW0xQ
9u86QkwvO5xKnPLOREa05iw=
=9Jjp
-----END PGP SIGNATURE-----

--=-H0R3Fri7anjoDKTk0a7F--

