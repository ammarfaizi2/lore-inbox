Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262096AbSI3N4W>; Mon, 30 Sep 2002 09:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262112AbSI3Nzd>; Mon, 30 Sep 2002 09:55:33 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:20452 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262096AbSI3Npu>;
	Mon, 30 Sep 2002 09:45:50 -0400
Subject: Network interrupt pause problem in 2.5.38 kernel
To: <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>,
       lse-tech@lists.sourceforge.net
Cc: "Bill Hartner" <bhartner@us.ibm.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFEBDCD60A.DF5A555A-ON87256C41.0056917B@boulder.ibm.com>
From: "Mala Anand" <manand@us.ibm.com>
Date: Mon, 30 Sep 2002 08:50:55 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 09/30/2002 07:50:55 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am seeing a network interrupt pause problem running Netperf3 on
kernel 2.5.38. Netperf3 TCP_STREAM test is run on 1 adapter/
1 connection configuration using SMP Kernel with maxcpus set to 1.

Two 996 MHz Pentium III systems with 4 gig memory/256KB L2 cache
Intel Gigabit Ethernet network card one each on server and client
2.5.38 kernel from www.kernel.org. No higmem support is enabled.
Intel e1000 driver (the one in the kernel) is used
Napi is not enabled.

The TCP_STREAM test was run with TCP-NO Deay ON, 64k socket buffer
size with a mtu size of 1500. The rest of tcp parameters used are
default values.

Running tcp_stream test for different message sizes, I noticed that
the interrupts are being paused for some of the tests. I ran 8 message
size and the following vmstat data for every 4 seconds show that
interrupts are paused occasinally during the test.

The test was run for 60 seconds and vmstat was collected for every 4
seconds. The vmstat log was edited to remove the first entry of the
run. The following vmstat is from the server and client for 2k and
4k message sizes:

message size: 2k  Throughput: 585.9 Mbits/sec
---------------------------------------------
SERVER:
   procs                    memory    swap      io     system     cpu
 r  b  w swpd   free   buff  cache  si  so  bi bo   in   cs  us  sy  id
 1  0  1   0 575580 108248  34136   0   0   0  20 55357   20  2  98  0
 1  0  1   0 575568 108256  34136   0   0   0   4 55621   19  2  98  0
 1  0  0   0 575576 108256  34136   0   0   0   0 55533   17  2  98  0
 1  0  1   0 575564 108264  34136   0   0   0   4 18424   11  1  33 67 ***
 1  0  1   0 575556 108272  34136   0   0   0   4 53502   19  2  99  0
 1  0  1   0 575544 108280  34136   0   0   0   4 53455   20  2  98  0
 1  0  1   0 575532 108288  34136   0   0   0   4 53513   19  2  98  0
 1  0  1   0 575528 108288  34136   0   0   0   0 53507   16  2  98  0
 1  0  1   0 575516 108296  34136   0   0   0  23 53510   19  2  98  0
 1  0  1   0 575524 108304  34140   0   0   0   8 53422   18  2  98  0
 1  0  1   0 575512 108312  34140   0   0   0   4 53511   19  2  98  0
 1  0  1   0 575500 108320  34140   0   0   0   4 53445   19  2  98  0
 1  0  1   0 575496 108320  34140   0   0   0   0 52943   16  2  98  0
 1  0  1   0 575484 108328  34140   0   0   0   4 53404   19  2  98  0

Message size:2k
---------------
CLIENT vmstat:
   procs                  memory     swap   io     system       cpu
 r  b  w swpd free   buff  cache   si so  bi bo   in   cs  us  sy  id
 1  0  0   0 773888  34492  35224  0  0   0   0 19906  1322  2  59  39
 1  0  1   0 773876  34500  35224  0  0   0   4 20035  1306  2  58  40
 1  0  0   0 773868  34508  35224  0  0   0   4 19928  1297  2  62  36
 1  0  0   0 773856  34516  35224  0  0   0   4 8977   452   1  28  72 ***
 1  0  0   0 773860  34524  35224  0  0   0   4 25267  1333  2  89   9
 1  0  0   0 773856  34524  35224  0  0   0   0 25197  1313  2  80  18
 1  0  0   0 773844  34532  35224  0  0   0   4 25223  1372  2  81  17
 1  0  1   0 773836  34540  35224  0  0   0   4 25233  1334  2  89   9
 1  0  0   0 773824  34548  35224  0  0   0   4 25261  1351  2  78  21
 1  0  1   0 773808  34556  35228  0  0   0   8 25218  1362  3  85  12
 1  0  1   0 773804  34556  35228  0  0   0   0 25250  1331  2  85  13
 1  0  0   0 773812  34564  35228  0  0   0   4 25208  1289  2  78  20
 1  0  1   0 773804  34572  35228  0  0   0   4 24982  1328  2  86  12
 1  0  1   0 773792  34580  35228  0  0   0   4 25206  1360  2  82  16

message size:4k  throughput: 574.5 Mbits/sec
--------------------------------------------
SERVER:
   procs                    memory    swap     io     system     cpu
 r  b  w swpd free   buff  cache    si  so  bi bo   in   cs  us sy  id
 1  0  1   0 574940 108556  34144   0   0   0  23 58303  20  1  99   0
 1  0  1   0 574928 108564  34144   0   0   0  23 58303  19  1  99   0
 0  0  0   0 574924 108564  34144   0   0   0   0 40233  14  1  68  32
 0  0  0   0 574912 108572  34144   0   0   0   4 1002   6   0   0 100 ***
 1  0  1   0 574904 108576  34148   0   0   0   4 36228  12  1  63  37
 1  0  1   0 574896 108580  34148   0   0   0   8 56477  19  1  99   0
 1  0  1   0 574908 108588  34148   0   0   0   4 56311  19  1  99   0
 1  0  1   0 574904 108588  34148   0   0   0   0 55842  16  1  99   0
 1  0  1   0 574892 108596  34148   0   0   0   4 56315  19  1  99   0
 1  0  1   0 574884 108604  34148   0   0   0   4 56381  19  1  99   0
 1  0  1   0 574872 108612  34148   0   0   0   7 56352  19  1  99   0
 1  0  0   0 574860 108620  34148   0   0   0   4 56392  19  1  99   0
 1  0  1   0 574856 108620  34148   0   0   0   0 56387  16  1  99   0
 1  0  1   0 574864 108628  34148   0   0   0   4 56326  19  1  99   0

message size4k
--------------
CLIENT
   procs                    memory    swap   io    system         cpu
 r  b  w swpd free   buff  cache  si  so  bi bo   in    cs  us  sy  id
 1  0  0  0 773448  34908  35236   0   0   0  0 16566  1532  1  60  39
 1  0  0  0 773420  34916  35236   0   0   0  4 16508  1553  1  52  46
 0  0  0  0 773352  34924  35236   0   0   0  4 10620   965  0  36  64
 0  0  0  0 773340  34932  35236   0   0   0 39 1010     5   0   0 100 ***
 1  0  0  0 773408  34940  35240   0   0   0  4 14732  1121  1  56  44
 1  0  0  0 773404  34940  35240   0   0   0  0 20551  1597  1  80  19
 1  0  0  0 773392  34948  35240   0   0   0  8 20492  1608  1  82  16
 1  0  0  0 773384  34956  35240   0   0   0  4 20432  1675  1  76  22
 1  0  0  0 773396  34964  35240   0   0   0  4 20544  1608  1  78  21
 1  0  0  0 773384  34972  35240   0   0   0  4 20551  1595  1  82  16
 1  0  0  0 773380  34972  35240   0   0   0  0 20554  1615  1  78  21
 1  0  0  0 773368  34980  35240   0   0   0  4 20526  1598  2  80  19
 1  0  0  0 773360  34988  35240   0   0   0  7 20578  1602  1  80  19
 1  0  0  0 773348  34996  35240   0   0   0  4 20529  1604  1  79  20

I have seen the number of interrupts go down moderately (10-20%) on
2.5.33 kernel during tcp_stream test. But only on 2.5.38 I see
interrupts pausing as shown in the above (***) vmstat data.Out of
3 runs for each message size I see this problem 2 times mostly.
I have not tested on other kernels, however I have not seen this
problem in 2.5.32. Has anyone seen this problem.

Regards,
    Mala


   Mala Anand
   IBM Linux Technology Center - Kernel Performance
   E-mail:manand@us.ibm.com
   http://www-124.ibm.com/developerworks/opensource/linuxperf
   http://www-124.ibm.com/developerworks/projects/linuxperf
   Phone:838-8088; Tie-line:678-8088




