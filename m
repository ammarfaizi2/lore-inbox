Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbTDDVqA (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 16:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbTDDVqA (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 16:46:00 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:62101 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261374AbTDDVp6 convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 16:45:58 -0500
Content-Type: text/plain; charset=US-ASCII
From: Badari Pulavarty <pbadari@us.ibm.com>
To: andrew <akpm@digeo.com>
Subject: Re: Testing with 4000 disks
Date: Fri, 4 Apr 2003 13:55:05 -0800
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <200304041024.33418.pbadari@us.ibm.com> <3E8DD614.1060500@us.ibm.com>
In-Reply-To: <3E8DD614.1060500@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304041355.05296.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay !! I just made all my filesystem except root ext2.
(I couldn't boot when I configed out ext3 - mounting
root failed).

Anyway, problem seem to have gone away..
Machine is really slow while trying to do IO on
all 4000 filesystems. It is slowly creating processes.
System is 100% busy. (so far, it created 461 processes 
out of 4000). But we are not running out of lowmem and 
inode caches seems to be reasonable..

So, it must be some leak in ext3..

   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
407 31  8      0 3334068  80996 150144    0    0 148795    12 1018 18807  0 100  0
413 25  9      0 3334004  80996 150144    0    0 149867    20 1014 18910  0 100  0
411 27  8      0 3334068  80996 150144    0    0 154293    26 1017 19447  0 100  0
405 33  8      0 3333940  80996 150144    0    0 156830    14 1013 19747  0 100  0
400 38  8      0 3334004  80996 150144    0    0 154778     9 1013 19525  0 100  0
425 18  8      0 3333180  81040 150100    0    0 155303     8 1016 19615  0 100  0
409 34  8      0 3333116  81256 150144    0    0 151814    13 1015 19182  0 100  0
416 30  9      0 3332564  81396 150264    0    0 134068    10 1015 17024  0 100  0

[root@elm3b78 root]# cat /proc/meminfo
MemTotal:      3883248 kB
MemFree:       3330836 kB
Buffers:         82328 kB
Cached:         150112 kB
SwapCached:          0 kB
Active:         129736 kB
Inactive:       141412 kB
HighTotal:     3014616 kB
HighFree:      2797632 kB
LowTotal:       868632 kB
LowFree:        533204 kB	<<<<
SwapTotal:     2040244 kB
SwapFree:      2040244 kB
Dirty:            1372 kB
Writeback:           0 kB
Mapped:          45224 kB
Slab:           231516 kB
Committed_AS:    47420 kB
PageTables:       5884 kB
ReverseMaps:      9475

[root@elm3b78 root]# grep inode /proc/slabinfo
rpc_inode_cache        0      0    404    0    0    1 :   32   16 :      0       0     0    0    0    0  153 :      0      0      0      0
udf_inode_cache        0      0    420    0    0    1 :   32   16 :      0       0     0    0    0    0  153 :      0      0      0      0
nfs_inode_cache        0      0    636    0    0    1 :   32   16 :      0       0     0    0    0    0  150 :      0      0      0      0
isofs_inode_cache      0      0    380    0    0    1 :   32   16 :      0       0     0    0    0    0  154 :      0      0      0      0
ext2_inode_cache   11425  11432    480 1429 1429    1 :   32   16 :  11432   11740  1429    0    0    0  152 :   9948   1487     10      0\
		
ext3_inode_cache    4720   4728    496  591  591    1 :   32   16 :   4728    4850   591    0    0    0  152 :   8147    610   4037      0
		(due to mount points /mnt/mnt1 /mnt/mnt2 .. /mnt/mnt4000)

shmem_inode_cache      2      8    464    1    1    1 :   32   16 :      8      15     1    0    0    0  152 :      0      2      0      0
sock_inode_cache      38     45    408    5    5    1 :   32   16 :     45     179     5    0    0    0  153 :    373     22    357      0
proc_inode_cache    2810   2810    380  281  281    1 :   32   16 :   2810    5428   304   23    0    0  154 :   3759    553   1519      0
inode_cache       148260 148270    364 14827 14827    1 :   32   16 : 148270  148474 14829    2    0    0  154 : 141839  15202   8781      0
		(due to /sysfs)


