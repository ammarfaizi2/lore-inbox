Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbUFPPPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbUFPPPU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 11:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbUFPPPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 11:15:20 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:33200 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S262388AbUFPPPP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 11:15:15 -0400
Date: Wed, 16 Jun 2004 17:15:44 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: Andi Kleen <ak@suse.de>
Cc: johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: lost timer check in 2.6.7
Message-ID: <20040616151544.GA14773@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	Andi Kleen <ak@suse.de>, johnstul@us.ibm.com,
	linux-kernel@vger.kernel.org
References: <20040616131912.14b73b39.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040616131912.14b73b39.ak@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 01:19:12PM +0200, Andi Kleen wrote:
> 
> 2.6.7 has 
> 
> +               /* ... but give the TSC a fair chance */
> +               if (lost_count > 25)
> +                       cpufreq_delayed_get();
> 
> While looking at porting this code to x86-64 I noticed that this only runs for 
> the first lost timer event.

Not exactly: lost_count is increased for every "tick" where lost ticks are
detected, but re-set anytime there is no lost tick.

> In case of dynamic frequency which varies shouldn't this
> be more like
> 
> 		if ((lost_count % 25) == 0) 
> 			cpufreq_delayed_get();
> 
> ? Otherwise this heuristic will only work once.

So if this heuristic works, no more ticks will be lost (at least in the near
future), so lost_count will be set to zero again. If, due to some new event,
ticks are lost again, lost_count will start at zero, reach 25 after some
time, and cpufreq_delayed_get() will be called again.

However: inaccuracies are only detected in _one_ direction: ticks being
missed, not "too many ticks" -- and only if it's a factor of two or
higher... Probably a better run-time check of the sanity of a timesource is
needed in future... on the other hand, frequencies shouldn't change behind
the kernel's back. That's what my other patch sent to the ACPI list a few
days ago (pstate_cnt) tries to address.

	Dominik
