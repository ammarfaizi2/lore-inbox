Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262874AbUEOOpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbUEOOpM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 10:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263227AbUEOOpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 10:45:11 -0400
Received: from aun.it.uu.se ([130.238.12.36]:51917 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262874AbUEOOoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 10:44:23 -0400
Date: Sat, 15 May 2004 16:44:13 +0200 (MEST)
Message-Id: <200405151444.i4FEiDkK001433@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@muc.de, bos@serpentine.com
Subject: Re: [PATCH][3/7] perfctr-2.7.2 for 2.6.6-mm2: x86_64
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 May 2004 11:09:11 +0200, Andi Kleen wrote:
>> entail; just look at the horrendous mess that is the P4 performance
>> counter event selector.
>
>There is no way around that - there are kernel users (like the
>nmi watchdog or oprofile) and kernel users cannot be made dependent 
>on user space modules.

The NMI watchdog uses a simple static mapping. No problem there.

I don't care where oprofile computes its mapping, but clearly
it could be done in user-space at the same time as user-space
chooses which events to monitor.

User-space needs to know about it anyway. For instance, unless
you understand the HW constraints, you may try to enable mutually
exclusive events. Some events may be unconstrained, but you need
to know about the constrained ones before you assign the
unconstrained ones. And user-space must know the mapping anyway
for the RDPMC instruction.

The kernel, in the case of both perfctr and oprofile, needs to be
informed of the mapping, but it has no real reason to compute it
itself -- especially not on a complex machine like the P4.

> Also I think managing of hardware resources is the 
>primary task of a kernel, nothing that should be delegated to user 
>space.

In my view, the kernel has three primary responsibilities:
- Control resources that user-space code is prevented from accessing.
- Implement useful well-understood abstractions.
- Task-related synchronization.

The only reason performance-counters must have kernel support
is because the control registers are reserved, and because the
kernel state previously didn't include the counters, so they
weren't context-switched.

We don't put an abstract floating-point module in the kernel,
charging it with choosing x87, 3dnow!, or sse code, and
performing register allocation, do we?
No, we expect user-space to deal with that.

In constrast to well-understood abstractions like file systems
or ethernet drivers, there is no common abstraction of the
performance counters that doesn't hide too much details.
And users need to know those details anyway when they interpret
the counter values. User-space libraries do implement abstractions,
for ease of use, but both they and expert users need low-level
interfaces with direct access to the hardware. And that's what
perfctr provides.

/Mikael
