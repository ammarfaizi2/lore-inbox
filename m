Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266585AbUHSQQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266585AbUHSQQe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 12:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266590AbUHSQQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 12:16:34 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:8697 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266585AbUHSQQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 12:16:30 -0400
Message-ID: <4124D25C.20703@acm.org>
Date: Thu, 19 Aug 2004 11:16:28 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Patch to 2.6.8.1-mm2 to allow multiple NMI handlers to be registered
References: <4124BACB.30100@acm.org> <16676.51035.924323.992044@alkaid.it.uu.se>
In-Reply-To: <16676.51035.924323.992044@alkaid.it.uu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:

>Corey Minyard writes:
> > +static int k7_watchdog_reset(int handled)
> > +{
> > +	unsigned int low, high;
> > +	int          source;
> > +
> > +	rdmsr(MSR_K7_PERFCTR0, low, high);
>
>Please use rdpmc() instead of rdmsr() when reading counter registers.
>Ditto in the other places.
>(I know oprofile doesn't, but that's no excuse.)
>  
>
Ok, no problem.

> > +	/* 
> > +	 * If the timer has overflowed, this is certainly a watchdog
> > +	 * source
> > +	 */
> > +	source = (low & (1 << 31)) == 0;
> > +	if (source)
>
>Why not "if ((int)low >= 0)"?
>  
>
IIRC, the docs state that timer goes off if the high bit is cleared in 
the register.  I was just going with the documentation description.  Not 
a big deal either way, I don't think.

> > +	/*
> > +	 * The only thing that SHOULD be before us is the oprofile
> > +	 * code.  If it has handled an NMI, then we shouldn't.  This
> > +	 * is a rather unnatural relationship, it would much better to
> > +	 * build a perf-counter handler and then tie both the
> > +	 * watchdog and oprofile code to it.  Then this ugliness
> > +	 * could go away.
> > +	 */
>
>Depending on the value of nmi_watchdog and how oprofile was
>set up, neither, just one, or both of them can cause NMIs.
>Only one of them can do it via the performance counters, however.
>  
>
For nmi_watchdog=1, I can come from both the performance counters and 
the IOAPIC only if they both go off at almost exactly the same time 
(there is only one edge for both).  Otherwise, the oprofile code can 
tell if it is the source, and it will return if it handled it or not.  
The race is small, but there.  I guess I might have to implement the 
ugliness I describe below.

>How do you handle multiple simultaneous NMIs from different sources?
>  
>
That's why the current NMI hardware sucks so bad.  In general, you 
cannot tell easily.  However, you can tell if the NMI came from at least 
the NMI watchdog if nmi_watchdog=2.  And you can usually tell if it was 
an ECC error or I/O error.  I'm working on getting things changed in 
IPMI to be able to tell if one came from IPMI.  At OLS, we talked about 
this for a while and people are going to start trying to push the 
hardware vendors to improve the NMI hardware so the source can always be 
known.  So things are not perfect, but I believe they are usable.

You cannot tell (well, I think you can, but it would be tricky*) if the 
NMI came from the nmi_watchdog=1 (IOAPIC) because that requires claiming 
a lock to look at the timer registers.  You cannot claim locks in an 
NMI, at least not general locks.  Other sources depend on the capability 
of the hardware.

Thanks,

-Corey

* If the processor has compare-and-swap (486 and newer do, I believe), 
you can create an "processor-owned" lock that you can atomically claim 
and set ownership of.  With that, the NMI handler could could first 
check and see if the processor it was running on owned the lock, and do 
the appropriate thing if it did.  Otherwise it could claim the spinlock 
normally.  Ugly, but possible.
