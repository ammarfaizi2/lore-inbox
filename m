Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965041AbVHPAKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbVHPAKI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 20:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbVHPAKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 20:10:08 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:6056 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965041AbVHPAKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 20:10:06 -0400
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: lkml <linux-kernel@vger.kernel.org>, George Anzinger <george@mvista.com>,
       frank@tuxrocks.com, Anton Blanchard <anton@samba.org>,
       benh@kernel.crashing.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <Pine.LNX.4.61.0508152115480.3728@scrub.home>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com>
	 <1123726394.32531.33.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508152115480.3728@scrub.home>
Content-Type: text/plain
Date: Mon, 15 Aug 2005 17:10:01 -0700
Message-Id: <1124151001.8630.87.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-16 at 00:14 +0200, Roman Zippel wrote:
> On Wed, 10 Aug 2005, john stultz wrote:
> 
> > 	Here's the next rev in my rework of the current timekeeping subsystem.
> > No major changes, only some cleanups and further splitting the larger
> > patches into smaller ones.
> > 
> > The goal of this patch set is to provide a simplified and streamlined
> > common timekeeping infrastructure that architectures can optionally use
> > to avoid duplicating code with other architectures.
> 
> It's still the same old abstraction. Let's try it in OO terms why it's the 
> wrong one. What basically is needed is something like this:
> 
> 	base clock	-> continuous clock	-> clock implemention
> 			-> tick clock		-> ....
> 
> The base clock class is an abstract class which provides the basic time 
> services like get time, set time...
> The continuous clock class and tick clock class are also abstract classes,
> but provide basic template functions, which can be used by the actual 
> implementations do most of the work.
> 
> What you do with your patches is to just provide an abstract class for 
> continous clocks and tick based clocks have to emulate a continuous clock. 

Sorry. It was subtle, but after thinking more about your arguments, I've
stepped back from my earlier goals of replacing the timekeeping code for
all arches and instead I've decided to just focus on allowing
architectures that would duplicate code using a continuous timesource
use a common code base.  

Think of it more as a replacement for the time_interpolator code (which
thanks to Christoph Lameter, it is quite influenced by).

So in that way the "abstract class" will just be the current interface
of:

1. do_gettimeofday()
2. do_settimeofday()
3. getnstimeofday()
4. periodic hook (update_wall_time)
5. init code

To that I'd like to add 
6. do_monotonic_clock() which I've just added and implementation for
tick based systems.

Then in the tick based class, nothing changes (except for the new
do_monotonic_clock implementation). And in the continuous timesource
class, it uses my generic-tod code.

> Please provide the right abstractions, e.g. leave the gettimeofday 
> implementation to the timesource and use some helper (template) functions 
> to do the actual work. Basically as long as you have a cycle_t in the 
> common code something is really wrong, this code belongs in the continous 
> clock template.

I'm not sure I agree. By pushing all the gettimeofday logic behind the
timesource or clock class you describe above, you end up with lots of
duplicated and error prone code. That's the issue I'm trying to avoid
between the different arches. Additionally The current i386 timer_opts
code (which I'm to blame for) does almost exactly this at the timesource
level, and while it did allow for alternate timesources to be easily
used, it caused a large amount of almost duplicate code with slightly
differing behavior, and has made changes like dynamic ticks difficult to
do correctly.

It was this reason (along with Christoph's proddings - due to the
fsyscall requirements) that the timesource structure only provides an
abstraction to a free running counter instead of a state-full structure
with function pointers that return the timeofday.

Now, this does not limit any arch from doing their own thing and
implementing their own "timeofday abstract class". I'm just trying to
provide a correct and clean infrastructure for the arches that could use
a continuous timesource. 

> This also allows better implementations, e.g. gettimeofday can be done in 
> a single step instead of two using a single lock instead of two.

This is a miss-characterization. In most cases the continuous
gettimeofday is done in a single step with a single lock. Although it
does have the flexibility to allow for more complex setups, as well as
the ability to opt out and use the existing tick based code. 

thanks
-john

