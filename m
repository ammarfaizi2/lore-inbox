Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbVKURJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbVKURJi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 12:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbVKURJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 12:09:38 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:52112 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932350AbVKURJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 12:09:37 -0500
Message-ID: <00de01c5eebe$325d2810$6f00a8c0@comcast.net>
From: "John Hawkes" <hawkes@sgi.com>
To: "Nathan Scott" <nathans@sgi.com>,
       "Lawrence Walton" <lawrence@the-penguin.otak.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, <linux-xfs@oss.sgi.com>
References: <20051120075233.GA20295@the-penguin.otak.com> <20051121100820.D6790390@wobbly.melbourne.sgi.com>
Subject: Re: unable to use dpkg 2.6.15-rc2
Date: Mon, 21 Nov 2005 09:08:29 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Nathan Scott" <nathans@sgi.com>

> > It's reproducible in 2.6.15-rc1, 2.6.15-rc1-mm1, 2.6.15-rc1-mm2 and
> > 2.6.15-rc2.
> >
> > It does not occur in 2.6.14.
> >
> > Most easily triggered by "make clean" in the Linux source, for those of
> > you without access to dpkg. But both clean and dpkg will trigger it.
>
> So far I've not been able to reproduce this; I'm using "make clean"
> and it works just fine for me (I'm using the current git tree).

I can reproduce this using with 2.6.15-rc1 using AIM7 or AIM9.  I forced a
corefile for one of the AIM7 threads that hung during close doing the disk_cp
subtest.  The AIM9 run hung doing disk_src (running each subtest for 100
seconds).  I didn't coredump that one, but rather I got into kdb and did a
backtrace on the AIM9 "singleuser" thread.

[1]kdb> btp 16155
Stack traceback for pid 16155
0xe000003864630000    16155    16116  0    1   D  0xe000003864630330
singleuser
0xa000000100778800 schedule+0x1300
        args (0xe000003864637b10, 0x7fffffffffffffff, 0xa00000010039c710,
0xa00000010077d740, 0x205)
0xa00000010077b430 schedule_timeout+0x170
        args (0x7fffffffffffffff, 0xa00000010039c6f0, 0xa00000010095c680,
0xa00000010039c710, 0x60f)
0xa00000010039c710 xlog_grant_log_space+0x670
        args (0xe00000347a9a6100, 0xe00000347a9db2c0, 0xa0000001008c57e0,
0xe000003864637b70, 0xe00000347a9db2f7)
0xa000000100397760 xfs_log_reserve+0x1c0
        args (0xe00000347a9db2c0, 0x0, 0x2, 0xe0000038624d23d8, 0x69)
0xa0000001003b11c0 xfs_trans_reserve+0xe0
        args (0xe0000038624d2388, 0x29, 0x268b8, 0x0, 0x4)
0xa0000001003c2e50 xfs_create+0x550
        args (0xe000003c6cbaa0c8, 0xe0000038625b17ec, 0xe000003864637c30,
0xe000003864637db0, 0x0)
0xa0000001003dcbd0 linvfs_mknod+0x630
        args (0xe000003c6de8a6e8, 0xe0000038625b1730, 0x81ed, 0x0, 0x0)
0xa0000001003dcd30 linvfs_create+0x30
        args (0xe000003c6de8a6e8, 0xe0000038625b1730, 0x81ff,
0xa000000100191dc0, 0x40c)
0xa000000100191dc0 vfs_create+0x1c0
        args (0xe000003c6de8a6e8, 0xe0000038625b1730, 0x81ff,
0xe0000038625b1768, 0xa000000100d35550)
0xa0000001001933c0 open_namei+0xea0
        args (0xe0000038625b1730, 0x8242, 0x1ff, 0xe000003864637dd0,
0xe0000038625b35e0)
0xa000000100168a80 filp_open+0x40
        args (0xe0000038604df000, 0x8241, 0x1ff, 0xa0000001001692b0, 0x38b)
0xa0000001001692b0 do_sys_open+0xb0
        args (0xe0000038604df000, 0x8241, 0x20, 0xfffffffffffffc18, 0x5)
0xa000000100169430 sys_open+0x50
        args (0x600000000005b180, 0x241, 0x1ff, 0x0, 0x8)
0xa000000100169490 sys_creat+0x30
        args (0x600000000005b180, 0x1ff, 0x607fffffffd394a0,
0xc00000000000048d, 0x600000000005a9c0)
0xa00000010000b800 ia64_ret_from_syscall
        args (0x600000000005b180, 0x1ff, 0x607fffffffd394a0,
0xc00000000000048d)
0xa000000000004000 __kernel_syscall_via_break
        args (0x600000000005b180, 0x1ff, 0x607fffffffd394a0,
0xc00000000000048d)


