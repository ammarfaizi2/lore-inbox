Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWC0AXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWC0AXn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 19:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWC0AXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 19:23:42 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:54701 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932265AbWC0AXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 19:23:42 -0500
Date: Mon, 27 Mar 2006 02:21:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: PI patch against 2.6.16-rt9
Message-ID: <20060327002105.GA29649@elte.hu>
References: <20060326234722.GA25331@elte.hu> <Pine.LNX.4.44L0.0603270055090.2708-100000@lifa01.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0603270055090.2708-100000@lifa01.phys.au.dk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Esben Nielsen <simlo@phys.au.dk> wrote:

> > how do you guarantee that some other CPU doesnt send us on some
> > goose-chase?
> 
> How should another CPU suddenly be able to insert stuff into a lock 
> chain? Only the tasks themselves can do that and they are blocked on 
> some lock - at least when we tested in some previous iteration. 
> Ofcourse, they can have been signalled or timed out since, such they 
> are already unblocked when the deadlock is reported. But that is not 
> an error since the locks at some point actually were in a deadlock 
> situation.

we are observing a non-time-coherent snapshot of the locking graph.  
There is no guarantee that due to timeouts or signals the chain we 
observe isnt artificially long - while if a time-coherent snapshot is 
taken it is always fine. E.g. lets take dentry locks as an example: 
their locking is ordered by the dentry (kernel-pointer) address. We 
could in theory have a 'chain' of subsequent locking dependencies 
related to 10,000 dentries, which are nicely ordered and create a 
10,000-entry 'chain' if looked at in a non-time-coherent form. I.e. your 
code could detect a deadlock where there's none. The more CPUs there 
are, the larger the likelyhood is that other CPUs 'lure us' into a long 
chain.

In other words: without taking all the locks we have no mathematical 
proof that we detected a deadlock!

also, how does the taking of 2 locks only improve latencies? We still 
have to hold the ->waiter_lock of this lock during this act, dont we? Or 
can we do boosting with totally unlocked (and interrupts-enabled) 
rescheduling points? If yes then the same situation could happen on UP 
too: if there's lots of rescheduling of this boosting chain.

nevertheless it _might_ work in practice, and it's certainly elegant and 
thus tempting. Could you try to port your patch to -rt10? [you can skip 
most of the conflicting rt7->rt10 deltas in rtmutex.c i think.]

	Ingo
