Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbULVOQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbULVOQh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 09:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbULVOQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 09:16:37 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:15245 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261794AbULVOQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 09:16:00 -0500
Date: Wed, 22 Dec 2004 09:16:00 -0500
To: linux-kernel@vger.kernel.org
Subject: Problem with XFS and/or VM deadlock in 2.6.8
Message-ID: <20041222141600.GA26253@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been having trouble with the filesystem apparently locking up on
a P4 2.8GHz HT machine (1GB ram, dual 120G SATA in raid1 with LVM on
top).

It locks up when I try and delete a lot of small files at once.
Yesterday I tried to go delete a build dir for gcc-3.3 and while waiting
for that 1.1GB to be deleted, went to delete a few other source dirs.
When it got down to about 38M left for gcc-3.3 it stopped getting any
further and top just showed rm in state D.  A few other rm's eventually
hit that state too.

When I went to reboot the machine to get it back to working normally, I
noticed the console had a bunch of messages from XFS and the VM.  So I
saved the messages in the hopes someone can figure something out to make
this go away.

Kernel version: 2.6.8-1-686-smp v2.6.8-10 (Debian sarge/sid build).

Errors from dmesg:
ad_extents+0x50/0x110 [xfs]
 [<f89fadcf>] xfs_bunmapi+0x101f/0x10c0 [xfs]
 [<f8a38f2c>] xfs_trans_unreserve_and_mod_sb+0x18c/0x190 [xfs]
 [<f8a4973a>] pagebuf_rele+0x3a/0x170 [xfs]
 [<f8a399b8>] xfs_trans_tail_ail+0x38/0x80 [xfs]
 [<f8a2c847>] xlog_state_release_iclog+0x27/0x110 [xfs]
 [<f8a3b517>] xfs_trans_unlock_items+0x57/0xe0 [xfs]
 [<f8a2bca9>] xlog_grant_log_space+0x189/0x4f0 [xfs]
 [<f8a3b08d>] xfs_trans_log_inode+0x2d/0x60 [xfs]
 [<f8a21b5a>] xfs_itruncate_finish+0x1fa/0x460 [xfs]
 [<f8a40f29>] xfs_inactive+0x509/0x570 [xfs]
 [<f8a51ecf>] vn_rele+0xff/0x120 [xfs]
 [<f8a504e8>] linvfs_clear_inode+0x18/0x30 [xfs]
 [<c017c486>] clear_inode+0xe6/0x120
 [<c017d68a>] generic_delete_inode+0x16a/0x1a0
 [<c017d8b3>] iput+0x63/0x90
 [<c0172043>] sys_unlink+0x113/0x140
 [<c0108ae5>] do_IRQ+0xe5/0x1a0
 [<c01061fb>] syscall_call+0x7/0xb
possible deadlock in kmem_alloc (mode:0x50)
printk: 107 messages suppressed.
rm: page allocation failure. order:5, mode:0x50
 [<c0142e59>] __alloc_pages+0x2f9/0x370
 [<c0142ef5>] __get_free_pages+0x25/0x40
 [<c0146a03>] kmem_getpages+0x23/0xd0
 [<c01477b6>] cache_grow+0xe6/0x1e0
 [<c0147a43>] cache_alloc_refill+0x193/0x250
 [<c0121442>] release_console_sem+0xe2/0xf0
 [<c0147f78>] __kmalloc+0x88/0xa0
 [<f8a464b9>] kmem_alloc+0x59/0xc0 [xfs]
 [<f8a21220>] xfs_iread_extents+0x50/0x110 [xfs]
 [<f89fadcf>] xfs_bunmapi+0x101f/0x10c0 [xfs]
 [<f8a38f2c>] xfs_trans_unreserve_and_mod_sb+0x18c/0x190 [xfs]
 [<f8a4973a>] pagebuf_rele+0x3a/0x170 [xfs]
 [<f8a399b8>] xfs_trans_tail_ail+0x38/0x80 [xfs]
 [<f8a2c847>] xlog_state_release_iclog+0x27/0x110 [xfs]
 [<f8a3b517>] xfs_trans_unlock_items+0x57/0xe0 [xfs]
 [<f8a2bca9>] xlog_grant_log_space+0x189/0x4f0 [xfs]
 [<f8a3b08d>] xfs_trans_log_inode+0x2d/0x60 [xfs]
 [<f8a21b5a>] xfs_itruncate_finish+0x1fa/0x460 [xfs]
 [<f8a40f29>] xfs_inactive+0x509/0x570 [xfs]
 [<f8a51ecf>] vn_rele+0xff/0x120 [xfs]
 [<f8a504e8>] linvfs_clear_inode+0x18/0x30 [xfs]
 [<c017c486>] clear_inode+0xe6/0x120
 [<c017d68a>] generic_delete_inode+0x16a/0x1a0
 [<c017d8b3>] iput+0x63/0x90
 [<c0172043>] sys_unlink+0x113/0x140
 [<c0108ae5>] do_IRQ+0xe5/0x1a0
 [<c01061fb>] syscall_call+0x7/0xb
possible deadlock in kmem_alloc (mode:0x50)
printk: 111 messages suppressed.
rm: page allocation failure. order:5, mode:0x50
 [<c0142e59>] __alloc_pages+0x2f9/0x370
 [<c0142ef5>] __get_free_pages+0x25/0x40
 [<c0146a03>] kmem_getpages+0x23/0xd0
 [<c01477b6>] cache_grow+0xe6/0x1e0
 [<c0147a43>] cache_alloc_refill+0x193/0x250
 [<c0121442>] release_console_sem+0xe2/0xf0
 [<c0147f78>] __kmalloc+0x88/0xa0
 [<f8a464b9>] kmem_alloc+0x59/0xc0 [xfs]
 [<f8a21220>] xfs_iread_extents+0x50/0x110 [xfs]
 [<f89fadcf>] xfs_bunmapi+0x101f/0x10c0 [xfs]
 [<f8a38f2c>] xfs_trans_unreserve_and_mod_sb+0x18c/0x190 [xfs]
 [<f8a4973a>] pagebuf_rele+0x3a/0x170 [xfs]
 [<f8a399b8>] xfs_trans_tail_ail+0x38/0x80 [xfs]
 [<f8a2c847>] xlog_state_release_iclog+0x27/0x110 [xfs]
 [<f8a3b517>] xfs_trans_unlock_items+0x57/0xe0 [xfs]
 [<f8a2bca9>] xlog_grant_log_space+0x189/0x4f0 [xfs]
 [<f8a3b08d>] xfs_trans_log_inode+0x2d/0x60 [xfs]
 [<f8a21b5a>] xfs_itruncate_finish+0x1fa/0x460 [xfs]
 [<f8a40f29>] xfs_inactive+0x509/0x570 [xfs]
 [<f8a51ecf>] vn_rele+0xff/0x120 [xfs]
 [<f8a504e8>] linvfs_clear_inode+0x18/0x30 [xfs]
 [<c017c486>] clear_inode+0xe6/0x120
 [<c017d68a>] generic_delete_inode+0x16a/0x1a0
 [<c017d8b3>] iput+0x63/0x90
 [<c0172043>] sys_unlink+0x113/0x140
 [<c0108ae5>] do_IRQ+0xe5/0x1a0
 [<c01061fb>] syscall_call+0x7/0xb
possible deadlock in kmem_alloc (mode:0x50)
possible deadlock in kmem_alloc (mode:0x50)
printk: 122 messages suppressed.
rm: page allocation failure. order:5, mode:0x50
 [<c0142e59>] __alloc_pages+0x2f9/0x370
 [<c0142ef5>] __get_free_pages+0x25/0x40
 [<c0146a03>] kmem_getpages+0x23/0xd0
 [<c01477b6>] cache_grow+0xe6/0x1e0
 [<c0147a43>] cache_alloc_refill+0x193/0x250
 [<c0121442>] release_console_sem+0xe2/0xf0
 [<c0147f78>] __kmalloc+0x88/0xa0
 [<f8a464b9>] kmem_alloc+0x59/0xc0 [xfs]
 [<f8a21220>] xfs_iread_extents+0x50/0x110 [xfs]
 [<f89fadcf>] xfs_bunmapi+0x101f/0x10c0 [xfs]
 [<f8a38f2c>] xfs_trans_unreserve_and_mod_sb+0x18c/0x190 [xfs]
 [<f8a4973a>] pagebuf_rele+0x3a/0x170 [xfs]
 [<f8a399b8>] xfs_trans_tail_ail+0x38/0x80 [xfs]
 [<f8a2c847>] xlog_state_release_iclog+0x27/0x110 [xfs]
 [<f8a3b517>] xfs_trans_unlock_items+0x57/0xe0 [xfs]
 [<f8a2bca9>] xlog_grant_log_space+0x189/0x4f0 [xfs]
 [<f8a3b08d>] xfs_trans_log_inode+0x2d/0x60 [xfs]
 [<f8a21b5a>] xfs_itruncate_finish+0x1fa/0x460 [xfs]
 [<f8a40f29>] xfs_inactive+0x509/0x570 [xfs]
 [<f8a51ecf>] vn_rele+0xff/0x120 [xfs]
 [<f8a504e8>] linvfs_clear_inode+0x18/0x30 [xfs]
 [<c017c486>] clear_inode+0xe6/0x120
 [<c017d68a>] generic_delete_inode+0x16a/0x1a0
 [<c017d8b3>] iput+0x63/0x90
 [<c0172043>] sys_unlink+0x113/0x140
 [<c0108ae5>] do_IRQ+0xe5/0x1a0
 [<c01061fb>] syscall_call+0x7/0xb
possible deadlock in kmem_alloc (mode:0x50)
printk: 105 messages suppressed.
rm: page allocation failure. order:5, mode:0x50
 [<c0142e59>] __alloc_pages+0x2f9/0x370
 [<c0142ef5>] __get_free_pages+0x25/0x40
 [<c0146a03>] kmem_getpages+0x23/0xd0
 [<c01477b6>] cache_grow+0xe6/0x1e0
 [<c0147a43>] cache_alloc_refill+0x193/0x250
 [<c0121442>] release_console_sem+0xe2/0xf0
 [<c0147f78>] __kmalloc+0x88/0xa0
 [<f8a464b9>] kmem_alloc+0x59/0xc0 [xfs]
 [<f8a21220>] xfs_iread_extents+0x50/0x110 [xfs]
 [<f89fadcf>] xfs_bunmapi+0x101f/0x10c0 [xfs]
 [<f8a38f2c>] xfs_trans_unreserve_and_mod_sb+0x18c/0x190 [xfs]
 [<f8a4973a>] pagebuf_rele+0x3a/0x170 [xfs]
 [<f8a399b8>] xfs_trans_tail_ail+0x38/0x80 [xfs]
 [<f8a2c847>] xlog_state_release_iclog+0x27/0x110 [xfs]
 [<f8a3b517>] xfs_trans_unlock_items+0x57/0xe0 [xfs]
 [<f8a2bca9>] xlog_grant_log_space+0x189/0x4f0 [xfs]
 [<f8a3b08d>] xfs_trans_log_inode+0x2d/0x60 [xfs]
 [<f8a21b5a>] xfs_itruncate_finish+0x1fa/0x460 [xfs]
 [<f8a40f29>] xfs_inactive+0x509/0x570 [xfs]
 [<f8a51ecf>] vn_rele+0xff/0x120 [xfs]
 [<f8a504e8>] linvfs_clear_inode+0x18/0x30 [xfs]
 [<c017c486>] clear_inode+0xe6/0x120
 [<c017d68a>] generic_delete_inode+0x16a/0x1a0
 [<c017d8b3>] iput+0x63/0x90
 [<c0172043>] sys_unlink+0x113/0x140
 [<c0108ae5>] do_IRQ+0xe5/0x1a0
 [<c01061fb>] syscall_call+0x7/0xb
possible deadlock in kmem_alloc (mode:0x50)
printk: 104 messages suppressed.
rm: page allocation failure. order:5, mode:0x50
 [<c0142e59>] __alloc_pages+0x2f9/0x370
 [<c0142ef5>] __get_free_pages+0x25/0x40
 [<c0146a03>] kmem_getpages+0x23/0xd0
 [<c01477b6>] cache_grow+0xe6/0x1e0
 [<c0147a43>] cache_alloc_refill+0x193/0x250
 [<c0121442>] release_console_sem+0xe2/0xf0
 [<c0147f78>] __kmalloc+0x88/0xa0
 [<f8a464b9>] kmem_alloc+0x59/0xc0 [xfs]
 [<f8a21220>] xfs_iread_extents+0x50/0x110 [xfs]
 [<f89fadcf>] xfs_bunmapi+0x101f/0x10c0 [xfs]
 [<f8a38f2c>] xfs_trans_unreserve_and_mod_sb+0x18c/0x190 [xfs]
 [<f8a4973a>] pagebuf_rele+0x3a/0x170 [xfs]
 [<f8a399b8>] xfs_trans_tail_ail+0x38/0x80 [xfs]
 [<f8a2c847>] xlog_state_release_iclog+0x27/0x110 [xfs]
 [<f8a3b517>] xfs_trans_unlock_items+0x57/0xe0 [xfs]
 [<f8a2bca9>] xlog_grant_log_space+0x189/0x4f0 [xfs]
 [<f8a3b08d>] xfs_trans_log_inode+0x2d/0x60 [xfs]
 [<f8a21b5a>] xfs_itruncate_finish+0x1fa/0x460 [xfs]
 [<f8a40f29>] xfs_inactive+0x509/0x570 [xfs]
 [<f8a51ecf>] vn_rele+0xff/0x120 [xfs]
 [<f8a504e8>] linvfs_clear_inode+0x18/0x30 [xfs]
 [<c017c486>] clear_inode+0xe6/0x120
 [<c017d68a>] generic_delete_inode+0x16a/0x1a0
 [<c017d8b3>] iput+0x63/0x90
 [<c0172043>] sys_unlink+0x113/0x140
 [<c0108ae5>] do_IRQ+0xe5/0x1a0
 [<c01061fb>] syscall_call+0x7/0xb
possible deadlock in kmem_alloc (mode:0x50)
printk: 113 messages suppressed.
rm: page allocation failure. order:5, mode:0x50
 [<c0142e59>] __alloc_pages+0x2f9/0x370
 [<c0142ef5>] __get_free_pages+0x25/0x40
 [<c0146a03>] kmem_getpages+0x23/0xd0
 [<c01477b6>] cache_grow+0xe6/0x1e0
 [<c0147a43>] cache_alloc_refill+0x193/0x250
 [<c0121442>] release_console_sem+0xe2/0xf0
 [<c0147f78>] __kmalloc+0x88/0xa0
 [<f8a464b9>] kmem_alloc+0x59/0xc0 [xfs]
 [<f8a21220>] xfs_iread_extents+0x50/0x110 [xfs]
 [<f89fadcf>] xfs_bunmapi+0x101f/0x10c0 [xfs]
 [<f8a38f2c>] xfs_trans_unreserve_and_mod_sb+0x18c/0x190 [xfs]
 [<f8a4973a>] pagebuf_rele+0x3a/0x170 [xfs]
 [<f8a399b8>] xfs_trans_tail_ail+0x38/0x80 [xfs]
 [<f8a2c847>] xlog_state_release_iclog+0x27/0x110 [xfs]
 [<f8a3b517>] xfs_trans_unlock_items+0x57/0xe0 [xfs]
 [<f8a2bca9>] xlog_grant_log_space+0x189/0x4f0 [xfs]
 [<f8a3b08d>] xfs_trans_log_inode+0x2d/0x60 [xfs]
 [<f8a21b5a>] xfs_itruncate_finish+0x1fa/0x460 [xfs]
 [<f8a40f29>] xfs_inactive+0x509/0x570 [xfs]
 [<f8a51ecf>] vn_rele+0xff/0x120 [xfs]
 [<f8a504e8>] linvfs_clear_inode+0x18/0x30 [xfs]
 [<c017c486>] clear_inode+0xe6/0x120
 [<c017d68a>] generic_delete_inode+0x16a/0x1a0
 [<c017d8b3>] iput+0x63/0x90
 [<c0172043>] sys_unlink+0x113/0x140
 [<c0108ae5>] do_IRQ+0xe5/0x1a0
 [<c01061fb>] syscall_call+0x7/0xb
possible deadlock in kmem_alloc (mode:0x50)
possible deadlock in kmem_alloc (mode:0x50)
printk: 181 messages suppressed.
rm: page allocation failure. order:5, mode:0x50
 [<c0142e59>] __alloc_pages+0x2f9/0x370
 [<c0142ef5>] __get_free_pages+0x25/0x40
 [<c0146a03>] kmem_getpages+0x23/0xd0
 [<c01477b6>] cache_grow+0xe6/0x1e0
 [<c0147a43>] cache_alloc_refill+0x193/0x250
 [<c0121442>] release_console_sem+0xe2/0xf0
 [<c0147f78>] __kmalloc+0x88/0xa0
 [<f8a464b9>] kmem_alloc+0x59/0xc0 [xfs]
 [<f8a21220>] xfs_iread_extents+0x50/0x110 [xfs]
 [<f89fadcf>] xfs_bunmapi+0x101f/0x10c0 [xfs]
 [<f8a38f2c>] xfs_trans_unreserve_and_mod_sb+0x18c/0x190 [xfs]
 [<f8a4973a>] pagebuf_rele+0x3a/0x170 [xfs]
 [<f8a399b8>] xfs_trans_tail_ail+0x38/0x80 [xfs]
 [<f8a2c847>] xlog_state_release_iclog+0x27/0x110 [xfs]
 [<f8a3b517>] xfs_trans_unlock_items+0x57/0xe0 [xfs]
 [<f8a2bca9>] xlog_grant_log_space+0x189/0x4f0 [xfs]
 [<f8a3b08d>] xfs_trans_log_inode+0x2d/0x60 [xfs]
 [<f8a21b5a>] xfs_itruncate_finish+0x1fa/0x460 [xfs]
 [<f8a40f29>] xfs_inactive+0x509/0x570 [xfs]
 [<f8a51ecf>] vn_rele+0xff/0x120 [xfs]
 [<f8a504e8>] linvfs_clear_inode+0x18/0x30 [xfs]
 [<c017c486>] clear_inode+0xe6/0x120
 [<c017d68a>] generic_delete_inode+0x16a/0x1a0
 [<c017d8b3>] iput+0x63/0x90
 [<c0172043>] sys_unlink+0x113/0x140
 [<c0108ae5>] do_IRQ+0xe5/0x1a0
 [<c01061fb>] syscall_call+0x7/0xb
possible deadlock in kmem_alloc (mode:0x50)
printk: 103 messages suppressed.
rm: page allocation failure. order:5, mode:0x50
 [<c0142e59>] __alloc_pages+0x2f9/0x370
 [<c0142ef5>] __get_free_pages+0x25/0x40
 [<c0146a03>] kmem_getpages+0x23/0xd0
 [<c01477b6>] cache_grow+0xe6/0x1e0
 [<c0147a43>] cache_alloc_refill+0x193/0x250
 [<c0121442>] release_console_sem+0xe2/0xf0
 [<c0147f78>] __kmalloc+0x88/0xa0
 [<f8a464b9>] kmem_alloc+0x59/0xc0 [xfs]
 [<f8a21220>] xfs_iread_extents+0x50/0x110 [xfs]
 [<f89fadcf>] xfs_bunmapi+0x101f/0x10c0 [xfs]
 [<f8a38f2c>] xfs_trans_unreserve_and_mod_sb+0x18c/0x190 [xfs]
 [<f8a4973a>] pagebuf_rele+0x3a/0x170 [xfs]
 [<f8a399b8>] xfs_trans_tail_ail+0x38/0x80 [xfs]
 [<f8a2c847>] xlog_state_release_iclog+0x27/0x110 [xfs]
 [<f8a3b517>] xfs_trans_unlock_items+0x57/0xe0 [xfs]
 [<f8a2bca9>] xlog_grant_log_space+0x189/0x4f0 [xfs]
 [<f8a3b08d>] xfs_trans_log_inode+0x2d/0x60 [xfs]
 [<f8a21b5a>] xfs_itruncate_finish+0x1fa/0x460 [xfs]
 [<f8a40f29>] xfs_inactive+0x509/0x570 [xfs]
 [<f8a51ecf>] vn_rele+0xff/0x120 [xfs]
 [<f8a504e8>] linvfs_clear_inode+0x18/0x30 [xfs]
 [<c017c486>] clear_inode+0xe6/0x120
 [<c017d68a>] generic_delete_inode+0x16a/0x1a0
 [<c017d8b3>] iput+0x63/0x90
 [<c0172043>] sys_unlink+0x113/0x140
 [<c0108ae5>] do_IRQ+0xe5/0x1a0
 [<c01061fb>] syscall_call+0x7/0xb
possible deadlock in kmem_alloc (mode:0x50)
printk: 98 messages suppressed.
rm: page allocation failure. order:5, mode:0x50
 [<c0142e59>] __alloc_pages+0x2f9/0x370
 [<c0142ef5>] __get_free_pages+0x25/0x40
 [<c0146a03>] kmem_getpages+0x23/0xd0
 [<c01477b6>] cache_grow+0xe6/0x1e0
 [<c0147a43>] cache_alloc_refill+0x193/0x250
 [<c0121442>] release_console_sem+0xe2/0xf0
 [<c0147f78>] __kmalloc+0x88/0xa0
 [<f8a464b9>] kmem_alloc+0x59/0xc0 [xfs]
 [<f8a21220>] xfs_iread_extents+0x50/0x110 [xfs]
 [<f89fadcf>] xfs_bunmapi+0x101f/0x10c0 [xfs]
 [<f8a38f2c>] xfs_trans_unreserve_and_mod_sb+0x18c/0x190 [xfs]
 [<f8a4973a>] pagebuf_rele+0x3a/0x170 [xfs]
 [<f8a399b8>] xfs_trans_tail_ail+0x38/0x80 [xfs]
 [<f8a2c847>] xlog_state_release_iclog+0x27/0x110 [xfs]
 [<f8a3b517>] xfs_trans_unlock_items+0x57/0xe0 [xfs]
 [<f8a2bca9>] xlog_grant_log_space+0x189/0x4f0 [xfs]
 [<f8a3b08d>] xfs_trans_log_inode+0x2d/0x60 [xfs]
 [<f8a21b5a>] xfs_itruncate_finish+0x1fa/0x460 [xfs]
 [<f8a40f29>] xfs_inactive+0x509/0x570 [xfs]
 [<f8a51ecf>] vn_rele+0xff/0x120 [xfs]
 [<f8a504e8>] linvfs_clear_inode+0x18/0x30 [xfs]
 [<c017c486>] clear_inode+0xe6/0x120
 [<c017d68a>] generic_delete_inode+0x16a/0x1a0
 [<c017d8b3>] iput+0x63/0x90
 [<c0172043>] sys_unlink+0x113/0x140
 [<c0108ae5>] do_IRQ+0xe5/0x1a0
 [<c01061fb>] syscall_call+0x7/0xb
possible deadlock in kmem_alloc (mode:0x50)
printk: 101 messages suppressed.
rm: page allocation failure. order:5, mode:0x50
 [<c0142e59>] __alloc_pages+0x2f9/0x370
 [<c0142ef5>] __get_free_pages+0x25/0x40
 [<c0146a03>] kmem_getpages+0x23/0xd0
 [<c01477b6>] cache_grow+0xe6/0x1e0
 [<c0147a43>] cache_alloc_refill+0x193/0x250
 [<c0121442>] release_console_sem+0xe2/0xf0
 [<c0147f78>] __kmalloc+0x88/0xa0
 [<f8a464b9>] kmem_alloc+0x59/0xc0 [xfs]
 [<f8a21220>] xfs_iread_extents+0x50/0x110 [xfs]
 [<f89fadcf>] xfs_bunmapi+0x101f/0x10c0 [xfs]
 [<f8a38f2c>] xfs_trans_unreserve_and_mod_sb+0x18c/0x190 [xfs]
 [<f8a4973a>] pagebuf_rele+0x3a/0x170 [xfs]
 [<f8a399b8>] xfs_trans_tail_ail+0x38/0x80 [xfs]
 [<f8a2c847>] xlog_state_release_iclog+0x27/0x110 [xfs]
 [<f8a3b517>] xfs_trans_unlock_items+0x57/0xe0 [xfs]
 [<f8a2bca9>] xlog_grant_log_space+0x189/0x4f0 [xfs]
 [<f8a3b08d>] xfs_trans_log_inode+0x2d/0x60 [xfs]
 [<f8a21b5a>] xfs_itruncate_finish+0x1fa/0x460 [xfs]
 [<f8a40f29>] xfs_inactive+0x509/0x570 [xfs]
 [<f8a51ecf>] vn_rele+0xff/0x120 [xfs]
 [<f8a504e8>] linvfs_clear_inode+0x18/0x30 [xfs]
 [<c017c486>] clear_inode+0xe6/0x120
 [<c017d68a>] generic_delete_inode+0x16a/0x1a0
 [<c017d8b3>] iput+0x63/0x90
 [<c0172043>] sys_unlink+0x113/0x140
 [<c0108ae5>] do_IRQ+0xe5/0x1a0
 [<c01061fb>] syscall_call+0x7/0xb
possible deadlock in kmem_alloc (mode:0x50)
printk: 108 messages suppressed.
rm: page allocation failure. order:5, mode:0x50
 [<c0142e59>] __alloc_pages+0x2f9/0x370
 [<c0142ef5>] __get_free_pages+0x25/0x40
 [<c0146a03>] kmem_getpages+0x23/0xd0
 [<c01477b6>] cache_grow+0xe6/0x1e0
 [<c0147a43>] cache_alloc_refill+0x193/0x250
 [<c0121442>] release_console_sem+0xe2/0xf0
 [<c0147f78>] __kmalloc+0x88/0xa0
 [<f8a464b9>] kmem_alloc+0x59/0xc0 [xfs]
 [<f8a21220>] xfs_iread_extents+0x50/0x110 [xfs]
 [<f89fadcf>] xfs_bunmapi+0x101f/0x10c0 [xfs]
 [<f8a38f2c>] xfs_trans_unreserve_and_mod_sb+0x18c/0x190 [xfs]
 [<f8a4973a>] pagebuf_rele+0x3a/0x170 [xfs]
 [<f8a399b8>] xfs_trans_tail_ail+0x38/0x80 [xfs]
 [<f8a2c847>] xlog_state_release_iclog+0x27/0x110 [xfs]
 [<f8a3b517>] xfs_trans_unlock_items+0x57/0xe0 [xfs]
 [<f8a2bca9>] xlog_grant_log_space+0x189/0x4f0 [xfs]
 [<f8a3b08d>] xfs_trans_log_inode+0x2d/0x60 [xfs]
 [<f8a21b5a>] xfs_itruncate_finish+0x1fa/0x460 [xfs]
 [<f8a40f29>] xfs_inactive+0x509/0x570 [xfs]
 [<f8a51ecf>] vn_rele+0xff/0x120 [xfs]
 [<f8a504e8>] linvfs_clear_inode+0x18/0x30 [xfs]
 [<c017c486>] clear_inode+0xe6/0x120
 [<c017d68a>] generic_delete_inode+0x16a/0x1a0
 [<c017d8b3>] iput+0x63/0x90
 [<c0172043>] sys_unlink+0x113/0x140
 [<c0108ae5>] do_IRQ+0xe5/0x1a0
 [<c01061fb>] syscall_call+0x7/0xb
----

I tried sending it through ksymoops, but that doesn't seem to apply here
since it isn't an oops, and the System.map entries seem to be already
decoded in the messages from dmesg.

I upgraded the system to 2.6.9-3 from Debian yesterday to try and see if
it runs better, although I don't often go deleting lots of files.  I
could always create some files to delete of course to test it again.

Len Sorensen
