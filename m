Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261451AbSKZWyD>; Tue, 26 Nov 2002 17:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261495AbSKZWyD>; Tue, 26 Nov 2002 17:54:03 -0500
Received: from dp.samba.org ([66.70.73.150]:11730 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261451AbSKZWx6>;
	Tue, 26 Nov 2002 17:53:58 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Werner Almesberger <wa@almesberger.net>
Cc: linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: Module Refcount & Stuff mini-FAQ 
In-reply-to: Your message of "Tue, 26 Nov 2002 04:12:12 -0300."
             <20021126041212.B22825@almesberger.net> 
Date: Wed, 27 Nov 2002 09:56:29 +1100
Message-Id: <20021126230116.0D27E2C478@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021126041212.B22825@almesberger.net> you write:
> Rusty Russell wrote:
> > Yes, but between doing and undoing (in the failure path) someone has
> > started using the module.
> 
> But how ? Don't we have only two ways of calling a module, i.e.
> by symbol, or by callback ? All callbacks that might call a module
> must be protected with try_module_get, right ? (*)

try_module_get() will succeed now during initialization, because the
module starts live.

> 
> (*) Actually, if the registration can be revoked, and the
>     deregistration function does properly synchronize with on-going
>     callbacks, you shouldn't need try_module_get either. E.g.
>     del_timer_sync doesn't need to know about module owners.

del_timer_sync is actually an oddity: most deregistration functions do
not block pending outstanding calls, they reference count and "unhook"
at deregistration, and delete when the refcount hits zero (if they do
anything at all 8).

(Note also: timers don't need to do try_module_get() since they can't
sleep).

> So, if you make try_module_get work during initialization, and
> modules don't publish their symbols before initialization is done,
> there should be no problem ?

Yes, but that's not the way things work currently: the interfaces to
reserve and publish are not separated.  And whether it's worth
separating them simply because of this, is the question.

> By the way, it's also not so nice that there can't be
> callbacks at removal, e.g.
> 
> service_unregister(...)
> {
> 	...
> 	for_pending_requests(req) {
> 		...
> 		if (try_module_get(req->owner))
> 			req->fn(req,REQUEST_CANCELLED);
> 		else
> 			printk(KERN_CRIT "we just dropped a request on the "
> 			  "floor, how nice\n");
> 		...
> 	}
> 	...
> }
> 
> Calling this from the module removal function would be
> perfectly safe.

Yes, and it's already in the list of exceptions: you're being called
by the module itself here.

Also, you're assuming that the coder chose not to do the
try_module_get() at request submission time.

Finally, there are some cases where a module can miss events while
unloading, but that's OK, because it's *guaranteed* to exit at this
point, so it must clean everything up in its cleanup routine anyway.
I couldn't think of an exception, can you?

> Actually ... can't you allow modules to be called until the
> cleanup function has returned ?

Only by splitting cleanup into "cleanup" and "destroy" (either by
having cleanup say "OK, I'm not live anymore" halfway though, or
having separate hooks).

We have over 1500 modules: not changing the interfaces to them was one
of the key goals.  If someone decides to later, fine.

> Two in one strike ain't bad ;-) Maybe we can find something that
> gets rid of that pesky NFS, too, e.g. by adding
> 
> #define while if    /* enforce efficient programming practices */
> 
> to linux/kernel.h, or such ;-)

Heh...  <sigh> Point taken.  I already decided to leave this one for
the moment, and do something more productive.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
