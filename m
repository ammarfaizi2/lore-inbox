Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964973AbWHWPYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbWHWPYg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 11:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbWHWPYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 11:24:36 -0400
Received: from nat.webnetassociados.com.br ([66.98.244.31]:37527 "EHLO
	www1.forexproject.com") by vger.kernel.org with ESMTP
	id S964973AbWHWPYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 11:24:35 -0400
Message-ID: <38798.127.0.0.1.1156346673.squirrel@forexproject.com>
Date: Wed, 23 Aug 2006 11:24:33 -0400 (EDT)
Subject: SMP Affinity and nice
From: "Rich Paredes" <rparedes@gmail.com>
To: linux-kernel@vger.kernel.org
Reply-To: rparedes@gmail.com
User-Agent: SquirrelMail/1.4.6
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - www1.forexproject.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [32003 505] / [47 12]
X-AntiAbuse: Sender Address Domain - gmail.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to come to an understanding as to why 1 process is getting
less cpu time than identical processes with a higher "nice" value.
Server has 2 physical processors with hyperthreading (cpu 0,1,2,3)

I am starting 5 processes that perform a square root loop to max out a
cpu.  They use the exact same code but are renamed for identification:
cpumax1, cpumax2, cpumax3, cpumax4, cpumax5
I start in order:
1.  nice -n 10 cpumax1
2.  nice -n 10 cpumax2
3.  nice -n 10 cpumax3
4.  nice -n 10 cpumax4
5.  nice -n 0 cpumax5

Here is the top output:
 PR  NI S %CPU    TIME+  P COMMAND
 35  10 R 99.9   1:46.90 3 cpumax1
 35  10 R 99.9   1:41.01 1 cpumax3
 35  10 R 99.9   1:39.48 0 cpumax4
 25   0 R 66.9   1:03.13 2 cpumax5
 35  10 R 33.0   0:39.30 2 cpumax2

cpumax1 is using processor 3, 99%
cpumax2 is using processor 2, 33%
cpumax3 is using processor 1, 99%
cpumax4 is using processor 0, 99%
cpumax5 is using processor 2, 66%

So since cpumax5 has a lower nice value and thus a higher priority (25 in
this case), shouldn't it be given it's own cpu.   If I give cpumax5 a nice
value of -20, it does start using it's own cpu.  I don't want to manage
cpu affinity via taskset command.

My explanation would be that since the scheduler tries to limit cpu
affinity, the nice value of 0 isn't enough to get the scheduler to move
this process to another processors run queue.  I could be totally wrong
here though.

I should also note here that this test is totally dependent on the order
of startup.  If I start cpumax5 first with a nice value of 0 before the
other 4, it will get it's own cpu:
 PR  NI S %CPU    TIME+  P COMMAND
 35  10 R 99.9   1:00.03 3 cpumax2
 25   0 R 99.9   1:08.01 1 cpumax5
 35  10 R 99.9   1:03.69 2 cpumax1
 35  10 R 50.3   0:29.02 0 cpumax3
 35  10 R 49.6   0:26.37 0 cpumax4

I just want to understand this better.  Thanks.
