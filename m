Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273795AbRIXEyK>; Mon, 24 Sep 2001 00:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273796AbRIXEyB>; Mon, 24 Sep 2001 00:54:01 -0400
Received: from rj.sgi.com ([204.94.215.100]:56769 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S273795AbRIXExw>;
	Mon, 24 Sep 2001 00:53:52 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PART1: Proposed init & module changes for 2.5 
In-Reply-To: Your message of "Mon, 24 Sep 2001 14:35:54 +1000."
             <E15lNTG-0000F2-00@wagner> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 24 Sep 2001 14:54:09 +1000
Message-ID: <5847.1001307249@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2001 14:35:54 +1000, 
Rusty Russell <rusty@rustcorp.com.au> wrote:
>In message <4103.1001293289@kao2.melbourne.sgi.com> you write:
>> When we discussed this at linux.conf.au in Sydney, we agreed that we
>> could call startfn after stopfn to handle the quiesce unload algorithm.
>> That handles the rmmod race without exporting mod use count to
>> everything, i.e.
>
>	Yes, this was my original intention, but the more I thought
>about it, the more I wondered if it was worth it.  In fact, my patch
>adds CONFIG_MODULE_UNLOAD, because most people don't actually need it,
>and I don't really care if most modules are not unloadable.  Loading
>modules makes sense.  Unloading them is pretty much an optimization.
>
>	The reason I eventually decided to split initialization in
>this version anyway, was that so many drivers get it wrong!  Things
>like registering interrupt handlers before they have set up their
>internal state, etc.  Splitting it into two functions is merely a
>mechanism to get them to think about things a little harder 8)

I absolutely agree that the split between probe and register needs to
be done.  The difference between calling startfn after stopfn and
forbidding that sequence is the difference between

  rmmod
    loses race
    return OK
    module is still in use, user is confused
 
and

  rmmod
    loses race
    calls startfn
    returns failure
    module is still in use, user is happy

Allowing startfn after stopfn gives a more consistent view of the
operation.

