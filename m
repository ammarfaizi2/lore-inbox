Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbVDCPbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVDCPbM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 11:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbVDCPbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 11:31:12 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:734 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261808AbVDCPbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 11:31:10 -0400
Subject: Re: sched /HT processor
From: Steven Rostedt <rostedt@goodmis.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Arun Srinivas <getarunsri@hotmail.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0504031253060.2448@dragon.hyggekrogen.localhost>
References: <BAY10-F53F98A846BEB2918701804D93A0@phx.gbl>
	 <Pine.LNX.4.62.0504031253060.2448@dragon.hyggekrogen.localhost>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sun, 03 Apr 2005 11:31:03 -0400
Message-Id: <1112542263.27149.113.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-04-03 at 13:17 +0200, Jesper Juhl wrote:
> 
> A reschedule can happen once every ms, but also upon returning to 
> userspace and when returning from an interrupt handler, and also when 
> something in the kernel explicitly calls schedule() or sleeps (which in 
> turn results in a call to schedule()). And each CPU runs schedule() 
> independently.
> At least that's my understanding of it - if I'm wrong I hope someone on 
> the list will correct me.

You're correct, but I'll add some more details here.  The actual
schedule happens when needed.  A schedule may not take place at every
ms, if the task running is not done with its time slice and no events
happened where another task should preempt it. If an RT task is running
in a FIFO policy, then it will continue to run until it calls schedule
itself or another process of higher priority preempts it. 

Now if you don't have PREEMPT turned on, than the schedule won't take
place at all while a task is in the kernel, unless the task explicitly
calls schedule.

What happens on a timer interrupt where a task is done with its time
slice or another event where a schedule should take place, is just the
need_resched flag is set for the task.  On return from the interrupt the
flag is checked, and if set a schedule is called. 

This is still a pretty basic description of what really happens, and if
you want to learn more, just start searching the kernel code for
schedule and need_resched. Don't forget to look in the asm code (ie
entry.S, and dependent on your arch other *.S files).

-- Steve


