Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbWC1V1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWC1V1W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 16:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWC1V1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 16:27:22 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:57744 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751279AbWC1V1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 16:27:21 -0500
Date: Tue, 28 Mar 2006 23:24:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: PI patch against 2.6.16-rt9
Message-ID: <20060328212448.GA7120@elte.hu>
References: <20060328205533.GC1217@elte.hu> <Pine.LNX.4.44L0.0603282202250.22822-100000@lifa02.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0603282202250.22822-100000@lifa02.phys.au.dk>
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

> > in short: wow do you ensure that the boosting is still part of the same
> > dependency chain where it started off?
> 
> I don't insure that. But does it matter?!?

yes.

> If the task is still blocked on a lock and the owner of that lock 
> might need boosting. The boosting operation itself will always be 
> _correct_ as the pi_lock is held when it is done. But the task doing 
> the boosting might have preempted for so long that there is nothing 
> left to do - and then it simply stops unless deadlock detection is on.

well, another possibility is that the task got blocked again, and we'll 
continue boosting _the wrong chain_. I.e. we'll add extra priority to 
task(s) that might not deserve it at all (it doesnt own the lock we are 
interested in anymore).

i.e. we must observe the boosting chain in a time-coherent form. We must 
observe an actual "frozen" (all locks held) state of the system that we 
_know_ forms a correct dependency chain at that moment, to be able to 
propagate the priority one step forward. The act of 'boosting' must be 
atomic.

	Ingo
