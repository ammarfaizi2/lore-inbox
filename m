Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269589AbTGUKGF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 06:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269601AbTGUKGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 06:06:05 -0400
Received: from [62.67.222.139] ([62.67.222.139]:14976 "EHLO kermit")
	by vger.kernel.org with ESMTP id S269589AbTGUKGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 06:06:00 -0400
Date: Mon, 21 Jul 2003 12:20:37 +0200
From: Konstantin Kletschke <konsti@ludenkalle.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test1-mm2 ext3 Oops and root mount issue
Message-ID: <20030721102037.GA1453@synertronixx3>
Reply-To: konsti@ludenkalle.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Key: http://www.ludenkalle.de/konsti/pubkey.asc
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

@home on i845PE and @work on SiS730 I got ext3 Oopses on more than
normal (not heavy) ide disk I/O:

 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000014
 kernel:  printing eip:
 kernel: c01d37ac
 kernel: *pde = 00000000
 kernel: Oops: 0000 [#1]
 kernel: PREEMPT DEBUG_PAGEALLOC
 kernel: CPU:    0
 kernel: EIP:    0060:[journal_dirty_metadata+92/912]    Not tainted VLI
 kernel: EFLAGS: 00010246
 kernel: EIP is at journal_dirty_metadata+0x5c/0x390
 kernel: eax: 00000000   ebx: dac7f004   ecx: 00000000   edx: cb1a63b4
 kernel: esi: c0f60f04   edi: 00000000   ebp: cb5b0004   esp: c53e9e5c
 kernel: ds: 007b   es: 007b   ss: 0068
 kernel: Process cvs (pid: 791, threadinfo=c53e8000 task=c0f4e000)
 kernel: Stack: 00001000 dbaee658 c01732e7 dbaee658 c0170673 c0f60f04 c0f60f04 c0f60f04
 kernel:        cb1a63b4 00000001 ca7720c4 c01c272c cb1a63b4 c0f60f04 00000000 00001000
 kernel:        c53e9eac 00000001 00000001 00000000 00000030 ca772040 c01c0cda da5e7d04
 kernel: Call Trace:
 kernel:  [__getblk+55/112] __getblk+0x37/0x70
 kernel:  [wake_up_buffer+19/64] wake_up_buffer+0x13/0x40
 kernel:  [ext3_getblk+252/688] ext3_getblk+0xfc/0x2b0
 kernel:  [ext3_new_inode+442/2144] ext3_new_inode+0x1ba/0x860
 kernel:  [kmem_cache_alloc+156/432] kmem_cache_alloc+0x9c/0x1b0
 kernel:  [ext3_bread+51/192] ext3_bread+0x33/0xc0
 kernel:  [ext3_mkdir+212/720] ext3_mkdir+0xd4/0x2d0
 kernel:  [ext3_mkdir+0/720] ext3_mkdir+0x0/0x2d0
 kernel:  [vfs_mkdir+116/208] vfs_mkdir+0x74/0xd0
 kernel:  [sys_mkdir+183/256] sys_mkdir+0xb7/0x100
 kernel:  [sys_munmap+88/128] sys_munmap+0x58/0x80
 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
 kernel:
 kernel: Code: ff 40 14 0f ba 2e 10 19 c0 85 c0 74 1a 89 f6 0f ba 26 10 19 c0 85
               c0 0f 85 36 03 00 00 0f ba 2e 10 19 c0 85 c0 75 e8 8b 54 24 30 <8b>
               47 14 3b 02 0f 84 d1 02 00 00 b8 00 e0 ff ff 21 e0 ff 40 14
 kernel:  <6>note: cvs[791] exited with preempt_count 1
 kernel: Debug: sleeping function called from invalid context at include/asm/semaphore.h:119
 kernel: Call Trace:
 kernel:  [__might_sleep+95/112] __might_sleep+0x5f/0x70
 kernel:  [remove_shared_vm_struct+62/160] remove_shared_vm_struct+0x3e/0xa0
 kernel:  [exit_mmap+475/704] exit_mmap+0x1db/0x2c0
 kernel:  [do_page_fault+0/1155] do_page_fault+0x0/0x483
 kernel:  [mmput+197/368] mmput+0xc5/0x170
 kernel:  [do_exit+412/2368] do_exit+0x19c/0x940
 kernel:  [do_page_fault+0/1155] do_page_fault+0x0/0x483
 kernel:  [die+587/592] die+0x24b/0x250
 kernel:  [do_page_fault+300/1155] do_page_fault+0x12c/0x483
 kernel:  [ext3_mark_iloc_dirty+40/64] ext3_mark_iloc_dirty+0x28/0x40
 kernel:  [ext3_mark_inode_dirty+79/96] ext3_mark_inode_dirty+0x4f/0x60
 kernel:  [find_get_page+121/352] find_get_page+0x79/0x160
 kernel:  [bh_lru_install+168/224] bh_lru_install+0xa8/0xe0
 kernel:  [do_page_fault+0/1155] do_page_fault+0x0/0x483
 kernel:  [error_code+45/56] error_code+0x2d/0x38
 kernel:  [journal_dirty_metadata+92/912] journal_dirty_metadata+0x5c/0x390
 kernel:  [__getblk+55/112] __getblk+0x37/0x70
 kernel:  [wake_up_buffer+19/64] wake_up_buffer+0x13/0x40
 kernel:  [ext3_getblk+252/688] ext3_getblk+0xfc/0x2b0
 kernel:  [ext3_new_inode+442/2144] ext3_new_inode+0x1ba/0x860
 kernel:  [kmem_cache_alloc+156/432] kmem_cache_alloc+0x9c/0x1b0
 kernel:  [ext3_bread+51/192] ext3_bread+0x33/0xc0
 kernel:  [ext3_mkdir+212/720] ext3_mkdir+0xd4/0x2d0
 kernel:  [ext3_mkdir+0/720] ext3_mkdir+0x0/0x2d0
 kernel:  [vfs_mkdir+116/208] vfs_mkdir+0x74/0xd0
 kernel:  [sys_mkdir+183/256] sys_mkdir+0xb7/0x100
 kernel:  [sys_munmap+88/128] sys_munmap+0x58/0x80
 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
 kernel:

I too experinced that this kernel is not able too mount root at
/dev/hda1 but giving him the devfs name of the partition helped :-)

Konsti

-- 
2.5.73-mm2
Konstantin Kletschke <konsti@ludenkalle.de>, <konsti@ku-gbr.de>
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
keulator.homelinux.org up 39 min, 1
