Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbWAEP7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWAEP7o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 10:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWAEP7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 10:59:44 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:50842 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1750906AbWAEP7n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 10:59:43 -0500
From: Roger Leigh <rleigh@whinlatter.ukfsn.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       autofs@linux.kernel.org, raven@themaw.net
Subject: Re: BUG: 2.6.14/2.6.15: USB storage/ext2fs uninterruptable sleep
References: <87zmmbt1ce.fsf@hardknott.home.whinlatter.ukfsn.org>
	<20060105054106.2d4076bc.akpm@osdl.org>
Date: Thu, 05 Jan 2006 15:59:41 +0000
In-Reply-To: <20060105054106.2d4076bc.akpm@osdl.org> (Andrew Morton's message
	of "Thu, 5 Jan 2006 05:41:06 -0800")
Message-ID: <87irsypswi.fsf@hardknott.home.whinlatter.ukfsn.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton <akpm@osdl.org> writes:

> Roger Leigh <rleigh@whinlatter.ukfsn.org> wrote:
>>
>> Hi folks,
>>
>> I use a USB storage device (Kingston 128 MiB keydrive) to hold GPG
>> keys, which is automounted with autofs4.  It's looking like a write
>> operation on the device (so far always involving an ext2_delete_inode
>> up to sync_buffer) causes the process to hang in an uninterruptable
>> sleep.
>>
>> The system is running stock kernel.org linux-2.6.15 and 2.6.14.5 on a
>> PowerPC 7447A system (Mac Mini) running Debian unstable.  The .config
>> is here: http://www.whinlatter.ukfsn.org/config-2.6.15-hardknott.bz2
>>
>> For example:
>> # cd /misc/pen-secure/.gnupg
>> # rm secring.gpg.lock pubring.gpg.lock pubring.gpg.tmp
>>
>> 7818 pts/1    D+     0:00 rm secring.gpg.lock pubring.gpg.lock pubring.gpg.tmp
>>
>> rm            D 0FF35634     0  7818   7196                   (NOTLB)
>> Call trace:
>>  [c0007524] __switch_to+0x54/0x6c
>>  [c0287c28] schedule+0x584/0x634
>>  [c0287d08] io_schedule+0x30/0x60
>>  [c006be78] sync_buffer+0x50/0x64
>>  [c0288854] __wait_on_bit_lock+0x60/0xc0
>>  [c0288928] out_of_line_wait_on_bit_lock+0x74/0x88
>>  [c006b33c] __lock_buffer+0x3c/0x4c
>>  [c006c570] sync_dirty_buffer+0x58/0x130
>>  [e2eef13c] ext2_xattr_delete_inode+0x1bc/0x278 [ext2]
>>  [e2ee8324] ext2_free_inode+0x38/0x27c [ext2]
>>  [e2eeb0a8] ext2_delete_inode+0x8c/0xac [ext2] [c00863b0] generic_delete_inode+0x104/0x17c
>>  [c0085450] iput+0x9c/0xb0
>>  [c007b09c] sys_unlink+0x124/0x180
>>  [c00046dc] ret_from_syscall+0x0/0x44
>>
>> I have had the same with the entry point being sys_rename:
>>
>> [gpg --recv-key ...]
>>
>> gpg           D 0F6D76B4     0 19099   3976 19103               (NOTLB)
>> Call trace:
>>  [c0007524] __switch_to+0x54/0x6c
>>  [c0287c28] schedule+0x584/0x634
>>  [c0287d08] io_schedule+0x30/0x60
>>  [c006be78] sync_buffer+0x50/0x64
>>  [c0288854] __wait_on_bit_lock+0x60/0xc0
>>  [c0288928] out_of_line_wait_on_bit_lock+0x74/0x88
>>  [c006b33c] __lock_buffer+0x3c/0x4c
>>  [c006c570] sync_dirty_buffer+0x58/0x130
>>  [e2eaf13c] ext2_xattr_delete_inode+0x1bc/0x278 [ext2]
>>  [e2ea8324] ext2_free_inode+0x38/0x27c [ext2]
>>  [e2eab0a8] ext2_delete_inode+0x8c/0xac [ext2] [c00863b0] generic_delete_inode+0x104/0x17c
>>  [c0085450] iput+0x9c/0xb0
>>  [c0083b14] dput+0x234/0x264
>>  [c007b908] sys_rename+0x168/0x1c4
>>
>> I can write other files to the device without trouble, but it's
>> clearly getting stuck somewhere inside the kernel.  In all the times
>> it's happened so far, eventually pdflush will subsequently go into D
>> state, and it's downhill from there (I can't unmount the filesystems
>> properly, and shutdown also hangs, so have to use Alt-SysRq to remount
>> readonly and reboot).
>>
>> The device is using usb-storage, rather than ub:
>> $ cat /proc/partitions |grep sda
>>    8     0     125952 sda
>>    8     1      97776 sda1
>>    8     2      28160 sda2
>>
>>
>> I'll be happy to provide any additional details or do any further
>> testing.

> I'd say that usb-storage is failing to send back I/O completions.

With some further testing with both usb-storage and ub, both show the
same behaviour when using autofs4 _or_ autofs.  When mounting by hand,
the problem does not occur.  While broken on 2.6.15 and 2.6.14, it
does appear to work on 2.6.13; I can't test earlier kernels at the
moment because of udev--I'll have to remove it first.

Using this simple test to exercise the device:
  while true; do cp /etc/fstab fstab; cat fstab; mv fstab t2; cat t2; rm t2; done
I quickly get a lockup with autofs4/autofs, with the device read/write
light lit up continuously.  When I run on a normal mount, the light
flashes once and then remains unlit (since there's nothing to write).
I'm not sure if this observation means autofs is doing something
wrong, but it does look like it's the main part of the problem.

I've CC'd the autofs list and maintainer, in case they can shed any
light on this.


Thanks,
Roger

- -- 
Roger Leigh
                Printing on GNU/Linux?  http://gimp-print.sourceforge.net/
                Debian GNU/Linux        http://www.debian.org/
                GPG Public Key: 0x25BFB848.  Please sign and encrypt your mail.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8+ <http://mailcrypt.sourceforge.net/>

iD8DBQFDvUJkVcFcaSW/uEgRAgpKAKCVvBmabzCtIKLafQv0tw7qHymx+gCfee5L
eP3COOtKcAY+StFV203JsPQ=
=OztQ
-----END PGP SIGNATURE-----
