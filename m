Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262483AbSIPQJU>; Mon, 16 Sep 2002 12:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262489AbSIPQJT>; Mon, 16 Sep 2002 12:09:19 -0400
Received: from dsl-213-023-040-192.arcor-ip.net ([213.23.40.192]:47495 "EHLO
	starship") by vger.kernel.org with ESMTP id <S262483AbSIPQJO>;
	Mon, 16 Sep 2002 12:09:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rusty Russell <rusty@rustcorp.com.au>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [RFC] Raceless module interface
Date: Mon, 16 Sep 2002 18:13:14 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
References: <20020916120022.22FFC2C12A@lists.samba.org>
In-Reply-To: <20020916120022.22FFC2C12A@lists.samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17qyUt-0000Jm-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 September 2002 04:17, Rusty Russell wrote:
> You weighed into a debate without background, with a longwinded
> "original" suggestion which wasn't, and then you accuse *me* of not
> reading?

Yup.  If you had actually read it, I apologize, but you showed every
sign of having not read it.

> You divided modules into counting and non-counting.  This is overly
> simplistic.  In fact, *interfaces* are divided into counting and
> non-counting: a module may use both.

Read closely and you will see I covered that.  Sure, my [rfc] may have
been less consise than the perfect piece of prose you would have
submitted in my place, but other than that, it seems to have held up
rather well under attack.

> A module which only uses
> counting interfaces is trivially safe from unload races.  The
> interesting problem is module which control their own reference
> counts, because they use one or more non-counting interfaces.
> 
> Your "solution" does not work:
> 
> >	unregister_callpoints(...);
> >	magic_wait_for_quiescence();
> >	return cleanup_foo(...);
> 
> In fact, it would look like:
> 
> >	unregister_callpoints(...);
> >	synchronize_kernel();
> >	if (atomic_read(&usecount) != 0) {
> >		reregister_callpoints(...);
> >		return -EBUSY;
> >	}
> >	cleanup_foo();

Ah no, I don't like the second one, it will introduce erratic behaviour
in LSM.  You will have a state where some security calls are implemented
and others not, then you will return to a state where all are.  Eep.

Granted, LSM will always have a state when the calls are partially
unplugged, but the next state after that should be complete removal.
The admin is going to be awfully surprised if something else happens.

So what I had in mind here (and did mention it) is to take the counter
into account in magic_wait_for_quiescence(), on the understanding that
this counter only counts possibly-sleeping states of module threads.

Anyway, how do you propose to handle this:

					task in module:
					   inc count
					   sleep
	synchronize_kernel:		
	   schedule()
	   wake up on cpu 1
					   wake up on cpu 0
					   dec count

	if (atomic_read(&usecount) != 0) /* false */
	free_module(module);
					   BOOM!

> Now, think what happens if reregister_callpoints() fails.  So we need
> "unuse_xxx" here then.
> 
> Now, *think* for one moment, from the point of view of the author of
> one of these modules.  Now, how are you going to explain the subtle
> requirements of your "two stage in one" interfaces?  Bear in mind that
> the init races weren't even understood by anyone on linux-kernel until
> two years ago, and you're dealing with a newbie kernel programmer.

OK, *finally* we get to the core of your argument.  You accused me of
being long-winded, but you have just taken several days to admit that
there is no inherent difference in capability between your proposal and
mine.  Though to be sure, some of your commentary was informative and
useful, still, you should have taken the position you are now about to
take right from the beginning.

> Now do you see my preference for taking the weight off the shoulders
> of module authors?  It's just not sane to ask them to deal with these
> fairly esoteric races, and expect them to get it right.

I feel no need to take any weight off the shoulders of the LSM authors,
they are big boys and they better know what they're doing.  IMHO, they'd
appreciate maximum control at the insertion/removal stage.

But proc modules, device drivers, even filesystems: I strongly agree
we need a dumbed-down interface.  However, please forgive me for not
immediately accepting the proposition that yours is the final word in
dumbed-down module interfaces.  I'm thinking that a set of easy-to-use
library calls will be just as good and will win on the grounds of using
the simpler interface.

> We could simply ban modules from using non-counting interfaces.

No we can't.  As I mentioned in my [rfc], there are some modules that
simply cannot use this technique, and I hope we've already rejected
the strategy of disallowing removal of such modules.  (The Chinese
have a saying that covers this: "cut off toes to avoid worm coming".)

> Or we
> could introduce two-stage registration interfaces and then simply ban
> their unloading.

No, the complaining would never end.

> Or we can make their unloading a kernel hacking
> option.  Or we can provide all the infrastructure, and allow the
> module authors to set their own comfort level.

This is a logical falacy, let's call it "trifurcation".  You have
presented three alternatives as if they were the only alternatives.
Two were bogus anyway; by either measure this last qualifies as pure
rhetoric.

In summary, you have retreated from the position that my interface
is somehow less capable than yours, and you have dug in to defend
the position that your interface is better for newbie programmers,
which appears to be your only argument at the moment.

If you turn out to be right, then good and my hat off to you.  If
you are wrong, and I can present an interface that is just as easy
for newbie programmers, than I am right and you should thank me
for sticking to my guns and insisting that we go with the simplest
inteface that will do the job.

-- 
Daniel
