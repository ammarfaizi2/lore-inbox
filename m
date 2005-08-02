Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261901AbVHBXid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbVHBXid (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 19:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVHBXid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 19:38:33 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:35825 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261901AbVHBXic
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 19:38:32 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1123011928.1590.43.camel@localhost.localdomain>
References: <20050730160345.GA3584@elte.hu>
	 <1122920564.6759.15.camel@localhost.localdomain>
	 <1122931238.4623.17.camel@dhcp153.mvista.com>
	 <1122944010.6759.64.camel@localhost.localdomain>
	 <20050802101920.GA25759@elte.hu>
	 <1123011928.1590.43.camel@localhost.localdomain>
Content-Type: text/plain
Organization: MontaVista
Date: Tue, 02 Aug 2005 16:38:15 -0700
Message-Id: <1123025895.25712.7.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Couldn't you just do some math off current->timestamp to see how long
the task has been running? This per arch stuff seems a bit invasive..

Daniel

On Tue, 2005-08-02 at 15:45 -0400, Steven Rostedt wrote:
> On Tue, 2005-08-02 at 12:19 +0200, Ingo Molnar wrote:
> > * Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > In my custom kernel, I have a wchan field of the task that records 
> > > where the task calls something that might schedule. This way I can see 
> > > where things locked up if I don't have a back trace of the task.  This 
> > > field is always zero when it switches to usermode.  Something like 
> > > this can also be used to check how long the process is in kernel mode.  
> > > If a task is in the kernel for more than 10 seconds without sleeping, 
> > > that would definitely be a good indication of something wrong.  I 
> > > probably could write something to check for this if people are 
> > > interested.  I wont waste my time if nobody would want it.
> > 
> > this would be a pretty useful extension of the softlockup checker!
> 
> Here it is (Finally).  I just had to be patient with the kjournal
> lockup.  I had to wait some time before the lockup occurred, but when it
> did, I got my message out:
> --------------------------------------------
> BUG: possible soft lockup detected on CPU#0! 1314840-1313839(1314839)
> curr=kjournald:734 count=11
>  [<c010410f>] dump_stack+0x1f/0x30 (20)
>  [<c01441e0>] softlockup_tick+0x170/0x1a0 (44)
>  [<c0125d32>] update_process_times+0x62/0x140 (28)
>  [<c010861d>] timer_interrupt+0x4d/0x100 (20)
>  [<c014450f>] handle_IRQ_event+0x6f/0x120 (48)
>  [<c014469c>] __do_IRQ+0xdc/0x1a0 (48)
>  [<c0105abe>] do_IRQ+0x4e/0x90 (28)
>  [<c0103b67>] common_interrupt+0x1f/0x24 (112)
>  [<c01edc36>] journal_commit_transaction+0x1206/0x1430 (112)
>  [<c01f06d0>] kjournald+0xd0/0x1e0 (84)
>  [<c01011ed>] kernel_thread_helper+0x5/0x18 (825638940)
> ---------------------------
> | preempt count: 20010003 ]
> | 3-level deep critical section nesting:
> ----------------------------------------
> .. [<c013d49a>] .... add_preempt_count+0x1a/0x20
> .....[<c01085ec>] ..   ( <= timer_interrupt+0x1c/0x100)
> .. [<c013d49a>] .... add_preempt_count+0x1a/0x20
> .....[<c014418d>] ..   ( <= softlockup_tick+0x11d/0x1a0)
> .. [<c013d49a>] .... add_preempt_count+0x1a/0x20
> .....[<c013e727>] ..   ( <= print_traces+0x17/0x50)
> 
> ------------------------------
> | showing all locks held by: |  (kjournald/734 [c13e20b0,  69]):
> ------------------------------
> -----------------------------------------------


