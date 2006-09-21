Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWIUHcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWIUHcl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 03:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWIUHcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 03:32:41 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:14528
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1750770AbWIUHck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 03:32:40 -0400
Date: Thu, 21 Sep 2006 00:32:22 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Esben Nielsen <simlo@phys.au.dk>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [PATCH] move put_task_struct() reaping into a thread [Re: 2.6.18-rt1]
Message-ID: <20060921073222.GC10337@gnuppy.monkey.org>
References: <20060920141907.GA30765@elte.hu> <20060921065624.GA9841@gnuppy.monkey.org> <20060921065402.GA22089@elte.hu> <20060921071838.GA10337@gnuppy.monkey.org> <20060921071624.GA25281@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060921071624.GA25281@elte.hu>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2006 at 09:16:24AM +0200, Ingo Molnar wrote:
> * Bill Huey <billh@gnuppy.monkey.org> wrote:
> > It's correct from the standpoint of it being reaped in another thread, 
> > so it fixed those crashes. But I pushed it down into another thread at 
> > the request of Esben and his private discussion with Paul McKenney, 
> > since a summary from Esben felt that call_rcu() was somehow less than 
> > ideal to do that.
> 
> but it _is_ already being reaped in another thread: softirq-rcu. 
> Splitting that up any further will only fragment the context-switching 
> and increases cache footprint - it wont (or rather, shouldnt) have any 
> functional effect. (As a sidenote, i'm considering the unification of 
> all 'same default priority' softirq threads into a single thread per 
> CPU, to further reduce this cost of 'spreadout'.)

I overloaded another reaping thread that was doing largely similar
functionality in that it was also reaping, so I don't think it's that bad.
I did it from a cleanliness point of view with the code tree. It's the
"desched_thread" in fork.c that I'm using. It seems to be the right
thing to do. I'm sure Esben will follow up on this.

> > > that you saw crashes under 2.6.17 - but did you manage to figure out 
> > > what the reason is for those crashes, and do those reasons really 
> > > necessiate the pushing of task-reapdown into yet another set of 
> > > kernel threads?
> > 
> > Unfortunately no. I even used Robert's .config on my machine. I added 
> > a disk controller and networking device driver just to boot into his 
> > configuration and I still couldn't replicated any of his kjournald 
> > problems at all. If I had his hardware I'd have a better way of 
> > replicating those problems and pound it out.
> 
> ok, then i guess what we have left is to wait and see whether it still 
> triggers with the current 2.6.18-rt codebase - maybe it triggers for 
> someone in a scenario that is easier to debug.

bill

