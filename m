Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267973AbUJOPER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267973AbUJOPER (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 11:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267979AbUJOPER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 11:04:17 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:41710 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S267973AbUJOPEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 11:04:13 -0400
Date: Fri, 15 Oct 2004 07:59:16 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, Sven Dietrich <sdietrich@mvista.com>,
       Daniel Walker <dwalker@mvista.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, abatyrshin@ru.mvista.com,
       amakarov@ru.mvista.com, emints@ru.mvista.com, ext-rt-dev@mvista.com,
       hzhang@ch.mvista.com, yyang@ch.mvista.com,
       "Witold. Jaworski@Unibw-Muenchen. De" 
	<witold.jaworski@unibw-muenchen.de>,
       arnd.heursch@unibw-muenchen.de
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
Message-ID: <20041015145915.GA1266@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20041011215420.GA19796@elte.hu> <EOEGJOIIAIGENMKBPIAECEIEDKAA.sdietrich@mvista.com> <20041012055029.GB1479@elte.hu> <20041014050905.GA6927@in.ibm.com> <20041014071810.GB9729@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041014071810.GB9729@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 09:18:10AM +0200, Ingo Molnar wrote:
> 
> * Dipankar Sarma <dipankar@in.ibm.com> wrote:
> 
> > On Tue, Oct 12, 2004 at 07:50:29AM +0200, Ingo Molnar wrote:
> > > 
> > > regarding RCU serialization - i think that is the way to go - i dont
> > > think there is any sensible way to extend RCU to a fully preempted
> > > model, RCU is all about per-CPU-ness and per-CPU-ness is quite limited 
> > > in a fully preemptible model.
> > 
> > It seems that way to me too. Long ago I implemented preemptible RCU,
> > but did not follow it through because I believed it was not a good
> > idea. The original patch is here :
> > 
> > http://www.uwsg.iu.edu/hypermail/linux/kernel/0205.1/0026.html
> 
> interesting!
> 
> > This allows read-side critical sections of RCU to be preempted. It
> > will take a bit of work to re-use it in RCU as of now, but I don't
> > think it makes sense to do so. [...]
> 
> note that meanwhile i have implemented another variant:
> 
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=109771365907797&w=2
> 
> i dont think this will be the final interface (the _rt postfix is
> stupid, it should probably be _spin?), but i think this is roughly the
> structure of how to attack it - a minimal extension to the RCU APIs to
> allow for serialization. What do you think about this particular
> approach?

One caution (which you are no doubt already aware of) -- if an RCU
algorithm that reads (rcu_read_lock()/rcu_read_unlock()) in process
context and updates in softirq/bh/irq context, you can see deadlocks.

						Thanx, Paul

> > [...] My primary concern is DoS/OOM situation due to preempted tasks
> > holding up RCU.
> 
> in the serialization solution in -U0 it would be possible to immediately
> free the RCU entries and hence have no DoS/OOM situation - although the
> -U0 patch does not do this yet.
> 
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
