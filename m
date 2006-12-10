Return-Path: <linux-kernel-owner+w=401wt.eu-S935217AbWLJWEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935217AbWLJWEe (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 17:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935226AbWLJWEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 17:04:34 -0500
Received: from quechua.inka.de ([193.197.184.2]:47669 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935217AbWLJWEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 17:04:33 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19: OOPS in cat /proc/fs/nfs/exports
References: <E1GrJH9-0003Hr-00@bigred.inka.de> <17780.62607.544405.181452@cse.unsw.edu.au> <E1Gripc-0004KC-00@bigred.inka.de> <17783.28848.504885.606906@cse.unsw.edu.au>
Organization: private Linux site, southern Germany
From: Olaf Titz <olaf@bigred.inka.de>
Date: Sun, 10 Dec 2006 23:04:22 +0100
Message-ID: <E1GtWmU-0007Cu-00@bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> What version of nfs-utils are you running?  We haven't been using
> nfsservctl(3, ...) on 2.6 kernels for ages - which probably explains
> why exp_export() has suffered so much bit-rot.  When I convinced
> exportfs to use that nfsservctl I got a very similar oops.
>
> This patch fixes it for me.  Does it fix it for you too?

The patch fixes the problem; however when I tested it, after some
export/unexport cycles, trying to mount gave me this:

Dec 10 21:32:10 glotze kernel: kernel BUG at /usr/opt/src/kernel/linux-2.6.19/mm/slab.c:594!
Dec 10 21:32:10 glotze kernel: invalid opcode: 0000 [#1]
Dec 10 21:32:10 glotze kernel: PREEMPT
Dec 10 21:32:10 glotze kernel: Modules linked in: nfsd exportfs i915 stv0299 budget_ci budget_core dvb_core saa7146 ttpci_eeprom lirc_serial(F) lirc_dev 8250 serial_core nfs lockd sunrpc tuner tvaudio bttv video_buf ir_common compat_ioctl32 i2c_algo_bit btcx_risc tveeprom i2c_core videodev v4l1_compat v4l2_common ipv6 nvram snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc ide_cd cdrom e100 mii af_packet
Dec 10 21:32:10 glotze kernel: CPU:    0
Dec 10 21:32:10 glotze kernel: EIP:    0060:[kfree+96/106]    Tainted: GF     VLI
Dec 10 21:32:10 glotze kernel: EFLAGS: 00010046   (2.6.19 #4)
Dec 10 21:32:10 glotze kernel: EIP is at kfree+0x60/0x6a
Dec 10 21:32:10 glotze kernel: eax: 80000400   ebx: c2955004   ecx: 457c6d08   edx: c1020a40
Dec 10 21:32:10 glotze kernel: esi: c1052aa0   edi: 00000000   ebp: 00000286   esp: c9d6fe54
Dec 10 21:32:10 glotze kernel: ds: 007b   es: 007b   ss: 0068
Dec 10 21:32:10 glotze kernel: Process rpc.mountd (pid: 1379, ti=c9d6e000 task=c8122550 task.ti=c9d6e000)
Dec 10 21:32:10 glotze kernel: Stack: c2955004 c2955405 00000000 cf33ac00 d058910b 00000000 c01602c1 c9d6fec0
Dec 10 21:32:10 glotze kernel:        cf7e40c0 c9d6ff54 c030b1ac ca116600 00000000 cd624858 cf7e4240 00000001
Dec 10 21:32:10 glotze kernel:        00000044 c1052ac0 00000000 00000001 00000000 c030b060 00000000 00000001
Dec 10 21:32:10 glotze kernel: Call Trace:
Dec 10 21:32:10 glotze kernel:  [pg0+270385419/1069880320] exp_export+0x141/0x43c [nfsd]
Dec 10 21:32:10 glotze kernel:  [do_lookup+89/365] do_lookup+0x59/0x16d
Dec 10 21:32:10 glotze kernel:  [__alloc_pages+79/707] __alloc_pages+0x4f/0x2c3
Dec 10 21:32:10 glotze kernel:  [file_move+52/76] file_move+0x34/0x4c
Dec 10 21:32:10 glotze kernel:  [simple_transaction_get+154/183] simple_transaction_get+0x9a/0xb7
Dec 10 21:32:10 glotze kernel:  [pg0+270355601/1069880320] write_export+0x0/0x15 [nfsd]
Dec 10 21:32:10 glotze kernel:  [pg0+270355727/1069880320] nfsctl_transaction_write+0x3f/0x5d [nfsd]
Dec 10 21:32:10 glotze kernel:  [sys_nfsservctl+325/432] sys_nfsservctl+0x145/0x1b0
Dec 10 21:32:10 glotze kernel:  [sys_stat64+30/35] sys_stat64+0x1e/0x23
Dec 10 21:32:10 glotze kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Dec 10 21:32:10 glotze kernel:  =======================
Dec 10 21:32:10 glotze kernel: Code: 1c 87 8b 03 3b 43 04 73 15 89 74 83 10 83 c0 01 89 03 55 9d 5b 5e 5f 5d c3 8b 52 0c eb d3 89 da 89 f8 e8 df fe ff ff 8b 03 eb de <0f> 0b 52 02 8c 01 2d c0 eb c2 55 57 56 53 89 c7 89 d5 8d 92 00
Dec 10 21:32:10 glotze kernel: EIP: [kfree+96/106] kfree+0x60/0x6a SS:ESP 0068:c9d6fe54

Might be unrelated (mountd not exportfs), but perhaps this code has
got as much bitrot too.

I've replaced exportfs, mountd and nfsd with a newer version and it
works now.

If this nfsservctl functions are not used anymore by the officially
supported version of system tools, shouldn't that code be removed
altogether? If OTOH it falls under "don't break userspace interface",
perhaps there is more left to fix...

Olaf
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD4DBQFFfIRdGPw4gdAdiZ0RAl6nAJ0SOgIZeKTrd9uzWcS6b/8Hgi/cNQCXdcQe
5vcZnrqxRGJZ3drwQ1jnOA==
=WoOx
-----END PGP SIGNATURE-----
