Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263105AbVHET0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263105AbVHET0x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 15:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbVHETYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 15:24:12 -0400
Received: from fmr22.intel.com ([143.183.121.14]:65495 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262819AbVHETXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 15:23:23 -0400
Date: Fri, 5 Aug 2005 12:23:02 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, Shaohua Li <shaohua.li@intel.com>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH 2.6.13-rc5-gitNOW] msleep() cannot be used from interrupt
Message-ID: <20050805122301.A30003@unix-os.sc.intel.com>
References: <20050805135007.GA6985@vana.vc.cvut.cz> <20050805115329.45889ef8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050805115329.45889ef8.akpm@osdl.org>; from akpm@osdl.org on Fri, Aug 05, 2005 at 11:53:29AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 11:53:29AM -0700, Andrew Morton wrote:
> 
> That's all pretty sad stuff.  I guess for now we can go back to the busy
> loop.  Longer-term it would be nice if we could tune up the HPET driver in
> some manner so we can avoid this busy-wait-in-interrupt.
> 
> I'm not sure who the HPET maintainer/expert is nowadays.  Robert Picco did
> the original work but I haven't seen Robert around for a long time?

Actually there are two parts in HPET. 
1) Using HPET for kernel timer and RTC emulation
2) HPET driver to export timers to user(/dev/hpet) and kernel drivers

We did the part (1) for i386 and I think Andi/Vojtech did (1) for x86_64. And 
Robert Picco did (2).

So, using rtc_get_rtc_time() in an interrupt handler will be my code. In this
part we try to emulate RTC interrupt using HPET and we have to read the current
RTC time in the interrupt handler. I can't think of any way of not doing
rtc_get_rtc_time here.

I think we should have two versions of rtc_get_rtc_time. One which does msleep,
that can be called from process context (in drivers/char/rtc.c) and one that
can be called from interrupt context (i386 and x86_64 hpet time routines). Or 
same routine behaving differently depending on where it is called from.

And for the hpet rtc emulation routines it should be OK even if the time is 
slightly off and not exact. So, probably we should be able to force read
rtc even when update is in progress. That way we can avoid the busy loop.
Unless RTC returns grossly wrong time values while UIP flag is set. I need to
look at RTC specs to verify that.

Thanks,
Venki
