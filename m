Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWJMN4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWJMN4c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 09:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWJMN4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 09:56:32 -0400
Received: from mail.daysofwonder.com ([213.186.49.53]:43483 "EHLO
	mail.daysofwonder.com") by vger.kernel.org with ESMTP
	id S1750824AbWJMN4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 09:56:31 -0400
Subject: Sluggish system while copying large files.
From: Brice Figureau <brice+lklm@daysofwonder.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 13 Oct 2006 15:56:14 +0200
Message-Id: <1160747774.7929.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a brand new Dell 2850 biXeon x86_64 with a Perc4e/Di (megaraid)
RAID card with two hardware RAID1 volumes (sda and sdb, ext3 on top of
LVM2, io scheduler deadline).

This machine runs 2.6.18 and is used as a mysql server.

Whenever I cp large files (for instance during backup) from one volume
to the other, the system becomes really sluggish. 
Typing a simple ls on an ssh connection to this host takes almost two to
three secs to print something. 
Even sometimes top stops displaying stats for a few secs.
Mysql isn't able to serve request during this time, and request are
piling until the copy is finished.

Unfortunately the server is live and I don't have the possibility to
test old or new kernels easily, so I don't have a baseline to compare
with.

swappiness is at 20, kernel compiled without preemption, but with
SMP/SMT enabled.

Mysql data is on sdb. The copy takes place from sdb to sda.

Here are some relevant information taken during the copy:

db1:~# cat /proc/meminfo  
MemTotal:      4052008 kB
MemFree:         30208 kB
Buffers:         13664 kB
Cached:         803040 kB
SwapCached:     245152 kB
Active:        3143372 kB
Inactive:       802852 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      4052008 kB
LowFree:         30208 kB
SwapTotal:    11863960 kB
SwapFree:     11359080 kB
Dirty:           15772 kB
Writeback:           0 kB
AnonPages:     3129008 kB
Mapped:          11108 kB
Slab:            44708 kB
PageTables:       8736 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:  13889964 kB
Committed_AS:  4183960 kB
VmallocTotal: 34359738367 kB
VmallocUsed:    268688 kB
VmallocChunk: 34359469319 kB
HugePages_Total:     0
HugePages_Free:      0
HugePages_Rsvd:      0
Hugepagesize:     2048 kB

db1:~# cat /proc/interrupts 
           CPU0       CPU1       CPU2       CPU3       
  0:        150          0          0   61882665    IO-APIC-edge  timer
  1:          0          0          0          8    IO-APIC-edge  i8042
  4:          0          0          0        362    IO-APIC-edge  serial
  6:          0          0          0          3    IO-APIC-edge  floppy
  8:          0          0          0          1    IO-APIC-edge  rtc
  9:          0          0          0          0   IO-APIC-level  acpi
 14:          0          0          0         75    IO-APIC-edge  ide0
169:          0          0          0          0   IO-APIC-level  uhci_hcd:usb1
177:          0          0          0     735551   IO-APIC-level  eth0
185:          0          0          0   16999043   IO-APIC-level  eth1
193:          0          0          0         28   IO-APIC-level  uhci_hcd:usb2
201:          0          0          0          0   IO-APIC-level  uhci_hcd:usb3
209:          0          0          0         22   IO-APIC-level  ehci_hcd:usb4
217:          0          0          0    8656182   IO-APIC-level  megaraid
NMI:       9978      18363       9809      18240 
LOC:   61877495   61866269   61877207   61868972 
ERR:          0
MIS:          0

vmstat -n 1 while copying:
procs -----------memory---------- ---swap-- -----io---- -system------cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa
 0  0 504880 509336  69504 271556    0    0     4   196  433  814  0  0 99  0
 0  1 504880 412668  69804 368132    0    0 48520   120 1265 2019  0  5 78 16
 1  1 504880 235472  70140 543320    0    0 87740   216 1879 2435  7 10 69 15
 1  0 504880  23412  70300 750176    0    0 136588   148 2603 3225  6 16 68 10
 1  0 504880  41176  33440 765444    0    0 101492   260 2027 2461  1 17 70 13
 0  3 504880  24404   4772 809288    0    0 58784 24152 1912 2022  0 12 68 19
 0  5 504880  36192   4640 794000    0    0 67912 53632 2150 1799  0 14 32 53
 0  5 504880  41744   4584 787236    0    0 22040 38972 1241  983  0  5 30 66
 0  5 504880  33456   4604 795348    0    0  4104 40628 1001  729  0  2 49 50
 0  5 504880  33456   4612 795340    0    0     4 43040  927  611  0  3 54 44
 0  6 504880  29868   4576 798700    0    0  8460 42808 1065  748  0  3 50 47
 0  6 504880  25852   4576 802108    0    0 12300 37004 1063  784  0  4 50 46
 0  6 504880  31260   4424 796604    0    0 14352 41088 1135  833  0  3 50 46
 0  5 504880  24052   4428 803640    0    0  3460 36748  962  795  0  1 50 49
 0  6 504880  24052   4436 803524    0    0     0 42496  972  664  0  3 48 49
 1  4 504880  35300   4280 798068    0    0 32544 39240 1410 1085  0 11 49 41
 1  6 504880  25884   4532 808996   32    0 17980 42876 1918 2977  5  5 55 35
 0  7 504880  26784   4304 806756    0    0 68740 39524 1965 1674  0 15 9 76
 0  7 504880  24164   4408 808460    0    0 15708 32676 1226 1205  3  4 13 81
 0  7 504880  25540   4540 806784    0    0 20540 43272 1376 1167  0  6 7 86
 0  4 504880  24636   4636 811356    0    0 10896 36008 1165 1063  0  4 17 78
 2  3 504880  43108   4620 791676    0    0 75504 35788 2076 1883  0 17 54 28
 0  3 504880  24412   4556 809596    0    0 41004 33672 1456 1175  0  8 64 27
 0  6 504880  28756   4400 806056    0    0 44020 36488 1589 1360  0 10 61 29
 0  6 504880  25272   4464 809416    0    0  9240 40960 1066  830  0  4 19 76
 5  4 504880  26124   4900 809312    0    0    20 19872 1344 2504 10  3 25 62
 2  3 504880  24128   5068 814156    0    0 14864 46408 1676 3055 49  6 23 22
 2  8 504880  21328   3880 818300    0    0 27036 34980 1354 1187 13  5 19 63
 2  8 504880  23456   3300 816272    0    0 33880 32116 1434 1339 10  7 19 63
 2  3 504880  31348   3424 809504    0    0 44204 25268 1747 1769  0 11 37 51
 1  2 504880  35344   3480 803892    0    0 84696 29408 2233 1999  1 18 49 34
 1  2 504880  23860   3488 813700    0    0 60612 46272 2137 1792  3 13 64 20
 1  8 504880  21396   3504 815764    0    0  4616 30816  849  743  0  2 55 42
 1  9 504880  25992   3572 812360    0    0 22752 37048 1349 1182 10  6 16 68
 1  9 504880  30948   3156 807160    0    0 52360 38976 1773 1501  1 12 15 72
 0  8 504880  25288   3220 812248    0    0 38836 32672 1452 1199  8  9 5 79
 1  3 504880  35720   3400 805028    0    0 21776 32780 1338 1971  1  7 27 65
 3  3 504880  26620   3272 811220    0    0 101168 27848 2542 2096  0 19 50 31
 1  8 504880  21440   3344 814744    0    0 15388 36924  995  925  0  4 50 46
 1 13 504880  21348   3320 814780    0    0 40228 40680 1560 1194  0  9 16 75
 1 11 504880  27968   3328 807932    0    0 10480 43076 1121  896  0  3 0 97
 1 11 504880  27968   3328 807948    0    0     0 41088  892  669  0  1 0 99
 1 11 504880  27936   3328 807992    0    0     0 38912  893  668  0  1 0 99
 1  5 504880  31648   3352 807964    4    0     8 25692  803  934  0  2 15 83
 1  3 504880  32144   3368 807976    0    0     8 38976  827  641  0  3 74 24
 1  3 504880  33880   3384 807940   20    0    20 17116  688  591  0  2 71 27
 6  1 504880  28804   4032 807976   52    0   136  4116 1563 12519 67  3 27  3
 0  0 504880  32400   4240 807992    0    0   136  1544  635 5984 84  3 13  0
 3  0 504880  32292   4364 808104    0    0    28   268  538 1872 33  1 65  1
 1  0 504880  31672   4468 808012    0    0     4   880  708 1042  8  2 87  3
 1  0 504880  31672   4576 808036    0    0    20   264  485  919  0  0 99  0
 1  0 504880  31796   4632 808200    0    0     0   148  399  744  1  0 99  0

iostat -x 3 sda sdb while copying:
avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.37    0.00    0.69    0.44    0.00   98.50

Device:         rrqm/s   wrqm/s   r/s   w/s   rsec/s   wsec/s avgrq-sz avgqu-sz   await  svctm  %util
sda               0.00     9.00  0.00 22.75     0.00   254.00    11.16     0.02    0.88   0.88   2.00
sdb               0.00     3.25  0.50 39.50     4.00  2978.00    74.55     0.04    1.10   0.70   2.80

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.38    0.00    3.81    6.69    0.00   89.12

Device:         rrqm/s   wrqm/s   r/s   w/s   rsec/s   wsec/s avgrq-sz avgqu-sz   await  svctm  %util
sda               1.75     9.75  0.50 20.00    18.00   238.00    12.49     0.02    1.17   1.17   2.40
sdb             140.00     9.25 524.25  8.75 58090.00   144.00   109.26     0.78    1.46   0.73  39.10

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           3.44    0.00   14.97   20.10    0.00   61.49

Device:         rrqm/s   wrqm/s   r/s   w/s   rsec/s   wsec/s avgrq-sz avgqu-sz   await  svctm  %util
sda               0.00  3683.29  1.00 268.08     7.98 27429.43   101.97    24.05   54.68   0.93  25.04
sdb             363.59    15.21 1514.96 31.92 187882.29  1981.05   122.74     2.67    1.73   0.64  98.25

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.06    0.00    3.19   53.09    0.00   43.66

Device:         rrqm/s   wrqm/s   r/s   w/s   rsec/s   wsec/s avgrq-sz avgqu-sz   await  svctm  %util
sda               0.00  9462.25  0.75 639.00     6.00 81216.00   126.96   144.09  225.13   1.56 100.10
sdb              33.75     2.00 148.25  3.75 18646.00    46.00   122.97     0.45    2.93   1.01  15.40

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.06    0.00    3.00   47.03    0.00   49.91

Device:         rrqm/s   wrqm/s   r/s   w/s   rsec/s   wsec/s avgrq-sz avgqu-sz   await  svctm  %util
sda               0.00  9196.26  0.00 618.95     0.00 78348.13   126.58   144.20  232.65   1.61  99.85
sdb              29.93     0.00 140.40  0.25 17731.67     2.00   126.09     0.32    2.26   0.75  10.57

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           1.94    0.00    8.87   56.53    0.00   32.67

Device:         rrqm/s   wrqm/s   r/s   w/s   rsec/s   wsec/s avgrq-sz avgqu-sz   await  svctm  %util
sda               1.74  8750.75  1.00 615.67    21.89 74993.03   121.65   125.90  207.92   1.62  99.60
sdb             133.83     2.74 513.43 48.01 62857.71  2648.76   116.68     1.73    3.09   0.99  55.32

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.25    0.00    9.31   58.81    0.00   31.62

Device:         rrqm/s   wrqm/s   r/s   w/s   rsec/s   wsec/s avgrq-sz avgqu-sz   await  svctm  %util
sda               0.00  8919.00  0.50 616.25     4.00 75618.00   122.61   129.00  205.81   1.62 100.10
sdb             157.50     8.00 642.50  5.25 78260.00   106.00   120.98     1.57    2.43   0.93  60.30

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          10.83    0.00    5.07   47.28    0.00   36.82

Device:         rrqm/s   wrqm/s   r/s   w/s   rsec/s   wsec/s avgrq-sz avgqu-sz   await  svctm  %util
sda               0.00  6166.17  1.75 504.76    14.04 57940.85   114.42   112.78  241.21   1.93  97.54
sdb              71.18     7.02 259.40 47.62 30676.69  2007.02   106.46     0.72    2.35   0.97  29.67

loadavg while copying is about 2.50
The nr_request and readahead are at default values.

During the copy it is as if mysql wasn't even able to touch the sdb.

As you can see the disk are used at almost 100% while writing, which
seems good, but this doesn't explain the slugginess. 
I first thought the server was swapping but it doesn't seem.

Using the anticipatory or cfq ioscheduler seems to mitigate a little bit
(at least it is a little bit less sluggish), but it is still not normal
behavior.

So now, to the question: what should I do to lower the impact of this
copy operation?

I don't mind the copy to last twice longer, as long as I'm sure mysql
can run during this time to serve requests...

As I'm not subscribed to the list, please CC: me on replies.

Many thanks for any idea on how to solve this issue,
-- 
Brice Figureau <brice+lklm@daysofwonder.com>

