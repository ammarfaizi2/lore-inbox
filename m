Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbSKNDTH>; Wed, 13 Nov 2002 22:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbSKNDSI>; Wed, 13 Nov 2002 22:18:08 -0500
Received: from dp.samba.org ([66.70.73.150]:2233 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261411AbSKNDSD>;
	Wed, 13 Nov 2002 22:18:03 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Modules and the Interfaces who Love Them (Take I) 
In-reply-to: Your message of "Wed, 13 Nov 2002 20:02:29 BST."
             <Pine.LNX.4.44.0211131430190.2109-100000@serv> 
Date: Thu, 14 Nov 2002 14:34:53 +1100
Message-Id: <20021114032456.5676D2C0C9@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0211131430190.2109-100000@serv> you write:
> Hi,
> 
> On Wed, 13 Nov 2002, Rusty Russell wrote:
> 
> > Feedback appreciated.  It's aimed at driver writers.
> 
> If that's your audience, I expect a very confused audience.

>From my feedback, I suspect you are right.  I've rewritten it.

> You can make it very simple: There are safe interfaces and there are 
> broken interfaces and you shall never write or use broken interfaces.
> For the majority of driver writers that's good enough.

Yes, maybe I should.

> Any documentation about module writing should also include/point to a 
> chapter about resource management.

Yes, it'd be nice to have good documentation on this.

> As soon as the user gets that right he will also have no problems to
> get module unloading right _if_ that would follow the same rules,
> but currently it involves lots of black magic instead.

Look, your implementation was slow, confusing, invasive, inflexible
*and* buggy.

Slow: Your approach where every interface has to do reference counts
even though they're only useful for modules makes every interface
slow, whether they are using modules or not.  You can't make them
fast, because that would make every interface NR_CPUS *
sizeof(cacheline) larger.

Confusing: Your "deregistration can fail if busy but must succeed
otherwise" is guaranteed to confuse authors who will wonder why.
Currently some fail if it wasn't registered in the first place.  To
understand why this has to change, they have to understand your
interface.  You require a massive style change of not handling failure
within the failing function.  Each module has to implement four (or
was it five?) functions for managing it.

Invasive: Every unregister interface to change, although many are very
happy with try_inc_modcount().  Worse, every module in the kernel has
to change to implement your method.

Inflexible: There is no way your scheme could allow "rmmod --wait" or
"rmmod --force" without adding yet another interface to *every*
module.

Buggy: You did not solve the "module used before init failed" problem,
but left the module loaded and uninitialized in this case.

> Rusty, I'm not impressed by the new module code,

I seriously question your taste in this matter.  You obviously hold a
personal dislike for my code.   Fine.

> maybe I'm missing something, but it doesn't fix anything

Then you don't understand the problem.

Sorry, but I'm wasting my time sending you mail. 8(
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
