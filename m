Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbVEUVpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbVEUVpI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 17:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbVEUVpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 17:45:08 -0400
Received: from ms-smtp-04-smtplb.tampabay.rr.com ([65.32.5.134]:59075 "EHLO
	ms-smtp-04.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S261638AbVEUVoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 17:44:55 -0400
Date: Sat, 21 May 2005 17:44:28 -0400
From: Chuck Berg <chuck@encinc.com>
To: linux-kernel@vger.kernel.org
Subject: hung nfs mount hangs all disk writes on the system
Message-ID: <20050521214428.GA28358@encinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a repeatable problem, where all disk writes on the system hang if an
NFS server disappears from the network during heavy writes.

This affects at least 2.6.11.10, 2.6.12-rc4, and Redhat's 2.6.9-5.ELsmp.
It happens whether I do an NFS version 2, 3, or 4 mount.

To reproduce:

mount somewhere:/v1 /v1
dd if=/dev/zero of=/v1/foo bs=1024k count=4096 &
route add -host somewhere bogushost
strace -tT dd if=/dev/zero of=/tmp/foo bs=4k count=1024

dd will usually get stuck in a write() call after a few blocks.

The system recovers after removing the blackhole route and umount -f'ing the
mount to the unreachable NFS server.

Here's sysrq-t output, for those tasks stuck in the D state. dd 5232 is
writing over NFS, the only one legitimately in the D state. The rest
are innocent victims, writing to local disk.

  task             PC      pid father child younger older
syslogd       D 00000004  5548  2662      1          2666  2618 (NOTLB)
f72d5bcc 00000082 f7ff0b14 00000004 00000000 f72d5be0 f72d5bcc 00000246 
       c01a377b 0000000a 00000286 c0125c82 00000046 f7d12c10 00000000 32bb4700 
       000f45f8 f7db6708 003e67a0 f72d5be0 f72d5c58 f72d5c28 c035c606 f7f2c538 
Call Trace:
 [<c035c606>] schedule_timeout+0x85/0xd2
 [<c035c565>] io_schedule_timeout+0xe/0x16
 [<c02813e9>] blk_congestion_wait+0x6d/0x82
 [<c014f475>] balance_dirty_pages+0x83/0x116
 [<c014ade3>] generic_file_buffered_write+0x251/0x56e
 [<c014b3e9>] __generic_file_aio_write_nolock+0x2e9/0x540
 [<c014b74c>] __generic_file_write_nolock+0x7e/0xa0
 [<c014ba8d>] generic_file_writev+0x4c/0xba
 [<c0173c99>] do_readv_writev+0x1f7/0x21f
 [<c0173d4f>] vfs_writev+0x40/0x51
 [<c0173e34>] sys_writev+0x3d/0x97
 [<c01036bd>] sysenter_past_esp+0x52/0x75
sshd          D F7FFF080  5928  3811   2965          3858       (NOTLB)
f5fd1f00 00000086 f5d62888 f7fff080 f5fd1ec8 c0151857 f7fff080 f5fd1ef0 
       c0153ce9 f7ff8580 f5fd1ee0 c0151857 c01742f0 00000020 00000000 a2280500 
       000f45c7 f7d12808 f72902b4 f72902bc 00000246 f5fd1f54 c035a2e5 f5fd1f20 
Call Trace:
 [<c035a2e5>] __down+0xb9/0x2db
 [<c035a822>] __down_failed+0xa/0x10
 [<c01742cc>] .text.lock.read_write+0xb/0x2f
 [<c017335a>] vfs_llseek+0x33/0x3a
 [<c0173430>] sys_llseek+0x44/0x8a
 [<c01036bd>] sysenter_past_esp+0x52/0x75
sshd          D F7FFF080  5772 10805   2965         14747  4973 (NOTLB)
f3f1ff00 00000086 f5329eb8 f7fff080 f3f1fec8 c0151857 f7fff080 f3f1fef0 
       c0153ce9 f7ff8580 f3f1fee0 c0151857 c01742f0 00000020 00000000 35803ec0 
       000f45c9 f7f1cd78 f72902b4 f72902bc 00000246 f3f1ff54 c035a2e5 f3f1ff20 
Call Trace:
 [<c035a2e5>] __down+0xb9/0x2db
 [<c035a822>] __down_failed+0xa/0x10
 [<c01742cc>] .text.lock.read_write+0xb/0x2f
 [<c017335a>] vfs_llseek+0x33/0x3a
 [<c0173430>] sys_llseek+0x44/0x8a
 [<c01036bd>] sysenter_past_esp+0x52/0x75
dd            D C844FC2C  5232 14672   3860                     (NOTLB)
c844fbf8 00000086 00000000 c844fc2c 00000000 c844fc0c c844fbf8 00000246 
       c02f3e75 c21ca114 00000286 003a5ded c844fbec f7d12c10 00000000 32bb4700 
       000f45f8 f7d2e888 003e67a0 c844fc0c c844fc84 c844fc54 c035c606 c844fc0c 
Call Trace:
 [<c035c606>] schedule_timeout+0x85/0xd2
 [<c035c565>] io_schedule_timeout+0xe/0x16
 [<c02813e9>] blk_congestion_wait+0x6d/0x82
 [<c014f475>] balance_dirty_pages+0x83/0x116
 [<c014ade3>] generic_file_buffered_write+0x251/0x56e
 [<c014b3e9>] __generic_file_aio_write_nolock+0x2e9/0x540
 [<c014b873>] generic_file_aio_write+0x65/0xd3
 [<f8e54724>] nfs_file_write+0x80/0xe2 [nfs]
 [<c017377a>] do_sync_write+0x91/0xdd
 [<c01738d1>] vfs_write+0x10b/0x10d
 [<c0173974>] sys_write+0x3d/0x64
 [<c01036bd>] sysenter_past_esp+0x52/0x75
sshd          D 00000004  5476 14747   2965         14906 10805 (NOTLB)
cb177c14 00000086 f7ff0b14 00000004 00000000 cb177c28 cb177c14 00000246 
       c01a377b 00000001 00000286 86fdc12b 000f45e4 f7db65a0 00000000 32bb4700 
       000f45f8 f7d9a598 003e67a0 cb177c28 cb177ca0 cb177c70 c035c606 f7c0b1dc 
Call Trace:
 [<c035c606>] schedule_timeout+0x85/0xd2
 [<c035c565>] io_schedule_timeout+0xe/0x16
 [<c02813e9>] blk_congestion_wait+0x6d/0x82
 [<c014f475>] balance_dirty_pages+0x83/0x116
 [<c014ade3>] generic_file_buffered_write+0x251/0x56e
 [<c014b3e9>] __generic_file_aio_write_nolock+0x2e9/0x540
 [<c014b873>] generic_file_aio_write+0x65/0xd3
 [<f88c66ce>] ext3_file_write+0x27/0xad [ext3]
 [<c017377a>] do_sync_write+0x91/0xdd
 [<c01738d1>] vfs_write+0x10b/0x10d
 [<c0173974>] sys_write+0x3d/0x64
 [<c01036bd>] sysenter_past_esp+0x52/0x75
sshd          D F7FFF080  6932 14908  14906                     (NOTLB)
f3847f00 00000082 f5329ee4 f7fff080 f3847ec8 c0151857 f7fff080 f3847ef0 
       c0153ce9 f7ff8580 f3847ee0 c0151857 c01742f0 f7d13180 00000000 eb5b4f40 
       000f45ca f7f1d858 f72902b4 f72902bc 00000246 f3847f54 c035a2e5 f3847f20 
Call Trace:
 [<c035a2e5>] __down+0xb9/0x2db
 [<c035a822>] __down_failed+0xa/0x10
 [<c01742cc>] .text.lock.read_write+0xb/0x2f
 [<c017335a>] vfs_llseek+0x33/0x3a
 [<c0173430>] sys_llseek+0x44/0x8a
 [<c01036bd>] sysenter_past_esp+0x52/0x75
dd            D 00000001  6020 14948      1               14669 (NOTLB)
c948bc14 00000082 f5debd44 00000001 00000000 c948bc28 c948bc14 00000246 
       c01a377b f76cd3f8 00000286 f88ca956 00001000 f7d2e720 00000000 32bb4700 
       000f45f8 f7d12d78 003e67a0 c948bc28 c948bca0 c948bc70 c035c606 c948bc54 
Call Trace:
 [<c035c606>] schedule_timeout+0x85/0xd2
 [<c035c565>] io_schedule_timeout+0xe/0x16
 [<c02813e9>] blk_congestion_wait+0x6d/0x82
 [<c014f475>] balance_dirty_pages+0x83/0x116
 [<c014ade3>] generic_file_buffered_write+0x251/0x56e
 [<c014b3e9>] __generic_file_aio_write_nolock+0x2e9/0x540
 [<c014b873>] generic_file_aio_write+0x65/0xd3
 [<f88c66ce>] ext3_file_write+0x27/0xad [ext3]
 [<c017377a>] do_sync_write+0x91/0xdd
 [<c01738d1>] vfs_write+0x10b/0x10d
 [<c0173974>] sys_write+0x3d/0x64
 [<c0103713>] syscall_call+0x7/0xb
sshd          D F7FFF080  6932 14953  14951                     (NOTLB)
c9507f00 00000082 f54e3ddc f7fff080 c9507ec8 c0151857 f7fff080 c9507ef0 
       c0153ce9 f7ff8580 c9507ee0 c0151857 c01742f0 c23bac10 00000000 79a70780 
       000f45d5 c23bb858 f72902b4 f72902bc 00000246 c9507f54 c035a2e5 c9507f20 
Call Trace:
 [<c035a2e5>] __down+0xb9/0x2db
 [<c035a822>] __down_failed+0xa/0x10
 [<c01742cc>] .text.lock.read_write+0xb/0x2f
 [<c017335a>] vfs_llseek+0x33/0x3a
 [<c0173430>] sys_llseek+0x44/0x8a
 [<c01036bd>] sysenter_past_esp+0x52/0x75

