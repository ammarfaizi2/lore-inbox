Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264285AbUACXfj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 18:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264319AbUACXfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 18:35:36 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:17924 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S264285AbUACXfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 18:35:31 -0500
Date: Sun, 4 Jan 2004 00:35:18 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: Soeren Sonnenburg <kernel@nn7.de>, Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>, gillb4@telusplanet.net
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
Message-ID: <20040103233518.GE3728@alpha.home.local>
References: <Pine.LNX.4.44.0401031439060.24942-100000@coffee.psychology.mcmaster.ca> <200401040800.06529.kernel@kolivas.org> <1073164240.9851.319.camel@localhost> <200401040815.54655.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401040815.54655.kernel@kolivas.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 08:15:54AM +1100, Con Kolivas wrote:
> The bash bug was waiting on a pipe problem; not just bash alone. I was just 
> offering a suggestion. I have no idea what exactly to blame without evidence 
> of what's at fault.

Well, I did a few tests here with both 2.4.23 and 2.6.1rc1. In fact, it is
also partially xterm which is to blame, because it is not really that fast
on 2.4. Look below :

Context
=======

- X not reniced (0)
- cd to a directory with about 2500 files
- ls -l

1) Simple standard 'ls -l' in an xterm
======================================

2.4.23$ time ls -l

real    0m0.444s
user    0m0.090s
sys     0m0.020s

2.6.1rc1$ time ls -l

real    0m3.995s
user    0m0.081s
sys     0m0.035s

2) introduction of a pipe : ls -l | cat
=======================================

2.4.23$ time ls -l |cat

real    0m0.444s
user    0m0.090s
sys     0m0.020s

2.6.1rc1$ time ls -l|cat

real    0m0.486s
user    0m0.048s
sys     0m0.029s

3) it is not xterm which gets all the CPU either :
==================================================

2.4.23$ time xterm -e sh -c "ls -l"

real    0m0.462s
user    0m0.140s
sys     0m0.040s

2.6.1rc1$ time xterm -e sh -c "ls -l"

real    0m4.010s
user    0m0.236s
sys     0m0.079s

4) CPU is eaten by the X server itself !
========================================

It appears that on 2.4.23, xterm quickly switches over to jump scrolling
which prevents X from eating all CPU. On 2.6.1rc1, it is not the case.
If I disable jump scrolling and list 2 directories totalizing 4000 files :

2.4.23$ time xterm +j -e sh -c "ls -l incoming tmp"

real    0m7.137s
user    0m0.390s
sys     0m0.080s

2.6.1rc1$ time xterm +j -e sh -c "ls -l incoming tmp"

real    0m7.113s
user    0m0.314s
sys     0m0.121s

And here is what 'top' says during last command :

top - 23:37:54 up 17 min,  5 users,  load average: 0.72, 0.62, 0.50
Tasks:  58 total,   4 running,  54 sleeping,   0 stopped,   0 zombie
Cpu(s):  94.5% user,   5.5% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    515292k total,   510688k used,     4604k free,   175784k buffers
Swap:   265064k total,        0k used,   265064k free,    19400k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command           
  234 root      16   0 22400  12m  11m S 90.0  2.4   2:20.01 X                 
  417 root      19   0  4764 2660 3844 R  7.3  0.5   0:00.24 xterm             
  418 willy     20   0  1900 1100 1304 R  2.3  0.2   0:00.10 ls                
  394 willy     16   0  1692  940 1556 R  0.5  0.2   0:00.94 top               
    1 root      16   0   348  192  316 S  0.0  0.0   0:05.05 init              
    2 root      34  19     0    0    0 S  0.0  0.0   0:00.00 ksoftirqd/0       
    3 root       5 -10     0    0    0 S  0.0  0.0   0:00.23 events/0          
    4 root       5 -10     0    0    0 S  0.0  0.0   0:00.24 kblockd/0         
    5 root      25   0     0    0    0 S  0.0  0.0   0:00.00 pdflush           

5) Tried again with X reniced to +10
====================================

2.6.1rc1$ xterm +j -e sh -c "ls -l incoming tmp"

top - 23:48:33 up 27 min,  6 users,  load average: 0.53, 0.46, 0.44
Tasks:  60 total,   2 running,  58 sleeping,   0 stopped,   0 zombie
Cpu(s):   4.9% user,   4.9% system,  90.2% nice,   0.0% idle,   0.0% IO-wait
Mem:    515292k total,   510652k used,     4640k free,   175712k buffers
Swap:   265064k total,        0k used,   265064k free,    19624k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command           
  234 root      35  10 22400  12m  11m R 92.0  2.4   3:58.50 X                 
  499 root      15   0  4764 2656 3844 S  4.0  0.5   0:00.24 xterm             
  500 willy     15   0  2024 1160 1416 S  3.0  0.2   0:00.10 ls                
    1 root      16   0   348  192  316 S  0.0  0.0   0:05.05 init              
    2 root      34  19     0    0    0 S  0.0  0.0   0:00.00 ksoftirqd/0       
    3 root       5 -10     0    0    0 S  0.0  0.0   0:00.28 events/0          
    4 root       5 -10     0    0    0 S  0.0  0.0   0:00.24 kblockd/0         
    5 root      25   0     0    0    0 S  0.0  0.0   0:00.00 pdflush           
    6 root      15   0     0    0    0 S  0.0  0.0   0:00.00 pdflush           

And now with jump scrolling enabled again with X still reniced to +10 :

2.4.23$ time xterm -e sh -c "ls -l incoming tmp"

real    0m0.648s
user    0m0.230s
sys     0m0.040s

2.6.1rc1$ time xterm -e sh -c "ls -l incoming tmp"

real    0m0.691s
user    0m0.230s
sys     0m0.063s

6) Conclusion
=============

Under 2.4, xterm uses jump scrolling which it does not use by default under
2.6 if X responds fast enough. The first dirty solution which comes to mind
is to renice X to >+10 to slow it a bit so that xterm hits the high water
level and jumps.

But it's not an effect of the scheduler alone, but a side effect of the
scheduler and xterm both trying to automatically adjust their behaviour in
a different manner. If either the scheduler or xterm was a bit smarter or
used different thresholds, the problem would go away. It would also explain
why there are people who cannot reproduce it. Perhaps a somewhat faster or
slower system makes the problem go away. Honnestly, it's the first time that
I notice that my xterms are jump-scrolling, it was so much fluid anyway.

BTW, I found an even simplest way to reproduce the problem while ensuring
that it is not I/O related. For this, I use the 'seq' utility :

2.4.23$ $ time xterm -e seq 1 4000

real    0m0.142s
user    0m0.060s
sys     0m0.030s

2.4.23$ time xterm +j -e seq 1 4000

real    0m4.079s
user    0m0.100s
sys     0m0.080s

Cheers,
Willy

