Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262240AbVAZAUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbVAZAUv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 19:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbVAZAUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 19:20:15 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:40322 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262240AbVAZARr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 19:17:47 -0500
Subject: Re: [RFC][PATCH] new timeofday arch specific hooks (v. A2)
From: john stultz <johnstul@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       Paul Mackerras <paulus@samba.org>, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max Asbock <amax@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>
In-Reply-To: <1106697227.5235.28.camel@gaston>
References: <1106607089.30884.10.camel@cog.beaverton.ibm.com>
	 <1106607153.30884.12.camel@cog.beaverton.ibm.com>
	 <1106620134.15850.3.camel@gaston>
	 <1106694561.30884.52.camel@cog.beaverton.ibm.com>
	 <1106697227.5235.28.camel@gaston>
Content-Type: text/plain
Date: Tue, 25 Jan 2005 16:17:35 -0800
Message-Id: <1106698655.1589.8.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-26 at 10:53 +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2005-01-25 at 15:09 -0800, john stultz wrote:
> 
> > The performance is a concern, and right now there are issues (ntp_scale
> > being the top of the list) however I hope they can be resolved. Looking
> > at ppc64's do_gettimeofday() vs this implementation there we do have
> > more overhead, but maybe you could suggest how we can avoid some of it?
> 
> I would suggest reclaculating the scale factor and offset for ntp
> adjustement regulary from the timer tick or so, not on each gettimeofday
> call.

Agreed. I'll get something like this done for the next release.


> Also, I have some updates to the ppc64 implementation where I regulary
> update the pre-scale offset into the post-scale one so that the
> timebase-prescale substraction always gives a 32 bits number. I do that
> so my fast userland gettimeofday can be implemented more easily and more
> efficiently for 32 bits processes. I yet have to check how I can hook
> those things into your new scheme.

Hmm. In my code, I move the interval delta (similar to your pre-scale
offset) to system_time (seems to be equivalent to the post-scale) at
each call to timeofday_interrupt_hook(). So while 64 bits are normally
used, you could probably get away doing the interval delta calculations
in 32bits if your timesource frequency isn't too large. This would only
be done in the arch-specific 32bit vsyscall code, right?

> > I still want to support vsyscall gettimeofday, although it does have to
> > be done on an arch-by-arch basis. It's likely the systemcfg data
> > structure can still be generated and exported. I'll look into it and see
> > what can be done.
> 
> Well, since it only contains the prescale and postscale offsets and the
> scaling value, it only needs to be updated when they change, so a hook
> here would be fine.

Great, thats what I was hoping.

thanks
-john

