Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbVJYO2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbVJYO2l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 10:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbVJYO2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 10:28:40 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:31126 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932162AbVJYO2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 10:28:40 -0400
Date: Tue, 25 Oct 2005 16:28:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rc5-rt6  -- False NMI lockup detects
Message-ID: <20051025142848.GA7642@elte.hu>
References: <1130250219.21118.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130250219.21118.11.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Hi Ingo and Thomas,
> 
> On some of my machines, I've been experiencing false NMI lockups.  
> This usually happens on slower machines, and taking a look into this, 
> it seems to be due to a short time where no processes are using 
> timers, and the ktimer interrupts aren't needed. So the APIC timer, 
> which now is used only for the ktimers, has a five second pause, and 
> causes the NMI to go off.  The NMI uses the apic timer to determine 
> lockups.

this would be a bug - the jiffy tick should be processed every 1 msec, 
regardless of whether there are any ktimers pending. (in the future we 
want to use a special ktimer for the jiffy tick, but that's not 
implemented yet.)

> So, I added a more generic method. This only works for x86 for now, 
> but it has a #ifdef to keep other archs working until it implements 
> this as well.  I added a nmi_irq_incr which is called by __do_IRQ in 
> the generic code.  This is what is used in the NMI code to determine 
> if the CPU has locked up.  This way we don't have to worry about what 
> resource we are using for timers.

this will be useful for tickless stuff - but right now 'no APIC timer 
irq for 5 seconds' is a 'must not happen'.

	Ingo
