Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267091AbTAPOEJ>; Thu, 16 Jan 2003 09:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267094AbTAPOEJ>; Thu, 16 Jan 2003 09:04:09 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:4876 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267091AbTAPOEH>; Thu, 16 Jan 2003 09:04:07 -0500
Message-ID: <3E26B737.7F9BCAEB@linux-m68k.org>
Date: Thu, 16 Jan 2003 14:44:23 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Werner Almesberger <wa@almesberger.net>, kuznet@ms2.inr.ac.ru,
       kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Migrating net/sched to new module interface
References: <20030116013125.ACE0F2C0A3@lists.samba.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Rusty Russell wrote:

> Deprecating every module, and rewriting their initialization routines
> is ambitious beyond the scale of anything you have mentioned.  Not
> that 90% of the kernel code couldn't use a damn good spring cleaning,
> but I'm not prepared to make such a change personally.

The transition would be rather painless:

	if (mod->new_exit) {
		res = -EBUSY;
		if (force || !mod_use_count(mod))
			res = mod->new_exit();
	} else {
		res = mod_try_exit();
		if (!res && mod->old_exit) {
			mod->old_exit();
	}

Yes, there is a small race, but at least it's nonfatal, as the module
has to repeat the module count test or is protected otherwise.
Now we can start fixing interfaces and exit functions can still call
mod_try_exit() before calling old style interfaces.

> So we go from:
> 
> int init(void)
> {
>         if (!register_foo(&foo))
>                 return -err;
>         if (!register_bar(&bar)) {
>                 unregister_foo(&foo);
>                 return -err;
>         }
>         return 0;
> }
> 
> void fini(void)
> {
>         unregister_foo(&foo);
>         unregister_bar(&bar);
> }
> 
> to:

int init(void)
{
	if (register_foo(&foo))
		return -err;
	if (register_bar(&bar))
		return -err;
	return 0;
}

void fini(void)
{
	if (unregister_bar(&bar))
		return -err;
	if (unregister_foo(&foo))
		return -err;
	return 0;
}

Hmm, looks as simple if not simpler to me.

> Something like this?
> 
> static int i_am_live;
> static spinlock_t my_lock = SPIN_LOCK_UNLOCKED;
> 
> /* This is our registered function. */
> static int foo_function(void *somedata)
> {
>         int live;
> 
>         spin_lock(&my_lock);
>         live = i_am_live;
>         spin_unlock(&my_lock);
>         if (!live)
>                 return -EIGNOREME???;
>         ...
> }

If the exit function starts the shutdown, there is no going back
anymore. Let's take loop.c as example. It can either deconfigure the
devices itself (via loop_clr_fd()) or it let's the user do it and only
removes unused devices and prevents any new loop_set_fd() to succeed. In
any case there will be no deadlock.

> > Hmm, what makes security modules (what exactly do you mean
> > by that ?) special ?
> 
> On a busy system, they're never not being used.  Your unload routine
> would always fail.  Same with netfilter modules.

int unregister(foo)
{
	lock();
	list_del_init(&foo->list);
	unlock();
	return foo->usecount ? -EBUSY : 0;
}

This makes sure no new user will start using it and at some point it has
to return zero.

> The current scheme is clean: it's two-stage delete with a nice helper
> function "try_module_get()" which tells you when it's going away, and
> no requirement that modules actually implement two-stage delete
> themselves.  The patch to mirror this in two-stage init was posted
> yesterday, as well.

The current scheme is the reserve/activate scheme in disguise and it
sucks as much. 

> Unfortunately, I don't have the patience to explain this once for
> every kernel developer.

Well, I'd be happy to see an implementation that not only works for the
most simplest cases.

bye, Roman


