Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbUJYDbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbUJYDbo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 23:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbUJYDbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 23:31:44 -0400
Received: from gherkin.frus.com ([192.158.254.49]:63879 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S261665AbUJYDbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 23:31:09 -0400
Subject: 2.6.9 oops on PCMCIA SCSI card removal
To: linux-scsi@vger.kernel.org
Date: Sun, 24 Oct 2004 22:31:06 -0500 (CDT)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20041025033106.079AADBDD@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think this is a new record in terms of syslog output for a single
"oops" :-).  Something obviously changed between 2.6.6 and 2.6.9 for
the following sequence of events to suddenly become problematic.

(1) Insert New Media Bus Toaster card (sym53c500_cs) with attached
    MO drive (no media present).  Card is correctly detected, as is
    MO drive.

(2) Insert medium.  Mount /dev/sda1 (ext2) read-only.  Enjoy mp3 files
    contained therein :-).

(3) Unmount /dev/sda1.

(4) Eject medium (using button on drive, not software "eject").

(5) "cardctl eject 0"
    Command never returned following "oops".  Keyboard interrupt
    worked: got shell prompt.

(6) Saw message on screen to the effect that SCSI caches were being
    flushed, then...  BOOM!  Eyes melt, skin explodes, everybody dead.
    Actually, not quite *that* bad.  Machine locked up momentarily while
    massive "oops" log got written to disk.  Afterward, things seemed to
    be mostly normal except machine could not unmount "/" on shutdown.

Kernel is "stock" 2.6.9.  What follows is what got written to syslog.

Badness in kref_get at lib/kref.c:32
 [kref_get+42/48] kref_get+0x2a/0x30
 [kobject_get+18/32] kobject_get+0x12/0x20
 [get_device+19/32] get_device+0x13/0x20
 [scsi_request_fn+32/1024] scsi_request_fn+0x20/0x400
 [blk_run_queue+37/80] blk_run_queue+0x25/0x50
 [scsi_wait_req+132/144] scsi_wait_req+0x84/0x90
 [pg0+98863351/1069290496] sd_sync_cache+0x67/0xf0 [sd_mod]
 [pg0+98867608/1069290496] sd_remove+0x18/0x50 [sd_mod]
 [device_release_driver+75/80] device_release_driver+0x4b/0x50
 [bus_remove_device+73/144] bus_remove_device+0x49/0x90
 [device_del+82/128] device_del+0x52/0x80
 [scsi_remove_device+73/160] scsi_remove_device+0x49/0xa0
 [scsi_forget_host+70/144] scsi_forget_host+0x46/0x90
 [scsi_remove_host+11/80] scsi_remove_host+0xb/0x50
 [pg0+98846565/1069290496] SYM53C500_release+0x15/0xd0 [sym53c500_cs]
 [pg0+98848351/1069290496] SYM53C500_detach+0x5f/0x70 [sym53c500_cs]
 [pg0+98568587/1069290496] unbind_request+0xcb/0xe0 [ds]
 [pg0+98570223/1069290496] ds_ioctl+0x2ef/0x550 [ds]
 [sock_def_readable+115/128] sock_def_readable+0x73/0x80
 [unix_dgram_sendmsg+1102/1328] unix_dgram_sendmsg+0x44e/0x530
 [sock_sendmsg+211/256] sock_sendmsg+0xd3/0x100
 [handle_mm_fault+175/320] handle_mm_fault+0xaf/0x140
 [do_page_fault+916/1440] do_page_fault+0x394/0x5a0
 [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
 [sys_sendto+203/240] sys_sendto+0xcb/0xf0
 [sys_sendto+218/240] sys_sendto+0xda/0xf0
 [unmap_page_range+58/96] unmap_page_range+0x3a/0x60
 [scheduler_tick+390/1168] scheduler_tick+0x186/0x490
 [update_process_times+42/48] update_process_times+0x2a/0x30
 [copy_from_user+46/96] copy_from_user+0x2e/0x60
 [sys_rt_sigaction+110/160] sys_rt_sigaction+0x6e/0xa0
 [sys_ioctl+228/576] sys_ioctl+0xe4/0x240
 [syscall_call+7/11] syscall_call+0x7/0xb
Unable to handle kernel paging request at virtual address 00100104
 printing eip:
c023e1a1
*pde = 00000000
Oops: 0002 [#1]
PREEMPT 
Modules linked in: snd_pcm_oss snd_mixer_oss sd_mod sym53c500_cs snd_cs4232 snd_opl3_lib snd_hwdep snd_cs4231_lib snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore ds i82365 pcmcia_core
CPU:    0
EIP:    0060:[scsi_device_dev_release+49/272]    Not tainted VLI
EFLAGS: 00010002   (2.6.9) 
EIP is at scsi_device_dev_release+0x31/0x110
eax: 00100100   ebx: c27d4408   ecx: 00200200   edx: c27d4584
esi: c27d4400   edi: 00000282   ebp: c10ce2b4   esp: c4a09b44
ds: 007b   es: 007b   ss: 0068
Process cardmgr (pid: 896, threadinfo=c4a08000 task=c4b6caa0)
Stack: c27d45a8 c0378988 c03789a0 c10ce2d8 c020ce03 c27d4584 c01c8117 c27d45a8 
       c27d45c0 c01c8120 c10ce200 c4a08000 c01c8435 c27d45a8 c4a08000 c27d4400 
       c01c8146 c27d45c0 c01c8120 c023c093 c27d45a8 c27d4584 c4a08000 c1252028 
Call Trace:
 [device_release+67/80] device_release+0x43/0x50
 [kobject_cleanup+103/112] kobject_cleanup+0x67/0x70
 [kobject_release+0/16] kobject_release+0x0/0x10
 [kref_put+37/112] kref_put+0x25/0x70
 [kobject_put+22/32] kobject_put+0x16/0x20
 [kobject_release+0/16] kobject_release+0x0/0x10
 [scsi_request_fn+563/1024] scsi_request_fn+0x233/0x400
 [blk_run_queue+37/80] blk_run_queue+0x25/0x50
 [scsi_wait_req+132/144] scsi_wait_req+0x84/0x90
 [pg0+98863351/1069290496] sd_sync_cache+0x67/0xf0 [sd_mod]
 [pg0+98867608/1069290496] sd_remove+0x18/0x50 [sd_mod]
 [device_release_driver+75/80] device_release_driver+0x4b/0x50
 [bus_remove_device+73/144] bus_remove_device+0x49/0x90
 [device_del+82/128] device_del+0x52/0x80
 [scsi_remove_device+73/160] scsi_remove_device+0x49/0xa0
 [scsi_forget_host+70/144] scsi_forget_host+0x46/0x90
 [scsi_remove_host+11/80] scsi_remove_host+0xb/0x50
 [pg0+98846565/1069290496] SYM53C500_release+0x15/0xd0 [sym53c500_cs]
 [pg0+98848351/1069290496] SYM53C500_detach+0x5f/0x70 [sym53c500_cs]
 [pg0+98568587/1069290496] unbind_request+0xcb/0xe0 [ds]
 [pg0+98570223/1069290496] ds_ioctl+0x2ef/0x550 [ds]
 [sock_def_readable+115/128] sock_def_readable+0x73/0x80
 [unix_dgram_sendmsg+1102/1328] unix_dgram_sendmsg+0x44e/0x530
 [sock_sendmsg+211/256] sock_sendmsg+0xd3/0x100
 [handle_mm_fault+175/320] handle_mm_fault+0xaf/0x140
 [do_page_fault+916/1440] do_page_fault+0x394/0x5a0
 [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
 [sys_sendto+203/240] sys_sendto+0xcb/0xf0
 [sys_sendto+218/240] sys_sendto+0xda/0xf0
 [unmap_page_range+58/96] unmap_page_range+0x3a/0x60
 [scheduler_tick+390/1168] scheduler_tick+0x186/0x490
 [update_process_times+42/48] update_process_times+0x2a/0x30
 [copy_from_user+46/96] copy_from_user+0x2e/0x60
 [sys_rt_sigaction+110/160] sys_rt_sigaction+0x6e/0xa0
 [sys_ioctl+228/576] sys_ioctl+0xe4/0x240
 [syscall_call+7/11] syscall_call+0x7/0xb
Code: 24 14 8b 6a 20 8d b2 7c fe ff ff 9c 5f fa b8 00 e0 ff ff 21 e0 8b 48 14 41 89 48 14 8b 82 84 fe ff ff 8d 9a 84 fe ff ff 8b 4b 04 <89> 48 04 c7 43 04 00 02 20 00 89 01 8d 9a 8c fe ff ff 8b 82 8c 
 <6>note: cardmgr[896] exited with preempt_count 2
bad: scheduling while atomic!
 [schedule+1248/1264] schedule+0x4e0/0x4f0
 [unmap_vmas+265/496] unmap_vmas+0x109/0x1f0
 [unmap_vmas+470/496] unmap_vmas+0x1d6/0x1f0
 [exit_mmap+104/336] exit_mmap+0x68/0x150
 [mmput+100/160] mmput+0x64/0xa0
 [do_exit+339/1072] do_exit+0x153/0x430
 [die+358/368] die+0x166/0x170
 [do_page_fault+514/1440] do_page_fault+0x202/0x5a0
 [do_page_fault+548/1440] do_page_fault+0x224/0x5a0
 [try_to_wake_up+149/176] try_to_wake_up+0x95/0xb0
 [recalc_task_prio+166/464] recalc_task_prio+0xa6/0x1d0
 [activate_task+81/112] activate_task+0x51/0x70
 [try_to_wake_up+62/176] try_to_wake_up+0x3e/0xb0
 [try_to_wake_up+149/176] try_to_wake_up+0x95/0xb0
 [process_timeout+0/16] process_timeout+0x0/0x10
 [wake_up_process+13/32] wake_up_process+0xd/0x20
 [do_page_fault+0/1440] do_page_fault+0x0/0x5a0
 [error_code+45/64] error_code+0x2d/0x40
 [scsi_device_dev_release+49/272] scsi_device_dev_release+0x31/0x110
 [device_release+67/80] device_release+0x43/0x50
 [kobject_cleanup+103/112] kobject_cleanup+0x67/0x70
 [kobject_release+0/16] kobject_release+0x0/0x10
 [kref_put+37/112] kref_put+0x25/0x70
 [kobject_put+22/32] kobject_put+0x16/0x20
 [kobject_release+0/16] kobject_release+0x0/0x10
 [scsi_request_fn+563/1024] scsi_request_fn+0x233/0x400
 [blk_run_queue+37/80] blk_run_queue+0x25/0x50
 [scsi_wait_req+132/144] scsi_wait_req+0x84/0x90
 [pg0+98863351/1069290496] sd_sync_cache+0x67/0xf0 [sd_mod]
 [pg0+98867608/1069290496] sd_remove+0x18/0x50 [sd_mod]
 [device_release_driver+75/80] device_release_driver+0x4b/0x50
 [bus_remove_device+73/144] bus_remove_device+0x49/0x90
 [device_del+82/128] device_del+0x52/0x80
 [scsi_remove_device+73/160] scsi_remove_device+0x49/0xa0
 [scsi_forget_host+70/144] scsi_forget_host+0x46/0x90
 [scsi_remove_host+11/80] scsi_remove_host+0xb/0x50
 [pg0+98846565/1069290496] SYM53C500_release+0x15/0xd0 [sym53c500_cs]
 [pg0+98848351/1069290496] SYM53C500_detach+0x5f/0x70 [sym53c500_cs]
 [pg0+98568587/1069290496] unbind_request+0xcb/0xe0 [ds]
 [pg0+98570223/1069290496] ds_ioctl+0x2ef/0x550 [ds]
 [sock_def_readable+115/128] sock_def_readable+0x73/0x80
 [unix_dgram_sendmsg+1102/1328] unix_dgram_sendmsg+0x44e/0x530
 [sock_sendmsg+211/256] sock_sendmsg+0xd3/0x100
 [handle_mm_fault+175/320] handle_mm_fault+0xaf/0x140
 [do_page_fault+916/1440] do_page_fault+0x394/0x5a0
 [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
 [sys_sendto+203/240] sys_sendto+0xcb/0xf0
 [sys_sendto+218/240] sys_sendto+0xda/0xf0
 [unmap_page_range+58/96] unmap_page_range+0x3a/0x60
 [scheduler_tick+390/1168] scheduler_tick+0x186/0x490
 [update_process_times+42/48] update_process_times+0x2a/0x30
 [copy_from_user+46/96] copy_from_user+0x2e/0x60
 [sys_rt_sigaction+110/160] sys_rt_sigaction+0x6e/0xa0
 [sys_ioctl+228/576] sys_ioctl+0xe4/0x240
 [syscall_call+7/11] syscall_call+0x7/0xb
bad: scheduling while atomic!
 [schedule+1248/1264] schedule+0x4e0/0x4f0
 [__generic_unplug_device+23/64] __generic_unplug_device+0x17/0x40
 [generic_unplug_device+26/64] generic_unplug_device+0x1a/0x40
 [io_schedule+14/32] io_schedule+0xe/0x20
 [__wait_on_buffer+171/176] __wait_on_buffer+0xab/0xb0
 [bh_wake_function+0/48] bh_wake_function+0x0/0x30
 [bh_wake_function+0/48] bh_wake_function+0x0/0x30
 [__bread_slow+73/112] __bread_slow+0x49/0x70
 [__bread+40/48] __bread+0x28/0x30
 [ext2_get_inode+173/256] ext2_get_inode+0xad/0x100
 [ext2_update_inode+65/864] ext2_update_inode+0x41/0x360
 [sk_free+99/224] sk_free+0x63/0xe0
 [ext2_delete_inode+0/112] ext2_delete_inode+0x0/0x70
 [ext2_delete_inode+49/112] ext2_delete_inode+0x31/0x70
 [generic_delete_inode+120/288] generic_delete_inode+0x78/0x120
 [iput+88/112] iput+0x58/0x70
 [dput+267/576] dput+0x10b/0x240
 [__fput+186/288] __fput+0xba/0x120
 [filp_close+67/112] filp_close+0x43/0x70
 [put_files_struct+79/176] put_files_struct+0x4f/0xb0
 [do_exit+406/1072] do_exit+0x196/0x430
 [die+358/368] die+0x166/0x170
 [do_page_fault+514/1440] do_page_fault+0x202/0x5a0
 [do_page_fault+548/1440] do_page_fault+0x224/0x5a0
 [try_to_wake_up+149/176] try_to_wake_up+0x95/0xb0
 [recalc_task_prio+166/464] recalc_task_prio+0xa6/0x1d0
 [activate_task+81/112] activate_task+0x51/0x70
 [try_to_wake_up+62/176] try_to_wake_up+0x3e/0xb0
 [try_to_wake_up+149/176] try_to_wake_up+0x95/0xb0
 [process_timeout+0/16] process_timeout+0x0/0x10
 [wake_up_process+13/32] wake_up_process+0xd/0x20
 [do_page_fault+0/1440] do_page_fault+0x0/0x5a0
 [error_code+45/64] error_code+0x2d/0x40
 [scsi_device_dev_release+49/272] scsi_device_dev_release+0x31/0x110
 [device_release+67/80] device_release+0x43/0x50
 [kobject_cleanup+103/112] kobject_cleanup+0x67/0x70
 [kobject_release+0/16] kobject_release+0x0/0x10
 [kref_put+37/112] kref_put+0x25/0x70
 [kobject_put+22/32] kobject_put+0x16/0x20
 [kobject_release+0/16] kobject_release+0x0/0x10
 [scsi_request_fn+563/1024] scsi_request_fn+0x233/0x400
 [blk_run_queue+37/80] blk_run_queue+0x25/0x50
 [scsi_wait_req+132/144] scsi_wait_req+0x84/0x90
 [pg0+98863351/1069290496] sd_sync_cache+0x67/0xf0 [sd_mod]
 [pg0+98867608/1069290496] sd_remove+0x18/0x50 [sd_mod]
 [device_release_driver+75/80] device_release_driver+0x4b/0x50
 [bus_remove_device+73/144] bus_remove_device+0x49/0x90
 [device_del+82/128] device_del+0x52/0x80
 [scsi_remove_device+73/160] scsi_remove_device+0x49/0xa0
 [scsi_forget_host+70/144] scsi_forget_host+0x46/0x90
 [scsi_remove_host+11/80] scsi_remove_host+0xb/0x50
 [pg0+98846565/1069290496] SYM53C500_release+0x15/0xd0 [sym53c500_cs]
 [pg0+98848351/1069290496] SYM53C500_detach+0x5f/0x70 [sym53c500_cs]
 [pg0+98568587/1069290496] unbind_request+0xcb/0xe0 [ds]
 [pg0+98570223/1069290496] ds_ioctl+0x2ef/0x550 [ds]
 [sock_def_readable+115/128] sock_def_readable+0x73/0x80
 [unix_dgram_sendmsg+1102/1328] unix_dgram_sendmsg+0x44e/0x530
 [sock_sendmsg+211/256] sock_sendmsg+0xd3/0x100
 [handle_mm_fault+175/320] handle_mm_fault+0xaf/0x140
 [do_page_fault+916/1440] do_page_fault+0x394/0x5a0
 [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
 [sys_sendto+203/240] sys_sendto+0xcb/0xf0
 [sys_sendto+218/240] sys_sendto+0xda/0xf0
 [unmap_page_range+58/96] unmap_page_range+0x3a/0x60
 [scheduler_tick+390/1168] scheduler_tick+0x186/0x490
 [update_process_times+42/48] update_process_times+0x2a/0x30
 [copy_from_user+46/96] copy_from_user+0x2e/0x60
 [sys_rt_sigaction+110/160] sys_rt_sigaction+0x6e/0xa0
 [sys_ioctl+228/576] sys_ioctl+0xe4/0x240
 [syscall_call+7/11] syscall_call+0x7/0xb

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
