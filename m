Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286975AbRL1SWW>; Fri, 28 Dec 2001 13:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286973AbRL1SWL>; Fri, 28 Dec 2001 13:22:11 -0500
Received: from synapse.t30.physik.tu-muenchen.de ([129.187.186.221]:61323 "EHLO
	synapse.t30.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S286971AbRL1SV5>; Fri, 28 Dec 2001 13:21:57 -0500
To: linux-kernel@vger.kernel.org
Subject: long latencies when writing to DVD-RAM, kernel 2.4.17
Content-Type: text/plain; charset=US-ASCII
From: Moritz Franosch <jfranosc@physik.tu-muenchen.de>
Date: 28 Dec 2001 19:21:55 +0100
Message-ID: <rxxn103tdbw.fsf@synapse.t30.physik.tu-muenchen.de>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

There have been latencies of up to about ten seconds (no screen
refresh under X, no mouse movement) during writing large files (size
larger than RAM) to DVD-RAM under kernel 2.4.13 (also reported in
http://groups.google.com/groups?hl=en&selm=fa.dqbjqmv.1eh8lob%40ifi.uio.no
for kernel 2.4.0). These long latencies have gone with 2.4.17,
interactive work is now possible during writing to DVD-RAM on my
system. Excellent!

A performance problem still remains, however. Copying a large file
from HDD to DVD-RAM almost completely blocks a concurrent compilation
('make') process (which reads its input files from HDD, of course). To
illustrate the problem, here is an extract of 'vmstat 1' output. It's
continuous, I only copied the headers. Periods with almost no CPU
usage (and so no progress of the compilation process) alternate with
periods of high CPU and HDD usage. I consider this to be a performance
bug because the compilation process should be able to read (at least
some) data from HDD while data is written to DVD-RAM. Periods with low
CPU usage take much longer than those with high CPU usage.

# period with low CPU usage, high data rate written to DVD-RAM and
# no data read from HDD
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  3  2  31076   4488   5256 187248   0   0     0  3950  111   123   0   0 100
 0  3  2  31076   4488   5256 187248   0   0     0     0  105   121   0   0 100
 0  3  2  31076   4484   5256 187252   0   0     0    64  116   122   0   0 100
 0  3  2  31076   4484   5256 187252   0   0     0  3872  111   122   0   0 100
 0  3  2  31076   4484   5256 187252   0   0     0     0  113   123   0   0 100
 0  3  2  31076   4484   5256 187252   0   0     0     0  111   118   0   1  99
 0  3  2  31076   4484   5256 187252   0   0     0  4118  111   126   0   1  99
 1  3  2  31076   4484   5256 187252   0   0     0   128  112   126   0   0 100
 0  3  2  31076   4484   5256 187252   0   0     0     0  111   120   0   0 100
 1  3  2  31076   4484   5256 187252   0   0     0  4080  113   127   0   1  99
 1  3  2  31076   4484   5256 187252   0   0     0     0  114   297   1   0  99
 1  3  2  31076   4476   5256 187256   0   0     0    64  111   414   5   0  95
 0  3  2  31076   4472   5256 187256   0   0     0     0  106   700   6   1  93
 0  3  2  31076   4472   5256 187256   0   0     0     0  106   130   0   0 100
 2  2  2  31076   4460   5272 187300   0   0  4868  4028  207   370   0   9  91
 0  3  2  31076   4424   5308 187304   0   0  8712     0  251   546   1  14  85
 0  3  2  31076   4568   5320 187140   0   0  4998     0  196   371   0   9  91
# period with high CPU usage, almost no data written to DVD-RAM and 
# high data rate from HDD
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 2  1  2  31076  11160   5352 186992   0   0    52   124  123   195  89   5   6
 3  1  2  31076  12336   5352 187092   0   0    12     0  117   153  98   2   0
 3  0  2  31076   7732   5352 187440   0   0   128     0  111   135  96   4   0
 2  1  0  31460   7692   5324 193016   0  68  6932    68  221   404  85  15   0
 3  0  0  31516   4432   5352 194652   0 444  7180   444  227   468  87  13   0
 3  0  0  31516   4380   5380 190024   0   0  6668     0  208   522  91   9   0
 2  1  0  31516   6236   5428 193832   0   0  6572     0  211   436  88  12   0
 1  2  0  31516   4452   5452 195776   0   0  4834     0  192   380  73  13  14
 3  0  0  31516   4368   5528 188876   0   0  6032    96  212   531  87  13   0
 1  2  0  31516  10304   5468 188020   0   0  7436     0  219   512  83  17   0
 3  0  0  31516   4356   5496 193052   0   0  6164     0  205   407  81  16   3
 2  1  1  31516   4296   5488 188276   0   0  8584     0  233   571  91   9   0
 3  0  0  31516   4856   5516 195472   0   0  6054     0  205   363  84  16   0
 2  1  0  31516   4404   5500 189176   0   0  5764   104  204   494  89  11   0
 2  1  0  31876   5180   5404 191620   0 332  6160   344  221   422  87  13   0
 1  2  1  32016   4408   5432 194108   0 236  6064  8036  229   399  85  15   0
# a period with low CPU usage starts again
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  3  1  32016   4488   5436 193828   0   0     8  1386  128   137   6   1  93
 0  3  1  32016   4488   5436 193828   0   0     0  3924  111   124   0   1  99
 0  3  2  32016   4436   5488 193828   0   0     0   928  122   132   0   1  99
 0  3  1  32016   4564   5488 193700   0   0     0     0  109   126   0   0 100
 0  3  1  32016   4560   5488 193704   0   0     0    64  110   122   0   0 100
 0  3  1  32016   4560   5488 193704   0   0     0     0  109   121   0   0 100
 0  3  1  32016   4568   5492 193692   0   0   128  4082  116   136   0   3  97
 1  3  1  32016   4568   5492 193692   0   0     0     0  116   127   0   0 100
 0  3  2  32016   4536   5520 193692   0   0     0   554  118   130   0   0 100
 2  1  2  32016   8440   5532 193260   0   0  2820   162  156   268  32   5  63
 1  2  2  32016   4384   5496 192272   0   0  4496  5356  193   372  87  13   0
 0  3  2  32016   4364   5496 191840   0   0     0  1260  112   133  71   0  29

The ATAPI DVD-RAM in on /dev/hdc, the HDD is on /dev/hda, so they
should be completely independent and processes should be able to
read/write to HDD and read/write to DVD-RAM at the same
time. Apparently, this is unfortunately not the case.


What's the reason for this misbehaviour of the kernel and what can be
done against it?


Thank you in advance,

Moritz



Here is some data of my system:

My system is SuSE 7.1.

Kernel is an original 2.4.17. (I have also
tried the preemptive kernel patch 'preempt-kernel-rml-2.4.17-1.patch'
but neither improves latencies of 2.4.13 nor does it improve the
behaviour of 2.4.17 described above.)

cat /proc/version
Linux version 2.4.17 (root@nomad) (gcc version 2.95.2 19991024 (release)) #1 Thu Dec 27 20:35:47 CET 2001

lsmod
Module                  Size  Used by
nls_iso8859-1           2880   0 (autoclean)
nls_cp437               4384   0 (autoclean)
ide-floppy             11360   0 (autoclean)
tuner                   8160   1 (autoclean)
tvaudio                 9840   0 (autoclean) (unused)
msp3400                14160   1 (autoclean)
bttv                   60624   0 (autoclean)
i2c-algo-bit            7168   1 (autoclean) [bttv]
i2c-core               12944   0 (autoclean) [tuner tvaudio msp3400 bttv i2c-algo-bit]
videodev                4640   3 (autoclean) [bttv]
vfat                    9520   0 (autoclean)
fat                    29728   0 (autoclean) [vfat]
ide-cd                 26672   1 (autoclean)
cdrom                  28928   0 (autoclean) [ide-cd]
es1371                 27072   1 (autoclean)
soundcore               3568   4 (autoclean) [es1371]
ac97_codec              9680   0 (autoclean) [es1371]
mga                   103456   1
agpgart                26320   1 (autoclean)
autofs4                 8576   2 (autoclean)
ne2k-pci                5056   1 (autoclean)
8390                    6032   0 (autoclean) [ne2k-pci]
apm                     9168   1

mount
/dev/hda3 on / type reiserfs (rw,noatime)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,mode=0620,gid=5)
/dev/hda1 on /boot type ext2 (rw,noatime)
/dev/hda6 on /home type ext2 (rw,noatime)
/dev/hda7 on /lscratch type reiserfs (rw,noatime)
shmfs on /dev/shm type shm (rw)
automount(pid332) on /net type autofs (rw,fd=5,pgrp=332,minproto=2,maxproto=4)
automount(pid330) on /misc type autofs (rw,fd=5,pgrp=330,minproto=2,maxproto=4)
/dev/hdc on /dvd type ext2 (rw,noexec,nosuid,nodev,user=jfranosc)

cat /proc/ide/ide1/hdc/driver
ide-cdrom version 4.59

cat /proc/ide/ide1/hdc/model
TOSHIBA DVD-RAM SD-W2002

cat /proc/ide/ide1/hdc/capacity
8946816

cat /proc/ide/ide1/hdc/settings
name                    value           min             max             mode
----                    -----           ---             ---             ----
breada_readahead        4               0               127             rw
current_speed           34              0               69              rw
dsc_overlap             0               0               1               rw
file_readahead          0               0               2097151         rw
ide_scsi                0               0               1               rw
init_speed              12              0               69              rw
io_32bit                1               0               3               rw
keepsettings            0               0               1               rw
max_kb_per_request      127             1               127             rw
nice1                   1               0               1               rw
number                  2               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               1               0               1               rw
using_dma               1               0               1               rw
