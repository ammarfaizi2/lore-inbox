Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751621AbWEPHGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbWEPHGa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 03:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbWEPHGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 03:06:30 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:27601 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751616AbWEPHGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 03:06:30 -0400
Date: Tue, 16 May 2006 09:06:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       apw@shadowen.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 NUMA panic compile error
Message-ID: <20060516070612.GA14317@elte.hu>
References: <20060515005637.00b54560.akpm@osdl.org> <200605152111.20693.ak@suse.de> <20060515192614.GA24887@elte.hu> <200605152138.57347.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605152138.57347.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> > Nevertheless for hard-to-debug bugs i prefer if they can be reproduced 
> > and debugged on 32-bit too, because x86_64 debugging is still quite a 
> > PITA and wastes alot of time: for example it has no support for exact 
> > kernel stacktraces.
> 
> Hopefully soon.

i've already implemented it for FRAME_POINTERS (i really needed it to 
not go insane when looking at lock validator output).

As you suggested a few weeks ago the real solution would be a dwarf 
parser. Maybe ia64's could be taken? Will post the patch for the 
FRAME_POINTERS solution soon. Sample output:

     [<ffffffff8020af4c>] __show_trace+0x3a/0x66
     [<ffffffff8020b36b>] show_trace+0x17/0x1a
     [<ffffffff80207e36>] show_regs+0x36/0x3c
     [<ffffffff80207e75>] smp_show_regs+0x39/0x52
     [<ffffffff8021559e>] smp_nmi_callback+0x6a/0x85
     [<ffffffff802163f2>] do_nmi+0x69/0x91
     [<ffffffff80601dca>] nmi+0x7e/0x85
     [<ffffffffffffffff>] 0xffffffffffffffff
     [<ffffffff80601ad0>] _spin_unlock_irqrestore+0x3e/0x47
     [<ffffffff8024424c>] prepare_to_wait+0x63/0x6d
     [<ffffffff8022ff0c>] do_syslog+0xf1/0x3ca
     [<ffffffff802ba3ed>] kmsg_read+0x3a/0x46
     [<ffffffff8027db72>] vfs_read+0xe6/0x191
     [<ffffffff8027e79d>] sys_read+0x44/0x82
     [<ffffffff80209b11>] system_call+0x7d/0x83
     [<ffffffffffffffff>] 0xffffffffffffffff

(and it works fine across irq/exception stacks too.)

> I think i386 only gained it very recently, so it can't be _that_ big a 
> problem.

i certainly used exact backtraces on i386 for many many years. Not sure 
whether those patches were all upstream though. It's also the 
combination of effects that makes the difference between i386 and x86_64 
so striking.

furthermore, the kernel's debugging infrastructure improved 
significantly, and we get more and more stackdumps to interpret [instead 
of hard to debug corruptions, etc.].

> The real issue is too deeply nested code like the callback hell we 
> have in some subsystems. Better would be to eliminate that. 2.4 was 
> much nicer in this regard and there has been quite a lot of 
> unnecessary complications in this area when the kernel went to 2.6.

i have no problems with interpreting occasional non-exact backtraces, 
but it is certainly non-obvious, and when you are looking at backtraces 
en masse, the unnecessary repetitive task can get really distracting and 
frustrating.

Exact backtraces on the other hand almost immediately create a unique 
and reliable "visual fingerprint", and if you have looked at enough of 
them, you almost recognize them just from looking at the shape of them. 
It's a completely different 'experience'. (and userspace developers will 
laugh out loud at us now i suspect ...)

> > Also, the printout of the backtrace is butt-ugly and as un-ergonomic 
> > to the human eye as it gets - who came up with that "two-maybe-one 
> > function entries per-line" nonsense? [Whoever did it he never had to 
> > look at (and make sense of) hundreds of stacktraces in a row.]
> 
> The original goal was to make it fit as much as possible on the screen 
> when you don't have a serial/net/fireconsole. But arguably it's less 
> and less useful because the kernel has gotten so huge that most 
> backtraces are very long and scroll away anyways.

yeah.

	Ingo
