Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265899AbUA1RRd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 12:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265981AbUA1RRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 12:17:33 -0500
Received: from news.cistron.nl ([62.216.30.38]:44509 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S265899AbUA1RR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 12:17:29 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: 2.6.2-rc2 nfsd+xfs spins in i_size_read()
Date: Wed, 28 Jan 2004 17:17:27 +0000 (UTC)
Organization: Cistron Group
Message-ID: <bv8qr7$m2v$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1075310247 22623 62.216.29.200 (28 Jan 2004 17:17:27 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Linux 2.6.2-rc2 NFS file server and another similar
box as client. Kernel is compiled for SMP (hyperthreading).

On the NFS server I'm exporting an XFS filesystem to the client
over Gigabit ethernet. The client mounts using
mount -o nfsvers=3,intr,rsize=32768,wsize=32768 server:/export/hwr /mnt

On the client I then run a large dd to a file on the server,
like dd if=/dev/zero of=/mnt/file bs=4096 count=800000

In a few seconds, the server locks up. It spins in
generic_fillattr(), apparently in the i_size_read() inline function.
Server responds to pings and sysrq, but nothing else.

2.6.1 doesn't show this behaviour. I tested several kernels:

2.6.1           	OK!
2.6.1-bk4		OK!
2.6.1-bk5		doesn't boot
2.6.1-bk6		hangs
2.6.2-rc1		hangs
2.6.2-rc2		hangs
2.6.2-rc2-gcc-2.95	hangs
2.6.2-rc1-mm3		OK!
2.6.2-rc2-mm1		OK!

I can't reproduce it on the local filesystem on the NFS server
directly, and I can't reproduce it on other filesystems than XFS.
But NFSD+XFS locks up every time.

Unfortunately the diff between 2.6.1-bk4 and bk6 is too large
for me to see what the difference is, likewise 2.6.2-rc2-mm1,
but perhaps someone has an idea what could be causing this ?

Here's the sysrq output:

Pid: 531, comm:                 nfsd
EIP: 0060:[<c01577c2>] CPU: 0
EIP is at generic_fillattr+0x82/0xa0
 EFLAGS: 00000246    Not tainted
EAX: 00000000 EBX: 07ae7200 ECX: f650a0a0 EDX: 000113eb
ESI: 00000000 EDI: f66cfed4 EBP: f66e5804 DS: 007b ES: 007b
CR0: 8005003b CR2: 40019000 CR3: 37245000 CR4: 000006d0
Call Trace:
 [<f8ab1f6b>] linvfs_getattr+0x2b/0x34 [xfs]
 [<c0157805>] vfs_getattr+0x25/0x84
 [<c01c19a3>] encode_post_op_attr+0x53/0x238
 [<c01c1e27>] encode_wcc_data+0x29f/0x2a8
 [<c01c4521>] nfs3svc_encode_commitres+0x19/0x5c
 [<c01b709d>] nfsd_dispatch+0x14d/0x1a3
 [<c02fb79b>] svc_process+0x3b3/0x640
 [<c01b6ddc>] nfsd+0x1e4/0x358
 [<c01b6bf8>] nfsd+0x0/0x358
 [<c0107251>] kernel_thread_helper+0x5/0xc




(By the way, on 2.6.2-rc1-mm3 and 2.6.2-rc2-mm1 mounting an XFS
 filesystem results in lots of:

 Badness in interruptible_sleep_on at kernel/sched.c:2239
 Call Trace:
  [<c011f5a3>] interruptible_sleep_on+0xf6/0xfb
  [<c011f209>] default_wake_function+0x0/0x12
  [<f8ac0fa2>] pagebuf_daemon+0x231/0x24c [xfs]
  [<c0339ed6>] ret_from_fork+0x6/0x14
  [<f8ac0d47>] pagebuf_daemon_wakeup+0x0/0x2a [xfs]
  [<f8ac0d71>] pagebuf_daemon+0x0/0x24c [xfs]
  [<c0109269>] kernel_thread_helper+0x5/0xb       )

Mike.

