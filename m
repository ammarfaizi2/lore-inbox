Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286626AbRLVBVS>; Fri, 21 Dec 2001 20:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286627AbRLVBVI>; Fri, 21 Dec 2001 20:21:08 -0500
Received: from mysql.sashanet.com ([209.181.82.108]:28032 "EHLO
	mysql.sashanet.com") by vger.kernel.org with ESMTP
	id <S286626AbRLVBU5>; Fri, 21 Dec 2001 20:20:57 -0500
Message-Id: <200112220117.fBM1HLM00755@mysql.sashanet.com>
Content-Type: text/plain; charset=US-ASCII
From: Sasha Pachev <sasha@mysql.com>
Organization: MySQL
To: linux-kernel@vger.kernel.org, riel@conectiva.com.br
Subject: disabling kswapd
Date: Fri, 21 Dec 2001 18:17:20 -0700
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik:

My original message for some reason did not seem to make it to the list, so I 
am resending this (with some modifications).

I have noticed that kswapd still runs and in when the memory is low, will do 
some hard thinking about what to swap even if the system does not have a swap 
partition. Here is the proof:

sasha@mysql:/usr/src/linux/mm > free
             total       used       free     shared    buffers     cached
Mem:        254816     248476       6340          0      27224      48832
-/+ buffers/cache:     172420      82396
Swap:            0          0          0
sasha@mysql:/usr/src/linux/mm > ps auxw | grep kswapd
root         5  0.1  0.0     0    0 ?        SW   Dec19   1:41 [kswapd]
sasha    25619  0.0  0.2  1552  612 pts/7    S    20:34   0:00 grep kswapd

So in this example kswapd essentially wasted 1 min and 41 sec of CPU time.

I have search through the archive and discovered a patch to disable kswapd 
through proc at 
http://www.uwsg.iu.edu/hypermail/linux/kernel/0108.0/0675.html. I adapted it 
to my kernel ( 2.4.17-rc2), disabled kswapd, did some testing and noticed 
much better performance.

I would like to request that the above patch in some form be officially 
included in the kernel. While a *perfectly working* kswapd on a system with 
many different processes behaving in a somewhat unpredicatable manner will be 
a boon, there are many instances when running kswapd does more harm than 
good. Below are three reasons why a sysadmin may want to have kswapd disabled:

  * the system is configured in such a way that it has plenty of RAM for 
buffers,cache, and all the processes it will ever run. For example, a 
dedicated server machine with lots of RAM, a small server binary, and a set 
of files it reads that alltogether will fit into RAM - many MySQL 
installations fit into this category. Running kswapd in this case would only 
be a waste of CPU

 * kswapd has a nasty bug that hogs CPU, causes kernel panic, or swaps out so 
aggressively that the system becomes unusable.

 * some other code in the kernel does not work well with kswapd - the 
particular problem I've run into, for example, was kswapd going crazy trying 
to shrink the buffers while find / was causing the kernel to expand them. The 
result was kswapd taking up 75% of CPU.

The bottom line is that a sysadmin should have a choice ( isn't that what 
Linux is all about, after all?). If he does not want to run kswapd, he should 
not have to. If he is really wrong in this, let him find out for himself.

-- 
MySQL Development Team
For technical support contracts, visit https://order.mysql.com/
   __  ___     ___ ____  __ 
  /  |/  /_ __/ __/ __ \/ /   Sasha Pachev <sasha@mysql.com>
 / /|_/ / // /\ \/ /_/ / /__  MySQL AB, http://www.mysql.com/
/_/  /_/\_, /___/\___\_\___/  Provo, Utah, USA
       <___/                  
