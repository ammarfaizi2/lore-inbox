Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbVHYRrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbVHYRrd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 13:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbVHYRrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 13:47:33 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:49086 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751362AbVHYRrc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 13:47:32 -0400
Date: Thu, 25 Aug 2005 19:47:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Sven-Thorsten Dietrich <sven@mvista.com>, Adrian Bunk <bunk@stusta.de>,
       george anzinger <george@mvista.com>, dwalker@mvista.com,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [RFC] RT-patch update to remove the global pi_lock
Message-ID: <20050825174732.GA23774@elte.hu>
References: <1124704837.5208.22.camel@localhost.localdomain> <20050822101632.GA28803@elte.hu> <1124710309.5208.30.camel@localhost.localdomain> <20050822113858.GA1160@elte.hu> <1124715755.5647.4.camel@localhost.localdomain> <20050822183355.GB13888@elte.hu> <1124739657.5809.6.camel@localhost.localdomain> <1124739895.5809.11.camel@localhost.localdomain> <1124981238.5350.6.camel@localhost.localdomain> <1124982413.5350.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124982413.5350.19.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Here it is a little ambiguous.  The process use to own the lock, but 
> someone stole it.  When grabbing a lock, I always grab the process 
> lock first before grabbing the lock's lock, but this isn't necessary.  
> So if you already have the two locks (mutex and process) as is the 
> case above, you don't need to unlock them and regrab them (although 
> this doesn't hurt, except for performance), because any race would 
> have been with the grabbing of these two locks in the first place.
> 
> Now, here's why it's safe.  The process that use to own the mutex and 
> had it stolen now is out of the chain.  The pi_lock and the wait_lock 
> here are not in any order.  So no one who is grabbing the process' 
> pi_lock should have owned the wait_lock and vice versa.
> 
> So here's an updated patch without this lock switching:

your patch works great here, on 3 separate systems: a 1-way, a 2/4-way 
and an 8-way.

the 1-way system performed so well running the SMP kernel that i first 
thought i booted the UP kernel by accident :-)

on the 8-way box, "hackbench 10" got _3.7_ times faster (!!!).

i have booted the 8-way box without your patch once more because i didnt 
believe the results initially and thought they were some benchmarking 
fluke. But no, it wasnt a fluke. The kernel profiles are nicely flat 
now.

i've released 2.6.13-rc7-rt2 with your patch included. This is certainly 
a major milestone for PREEMPT_RT, it is now a first-class scalability 
citizen on SMP too. Great work Steven!

	Ingo
