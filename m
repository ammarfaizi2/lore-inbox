Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264730AbSKIEJW>; Fri, 8 Nov 2002 23:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264727AbSKIEJH>; Fri, 8 Nov 2002 23:09:07 -0500
Received: from dp.samba.org ([66.70.73.150]:23009 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264729AbSKIEJA>;
	Fri, 8 Nov 2002 23:09:00 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       "Van Maren, Kevin" <kevin.vanmaren@unisys.com>,
       linux-ia64@linuxia64.org,
       Linux Kernel List <linux-kernel@vger.kernel.org>, rusty@rustcorp.com.au,
       dhowells@redhat.com, mingo@elte.hu, torvalds@transmeta.com
Subject: Re: [Linux-ia64] reader-writer livelock problem 
In-reply-to: Your message of "08 Nov 2002 09:38:25 -0800."
             <1036777105.13021.13.camel@ixodes.goop.org> 
Date: Sat, 09 Nov 2002 13:48:17 +1100
Message-Id: <20021109041543.EBE8A2C29F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1036777105.13021.13.camel@ixodes.goop.org> you write:
> On Fri, 2002-11-08 at 09:25, Linus Torvalds wrote:
> > There's another reason for not doing it that way: allowing readers to keep 
> > interrupts on even in the presense of interrupt uses of readers.
> > 
> > If you do the "pending writes stop readers" approach, you get
> > 
> > 		cpu1			cpu2
> > 
> > 		read_lock() - get
> > 
> > 					write_lock_irq() - pending
> > 
> > 		irq happens
> > 		 - read_lock() - deadlock
> > 
> > and that means that you need to make readers protect against interrupts 
> > even if the interrupts only read themselves.
> 
> Even without interrupts that would be a bug.  It isn't ever safe to
> attempt to retake a read lock if you already hold it, because you may
> deadlock with a pending writer.  Fair multi-reader locks aren't
> recursive locks.

That's the point.  This is explicitly guaranteed with the current
locks, and you are allowed to recurse on them.  The netfilter code
explicitly uses this to retake the net brlock, since it gets called
from different paths.

Implement "read_lock_yield" or "wrlock_t" but don't break existing
semantics until 2.7 *please*!

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
