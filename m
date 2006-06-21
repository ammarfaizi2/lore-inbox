Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWFUQie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWFUQie (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 12:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWFUQie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 12:38:34 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:46127 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP id S932162AbWFUQid
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 12:38:33 -0400
Subject: Re: [PATCH] kprobes for s390 architecture
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Mike Grundy <grundym@us.ibm.com>
Cc: jan.glauber@de.ibm.com, linux-kernel@vger.kernel.org,
       systemtap@sources.redhat.com
In-Reply-To: <20060621042804.GA20300@localhost.localdomain>
References: <20060612131552.GA6647@localhost.localdomain>
	 <1150141217.5495.72.camel@localhost>
	 <20060621042804.GA20300@localhost.localdomain>
Content-Type: text/plain
Organization: IBM Corporation
Date: Wed, 21 Jun 2006 18:38:40 +0200
Message-Id: <1150907920.8295.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-20 at 21:28 -0700, Mike Grundy wrote:
> Hi Martin - This patch implements the suggestions from your review. There were
> a couple points I wanted to go over:
> > There are some more instructions missing that need fixup:
> > "brxh" 0x84??????, "brxle" 0x85??????, "brc" 0xa7?4????,
> > "brct" 0xa7?6????, "brctg" 0xa7?7????, "bctgr" 0xb946????,
> > "brxhg" 0xec????????44 and "brxlg" 0xec??????45.
> Since all of these are relative branches, and they don't save the psw, the
> standard clean up of adjusting the original psw by the offset from the out of
> line address after single step. Unless I'm just being dense :-) 

All of these are conditional branches, if the branch is not taken you
have to do a cleanup.

> > > +void __kprobes arch_arm_kprobe(struct kprobe *p)
> > > +{
> > > +	*p->addr = BREAKPOINT_INSTRUCTION;
> > > +}
> > > +
> > > +void __kprobes arch_disarm_kprobe(struct kprobe *p)
> > > +{
> > > +	*p->addr = p->opcode;
> > > +}
> > > +
> > 
> > I would feel better if the kernel code is changed in a more controlled
> > manner. Do an smp_call_function to avoid concurrent execution of the
> > instruction you are changing.
> I'm not sure that repeatedly executing the same operation on the same area of
> memory on multiple CPUs is the answer. I'm not sure there is a right answer:
> If the instruction is brought into the pipeline while it is being changed
> on another cpu it will either execute the original instruction and that probe
> opportunity will be missed, execute the modified opcode and cause a probe hit
> (which is ok, everything is ready for it), or stall the pipeline while it 
> figures out why the heck someone is modifying something in the I-cache (IIRC
> that will slow things down a tad. (I'd really like to plead "all the other
> architectures do it this way", but instead I'll read every paper I can find
> on I-cache operations and zseries processors over diner)

You misunderstood me here. I'm not talking about storing the same piece
of data to memory on each processor. I'm talking about isolating all
other cpus so that the initiating cpu can store the breakpoint to memory
without running into the danger that another cpu is trying to execute it
at the same time. But probably the store should be atomic in regard to
instruction fetching on the other cpus. It is only two bytes and it
should be aligned.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


