Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281126AbRKOWba>; Thu, 15 Nov 2001 17:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281128AbRKOWbV>; Thu, 15 Nov 2001 17:31:21 -0500
Received: from elin.scali.no ([62.70.89.10]:56335 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S281126AbRKOWbL>;
	Thu, 15 Nov 2001 17:31:11 -0500
Message-ID: <3BF44234.FFC3BE9@scali.no>
Date: Thu, 15 Nov 2001 23:31:16 +0100
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13win4lin i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: kswapd using a lot of CPU
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel/VM gurus,

What the f**k is going on here (RedHat 7.1 kernel-2.4.9-12smp, glibc-2.2.4-19)
?

 10:58pm  up 6 days, 12:06,  1 user,  load average: 3.33, 3.31, 3.20
146 processes: 142 sleeping, 4 running, 0 zombie, 0 stopped
CPU0 states: 36.2% user, 63.3% system, 35.4% nice,  0.0% idle
CPU1 states: 84.1% user, 15.1% system, 84.2% nice,  0.0% idle
Mem:   512244K av,  202012K used,  310232K free,    1072K shrd,   13480K buff
Swap: 2048248K av,       0K used, 2048248K free                   58708K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
    5 root      20   0     0    0     0 RW   78.4  0.0  97:45 kswapd
 3342 magma     20   2 71200  43M 15196 R N  60.2  8.7  54:20 MAGMAfill
 3341 magma     18   2 71516  44M 16044 R N  60.0  8.8  54:37 MAGMAfill


# vmstat 2
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 2  0  1      0 309100  13480  58932   2   3    10    15   31    32  18   1   4
 2  0  1      0 309076  13480  58940   0   0     0    28  180   161  60  40   0
 2  0  1      0 309020  13480  58944   0   0     0    46  215   191  60  40   0
 2  0  1      0 309080  13480  58948   0   0     0    20  152   143  61  39   0
 2  0  1      0 309088  13480  58948   0   0     0     6  131   141  59  41   0
 2  0  1      0 309064  13480  58952   0   0     0    12  109   129  59  41   0
 2  0  1      0 309028  13480  58956   0   0     0    56  167   153  57  43   0
 2  0  1      0 308912  13480  58960   0   0     0    32  211   201  60  39   0
 2  0  1      0 309072  13480  58960   0   0     0     0  115   118  62  38   0
 2  0  1      0 309072  13480  58960   0   0     0    12  134   142  60  40   0
 2  0  1      0 309076  13480  58960   0   0     0     0  104   122  59  41   0
 2  0  1      0 309072  13480  58960   0   0     0     0  130   127  61  39   0

kswapd is using plenty of CPU (this is, as you can see, a dual processor box,
more exactly 2xPIII 1GHz), but there's no swapping going on ?!?. And even more
strange is that there is actually nothing that is swapped out (2GB free).

If I try the following :

# cat /proc/swaps 
Filename                        Type            Size    Used    Priority
/dev/hda7                       partition       2048248 0       -1

# /sbin/swapoff /dev/hda7

Still kswapd is using a lot of CPU :

 11:07pm  up 6 days, 12:15,  1 user,  load average: 3.33, 3.33, 3.24
146 processes: 141 sleeping, 5 running, 0 zombie, 0 stopped
CPU0 states: 40.0% user, 58.0% system, 40.0% nice,  0.1% idle
CPU1 states: 69.1% user, 30.0% system, 68.0% nice,  0.0% idle
Mem:   512244K av,  324476K used,  187768K free,    1072K shrd,   13608K buff
Swap:       0K av,       0K used,       0K free                  151296K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
    5 root      20   0     0    0     0 RW   80.0  0.0 105:19 kswapd
 3342 magma     20   2 65036  37M 15368 R N  62.3  7.5  60:10 MAGMAfill
 3341 magma     18   2  104M  78M 16096 R N  60.5 15.7  60:12 MAGMAfill



When I do :

# /sbin/swapon /dev/hda7

Nothing changes for kswapd, but the swap device gets a lower priority :

# cat /proc/swaps 
Filename                        Type            Size    Used    Priority
/dev/hda7                       partition       2048248 0       -2


If I repetedly do 'swapoff/swapon' the Priority decreases each time.


If I try a test application I've written which just mallocs a given amount of
memory (I tried 450MBytes in this case), memsets it and then frees it, I'm able
to force something to swap out, but after the application has exited kswapd is
still using a lot of CPU.


The only thing that seems to solve the issue is to kill the two user processes
(MPI processes) that is also using CPU.

Any feedback is highly appreciated,

Thanks,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best   
 mailto:sp@scali.no  |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.12.2 -         
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >300MBytes/s and <4uS latency
