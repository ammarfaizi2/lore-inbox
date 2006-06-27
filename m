Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbWF0OkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWF0OkK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 10:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030188AbWF0OkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 10:40:10 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:59357 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1030184AbWF0OkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 10:40:07 -0400
Date: Tue, 27 Jun 2006 07:32:04 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       perfctr-devel <perfctr-devel@lists.sourceforge.net>,
       linux-ia64 <linux-ia64@vger.kernel.org>,
       perfmon <perfmon@napali.hpl.hp.com>,
       oprofile-list <oprofile-list@lists.sourceforge.net>
Subject: Re: 2.6.17.1 new perfmon code base, libpfm, pfmon available
Message-ID: <20060627143204.GC16417@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200606270159_MC3-1-C391-1A2A@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606270159_MC3-1-C391-1A2A@compuserve.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck,

On Tue, Jun 27, 2006 at 01:57:39AM -0400, Chuck Ebbert wrote:
> It works:
> 
> $ pfmon --system-wide -0 -e interrupts_masked_cycles,interrupts_taken --edge-mask 0,1 -t 10
> <session to end in 10 seconds>
> CPU0    16359 INTERRUPTS_MASKED_CYCLES
> CPU0     5006 INTERRUPTS_TAKEN
> 
> 5006 hardware interrupts in 10 seconds, 16359 interrupt-disable events ==>
> the kernel disabled interrupts 11353 times for critical sections.  To get
> useful results it looks like booting with idle=poll and disabling cpufreq
> is needed, though, since interrupts_masked_cycles (non-edge mode) counts
> even when the CPU is halted:

Yes, I think you need to be careful with the idle thread, some events may or
may not count when going low-power. I think it is best to avoid going
low-power for measurements. It is also useful for some measurements to
exclude the idle task, i.e., to get useful kernel execution. For that
you can use the --excl-idle option of pfmon.

> 
> $ pfmon --system-wide -0 -e interrupts_masked_cycles,cpu_clk_unhalted -t 10
> <session to end in 10 seconds>
> CPU0    352020255 INTERRUPTS_MASKED_CYCLES
> CPU0     65351172 CPU_CLK_UNHALTED
> 
> > > And is someone working on kernel profiling tools that use the perfmon2
> > > infrastructure on i386?  I'd like to see kernel-based profiling that lets
> > > you use something like the existing 'readprofile' to retrieve results.  This
> > > would be a lot better than the current timer-based profiling.
> > > 
> > You can do this on your athlon using pfmon already, you need to enable a
> > different sampling module. Here is an example:
> > 
> > $ pfmon --smpl-module=inst-hist -ecpu_clk_unhalted -k --long-smpl-period=100000 \
> >      --resolve-addr --system-wide --session-timeout=10
> 
> That produces no output except for column headings.  Thinking it was a problem with
> x86_64 32-bit support, I built a p6 version.  I tried both short and long
> periods on both systems with the same result:

I think this is an issue with the NMI setup. I have looked at the code and found
some problems. They wil be fixed in the next patch. I suspect that if you say nmi_watchdog=2
on the kernel cmdline, it will work.

I have added the following 3 patches.
Thanks.

> 
> perfmon: add Pentium II support (family 6 model 3 only.)
> 
> --- 2.6.17.1-d4-pfmon.orig/arch/i386/perfmon/perfmon_p6.c
> +++ 2.6.17.1-d4-pfmon/arch/i386/perfmon/perfmon_p6.c
> @@ -76,6 +76,9 @@ static int pfm_p6_probe_pmu(void)
>  	}
>  
>  	switch(cpu_data->x86_model) {
> +		case 3:
> +			PFM_INFO("Pentium II PMU detected");
> +			break;
>  		case 7 ... 11:
>  			PFM_INFO("P6 core PMU detected");
>  			break;
> _
> 
> libpfm: Add Pentium II support (family 6 model 3 only.)
> 
> --- libpfm-3.2-060621.orig/lib/pfmlib_i386_p6.c
> +++ libpfm-3.2-060621/lib/pfmlib_i386_p6.c
> @@ -136,6 +136,7 @@ pfm_i386_p6_detect(void)
>  		return PFMLIB_ERR_NOTSUPP;
>  
>  	switch(model) {
> +		case 3: /* Pentium II */
>  		case 7: /* Pentium III Katmai */
>  		case 8: /* Pentium III Coppermine */
>  		case 9: /* Mobile Pentium III */
> _
> 
> pfmon: don't build gen_ia32 sample module if not configured.
> 
> --- pfmon-3.2-060621.orig/pfmon/pfmon_smpl.c
> +++ pfmon-3.2-060621/pfmon/pfmon_smpl.c
> @@ -61,6 +61,8 @@ static pfmon_smpl_module_t *smpl_modules
>  #endif
>  #ifdef CONFIG_PFMON_I386_P6
>  	&detailed_i386_p6_smpl_module, /* must be first for P6 */
> +#endif
> +#ifdef CONFIG_PFMON_GEN_IA32
>  	&detailed_gen_ia32_smpl_module, /* must be last for I386 */
>  #endif
>  	&inst_hist_smpl_module,		/* works for any PMU model */

-- 

-Stephane
