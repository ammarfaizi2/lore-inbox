Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWFTFOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWFTFOc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 01:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWFTFOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 01:14:32 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26773 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751238AbWFTFOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 01:14:31 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: The i386 and x86_64 genirq patches are wrong!
References: <m1r71t2ew8.fsf@ebiederm.dsl.xmission.com>
	<20060614070353.GA11896@elte.hu>
	<m1y7vzzlrk.fsf@ebiederm.dsl.xmission.com>
	<20060619144150.51fe627c.akpm@osdl.org>
Date: Mon, 19 Jun 2006 23:13:58 -0600
In-Reply-To: <20060619144150.51fe627c.akpm@osdl.org> (Andrew Morton's message
	of "Mon, 19 Jun 2006 14:41:50 -0700")
Message-ID: <m1zmg8flyh.fsf@ebiederm.dsl.xmission.com>
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

Should be in the morning.  The patches are ready I just need to make certain
I copy all of the appropriate people, add signed-off-by lines, etc.
The reason for the delay was that I didn't have a convenient base.  I
had a development effort that as it's final product turned up a bug.

I think everything is in good shape but I don't trust myself until I slept
on it all.

My patches are incremental against 2.6.17-rc6-mm2 as that turned out
to be the easiest place to start.

Eric



