Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318173AbSG2WGM>; Mon, 29 Jul 2002 18:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318174AbSG2WGM>; Mon, 29 Jul 2002 18:06:12 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:65210 "EHLO e1.ny.us.ibm.com.")
	by vger.kernel.org with ESMTP id <S318173AbSG2WGJ>;
	Mon, 29 Jul 2002 18:06:09 -0400
Subject: Re: Linux kernel deadlock caused by spinlock bug
From: john stultz <johnstul@us.ibm.com>
To: kevin.vanmaren@unisys.com
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200207292158.g6TLw9N02275@eng2.beaverton.ibm.com>
References: <200207292158.g6TLw9N02275@eng2.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 29 Jul 2002 14:55:24 -0700
Message-Id: <1027979724.1073.99.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  I have hit a problem with the Linux reader/writer spinlock
>  implementation that is causing a kernel deadlock (technically
>  livelock) which causes the system to hang (hard) when running
>  certain user applications.  This problem could be exploited as
>  a DoS attack on medium-to-large SMP machines.
<snip>
>  With "several" processors acquiring and releasing read locks, it is
>  possible for a processor to _never_ succeed in acquiring a write lock.
>  Even though the read lock is held for a very short period, with much
>  contention for the cache line the processor would often lose ownership
>  before it could release the read lock.  [Even if it had it longer,
>  because it was looping, there would still be a good chance that it
>  would lose the cache line while holding the reader lock.]  By the time
>  the reader got the cache line back to release the lock, another processor
>  had acquired the read lock.  This behavior resulted in a processor not
>  being able to acquire the write lock, which it was attempting to do in
>  an interrupt handler.  So the interrupt handler was _never_ able to
>  complete and other interrupts were blocked by that processor (in my
>  case, network and keyboard interrupts).
>  
>  The specific case I tracked down consisted of several processes in
>  a tight gettimeofday() loop, which resulted in the reader count never
>  getting to zero because there was always an outstanding reader.  While
>  I will stipulate that it is not a good thing for several processes to
>  be looping in gettimeofday(), I will assert that it is a very bad thing
>  for a few processes calling such a benign system call to hang the system.

I just wanted to add a "me too" on this. I'm also seeing rw-lock
starvation in do_gettimeofday(). While it does not lead to system
deadlock, it does cause the values returned from gettimeofday to loop as
the timer_bh cannot increment the xtime values (causing possible
application deadlock). In my case,the problem is exaggerated because I'm
using do_slowgettimeofffset due to TSC skew on the i386 hardware I'm
using.

thanks
-john


