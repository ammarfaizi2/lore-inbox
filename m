Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313137AbSD3JKE>; Tue, 30 Apr 2002 05:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313161AbSD3JKD>; Tue, 30 Apr 2002 05:10:03 -0400
Received: from 11.ylenurme.ee ([193.40.6.11]:12692 "HELO linking.ee")
	by vger.kernel.org with SMTP id <S313137AbSD3JKC>;
	Tue, 30 Apr 2002 05:10:02 -0400
Date: Tue, 30 Apr 2002 12:10:11 +0300 (EEST)
From: <elmer@linking.ee>
X-X-Sender: <elmer@server>
To: <linux-kernel@vger.kernel.org>
Subject: LOCKUP: 2.4.18 + crtypo pathc2 locking raid/loop/ext3 wait_o under
 stress test 
Message-ID: <Pine.LNX.4.33.0204301148310.17403-100000@server>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



/ is ext3 over /dev/md/0 (raid1)
swap is /dev/loop/0 with blowfish over /dev/md/1 (raid0)
/home is ext3 over /dev/loop/1 with blowfish over /dev/md/2 (raid1)

256 ram. duron, hpt370,
raw IDE speed 40MB/s,
raw raid1 speed 37MB/s, raid0 speed near 80.
raw crypto speed 20MB/s (cpu full)

stress test is
1. a.out swap stress seeking 512M memory, while (1) for (i =0; i < 256M ;
i+=256) intarray[i]=i, taking 1-3% processor, all io
2. dd on /home of 512MB chunks , write,read, taking sometimes all
processor all IO, if swap takes io, dd is low
3. while true; do ls /home; done ; takes all the rest of IO.
4. ping flood outside computer


any following ls anywhere does not  block.
sync  blocks. It is somewhat weird as one ls is blocking.

process states after several killall -9 a.out dd ls

  F   UID   PID  PPID PRI  NI   VSZ  RSS WCHAN  STAT TTY        TIME COMMAND
100     0     1     0   9   0  1412  408 blowfi S    ?          0:06 init
040     0     2     1   9   0     0    0 contex SW   ?          0:00 [keventd]
040     0     3     0  19  19     0    0 ksofti SWN  ?          0:00 [ksoftirqd_
040     0     4     0   9   0     0    0 wait_o DW   ?          0:49 [kswapd]
040     0     5     0   9   0     0    0 bdflus SW   ?          0:00 [bdflush]
040     0     6     0   9   0     0    0 wait_o DW   ?          0:00 [kupdated]
040     0     7     1   9   0     0    0 down_i SW   ?          0:00 [i2oevtd]
040     0     8     1  -1 -20     0    0 md_thr SW<  ?          0:00 [mdrecovery
040     0     9     1  -1 -20     0    0 md_thr SW<  ?          0:29 [raid1d]
040     0    10     1  19  19     0    0 md_thr SWN  ?          0:09 [raid1syncd
040     0    11     1  -1 -20     0    0 md_thr SW<  ?          0:01 [raid1d]
040     0    12     1  19  19     0    0 md_thr SWN  ?          0:00 [raid1syncd
040     0    13     1   9   0     0    0 kjourn SW   ?          0:02 [kjournald]
040     0    14     0   9   0     0    0 blowfi SW   ?          0:00 [klids]
040     0    54     1  -1 -20     0    0 down_i SW<  ?          0:35 [loop0]
040     0   376     1   9   0     0    0 rtl813 SW   ?          0:00 [eth0]
040     0   452     1   9   0  1472  476 do_sel S    ?          0:00 syslogd -m
140     0   457     1   9   0  2092  456 do_sys S    ?          0:00 klogd -2
040     0   538     1   9   0     0    0 kjourn SW   ?          0:00 [kjournald]
040     0   539     1  -1 -20     0    0 down_i SW<  ?          0:00 [loop1]
040     0   541     1   9   0     0    0 wait_o DW   ?          0:05 [kjournald]
040     0   592     1   7   0  1584  448 nanosl S    ?          0:00 crond
040     2   628     1   9   0  1444  392 nanosl S    ?          0:00 /usr/sbin/a
100     0   635     1   9   0  2320  412 wait4  S    vc/1       0:00 login -- ro
100     0   636     1   9   0  2320  412 wait4  S    vc/2       0:00 login -- ro
100     0   637     1   9   0  2320  428 wait4  S    vc/3       0:00 login -- ro
100     0   638     1   9   0  2320  648 wait4  S    vc/4       0:00 login -- ro
100     0   639     1   9   0  2320  668 wait4  S    vc/5       0:00 login -- ro
100     0   640     1   9   0  2320  668 wait4  S    vc/6       0:00 login -- ro
100     0   643   635  15   0  2540 1000 read_c S    vc/1       0:04 -bash
100     0   695   636   9   0  2516  596 wait4  S    vc/2       0:00 -bash
100     0   902   695   9   0  2364  412 wait4  S    vc/2       0:00 su - elmer
100   500   903   902   9   0  2452  600 wait4  S    vc/2       0:00 -bash
100   500  2166   903   9   0  2876  652 do_sel S    vc/2       0:00 ssh 10.110.
100     0  2243   637   9   0  2508  640 wait4  S    vc/3       0:00 -bash
000     0  2290  2243   9   0 501372 152928 wait_o D vc/3       0:49 ./a.out .
100     0  2310   638   9   0  2508  960 wait4  S    vc/4       0:00 -bash
040     0  2359  2310   9   0  2508  960 wait4  S    vc/4       0:00 -bash
000     0  2362  2359   9   0 525952 456 wait_o D    vc/4       0:48 dd if /dev/
100     0  2365   639   9   0  2500 1124 wait4  S    vc/5       0:00 -bash
100     0  2412   640   9   0  2500 1060 wait4  S    vc/6       0:07 -bash
000     0  6444  2412   9   0  1708  592 wait_o D    vc/6       0:00 ls --color=
000     0  6445  2365  19   0  2212 1120 do_sel S    vc/5       0:02 top
000     0  6473   643   9   0  1632  488 wait_o D    vc/1       0:01 sync
100     0  6506   643  17   0  3136 1200 -      R    vc/1       0:00 ps axl

