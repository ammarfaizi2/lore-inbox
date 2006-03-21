Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751806AbWCUPyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbWCUPyO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 10:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030440AbWCUPyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 10:54:10 -0500
Received: from bay109-f35.bay109.hotmail.com ([64.4.19.45]:36121 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1030436AbWCUPyI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 10:54:08 -0500
Message-ID: <BAY109-F3575263F80EBD0AA0F7452D6D80@phx.gbl>
X-Originating-IP: [61.247.247.124]
X-Originating-Email: [agovinda04@hotmail.com]
From: "govind raj" <agovinda04@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: IOWAIT problem
Date: Tue, 21 Mar 2006 21:24:00 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 21 Mar 2006 15:54:04.0343 (UTC) FILETIME=[ADD50C70:01C64CFF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We are facing a problem in the Linux kernel going into a near-100% IO-WAIT 
condition and the machine freezes.

We have already googled and gone through the various IOWAIT issues that have 
been reported specifically on Linux 2.6.x kernel but
could not find any resolutions to those email threads. We would appreciate 
if the experts can shed some light on this behaviour as we
are currently struggling with this situation for the last 4 weeks now.

Here is our environment:

Hardware: Intel 915 / 4 SATA ports on the motherboard / 1GB RAM
Hard disks: Seagate Barracuda and Western Digital
Hard disks capacity: 250 GB (Seagate) and 250 GB (Western Digital)

Kernel: Linux kernel 2.6.12.6
Other software: EVMS 2.5.4 (with 2.6 patch of the device mapper installed on 
the server)
Device driver: libata / ata_piix and MD (Multiple disk)

Here is what we are observing:

a) When we create a RAID set using just a single disk, everything works 
fine. We are able to mount the disk (or) create EVMS volumes
(or) read/write heavy quantities of data to this RAID set. This is 
absolutely No problem at all

b) When we create a RAID set (RAID0 or RAID1 or RAID5) spanning MORE than 
one disk, then we observe that very frequently, the 'top'
shows that the CPU IO-WAIT is reaching 100% and the whole machine just seems 
to freeze eternally.... untill we press the RESET button..

Some of the various activities that seem to trigger this are: Creating 
volumes or snapshots over this raid set spanning more than 1 disk,
mounting / unmounting the volumes on top of this RAID set, reading / writing 
the data. There is _NO_ particular sequence that is alone
caused this problem over the last 4 weeks.

Debug information:

When we do a top of the system, the following is the output:

===================================================
15:51:47  up 58 min,  7 users,  load average: 0.99, 0.62, 0.25
47 processes: 45 sleeping, 2 running, 0 zombie, 0 stopped
CPU states:  cpu    user    nice  system    irq  softirq  iowait    idle
           total    0.0%    0.0%    0.0%   0.0%     0.0%  100.0%    0.0%
Mem:   507000k av,  141180k used,  365820k free,       0k shrd,   28216k
buff
        51736k active,              70212k inactive
Swap:       0k av,       0k used,       0k free                   78204k
cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU
COMMAND
12881 root      16   0  2152  992   780 R     0.1  0.1   0:00   0 top
    1 root      16   0   724  300   256 S     0.0  0.0   0:00   0 init
    2 root      RT   0     0    0     0 SW    0.0  0.0   0:00   0
migration/0
    3 root      34  19     0    0     0 SWN   0.0  0.0   0:00   0
ksoftirqd/0
    4 root      10  -5     0    0     0 SW<   0.0  0.0   0:00   0
events/0
    5 root      11  -5     0    0     0 SW<   0.0  0.0   0:00   0
khelper

===================================================

When we do a Ctrl + Scroll lock key sequence during the time the machine is 
in an IOWAIT state of 100%, the output is as follows:

===================================================

[<c011b9e8>] do_wait+0x27c/0x30f
[<c0114e72>] default_wake_function+0x0/0x12
[<c01181e8>] do_fork+0xff/0x165
[<c0114e72>] default_wake_function+0x0/0x12
[<c011bb13>] sys_wait4+0x28/0x2c
[<c0102d91>] syscall_call+0x7/0xb
umount        D DCA52E80     0  6581   6580                     (NOTLB)
d79c7e6c 00000086 e0192626 dca52e80 db7d7280 db128a40 e0190909 db128a40
       00000000 c13f4e80 c13f4520 00000000 00005bd4 7200474b 00000072 
db128a40
       d79faa40 d79fab64 00000000 00000000 c13f4520 00000000 c13ef6c0
d79c7e78
Call Trace:
[<e0192626>] dm_table_unplug_all+0x27/0x31 [dm_mod]
[<e0190909>] dm_unplug_all+0x1d/0x2a [dm_mod]
[<c02d4ad5>] io_schedule+0x26/0x30
[<c014ed8c>] sync_buffer+0x0/0x3b
[<c014edc4>] sync_buffer+0x38/0x3b
[<c02d4c73>] __wait_on_bit+0x2b/0x51
[<c014ed8c>] sync_buffer+0x0/0x3b
[<c02d4d0a>] out_of_line_wait_on_bit+0x71/0x79
[<c01297d0>] wake_bit_function+0x0/0x34
[<c0151aaa>] submit_bh+0x128/0x14e
[<c01297d0>] wake_bit_function+0x0/0x34
[<c0151bb7>] sync_dirty_buffer+0x77/0xa6
[<c018400b>] ext2_sync_super+0x42/0x4a
[<c0183244>] ext2_put_super+0x26/0x9f
[<c015331e>] generic_shutdown_super+0x75/0xf9
[<c0153c20>] kill_block_super+0x1a/0x2e
[<c0153211>] deactivate_super+0x46/0x59
[<c01656b8>] sys_umount+0x6b/0x73
[<c014493b>] do_munmap+0xdf/0xeb
[<c0144979>] sys_munmap+0x32/0x4d
[<c01121de>] do_page_fault+0x0/0x4cc
[<c0102d37>] sysenter_past_esp+0x54/0x75

==========================================

Another situtation when the IO-WAIT went to 100%, the output of the 
Ctrl+Lock key sequence was as follows:

=========================================
evms          D DA4D8F1C     0 12863  12861 12874               (NOTLB)
d6d4bd5c 00000086 c14c5480 da4d8f1c e0190909 c14c5480 da32ee40 e0192626
       c14c5480 da4d8e80 c13f4520 00000000 0001aa83 759d11c3 000002f2 
c0332c00
       d6640530 d6640654 e0190909 00000000 c13f4520 00000000 c13f0340
d6d4bd68
Call Trace:
[<e0190909>] dm_unplug_all+0x1d/0x2a [dm_mod]
[<e0192626>] dm_table_unplug_all+0x27/0x31 [dm_mod]
[<e0190909>] dm_unplug_all+0x1d/0x2a [dm_mod]
[<c02d4ad5>] io_schedule+0x26/0x30
[<c01353ff>] sync_page+0x0/0x49
[<c0135445>] sync_page+0x46/0x49
[<c02d4c73>] __wait_on_bit+0x2b/0x51
[<c0135996>] wait_on_page_bit+0x71/0x7a
[<c01297d0>] wake_bit_function+0x0/0x34
[<c01297d0>] wake_bit_function+0x0/0x34
[<c01355c0>] wait_on_page_writeback_range+0xac/0xeb
[<c0135568>] wait_on_page_writeback_range+0x54/0xeb
[<c01357ad>] filemap_fdatawait+0x4b/0x52
[<c014ef30>] sync_blockdev+0x2a/0x36
[<c017539a>] quota_sync_sb+0x33/0xe9
[<c014f028>] freeze_bdev+0x45/0xc6
[<e019102d>] __lock_fs+0x71/0xa4 [dm_mod]
[<e01910f0>] dm_suspend+0x59/0x1bc [dm_mod]
[<c0114e72>] default_wake_function+0x0/0x12
[<c0114e72>] default_wake_function+0x0/0x12
[<e019319e>] __get_name_cell+0xe/0x60 [dm_mod]
[<e0193da8>] do_suspend+0xff/0x125 [dm_mod]
[<e0194dd0>] ctl_ioctl+0xdd/0x128 [dm_mod]
[<e0193f44>] dev_suspend+0x0/0x18 [dm_mod]
[<c015d28d>] do_ioctl+0x55/0x66
[<c015d539>] vfs_ioctl+0x184/0x192
[<c015d572>] sys_ioctl+0x2b/0x45
[<c0102d91>] syscall_call+0x7/0xb

evms          S 00000000     0 12874  12863 12875               (NOTLB)
d4adbf1c 00000086 00000001 00000000 d6640a40 00000010 c0339000 00000000
       000000d0 d4adbf98 c13f4520 00000000 00000234 f1f43abc 000002f8 
c0332c00
       d6640a40 d6640b64 002d1dc2 00000000 002d1dc2 d4adbf24 d4adbf98 
d5c36e20 Call Trace:
[<c02d4bb2>] schedule_timeout+0x91/0xae
[<c01203b1>] process_timeout+0x0/0x9
[<c015e2d1>] do_poll+0x50/0xae
[<c015e311>] do_poll+0x90/0xae
[<c015e468>] sys_poll+0x139/0x1d1
[<c015da3f>] __pollwait+0x0/0x9b
[<c0102d91>] syscall_call+0x7/0xb
evms          S D5F05F6C     0 12875  12874                     (NOTLB)
d5f05f9c 00000086 bf5ff664 d5f05f6c 00000014 d6640530 bf5ff6f4 d6640530
       00000000 c13f4e80 c13f4520 00000000 000034bf 70cc77ad 000002f2 
d6640530
       d4466020 d4466144 00000000 bf5ffbe0 d5f04000 bf5ffbe0 00000000 
d5f04000 Call Trace:
[<c01020c2>] sys_rt_sigsuspend+0xb4/0xcf [<c0102d91>] syscall_call+0x7/0xb
===============================


When we do a iostat, the following is the output:

===================================================
# iostat -x /dev/sdb 1
Linux 2.6.12.6 ((none))         04/11/23

avg-cpu:  %user   %nice    %sys   %idle
           0.43    0.00    0.63   98.95

Device:    rrqm/s wrqm/s   r/s   w/s  rsec/s  wsec/s    rkB/s    wkB/s
avgrq-sz avgqu-sz   await  svctm  %util

avg-cpu:  %user   %nice    %sys   %idle
            nan     nan     nan     nan

Device:    rrqm/s wrqm/s   r/s   w/s  rsec/s  wsec/s    rkB/s    wkB/s
avgrq-sz avgqu-sz   await  svctm  %util

avg-cpu:  %user   %nice    %sys   %idle
            nan     nan     nan     nan

Device:    rrqm/s wrqm/s   r/s   w/s  rsec/s  wsec/s    rkB/s    wkB/s
avgrq-sz avgqu-sz   await  svctm  %util

avg-cpu:  %user   %nice    %sys   %idle
            nan     nan     nan     nan

Device:    rrqm/s wrqm/s   r/s   w/s  rsec/s  wsec/s    rkB/s    wkB/s
avgrq-sz avgqu-sz   await  svctm  %util

====================================================


Thanks in advance,
A.govind


