Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbUCJLcw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 06:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbUCJLcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 06:32:52 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:59789 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262027AbUCJLcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 06:32:47 -0500
Date: Wed, 10 Mar 2004 12:32:46 +0100
From: Pavel Machek <pavel@suse.cz>
To: Bruno Ducrot <ducrot@poupinou.org>
Cc: patches@x86-64.org, kernel list <linux-kernel@vger.kernel.org>,
       Cpufreq mailing list <cpufreq@www.linux.org.uk>, davej@redhat.com
Subject: Re: powernow-k8 updates
Message-ID: <20040310113246.GA4775@atrey.karlin.mff.cuni.cz>
References: <20040309214830.GA1240@elf.ucw.cz> <20040310110941.GC28592@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310110941.GC28592@poupinou.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > --- clean/arch/i386/kernel/cpu/cpufreq/Kconfig	2004-02-05 01:53:54.000000000 +0100
> > +++ linux/arch/i386/kernel/cpu/cpufreq/Kconfig	2004-03-03 23:07:26.000000000 +0100
> > @@ -93,6 +93,19 @@
> >  	depends on CPU_FREQ && EXPERIMENTAL
> >  	help
> >  	  This adds the CPUFreq driver for mobile AMD Opteron/Athlon64 processors.
> > +	  It relies on old "PST" tables. Unfortunately, many BIOSes get this table
> > +	  wrong. 
> > +
> > +	  For details, take a look at linux/Documentation/cpu-freq. 
> > +
> > +	  If in doubt, say N.
> > +
> > +config X86_POWERNOW_K8_ACPI
> > +	tristate "AMD Opteron/Athlon64 PowerNow! using ACPI"
> > +	depends on CPU_FREQ && EXPERIMENTAL
> 
> Why there is no dependency with ACPI here?

I'll fix that.

> > +/*
> > + * Each processor may have
> > + * a different number of entries in its array. I.e., processor 0 may have
> > + * 3 pstates, processor 1 may have 5 pstates.
> > + */
> 
> No.  That will break current ACPI v2.0c specification.  All processors
> shall have the same number of states.  More, they have to support the
> same set of pairs of frequency/power consuption.
> 
> If that is not acceptable by AMD, then you have to contact ACPI SIG
> at <http://www.acpi.info/> in order to change specs.

Notice that amd's powernow is done through acpi, but does not comply
to the acpi specs. That should be okay; in such case its up to AMD to
define how it behaves.


> For the last time, why on earth you still do not consider the ACPI
> perflib.  Links to the cpufreq-developper mailing list with even a kind
> of public access have been posted.  That will eliminate the following
> functions amongst other things.  Look at drivers/acpi/processor.c

I see that file. It seems to be full of northbridge bugs workarounds,
and seems to be handling processor C states. It handles powernow
states on machines that do it through acpi. I do not see how I could
use it, and I do not see how query_ac could disappear. It might be
nice to use same processor/.../performance interface, but it is
deprecated anyway. 

What do I miss?


> > +static u32 query_ac(void)
> > +{
> > +	acpi_status rc;
> > +	unsigned long state;
> > +
> > +	if (psrh) {
> > +		rc = acpi_evaluate_integer(psrh, NULL, NULL, &state);
> > +		if (ACPI_SUCCESS(rc)) {
> > +			if (state == 1)
> > +				return POW_AC;
> > +			else if (state == 0)
> > +				return POW_BAT;
> > +			else
> > +				printk(EFX "psr state %lx\n", state);
> > +		}
> > +		else {
> > +			printk(EFX "error %x evaluating psr\n", rc );
> > +		}
> > +	}
> > +	return POW_UNK;
> > +}
> > +
> > +/* gives us the (optional) battery/thermal restrictions */
> > +static int process_ppc(acpi_handle objh)
> > +{
> > +	acpi_status rc;
> > +	unsigned long state;
> > +
> > +	if (objh) {
> > +		ppch = objh;
> > +	} else {
> > +		if (ppch) {
> > +			objh = ppch;
> > +		} else {
> > +			rstps = 0;
> > +			return 0;   
> > +		}
> > +	}
> > +
> > +	if (num_online_cpus() > 1) {
> > +		/* For future thermal support (next release?), rstps needs   */
> > +		/* to be per processor, and handled for the SMP case. Later. */
> > +		dprintk(EFX "ignoring attempt to restrict pstates for SMP\n");
> > +	}
> > +	else {
> > +		rc = acpi_evaluate_integer(objh, NULL, NULL, &state);
> > +		if (ACPI_SUCCESS(rc)) {
> > +			rstps = state & 0x0f;
> > +			//dprintk(DFX "pstate restrictions %x\n", rstps);
> > +			if (!seenrst)
> > +				seenrst = rstps;
> > +		}
> > +		else {
> > +			rstps = 0;
> > +			printk(EFX "error %x processing ppc\n", rc);
> > +			return -ENODEV;
> > +		}
> > +	}
> > +	return 0;
> > +}
> 

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
