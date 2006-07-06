Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbWGFHTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbWGFHTH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 03:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbWGFHTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 03:19:07 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:4771 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964930AbWGFHTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 03:19:05 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: kmannth@gmail.com, linux-kernel@vger.kernel.org, mingo@elte.hu,
       tglx@linutronix.de, Natalie.Protasevich@UNISYS.com
Subject: Re: 2.6.17-mm6
References: <20060703030355.420c7155.akpm@osdl.org>
	<a762e240607051447x3c3c6e15k9cdb38804cf13f35@mail.gmail.com>
	<20060705155037.7228aa48.akpm@osdl.org>
	<a762e240607051628n42bf3b79v34178c7251ad7d92@mail.gmail.com>
	<20060705164457.60e6dbc2.akpm@osdl.org>
	<20060705164820.379a69ba.akpm@osdl.org>
	<a762e240607051705h33952e5elf6bd09c1ccea8ab4@mail.gmail.com>
	<20060705172545.815872b6.akpm@osdl.org>
	<m1u05v2st3.fsf@ebiederm.dsl.xmission.com>
	<20060705225905.53e61ca0.akpm@osdl.org>
	<20060705233123.dcb0a10b.akpm@osdl.org>
Date: Thu, 06 Jul 2006 01:18:03 -0600
In-Reply-To: <20060705233123.dcb0a10b.akpm@osdl.org> (Andrew Morton's message
	of "Wed, 5 Jul 2006 23:31:23 -0700")
Message-ID: <m17j2r2od0.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Wed, 5 Jul 2006 22:59:05 -0700
> Andrew Morton <akpm@osdl.org> wrote:
>
>> On Wed, 05 Jul 2006 23:42:00 -0600
>> ebiederm@xmission.com (Eric W. Biederman) wrote:
>> 
>> > So I suspect that we need to de-percpuify kernel_stat.irqs.
>> 
>> I think so.
>
> Maybe not.  If we do this, we lose the pretty CPUn columns in
> /proc/interrupts.  That /proc/interrupts display requires that we maintain
> NR_CPUS*NR_IRQS counters.

Yes.  Although at least part of that display is per architecture
so we may be able to get away with a little more.

> Given that a large NR_IRQs space will be sparsely populated, we should
> dynamically allocate the NR_CPUS storage for each active IRQ, as you say.

To some extent.  Although with MSI-X there is the potential we could use
all of them.   (But probably not).

Natalie has a firmer grasp on what is common that I do.
But I think the big Unisys boxes were running 1-2 active irqs per
cpu, and I believe some large IBM boxes were worse.

What is scary is that at 1K cpus if we wind up using all of the irqs
we start consuming 1Gig of RAM.  At only 128 cpus we are still in the 2M-15M
territory, so that isn't too scary.  The point is that after a certain
put the memory usage for all of those counters goes insane.

So I'm not certain how safe it is to leave something that explodes that badly
in there.

We at least need a big fat scary comment and probably something like
#if (NR_IRQS*NR_CPUS) > 1000000
#error ouch! NR_IRQS*NR_CPUS too large.
#endif

> That involves putting it into the irq_desc (as good a place as any).  And a
> rather large number of trivial edits.  I guess we do this only for genirq?

Probably.  The potential has always been there, but it clearly wasn't
unlocked until just recently.

If we find a cheap solution then we can do something.

As a short term thing I am tempted to say just:
#define NR_IRQS (256 + (NR_CPUS*8))

Which would reduce kstat_irqs to 5k, and would relieve the immediate
symptoms.

Eric
