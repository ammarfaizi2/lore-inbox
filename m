Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131719AbRALTdq>; Fri, 12 Jan 2001 14:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131645AbRALTdg>; Fri, 12 Jan 2001 14:33:36 -0500
Received: from colorfullife.com ([216.156.138.34]:43525 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S132462AbRALTd2>;
	Fri, 12 Jan 2001 14:33:28 -0500
Message-ID: <3A5F5BFB.69134DB9@colorfullife.com>
Date: Fri, 12 Jan 2001 20:33:15 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Frank de Lange <frank@unternet.org>
CC: dwmw2@infradead.org, linux-kernel@vger.kernel.org, mingo@elte.hu,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware 
 related?
In-Reply-To: <3A5F3BF4.7C5567F8@colorfullife.com> <20010112183314.A24174@unternet.org> <3A5F4428.F3249D2@colorfullife.com> <20010112192500.A25057@unternet.org> <3A5F5538.57F3FDC5@colorfullife.com> <20010112202104.C25675@unternet.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank de Lange wrote:
> 
> On Fri, Jan 12, 2001 at 08:04:24PM +0100, Manfred Spraul wrote:
> > I removed the disable_irq lines from 8390.c, and that fixed the problem:
> > no hang within 2 minutes - the test is still running.
> >
> > Frank, could you double check it?
> 
> I'm currently running my own patched version, which uses
> spin_lock_irq/spin_unlock_irq instead of
> spin_lock_irqsave/spin_unlock_irqrestore like you patch uses. Looking at
> spinlock.h, spin_lock_irq does a local irq disable, which seems to be closer to
> the original intent (disable_irq) than spin_lock_irqsave. Anyone want to
> comment on this?
> 
It's a bit dangerous: _if_ one of the function is called with disabled
local interrupts, then spin_unlock_irq would enable these interrupts.
That could cause other problems, but I haven't checked if these function
are actually called with disabled interrupts - e.g. the transmit
function is called with enabled interrupts.

Frank, the 2.4.0 contains 2 band aids that were added for ne2k smp:

* From Ingo: focus cpu disabled, in arch/i386/kernel/apic.c
* From myself: TARGET_CPU = cpu_online_mask, was 0xFF.

Could you disable both bandaids? I disabled them, no problems so far.

Now back to the disable_irq_nosync().
--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
