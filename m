Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbUKOBH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbUKOBH6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 20:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbUKOBH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 20:07:58 -0500
Received: from fsmlabs.com ([168.103.115.128]:17028 "EHLO musoma.fsmlabs.com")
	by vger.kernel.org with ESMTP id S261413AbUKOBHq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 20:07:46 -0500
Date: Sun, 14 Nov 2004 18:07:16 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andi Kleen <ak@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Intel thermal monitor for x86_64
In-Reply-To: <20041114081649.GA16795@wotan.suse.de>
Message-ID: <Pine.LNX.4.61.0411141801320.3754@musoma.fsmlabs.com>
References: <Pine.LNX.4.61.0411130629190.3062@musoma.fsmlabs.com>
 <20041114081649.GA16795@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Nov 2004, Andi Kleen wrote:

> On Sat, Nov 13, 2004 at 11:36:47AM -0700, Zwane Mwaikambo wrote:
> > Patch adds support for notification of overheating conditions on intel 
> > x86_64 processors. Tested on EM64T, test booted on AMD64.
> > 
> > Hardware courtesy of Intel Corporation
> 
> Did you actually execute the code by faking/forcing such a event? 

Forced the event ;)

> > +#if defined(CONFIG_X86_MCE_INTEL)
> > +ENTRY(thermal_interrupt)
> > +	apicinterrupt THERMAL_APIC_VECTOR,smp_thermal_interrupt
> > +#endif
> 
> Cleaner would be probably to add a weak dummy smp_thermal_interrupt
> in traps.c and drop all the ifdefs.

Ok i can do that, weak functions tend to get different reactions from 
different people, so i rarely use them in submitted code.

> Maybe this should be made a different taint bit? 

Hmm, i'm not sure, if the cpu trips the overheating condition the other 
components may not be running within specification either. I think let's 
be cautious and just set the taint bit.

> > +	} else {
> > +		cpu_clear(smp_processor_id(), cpu_thermal_status);
> > +	}
> > +
> > +	if (time_after(jiffies, next_thermal_check))
> > +		tasklet_schedule(&thermal_tasklet);
> 
> I think there is actually a better way to do this (sorry for telling
> you late, but I also only realized it later). Can you just make
> the thermal APIC interrupt non NMI? Then the normal locking rules
> apply and printk should work directly. 

It's not actually an NMI, it's delivered via FIXED delivery mode and is 
maskable. I thought you had some sort of aversion towards using printk 
within that context.

> Also can you at least additionally log an synthetic event using mce_log() ?
> This way someone collecting these log entries centrally get its it 
> all in the same log file. 

Ok, then i think we need to make the mce logging capable of storing 
extended information, is the code i did for i386 ok with you?

Thanks,
	Zwane

