Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbUKOJSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbUKOJSe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 04:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbUKOJSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 04:18:34 -0500
Received: from news.suse.de ([195.135.220.2]:51111 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261558AbUKOJR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 04:17:27 -0500
Date: Mon, 15 Nov 2004 10:01:57 +0100
From: Andi Kleen <ak@suse.de>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Intel thermal monitor for x86_64
Message-ID: <20041115090156.GC1662@wotan.suse.de>
References: <Pine.LNX.4.61.0411130629190.3062@musoma.fsmlabs.com> <20041114081649.GA16795@wotan.suse.de> <Pine.LNX.4.61.0411141801320.3754@musoma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411141801320.3754@musoma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2004 at 06:07:16PM -0700, Zwane Mwaikambo wrote:
> On Sun, 14 Nov 2004, Andi Kleen wrote:
> 
> > On Sat, Nov 13, 2004 at 11:36:47AM -0700, Zwane Mwaikambo wrote:
> > > Patch adds support for notification of overheating conditions on intel 
> > > x86_64 processors. Tested on EM64T, test booted on AMD64.
> > > 
> > > Hardware courtesy of Intel Corporation
> > 
> > Did you actually execute the code by faking/forcing such a event? 
> 
> Forced the event ;)
> 
> > > +#if defined(CONFIG_X86_MCE_INTEL)
> > > +ENTRY(thermal_interrupt)
> > > +	apicinterrupt THERMAL_APIC_VECTOR,smp_thermal_interrupt
> > > +#endif
> > 
> > Cleaner would be probably to add a weak dummy smp_thermal_interrupt
> > in traps.c and drop all the ifdefs.
> 
> Ok i can do that, weak functions tend to get different reactions from 
> different people, so i rarely use them in submitted code.
> 
> > Maybe this should be made a different taint bit? 
> 
> Hmm, i'm not sure, if the cpu trips the overheating condition the other 
> components may not be running within specification either. I think let's 
> be cautious and just set the taint bit.
> 
> > > +	} else {
> > > +		cpu_clear(smp_processor_id(), cpu_thermal_status);
> > > +	}
> > > +
> > > +	if (time_after(jiffies, next_thermal_check))
> > > +		tasklet_schedule(&thermal_tasklet);
> > 
> > I think there is actually a better way to do this (sorry for telling
> > you late, but I also only realized it later). Can you just make
> > the thermal APIC interrupt non NMI? Then the normal locking rules
> > apply and printk should work directly. 
> 
> It's not actually an NMI, it's delivered via FIXED delivery mode and is 
> maskable. I thought you had some sort of aversion towards using printk 
> within that context.

No, I was just worried about the locking issues.  Ok it was my mistake
then I assume you used an NMI LVT setup. Without NMI using printk
is fine and simpler. Can you change it to do that directly? 

Putting events additionally into mcelog would be still nice though.

> > Also can you at least additionally log an synthetic event using mce_log() ?
> > This way someone collecting these log entries centrally get its it 
> > all in the same log file. 
> 
> Ok, then i think we need to make the mce logging capable of storing 
> extended information, is the code i did for i386 ok with you?

No, see my other mail for that.

for the thermtrips I would just redefine some fields and invent 
a magic high bank number.

-Andi
