Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263228AbUJ2KbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbUJ2KbJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 06:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263231AbUJ2KaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 06:30:13 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:47884 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S263226AbUJ2K2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 06:28:53 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re:Swap strangeness: total VIRT ~23mb for all processes, swap 91156k used - impossible?
Date: Fri, 29 Oct 2004 13:28:09 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200410281333.53976.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.53.0410281330030.12977@yvahk01.tjqt.qr> <200410281444.53443.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200410281444.53443.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Message-Id: <200410291327.50688.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_5shgBVgzCXVjJ8e"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_5shgBVgzCXVjJ8e
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> > Have <= 128 MB RAM? Have a heavy busy system (even with >= 128)?
> 
> 128mb. System was idle, fresh after boot.
> 
> Seems I wasn't clear enough. I will try harder now:
> 
> Even if I add up size of every process, *counting libc shared pages
> once per process* (which will overestimate memory usage), I arrive at
> 23mb *total memory required by all processes*. How come kernel
> found 90mb to swap out? There is NOTHING to swap out except those
> 23mb!
> 
> (Of course when oom_trigger was running, kernel first swapped out
> those 23mb and then started swapping out momery taken by oom_trigger
> itself, but when oom_trigger was killed, its RAM *and* swapspace
> should be deallocated. Thus I expected to see ~20 mb swap usage).

I did more testing. It does not happen right after boot.

It is not 100% reproducible, I *think* I need to fill pagecache
with filesystem cache first
(grep -rF qjklwmhflakwghfjklah $source_tree does this nicely)
and let the box sit idle for a minute or two.

Then I run oom_trigger. Typically it eats ~350mb and is killed.
That is, when things are working normally.

But sometimes it eats only ~250mb, and top before/after that looks
like this:

before oom: 
top - 08:14:12 up 15 min,  1 user,  load average: 0.37, 0.14, 0.06
Tasks:  78 total,   1 running,  77 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.4% us,  1.1% sy,  0.0% ni, 94.2% id,  4.2% wa,  0.1% hi,  0.0% si
Mem:    112376k total,   108564k used,     3812k free,    14968k buffers
Swap:   262136k total,     2592k used,   259544k free,    80516k cached

after oom:
top - 08:14:27 up 15 min,  1 user,  load average: 0.52, 0.18, 0.07
Tasks:  78 total,   1 running,  77 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.4% us,  1.3% sy,  0.0% ni, 93.4% id,  4.8% wa,  0.1% hi,  0.0% si
Mem:    112376k total,   107704k used,     4672k free,    10336k buffers
Swap:   262136k total,    84168k used,   177968k free,     4056k cached

Both mem and swap 'used' values look strange.

Complete top outputs are attached.

Subsequently I automated the thing, and another such
event was captured (tarball of /proc/N/status before
and after OOM is attached):

#!/bin/sh
cd status_before
echo "PID.... Before......................... After......................"
for b in *; do
    a=../status_after/$b
    echo "$b:"$'\t'`grep VmSize $b`$'\t'`grep VmRSS $b`$'\t'`grep VmSize $a`$'\t'`grep VmRSS $a`
done

PID.... Before......................... After......................
1:	VmSize: 968 kB	VmRSS: 56 kB	VmSize: 968 kB	VmRSS: 4 kB
1094:	VmSize: 1212 kB	VmRSS: 4 kB	VmSize: 1212 kB	VmRSS: 0 kB
1101:	VmSize: 1548 kB	VmRSS: 960 kB	VmSize: 1548 kB	VmRSS: 0 kB
1102:	VmSize: 340 kB	VmRSS: 28 kB	VmSize: 340 kB	VmRSS: 0 kB
1208:	VmSize: 1660 kB	VmRSS: 896 kB	VmSize: 1660 kB	VmRSS: 772 kB
125:
1459:	VmSize: 960 kB	VmRSS: 548 kB	VmSize: 960 kB	VmRSS: 484 kB
1460:	VmSize: 968 kB	VmRSS: 596 kB
2:
23:
247:
269:	VmSize: 1212 kB	VmRSS: 76 kB	VmSize: 1212 kB	VmRSS: 0 kB
3:
4:
47:
471:	VmSize: 1352 kB	VmRSS: 4 kB	VmSize: 1352 kB	VmRSS: 0 kB
48:
49:
50:
51:
539:	VmSize: 52 kB	VmRSS: 16 kB	VmSize: 52 kB	VmRSS: 4 kB
549:	VmSize: 348 kB	VmRSS: 4 kB	VmSize: 348 kB	VmRSS: 0 kB
555:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
556:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
557:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
558:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
559:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
560:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
561:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
562:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
563:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
565:	VmSize: 28 kB	VmRSS: 4 kB	VmSize: 28 kB	VmRSS: 0 kB
572:	VmSize: 28 kB	VmRSS: 4 kB	VmSize: 28 kB	VmRSS: 0 kB
577:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
578:	VmSize: 1260 kB	VmRSS: 4 kB	VmSize: 1260 kB	VmRSS: 0 kB
588:	VmSize: 3076 kB	VmRSS: 3076 kB	VmSize: 3076 kB	VmRSS: 3076 kB
589:	VmSize: 28 kB	VmRSS: 24 kB	VmSize: 28 kB	VmRSS: 24 kB
593:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
594:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
595:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
602:	VmSize: 36 kB	VmRSS: 32 kB	VmSize: 36 kB	VmRSS: 28 kB
604:	VmSize: 28 kB	VmRSS: 28 kB	VmSize: 28 kB	VmRSS: 28 kB
611:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
612:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
633:	VmSize: 2492 kB	VmRSS: 920 kB	VmSize: 2492 kB	VmRSS: 760 kB
634:	VmSize: 28 kB	VmRSS: 4 kB	VmSize: 28 kB	VmRSS: 0 kB
640:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
641:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
642:	VmSize: 28 kB	VmRSS: 4 kB	VmSize: 28 kB	VmRSS: 0 kB
648:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
649:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
650:	VmSize: 44 kB	VmRSS: 4 kB	VmSize: 44 kB	VmRSS: 0 kB
656:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
657:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
658:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
659:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
660:	VmSize: 28 kB	VmRSS: 4 kB	VmSize: 28 kB	VmRSS: 0 kB
663:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
664:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
665:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
666:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
667:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
668:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
669:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
672:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
673:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
674:	VmSize: 1416 kB	VmRSS: 368 kB	VmSize: 1416 kB	VmRSS: 180 kB
678:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
679:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
680:	VmSize: 20 kB	VmRSS: 16 kB	VmSize: 20 kB	VmRSS: 0 kB
682:	VmSize: 36 kB	VmRSS: 24 kB	VmSize: 36 kB	VmRSS: 0 kB
695:	VmSize: 28 kB	VmRSS: 4 kB	VmSize: 28 kB	VmRSS: 0 kB
696:	VmSize: 1824 kB	VmRSS: 508 kB	VmSize: 1824 kB	VmRSS: 504 kB
715:	VmSize: 28 kB	VmRSS: 24 kB	VmSize: 28 kB	VmRSS: 0 kB
718:	VmSize: 708 kB	VmRSS: 4 kB	VmSize: 708 kB	VmRSS: 0 kB
723:	VmSize: 708 kB	VmRSS: 4 kB	VmSize: 708 kB	VmRSS: 0 kB
724:	VmSize: 708 kB	VmRSS: 4 kB	VmSize: 708 kB	VmRSS: 0 kB
731:	VmSize: 28 kB	VmRSS: 28 kB	VmSize: 28 kB	VmRSS: 0 kB
750:	VmSize: 708 kB	VmRSS: 4 kB	VmSize: 708 kB	VmRSS: 0 kB
754:	VmSize: 708 kB	VmRSS: 4 kB	VmSize: 708 kB	VmRSS: 0 kB
759:	VmSize: 708 kB	VmRSS: 4 kB	VmSize: 708 kB	VmRSS: 0 kB
--
vda





--Boundary-00=_5shgBVgzCXVjJ8e
Content-Type: text/plain;
  charset="koi8-r";
  name="after"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="after"

top - 08:14:27 up 15 min,  1 user,  load average: 0.52, 0.18, 0.07
Tasks:  78 total,   1 running,  77 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.4% us,  1.3% sy,  0.0% ni, 93.4% id,  4.8% wa,  0.1% hi,  0.0% si
Mem:    112376k total,   107704k used,     4672k free,    10336k buffers
Swap:   262136k total,    84168k used,   177968k free,     4056k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND            
 1470 root      15   0  1652  788 1520 R  2.0  0.7   0:00.01 top                
    1 root      16   0   968    4  892 S  0.0  0.0   0:01.27 init               
    2 root      34  19     0    0    0 S  0.0  0.0   0:00.00 ksoftirqd/0        
    3 root       5 -10     0    0    0 S  0.0  0.0   0:00.03 events/0           
    4 root       5 -10     0    0    0 S  0.0  0.0   0:00.00 khelper            
   23 root       5 -10     0    0    0 S  0.0  0.0   0:00.08 kblockd/0          
   47 root      15   0     0    0    0 S  0.0  0.0   0:00.04 pdflush            
   50 root      14 -10     0    0    0 S  0.0  0.0   0:00.00 aio/0              
   49 root      15   0     0    0    0 S  0.0  0.0   0:03.60 kswapd0            
   51 root      15   0     0    0    0 S  0.0  0.0   0:00.00 cifsoplockd        
  125 root      25   0     0    0    0 S  0.0  0.0   0:00.00 kseriod            
  247 root       5 -10     0    0    0 S  0.0  0.0   0:00.00 reiserfs/0         
  269 root      16   0  1212    4 1180 S  0.0  0.0   0:00.01 udevd              
  471 rpc       16   0  1360    4 1308 S  0.0  0.0   0:00.00 rpc.portmap        
  538 root      15   0    52   16   16 S  0.0  0.0   0:00.02 svscan             
  548 root      16   0   348    4  316 S  0.0  0.0   0:00.00 sleep              
  554 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  555 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  556 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  557 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  558 root      18   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  559 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  560 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  561 root      18   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  562 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  564 root      15   0  1260    4 1228 S  0.0  0.0   0:00.03 gpm                
  565 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  570 daemon    16   0    28    4   20 S  0.0  0.0   0:00.00 multilog           
  575 root      16   0  3076 3076 2456 S  0.0  2.7   0:00.02 ntpd               
  581 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  582 root      17   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  583 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  584 logger    17   0    28   28   20 S  0.0  0.0   0:00.00 multilog           
  599 daemon    18   0    28    4   20 S  0.0  0.0   0:00.00 multilog           
  602 daemon    17   0    28    4   20 S  0.0  0.0   0:00.00 multilog           
  607 root      18   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  608 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  617 root      17   0    36   28   16 S  0.0  0.0   0:00.01 socklog            
  625 daemon    17   0    28    4   20 S  0.0  0.0   0:00.00 multilog           
  626 root      18   0  2492  700 2400 S  0.0  0.6   0:00.11 sshd               
  630 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  631 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  633 root      18   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  634 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  644 apache    15   0    28    4   20 S  0.0  0.0   0:00.00 multilog           
  650 root      16   0    44    4   36 S  0.0  0.0   0:00.00 tcpserver          
  677 daemon    18   0    28    4   20 S  0.0  0.0   0:00.00 multilog           
  681 root      18   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  682 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  683 root      19   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  684 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  685 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  707 daemon    18   0    28    4   20 S  0.0  0.0   0:00.00 multilog           
  717 root      17   0  1824  508 1528 S  0.0  0.5   0:00.01 login              
  722 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  723 root      16   0   708    4  576 S  0.0  0.0   0:00.00 getty              
  728 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  729 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  730 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  731 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  732 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  733 logger    16   0    36    4   16 S  0.0  0.0   0:00.00 socklog            
  734 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  737 root      16   0   708    4  576 S  0.0  0.0   0:00.00 getty              
  742 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  743 root      16   0  1376  120 1320 S  0.0  0.1   0:00.02 automount          
  745 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  746 root      20   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  747 root      18   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  753 root      16   0   708    4  576 S  0.0  0.0   0:00.00 getty              
  754 root      16   0   708    4  576 S  0.0  0.0   0:00.00 getty              
  755 root      16   0   708    4  576 S  0.0  0.0   0:00.00 getty              
  758 root      16   0   708    4  576 S  0.0  0.0   0:00.00 getty              
  762 logger    16   0    28    4   20 S  0.0  0.0   0:00.00 multilog           
  776 logger    16   0    28    4   20 S  0.0  0.0   0:00.01 multilog           
 1060 root      16   0  1216  484  892 S  0.0  0.4   0:00.02 bash               
 1322 root      15   0     0    0    0 S  0.0  0.0   0:00.00 pdflush            
 1325 user0     16   0  1656  768 1520 S  0.0  0.7   0:01.13 top                


--Boundary-00=_5shgBVgzCXVjJ8e
Content-Type: text/plain;
  charset="koi8-r";
  name="before"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="before"

top - 08:14:12 up 15 min,  1 user,  load average: 0.37, 0.14, 0.06
Tasks:  78 total,   1 running,  77 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.4% us,  1.1% sy,  0.0% ni, 94.2% id,  4.2% wa,  0.1% hi,  0.0% si
Mem:    112376k total,   108564k used,     3812k free,    14968k buffers
Swap:   262136k total,     2592k used,   259544k free,    80516k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND            
    1 root      16   0   968    4  892 S  0.0  0.0   0:01.27 init               
    2 root      34  19     0    0    0 S  0.0  0.0   0:00.00 ksoftirqd/0        
    3 root       5 -10     0    0    0 S  0.0  0.0   0:00.03 events/0           
    4 root       5 -10     0    0    0 S  0.0  0.0   0:00.00 khelper            
   23 root       5 -10     0    0    0 S  0.0  0.0   0:00.07 kblockd/0          
   47 root      15   0     0    0    0 S  0.0  0.0   0:00.03 pdflush            
   50 root      14 -10     0    0    0 S  0.0  0.0   0:00.00 aio/0              
   49 root      15   0     0    0    0 S  0.0  0.0   0:02.28 kswapd0            
   51 root      15   0     0    0    0 S  0.0  0.0   0:00.00 cifsoplockd        
  125 root      25   0     0    0    0 S  0.0  0.0   0:00.00 kseriod            
  247 root       5 -10     0    0    0 S  0.0  0.0   0:00.00 reiserfs/0         
  269 root      16   0  1212   76 1180 S  0.0  0.1   0:00.01 udevd              
  471 rpc       16   0  1360    4 1308 S  0.0  0.0   0:00.00 rpc.portmap        
  538 root      16   0    52   16   16 S  0.0  0.0   0:00.02 svscan             
  548 root      16   0   348    4  316 S  0.0  0.0   0:00.00 sleep              
  554 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  555 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  556 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  557 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  558 root      18   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  559 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  560 root      16   0    20   16   16 S  0.0  0.0   0:00.00 supervise          
  561 root      18   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  562 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  564 root      15   0  1260  140 1228 S  0.0  0.1   0:00.03 gpm                
  565 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  570 daemon    17   0    28   28   20 S  0.0  0.0   0:00.00 multilog           
  575 root      16   0  3076 3076 2456 S  0.0  2.7   0:00.02 ntpd               
  581 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  582 root      17   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  583 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  584 logger    17   0    28   28   20 S  0.0  0.0   0:00.00 multilog           
  599 daemon    18   0    28    4   20 S  0.0  0.0   0:00.00 multilog           
  602 daemon    17   0    28    4   20 S  0.0  0.0   0:00.00 multilog           
  607 root      18   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  608 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  617 root      17   0    36   32   16 S  0.0  0.0   0:00.01 socklog            
  625 daemon    17   0    28    4   20 S  0.0  0.0   0:00.00 multilog           
  626 root      18   0  2492  700 2400 S  0.0  0.6   0:00.11 sshd               
  630 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  631 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  633 root      18   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  634 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  644 apache    15   0    28    4   20 S  0.0  0.0   0:00.00 multilog           
  650 root      16   0    44    4   36 S  0.0  0.0   0:00.00 tcpserver          
  677 daemon    18   0    28    4   20 S  0.0  0.0   0:00.00 multilog           
  681 root      18   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  682 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  683 root      19   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  684 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  685 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  707 daemon    18   0    28    4   20 S  0.0  0.0   0:00.00 multilog           
  717 root      17   0  1824  508 1528 S  0.0  0.5   0:00.01 login              
  722 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  723 root      16   0   708    4  576 S  0.0  0.0   0:00.00 getty              
  728 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  729 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  730 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  731 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  732 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  733 logger    16   0    36   24   16 S  0.0  0.0   0:00.00 socklog            
  734 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  737 root      16   0   708    4  576 S  0.0  0.0   0:00.00 getty              
  742 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  743 root      16   0  1376  140 1320 S  0.0  0.1   0:00.02 automount          
  745 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  746 root      20   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  747 root      18   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  753 root      16   0   708    4  576 S  0.0  0.0   0:00.00 getty              
  754 root      16   0   708    4  576 S  0.0  0.0   0:00.00 getty              
  755 root      16   0   708    4  576 S  0.0  0.0   0:00.00 getty              
  758 root      16   0   708    4  576 S  0.0  0.0   0:00.00 getty              
  762 logger    16   0    28    4   20 S  0.0  0.0   0:00.00 multilog           
  776 logger    16   0    28   28   20 S  0.0  0.0   0:00.01 multilog           
 1060 root      16   0  1216  492  892 S  0.0  0.4   0:00.02 bash               
 1322 root      15   0     0    0    0 S  0.0  0.0   0:00.00 pdflush            
 1325 user0     16   0  1656  892 1520 S  0.0  0.8   0:01.08 top                
 1467 root      15   0  1652  788 1520 R  0.0  0.7   0:00.00 top                


--Boundary-00=_5shgBVgzCXVjJ8e
Content-Type: application/x-tbz;
  name="proc.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="proc.tar.bz2"

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
6SIfTERP/4u5IpwoSHS1ZLEA

--Boundary-00=_5shgBVgzCXVjJ8e--

