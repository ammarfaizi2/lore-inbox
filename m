Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262161AbVBAWyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbVBAWyj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 17:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbVBAWvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 17:51:38 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:13462 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262149AbVBAWsO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 17:48:14 -0500
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A2)
From: john stultz <johnstul@us.ibm.com>
To: Tim Bird <tim.bird@am.sony.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <41FFFD4F.9050900@am.sony.com>
References: <1106607089.30884.10.camel@cog.beaverton.ibm.com>
	 <41FFFD4F.9050900@am.sony.com>
Content-Type: text/plain
Date: Tue, 01 Feb 2005 14:48:09 -0800
Message-Id: <1107298089.2040.184.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-01 at 14:06 -0800, Tim Bird wrote:
> Minor spelling fix, and a question.
> 
> john stultz wrote:
> > linux-2.6.11-rc2_timeofday-core_A2.patch
> > ========================================
> > diff -Nru a/drivers/Makefile b/drivers/Makefile
> > --- a/drivers/Makefile	2005-01-24 13:30:06 -08:00
> > +++ b/drivers/Makefile	2005-01-24 13:30:06 -08:00
> ...
> 
> > + * all systems. It has the same course resolution as
> should be "coarse"

Good catch, I'm a terrible speller.

> Do you replace get_cmos_time() - it doesn't look like it.

Nope, its still used on i386 and x86-64, however I had to create an arch
independent abstraction for set/read_persistent_clock(). 

> You use it in your patch here...
> 
> > diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
> > --- a/arch/i386/kernel/time.c	2005-01-24 13:33:59 -08:00
> > +++ b/arch/i386/kernel/time.c	2005-01-24 13:33:59 -08:00
> ...
> 
> > +/* arch specific timeofday hooks */
> > +nsec_t read_persistent_clock(void)
> > +{
> > +	return (nsec_t)get_cmos_time() * NSEC_PER_SEC;
> > +}
> > +
> 
> I didn't scan for all uses of read_persistent_clock, but
> in my experience get_cmos_time() has a latency of up to
> 1 second on x86 because it synchronizes with the rollover
> of the RTC seconds.

I believe you're right. Although we don't call read_persistent_clock()
very frequently, nor do we call it in ways we don't already call
get_cmos_time(). So I'm not sure exactly what the concern is.

> This comment in timeofday.c:timeofday_suspend_hook
> worries me:
> 
> > +	/* First off, save suspend start time
> > +	 * then quickly read the time source.
> > +	 * These two calls hopefully occur quickly
> > +	 * because the difference will accumulate as
> > +	 * time drift on resume.
> > +	 */
> > +	suspend_start = read_persistent_clock();
> 
> Do you know if the sync problem is an issue here?

I don't believe so. The full context of the code is this:

	/* First off, save suspend start time
	 * then quickly read the time source.
	 * These two calls hopefully occur quickly
	 * because the difference will accumulate as
	 * time drift on resume.
	 */
	suspend_start = read_persistent_clock();
	now = read_timesource(timesource);


Since we call read_persistent_clock(), it should return right as the
second changes, thus we will be marking the new second as closely as
possible with the timesource value. If the order was reversed, I think
it would be a concern. 

I've only lightly tested the suspend code, but on my system I didn't see
very much drift appear. Regardless, it should be better then what the
current suspend/resume code does, which doesn't keep any sub-second
resolution across suspend.

thanks so much for the code review!
-john

