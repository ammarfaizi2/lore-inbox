Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318844AbSG0WdX>; Sat, 27 Jul 2002 18:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318845AbSG0WdX>; Sat, 27 Jul 2002 18:33:23 -0400
Received: from holomorphy.com ([66.224.33.161]:51108 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318844AbSG0WdW>;
	Sat, 27 Jul 2002 18:33:22 -0400
Date: Sat, 27 Jul 2002 15:36:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] Re: Serial Oopsen caused by global IRQ chanes
Message-ID: <20020727223617.GO25038@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Russell King <rmk@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
References: <20020727191119.C32766@flint.arm.linux.org.uk> <Pine.LNX.4.44.0207272034210.19384-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207272034210.19384-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2002 at 08:43:04PM +0200, Ingo Molnar wrote:
> the attached patch fixes a synchronize_irq() bug: if the interrupt is 
> freed while an IRQ handler is running (irq state is IRQ_INPROGRESS) then 
> synchronize_irq() will return early, which is incorrect.
> there was another do_IRQ() bug that in fact necessiated the bad code that
> caused the synchronize_irq() bug - we kept the IRQ_INPROGRESS bit set for
> not active interrupt sources - after they happen for the first time. Now
> the only effect this has is on i8259A irq handling - we used to keep these
> irqs disabled after the first 'spurious' interrupt happened.  Now what the
> i8259A code really wants to do IMO is to keep the interrupt disabled if
> there is no handler defined for that interrupt source. The patch adds
> exactly this. I dont remember why this was needed in the first place (irq
> probing? avoidance of interrupt storms?), but with the patch the behavior
> should be equivalent.

I'm having trouble with this one, I seem to get lots of these messages:

pu: 12, clocks: 99983, slice: 3029
CPU12<T0:99968,T1:60576,D:15,S:3029,C:99983>
CPU 12 IS NOW UP!
Bringing up 13
cpu: 13, clocks: 99983, slice: 3029
CPU13<T0:99968,T1:57552,D:10,S:3029,C:99983>
CPU 13 IS NOW UP!
Bringing up 14
cpu: 14, clocks: 99983, slice: 3029
CPU14<T0:99968,T1:54528,D:5,S:3029,C:99983>
CPU 14 IS NOW UP!
Bringing up 15
cpu: 15, clocks: 99983, slice: 3029
CPU15<T0:99968,T1:51504,D:0,S:3029,C:99983>
CPU 15 IS NOW UP!
CPUS done 4294967295
Linux NET4.0 for Linux 2.4

... and then the kernel deadlocks after free_initmem()'s printk().


Cheers,
Bill
