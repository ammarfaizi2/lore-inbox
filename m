Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWGAV4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWGAV4J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 17:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbWGAV4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 17:56:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:15266 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751149AbWGAV4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 17:56:08 -0400
Subject: Re: [patch 1/2] sLeAZY FPU feature - x86_64 support
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <200607012349.36091.ak@suse.de>
References: <1151773893.3195.45.camel@laptopd505.fenrus.org>
	 <1151773956.3195.47.camel@laptopd505.fenrus.org>
	 <200607012349.36091.ak@suse.de>
Content-Type: text/plain
Date: Sat, 01 Jul 2006 23:56:06 +0200
Message-Id: <1151790966.3195.66.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> However I'm not sure 256 is a good number. It seems a bit too high.

it's 256 context switches... if you care about context switch cycles
you'll do many, and 256 isn't a lot ;)

(remember that this is after 5 *consecutive* fpu uses, not just 5 uses
total, to you're really a heavy fpu user if you hit that)

> 
> > Index: linux-2.6.17-sleazyfpu/arch/x86_64/kernel/process.c
> > ===================================================================
> > --- linux-2.6.17-sleazyfpu.orig/arch/x86_64/kernel/process.c
> > +++ linux-2.6.17-sleazyfpu/arch/x86_64/kernel/process.c
> > @@ -515,6 +515,10 @@ __switch_to(struct task_struct *prev_p, 
> >  	int cpu = smp_processor_id();  
> >  	struct tss_struct *tss = &per_cpu(init_tss, cpu);
> >  
> > +	/* we're going to use this soon, after a few expensive things */
> > +	if (next_p->fpu_counter>5)
> > +		prefetch(&next->i387.fxsave);
> 
> Did you measure this prefetch makes a difference? I would expect it to
> be too soon to be really worth while (normally you need hundreds of
> instructions for them to make sense and that's probably not the case here) 

s/instructions/cycles/

well there are 4 segment loads, a few msr accesses, a few PDA writes and
optionally even the fxsave of the old task inbetween the prefetch and
the use of the memory; those do add up *bigtime*...



