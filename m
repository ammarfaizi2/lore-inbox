Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263837AbSKRSHy>; Mon, 18 Nov 2002 13:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263968AbSKRSHx>; Mon, 18 Nov 2002 13:07:53 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:22024 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263837AbSKRSHm>; Mon, 18 Nov 2002 13:07:42 -0500
Date: Mon, 18 Nov 2002 19:14:30 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: linux-kernel@vger.kernel.org
cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: [RFC] module locking: what was, what is, what could be
Message-ID: <Pine.LNX.4.44.0211181600190.2113-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Below is some example pseudo code, which demonstrates different locking 
strategies. I'd really would like to see a bit feed back to this. Whatever 
locking we choose now, it will change driver APIs in different ways, so 
I'd suggest to carefully think about this now.

First example demonstrates the old locking, as most people should know it. 
I splitted the examples into three phases, each demonstrating a single 
major phase in the live of an object.

init:
	obj = create();
	list_lock();
	register(obj);
	list_unlock();
use:
	list_lock();
	if ((obj = find())) {
		unload_lock();
		if (!deleted(mod))
			inc_ref(mod);
		else
			fail;
		unload_unlock();
	}
	list_unlock();
exit:
	unload_lock();
	if (ref(mod) > 0)
		busy;
	else
		set_deleted(mod);
	unload_unlock();
	list_lock();
	unregister(obj);
	list_unlock();
	delete(obj);

Rusty didn't change very much, it's still the same basic mechanism. 
unload_lock() and inc_ref() are simpler, OTOH ref() has to do _much_ more 
work. deleted() became live() and is now only set after initialization, 
which introduced new problems. This is fixable by splitting the module 
initialization into two phases and inbetween the module becomes live:

init:
	obj = create();
	set_live(mod);
	list_lock();
	register(obj);
	list_unlock();
use:
	list_lock();
	if ((obj = find())) {
		unload_lock();
		if (live(mod))
			inc_ref(mod);
		else
			fail;
		unload_unlock();
	}
	list_unlock();
exit:
	unload_lock();
	if (ref(mod) > 0)
		busy;
	else
		clear_live(mod);
	unload_unlock();
	list_lock();
	unregister(obj);
	list_unlock();
	delete(obj);

Finally I'd like to demonstrate a locking strategy, which I proposed 
already earlier and according to Rusty is "slow, confusing, invasive, 
inflexible *and* buggy".

init:
	obj = create();
	list_lock();
	register(obj);
	list_unlock();
use:
	list_lock();
	if ((obj = find()))
		inc_ref(obj);
	list_unlock();
exit1:
	if (registered(obj)) {
		list_lock();
		unregister(obj);
		list_unlock();
	}
	if (ref(obj) > 0)
		busy;
	else
		delete(obj);
exit2:
	list_lock();
	if (ref(obj) > 0)
		busy;
	else
		unregister(obj);
	list_unlock();
	delete(obj);

There are other variations of the exit phase possible, but the basic idea 
is that the driver tells the module code, whether it's safe to unload or 
not (and not the other way around, but the driver could still use a single 
module count for this).
I have to agree, that this is the most invasive strategy (because it's 
different), but if done correctly it will lead to cleaner, smaller, and 
more flexible code.

Consequences:
The current locking strategy requires that _all_ interfaces which could be 
during module init are split into a allocate and install phase, the use of 
the module ref for every object is mandatory and the module unload should 
rather be avoided, because it really hurts.
My locking strategy requires more care during exit when multiple objects 
have to be unregistered (during install all objects can simply be 
installed when they are ready), but most drivers install only a single 
interface through which the driver can be opened/closed. If multiple 
interfaces are used, it can leave the module in a loaded but unregistered 
state, but there are a few strategies to avoid this.

bye, Roman


