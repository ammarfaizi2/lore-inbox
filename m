Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbTEYLuQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 07:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbTEYLuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 07:50:16 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:15280 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S262023AbTEYLuN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 07:50:13 -0400
To: linux-kernel@vger.kernel.org
Subject: [OOPS] ide-ops:1262 in 2.4.21-rc3
Mail-Copies-To: never
From: Roland Mas <roland.mas@free.fr>
Date: Sun, 25 May 2003 14:03:20 +0200
Message-ID: <87d6i7kzcn.fsf@free.fr>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there.  The kernel tells me it has a bug.  The ksymoops'ed trace is
later in this message.  First a few bits of context:

- Kernel version is vanilla 2.4.21-rc3 (no patches or external
  modules), compiled with gcc-3.3;
- Box is an Athlon 2200+, one gig of RAM;
- IDE setup:
,----
| hda: Maxtor 6Y080L0, ATA DISK drive
| hdb: SAMSUNG CDRW/DVD SM-348B, ATAPI CD/DVD-ROM drive
| hdc: Maxtor 6Y080L0, ATA DISK drive
`----
- Trigger command: "cdrecord dev=0,0,0 blank=fast";
- Boot options: "auto BOOT_IMAGE=Linux ro root=900 hdb=scsi";
- Bits of the .config file I think may be relevant:
,----
| CONFIG_BLK_DEV_IDESCSI=m
| CONFIG_BLK_DEV_IDECD=m
| CONFIG_SCSI=m
| CONFIG_BLK_DEV_SR=m
| CONFIG_MD=y
| CONFIG_BLK_DEV_MD=y
| CONFIG_MD_LINEAR=m
| CONFIG_MD_RAID0=m
| CONFIG_MD_RAID1=y
| CONFIG_MD_RAID5=m
| # CONFIG_MD_MULTIPATH is not set
| CONFIG_BLK_DEV_LVM=m
`----
- Running up-to-date Debian unstable.

  The problem happens when I try to blank a CD-RW from a terminal in
X-Window (or from a GUI frontend such as gcombust).  The same command
issued on the console does not cause the panic.  I'll check whether it
does if issued on the console when X is running.

  The problem started happening when I reordered my IDE devices: when
I bought this box, the hard disks were both on the same IDE bus (hda
and hdb), and the CD-RW/DVD combo was on the other one (hdd).  When
setting up RAID-1 on a few partitions of the hard disks, I moved them
around so that they be on different buses, as recommended by the
HOWTO.  I didn't try burning a CD between the setting up of the RAID
array and the moving-drives-around operation.  I also didn't try
switching back to an earlier kernel such as 2.4.21-rc2.  At first I
thought maybe it was a problem of trying to do stuff on the IDE bus
while the RAID array is resyncing (/dev/md[0-7] total 40 GB, and it
"only" resyncs at 2 MB/s), but I managed to blank and record a CD-RW
even during a resync (from console), so that option seems out.

ksymoops 2.4.8 on i686 2.4.21-rc3.  Options used
     -V (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-rc3/ (default)
     -m /boot/System.map-2.4.21-rc3 (default)

kernel BUG at ide-ops: 1262!
invalid operand: 0000
CPU:    0
EIP:    0010: [<c01af154>] not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210086
eax: f8931630 ebx: 00000000 ecx: 00000032 edx: f6968a54
esi: f6148e00 edi: c02cac0c ebp: c02caa20 esp: c028de90
ds: 0018 es: 0018 ss: 0018
Process swapper (pid: 0, stackpage=c028d000)
Stack: 00200046 0000002e 00200082 f6147e00 f7eeb7bc 00200086 00000000 f6148e00
       00000000 00000002 c01af347 c02cac0c 00000000 f8932869 c02cac0c f8929a13
       f6148e00 00000002 00000000 f6968a54 f6148e00 00200282 fffffffe 00200046
Call Trace:   [<c01af347>] [<f8932869>] [<f8928a13>] [<f8927eb8>] [<f8927e40>]
 [<c011d050>] [<c0119482>] [<c0119396>] [<c01191d1>] [<c0108a0b>] [<c010ae98>]
 [<c0191404>] [<c01912e0>] [<c01912e0>] [<c0105472>] [<c0105000>]
Code: 0f 0b ee 04 7c b4 23 c0 80 bf f9 00 00 00 20 74 0c 8b 74 24


>>EIP; c01af154 <do_reset1+24/200>   <=====

>>eax; f8931630 <[ide-scsi]idescsi_pc_intr+0/320>
>>edx; f6968a54 <_end+36691344/38531970>
>>esi; f6148e00 <_end+35e716f0/38531970>
>>edi; c02cac0c <ide_hwifs+1ec/2b48>
>>ebp; c02caa20 <ide_hwifs+0/2b48>
>>esp; c028de90 <init_task_union+1e90/2000>

Trace; c01af347 <ide_do_reset+17/20>
Trace; f8932869 <[ide-scsi]idescsi_reset+19/30>
Trace; f8928a13 <[scsi_mod]scsi_reset+f3/350>
Trace; f8927eb8 <[scsi_mod]scsi_old_times_out+78/150>
Trace; f8927e40 <[scsi_mod]scsi_old_times_out+0/150>
Trace; c011d050 <run_timer_list+f0/160>
Trace; c0119482 <bh_action+22/40>
Trace; c0119396 <tasklet_hi_action+46/70>
Trace; c01191d1 <do_softirq+91/a0>
Trace; c0108a0b <do_IRQ+ab/e0>
Trace; c010ae98 <call_do_IRQ+5/d>
Trace; c0191404 <pr_power_idle+124/2d0>
Trace; c01912e0 <pr_power_idle+0/2d0>
Trace; c01912e0 <pr_power_idle+0/2d0>
Trace; c0105472 <cpu_idle+42/60>
Trace; c0105000 <_stext+0/0>

Code;  c01af154 <do_reset1+24/200>
00000000 <_EIP>:
Code;  c01af154 <do_reset1+24/200>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01af156 <do_reset1+26/200>
   2:   ee                        out    %al,(%dx)
Code;  c01af157 <do_reset1+27/200>
   3:   04 7c                     add    $0x7c,%al
Code;  c01af159 <do_reset1+29/200>
   5:   b4 23                     mov    $0x23,%ah
Code;  c01af15b <do_reset1+2b/200>
   7:   c0 80 bf f9 00 00 00      rolb   $0x0,0xf9bf(%eax)
Code;  c01af162 <do_reset1+32/200>
   e:   20 74 0c 8b               and    %dh,0xffffff8b(%esp,%ecx,1)
Code;  c01af166 <do_reset1+36/200>
  12:   74 24                     je     38 <_EIP+0x38>

<O> Kernel panic: Aiee, killing interrupt handler!

  This is my first post on LKML, and I've only just re-subscribed
after like four years of not-touching-it-with-a-ten-foot-pole, so the
habits may have changed.  I did read the FAQ and search the archives
for "ide oops", though.  If some info is missing, I'll be glad to
provide it.

Roland.
-- 
Roland Mas

Lord of the rings?  Show us.
European Juggling Convention -- Svendborg, Denmark.  http://ejc2003.dk
