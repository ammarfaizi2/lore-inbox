Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261632AbSIXKL5>; Tue, 24 Sep 2002 06:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261635AbSIXKL5>; Tue, 24 Sep 2002 06:11:57 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:62733 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261632AbSIXKLz>; Tue, 24 Sep 2002 06:11:55 -0400
Date: Tue, 24 Sep 2002 12:16:42 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: kaos@ocs.com.au, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] In-kernel module loader 1/7 
In-Reply-To: <20020923002313.E42122C0D7@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0209231954040.338-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 23 Sep 2002, Rusty Russell wrote:

> Yeah, I realized this after I sent the mail.  Sorry.  The problem is
> one level higher in your implementation:
>
> 		error = start_module(mod);
> 		if (error)
> 			exit_module(mod);
>
> If the exit fails here (because the module is now in use, so the
> unregister_notifier() fails, you need to loop and yield, because you
> have no way of saying "wake me when you can be unloaded".

That's not the job of the kernel, the module will stay in the cleanup
stage, until the the user requests module removal. This is what actually
happens above:

	mod->state = initializing;
	err = mod->init();
	if (err) {
		mod->state = cleanup;
		if (!mod->exit())
			mod->state = exit;
	} else
		mod->state = running;

As long as the module is in the cleanup stage you can only call exit().

> OK, so we fail the some_notifier2 here, and call exitfn:
>
> > int exitfn()
> > {
> > 	int err;
> >
> > 	err = unregister_filesystem(&some_notifier2);
> > 	if (err)
> > 		return err;
>
> This will trigger (err == -ENOENT) I assume?  I think you really need:

Look at the unregister example in the last mail. It will suceed silently.

> > If you insist on doing the synchronize call in the module code, then you
> > need two stages. On the other you also could simply do this in the driver
> > code:
> >
> > 	if (hook) {
> > 		hook = NULL;
> > 		synchronize();
> > 	}
> > 	...
>
> Hmm, at least if we force the module author to provide two functions,
> they don't have to have a clear understanding of the subtleties.  I
> know, I'm a coward.

This shouldn't be the standard method, so any module author using such
hooks should be aware of it's problems, so I don't see a problem here.

> I'm not clear on the exact desired semantics of stop and exit?  When
> should stop() fail?

stop() would just unregister the interface and is not really expected to
fail. On the other it's also possible to do an implicit stop within the
exit call.

> int stop_ip_conntrack(void)
> {
> 	nf_unregister_hook(&ip_conntrack_in_ops);
> 	nf_unregister_hook(&ip_conntrack_local_out_ops);
> 	nf_unregister_hook(&ip_conntrack_out_ops);
> 	nf_unregister_hook(&ip_conntrack_local_in_ops);
> 	/* Force synchronization */
> 	br_write_lock_irq(BR_NETPROTO_LOCK);
> 	br_write_unlock_irq(BR_NETPROTO_LOCK);

nf_unregister_hook() already takes BR_NETPROTO_LOCK?

> 	if (proc_net_destroy(proc) == -EBUSY)
> 		return -EBUSY;

That goes into the exit routine and a proc_net_unlink() should be here.

> 	return 0;
> }
>
> Now, we put callback pointers inside packets, so we need to keep a
> count of how many of those we have (packet_count):
>
> int exit_ip_conntrack(void)
> {
> 	if (!bigref_is_zero(&packet_count))
> 		return -EBUSY;
>
> 	/* Woohoo!  We're free, clean up! */
> 	ip_conntrack_cleanup();
> 	return 0;
> }

It's pretty simple to join the stop/exit functions into single functions.
I think it's better if the destroy function also does an unlink if
necessary and the start/stop functions should/can be introduced later.
BTW another way to avoid the packet count would to examine every active
packet and check for pointers to the module.

> int usecount_ip_conntrack(void)
> {
> 	return atomic_read(&proc->use)
> 		 + bigref_approx_val(&packet_count);
> }

The usecount doesn't has to be exact, basically you could even return 0,
then you just have to prevent automatic removal somehow. The usecount is
mostly for the user and IMO should have a meaningful value for the user.

> > Why would I want to reinit the module after a failed exit? As long as
>
> But, this is what you seem to do in try_unregister_module:
>
> 	if (test_bit(MOD_INITIALIZED, &mod->flags)) {
> 		res = exit_module(mod);
> 		if (res) {
> 			start_module(mod);
> 			goto out;
> 		}
> 	}

Um, sorry if that code caused confusion, that code will change. The
start/stop will be introduced later. If the exit fails the module must
stay in the cleanup state and the next cleanup attempt should only be done
on explicit user request.
Maybe I really should update the patch. :) I'm not sure if the problem is
really that urgent that it can't wait for 2.7. On the other hand I could
produce a patch that preserves complete backward compability, but already
introduces the new infrastructure.

bye, Roman


