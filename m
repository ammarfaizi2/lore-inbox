Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932539AbWBPTGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbWBPTGS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 14:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbWBPTGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 14:06:18 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:45247 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932539AbWBPTGR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 14:06:17 -0500
Subject: Re: [patch] hrtimer: round up relative start time on low-res arches
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0602161244240.30994@scrub.home>
References: <Pine.LNX.4.61.0602130207560.23745@scrub.home>
	 <1139827927.4932.17.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0602131208050.30994@scrub.home>
	 <20060214074151.GA29426@elte.hu>
	 <Pine.LNX.4.61.0602141113060.30994@scrub.home>
	 <20060214122031.GA30983@elte.hu>
	 <Pine.LNX.4.61.0602150033150.30994@scrub.home>
	 <20060215091959.GB1376@elte.hu>
	 <Pine.LNX.4.61.0602151259270.30994@scrub.home>
	 <1140036234.27720.8.camel@leatherman>
	 <Pine.LNX.4.61.0602161244240.30994@scrub.home>
Content-Type: text/plain
Date: Thu, 16 Feb 2006 11:06:10 -0800
Message-Id: <1140116771.7028.31.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-16 at 15:10 +0100, Roman Zippel wrote:
> On Wed, 15 Feb 2006, john stultz wrote:
> 
> > 	I just wanted to make sure you know I'm not ignoring your suggestions.
> > I do appreciate the time you have spent, and I have been continuing to
> > work on implementing your idea. Unfortunately the code is not trivial
> > and very much hurts the readability. I expect thats a sacrifice that
> > will be necessary, but hopefully after some review cycles we'll be able
> > to come to something we both like.
> 
> The code could be cleaned up a little, but the main difference is that my 
> code is much more compact, it lacks all the redundancy of your code, which 
> makes it harder to read. My hope was here instead of putting back the 
> code redundancy to add documentation instead, which would explain the 
> subtleties.
> I actually think that the basic principle of my code is quite simple, the 
> problem is that it's a little buried inbetween how the incremental updates 
> are done in my prototype, so after a little cleaning and separating the 
> special cases, I think my code would be a lot more readable.

I'll admit I'm slow, but since it has taken me a number of weeks to sort
out exactly the details of what is being done in your implementation,
and I *still* have bugs after re-implementing it, I'd not claim your
code is simple. The potential to be very precise and efficient: yes, but
not so trivial to follow.

(This is why I cringe at the idea of trying to implement it for each
clock like you're prototype suggested.)

Maybe when I send out the patch you can suggest improvements to the
comments or other ways to better clarify the code as you suggested
above.

> > I'm hoping to have a first pass patch I can mail this week.
> 
> I'm looking forward to it.
> BTW What do you think how difficult it would be to rebase your patches on 
> my NTP4 patches? 

I'd be very much open to it, although I haven't seen any further updates
to the code since I mailed you some feedback on them. Have you had a
chance to follow up on those?

> In the end the simplification of my patches should also 
> make your patches simpler, as it precalculates as much as possible and 
> reduces the work done in the fast paths. It would avoid a lot of extra 
> work, which you currently do.

Well, I'm still cautious, since it still has some dependencies on HZ
(see equation below), which I'm trying to avoid. However I don't think
your patches keep me from getting the info I need (or atleast, the info
I think I need ;). They do seem to help close the gap between what I
want and what you want, so I think they are a good step forward.

> The main problem that I see is that you need to drop the ppm calculations, 
> the new code provides a scaled nsec value per tick (tick_nsec + time_adj) 
> and you basically only need "(update - 10^9/HZ) / cycles" to calculate the 
> new multiplier adjustment.

My test patch does this already, although for now it calculates the ntp
interval (something like "tick_nsec + time_adj" in your code) from the
ppm value. That calculation would hopefully be replaced w/ some
ntp_get_interval() call that would pull the equivalent from your code.


> You also need to drop your ntp rework, the changes to the generic code 
> should be quite simple now, basically just exporting second_overflow() 
> and creating an alternative do_timer() entry point which doesn't call 
> update_wall_time().
> 
> Besides some small cleanups I think my code is ready for some serious 
> testing, but it conflicts with your NTP changes.

If you think they're ready, mail them to the list and I'll look them
over then take a swing at re-basing my work on top of them.

thanks
-john


