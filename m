Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWHKInx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWHKInx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 04:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWHKInx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 04:43:53 -0400
Received: from tiu.fh-brandenburg.de ([195.37.0.8]:59896 "EHLO
	tiu.fh-brandenburg.de") by vger.kernel.org with ESMTP
	id S1750887AbWHKInw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 04:43:52 -0400
Date: Fri, 11 Aug 2006 10:43:44 +0200
From: Markus Dahms <dahms@fh-brandenburg.de>
To: linux-kernel@vger.kernel.org
Subject: [BUG] "held lock freed!" on 2.6.18-rc4-gc4e321b8, not reproducible
Message-ID: <20060811084344.GA29613@fh-brandenburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAKlBMVEW4lkTW0MHdtVQ7MRgk FwEZCgD+/v7z8vMKAADRrlz///9oVix+bkv+/v0NL+OXAAACaklEQVQ4jV2UMYviQBTHQzbN kkokJ4iFTOsVJ+yxObDwwAUXbWQVAusnmE62k1wVU8Xqzkas0mRg2AU37HIuXnGeegY3n0DI d7k3M5moNxAzzm/+8978Z14UmjbMfkgpjgusE1CFnraS1bD6Rd49A77ZUvRm9T+A6VPeUxHS ndU5CEAQImgvzu4UBEyAFFVF5dfx8CyGb871q0Ztjso3RZqcgLynW/2456hosZOAbYJE80Wt QHLRJ3TROV0qP9o4bAu2hyoSgCAg5rLJ8sT+/RFASjBxw5KBHO6Rdn1cikSt5k4k10faPssq sEfv429UKo6ARO3FNZVgsc+WstOUUvAXAJaCZ3g/wfPogUKeB0TgAg5u0bZIAwYCJqgGaX6P t8wroZACCdrSXQME7J0IUBnz80jA76UQSPA1Pai8t6ge5HgCoMMB9s1fd0dB8iABt++A03EI +HYhAInqzD6cgT/MXAB+9308TJIDphLMhML2tCpNkiTAQQo+dkCvUKMOZibitM5AFL4Wz0G6 1IZ5dtKMt4kIvlUX+0G8GkrwUP8hFFFdq3123VVmIgdYYafteL83zgc+jAFMfqYbbLhfUFn4 yxVpDGr31p6qVpyhjCGywpTkBma3dQm7CURWsI+E246pHZt1uEwwJzc0Qgn4PNuDlUmp14uN ELJit+SQ3qZZ56lktTfWSzg5LTW/P+sMzJZa1hohRMNZGfhdvbNlRVue8tuTlQHZzpxRWL6c Kt91Xg5ZRUXzmzms07hamlWWTwaMtjLVrHh91xPfjAzY7nJpxUNSyPGvzBGQtevWMu/B3axL 4Exw9o/+AxnogmiXX+X9AAAAAElFTkSuQmCC
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I got the following bug on 2.6.18-rc4+ after booting but could not
reproduce it. So it may be a race condition or just a hardware bug.

GIT c4e321b85a89d7cd392d3105b2c033a6c58ed337 from .../gregkh/linux-2.6
Hardware: AMD K7 1.8GHz, VIA chipset, PATA... - some time old

Except the bug message the machine runs normally..

Markus

====>8=====
[...]
EXT3-fs: mounted filesystem with ordered data mode.
input: AT Translated Set 2 keyboard as /class/input/input0
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 192k freed
Write protecting the kernel read-only data: 275k

=========================
[ BUG: held lock freed! ]
-------------------------
mount/320 is freeing memory c1796c20-c1796c5f, with a lock still held there!
 (&sbinfo->stat_lock){--..}, at: [<c015e9f8>] shmem_get_inode+0x28/0x1d0
2 locks held by mount/320:
 #0:  (&type->s_umount_key#8){--..}, at: [<c016ce6f>] sget+0x15f/0x370
 #1:  (&sbinfo->stat_lock){--..}, at: [<c015e9f8>] shmem_get_inode+0x28/0x1d0

stack backtrace:
 [<c010562b>] show_trace+0x1b/0x20
 [<c0105656>] dump_stack+0x26/0x30
 [<c0137989>] debug_check_no_locks_freed+0x189/0x190
 [<c0161f95>] kfree+0x55/0xc0
 [<c0181c2c>] free_fdtable_rcu+0xdc/0x130
 [<c012d7d0>] __rcu_process_callbacks+0x80/0x1b0
 [<c012d912>] rcu_process_callbacks+0x12/0x30
 [<c01209ee>] tasklet_action+0x4e/0x90
 [<c0121158>] __do_softirq+0x58/0xe0
 [<c01059b4>] do_softirq+0x64/0xf0
 =======================
 [<c0121016>] irq_exit+0x36/0x40
 [<c0105aef>] do_IRQ+0xaf/0x110
 [<c0103a2d>] common_interrupt+0x25/0x2c
 [<c02cd71b>] _spin_lock+0x3b/0x50
 [<c015e9f8>] shmem_get_inode+0x28/0x1d0
 [<c015ecf0>] shmem_fill_super+0x150/0x1a0
 [<c016d19a>] get_sb_nodev+0x5a/0xb0
 [<c015df6e>] shmem_get_sb+0x2e/0x30
 [<c016c7bd>] vfs_kern_mount+0x4d/0x90
 [<c016c86f>] do_kern_mount+0x3f/0x60
 [<c0183b3d>] do_mount+0x29d/0x660
 [<c0183f8c>] sys_mount+0x8c/0xd0
 [<c010303f>] syscall_call+0x7/0xb
[...]
====>8=====

-- 
A computer without COBOL and Fortran is like a piece of chocolate cake
without ketchup and mustard.
