Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267628AbTAQTMe>; Fri, 17 Jan 2003 14:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267637AbTAQTMe>; Fri, 17 Jan 2003 14:12:34 -0500
Received: from air-2.osdl.org ([65.172.181.6]:39377 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267628AbTAQTMc>;
	Fri, 17 Jan 2003 14:12:32 -0500
Message-Id: <200301171921.h0HJLSA17204@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: [OSDL][BENCHMARK] Database results 2.4 versus 2.5
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 17 Jan 2003 11:21:28 -0800
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We have found some very nice database performance improvements in the
OSDL-DBT-2 database workload comparing the latest 2.4 kernel with 2.5.49
on a 8-way Profusion Xeon 700MHz Pentium III system with 4GB of memory.
We suspect there will be I/O improvements after moving to the latest
2.5 releases.  We would like to optimize our memory utilization before
moving on to those experiments.

OSDL-DBT-2 is transaction intensive.  We have implemented two variants on
SAP-DB using raw data files: 
-one "cached" that  runs in memory and does very little I/O except for 
   the log writes, and
-another "non-cached" with heavy reads and some writes.

In both variants the database buffer cache is sized to consume most of the
memory on the system.  There are five transaction types running during the
test run.  For the workload metric, we count how many of one transaction
type,"new-order", complete per minute (NOTPM).  We measure this after the
database cache is warm.  The new-order transaction represents 45% of all
transactions running.  The bigger the number, the better the performance.

We did several runs of each variant (cached and non-cached) on each of
the two OS versions (2.4.21-pre3 and 2.5.49*).  Run variances were low
compared to the differences we saw between OS versions.  Results are as
follows (numbers represent average over the runs):


Linux       DBT2      Metric  Wrkld %memused            iostats
Version     Workload (bigger Speedup on4GB   %user %sys  total
                      better)                            iops
___________________________________________________________________
2.4.21-pre3 cached     4479          99.73    74.24 3.64  **     
2.5.49 (*)  cached     5040          99.73    85.37 2.85  381   
            cached            12.5%     
___________________________________________________________________     
2.4.21-pre3 noncached  1407.8        95.11    25.75 9.68   **
2.5.49 (*)  noncached  1667.5        99.68    49.12 7.2   1461          
           non-cached        18.4%      
___________________________________________________________________
** iostats is broken at 2.4 due to driver problems.  

( If the table above gets distorted, or you want more details, please go to:
http://www.osdl.org/projects/dbt2dev/results/LKML_dbt2_2.4v2.5_both.html )


The results for 2.5 are significantly improved over 2.4, 12.5% for the
cached workload and 18.4% for the non-cached.

Notice that even though the %sys times are not particularly high at 2.4 ,
the metric improves.  Our examination of the statistics show that both
the cached and non-cached workloads are paging in the 2.4 case but are
not paging in the 2.5 case.  Since we use raw data files rather than file
system, we think that the 2.5 kernel is taking away memory from the mostly
unused file system buffer cache in favor of database cache, but cannot
do this in the 2.4.  Perhaps someone can confirm this? Any suggestions
for further improvement?

The %sys drops going from 2.4 to 2.5 in both cases.  We suspect this is
due to lack of paging in the 2.5 runs.

We saved system and database stats from these runs.  The system
configuration details and summarized stats can be found at the URL
given above.



Regards,

Mary Edie Meredith 
Mark Wong 
cliffw
Open Source Development Lab

OSDL DBT-2 Project information: http://sourceforge.net/projects/osdldbt

OSDL-DBT-2 tests on 4-way systems will be released soon as part of OSDL's
test suite in the Scalable Test Platform (STP) : http://www.osdl.org/stp/


(*)We needed to include Mathew Wilcox's flock patch so we could
stop and restart the database.  Note this patch should not be used
on any systems with NFS.  The patch is found at the following URL:
ftp://ftp.linux.org.uk/pub/linux/willy/patches/flock-2.5.49-2.diff



