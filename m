Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbWFTWY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWFTWY1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWFTWY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:24:27 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35044 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751304AbWFTWY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:24:26 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: The i386 and x86_64 genirq patches are wrong!
References: <m1r71t2ew8.fsf@ebiederm.dsl.xmission.com>
	<20060614070353.GA11896@elte.hu>
	<m1y7vzzlrk.fsf@ebiederm.dsl.xmission.com>
	<20060619144150.51fe627c.akpm@osdl.org>
Date: Tue, 20 Jun 2006 16:23:48 -0600
In-Reply-To: <20060619144150.51fe627c.akpm@osdl.org> (Andrew Morton's message
	of "Mon, 19 Jun 2006 14:41:50 -0700")
Message-ID: <m1bqsneaa3.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ebiederm@xmission.com (Eric W. Biederman) wrote:
>>
>> Ingo Molnar <mingo@elte.hu> writes:
>> 
>> > here too it's hard for me to give an answer without seeing your specific 
>> > changes (against whatever base is most convenient to you). MSI certainly 
>> > works fine on current -mm. (at least on my box)
>> 
>> Ok.  Looking closer.  I have found a clear functional bug.
>> 
>> When CONFIG_PCI_MSI is not set.
>>   move_irq expands to move_native_irq.
>> 
>>   ack_ioapic_vector
>>     move_native_irq
>>     ack_ioapic_irq
>>       move_irq
>>         move_native_irq
>> 
>>   ack_ioapic_quirk_vector
>>     move_native_irq
>>     ack_ioapic_quirk_irq
>>       move_irq
>>         move_native_irq
>> 
>> So we wind up calling move_native_irq twice when MSI is disabled where
>> before your conversion we only ever called it once.  Luckily in
>> the case where we have the double call vector_to_irq is a noop so
>> we only migration the same irq twice.
>> 
>
> OK, but this doesn't seem to answer Ingo's request "could you please send
> that fix to me, against whatever base you have it tested on, and i'll merge
> it to genirq/irqchips [and fix up genirq if needed].  Please also include a
> description of the problem.  How common is that edge retrigger problem, and
> how come this has never been seen in the past years since we had
> irqbalance?"
>
> The genirq patches are stuck in limboland until issues like this are
> resolved.  I'm not planning on sending them to Linus for 2.6.18 so there's
> no huge rush on it, but it would be nice to get all these loose ends tied
> off reasonably promptly, please.

So to wrap thread up cleanly.  Before I start another one.

The bug fix is only important for level triggered irqs if you change
their vector.  Since we don't change their vector right now we don't
see a problem.

The two outstanding issues I have with the genirq patches are:

- On x86_64 irq migration was removed.  The irq balancer there
  is in user space, but we still have it, so not being able
  to bind irqs to anything but cpu 0 is a regression.

- On i386 the CONFIG_PCI_MSI defined was mishandled and we attempt
  to migrate an irq twice.  As I mentioned above.

A new patchset follows shortly that addresses the root cause and
removes the difference in behaviour of io_apic.c present
CONFIG_PCI_MSI  is defined.  

Eric



   

