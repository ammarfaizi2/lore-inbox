Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbWDRNL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWDRNL3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 09:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbWDRNL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 09:11:28 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:21997 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1750852AbWDRNL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 09:11:28 -0400
Subject: Re: [RT] bad BUG_ON in rtmutex.c
From: Daniel Walker <dwalker@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0604180831390.9005@gandalf.stny.rr.com>
References: <1145324887.17085.35.camel@localhost.localdomain>
	 <1145362851.5447.12.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0604180831390.9005@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Tue, 18 Apr 2006 06:11:25 -0700
Message-Id: <1145365886.5447.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-18 at 08:34 -0400, Steven Rostedt wrote:
> On Tue, 18 Apr 2006, Daniel Walker wrote:
> 
> > On Mon, 2006-04-17 at 21:48 -0400, Steven Rostedt wrote:
> > ...
> > >
> > > So the question now is: is this a real bug?
> >
> > It seems like a possible scenario . So if the false BUG_ON() needlessly
> > kills a perfectly running system, then it must be a bug. It's the case
> > of the buggy BUG_ON ;) !
> >
> 
> It was late when I was writing that.  I reread my email today, and realize
> that there's a few confusing statements there.  That last one being one :)

Yeah , it was a bit confusing .

> I meant to say:
> 
>   So the question is now: Is that case in BUG_ON a real bug?
> 
> The BUG_ON bugging a normal system _is_ a bug.

Something in the code bothered me right around the block you
referenced. 

Specifically when it drops the pi_lock , then takes it again, then does
plist_add to the pi_waiters ( during the "Boost the owner" section in
rt_mutex_adjust_prio_chain() ). Since the pi_lock was dropped you could
get an priority change which would lead to a bogus value in
waiter->pi_list_entry.prio .

I was looking over the code, and it seems like once all the chain
adjusting bottoms out you would end up with the correct priorities in
the waiter structures .. Cause whatever task made the priority
adjustment would just end up resetting the pi_waiters during it's
adjustment process. (Seems like there's room for optimization
though ..) 

Daniel

