Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131382AbRCNO2Z>; Wed, 14 Mar 2001 09:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131387AbRCNO2P>; Wed, 14 Mar 2001 09:28:15 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:1028 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S131382AbRCNO2C>; Wed, 14 Mar 2001 09:28:02 -0500
Date: Wed, 14 Mar 2001 08:26:03 -0600
From: Philipp Rumpf <prumpf@mandrakesoft.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Boris Dragovic <lynx@falcon.etf.bg.ac.yu>,
        Oswald Buddenhagen <ob6@inf.tu-dresden.de>,
        linux-kernel@vger.kernel.org
Subject: Re: static scheduling - SCHED_IDLE?
Message-ID: <20010314082603.A29144@mandrakesoft.mandrakesoft.com>
In-Reply-To: <20010309204243.E13320@pcep-jamie.cern.ch> <Pine.LNX.4.33.0103100001200.2283-100000@duckman.distro.conectiva> <20010309210913.F13320@pcep-jamie.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <20010309210913.F13320@pcep-jamie.cern.ch>; from Jamie Lokier on Fri, Mar 09, 2001 at 09:09:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2001 at 09:09:13PM +0100, Jamie Lokier wrote:
> Rik van Riel wrote:
> > > Just raise the priority whenever the task's in kernel mode.  Problem
> > > solved.
> > 
> > Remember that a task schedules itself out at the timer interrupt,
> > in kernel/sched.c::schedule() ... which is kernel mode ;)
> 
> Even nicer.  On x86 change this:
> 
> reschedule:
> 	call SYMBOL_NAME(schedule)    # test
> 	jmp ret_from_sys_call
> 
> to this:
> 
> reschedule:
> 	orl $PF_HONOUR_LOW_PRIORITY,flags(%ebx)	
> 	call SYMBOL_NAME(schedule)    # test
> 	andl $~PF_HONOUR_LOW_PRIORITY,flags(%ebx)
> 	jmp ret_from_sys_call
> 
> (You get the idea; this isn't the best implementation).

A few months ago, I implemented preemptible kernel threads (locally;  I
tend to think the other patches are superior).  Part of the changes was
to separate schedule into __schedule() (common part), schedule_user()
(automatic schedule from entry.S) and schedule() (manual schedule in
kernel space);  besides making what Jamie proposed easier, we can also
save a few cycles in the (common) schedule_user case:

 - we never release the kernel lock
 - we can pass current to schedule_user
 - we just handled softirqs

this is 2.5 material though ...
