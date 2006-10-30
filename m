Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751848AbWJ3OYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbWJ3OYk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 09:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbWJ3OYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 09:24:40 -0500
Received: from smtpout.mac.com ([17.250.248.186]:18413 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751848AbWJ3OYh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 09:24:37 -0500
In-Reply-To: <Pine.LNX.4.64.0610281651340.3849@g5.osdl.org>
References: <200610282350.k9SNoljL020236@freya.yggdrasil.com> <Pine.LNX.4.64.0610281651340.3849@g5.osdl.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A2B15573-3DDD-4F70-AC04-C37DBA3AC752@mac.com>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, akpm@osdl.org, bunk@stusta.de,
       greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, matthew@wil.cx, pavel@ucw.cz,
       shemminger@osdl.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [patch] drivers: wait for threaded probes between initcall levels
Date: Mon, 30 Oct 2006 09:23:10 -0500
To: Linus Torvalds <torvalds@osdl.org>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 28, 2006, at 19:55:42, Linus Torvalds wrote:
> On Sun, 29 Oct 2006, Adam J. Richter wrote:
>> If only calls to execute_in_parallel nest, your original  
>> implementation would always deadlock when the nesting depth  
>> exceeds the allowed number of threads, and also potentially in  
>> some shallower nesting depths given a very unlucky order of  
>> execution.  In your original message, you mentioned allowing the  
>> parallelism limit to be set as low as 1.
>
> No, I'm saying that nesting simply shouldn't be _done_. There's no  
> real reason. Any user would be already either parallel or doesn't  
> need to be parallel at all. Why would something that already _is_  
> parallel start another parallel task?

Well, I would argue that there actually _is_ a reason; the same  
reason that GNU make communicates between recursive invocations to  
control the maximum number of in-progress execution threads ("-J4"  
will have 4 make targets running at once, _even_ in the presence of  
recursive make invocations and nested directories).  Likewise in the  
context of recursively nested busses and devices; multiple PCI  
domains, USB, Firewire, etc.

> IOW, what I was trying to say (perhaps badly) is that "nesting"  
> really isn't a sensible operation - you'd never do it. You'd do the  
> "startup" and "shutdown" things at the very highest level, and then  
> in between those calls you can start a parallel activity at any  
> depth of the call stack, but at no point does it really make sense  
> to start it from within something that is already parallel.

Well, perhaps it does.  If I have (hypothetically) a 64-way system  
with several PCI domains, I should be able to not only start scanning  
each PCI domain individually,  but once each domain has been scanned  
it should be able to launch multiple probing threads, one for each  
device on the PCI bus.  That is, assuming that I have properly set up  
my udev to statically name devices.

Perhaps it would make more sense for the allow_parallel() call to  
specify instead a number of *additional* threads to spawn, such that  
allow_parallel(0) on the top level would force the normal serial boot  
order, allow_parallel(1) would allow one probing thread and the init  
thread to both probe hardware at once, etc.

With a little per-thread context on the stack, you could fairly  
easily keep track of the number of allowed sub-threads on a per- 
allow_parallel() basis.  Before you spawn each new thread, create its  
new per-thread state for it and pass its pointer to the child  
thread.  With each new do_in_parallel() call it would down the  
semaphores for each "context" up the tree until it hit the top, and  
then it would allocate a new context and fork off a new thread for  
the _previous_ call to do_in_parallel().  The last call would remain  
unforked, and so finalize_parallel() would first execute that call in  
the current thread and then reap all of the children by waiting on  
their completions then freeing their contexts.

I admit the complexity is a bit high, but since the maximum nesting  
is bounded by the complexity of the hardware and the number of  
busses, and the maximum memory-allocation is strictly limited in the  
single-threaded case this could allow 64-way systems to probe all  
their hardware an order of magnitude faster than today without  
noticeably impacting an embedded system even in the absolute worst case.

I _believe_ that this should also be coupled with a bit of cleanup of  
probe-order dependencies.  If a subsystem depends on another being  
initialized, the depended-on one could very easily export a  
wait_for_foo_init() function:

DECLARE_COMPLETION(foo_init_completion);
static int foo_init_result;

int wait_for_foo_init()
{
	wait_for_completion(&foo_init_completion);
	return foo_init_result;
}

int foo_init(struct parallel_state *state)
{
	struct foo_device *dev;
	
	allow_parallel(state, 3);

#if 1
	/* Assumes: int foo_probe_device(void *dev); */
	for_each_foo_device(dev)
		do_in_parallel(state, foo_probe_device, dev);
#else
	/* Assumes: int foo_probe_device(struct parallel_state *state,
			void *dev); */
	for_each_foo_device(dev)
		do_in_parallel_nested(state, foo_probe_device, dev);
#endif

	foo_init_result = finalize_parallel(state);
	complete(&foo_init_completion);
	return foo_init_result;
}

And of course if you wanted to init both the foo and bar busses in  
parallel you could implement a virtually identical function using the  
do_in_parallel_nested() variant on top of the foo_init() function.

I'm working on a sample implementation of the allow_parallel()  
do_in_parallel() and finalize_parallel() functions, but I'm going to  
take the time to make sure its right.  In the mean-time, I'm  
interested in any comments.

Cheers,
Kyle Moffett
