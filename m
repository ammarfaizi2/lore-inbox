Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262691AbVDAKck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbVDAKck (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 05:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbVDAKck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 05:32:40 -0500
Received: from fire.osdl.org ([65.172.181.4]:42411 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262691AbVDAKb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 05:31:58 -0500
Date: Fri, 1 Apr 2005 02:30:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: johnpol@2ka.mipt.ru
Cc: linux-kernel@vger.kernel.org, guillaume.thouvenin@bull.net,
       jlan@engr.sgi.com, efocht@hpce.nec.com, linuxram@us.ibm.com,
       gh@us.ibm.com, elsa-devel@lists.sourceforge.net, greg@kroah.com
Subject: Re: [1/1] CBUS: new very fast (for insert operations) message bus
 based on kenel connector.
Message-Id: <20050401023004.2a83dbe5.akpm@osdl.org>
In-Reply-To: <1112350615.9334.194.camel@uganda>
References: <20050320112336.2b082e27@zanzibar.2ka.mipt.ru>
	<20050331162758.44aeaf44.akpm@osdl.org>
	<1112337814.9334.42.camel@uganda>
	<20050331232625.09057712.akpm@osdl.org>
	<1112341514.9334.103.camel@uganda>
	<20050331235927.6d104665.akpm@osdl.org>
	<1112345400.9334.157.camel@uganda>
	<20050401012547.68c26523.akpm@osdl.org>
	<1112350615.9334.194.camel@uganda>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
>
> > > keventd does very hard jobs on some of my test machines which 
> > > for example route big amount of traffic.
> > 
> > As I said - that's going to cause _your_ kernel thread to be slowed down as
> > well.
> 
> Yes, but it does not solve peak performance issues - all scheduled
> jobs can run one after another which will decrease insert performance.

Well the keventd handler would simply process all currently-queued
messages.  It's not as if you'd only process one event per keventd callout.

> > I mean, it's just a choice between two ways of multiplexing the CPU.  One
> > is via a context switch in schedule() and the other is via list traversal
> > in run_workqueue().  The latter will be faster.
> 
> But in case of separate thread one can control execution process,
> if it will be called from work queue then insert requests 
> can appear one after another in a very interval,
> so theirs processing will hurt insert performance.

Why does insert performance matter so much?  These things still have to be
sent up to userspace.

(please remind me why cbus exists, btw.  What functionality does it offer
which the connector code doesn't?)

> > > > Plus keventd is thread-per-cpu and quite possibly would be faster.
> > > 
> > > I experimented with several usage cases for CBUS and it was proven 
> > > to be the fastest case when only one sending thread exists which manages
> > > only very limited amount of messages at a time [like 10 in CBUS
> > > currently]
> > 
> > Maybe that's because the cbus data structures are insufficiently
> > percpuified.  On really big machines that single kernel thread will be a
> > big bottleneck.
> 
> It is not because of messages itself, but becouse of it's peaks,
> if there is a peak then above mechanism will smooth it into
> several pieces [for example 10 in each bundle, that value should be
> changeable in run-time, will place it into TODO],
> with keventd there is no guarantee that next peak will be processed
> not just after the current one, but after some timeout.

keventd should process all the currently-queued messages.  If messages are
being queued quickly then that will be a lot of messages on each keventd
callout.

> > Introducing an up-to-ten millisecond latency seems a lot worse than some
> > reduction in peak bandwidth - it's not as if pumping 100000 events/sec is a
> > likely use case.  Using prepare_to_wait/finish_wait will provide some
> > speedup in SMP environments due to reduced cacheline transfers.
> 
> It is a question actually...
> If we allow peak processing, then we _definitely_ will have insert 
> performance degradation, it was observed in my tests.

I don't understand your terminology.  What is "peak processing" and how
does it differ from maximum insertion rate?

> The main goal of CBUS was exactly insert speed

Why?

> - so
> it somehow must smooth shape performance peaks, and thus
> above budget was introdyced.

An up-to-ten-millisecond latency between the kernel-side queueing of a
message and the delivery of that message to userspace sounds like an
awfully bad restriction to me.  Even one millisecond will have impact in
some scenarios.

> It is similar to NAPI in some abstract way, but with different aims - 
> NAPI for speed improovement, but here we have peak smootheness.
> 
> > > If too many deferred insert works will be called simultaneously
> > > [which may happen with keventd] it will slow down insert operations
> > > noticeably.
> > 
> > What is a "deferred insert work"?  Insertion is always synchronous?
> 
> Insert is synchronous in one CPU, but actuall message delivering is
> deferred.

OK, so why does it matter that "If too many deferred insert works will be
called [which may happen with keventd] it will slow down insert operations
noticeably"?

There's no point in being able to internally queue messages at a higher
frequency than we can deliver them to userspace.  Confused.

> > > I did not try that case with the keventd but with one kernel thread 
> > > it was tested and showed worse performance.
> > 
> > But your current implementation has only one kernel thread?
> 
> It has a budget and timeout between each bundle processing.
> keventd does not allow to create such a timeout between each bundle
> processing.

Yes, there's batching there.  But I don't understand why the ability to
internally queue events at a high rate is so much more important than the
latency which that batching will introduce.

(And keventd _does_ allow such batching.  schedule_delayed_work()).

