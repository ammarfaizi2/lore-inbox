Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317341AbSGDGXq>; Thu, 4 Jul 2002 02:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317342AbSGDGXp>; Thu, 4 Jul 2002 02:23:45 -0400
Received: from OL65-148.fibertel.com.ar ([24.232.148.65]:27883 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S317341AbSGDGXo>;
	Thu, 4 Jul 2002 02:23:44 -0400
Date: Thu, 4 Jul 2002 03:29:29 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [OKS] Module removal
Message-ID: <20020704032929.N2295@almesberger.net>
References: <20020702133658.I2295@almesberger.net> <Pine.LNX.3.96.1020704000434.2248F-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1020704000434.2248F-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Thu, Jul 04, 2002 at 12:11:14AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> Isn't the right thing to make everything stop using the module before
> ending it, for any definition of ending?

This certainly seems to be the most understandable way, yes. I think
modules follow basically the principle illistrated below (that's case
4b in the taxonomy I posted earlier), where deregistration doesn't
stop everything, but which should be safe except for
return-after-removal:


foo_dispatch(...)
{
    read_lock(global_foo_lock);
    ...
    xxx = find_stuff();
    ...
    xxx->whatever_op(xxx->data);
}

foo_deregister(...)
{
    write_lock(global_foo_lock);
    ...
    write_unlock(global_foo_lock);
}

bar_whatever_op(my_data)
{   
    lock(my_data); /* think MOD_INC_USE_COUNT */
    ...
    read_unlock(global_foo_lock);
    ...
    unlock(my_data); /* think MOD_DEC_USE_COUNT */
    /* return-after-removal race if my_data also protects code,
       not only data ! */
}

bar_main(...)
{
    foo_register(&bar_ops,&bar_data);
    ...
    foo_deregister(&bar_ops);
    ...
    lock(bar_data); /* barrier */
    unlock(bar_data);
    ...
    destroy(&bar_data);
}


/* I'm a lazy bastard for not validating this with something like
   Spin, so there may be races left. */

Now there are quite a few things you can omit, without ever noticing
problems. E.g. the read_unlock from bar_whatever_op could be before
the call to whatever_op in foo_dispatch, and all you get is a tiny
bar_whatever_op vs. destroy race. Likewise, moving the barrier in
bar_main may go unnoticed for a long time. If bar_data is never
destroyed, or synchronized by some other means, most of the locking
is actually superfluous, so in many situations, using this model
without strictly following every single detail is actually okay, at
last as far as data races are concerned.

So I think we need to distinguish the entry-after-removal race and
the return-after-removal race, because the former may also be a data
race, while the latter is typically only a code race. (The latter
becomes a data race if you touch shared data after releasing the
lock, but this would be a fairly obvious mistake.)

The entry-after-removal race is not module specific, and may exist
as a true data race in the kernel. (Didn't search for it - I'm not
happy with the fact that I wouldn't be able to catch it in the act
anyway, so I'd rather play a bit with infrastructure first.)

The return-after-removal race could be solved by not deallocating
module memory, or - probably cheaper, but requiring either code
changes or advanced gcc wizardry - by using decrement_and_return.

By the way, there are cases where MOD_DEC_USE_COUNT is followed by
code other than a direct return, e.g. (arbitrary example) in
drivers/net/aironet4500_core.c

This is correct if we can be sure that the use count never reaches
0 here, but then the whole inc/dec exercise is probably redundant.
("probably" as in "it doesn't have to be, but I'd be surprised if
it isn't"; I'll give an example in a later posting.)

However, if this MOD_DEC_USE_COUNT may ever decrement the count to
zero, we have something worse than the usual return-after-removal
race. This may even be a data race, so such code is suspicious in
any case.

> It seems slightly like that tree falling in the forest, and no one to hear
> it. Much easier to handle removal right than service requests after close. 

I can understand why people don't want to use totally "safe"
deregistration, e.g.

 - locking gets more complex and you may run into hairy deadlock
   scenarios
 - accomplishing timely removal may become more difficult
 - nobody likes patches that change the world

So the entry/return-after-removal issues may still need to be
resolved. I'm mainly worried about entry-after-removal, because
it seems to me that this is likely to imply data races in
non-modules too, so try_inc_mod_count neither sufficient (for it
doesn't help with non-modules) nor required (because fixing the
race would also eliminate entry-after-removal).

I've seen very few reponses to my analysis. Does everybody think
I'm nuts (quite possible :-), or is this worth continuing ?

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://icapeople.epfl.ch/almesber/_____________________________________/
