Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbTIEVOq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 17:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbTIEVOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 17:14:46 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:50573 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263152AbTIEVOo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 17:14:44 -0400
Date: Fri, 5 Sep 2003 22:14:28 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH] idle using PNI monitor/mwait (take 2)
Message-ID: <20030905211428.GB6019@mail.jlokier.co.uk>
References: <7F740D512C7C1046AB53446D3720017304AF0D@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F740D512C7C1046AB53446D3720017304AF0D@scsmsx402.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nakajima, Jun wrote:
> We are doing this as defensive programming (because of bogus device
> drivers, for example), like the other idle routines (default_idle, and
> poll_idle) always do. 
> 
> BTW, I'm not sure that local_irq_disable() is really required below (as
> you know, "sti" is hiding in safe_halt()).
> 
> void default_idle(void)
> {
> 	if (!hlt_counter && current_cpu_data.hlt_works_ok) {
> =>		local_irq_disable();
> 		if (!need_resched())
> 			safe_halt();
> 		else
> 			local_irq_enable();
> 	}
> }


It isn't defensive.  The local_irq_disable() is needed to avoid a race
condition.  It was added to fix high latency spikes.

(A comment to that effect in default_idle would be nice).

Without it, after checking need_resched, that flag can be set by an
interrupt before we do "hlt".

The result is a halted CPU even though need_resched is set, and the
idle loop isn't broken until the next interrupt, often a timer tick.

The "sti" in safe_halt() is immediately before the "hlt", which means
it doesn't enable interrupts until after the "hlt" instruction.  This
means that any interrupt will wake the CPU.

local_irq_disable() isn't required in the monitor/mwait loop, because
you check need_resched between the monitor and mwait.  (If Intel had
implemented monitor+mwait as a single instruction, then you'd need it).

So you can remove it from your loop.

Enjoy :)
-- Jamie

