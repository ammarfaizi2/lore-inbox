Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267132AbSKSHF7>; Tue, 19 Nov 2002 02:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267130AbSKSHF7>; Tue, 19 Nov 2002 02:05:59 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:19370 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264771AbSKSHF4>;
	Tue, 19 Nov 2002 02:05:56 -0500
Date: Tue, 19 Nov 2002 02:12:54 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Doug Ledford <dledford@redhat.com>,
       Linux Scsi Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Why /dev/sdc1 doesn't show up... 
In-Reply-To: <20021119055636.94C182C088@lists.samba.org>
Message-ID: <Pine.GSO.4.21.0211190116420.27757-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Nov 2002, Rusty Russell wrote:

> means that /sbin/hotplug is called for everything which was registered
> at boot.  (We may not want to do this, but in general the symmetry
> seems really nice).
> 
> [ Note: the logic for /sbin/hotplug applies to any similar "publicity"
>   function which promises that something now exists. ]
> 
> Al, thoughts?
> Rusty.

Wrong granularity.  "module had finished initialization" is _not_ a natural
event wrt stuff exported by that module.  And that's one of the main problems
I have with your approach - you are trying to make module loader do the
stuff that has nothing whatsoever with modules.

Moreover, if driver is built into the kernel, you get (at the very least)
a different mechanism for triggering the same events, if not the outright
different sequence of events.  Which is a Bad Thing(tm) since it leads to
a shitload of extra problems with debugging.

I went through the init code of all block device drivers and there was
a metric buttload of crap in handling failures.  I doubt that more than
5% had any relation to races - much more often taking given failure path
had lead to oops.  Deterministic one.  With nothing else happening with
the system.

Double freeing.  Forgetting to free.  Dereference after freeing.  Leaving
timers active.  Leaving pointers to local structures in global arrays.
Plain and simple dereferencing of NULL due to wrong order.  Freeing what
you had never allocated.  Similar for resources other than memory.  Doing
cleanup in a fashion that screws other drivers.  IOW, all sorts of crap
that can accumulate in a spaghetty code that never got any serious testing.
Path-dependent crap, at that - different exits are fscked in different ways.

On that background all shite you are so concerned about is a noise.  More often
than not, screwups in export order that might be papered over by your semantics
change either do not matter since the module doesn't fail in init _or_ do not
matter since it does fail and gets the system fscked to hell and back on the
failure exit path, races or not.

In other words, this band-aid doesn't do anything useful - if you go and
fix the crap in driver's init you can fix the export order while you are
at it.  If you do not - pray that failure will not happen, because it it
will you are screwed without any races.

There is no fscking way for module loader to handle that.  Leave it as-is,
possibly making the loader BUG() if init fails and refcount is positive.
Anything beyond that is not a responsibility of modules code.  Note that
such BUG() doesn't add any new breakage - such situation had always been
a bug.  

And yes, that means the need to fix the error recovery in driver init.
Tough.  I don't know any other way to handle
	kfree(p);
	p = NULL;
	kfree(p->bar);
and I don't believe that you can find one.  Again, no silver bullets -
if you want to talk about handling half-way failures in module init,
be ready to deal with the above (embedded into the mess of goto and
function calls, to boot).

We are talking about bugs that had always been on these codepaths - both
in modular and built-in cases.  They need to be dealt with before we can
do anything about these codepaths.  Has nothing to module loader...

What we _can_ do (and that will be on per-subsystem basis) is providing
APIs that would cut down on the amount of glue needed in driver init.
And that's where switch to use of /sbin/hotplug (again, on per-subsystem
basis) might help big way.  But for each subsystem that will require
looking through the drivers using it.

BTW, remember the flamef^Warguments about turning kdev_t into a pointer
and thus avoiding digging through piles and piles of cr^Hode?  Didn't
fly for exactly the same reasons - there's no way to do it magically
for entire kernel without breaking tons of code and/or creating an
impossible-to-debug mess...

