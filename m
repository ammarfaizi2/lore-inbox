Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261807AbSIPLzc>; Mon, 16 Sep 2002 07:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261923AbSIPLzb>; Mon, 16 Sep 2002 07:55:31 -0400
Received: from dp.samba.org ([66.70.73.150]:15049 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261807AbSIPLzY>;
	Mon, 16 Sep 2002 07:55:24 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Daniel Phillips <phillips@arcor.de>, Roman Zippel <zippel@linux-m68k.org>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Raceless module interface 
In-reply-to: Your message of "Fri, 13 Sep 2002 15:34:53 +0200."
             <E17pqaz-000891-00@starship> 
Date: Mon, 16 Sep 2002 12:17:33 +1000
Message-Id: <20020916120022.22FFC2C12A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <E17pqaz-000891-00@starship> you write:
> On Friday 13 September 2002 08:51, Rusty Russell wrote:
> > If you split registration interfaces into reserve (can fail) and
> > use (can't fail), then you do:
> 
> Why is that different from:
> 
>  	int my_module_init(void)
>  	{
>  		int ret;
>  		ret = reserve_foo();
>  		if (ret != 0)
>  			return ret;
>  		ret = reserve_bar();
>  		if (ret != 0) {
>  			unreserve_foo();
> 	 		return ret;
> 		}
>  		use_foo();
>  		use_bar();
> 		return 0;
>  	}

As I said:

R> Of course you can simulate a two-stage within a single-stage, of course,
R> by doing int single_stage(void) { stage_one(); stage_two(); }, so
R> "need" is a bit strong.

> Of course, and you might consider actually reading my [RFC].

You weighed into a debate without background, with a longwinded
"original" suggestion which wasn't, and then you accuse *me* of not
reading?

You divided modules into counting and non-counting.  This is overly
simplistic.  In fact, *interfaces* are divided into counting and
non-counting: a module may use both.  A module which only uses
counting interfaces is trivially safe from unload races.  The
interesting problem is module which control their own reference
counts, because they use one or more non-counting interfaces.

Your "solution" does not work:

>	unregister_callpoints(...);
>	magic_wait_for_quiescence();
>	return cleanup_foo(...);

In fact, it would look like:

>	unregister_callpoints(...);
>	synchronize_kernel();
>	if (atomic_read(&usecount) != 0) {
>		reregister_callpoints(...);
>		return -EBUSY;
>	}
>	cleanup_foo();

Now, think what happens if reregister_callpoints() fails.  So we need
"unuse_xxx" here then.

Now, *think* for one moment, from the point of view of the author of
one of these modules.  Now, how are you going to explain the subtle
requirements of your "two stage in one" interfaces?  Bear in mind that
the init races weren't even understood by anyone on linux-kernel until
two years ago, and you're dealing with a newbie kernel programmer.

Now do you see my preference for taking the weight off the shoulders
of module authors?  It's just not sane to ask them to deal with these
fairly esoteric races, and expect them to get it right.

We could simply ban modules from using non-counting interfaces.  Or we
could introduce two-stage registration interfaces and then simply ban
their unloading.  Or we can make their unloading a kernel hacking
option.  Or we can provide all the infrastructure, and allow the
module authors to set their own comfort level.

> Don't forget that the Unix way has traditionally been to use the
> simplest interface that will do the job; if you propose a fat
> interface you need to prove that the thin one cannot do the job.

Gee, really?  You're so clever!

You patronising little shit,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
