Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVARIwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVARIwv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 03:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVARIws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 03:52:48 -0500
Received: from colin2.muc.de ([193.149.48.15]:47116 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261197AbVARIwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 03:52:20 -0500
Date: 18 Jan 2005 09:52:18 +0100
Date: Tue, 18 Jan 2005 09:52:17 +0100
From: Andi Kleen <ak@muc.de>
To: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Cc: Juho Snellman <jsnell@iki.fi>, linux-kernel@vger.kernel.org
Subject: Re: x86-64: int3 no longer causes SIGTRAP in 2.6.10
Message-ID: <20050118085217.GA9721@muc.de>
References: <20050118011244.GA23256@iki.fi> <m1sm4zv78j.fsf@muc.de> <20050118084915.GA1321@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118084915.GA1321@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes its a bug, we turn trap 3 into interrupt gates to ensure that it is not preemtable.

Is the patch ok for you?

-Andi

> > Like this patch.
> > 
> > Index: linux/arch/x86_64/kernel/traps.c
> > ===================================================================
> > --- linux.orig/arch/x86_64/kernel/traps.c	2005-01-17 10:34:24.%N +0100
> > +++ linux/arch/x86_64/kernel/traps.c	2005-01-18 02:42:02.%N +0100
> > @@ -908,7 +908,7 @@
> >  	set_intr_gate(0,&divide_error);
> >  	set_intr_gate_ist(1,&debug,DEBUG_STACK);
> >  	set_intr_gate_ist(2,&nmi,NMI_STACK);
> > -	set_intr_gate(3,&int3);
> > +	set_system_gate(3,&int3);
> >  	set_system_gate(4,&overflow);	/* int4-5 can be called from all */
> >  	set_system_gate(5,&bounds);
> >  	set_intr_gate(6,&invalid_op);
> > Index: linux/arch/x86_64/kernel/kprobes.c
> > ===================================================================
> > --- linux.orig/arch/x86_64/kernel/kprobes.c	2005-01-04 12:12:39.%N +0100
> > +++ linux/arch/x86_64/kernel/kprobes.c	2005-01-18 02:46:05.%N +0100
> > @@ -297,6 +297,8 @@
> >  	struct die_args *args = (struct die_args *)data;
> >  	switch (val) {
> >  	case DIE_INT3:
> > +		if (args->regs->cs & 3)
> > +			return NOTIFY_DONE;
> >  		if (kprobe_handler(args->regs))
> >  			return NOTIFY_STOP;
> >  		break;
> > 
> > 
