Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265752AbSJTDdm>; Sat, 19 Oct 2002 23:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265753AbSJTDdm>; Sat, 19 Oct 2002 23:33:42 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:3712 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S265752AbSJTDdk>;
	Sat, 19 Oct 2002 23:33:40 -0400
Date: Sat, 19 Oct 2002 22:39:27 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: linux-kernel@vger.kernel.org
Subject: ide-scsi segfaults under 2.5.44
Message-ID: <Pine.LNX.4.44.0210192229310.891-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting an oops when attempting to remove ide-scsi modules:

Oct 19 22:10:30 dad kernel: Unable to handle kernel paging request at 
virtual address d909b03c
Oct 19 22:10:30 dad kernel:  printing eip:
Oct 19 22:10:30 dad kernel: c01d0665
Oct 19 22:10:30 dad kernel: *pde = 17d2d067
Oct 19 22:10:30 dad kernel: *pte = 00000000
Oct 19 22:10:30 dad kernel: Oops: 0000
Oct 19 22:10:30 dad kernel: sr_mod cdrom sg ymfpci ac97_codec soundcore 
parport_pc lp parport scsi_mod rtc
Oct 19 22:10:30 dad kernel: CPU:    0
Oct 19 22:10:30 dad kernel: EIP:    0060:[<c01d0665>]    Not tainted
Oct 19 22:10:30 dad kernel: EFLAGS: 00010202
Oct 19 22:10:30 dad kernel: EIP is at driver_detach+0x35/0x40
Oct 19 22:10:30 dad kernel: eax: d9097050   ebx: d905f784   ecx: d9099000   
edx: d909b03c
Oct 19 22:10:30 dad kernel: esi: d905f780   edi: d9097028   ebp: d5cf0000   
esp: d5d0bf5c
Oct 19 22:10:30 dad kernel: ds: 0068   es: 0068   ss: 0068
Oct 19 22:10:30 dad kernel: Process rmmod (pid: 953, threadinfo=d5d0a000 
task=d5cee080)
Oct 19 22:10:30 dad kernel: Stack: d905f784 d905f780 d9097028 c01d0857 
d9097028 d9097028 d905f780 00000000
Oct 19 22:10:30 dad kernel:        c01d0b78 d9097028 d9090000 00000000 
d90928ac d9097028 c0119e1e d9090000
Oct 19 22:10:30 dad kernel:        00000000 fffffff0 c01192f7 d9090000 
00000000 d5d0a000 bffffcb5 00000001
Oct 19 22:10:30 dad kernel: Call Trace:
Oct 19 22:10:30 dad kernel:  [<d905f784>] 
scsi_driverfs_bus_type_Rfc6baff9+0x4/0x80 [scsi_mod]
Oct 19 22:10:30 dad kernel:  [<d905f780>] 
scsi_driverfs_bus_type_Rfc6baff9+0x0/0x80 [scsi_mod]
Oct 19 22:10:30 dad kernel:  [<d9097028>] sg_template+0x48/0xa0 [sg]
Oct 19 22:10:30 dad kernel:  [<c01d0857>] bus_remove_driver+0x37/0x70
Oct 19 22:10:30 dad kernel:  [<d9097028>] sg_template+0x48/0xa0 [sg]
Oct 19 22:10:30 dad kernel:  [<d9097028>] sg_template+0x48/0xa0 [sg]
Oct 19 22:10:30 dad kernel:  [<d905f780>] 
scsi_driverfs_bus_type_Rfc6baff9+0x0/0x80 [scsi_mod]
Oct 19 22:10:30 dad kernel:  [<c01d0b78>] put_driver+0x28/0x50
Oct 19 22:10:30 dad kernel:  [<d9097028>] sg_template+0x48/0xa0 [sg]
Oct 19 22:10:30 dad kernel:  [<d90928ac>] exit_sg+0x4c/0x50 [sg]
Oct 19 22:10:30 dad kernel:  [<d9097028>] sg_template+0x48/0xa0 [sg]
Oct 19 22:10:30 dad kernel:  [<c0119e1e>] free_module+0x1e/0xb0
Oct 19 22:10:30 dad kernel:  [<c01192f7>] sys_delete_module+0xe7/0x1c0
Oct 19 22:10:30 dad kernel:  [<c0108adf>] syscall_call+0x7/0xb
Oct 19 22:10:30 dad kernel:
Oct 19 22:10:30 dad kernel: Code: 8b 32 75 d7 5b 5e 5f c3 8d 76 00 57 56 
53 8b 7c 24 10 ff b7


The problem does seem to be order dependent.  I haven't had a chance to 
fully explore this because I have to reboot each time to get the system 
into a sane state.  However, it appears that if I remove the sg module 
first, I get the above oops.  If I remove the ide-scsi module first I get 
the following: 

Oct 19 22:09:34 dad kernel: Badness in put_device at 
drivers/base/core.c:139
Oct 19 22:09:34 dad kernel: Call Trace:
Oct 19 22:09:34 dad kernel:  [<c01cfbfc>] put_device+0x9c/0xc0
Oct 19 22:09:34 dad kernel:  [<d90927e8>] sg_detach+0x1a8/0x1d0 [sg]
Oct 19 22:09:34 dad kernel:  [<d90970fc>] dev_attr_kdev+0x0/0x10 [sg]
Oct 19 22:09:34 dad kernel:  [<d909710c>] dev_attr_type+0x0/0x10 [sg]
Oct 19 22:09:34 dad kernel:  [<d90a8e55>] sr_detach+0x45/0x80 [sr_mod]
Oct 19 22:09:34 dad kernel:  [<d9096fe0>] sg_template+0x0/0xa0 [sg]
Oct 19 22:09:34 dad kernel:  [<d90541ba>] 
scsi_host_chk_and_release+0x13a/0x200 [scsi_mod]
Oct 19 22:09:34 dad kernel:  [<d905f810>] scsi_host_list+0x0/0x8 
[scsi_mod]
Oct 19 22:09:34 dad kernel:  [<d9054080>] 
scsi_host_chk_and_release+0x0/0x200 [scsi_mod]
Oct 19 22:09:34 dad kernel:  [<d90632c0>] idescsi_template+0x0/0x80 
[ide-scsi]
Oct 19 22:09:34 dad kernel:  [<d905401a>] scsi_tp_for_each_host+0x1a/0x30 
[scsi_mod]
Oct 19 22:09:34 dad kernel:  [<d90632c0>] idescsi_template+0x0/0x80 
[ide-scsi]
Oct 19 22:09:34 dad kernel:  [<d9054a07>] 
scsi_unregister_host_R08850fd9+0x17/0x70 [scsi_mod]
Oct 19 22:09:34 dad kernel:  [<d90632c0>] idescsi_template+0x0/0x80 
[ide-scsi]
Oct 19 22:09:34 dad kernel:  [<d9054080>] 
scsi_host_chk_and_release+0x0/0x200 [scsi_mod]
Oct 19 22:09:34 dad kernel:  [<d906251a>] exit_idescsi_module+0xa/0x20 
[ide-scsi]
Oct 19 22:09:34 dad kernel:  [<d90632c0>] idescsi_template+0x0/0x80 
[ide-scsi]
Oct 19 22:09:34 dad kernel:  [<c0119e1e>] free_module+0x1e/0xb0
Oct 19 22:09:34 dad kernel:  [<c01192f7>] sys_delete_module+0xe7/0x1c0
Oct 19 22:09:34 dad kernel:  [<c0108adf>] syscall_call+0x7/0xb
Oct 19 22:09:34 dad kernel:

In either case I get a segfault on shutdown, and a lockup.  I've not seen 
any filesystem corruption and the journal restores things in an orderly 
fashion on reboot.

