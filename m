Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319270AbSIKS2X>; Wed, 11 Sep 2002 14:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319271AbSIKS2X>; Wed, 11 Sep 2002 14:28:23 -0400
Received: from dsl-213-023-021-043.arcor-ip.net ([213.23.21.43]:745 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319270AbSIKS2T>;
	Wed, 11 Sep 2002 14:28:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: [RFC] Raceless module interface
Date: Wed, 11 Sep 2002 20:35:05 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209101201280.8911-100000@serv>
In-Reply-To: <Pine.LNX.4.44.0209101201280.8911-100000@serv>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17pCKQ-0007Sz-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

On Tuesday 10 September 2002 12:17, Roman Zippel wrote:
> I implemented something like this some time ago. If module->count isn't
> used by module.c anymore, why should it be in the module structure?
> Consequently I removed it from the module struct (what breaks of course
> unloading of all modules, so I'll probably reintroduce it with big a
> warning). If the count isn't in the module structure, the locking will
> become quite simpler. More info is here
> http://marc.theaimsgroup.com/?l=linux-kernel&m=102754132716703&w=2

Ah, I remember your original post but I didn't fully understand what you were 
going on about at the time.  Now I do, and we're on the same page.  Not only 
that, but I'm getting to the point with this messy problem where I can 
articulate the issues clearly, so let's try to do it now.  Please ack/nack me 
as I go.

First, let's identify the central issue that's causing conceptual problems 
for some who've sniffed at these issues.  It's simple, there are two broad 
categories of modules:

  - Those for which we account exactly for all task entry/exits
  - Those for which we do not, or cannot account current usage exactly

Let's call the former "counting" and the latter "noncounting" modules.  The 
number of tasks executing in a given module is the count of task entries 
minus the count of task exits.  Obviously this is a big problem when we have 
no good way of counting accurately, but it is not an insoluble problem, and a 
solution is presented here, based on earlier discussions on lkml.

Preventing Unload Races in Counting Modules
-------------------------------------------

Module unload races in counting modules are easy to handle.  Al Viro has 
written code that handles those in a passably competent way and we will 
improve Al's approach incrementally as described below.

I'll digress for a moment and ask the question "why are counting modules 
countable?".  Well, using filesystems as an example, the vfs initiates each 
and every call into a filesystem module, and every vfs high level function is 
structured in such a way that all calls into a filesystem module return 
before the the vfs goes on to do something else.  So it's easy to write 
accounting code that relies on this behavior, and in fact, the accounting job 
reduces to simply counting the number of times a given module is mounted vs 
unmounted.

Even in this simple situation there are possible races, and one of the races 
is dealt with by Al's odd-looking try_inc_mod_count function, which protects 
the incrementing of its counter in three ways: 1) by using atomic operations 
2) by protecting incrementing and testing with a spin lock 3) by additionally 
protecting incrementing with a state flag.  Decrementing the counter is 
protected only by the use of atomic decrement, and turns out not to need any 
more protection than that (granted, this interesting fact is largely useless 
in terms of cycles saved).

So let's look at the curious structure of the count increment operation, 
try_inc_mod_count.  This acts on a counter embedded in struct module.  (As 
you point out, it doesn't need to, it can act on a counter embedded in the 
struct filesystem instead, there is a very good reason for doing that, which 
I'll get back to.)

I'm won't show Al's version, I'll show my improved version, which  
substitutes a special state of the counter variable for Al's state flag, a 
small but useful change:

int try_inc_mod_count(struct module *module)
{
        int result = 1;
        if (module) {
                spin_lock(&unload_lock);
                if (atomic_read(&module->count) == -1)
                        result = 0;
                else
                        atomic_inc(&module->count);
                spin_unlock(&unload_lock);
        }
        return result;
}

If the counter has the value -1 then it can't be incremented and this 
function returns 0.  This corresponds to the state where unloading is in 
progress, and for filesystems, means that an attempted mount will fail.  If 
the counter has any other value then that value is incremented, the function 
returns true, and the mount proceeds.  Getting rid of the state flag 
simplifies the later step of removing the counter from struct module.

The only other thing worth noting about this function is that, to use it, you 
have to be able to locate the module given a struct filesystem, hence the 
->owner field in that structure.  With the techniques you and I have 
identified, we can dispense with the ->owner field, removing considerable 
cruft in the process.  However, for the moment I think we should produce a 
patch that aims narrowly at getting rid of the unload races, and do the 
spinoff cleanups after.

The other main part of this mechanism is in sys_delete_module, in which the 
test for zero module count and setting of the state flag are protected by the 
same spinlock as above.  Our improvement here will be to encapsulate this 
functionality in a module helper function, that looks something like this:

int try_mod_count(struct module *module)
{
	int count;
	spin_lock(&unload_lock);
	count = atomic_read(&module->count);
	if (!count)
		atomic_set(&module->count, -1);
	spin_unlock(&unload_lock);
	return count;
}

This function returns zero if the (counting) module has no users, and returns 
the (approximate) number of users otherwise.  If the function returns zero, 
then additionally, the module count is set to -1, a state in which 
try_inc_mod_count is prevented from incrementing it, so after the spinlock is 
released, any pending mounts will fail as they should, because we have been 
asked to unload the module and are in the process of doing so.

The remaining possible races here are currently closed by the BKL, and we 
will change that to a semaphore in due course.  The fact that we use a 
sleeping lock for this purpose means that a module's cleanup_function is 
unrestricted in terms of scheduling.

The (counting) module's cleanup_function will therefore look something like 
this:

	int error = try_mod_count(module);
	if (!error) {
		unregister_filesystem(foo_filesystem);
		cleanup_foo(foo_filesystem);
	}
	return error;

And we will later design the 'module' parameter out of this, because it is no 
longer needed by generic code and so the associated cruft can be eliminated.  
As a programmer/guru friend once said: the code "won't have its thumb tied to 
its nose any more".

Note that our returned error can also take on a negative value (i.e., a 
standard error code) should module unloading fail for some other reason than 
the module simply having users.  Additionally, a return of -1 means "you 
already killed me, stupid, I'm already dead, and I already unregistered and 
cleaned up my filesystem".  The state the module is in when its count is -1 
is interesting and potentially useful: in this state the module can legally 
be reinitialized/reactivated, instead of just being removed from the module 
list and destroyed.

(Roman, is -1 an ok error code to return here, given that there could be 
other negative error values returned as well?)

Now we can look at the revised version of sys_delete_module, which has the 
code:

	BUG_ON(!mod->cleanup);
	if ((error = mod->cleanup())
		goto out_error;
	free_module(module);

and free_module will no longer call the cleanup_function.  Nice and simple, 
easy to understand, is it not?  What's more, we don't have to change this 
code at all to handle the more difficult case of noncounting modules.

Preventing Unload Races in Noncounting Modules
----------------------------------------------

Noncounting modules typically don't keep track of the number of task 
entry/exits, typically because the cost of even a simple inc/dec wrapper in 
generic kernel code is unacceptable, and because the wrappers just plain look 
ugly.  The proposed Linux Security Module is a good example of a noncounting 
kind of module: many vfs functions that currently execute security checks 
using inline code now must henceforth call indirectly through a module to do 
it.  Linus will never buy it if these calls are inefficient.  At present, 
some of these security tests consist of just a few instructions, so wrapping 
an accounting interface around those is going to show up on an execution 
profile, never mind the extra source code.

This is far from the only reason why a module might be noncounting, but it's 
sufficient to show why we can't ignore the problem.  Fortunately, there is a 
well-understood way to deal with such modules, consisting of two steps:

  - Stub out all the module call points
  - Wait until ever running task on the system has scheduled at least once

To make this work, we rely on the rule that no module code may sleep/schedule 
unless it first increments a counter.  The counter incremented will, at 
present, be the module->count, but that is entirely up to the module itself; 
module.c will no longer care how it keeps track, as long as it does.

With config_preempt code, we must additionally disable preemption until the 
module quiescence test has completed.  I'm not going to go further into this, 
because this is deep scheduling-fu, and I haven't got working code to show 
yet.  Suffice to say that we have the technology to build a 
magic_wait_for_quiescence, and we must now proceed to do that.  (Robert, are 
you reading?)  A noncounting module uses the test as follows, in its 
cleanup_function:

	unregister_callpoints(...);
	magic_wait_for_quiescence();
	return cleanup_foo(...);

Blessed relief, that was easy.  Now it's just a matter of coding ;-)

One can easily imagine a kind of module that needs both the try_mod_count 
mechanism and the magic_wait_for_quiescence, or one that also has to wait for 
some daemon to exit, or a module that supports more than a single subsystem, 
possibly of very different kinds.  All these variations are handled in the 
obvious way: by customizing the cleanup_function, with the aid of helper 
functions.  This allows us to avoid the strong temptation to over-engineer 
the module interface, trying to anticipate every possible kind of module that 
someone might write in the future.

Now there's the question "if this is such a great approach, why not make all 
modules work this way, not just filesystems?".  Easy: the magic scheduling 
approach impacts the scheduler, however lightly, and worse, we cannot put an 
upper bound on the time needed for magic_wait_for_quiescence to complete.  So 
the try_count approach is preferable, where it works.

Implementation Issues
---------------------

OK, I think we agree on the general outline of the work that has to be done.  
If not, please shout now, otherwise, feel free to niggle me to death in the 
usual way ;-)

Let me touch on just one more issue: we need to do this work without breaking 
every existing module in the world.  In other words, we need a compatibility 
wrapper to get us through the period, possibly as long as a year or two, when 
there are still a lot of modules both in-kernel and outside, whose 
cleanup_functions just return void.  Module.c will detect this and do theits 
magic_wait_for_quiescence following the module's cleanup_function.  Thus, 
such modules will be no more broken than they ever were.

What we want is a define a new 'module_kill' macro, which will live alongside 
a backwards-compatible 'module_exit' macro for now.  The latter generates a 
function call hook that module.c detects and wraps like this:

	if (!mod->old_cleanup) {
		WARN(1, "Please fix your old-style module");
		if ((error = try_mod_count(module)))
			goto out_error;
		mod->old_cleanup();
		free_module(module);
	} else {
		<nice new interface>
	}

Miscellaneous other improvements we might want to make are:

  - Use a semaphore instead of lock_kernel
  - Clean up the generally substandard code in module.c
  - Move the semaphore into struct module
  - Move unload_lock into module
  - Other things I've forgotten for the moment

But these can all wait.  We have races now, and we have proposals on the 
table that smell like over-engineering.  So we need to do the work I've 
described above, promptly, and get it into circulation.

Comments/flames/races?

-- 
Daniel
