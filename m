Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131062AbQKCSAH>; Fri, 3 Nov 2000 13:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131036AbQKCR7s>; Fri, 3 Nov 2000 12:59:48 -0500
Received: from 64.124.41.10.napster.com ([64.124.41.10]:26374 "EHLO
	foobar.napster.com") by vger.kernel.org with ESMTP
	id <S130525AbQKCR7m>; Fri, 3 Nov 2000 12:59:42 -0500
Message-ID: <3A02FD06.4896579C@napster.com>
Date: Fri, 03 Nov 2000 09:59:34 -0800
From: Jordan Mendelson <jordy@napster.com>
Organization: Napster, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 0-order allocation failed / Fragmentation Bug? (2.4.0-test10)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been receiving these error messages during times of near complete
memory depletion. This particular machine runs a bare minimum of
processes and a our own application which is a threaded long running (1
day, 5:39) which consumes most of the resources on the machine. Oddly
enough however, the mallinfo() for this process shows a discrepancy of
650 megs with ps and top. 

This process handles a large number of TCP connections and does a lot of
dynamic memory allocation, so I assumed the difference was due to memory
fragmentation on our part, however I thought that kswapd would reclaim
memory once it started swapping it out.

Another oddity is the bogomips reported by each CPU are somewhat
different from eachother.

The message being received is:

Nov  3 10:04:30 n175 kernel: __alloc_pages: 0-order allocation failed. 
Nov  3 10:04:30 n175 last message repeated 363 times

The kernel version:

Linux version 2.4.0-test10 (root@stp) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #1 SMP Tue Oct 31 13:13:05 PST 2000


What free reports:

             total       used       free     shared    buffers    
cached
Mem:       1028256    1024172       4084          0        148     
59296
-/+ buffers/cache:     964728      63528
Swap:       136512      75588      60924


ps and top report that the process taking up all this memory has an RSS
of 967656 KB and a VSIZE of 1005892, but mallinfo() on the process shows
a completely different number:

Memory statistics from mallinfo:
Total space allocated from system: 361406208
Number of non-inuse chunks: 1079273
Number of mmapped regions: 0
Total space in mmapped regions: 0
Total allocated space: 235536032
Total non-inuse space: 125870176
Top-most, releasable (via malloc_trim) space: 68776

All memory in this process is allocated via new or malloc (new calls
malloc though) and the numbers mallinfo() and ps report are 99.5%
accurate up until a sort of "slide" period where they diverge fairly
quickly.

$ cat /proc/slabinfo
slabinfo - version: 1.1 (SMP)
kmem_cache            68     68    232    4    4    1 :  252  126
nfs_read_data          0      0    352    0    0    1 :  124   62
nfs_write_data         0      0    384    0    0    1 :  124   62
nfs_page               0      0     96    0    0    1 :  252  126
nfs_fh                80     80     96    2    2    1 :  252  126
tcp_tw_bucket         39     80     96    2    2    1 :  252  126
tcp_bind_bucket       33    452     32    4    4    1 :  252  126
tcp_open_request     403    413     64    7    7    1 :  252  126
inet_peer_cache        1     59     64    1    1    1 :  252  126
ip_fib_hash           11    113     32    1    1    1 :  252  126
ip_dst_cache       15813  23856    160  994  994    1 :  252  126
arp_cache             46     90    128    3    3    1 :  252  126
blkdev_requests      768    800     96   20   20    1 :  252  126
dnotify cache          0      0     20    0    0    1 :  252  126
file lock cache        0      0     92    0    0    1 :  252  126
fasync cache           0      0     16    0    0    1 :  252  126
uid_cache              3    226     32    2    2    1 :  252  126
skbuff_head_cache   2840  12984    160  541  541    1 :  252  126
sock                7757  10310    800 2062 2062    1 :  124   62
inode_cache         7616  11000    384 1100 1100    1 :  124   62
bdev_cache             7    118     64    2    2    1 :  252  126
sigqueue              58     58    132    2    2    1 :  252  126
kiobuf                 0      0    128    0    0    1 :  252  126
dentry_cache        7730  12420    128  414  414    1 :  252  126
filp               11758  11800     96  295  295    1 :  252  126
names_cache            2      2   4096    2    2    1 :   60   30
buffer_head        15200  25520     96  637  638    1 :  252  126
mm_struct             72     72    160    3    3    1 :  252  126
vm_area_struct      1048   1062     64   18   18    1 :  252  126
fs_cache             118    118     64    2    2    1 :  252  126
files_cache           27     27    416    3    3    1 :  124   62
signal_act            24     24   1312    8    8    1 :   60   30
size-131072(DMA)       0      0 131072    0    0   32 :    0    0
size-131072            0      0 131072    0    0   32 :    0    0
size-65536(DMA)        0      0  65536    0    0   16 :    0    0
size-65536             0      0  65536    0    0   16 :    0    0
size-32768(DMA)        0      0  32768    0    0    8 :    0    0
size-32768             0      0  32768    0    0    8 :    0    0
size-16384(DMA)        0      0  16384    0    0    4 :    0    0
size-16384             0      0  16384    0    0    4 :    0    0
size-8192(DMA)         0      0   8192    0    0    2 :    0    0
size-8192              3      3   8192    3    3    2 :    0    0
size-4096(DMA)         0      0   4096    0    0    1 :   60   30
size-4096             12     12   4096   12   12    1 :   60   30
size-2048(DMA)         0      0   2048    0    0    1 :   60   30
size-2048            661   1600   2048  507  800    1 :   60   30
size-1024(DMA)         0      0   1024    0    0    1 :  124   62
size-1024           1258   2096   1024  523  524    1 :  124   62
size-512(DMA)          0      0    512    0    0    1 :  124   62
size-512              90    104    512   12   13    1 :  124   62
size-256(DMA)          0      0    256    0    0    1 :  252  126
size-256             469    615    256   41   41    1 :  252  126
size-128(DMA)          0      0    128    0    0    1 :  252  126
size-128            1423   4170    128  139  139    1 :  252  126
size-64(DMA)           0      0     64    0    0    1 :  252  126
size-64              637   1298     64   22   22    1 :  252  126
size-32(DMA)           0      0     32    0    0    1 :  252  126
size-32             1192   4068     32   36   36    1 :  252  126

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 1
cpu MHz         : 601.000371
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov
pat pse36 mmx fxsr xmm
bogomips        : 1199.31

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 1
cpu MHz         : 601.000371
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov
pat pse36 mmx fxsr xmm
bogomips        : 1202.59

$ cat /proc/interrupts 
           CPU0       CPU1       
  0:    5383441    5395290    IO-APIC-edge  timer
  1:          0          2    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          1          0    IO-APIC-edge  rtc
 13:          0          0          XT-PIC  fpu
 14:          0          4    IO-APIC-edge  ide0
 16:   97170576   97185015   IO-APIC-level  eth0
 19:     220372     221162   IO-APIC-level  aic7xxx
NMI:   10778640   10778640 
LOC:   10778106   10778105 
ERR:          0

$ cat /proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000d17ff : Extension ROM
000f0000-000fffff : System ROM
00100000-3fffcfff : System RAM
  00100000-0027e137 : Kernel code
  0027e138-003151bf : Kernel data
3fffd000-3fffefff : ACPI Tables
3ffff000-3fffffff : ACPI Non-volatile Storage
de800000-df7fffff : PCI Bus #02
  de800000-de8fffff : Intel Corporation 82557 [Ethernet Pro 100] (#2)
  df000000-df0fffff : Intel Corporation 82557 [Ethernet Pro 100]
df800000-dfbfffff : Trident Microsystems 3DIm`age 975
e0000000-e001ffff : Trident Microsystems 3DIm`age 975
e0800000-e0bfffff : Trident Microsystems 3DIm`age 975
e1000000-e1000fff : Adaptec AHA-2940U2/W / 7890
e1f00000-e3efffff : PCI Bus #02
  e2000000-e2000fff : Intel Corporation 82557 [Ethernet Pro 100] (#2)
    e2000000-e2000fff : eepro100
  e3000000-e3000fff : Intel Corporation 82557 [Ethernet Pro 100]
    e3000000-e3000fff : eepro100
e4000000-e7ffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

$ cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  1052934144 1046482944  6451200        0   196608 121032704
Swap: 139788288 134557696  5230592
MemTotal:      1028256 kB
MemFree:          6300 kB
MemShared:           0 kB
Buffers:           192 kB
Cached:         118196 kB
Active:         115828 kB
Inact_dirty:       276 kB
Inact_clean:      2284 kB
Inact_target:     2332 kB
HighTotal:      131060 kB
HighFree:         4232 kB
LowTotal:       897196 kB
LowFree:          2068 kB
SwapTotal:      136512 kB
SwapFree:         5108 kB


Just for laughs, here is the status file for the long running process:
$ cat /proc/410/status
Name:   napd
State:  R (running)
Pid:    410
PPid:   409
TracerPid:      0
Uid:    150     150     150     150
Gid:    150     150     150     150
FDSize: 16384
Groups: 
VmSize:  1005892 kB
VmLck:         0 kB
VmRSS:    978924 kB
VmData:   999880 kB
VmStk:        32 kB
VmExe:      4760 kB
VmLib:      1056 kB
SigPnd: 0000000000000000
SigBlk: 0000000080000000
SigIgn: 8000000000081004
SigCgt: 0000000380014002
CapInh: 0000000000000000
CapPrm: 0000000000000000
CapEff: 0000000000000000


Any help would be greatly appreciated.

Jordan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
