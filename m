Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265895AbTAOJZJ>; Wed, 15 Jan 2003 04:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265909AbTAOJZJ>; Wed, 15 Jan 2003 04:25:09 -0500
Received: from almesberger.net ([63.105.73.239]:27919 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S265895AbTAOJZG>; Wed, 15 Jan 2003 04:25:06 -0500
Date: Wed, 15 Jan 2003 06:33:49 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kuznet@ms2.inr.ac.ru, Roman Zippel <zippel@linux-m68k.org>,
       kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Migrating net/sched to new module interface
Message-ID: <20030115063349.A1521@almesberger.net>
References: <20030115043147.A1840@almesberger.net> <20030115082444.062EF2C0F0@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030115082444.062EF2C0F0@lists.samba.org>; from rusty@rustcorp.com.au on Wed, Jan 15, 2003 at 07:16:24PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 1) It's simply not a good idea to force 1600 modules to change, no
>    matter what timescale.

That's the part that I don't believe. The kernel interfaces
aren't static. Locking rules have changed several times, the
wait/sleep interface has changed, the concept of a module
owner has been added, various other interfaces have changed.

So a module will eventually have to be maintained. And the
more important a module, the more timely this will be done.
(Well, or so everybody wishes :-) Unmaintained modules will
eventually just fail to work or even compile for other reasons,
at which point they cease to be a problem as far as the
loading/unloading mechanism is concerned.

I agree that it's a bad idea to force changes. That's why
there should be a reasonably long period where the current
hack and a clean mechanism are available in parallel.

> And changing it in a way that is *more*,
>    not *less* complex is even worse.

The implementation may be more complex, but the change I'm
suggesting would greatly simplify the rules: no endless set
of voodoo rites, but one simple rule: "the shutdowncall
function either does nothing, and returns failure, or it
returns success, and completely de-registers everything it
has previously registered".

> PS.  The *implementation* flaw in your scheme: someone starts using a
>      module as you try to deregister it.

How could they ? The symbols are hidden, so that way is
blocked. If another module has registered callbacks using
symbols obtained from that module, that other module needs
to be unloaded first anyway, so these references are gone
too.

If the static kernel accesses a module by resolving symbols
(except for the well-controlled operations of the module
loader itself), yes, then that module would become
un-unloadable. I'm not sure this is much of an issue.

If a callback comes in at the wrong moment, the module can
choose to de-register and wait until the subsystem has
finished any callbacks, or detect that it's about to
shut itself down, and fail the callback. The point is that
all the locking is now under control of the module, and
not scattered all over kernel+module(s).

> (ie. you can never unload security modules),

Hmm, what makes security modules (what exactly do you mean
by that ?) special ? In any case, a module that's truly
unloadable would simply return failure from its
shutdowncall.

> or you leave it half unloaded (even worse).

There's always the choice of just sleeping through any
inconvenient callbacks. In some cases, this is perfectly
acceptable, because the callback won't keep the module
busy for a long time anyway (interrupts, timers, tasklets,
etc.). In other cases (e.g. "open" functions), a callback
could keep it busy forever.

In that case, the module needs to maintain its own usage
count and have some flag that indicates that it's shutting
down. So the callback would look like this:

static int foo_open(...)
{
	atomic_inc(&busy);
	if (shutting_down) {
		atomic_dec(&busy);
		return -EGONEFISHING;
	}
	...
}

static int foo_shutdown(...)
{
	shutting_down = 1;
	if (atomic_read(&busy)) {
		shutting_down = 0;
		return -EBUSY;
	}
	deregister_whatever(&myself);
	/* deregister and synchronize */
	...
}

"busy" could of course just be the module use count.

There is the race condition that the module could briefly
disappear (i.e. "foo_open" fails), and then come back, because
it turned out to be or appear to be busy. But I think,
considering that we're actually trying to make it go away, this
is acceptable behaviour. You have the race conditions "is busy"
vs. "can unload" and "can use" vs. "has been unloaded" anyway.

This can be greatly simplified if we have a
try_deregister_whatever that just returns an error if it would
have to sleep, i.e. if the synchronization is pushed into the
service.

Of course, if the "whatever" subsystem will make callbacks
after returning from deregister_whatever, this doesn't work,
and the module has to use the old mechanisms. But that's really
a bug in the "whatever" subsystem.

The problem I see with the current module interface is that it
just tries to hack the current mess into a less buggy state,
but doesn't provide much of an incentive for actually cleaning
up the interfaces.

Avoiding the bugs is good, but we should also work towards a
clean long-term solution.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
