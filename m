Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267823AbUHERLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267823AbUHERLm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 13:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267817AbUHERKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 13:10:16 -0400
Received: from fecls-02.atlarge.net ([129.41.63.107]:2790 "HELO
	fecls-02.atlarge.net") by vger.kernel.org with SMTP id S267819AbUHERIj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 13:08:39 -0400
Message-ID: <41126811.7020607@dssimail.com>
Date: Thu, 05 Aug 2004 12:02:09 -0500
From: "Mr. Berkley Shands" <berkley@dssimail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Severe I/O performance regression 2.6.6 to 2.6.7 or 2.6.8-rc3
Content-Type: multipart/mixed;
 boundary="------------060607030601090007050309"
X-OriginalArrivalTime: 05 Aug 2004 17:02:11.0692 (UTC) FILETIME=[F31F42C0:01C47B0D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060607030601090007050309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Two severe disk read bugs:

In a nutshell (see attached for gory details). Moving from 2.6.6 to 
2.6.7 dropped multi-threaded RAID0
read performance from 429MB/Sec to 81MB/Sec. Single threaded reads 
improved  368MB/Sec to 418MB/Sec.
The code in drivers/md has no effect on this problem. Clearly this is a 
thread access issue. Redhat ES3.0
on x86_64 or i686.  The underlying hardware is capable of 955MB/Sec disk 
reads off 28 drives,
541MB/Sec off 14 drives. Tuning I/O block size (11KB to 239KB) and 
BLKRASET size (448 to 1024 or more)
helps a little. System idle goes from 0% to 50% (2.6.6 to 2.6.8-rc3).

File reads (ext3/raid0) exceeding physical ram size cause kswapd to go 
out to lunch.
The I/O rate drops to 10MB/Sec. Under 2.6.6 there was NO effect for 
large files. Using
fadvise64() helps a little on i686, but hurts on x86_64. fadvise64_64() 
is just plain broken.

This was discovered while testing I/O throughput for a paper being 
submitted to ASPLOS BEACON
workshop - October 2004.

I'll run most any experiment on either architecture to help diagnose 
this, and will fiddle kernel code
and debug options as requested. Source code to the test suite available 
on request to developers only.

Mr. Berkley Shands
berkley<at>dssimail.com
berkley<at>cse.wustl.edu

--------------060607030601090007050309
Content-Type: text/plain;
 name="Raid0.bug"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Raid0.bug"

I/O throughput regression bug going from 2.6.6 to 2.6.7 or 2.6.8-rc3
There are several I/O throughput bugs that were introduced in 2.6.7,
not related to any updates in drivers/md. The first reduces multi-threaded
reads of a file on an ext3/RAID0 file from ~600MB/Sec to ~160MB/Sec on my 
opteron. The same result is seen on a i686 based system. Doing single threaded
reads of the same ext3/RAID0 file shows a ~60MB/Sec reduction.
The hardware is 2-Adaptec 39320A-R HBAs into 4 7-drive strings of 15KRPM Seagate
U320 drives. The AIC79XX driver is V2.0.12 (the stock driver shows lower 
performance).

The second throughput bug happens when the file being read is larger than 
physical memory, in this case 16GB of file, and 8GB of RAM. Reading the first 
7GB of file runs at ~420MB/Sec (1-39320A and 14 drives). The next 9GB runs at 
60MB/Sec or less. If I use fadvise64_64() to try to manage the file cache,
the rate drops to under 10MB/Sec :-)

Observations - kswapd goes nuts under 2.6.7, 2.6.8-rc3 when the file being read
exceeds the physical memory size. System idle time (from top) is near zero
for 2 threads reading under 2.6.6, and is 50% or better for 2.6.7 or 2.6.8-rc3.
Otherwise I/O wait is the dominant state 89% to 95%. The opteron is capable of
955MB/Sec raw I/O off the 28 drive array using O_DIRECT on /dev/sda, /dev/sdb...
541MB/Sec raw I/O off the 14 drive array.

The value of 2 threads, 11KB reads, and 448 RASize were close to optimal
for 2.6.2 through 2.6.6 on the 14 drive system. fadvise64_64() is broken on 
i686 and x86_64. The 3rd parameter is being passed garbage off the stack.
Patching the ioctl fixed that one. fadvise64_64() helps on the i686, but is
very harmfull on the x86_64.

The values passed via ioctl(BLKRASET | BLKFRASET) to get peak performance
vary radically between 2.6.6, 2.6.7, and 2.6.8-rc3 for /dev/md0. The ioctl does
a right shift by 3 bits before using the passed in value, so my RASize value is
left shifted by 3 bits (X * 8) before being passed in.

4-controller, 28 drives, raid0, 2.6.6, 2 threads
<threads, Read KBytes, RASize, MB/Sec> 
 2,  11,  448,   552.617 
 2,  11, 2736,   595.695 
 2,  11, 2275,   596.911 
 2,  11, 2253,   597.956 
 2,  11, 2321,   600.234 
 2,  11, 2164,   601.115 

2-controller, 14 drives, raid0, 2.6.8-rc3, 2 threads
<threads, Read KBytes, RASize, MB/Sec> 
 2,  11, 448,    81.543 
 2, 239, 448,   154.706 
 2, 239, 673,   161.070 
 2, 239, 124,   161.158  
 2, 239, 149,   161.209 
 2, 239, 128,   161.298 
 2, 239, 229,   161.400 
 2, 239, 548,   161.897 

2-controller, 14 drives, raid0, 2.6.8-rc3, single thread
<threads, Read KBytes, RASize, MB/Sec> 
 1,  11, 448,   329.419
 1,  11, 935,   373.382 
 1,  11, 894,   373.518 
 1,  11, 1021,  377.442 
 1,  11, 1023,  387.952 
 1,  11, 1024,  418.985 

2-controller, 14 drives, raid0, 2.6.6, 2 threads
<threads, Read KBytes, RASize, MB/Sec> 
 2,  11, 471,   429.170 
 2,  11, 470,   430.252 
 2,  11, 493,   430.523 
 2,  11, 514,   430.795 
 2,  11, 448,   431.612 

2-controller, 14 drives, raid0, 2.6.6, single thread
<threads, Read KBytes, RASize, MB/Sec> 
 1,   7, 448,   328.047 
 1,   7, 681,   365.714 
 1,   7, 675,   366.107 
 1,   7, 186,   366.237 
 1,   7, 668,   367.882 
 1,   7, 662,   368.213 

Hardware setup:
dual cpu 2.0GHz opteron, Tyan S2885, 8GB ram, dual 39320A-R on
different PCi-X busses. RedHat ES3.0-update 1.

dual cpu 2.66GHZ Xeon w/hyperthtreading, SuperMicro X5DA8, 2GB RAM,
dual 39320A-R (or AIC7902 on mobo), RedHat ES3.0-update 2.

14 Seagate 36GB 15K RPM U320 drives in one partition, 
14 Fujitsu 73GB 15K RPM U320 drives in two 36GB partitions.
(better have the right ucode for those fujitsu drives!)
In two StorCase 14-bay Infostations.

--------------060607030601090007050309--
