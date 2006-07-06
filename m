Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWGFWFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWGFWFP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 18:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWGFWFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 18:05:15 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:10394 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750888AbWGFWFM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 18:05:12 -0400
Subject: Re: 2.6.17-mm2 hrtimer code wedges at boot?
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0607061912370.12900@scrub.home>
References: <20060624061914.202fbfb5.akpm@osdl.org>
	 <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu>
	 <Pine.LNX.4.64.0606271212150.17704@scrub.home>
	 <200606271643.k5RGh9ZQ004498@turing-police.cc.vt.edu>
	 <Pine.LNX.4.64.0606271903320.12900@scrub.home>
	 <Pine.LNX.4.64.0606271919450.17704@scrub.home>
	 <200606271907.k5RJ7kdg003953@turing-police.cc.vt.edu>
	 <1151453231.24656.49.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.64.0606281218130.12900@scrub.home>
	 <Pine.LNX.4.64.0606281335380.17704@scrub.home>
	 <200606292307.k5TN7MGD011615@turing-police.cc.vt.edu>
	 <1151695569.5375.22.camel@localhost.localdomain>
	 <200606302104.k5UL41vs004400@turing-police.cc.vt.edu>
	 <Pine.LNX.4.64.0607030256581.17704@scrub.home>
	 <200607050429.k654TXUr012316@turing-police.cc.vt.edu>
	 <1152147114.24656.117.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.64.0607061912370.12900@scrub.home>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 15:05:05 -0700
Message-Id: <1152223506.24656.173.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-06 at 22:33 +0200, Roman Zippel wrote:
> Hi,
> 
> On Wed, 5 Jul 2006, john stultz wrote:
> 
> > Roman: While I'm not 100% confident about my assessment above, I worry
> > this is mimicking the problems I had been seeing in my simulator w/ your
> > clocksource_adjustment algorithm when I simulated dropping many ticks.
> > While currently this behavior points to some other problem, with the
> > dynticks patch, its much more likely that we will see 100s of ticks
> > skipped.
> > 
> > I quickly revived my P-D adjustment patch and it does not appear to
> > suffer from the same problem with the above droptick change (although
> > its only been lightly tested). 
> 
> The PID concept had me confused for a while and I'm still not sure it 
> really applies, but there are similarities and what I want to do is not 
> that different from yours (limiting then the effect of the current error) 
> with the biggest difference that I keep everything in the big adjust 
> function, so the extra work is only done when needed.

Yea. I've been trying to map your method to the PID concept as well
(when all you have is a hammer... ;) and they are similar, however the
"future error" aspect of yours makes it a little more difficult to
grasp, but it is more compact.


> > +		int adj, multadj = 0;
> > +		s64 offset_update = 0, snsec_update = 0;
> > +		
> > +		/* First do the frequency adjustment:
> > +		 *   The idea here is to look at the error 
> > +		 *   accumulated since the last call to 
> > +		 *   update_wall_time to determine the 
> > +		 *   frequency adjustment needed so no new
> > +		 *   error will be incurred in the next
> > +		 *   interval.
> > +		 *
> > +		 *   This is basically derivative control
> > +		 *   using the PID terminology (we're calculating
> > +		 *   the derivative of the slope and correcting it).
> > +		 *
> > +		 *   The math is basically:
> > +		 *      multadj = interval_error/interval_cycles
> > +		 *   Which we fudge using binary approximation.
> > +		 */
> > +		if(interval_error >= 0) {
> > +			adj = error_aproximation(interval_error,
> > +						interval_cycs, 0);
> > +			multadj += 1 << adj;
> > +			snsec_update += interval << adj;
> > +			offset_update += offset << adj;
> > +		} else {
> > +			adj = error_aproximation(-interval_error, 
> > +						interval_cycs, 0);
> > +			multadj -= 1 << adj;
> > +			snsec_update -= interval << adj;
> > +			offset_update -= offset << adj;
> > +	        }
> 
> Here we actually don't derive very much, we already know how it will 
> change. :)

Correct, by looking one step ahead in your method that's where you're
taking the derivative into effect. Although keeping this future
reference does require some extra mental gymnastics for me.

> We basically want to keep the difference between tick length and xtime 
> interval as small as possible. Since most of the difference comes via 
> second_overflow(), we might want to do some precalculations near there, so 
> we avoid accumulating a lot of error in the first place, this is 
> especially important with only rare updates.

I don't think I disagree here, I can see how looking ahead in the future
is helpful to correct for error when the adjustment changes.

> > +		/* Now do the offset adjustment:
> > +		 *   Now that the frequncy is fixed, we
> > +		 *   want to look at the total error accumulated
> > +		 *   to move us back in sync using the same method.
> > +		 *   However, we must be careful as if we make too 
> > +		 *   sudden an adjustment we might overshoot. So we 
> > +		 *   limit the amount of change to spread the 
> > +		 *   adjustment (using MAXOFFADJ) over a longer 
> > +		 *   period of time.
> > +		 *
> > +		 *   This is basically proportional control
> > +		 *   using the PID terminology.
> > +		 *
> > +		 *   We use interval_cycs here as the divisor, which
> > +		 *   hopes that the next sample will be similar in 
> > +		 *   distance from the last.
> > +		 */
> > +		if(error >= 0) {
> > +			adj = error_aproximation(error, 
> > +					interval_cycs, MAXOFFADJ);
> > +			multadj += 1<<adj;
> > +			snsec_update += interval <<adj;
> > +			offset_update += offset << adj;
> > +		} else {
> > +			adj = error_aproximation(-error,
> > +						interval_cycs, MAXOFFADJ);
> > +			multadj -= 1<<adj;
> > +			snsec_update -= interval <<adj;
> > +			offset_update -= offset << adj;
> > +		}
> 
> The limitation avoids the biggest problems, but it also may slow down the 
> error reduction (the more the bigger the shift value is). The main problem 
> is really that we don't know how many ticks will be skipped and with 
> interval_cycs you only know what happened last and this won't help if 
> ticks are skipped in irregular intervals.

I think one of the important parts of my method is that I've broken up
the error into two different types of error, that can be manipulated
independently:

1) Error accumulated in the last period - the derivative part.
2) Total error - the proportional part.

Taking component #1, we directly correct the frequency to flatten the
error slope so in the next tick we should not accumulate any *extra*
error (ideally, of course, since our granularity won't quite allow for
that). Note that there is no "gain" (using the PID terminology) in that
sense being applied. Its just an absolute frequency correction.

Then taking component #2, if we calculated error/interval that would be
the ideal correction to the proportional component for the next tick.
However since we don't know when the next tick will occur, we use two
methods to dampen the effect to avoid overshoot: a) Use the value
interval/interval_cycs as our "gain" factor, thus if ticks are being
lost, we assume will will continue to lose ticks. You are correct here
in that irregular tick skipping could defeat this, but if a constant
gain factor (of say, 1<<8) was used, we would have a hard time
converging because the error/(interval*gain) would goto zero early. 

So instead, keeping the non-constant gain in (a), we use b) a limiter
(MAXOFFADJ) so any proportional change is very dampened. This does have
the effect that any large error takes awhile to reduce, but since we
correct the recent (derivative error) directly, we should not be
accumulating more.

The combination of these two effects allows us to converge reasonably
quickly when we are not skipping ticks, and controls overshoot when we
are skipping ticks (proportionally to the number of ticks skipped).


> Regarding dynticks it would help a lot here to know how many ticks are 
> skipped so you can spread the error correction evenly over this period 
> until the next adjustment and the correction is stopped in time.

I've considered alternatives, where we use a constant gain with the
proportional component (so any proportional change would be spread over
one second), but to avoid constant offsets when the total error was
smaller then the gain factor, we could also calculate a non-gain'ed
adjustment w/ a limiter and include that. This would be more ideal in
your irregular ticks example, but I'm not sure its really that much more
beneficial from what I proposed.

Anyway, I'm interested in what you are thinking for a more minimal
approach to what we have in mainline, since I have a harder time
wrapping my head around the future-error part (I can intuit what you
want to accomplish, and I understand the benefit of looking ahead, but I
just haven't been able to work out a proof for it :).

thanks
-john

