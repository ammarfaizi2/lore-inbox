Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261850AbSJQHtt>; Thu, 17 Oct 2002 03:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261851AbSJQHtt>; Thu, 17 Oct 2002 03:49:49 -0400
Received: from dp.samba.org ([66.70.73.150]:38819 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261850AbSJQHtk>;
	Thu, 17 Oct 2002 03:49:40 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Daniel Phillips <phillips@arcor.de>, S@samba.org
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
ubject: Re: [PATCH] In-kernel module loader 1/7 
In-reply-to: Your message of "Thu, 17 Oct 2002 03:57:17 +0200."
             <E181zuY-0004Fl-00@starship> 
Date: Thu, 17 Oct 2002 17:41:08 +1000
Message-Id: <20021017075539.8DE762C0CA@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <E181zuY-0004Fl-00@starship> you write:
> On Thursday 17 October 2002 00:48, Rusty Russell wrote:
> > > On Wednesday 16 October 2002 08:11, Rusty Russell wrote:
> > > > It needs to be turned off when dealing with any interface which might
> > > > be used by one of the hard modules.  Which is pretty bad.
> > > 
> > > As far as I can see, preemption only has to be disabled during the 
> > > synchronize_kernel phase of unloading that one module, and this requireme
nt 
> > > is inherited neither by dependant or depending modules.
> > 
> > No, someone could already have been preempted before you start
> > synchronize_kernel().
> 
> I don't get that.  The sequence is:
> 
>   - turn off preemption
>   - unhook call points
>   - synchronize_kernel
>   - ...
> 
> which doesn't leave any preemption hole that I can see, so I can't comment
> on a couple of the other points until you clear that one up.

You mean that "turn off preemption" also wakes up anyone currently
preempted?  Otherwise they're preempted just inside one of those call
points.

> > Still a race between the zero check and the can't-increment state
> > setting.
> 
> But that one is easy: the zero check just takes the same spinlock as 
> TRY_INC_MOD_COUNT, then sets can't-increment only in the case the count
> is zero, considerably simpler than:

The current spinlock is horrible.  You could use a brlock, of course,
but I didn't mainly because of code bloat and speed.  My current code
looks like:

static inline int try_module_get(struct module *module)
{
	int ret = 1;

	if (module) {
		unsigned int cpu = get_cpu();
		if (likely(module->ref[cpu].live))
			local_inc(&module->ref[cpu].counter);
		else
			ret = 0;
		put_cpu();
	}
	return ret;
}

Which is small enough to be inlined quite nicely, and very fast.
Adding br_read_lock_irqsave() starts to get big and slow (at that
point it's more likely we want to move the module case out of line).

> > This is what my current code does: rmmod itself checks (if
> > /proc/modules available), then the kernel sets the module to
> > can't-increment, then checks again.  If the non-blocking flag is set,
> > it then re-animates the module and fails, otherwise it waits.
> 
> and leaves no window for spurious failure.  The still-initializing case is
> also easy, e.g., a filesystem module simply doesn't call register_filesystem
> until it's completely ready to service calls, so nobody is able to do
> TRY_INC_MOD_COUNT.

Consider some code which needs to know when cpus go up and down, so
registers a notifier.  If the notifier fires before the init is
finished, the notifier code will fail to "try_inc_mod_count()" and
won't call it (it doesn't do try_inc_mod_count at the moment, but
that's a bug).

I don't know of any code which does this now, but it is at least a
theoretical problem.

> > BTW, current patchset (2.5.43):
> 
> Thanks, I'll read them all on the 21st ;-)  The other thing I need to read
> closely is Roman's strategy for changing the module format, and the weird
> linker connections.

Roman dislikes linking in the kernel.  So did I until I wrote it: it's
really trivial (esp. compared with the code to coordinate with the
userspace linker properly).  And it exists today.  The linking takes
around 200 lines.  But, let's say his solution is 500 lines shorter
than mine.

For those five hundred lines, the new parameter infrastructure and
module versioning changes can be done *without* requiring any changes
in modutils.  If you've been following the module changes closely in
the last couple of years, you'll realize what a pain it has been to
introduce changes like licensing, etc.  This frees up our hand.

IMHO, the benifits of having it in-kernel outweigh the slight extra
size.

> > ...The second is the "die-mother-fucker-die"
> > version, which taints the kernel and just removes the damn thing.  For
> > most people, this is better than a reboot, and will usually "work".
> 
> Is there a case where removing a module would actually help?  What is
> the user going to do next, try to reinsert the same module?

Insert a fixed one, hopefully 8).  I was thinking for kernel
developers, and general robustness (eg. an oops inside a module leaves
its refcount at 1).

> > http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Module/force-un
load.patch.gz
> 
> ERROR 404: Not Found.

Damn my fingers.  Updated (now applies on top of the others) but I
haven't tested this version yet (that's what I'm doing now):

http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Module/forceunload.patch.gz

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
