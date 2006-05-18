Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWERIjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWERIjs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 04:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWERIjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 04:39:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:47550 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750803AbWERIjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 04:39:47 -0400
X-IronPort-AV: i="4.05,139,1146466800"; 
   d="scan'208"; a="37975295:sNHT15017142"
Subject: Re: [PATCH] don't use flush_tlb_all in suspend time
From: Shaohua Li <shaohua.li@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060518083146.GA12724@elf.ucw.cz>
References: <1146367462.21486.10.camel@sli10-desk.sh.intel.com>
	 <20060430064505.GA5091@ucw.cz>
	 <1146379596.8456.4.camel@sli10-desk.sh.intel.com>
	 <20060429235721.1d081ea5.akpm@osdl.org> <20060430120421.GA30024@elf.ucw.cz>
	 <1147922973.32046.13.camel@sli10-desk.sh.intel.com>
	 <20060518083146.GA12724@elf.ucw.cz>
Content-Type: text/plain
Date: Thu, 18 May 2006 16:38:21 +0800
Message-Id: <1147941501.32046.18.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-18 at 10:31 +0200, Pavel Machek wrote:
> Hi!
> 
> > > > In which case, how's about this?
> > > 
> > > Certainly better, I'd say.
> > > 
> > > > @@ -420,7 +421,14 @@ void zap_low_mappings (void)
> > > >  #else
> > > >  		set_pgd(swapper_pg_dir+i, __pgd(0));
> > > >  #endif
> > > > -	if (cpus_weight(cpu_online_map) == 1)
> > > > +	/*
> > > > +	 * We can be called at suspend/resume time, with local interrupts
> > > > +	 * disabled.  But flush_tlb_all() requires that local interrupts be
> > > > +	 * enabled.
> > > > +	 *
> > > > +	 * Happily, the APs are not yet started, so we can use local_flush_tlb()	 * in that case
> > > > +	 */
> > > > +	if (num_online_cpus() == 1)
> > > >  		local_flush_tlb();
> > > >  	else
> > > >  		flush_tlb_all();
> > > 
> > > But this still scares. It means calling convention is "may enable
> > > interrupts with >1 cpu, may not with == 1 cpu". 
> > Below patch should make things clean. How do you think?
> 
> Nice...
> 
> Could we perhaps reuse swsusp_pg_dir (just make it used for swsusp &
> suspend-to-ram) to save a bit more code? It is in arch/i386/mm/init.c
Sure. But it's under CONFIG_SOFTWARE_SUSPEND. That part needs cleanup I
think and it's a little strange to me (why should we simply copy
swapper_pg_dir to swsusp_pg_dir, instead do it in zap_low_mappings?).

Thanks,
Shaohua
