Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWGFUd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWGFUd1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 16:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWGFUd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 16:33:27 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:61147 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750809AbWGFUd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 16:33:26 -0400
Date: Thu, 6 Jul 2006 22:33:03 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm2 hrtimer code wedges at boot?
In-Reply-To: <1152147114.24656.117.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.64.0607061912370.12900@scrub.home>
References: <20060624061914.202fbfb5.akpm@osdl.org> 
 <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu> 
 <Pine.LNX.4.64.0606271212150.17704@scrub.home> 
 <200606271643.k5RGh9ZQ004498@turing-police.cc.vt.edu> 
 <Pine.LNX.4.64.0606271903320.12900@scrub.home>  <Pine.LNX.4.64.0606271919450.17704@scrub.home>
  <200606271907.k5RJ7kdg003953@turing-police.cc.vt.edu> 
 <1151453231.24656.49.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.64.0606281218130.12900@scrub.home>
  <Pine.LNX.4.64.0606281335380.17704@scrub.home> 
 <200606292307.k5TN7MGD011615@turing-police.cc.vt.edu> 
 <1151695569.5375.22.camel@localhost.localdomain> 
 <200606302104.k5UL41vs004400@turing-police.cc.vt.edu> 
 <Pine.LNX.4.64.0607030256581.17704@scrub.home> 
 <200607050429.k654TXUr012316@turing-police.cc.vt.edu>
 <1152147114.24656.117.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 5 Jul 2006, john stultz wrote:

> Roman: While I'm not 100% confident about my assessment above, I worry
> this is mimicking the problems I had been seeing in my simulator w/ your
> clocksource_adjustment algorithm when I simulated dropping many ticks.
> While currently this behavior points to some other problem, with the
> dynticks patch, its much more likely that we will see 100s of ticks
> skipped.
> 
> I quickly revived my P-D adjustment patch and it does not appear to
> suffer from the same problem with the above droptick change (although
> its only been lightly tested). 

The PID concept had me confused for a while and I'm still not sure it 
really applies, but there are similarities and what I want to do is not 
that different from yours (limiting then the effect of the current error) 
with the biggest difference that I keep everything in the big adjust 
function, so the extra work is only done when needed.

> +		int adj, multadj = 0;
> +		s64 offset_update = 0, snsec_update = 0;
> +		
> +		/* First do the frequency adjustment:
> +		 *   The idea here is to look at the error 
> +		 *   accumulated since the last call to 
> +		 *   update_wall_time to determine the 
> +		 *   frequency adjustment needed so no new
> +		 *   error will be incurred in the next
> +		 *   interval.
> +		 *
> +		 *   This is basically derivative control
> +		 *   using the PID terminology (we're calculating
> +		 *   the derivative of the slope and correcting it).
> +		 *
> +		 *   The math is basically:
> +		 *      multadj = interval_error/interval_cycles
> +		 *   Which we fudge using binary approximation.
> +		 */
> +		if(interval_error >= 0) {
> +			adj = error_aproximation(interval_error,
> +						interval_cycs, 0);
> +			multadj += 1 << adj;
> +			snsec_update += interval << adj;
> +			offset_update += offset << adj;
> +		} else {
> +			adj = error_aproximation(-interval_error, 
> +						interval_cycs, 0);
> +			multadj -= 1 << adj;
> +			snsec_update -= interval << adj;
> +			offset_update -= offset << adj;
> +	        }

Here we actually don't derive very much, we already know how it will 
change. :)
We basically want to keep the difference between tick length and xtime 
interval as small as possible. Since most of the difference comes via 
second_overflow(), we might want to do some precalculations near there, so 
we avoid accumulating a lot of error in the first place, this is 
especially important with only rare updates.

> +		/* Now do the offset adjustment:
> +		 *   Now that the frequncy is fixed, we
> +		 *   want to look at the total error accumulated
> +		 *   to move us back in sync using the same method.
> +		 *   However, we must be careful as if we make too 
> +		 *   sudden an adjustment we might overshoot. So we 
> +		 *   limit the amount of change to spread the 
> +		 *   adjustment (using MAXOFFADJ) over a longer 
> +		 *   period of time.
> +		 *
> +		 *   This is basically proportional control
> +		 *   using the PID terminology.
> +		 *
> +		 *   We use interval_cycs here as the divisor, which
> +		 *   hopes that the next sample will be similar in 
> +		 *   distance from the last.
> +		 */
> +		if(error >= 0) {
> +			adj = error_aproximation(error, 
> +					interval_cycs, MAXOFFADJ);
> +			multadj += 1<<adj;
> +			snsec_update += interval <<adj;
> +			offset_update += offset << adj;
> +		} else {
> +			adj = error_aproximation(-error,
> +						interval_cycs, MAXOFFADJ);
> +			multadj -= 1<<adj;
> +			snsec_update -= interval <<adj;
> +			offset_update -= offset << adj;
> +		}

The limitation avoids the biggest problems, but it also may slow down the 
error reduction (the more the bigger the shift value is). The main problem 
is really that we don't know how many ticks will be skipped and with 
interval_cycs you only know what happened last and this won't help if 
ticks are skipped in irregular intervals.
Regarding dynticks it would help a lot here to know how many ticks are 
skipped so you can spread the error correction evenly over this period 
until the next adjustment and the correction is stopped in time.

bye, Roman
