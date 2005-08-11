Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbVHKHmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbVHKHmT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 03:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbVHKHmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 03:42:19 -0400
Received: from mail23.sea5.speakeasy.net ([69.17.117.25]:3813 "EHLO
	mail23.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1030199AbVHKHmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 03:42:18 -0400
Date: Thu, 11 Aug 2005 03:42:15 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: serue@us.ibm.com
cc: lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Stacker - single-use static slots
In-Reply-To: <20050810144516.GA5796@serge.austin.ibm.com>
Message-ID: <Pine.LNX.4.63.0508110331250.27749@excalibur.intercode>
References: <20050727181732.GA22483@serge.austin.ibm.com>
 <Lynx.SEL.4.62.0507271527390.1844@thoron.boston.redhat.com>
 <Lynx.SEL.4.62.0507271535150.1844@thoron.boston.redhat.com>
 <20050803164516.GB13691@serge.austin.ibm.com>
 <Lynx.SEL.4.62.0508051154150.8981@thoron.boston.redhat.com>
 <20050810144516.GA5796@serge.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2005, serue@us.ibm.com wrote:

> those annoying cache effects, I assume - 3 slots (the default)
> outperforms two slots, even though only one slot is being used.  These
> tests were run on a 16-way power4+ system.  I may try to re-run on some
> x86 hardware, though each run will probably take 24 hours.

I've also run some benchmarks, comparing vanilla kernel with the 
two stacker approaches.  Results below.

Results seem to be mixed, sometimes a bit better, sometimes a bit worse.  
The macro benchmarks tend to show better figures for the static slot 
model.

Overall, it seems that SELinux could expect to take a 1-2% performance hit 
with the stacker.

==============================================================================
Performance testing summary using the stacker patches, 11 Aug 2005.

Test system:
  8-way 900Mhz PIII Xeon, 4GB RAM, FC4, current updates.
  
Test data was managed on an ext2 filesystem, using targeted policy.
Kernel version 2.6.13-rc4.

The kernel was configured as follows:

 control
    Standard kernel with SELinux and secondarily stacked capabilities.

 stacker_dynamic
   Stacker with fully dynamic security fields, SELinux + caps.

 stacker_static 
   Stacker with three static slots for security fields, SELinux + caps.


-----------------------------------------------------------------------------
Unixbench
-----------------------------------------------------------------------------

Six iterations.
Larger is better.

1) control

Execl Throughput                                43.0     1159.7      269.7
File Copy 1024 bufsize 2000 maxblocks         3960.0    93041.0      235.0
File Copy 256 bufsize 500 maxblocks           1655.0    44393.0      268.2
File Copy 4096 bufsize 8000 maxblocks         5800.0   129172.0      222.7
Pipe Throughput                              12440.0   217759.8      175.0
Process Creation                               126.0     5687.4      451.4
Shell Scripts (8 concurrent)                     6.0      750.9     1251.5
System Call Overhead                         15000.0   752195.3      501.5
                                                                 =========
     FINAL SCORE                                                     342.1


2) stacker_dynamic

Execl Throughput                                43.0     1163.8      270.7
File Copy 1024 bufsize 2000 maxblocks         3960.0    92321.0      233.1
File Copy 256 bufsize 500 maxblocks           1655.0    44309.0      267.7
File Copy 4096 bufsize 8000 maxblocks         5800.0   128635.0      221.8
Pipe Throughput                              12440.0   211583.8      170.1
Process Creation                               126.0     5657.9      449.0
Shell Scripts (8 concurrent)                     6.0      744.0     1240.0
System Call Overhead                         15000.0   759228.4      506.2
                                                                 =========
     FINAL SCORE                                                     340.2



3) stacker_static

Execl Throughput                                43.0     1159.6      269.7
File Copy 1024 bufsize 2000 maxblocks         3960.0    88455.0      223.4
File Copy 256 bufsize 500 maxblocks           1655.0    40165.0      242.7
File Copy 4096 bufsize 8000 maxblocks         5800.0   125384.0      216.2
Pipe Throughput                              12440.0   208970.6      168.0
Process Creation                               126.0     5712.9      453.4
Shell Scripts (8 concurrent)                     6.0      752.5     1254.2
System Call Overhead                         15000.0   746153.0      497.4
                                                                 =========
     FINAL SCORE                                                     332.7

-----------------------------------------------------------------------------
Apachebench
-----------------------------------------------------------------------------

Local webserver, logging to /dev/null.
100k requests of a 100k file.

---------------------------------------------------------
#clients                 1         2         4         8
---------------------------------------------------------
control         : 15627.93  18715.48  20377.54  21543.10
stacker_dynamic : 15371.80  18049.45  20281.98  21037.24
stacker_static  : 15247.48  18395.96  20579.46  21523.41
---------------------------------------------------------


----------------------------------------------------------------------------
dbench
-----------------------------------------------------------------------------

300s tests incl. 60s of warmup.
Throughput in MB/s.
Larger is better.

-----------------------------------------------------
# procs                 2        4        8       16
-----------------------------------------------------
control         : 200.264  351.135  514.327  483.085
stacker_dynamic : 192.805  336.097  511.713  474.047
stacker_static  : 197.254  333.781  510.713  471.581
-----------------------------------------------------


----------------------------------------------------------------------------
lmbench
-----------------------------------------------------------------------------

Processor, Processes - times in microseconds - smaller is better
------------------------------------------------------------------------------
Host                 OS  Mhz null null      open slct sig  sig  fork exec sh  
                             call  I/O stat clos TCP  inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
control   Linux 2.6.13-  900 0.24 0.85 5.29 6.83 23.6 1.01 3.98 215. 1054 3482
stack_dyn Linux 2.6.13-  900 0.24 0.91 5.72 7.17 23.6 1.01 4.25 211. 1046 3500
stack_sta Linux 2.6.13-  900 0.24 0.89 5.41 6.97 27.3 1.01 4.28 209. 1052 3450

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------------------
Host                 OS  2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                         ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ------ ------ ------ ------ ------ ------- -------
control   Linux 2.6.13- 1.7800 5.3700 7.0500   12.0 6.1000 4.42000    11.6
stack_dyn Linux 2.6.13- 2.1100 3.9800 2.0400   10.2   12.5 8.44000    19.6
stack_sta Linux 2.6.13- 1.8800 4.2500 2.1700   10.2   20.5 9.56000    25.1

*Local* Communication latencies in microseconds - smaller is better
---------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
control   Linux 2.6.13- 1.780  52.3 18.2 100.1  83.4 112.1  96.1 177.
stack_dyn Linux 2.6.13- 2.110  30.4 25.3 101.7  83.7 112.8  98.4 180.
stack_sta Linux 2.6.13- 1.880  52.5 20.6 102.6  84.2 112.7  97.1 180.

File & VM system latencies in microseconds - smaller is better
-------------------------------------------------------------------------------
Host                 OS   0K File      10K File     Mmap    Prot   Page   100fd
                        Create Delete Create Delete Latency Fault  Fault  selct
--------- ------------- ------ ------ ------ ------ ------- ----- ------- -----
control   Linux 2.6.13-   42.4   18.1   79.6   33.4  4066.0 0.341 2.73660  20.8
stack_dyn Linux 2.6.13-   44.2   18.5   77.7   34.2  4064.0 0.217 2.73910  18.5
stack_sta Linux 2.6.13-   44.2   18.4   77.6   34.5  4072.0 0.201 2.76820  18.4

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
control   Linux 2.6.13- 105. 163. 106.  228.3  256.7  133.4  130.0 256. 201.4
stack_dyn Linux 2.6.13- 207. 295. 170.  228.1  256.7  133.7  130.2 257. 201.1
stack_sta Linux 2.6.13- 107. 162. 106.  227.6  256.6  133.4  130.4 257. 201.6


==============================================================================


