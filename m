Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277382AbRKMNMb>; Tue, 13 Nov 2001 08:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278770AbRKMNMW>; Tue, 13 Nov 2001 08:12:22 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:42954 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S277382AbRKMNMI>; Tue, 13 Nov 2001 08:12:08 -0500
Message-ID: <3BF11C21.8090809@sap.com>
Date: Tue, 13 Nov 2001 14:12:01 +0100
From: Willi =?ISO-8859-1?Q?N=FC=DFer?= <wilhelm.nuesser@sap.com>
Organization: SAP AG
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Performance tests 2.4.7 SuSE / Red Hat vs. 2.4.14 (pre8)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

on LKML there were many discussions about the performance
of recent kernels. We did some test, too, and perhaps their
outcome is interesting to someone:

we tested in long time runs the performance of distributor
provide kernels based on 2.4.7 vs. the new stock 2.4.14 (pre 8).


1) Test description:
The test suite we use for our QA and stress tests consists of a
so-called "standard SAP SD benchmark". This benchmark tries to emulate a
typical user load on a SAP system. It consists of a benchmark driver
which simulates multiple users logging into the system and starting
transactions which consist of several dialog steps. The relevant
performance quantity is therefore based on the throughput, i.e. dialog
steps per second. More technically speaking the typical work load this
benchmark generates is dominated by m[map, copy], string operations and
integer operations. It has a huge memory footprint / working set
(approx. 2 GB). It tests mainly the CPU performance and the VM
behaviour. Network performance and  disk IO (for the database) are
much less important.

Test hardware:
4 way Dell, 4 GB physical RAM, SCSI/RAID subsystem,
DB runs on FS.

Test setting:
we configured the SAP system for 4GB and measured the dialog steps per
second for a situation where only 1 GB was activated at boot time.
This led to heavy swapping load over several hours to days.
The results were checked several times.

2) Main result:
Dialog steps per second of a typical test series:

	2.4.7			2.4.14
-----------------------------------------
	8.59			15.47
	4.40			14.76
	2.67			11.61
	2.30			14.63
	1.87			14.42
	1.65			15.30	
	1.26			15.02	
	1.68			14.53
	1.17 			15.23
	1.80			12.82
	1.10			14.59
	1.20			16.09
	1.26			14.38
	1.34			15.41


Two aspects seem to be reproduceable:
	1) whereas 2.4.7 shows a significant degradation over time
	2.4.14 remains stable.
	
	2) the asymptotic behaviour of the 2.4.14 based kernel is faster
	than 2.4.7 by a	_factor_ of around _10_. Compared to
	our previous experiences with 2.2 ad 2.4 based this is
	incredible... (OK, I don't want to become enthusiastic :-))


				
3) Details of typical runs:

2.4.7:
------

a)
vmstat 5:

          procs                      memory    swap          io     system
            cpu
        r  b  w   swpd   free   buff  cache  si  so    bi    bo   in
cs  us
        sy  id
        0 18  0 1718772   4692    380   9404  56  45    60    48   43    71
1   0  98
        0 15  1 1725360   5824    384   9384 5102 692  5109   713  410  1155
        2   1  96
        0 13  0 1723960   4824    372   9308 3316 467  3316   478  390   925
        2   2  96
        0 21  1 1719720   5576    368   9320 3973 1162  3978  1197  494 
   887
         3   2  95
        0 21  1 1727092   4732    368   9316 1539 1187  1539  1191  419 
   399
         1   1  98
        0 16  1 1726992   4752    368   9268 4510 951  4517   982  432   956
        4   3  94


b)
Top 10 of /proc/profile:
5785008 default_idle                             90390.7500
        10132 blk_get_queue                            126.6500
         6744 swap_out_pmd                              22.1842
         5839 refill_inactive_scan                      19.2072
         3451 __wake_up                                 17.9740
         9004 __get_swap_page                           13.7256
          402 __free_pages                              12.5625
         1143 __remove_inode_page                       10.2054
          469 add_wait_queue_exclusive                   9.7708
         3398 bounce_end_io_read                         9.2337


c)
meminfo during run:
               total:    used:    free:  shared: buffers:  cached:
Mem:  1051394048 1047044096  4349952 443473920  1052672 294608896
Swap: 4294934528 1314680832 2980253696
MemTotal:      1026752 kB
MemFree:          4248 kB
MemShared:      433080 kB
Buffers:          1028 kB
Cached:          20900 kB
SwapCached:     266804 kB
Active:         694700 kB
Inact_dirty:     19296 kB
Inact_clean:      7816 kB
Inact_target:    12836 kB
HighTotal:      131072 kB
HighFree:         1460 kB
LowTotal:       895680 kB
LowFree:          2788 kB
SwapTotal:     4194272 kB
SwapFree:      2910404 kB
NrSwapPages:    727602 pages


###################################################################

2.4.14:
--------

a) vmstat 5:
          procs                      memory    swap          io     system
            cpu
        r  b  w   swpd   free   buff  cache  si  so    bi    bo   in
cs  us
        sy  id
22  0  3 898668   6248    472 682160 273 108   298   187   67   391  55
         3  42
11  1  5 898696   2676    836 684692 2661 489  2813  1576  564  2570  91
         9   0
21  3  4 899164   5824    512 684520 2863 666  2947  2096  595  2517  77
         9  14
15  2  2 899628   5212    440 683816 3134 658  3260  2023  647  2631  89
         4   7
23  5  4 899796   5284    452 684860 2726 824  2842  2297  641  2552  81
         5  14
16  7  4 899700   6056    400 683916 3250 788  3346  2079  656  2527  89
         5   6



b) /proc/profile:
219002 default_idle                             3421.9062
          604 fget                                       9.4375
          452 system_call                                8.0714
          354 sock_poll                                  7.3750
          488 wake_up_process                            5.0833
         2123 scsi_dispatch_cmd                          4.9144
          230 add_wait_queue_exclusive                   4.7917
          269 mark_page_accessed                         4.2031
           55 RDOUTDOOR                                  3.4375
          197 __generic_copy_to_user                     3.0781

Despite a comparable swapping rate the 2.4.14 runs much more smooth.
One reason could be that the VM has stepped almost completely out of the
way...


c)
meminfo during run:
               total:    used:    free:  shared: buffers:  cached:
Mem:  1052712960 1046528000  6184960        0   319488 856850432
Swap: 4294934528 1313320960 2981613568
MemTotal:      1028040 kB
MemFree:          6040 kB
MemShared:           0 kB
Buffers:           312 kB
Cached:         714576 kB
SwapCached:     122192 kB
Active:         851084 kB
Inactive:       113592 kB
HighTotal:      131072 kB
HighFree:         2044 kB
LowTotal:       896968 kB
LowFree:          3996 kB
SwapTotal:     4194272 kB
SwapFree:      2911732 kB


###########################################################################

4) Our conclusion:

Although we still see some problems with the 2.4.14 based kernel it
looks really promising for us. A _stable_ increase of a factor of
10 in memory critical situations is impressive. Especially since our
customer tend to steer every system finally into this load region ;-)

Great work!


Best regards
	Willi Nuesser
	SAP LinuxLab

PS:
Please CC me, since I'm not on LKML

PPS:
In case you need any further info please mail me. We can put more
detailed data on our ftp server.










