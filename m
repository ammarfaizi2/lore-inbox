Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946171AbWKJJ2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946171AbWKJJ2E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 04:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946187AbWKJJ2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 04:28:03 -0500
Received: from mx1.suse.de ([195.135.220.2]:47331 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1946171AbWKJJ2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 04:28:01 -0500
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 13/19] GTOD: Mark TSC unusable for highres timers
Date: Fri, 10 Nov 2006 10:27:43 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de,
       john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>
References: <20061109233030.915859000@cruncher.tec.linutronix.de> <20061110005020.4538e095.akpm@osdl.org> <20061110085728.GA14620@elte.hu>
In-Reply-To: <20061110085728.GA14620@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611101027.43744.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 November 2006 09:57, Ingo Molnar wrote:
> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > If so, could that function use the PIT/pmtimer/etc for working out if 
> > the TSC is bust, rather than directly using jiffies?
> 
> there's no realiable way to figure out the TSC is bust: some CPUs have a 
> slight 'skew' between cores for example. 

We find this out by black listing them. I got that working reliably as far as I know.

The main cases I know where we can't use it right now is:
- AMD >1 core
* when clock ramping is disabled it gets a little better, but on multi socket
it is still broken
* also it varies in frequency here which has to be handled
+ There is a little issue here that the frequency takes some unpredictible 
time to stabilize after the frequency change. AFAIK the error is too small
to cause problems though.
- Some Intel NUMA systems (IBM x4xx, Unisys ES7000, ScaleMP) 
* handled by detecting multiple Apic Clusters
- Intel systems with C3
* stops in C3. disable here
- a few P4 dual cores seem to lose TSC synchronization when overclocked
(or most likely overvolted) and running out of Spec
* I chose to ignore this case. User fault. They can set command line options.
- We had one Intel BIOS which misprogrammed the FSB dividers
* Got fixed by BIOS update. Also it was a obscure case that can be handled
with command line options.

I don't see how this is changing much with dyntimers. The only
difference that should be there is that you require TSC stability for
a longer time (instead of only HZ), but normally when the TSC is instable
it already causes trouble in the current setup.

You're probably overreacting to something. Maybe one of the old bugs?
(I had a typo in the Intel C3 detection for a long time that broke
a lot of Intel laptops) 

> On some systems the TSC might  
> skew between sockets. A CPU might break its TSC only once some 
> powersaving mode has been activated - which might be long after bootup. 
> The whole TSC business is a nightmare and cannot be supported reliably.

I disagree. 

> AFAIK Windows doesnt use it, so it's a continuous minefield for new 
> hardware to break.

Not true.
 
> We should wait until CPU makers get their act together and implement a 
> TSC variant that is /architecturally promised/ to have constant 
> frequency (system bus frequency or whatever) 

Intel already has that (modulo totally broken BIOS and overclocking). 
TSC is running always at highest P-state and usually synchronized too.

AMD is getting there.

> and which never stops. 

That's unrealistic unfortunately any time soon.  All the CPU vendors
are pushing for much more aggressive power saving and this basically 
means turning off the CPU completely in the deeper sleep states.

-Andi

 
