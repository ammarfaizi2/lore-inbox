Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264630AbSIWASH>; Sun, 22 Sep 2002 20:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264638AbSIWASH>; Sun, 22 Sep 2002 20:18:07 -0400
Received: from dp.samba.org ([66.70.73.150]:44520 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264630AbSIWASC>;
	Sun, 22 Sep 2002 20:18:02 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: kaos@ocs.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] In-kernel module loader 1/7 
In-reply-to: Your message of "Sat, 21 Sep 2002 19:09:19 +0200."
             <Pine.LNX.4.44.0209211411010.338-100000@serv> 
Date: Mon, 23 Sep 2002 10:20:46 +1000
Message-Id: <20020923002313.E42122C0D7@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0209211411010.338-100000@serv> you write:
> Hi,
> 
> On Sat, 21 Sep 2002, Rusty Russell wrote:
> 
> > initfn()
> > {
> > 	register_notifier(some_notifier); /* Entry point one */
> > 	if (register_filesystem(some_notifier2) != 0) {
> > 		unregister_notifier(some_notifier); /* This fails! */
> > 		return -EBUSY;
> > 	}
> >
> > How does your solution of failing the unregister_notifier in this case
> > stop the race?  I probably missed something here?
> 
> You shouldn't do any cleanup in the init function and do it instead in
> the exit function. That's the reason why I said earlier that calling exit
> even after a failed init is not just an implementation detail. So your
> functions would look like this:

Yeah, I realized this after I sent the mail.  Sorry.  The problem is
one level higher in your implementation:

		error = start_module(mod);
		if (error)
			exit_module(mod);

If the exit fails here (because the module is now in use, so the
unregister_notifier() fails, you need to loop and yield, because you
have no way of saying "wake me when you can be unloaded".

> int initfn()
> {
> 	int err;
> 
> 	err = register_notifier(&some_notifier);
> 	if (err)
> 		return err;
> 	err = register_filesystem(&some_notifier2);
> 	return err;
> }

OK, so we fail the some_notifier2 here, and call exitfn:

> int exitfn()
> {
> 	int err;
> 
> 	err = unregister_filesystem(&some_notifier2);
> 	if (err)
> 		return err;

This will trigger (err == -ENOENT) I assume?  I think you really need:

int exitfn()
{
	int busy;

	busy = (unregister_filesystem(&some_notifier2) == -EBUSY
		|| unregister_filesystem(&some_notifier) == -EBUSY);
	if (busy)
		return -EBUSY;
	return 0;
}

> If you insist on doing the synchronize call in the module code, then you
> need two stages. On the other you also could simply do this in the driver
> code:
> 
> 	if (hook) {
> 		hook = NULL;
> 		synchronize();
> 	}
> 	...

Hmm, at least if we force the module author to provide two functions,
they don't have to have a clear understanding of the subtleties.  I
know, I'm a coward.

> > > Even your bigref is still overkill. When packets come in, you already hav
e
> > > to take _some_ lock, under the protection of this lock you can implement
> > > cheap, simple, portable and cache friendly counts, which can be used for
> > > synchronization.
> >
> > No: networking uses the network brlock for exactly this reason 8(
> 
> It can't be that difficult. After you removed the hooks you only have to
> wait for some time and I can't believe it's that difficult to calculate
> the needed time. Using the number of incoming packets is one possibility,
> the number of network interrupts should be another way.
> You could even temporarily shutdown all network interfaces, if it's really
> that difficult.

Yes, you can actually unregister all your hooks and then take the
write brlock for a moment (this is what I do in the ip_conntrack
code).  Let me think, in this case, functions would look like.  Please
see if my understanding is correct:

static struct proc_dir_entry *proc;

int start_ip_conntrack(void)
{
	ret = ip_conntrack_init();
	if (ret < 0)
		return ret;

	proc = proc_net_create("ip_conntrack",0,list_conntracks);
	if (!proc)
		return -EBUSY;

	ret = nf_register_hook(&ip_conntrack_in_ops);
	if (ret < 0)
		return ret;

	ret = nf_register_hook(&ip_conntrack_local_out_ops);
	if (ret < 0)
		return ret;
		
	ret = nf_register_hook(&ip_conntrack_out_ops);
	if (ret < 0)
		return ret;

	ret = nf_register_hook(&ip_conntrack_local_in_ops);
	return ret;
}

I'm not clear on the exact desired semantics of stop and exit?  When
should stop() fail?

int stop_ip_conntrack(void)
{
	nf_unregister_hook(&ip_conntrack_in_ops);
	nf_unregister_hook(&ip_conntrack_local_out_ops);
	nf_unregister_hook(&ip_conntrack_out_ops);
	nf_unregister_hook(&ip_conntrack_local_in_ops);
	/* Force synchronization */
	br_write_lock_irq(BR_NETPROTO_LOCK);
	br_write_unlock_irq(BR_NETPROTO_LOCK);
	if (proc_net_destroy(proc) == -EBUSY)
		return -EBUSY;
	return 0;
}

Now, we put callback pointers inside packets, so we need to keep a
count of how many of those we have (packet_count):

int exit_ip_conntrack(void)
{
	if (!bigref_is_zero(&packet_count))
		return -EBUSY;

	/* Woohoo!  We're free, clean up! */
	ip_conntrack_cleanup();
	return 0;
}

int usecount_ip_conntrack(void)
{
	return atomic_read(&proc->use)
		 + bigref_approx_val(&packet_count);
}

Am I using this interface correctly?  Since netfilter hooks can't
sleep, nf_register_hook can't be busy (ie. can't fail for that
reason).  I added a -EBUSY return to proc_net_destroy().  

> > > - A call to exit does in any case start the removal of the module, that
> > > means it starts removing interface (and which won't get reinstalled).
> > > If there is still any user, exit will fail, you can try it later again
> > > after you killed that user.
> >
> > If the exit fails and you fail the rmmod, you need to reinit the
> > module.  Otherwise noone can use it, but it cannot be replaced (say
> > it's holding some io region or other resource).
> 
> Why would I want to reinit the module after a failed exit? As long as

But, this is what you seem to do in try_unregister_module:

	if (test_bit(MOD_INITIALIZED, &mod->flags)) {
		res = exit_module(mod);
		if (res) {
			start_module(mod);
			goto out;
		}
	}

> > If you want to wait, that may be OK, but if you want to abort the
> > unload, the module needs to give you a *third* function, and that's
> > where my "too much work for every module author" line gets crossed 8(
> 
> What do you mean?

I thought you might want a "restart()" function, but I don't think you
do.

> > > Anyway, almost any access to a driver goes through the filesystem and
> > > there it's a well known problem of unlinked but still open files. Driver
> > > access is pretty much the same problem to which you can apply the same
> > > well known solutions.
> >
> > Not sure what you mean here.
> 
> You start using drivers like files by opening them, while it's open it can
> be removed (made unreachable), but only when the last user is gone can the
> resources be released. Treat a driver like a file (or maybe a complete
> file system) and you can use a lot of Al-proof infrastructure for free.

Oh, I see what you are saying.  Yes, this is two-stage delete.  It's
very common in the networking code too, for similar reasons.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
