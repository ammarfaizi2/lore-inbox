Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbTKJBo5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 20:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbTKJBo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 20:44:57 -0500
Received: from terra.inf.ufsc.br ([150.162.60.10]:10660 "EHLO
	terra.inf.ufsc.br") by vger.kernel.org with ESMTP id S262106AbTKJBo4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 20:44:56 -0500
From: Gustavo De Nardin <nardin@inf.ufsc.br>
To: linux-kernel@vger.kernel.org
Subject: forcedeth
Date: Sun, 9 Nov 2003 23:45:04 -0200
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200311092245.06049.nardin@inf.ufsc.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  * With MTU 1500, 'ping -s $SIZE anotherhost' doesn' t work for $SIZE >= 1472,
up to 1471 works. With MTU <= 1499 everything seems ok.

  * modprobe -r forcedeth segfaults/oopses.

  Here's what I got in kern.log (using 2.6.0-test9 + Nick Piggin's scheduler v17a,
forcedeth 0.14 from akpm's patches (debug disabled, sorry)):

Nov  9 22:19:34 therion kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000068
Nov  9 22:19:34 therion kernel:  printing eip:
Nov  9 22:19:34 therion kernel: c018e3c5
Nov  9 22:19:34 therion kernel: *pde = 00000000
Nov  9 22:19:34 therion kernel: Oops: 0002 [#1]
Nov  9 22:19:34 therion kernel: CPU:    0
Nov  9 22:19:34 therion kernel: EIP:    0060:[sysfs_hash_and_remove+21/125]    Not tainted
Nov  9 22:19:34 therion kernel: EFLAGS: 00010282
Nov  9 22:19:34 therion kernel: EIP is at sysfs_hash_and_remove+0x15/0x7d
Nov  9 22:19:34 therion kernel: eax: 00000000   ebx: c041a664   ecx: 00000068   edx: cd2ac1f0
Nov  9 22:19:34 therion kernel: esi: cd2ac180   edi: cd1aa800   ebp: cde8a800   esp: c2847e68
Nov  9 22:19:34 therion kernel: ds: 007b   es: 007b   ss: 0068
Nov  9 22:19:34 therion kernel: Process modprobe (pid: 621, threadinfo=c2846000 task=c68a86a0)
Nov  9 22:19:34 therion kernel: Stack: c018e39b c2847e74 c041a664 cd2ac180 c018f92d cd2ac180 c03bc507 cd2ac180
Nov  9 22:19:34 therion kernel:        c041a6c0 c018fa68 cd2ac180 c041a6c0 cd1aa800 cd1aa990 c030b3e5 cd1aa998
Nov  9 22:19:34 therion kernel:        c041a6c0 cd1aa800 c2847ec8 c03080f2 cd1aa800 cd1aa800 c01718ac cd1aa800
Nov  9 22:19:34 therion kernel: Call Trace:
Nov  9 22:19:34 therion kernel:  [sysfs_get_dentry+107/128] sysfs_get_dentry+0x6b/0x80
Nov  9 22:19:34 therion kernel:  [remove_files+45/64] remove_files+0x2d/0x40
Nov  9 22:19:34 therion kernel:  [sysfs_remove_group+40/128] sysfs_remove_group+0x28/0x80
Nov  9 22:19:34 therion kernel:  [netdev_unregister_sysfs+101/112] netdev_unregister_sysfs+0x65/0x70
Nov  9 22:19:34 therion kernel:  [netdev_run_todo+258/512] netdev_run_todo+0x102/0x200
Nov  9 22:19:34 therion kernel:  [destroy_inode+92/96] destroy_inode+0x5c/0x60
Nov  9 22:19:34 therion kernel:  [_end+239382595/1068808528] remove_nic+0x23/0xa0 [forcedeth]
Nov  9 22:19:34 therion kernel:  [dput+34/544] dput+0x22/0x220
Nov  9 22:19:34 therion kernel:  [pci_device_remove+59/64] pci_device_remove+0x3b/0x40
Nov  9 22:19:34 therion kernel:  [device_release_driver+100/112] device_release_driver+0x64/0x70
Nov  9 22:19:34 therion kernel:  [driver_detach+32/48] driver_detach+0x20/0x30
Nov  9 22:19:34 therion kernel:  [bus_remove_driver+61/128] bus_remove_driver+0x3d/0x80
Nov  9 22:19:34 therion kernel:  [driver_unregister+19/40] driver_unregister+0x13/0x28
Nov  9 22:19:34 therion kernel:  [pci_unregister_driver+22/48] pci_unregister_driver+0x16/0x30
Nov  9 22:19:34 therion kernel:  [_end+239382735/1068808528] exit_nic+0xf/0x13 [forcedeth]
Nov  9 22:19:34 therion kernel:  [sys_delete_module+310/400] sys_delete_module+0x136/0x190
Nov  9 22:19:34 therion kernel:  [bad_page+56/144] bad_page+0x38/0x90
Nov  9 22:19:34 therion kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov  9 22:19:34 therion kernel:
Nov  9 22:19:34 therion kernel: Code: ff 48 68 78 63 8b 44 24 18 89 34 24 89 44 24 04 e8 56 ff ff


-- 
# Hope is a waking dream. -- Aristotle
