Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750834AbWFEVIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWFEVIE (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 17:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWFEVIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 17:08:04 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:8585 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750834AbWFEVIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 17:08:02 -0400
Date: Mon, 5 Jun 2006 23:07:01 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: clocksource
In-Reply-To: <1149538810.9226.29.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0606052226150.32445@scrub.home>
References: <20060604135011.decdc7c9.akpm@osdl.org> 
 <Pine.LNX.4.64.0606050141120.17704@scrub.home> <1149538810.9226.29.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 5 Jun 2006, john stultz wrote:

> On Mon, 2006-06-05 at 01:50 +0200, Roman Zippel wrote:
> > Hi,
> > 
> > On Sun, 4 Jun 2006, Andrew Morton wrote:
> > 
> > > time-use-clocksource-infrastructure-for-update_wall_time.patch
> > 
> > I still disagree with the update_wall_time() changes, they should be kept 
> > the new separate from this. 
> 
> Is this directly related to the next item (if so, how?), or just
> preference? I'd really like to avoid having multiple code paths for the
> timekeeping core, so I'd like to see this unified. I'm willing to
> optimize out bits w/ constants and whatnot, but I worry it will be a
> nightmare to maintain if we have multiple generic update_wall_time
> implementations.

One "unified" version will only be worse. Keeping the new path separate 
from the old path will only make things clearer and more flexible.
Right now you have a mixture of old code, interpolator code and new 
timekeeping code, which makes it a big mess. _Please_ don't do this, it 
makes your code very hard to read, personally I cannot guarantee that this 
thing does the right thing, with the separate function we at least have a 
backup plan. John, this is very sensitive code, I beg you not to fuck 
around with it. :-(

> > The error algorithm is a somewhat old version 
> > and can cause oscillation and thus a confused clock.
> 
> Would you mind elaborating on this? Which aspect of the error algorithm
> is off? How does the clock become confused? Could you point to the line
> numbers, etc?  I assume your last patchset contains the current version?

With large clock offsets the lookahead doesn't work correctly, basically 
because it's already to late and it can cause overadjustment. Because of 
this I do an extra lookahead in clocksource_bigadjust().

> > > time-let-user-request-precision-from-current_tick_length.patch
> > 
> > This is broken, as it simply throws away resolution depending on the 
> > clock.
> 
> So if the clock shift value is less then 12 (SHIFT_SCALE - 10), this is
> true, and currently that's only the jiffies case.
> 
> Just to be clear, are you then suggesting that the accumulation in
> update_wall_time should be done in a fixed shifted nanosecond unit
> regardless of the clock shift value? Is SHIFT_SCALE-10, good enough in
> your mind for this?
> 
> That seems not too difficult to do, and can be done w/ an incremental
> patch. I'll try to crank that out today.

I'd prefer you'd just take the update function from my patch, it's nicely 
optimized and I'll try to address any concern you have about it.
For this I also I posted a userspace test program, so that I know how it 
behaves, do you have something similiar for yours?

bye, Roman
