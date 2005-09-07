Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbVIGSPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbVIGSPV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 14:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbVIGSPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 14:15:21 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:31646 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932179AbVIGSPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 14:15:19 -0400
Date: Wed, 7 Sep 2005 23:44:45 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Tony Lindgren <tony@atomide.com>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       ck list <ck@vds.kolivas.org>, rmk+lkml@arm.linux.org.uk,
       schwidefsky@de.ibm.com
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050907181445.GD28387@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050904212616.B11265@flint.arm.linux.org.uk> <20050905053225.GA4294@in.ibm.com> <20050905054813.GC25856@us.ibm.com> <20050905063229.GB4294@in.ibm.com> <20050905064416.GD25856@us.ibm.com> <20050906205112.GA3038@us.ibm.com> <20050907081303.GC5804@atomide.com> <20050907155352.GD4590@us.ibm.com> <20050907170703.GA28387@in.ibm.com> <20050907172315.GB22849@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050907172315.GB22849@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2005 at 10:23:15AM -0700, Nishanth Aravamudan wrote:
> > > #define DYN_TICK_MIN_SKIP	2
> 
> Another point. Why is this 2? I guess if you're going to make it 2, why
> bother defining/checking it at all?

I think that should be arch-specific.


> > > 	void (*disable_dyn_tick) (void);
> > > 	unsigned long (*reprogram) (unsigned long); /* return number of ticks skipped */
> > 
> > How will it be able to return the number of ticks skipped? Or are you
> > referring to max_skip here?
> 
> Yes, maybe this can be a void function... I was thinking more along the
> lines of you can send whatever request you want to reprogram(), it does
> what it can with the request (cuts it short if too long, ignores it if
> too short) and then returns what it actually did.

Looks fine in that case to have a non-void return.

> > In x86-like architectures, there can be multiple ticksources that can
> > be simultaneously active - ex: APIC and PIT. So one
> > "current_ticksource" doesnt capture that fact?
> 
> Not really, though, right? Only one is registered to do the timer
> callbacks? 

True.

> So, for x86, if you use the PIT ticksource, you only need to
> be PIT aware, but if you use the APIC ticksource, then it needs to be
> aware of the APIC and PIT (I believe you mentioned they are tied to each
> other), but that's ticksource-specific. CMIIW, though, please.

I was going more by what meaning 'current_ticksource' may give - from
a pure "ticksource" perspective, both (PIT/APIC) are tick sources!
Thats why current_ticksource may not be a good term.

> Maybe you are right. I don't like having a separate struct for the
> state, though, and the dyn_tick_timer struct doesn't have a
> recover_time() style member. If you look closely, my structure is

I agree we can remove the separate struct for state and have
recover_time member. Although in x86, it may have to be a wrapper
around mark_offset() since mark_offset does not recover time
completely (it expect the callee to recover one remaining tick).

> basically exactly what the x86 work has, just some different names
> (don't need arch_ prefix, for instance, because it's clearly
> dyn_tick_timer specific, etc.) I also would like to hear from the s390
> folks about their issues/opinions.

Martin Schwidefsky (whom I have CC'ed) may be the person who can comment on 
behalf of s390.

> Yes, true. I'm wondering, do we need to make the
> current_ticksource/current_dyn_tick_timer per-CPU? I am just wondering
> how to gracefully handle the SMP case. Or is that not a problem?

I don't see that current_ticksource/current_dyn_tick_timer to be write-heavy.
In fact I see them to be initialied during bootup and after that mostly
read-only. That may not warrant a per-CPU structure.


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
