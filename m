Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291247AbSAaTsN>; Thu, 31 Jan 2002 14:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291251AbSAaTsE>; Thu, 31 Jan 2002 14:48:04 -0500
Received: from mg02.austin.ibm.com ([192.35.232.12]:49563 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S291247AbSAaTrt>; Thu, 31 Jan 2002 14:47:49 -0500
Message-Id: <200201311947.NAA25750@popmail.austin.ibm.com>
Content-Type: text/plain; charset=US-ASCII
From: Andrew Theurer <habanero@us.ibm.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: (O)1 Netbench results and some problems
Date: Thu, 31 Jan 2002 11:45:36 -0800
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I have run some Netbench tests on Ingo's scheduler (J7), and I'd like
to share the results here.  Included below is a text version of the
index.html on:

http://lse.sourceforge.net/benchmarks/netbench/results/february_2002/sched/

Please take a look at the "Notes" section at the bottom.  I am having
trouble with the scheduler on uniprocessor on high loads.  I there is
anything I can do to help resolve this problem, please let me know!

Thanks,

Andrew Theurer


>>index.html
These results compare the linux scheduler to 
the (O)1 scheduler on 2.4.17.  Version J7 of 
the (0)1 scheduler is used here. 

Results can be found here: 
                                                    Peak Throughput 
./up                       Uniprocessor results 
./up/baseline              Default scheduler         275.477 Mbps 
./up/o1                    (O)1 scheduler            289.221 Mbps 

./4p                       4-way SMP results 
./4p/affinity               IRQ & process affinity 
./4p/affinity/baseline     Default scheduler         741.147 Mbps 
./4p/affinity/o1           (O)1 scheduler            774.804 Mbps 
./4p/no_affinity           No IRQ & process affinity 
./4p/no_affinity/baseline  Default scheduler         596.774 Mbps 
./4p/no_affinity/o1        (O)1 scheduler            623.589 Mbps 

Under each of these results are more directories and files: 

./netbench              NetBench results in Excel 
./sar                   Sysstat files 
./proc 
./samba                 Samba log files 
./config-`uname -r`     .config from kernel build 
sysctl.conf 
dropped_packets.txt     Any dropped packets during test 
  

Hardware: 

Server 
------ 
4 x 700 MHz PIIIXeon, 1 MB L2 
2.5 GB memory 
4 Alteon Gbps Ethernet adapters 
14 15k rpm SCSI, RAID 5 
  

Clients (48) 
------- 
866 MHz PIII, 256 MB 
100 Mbps Ethernet 
  

Network 
------- 
2 Switches, 2 Gbps and 24 100 Mbps ports per switch 
Each switch has 2 VLANS, for a total of 4 networks 
  

Notes: 

Good News: 4-way tests were conducted initially, and when using affinity, 
results using the (O)1 scheduler showed a 4.54% increase in peak throughput.  
The same tests were run without affinity, and results using the (O)1 
scheduler showed a 4.49% increase in throughput.  This was a little 
surprising, since previous kernprofs on the default scheduler showed only 
about 2% in schedule. 

Bad News: Now, on to the uniprocessor results.  Every single test with the 
(O)1 scheduler resulted in some client errors.  These tests typically start 
with 4 clients, and add 4 more clients for each test case until 48 clients 
are used (that's all we have).  The (O)1 scheduler would run without client 
errors until 20 clients were reached.  Clients would complain about various 
failed attempts and doing an SMB operation. 

Now, none of these problems were evident with the default scheduler.  I did 
some poking around during one of the tests. Things like "ps" would take more 
than 2 minutes to start.  Actually, attempting to start any new task would be 
delayed until the current NetBench test case would complete (each test case 
runs for 3 minutes).  With the default scheduler, response time was 
excellent, within 1 second, even with a run queue length in the 40's. 

I think it's safe to say these two side affects are related.  Both the "ps" 
and "smbd" seem to have problems getting on to a run queue.  The Netbench 
test is throttled, so all of the smbd processes get a chance to sit on the 
wait queue for a while.  I'm not sure why occasionally one of these smbd 
processes has a very difficult time getting a shot on a run queue. 

There is some good news in this.  Results using the (O)1 scheduler still 
showed a higher peak throughput than the default scheduler, despite the 
client errors. 
  
So, I am looking for some guidance here.  Has anyone seen this behavior with 
(O)1 on high load workloads?  What's going on here? 

Andrew Theurer 
habanero@us.ibm.com 
  
