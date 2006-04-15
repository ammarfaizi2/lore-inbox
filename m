Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbWDOLUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWDOLUK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 07:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWDOLUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 07:20:10 -0400
Received: from smtp.blackdown.de ([213.239.206.42]:34962 "EHLO
	smtp.blackdown.de") by vger.kernel.org with ESMTP id S932482AbWDOLUI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 07:20:08 -0400
From: Juergen Kreileder <jk@blackdown.de>
To: Alasdair G Kergon <agk@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: BUG at drivers/md/kcopyd.c:146 (was: [PATCH 1/9] device-mapper snapshot: load metadata on creation)
References: <20060120211116.GB4724@agk.surrey.redhat.com>
X-PGP-Key: http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0x730A28A5
X-PGP-Fingerprint: 7C19 D069 9ED5 DC2E 1B10  9859 C027 8D5B 730A 28A5
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>, Andrew Morton
	<akpm@osdl.org>, linux-kernel@vger.kernel.org
Date: Sat, 15 Apr 2006 13:19:51 +0200
In-Reply-To: <20060120211116.GB4724@agk.surrey.redhat.com> (Alasdair
	G. Kergon's message of "Fri, 20 Jan 2006 21:11:16 +0000")
Message-ID: <87odz3f5m0.fsf@blackdown.de>
Organization: Blackdown Java-Linux Team
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alasdair G. Kergon <agk@redhat.com> writes:

> Move snapshot metadata loading to happen when the table is created 
> instead of when the device is resumed.  Writes to the origin device
> don't trigger exceptions until each snapshot table becomes active 
> when resume() is called on each snapshot.
>
> If you're using lvm2, for this patch to work properly you should
> update to lvm2 version 2.02.01 or later and device-mapper version
> 1.02.02 or later.

I'm using devmapper 1.02.03 and lvm2 2.02.02 with 2.6.16.2,
nevertheless my logical volumes locked up three time when removing
snapshots so far.  Twice I got BUG at drivers/md/kcopyd.c:146, the
third time logging stopped at the first lvremove.

2.6.15 and earlier kernels in combination with older tools worked fine
over the last year.


        Juergen

kernel BUG at drivers/md/kcopyd.c:146!
invalid opcode: 0000 [#1]
CPU:    0
EIP:    0060:[client_free_pages+42/64]    Not tainted VLI
EFLAGS: 00010283   (2.6.16.2-exec-shield #1) 
EIP is at client_free_pages+0x2a/0x40
eax: 00000100   ebx: f6a92880   ecx: c18df0c0   edx: 00000000
esi: f4636880   edi: c044b13c   ebp: f88dc040   esp: e855fdb8
ds: 007b   es: 007b   ss: 0068
Process lvremove (pid: 3034, threadinfo=e855e000 task=d2f4ea70)
Stack: <0>f6a92880 c02a6382 f545fac0 c02a85ad f88dc040 f6002d80 00000000 00000000 
       c02a22c6 00000008 f6002d80 f6a92c60 00000004 c02a4a40 c02a3fc3 c03b894c 
       f88aa000 c02a4a74 00000000 00000000 f88aa000 c02a418e 00000001 00000202 
Call Trace:
 [kcopyd_client_destroy+18/80] kcopyd_client_destroy+0x12/0x50
 [snapshot_dtr+173/240] snapshot_dtr+0xad/0xf0
 [dm_table_put+86/208] dm_table_put+0x56/0xd0
 [dev_remove+0/128] dev_remove+0x0/0x80
 [__hash_remove+99/128] __hash_remove+0x63/0x80
 [dev_remove+52/128] dev_remove+0x34/0x80
 [ctl_ioctl+430/688] ctl_ioctl+0x1ae/0x2b0
 [ctl_ioctl+0/688] ctl_ioctl+0x0/0x2b0
 [do_ioctl+105/112] do_ioctl+0x69/0x70
 [vfs_ioctl+92/640] vfs_ioctl+0x5c/0x280
 [sys_ioctl+61/112] sys_ioctl+0x3d/0x70
 [sysenter_past_esp+86/121] sysenter_past_esp+0x56/0x79
Code: 00 53 89 c3 8b 40 0c 39 43 10 75 1f 8b 43 08 e8 bd ff ff ff c7 43 08 00 00 00 00 c7 43 0c 00 00 00 00 c7 43 10 00 00 00 00 5b c3 <0f> 0b 92 00 68 a7 37 c0 eb d7 8d b6 00 00 00 00 8d bf 00 00 00 
 <1>Unable to handle kernel paging request at virtual address f8929fa8
 printing eip:
c02a9c90
*pde = 00000000
Oops: 0002 [#2]
CPU:    0
EIP:    0060:[persistent_commit+64/272]    Not tainted VLI
EFLAGS: 00010286   (2.6.16.2-exec-shield #1) 
EIP is at persistent_commit+0x40/0x110
eax: f8929fa0   ebx: f4c59840   ecx: 00000000   edx: 0000076b
esi: 000003fd   edi: 00000000   ebp: c02a8ec0   esp: ee497ef4
ds: 007b   es: 007b   ss: 0068
Process kcopyd (pid: 2511, threadinfo=ee496000 task=e65d5030)
Stack: <0>0000076b 00000000 000003fd 00000000 c1b57cf4 f545fac0 c1b57cf4 c02a8e70 
       c02a8eb2 c1b57cf4 c86cf1e0 00000000 c02a61fd 00000000 00000282 c86cf1e0 
       c03b8a08 c02a61b0 c02a6a38 00000000 c044b104 f4bab580 00000296 00000000 
Call Trace:
 [copy_callback+0/80] copy_callback+0x0/0x50
 [copy_callback+66/80] copy_callback+0x42/0x50
 [run_complete_job+77/112] run_complete_job+0x4d/0x70
 [run_complete_job+0/112] run_complete_job+0x0/0x70
 [process_jobs+24/192] process_jobs+0x18/0xc0
 [do_work+15/45] do_work+0xf/0x2d
 [run_workqueue+94/208] run_workqueue+0x5e/0xd0
 [do_work+0/45] do_work+0x0/0x2d
 [worker_thread+238/288] worker_thread+0xee/0x120
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [kthread+214/224] kthread+0xd6/0xe0
 [worker_thread+0/288] worker_thread+0x0/0x120
 [kthread+0/224] kthread+0x0/0xe0
 [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Code: 31 ff 89 34 24 8b 72 0c 89 7c 24 0c 89 74 24 08 8b 53 20 8d 42 01 89 43 20 89 d8 e8 ab f9 ff ff 85 c0 74 12 8b 14 24 8b 4c 24 04 <89> 70 08 89 78 0c 89 10 89 48 04 8b 43 28 8b 53 2c 8d 14 c2 40 




kernel BUG at drivers/md/kcopyd.c:146!
invalid opcode: 0000 [#1]
CPU:    0
EIP:    0060:[client_free_pages+42/64]    Not tainted VLI
EFLAGS: 00010283   (2.6.16.2-exec-shield #1) 
EIP is at client_free_pages+0x2a/0x40
eax: 00000100   ebx: f628c520   ecx: c18df0c0   edx: 00000000
esi: eeb1a660   edi: c044b13c   ebp: f88d8040   esp: eb26bdb8
ds: 007b   es: 007b   ss: 0068
Process lvremove (pid: 5735, threadinfo=eb26a000 task=f0522a70)
Stack: <0>f628c520 c02a6382 f65ca1c0 c02a85ad f88d8040 f1e1e3c0 00000000 00000000 
       c02a22c6 00000008 f1e1e3c0 f628c2a0 00000004 c02a4a40 c02a3fc3 c03b894c 
       f88aa000 c02a4a74 00000246 00000000 f88aa000 c02a418e 00000001 00000202 
Call Trace:
 [kcopyd_client_destroy+18/80] kcopyd_client_destroy+0x12/0x50
 [snapshot_dtr+173/240] snapshot_dtr+0xad/0xf0
 [dm_table_put+86/208] dm_table_put+0x56/0xd0
 [dev_remove+0/128] dev_remove+0x0/0x80
 [__hash_remove+99/128] __hash_remove+0x63/0x80
 [dev_remove+52/128] dev_remove+0x34/0x80
 [ctl_ioctl+430/688] ctl_ioctl+0x1ae/0x2b0
 [ctl_ioctl+0/688] ctl_ioctl+0x0/0x2b0
 [do_ioctl+105/112] do_ioctl+0x69/0x70
 [vfs_ioctl+92/640] vfs_ioctl+0x5c/0x280
 [sys_ioctl+61/112] sys_ioctl+0x3d/0x70
 [sysenter_past_esp+86/121] sysenter_past_esp+0x56/0x79
Code: 00 53 89 c3 8b 40 0c 39 43 10 75 1f 8b 43 08 e8 bd ff ff ff c7 43 08 00 00 00 00 c7 43 0c 00 00 00 00 c7 43 10 00 00 00 00 5b c3 <0f> 0b 92 00 68 a7 37 c0 eb d7 8d b6 00 00 00 00 8d bf 00 00 00 
 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000034
 printing eip:
c01551a5
*pde = 2b207001
*pte = 2e12c067
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[bio_add_page+21/80]    Not tainted VLI
EFLAGS: 00010286   (2.6.16.2-exec-shield #1) 
EIP is at bio_add_page+0x15/0x50
eax: 00000000   ebx: e84ef580   ecx: 00001000   edx: c15da5c0
esi: c15da5c0   edi: ef705f04   ebp: ee8ba20c   esp: ef705e74
ds: 007b   es: 007b   ss: 0068
Process kcopyd (pid: 5203, threadinfo=ef704000 task=f0f2a030)
Stack: <0>0000000c 00000010 00000000 00000010 e84ef580 c02a5c4b 00000000 ee8ba20c 
       00000001 00000001 00000000 00000000 c02a59f0 c02a5a10 00000000 ef4af780 
       00000000 00001000 c15da5c0 00000001 00000001 ee8ba20c c02a6950 c02a5d28 
Call Trace:
 [dispatch_io+299/400] dispatch_io+0x12b/0x190
 [list_get_page+0/32] list_get_page+0x0/0x20
 [list_next_page+0/16] list_next_page+0x0/0x10
 [complete_io+0/208] complete_io+0x0/0xd0
 [async_io+120/208] async_io+0x78/0xd0
 [dm_io_async+74/96] dm_io_async+0x4a/0x60
 [complete_io+0/208] complete_io+0x0/0xd0
 [list_get_page+0/32] list_get_page+0x0/0x20
 [list_next_page+0/16] list_next_page+0x0/0x10
 [run_io_job+0/144] run_io_job+0x0/0x90
 [run_io_job+124/144] run_io_job+0x7c/0x90
 [complete_io+0/208] complete_io+0x0/0xd0
 [process_jobs+24/192] process_jobs+0x18/0xc0
 [run_workqueue+94/208] run_workqueue+0x5e/0xd0
 [do_work+0/45] do_work+0x0/0x2d
 [worker_thread+238/288] worker_thread+0xee/0x120
 [default_wake_function+0/16] default_wake_function+0x0/0x10
 [kthread+214/224] kthread+0xd6/0xe0
 [worker_thread+0/288] worker_thread+0x0/0x120
 [kthread+0/224] kthread+0x0/0xe0
 [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Code: 14 89 1c 24 e8 fd fd ff ff 83 c4 0c 5b c3 90 8d b4 26 00 00 00 00 83 ec 14 89 5c 24 0c 89 74 24 10 89 c3 8b 40 08 89 d6 8b 40 50 <8b> 40 34 0f b7 90 38 01 00 00 89 0c 24 89 f1 89 54 24 08 8b 54 

-- 
Juergen Kreileder, Blackdown Java-Linux Team
http://blog.blackdown.de/
