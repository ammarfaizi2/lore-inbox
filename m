Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbUDUMjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbUDUMjh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 08:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbUDUMjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 08:39:37 -0400
Received: from mail4.hitachi.co.jp ([133.145.228.5]:49378 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP id S261298AbUDUMj2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 08:39:28 -0400
MIME-Version: 1.0
Date: Wed, 21 Apr 2004 21:39:23 +0900
Subject: Re: IA64 Linux VM performance woes
From: Satoshi Oshima <oshima@sdl.hitachi.co.jp>
To: linux-kernel@vger.kernel.org
Message-ID: <JT20040421213923.40329203@sdl.hitachi.co.jp>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-Mailer: JsvMail 5.0 (Shuriken Pro3)
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Michael and all.

We have realized the same kind of performance issue. 
In our case it is not an IA64 huge scale system but an IA32
server system.

In our experiment, we see file I/O throughput decline on 
the server with over 8GByte memory. Kernel versions we use 
are 2.6.0 and Red Hat AS3. We show our experiment.

Below is our hardware configuration and test bench.

CPUs: Xeon 1.6Ghz - 4way
Memory: 12GB
Storage: ATA 120GB
File I/O workload generator consists of 1024 processes and 
generates 100KByte to 5MByte file write. Using "mem=" option, 
we change the memory recognition 2GByte to 12GB.

Below is the result ( unit: MByte/sec).

      2GB  4GB  8GB  12GB
2.6.0 13.1 18.5 18.4 16.1
AS3   11.0 11.3 10.3 8.92

The result shows throughput decline occurs when the server 
has over 8GByte memory.

We agree that your proposal is good idea. It reduces cache 
memory reclaiming cost to set upper bound on number of 
cache memory pages. 

Generally it is very difficult to build one system which 
could handle various type of workloads well. So we hope 
Linux would have kernel parameter tuning interface.

We would be very happy if we could share information to 
manage large scale memory.

Thank you.

Satoshi Oshima,
Systems Development Laboratory
Hitachi Ltd.

>>Hello all.
>>
>>We are trying to deploy a 128 PE SGI Altix 3700 running Linux, with 265GB 
main>>
>>memory and 10TB RAID disk (TP9500) :
>>
>># cat /etc/redhat-release
>>Red Hat Linux Advanced Server release 2.1AS (Derry)
>>
>># cat /etc/sgi-release
>>SGI ProPack 2.4 for Linux, Build 240rp04032500_10054-0403250031
>>
>># uname -a
>>Linux c 2.4.21-sgi240rp04032500_10054 #1 SMP Thu Mar 25 00:45:27
>>PST 2004 ia64 unknown
>>
>>We have been experiencing bad performance and downright bad behavior when 
we
>>are trying to read or write large files (10-100GB).
>>
>>File Throughput Issues
>>----------------------
>>At first the throughtput we are getting without file cache bypass is at 
around>>
>>440MB/sec MAX. This specific file system has LUNs whose primary FC paths 
go
>>over all four 2Gb/sec FC channels and the max throughput should have been
>>close to 800MB/sec.
>>
>>I've also noticed that the FC adapter driver threads are running at 100% 
CPU
>>utilization, when they are pumping data to the RAID for long time. Is 
there
>>any data copy taking place at the drivers? The HBAs are from QLogic.
>>
>>
>>VM Untoward Behavior
>>-------------------
>>A more disturbing issue is that the system does NOT clean up the file 
cache
>>and eventually all memory gets occupied by FS pages. Then the system 
simply
>>hungs.
>>
>>We tried enabling / removing bootCPUsets, bcfree and anything else 
available
>>to us. The crashes are just keep comming. Recently we started 
experiencing a
>>lot of 'Cannot do kernel page out at address' by the bdflush and kupdated
>>threads as well. This complicates any attempt to tune the FS in a way 
that can>>
>>maximize the throughput and finally setup sub-volumes on the RAID in a 
way
>>that different FS performance objectives can be attained.
>>
>>
>>Tunning bdlsuh/kupdated Behavior
>>-------------------------------
>>
>>One of our main objectives at our center is to maximize file thoughput 
for our>>
>>systems. We are a medium size Supercomputing Center were compute and I/O
>>intensive numerical computation code runs in batch sub-systems. Several
>>programs expect and generate often very large files, in the order of 10-
70GBs.>>
>>Minimizing file access time is importand in a batch environment since
>>processors remain allocated and idle while data is shuttled back and 
forth
>>from the file system.
>>
>>Another common problem is the competition between file cache and 
computation
>>pages. We definitely do NOT want file cache pages being cached, while
>>computation pages are reclaimed.
>>
>>As far as I know, the only place in Linux that the VM / file cache 
behavior
>>can be tuned is with the 'bdflush/kupdated' settings. We need a good way 
to
>>tuneup the 'bdflush' parameters. I have been trying very hard to find in-
depth>>
>>documentation on this.
>>
>>Unfortunately I have only gleaned some general and abstract advices on 
the
>>bdflush parameters, mainly in the kernel source documentation tree
>>(/usr/src/kernel/Documentation/).
>>
>>For instance, what is a 'buffer'? Is it a fixed size block (e.g., a VM 
page)
>>or it can be of any size? This is important as bdlush uses number and
>>percentages of dirty buffers. A small number of large buffers require 
much
>>more data to get transferred to the disks, vs. a large number of small
>>buffers.
>>
>>Controls that are Needed
>>------------------------
>>Ideally we need to:
>>
>>1. Set an upper bound on the number of memory pages ever caching FS 
blocks.
>>
>>2. Control the amount of data flushed out to disk in set time periods; 
that is>>
>>we need to be able to match the long term flushing rate with the service 
rate
>>that the I/O subsystem is capable of delivering, tolerating possible 
transient>>
>>spikes. We also need to be able to control the amount of read-ahead, 
write
>>behind or even hint that data are only being streamed through, never to 
be
>>reused again.
>>
>>3. Specify different parameters for 2., above, per file system: we have 
file
>>systems that are meant to transfer wide stripes of sequential data, vs. 
file
>>systems that need to perform well with smaller block, random I/O, vs. 
ones
>>that need to provide access to numerous smaller files. Also, cache 
percentages>>
>>per file system would be useful.
>>
>>4. Specify, if else fails, what parts of the FS cache should flushed in 
the
>>near future.
>>
>>5. Provide in-depth technical documentation on the internal workings of 
the
>>file system cache, its interaction with the VM and the interaction of 
XFS/LVM
>>with the VM.
>>
>>6. We do operate IRIX Origins and IBM Regatta SMPs where all these issues 
have>>
>>been addressed to a far more satisfying degree than on Linux. Is the IRIX 
file>>
>>system cache going to be ported to ALTIX Linux? There is already a LOT of
>>experience in IRIX for these types of matters that should NOT remain
>>unleveraged.
>>
>>
>>Any information/hint or pointers for in-depth discussion on the bugs and
>>tunning of VM/FS and I/O subsystems or other relevant topics would be
>>GREATLY appreciated!
>>
>>We are willing to share our experience with anyone who is interested in
>>improving any of the above kernel sub-systems and provide feedback with
>>experimental results and insights.
>>
>>Thanks
>>
>>Michael Thomadakis
>>
>>Supercomputing Center
>>Texas A&M University


