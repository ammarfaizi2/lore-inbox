Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWGKIEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWGKIEM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 04:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWGKIEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 04:04:12 -0400
Received: from www.tglx.de ([213.239.205.147]:986 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1750731AbWGKIEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 04:04:09 -0400
Subject: Re: [BUG] APM resume breakage from 2.6.18-rc1 clocksource changes
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: john stultz <johnstul@us.ibm.com>, Pavel Machek <pavel@ucw.cz>,
       Mikael Pettersson <mikpe@it.uu.se>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.64.0607110054180.12900@scrub.home>
References: <200607092352.k69NqZuJ029196@harpo.it.uu.se>
	 <1152554328.5320.6.camel@localhost.localdomain>
	 <20060710180839.GA16503@elf.ucw.cz>
	 <Pine.LNX.4.64.0607110035300.17704@scrub.home>
	 <1152571816.9062.29.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607110054180.12900@scrub.home>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 10:07:09 +0200
Message-Id: <1152605229.32107.88.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman,

On Tue, 2006-07-11 at 00:59 +0200, Roman Zippel wrote:
> > The timer interrupt is re-enabled, via the timer_sysclass::resume hook,
> > while the timekeeping code is re-enabled via the
> > timekeeping_sysclass::resume hook. The issue being that I'm not sure
> > there's a defined way to specify the .resume calling order.
> > 
> > The timekeeping_suspended flag is a bit heavy handed, but I think it
> > might be the safest bet (assuming Mikael finds it works for him).
> 
> As temporary measure it's ok, but please add a comment, that it's there 
> because of broken suspend/resume ordering.
> That's another reason why I think that keeping interrupt handling and 
> timekeeping separate is illusionary.

It is not illusionary at all and we have to find a way to handle this.

Forcing time keeping to be bound on some interrupt handling is the wrong
design and in the way of tickless systems.

When there is a system where the time source is bound to an interrupt
event then the handling code for that time source has to cope with the
problem instead of enforcing this not generally valid scenario on
everything. We can of course add helpers into the generic part of the
time keeping code to make this easier.

The majority of machines has stand alone time sources and there is no
need to enforce artificial interrupt relations on them.

Please accept that the "tick" is not the holy grail of Linux. We have
already way too much historic tick ballast all over the place, so we
really want to avoid that when we design replacement functionality.

	tglx


