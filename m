Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbVASLeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVASLeS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 06:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVASLeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 06:34:17 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:49314 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261694AbVASLeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 06:34:02 -0500
Date: Wed, 19 Jan 2005 17:06:36 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Andi Kleen <ak@muc.de>
Cc: Juho Snellman <jsnell@iki.fi>, linux-kernel@vger.kernel.org
Subject: Re: x86-64: int3 no longer causes SIGTRAP in 2.6.10
Message-ID: <20050119113636.GA1498@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20050118011244.GA23256@iki.fi> <m1sm4zv78j.fsf@muc.de> <20050118084915.GA1321@in.ibm.com> <20050118085217.GA9721@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118085217.GA9721@muc.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

> > > -	set_intr_gate(3,&int3);
> > > +	set_system_gate(3,&int3);
> > >  	set_system_gate(4,&overflow);	/* int4-5 can be called from all */
> > >  	set_system_gate(5,&bounds);
> > >  	set_intr_gate(6,&invalid_op);
> > > Index: linux/arch/x86_64/kernel/kprobes.c

This looks good to me. Andi do you see any thing that will cause premption
 by moving int3 to system gate.

> > > ===================================================================
> > > --- linux.orig/arch/x86_64/kernel/kprobes.c	2005-01-04 12:12:39.%N +0100
> > > +++ linux/arch/x86_64/kernel/kprobes.c	2005-01-18 02:46:05.%N +0100
> > > @@ -297,6 +297,8 @@
> > >  	struct die_args *args = (struct die_args *)data;
> > >  	switch (val) {
> > >  	case DIE_INT3:
> > > +		if (args->regs->cs & 3)
> > > +			return NOTIFY_DONE;

This will prevent handling of userspace probes (privilege level 3). The 
kprobe_exception handler will return from here and registered user space probe
handler won't be called.

Thanks
Prasanna
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
