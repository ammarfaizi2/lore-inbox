Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286815AbRLVQgd>; Sat, 22 Dec 2001 11:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286818AbRLVQgX>; Sat, 22 Dec 2001 11:36:23 -0500
Received: from mysql.sashanet.com ([209.181.82.108]:55424 "EHLO
	mysql.sashanet.com") by vger.kernel.org with ESMTP
	id <S286815AbRLVQgD>; Sat, 22 Dec 2001 11:36:03 -0500
Message-Id: <200112221631.fBMGVrM19454@mysql.sashanet.com>
Content-Type: text/plain;
  charset="us-ascii"
From: Sasha Pachev <sasha@mysql.com>
Organization: MySQL
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: disabling kswapd
Date: Sat, 22 Dec 2001 09:31:52 -0700
X-Mailer: KMail [version 1.3.1]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0112220212010.15741-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0112220212010.15741-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 December 2001 09:44 pm, Rik van Riel wrote:
> On Fri, 21 Dec 2001, Sasha Pachev wrote:
> 
> > http://www.uwsg.iu.edu/hypermail/linux/kernel/0108.0/0675.html. I
> > adapted it to my kernel ( 2.4.17-rc2), disabled kswapd, did some
> > testing and noticed much better performance.
> 
> This is very hard to believe.
> 
> If kswapd does not run, it just means that _other_ processes
> will run the exact same code, only synchronously (instead of
> having kswapd do the cleanup for them).

That does make a difference. kswapd does its clean-up in a loop that runs 
with very high priority every time it thinks that there are not enough free 
pages. The process will only run this code if it actually fails to find a 
free page, and if I understand correctly, do so with its regular priority, 
right?

In my case, I do not mind if the process gets stuck looking for a free page 
while letting other processes that already have all the pages they need run, 
as opposed to kswapd monopolizing the CPU trying to clean up.

So, I would like to reiterate that kswapd disabling feature would be very 
helpful to have in the kernel. It involves only trivial code changes, and it 
does allow a sysadmin to do things a different way - like I said earlier, 
Linux is about choice, and when it is possible, one should have it.

But actually, digging a little deeper - I think there is still a bug in 
shrink_caches(). Even after disabling kswapd, in one instance I had a process 
brutally murdered at the time when I had over 100MB of cache available. The 
cache was heavily used and growing, if that helps any. 

It must be noted that the one process murder in this case did not compare 
with a massacre that happened in the same situation when kswapd was not 
disabled. About 10 processes got killed.

-- 
MySQL Development Team
For technical support contracts, visit https://order.mysql.com/
   __  ___     ___ ____  __ 
  /  |/  /_ __/ __/ __ \/ /   Sasha Pachev <sasha@mysql.com>
 / /|_/ / // /\ \/ /_/ / /__  MySQL AB, http://www.mysql.com/
/_/  /_/\_, /___/\___\_\___/  Provo, Utah, USA
       <___/                  
