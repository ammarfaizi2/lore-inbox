Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288130AbSAXOll>; Thu, 24 Jan 2002 09:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288127AbSAXOlX>; Thu, 24 Jan 2002 09:41:23 -0500
Received: from host-01.pronet.pl ([213.241.42.209]:5646 "EHLO pronet.pl")
	by vger.kernel.org with ESMTP id <S288117AbSAXOlQ>;
	Thu, 24 Jan 2002 09:41:16 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marcin Prejsnar <alex@pronet.pl>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Memory problem 2.4.9-2.4.17
Date: Thu, 24 Jan 2002 15:40:33 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Organization: ProNet s.c.
Message-Id: <E16Tl3p-00024g-00@alex.pronet.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

[1.] SUMMARY
	Error packets received on interface ppp cause free memory decrease.

[2.] FULL DESCRIPTION
	I found connection between number of error packets received from interface 
ppp and amount of free memory in the system. While number of error packets 
increase, parameter "skbuff_head_cache" (from /proc/slabinfo) increase too. 
Every 2 errors appears - "shbuff_head_cache" rise 1. This parameter never 
decrease, even after interface restart, and unload all possible modules.
	Below some reports, from three points in time. In each case: first line - 
just after system start, second - after several hours, third just - before 
system crash (out of memory).

#ifconfig ppp0 | grep "RX packets"
          RX packets:57 errors:0 dropped:0 overruns:0 frame:0
          RX packets:714315 errors:9884 dropped:0 overruns:0 frame:0
          RX packets:1529320 errors:46683 dropped:0 overruns:0 frame:0

#grep skbuff /pros/slabinfo
skbuff_head_cache    173    180    192    9    9    1
skbuff_head_cache   5373   5380    192  269  269    1
skbuff_head_cache  23245  23260    192 1163 1163    1

#vmstat
 r b w  swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0 0 0     0  33684   6812  11604   0   0    16     8  135    13   1   2  98
 0 0 0   108   1892  21772  13916   0   0     0     1  300     6   0   3  97
 0 0 0  4132   1964    456   2904   2   4    14     8  427    20   0   3  97

#free
             total       used       free     shared    buffers     cached
Mem:         62536      27100      35436          0       6740      10584
- -/+ buffers/cache:       9776      52760
Mem:         62536      60644       1892          0      21772      13916
- -/+ buffers/cache:      24956      37580
Mem:         62536      60564       1972          0        452       2900
- -/+ buffers/cache:      57212       5324

I can send you more detailed report from my system (including all slabinfo, 
meminfo, and output from "vmstat" and "free" every one minute)

[3.] KEYWORDS
ppp interface, error packets, skbuff_head_cache, memory leak, linux-2.4.x, 

[4.] KERNEL VERSION
Tested kernels: (All tested kernels have the same problem)
2.4.9
2.4.10
2.4.12
2.4.13
2.4.14
2.4.16
2.4.17
2.4.13-ac8

[5.] Not aplicapable ... I think...

[6.] I have replicate this problem on other hardware too. Two machines 
connected with broken null-modem cable, and ping apropriate ppp interface 
from one to another:
#ping -l 30000000 -s 3000 192.168.101.5

[7.] ENVIRONMEMT
[7.1] SOFTWARE
Router-firewall on RedHat linux 7.1 (with updates).

#ver_linux:
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.57
Modules Loaded         ppp_deflate bsd_comp ppp_async serial ppp_generic slhc 
isa-pnp af_packet 3c59x ipt_LOG ipt_limit iptable_filter ip_nat_ftp 
iptable_nat ip_tables ip_conntrack_ftp ip_conntrack usb-uhci usbcore

[7.2] Processor info:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 501.143
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr
bogomips        : 999.42

[7.3] MODULE INFORMATION
ppp_deflate            42368   2 (autoclean)
bsd_comp                4704   0 (autoclean)
ppp_async               6768   1 (autoclean)
serial                 56144   1 (autoclean)
ppp_generic            16448   3 (autoclean) [ppp_deflate bsd_comp ppp_async]
slhc                    5312   0 (autoclean) [ppp_generic]
isa-pnp                30224   0 (autoclean) [serial]
af_packet              12608   0 (autoclean)
3c59x                  26048   3 (autoclean)
ipt_LOG                 3920  19 (autoclean)
ipt_limit               1392  17 (autoclean)
iptable_filter          2160   0 (autoclean) (unused)
ip_nat_ftp              4208   0 (unused)
iptable_nat            23376   1 [ip_nat_ftp]
ip_tables              14016   6 [ipt_LOG ipt_limit iptable_filter 
iptable_nat]
ip_conntrack_ftp        4208   0 [ip_nat_ftp]
ip_conntrack           22992   2 [ip_nat_ftp iptable_nat ip_conntrack_ftp]
usb-uhci               21776   0 (unused)
usbcore                52000   1 [usb-uhci]

[7.4] Loaded driver and hardware information

#cat /proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000cc7ff : Extension ROM
000cd000-000cd7ff : Extension ROM
000ce000-000ce7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-03feffff : System RAM
  00100000-001fc367 : Kernel code
  001fc368-0024453f : Kernel data
03ff0000-03ff2fff : ACPI Non-volatile Storage
03ff3000-03ffffff : ACPI Tables
e0000000-e7ffffff : PCI Bus #01
  e0000000-e3ffffff : S3 Inc. 86c368 [Trio 3D/2X]
e8000000-e9ffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
ed000000-ed00007f : 3Com Corporation 3c905C-TX [Fast Etherlink]
ed001000-ed00107f : 3Com Corporation 3c905C-TX [Fast Etherlink] (#3)
ed002000-ed00207f : 3Com Corporation 3c905C-TX [Fast Etherlink] (#2)
ed003000-ed003fff : PCI device 14d2:a003 (Titan Electronics Inc)
ed004000-ed004fff : PCI device 14d2:a003 (Titan Electronics Inc)
ed005000-ed005fff : PCI device 14d2:ffff (Titan Electronics Inc)
ed006000-ed006fff : PCI device 14d2:ffff (Titan Electronics Inc)
ffff0000-ffffffff : reserved

[8.] If you need more information please contact me: alex@pronet.pl.

[9.] I am astonished, nobody found this before...
- -- 
_____________________________________________
| Marcin Prejsnar <alex@pronet.pl>
| PGP key: hkp://wwwkeys.gpg.net/0x96b760e5

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8UBzphW+S5Ja3YOURAud8AJ4zkkQoxB1MVNUbhUpkZaHsYmPMcwCfd75+
f+nY+qZspVPd+EKKXui7WJY=
=qqVJ
-----END PGP SIGNATURE-----
