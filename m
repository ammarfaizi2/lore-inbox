Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269130AbSIRSHo>; Wed, 18 Sep 2002 14:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269081AbSIRSHo>; Wed, 18 Sep 2002 14:07:44 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:24324 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S269130AbSIRSHn> convert rfc822-to-8bit; Wed, 18 Sep 2002 14:07:43 -0400
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Linux TPC-C performance aided by kernel features
Date: Wed, 18 Sep 2002 13:12:40 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E106402D09E36@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux TPC-C performance aided by kernel features
Thread-Index: AcJfPvkJwy4jn2deQaOjqkCnKZiduA==
From: "Bond, Andrew" <Andrew.Bond@hp.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Sep 2002 18:12:40.0647 (UTC) FILETIME=[F9FC5570:01C25F3E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This past Monday HP released the very first TPC-C benchmark result done using Linux.  When comparing it to a previous HP result using basically the same hardware and same database but with Windows 2000, the Linux result is faster and cheaper.  The benchmark is a proof point that shows Linux can run well in an enterprise environment.

Of more interest to this mailing list however would be some of the kernel features that gave us a performance boost.

1. Async IO  - We saw about a 5% increase in performance when using Ben's asynchronous IO with Oracle.  The peformance gain was because of reduced overhead on the Oracle and OS process front.  By using async IO we were able to run with only 2 Oracle dbwriter processes rather than the 15+ we would have needed without it.  This made the Oracle environment more efficient, and reduced our context switch overhead on the OS side.

2. Large memory support (16GB) - The Oracle processes used about 14GB of shared memory which was allocated using shmfs and managed through a mapping window in the Oracle process space.  Databases always love more memory, however in an IA-32 architecture the gains definitely diminish once you get past 4GB because of overhead.  Our gains going from 8GB to 16GB of memory in the system were in the 10% range.  

3. Raw device access - I don't have a percentage gain for this one since we have been using this feature since the beginning.  Initial testing last year showed that raw device access was definitely superior to other methods of device access.  On a single node, O_DIRECT would be an option now, but for cluster configurations multinode filesystem access would be needed.  One limitation we kept running into was the 256 raw device limit imposed by raw having a single major number.  This issue has been taken care of in 2.5, but for 2.4 based kernels it is a limitation for larger configurations.

4. 2MB PTE's for Oracle memory - We saw an 8% gain when we switched from using 4k PTE's to 2MB PTE's for the shared memory Oracle was allocating.  14GB of the 16GB of memory on the system was set aside for this "bigpage" usage.

Other features such as IO elevator tuning, process priority adjustment, and TCP tuning were also used.


For those that are interested in more detail about the benchmark configuration I would refer you to this TPC web page where #7 is the Linux benchmark and #8 is the Windows one.  You can select the benchmark and pull up the full disclosure report for more gory detail.

http://www.tpc.org/tpcc/results/tpcc_perf_results.asp?resulttype=cluster

Regards,
Andy

