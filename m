Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVEFX1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVEFX1w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 19:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVEFX10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 19:27:26 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:15519 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261331AbVEFXPu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 19:15:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JzIvcLAluM7f5qzbs2vKNJZbOhZWurrTmxm7e8zt4z/Z6OYk7zNQfhfN+xEzlrMVyzBKnSR5En9rh390QQkQE28PT9qyyjO3LyXafDA+awgUopgBELEXttAdTw2gQ4nYsHtOd/uNlebkO2eSOO9157hHnyjoUbziOklMmjDuWsg=
Message-ID: <92df317505050616152d07f7f@mail.gmail.com>
Date: Fri, 6 May 2005 19:15:47 -0400
From: Yuly Finkelberg <liquidicecube@gmail.com>
Reply-To: Yuly Finkelberg <liquidicecube@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Problem while stopping many threads within a module
In-Reply-To: <d5e597$jok$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4279084C.9030908@free.fr> <20050504191604.GA29730@nevyn.them.org>
	 <Pine.LNX.4.61.0505042031120.22323@chaos.analogic.com>
	 <Pine.LNX.4.61.0505050814340.24130@chaos.analogic.com>
	 <d5e597$jok$1@news.cistron.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello -

I'm having a strange thread scheduling issue in a project that I'm
working on.  We have a module, with an interface that can be called by
many (currently 50) threads simulatenously.  Threads that have entered
the kernel, sleep on a wait queue until everyone else has entered.  At
this point, a "master" process wakes up the first thread, which does
some work, then wakes up the second, etc.  After waking up its
successor, each thread changes its state to STOPPED and sends itself a
SIGSTOP.  Note that the threads are created with
CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND but NOT CLONE_THREAD so
there is no group stop.

Basically, the structure is the following:
kernel_entry_point() {
        wait until its your turn
        ...... do some work .... (serialized)
        wake up the next thread
        send SIGSTOP to yourself
}

At the same time, a monitoring process polls until all the threads
have stopped themselves:
monitor() {
repeat:
        for each thread
               if (thread->state < TASK_STOPPED)
                       yield()
                       goto repeat
}

Now, here's the problem.  On 2.6.9 UP (Preempt), it is often the case
that one thread gets "stuck" in between the wake up of the next thread
and stopping itself -- this causes the monitor to poll for extended
periods of time, since the thread remains RUNNING.  Strangely enough,
it generally gets unstuck by itself, sometimes within 10 seconds,
sometimes after as long as 10 minutes.  When peeking at the kernel
stack of the offending process via the monitor, I only see that it is
in schedule and the stack looks like this:

       c55e7ad0 00000086 c55e6000 c55e7a94 00000046 c55e6000 c55e7ad0 c0109c2d 
       00000000 c03ddae0 00000001 fd0b6c12 0013bc9f c6502130 001770fe fd478e5c 
       0013bc9f c55d546c c05d3960 00002710 c05d3960 c55e6000 c0106f25 c05d3960 
Call Trace:
[<c0106f25>] need_resched+0x27/0x32

It also continues to be charged ticks, indicating that its being
scheduled but is making no progress?  However, I can't find anything
that this thread could be spinning on.  Also, I don't understand why
there is no further context on the stack -- the thread does eventually
finish and never leaves the kernel, so the stack shouldn't be
corrupted...  How can it finish if it has nowhere to return?

I realize that this is a long shot, but if anyone has any ideas, I'd
appreciate hearing them.  Please let me know if I can provide any
further information.

Thanks,
-Yuly
