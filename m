Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269617AbTGUKX5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 06:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269621AbTGUKX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 06:23:57 -0400
Received: from tmi.comex.ru ([217.10.33.92]:33465 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S269617AbTGUKXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 06:23:54 -0400
X-Comment-To: Konstantin Kletschke
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1-mm2 ext3 Oops and root mount issue
From: Alex Tomas <bzzz@tmi.comex.ru>
To: linux-kernel@vger.kernel.org
Organization: HOME
Date: Mon, 21 Jul 2003 14:38:33 +0000
In-Reply-To: <20030721102037.GA1453@synertronixx3> (Konstantin Kletschke's
 message of "Mon, 21 Jul 2003 12:20:37 +0200")
Message-ID: <87k7acymfq.fsf@gw.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.3 (gnu/linux)
References: <20030721102037.GA1453@synertronixx3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this is my stupid 'fix' in -mm2. sorry for this.
please, apply fix from Andrew



--- linux-2.5.74/fs/ext3/inode.c~ext3-getblk-race-fix	Wed Jul 16 15:04:33 2003
+++ linux-2.5.74-alexey/fs/ext3/inode.c	Mon Jul 21 14:36:37 2003
@@ -936,14 +936,12 @@ struct buffer_head *ext3_getblk(handle_t
 			   ext3_get_block instead, so it's not a
 			   problem. */
 			lock_buffer(bh);
-			if (!buffer_uptodate(bh)) {
-				BUFFER_TRACE(bh, "call get_create_access");
-				fatal = ext3_journal_get_create_access(handle, bh);
-				if (!fatal) {
-					memset(bh->b_data, 0,
-							inode->i_sb->s_blocksize);
-					set_buffer_uptodate(bh);
-				}
+			BUFFER_TRACE(bh, "call get_create_access");
+			fatal = ext3_journal_get_create_access(handle, bh);
+			if (!fatal && !buffer_uptodate(bh)) {
+				memset(bh->b_data, 0,
+						inode->i_sb->s_blocksize);
+				set_buffer_uptodate(bh);
 			}
 			unlock_buffer(bh);
 			BUFFER_TRACE(bh, "call ext3_journal_dirty_metadata");

_


>>>>> Konstantin Kletschke (KK) writes:

 KK> Hi!
 KK> @home on i845PE and @work on SiS730 I got ext3 Oopses on more than
 KK> normal (not heavy) ide disk I/O:

 KK>  kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000014
 KK>  kernel:  printing eip:
 KK>  kernel: c01d37ac
 KK>  kernel: *pde = 00000000
 KK>  kernel: Oops: 0000 [#1]
 KK>  kernel: PREEMPT DEBUG_PAGEALLOC
 KK>  kernel: CPU:    0
 KK>  kernel: EIP:    0060:[journal_dirty_metadata+92/912]    Not tainted VLI
 KK>  kernel: EFLAGS: 00010246
 KK>  kernel: EIP is at journal_dirty_metadata+0x5c/0x390
 KK>  kernel: eax: 00000000   ebx: dac7f004   ecx: 00000000   edx: cb1a63b4
 KK>  kernel: esi: c0f60f04   edi: 00000000   ebp: cb5b0004   esp: c53e9e5c
 KK>  kernel: ds: 007b   es: 007b   ss: 0068
 KK>  kernel: Process cvs (pid: 791, threadinfo=c53e8000 task=c0f4e000)
 KK>  kernel: Stack: 00001000 dbaee658 c01732e7 dbaee658 c0170673 c0f60f04 c0f60f04 c0f60f04
 KK>  kernel:        cb1a63b4 00000001 ca7720c4 c01c272c cb1a63b4 c0f60f04 00000000 00001000
 KK>  kernel:        c53e9eac 00000001 00000001 00000000 00000030 ca772040 c01c0cda da5e7d04
 KK>  kernel: Call Trace:
 KK>  kernel:  [__getblk+55/112] __getblk+0x37/0x70
 KK>  kernel:  [wake_up_buffer+19/64] wake_up_buffer+0x13/0x40
 KK>  kernel:  [ext3_getblk+252/688] ext3_getblk+0xfc/0x2b0
 KK>  kernel:  [ext3_new_inode+442/2144] ext3_new_inode+0x1ba/0x860
 KK>  kernel:  [kmem_cache_alloc+156/432] kmem_cache_alloc+0x9c/0x1b0
 KK>  kernel:  [ext3_bread+51/192] ext3_bread+0x33/0xc0
 KK>  kernel:  [ext3_mkdir+212/720] ext3_mkdir+0xd4/0x2d0
 KK>  kernel:  [ext3_mkdir+0/720] ext3_mkdir+0x0/0x2d0
 KK>  kernel:  [vfs_mkdir+116/208] vfs_mkdir+0x74/0xd0
 KK>  kernel:  [sys_mkdir+183/256] sys_mkdir+0xb7/0x100
 KK>  kernel:  [sys_munmap+88/128] sys_munmap+0x58/0x80
 KK>  kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
 KK>  kernel:
 KK>  kernel: Code: ff 40 14 0f ba 2e 10 19 c0 85 c0 74 1a 89 f6 0f ba 26 10 19 c0 85
 KK>                c0 0f 85 36 03 00 00 0f ba 2e 10 19 c0 85 c0 75 e8 8b 54 24 30 <8b>
 KK>                47 14 3b 02 0f 84 d1 02 00 00 b8 00 e0 ff ff 21 e0 ff 40 14
 KK>  kernel:  <6>note: cvs[791] exited with preempt_count 1
 KK>  kernel: Debug: sleeping function called from invalid context at include/asm/semaphore.h:119
 KK>  kernel: Call Trace:
 KK>  kernel:  [__might_sleep+95/112] __might_sleep+0x5f/0x70
 KK>  kernel:  [remove_shared_vm_struct+62/160] remove_shared_vm_struct+0x3e/0xa0
 KK>  kernel:  [exit_mmap+475/704] exit_mmap+0x1db/0x2c0
 KK>  kernel:  [do_page_fault+0/1155] do_page_fault+0x0/0x483
 KK>  kernel:  [mmput+197/368] mmput+0xc5/0x170
 KK>  kernel:  [do_exit+412/2368] do_exit+0x19c/0x940
 KK>  kernel:  [do_page_fault+0/1155] do_page_fault+0x0/0x483
 KK>  kernel:  [die+587/592] die+0x24b/0x250
 KK>  kernel:  [do_page_fault+300/1155] do_page_fault+0x12c/0x483
 KK>  kernel:  [ext3_mark_iloc_dirty+40/64] ext3_mark_iloc_dirty+0x28/0x40
 KK>  kernel:  [ext3_mark_inode_dirty+79/96] ext3_mark_inode_dirty+0x4f/0x60
 KK>  kernel:  [find_get_page+121/352] find_get_page+0x79/0x160
 KK>  kernel:  [bh_lru_install+168/224] bh_lru_install+0xa8/0xe0
 KK>  kernel:  [do_page_fault+0/1155] do_page_fault+0x0/0x483
 KK>  kernel:  [error_code+45/56] error_code+0x2d/0x38
 KK>  kernel:  [journal_dirty_metadata+92/912] journal_dirty_metadata+0x5c/0x390
 KK>  kernel:  [__getblk+55/112] __getblk+0x37/0x70
 KK>  kernel:  [wake_up_buffer+19/64] wake_up_buffer+0x13/0x40
 KK>  kernel:  [ext3_getblk+252/688] ext3_getblk+0xfc/0x2b0
 KK>  kernel:  [ext3_new_inode+442/2144] ext3_new_inode+0x1ba/0x860
 KK>  kernel:  [kmem_cache_alloc+156/432] kmem_cache_alloc+0x9c/0x1b0
 KK>  kernel:  [ext3_bread+51/192] ext3_bread+0x33/0xc0
 KK>  kernel:  [ext3_mkdir+212/720] ext3_mkdir+0xd4/0x2d0
 KK>  kernel:  [ext3_mkdir+0/720] ext3_mkdir+0x0/0x2d0
 KK>  kernel:  [vfs_mkdir+116/208] vfs_mkdir+0x74/0xd0
 KK>  kernel:  [sys_mkdir+183/256] sys_mkdir+0xb7/0x100
 KK>  kernel:  [sys_munmap+88/128] sys_munmap+0x58/0x80
 KK>  kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
 KK>  kernel:

 KK> I too experinced that this kernel is not able too mount root at
 KK> /dev/hda1 but giving him the devfs name of the partition helped :-)

 KK> Konsti

 KK> -- 
 KK> 2.5.73-mm2
 KK> Konstantin Kletschke <konsti@ludenkalle.de>, <konsti@ku-gbr.de>
 KK> GPG KeyID EF62FCEF
 KK> Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
 KK> keulator.homelinux.org up 39 min, 1
 KK> -
 KK> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
 KK> the body of a message to majordomo@vger.kernel.org
 KK> More majordomo info at  http://vger.kernel.org/majordomo-info.html
 KK> Please read the FAQ at  http://www.tux.org/lkml/

