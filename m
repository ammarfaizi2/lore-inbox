Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVFKBzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVFKBzu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 21:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVFKBzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 21:55:49 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:11937 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261521AbVFKBze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 21:55:34 -0400
Date: Fri, 10 Jun 2005 18:55:51 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Eric Piel <Eric.Piel@lifl.fr>
Cc: linux-kernel@vger.kernel.org, bhuey@lnxw.com, andrea@suse.de,
       tglx@linutronix.de, karim@opersys.com, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050611015551.GR1300@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <42A714B7.8010105@lifl.fr> <20050609022041.GG1295@us.ibm.com> <42AA0D03.2090505@lifl.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42AA0D03.2090505@lifl.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 11:58:27PM +0200, Eric Piel wrote:
> 06/09/2005 04:20 AM, Paul E. McKenney wrote/a écrit:
> >>Concerning the QoS, we have been able to obtain hard realtime, at least
> >>very firm real-time. Tests were conducted over 8 hours on IA-64 and x86
> >>and gave respectively 105µs and 40µs of maximum latency. Not as good as
> >>you have mentioned but mostly of the same order :-)
> >
> > Quite impressive!  So, does this qualify as "ruby hard", or is it only
> > "metal hard"?  ;-)
> Well, you have to consider that this is still full Linux running. All 
> the best we can do is to not make it crash or hung more than the vanilla 
> kernel, it's still vulnerable to any bug of any driver :-/ In addition, 
> I highly doubt this approach can ever have an implementation were the 
> maximum latency is theoritically proven. The best we have is just 
> measurements of the system running with high loads during very long time.

Hmmm...  Might one make a theoretical proof that assumed the absense
of bugs?  Wholly unrealistic, I know, but seems like a reasonable
question to ask.  Besides, isn't theory -supposed- to be wholly
unrealistic?

> > The service measured was process scheduling, right?
> Yes, on IA64, from the hardware IRQ fireing to process scheduling (on 
> x86 it's from kernel IRQ handling to process scheduling).

Cool!

> >>Concerning the "e. fault isolation", on our implementation, holding a
> >>lock, mutex or semaphore will automatically migrate the task, therefore
> >>it's not a problem. Of course, some parts of the kernel that cannot be
> >>migrated might take a lock, namely the scheduler. For the scheduler, we
> >>modified most of the data structures requiring a lock so that they can
> >>be accessed locklessly (it's the hardest part of the implementation).
> >
> >
> > Are the non-migrateable portions of the scheduler small enough that
> > one could do a worst-case timing analysis?  Preferably aided by some
> > automation...
> Well, ARTiS only modifies the schedule() function but there is probably 
> too much possible interaction to really be able to prove anything (the 
> fact that it's a SMP system doesn't help!).

SMP does make it more complex, but not hopeless.  If you can bound the
number of threads, and if you can guarantee FIFO queuing on locks,
then the locks can have bounded wait times.  Not that any of the
high-performance spinlocks actually have this property...

> > One approach would be to mark the migrated task so that it returns
> > to the realtime CPU as soon as it completes the realtime-unsafe
> > operation.
> We use a different approach: keep (small) statistics of the task doing 
> often lock and the one that are more "computational". Then we migrate in 
> priority the tasks that don't do locks. Your suggestion could be used 
> at the same time but it might not be so efficient anymore. Additionally, 
> in the current implementation, it's not so easy to know when a task 
> which is running can go back to a RT CPU.

OK.  I suppose you could migrate it back as soon as it returned to
user-mode execution.  Might or might not be useful.  The other approach
would be once it dropped all of its locks, but, as you say, this could
result in a large number of migrations...

> > Another approach is to insert a virtualization layer (think in terms of
> > a very cut-down variant of Xen) that tells the OS that there are two 
> CPUs.
> > This layer then gives realtime service to one, but not to the other.
> > That way, the OS thinks that it has two CPUs, and can still do the
> > migration tricks despite having only one real CPU.
> Simulation of an SMP on a UP? This sounds quite heavy but it might be 
> interesting to try :-)

It can be quite light-weight -- you just have to carefully lie to the
OS about what CPU it is running on.  And no doubt fix a bunch of places
where it makes assumptions about the two CPUs being real CPUs.  :-(

						Thanx, Paul

> > Anyway, interesting approach!
> Thanks,
> 
> Eric
> 
