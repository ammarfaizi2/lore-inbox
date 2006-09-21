Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWIUHhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWIUHhr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 03:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWIUHhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 03:37:47 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:15501 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750811AbWIUHhq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 03:37:46 -0400
Date: Thu, 21 Sep 2006 09:29:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [PATCH] move put_task_struct() reaping into a thread [Re: 2.6.18-rt1]
Message-ID: <20060921072908.GA27280@elte.hu>
References: <20060920141907.GA30765@elte.hu> <20060921065624.GA9841@gnuppy.monkey.org> <20060921065402.GA22089@elte.hu> <20060921071838.GA10337@gnuppy.monkey.org> <20060921071624.GA25281@elte.hu> <20060921073222.GC10337@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060921073222.GC10337@gnuppy.monkey.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4998]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Bill Huey <billh@gnuppy.monkey.org> wrote:

> > but it _is_ already being reaped in another thread: softirq-rcu. 
> > Splitting that up any further will only fragment the 
> > context-switching and increases cache footprint - it wont (or 
> > rather, shouldnt) have any functional effect. (As a sidenote, i'm 
> > considering the unification of all 'same default priority' softirq 
> > threads into a single thread per CPU, to further reduce this cost of 
> > 'spreadout'.)
> 
> I overloaded another reaping thread that was doing largely similar 
> functionality in that it was also reaping, so I don't think it's that 
> bad. I did it from a cleanliness point of view with the code tree. 
> It's the "desched_thread" in fork.c that I'm using. It seems to be the 
> right thing to do. I'm sure Esben will follow up on this.

the reason why i added desched_thread was not because it's "more right" 
to do this from a separate context, but simply because the resource 
freed by it is not being freed via RCU by the upstream kernel. If that 
resource (mm_struct) were freed by RCU we'd have its rt-friendly 
reapdown "for free" and no desched_thread would be needed at all.

	Ingo
