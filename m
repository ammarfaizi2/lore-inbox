Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266971AbTAPELw>; Wed, 15 Jan 2003 23:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266794AbTAPELw>; Wed, 15 Jan 2003 23:11:52 -0500
Received: from almesberger.net ([63.105.73.239]:14098 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S266971AbTAPELv>; Wed, 15 Jan 2003 23:11:51 -0500
Date: Thu, 16 Jan 2003 01:20:39 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kuznet@ms2.inr.ac.ru, Roman Zippel <zippel@linux-m68k.org>,
       kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Migrating net/sched to new module interface
Message-ID: <20030116012039.F1521@almesberger.net>
References: <20030115234258.E1521@almesberger.net> <20030116033343.C87CF2C33D@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030116033343.C87CF2C33D@lists.samba.org>; from rusty@rustcorp.com.au on Thu, Jan 16, 2003 at 02:31:27PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> The ONLY time that FUNCTIONS vanish is when MODULES get UNLOADED (or
> fail to LOAD).

Yes, of course. That's not what I mean. (See below.)

> So you're suggesting we should lock ALL functions the way we lock all
> other datastructures.  I look forward to your compiler patch.

No, it's not locking for concurrent access, but locking for
access vs. removal.

If a function pointer gets disseminated without any way for
the caller to revoke it, then try_module_get is indeed the only
possible solution. But I think this is the rare exception.

The usual way for disseminating function pointers seems to be
through registration at some service interface, or through a
callback. Do you agree with this ?

Service interfaces normally also have a deregistration
function, and callbacks are either synchronous, so you have
to wait for them to complete, but you're busy anyway, or
asynchronous, usually with a way to cancel them.

Now, if the service insists on calling back even after
deregistration or cancellation, with no means for making
sure that at some point no further callback will happen, I'd
consider this a bug of the service - a bug that should be
fixed. (If there's a way to deregister with and without
synchronization, that's fine, of course.) Do you agree with
this ?

If you agree so far, then I hope you'll also agree that a
module can always be safely unloaded, without try_module_get,
if its cleanup function just deregisters/cancels and
synchronizes all the service registrations/callbacks the
module made. Plain and simple.

Of course, this means that module can spend an unbounded amount
of time in its cleanup function.

Do you agree so far ?

Now, if we accept that there may be the requirement that we
can't always wait for deregistration/cancellation to complete,
this leads to the more complex scenario we've discussed earlier
in this thread.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
