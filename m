Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262713AbVDALW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262713AbVDALW2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 06:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbVDALW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 06:22:28 -0500
Received: from fire.osdl.org ([65.172.181.4]:46058 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262713AbVDALWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 06:22:12 -0500
Date: Fri, 1 Apr 2005 03:20:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: johnpol@2ka.mipt.ru
Cc: linux-kernel@vger.kernel.org, guillaume.thouvenin@bull.net,
       jlan@engr.sgi.com, efocht@hpce.nec.com, linuxram@us.ibm.com,
       gh@us.ibm.com, elsa-devel@lists.sourceforge.net, greg@kroah.com
Subject: Re: [1/1] CBUS: new very fast (for insert operations) message bus
 based on kenel connector.
Message-Id: <20050401032023.3d05d42f.akpm@osdl.org>
In-Reply-To: <1112352955.9334.225.camel@uganda>
References: <20050320112336.2b082e27@zanzibar.2ka.mipt.ru>
	<20050331162758.44aeaf44.akpm@osdl.org>
	<1112337814.9334.42.camel@uganda>
	<20050331232625.09057712.akpm@osdl.org>
	<1112341514.9334.103.camel@uganda>
	<20050331235927.6d104665.akpm@osdl.org>
	<1112345400.9334.157.camel@uganda>
	<20050401012547.68c26523.akpm@osdl.org>
	<1112350615.9334.194.camel@uganda>
	<20050401023004.2a83dbe5.akpm@osdl.org>
	<1112352955.9334.225.camel@uganda>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
>
> On Fri, 2005-04-01 at 02:30 -0800, Andrew Morton wrote:
> > Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > >
> > > > > keventd does very hard jobs on some of my test machines which 
> > > > > for example route big amount of traffic.
> > > > 
> > > > As I said - that's going to cause _your_ kernel thread to be slowed down as
> > > > well.
> > > 
> > > Yes, but it does not solve peak performance issues - all scheduled
> > > jobs can run one after another which will decrease insert performance.
> > 
> > Well the keventd handler would simply process all currently-queued
> > messages.  It's not as if you'd only process one event per keventd callout.
> 
> But that will hurt insert performance.

Why?  All it involves is one schedule_work() on the insert side.  And that
will involve just a single test_bit() in the great majority of cases
because the work will already be pending.

> Processing all messages without splitting them up into pieces noticebly
> slows insert operation down.

What does "splitting them up into pieces" mean?  They're single messages
end-to-end.  You've been discussing batching of messages, which is the
opposite?

> > (please remind me why cbus exists, btw.  What functionality does it offer
> > which the connector code doesn't?)
> 
> The main goal of CBUS is insert operation performance.
> Anyone who wants to have maximum delivery speed should use direct
> connector's
> methods instead.

Delivery speed is not the same thing as insertion speed.  All the insertion
does is to place the event onto an internal queue.  We still need to do a
context switch and send the thing.  Provided there's a reasonable amount of
batching, the CPU consumption will be the same in both cases.

> > > > Introducing an up-to-ten millisecond latency seems a lot worse than some
> > > > reduction in peak bandwidth - it's not as if pumping 100000 events/sec is a
> > > > likely use case.  Using prepare_to_wait/finish_wait will provide some
> > > > speedup in SMP environments due to reduced cacheline transfers.
> > > 
> > > It is a question actually...
> > > If we allow peak processing, then we _definitely_ will have insert 
> > > performance degradation, it was observed in my tests.
> > 
> > I don't understand your terminology.  What is "peak processing" and how
> > does it differ from maximum insertion rate?
> > 
> > > The main goal of CBUS was exactly insert speed
> > 
> > Why?
> 
> To allow connector usage in a really fast pathes.
> If one cares about _delivery_ speed then one should use cn_netlink_send
> ().

We care about both insertion and delivery!  Sure, simply sticking the event
onto a queue is faster than delivering it.  But we still need to deliver it
sometime so there's no aggregate gain.  Still confused.

> > > - so
> > > it somehow must smooth shape performance peaks, and thus
> > > above budget was introdyced.
> > 
> > An up-to-ten-millisecond latency between the kernel-side queueing of a
> > message and the delivery of that message to userspace sounds like an
> > awfully bad restriction to me.  Even one millisecond will have impact in
> > some scenarios.
> 
> If you care about delivery speed stronger than insertion, 
> then you do not need to use CBUS, but cn_netlink_send() instead.
> 
> I will test smaller values, but doubt it will have better insert
> performance.

I fail to see why it is desirable to defer the delivery.  The delivery has
to happen some time, and we've now incurred additional context switch
overhead.

> Concider fork() connector - it is better for userspace
> to return from system call as soon as possible, while information
> delivering
> about that event will be delayed.

Why?  The amount of CPU required to deliver the information regarding a
fork is the same in either case.  Probably more, in the deferred case.

> Noone says that queueing is done in much higher rate then delivering, 
> it only shapes shart peaks when it is unacceptably to wait untill
> delivery
> is finished.

Maybe cbus gave better lmbench numbers because the forking was happening on
one CPU and the event delivery was pushed across to the other one.  OK for
a microbenchmark, but dubious for the real world.

I can see that there might be CPU consumption improvements due to the
batching of work and hence more effective CPU cache utilisation.  That
would need to be carefully measured, and you'd get the same effect by
simply doing a list_add+schedule_work for each insertion.


> > > > > I did not try that case with the keventd but with one kernel thread 
> > > > > it was tested and showed worse performance.
> > > > 
> > > > But your current implementation has only one kernel thread?
> > > 
> > > It has a budget and timeout between each bundle processing.
> > > keventd does not allow to create such a timeout between each bundle
> > > processing.
> > 
> > Yes, there's batching there.  But I don't understand why the ability to
> > internally queue events at a high rate is so much more important than the
> > latency which that batching will introduce.
> 
> With such mechanism we may use event notification in a really fast
> pathes.
> We always defer actuall work processing out from HW interrupts, 
> although for the task running from that interrupt it would be better
> to steal the whole CPU and run there [in HW irq] until it finishes.

I agree that there are advantages to queueing the event and sending it
later: it allows events to be sent from IRQ context and is more CPU-cache
friendly.

But the up-to-ten millisecond latency probably makes this thing pretty
useless for everything except the fork() application.

And queueing up arbitrary numbers of objects in this manner is a design
problem: if the generator is generating events faster than the kernel
thread can deliver them, we'll kill the machine.

> > (And keventd _does_ allow such batching.  schedule_delayed_work()).
> 
> And it is still unacceptible, since there may be too many events
> delayed to the same time, so they all will be processed in the same
> time, 
> which will hurt insert operation performance.

Why?  It's equivalent to the msleep(10).
