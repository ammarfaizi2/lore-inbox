Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269523AbUJVG2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269523AbUJVG2m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 02:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269549AbUJVG1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 02:27:22 -0400
Received: from mailgate2.mysql.com ([213.136.52.47]:35024 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S269504AbUJVG0L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 02:26:11 -0400
Subject: IO performance problems with 2.6.9
From: Peter Zaitsev <peter@mysql.com>
To: linux-kernel@vger.kernel.org
Cc: andrea@novell.com, alexeyk@mysql.com, markw@osdl.org
Content-Type: text/plain
Message-Id: <1098426220.5482.235.camel@sphere.site>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 21 Oct 2004 23:23:41 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was testing Linux performance on 80 drives disk array today
(8 hardware RAID volumes stripped by Linux RAID0 256K stripe) 

I've initially spotted this by very poor performance with DBT2
benchmark, while later isolated test to "SysBench" 
http://sysbench.sourceforge.net/,  running random read/write tests 
on single 40G file. 

The system is dual Opteron 2.4  with 8G of memory. 

ReiserFS file system (data=writeback,noatime,notail) was used.

Results I'm getting in IOs/Sec with 256 concurrent threads are:

                    READ     WRITE
Buffered IO 16K     6185     2496 
O_DIRECT 16K        5169      471
Buffered IO 4K      7091     4758
O_DIRECT    4K      7676      571 


Note I had only 1Gb FC connection so 16K reads saturated about 5xxx/sec


For Comparison I also did the run with SUSE SLES Kernel  (2.6.5-7.97SMP)


                    READ     MIXED (R/W)
Buffered IO 16K     2375     2520
O_DIRECT 16K        5391     1052
Buffered IO 4K      9576     5736
O_DIRECT    4K      8063     1041 

Sorry I did not do Exactly the same run due to lack of time accessing
hardware.

The issues with these results are:

1) SuSE kernel does "Buffered" reads in 4K reads instead of 16K reads.
This can be seen in "iostat -x". This seems to be fixed in 2.6.9

2) 2.6.9 does writes in 4K requests instead of 16K. This also can be 
seen in "iostat -x" 

3) O_DIRECT writes are simply broken :)
One can see in vmstat only 1 thread will be in "b" if this mode is used
and only one outstanding request will be submitted to SCSI controller at
the same time. Interesting enough if I use 128 files totaling the same
size  O_DIRECT shows good performance.  I thought inode locking problem
was removed in 2.6 :(

4) Unrelated but still unfortunate.  2.6.9 kernel seems to behave weird
if swap is disabled.  I was running with 8G of memory allocating 6G for
MySQL buffers  which left about 1.5G for kernel, 1G of which was used
for file cache.   During IO intensive run, using buffered IO I got
"kswapd" running like a crazy taking 90% of CPU time on one of CPUs. 
What for is it running if there is no swap files enabled ? 



-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com



