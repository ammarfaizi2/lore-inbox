Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbWBANQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbWBANQQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 08:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbWBANQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 08:16:15 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:48593 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964958AbWBANQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 08:16:14 -0500
Subject: Re: [PATCH] Avoid moving tasks when a schedule can be made.
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060201130818.GA26481@elte.hu>
References: <1138736609.7088.35.camel@localhost.localdomain>
	 <20060201130818.GA26481@elte.hu>
Content-Type: text/plain
Date: Wed, 01 Feb 2006 08:15:54 -0500
Message-Id: <1138799754.7088.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-01 at 14:08 +0100, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> [pls. use -p when generating patches]
> 
> > @@ -1983,6 +1983,10 @@
> >  
> >  	curr = curr->prev;
> >  
> > +	/* bail if someone else woke up */
> > +	if (need_resched())
> > +		goto out;
> > +
> >  	if (!can_migrate_task(tmp, busiest, this_cpu, sd, idle, &pinned)) {
> >  		if (curr != head)
> >  			goto skip_queue;
> 
> even putting the problems of this approach aside (is it right to abort 
> the act of load-balancing - which is a periodic activity that wont be 
> restarted after this - so we lose real work), i think this will not 
> solve the latency. Imagine a hardirq hitting the CPU that is executing 
> move_tasks() above. We might not service that hardirq for up to 1.5 
> msecs ...
> 
> i think the right approach would be to split up this work into smaller 
> chunks. Or rather, lets first see how this can happen: why is 
> can_migrate() false for so many tasks? Are they all cpu-hot? If yes, 
> shouldnt we simply skip only up to a limit of tasks in this case - it's 
> not like we want to spend 1.5 msecs searching for a cache-cold task 
> which might give us a 50 usecs advantage over cache-hot tasks ...
> 

OK, agreed.

Just to clear things up.  I looked further into what was causing this,
and the can_migrate was indeed true, and it just happened that we got a
large imbalance, and it pulled a few hundred tasks.  So, my earlier
analysis was incorrect about the can_migrate being false.

-- Steve

