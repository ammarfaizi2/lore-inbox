Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265602AbTFSIdS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 04:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265619AbTFSIdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 04:33:18 -0400
Received: from imap.gmx.net ([213.165.64.20]:39911 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265602AbTFSIdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 04:33:13 -0400
Message-Id: <5.2.0.9.2.20030619103935.023f5648@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Thu, 19 Jun 2003 10:51:32 +0200
To: Nick Piggin <piggin@cyberone.com.au>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] 2.5.72 O(1) interactivity bugfix
Cc: Con Kolivas <kernel@kolivas.org>, Andreas Boman <aboman@midgaard.us>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <3EF16738.9010104@cyberone.com.au>
References: <5.2.0.9.2.20030619071327.00ce7ee8@pop.gmx.net>
 <1055983621.1753.23.camel@asgaard.midgaard.us>
 <200306190043.14291.kernel@kolivas.org>
 <200306190938.04430.kernel@kolivas.org>
 <1055983621.1753.23.camel@asgaard.midgaard.us>
 <5.2.0.9.2.20030619071327.00ce7ee8@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:33 PM 6/19/2003 +1000, Nick Piggin wrote:
>Mike Galbraith wrote:
>
>>At 11:12 AM 6/19/2003 +1000, Con Kolivas wrote:
>>
>>>On Thu, 19 Jun 2003 10:47, Andreas Boman wrote:
>>> > On Wed, 2003-06-18 at 19:38, Con Kolivas wrote:
>>> > >
>>> > > I had another look at 2.5 and noticed the max sleep avg is set to 10
>>> > > seconds instead of 2 seconds in 2.4. This could make a _big_ difference
>>> > > to new forked tasks if they all start out penalised as most
>>> > > non-interactive. It can take 5 times longer before they get the balance
>>> > > right. Can you try with this set to 2 or even 1 second on 2.5?
>>> >
>>> > Ahh, thanks Con, setting MAX_SLEEP_AVG to 2 *almost* removes all xmms
>>> > skipping here, a song *may* skip during desktop switches sometime during
>>> > the first 5 sec or so of playback IFF make -j20 is running. On a mostly
>>> > idle box (well LoadAvg 3 or so is mostly idle isnt it? ;) desktop
>>> > switching doesnt cause skips anymore 8)
>>>
>>>That's nice; a MAX_SLEEP_AVG of 1 second will shorten that 5 seconds to half
>>>that as well. What you describe makes perfect sense given that achieving a
>>>balance is an exponential function where the MSA is the time constant.
>>
>>
>>However, that will also send X and friends go off to the expired array 
>>_very_ quickly.  This will certainly destroy interactive feel under load 
>>because your desktop can/will go away for seconds at a time.  Try to drag 
>>a window while a make -j10 is running, and it'll get choppy as 
>>heck.  AFAIKT, anything that you do to increase concurrency in a global 
>>manner is _going_ to have the side effect of damaging interactive feel to 
>>some extent.  The one and only source of desktop responsiveness is the 
>>large repository of cpu ticks a task is allowed to save up for a rainy day.
>>
>>What I would love to figure out is a way to reintroduce back-boost 
>>without it having global impact.  I think hogging the cpu is absolutely 
>>_wonderful_ when the hogs are the tasks I'm interacting 
>>with.  Unfortunately, there seems to be no way to determine whether a 
>>human is intimately involved or not other than to specifically tell the 
>>scheduler this via renice.
>
>
>Could certian drivers or subsystems say they are interactive and
>provide some input to the scheduler that way? Reads from input
>devices for example could increase a processes "interactivity" a
>lot, while writes to console or ... no, everything gets multiplexed
>through X, doesn't it...

The mouse and keyboard are wonderful candidates for this... there's always 
a human connected.  It's too bad there's no way to tell if a human is 
staring at the display.  If I'm mesmerized by xmms gl eye-candy, it's a 
highly interactive cpu hog.

>The backboost was quite a good idea. I didn't follow it closely
>but what if you impemented the above idea, which increased
>an "interactiveness" number, then X clients could simply have
>their interactiveness value boosted by X?

Sounds good.  What I'm trying within the current framework is to let tasks 
which are extremely light weight (and not kernel threads) do 
backboost.  Dunno if anything good will come out of it.

>Am I rambling? ;)

IMHO, the more people who ruminate/ramble on this very hard subject the better.

         -Mike 

