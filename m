Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267395AbTAQFrJ>; Fri, 17 Jan 2003 00:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267394AbTAQFrJ>; Fri, 17 Jan 2003 00:47:09 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:12812
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267395AbTAQFrH>; Fri, 17 Jan 2003 00:47:07 -0500
Date: Fri, 17 Jan 2003 00:56:32 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, <mingo@elte.hu>, <rml@tech9.net>
Subject: Re: [PATCH][2.5] smp_call_function_mask
In-Reply-To: <20030116214424.037f57aa.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0301170051480.24250-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2003, Andrew Morton wrote:

> Zwane Mwaikambo <zwane@holomorphy.com> wrote:
> >
> > This patch adds a smp_call_function which also accepts a cpu mask which is 
> > needed for targetting specific or groups of cpus.
> 
> What is it needed for?

I need to interrupt a specific cpu to initiate a cpu offline process.

> > Index: linux-2.5.58-cpu_hotplug/arch/i386/kernel/smp.c
> 
> ia32 only?

I'll try my best with the other archs. I can hack and rediff.

> > +int smp_call_function_mask (void (*func) (void *info), void *info, int nonatomic,
> > +			int wait, unsigned long mask)
> > +/*
> > + * [SUMMARY] Run a function on specific CPUs, save self.
> > + * <func> The function to run. This must be fast and non-blocking.
> > + * <info> An arbitrary pointer to pass to the function.
> > + * <nonatomic> currently unused.
> > + * <wait> If true, wait (atomically) until function has completed on other CPUs.
> > + * <mask> The bitmask of CPUs to call the function
> > + * [RETURNS] 0 on success, else a negative status code. Does not return until
> > + * remote CPUs are nearly ready to execute <<func>> or are or have executed.
> > + *
> > + * You must not call this function with disabled interrupts or from a
> > + * hardware interrupt handler or from a bottom half handler.
> > + */
> 
> Please don't invent new coding styles.  The comment block goes outside the
> function.  Nice comment block though.

No credit to me, ripped from smp_call_function, i'll switch to docbook 
version.

> > +{
> > +	struct call_data_struct data;
> > +	int num_cpus = hweight32(mask);
> > +
> > +	if (num_cpus == 0)
> > +		return -EINVAL;
> > +
> > +	if ((1UL << smp_processor_id()) & mask)
> > +		return -EINVAL;
> 
> Preempt safety?

Good point, i think a get_cpu and put_cpu_no_resched should suffice.

	Zwane
-- 
function.linuxpower.ca

