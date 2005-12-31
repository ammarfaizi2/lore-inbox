Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964980AbVLaPMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbVLaPMI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 10:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbVLaPMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 10:12:07 -0500
Received: from 213-140-2-71.ip.fastwebnet.it ([213.140.2.71]:21430 "EHLO
	aa004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S964980AbVLaPMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 10:12:06 -0500
Date: Sat, 31 Dec 2005 16:11:34 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Mike Galbraith <efault@gmx.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
Message-ID: <20051231161134.4236c37a@localhost>
In-Reply-To: <5.2.1.1.2.20051231090255.00bede00@pop.gmx.net>
References: <200512281027.00252.kernel@kolivas.org>
	<20051227190918.65c2abac@localhost>
	<20051227224846.6edcff88@localhost>
	<200512281027.00252.kernel@kolivas.org>
	<5.2.1.1.2.20051231090255.00bede00@pop.gmx.net>
X-Mailer: Sylpheed-Claws 2.0.0-rc1 (GTK+ 2.6.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Dec 2005 09:13:24 +0100
Mike Galbraith <efault@gmx.de> wrote:

> Ingo seems to have done something in 2.6.15-rc7-rt1 which defeats your 
> little proggy.  Taking a quick peek at the rt scheduler changes, nothing 
> poked me in the eye, but by golly, I can't get this kernel to act up, 
> whereas 2.6.14-virgin does.

Ok, I've sucessfully booted 2.6.15-rc7-rt1 (I think that I was
having troubles with Thread Softirqs and/or Thread Hardirqs).

First thing: I've preemption disabled, but it shouldn't matter too much
since we are talking about priority calculation...

1) My program isn't defeated at all. If I start it with the same args
of the previous examples it "seems" defeated, but it isn't.

Lowering the "cpu burn argument" I can reproduce the problem again:

"./a.out 200 & ./a.out 333"

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5607 paolo     15   0  2396  320  252 R 56.1  0.1   0:06.79 a.out
 5606 paolo     15   0  2396  324  252 R 38.7  0.1   0:04.55 a.out
    1 root      16   0  2556  552  468 S  0.0  0.1   0:00.28 init


2) Priority fluctuation - very interesting: playing with the only arg
my program has I've found this:

./a.out 200
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5628 paolo     15   0  2392  320  252 R 48.5  0.1   0:18.34 a.out

./a.out 300
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5633 paolo     15   0  2392  324  252 S 50.1  0.1   0:09.42 a.out

./a.out 400
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5634 paolo     15   0  2392  320  252 S 66.7  0.1   0:06.31 a.out

./a.out 500
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5638 paolo     25   0  2396  320  252 R 67.7  0.1   0:14.78 a.out

./a.out 700
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5640 paolo     15   0  2392  320  252 S 80.1  0.1   0:25.88 a.out

./a.out 800
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5644 paolo     17   0  2396  320  252 R 79.6  0.1   0:26.54 a.out


In the "./a.out 500" case, the priority starts at something like 16 and
then slowly go up to 25 _BUT_ if I start my DD test my cpu-eater
priority goes quickly to 16!

The real world test case (transcode) is a bit harder to describe: its
priority usually goes up to 25, sometimes I've seen it fluctuating a
bit (like go to 19 and then back to 25).

When I start my DD test I've seen basically 2 different behaviours:

A) good
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5788 paolo     25   0  114m  18m 2440 R 82.2  3.7   0:10.16 transcode
 5804 paolo     15   0 49860 4500 1896 S  8.5  0.9   0:00.99 tcdecode
 5808 paolo     18   0  4952 1520  412 D  5.0  0.3   0:00.36 dd

B) bad
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5743 paolo     18   0  114m  18m 2440 R 75.0  3.7   0:26.79 transcode
 5759 paolo     15   0 49864 4500 1896 S  7.8  0.9   0:02.71 tcdecode
 5750 paolo     16   0 19840 1136  916 S  1.5  0.2   0:00.23 tcdemux
 5201 root      15   0  167m  17m 3336 S  0.8  3.5   0:19.38 X
 5764 paolo     18   0  4948 1520  412 R  0.7  0.3   0:00.04 dd

Sometimes happens A and sometimes happens B...

PS: probably all these numbers aren't 100% reproducible... this is what
happens on my PC.

-- 
	Paolo Ornati
	Linux 2.6.15-rc7-rt1 on x86_64
