Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262849AbUKXVEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262849AbUKXVEc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 16:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbUKXVEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 16:04:32 -0500
Received: from over.ny.us.ibm.com ([32.97.182.111]:15573 "EHLO
	over.ny.us.ibm.com") by vger.kernel.org with ESMTP id S262849AbUKXVES
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 16:04:18 -0500
Date: Wed, 24 Nov 2004 10:16:07 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: janitor@sternwelten.at, netdev@oss.sgi.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Subject: Re: [PATCH] Add ssleep_interruptible()
Message-ID: <20041124181607.GA1720@us.ibm.com>
References: <E1CO1vc-00022t-N2@sputnik> <20041101200749.GF1730@us.ibm.com> <20041117013059.GA4218@us.ibm.com> <20041122024804.GD4146@verge.net.au> <20041122171922.GA7770@us.ibm.com> <20041124020111.GF31329@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041124020111.GF31329@verge.net.au>
X-Operating-System: Linux 2.6.9-test-acpi (i686)
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 11:01:13AM +0900, Horms wrote:
> On Mon, Nov 22, 2004 at 09:19:22AM -0800, Nishanth Aravamudan wrote:
> > On Mon, Nov 22, 2004 at 11:48:05AM +0900, Horms wrote:
> > > On Tue, Nov 16, 2004 at 05:30:59PM -0800, Nishanth Aravamudan wrote:
> > > > On Mon, Nov 01, 2004 at 12:07:49PM -0800, Nishanth Aravamudan wrote:
> > > > > Description: Adds ssleep_interruptible() to allow longer delays to occur
> > > > > in TASK_INTERRUPTIBLE, similarly to ssleep(). To be consistent with
> > > > > msleep_interruptible(), ssleep_interruptible() returns the remaining time
> > > > > left in the delay in terms of seconds. This required dividing the return
> > > > > value of msleep_interruptible() by 1000, thus a cast to (unsigned long)
> > > > > to prevent any floating point issues.
> > > > > 
> > > > > Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> > > > > 
> > > > > --- 2.6.10-rc1-vanilla/include/linux/delay.h	2004-10-30 
> > > > > 15:34:03.000000000 -0700
> > > > > +++ 2.6.10-rc1/include/linux/delay.h	2004-11-01 12:06:11.000000000 -0800
> > > > > @@ -46,4 +46,9 @@ static inline void ssleep(unsigned int s
> > > > > 	msleep(seconds * 1000);
> > > > > }
> > > > > 
> > > > > +static inline unsigned long ssleep_interruptible(unsigned int seconds)
> > > > > +{
> > > > > +	return (unsigned long)(msleep_interruptible(seconds * 1000) / 1000);
> > > > > +}
> > > > > +
> > > > > #endif /* defined(_LINUX_DELAY_H) */
> > > > 
> > > > After a discussion on IRC, I believe it is pretty clear that this
> > > > function has serious issues. Mainly, that if I request a delay of 1
> > > > second, but msleep_interruptible() returns after 1 millisecond, then
> > > > ssleep_interruptible() will return 0, claiming the entire delay was
> > > > used (due to rounding).
> > > > 
> > > > Perhaps we should just be satisfied with milliseconds being the grossest
> > > > (in contrast to fine) measure of time, at least in terms of
> > > > interruptible delays. ssleep() is unaffected by this problem, of course.
> > > > 
> > > > Please revert this patch, if applied, as well as any of the other
> > > > patches I sent using ssleep_interruptible() [only a handful].
> > > 
> > > Would making sure that the time slept was always rounded up to
> > > the nearest second resolve this problem. I believe that rounding
> > > up is a common approach to resolving this type of problem when
> > > changing clock resolution.
> > > 
> > > I am thinking of something like this.
> > > 
> > > ===== include/linux/delay.h 1.6 vs edited =====
> > > --- 1.6/include/linux/delay.h	2004-09-03 18:08:32 +09:00
> > > +++ edited/include/linux/delay.h	2004-11-22 11:47:03 +09:00
> > > @@ -46,4 +46,10 @@ static inline void ssleep(unsigned int s
> > >  	msleep(seconds * 1000);
> > >  }
> > >  
> > > +static inline unsigned long ssleep_interruptible(unsigned int seconds)
> > > +{
> > > +	return (unsigned long)((msleep_interruptible(seconds * 1000) + 999) / 
> > > +			1000);
> > 
> > This is a good idea, but I have two issues:
> > 
> > 1) A major reason for having msecs_to_jiffies() and co. is to avoid
> > having to do this type of conversion ourselves. A weak argument,
> > admittedly, but just something to keep in mind.
> > 
> > 2) This still has a serious logical flaw: If I request 1 second of
> > sleep, and I don't sleep the entire time, then it is now guaranteed that
> > I will think I did not sleep at all (ie. ssleep_interruptible() will
> > return 1). That's just another version of the original issue.
> > 
> > I just don't think it's useful to have this coarse of granularity, at
> > least in terms of interruptible sleep.
> 
> If it is unacceptable to neither underestimate or overestimate the
> duration of a sleep to the nearest second (the unit of granularity of
> the sleep in this case) then I agree.

This is kind of my position. Overestimating leads to the potential, if a
loop is used by the caller, of never leaving the loop, e.g.

timeout = 1;
while (timeout) {
	timeout = ssleep_interruptible(timeout);
}

Underestimating leads to leaving the loop too early, because the caller
thinks a full second has expired and thus a signal was *not* received in
on *full* second, typically leading to an error condition.

> That is unless you want to request
> a sleep in seconds but have the duration returned in milliseconds. But
> if that is the case then it is probably more sensible to just use
> msleep_interruptible() and be done with it.

Exactly, I think that an API which has a parameter in seconds and a
return value in milliseconds is pretty bad. Makes things very confusing
and really msleep_interruptible() is the same, just a difference of
parameter units, then.

-Nish
