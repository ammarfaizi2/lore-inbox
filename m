Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751890AbWJITYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbWJITYU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 15:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751895AbWJITYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 15:24:20 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:27554 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751890AbWJITYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 15:24:20 -0400
Subject: Re: [PATCH 01/10] -mm: clocksource: increase initcall priority
From: Daniel Walker <dwalker@mvista.com>
To: john stultz <johnstul@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1160419851.5458.17.camel@localhost.localdomain>
References: <20061006185439.667702000@mvista.com>
	 <20061006185456.261581000@mvista.com>
	 <1160419851.5458.17.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 12:24:16 -0700
Message-Id: <1160421857.30532.19.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-09 at 11:50 -0700, john stultz wrote:
> On Fri, 2006-10-06 at 11:54 -0700, Daniel Walker wrote:
> > plain text document attachment (clocksource_init_call.patch)
> > Since it's likely that this interface would get used during bootup 
> > I moved all the clocksource registration into the postcore initcall. 
> 
> So this is still somewhat of an open question: While timekeeping_init
> runs quite early, and the timekeeping subsystem and its interface is
> usable early in the boot process, currently not all the clocksources are
> available as early. This is by design, as there may be clocksource
> driver modules loaded later on in the boot process, so we don't want to
> require it early.
> 
> So, the question becomes: Do we want to start using arch specific
> clocksources as early as possible, with the potential that we'll replace
> it when a better one shows up later? It would allow for finer grained
> timekeeping early in boot, which sounds nice, but I'm not sure how great
> the real need is for that.

My main motivation is that I'm assuming other uses of the interface will
exist. Then anything that uses the interface after postcore will avoid
switching clocks later.

If I for instance, just return clocksource_jiffies until the system is
fully booted then any thing that got a clock early, even during part of
device_initcall, would end up switching to a new clock when boot up
finished. I think that was acceptable when just timekeeping might have
been using the interface, but I don't know that it would scale well from
1 to 2 to 5 users of the interface. Then you would have several clock
switches happened after boot up .

> > This also eliminated some clocksource shuffling during bootup.
> 
> Actually, I'm not sure I see this. Which shuffling does it avoid? 

The shuffling that you commented about in kernel/time/clocksource.c
which was the reason for the "finished_booting" flag, and related code.

> I suspect it might actually cause more shuffling, as some clocksources
> (well, just the TSC, really.. its such a pain...) are not disqualified
> until later because we don't know if the system will enter C3, or change
> cpufreq, etc..  By waiting longer, we increase the chance that those
> disqualifying actions will occur before we install it.

This is something I've struggled with, but it's still and issue with the
current code to a lesser degree. Like cpufreq isn't likely to be used
during bootup, but acpi sleep states might be..

The current code can be classified as avoiding shuffle, but not
eliminating it. Like with the acpi_pm timer, I was thinking I'd just put
it back into device_initcall and assume shuffling might happen in rare
cases.

Daniel

