Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbVHXBOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbVHXBOY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 21:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbVHXBOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 21:14:24 -0400
Received: from fmr18.intel.com ([134.134.136.17]:9875 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750823AbVHXBOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 21:14:24 -0400
Subject: Re: [PATCH] Add MCE resume under ia32
From: Shaohua Li <shaohua.li@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
In-Reply-To: <20050823103256.GB2795@elf.ucw.cz>
References: <1124762500.3013.3.camel@linux-hp.sh.intel.com>
	 <20050823103256.GB2795@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 24 Aug 2005 09:13:21 +0800
Message-Id: <1124846001.3007.7.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-23 at 12:32 +0200, Pavel Machek wrote:
> > It's widely seen a MCE non-fatal error reported after resume. It seems
> > MCE resume is lacked under ia32. This patch tries to fix the gap.
> 
> Well, you patch seems like missing piece of puzzle, but:
> 
> a) we probably want to do it for x86-64, too, and 
x86-64 has resume support. It uses 'on_each_cpu' in resume method, which
is known broken. We'd better fix it.

> 
> > diff -puN arch/i386/power/cpu.c~mcheck_resume arch/i386/power/cpu.c
> > --- linux-2.6.13-rc6/arch/i386/power/cpu.c~mcheck_resume	2005-08-23 09:32:13.054008584 +0800
> > +++ linux-2.6.13-rc6-root/arch/i386/power/cpu.c	2005-08-23 09:41:54.992540480 +0800
> > @@ -104,6 +104,8 @@ static void fix_processor_context(void)
> >  
> >  }
> >  
> > +extern void mcheck_init(struct cpuinfo_x86 *c);
> > +
> >  void __restore_processor_state(struct saved_context *ctxt)
> >  {
> >  	/*
> 
> 
> this should go to some header file and most importantly
If you agree my other points, I'll do this.

> 
> > @@ -138,6 +140,9 @@ void __restore_processor_state(struct sa
> >  	fix_processor_context();
> >  	do_fpu_end();
> >  	mtrr_ap_init();
> > +#ifdef CONFIG_X86_MCE
> > +	mcheck_init(&boot_cpu_data);
> > +#endif
> >  }
> 
> c) can't we register MCEs like some kind of system device so that this
> kind of hooks is not neccessary?
Like x86-64 does, right? In this way, we must register a device for each
cpu. But APs directly call mcheck_init in resume time (cpuhotplug
framework). Only BP requires to call the resume method, so I think
restore_processor_state calls it might be cleaner. 

Thanks,
Shaohua

