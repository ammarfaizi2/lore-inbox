Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261689AbTAQWKM>; Fri, 17 Jan 2003 17:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261721AbTAQWKM>; Fri, 17 Jan 2003 17:10:12 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:28177 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261689AbTAQWJI>; Fri, 17 Jan 2003 17:09:08 -0500
Message-ID: <3E28785A.AC583D9F@linux-m68k.org>
Date: Fri, 17 Jan 2003 22:40:42 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Werner Almesberger <wa@almesberger.net>, kuznet@ms2.inr.ac.ru,
       kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Migrating net/sched to new module interface
References: <20030117022833.229992C365@lists.samba.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Rusty Russell wrote:

> Two Stage Delete
> ================
> 
> So let's apply standard locking techniques.  A standard approach to
> this for data (eg networking packets) involves two-stage delete: we
> keep a reference count in the object, which is usually 1 + number of
> users, and to delete it we mark it deleted so noone new can use it,
> and drop the reference count.  The last user, who drops the reference
> count to zero, actually does the free.

Rusty, could you please show me where you found the deleted flag in
network packets? Where did you find that it's required to test the
deleted flag before you can get a reference to the object?
Actually it's far more common to just delete the object when all
references are gone without any need for a deleted flag. Why does
everyone else get away with a "single stage delete"? Where is the
deleted flag (or active flag) for modules coming from?

(BTW I would be really happy to get any response to this, I already
explained this all before, so I'd really like to know whether someone
understands what I'm talking about or what is so difficult to
understand.)

As already mentioned every object can only be deleted, when it's nowhere
registered anymore and all users are gone, the same is true for modules:

	if (!is_registered(obj) && !get_usecount(obj))
		delete(obj);

The is_registered() check can be omitted, if we unregister the object
ourselves, but this requires some locking to prevent new users until the
object is unregistered:

	lock();
	if (get_usecount(obj)) {
		unlock();
		return -EBUSY;
	}
	unregister(obj);
	unlock();
	delete(obj);

New users have to do this:

	lock();
	obj = lookup();
	if (obj)
		inc_usecount(obj);
	unlock();

This is the standard mechanism we can find all over the kernel. The
problem with modules now is that the usecount check and the unregister
happen at two different places and the lock is not held until the object
is unregistered, so we have to add a new flag:

	mod_lock();
	if (get_usecount(obj)) {
		mod_unlock();
		return -EBUSY;
	}
	deactivate(obj);
	mod_unlock();
	...
	obj_lock();
	unregister(obj);
	obj_unlock();
	delete(obj);

New users have to do this now:

	obj_lock();
	obj = lookup();
	if (obj) {
		mod_lock();
		if (is_active(obj))
			inc_usecount(obj);
		mod_unlock();
	}
	obj_unlock();

Rusty now worked very hard to make the read path as cheap as possible,
but the general complexity is still the same as always. The only way to
make this even cheaper is to reduce the complexity and this is only
possible by getting rid of the is_active() check. The only consequence
would be that we had no global activate switch anymore, but is it really
needed? (Insert compelling reason here, why such a switch is absolutely
required, as I don't know any.)

To understand the possible alternatives I have to rename Rustys "Two
Stage Delete" into "Three stage delete":
1. deactivate
2. unregister
3. delete
(In case anyone was wondering where the single reference in Rustys
example is coming from - it's the registered state from the second
stage).
As said above the delete stage can only be entered if the object is not
registered and not used anymore, this is the only absolute requirement,
but currently we can't even get past the first stage as long as there
are users (otherwise we risk a deadlock).
When Rusty is now talking about exposing a two stage api to the modules,
he actually means the first stage in order to leave it to the module how
to deactivate the module. It makes indeed little sense to expose this
stage, because this is the stage, which is causing the extra complexity
and which we should rather get rid of.
On the other hand it would make quite a lot more sense to expose the
second stage to the modules. This stage is independent of the usecount,
this means we can easily and safely prevent new users from using the
module. The standard mechanism above to remove an object can easily be
changed into:

unregister(force):
	lock();
	if (get_usecount(obj) && !force) {
		unlock();
		return -EBUSY;
	}
	unregister(obj);
	unlock();
delete:
	if (get_usecount(obj))
		return -EBUSY;
	delete(obj);

Doing these stages with one or two functions doesn't really matter, the
work has to be done anyway and causes no real extra complexity.

bye, Roman


