Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263419AbUEPJ7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263419AbUEPJ7H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 05:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUEPJ7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 05:59:07 -0400
Received: from aun.it.uu.se ([130.238.12.36]:46514 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S263419AbUEPJ67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 05:58:59 -0400
Date: Sun, 16 May 2004 11:58:46 +0200 (MEST)
Message-Id: <200405160958.i4G9wksI006575@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@muc.de
Subject: Re: [PATCH][3/7] perfctr-2.7.2 for 2.6.6-mm2: x86_64
Cc: bos@serpentine.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 May 2004 21:26:40 +0200, Andi Kleen wrote:
>On Sat, May 15, 2004 at 04:44:13PM +0200, Mikael Pettersson wrote:
>> On Sat, 15 May 2004 11:09:11 +0200, Andi Kleen wrote:
>> >> entail; just look at the horrendous mess that is the P4 performance
>> >> counter event selector.
>> >
>> >There is no way around that - there are kernel users (like the
>> >nmi watchdog or oprofile) and kernel users cannot be made dependent 
>> >on user space modules.
>> 
>> The NMI watchdog uses a simple static mapping. No problem there.
>
>So how do you prevent your user applications from overwriting
>the single perfctr the watchdog uses?

Since kernel 2.6.6-rc<something> there is a new API in
place which makes the NMI watchdog the default owner of
the lapic NMI hardware (perfctrs + LVTPC). This API also
allows other drivers to reserve the hardware. If the NMI
watchdog currently owns the hardware, it voluntarily
gives it up. If driver Y tries to reserve the hardware
while it is reserved by driver X, then Y gets -EBUSY.
When a driver releases the hardware, it reverts to the
NMI watchdog.

This allows oprofile and perfctr to coexist safely,
and keeps the watchdog running whenever the hardware
isn't reserved.

John Levon (original oprofile maintainer) has been
involved in the design of this, and he has expressed
no concerns about the semantics.

>> User-space needs to know about it anyway. For instance, unless
>> you understand the HW constraints, you may try to enable mutually
>> exclusive events. Some events may be unconstrained, but you need
>> to know about the constrained ones before you assign the
>> unconstrained ones. And user-space must know the mapping anyway
>> for the RDPMC instruction.
>
>Sure, but it could still ask the kernel if it's available, no?

It could.

>> We don't put an abstract floating-point module in the kernel,
>> charging it with choosing x87, 3dnow!, or sse code, and
>> performing register allocation, do we?
>
>Bad analogy.  The kernel switches the FP state and each process
>has its own and does not impact any other processes.

Which is _exactly_ what perfctr's per-process counters adds,
but for the performance counters. The only difference is that
FP has been in the user-level state for a long time so people
naturally expect it to be there, and that FP tends to have
fewer supervisor-only control registers than the performance
counters. (x86 has none I think, but PowerPC has two FP control
bits in one supervisor-only register, so Linux on PowerPC has a
special prctl() call to control those bits.)

/Mikael
