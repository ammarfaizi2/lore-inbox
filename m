Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbUKRVSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbUKRVSs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 16:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbUKRVQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 16:16:59 -0500
Received: from news.suse.de ([195.135.220.2]:26046 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261167AbUKRVPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 16:15:32 -0500
Date: Thu, 18 Nov 2004 21:01:43 +0100
From: Andi Kleen <ak@suse.de>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Intel thermal monitor for x86_64 (updated)
Message-ID: <20041118200143.GP17532@wotan.suse.de>
References: <Pine.LNX.4.61.0411180652330.7187@musoma.fsmlabs.com> <20041118163309.GK17532@wotan.suse.de> <Pine.LNX.4.61.0411181053410.4034@musoma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411181053410.4034@musoma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 10:58:46AM -0700, Zwane Mwaikambo wrote:
> > > +	static unsigned long next_check[NR_CPUS];
> > 
> > Use per cpu data for this. 
> 
> I can do that, doesn't per_cpu do cacheline alignment? I was trying to 
> avoid allocating more space.

Not for individual data items, no. It would be completely useless because 
only the same CPUs are sharing data there.

> > > +	if (!cpu_isset(m.cpu, logged_cpus)) {
> > > +		cpu_set(m.cpu, logged_cpus);
> > > +		mce_log(&m);
> > > +	}
> > 
> > Does the comment match the code? I guess you mean the following
> > events after the first can be bogus.
> > 
> > It seems a bit bogus to printk but not log for known spurious 
> > conditions.
> 
> Well by spurious i mean that there will be a _lot_ of these events whilst 
> the TCC attempts to reduce the processor temperature, i don't want to 
> flood the mce log with the subsequent events.


Flooding the kmsg is as bad.

I think a better strategy is to just increase the minimum check interval
to avoid this. And then treat printk and mce_log the same.

> 
> > Also the next_check logic should already handle this I guess,
> > becaumse I assume the temperature dropping won't take
> > that long.  So I guess it would be best to drop that 
> > and if it's still a problem use a longer next_check timeout
> > of several seconds.
> 
> The temperature drop can take a while, i've observed 2-3 minutes if the 
> processor is also loaded and the ambient temperature is low (20C). So you 
> could lose 12 or so slots in the mce log due to the temperature ping 
> ponging.

Ok then perhaps a extremly long check timeout of 5 minutes? 

-Andi
