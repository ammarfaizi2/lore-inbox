Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262666AbVDAJ1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbVDAJ1N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 04:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbVDAJ1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 04:27:13 -0500
Received: from fire.osdl.org ([65.172.181.4]:32218 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262666AbVDAJ1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 04:27:03 -0500
Date: Fri, 1 Apr 2005 01:25:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: johnpol@2ka.mipt.ru
Cc: linux-kernel@vger.kernel.org, guillaume.thouvenin@bull.net,
       jlan@engr.sgi.com, efocht@hpce.nec.com, linuxram@us.ibm.com,
       gh@us.ibm.com, elsa-devel@lists.sourceforge.net, greg@kroah.com
Subject: Re: [1/1] CBUS: new very fast (for insert operations) message bus
 based on kenel connector.
Message-Id: <20050401012547.68c26523.akpm@osdl.org>
In-Reply-To: <1112345400.9334.157.camel@uganda>
References: <20050320112336.2b082e27@zanzibar.2ka.mipt.ru>
	<20050331162758.44aeaf44.akpm@osdl.org>
	<1112337814.9334.42.camel@uganda>
	<20050331232625.09057712.akpm@osdl.org>
	<1112341514.9334.103.camel@uganda>
	<20050331235927.6d104665.akpm@osdl.org>
	<1112345400.9334.157.camel@uganda>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
>
> On Thu, 2005-03-31 at 23:59 -0800, Andrew Morton wrote:
> > Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > >
> > > On Thu, 2005-03-31 at 23:26 -0800, Andrew Morton wrote:
> > > > Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > > > >
> > > > > > > +static int cbus_event_thread(void *data)
> > > > >  > > +{
> > > > >  > > +	int i, non_empty = 0, empty = 0;
> > > > >  > > +	struct cbus_event_container *c;
> > > > >  > > +
> > > > >  > > +	daemonize(cbus_name);
> > > > >  > > +	allow_signal(SIGTERM);
> > > > >  > > +	set_user_nice(current, 19);
> > > > >  > 
> > > > >  > Please use the kthread api for managing this thread.
> > > > >  > 
> > > > >  > Is a new kernel thread needed?
> > > > > 
> > > > >  Logic behind cbus is following: 
> > > > >  1. make insert operation return as soon as possible,
> > > > >  2. deferring actual message delivering to the safe time
> > > > > 
> > > > >  That thread does second point.
> > > > 
> > > > But does it need a new thread rather than using the existing keventd?
> > > 
> > > Yes, it is much cleaner [especially from performance tuning point] 
> > > to use own kernel thread than pospone all work to the queued work.
> > > 
> > 
> > Why?  Unless keventd is off doing something else (rare), it should be
> > exactly equivalent.  And if keventd _is_ off doing something else then that
> > will slow down this kernel thread too, of course.
> 
> keventd does very hard jobs on some of my test machines which 
> for example route big amount of traffic.

As I said - that's going to cause _your_ kernel thread to be slowed down as
well.

I mean, it's just a choice between two ways of multiplexing the CPU.  One
is via a context switch in schedule() and the other is via list traversal
in run_workqueue().  The latter will be faster.

> > Plus keventd is thread-per-cpu and quite possibly would be faster.
> 
> I experimented with several usage cases for CBUS and it was proven 
> to be the fastest case when only one sending thread exists which manages
> only very limited amount of messages at a time [like 10 in CBUS
> currently]

Maybe that's because the cbus data structures are insufficiently
percpuified.  On really big machines that single kernel thread will be a
big bottleneck.

> without direct awakening [that is why wake_up() is commented in
> cbus_insert()].

You mean the

	interruptible_sleep_on_timeout(&cbus_wait_queue, 10);

?  (That should be HZ/100, btw).

That seems a bit kludgy - someone could queue 10000 messages in that time,
although they'll probably run out of memory first, if it's doing
GFP_ATOMIC.

Introducing an up-to-ten millisecond latency seems a lot worse than some
reduction in peak bandwidth - it's not as if pumping 100000 events/sec is a
likely use case.  Using prepare_to_wait/finish_wait will provide some
speedup in SMP environments due to reduced cacheline transfers.

> If too many deferred insert works will be called simultaneously
> [which may happen with keventd] it will slow down insert operations
> noticeably.

What is a "deferred insert work"?  Insertion is always synchronous?

> I did not try that case with the keventd but with one kernel thread 
> it was tested and showed worse performance.

But your current implementation has only one kernel thread?

