Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266233AbSKZHFQ>; Tue, 26 Nov 2002 02:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266243AbSKZHFQ>; Tue, 26 Nov 2002 02:05:16 -0500
Received: from almesberger.net ([63.105.73.239]:46089 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S266233AbSKZHFP>; Tue, 26 Nov 2002 02:05:15 -0500
Date: Tue, 26 Nov 2002 04:12:12 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: Module Refcount & Stuff mini-FAQ
Message-ID: <20021126041212.B22825@almesberger.net>
References: <20021125232610.A22825@almesberger.net> <20021126044142.48F332C07F@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021126044142.48F332C07F@lists.samba.org>; from rusty@rustcorp.com.au on Tue, Nov 26, 2002 at 02:16:44PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> Yes, but between doing and undoing (in the failure path) someone has
> started using the module.

But how ? Don't we have only two ways of calling a module, i.e.
by symbol, or by callback ? All callbacks that might call a module
must be protected with try_module_get, right ? (*)

(*) Actually, if the registration can be revoked, and the
    deregistration function does properly synchronize with on-going
    callbacks, you shouldn't need try_module_get either. E.g.
    del_timer_sync doesn't need to know about module owners.

So, if you make try_module_get work during initialization, and
modules don't publish their symbols before initialization is done,
there should be no problem ?

> Given we have a method of isolating a module already, it seems logical
> to use it to prevent exactly this race.

But that's mainly the symbol-unload race, considering that any call
through a function pointer requires try_module_get anyway. Without
try_module_get, there would also be callback-unload races if
callback de-registration doesn't synchronize (e.g. del_timer
vs. del_timer_sync).

By the way, it's also not so nice that there can't be
callbacks at removal, e.g.

service_unregister(...)
{
	...
	for_pending_requests(req) {
		...
		if (try_module_get(req->owner))
			req->fn(req,REQUEST_CANCELLED);
		else
			printk(KERN_CRIT "we just dropped a request on the "
			  "floor, how nice\n");
		...
	}
	...
}

Calling this from the module removal function would be
perfectly safe.

Actually ... can't you allow modules to be called until the
cleanup function has returned ?

> Unfortunately my last attempt
> assumed noone did this, and broke IDE and SCSI (hence pissing
> *everyone* off 8).

Two in one strike ain't bad ;-) Maybe we can find something that
gets rid of that pesky NFS, too, e.g. by adding

#define while if    /* enforce efficient programming practices */

to linux/kernel.h, or such ;-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
