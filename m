Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271196AbTHCOqd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 10:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271197AbTHCOqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 10:46:33 -0400
Received: from hell.org.pl ([212.244.218.42]:14345 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S271196AbTHCOqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 10:46:30 -0400
Date: Sun, 3 Aug 2003 16:51:13 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: linux-kernel@vger.kernel.org
Subject: [2.5/2.6] buffer layer error at fs/buffer.c:2800 when unlinking
Message-ID: <20030803145113.GA31715@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've recently managed to nail down the problems that have been occuring on 
 my machine at least since 2.5.59. I use XFS as my rootfs, no other
filesystems are compiled in, but I doubt the filesystem is to blame, since
the problem does not appear under 2.4, despite the similar codebase.
Here's the guts: upon unlinking files in /var/{run,lock/subsys} (typically
during shutdown, but not only), and when doing "dd if=/dev/urandom
of=/etc/random-seed count=1 bs=512" the following traces appear:
#v+
buffer layer error at fs/buffer.c:2800
Call Trace:
 [<c014f1c6>] drop_buffers+0xb3/0xb9
 [<c014f208>] try_to_free_buffers+0x3c/0x96
 [<c01db1a1>] linvfs_release_page+0x74/0x78
 [<c014d2e6>] try_to_release_page+0x5c/0x6c
 [<c014d3d9>] block_invalidatepage+0xe3/0xf6
 [<c013a9db>] do_invalidatepage+0x27/0x2b
 [<c013aa66>] truncate_complete_page+0x87/0x89
 [<c013abc3>] truncate_inode_pages+0xcd/0x2be
 [<c01df4f1>] linvfs_unlink+0x5c/0x5e
 [<c0160e4a>] generic_delete_inode+0xc0/0xc5
 [<c0160fce>] iput+0x55/0x6f
 [<c01584bb>] sys_unlink+0x86/0x135
 [<c010905f>] syscall_call+0x7/0xb

buffer layer error at fs/buffer.c:2800
Call Trace:
 [<c014f1c6>] drop_buffers+0xb3/0xb9
 [<c014f208>] try_to_free_buffers+0x3c/0x96
 [<c01db1a1>] linvfs_release_page+0x74/0x78
 [<c014d2e6>] try_to_release_page+0x5c/0x6c
 [<c014d3d9>] block_invalidatepage+0xe3/0xf6
 [<c013a9db>] do_invalidatepage+0x27/0x2b
 [<c013aa66>] truncate_complete_page+0x87/0x89
 [<c013abc3>] truncate_inode_pages+0xcd/0x2be
 [<c01df4f1>] linvfs_unlink+0x5c/0x5e
 [<c0160e4a>] generic_delete_inode+0xc0/0xc5
 [<c0160fce>] iput+0x55/0x6f
 [<c01584bb>] sys_unlink+0x86/0x135
 [<c010905f>] syscall_call+0x7/0xb

// that's pcmcia: one trace for /var/run/cardmgr.pid, one for
// /var/lock/subsys/pcmcia

buffer layer error at fs/buffer.c:2800
Call Trace:
 [<c014f1c6>] drop_buffers+0xb3/0xb9
 [<c014f208>] try_to_free_buffers+0x3c/0x96
 [<c01db1a1>] linvfs_release_page+0x74/0x78
 [<c014d2e6>] try_to_release_page+0x5c/0x6c
 [<c014d3d9>] block_invalidatepage+0xe3/0xf6
 [<c013a9db>] do_invalidatepage+0x27/0x2b
 [<c013aa66>] truncate_complete_page+0x87/0x89
 [<c013abc3>] truncate_inode_pages+0xcd/0x2be
 [<c016ba43>] padzero+0x28/0x2a
 [<c018e6ad>] xfs_bmap_last_offset+0xc2/0x119
 [<c018d929>] xfs_bmap_search_extents+0x70/0x85
 [<c01b55c1>] xfs_file_last_byte+0xea/0xf7
 [<c01b566c>] xfs_itruncate_start+0x9e/0xe2
 [<c01d0bfd>] xfs_setattr+0xdd1/0xfc2
 [<c01df9d8>] linvfs_setattr+0x11d/0x1c6
 [<c0161931>] notify_change+0x150/0x183
 [<c0148fd9>] do_truncate+0x4b/0x62
 [<c01d0e3b>] xfs_access+0x4d/0x5b
 [<c01562e8>] permission+0x46/0x48
 [<c01575ec>] may_open+0x169/0x1ba
 [<c01576e9>] open_namei+0xac/0x3f3
 [<c0149ffd>] filp_open+0x43/0x69
 [<c014a3e4>] sys_open+0x5b/0x8b
 [<c010905f>] syscall_call+0x7/0xb

// that's dd

buffer layer error at fs/buffer.c:2800
Call Trace:
 [<c014f1c6>] drop_buffers+0xb3/0xb9
 [<c014f208>] try_to_free_buffers+0x3c/0x96
 [<c01db1a1>] linvfs_release_page+0x74/0x78
 [<c014d2e6>] try_to_release_page+0x5c/0x6c
 [<c014d3d9>] block_invalidatepage+0xe3/0xf6
 [<c013a9db>] do_invalidatepage+0x27/0x2b
 [<c013aa66>] truncate_complete_page+0x87/0x89
 [<c013abc3>] truncate_inode_pages+0xcd/0x2be
 [<c01df4f1>] linvfs_unlink+0x5c/0x5e
 [<c0160e4a>] generic_delete_inode+0xc0/0xc5
 [<c0160fce>] iput+0x55/0x6f
 [<c01584bb>] sys_unlink+0x86/0x135
 [<c010905f>] syscall_call+0x7/0xb

// that's another one -- probably /var/run/sshd.pid
#v-
Oddly enough, those errors do not appear when I touch and remove the files
manually. I can observe this behaviour on any kernel version between 2.5.59
and 2.6.0-test2. I didn't test earlier versions. The traces come from
2.6.0-test2.

FYI: I never had any fs corruption whatsoever, just those annoying
messages.

I'll be happy to provide any additional information.
Please Cc: me, as I can't handle lkml traffic.

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
