Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752129AbWAEK3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbWAEK3I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 05:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752130AbWAEK3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 05:29:08 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:20381 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1752129AbWAEK3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 05:29:07 -0500
From: Roger Leigh <rleigh@whinlatter.ukfsn.org>
To: linux-kernel@vger.kernel.org
Subject: BUG: 2.6.14/2.6.15: USB storage/ext2fs uninterruptable sleep
Date: Thu, 05 Jan 2006 10:29:05 +0000
Message-ID: <87zmmbt1ce.fsf@hardknott.home.whinlatter.ukfsn.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I use a USB storage device (Kingston 128 MiB keydrive) to hold GPG
keys, which is automounted with autofs4.  It's looking like a write
operation on the device (so far always involving an ext2_delete_inode
up to sync_buffer) causes the process to hang in an uninterruptable
sleep.

The system is running stock kernel.org linux-2.6.15 and 2.6.14.5 on a
PowerPC 7447A system (Mac Mini) running Debian unstable.  The .config
is here: http://www.whinlatter.ukfsn.org/config-2.6.15-hardknott.bz2

For example:
# cd /misc/pen-secure/.gnupg
# rm secring.gpg.lock pubring.gpg.lock pubring.gpg.tmp

7818 pts/1    D+     0:00 rm secring.gpg.lock pubring.gpg.lock pubring.gpg.tmp

rm            D 0FF35634     0  7818   7196                   (NOTLB)
Call trace:
 [c0007524] __switch_to+0x54/0x6c
 [c0287c28] schedule+0x584/0x634
 [c0287d08] io_schedule+0x30/0x60
 [c006be78] sync_buffer+0x50/0x64
 [c0288854] __wait_on_bit_lock+0x60/0xc0
 [c0288928] out_of_line_wait_on_bit_lock+0x74/0x88
 [c006b33c] __lock_buffer+0x3c/0x4c
 [c006c570] sync_dirty_buffer+0x58/0x130
 [e2eef13c] ext2_xattr_delete_inode+0x1bc/0x278 [ext2]
 [e2ee8324] ext2_free_inode+0x38/0x27c [ext2]
 [e2eeb0a8] ext2_delete_inode+0x8c/0xac [ext2] [c00863b0] generic_delete_inode+0x104/0x17c
 [c0085450] iput+0x9c/0xb0
 [c007b09c] sys_unlink+0x124/0x180
 [c00046dc] ret_from_syscall+0x0/0x44

I have had the same with the entry point being sys_rename:

[gpg --recv-key ...]

gpg           D 0F6D76B4     0 19099   3976 19103               (NOTLB)
Call trace:
 [c0007524] __switch_to+0x54/0x6c
 [c0287c28] schedule+0x584/0x634
 [c0287d08] io_schedule+0x30/0x60
 [c006be78] sync_buffer+0x50/0x64
 [c0288854] __wait_on_bit_lock+0x60/0xc0
 [c0288928] out_of_line_wait_on_bit_lock+0x74/0x88
 [c006b33c] __lock_buffer+0x3c/0x4c
 [c006c570] sync_dirty_buffer+0x58/0x130
 [e2eaf13c] ext2_xattr_delete_inode+0x1bc/0x278 [ext2]
 [e2ea8324] ext2_free_inode+0x38/0x27c [ext2]
 [e2eab0a8] ext2_delete_inode+0x8c/0xac [ext2] [c00863b0] generic_delete_inode+0x104/0x17c
 [c0085450] iput+0x9c/0xb0
 [c0083b14] dput+0x234/0x264
 [c007b908] sys_rename+0x168/0x1c4

I can write other files to the device without trouble, but it's
clearly getting stuck somewhere inside the kernel.  In all the times
it's happened so far, eventually pdflush will subsequently go into D
state, and it's downhill from there (I can't unmount the filesystems
properly, and shutdown also hangs, so have to use Alt-SysRq to remount
readonly and reboot).

The device is using usb-storage, rather than ub:
$ cat /proc/partitions |grep sda
   8     0     125952 sda
   8     1      97776 sda1
   8     2      28160 sda2


I'll be happy to provide any additional details or do any further
testing.


Regards,
Roger

-- 
Roger Leigh
                Printing on GNU/Linux?  http://gimp-print.sourceforge.net/
                Debian GNU/Linux        http://www.debian.org/
                GPG Public Key: 0x25BFB848.  Please sign and encrypt your mail.
