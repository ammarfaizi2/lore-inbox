Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265400AbUADMH4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 07:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265406AbUADMHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 07:07:44 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:50436 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S265400AbUADMHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 07:07:41 -0500
Date: Sun, 4 Jan 2004 13:07:20 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Lincoln Dale <ltd@cisco.com>, Soeren Sonnenburg <kernel@nn7.de>,
       Con Kolivas <kernel@kolivas.org>, Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>, gillb4@telusplanet.net
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
Message-ID: <20040104120720.GA14497@alpha.home.local>
References: <200401041242.47410.kernel@kolivas.org> <Pine.LNX.4.44.0401031439060.24942-100000@coffee.psychology.mcmaster.ca> <200401040815.54655.kernel@kolivas.org> <20040103233518.GE3728@alpha.home.local> <200401041242.47410.kernel@kolivas.org> <5.1.0.14.2.20040104195316.02151e98@171.71.163.14> <3FF7DA24.40802@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF7DA24.40802@cyberone.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Now testing Con's noint patch against 2.6.0. It returns somewhat simmilar
results to Nick's w29p2, and behaves normally. The only noticeable difference
is that a simple task like "while :; do :; done&" eats about 100ms each second,
so if you start 10 of these, you're able to type only once a second (tested).
But I understand that this 'dumbness' was exactly the goal of this patch.
I think that I'll try to use 2.6 + Nick's scheduler for some time on my
notebook to get an overall idea on how it behaves.

BTW, Nick, does your patch rely on -mm1 exclusive features, or would it be
possible to back-port it to plain 2.6 ?

Cheers,
Willy

1) X not reniced.
=================

noint$ time xterm -e seq 1 5000

real    0m0.548s
user    0m0.267s
sys     0m0.052s

noint$ time xterm -e sh -c "ls -l incoming tmp"

real    0m0.974s
user    0m0.481s
sys     0m0.091s

2) Now renicing X to -10
========================

noint$ time xterm -e sh -c "ls -l incoming tmp"

real    0m0.997s
user    0m0.471s
sys     0m0.101s

noint$ time xterm -e seq 1 5000

real    0m0.390s
user    0m0.261s
sys     0m0.058s

3) Now renicing X to +10 to compare with my previous tests
==========================================================

noint$ time xterm -e seq 1 5000

real    0m0.452s
user    0m0.257s
sys     0m0.070s

noint$ time xterm -e sh -c "ls -l incoming tmp"

real    0m0.956s
user    0m0.441s
sys     0m0.091s

noint$ time find incoming tmp |wc -l
  204276

real    0m0.914s
user    0m0.257s
sys     0m0.653s

noint$ time xterm -e sh -c "find incoming tmp"

real    0m23.107s
user    0m5.652s
sys     0m1.631s

top - 12:56:42 up 9 min,  5 users,  load average: 0.61, 0.54, 0.26
Tasks:  59 total,   3 running,  56 sleeping,   0 stopped,   0 zombie
Cpu(s):  24.8% user,   8.9% system,  66.3% nice,   0.0% idle,   0.0% IO-wait
Mem:    515292k total,   217816k used,   297476k free,    94344k buffers
Swap:   265064k total,        0k used,   265064k free,    45236k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command           
  239 root      30  10 23632  13m  11m R 66.2  2.7   0:11.11 X                 
  374 root      20   0  4764 2660 3844 S 24.7  0.5   0:01.22 xterm             
  375 willy     20   0  1420  540 1252 S  7.9  0.1   0:00.35 find              
  373 root      20   0  1692  940 1556 R  1.0  0.2   0:00.08 top               

4) Same with renice -15 :
=========================

noint$ time xterm -e sh -c "find incoming tmp"

real    0m22.622s
user    0m5.681s
sys     0m1.807s

top - 12:57:45 up 10 min,  5 users,  load average: 0.33, 0.48, 0.26
Tasks:  59 total,   3 running,  56 sleeping,   0 stopped,   0 zombie
Cpu(s):  88.8% user,  11.2% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    515292k total,   217880k used,   297412k free,    94404k buffers
Swap:   265064k total,        0k used,   265064k free,    45236k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command           
  239 root       5 -15 23632  13m  11m S 64.3  2.7   0:25.55 X                 
  380 root      20   0  4764 2660 3844 R 26.1  0.5   0:00.82 xterm             
  381 willy     20   0  1420  540 1252 S  7.5  0.1   0:00.23 find              


