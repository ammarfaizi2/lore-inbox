Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273791AbRIXEmH>; Mon, 24 Sep 2001 00:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273792AbRIXEls>; Mon, 24 Sep 2001 00:41:48 -0400
Received: from sydney4.au.ibm.com ([202.135.142.205]:13 "EHLO wagner")
	by vger.kernel.org with ESMTP id <S273791AbRIXEli>;
	Mon, 24 Sep 2001 00:41:38 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PART1: Proposed init & module changes for 2.5 
In-Reply-To: Your message of "Mon, 24 Sep 2001 11:01:29 +1000."
             <4103.1001293289@kao2.melbourne.sgi.com> 
Date: Mon, 24 Sep 2001 14:35:54 +1000
Message-Id: <E15lNTG-0000F2-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <4103.1001293289@kao2.melbourne.sgi.com> you write:
> On Mon, 24 Sep 2001 08:42:25 +1000, 
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> >In message <20010923124336.D30515@nightmaster.csn.tu-chemnitz.de> you write:
> >> Can the startcall or the initcall still be called after stopcall? 
> >
> >No: at this stage the module will have to be reloaded, exactly because
> >of assumptions like zero-initialization.
> 
> When we discussed this at linux.conf.au in Sydney, we agreed that we
> could call startfn after stopfn to handle the quiesce unload algorithm.
> That handles the rmmod race without exporting mod use count to
> everything, i.e.
> 
>   rmmod
>   if use count == 0, call stopfn()
>     synchronize_kernel()
>     if use count == 0, exitfn()
>     if use count != 0, startfn()
> 
> That catches the race where a second cpu has entered the module but not
> done MOD_INC_USECOUNT yet.  The module is now in use but stopfn has
> been called, the best thing to do is accept that rmmod lost the race
> and reinstate the module.

Hi Keith!

	Yes, this was my original intention, but the more I thought
about it, the more I wondered if it was worth it.  In fact, my patch
adds CONFIG_MODULE_UNLOAD, because most people don't actually need it,
and I don't really care if most modules are not unloadable.  Loading
modules makes sense.  Unloading them is pretty much an optimization.

	The reason I eventually decided to split initialization in
this version anyway, was that so many drivers get it wrong!  Things
like registering interrupt handlers before they have set up their
internal state, etc.  Splitting it into two functions is merely a
mechanism to get them to think about things a little harder 8)

	  And honestly, I got distracted by the PARAM stuff 8)

Cheers!
Rusty.
--
Premature optmztion is rt of all evl. --DK
