Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbUKWOcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbUKWOcx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 09:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbUKWOcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 09:32:53 -0500
Received: from pop.gmx.de ([213.165.64.20]:63132 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261258AbUKWOcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 09:32:45 -0500
Date: Tue, 23 Nov 2004 15:32:44 +0100 (MET)
From: "Daniel Blueman" <daniel.blueman@gmx.net>
To: linux-ia64@linuxia64.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: [2.6.9, ia64] sleeping while atomic from 'find /proc'...
X-Priority: 3 (Normal)
X-Authenticated: #8973862
Message-ID: <3964.1101220364@www11.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When running 2.6.9 on an IA64 Intel Tiger 4 system, I saw a series of code
path sleeping while atomic warnings, from doing a 'find /proc':

--- [1]

Debug: sleeping function called from invalid context at mm/mmap.c:94
in_atomic():1, irqs_disabled():0

Call Trace:
 [<a00000010001a6e0>] show_stack+0x80/0xa0
                                sp=e00000002064f830 bsp=e000000020641420
 [<a00000010001a730>] dump_stack+0x30/0x60
                                sp=e00000002064fa00 bsp=e000000020641410
 [<a000000100097c50>] __might_sleep+0x1b0/0x220
                                sp=e00000002064fa00 bsp=e0000000206413e0
 [<a00000010011d3e0>] remove_vm_struct+0x40/0x1c0
                                sp=e00000002064fa10 bsp=e0000000206413a8
 [<a0000001001223e0>] exit_mmap+0x400/0x4e0
                                sp=e00000002064fa10 bsp=e000000020641360
 [<a000000100098fd0>] mmput+0x110/0x1a0
                                sp=e00000002064fad0 bsp=e000000020641340
 [<a0000001000a45d0>] do_exit+0x4d0/0xbc0
                                sp=e00000002064fad0 bsp=e0000000206412c8
 [<a000000100040d90>] die+0x1f0/0x200
                                sp=e00000002064fad0 bsp=e000000020641290
 [<a000000100062aa0>] ia64_do_page_fault+0x200/0xa40
                                sp=e00000002064fad0 bsp=e000000020641230
 [<a0000001000125a0>] ia64_leave_kernel+0x0/0x270
                                sp=e00000002064fb60 bsp=e000000020641230
 [<a0000001001b5d70>] proc_get_inode+0x1b0/0x3e0
                                sp=e00000002064fd30 bsp=e0000000206411d0
 [<a0000001001bc600>] proc_lookup+0x260/0x2c0
                                sp=e00000002064fd30 bsp=e000000020641188
 [<a0000001001b6200>] proc_root_lookup+0x80/0xe0
                                sp=e00000002064fd30 bsp=e000000020641160
 [<a000000100166c70>] real_lookup+0x230/0x2a0
                                sp=e00000002064fd30 bsp=e000000020641120
 [<a0000001001673a0>] do_lookup+0x160/0x180
                                sp=e00000002064fd30 bsp=e0000000206410e0
 [<a000000100168770>] link_path_walk+0x13b0/0x24a0
                                sp=e00000002064fd30 bsp=e000000020641050
 [<a000000100169fa0>] path_lookup+0x180/0x400
                                sp=e00000002064fd50 bsp=e000000020641020
 [<a00000010016a620>] __user_walk+0x80/0xc0
                                sp=e00000002064fd50 bsp=e000000020640ff0
 [<a00000010015deb0>] vfs_lstat+0x30/0xc0
                                sp=e00000002064fd50 bsp=e000000020640fd0
 [<a00000010015e430>] sys_newlstat+0x30/0x80
                                sp=e00000002064fdc0 bsp=e000000020640f78
 [<a000000100012400>] ia64_ret_from_syscall+0x0/0x20
                                sp=e00000002064fe30 bsp=e000000020640f60

--- [2]

Debug: sleeping function called from invalid context at fs/file_table.c:126
in_atomic():1, irqs_disabled():0

Call Trace:
 [<a00000010001a6e0>] show_stack+0x80/0xa0
                                sp=e00000002064f8f0 bsp=e000000020641470
 [<a00000010001a730>] dump_stack+0x30/0x60
                                sp=e00000002064fac0 bsp=e000000020641460
 [<a000000100097c50>] __might_sleep+0x1b0/0x220
                                sp=e00000002064fac0 bsp=e000000020641438
 [<a000000100144950>] __fput+0x50/0x360
                                sp=e00000002064fad0 bsp=e0000000206413e0
 [<a0000001001448e0>] fput+0x40/0x60
                                sp=e00000002064fad0 bsp=e0000000206413c8
 [<a000000100141800>] filp_close+0xc0/0x140
                                sp=e00000002064fad0 bsp=e000000020641398
 [<a0000001000a2250>] put_files_struct+0x130/0x260
                                sp=e00000002064fad0 bsp=e000000020641340
 [<a0000001000a4630>] do_exit+0x530/0xbc0
                                sp=e00000002064fad0 bsp=e0000000206412c8
 [<a000000100040d90>] die+0x1f0/0x200
                                sp=e00000002064fad0 bsp=e000000020641290
 [<a000000100062aa0>] ia64_do_page_fault+0x200/0xa40
                                sp=e00000002064fad0 bsp=e000000020641230
 [<a0000001000125a0>] ia64_leave_kernel+0x0/0x270
                                sp=e00000002064fb60 bsp=e000000020641230
 [<a0000001001b5d70>] proc_get_inode+0x1b0/0x3e0
                                sp=e00000002064fd30 bsp=e0000000206411d0
 [<a0000001001bc600>] proc_lookup+0x260/0x2c0
                                sp=e00000002064fd30 bsp=e000000020641188
 [<a0000001001b6200>] proc_root_lookup+0x80/0xe0
                                sp=e00000002064fd30 bsp=e000000020641160
 [<a000000100166c70>] real_lookup+0x230/0x2a0
                                sp=e00000002064fd30 bsp=e000000020641120
 [<a0000001001673a0>] do_lookup+0x160/0x180
                                sp=e00000002064fd30 bsp=e0000000206410e0
 [<a000000100168770>] link_path_walk+0x13b0/0x24a0
                                sp=e00000002064fd30 bsp=e000000020641050
 [<a000000100169fa0>] path_lookup+0x180/0x400
                                sp=e00000002064fd50 bsp=e000000020641020
 [<a00000010016a620>] __user_walk+0x80/0xc0
                                sp=e00000002064fd50 bsp=e000000020640ff0
 [<a00000010015deb0>] vfs_lstat+0x30/0xc0
                                sp=e00000002064fd50 bsp=e000000020640fd0
 [<a00000010015e430>] sys_newlstat+0x30/0x80
                                sp=e00000002064fdc0 bsp=e000000020640f78
 [<a000000100012400>] ia64_ret_from_syscall+0x0/0x20
                                sp=e00000002064fe30 bsp=e000000020640f60

--- [3]

Debug: sleeping function called from invalid context at
include/asm/semaphore.h:65
in_atomic():1, irqs_disabled():0

Call Trace:
 [<a00000010001a6e0>] show_stack+0x80/0xa0
                                sp=e00000002064f8f0 bsp=e0000000206414c0
 [<a00000010001a730>] dump_stack+0x30/0x60
                                sp=e00000002064fac0 bsp=e0000000206414b0
 [<a000000100097c50>] __might_sleep+0x1b0/0x220
                                sp=e00000002064fac0 bsp=e000000020641488
 [<a000000100164cf0>] pipe_release+0x30/0x1e0
                                sp=e00000002064fad0 bsp=e000000020641458
 [<a000000100165370>] pipe_write_release+0x50/0x80
                                sp=e00000002064fad0 bsp=e000000020641438
 [<a000000100144c40>] __fput+0x340/0x360
                                sp=e00000002064fad0 bsp=e0000000206413e0
 [<a0000001001448e0>] fput+0x40/0x60
                                sp=e00000002064fad0 bsp=e0000000206413c8
 [<a000000100141800>] filp_close+0xc0/0x140
                                sp=e00000002064fad0 bsp=e000000020641398
 [<a0000001000a2250>] put_files_struct+0x130/0x260
                                sp=e00000002064fad0 bsp=e000000020641340
 [<a0000001000a4630>] do_exit+0x530/0xbc0
                                sp=e00000002064fad0 bsp=e0000000206412c8
 [<a000000100040d90>] die+0x1f0/0x200
                                sp=e00000002064fad0 bsp=e000000020641290
 [<a000000100062aa0>] ia64_do_page_fault+0x200/0xa40
                                sp=e00000002064fad0 bsp=e000000020641230
 [<a0000001000125a0>] ia64_leave_kernel+0x0/0x270
                                sp=e00000002064fb60 bsp=e000000020641230
 [<a0000001001b5d70>] proc_get_inode+0x1b0/0x3e0
                                sp=e00000002064fd30 bsp=e0000000206411d0
 [<a0000001001bc600>] proc_lookup+0x260/0x2c0
                                sp=e00000002064fd30 bsp=e000000020641188
 [<a0000001001b6200>] proc_root_lookup+0x80/0xe0
                                sp=e00000002064fd30 bsp=e000000020641160
 [<a000000100166c70>] real_lookup+0x230/0x2a0
                                sp=e00000002064fd30 bsp=e000000020641120
 [<a0000001001673a0>] do_lookup+0x160/0x180
                                sp=e00000002064fd30 bsp=e0000000206410e0
 [<a000000100168770>] link_path_walk+0x13b0/0x24a0
                                sp=e00000002064fd30 bsp=e000000020641050
 [<a000000100169fa0>] path_lookup+0x180/0x400
                                sp=e00000002064fd50 bsp=e000000020641020
 [<a00000010016a620>] __user_walk+0x80/0xc0
                                sp=e00000002064fd50 bsp=e000000020640ff0
 [<a00000010015deb0>] vfs_lstat+0x30/0xc0
                                sp=e00000002064fd50 bsp=e000000020640fd0
 [<a00000010015e430>] sys_newlstat+0x30/0x80
                                sp=e00000002064fdc0 bsp=e000000020640f78
 [<a000000100012400>] ia64_ret_from_syscall+0x0/0x20
                                sp=e00000002064fe30 bsp=e000000020640f60

-- 
Daniel J Blueman

Geschenkt: 3 Monate GMX ProMail + 3 Top-Spielfilme auf DVD
++ Jetzt kostenlos testen http://www.gmx.net/de/go/mail ++
