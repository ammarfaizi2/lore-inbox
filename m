Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281029AbRKTVjR>; Tue, 20 Nov 2001 16:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280998AbRKTVjI>; Tue, 20 Nov 2001 16:39:08 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:36998 "EHLO
	lazy.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S281016AbRKTVjB>; Tue, 20 Nov 2001 16:39:01 -0500
Date: Tue, 20 Nov 2001 15:27:24 -0600 (CST)
From: Manoj Iyer <manjo@austin.ibm.com>
X-X-Sender: <manjo@lazy>
To: kernelmailinglist <linux-kernel@vger.kernel.org>
Subject: OOM killer very aggressive on 2.4.15.pre7
Message-ID: <Pine.LNX.4.33.0111201456490.18484-100000@lazy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am running my memory management tests (ltp.sf.net under
testcases/kernel/mem/...) on linux-2.4.15.pre7i, trying to stress it. I
notice that the OOM killer is very aggressively killing my processes.

The tests can be found on ltp web site, ltp.sf.net, under
.../testcases/kernel/mem/... and
.../testcases/kernel/network/nfs/nfsstress/...

I try to stress VMM by doing the following.

1) mmap a file of size = sizeof(char) * 1000000000; as shared and private
mapping.

2) mmap the same size as anonymous memory, private and shared.

3) mmap a file of same size shared.

4) memory race conditions tests.

5) spawn 30 threads, each thread mallocs memory in a loop size is either
powers of 2,3,or 7 or size = numbers in fibbanoci series. (see source
mallocstress.c for details on ltp.sf.net)

6) Also I am generating a lot of disk I/O and compiles (invoking cc) by
running my make_tree (NFS client) test over NFS. (details about the test
available in the source
.../testcases/kernel/network/nfs/nfsstress/make_tree.c.)

machine configuration is:
kernel:         2.4.15.pre7(SMP)
Total Memory:   9GB
Total Swap:     5GB
HDD:            14GB
CPU:            2 way, pentium III coppermine
Himem:          set to 4GB

I did not notice such aggrasivness in the OOM killer when I was running
the same on linux-2.4.15.pre6. The results of that test are available
towards the end. The tests that do the mmap's were being killed most
often, even if I restart them (now it becomes the most recently used) it
still gets killed. I was running the same number of test on 2.4.15.pre6
and OOM was not this aggressive.

When I try to restart the mmap tests, mmap() compilains out of memory, and
is eventually killed.  The machine memory statistics that instant are as
follows (reported by top refreshing every 2 sec).

Mem:   1029356K total,  1023836K used,     5520K free,      232K buffers
Swap:   538136K total,   511432K used,    26704K free,   927712K cached

I have now overloaded the machine by running the mmap tests in a infinite
while loop. So that it will restart if killed by the OOM killer. Also,
assuming that I will bring the swap free to zero, I did succede in
bringing swap free to zero, and the VMM did a good job by killing some
processes and keep the machine running. This is a major improvement over
2.4.13 where the machine would just hang (do nothing!).

I will let these tests run for 24hrs and I will post my test results
tomorrow(11/21/2001). If someone has any suggestion or require some
different statisitcs from these tests please email me so that I can post
that too.  My email at work is manjo@austin.ibm.com and that at home is
manjo@austin.rr.com.

The results of VMM tests on 2.4.15.pre6 on SMP is as follows.

Kernel:                 2.4.15.pre6 (SMP)
Total mem:              9GB
Total Swap:             5GB
Total CPU:              2 way, (Pentium III coppermine)
Total exec time:        24Hrs


CPU utilization
~~~~~~~~~~~~~~~
09:11:22          CPU     %user     %nice   %system     %idle
Average:            0     16.66      0.00     59.60     23.74
Average:            1     16.40      0.00     59.89     23.71
average:          all     16.53      0.00     59.74     23.73

I/O  and transfer rate statistics
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
09:11:22          tps      rtps      wtps   bread/s   bwrtn/s
Average:        92.74     50.96     41.78   2814.52  12581.92

paging statistics.
~~~~~~~~~~~~~~~~~~
09:11:22     pgpgin/s pgpgout/s  activepg  inadtypg  inaclnpg  inatarpg
Average:      1407.26   6290.88     34395         0         0         0

process creation activity.
~~~~~~~~~~~~~~~~~~~~~~~~~~
09:11:22       proc/s
Average:        17.09

activity for each block device
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
09:11:22          DEV       tps    blks/s
Average:       dev8-0     92.74  15396.44


queue length and load averages
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
09:11:22      runq-sz  plist-sz   ldavg-1   ldavg-5
Average:           24       556     41.30     41.21

memory  and  swap space utilization statiscs
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
09:11:22    kbmemfree kbmemused  %memused kbmemshrd kbbuffers  kbcached
kbswpfree kbswpused  %swpused
Average:       121312    779068     86.53         0      9278    403342
305511    232625     43.23

memory statistics.
~~~~~~~~~~~~~~~~~~
09:11:22      frmpg/s   shmpg/s   bufpg/s   campg/s
Average:         2.42      0.00      0.05     -1.35

system switching activity.
~~~~~~~~~~~~~~~~~~~~~~~~~~
09:11:22      cswch/s
Average:     52151.52o

swapping  statistics
~~~~~~~~~~~~~~~~~~~~
09:11:22     pswpin/s pswpout/s
Average:        12.72    842.88

ksymoops -m /boot/System.map-2.4.15-pre6 /var/log/messages /var/log/kern.log
/var/log/syslog

ksymoops 2.4.3 on i686 2.4.15-pre6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.15-pre6/ (default)
     -m /boot/System.map-2.4.15-pre6 (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Nov 19 10:40:46 corvette kernel: WARNING: MP table in the EBDA can be UNSAFE,
contact linux-smp@vger.kernel.org if you experience SMP problems!
Nov 19 10:40:46 corvette kernel: cpu: 0, clocks: 1332704, slice: 444234
Nov 19 10:40:46 corvette kernel: cpu: 1, clocks: 1332704, slice: 444234
Nov 19 10:40:47 corvette kernel: ds: no socket drivers loaded!
Nov 19 10:40:46 corvette kernel: WARNING: MP table in the EBDA can be UNSAFE,
contact linux-smp@vger.kernel.org if you experience SMP problems!
Nov 19 10:40:46 corvette kernel: cpu: 0, clocks: 1332704, slice: 444234
Nov 19 10:40:46 corvette kernel: cpu: 1, clocks: 1332704, slice: 444234
Nov 19 10:40:47 corvette kernel: ds: no socket drivers loaded!

1 warning issued.  Results may not be reliable.


Nov 19 10:40:46 corvette kernel: Warning only 896MB will be used.
Nov 19 10:40:46 corvette kernel: Use a HIGHMEM enabled kernel.
Nov 19 10:40:46 corvette kernel: found SMP MP-table at 0009e1d0
Nov 19 10:40:46 corvette kernel: hm, page 0009e000 reserved twice.
Nov 19 10:40:46 corvette kernel: hm, page 0009f000 reserved twice.
Nov 19 10:40:46 corvette kernel: hm, page 0009e000 reserved twice.
co
ntact linux-smp@vger.kernel.org if you experience SMP problems!
Nov 19 10:40:46 corvette kernel: On node 0 totalpages: 229376
Nov 19 10:40:46 corvette kernel: zone(0): 4096 pages.
Nov 19 10:40:46 corvette kernel: zone(1): 225280 pages.
Nov 19 10:40:46 corvette kernel: zone(2): 0 pages.
Nov 19 10:40:46 corvette kernel: Intel MultiProcessor Specification v1.4
Nov 19 10:40:46 corvette kernel:     Virtual Wire compatibility mode.
Nov 19 10:40:46 corvette kernel: OEM ID: IBM ENSW Product ID: NF 6000R SMP APIC
at: 0xFEE00000

Thanks
Manoj Iyer

*******************************************************************************
Linux Test Project WEB:ltp.sf.net
IBM, Austin TX.
email: manjo@austin.ibm.com
Phone: 512 838 4064
*******************************************************************************

