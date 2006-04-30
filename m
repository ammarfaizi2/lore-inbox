Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWD3MFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWD3MFL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 08:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWD3MFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 08:05:11 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28642 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750785AbWD3MFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 08:05:09 -0400
Date: Sun, 30 Apr 2006 14:04:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] don't use flush_tlb_all in suspend time
Message-ID: <20060430120421.GA30024@elf.ucw.cz>
References: <1146367462.21486.10.camel@sli10-desk.sh.intel.com> <20060430064505.GA5091@ucw.cz> <1146379596.8456.4.camel@sli10-desk.sh.intel.com> <20060429235721.1d081ea5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060429235721.1d081ea5.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On So 29-04-06 23:57:21, Andrew Morton wrote:
> Shaohua Li <shaohua.li@intel.com> wrote:
> >
> > On Sun, 2006-04-30 at 06:45 +0000, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > flush_tlb_all uses on_each_cpu, which will disable/enable interrupt.
> > > > In suspend/resume time, this will make interrupt wrongly enabled.
> > > 
> > > > diff -puN arch/i386/mm/init.c~flush_tlb_all_check arch/i386/mm/init.c
> > > > --- linux-2.6.17-rc3/arch/i386/mm/init.c~flush_tlb_all_check	2006-04-29 08:47:05.000000000 +0800
> > > > +++ linux-2.6.17-rc3-root/arch/i386/mm/init.c	2006-04-29 08:48:15.000000000 +0800
> > > > @@ -420,7 +420,10 @@ void zap_low_mappings (void)
> > > >  #else
> > > >  		set_pgd(swapper_pg_dir+i, __pgd(0));
> > > >  #endif
> > > > -	flush_tlb_all();
> > > > +	if (cpus_weight(cpu_online_map) == 1)
> > > > +		local_flush_tlb();
> > > > +	else
> > > > +		flush_tlb_all();
> > > >  }
> > > >
> > > 
> > > Either it is okay to enable interrupts here -> unneccessary and ugly
> > > test, or it is not, and then we are broken in SMP case.
> > It's not broken in SMP case, APs are offlined here in suspend/resume.
> > 
> 
> In which case, how's about this?

Certainly better, I'd say.

> @@ -420,7 +421,14 @@ void zap_low_mappings (void)
>  #else
>  		set_pgd(swapper_pg_dir+i, __pgd(0));
>  #endif
> -	if (cpus_weight(cpu_online_map) == 1)
> +	/*
> +	 * We can be called at suspend/resume time, with local interrupts
> +	 * disabled.  But flush_tlb_all() requires that local interrupts be
> +	 * enabled.
> +	 *
> +	 * Happily, the APs are not yet started, so we can use local_flush_tlb()	 * in that case
> +	 */
> +	if (num_online_cpus() == 1)
>  		local_flush_tlb();
>  	else
>  		flush_tlb_all();

But this still scares. It means calling convention is "may enable
interrupts with >1 cpu, may not with == 1 cpu". 

								Pavel
-- 
Thanks for all the (sleeping) penguins.
