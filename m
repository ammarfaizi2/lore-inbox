Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWGAMNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWGAMNd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 08:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWGAMNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 08:13:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:18092 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750957AbWGAMNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 08:13:32 -0400
Subject: Re: RFC: unlazy fpu for frequent fpu users
From: Arjan van de Ven <arjan@infradead.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200607010753_MC3-1-C3ED-2040@compuserve.com>
References: <200607010753_MC3-1-C3ED-2040@compuserve.com>
Content-Type: text/plain
Date: Sat, 01 Jul 2006 14:13:30 +0200
Message-Id: <1151756010.3195.31.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You can do better that that.  FXSR doesn't destroy the FPU contents; if
> you track the context carefully you can completely avoid the restore.
> This requires keeping a per-cpu variable that holds a pointer to the


to be honest, while I like the idea, it does scare me from a security
point of view, both in terms of leaks and in terms of injecting bad
stuff. 

> > --- linux-2.6.17-sleazyfpu.orig/arch/x86_64/kernel/process.c
> > +++ linux-2.6.17-sleazyfpu/arch/x86_64/kernel/process.c
> > @@ -515,6 +515,9 @@ __switch_to(struct task_struct *prev_p, 
> >       int cpu = smp_processor_id();  
> >       struct tss_struct *tss = &per_cpu(init_tss, cpu);
> >  
> > +     /* prefetch the fxsave area into the cache */
> > +     prefetch(&next->i387.fxsave);
> > +
> >       /*
> >        * Reload esp0, LDT and the page table pointer:
> >        */
> 
> This prefetch is probably a bad idea.  I ported your patch to i386 and it was
> actually slower until I changed it:
> 
> +       if (next_p->fpu_counter > 5)
> +               /* prefetch the fxsave area into the cache */
> +               prefetch(&next->i387.fxsave);
> +
> 
> Now it's ~.4% faster.  The test was an FP program doing a simple benchmark
> while a non-FP program ran in a tight loop.

nice! I sort of am not a big fan of if .. prefetch() but if it shows
gain... then you convinced me. 0.4% is roughly the same order I saw.
It's not gigantic but it's almost free to do so it may be worth it
anyway... 
Can you send me your patch so that I can integrate it (and I'll port
your if() to the prefetch)... 

Greetings,
    Arjan van de Ven

