Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278305AbRJSEpz>; Fri, 19 Oct 2001 00:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278306AbRJSEpp>; Fri, 19 Oct 2001 00:45:45 -0400
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:28401 "EHLO
	swan.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S278305AbRJSEpa>; Fri, 19 Oct 2001 00:45:30 -0400
From: rwhron@earthlink.net
Date: Fri, 19 Oct 2001 00:48:04 -0400
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: VM tests on 2.4.13-pre5
Message-ID: <20011019004804.A447@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kernel: 2.4.13-pre5

Tests:  mmap001 and mtest01 from Linux Test Project.  Listen to mp3blaster.

Summary: 

mmap001 wall clock time higher than 2.4.13-ac3-vmpatch-freeswap and 2.4.13-pre3aa1.  

mtest01 terminated with signals 2 and 3, CPU utilization ~ 100% on first run.
Second try had much longer wall clock times than other kernels.

mp3blaster not too pleasant.


Average for 5 mmap001 runs
bytes allocated:                    2048000000
User time (seconds):                19.558
System time (seconds):              19.800
Elapsed (wall clock seconds) time:  262.80
Percent of CPU this job got:        14.60
Major (requiring I/O) page faults:  500213.0
Minor (reclaiming a frame) faults:  40.6


Comparison for mmap001 test:

2.4.12-ac3-vmpatch-freeswap	Elapsed (wall clock seconds) time:  152.87
2.4.13-pre3aa1			Elapsed (wall clock seconds) time:  204.09
2.4.13-pre3aa1 page-cluster=2	Elapsed (wall clock seconds) time:  213.90
2.4.13-pre3aa1 page-cluster=4	Elapsed (wall clock seconds) time:  209.41
2.4.13-pre3aa1 page-cluster=6	Elapsed (wall clock seconds) time:  206.08
2.4.13-pre5			Elapsed (wall clock seconds) time:  262.80


mtest01

The first time I ran this test, it went much longer than expected.
Five tests terminated with signal 2, and five terminated with signal 3.
That was odd because I run the same script with the same basically the
same processes running each time.

I re-ran the test a second time (only 3 iterations).  

Averages for 3 mtest01 runs
bytes allocated:                    1249902592
User time (seconds):                2.143
System time (seconds):              4.600
Elapsed (wall clock) time:          153.333
Percent of CPU this job got:        4.00
Major (requiring I/O) page faults:  164.3
Minor (reclaiming a frame) faults:  305953.3

Comparison for mtest01:

2.4.12-ac3 page-cluster=2	Elapsed (wall clock) time:          36.066
2.4.12-ac3 page-cluster=4	Elapsed (wall clock) time:          34.777
2.4.13-pre3aa1 page-cluster=2	Elapsed (wall clock) time:          47.878

Only 2.4.13-pre3aa1 page-cluster=2 sounds good in mp3blaster throughout the test.



mmap001test scripty

#!/bin/bash

# script to exercise mmap.  
#
# Uses "mmap001" test from Linux Test Project
#
# see: http://ltp.sourceforge.net/
#

PATH="$PATH:/usr/src/sources/l/cvs/ltp/testcases/bin"
# mmap, touch, msync, and munmap pages

test=mmap001
pages=500000
args="-m $pages"

test_log=${test}-`uname -r`.log
vmstat_log=vmstat-${test}-`uname -r`.log

# iterations
typeset -i i=5

# watch memory usage every second
vmstat 1 > $vmstat_log &

echo running $i iterations of $test $args
echo "output is going to $test_log and $vmstat_log"

# need full featured bash for (( arith )).
while	((i > 0))
do	/usr/bin/time -v $test $args
	((i--))
done > $test_log  2>&1

# kill vmstat 
kill $!

-- 
Randy Hron

