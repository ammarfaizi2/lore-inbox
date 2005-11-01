Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbVKALf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbVKALf3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 06:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbVKALf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 06:35:29 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26840 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750756AbVKALf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 06:35:28 -0500
To: OBATA Noboru <noboru.obata.ar@hitachi.com>
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [KDUMP] pending interrupts problem
References: <m13bmnc7jr.fsf@ebiederm.dsl.xmission.com>
	<20051101.181319.92587627.noboru.obata.ar@hitachi.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 01 Nov 2005 04:34:49 -0700
In-Reply-To: <20051101.181319.92587627.noboru.obata.ar@hitachi.com> (OBATA
 Noboru's message of "Tue, 01 Nov 2005 18:13:19 +0900 (JST)")
Message-ID: <m1d5lk8uue.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OBATA Noboru <noboru.obata.ar@hitachi.com> writes:

> On Thu, 27 Oct 2005, Eric W. Biederman wrote:
>> 
>> > But pending interrupts on other vectors may cause another
>> > problem.  They would cause misrouted IRQs, which are now
>> > addressed by "irqpoll" kernel parameter.  But I'm not sure this
>> > solves all the problems.
>> 
>> The irqs should not be misrouted.  They simply come at an unexpected
>> time.
>
> Okay, I guess the irqs are not misrouted because kdump does not
> touch the IO-APIC routing table, and the second kernel will
> build the same one.

Right the problem irqpoll addresses is irqs that get stuck on.
The kernel will disable them at the interrupt controller and
we need a way to continue.  Mostly that only happens if the
irq is shared with something else, that we don't load a driver for,
or if an irq comes in before the driver initializes.

>> > So another way to solve this problem is to clear all such
>> > pending interrupts before booting the second kernel.  
>> 
>> No.  The second kernel gets to cope, because we cannot
>> do anything reliable in the crashed kernel.
>
> Well, I first thought that restoring the hardware status back to
> normal before booting the second kernel is better because it may
> require fewer changes on the kernel core code.
>
> But now I'm getting the idea what kdump is trying to do.  Kdump
> wants to do less in the crashed kernel, and solve problems in
> the second kernel.

Right and the result is a more robust kernel in general.  In most
cases the failure mode is a second kernel that doesn't boot,
or it doesn't successfully initialize the drivers.  Which is
a much better failure than potentially scribbling random
data all over you disk, which is what using drivers in a broken
kernel can do.

> I think we need more test cases, especially the cases that focus
> on "status" of hardware, to make kdump more reliable.  Kdump
> should recover from all possible status of supported hardware.

Given that part of all possible status is broken hardware,
that isn't necessarily possible. Still attempting to recover
from all possible status is a sound plan.

> Is anyone working on developing such test cases for kdump?

Not to my knowledge.  The big push until just lately has simply
been to get the core working.  Vivek Goyal would be the most
likely suspect. But feel free to work on pathological scenarios.

I'm still not quite convinced that crashdumps are interesting yet :)

Eric

