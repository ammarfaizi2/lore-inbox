Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261430AbSIWWlo>; Mon, 23 Sep 2002 18:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261433AbSIWWlo>; Mon, 23 Sep 2002 18:41:44 -0400
Received: from adedition.com ([216.209.85.42]:47878 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S261430AbSIWWlm>;
	Mon, 23 Sep 2002 18:41:42 -0400
Date: Mon, 23 Sep 2002 18:44:23 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: =?iso-8859-1?Q?Peter_W=E4chtler?= <pwaechtler@mac.com>
Cc: Ingo Molnar <mingo@elte.hu>, Larry McVoy <lm@bitmover.com>,
       Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020923184423.B26887@mark.mielke.cc>
References: <Pine.LNX.4.44.0209232233250.2343-100000@localhost.localdomain> <3D8F82E5.90A64E8@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D8F82E5.90A64E8@mac.com>; from pwaechtler@mac.com on Mon, Sep 23, 2002 at 11:08:53PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 11:08:53PM +0200, Peter Wächtler wrote:
> With 1:1 on "hitting" a blocking condition the kernel will
> switch to a different beast (yes, a thread gets a bonus for
> using the same MM and the same cpu).

> But on M:N the "user process" makes some more progress in its
> timeslice (does it get even punished for eating up its 
> timeslice?) I would think that it tends to cause less context
> switches but tends to do more syscalls :-(

Think of it this way... two threads are blocked on different resources...
The currently executing thread reaches a point where it blocks.

    OS threads:
        1) thread#1 invokes a system call
        2) OS switches tasks to thread#2 and returns from blocking

    user-space threads:
        1) thread#1 invokes a system call
        2) thread#1 returns from system call, EWOULDBLOCK
        3) thread#1 invokes poll(), select(), ioctl() to determine state
        4) thread#1 returns from system call
        5) thread#1 switches stack pointer to be thread#2 upon determination
           that the resource thread#2 was waiting on is ready.

Certainly the above descriptions are not fully accurate, or complete,
and it is possible that the M:N threading would make a fair compromise
between OS thread sand user-space threads, however, if user-space threads
requires all this extra work, and M:N threads requires some extra work,
some less work, and extra book keeping and system calls, why couldn't
OS threads by themselves be more efficient?

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

