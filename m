Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbUKRSDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbUKRSDh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 13:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbUKRSC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 13:02:26 -0500
Received: from fsmlabs.com ([168.103.115.128]:22243 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261846AbUKRR7C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 12:59:02 -0500
Date: Thu, 18 Nov 2004 10:58:46 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andi Kleen <ak@suse.de>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Intel thermal monitor for x86_64 (updated)
In-Reply-To: <20041118163309.GK17532@wotan.suse.de>
Message-ID: <Pine.LNX.4.61.0411181053410.4034@musoma.fsmlabs.com>
References: <Pine.LNX.4.61.0411180652330.7187@musoma.fsmlabs.com>
 <20041118163309.GK17532@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2004, Andi Kleen wrote:

> On Thu, Nov 18, 2004 at 08:49:47AM -0700, Zwane Mwaikambo wrote:
> > diff -u -p -B -r1.1.1.1 mce.h
> > --- linux-2.6.10-rc1-mm5/include/asm-x86_64/mce.h	11 Nov 2004 17:21:48 -0000	1.1.1.1
> > +++ linux-2.6.10-rc1-mm5/include/asm-x86_64/mce.h	18 Nov 2004 13:18:38 -0000
> > @@ -64,4 +64,16 @@ struct mce_log { 
> >  #define MCE_GET_LOG_LEN      _IOR('M', 2, int)
> >  #define MCE_GETCLEAR_FLAGS   _IOR('M', 3, int)
> >  
> > +#define MCE_EXTENDED_BANK	20
> 
> But better use a higher bank (128 or somesuch). It wouldn't surprise
> me if Intel did something similar to their MCE architecture as 
> they did for their performance counters, and then 20 banks 
> in the hardware would be quite possible.

Will do.

> > +	static cpumask_t logged_cpus;
> > +	static unsigned long next_check[NR_CPUS];
> 
> Use per cpu data for this. 

I can do that, doesn't per_cpu do cacheline alignment? I was trying to 
avoid allocating more space.

> > +	/* Only log the first overheat condition, these can be spurious whilst
> > +	 * the Thermal Control Circuitry attempts to drop the temperature.
> > +	 */
> > +	if (!cpu_isset(m.cpu, logged_cpus)) {
> > +		cpu_set(m.cpu, logged_cpus);
> > +		mce_log(&m);
> > +	}
> 
> Does the comment match the code? I guess you mean the following
> events after the first can be bogus.
> 
> It seems a bit bogus to printk but not log for known spurious 
> conditions.

Well by spurious i mean that there will be a _lot_ of these events whilst 
the TCC attempts to reduce the processor temperature, i don't want to 
flood the mce log with the subsequent events.

> Also the next_check logic should already handle this I guess,
> becaumse I assume the temperature dropping won't take
> that long.  So I guess it would be best to drop that 
> and if it's still a problem use a longer next_check timeout
> of several seconds.

The temperature drop can take a while, i've observed 2-3 minutes if the 
processor is also loaded and the ambient temperature is low (20C). So you 
could lose 12 or so slots in the mce log due to the temperature ping 
ponging.

Thanks,
	Zwane
