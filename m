Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWJKK2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWJKK2n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 06:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWJKK2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 06:28:43 -0400
Received: from server128114.rev.netart.pl ([85.128.128.114]:56254 "EHLO
	tech.serwery.pl") by vger.kernel.org with ESMTP id S1751159AbWJKK2m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 06:28:42 -0400
Date: Wed, 11 Oct 2006 12:28:38 +0200
From: NetArt - Grzegorz Nosek <grzegorz.nosek@netart.pl>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18 xfs lockdep warning
Message-ID: <20061011102838.GA10195@tech.serwery.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

(not subscribed, please cc)

I'd like to report a lockdep warning with 2.6.18 while unmounting a
xfs filesystem.

Tested on vanilla 2.6.18, the trace I get is as follows:

[ 9545.550736] =============================================
[ 9545.555027] [ INFO: possible recursive locking detected ]
[ 9545.558413] ---------------------------------------------
[ 9545.569664] umount/2057 is trying to acquire lock:
[ 9545.572641]  (&(&ip->i_lock)->mr_lock){----}, at: [<d091c7d5>] xfs_ilock+0x6e/0xd5 [xfs]
[ 9545.585636]
[ 9545.585642] but task is already holding lock:
[ 9545.593578]  (&(&ip->i_lock)->mr_lock){----}, at: [<d091c7d5>] xfs_ilock+0x6e/0xd5 [xfs]
[ 9545.603325]
[ 9545.603330] other info that might help us debug this:
[ 9545.621763] 3 locks held by umount/2057:
[ 9545.633364]  #0:  (&type->s_umount_key#14){----}, at: [<c0166915>] deactivate_super+0x5e/0x75
[ 9545.660334]  #1:  (&type->s_lock_key#7){--..}, at: [<c034f9c3>] mutex_lock+0x8/0xa
[ 9545.676017]  #2:  (&(&ip->i_lock)->mr_lock){----}, at: [<d091c7d5>] xfs_ilock+0x6e/0xd5 [xfs]
[ 9545.691166]
[ 9545.691170] stack backtrace:
[ 9545.710694]  [<c0104cb6>] show_trace+0x12/0x14
[ 9545.723104]  [<c0104cd1>] dump_stack+0x19/0x1c
[ 9545.730674]  [<c0133cd6>] __lock_acquire+0x8ff/0xd05
[ 9545.740433]  [<c01343f7>] lock_acquire+0x5c/0x79
[ 9545.747058]  [<c0130c26>] down_write+0x2b/0x44
[ 9545.761096]  [<d091c7d5>] xfs_ilock+0x6e/0xd5 [xfs]
[ 9545.776963]  [<d08e7ab7>] xfs_qm_unmount_quotas+0x5f/0x16c [xfs]
[ 9545.790230]  [<d0938955>] xfs_unmount_flush+0x11b/0x14d [xfs]
[ 9545.800454]  [<d093a83b>] xfs_unmount+0xca/0x192 [xfs]
[ 9545.819482]  [<d094bee9>] vfs_unmount+0x18/0x39 [xfs]
[ 9545.830789]  [<d094b19b>] xfs_fs_put_super+0x31/0x70 [xfs]
[ 9545.841637]  [<c0166669>] generic_shutdown_super+0x85/0x131
[ 9545.856059]  [<c0166735>] kill_block_super+0x20/0x32
[ 9545.865847]  [<c016691a>] deactivate_super+0x63/0x75
[ 9545.871602]  [<c017a53c>] mntput_no_expire+0x44/0x69
[ 9545.881504]  [<c016cd65>] path_release_on_umount+0x15/0x18
[ 9545.899773]  [<c017b2d3>] sys_umount+0x3b/0x1f0
[ 9545.906425]  [<c017b4a1>] sys_oldumount+0x19/0x1b
[ 9545.916040]  [<c0102bdf>] syscall_call+0x7/0xb

I have added some debugging code that prints xfs_ilock's arguments and
a stack trace if called from xfs_unmount(). The dumps just before the
lockdep warning:

[ 9545.278026] xfs_ilock: ip = cf34bc80, lock_flags = 4
[ 9545.281364] BUG: warning at fs/xfs/xfs_iget.c:851/xfs_ilock()
[ 9545.289024]  [<c0104cb6>] show_trace+0x12/0x14
[ 9545.292870]  [<c0104cd1>] dump_stack+0x19/0x1c
[ 9545.295737]  [<d091c837>] xfs_ilock+0xd0/0xd5 [xfs]
[ 9545.299567]  [<d0938861>] xfs_unmount_flush+0x27/0x14d [xfs]
[ 9545.303186]  [<d093a83b>] xfs_unmount+0xca/0x192 [xfs]
[ 9545.308828]  [<d094bee9>] vfs_unmount+0x18/0x39 [xfs]
[ 9545.312102]  [<d094b19b>] xfs_fs_put_super+0x31/0x70 [xfs]
[ 9545.315431]  [<c0166669>] generic_shutdown_super+0x85/0x131
[ 9545.319170]  [<c0166735>] kill_block_super+0x20/0x32
[ 9545.322319]  [<c016691a>] deactivate_super+0x63/0x75
[ 9545.338958]  [<c017a53c>] mntput_no_expire+0x44/0x69
[ 9545.356379]  [<c016cd65>] path_release_on_umount+0x15/0x18
[ 9545.366478]  [<c017b2d3>] sys_umount+0x3b/0x1f0
[ 9545.372272]  [<c017b4a1>] sys_oldumount+0x19/0x1b
[ 9545.381929]  [<c0102bdf>] syscall_call+0x7/0xb
[ 9545.407021] xfs_ilock: ip = cf34ba80, lock_flags = 4
[ 9545.416564] BUG: warning at fs/xfs/xfs_iget.c:851/xfs_ilock()
[ 9545.426716]  [<c0104cb6>] show_trace+0x12/0x14
[ 9545.432407]  [<c0104cd1>] dump_stack+0x19/0x1c
[ 9545.442094]  [<d091c837>] xfs_ilock+0xd0/0xd5 [xfs]
[ 9545.456621]  [<d08e7ab7>] xfs_qm_unmount_quotas+0x5f/0x16c [xfs]
[ 9545.470647]  [<d0938955>] xfs_unmount_flush+0x11b/0x14d [xfs]
[ 9545.480818]  [<d093a83b>] xfs_unmount+0xca/0x192 [xfs]
[ 9545.490890]  [<d094bee9>] vfs_unmount+0x18/0x39 [xfs]
[ 9545.500808]  [<d094b19b>] xfs_fs_put_super+0x31/0x70 [xfs]
[ 9545.513308]  [<c0166669>] generic_shutdown_super+0x85/0x131
[ 9545.517250]  [<c0166735>] kill_block_super+0x20/0x32
[ 9545.520460]  [<c016691a>] deactivate_super+0x63/0x75
[ 9545.523602]  [<c017a53c>] mntput_no_expire+0x44/0x69
[ 9545.526630]  [<c016cd65>] path_release_on_umount+0x15/0x18
[ 9545.530142]  [<c017b2d3>] sys_umount+0x3b/0x1f0
[ 9545.543931]  [<c017b4a1>] sys_oldumount+0x19/0x1b
[ 9545.547650]  [<c0102bdf>] syscall_call+0x7/0xb

So these warnings might be bogus as they refer to different `ip'
variables.

In my setup it's 100% reproducible (the first umount after reboot
only, I presume lockdep shuts up afterwards). Has anybody else
noticed this behaviour? I have scanned through the git repository
up to 2.6.19-rc1-gitsomething and couldn't find anything related.

XFS-related .config snippet:

CONFIG_XFS_FS=m
CONFIG_XFS_QUOTA=y
# CONFIG_XFS_SECURITY is not set
CONFIG_XFS_POSIX_ACL=y
# CONFIG_XFS_RT is not set
# CONFIG_VXFS_FS is not set

Best regards,
 Grzegorz Nosek

