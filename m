Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbVASMTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVASMTc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 07:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVASMTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 07:19:32 -0500
Received: from colin2.muc.de ([193.149.48.15]:44548 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261702AbVASMTZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 07:19:25 -0500
Date: 19 Jan 2005 13:19:23 +0100
Date: Wed, 19 Jan 2005 13:19:23 +0100
From: Andi Kleen <ak@muc.de>
To: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Cc: Juho Snellman <jsnell@iki.fi>, linux-kernel@vger.kernel.org
Subject: Re: x86-64: int3 no longer causes SIGTRAP in 2.6.10
Message-ID: <20050119121923.GA2027@muc.de>
References: <20050118011244.GA23256@iki.fi> <m1sm4zv78j.fsf@muc.de> <20050118084915.GA1321@in.ibm.com> <20050118085217.GA9721@muc.de> <20050119113636.GA1498@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119113636.GA1498@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2005 at 05:06:36PM +0530, Prasanna S Panchamukhi wrote:
> Hi Andi,
> 
> > > > -	set_intr_gate(3,&int3);
> > > > +	set_system_gate(3,&int3);
> > > >  	set_system_gate(4,&overflow);	/* int4-5 can be called from all */
> > > >  	set_system_gate(5,&bounds);
> > > >  	set_intr_gate(6,&invalid_op);
> > > > Index: linux/arch/x86_64/kernel/kprobes.c
> 
> This looks good to me. Andi do you see any thing that will cause premption
>  by moving int3 to system gate.

The only difference between an interrupt gate and a system gate is 
that a system gate can be called directly from user space using "int". 

I don't see how that would affect preemption.



> 
> > > > ===================================================================
> > > > --- linux.orig/arch/x86_64/kernel/kprobes.c	2005-01-04 12:12:39.%N +0100
> > > > +++ linux/arch/x86_64/kernel/kprobes.c	2005-01-18 02:46:05.%N +0100
> > > > @@ -297,6 +297,8 @@
> > > >  	struct die_args *args = (struct die_args *)data;
> > > >  	switch (val) {
> > > >  	case DIE_INT3:
> > > > +		if (args->regs->cs & 3)
> > > > +			return NOTIFY_DONE;
> 
> This will prevent handling of userspace probes (privilege level 3). The 
> kprobe_exception handler will return from here and registered user space probe
> handler won't be called.

It's equivalent to the previous code - previously the CPU would reject
the int 3 call though and turn it into an GPF. If you prefer it I can
remove it. But were user space probes ever tested? It doesn't look like it.
If they're broken perhaps it would be better to disable it for now 
to prevent any unintended security issues.

-Andi

