Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129543AbQKGAC6>; Mon, 6 Nov 2000 19:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129802AbQKGACs>; Mon, 6 Nov 2000 19:02:48 -0500
Received: from cs.columbia.edu ([128.59.16.20]:13730 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S129543AbQKGACo>;
	Mon, 6 Nov 2000 19:02:44 -0500
Date: Mon, 6 Nov 2000 16:02:40 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.0test10 crash (RAID+SMP)
Message-ID: <Pine.LNX.4.21.0011061601120.7242-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[s/rutgers.edu/kernel.org/]

On Tue, 7 Nov 2000 09:19:12 +1100 (EST), Neil Brown <neilb@cse.unsw.edu.au>
wrote:
> On Monday November 6, jgarzik@mandrakesoft.com wrote:

>> If multiple interrupts are hitting a single code path (like IDE irqs 14
>> -and- 15), you definitely have to think about that.  The reentrancy
>> guarantee only exists when a single IRQ is assigned to a single
>> handler...
>> 
> The b_end_io routine that raid1 attaches to io request buffer_heads
> that are used for resyncing had a side effect of re-enabling
> interrupts.  As it is called from an interrupt context, this is
> clearly a bug.  It allowed another interrupt to be serviced before a
> previous interrupt had been completed, which is a problem waiting to
> happen.
> In this case, it became a real problem because the first interrupt had
> grabbed a spinlock (I didn't bother to discover which one) and the
> second interrupt tried to grab the same spinlock. This produced the
> deadlock which the NMI-Oopser detected and reported.

You are absolutely right, it is a bug, but Jeff is also right in pointing
that the bug won't hit you unless you have two different hardware IRQ's
being serviced by the same code. Otherwise, just enabling the interrupts
won't re-enable _your_ IRQ, so another interrupt triggered by your IRQ
won't be serviced until you exit the handler.

It could also be that the code is running with SA_INTERRUPT and is relying
on the fact that _all_ interrupts are disabled. That's less likely, 
especially since AFAIK the interrupts are disabled only on the local
processor, so it's not much of a guarantee on SMP.

In any case, a bug is a bug and should get fixed, no question about it. :)

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
