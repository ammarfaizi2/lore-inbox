Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271751AbRH0PDy>; Mon, 27 Aug 2001 11:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271753AbRH0PDg>; Mon, 27 Aug 2001 11:03:36 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:49836 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S271751AbRH0PDa>; Mon, 27 Aug 2001 11:03:30 -0400
Message-ID: <3B8A6122.3C784F2D@us.ibm.com>
Date: Mon, 27 Aug 2001 10:02:58 -0500
From: Andrew Theurer <habanero@us.ibm.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Journal Filesystem Comparison on Netbench
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I recently starting doing some fs performance comparisons with Netbench
and the journal filesystems available in 2.4:  Reiserfs, JFS, XFS, and
Ext3.  I thought some of you may be interested in the results.  Below
is the README from the http://lse.sourceforge.net.  There is a kernprof
for each test, and I am working on the lockmeter stuff right now.  Let
me
know if you have any comments.  

Andrew Theurer
IBM LTC 


README:

http://lse.sourceforge.net/benchmarks/netbench/results/august_2001/filesystems/raid1e/README

The following is a filesystem comparison on the NetBench workload.
Filesystems tested include EXT2, EXT3, Reiserfs, XFS, and JFS.  
Server hardware is an 8 processor Intel Xeon, 700 MHz, 1MB L2
cache, Profusion chipset, 4GB interleaved memory, and 4 Intel
gigabit ethernet cards.  This test was conducted using a 
RAID disk system, consisting of an IBM ServeRAID 4H SCSI adapter, 
equipped with 32 MB cache, using one SCSI channel, attached to 10
disks, each having a capacity of 9 GB and a speed 10,000 RPM.  
The RAID was configured for level 10, a 5 disk stripe with mirror.   

The server was tested using linux 2.4.7, Samba 2.2.0, and NetBench
7.0.1.
Since we only have enough clients to drive a 4-way SMP test (44), the 
kernel used 4 processors instead of eight.  The 
"Enterprise Disk Suite" test was used for NetBench.  Each filesystem
was tested with the same test, starting with 4 clients and increasing
clients by 4 up to 44 clients.  

Some optimizations were used for linux, including zerocopy,
IRQ affinity, and interrupt delay for the gigabit cards, 
and process affinity for the smbd processes.

Default configurations for all filesystems were used, except ext3 
used mode "data=writeback".  No special options were chosen 
for performance for these initial tests.  If you know of
performance options that would benefit this test, please send
me email, habanero@us.ibm.com  


Peak Performance Results:

EXT2      773 Mbps @ 44 clients
EXT3      660 Mbps @ 44 clients
Reiserfs  532 Mbps @ 28 clients
XFS       661 Mbps @ 44 clients
JFS       683 Mbps @ 40 clients


Data Files:

This directory contains:

        kp.html         Kernprof top 25 list for all filesystems, 
                        recorded during a 44 client test.
        lock.html       -pending completion-  Lockmeter results,
                        recorded during a 44 client test.
                        -update: Reiserfs lockmeter is completed. 
                        look at ./reiserfs/4p/lockmeter.txt for complete
lockstat file.

        README          This file
        ./<fstype>      Test data for filesystem, <fstype> =
[ext2|ext3|xfs|reiserfs|jfs]
                        First subdirectory is the SMP config (4P for
these tests)
                        Next level directories are: 
                          
                        sar:  sysstat log for test
                        netbench: netbench results in Excel format
                        proc:  some proc info before test
                        samba:  samba info


Notes:

In this test, JFS had the best peak throughput for journal filesystems,
and ext2 had the best peak throughput for all filesystems.  Reiserfs 
had the lowest peak throughput, and also had the most % time in
stext_lock
(as shown in kp.html).  

Netbench is usually an "in memory" test, such that all files stay in
buffer cache.  Actually, during the test, kupdate is stopped.  No file
data
is ever written to disk, but with the introduction on journal
filesystems,
journal data is written to disk.  This allows the opportunity to compare
how much data and how often data is written to disk for the 4 journal
filesystems tested.  the sysstat information shows blocks/sec for
devices.
In these tests, the device for the samba share is on dev8-1. 
JFS experienced a peak blocks/sec of ~10,000, while XFS was ~4100, EXT3
was ~1100, and Reiserfs was ~800.  It was interesting to see Reiserfs
write at 800 blocks/sec, then nothing for 30 seconds, then again at 
~800 blocks/sec.  No other journal filesystem experienced that pattern
of journal activity.  


Next Steps:

Finish lockmeter reports
Same tests on non-cached, single SCSI disk
Investigate performance options for each filesystem
