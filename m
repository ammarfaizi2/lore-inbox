Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261990AbVHEUku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbVHEUku (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 16:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVHEUkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 16:40:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10713 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263164AbVHEUjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 16:39:45 -0400
Date: Fri, 5 Aug 2005 13:38:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: vandrove@vc.cvut.cz, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       shaohua.li@intel.com, venkatesh.pallipadi@intel.com
Subject: Re: [PATCH 2.6.13-rc5-gitNOW] msleep() cannot be used from
 interrupt
Message-Id: <20050805133824.4e0b4dcb.akpm@osdl.org>
In-Reply-To: <20050805122301.A30003@unix-os.sc.intel.com>
References: <20050805135007.GA6985@vana.vc.cvut.cz>
	<20050805115329.45889ef8.akpm@osdl.org>
	<20050805122301.A30003@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Venkatesh Pallipadi <venkatesh.pallipadi@intel.com> wrote:
>
> On Fri, Aug 05, 2005 at 11:53:29AM -0700, Andrew Morton wrote:
> > 
> > That's all pretty sad stuff.  I guess for now we can go back to the busy
> > loop.  Longer-term it would be nice if we could tune up the HPET driver in
> > some manner so we can avoid this busy-wait-in-interrupt.
> > 
> > I'm not sure who the HPET maintainer/expert is nowadays.  Robert Picco did
> > the original work but I haven't seen Robert around for a long time?
> 
> Actually there are two parts in HPET. 
> 1) Using HPET for kernel timer and RTC emulation
> 2) HPET driver to export timers to user(/dev/hpet) and kernel drivers
> 
> We did the part (1) for i386 and I think Andi/Vojtech did (1) for x86_64. And 
> Robert Picco did (2).

OK, thanks.

> So, using rtc_get_rtc_time() in an interrupt handler will be my code. In this
> part we try to emulate RTC interrupt using HPET and we have to read the current
> RTC time in the interrupt handler. I can't think of any way of not doing
> rtc_get_rtc_time here.
>
> I think we should have two versions of rtc_get_rtc_time. One which does msleep,
> that can be called from process context (in drivers/char/rtc.c) and one that
> can be called from interrupt context (i386 and x86_64 hpet time routines). Or 
> same routine behaving differently depending on where it is called from.

Yes, we could do that.  But when one is chasing "worst-case latency", we
need to address the worst-case machine, as well as the worst-case
codepath...

> And for the hpet rtc emulation routines it should be OK even if the time is 
> slightly off and not exact. So, probably we should be able to force read
> rtc even when update is in progress. That way we can avoid the busy loop.
> Unless RTC returns grossly wrong time values while UIP flag is set. I need to
> look at RTC specs to verify that.

Yup, no hurry.  If we can improve that codepath sometime it'd be nice, thanks.
