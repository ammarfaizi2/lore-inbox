Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265400AbUAHQDR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 11:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265389AbUAHQCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 11:02:53 -0500
Received: from fmr01.intel.com ([192.55.52.18]:65482 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S265353AbUAHQCl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 11:02:41 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: stability problems with 2.4.24/Software RAID/ext3
Date: Thu, 8 Jan 2004 11:02:31 -0500
Message-ID: <E5DA6395B8F9614EB7A784D628184B200E345C@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: stability problems with 2.4.24/Software RAID/ext3
Thread-Index: AcPV+9JryqGm7AmFSCu2TfT23Vh8MAAA/Hrw
From: "Cress, Andrew R" <andrew.r.cress@intel.com>
To: "martin f krafft" <madduck@madduck.net>,
       "linux kernel mailing list" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Jan 2004 16:02:32.0341 (UTC) FILETIME=[D2EA2450:01C3D600]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,

I've seen some issues with jbd/transaction.c in 2.4.20+ that look
similar to one of your panics.  There was a fix by RedHat to the problem
I saw.
 
https://listman.redhat.com/archives/ext3-users/2002-December/msg00125.ht
ml
You may want to check it out to see if this fix is already included in
your 2.4.24 kernel.   

Andy

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of martin f krafft
Sent: Thursday, January 08, 2004 10:12 AM
To: linux kernel mailing list
Subject: stability problems with 2.4.24/Software RAID/ext3


Hi all,

I operate a groupware server which is giving me a very hard time.
It's an AMD Athlon XP 3000+ with 1Gb of RAM, and four 7200 UPM IDE
harddrives, two attached to the primary channels of the onboard
controller, and two to the primary channels of a Promise 20269 EIDE
controller. The kernel is a 2.4.24 with the configuration I placed
here:

  ftp://ftp.madduck.net/scratch/config-2.4.24-gaia.gz 

The system is configured with 7 Software-RAID and three swap partitions:

  md1:  /boot      (ext3) RAID 1 spanning hda1 and hdc1
  md5:  /          (ext3) RAID 5 hda5/hdc5/hde5 with hdg5 as a spare
  md6:  /usr       (ext3) RAID 5 hda6/hdc6/hde6 with hdg6 as a spare
  md7:  /var       (ext3) RAID 5 hda7/hdc7/hde7 with hdg7 as a spare
  md8:  /usr/local (ext3) RAID 5 hda8/hdc8/hde8 with hdg8 as a spare
  md9:  /home      (ext3) RAID 5 hda9/hdc9/hde9 with hdg9 as a spare
  md10: /tmp       (ext3) RAID 5 hda10/hdc10/hde10 with hdg10 as a spare

  hda2 holds a non-RAID rescue system with RAID 1/5 supporrt

  hdc2, hde2, hdg2 are swap partitions of 256 Mb each.
  
  hde1 and hdg1 are unused.

The individial harddisks are identically tweaked with hdparm:

  hdparm -A1 -B255 -c1 -d1 -p -u0 -W0 -Xudma6 /dev/hd{a,c,e,g}

See the end of this mail for details.

The system experiences severe stability problems, which I relate to
the filesystem, RAID, or controller code, because it's reproducible
with excessive disk operations. E.g., doing something like

  rsync -a --exclude /tmp / /tmp/dump

will most likely crash the system with a kernel oops. This kernel
oops is not recorded in the log, but I took it down as follows:
  
  kernel: Unable to handle kernel paging request at virtual address
00529610
  kernel:  printing eip:
  kernel: c01c7f41
  kernel: *pde = 00000000
  kernel: Oops: 0002
  kernel: CPU:    0
  kernel: EIP:    0010:[__remove_inode_queue+17/48]    Not tainted
  kernel: EFLAGS: 00010202
  kernel: eax: cef76320   ebx: cc529590   ecx: 00529610   edx : cc529540
  kernel: esi: cc529540   edi: c1e59510   ebp: cc4e7cc0   esp : f3a55e54
  kernel: ds: 0018   es: 0018   ss: 0018
  kernel: Process kjournald (pid: 24176, stackpage=f3a55000)
  kernel: Stack: 00000000 c01c862a cc529540 c02029d8 cc529540 c1e59ea0
c01fec42 cc529540 
  kernel:        00000040 f3a55ea4 00000d0d f7ee8280 f6965d34 00000000
00000000 00000000 
  kernel:        0000000f cb3b3840 e6e308a0 00000d0d cc0ec9c0 cc0eca40
cc0ec0c0 cc149bc0 
  kernel: Call Trace:    [__refile_buffer+106/112]
[journal_free_journal_head+24/32] [journal_commit_transaction+4066/4352]
[kjournald+263/464] [commit_timeout+0/16]
  kernel:   [arch_kernel_thread+43/64] [kjournald+0/464]
  kernel: 
  kernel: Code: 89 01 c7 43 04 00 00 00 00 c7 42 50 00 00 00 00 b8 09 00
00 

  kernel:  <1>Unable to handle kernel NULL pointer dereference at
virtual address 00000000
  kernel:  printing eip:
  kernel: c01be950
  kernel: *pde = 00000000
  kernel: Oops: 0000
  kernel: CPU:    0
  kernel: EIP:    0010:[kmem_cache_reap+128/448]    Not tainted
  kernel: EFLAGS: 00010013
  kernel: eax: 00000000   ebx: 00000001   ecx: c1c0d348   edx : c1c0d358
  kernel: esi: 00000000   edi: 00000005   ebp: 00000000   esp : c1c33f38
  kernel: ds: 0018   es: 0018   ss: 0018
  kernel: Process kswapd (pid: 4, stackpage=c1c33000)
  kernel: Stack: c1240260 000001d0 c1c0d348 00000000 00000000 00000000
00000020 000001d0 
  kernel:        c0102aa0 00000006 c01bf646 00000006 c0102aa0 c0102aa0
000001d0 00000006 
  kernel:        c0102aa0 00000000 c01bf706 00000020 c0102aa0 c1c32000
c0102940 c01bf824 
  kernel: Call Trace:    [shrink_caches+38/176]
[try_to_free_pages_zone+54/96] [kswapd_balance_pgdat+84/160]
[kswapd_balance+25/48] [kswapd+141/176]

since the two crashes are related to kswapd and kjournald, I would
assume it's the underlying RAID code that's problematic. However,
maybe you can extract more information from the above crashes.

The following is a snapshot from `vmstat 1` prior to a regular
kernel panic, which resulted in a reboot (thanks to sys.kernel.panic
== 60):

 1  1  2  10184  12344  47020 749912   0   0     0  4344  382   308   0
1  99
 0  1  1  10184  12344  47020 749912   0   0     0  5936  395   334   0
2  98
 0  1  1  10184  12332  47020 749916   0   0     4  4808  379   330   0
3  97
 0  1  1  10184  12332  47020 749916   0   0     0  5008  342   277   1
0  99
 0  1  2  10184  12328  47024 749916   0   0     0  5120  330   293   0
4  96
 0  3  2  10184  12356  47040 750108   0   0    64  4772  367   360   0
3  97
 0  1  1  10184  12460  47052 749704   0   0  1220  6236  352   390   1
4  95
 0  1  1  10184  12044  47052 750096   0   0  2176  6772  371   497   6
5  89
 0  1  1  10184  12388  47060 749704   0   0   324  7732  367   376   0
6  94
 0  1  2  10184  12512  47068 749824   0   0    56  7448  365   312   0
1  99
 0  1  1  10184  12832  47080 749444   0   0   424  6648  368   363   0
3  97
 0  1  1  10184  11884  47092 750156   0   0  2304  7960  416   504   1
8  91
 2  0  1  10184  12708  47100 749284   0   0  1772  6836  370   462   5
4  91

Interestingly, just now, the machine crashed differently. `vmstat 1`
was still running, but new processes could not be started, after the
kernel reported a lot of oopses in user-space processes (e.g. rsync,
top, zsh), as well as some of the kjournald oopses like above.
I have included the footprint of the user-space program oopses
further down. `vmstat 1` was happily printing the following away,
when the system was already unusable. The b > 127 value is
interesting, as it has been continuously increasing (well, in
a non-decreasing way) after a certain point, and somewhere on the
way, the system reached the state of agnosia.

 0 127  2  16124  10304  43004 682188   0   0     0     0  109     7   0
0 100
 0 127  2  16124  10304  43004 682188   0   0     0     0  111     5   0
0 100
 0 127  2  16124  10304  43004 682188   0   0     0     0  114     9   0
0 100
 0 127  2  16124  10304  43004 682188   0   0     0     0  111     5   0
0 100
 0 127  2  16124  10304  43004 682188   0   0     0     0  115     9   0
0 100
 0 128  2  16124  10420  43004 682060   0   0     0     0  119    12   0
0 100
 0 128  2  16124  10420  43004 682060   0   0     0     0  122    11   0
0 100

Apart from these panics and hangups, the system also randomly issues
segfaults to processes, or reports a kernel oops. These take the
following form:

  kernel: kernel BUG at mmap.c:842!
  kernel: invalid operand: 0000
  kernel: CPU:    0
  kernel: EIP:    0010:[find_vma_prev+124/176]    Not tainted
  kernel: EFLAGS: 00010206
  kernel: eax: c7ce4dc0   ebx: c7ce4e40   ecx: c7ce4dd8   edx: c95fde90
  kernel: esi: 4e968000   edi: c7ce4658   ebp: d16b8ec0   esp: c95fde50
  kernel: ds: 0018   es: 0018   ss: 0018
  kernel: Process python2.1 (pid: 24868, stackpage=c95fd000)
  kernel: Stack: c7ce4e40 4e968000 00001000 d16b8ec0 c01b7104 d16b8ec0
4e968000 c95fde90 
  kernel:        c01d116d e70b82c0 4e93d000 00001000 c01b6a44 d16b8ec0
4e93d000 e70b82c0 
  kernel:        c7ce4dc0 c7ce4e40 00000000 4e968000 00001000 c01b6550
d16b8ec0 4e968000 
  kernel: Call Trace:    [do_munmap+132/432] [link_path_walk+1309/1776]
[get_unmapped_area+164/320] [do_mmap_pgoff+400/1504] [old_mmap+269/336]
  kernel:   [system_call+51/80] [sys_fstat64+73/128] [system_call+77/80]
  kernel: 
  kernel: Code: 0f 0b 4a 03 80 86 34 c0 89 d8 5b 5e 5f 5d c3 39 5d 00 eb
ea 

or:

  kernel: Unable to handle kernel paging request at virtual address
712e746b
  kernel:  printing eip:
  kernel: c01eb950
  kernel: *pde = 00000000
  kernel: Oops: 0000
  kernel: CPU:    0
  kernel: EIP:    0010:[proc_pid_stat+144/800]    Not tainted
  kernel: EFLAGS: 00010206
  kernel: eax: dd95e5ad   ebx: d0988500   ecx: d098851c   edx: 712e7463
  kernel: esi: f5138000   edi: d5ce25ad   ebp: 000003ff   esp: f3a9de14
  kernel: ds: 0018   es: 0018   ss: 0018
  kernel: Process top (pid: 26768, stackpage=f3a9d000)
  kernel: Stack: c01e9eb9 f5138000 c0361e64 cbc4f1c0 cbc4f1c0 c01ea17e
e70b8c40 cbc4f1c0 
  kernel:        0000000b 00000004 f5138000 ffffffea fffffff4 cbc4f82c
cbc4f7c0 e70b8c40 
  kernel:        c01d0b03 cbc4f7c0 e70b8c40 e70b8c40 e5ac300e fffffffe
f3a9df0c c01d116d 
  kernel: Call Trace:    [proc_pid_make_inode+121/160]
[proc_base_lookup+254/560] [real_lookup+195/240]
[link_path_walk+1309/1776] [get_empty_filp+77/288]
  kernel:   [proc_info_read+87/272] [filp_open+98/112]
[sys_read+163/304] [system_call+51/80] [sys_close+78/96]
[system_call+77/80]
  kernel: 
  kernel: Code: 8b 42 08 2b 42 04 8b 52 0c 01 c7 85 d2 75 f1 ba ff ff ff
ff 

Thanks for any hints or pointers!

hdparm configuration:

  multcount    = 16 (on)
  I/O support  =  1 (32-bit)
  unmaskirq    =  0 (off)
  using_dma    =  1 (on)
  keepsettings =  0 (off)
  nowerr       =  0 (off)
  readonly     =  0 (off)
  readahead    =  6 (on)
  geometry     = 238216/16/63, sectors = 240121728, start = 0
  busstate     =  1 (on)
  Model=Maxtor 6Y120L0, FwRev=YAR41BW0, SerialNo=Y31GHARE
  Config={ Fixed }
  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
  BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=240121728
  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
  PIO modes: pio0 pio1 pio2 pio3 pio4 
  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5
*udma6 
  AdvancedPM=yes: disabled (255) WriteCache=enabled
  Drive Supports : ataATA-1 ATA-2 ATA-3 ATA-4 ATA-5 ATA-6 ATA-7 

-- 
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
 
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
 
"the vast majority of our imports come from outside the country."  
                                                      - george w. bush 
