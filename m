Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262497AbVCXOdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbVCXOdm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 09:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbVCXOdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 09:33:41 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:13054 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262497AbVCXOdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 09:33:37 -0500
Date: Thu, 24 Mar 2005 09:33:26 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
In-Reply-To: <20050324113912.GA20911@elte.hu>
Message-ID: <Pine.LNX.4.58.0503240916210.18714@localhost.localdomain>
References: <20050322092331.GA21465@elte.hu> <20050322093201.GA21945@elte.hu>
 <20050322100153.GA23143@elte.hu> <20050322112856.GA25129@elte.hu>
 <20050323061601.GE1294@us.ibm.com> <20050323063317.GB31626@elte.hu>
 <20050324052854.GA1298@us.ibm.com> <20050324053456.GA14494@elte.hu>
 <Pine.LNX.4.58.0503240310490.18714@localhost.localdomain>
 <Pine.LNX.4.58.0503240341280.18714@localhost.localdomain> <20050324113912.GA20911@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Mar 2005, Ingo Molnar wrote:
>
> there's another approach that could solve this problem: let the
> scheduler sort it all out. Esben Nielsen had this suggestion a couple of
> months ago - i didnt follow it because i thought that technique would
> create too many runnable tasks, but maybe that was a mistake. If we do
> the owning of the lock once the wakee hits the CPU we avoid the 'partial
> owner' problem, and we have the scheduler sort out priorities and
> policies.

I've thought about this too, and came up with the conclusion that this was
too messy.  You have to give up the information of the processes that are
waiting on the lock when you release it. Or keep the information of the
waiters (waking only one "the wakee") but then you have a lock with
waiters and no owner, which is the messy part.

On an SMP machine, there may even be a chance of a lower priority process
that gets it. That would be possible if the low priority process on the
other CPU tries to grab the lock just after it was released but before
the just woken up high priorty processes get scheduled. So there's a
window where the lock is open, and the lower priority process snagged it
just before the others got in.


>
> but i think i like the 'partial owner' (or rather 'owner pending')
> technique a bit better, because it controls concurrency explicitly, and
> it would thus e.g. allow another trick: when a new owner 'steals' a lock
> from another in-flight task, then we could 'unwakeup' that in-flight
> thread which could thus avoid two more context-switches on e.g. SMP
> systems: hitting the CPU and immediately blocking on the lock. (But this
> is a second-phase optimization which needs some core scheduler magic as
> well, i guess i'll be the one to code it up.)
>

Darn! It seemed like fun to implement. I may do it myself anyway on my
kernel just to understand your implementation even better.

Later,

-- Steve

