Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWGGHyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWGGHyr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 03:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbWGGHyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 03:54:47 -0400
Received: from tim.rpsys.net ([194.106.48.114]:2947 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750965AbWGGHyr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 03:54:47 -0400
Subject: Re: [PATCH] Create new LED trigger for CPU activity
From: Richard Purdie <rpurdie@rpsys.net>
To: Thomas Tuttle <thinkinginbinary@gmail.com>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>, Rod Whitby <rod@whitby.id.au>
In-Reply-To: <20060707015837.GD8900@phoenix>
References: <20060706191603.GA13898@phoenix>
	 <20060706235204.GB4821@elf.ucw.cz>  <20060707015837.GD8900@phoenix>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 08:54:29 +0100
Message-Id: <1152258869.5548.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-06 at 21:58 -0400, Thomas Tuttle wrote:
> On July 06 at 19:52 EDT, Pavel Machek hastily scribbled:
> > > +#define UPDATE_INTERVAL (5) /* delay between updates, in ms */
> > Polling every 5 msec is going to cost _lot_ of juice. Is there a
> > better way?
> This is a sticky issue.  My first idea was to wire something into
> schedule() so that when the idle process was selected, it would switch
> the LED off, and when another process was selected, it would switch it
> on, but that would have been really hairy.  In addition, it wouldn't
> allow the trigger to differentiate between user, system, nice, and
> iowait time, which it can now.

CPU activity was always going to be desired but tricky. At the moment, I
know of at least three ways people have implemented it, yours, one from
the NSLU2 people and the existing old ARM LED infrastructure.

For the old ARM approach, see arch/arm/kernel/process.c
NSLU2 patch:
http://trac.nslu2-linux.org/kernel/browser/trunk/patches/2.6.17/50-leds-arm-cpu-activity.patch

These other two patches are good in that they hook into the idle handler
and only do things at cpu idle time rather than running every 5ms.
Running every 5ms is not going to work well on my arm handheld (for
example). The existing ARM code is the simplest but doesn't give the
amount of configuration the NSLU2 people want.

I've just been asked for a trigger with the same behaviour as the old
ARM LED code to complicate matters (then we have no reason people can't
port their LED code over to the new interface). For that reason I'll be
writing a trigger to emulate the old ARM approach.

> I don't think it's that much of a performance hit (the calculations are
> fairly short, and a trigger event isn't sent unless the LED state
> changed), but if you disagree, I can do a couple of things:

Running every 5ms like this *is* going to hit performance, particularly
on lower CPU powered devices.

>   * Lower the frequency to every 10ms (100Hz) or 40ms (25Hz).  This will
> 	  reduce the performance hit, but also reduce the accuracy of the LED.
> 		Right now, it flickers nicely when the CPU is somewhat busy, but if
> 		I lower the frequency, it will more often stay on rather than
> 		flickering.  I guess it's a matter of taste.

At the moment you check (used_cputime > 0). If you compared that to some
small value instead of zero, you might reduce the always on threshold.
Finding that threshold might be tricky though.

> 	* Try to hook it in to the scheduler, so it actually knows the moment
> 	  the CPU idles or starts doing something.  This will make it
> 		impossible to differentiate user/system time, and hard to
> 		differentiate user/nice time.

Is that differentiation useful in practise? (I'll have to try it and see
I guess)

There is no right answer here. I want to test the different approaches
before any of these triggers get into mainline as we don't want a great
stack of different cpu activity triggers. Perhaps you could do the same
and see how you feel about the other approaches. 

Richard

