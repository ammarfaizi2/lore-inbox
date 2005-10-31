Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbVJaHUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbVJaHUW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 02:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbVJaHUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 02:20:22 -0500
Received: from [152.101.81.89] ([152.101.81.89]:36799 "EHLO southa.com")
	by vger.kernel.org with ESMTP id S932303AbVJaHUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 02:20:22 -0500
Message-ID: <006301c5ddee$6ac55780$9d02a8c0@southa.com>
From: "Kyle Wong" <kylewong@southa.com>
To: <linux-kernel@vger.kernel.org>
Subject: ext3 related lock up, cannot umount filesystem or shutdown server.
Date: Mon, 31 Oct 2005 15:40:51 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Last night there's some strange problem with one of my servers, I can still
telnet into it, execute processes, etc, but there's some running unkillable
"D" state processes running at my "backup" (/dev/md3) volumn, "shutdown -r
now", gives no response.

[root@rsync ~]# ps -aux |grep "rsync"
Warning: bad syntax, perhaps a bogus '-'? See
/usr/share/doc/procps-3.2.5/FAQ
nobody   10354  0.0  0.1   4928  1548 ?        Ds   03:24   0:00
rsync --daemon
nobody   10355  0.0  0.0      0     0 ?        Z    03:25   0:00 [rsync]
<defunct>
nobody   10820  0.0  0.1   4532  1028 ?        D    04:03   0:00
rsync --daemon
nobody   10827  0.0  0.1   4536  1036 ?        D    05:16   0:00
rsync --daemon
nobody   11256  0.0  0.1   5444  1944 ?        Ds   14:50   0:00
rsync --daemon

[root@rsync ~]# mount
/dev/md1 on / type ext3 (rw,noatime)
/dev/proc on /proc type proc (rw)
/dev/sys on /sys type sysfs (rw)
/dev/devpts on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/md0 on /boot type ext3 (rw)
/dev/shm on /dev/shm type tmpfs (rw)
/dev/md2 on /testraid type ext3 (rw,noatime)
/dev/md3 on /backup type ext3 (rw,noatime)
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)

[root@rsync ~]# more /proc/mdstat
Personalities : [raid1] [raid5]
md1 : active raid1 hdc2[1] hda2[0]
      10241344 blocks [2/2] [UU]

md2 : active raid5 sdf1[5] sde1[4] sdd1[3] sdc1[2] sdb1[1] sda1[0]
      54299200 blocks level 5, 64k chunk, algorithm 2 [6/6] [UUUUUU]

md3 : active raid5 sdf2[7] sde2[6] sdd2[5] sdc2[4] sdb2[3] sda2[2] hdc4[1]
hda4[0]
      1633352000 blocks level 5, 64k chunk, algorithm 2 [8/8] [UUUUUUUU]

md0 : active raid1 hdc1[1] hda1[0]
      104320 blocks [2/2] [UU]

unused devices: <none>

Also, it got the following at my /var/log/messages:

Oct 31 03:24:55 rsync kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000040
Oct 31 03:24:55 rsync kernel:  printing eip:
Oct 31 03:24:55 rsync kernel: c0153018
Oct 31 03:24:55 rsync kernel: *pde = 00000000
Oct 31 03:24:55 rsync kernel: Oops: 0000 [#1]
Oct 31 03:24:55 rsync kernel: Modules linked in: md5 ipv6 dm_mod video
button battery ac shpchp i2c_viapro i2c_core via_rhine mii ext3 jbd raid5
xor raid1 sata_sil sata_via libata sd_mod scsi_mod
Oct 31 03:24:55 rsync kernel: CPU:    0
Oct 31 03:24:55 rsync kernel: EIP:    0060:[<c0153018>]    Not tainted VLI
Oct 31 03:24:55 rsync kernel: EFLAGS: 00010002   (2.6.12-1.1456_FC4)
Oct 31 03:24:55 rsync kernel: EIP is at find_get_page+0xf/0x24
Oct 31 03:24:55 rsync kernel: eax: 00000040   ebx: 03afcdb6   ecx: 00000040
edx: fffffffa
Oct 31 03:24:55 rsync kernel: esi: 03afcdb6   edi: 00000000   ebp: f6a5babc
esp: e5df8cb8
Oct 31 03:24:55 rsync kernel: ds: 007b   es: 007b   ss: 0068
Oct 31 03:24:55 rsync kernel: Process rsync (pid: 10353, threadinfo=e5df8000
task=c19a0aa0)
Oct 31 03:24:55 rsync kernel: Stack: c017ddf7 d9069f50 0000000c 0000000f
00000001 c12452e0 00000000 00000000
Oct 31 03:24:55 rsync kernel:        e926c2b8 f6a5b9d4 00000246 e19c03d0
f8916ac2 03afcdb6 00000000 f6a5b940
Oct 31 03:24:55 rsync kernel:        00000000 c01801e2 00000000 00000000
00001000 c12452e0 c01807d8 d9069f50
Oct 31 03:24:55 rsync kernel: Call Trace:
Oct 31 03:24:55 rsync kernel:  [<c017ddf7>] __find_get_block_slow+0x38/0x25c
Oct 31 03:24:55 rsync kernel:  [<f8916ac2>] ext3_get_block+0x52/0x90 [ext3]
Oct 31 03:24:55 rsync kernel:  [<c01801e2>]
unmap_underlying_metadata+0x2d/0x74
Oct 31 03:24:55 rsync kernel:  [<c01807d8>]
__block_prepare_write+0x2ba/0x439
Oct 31 03:24:55 rsync kernel:  [<c01810c2>] block_prepare_write+0x22/0x30
Oct 31 03:24:55 rsync kernel:  [<f8916a70>] ext3_get_block+0x0/0x90 [ext3]
Oct 31 03:24:55 rsync kernel:  [<f89170bb>] ext3_prepare_write+0x121/0x135
[ext3]
Oct 31 03:24:55 rsync kernel:  [<f8916a70>] ext3_get_block+0x0/0x90 [ext3]
Oct 31 03:24:55 rsync kernel:  [<f8916f9a>] ext3_prepare_write+0x0/0x135
[ext3]
Oct 31 03:24:55 rsync kernel:  [<c0154be4>]
generic_file_buffered_write+0x292/0x5f9
Oct 31 03:24:55 rsync kernel:  [<c01551ca>]
__generic_file_aio_write_nolock+0x27f/0x493
Oct 31 03:24:55 rsync kernel:  [<c02fe4cd>] sock_aio_read+0xf9/0x12b
Oct 31 03:24:55 rsync kernel:  [<c0155627>] generic_file_aio_write+0x71/0xde
Oct 31 03:24:55 rsync kernel:  [<f8914736>] ext3_file_write+0x24/0x9a [ext3]
Oct 31 03:24:55 rsync kernel:  [<c017c068>] do_sync_write+0x9e/0xec
Oct 31 03:24:55 rsync kernel:  [<c0140512>]
autoremove_wake_function+0x0/0x37
Oct 31 03:24:56 rsync kernel:  [<c017bfca>] do_sync_write+0x0/0xec
Oct 31 03:24:56 rsync kernel:  [<c017c154>] vfs_write+0x9e/0x110
Oct 31 03:24:56 rsync kernel:  [<c017c271>] sys_write+0x41/0x6a
Oct 31 03:24:56 rsync kernel:  [<c0103a61>] syscall_call+0x7/0xb
Oct 31 03:24:56 rsync kernel: Code: ff ff c7 04 24 02 00 00 00 b9 a3 29 15
c0 89 da e8 6c 19 22 00 83 c4 20 5b 5e 5f c3 fa 83 c0 04 e8 22 e0 0b 00 89
c1 85 c0 74 0c <8b> 00 89 ca 66 85 c0 78 07 ff 42 04 fb 89 c8 c3 8b 51 0c eb
f4

Is it ext3 related bug, or hardware problem?
Is there anyway I can remote reboot the machine?

Please CC any reply to me as I'm subscribed, thanks.

