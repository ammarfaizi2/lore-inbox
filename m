Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261283AbSJPR1Z>; Wed, 16 Oct 2002 13:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261288AbSJPR1Z>; Wed, 16 Oct 2002 13:27:25 -0400
Received: from dsl-213-023-039-240.arcor-ip.net ([213.23.39.240]:56735 "EHLO
	starship") by vger.kernel.org with ESMTP id <S261283AbSJPR1V>;
	Wed, 16 Oct 2002 13:27:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] In-kernel module loader 1/7
Date: Wed, 16 Oct 2002 19:33:47 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
References: <20021016081803.A69AC2C09F@lists.samba.org>
In-Reply-To: <20021016081803.A69AC2C09F@lists.samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E181s3M-0004C7-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Warning, this is one of those reply-to-every-point posts, read on if you
have masochistic tendencies.)

On Wednesday 16 October 2002 08:11, Rusty Russell wrote:
> > > And, of course, disabling preemption widely kind of defeats the point
> > > of having a preemptive kernel 8(
> > 
> > It only needs to be turned off when unloading one of the "hard" modules.
> > This would be an incrementing disable to accodate simultaneous unloads.
> > During the unload your desktop might get a little bit less interactive,
> > but that's better than not being able to unload at all.
> 
> It needs to be turned off when dealing with any interface which might
> be used by one of the hard modules.  Which is pretty bad.

What are you thinking about here?  (Oh, I see it's elaborated below.)  

As far as I can see, preemption only has to be disabled during the 
synchronize_kernel phase of unloading that one module, and this requirement 
is inherited neither by dependant or depending modules.

> > Conceptually, are there any outstanding issues with "hard"
> > way of unloading modules, assuming we can use the TRY_INC way[1] for
> > "easy" modules?  One I don't recall being discussed, is the inherent
> > difficulty of unhooking an interface like LSM, one function at a time.
> 
> Without preempt, it was relatively easy (my initial code preceeded
> preempt).  With preempt, unless you touch the scheduler (I have code
> for that too, Ingo doesn't like it anyway), a module can't control its
> own reference counts.

The current proposal touches the scheduler only in the slow path of 
preempt_schedule, does it not?  It's hard to see what the objection to that 
would be.  By the way, do you when I say "schedule on every cpu", is that 
exactly equivalent to your synchronize_kernel?

> Either way, how do you return "Pretend I wasn't here" in general, if
> the module is being unloaded?  Only the infrastructure knows what to
> do.
> 
> If a module cannot control its own reference counts, every exported
> interface which can sleep needs to do the try_inc_modcount thing, or a
> module which uses it cannot be unloaded.

But this question goes away if we get our preempt-off switch, no?

> Now, there remains a subtle problem with the try_inc_mod_count
> approach in general.  It is the "spurious failure" problem, where
> eg. a notifier cannot inc the module count, and so does not call the
> registered notifier, but the module is still being initialized *OR* is
> in the middle of an attempt to remove the module (which fails, and the
> module is restored to "life").

Oh, I'm well aware of that one.  This is a subtle design requirement that 
just didn't get to the top of the list of things to talk about, because of 
the other, competing things to talk about.  To me, it's a given that the 
interface must not introduce any dead periods as a result of, say, the user 
attempting to unload a busy module.  For "hard" modules there is no choice: 
the first step must necessarily be to remove the function hooks and thus deny 
the service the module was providing.  For this kind of module, the unload 
should either wait until it succeeds or generate a user-visible error if it 
cannot.  If the "hard" module also exports counting-style interfaces, then 
these should all be determined to be in a quiescent state before proceding 
with the unhooking.

For pure counting-style modules, it's easy to avoid this problem: the module
is placed in the can't-increment state if and only if the current count is 
zero, and from that point on we know the unload will either succeed or fail 
with an error.

> Will this be a problem in general?  I don't think so, since I couldn't
> find an example, but it's possible.

Since it's easy to avoid, why leave the fuzz there?

Things get more interesting with (the proposed) rmmod -f.  In this case
some as-yet-undefined mechanism would try to, say, unmount all the 
filesystems using a given module.  It's just too hard and too much work to
try do the shy suitor thing here, and determine beforehand if all the 
unmounts will be successful.  The easy way out is just to say "yes,
rmmod -f may be unsuccessful but still change the system state, deal with
it".  An even easier way is just to put rmmod -f on the back burner for
the time being.

> The major advantage of this scheme is the simplicity for module
> authors (for the vast majority, no change).  Given the complete dogs
> breakfast most module authors made of the current module count scheme,
> that's a HUGE bonus.

Yes, well, for "easy" modules, all the interfaces that are on the table
or in use are simple.  Hard modules require some care on the part of the 
author, but we knew that.  IMHO, the important thing is to be able to state 
the rules clearly.

-- 
Daniel
