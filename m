Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318027AbSHVWyP>; Thu, 22 Aug 2002 18:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318028AbSHVWyO>; Thu, 22 Aug 2002 18:54:14 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:53736 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318027AbSHVWyJ>;
	Thu, 22 Aug 2002 18:54:09 -0400
Subject: Performance of 2.4.17-based Kernel vs 2.5.26-based Kernel Under Database
 Workload
To: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@zip.com.au>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFE708D02D.C1935D57-ON85256C1D.006DDF9E@pok.ibm.com>
From: "Peter Wong" <wpeter@us.ibm.com>
Date: Thu, 22 Aug 2002 17:28:47 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.10 SPR# MIAS5B3GZN |June
 28, 2002) at 08/22/2002 06:57:59 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have compared the performance of 2.4.17 kernel+patches against that
of 2.5.26 kernel+patches under a very heavy database workload. A
100 GB database is used and stored on raw devices. The workload
consists of a sequence of highly complex queries, and is processed
with a 8-way 700 HMz Pentium III Xeon machine, 4 GB RAM and 2 MB L2
cache. Six SCSI adapters are used with 120 disks, each of which has
a capacity of 9.1 GB and a rotational speed of 10K RPM.

Details of the kernels:

The 2.4.17+ kernel consists of:
  - 2.4.17 (kernel.org)
  - bounce buffer patch (Jens Axboe)
  - IPS patch (Peter Wong)
  - io_request_lock patch (Jonathan Lahr)
  - rawvary patch (Badari Pulavarty)
  - changes to TASK_UNMAPPED_BASE and PAGE_OFFSET to provide
    more room for the database bufferpool

The 2.5.26+ kernel consists of
  - 2.5.26 (kernel.org)
  - direct I/O patch (Andrew Morton, Badari Pulavarty ported it
                      from 2.5.31)
  - changes to exec.c (a fix needed to run the benchmark)
  - changes to TASK_UNMAPPED_BASE to provide more room for the
    database bufferpool

Based upon the throughput of the workload, there is a 8% improvement
of 2.5.26+ over 2.4.17+, which indicates that the new 2.5 code
performs better than the 2.4 code. Indeed, the bounce buffer patch,
the removal of io_request_lock, and efficient handling of large I/O
via the bio struct are already incorporated into the 2.5 kernel.

I have not collected lockmeter and kernprof data on 2.5.26+ yet.
However, I have collected them on the 2.5.25-based kernel. Note
that the 2.5.25-based kernel achieves about the same performance
level as the 2.5.26+ kernel.

The lockmeter tool indicates no hot locks, and in fact, there is
almost no lock contention on the system. By examining one query
which scans a ~75 GB table and performs simple comparisons, the
lock spin time is close to 0%. The top lock is used inside the
IPS interrupt handler routine. The following is a clip of the
lockmeter result showing the *TOTAL* and do_ipsinstr+0x24.


SPINLOCKS       HOLD            WAIT
  UTIL  CON  MEAN(  MAX )   MEAN(  MAX )(% CPU)     TOTAL  NAME

       2.0%  5.3us(8532us)  9.5us( 414us)(0.07%)  65591728  *TOTAL*

15.3% 0.74%   63us( 162us)   10us( 202us)(0.00%)   1326034  do_ipsintr
                                                            +0x24

All of the other complex queries show a similar lockmeter result.

Using the kernprof tool to examine the same query, do_ipsintr is also
at the top of the list, but it only consumes a small percentage of
the total time. The following is a clip of the kernprof result showing
the top functions.


        TOTAL_SAMPLES                  3137055
        USER [c0125ef0]:               2159334    (68.8%)
        default_idle [c0105310]:        759032    (24.2%)
        do_ipsintr [c0213810]:           76169    ( 2.4%)
        do_softirq [c011b930]:           46244    ( 1.5%)
        scsi_dispatch_cmd [c01f58b0]:    12937    ( 0.4%)

All of the other complex queries show a similar kernprof result for
the top functions.

Regards,
Peter

Peter Wai Yee Wong
IBM Linux Technology Center, Performance Analysis
email: wpeter@us.ibm.com


