Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVARIsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVARIsc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 03:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVARIsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 03:48:32 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:4740 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261200AbVARIsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 03:48:21 -0500
Date: Tue, 18 Jan 2005 14:19:15 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Andi Kleen <ak@muc.de>
Cc: Juho Snellman <jsnell@iki.fi>, linux-kernel@vger.kernel.org
Subject: Re: x86-64: int3 no longer causes SIGTRAP in 2.6.10
Message-ID: <20050118084915.GA1321@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20050118011244.GA23256@iki.fi> <m1sm4zv78j.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1sm4zv78j.fsf@muc.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 02:47:08AM +0100, Andi Kleen wrote:
> Juho Snellman <jsnell@iki.fi> writes:
> 
> > 2.6.10 changed the behaviour of the int3 instruction on x86-64. It
> > used to result in a SIGTRAP, now it's a SIGSEGV in both native and
> > 32-bit legacy modes. This was apparently caused by the kprobe port,
> > specifically this part:
> >
> > --- a/arch/x86_64/kernel/traps.c        2004-12-24 13:36:17 -08:00
> > +++ b/arch/x86_64/kernel/traps.c        2004-12-24 13:36:17 -08:00
> > @@ -862,8 +910,8 @@
> >         set_intr_gate(0,&divide_error);
> >         set_intr_gate_ist(1,&debug,DEBUG_STACK);
> >         set_intr_gate_ist(2,&nmi,NMI_STACK);
> > -       set_system_gate(3,&int3);       /* int3-5 can be called from all */
> > -       set_system_gate(4,&overflow);
> > +       set_intr_gate(3,&int3);
> > +       set_system_gate(4,&overflow);   /* int4-5 can be called from all */
> >
> > Was effectively disabling int3 a conscious decision, or just an
> > unintended side-effect? This breaks at least Steel Bank Common Lisp
> 
> It's a bug. Thanks for the report.
> 
> I'm not sure why it was even changed. Prasanna? 
> 
> I think it should be just changed back. If kprobes cannot 
> deal with traps for user space it needs to be fixed. e.g.
> by adding a user space check in kprobe_handler().
> 
Yes its a bug, we turn trap 3 into interrupt gates to ensure that it is not preemtable.

Thanks
Prasanna
> -Andi
> 
> Like this patch.
> 
> Index: linux/arch/x86_64/kernel/traps.c
> ===================================================================
> --- linux.orig/arch/x86_64/kernel/traps.c	2005-01-17 10:34:24.%N +0100
> +++ linux/arch/x86_64/kernel/traps.c	2005-01-18 02:42:02.%N +0100
> @@ -908,7 +908,7 @@
>  	set_intr_gate(0,&divide_error);
>  	set_intr_gate_ist(1,&debug,DEBUG_STACK);
>  	set_intr_gate_ist(2,&nmi,NMI_STACK);
> -	set_intr_gate(3,&int3);
> +	set_system_gate(3,&int3);
>  	set_system_gate(4,&overflow);	/* int4-5 can be called from all */
>  	set_system_gate(5,&bounds);
>  	set_intr_gate(6,&invalid_op);
> Index: linux/arch/x86_64/kernel/kprobes.c
> ===================================================================
> --- linux.orig/arch/x86_64/kernel/kprobes.c	2005-01-04 12:12:39.%N +0100
> +++ linux/arch/x86_64/kernel/kprobes.c	2005-01-18 02:46:05.%N +0100
> @@ -297,6 +297,8 @@
>  	struct die_args *args = (struct die_args *)data;
>  	switch (val) {
>  	case DIE_INT3:
> +		if (args->regs->cs & 3)
> +			return NOTIFY_DONE;
>  		if (kprobe_handler(args->regs))
>  			return NOTIFY_STOP;
>  		break;
> 
> 

-- 
Have a Nice Day!

Thanks & Regards
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
