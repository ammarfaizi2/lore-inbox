Return-Path: <linux-kernel-owner+w=401wt.eu-S932330AbXAGCJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbXAGCJL (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 21:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbXAGCJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 21:09:11 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:47920 "EHLO scrub.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932328AbXAGCJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 21:09:09 -0500
From: Roman Zippel <zippel@linux-m68k.org>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [RFC] HZ free ntp
Date: Sat, 6 Jan 2007 17:46:52 +0100
User-Agent: KMail/1.9.5
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20061204204024.2401148d.akpm@osdl.org> <200701011727.46944.zippel@linux-m68k.org> <1167766932.3141.10.camel@localhost>
In-Reply-To: <1167766932.3141.10.camel@localhost>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200701061746.52861.zippel@linux-m68k.org>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 02 January 2007 20:42, john stultz wrote:

> > tick_nsec doesn't require special treatment, in the middle term it's
> > obsolete anyway, it could be replaced with (current_tick_length() >>
> > TICK_LENGTH_SHIFT) and current_tick_length() being inlined.
>
> If NTP_INTERVAL_FREQ is different then HZ, then tick_nsec still has a
> different meaning then (current_tick_length() >> TICK_LENGTH_SHIFT).
> So since tick_nsec is still used in quite a few places, so I'm hesitant
> to pull it.

The current usage under arch is pretty much bogus and they likely can't use 
dyntick anyway, so it would be easier to disable tick_nsec completely if 
dyntick is enabled.

> > NTP_INTERVAL_FREQ could be a real variable (so it can be initialized at
> > runtime), it's already gone from all important paths.
>
> Wait, so you're suggesting NTP_INTERVAL_FREQ be a dynamic variable
> instead of a constant? Curious, could you give a bit more detail on why?

We already have more than enough config options, where the user has barely any 
idea what to do, so we should try to configure and initialize as much as 
possible at runtime depending on what the hardware is capable of.

That reminds me that the main problem left for a dynamic variable is 
time_offset. It should become a 64 bit value, so SHIFT_UPDATE isn't needed 
anymore. Right now it depends on HZ to maximize the value range.

> > In the short term I'd prefered a clock would store its frequency instead
> > of using NTP_INTERVAL_LENGTH in clocksource_calculate_interval(), so it
> > doesn't has to be derived there.
>
> I don't follow this at all. clocksources do store their own frequency
> (via mult/shift). Could you explain?

mult is not a constant and calculating the frequency like this is not very 
precise.

bye, Roman
