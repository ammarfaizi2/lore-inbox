Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135270AbRAJMIv>; Wed, 10 Jan 2001 07:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135421AbRAJMIb>; Wed, 10 Jan 2001 07:08:31 -0500
Received: from chiara.elte.hu ([157.181.150.200]:61708 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S135270AbRAJMIX>;
	Wed, 10 Jan 2001 07:08:23 -0500
Date: Wed, 10 Jan 2001 13:07:53 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <3A5C4FAC.CA6E46A9@colorfullife.com>
Message-ID: <Pine.LNX.4.30.0101101304330.1681-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 Jan 2001, Manfred Spraul wrote:

> > well, this is a performance problem if you are using threads. For normal
> > processes there is no need for a SMP cross-call, there TLB flushes are
> > local only.
> >
> But that would be ugly as hell:
> so apache 2.0 would become slower with MSG_NOCOPY, whereas samba 2.2
> would become faster.

there *is* a cost of having a shared VM - and this is i suspect
unavoidable.

> Is is possible to move the responsibility for maitaining the copy to
> the caller?

this needs a completion event i believe.

> e.g. use msg_control, and then the caller can request either that a
> signal is sent when that data is transfered, or that a variable is set
> to 0.

i believe a signal-based thing would be the right (and scalable) solution
- the signal handler could free() the buffer.

this makes sense even in the VM-assisted MSG_NOCOPY case, since one wants
to do garbage collection of these in-flight buffers anyway. (not for
correctness but for performance reasons - free()-ing and immediately
reusing such a buffer would generate a COW.)

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
