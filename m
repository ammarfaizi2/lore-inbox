Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWC1U6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWC1U6I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 15:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWC1U6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 15:58:08 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:63132 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932169AbWC1U6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 15:58:07 -0500
Date: Tue, 28 Mar 2006 22:55:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: PI patch against 2.6.16-rt9
Message-ID: <20060328205533.GC1217@elte.hu>
References: <20060327002105.GA29649@elte.hu> <Pine.LNX.4.44L0.0603271501150.20599-100000@lifa03.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0603271501150.20599-100000@lifa03.phys.au.dk>
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

> > we are observing a non-time-coherent snapshot of the locking graph.
> > There is no guarantee that due to timeouts or signals the chain we
> > observe isnt artificially long - while if a time-coherent snapshot is
> > taken it is always fine. E.g. lets take dentry locks as an example:
> > their locking is ordered by the dentry (kernel-pointer) address. We
> > could in theory have a 'chain' of subsequent locking dependencies
> > related to 10,000 dentries, which are nicely ordered and create a
> > 10,000-entry 'chain' if looked at in a non-time-coherent form. I.e. your
> > code could detect a deadlock where there's none. The more CPUs there
> > are, the larger the likelyhood is that other CPUs 'lure us' into a long
> > chain.
> 
> I don't quite understand you examble: Are all 10,000 held at once?

no.

> If no, how are they all going to suddenly put into the lock chain due 
> to signals or timeouts? Those things unlocks locks and therefore 
> breaks the chain.

the core problem with your approach is that for each step in the 
'boosting chain' (which can be quite long in theory), all that we are 
holding is a task reference get get_task_struct(), to a task that was 
blocked before. We then make ourselves preemptible - and once get get 
back and continue the boosting chain, there is no guarantee that the 
boosting makes any sense! Normally that task will probably still be 
blocked, and we continue with our boosting. But the task could have 
gotten unblocked, it could have gotten re-blocked, and we'd continue 
doing the boosting.

in short: wow do you ensure that the boosting is still part of the same 
dependency chain where it started off?

	Ingo
