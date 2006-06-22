Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161069AbWFVL2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161069AbWFVL2Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 07:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161073AbWFVL2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 07:28:24 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:10110 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161069AbWFVL2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 07:28:23 -0400
Subject: Re: [PATCH] kprobes for s390 architecture
From: Jan Glauber <jan.glauber@de.ibm.com>
To: Mike Grundy <grundym@us.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org,
       systemtap@sources.redhat.com
In-Reply-To: <20060621173436.GA7834@localhost.localdomain>
References: <20060612131552.GA6647@localhost.localdomain>
	 <1150141217.5495.72.camel@localhost>
	 <20060621042804.GA20300@localhost.localdomain>
	 <1150907920.8295.10.camel@localhost>
	 <20060621173436.GA7834@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 22 Jun 2006 13:28:36 +0200
Message-Id: <1150975716.6496.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-21 at 10:34 -0700, Mike Grundy wrote:
> On Wed, Jun 21, 2006 at 06:38:40PM +0200, Martin Schwidefsky wrote:
> > You misunderstood me here. I'm not talking about storing the same piece
> > of data to memory on each processor. I'm talking about isolating all
> > other cpus so that the initiating cpu can store the breakpoint to memory
> > without running into the danger that another cpu is trying to execute it
> > at the same time. But probably the store should be atomic in regard to
> > instruction fetching on the other cpus. It is only two bytes and it
> > should be aligned.
> 
> So maybe something like this:
> 
> void smp_replace_instruction(void *info) {
>         struct ins_replace_args *parms;
>         parms = (struct ins_replace_args *) info;
>         *parms->addr = *parms->insn
> }
> 
> void __kprobes arch_arm_kprobe(struct kprobe *p)
> {
>         struct ins_replace_args parms;
>         parms.addr = p->addr;
>         parms.insn = BREAKPOINT_INSTRUCTION
> 
>         preempt_disable();
>         smp_call_function(smp_replace_instruction, &parms, 0, 1);
>         preempt_enable();
> }

Preemption disabling is not necessary around smp_call_function(), since
smp_call_function() takes a spin lock. But smp_call_function() is wrong
here, it calls the code on all other CPUs but not on our own. Please use
on_each_cpu() instead.

Jan

---
Jan Glauber
IBM Linux Technology Center
Linux on zSeries Development, Boeblingen

