Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262885AbSJaRtA>; Thu, 31 Oct 2002 12:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262888AbSJaRs7>; Thu, 31 Oct 2002 12:48:59 -0500
Received: from mg03.austin.ibm.com ([192.35.232.20]:35547 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262885AbSJaRs5>; Thu, 31 Oct 2002 12:48:57 -0500
Message-ID: <3DC16DF5.E4969AA7@austin.ibm.com>
Date: Thu, 31 Oct 2002 11:52:53 -0600
From: Bill Hartner <hartner@austin.ibm.com>
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: cmm@us.ibm.com, Hugh Dickins <hugh@veritas.com>, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: [PATCH]updated ipc lock patch [PERFORMANCE RESULTS]
References: <Pine.LNX.4.44.0210211946470.17128-100000@localhost.localdomain> <3DB86B05.447E7410@us.ibm.com> <3DB87458.F5C7DABA@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton wrote:
> 
> mingming cao wrote:
> >
> > Hi Andrew,
> >
> > Here is the updated ipc lock patch:
> 
> 
> So to be able to commend this change to Linus I'd have to rely on
> assurances from people who _do_ understand IPC (Hugh?) and on lots
> of testing.
> 
> So yes, I'll include it, and would solicit success reports from
> people who are actually exercising that code path, thanks.
> 

Andrew,

I tested Mingming's RCU ipc lock patch using a *new* microbenchmark - semopbench.
semopbench was written to test the performance of Mingming's patch.
I also ran a 3 hour stress and it completed successfully.

Explanation of the microbenchmark is below the results.
Here is a link to the microbenchmark source.

http://www-124.ibm.com/developerworks/opensource/linuxperf/semopbench/semopbench.c

SUT : 8-way 700 Mhz PIII

I tested 2.5.44-mm2 and 2.5.44-mm2 + RCU ipc patch

>semopbench -g 64 -s 16 -n 16384 -r > sem.results.out
>readprofile -m /boot/System.map | sort -n +0 -r > sem.profile.out

The metric is seconds / per repetition.  Lower is better.
                    
kernel              run 1     run 2
                    seconds   seconds
==================  =======   =======
2.5.44-mm2          515.1       515.4
2.5.44-mm2+rcu-ipc   46.7        46.7

With Mingming's patch, the test completes 10X faster.

-----

2.4.44-mm2 readprofile shows 70 % of 8 CPUs spinning on .text.lock.sem :

http://www-124.ibm.com/developerworks/opensource/linuxperf/semopbench/sem.profile.1.out

2.5.44-mm2 + Mingming's patch shows that the spin on .text.lock.sem is gone :

http://www-124.ibm.com/developerworks/opensource/linuxperf/semopbench/sem.rcu.profile.1.out

Here is the semopbench results for 2.5.44-mm2 :

http://www-124.ibm.com/developerworks/opensource/linuxperf/semopbench/sem.results.1.out

Here is the semopbench results for 2.5.44-mm2 + Mingming's patch :

http://www-124.ibm.com/developerworks/opensource/linuxperf/semopbench/sem.rcu.results.1.out

-----

Here is some info on how the microbenchmark works :

>semopbench -g 64 -s 16 -n 16384 -r

-g 64 creates 64 sema4 groups

group0
group1
...
group63

-s 16 creates 16 sema4s in each group

group0  - sem0, sem1, ... sem15
group1  - sem0, sem1, ... sem15
...
group63 - sem0, sem1, ... sem15

For each of the 1024 (64*16) sema4s, a process is forked and sleeps on
it's own sema4.  When the test starts, the master process will post the
sema4 for the 1st process in each group.

When the 1st process in each group wakes up it will :

	(a) resets it's own sema4
	(b) post the sema4 for the next process in the group
	(c) waits on his own sema4

-n 16384 runs through each sema4 group in the above manner 16384 times.

semopbench reports :

(1) average microseconds that it takes each process to complete repetitions.
(2) CPU utilization

-d turns on debug printfs
-v turns on per process times.
-r does a readprofile -r , reset of the profile buffer before test starts

Bill Hartner
-- 
IBM Linux Technology Center Performance Team
http://www-124.ibm.com/developerworks/oss/linux
hartner@austin.ibm.com
