Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263796AbUADLrB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 06:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264291AbUADLrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 06:47:00 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:48644 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263796AbUADLq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 06:46:57 -0500
Date: Sun, 4 Jan 2004 12:46:35 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Lincoln Dale <ltd@cisco.com>, Soeren Sonnenburg <kernel@nn7.de>,
       Con Kolivas <kernel@kolivas.org>, Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>, gillb4@telusplanet.net
Subject: Nicks's scheduler's OK [was Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!]
Message-ID: <20040104114635.GA14433@alpha.home.local>
References: <200401041242.47410.kernel@kolivas.org> <Pine.LNX.4.44.0401031439060.24942-100000@coffee.psychology.mcmaster.ca> <200401040815.54655.kernel@kolivas.org> <20040103233518.GE3728@alpha.home.local> <200401041242.47410.kernel@kolivas.org> <5.1.0.14.2.20040104195316.02151e98@171.71.163.14> <3FF7DA24.40802@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF7DA24.40802@cyberone.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 08:17:24PM +1100, Nick Piggin wrote:
> 
> Or, out of interest, an alternate scheduler?
> 
> http://www.kerneltrap.org/~npiggin/w29p2.gz
> (applies 2.6.1-rc1-mm1, please renice X to -10 or so)

Nick's scheduler seems rather interesting. X is nearly insensible to renice
as it was in 2.4. I cannot get a slow scrolling anymore except with xterm +j.
And the differences in time between renice -15 and renice +10 are about 5%,
which is perfectly acceptable to me. I got back the 2.4 behaviour (= a usable
desktop). Now recompiling Con's "noint" patch on 2.6.0 for reference.

Cheers,
Willy

1) X not reniced.
=================

w29p2$ time xterm -e seq 1 5000

real    0m0.487s
user    0m0.244s
sys     0m0.075s

w29p2$ time xterm -e sh -c "ls -l incoming tmp"

real    0m1.000s
user    0m0.491s
sys     0m0.106s

2) Now renicing X to -10 as suggested by Nick
=============================================

w29p2$ time xterm -e sh -c "ls -l incoming tmp"

real    0m0.998s
user    0m0.476s
sys     0m0.126s

w29p2$ time xterm -e seq 1 5000

real    0m0.420s
user    0m0.276s
sys     0m0.082s

3) Now renicing X to +10 to compare with my previous tests
==========================================================

w29p2$ time xterm -e seq 1 5000

real    0m0.528s
user    0m0.282s
sys     0m0.056s

w29p2$ time xterm -e sh -c "ls -l incoming tmp"

real    0m0.967s
user    0m0.498s
sys     0m0.111s

w29p2$ time find incoming tmp |wc -l
  204276

real    0m0.937s
user    0m0.299s
sys     0m0.593s

w29p2$ time xterm -e sh -c "find incoming tmp"

real    0m21.368s
user    0m5.838s
sys     0m1.341s

top - 12:31:23 up 11 min,  6 users,  load average: 0.59, 0.68, 0.39
Tasks:  61 total,   2 running,  59 sleeping,   0 stopped,   0 zombie
Cpu(s):  29.1% user,   6.8% system,  64.1% nice,   0.0% idle,   0.0% IO-wait
Mem:    515248k total,   231160k used,   284088k free,    99172k buffers
Swap:   265064k total,        0k used,   265064k free,    45328k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command           
  302 root      50  10 21500  11m  11m R 63.9  2.3   1:41.67 X                 
  475 root      37   0  4764 2660 3844 S 31.0  0.5   0:01.68 xterm             
  476 willy     39   0  1420  540 1252 S  3.9  0.1   0:00.23 find              
    1 root      25   0   348  192  316 S  0.0  0.0   0:05.06 init              
    2 root      41  19     0    0    0 S  0.0  0.0   0:00.00 ksoftirqd/0       
    3 root      12 -10     0    0    0 S  0.0  0.0   0:00.20 events/0          
    4 root      16 -10     0    0    0 S  0.0  0.0   0:00.03 kblockd/0         

4) Same with renice -15 :
=========================

w29p2$ time xterm -e sh -c "find incoming tmp"

real    0m19.147s
user    0m5.085s
sys     0m1.238s

top - 12:33:33 up 13 min,  6 users,  load average: 0.65, 0.68, 0.42
Tasks:  61 total,   4 running,  57 sleeping,   0 stopped,   0 zombie
Cpu(s):  93.1% user,   6.9% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    515248k total,   233464k used,   281784k free,    99540k buffers
Swap:   265064k total,        0k used,   265064k free,    45992k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command           
  302 root      24 -15 21500  11m  11m R 66.2  2.3   2:08.25 X                 
  482 root      40   0  4764 2660 3844 R 29.2  0.5   0:01.50 xterm             
  483 willy     37   0  1420  540 1252 R  4.9  0.1   0:00.25 find              
    1 root      26   0   348  192  316 S  0.0  0.0   0:05.06 init              
    2 root      41  19     0    0    0 S  0.0  0.0   0:00.00 ksoftirqd/0       
    3 root      12 -10     0    0    0 S  0.0  0.0   0:00.21 events/0          
    4 root      15 -10     0    0    0 S  0.0  0.0   0:00.03 kblockd/0         
    5 root      39   0     0    0    0 S  0.0  0.0   0:00.00 pdflush           
    6 root      23   0     0    0    0 S  0.0  0.0   0:00.00 pdflush           

