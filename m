Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263888AbUDPWGZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 18:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263876AbUDPWEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 18:04:44 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:13000 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S263867AbUDPV7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:59:32 -0400
Message-ID: <4080573C.4090709@suse.com>
Date: Fri, 16 Apr 2004 17:59:24 -0400
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Anthony R." <russo.lutions@verizon.net>
Cc: linux-kernel@vger.kernel.org,
       ReiserFS Mailing List <reiserfs-list@namesys.com>
Subject: [PATCH] ReiserFS I/O error Handling [was Re: kernel BUG at fs/reiserfs/prints.c:339!
 kernel 2.6.5]
References: <407FF7CA.3050002@verizon.net>
In-Reply-To: <407FF7CA.3050002@verizon.net>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.16.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


It's most definately a hardware problem. It could be your disk, your
controller, or the cable connecting them, but somehow hdb1 started
getting I/O errors. One of them just happened to be in the journal area,
which ReiserFS doesn't handle well at the moment; it just panics, which
is what you saw.

I've got a patch in development that I just need to squeeze one last bug
out of that will allow ReiserFS to take write errors while writing to
the journal or flushing out from the journal to the disk more
gracefully. Rather than panicking, it remounts the filesystem read-only
and aborts existing transactions. The filesystem can then be umounted.

The last bug that I'm working out is a race at umount. It happens on
average 1/10 umounts, but it's still a bug.

I've posted my patches at
ftp://ftp.suse.com/pub/people/jeffm/reiserfs/kernel-v2.6/io-error/

Since this was developed on the SuSE kernel, Chris Mason's data logging
patches are also required. My xattr patches are required for context,
but if you don't have them applied, you can safely remove the xattr
portions of the patch.

- -Jeff


Anthony R. wrote:
| Hi,
|
| Using kernel version 2.6.5, Pentium 4 PC,
| ReiserFS. While running slocate cron job, the
| following errors showed up and the harddrive's
| LED remained lit until a hard power cycle. I've been running
| 2.6.x kernels on this same hardware for months and never
| saw this problem before until kernel 2.6.5. I realize it could be a
| hardware problem but I want to report it here first.
|
| Thank you.
|
| -- tony
|
| Syslog messages follow:
|
| Apr 16 04:07:14 manic kernel: hdb: dma_timer_expiry: dma status == 0x61
| Apr 16 04:07:24 manic kernel: hdb: DMA timeout error
| Apr 16 04:07:24 manic kernel: hdb: dma timeout error: status=0xd0 { Busy }
| Apr 16 04:07:24 manic kernel:
| Apr 16 04:07:24 manic kernel: hda: DMA disabled
| Apr 16 04:07:24 manic kernel: hdb: DMA disabled
| Apr 16 04:07:55 manic kernel: ide0: reset timed-out, status=0xd0
| Apr 16 04:07:55 manic kernel: hdb: status error: status=0x00 { }
| Apr 16 04:07:55 manic kernel:
| Apr 16 04:07:55 manic kernel: hdb: drive not ready for command
| Apr 16 04:07:55 manic kernel: hdb: status error: status=0x00 { }
| Apr 16 04:07:55 manic kernel:
| Apr 16 04:07:55 manic kernel: hdb: drive not ready for command
| Apr 16 04:07:56 manic kernel: hdb: status error: status=0x00 { }
| Apr 16 04:07:56 manic kernel:
| Apr 16 04:07:56 manic kernel: hdb: drive not ready for command
| Apr 16 04:07:56 manic kernel: hdb: status error: status=0x00 { }
| Apr 16 04:07:56 manic kernel:
| Apr 16 04:07:56 manic kernel: hdb: drive not ready for command
| Apr 16 04:08:27 manic kernel: ide0: reset timed-out, status=0xd0
| Apr 16 04:08:27 manic kernel: end_request: I/O error, dev hdb, sector
499007
| Apr 16 04:08:27 manic kernel: end_request: I/O error, dev hdb, sector
499007
| Apr 16 04:08:28 manic kernel: vs-13050: reiserfs_update_sd: i/o failure
| occurred trying to update [1 2 0x0 SD] stat dataend_request: I/O error,
| dev hdb, sector 36743
| Apr 16 04:08:28 manic kernel: Buffer I/O error on device hdb1, logical
| block 4585
| Apr 16 04:08:28 manic kernel: lost page write due to I/O error on hdb1
| Apr 16 04:08:28 manic kernel: journal-601, buffer write failed
|
| Apr 16 04:08:28 manic kernel: ------------[ cut here ]------------
| Apr 16 04:08:28 manic kernel: kernel BUG at fs/reiserfs/prints.c:339!
| Apr 16 04:08:28 manic kernel: invalid operand: 0000 [#1]
| Apr 16 04:08:28 manic kernel: PREEMPT
| Apr 16 04:08:28 manic kernel: CPU:    0
| Apr 16 04:08:28 manic kernel: EIP:    0060:[<c019ad43>]    Tainted: P
| Apr 16 04:08:28 manic kernel: EFLAGS: 00010286   (2.6.5)
| Apr 16 04:08:28 manic kernel: EIP is at reiserfs_panic+0x37/0x67
| Apr 16 04:08:28 manic kernel: eax: 00000024   ebx: c2692e00   ecx:
| c04b46c4   edx: c03f1838
| Apr 16 04:08:28 manic kernel: esi: f8bd4ddc   edi: 00000000   ebp:
| f6477d08   esp: f6477cf8
| Apr 16 04:08:28 manic kernel: ds: 007b   es: 007b   ss: 0068
| Apr 16 04:08:28 manic kernel: Process pdflush (pid: 6243,
| threadinfo=f6476000 task=cd081800)
| Apr 16 04:08:28 manic kernel: Stack: c0397014 c04c32a0 f8bd4ddc c2692e00
| f6477d4c c01a5c7e c2692e00 c03a2240
| Apr 16 04:08:28 manic kernel:        00000000 00001000 f6fd1000 f6fe7a00
| 000011ea 00000005 00000003 00000000
| Apr 16 04:08:28 manic kernel:        00000002 f462d2ec 00000031 f6fe7a00
| c2692e00 f6477dc0 c01aa04c c2692e00
| Apr 16 04:08:28 manic kernel: Call Trace:
| Apr 16 04:08:28 manic kernel:  [<c01a5c7e>] flush_commit_list+0x2cc/0x459
| Apr 16 04:08:28 manic kernel:  [<c01aa04c>] do_journal_end+0x598/0xbbe
| Apr 16 04:08:28 manic kernel:  [<c01a8b62>] do_journal_begin_r+0x256/0x28a
| Apr 16 04:08:28 manic kernel:  [<c01a93e3>] flush_old_commits+0x12f/0x1c2
| Apr 16 04:08:28 manic kernel:  [<c0197cc6>] reiserfs_write_super+0x84/0x86
| Apr 16 04:08:28 manic kernel:  [<c01535f4>] sync_supers+0xb2/0xbb
| Apr 16 04:08:28 manic kernel:  [<c01356b6>] wb_kupdate+0x43/0x134
| Apr 16 04:08:28 manic kernel:  [<c011463f>] schedule+0x344/0x5a0
| Apr 16 04:08:28 manic kernel:  [<c0135cf4>] __pdflush+0xdc/0x1de
| Apr 16 04:08:28 manic kernel:  [<c0135e20>] pdflush+0x2a/0x2e
| Apr 16 04:08:28 manic kernel:  [<c0135673>] wb_kupdate+0x0/0x134
| Apr 16 04:08:28 manic kernel:  [<c0129a10>] kthread+0xa5/0xaa
| Apr 16 04:08:28 manic kernel:  [<c0135df6>] pdflush+0x0/0x2e
| Apr 16 04:08:28 manic kernel:  [<c012996b>] kthread+0x0/0xaa
| Apr 16 04:08:28 manic kernel:  [<c0104fcd>] kernel_thread_helper+0x5/0xb
| Apr 16 04:08:28 manic kernel:
| Apr 16 04:08:28 manic kernel: Code: 0f 0b 53 01 53 aa 39 c0 b8 68 a6 39
| c0 8d 93 10 01 00 00 85
| Apr 16 04:08:28 manic kernel:  end_request: I/O error, dev hdb, sector
36751
| Apr 16 04:08:28 manic kernel: Buffer I/O error on device hdb1, logical
| block 4586
| Apr 16 04:08:28 manic kernel: lost page write due to I/O error on hdb1
| Apr 16 04:08:29 manic kernel: end_request: I/O error, dev hdb, sector
| 43544419
| Apr 16 04:08:29 manic kernel: end_request: I/O error, dev hdb, sector
| 43544419
| Apr 16 04:08:46 manic kernel: vs-13050: reiserfs_update_sd: i/o failure
| occurred trying to update [1 2 0x0 SD] stat data<4>
|


- --
Jeff Mahoney
SuSE Labs
jeffm@suse.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAgFc8LPWxlyuTD7IRAv4qAJsHPp6LeqauUMpVBZgJ5EEBWaKu7gCglv5d
nHt/ieiTbGfQwProb13p258=
=q+qX
-----END PGP SIGNATURE-----
