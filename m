Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267330AbUHRQQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267330AbUHRQQd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 12:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266825AbUHRQQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 12:16:32 -0400
Received: from smtp06.ya.com ([62.151.11.163]:26005 "EHLO smtpauth.ya.com")
	by vger.kernel.org with ESMTP id S267330AbUHRQQY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 12:16:24 -0400
From: David Martinez Moreno <ender@debian.org>
To: linux-kernel@vger.kernel.org, nathans@sgi.com
Subject: Crashes and lockups in XFS filesystem (2.6.8-rc4).
Date: Wed, 18 Aug 2004 18:16:57 +0200
User-Agent: KMail/1.6.2
Cc: ender@debian.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200408181816.57940.ender@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello, I am getting persistent lockups that could be IMHO XFS-related. I 
created a fresh XFS filesystem in a SCSI disk, with xfsprogs version 2.6.18.

	Mounted /dev/sda1 under /mnt, after that, I have been copying lots of files 
from /dev/md0, then run a find blabla -exec rm \{\{ \; over /mnt and then 
voilà! the lockup:

ulises:/mnt/debian# df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/hda5             5,6G  1,8G  3,5G  34% /
tmpfs                 252M     0  252M   0% /dev/shm
/dev/hda1              19M   11M  6,9M  62% /boot
/dev/hda6             9,2G  1,8G  7,0G  21% /var
/dev/hda8             3,7G  2,3G  1,2G  67% /home
/dev/md0              224G  182G   42G  82% /mirror
/dev/sda1              69G   56G   13G  82% /mnt
ulises:/mnt/debian# find . \( -name *m68k.deb \) -exec rm \{\} \; &
[1] 13215
ulises:/mnt/debian# df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/hda5             5,6G  1,8G  3,5G  34% /
tmpfs                 252M     0  252M   0% /dev/shm
/dev/hda1              19M   11M  6,9M  62% /boot
/dev/hda6             9,2G  1,8G  7,0G  21% /var
/dev/hda8             3,7G  2,3G  1,2G  67% /home
Segmentation fault  <<<<<< when trying to display free space in /mnt
ulises:/mnt/debian# df -k
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hda5              5767428   1839536   3634920  34% /
tmpfs                   257484         0    257484   0% /dev/shm
/dev/hda1                18998     11044      6973  62% /boot
/dev/hda6              9612100   1874984   7248844  21% /var
/dev/hda8              3799944   2398188   1208728  67% /home
Segmentation fault
ulises:~# dmesg
[...]
XFS mounting filesystem sda1
Starting XFS recovery on filesystem: sda1 (dev: sda1)
Ending XFS recovery on filesystem: sda1 (dev: sda1)
Unable to handle kernel paging request at virtual address 020000b4
 printing eip:
c01fcd41
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01fcd41>]    Not tainted
EFLAGS: 00010206   (2.6.8-rc4)
EIP is at xfs_log_force+0x28/0x6c
eax: 02000000   ebx: 00000002   ecx: 00000000   edx: 00000000
esi: df234c40   edi: dacae2f4   ebp: 00000000   esp: dec44f64
ds: 007b   es: 007b   ss: 0068
Process xfssyncd (pid: 174, threadinfo=dec44000 task=dee7a8c0)
Stack: dffabc80 00000000 00000031 c0207bba 00000031 df234c40 c020f59d dacae2f4
       00000000 00000000 00000002 004bcd64 dec44fb0 00000000 00000002 00000000
       dec44000 df234c40 00000000 00000000 c020ec0f dacae2f4 00000031 00000000
Call Trace:
 [<c0207bba>] xfs_getsb+0x2f/0x45
 [<c020f59d>] xfs_syncsub+0x4e/0x303
 [<c020ec0f>] xfs_sync+0x29/0x2d
 [<c02211cc>] vfs_sync+0x34/0x38
 [<c022076f>] xfssyncd+0x7e/0xce
 [<c02206f1>] xfssyncd+0x0/0xce
 [<c0101fdd>] kernel_thread_helper+0x5/0xb
Code: f6 80 b4 00 00 00 08 75 34 89 ce 09 d6 75 18 89 5c 24 04 89
 <1>Unable to handle kernel NULL pointer dereference at virtual address 
00000000
 printing eip:
c020ebb4
*pde = 00000000
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[<c020ebb4>]    Not tainted
EFLAGS: 00010202   (2.6.8-rc4)
EIP is at xfs_statvfs+0xb6/0xe8
eax: 00000000   ebx: dacae314   ecx: dacae2f4   edx: 00000000
esi: dacae2f4   edi: 00000000   ebp: c0cf1ebc   esp: c0cf1e68
ds: 007b   es: 007b   ss: 0068
Process df (pid: 30308, threadinfo=c0cf1000 task=c64726c0)
Stack: dacae2f4 00000000 c0cf1f74 c0cf1efc c0cf1000 c0221194 dfced400 c0cf1ebc
       00000000 c0220b0a dfced400 c0cf1ebc 00000000 c013e3af c154ce00 c0cf1ebc
       c0cf1f14 c013e430 c154ce00 c0cf1ebc d24a1001 58465342 00000000 bfeb0fdc
Call Trace:
 [<c0221194>] vfs_statvfs+0x34/0x38
 [<c0220b0a>] linvfs_statfs+0x28/0x2e
 [<c013e3af>] vfs_statfs+0x4b/0x66
 [<c013e430>] vfs_statfs64+0x23/0xb2
 [<c013e5ea>] sys_statfs64+0x81/0xbf
 [<c024fac4>] tty_write+0x179/0x1bc
 [<c0254921>] write_chan+0x0/0x219
 [<c024f94b>] tty_write+0x0/0x1bc
 [<c01403e9>] vfs_write+0xc9/0x119
 [<c014050a>] sys_write+0x51/0x80
 [<c0103aa1>] sysenter_past_esp+0x52/0x71
Code: 8b 00 c7 45 24 ff 00 00 00 89 c2 0f b6 c8 25 00 ff 0f 00 c1
 <1>Unable to handle kernel NULL pointer dereference at virtual address 
00000000
 printing eip:
c020ebb4
*pde = 00000000
Oops: 0000 [#3]
CPU:    0
EIP:    0060:[<c020ebb4>]    Not tainted
EFLAGS: 00010202   (2.6.8-rc4)
EIP is at xfs_statvfs+0xb6/0xe8
eax: 00000000   ebx: dacae314   ecx: dacae2f4   edx: 00000000
esi: dacae2f4   edi: 00000000   ebp: c987cebc   esp: c987ce68
ds: 007b   es: 007b   ss: 0068
Process df (pid: 30728, threadinfo=c987c000 task=c156abd0)
Stack: dacae2f4 00000000 c987cf74 c987cefc c987c000 c0221194 dfced400 c987cebc
       00000000 c0220b0a dfced400 c987cebc 00000000 c013e3af c154ce00 c987cebc
       c987cf14 c013e430 c154ce00 c987cebc d24a1001 58465342 00000000 bfeb0fdc
Call Trace:
 [<c0221194>] vfs_statvfs+0x34/0x38
 [<c0220b0a>] linvfs_statfs+0x28/0x2e
 [<c013e3af>] vfs_statfs+0x4b/0x66
 [<c013e430>] vfs_statfs64+0x23/0xb2
 [<c013e5ea>] sys_statfs64+0x81/0xbf
 [<c024fac4>] tty_write+0x179/0x1bc
 [<c0111811>] recalc_task_prio+0x93/0x188
 [<c0105878>] math_state_restore+0x28/0x42
 [<c0103aa1>] sysenter_past_esp+0x52/0x71
Code: 8b 00 c7 45 24 ff 00 00 00 89 c2 0f b6 c8 25 00 ff 0f 00 c1
 <1>Unable to handle kernel NULL pointer dereference at virtual address 
00000000
 printing eip:
c020ebb4
*pde = 00000000
Oops: 0000 [#4]
CPU:    0
EIP:    0060:[<c020ebb4>]    Not tainted
EFLAGS: 00010202   (2.6.8-rc4)
EIP is at xfs_statvfs+0xb6/0xe8
eax: 00000000   ebx: dacae314   ecx: dacae2f4   edx: 00000000
esi: dacae2f4   edi: 00000000   ebp: d27c1ebc   esp: d27c1e68
ds: 007b   es: 007b   ss: 0068
Process df (pid: 7037, threadinfo=d27c1000 task=c64726c0)
Stack: dacae2f4 00000000 d27c1f74 d27c1efc d27c1000 c0221194 dfced400 d27c1ebc
       00000000 c0220b0a dfced400 d27c1ebc 00000000 c013e3af c154ce00 d27c1ebc
       d27c1f14 c013e430 c154ce00 d27c1ebc d75b8001 58465342 00000000 bfeb0fdc
Call Trace:
 [<c0221194>] vfs_statvfs+0x34/0x38
 [<c0220b0a>] linvfs_statfs+0x28/0x2e
 [<c013e3af>] vfs_statfs+0x4b/0x66
 [<c013e430>] vfs_statfs64+0x23/0xb2
 [<c013e5ea>] sys_statfs64+0x81/0xbf
 [<c024fac4>] tty_write+0x179/0x1bc
 [<c0254921>] write_chan+0x0/0x219
 [<c024f94b>] tty_write+0x0/0x1bc
 [<c01403e9>] vfs_write+0xc9/0x119
 [<c014050a>] sys_write+0x51/0x80
 [<c0103aa1>] sysenter_past_esp+0x52/0x71
Code: 8b 00 c7 45 24 ff 00 00 00 89 c2 0f b6 c8 25 00 ff 0f 00 c1
[...]

	XFS keeps segfaulting and dying in my machine. It is so strange...

General data:
x86 P-IV 2.5 GHz
512 MB RAM
The filesystem was onto a MAXTOR 70 GB SCSI disk, connected to Adaptec AIC79XX 
PCI-X SCSI card. The other filesystem containing files over XFS is a RAID0 
over two identical IDE disks.

	If you need further information, like .config or so, please do not hesitate 
to ask.

	Thanks in advance,


		Ender.
-- 
 Why is a cow? Mu. (Ommmmmmmmmm)
