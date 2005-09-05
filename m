Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbVIEIcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbVIEIcb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 04:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbVIEIcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 04:32:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31503 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932295AbVIEIca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 04:32:30 -0400
Date: Mon, 5 Sep 2005 09:32:21 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050905093221.E24051@flint.arm.linux.org.uk>
Mail-Followup-To: Srivatsa Vaddagiri <vatsa@in.ibm.com>,
	Nishanth Aravamudan <nacc@us.ibm.com>,
	Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
	akpm@osdl.org, ck list <ck@vds.kolivas.org>
References: <20050831165843.GA4974@in.ibm.com> <200509031801.09069.kernel@kolivas.org> <20050903090650.B26998@flint.arm.linux.org.uk> <200509031814.49666.kernel@kolivas.org> <20050904201054.GA4495@us.ibm.com> <20050905070053.GA7329@in.ibm.com> <20050905084425.B24051@flint.arm.linux.org.uk> <20050905081935.GB7924@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050905081935.GB7924@in.ibm.com>; from vatsa@in.ibm.com on Mon, Sep 05, 2005 at 01:49:35PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 01:49:35PM +0530, Srivatsa Vaddagiri wrote:
> This is precisely what I have done. I have made cur_timer->mark-offset() to 
> return the lost ticks and update wall-time from the callee, which
> can be either timer_interrupt handler or in dyn-tick case the dyn-tick
> code (I have called it dyn_tick_interrupt) which is called before processing 
> _any_ interrupt.

When you have a timer which constantly increments from 0 to MAX and
wraps, and you can set the value to match to cause an interrupt,
it makes more sense to handle it the way we're doing it (which
incidentally leads to no loss of precision.)

Calculating the number of ticks missed, updating the kernel time,
and updating the timer match will cause problems with these - if
the timer has already past the number of ticks you originally
calculated, you may not get another interrupt for a long time.

So I don't actually think that your proposal will work for these
(SA11x0 and PXA).

> If ARM had a timer_opts equivalent we could have followed 

I think your timer_opts is effectively our struct sys_timer.

>                         int lost;
> 
>                         lost = cur_timer->mark_offset();
>                         if (lost)
>                                 do_timer(regs);

This seems to only recover one tick.  What if multiple ticks were lost?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
