Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266979AbSL3Oqz>; Mon, 30 Dec 2002 09:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266981AbSL3Oqz>; Mon, 30 Dec 2002 09:46:55 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:28586 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266979AbSL3Oqy>; Mon, 30 Dec 2002 09:46:54 -0500
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
References: <3E1044D4.6050409@colorfullife.com>
From: Andi Kleen <ak@muc.de>
Date: 30 Dec 2002 15:54:56 +0100
In-Reply-To: <3E1044D4.6050409@colorfullife.com>
Message-ID: <m3adino8u7.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> writes:

> - The AMD docs contain one odd sentence:
> "The CS and SS registers must not be modified by the operating system
> between the execution of the SYSCALL and the corresponding SYSRET
> instruction".

As I understand it is:

SYSCALL does not actually load the new CS/SS from the GDT,
but just set the internal base/limit/descriptor valid registers to
"flat" values. SYSEXIT undo this. When the SYSRET is executed the
selector should be still the same, otherwise the resulting state may not be 
exactly the same as when SYSCALL happend.

But if you make sure that CS/SS have the same state on SYSRET then
everything should be ok. This means a context switch to a process with
possibly different CS/SS values should be ok.

The GDT is guaranteed to stay constant and SYSCALL forbids use of an
LDT for SS/CS.

I have not actually tried this on an Athlon, but on x86-64 with 
entering long mode it works (including context switches to processes with
different segments etc.)

To add to confusion there are three different all slightly different 
SYSCALL flavours: 

K6 (unusable iirc), Athlon/Hammer with 32bit OS 
(would work, but they have SYSENTER too so it makes sense to just share code 
with Intel), Hammer with 64bit OS (working, has to use SYSCALL from both
32bit and 64bit processes)

They are different in what registers they clobber and how EFLAGS is handled
and some other details.

On x86-64 SYSCALL is the only and native system call entry instruction
for 64bit processes.  The only reason to use SYSCALL from 32bit programs is 
that on a x86-64 SYSENTER from 32bit processes to 64bit kernels is not 
supported, so the 2.5.53 x86-64 kernel implements the AT_SYSINFO vsyscall
page using SYSCALL.

> Is SYSCALL+iretd permitted? That's needed for execve, iopl, task

Yes, it works.

> switches, signal delivery.
> What about interrupts during SYSCALLs? 

SYSCALL in 32bit mode turns off IF on entry (in long mode it is configurable 
using a MSR) 

-Andi
