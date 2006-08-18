Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWHRFum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWHRFum (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 01:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWHRFum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 01:50:42 -0400
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:62585 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964841AbWHRFul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 01:50:41 -0400
From: David Brownell <david-b@pacbell.net>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [RFC][PATCH] Unify interface to persistent CMOS/RTC/whatever clock
Date: Thu, 17 Aug 2006 22:50:35 -0700
User-Agent: KMail/1.7.1
References: <200608162247.41632.david-b@pacbell.net> <200608171641.20919.david-b@pacbell.net> <1155859636.31755.159.camel@cog.beaverton.ibm.com>
In-Reply-To: <1155859636.31755.159.camel@cog.beaverton.ibm.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608172250.36045.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By the way, one furher observation:

> > Presumably this is stuff that should be done by the RTC class resume()
> > method, probably for the CONFIG_RTC_HCTOSYS_DEVICE clock (though there
> > could be a better RTC ... one that's being NTP-corrected).  That'd
> > be no sooner than 2.6.19, which adds new class-level suspend()/resume()
> > calls to help offload individual drivers.
> 
> Hrm. I'm a bit skeptical that the RTC resume code should update the
> timekeeping code instead of the timekeeping code doing it.

But how could timekeeping code know when the RTC is accessible again?

It might be unusable until after e.g. an I2C controller and then the RTC
are resumed (and maybe a parent to the I2C controller) ... the class
resume mechanism piggybacks on the normal resume sequencing, so doing it
that way would automatically resolve that issue.


> It seems that 
> it would cause additional complexity (what if there are two RTC
> devices?) and would still have some of the suspend/resume ordering
> issues I'm worried about.

The RTC framework currently "knows" which RTC is used for the hctosys
update, so that approach can be addressed by saving a single pointer
and adding some class suspend()/resume() code to test it.  No complexity
necessary; if it's good enough to set the initial system time, it's
good enough to set it again after resume.  (And maybe all the RTCs
should be getting NTP updates, not just one of them ...)

I think that if you keep in mind that scenario -- I2C used to access
the RTC clock -- and make sure it works, you'll notice a few details
of your current approach that need to be changed.

In particular, it is impossible for any sys_device's driver resume()
to access I2C (since that resume is done with irqs disabled, while i2c
controllers normally require irqs to run); but that's what the current
version of timekeeping_resume() in your patch would be doing.

- Dave

