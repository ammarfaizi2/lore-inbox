Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265464AbTFSFy6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 01:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265470AbTFSFy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 01:54:58 -0400
Received: from imap.gmx.net ([213.165.64.20]:23962 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265464AbTFSFyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 01:54:52 -0400
Message-Id: <5.2.0.9.2.20030619071327.00ce7ee8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Thu, 19 Jun 2003 08:13:08 +0200
To: Con Kolivas <kernel@kolivas.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] 2.5.72 O(1) interactivity bugfix
Cc: Andreas Boman <aboman@midgaard.us>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200306191112.49621.kernel@kolivas.org>
References: <1055983621.1753.23.camel@asgaard.midgaard.us>
 <200306190043.14291.kernel@kolivas.org>
 <200306190938.04430.kernel@kolivas.org>
 <1055983621.1753.23.camel@asgaard.midgaard.us>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:12 AM 6/19/2003 +1000, Con Kolivas wrote:
>On Thu, 19 Jun 2003 10:47, Andreas Boman wrote:
> > On Wed, 2003-06-18 at 19:38, Con Kolivas wrote:
> > >
> > > I had another look at 2.5 and noticed the max sleep avg is set to 10
> > > seconds instead of 2 seconds in 2.4. This could make a _big_ difference
> > > to new forked tasks if they all start out penalised as most
> > > non-interactive. It can take 5 times longer before they get the balance
> > > right. Can you try with this set to 2 or even 1 second on 2.5?
> >
> > Ahh, thanks Con, setting MAX_SLEEP_AVG to 2 *almost* removes all xmms
> > skipping here, a song *may* skip during desktop switches sometime during
> > the first 5 sec or so of playback IFF make -j20 is running. On a mostly
> > idle box (well LoadAvg 3 or so is mostly idle isnt it? ;) desktop
> > switching doesnt cause skips anymore 8)
>
>That's nice; a MAX_SLEEP_AVG of 1 second will shorten that 5 seconds to half
>that as well. What you describe makes perfect sense given that achieving a
>balance is an exponential function where the MSA is the time constant.

However, that will also send X and friends go off to the expired array 
_very_ quickly.  This will certainly destroy interactive feel under load 
because your desktop can/will go away for seconds at a time.  Try to drag a 
window while a make -j10 is running, and it'll get choppy as heck.  AFAIKT, 
anything that you do to increase concurrency in a global manner is _going_ 
to have the side effect of damaging interactive feel to some extent.  The 
one and only source of desktop responsiveness is the large repository of 
cpu ticks a task is allowed to save up for a rainy day.

What I would love to figure out is a way to reintroduce back-boost without 
it having global impact.  I think hogging the cpu is absolutely _wonderful_ 
when the hogs are the tasks I'm interacting with.  Unfortunately, there 
seems to be no way to determine whether a human is intimately involved or 
not other than to specifically tell the scheduler this via renice.

> > Doing make -j20 and staying on the same desktop doesnt cause any
> > skipping at all (but it didnt cause much skipping at all on plain
> > 2.5.72-mm1 either).
>
>So it is better than the default mm1? (doesnt cause any vs didnt cause much)
>
> > I also applied your p->sleep_avg = 0; stuff (keeping MAX_SLEEP_AVG 2 and
> > HZ 1000) and it behaved just like I described earlier (songs started
> > after the make never stop skipping).
>
>Well anything started will be penalised initially as being completely
>non-interactive with the p->sleep_avg = 0. This seems to work fine for normal
>usage patterns I've found on -ck1, as after a short while it gets a bonus up
>to interactive. But you say that doesn't happen on 2.5?
>
> > I am fairly sure the winner for me here was the MAX_SLEEP_AVG since I
> > have fiddled with HZ before without it making big noticable differences.
>
>Yes you're confirming pretty much what I'm finding now that I've played with
>it a lot more.
>
> > I havent gotten a 2.4 kernel patched up yet (lazy), but I'll get that
> > done and see how that sleep_avg patch behaves here then.
>
>Shouldn't be any different than what you've described on 2.5 now, if you make
>CHILD_PENALTY match that on 2.5 (is 50 in 2.5, was 95 in -ck1)

This is the easy way to cure xmms's problem of new thread starting at too 
low priority, but it also shows the other side of the coin.  With this 
change, your interactive feel will be wonderful.  However, when you start a 
cpu hog, it starts it's life with a fully loaded starve-me battery.  What 
happens when a highly charged task forks off a bunch of cpu hogs?  Yup, 
mega-starvation until they burn off the pre-charge.

Sigh, scheduling is a _bitch_.

         -Mike 

