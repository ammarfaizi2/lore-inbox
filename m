Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276424AbRLHMJm>; Sat, 8 Dec 2001 07:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278701AbRLHMJd>; Sat, 8 Dec 2001 07:09:33 -0500
Received: from a56d18.elisa.omakaista.fi ([212.54.5.56]:46976 "EHLO
	masiina.localdomain") by vger.kernel.org with ESMTP
	id <S276424AbRLHMJZ>; Sat, 8 Dec 2001 07:09:25 -0500
Message-ID: <3C1202ED.6010003@retiisi.dyndns.org>
Date: Sat, 08 Dec 2001 14:09:17 +0200
From: Sakari Ailus <sailus@retiisi.dyndns.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: fi, en-us, sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: reading at the end of block device fails
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

       [1.] One line summary of the problem:

Reading at the end of block device fails.

       [2.] Full description of the problem/report:

I have three machines, all with one hard disk, and one machine always
fails reading few last kB's at the end of its hard disk. It works fine
on two other hard disks. (Disk sizes and partition information at the 
end of message.)

AFAIR I've seen something like this on some CD-ROM's also (IDE CD-ROM
drive using SCSI emulation)...

Here's an example:

---
22:51:59 toosa root [/tmp]grep hda9 /proc/partitions
      3     9      88326 hda9
22:52:06 toosa root [/tmp]dd if=/dev/hda9 of=/dev/null skip=88324 bs=1k
count=2
dd: /dev/hda9: Input/output error
0+0 records in
0+0 records out
---

When I run this, I get these messages on syslog:

---
Dec  7 22:52:10 toosa kernel: attempt to access beyond end of device
Dec  7 22:52:10 toosa kernel: 03:09: rw=0, want=88328, limit=88326
---

Instead, reading a few sectors from earlier position works fine:

---
22:58:41 toosa root [/tmp]dd if=/dev/hda9 of=/dev/null skip=88322 bs=1k
count=2
2+0 records in
2+0 records out
---

I wouldn't have noticed this unless the swap partition
hadn't been at the end of the hard disk... ;-) Lots of oopses at the 
same time, programs crash, etc.

       [3.] Keywords (i.e., modules, networking, kernel):

I/O, end of disk, block device

       [4.] Kernel version (from /proc/version):

Linux version 2.4.16 (root@masiina) (gcc version 2.95.2 20000220 (Debian
GNU/Linux)) #1 Mon Nov 26 20:20:53 EET 2001

       [6.] A small shell script or example program which triggers the
            problem (if possible)

This script prints out command line which may trigger the problem. It
assumes (block) device to be tested is /dev/hda.

---
#!/bin/bash

HD=hda
LINE=$(grep $HD /proc/partitions | tail -1)
DEV=$(echo $LINE | awk '{print $4;}')
POS=$(echo $LINE | awk '{print $3-2;}')

echo dd if=/dev/"$DEV" of=/dev/null skip=$POS bs=1k count=2
---

       [7.] Environment
       [7.1.] Software (add the output of the ver_linux script here)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux toosa 2.4.16 #1 Mon Nov 26 20:20:53 EET 2001 i586 unknown

Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.9.5.0.37
...
mount                  2.10q
modutils               2.4.2
e2fsprogs              1.19
reiserfsprogs          3.x.0j
PPP                    2.4.0
Linux C Library        2.1.3
ldd: version 1.9.11
Procps                 2.0.6
Net-tools              1.54
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         ipt_MASQUERADE iptable_nat ip_conntrack
iptable_filter rtc nls_iso8859-1 nls_cp437 msdos autofs4 ip_tables lp
parport_pc parport 3c509 minix vfat fat

util-linux is of version 2.10q. Debian doesn't seem to have fdformat any
more.

       [7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : CyrixInstead
cpu family      : 5
model           : 2
model name      : 6x86 2x Core/Bus Clock
stepping        : 7
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : yes
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu cyrix_arr
bogomips        : 132.30

       [7.3.] Module information (from /proc/modules):

ipt_MASQUERADE          1200   1 (autoclean)
iptable_nat            12656   0 (autoclean) [ipt_MASQUERADE]
ip_conntrack           12800   1 (autoclean) [ipt_MASQUERADE iptable_nat]
iptable_filter          1696   0 (autoclean) (unused)
rtc                     5472   0 (autoclean)
nls_iso8859-1           2848   2 (autoclean)
nls_cp437               4352   2 (autoclean)
msdos                   4784   2 (autoclean)
autofs4                 8032   0 (unused)
ip_tables              10400   5 [ipt_MASQUERADE iptable_nat iptable_filter]
lp                      5824   0
parport_pc             12320   1
parport                13792   1 [lp parport_pc]
3c509                   5744   1
minix                  17984   0 (unused)
vfat                    9264   0 (unused)
fat                    29184   0 [msdos vfat]

       [7.5.] Other information that might be relevant to the problem
              (please look in /proc and include all information that you
               think to be relevant):

Disks on all machines (first hard disk is the one I've problems with):

1: hda: 10003456 sectors (5122 MB) w/256KiB Cache, CHS=622/255/63
2: hde: 80063424 sectors (40992 MB) w/2048KiB Cache, CHS=79428/16/63,
UDMA(66)
3: hde: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63,
UDMA(100)

/proc/partitions (on problematic machine):

---
major minor  #blocks  name

      3     0    5001728 hda
      3     1       8001 hda1
      3     2     409657 hda2
      3     3          1 hda3
      3     5    1028128 hda5
      3     6    1919736 hda6
      3     7    1534176 hda7
      3     8       8001 hda8
      3     9      88326 hda9
---

And on other machines:

---
major minor  #blocks  name

   33     0   40031712 hde
   33     1      15592 hde1
   33     2     512064 hde2
   33     3   39504024 hde3
---
and
---
major minor  #blocks  name

   33     0   30018240 hde
   33     1       8001 hde1
   33     2    1028160 hde2
   33     3          1 hde3
   33     5     313236 hde5
   33     6     722893 hde6
   33     7       8001 hde7
   33     8    2056288 hde8
   33     9    2056288 hde9
   33    10    2032191 hde10
   33    11     465853 hde11
   33    12   21326256 hde12
---

Partition table print from fdisk on first machine, end of hda is also 
end of /dev/hda9:

---
01:14:14 toosa root [/tmp]fdisk /dev/hda

Command (m for help): p

Disk /dev/hda: 255 heads, 63 sectors, 622 cylinders
Units = cylinders of 16065 * 512 bytes

      Device Boot    Start       End    Blocks   Id  System
/dev/hda1   *         1         1      8001    a  OS/2 Boot Manager
/dev/hda2             2        52    409657+   6  FAT16
/dev/hda3            53       622   4578525    5  Extended
/dev/hda5   *        53       180   1028128+   6  FAT16
/dev/hda6   *       181       419   1919736   83  Linux
/dev/hda7   *       420       610   1534176   83  Linux
/dev/hda8   *       611       611      8001   83  Linux
/dev/hda9   *       612       622     88326   82  Linux swap
---

I can't help noticing that the size of that swap partition isn't 
divisible by 4 (but 2 instead). Other partitions on these disks have odd 
size or are divisible by 4, I tried this on few of them with no problems.

-- 
Sakari Ailus
sakari.ailus@retiisi.dyndns.org

