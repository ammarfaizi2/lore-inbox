Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWJHPpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWJHPpV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 11:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWJHPpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 11:45:21 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:24750 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751232AbWJHPpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 11:45:20 -0400
Subject: Re: + clocksource-increase-initcall-priority.patch added to -mm
	tree
From: Daniel Walker <dwalker@mvista.com>
To: tglx@linutronix.de
Cc: akpm@osdl.org, johnstul@us.ibm.com, mingo@elte.hu, zippel@linux-m68k.org,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1160319234.5686.12.camel@localhost.localdomain>
References: <200610070153.k971ren4020838@shell0.pdx.osdl.net>
	 <1160294812.22911.8.camel@localhost.localdomain>
	 <1160302797.22911.37.camel@localhost.localdomain>
	 <1160319033.3693.19.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160319234.5686.12.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 08 Oct 2006 08:45:17 -0700
Message-Id: <1160322317.3693.47.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-08 at 16:53 +0200, Thomas Gleixner wrote:
> On Sun, 2006-10-08 at 07:50 -0700, Daniel Walker wrote:
> > On Sun, 2006-10-08 at 12:19 +0200, Thomas Gleixner wrote:
> > > On Sun, 2006-10-08 at 10:06 +0200, Thomas Gleixner wrote:
> > > > On Fri, 2006-10-06 at 18:53 -0700, akpm@osdl.org wrote:
> > > > > Since it's likely that this interface would get used during bootup I moved all
> > > > > the clocksource registration into the postcore initcall.  This also eliminated
> > > > > some clocksource shuffling during bootup.
> > > > 
> > > > We had the init call in postcore already. John moved it to module init
> > > > to eliminate trouble with unsynced / unstable TSCs, IIRC.
> > > > 
> > > > John, can you please comment on this.
> > > 
> > > It also breaks pmtimer.
> > 
> > OGAWA reported this already. It breaks the case when there is a verified
> > read needed, instead of the fast read. I'll fix it.
> 
> I'd like to know, why we need to move that and you did not explain _why_
> it is likely that it is used during bootup.

If the clocksources are registered at the same time as the clocksource
users then you end up with users frequently switching clocks during boot
up. The original clocksource code solved this by not allowing a real
clocksource lookup until after the system fully booted.

However, if you put all the clocksources into postcore initcall, with
that being known in advance, and all the users are in lower priority
initcalls then you don't need extra code to prevent churn during bootup.

The reason that I think this will get used during boot up is because
some of the target users will be instrumentation, and (my prediction
anyway) is that some will need to use the interface early. Still even
postcore may not be early enough.

Daniel

