Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266749AbUIVTUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266749AbUIVTUS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 15:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266786AbUIVTUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 15:20:18 -0400
Received: from chaos.analogic.com ([204.178.40.224]:18048 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266749AbUIVTUG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 15:20:06 -0400
Date: Wed, 22 Sep 2004 15:19:51 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Stas Sergeev <stsp@aknet.ru>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: ESP corruption bug - what CPUs are affected?
In-Reply-To: <4151C949.1080807@aknet.ru>
Message-ID: <Pine.LNX.4.53.0409221501440.1085@chaos.analogic.com>
References: <3BFF2F87096@vcnet.vc.cvut.cz> <414C662D.5090607@aknet.ru>
 <20040918165932.GA15570@vana.vc.cvut.cz> <414C8924.1070701@aknet.ru>
 <20040918203529.GA4447@vana.vc.cvut.cz> <4151C949.1080807@aknet.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What problem is this supposed to fix?  ESP is __not__ corrupted
when returning to protected-mode or a different privilege level.
You don't 'return' to protected mode from a virtual-8086 mode,
even though you (can) use an `iret`instruction. The fundamental
change is though the EFLAGS register stored in the TSS.

The so-called bug is that when in real mode or in virtual-8086
mode, the high word of ESP is not changed. It is not a bug
because the high word doesn't even exist when in VM-86 mode!!
It is possible to use the 32-bit prefix, when in 16-bit mode,
to muck with the high word of the stack, but that's not
a documented procedure, but a side-effect of such an undocumented
instruction.

There is no bug to fix. When the VM-86 mode transitions to
32-bit protected mode, the stack is restored to the condition
it was just prior to the transition to VM-86 mode, therefore you
don't "use up" any stack. The so-called bug is only cosmetic
when somebody is prowling around in undocumented shadows.

Please, somebody from Intel tell these guys to leave the thing
alone. I, for one, don't want a bunch of "fixes" that do nothing
except consume valuable RAM, making it near impossible to
use later versions of Linux in embedded systems.


On Wed, 22 Sep 2004, Stas Sergeev wrote:

> Hi Petr et al.
>
> I coded up something that remotely looks like the
> discussed patch.
> I have deviated from your proposals at some important
> points:
> 1. I am not allocating the ring1 stack separately,
> I am allocating it on a ring0 stack. Much simpler
> code, although non-reentrant/preempt-unsafe.
> 2. I am disabling the interrupts after all. That's
> because of the preempt-unsafeness. I pass up the
> IOPL=1 when necessary, to avoid problems.
> But I guess also with your technique the interrupts
> had to be disabled, unless the ring1 stack is
> per-thread.
> 3. I am using LAR. Do you really think it can be
> slower than the whole thing of locating LDT?
>
> Let me know if I did something stupid.
> The patch is attached.
> I tested (pretty much) everything in it, except
> probably the "popl %esp" restartability. But that
> one looks fairly simple and should work.
>
> Does this patch look good?
>
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.

