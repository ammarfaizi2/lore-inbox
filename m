Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130661AbRCIULM>; Fri, 9 Mar 2001 15:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130662AbRCIULF>; Fri, 9 Mar 2001 15:11:05 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:9479 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S130661AbRCIUKB>;
	Fri, 9 Mar 2001 15:10:01 -0500
Date: Fri, 9 Mar 2001 21:09:13 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Boris Dragovic <lynx@falcon.etf.bg.ac.yu>,
        Oswald Buddenhagen <ob6@inf.tu-dresden.de>,
        linux-kernel@vger.kernel.org
Subject: Re: static scheduling - SCHED_IDLE?
Message-ID: <20010309210913.F13320@pcep-jamie.cern.ch>
In-Reply-To: <20010309204243.E13320@pcep-jamie.cern.ch> <Pine.LNX.4.33.0103100001200.2283-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0103100001200.2283-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Sat, Mar 10, 2001 at 12:02:05AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> > Just raise the priority whenever the task's in kernel mode.  Problem
> > solved.
> 
> Remember that a task schedules itself out at the timer interrupt,
> in kernel/sched.c::schedule() ... which is kernel mode ;)

Even nicer.  On x86 change this:

reschedule:
	call SYMBOL_NAME(schedule)    # test
	jmp ret_from_sys_call

to this:

reschedule:
	orl $PF_HONOUR_LOW_PRIORITY,flags(%ebx)	
	call SYMBOL_NAME(schedule)    # test
	andl $~PF_HONOUR_LOW_PRIORITY,flags(%ebx)
	jmp ret_from_sys_call

(You get the idea; this isn't the best implementation).

I think this code can only be reached in two ways:

  1. An interrupt, exception, page fault etc. that is returning to user space.
  2. A system call, whatever space it's from.

In both these cases, no critical locks will be held, right?

-- Jamie
