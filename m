Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261688AbSIXO7O>; Tue, 24 Sep 2002 10:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261689AbSIXO7O>; Tue, 24 Sep 2002 10:59:14 -0400
Received: from dp.samba.org ([66.70.73.150]:19615 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261688AbSIXO7K>;
	Tue, 24 Sep 2002 10:59:10 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: kaos@ocs.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] In-kernel module loader 1/7 
In-reply-to: Your message of "Tue, 24 Sep 2002 12:16:42 +0200."
             <Pine.LNX.4.44.0209231954040.338-100000@serv> 
Date: Wed, 25 Sep 2002 00:54:27 +1000
Message-Id: <20020924150424.504A42C07A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0209231954040.338-100000@serv> you write:
> Hi,
> 
> On Mon, 23 Sep 2002, Rusty Russell wrote:
> 
> > Yeah, I realized this after I sent the mail.  Sorry.  The problem is
> > one level higher in your implementation:
> >
> > 		error = start_module(mod);
> > 		if (error)
> > 			exit_module(mod);
> >
> > If the exit fails here (because the module is now in use, so the
> > unregister_notifier() fails, you need to loop and yield, because you
> > have no way of saying "wake me when you can be unloaded".
> 
> That's not the job of the kernel, the module will stay in the cleanup
> stage, until the the user requests module removal. This is what actually
> happens above:
> 
> 	mod->state = initializing;
> 	err = mod->init();
> 	if (err) {
> 		mod->state = cleanup;
> 		if (!mod->exit())
> 			mod->state = exit;
> 	} else
> 		mod->state = running;
> 
> As long as the module is in the cleanup stage you can only call exit().

Ah, OK, I missed the bit test around the unregister_module().  You
leave it half-loaded.  Sorry for being so obtuse.

> > > 	err = unregister_filesystem(&some_notifier2);
> > > 	if (err)
> > > 		return err;
> >
> > This will trigger (err == -ENOENT) I assume?  I think you really need:
> 
> Look at the unregister example in the last mail. It will suceed silently.

Does that really seem consistent?  Unregister functions don't fail if
you're not registered, but fail if it can't unregister you because
you're busy?

> > Hmm, at least if we force the module author to provide two functions,
> > they don't have to have a clear understanding of the subtleties.  I
> > know, I'm a coward.
> 
> This shouldn't be the standard method, so any module author using such
> hooks should be aware of it's problems, so I don't see a problem here.

I still worry that they don't *know* when they need to do something
special.  This is true of almost any implementation.

> > I'm not clear on the exact desired semantics of stop and exit?  When
> > should stop() fail?
> 
> stop() would just unregister the interface and is not really expected to
> fail. On the other it's also possible to do an implicit stop within the
> exit call.

I guess it would be clearer (to me at least) if it returned void then.

> > int stop_ip_conntrack(void)
> > {
> > 	nf_unregister_hook(&ip_conntrack_in_ops);
> > 	nf_unregister_hook(&ip_conntrack_local_out_ops);
> > 	nf_unregister_hook(&ip_conntrack_out_ops);
> > 	nf_unregister_hook(&ip_conntrack_local_in_ops);
> > 	/* Force synchronization */
> > 	br_write_lock_irq(BR_NETPROTO_LOCK);
> > 	br_write_unlock_irq(BR_NETPROTO_LOCK);
> 
> nf_unregister_hook() already takes BR_NETPROTO_LOCK?

It does indeed.  The synchronize step is not required here (it is in
the real code, which uses also uses an "ip_ct_attach" ptr).

> > 	if (proc_net_destroy(proc) == -EBUSY)
> > 		return -EBUSY;
> 
> That goes into the exit routine and a proc_net_unlink() should be here.

Right, ok.

> > 	return 0;
> > }
> >
> > Now, we put callback pointers inside packets, so we need to keep a
> > count of how many of those we have (packet_count):
> >
> > int exit_ip_conntrack(void)
> > {
> > 	if (!bigref_is_zero(&packet_count))
> > 		return -EBUSY;
> >
> > 	/* Woohoo!  We're free, clean up! */
> > 	ip_conntrack_cleanup();
> > 	return 0;
> > }
> 
> It's pretty simple to join the stop/exit functions into single functions.
> I think it's better if the destroy function also does an unlink if
> necessary and the start/stop functions should/can be introduced later.
> BTW another way to avoid the packet count would to examine every active
> packet and check for pointers to the module.

We don't keep a list of packets anywhere useful: they're spread
throughout the system (well, not quite true, we do use a slab cache
8).

> Um, sorry if that code caused confusion, that code will change. The
> start/stop will be introduced later. If the exit fails the module must
> stay in the cleanup state and the next cleanup attempt should only be done
> on explicit user request.

Oh, OK.

> Maybe I really should update the patch. :) I'm not sure if the problem is
> really that urgent that it can't wait for 2.7. On the other hand I could
> produce a patch that preserves complete backward compability, but already
> introduces the new infrastructure.

Roman, I'm determined to put the in-kernel module linker in 2.5, and
these races will be solved in some way.  It's too much obviously the
right thing, especially now I've implemented modversions, parameters
and licensing stuff on top of it.  Now the implementations can change
between kernel versions without any pain, even if you don't agree that
it's markedly simpler and makes initramdisk feasible.

In summary, your approach requires (I hope I am being fair?):

1) Registration interfaces (where callbacks can sleep) must keep track
   of reference counts of current users.

2) They must also implement two-stage delete (ie. proc_net_unlink()).

3) Their de-registration interfaces must fail if they are in use (and
   for no other reason, including an uninitialized never-registered
   object).

4) Module initialization should remove their cleanup paths, and ensure
   that the exit function can be called if initialization fails
   partway.

5) Modules which use unsafe interfaces must be very careful.

Now, my approach requires:
1) Registration interfaces (where callbacks can sleep) must keep track
   of reference counts of current users through try_module_get(foo->owner),
   and handle it failing.

2) Modules which use unsafe interfaces must be very careful.

See why I like the "extend try_inc_mod_count()" solution?  It's not
perfect, but it's already there and it's simple.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
