Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbWD3GsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbWD3GsL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 02:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbWD3GsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 02:48:11 -0400
Received: from fmr20.intel.com ([134.134.136.19]:30891 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750986AbWD3GsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 02:48:10 -0400
Subject: Re: [PATCH] don't use flush_tlb_all in suspend time
From: Shaohua Li <shaohua.li@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060430064505.GA5091@ucw.cz>
References: <1146367462.21486.10.camel@sli10-desk.sh.intel.com>
	 <20060430064505.GA5091@ucw.cz>
Content-Type: text/plain
Date: Sun, 30 Apr 2006 14:46:36 +0800
Message-Id: <1146379596.8456.4.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-04-30 at 06:45 +0000, Pavel Machek wrote:
> Hi!
> 
> > flush_tlb_all uses on_each_cpu, which will disable/enable interrupt.
> > In suspend/resume time, this will make interrupt wrongly enabled.
> 
> > diff -puN arch/i386/mm/init.c~flush_tlb_all_check arch/i386/mm/init.c
> > --- linux-2.6.17-rc3/arch/i386/mm/init.c~flush_tlb_all_check	2006-04-29 08:47:05.000000000 +0800
> > +++ linux-2.6.17-rc3-root/arch/i386/mm/init.c	2006-04-29 08:48:15.000000000 +0800
> > @@ -420,7 +420,10 @@ void zap_low_mappings (void)
> >  #else
> >  		set_pgd(swapper_pg_dir+i, __pgd(0));
> >  #endif
> > -	flush_tlb_all();
> > +	if (cpus_weight(cpu_online_map) == 1)
> > +		local_flush_tlb();
> > +	else
> > +		flush_tlb_all();
> >  }
> >
> 
> Either it is okay to enable interrupts here -> unneccessary and ugly
> test, or it is not, and then we are broken in SMP case.
It's not broken in SMP case, APs are offlined here in suspend/resume.

Thanks,
Shaohua

