Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933012AbWJITth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933012AbWJITth (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 15:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933017AbWJITtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 15:49:36 -0400
Received: from www.osadl.org ([213.239.205.134]:33998 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S933012AbWJITtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 15:49:36 -0400
Subject: Re: [PATCH 01/10] -mm: clocksource: increase initcall priority
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Daniel Walker <dwalker@mvista.com>
Cc: john stultz <johnstul@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1160421857.30532.19.camel@c-67-180-230-165.hsd1.ca.comcast.net>
References: <20061006185439.667702000@mvista.com>
	 <20061006185456.261581000@mvista.com>
	 <1160419851.5458.17.camel@localhost.localdomain>
	 <1160421857.30532.19.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 21:49:38 +0200
Message-Id: <1160423379.5686.236.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-09 at 12:24 -0700, Daniel Walker wrote:
> > So, the question becomes: Do we want to start using arch specific
> > clocksources as early as possible, with the potential that we'll replace
> > it when a better one shows up later? It would allow for finer grained
> > timekeeping early in boot, which sounds nice, but I'm not sure how great
> > the real need is for that.
> 
> My main motivation is that I'm assuming other uses of the interface will
> exist. Then anything that uses the interface after postcore will avoid
> switching clocks later.

What does it matter, when clocks switch? That's a one time event.

The boot code is different and there is nothing which requires the
availability of that interface in the early boot process.

> If I for instance, just return clocksource_jiffies until the system is
> fully booted then any thing that got a clock early, even during part of
> device_initcall, would end up switching to a new clock when boot up
> finished. I think that was acceptable when just timekeeping might have
> been using the interface, but I don't know that it would scale well from
> 1 to 2 to 5 users of the interface. Then you would have several clock
> switches happened after boot up .

What are the 5 users of that interface ? 

There is one existing user, one artifical you try to create for
sched_clock and some handwaving about instrumentation. Even when we have
5 users, then the switching of clocks does not matter anything. This
happens the same way, when I load the highest rated clock source as a
module during init.

> > I suspect it might actually cause more shuffling, as some clocksources
> > (well, just the TSC, really.. its such a pain...) are not disqualified
> > until later because we don't know if the system will enter C3, or change
> > cpufreq, etc..  By waiting longer, we increase the chance that those
> > disqualifying actions will occur before we install it.
> 
> This is something I've struggled with, but it's still and issue with the
> current code to a lesser degree. Like cpufreq isn't likely to be used
> during bootup, but acpi sleep states might be..

Lesser degree ? You have an issue, which was not there before you made
the changes. This is simply regression and the ignoring of that
regression is wilful breakage.

> The current code can be classified as avoiding shuffle, but not
> eliminating it. Like with the acpi_pm timer, I was thinking I'd just put
> it back into device_initcall and assume shuffling might happen in rare
> cases.

Great. We install TSC in early boot and pmtimer in late boot. Now we
have the fun of unsynced TSCs and time going backwards again, until we
get pmtimer loaded. I have explained it to you already, but that is the
reason why that stuff was moved into late boot.

Also you have not yet once given an explanation other than the "magic
churn", why this is necessary. There is no churn. The clocksource layer
is designed to allow the replacement of clock sources and it does not
hurt at all. It does also not matter if there are 1 ore 100 users.

	tglx


