Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965058AbWHHXRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058AbWHHXRg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 19:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965068AbWHHXRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 19:17:36 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:30426 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S965058AbWHHXRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 19:17:35 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] ReiserFS: Make sure all dentries refs are released before calling kill_block_super()
Date: Wed, 9 Aug 2006 01:16:38 +0200
User-Agent: KMail/1.9.3
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com, Olof Johansson <olof@lixom.net>
References: <200608081639.38245.rjw@sisk.pl> <20060804192540.17098.39244.stgit@warthog.cambridge.redhat.com> <32278.1155057836@warthog.cambridge.redhat.com>
In-Reply-To: <32278.1155057836@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608090116.38476.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 August 2006 19:23, David Howells wrote:
> 
> Make sure all dentries refs are released before calling kill_block_super() so
> that the assumption that generic_shutdown_super() can completely destroy the
> dentry tree for there will be no external references holds true.
> 
> What was being done in the put_super() superblock op, is now done in the
> kill_sb() filesystem op instead, prior to calling kill_block_super().
> 
> This prevents the BUG_ON() in the reduced-locking dcache destroyer patch from
> barking at reiserfs.
> 
> I've tested this patch by creating a ReiserFS partition, mounting and
> unmounting it a few times, and doing things to its contents whilst it is
> mounted.

It didn't apply cleanly to -rc3-mm2 for me and produces the appended oops
every time at the kernel startup (on x86_64).

Greetings,
Rafael


input: SynPS/2 Synaptics TouchPad as /class/input/input2
RAMDISK: ext2 filesystem found at block 0
RAMDISK: Loading 2000KiB [1 disk] into ram disk... done.
Unable to handle kernel NULL pointer dereference at 0000000000000510 RIP:
 [<ffffffff802edc73>] reiserfs_kill_sb+0x13/0xa0
PGD 0
Oops: 0000 [1] PREEMPT
last sysfs file: /block/hdc/range
CPU 0
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.18-rc3-mm2 #10
RIP: 0010:[<ffffffff802edc73>]  [<ffffffff802edc73>] reiserfs_kill_sb+0x13/0xa0
RSP: 0000:ffff81005ff27a98  EFLAGS: 00010292
RAX: 0000000000000000 RBX: ffff810037c3ad20 RCX: 0000000000000003
RDX: 0000000000000008 RSI: ffff81005ff08798 RDI: ffff810037c3ad20
RBP: ffff81005ff27aa8 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000001 R12: ffffffff805778c0
R13: 0000000000000001 R14: ffff810037c23080 R15: ffff810037df8168
FS:  0000000000000000(0000) GS:ffffffff808c2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000510 CR3: 0000000000201000 CR4: 00000000000006e0
Process swapper (pid: 1, threadinfo ffff81005ff26000, task ffff81005ff08040)
Stack:  ffff810037c3ad20 ffff810037c3ad20 ffff81005ff27ac8 ffffffff80294671
 00000000ffffffea ffff810037c3ad20 ffff81005ff27b38 ffffffff8029539f
 ffffffff802ee260 0000000000000000 ffffff00306d6172 ffff810037df8168
Call Trace:
 [<ffffffff80294671>] deactivate_super+0x81/0xa0
 [<ffffffff8029539f>] get_sb_bdev+0x12f/0x180
 [<ffffffff802ec653>] get_super_block+0x13/0x20
 [<ffffffff80294746>] vfs_kern_mount+0xb6/0x160
 [<ffffffff8029485a>] do_kern_mount+0x4a/0x70
 [<ffffffff802ae370>] do_mount+0x720/0x790
 [<ffffffff802ae474>] sys_mount+0x94/0xe0
 [<ffffffff808d5b75>] mount_block_root+0xf5/0x2a0
 [<ffffffff808d84d2>] initrd_load+0xc2/0x330
 [<ffffffff808d5e43>] prepare_namespace+0xc3/0x140
 [<ffffffff8020723c>] init+0x1dc/0x2c0
 [<ffffffff8020a706>] child_rip+0x8/0x12
DWARF2 unwinder stuck at child_rip+0x8/0x12
Leftover inexact backtrace:
 [<ffffffff80471edb>] _spin_unlock_irq+0x2b/0x60
 [<ffffffff8020a2c0>] restore_args+0x0/0x30
 [<ffffffff80207060>] init+0x0/0x2c0
 [<ffffffff8020a6fe>] child_rip+0x0/0x12


Code: 48 8b b8 10 05 00 00 48 85 ff 74 31 e8 9c a3 fb ff 48 8b 83
RIP  [<ffffffff802edc73>] reiserfs_kill_sb+0x13/0xa0
 RSP <ffff81005ff27a98>
CR2: 0000000000000510
 <0>Kernel panic - not syncing: Attempted to kill init!

