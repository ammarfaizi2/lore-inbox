Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262152AbSJ2ULH>; Tue, 29 Oct 2002 15:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262325AbSJ2ULH>; Tue, 29 Oct 2002 15:11:07 -0500
Received: from h24-82-72-95.vf.shawcable.net ([24.82.72.95]:20161 "EHLO
	grue.userfriendly.org") by vger.kernel.org with ESMTP
	id <S262152AbSJ2ULF> convert rfc822-to-8bit; Tue, 29 Oct 2002 15:11:05 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Jay Thorne <yohimbe@userfriendly.org>
Organization: Userfriendly Media Inc
To: linux-kernel@vger.kernel.org
Subject: CPU usage abnormal in 2.4.17+
Date: Tue, 29 Oct 2002 12:17:25 -0800
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210291217.25893.yohimbe@userfriendly.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've a machine, running a rather common load. Webserver, running apache / mod_perl,
middling CPU usage, database traffic, etc. Usage is average 80kbytes/sec all day, 
peaks are at 200kbytes/second. Distro is rh 7.2, running the newest kernel, but I've tried
2.4.20-pre9 and 2.4.17.

What's not common is this:

Constantly, every 270 seconds, the cpu usage 'pins the needle', 
the runqueue gets to 50 or more processes, the number of context switches goes 
much higher than normal. During these burps, process launch appears stalled, but shell 
interactive responsiveness stays normal and ping times do not change. My load graphs look
like near perfect sawtooth waves. Load spikes go up to 40 or more, then steady down to 3.5

The actual web traffic load on the machine is quite predictable, and varies slowly over the day, 
not every 4 1/2 minutes.
Its got lots of ram, I think, and most of the time, its not all that heavily loaded, since it 
averages at least 20% idle during the non-burp times. 

This is regardless of load. Our traffic peaks in the morning and this behaviour is constant 
all day. I've limited the process count, done the usual tuning things, added ram, etc.
I booted with profile=2 and have some details to follow. We have machines running 
the same kernel with much heavier net traffic that are running less cpu bound, just 
serving static content. They show no such burps.

CPU is p4/1.6G 768M DDR ram. Disks are IDE. Net cards are eepro100. Turning off disk write 
traffic is impossible, but I was able to switch between the two IDE 
channels/different HDs to no avail. Its not got all that heavy of write traffic anyway. 
vmstat shows context switches going crazy during the "burp" and readprofile shows lots of 
calls to statm_pgd_range and system_call.

Since the system time is only 6% during these burps it doesn't appear to be some
kind of locking thing, the machine is uniprocessor anyway, and that time could just be 
scheduler time for all the context switches. Stracing the processes give no clues, as
they have identical traces in non-burp times. As is typical in current apache, there is signal
traffic (SIGALRM) between the parent and the children once a second, but nothing unusual during the
overload time.

Any advice on what to look at next?

Stats follow.
--

Linux arsozah 2.4.18-17.7.x #1 Tue Oct 8 13:33:14 EDT 2002 i686 unknown
[root@arsozah linux-2.4]# cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  790011904 766226432 23785472        0 27586560 246759424
Swap: 1077501952 74747904 1002754048
MemTotal:       771496 kB
MemFree:         23228 kB
MemShared:           0 kB
Buffers:         26940 kB
Cached:         211180 kB
SwapCached:      29796 kB
Active:         454916 kB
Inact_dirty:    167372 kB
Inact_clean:     93232 kB
Inact_target:   143104 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       771496 kB
LowFree:         23228 kB
SwapTotal:     1052248 kB
SwapFree:       979252 kB
Committed_AS:  1195052 kB

vmstat 5
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  0  82436  11460  22828 209496  72   0    76    86  738   670  64   3  33
 9  0  0  82436  11460  22860 209592   0   0     6    80  839   523  67   2  31
32  0  0  82436  11460  22912 209684   0   0     3   329  848   617  88   3   9
 8  0  0  82436  11460  22928 209796   0   0     2    79  776   698  76   2  22
19  0  0  82436  11460  22968 209884   0   0     6   182  724  2097  85   4  11
43  0  0  82436  10400  23028 209916 128   0   130   206  713  3333  94   6   0
64  2  2  82436   9320  23036 209952   1   0     2    30  632  3821  93   7   0
64  1  1  82436   7460  23068 210044   3   0    10    65  668  3239  95   5   0
62  0  1  82436   7036  23092 208256   2   0     7    74  776  2231  95   5   0
54  0  1  81028  12272  23068 207772 104   0   105   136  688  2591  95   5   0
31  0  1  81028   8292  23100 207936   1   0     2   242  801   913  97   3   0
55  0  1  81028   8288  23120 207984  12   0    12    73  896  1122  97   3   0
12  0  1  80532  11892  23164 208204  62   0    66   120  821  1680  97   3   0
19  0  1  80532  11892  23192 208300   0   0     3    96  776   814  77   3  20
 0  0  0  80532  11892  23296 208416   0   0     6   554  794  1243  81   3  16
 1  0  0  80532  11664  23344 208504   1   0     5    89  763   706  73   2  25
 0  0  0  80532  11448  23432 208600   0   0     9   482  715  1886  78   3  20

[root@arsozah linux-2.4]# readprofile -m /boot/System.map |sort -n |tail -30
  5201 proc_pid_statm                            14.1332
  5803 do_rw_disk                                 3.9856
  5841 sock_read                                 36.5063
  5872 setscheduler                               7.8085
  5903 sys_write                                 24.5958
  5965 unix_stream_data_wait                     24.8542
  6482 alloc_skb                                 15.5817
  6556 do_softirq                                45.5278
  6840 kfree                                     38.8636
  6912 generic_file_write                         3.5410
  8949 sys_rt_sigprocmask                        19.2866
  9555 do_gettimeofday                           74.6484
  9572 device_not_available                     199.4167
  9872 unix_stream_sendmsg                       14.3488
 10466 kmalloc                                   40.8828
 10563 sock_recvmsg                              60.0170
 11780 fget                                     245.4167
 12042 __wake_up                                125.4375
 12396 proc_pid_stat                             14.6179
 17273 sys_read                                  71.9708
 18229 __generic_copy_to_user                   284.8281
 24197 number                                    30.8635
 29399 handle_IRQ_event                         262.4911
 43859 schedule                                  76.1441
 46887 unix_stream_recvmsg                       50.5248
141693 statm_pgd_range                          316.2790
167064 system_call                              2983.2857
1676560 apm_bios_call_simple                     14969.2857
9830981 default_idle                             204812.1042
12419127 total                                     10.7757

[root@arsozah root]# lspci
00:00.0 Host bridge: Intel Corporation 82845 845 (Brookdale) Chipset Host Bridge (rev 04)
00:01.0 PCI bridge: Intel Corporation 82845 845 (Brookdale) Chipset AGP Bridge (rev 04)
00:1e.0 PCI bridge: Intel Corporation 82801BAM PCI (rev 05)
00:1f.0 ISA bridge: Intel Corporation 82801BA ISA Bridge (ICH2) (rev 05)
00:1f.1 IDE interface: Intel Corporation 82801BA IDE U100 (rev 05)
02:02.0 VGA compatible controller: Cirrus Logic GD 5434-8 [Alpine] (rev f9)
02:03.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
02:04.0 USB Controller: NEC Corporation USB (rev 41)
02:04.1 USB Controller: NEC Corporation USB (rev 41)
02:04.2 USB Controller: NEC Corporation: Unknown device 00e0 (rev 02)
02:08.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
02:09.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)

-- 
Jay "yohimbe" Thorne  yohimbe@userfriendly.org
Mgr Sys & Tech, Userfriendly.org

