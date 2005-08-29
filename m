Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbVH2Rp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbVH2Rp3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 13:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbVH2Rp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 13:45:29 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:20169 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751174AbVH2Rp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 13:45:28 -0400
Date: Mon, 29 Aug 2005 10:45:25 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, amitkale@linsyssoft.com,
       Bob Picco <bob.picco@hp.com>
Subject: Re: [patch 08/16] Add support for X86_64 platforms to KGDB
Message-ID: <20050829174525.GD3827@smtp.west.cox.net>
References: <resend.7.2982005.trini@kernel.crashing.org> <1.2982005.trini@kernel.crashing.org> <resend.8.2982005.trini@kernel.crashing.org> <200508291913.48648.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508291913.48648.ak@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2005 at 07:13:47PM +0200, Andi Kleen wrote:
> On Monday 29 August 2005 18:10, Tom Rini wrote:
> 
> > +void __init early_setup_per_cpu_area(void)
> > +{
> > +	static char cpu0[PERCPU_ENOUGH_ROOM]
> > +		__attribute__ ((aligned (SMP_CACHE_BYTES)));
> > +	char *ptr = cpu0;
> > +
> > +	cpu_pda[0].data_offset = ptr - __per_cpu_start;
> > +	memcpy(ptr, __per_cpu_start, __per_cpu_end - __per_cpu_start);
> > +}
> 
> What is that?  It looks totally bogus. Can you tell exactly where you
> believe early per cpu data is needed?

Bob did this part (forgot to CC him, oops).  But I believe it's needed
for setting traps so much earlier.

> > +
> >  /*
> >   * Great future plan:
> >   * Declare PDA itself and support (irqstack,tss,pgd) as per cpu data.
> > @@ -97,7 +107,9 @@ void __init setup_per_cpu_areas(void)
> >  	for (i = 0; i < NR_CPUS; i++) {
> >  		char *ptr;
> >
> > -		if (!NODE_DATA(cpu_to_node(i))) {
> > +		if (cpu_pda[i].data_offset)
> > +			continue;
> 
> And that looks broken too.

I believe that's to takecare of the case where something is covered in
early_setup_cpu_areas().

> In general I would also advise to mix any other changes outside kgdb* into the 
> x86-64 kgdb patch. Either the patch should be merged into mainline in a 
> separate patch or kgdb reworked to not need this.

ok.

> > +	if (notify_die(DIE_PAGE_FAULT, "no context", regs, error_code, 14,
> > +				SIGSEGV) == NOTIFY_STOP)
> > +		return;
> > +
> 
> I can see the point of that. It's ok if you submit it as a separate patch.

I can split that out into one that follows the KDB_VECTOR rename easily
enough.

> Regarding early trap init: I would have no problem to move all of traps_init
> into setup_arch (and leave traps_init empty for generic code). I actually
> don't know why it runs so late. But doing it half way is ugly.

Should I make setup_per_cpu_area and trap_init empty and turn the real
ones into early_foo?

-- 
Tom Rini
http://gate.crashing.org/~trini/
