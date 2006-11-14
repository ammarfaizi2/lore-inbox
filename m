Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933242AbWKNIXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933242AbWKNIXA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 03:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933227AbWKNIXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 03:23:00 -0500
Received: from mga05.intel.com ([192.55.52.89]:5247 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S933211AbWKNIW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 03:22:59 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,420,1157353200"; 
   d="scan'208"; a="15515867:sNHT22680540"
Subject: Re: [PATCH] Incorrect MSI interrupt type name
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, "Eric W. Biederman" <ebiederm@xmission.com>,
       LKML <linux-kernel@vger.kernel.org>,
       "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
In-Reply-To: <20061113234315.767f7516.akpm@osdl.org>
References: <1163488977.4311.52.camel@ymzhang-perf.sh.intel.com>
	 <20061113234315.767f7516.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1163492461.4311.60.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 14 Nov 2006 16:21:01 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-14 at 15:43, Andrew Morton wrote:
> On Tue, 14 Nov 2006 15:22:57 +0800
> "Zhang, Yanmin" <yanmin_zhang@linux.intel.com> wrote:
> 
> > /proc/interrupts shows "<NULL>" for MSI interrupt type name on
> > my ia64 machine.
> > 
> > Below patch against 2.6.19-rc5-mm1 fixes it.
> > 
> > Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>
> > 
> > ---
> > 
> > --- linux-2.6.19-rc5-mm1/arch/ia64/kernel/msi_ia64.c	2006-11-14 14:16:12.000000000 +0800
> > +++ linux-2.6.19-rc5-mm1_fix/arch/ia64/kernel/msi_ia64.c	2006-11-14 15:08:37.000000000 +0800
> > @@ -115,7 +115,7 @@ static int ia64_msi_retrigger_irq(unsign
> >   * Generic ops used on most IA64 platforms.
> >   */
> >  static struct irq_chip ia64_msi_chip = {
> > -	.name		= "PCI-MSI",
> > +	.typename	= "PCI-MSI",
> >  	.mask		= mask_msi_irq,
> >  	.unmask		= unmask_msi_irq,
> >  	.ack		= ia64_ack_msi_irq,
> 
> I think the bug is that ia64 is printing ->typename, whereas it should be
> printing ->name:
A couple of other arch also use typename instead of name when printing.

In addition, function irq_chip_set_defaults will let name=typename if
name is NULL.

Is it more reasonable to delete typename completely?

> 
> 
>  arch/ia64/kernel/iosapic.c |    2 +-
>  arch/ia64/kernel/irq.c     |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff -puN arch/ia64/kernel/iosapic.c~ia64-irqs-use-name-not-typename arch/ia64/kernel/iosapic.c
> --- a/arch/ia64/kernel/iosapic.c~ia64-irqs-use-name-not-typename
> +++ a/arch/ia64/kernel/iosapic.c
> @@ -664,7 +664,7 @@ register_intr (unsigned int gsi, int vec
>  			printk(KERN_WARNING
>  			       "%s: changing vector %d from %s to %s\n",
>  			       __FUNCTION__, vector,
> -			       idesc->chip->typename, irq_type->typename);
> +			       idesc->chip->name, irq_type->name);
>  		idesc->chip = irq_type;
>  	}
>  	return 0;
> diff -puN arch/ia64/kernel/irq.c~ia64-irqs-use-name-not-typename arch/ia64/kernel/irq.c
> --- a/arch/ia64/kernel/irq.c~ia64-irqs-use-name-not-typename
> +++ a/arch/ia64/kernel/irq.c
> @@ -76,7 +76,7 @@ int show_interrupts(struct seq_file *p, 
>  			seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
>  		}
>  #endif
> -		seq_printf(p, " %14s", irq_desc[i].chip->typename);
> +		seq_printf(p, " %14s", irq_desc[i].chip->name);
>  		seq_printf(p, "  %s", action->name);
>  
>  		for (action=action->next; action; action = action->next)
> _
