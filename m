Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbWCRCkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbWCRCkg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 21:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbWCRCkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 21:40:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30390 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750883AbWCRCkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 21:40:36 -0500
Date: Fri, 17 Mar 2006 18:37:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: steiner@sgi.com, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - Reduce overhead of calc_load
Message-Id: <20060317183742.10431ba2.akpm@osdl.org>
In-Reply-To: <441B6BD3.2030807@yahoo.com.au>
References: <20060317145709.GA4296@sgi.com>
	<20060317145912.GA13207@elte.hu>
	<20060317152611.GA4449@sgi.com>
	<20060317171538.3826eb41.akpm@osdl.org>
	<441B6BD3.2030807@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> > Perhaps nr_context_switches() and nr_iowait() should also go into this
> > function, then we rename it all to
> > 
> > 	struct sched_stuff {
> > 		unsigned nr_uninterruptible;
> > 		unsigned nr_running;
> > 		unsigned nr_active;
> > 		unsigned long nr_context_switches;
> > 	};
> > 
> > 	void get_sched_stuff(struct sched_stuff *);
> > 
> > and then convert all those random little counter-upper-callers we have.
> > 
> 
> Is there a need? Do they (except calc_load) use multiple values at
> the same time?

Don't know.  It might happen in the future.  And the additional cost is
practically zero.

> > And then give get_sched_stuff() a hotplug handler (probably unneeded) and
> 
> What would the hotplug handler do?

Move the stats from the going-away CPU into the current CPU's runqueue.

> > then scratch our heads over why nr_uninterruptible() iterates across all
> > possible CPUs while this new nr_active() iterates over all online CPUs like
> > nr_running() and unlike nr_context_switches().
> > 
> 
> I think it need only iterate over possible CPUs.

Someone who has four online CPUs, sixteen present CPUs and 128 possible
CPUs would be justifiably disappointed, no?

> > 
> > IOW: this code's an inefficient mess and needs some caring for.
> 
> What are the performance critical places that call the nr_blah() functions?
> 

That depends upon the frequency with which userspace reads /proc/loadavg,
/proc/stat or /proc/future-stuff.

