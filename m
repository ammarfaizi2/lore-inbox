Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262635AbUKLWR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbUKLWR2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 17:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262641AbUKLWR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 17:17:27 -0500
Received: from mail.aei.ca ([206.123.6.14]:45507 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S262635AbUKLWQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 17:16:41 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-1
From: Shane Shrybman <shrybman@aei.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Amit Shah <amit.shah@codito.com>
In-Reply-To: <20041112201334.GA14785@elte.hu>
References: <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu>
	 <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu>
	 <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu>
	 <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu>
	 <20041111215122.GA5885@elte.hu> <1100269881.10971.6.camel@mars>
	 <20041112201334.GA14785@elte.hu>
Content-Type: text/plain
Message-Id: <1100297757.4831.4.camel@mars>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 12 Nov 2004 17:15:58 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-12 at 15:13, Ingo Molnar wrote:
> * Shane Shrybman <shrybman@aei.ca> wrote:
> 
> > V0.7.25-1 has been stable here with the ivtv driver for 11 hrs. No
> > sign of the ide dma time out issue either. Out of curiosity, do we
> > know what solved that problem?
> 
> could you try the attached patch - does it trigger the DMA timeouts
> again? There were 3 changes to the IOAPIC code that could have affected
> your dma-timeout problem, this patch reverts all of them.
> 

Yes it does trigger the DMA timeouts again. Just the addition of
CONFIG_SMP dep is enough to trigger it. Which isn't surprising since
the hack was to put #if 0 there wasn't it?

> Mark's suggestion sounds quite plausible too - but the question is, your
> timeout problems went away previously by tweaking io_apic.c, so it would
> be nice to see that they are still gone even with the old 'broken'
> io_apic.c logic. (none of the io_apic.c changes fixes any particular
> bug, they are only latency optimizations, so i'd be surprised if they
> really impacted your timeout problems.)
> 
> if the DMA timeouts are still gone even with this patch applied then i
> think it's safe to conclude that Mark's explanation is the correct one,
> and that it was starvation of the SCHED_OTHER IDE irq-thread that caused
> the timeouts: it _really_ was a timeout. (a workaround would be to make
> the timeout longer)
> 
> 	Ingo
> 
> --- linux/arch/i386/kernel/io_apic.c.orig2	
> +++ linux/arch/i386/kernel/io_apic.c	
> @@ -150,7 +150,7 @@ static void update_io_apic_cache(unsigne
>  	}
>  }
>  
> -#define IOAPIC_CACHE
> +// #define IOAPIC_CACHE
>  /*
>   * Some systems need a POST flush or else level-triggered interrupts
>   * generate lots of spurious interrupts due to the POST-ed write not
> @@ -188,7 +188,7 @@ static void __modify_IO_APIC_irq (unsign
>  		/*
>  		 * Force POST flush by reading:
>  	 	 */
> -		reg = *(IO_APIC_BASE(entry->apic)+4);
> +		reg = io_apic_read(entry->apic, 0x10 + pin*2);
>  #endif
>  		if (!entry->next)
>  			break;
> @@ -1940,7 +1940,7 @@ static unsigned int startup_level_ioapic
>   * unacked local APIC is dangerous on SMP as it can prevent the
>   * delivery of IPIs and can thus cause deadlocks.)
>   */
> -#if defined(CONFIG_PREEMPT_HARDIRQS) && defined(CONFIG_SMP)
> +#if defined(CONFIG_PREEMPT_HARDIRQS)
>  
>  static void mask_and_ack_level_ioapic_irq(unsigned int irq)
>  {
> 

shane

