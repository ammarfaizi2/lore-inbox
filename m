Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264773AbSJOTcH>; Tue, 15 Oct 2002 15:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264777AbSJOTcH>; Tue, 15 Oct 2002 15:32:07 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:7606 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264773AbSJOTcE>;
	Tue, 15 Oct 2002 15:32:04 -0400
Message-ID: <3DAC7023.68FEB8A7@us.ibm.com>
Date: Tue, 15 Oct 2002 14:44:35 -0500
From: Mala Anand <mkanand@us.ibm.com>
Organization: IBM LTC Performance Team
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, davem@redhat.com, bhartner@us.ibm.com
Subject: context switches increased in 2.5.40 kernel
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see increased context switches running netperf3 on 2.5.40 kernel
compared to previous level kernels.
NAPI and TSO are disabled for this test. I disabled TSO as I saw,
interrupts dropping low in the middle of the test using TSO. This
problem was posted earlier at:
http://marc.theaimsgroup.com/?l=lse-tech&m=103339396818585&w=2

The tcp_stream throughput also degraded.  I am using SMP kernel on
an 2-way system with 1 gigabit ethernet adapter on each server and 
client system. 

The throughput results comparing 2.5.38 and 2.5.40:

           2.5.38              2.5.40       % difference
Msgsize     Kernel	       Kernel
(bytes)     Throughput	       Throughput
            Mbits/Sec          Mbits/Sec
512         568.7               488.1          -14%         
1024        629.9               534.8          -15%        
2048        673.4               473.6          _29.7%
4096        720.9               492.3          -31.7%
8192        779.6               667.5          -14.4%
16384       809.8               639.3          -21.1%
32768       757.6               672.3          -11.2%
65536       743.9               644.1          -13.4

The throughput of Netperf3 tcp_stream test has come down considerably
in 2.5.40 compared to 2.5.38 kernel. The vmstat data shows that the
interrupts have come down while the context switches have increased
substantially for the same idle time. 

The following is the vmstat (for every 4 seconds during the test) data 
taken during 8k message size test:


2.5.38 kernel
   procs                    memory    swap      io     system        
cpu
 r  b  w swpd   free   buff  cache  si  so  bi  bo   in    cs  us  sy 
id
 1  0  1    0 860564   6028  17160   0   0   0   1 65188  1761  0  71 
29
 1  0  1    0 860548   6036  17160   0   0   0   4 65219  1755  0  68 
31
 1  0  2    0 860536   6044  17160   0   0   0   4 65178  1767  0  68 
32
 1  0  1    0 860544   6052  17160   0   0   0   4 65095  1774  0  71 
28
 1  0  1    0 860532   6060  17160   0   0   0   4 64929  1656  0  68 
32
 1  0  1    0 860532   6060  17160   0   0   0   0 65117  1693  0  67 
32
 1  0  1    0 860340   6092  17160   0   0   0   4 65436  1606  0  71 
29
 1  0  2    0 860340   6092  17160   0   0   0   0 65572  1695  0  68 
32
 1  0  2    0 860328   6100  17160   0   0   0   4 65618  1682  0  71 
29
 1  0  2    0 860316   6108  17160   0   0   0   4 65674  1662  0  69 
31
 1  0  1    0 860304   6116  17160   0   0   0   4 65474  1638  0  68 
32
 1  0  0    0 860312   6124  17160   0   0   0   4 65701  1686  0  71 
29



2.5.40 kernel

   procs                      memory    swap      io   system        
cpu
 r  b  w swpd   free   buff  cache  si  so  bi  bo   in    cs  us  sy 
id
 1  0  2    0 855940   6236  20908   0   0   0   0 49151 82681  0  72 
28
 1  0  2    0 855952   6244  20908   0   0   0   4 49299 83239  0  72 
27
 1  0  3    0 855968   6252  20908   0   0   0   4 49215 82935  0  72 
28
 1  0  2    0 855932   6260  20908   0   0   0   4 49426 83486  0  72 
28
 1  0  3    0 855984   6268  20908   0   0   0   4 49407 83290  0  72 
27
 1  0  2    0 855788   6292  20908   0   0   0   4 50632 85295  0  72 
28
 1  0  2    0 855784   6300  20908   0   0   0   4 50697 85708  0  73 
27
 1  0  4    0 855748   6304  20908   0   0   0   3 50791 85757  0  73 
27
 1  0  2    0 855800   6308  20908   0   0   0   1 50880 86276  0  72 
27
 1  0  3    0 855760   6316  20908   0   0   0   4 50854 86024  0  73 
27
 1  0  2    0 855696   6324  20908   0   0   0   4 50463 85161  0  72 
28

The context switches increased from ~1600 to ~85000. 

The following are the readprofile from 2.5.38 and 2.5.40 kernels:

2.5.38 kernel:
-------------
 00000000 total                                100076
 c0105380 poll_idle                             32261
 c01a4480 __generic_copy_to_user                27229
 c01f00e0 e1000_intr                            11131
 c02cafe0 tcp_v4_rcv                             3009
 c02c2d80 tcp_rcv_established                    1515
 c02b0880 ip_route_input                         1327
 c01f02f0 e1000_clean_rx_irq                     1265
 c012f460 kmalloc                                1201
 c012f660 kfree                                  1168
 c02abba0 eth_type_trans                         1085
 c011b500 do_softirq                             1045
 c02b2cf0 ip_rcv                                 1033

2.5.40 kernel:
-------------
00000000 total                                 100132  
c0105380 poll_idle                              31011
c01a7a00 __generic_copy_to_user                 23215
c01f59c0 e1000_intr                              8253
c01145e0 schedule                                4556
c0114a00 __wake_up                               2867
c02da840 tcp_v4_rcv                              2009
c0132430 kfree                                   1977
c0132230 kmalloc                                 1785
c02d25c0 tcp_rcv_established                     1285
c0126240 context_thread                          1112
c01f5bd0 e1000_clean_rx_irq                      1096
c02bb3c0 eth_type_trans                          1052

As you can see the schedule and __wake_up are high in 2.5.40
kernel profile. The ticks spent in __generic_copy_to_user is lowered
indicating a drop in the data received. Does this have anything
to do with tcp_wakeup patch? In 2.5.38 kernel __wakeup is not
seen in the profile.




Regards,
    Mala


   Mala Anand
   IBM Linux Technology Center 
   E-mail:mkanand@us.ibm.com
   http://www-124.ibm.com/developerworks/oss/linux
   Phone:838-8088; Tie-line:678-8088
