Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317656AbSFRWDg>; Tue, 18 Jun 2002 18:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317655AbSFRWDg>; Tue, 18 Jun 2002 18:03:36 -0400
Received: from mail.webmaster.com ([216.152.64.131]:36245 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S317654AbSFRWDd> convert rfc822-to-8bit; Tue, 18 Jun 2002 18:03:33 -0400
From: David Schwartz <davids@webmaster.com>
To: <mgix@mgix.com>, <rusty@rustcorp.com.au>
CC: <linux-kernel@vger.kernel.org>, <mingo@redhat.com>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Tue, 18 Jun 2002 15:03:31 -0700
In-Reply-To: <AMEKICHCJFIFEDIBLGOBEEELCBAA.mgix@mgix.com>
Subject: RE: Question about sched_yield()
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20020618220332.AAA14486@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>    3. A CPU hog at best when running on an SMP boxes: the spinning
>thread gobbles up a whole 100% of a CPU.

	For the few hundred cycles some other thread holds the lock.

>"Smart" spinlocks basically try and do it this way:
>
>    int spinLoops= GetNumberOfProcsICanRunOn() > 1 ? someBigNumber : 1;
>    while(1)
>    {
>        int n= spinLoops;
>        while(n--) tryAndGetTheSpinLock();
>        if(gotIt) break;
>        sched_yield();
>    }
>
>These seem to have all the qualities I want:

	Almost.

>2. On an SMP box, the thread will bang on the spinlock a large
>number of times, hoping to get it before it gets taskswitched away.
>If it does, great: no time lost.
>If it doesn't, we're out of luck, yield the CPU and try again next time.

	You should limit how many times you spin in this loop. If it gets to be too 
many, you should block.

	You can either block by sleeping for a few milliseconds. If you don't like 
the idea that one thread will release the lock and the other will waste time 
sleeping, then associate a kernel lock with the spinlock when a thread gives 
up waiting, have your unlock function check for an associated kernel lock and 
if there is one, unlock it.

	DS


