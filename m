Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbTIZB5W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 21:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbTIZB5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 21:57:22 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:48322 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S262336AbTIZB5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 21:57:16 -0400
Subject: kernel BUG using multipath on 2.6.0-test5
From: Steven Dake <sdake@mvista.com>
Reply-To: sdake@mvista.com
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: MontaVista Software, Inc.
Message-Id: <1064541435.4763.51.camel@persist.az.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 25 Sep 2003 18:57:15 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

I've finally gotten around to trying out 2.6.0-test5 with some automatic
multipathing code on which I am working.  The code automatically
determines and configures multiple paths to a device using the MD
driver.

My program works fine on 2.4.x + qlogic FC driver but not on 2.6.0-test5
with qlogic FC driver.  The qlogic FC driver works for the individual
drives, so it is less likely the cuase of the problem.

The mdstat looks like this:
root@192.168.1.95:~# cat /proc/mdstat
Personalities : [linear] [raid0] [raid1] [raid5] [multipath]
md254 : active multipath sdb[1] sdd[0]
      1000000 blocks [2/2] [UU]

md255 : active multipath sda[1] sdc[0]
      1000000 blocks [2/2] [UU]

unused devices: <none>

I attempted a mke2fs /dev/md254 (which is the multipath device) and the
process froze.  Looking at varlogmessages, I see:

--------------------

kernel BUG at drivers/scsi/scsi_lib.c:544!
invalid operand: 0000 [#1]
CPU:    2
EIP:    0060:[<c01f5db3>]    Not tainted
EFLAGS: 00010046
EIP is at scsi_alloc_sgtable+0xed/0xfa
eax: 00000000   ebx: e8a75378   ecx: f7ce2424   edx: f7cfd200
esi: f7cfd200   edi: f7cfd200   ebp: f7ce2400   esp: ea11fc68
ds: 007b   es: 007b   ss: 0068
Process mke2fs (pid: 147, threadinfo=ea11e000 task=f76b9940)
Stack: e8a75378 c01f172c f7d21e60 e8a75378 f7cfd200 f7cfd200 f7ce2400
c01f631d
       f7cfd200 00000020 e8a75378 e8a75378 f7cfd200 e8a75378 c01f6455
f7cfd200
       00000020 c03c4680 00000001 e8a75378 f7ce4c00 c03c4680 00000001
c01be1aa
Call Trace:
 [<c01f172c>] __scsi_get_command+0x2b/0x74
 [<c01f631d>] scsi_init_io+0x7a/0x13d
 [<c01f6455>] scsi_prep_fn+0x75/0x171
 [<c01be1aa>] elv_next_request+0x47/0xf1
 [<c01bf9e9>] generic_unplug_device+0x5a/0x69
 [<c01bfb2a>] blk_run_queues+0x85/0x9d
 [<c014da8c>] __wait_on_buffer+0xd7/0xde
 [<c011b4e1>] autoremove_wake_function+0x0/0x4f
 [<c011b4e1>] autoremove_wake_function+0x0/0x4f
 [<c014f8af>] __block_prepare_write+0x11a/0x432
 [<c0150406>] block_prepare_write+0x34/0x4d
 [<c015390a>] blkdev_get_block+0x0/0x5b
 [<c01331bf>] generic_file_aio_write_nolock+0x3be/0xa9e
 [<c015390a>] blkdev_get_block+0x0/0x5b
 [<c013ec16>] do_anonymous_page+0x11f/0x1e9
 [<c0134fff>] buffered_rmqueue+0xc0/0x13f
 [<c0135111>] __alloc_pages+0x93/0x30f
 [<c013391d>] generic_file_write_nolock+0x7e/0x9c
 [<c013f238>] handle_mm_fault+0xf7/0x162
 [<c0117832>] do_page_fault+0x126/0x43f
 [<c01548cc>] blkdev_file_write+0x37/0x3b
 [<c014c7a6>] vfs_write+0xbc/0x127
 [<c0153ac7>] block_llseek+0x0/0xef
 [<c014c8b6>] sys_write+0x42/0x63
 [<c01090d7>] syscall_call+0x7/0xb

Code: 0f 0b 20 02 1c bb 2c c0 e9 2d ff ff ff 8b 44 24 08 8b 54 24

Should this work or is multipath known broken in 2.6?  Anyone have
started debugging multipath and want to work together on it?

Thanks
-steve

