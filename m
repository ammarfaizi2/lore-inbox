Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758958AbWK2XNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758958AbWK2XNp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 18:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758959AbWK2XNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 18:13:45 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:54226 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1758957AbWK2XNo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 18:13:44 -0500
Date: Wed, 29 Nov 2006 15:15:07 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rt] 2.6.19-4c6-rt9 build problem
Message-ID: <20061129231507.GG2335@us.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20061129194821.GA2895@us.ibm.com> <20061129200307.GA11591@elte.hu> <20061129224451.GC2335@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129224451.GC2335@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2006 at 02:44:52PM -0800, Paul E. McKenney wrote:
> On Wed, Nov 29, 2006 at 09:03:07PM +0100, Ingo Molnar wrote:
> >
> > * Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> >
> > > Hello!
> > >
> > > Got a compiler error building 1.6.19-rc6-rt9 on NUMA-Q, admittedly
> > > with unusual config.  The patch below solves it, though I cannot say
> > > that I am an ACPI expert.
> >
> > thanks, applied. Have you tried to boot the resulting kernel as well?

And with these two changes, it does boot!

							Thanx, Paul

> Hit another build error.  :-/
> 
> The following combined (crude) patch makes the build succeed.  Rebooting now,
> with fingers firmly crossed...
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
>  include/linux/acpi_pmtmr.h |    2 ++
>  mm/page_alloc.c            |    2 ++
>  2 files changed, 4 insertions(+)
> 
> diff -urpNa -X dontdiff linux-2.6.19-rc6-rt9/include/linux/acpi_pmtmr.h linux-2.6.19-rc6-rt9.tscbug/include/linux/acpi_pmtmr.h
> --- linux-2.6.19-rc6-rt9/include/linux/acpi_pmtmr.h	2006-11-28 17:21:55.000000000 -0800
> +++ linux-2.6.19-rc6-rt9.tscbug/include/linux/acpi_pmtmr.h	2006-11-29 08:09:07.000000000 -0800
> @@ -27,6 +27,8 @@ static inline u32 acpi_pm_read_early(voi
> 
>  #else
> 
> +#define pmtmr_ioport 0
> +
>  static inline u32 acpi_pm_read_early(void)
>  {
>  	return 0;
> diff -urpNa -X dontdiff linux-2.6.19-rc6-rt9/mm/page_alloc.c linux-2.6.19-rc6-rt9.tscbug/mm/page_alloc.c
> --- linux-2.6.19-rc6-rt9/mm/page_alloc.c	2006-11-28 17:21:56.000000000 -0800
> +++ linux-2.6.19-rc6-rt9.tscbug/mm/page_alloc.c	2006-11-29 14:14:09.000000000 -0800
> @@ -2790,7 +2790,9 @@ static int page_alloc_cpu_notify(struct
>  		__lock_cpu_pcp(&flags, cpu);
>  		WARN_ON_ONCE(cpu == raw_smp_processor_id());
> 
> +#ifdef CONFIG_PM
>  		__drain_pages(cpu);
> +#endif /* #ifdef CONFIG_PM */
>  		vm_events_fold_cpu(cpu);
>  		refresh_cpu_vm_stats(cpu);
>  		unlock_cpu_pcp(flags, cpu);
