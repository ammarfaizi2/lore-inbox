Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbTJHPzq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 11:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbTJHPzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 11:55:01 -0400
Received: from ltgp.iram.es ([150.214.224.138]:4749 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S261683AbTJHPyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 11:54:20 -0400
From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 8 Oct 2003 17:48:46 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Time precision, adjtime(x) vs. gettimeofday
Message-ID: <20031008154846.GA29868@iram.es>
References: <1065619951.25818.15.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065619951.25818.15.camel@gaston>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hi!,

On Wed, Oct 08, 2003 at 03:32:31PM +0200, Benjamin Herrenschmidt wrote:
> 
> Hi !
> 
> While fixing problems experienced by some scientific users who
> found out that gettimeofday() could sometimes run backward, I
> found a nasty issue I don't know if we can fix at all or if it's
> not worth bothering.
> 
> So the problem is with any arch (ppc, x86, ...) who uses a HW
> timer (like the CPU timebase on PPC) to provide better-than-jiffy
> precision in do_gettimeofday().
> 
> The problem is that the offset added to xtime value (typically
> the HW timer current value minus the HW timer value at the last
> timer interrupt scaled to usec) uses a scaling factor which has
> been calibrated once, and doesn't take into account the adjustements
> done to xtime increase by adjtime/adjtimex algorithm.

Well, it it affects gettimeofday which has a precision of 1 part in
10000 (100 ppm), it means that our boot time timebase calibration was 
not very good to start with, on my set of running VME machines I have
the following (values in ppm): 

$cat  /nfsroots/v*/etc/ntp/drift
-10.191
-2.787
3.869
-5.645
-1.146
-7.383
4.400
5.824
4.640
0.014
-8.371
0.056
-2.324
-5.655
-5.828
-4.862
-3.380

I can understand that we'll certainly have more serious problems
of non-monotonicity for nanosecond precision timestamps.

I also have from time to time a bad timebase calibration at boot which 
makes the drift go to about 400ppm. I just don't have this problem
on any machine right now. I believed I mentioned this issue once 
on the list but never found time to track it. 

Maybe the boot-time timebase calibration could use a longer period.
However, I'd first like to know by how much the timebase calibration
of the user which has the problem varies between reboots.

> 
> That means that if, for example, adjtimex was called with a factor
> that is trying to slow you down a bit, and you call gettimeofday
> right before the end of a jiffy period, you may calculate an offset
> based on the HW timer that is actually higher than what will be
> really added to xtime on the next interrupt.
> 
> So you can end-up returning non-monotonic values from gettimeofday().

As I said, only if you have fairly large corrections. Anything below


> 
> I don't see a way to fix that that wouldn't bloat do_gettimeofday(),
> except if we can, at jiffy interrupt time, pre-calculate a scaling
> factor for the next jiffy and just apply it on the HW timer value
> on the next calls to do_gettimeofday(). But that option would need
> better understanding of the adjtime(x) algorithm that what I have
> at this point.
> 
> Storing the last value to make sure we don't return a value that is
> lower will defeat the read_lock/write_lock mecanism, forcing us to
> take the write_lock(), and thus screwing up scalability.
> 
> Any idea ?
> 
> Note: In addition to the above, there seem to be a race on x86 2.4
> (only, 2.6 doesn't have it) due to the fact that the actual xtime
> increase is done from a bottom half. The HW timer "last stamp" is
> stored from the HW interrupt, xtime is only updated on the BH, so
> if gettimeofday is called in between those 2, you'll end up using
> the "new" "last stamp" with the old xtime, thus returning an
> incorrect value. A fix we use on PPC is to use
> 
>  jiffies - wall_jiffies
> 
> As an additional correction.

AFAIR, this correction is also done on x86.


	Regards,
	Gabriel
