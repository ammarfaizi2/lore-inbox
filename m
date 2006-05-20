Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbWETPuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWETPuu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 11:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWETPut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 11:50:49 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29083 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751300AbWETPut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 11:50:49 -0400
Date: Sat, 20 May 2006 17:50:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Shaohua Li <shaohua.li@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] don't use flush_tlb_all in suspend time
Message-ID: <20060520155007.GC2946@elf.ucw.cz>
References: <1146367462.21486.10.camel@sli10-desk.sh.intel.com> <20060430064505.GA5091@ucw.cz> <1146379596.8456.4.camel@sli10-desk.sh.intel.com> <20060429235721.1d081ea5.akpm@osdl.org> <20060430120421.GA30024@elf.ucw.cz> <1147922973.32046.13.camel@sli10-desk.sh.intel.com> <20060518083146.GA12724@elf.ucw.cz> <1148001335.32046.25.camel@sli10-desk.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148001335.32046.25.camel@sli10-desk.sh.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > @@ -420,7 +421,14 @@ void zap_low_mappings (void)
> > > > >  #else
> > > > >  		set_pgd(swapper_pg_dir+i, __pgd(0));
> > > > >  #endif
> > > > > -	if (cpus_weight(cpu_online_map) == 1)
> > > > > +	/*
> > > > > +	 * We can be called at suspend/resume time, with local interrupts
> > > > > +	 * disabled.  But flush_tlb_all() requires that local interrupts be
> > > > > +	 * enabled.
> > > > > +	 *
> > > > > +	 * Happily, the APs are not yet started, so we can use local_flush_tlb()	 * in that case
> > > > > +	 */
> > > > > +	if (num_online_cpus() == 1)
> > > > >  		local_flush_tlb();
> > > > >  	else
> > > > >  		flush_tlb_all();
> > > > 
> > > > But this still scares. It means calling convention is "may enable
> > > > interrupts with >1 cpu, may not with == 1 cpu". 
> > > Below patch should make things clean. How do you think?
> > 
> > Nice...
> > 
> > Could we perhaps reuse swsusp_pg_dir (just make it used for swsusp &
> > suspend-to-ram) to save a bit more code? It is in arch/i386/mm/init.c
> Ok, I guess this is what you want.

Yes, thanks a lot for patience.

> Signed-off-by: Shaohua Li <shaohua.li@intel.com>

Acked-by: Pavel Machek <pavel@suse.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
