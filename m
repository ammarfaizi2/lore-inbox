Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263046AbVHES7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263046AbVHES7o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 14:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262824AbVHES7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 14:59:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7856 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263046AbVHESyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 14:54:49 -0400
Date: Fri, 5 Aug 2005 11:53:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Shaohua Li <shaohua.li@intel.com>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH 2.6.13-rc5-gitNOW] msleep() cannot be used from
 interrupt
Message-Id: <20050805115329.45889ef8.akpm@osdl.org>
In-Reply-To: <20050805135007.GA6985@vana.vc.cvut.cz>
References: <20050805135007.GA6985@vana.vc.cvut.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec <vandrove@vc.cvut.cz> wrote:
>
> Since beginning of July my Opteron box was randomly crashing and being rebooted
>  by hardware watchdog.  Today it finally did it in front of me, and this patch
>  will hopefully fix it.
> 
>  Problem is that at the end of June (28th, commit 
>  47f176fdaf8924bc83fddcf9658f2fd3ef60d573, [PATCH] Using msleep() instead of HZ) 
>  rtc_get_rtc_time was converted to use msleep() instead of busy waiting.  But
>  rtc_get_rtc_time is used by hpet_rtc_interrupt, and scheduling is not allowed
>  during interrupt.  So I'm reverting this part of original change, replacing
>  msleep() back with busy loop.
> 
>  Original old code was busy waiting for 20ms, while on my hardware in the worst
>  case update-in-progress bit was asserted for at most 363 passes through loop
>  (on 2GHz dual Opteron), much less than even one jiffie, not even talking
>  about 20ms.  So I changed code to just wait only as long as necessary.  Otherwise
>  when RTC was set to generate 8192Hz timer, it stopped doing anything for
>  20ms (160 pulses were skipped!) from time to time, and this is rather suboptimal
>  as far as I can tell.

That's all pretty sad stuff.  I guess for now we can go back to the busy
loop.  Longer-term it would be nice if we could tune up the HPET driver in
some manner so we can avoid this busy-wait-in-interrupt.

I'm not sure who the HPET maintainer/expert is nowadays.  Robert Picco did
the original work but I haven't seen Robert around for a long time?
