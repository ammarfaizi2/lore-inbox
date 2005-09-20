Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932667AbVITQpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932667AbVITQpG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 12:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932664AbVITQpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 12:45:06 -0400
Received: from oban.houtzager.net ([217.77.130.26]:51942 "EHLO
	oban.houtzager.net") by vger.kernel.org with ESMTP id S932667AbVITQpD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 12:45:03 -0400
Subject: OOPS in raid10.c:1448 in vanilla 2.6.13.2
From: Guus Houtzager <guus@luna.nl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Luna.nl BV
Date: Tue, 20 Sep 2005 18:44:30 +0200
Message-Id: <1127234670.2893.103.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On a new server I've been playing with software raid10.
It's a Supermicro 5014C-MT which has a P8SCT motherboard.
It has a 4 port SATA backplane connected to the ICH6R southbridge.
>From Jeff Garzik's webpages I know that libata does not and will not
support hot swap on ICH6R, so if I trigger an OOPS while doing that,
it's my problem. However, if I reset the machine after the oops, it
oopses again when trying to resync the raiddevice with all disks present
which I didn't expect and find very odd: I expected maybe an
errormessage and at best a succesfull resync. 

This is what I did (Debian Sarge install):
# mdadm --create /dev/md1 --level=10 --raid-devices=4 /dev/sd[abcd]2
(mdadm is version 1.9.0-4, new enough to support raid10)
And let it sync.
# mke2fs -j /dev/md1
# mount /dev/md1 /mnt
Then removed sdb from the server. It took a while, but sdb2 got marked
faulty. Gave messages like this in syslog (as I expected):
Sep 20 19:08:23 lorentz kernel: ata2: error occurred, port reset
Sep 20 19:08:23 lorentz kernel: ata2: status=0x01 { Error }
Sep 20 19:08:23 lorentz kernel: ata2: called with no error (01)!
Sep 20 19:08:23 lorentz kernel: SCSI error : <1 0 0 0> return code =
0x8000002
Sep 20 19:08:23 lorentz kernel: sdb: Current: sense key=0x3
Sep 20 19:08:23 lorentz kernel:     ASC=0xc ASCQ=0x2
Sep 20 19:08:23 lorentz kernel: end_request: I/O error, dev sdb, sector
3919610
Sep 20 19:08:23 lorentz kernel: raid10: Disk failure on sdb2, disabling
device.
Sep 20 19:08:23 lorentz kernel: ^IOperation continuing on 3 devices

Then removed sdc from the server. Also took a while, but sdc2 also got
marked faulty.
Filesystem on /mnt stays usable during all this (slight hickup when a
disk is removed, but keeps going)
Then reinserted sdc. To get it resynced I did:
# mdadm /dev/md1 -r /dev/sdc2
# mdadm /dev/md1 -a /dev/sdc2
And it happily resynced and made sdc2 healthy again.
Then removed sdd and sdd2 got marked faulty. Filesystem kept working.
So at that point I was happy. At that point I just wanted to readd both
disks and get on with installing the server. So I reinserted both disks
m, waited several minutes and did:
# mdadm /dev/md1 -r /dev/sdb2
# mdadm /dev/md1 -r /dev/sdd2
# mdadm /dev/md1 -a /dev/sdb2
# mdadm /dev/md1 -a /dev/sdd2
And then it OOPS-ed.
Sep 20 19:25:01 lorentz kernel: md: unbind<sdb2>
Sep 20 19:25:01 lorentz kernel: md: export_rdev(sdb2)
Sep 20 19:25:06 lorentz kernel: md: unbind<sdd2>
Sep 20 19:25:06 lorentz kernel: md: export_rdev(sdd2)
Sep 20 19:25:09 lorentz kernel: md: bind<sdb2>
Sep 20 19:25:09 lorentz kernel: RAID10 conf printout:
Sep 20 19:25:09 lorentz kernel:  --- wd:2 rd:4
Sep 20 19:25:09 lorentz kernel:  disk 0, wo:0, o:1, dev:sda2
Sep 20 19:25:09 lorentz kernel:  disk 1, wo:0, o:1, dev:sdc2
Sep 20 19:25:09 lorentz kernel:  disk 2, wo:1, o:1, dev:sdb2
Sep 20 19:25:09 lorentz kernel: md: syncing RAID array md1
Sep 20 19:25:09 lorentz kernel: md: minimum _guaranteed_ reconstruction
speed: 1000 KB/sec/disc.
Sep 20 19:25:09 lorentz kernel: md: using maximum available idle IO
bandwith (but not more than 200000 KB/sec) for reconstruction.
Sep 20 19:25:09 lorentz kernel: md: using 128k window, over a total of
979840 blocks.
Sep 20 19:25:09 lorentz kernel: ------------[ cut here ]------------
Sep 20 19:25:09 lorentz kernel: kernel BUG at drivers/md/raid10.c:1448!
Sep 20 19:25:09 lorentz kernel: invalid operand: 0000 [#1]
Sep 20 19:25:09 lorentz kernel: SMP
Sep 20 19:25:09 lorentz kernel: Modules linked in:
Sep 20 19:25:09 lorentz kernel: CPU:    1
Sep 20 19:25:09 lorentz kernel: EIP:    0060:[sync_request+780/2122]
Not tainted VLI
Sep 20 19:25:09 lorentz kernel: EFLAGS: 00010246   (2.6.13.2)
Sep 20 19:25:09 lorentz kernel: EIP is at sync_request+0x30c/0x84a
Sep 20 19:25:09 lorentz kernel: eax: 00000000   ebx: f75d9300   ecx:
00000018   edx: 00000002
Sep 20 19:25:09 lorentz kernel: esi: f7c63880   edi: f75d930c   ebp:
f7c5c120   esp: f4df5eb0
Sep 20 19:25:09 lorentz kernel: ds: 007b   es: 007b   ss: 0068
Sep 20 19:25:09 lorentz kernel: Process md1_resync (pid: 1479,
threadinfo=f4df5000 task=f74c2020)
Sep 20 19:25:09 lorentz kernel: Stack: f7c63880 f75d9300 00000002
00000000 00000010 00000000 00000080 00000000
Sep 20 19:25:09 lorentz kernel:        00000000 00000000 00000002
00000002 00000003 00000000 e3c2c626 f4df5f3c
Sep 20 19:25:09 lorentz kernel:        f4df5f64 00000000 00000000
00000000 00000000 00000000 f7c70000 c037e533
Sep 20 19:25:09 lorentz kernel: Call Trace:
Sep 20 19:25:09 lorentz kernel:  [md_do_sync+1370/1792] md_do_sync
+0x55a/0x700
Sep 20 19:25:09 lorentz kernel:  [complete+66/82] complete+0x42/0x52
Sep 20 19:25:09 lorentz kernel:  [md_thread+297/359] md_thread
+0x129/0x167
Sep 20 19:25:09 lorentz kernel:  [autoremove_wake_function+0/75]
autoremove_wake_function+0x0/0x4b
Sep 20 19:25:09 lorentz kernel:  [md_thread+0/359] md_thread+0x0/0x167
Sep 20 19:25:09 lorentz kernel:  [kernel_thread_helper+5/11]
kernel_thread_helper+0x5/0xb
Sep 20 19:25:09 lorentz kernel: Code: 00 8b 54 24 14 85 d2 0f 85 25 ff
ff ff 8b 44 24 18 2b 44 24 64 01 44 24 20 83 44 24 24 01 8b 4c 24 18 89
4c 24 64 e9 24 fd ff ff <0f> 0b a8 05 ff 19 46 c0 89 dd 8b 56 08 e9 b8
fe ff ff 8b 46 60
Sep 20 19:25:11 lorentz kernel:  <6>md: bind<sdd2>
Sep 20 19:25:41 lorentz kernel: md: unbind<sdd2>
Sep 20 19:25:41 lorentz kernel: md: export_rdev(sdd2)
Sep 20 19:25:56 lorentz kernel: md: cannot remove active disk sdb2 from
md1 ...

And then I resetted the machine with the reset switch.
But to my surprise it oopsed again on reboot when the machine tried to
resync automatically. It looks like the same oops as above, but I
included it just to be sure:

Sep 20 19:42:07 lorentz kernel: ------------[ cut here ]------------
Sep 20 19:42:07 lorentz kernel: kernel BUG at drivers/md/raid10.c:1448!
Sep 20 19:42:07 lorentz kernel: invalid operand: 0000 [#1]
Sep 20 19:42:07 lorentz kernel: SMP
Sep 20 19:42:07 lorentz kernel: Modules linked in:
Sep 20 19:42:07 lorentz kernel: CPU:    1
Sep 20 19:42:07 lorentz kernel: EIP:    0060:[sync_request+780/2122]
Not tainted VLI
Sep 20 19:42:07 lorentz kernel: EFLAGS: 00010246   (2.6.13.2)
Sep 20 19:42:07 lorentz kernel: EIP is at sync_request+0x30c/0x84a
Sep 20 19:42:07 lorentz kernel: eax: 00000000   ebx: f79bbc80   ecx:
00000018 edx: 00000002
Sep 20 19:42:07 lorentz kernel: esi: f7d13700   edi: f79bbc8c   ebp:
f7cd63a0 esp: c1a28eb0
Sep 20 19:42:07 lorentz kernel: ds: 007b   es: 007b   ss: 0068
Sep 20 19:42:07 lorentz kernel: Process md1_resync (pid: 883,
threadinfo=c1a28000 task=f7cdf020)
Sep 20 19:42:07 lorentz kernel: Stack: f7d13700 f79bbc80 00000002
00000000 00000010 00000000 00000080 00000000
Sep 20 19:42:07 lorentz kernel:        00000000 00000000 00000002
00000002 00000003 00000000 4335da26 c1a28f3c
Sep 20 19:42:07 lorentz kernel:        c1a28f64 00000000 00000000
00000000 00000000 00000000 f7ce2200 c037e533
Sep 20 19:42:07 lorentz kernel: Call Trace:
Sep 20 19:42:07 lorentz kernel:  [md_do_sync+1370/1792] md_do_sync
+0x55a/0x700
Sep 20 19:42:07 lorentz kernel:  [complete+66/82] complete+0x42/0x52
Sep 20 19:42:07 lorentz kernel:  [md_thread+297/359] md_thread
+0x129/0x167
Sep 20 19:42:07 lorentz kernel:  [autoremove_wake_function+0/75]
autoremove_wake_function+0x0/0x4b
Sep 20 19:42:07 lorentz kernel:  [md_thread+0/359] md_thread+0x0/0x167
Sep 20 19:42:07 lorentz kernel:  [kernel_thread_helper+5/11]
kernel_thread_helper+0x5/0xb
Sep 20 19:42:07 lorentz kernel: Code: 00 8b 54 24 14 85 d2 0f 85 25 ff
ff ff 8b
44 24 18 2b 44 24 64 01 44 24 20 83 44 24 24 01 8b 4c 24 18 89 4c 24 64
e9 24 fd ff ff <0f> 0b a8 05 ff 19 46 c0 89 dd 8b 56 08 e9 b8 fe ff ff
8b 46 60

So did I stumble on a bug here or did I just do something stupid? I
haven't tried with a different kernel.
More information available on request.

Thanks!!

Regards,

Guus Houtzager
-- 
                              Luna.nl B.V.
                Puntegaalstraat 109 * 3024 EB Rotterdam
              T 010 7502000 * F 010 7502002 * www.luna.nl



