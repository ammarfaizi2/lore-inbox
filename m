Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261516AbSJAHzi>; Tue, 1 Oct 2002 03:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261524AbSJAHzi>; Tue, 1 Oct 2002 03:55:38 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:46331 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261516AbSJAHzh>;
	Tue, 1 Oct 2002 03:55:37 -0400
Message-ID: <3D99561C.D391C6DD@mvista.com>
Date: Tue, 01 Oct 2002 01:00:28 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "David S. Miller" <davem@redhat.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, wli@holomorphy.com, dipankar@in.ibm.com,
       kuznet@ms2.inr.ac.ru
Subject: Re: [patch] smptimers, old BH removal, tq-cleanup, 2.5.39
References: <Pine.LNX.4.44.0210010723460.5969-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> On Mon, 30 Sep 2002, David S. Miller wrote:
> 
> > I did some thinking, and I don't understand how this old code can be
> > legal.  Doesn't this make do_gettimeofday() inaccurate?
> 
> it's a mostly bogus comment, dont think about it too much.
> 
>         Ingo
Actually gettimeofday is fine.  It does not depend on the
timer interrupt, but only on one happening every once in a
while.  It make up any latency by using the TSC and time of
last interrupt and is in no way dependent on any latency in
the run_timer_list.

By the way, I have been lately impressed with the relative
amount of time a cli/sti takes and have wondered if we might
not get a "nice" improvement in system performance by moving
the xtime read/write lock from an irq to a bh lock.  This
would avoid the cli/sti in the read lock which is needed to
read the time.  All this should take (aside from finding all
the locks) is to move the write access of xtime to the bh
code.  Since it does nothing if timer_jiffie == jiffie, it
does not hurt to call it from each cpu.  The timer interrupt
would then bump a shadow jiffie which would not appear in
jiffies until the bh code runs.

On finding the locks, I suggest abstracting them to a macro,
thus allowing the change to be made only one place.  Of
course, we need to change the name of the lock to enlist the
compilers help in finding them.  But then if we are sure
this is the way to go, there is no need for the macro.
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
