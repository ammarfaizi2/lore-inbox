Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274817AbRIUURt>; Fri, 21 Sep 2001 16:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274815AbRIUURj>; Fri, 21 Sep 2001 16:17:39 -0400
Received: from quark.didntduck.org ([216.43.55.190]:61199 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S274810AbRIUURa>; Fri, 21 Sep 2001 16:17:30 -0400
Message-ID: <3BABA061.747A2C57@didntduck.org>
Date: Fri, 21 Sep 2001 16:17:37 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: ddade@digitalstatecraft.com, linux-kernel@vger.kernel.org
Subject: Re: Questions about task, thread, and tss _struct
In-Reply-To: <F196i6i9J1Mm3xFKGqv00002af1@hotmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Donald Dade wrote:
> 
> I have a few points of confusion, and I would deeply appreciate any
> clarifications. They concern the three primary structures task_struct,
> thread_struct, and tss_struct. (in kernel 2.4.x)

task_struct contains architecture independant process information.
thread_struct contains architecture dependant process information.
tss_struct is x86-specific, defined by the hardware.

> 1) I am having a difficult time understanding how tss_struct could be moved
> out of task_struct (per process basis, as one would expect) to a statically
> allocated array (per CPU basis, ???). How can these registers be saved
> across context switches, when there are only as many such structures as
> there are CPUs? I did not follow the explanation in UTLK.

The TSS (Task State Segment) structure is defined by the processor for
hardware task switching.  Earlier versions of Linux on the x86 used one
TSS for each process and used hardware task switching.  This effectively
limited the number of processes to about 500.  We now have one TSS per
cpu, and do software task switching.

> 2) Why the multiple stack pointers and stack segments in tss_struct?

The x86 architecture has 4 priviledge levels (aka rings), with Linux
only using ring 3 (user) and ring 0 (kernel).  When moving to a higher
privilege level (smaller numerically), a new stack pointer is loaded
fron the corresponding pointer in the TSS.

> 3) What is esp0 in thread_struct?

The kernel stack pointer for the current process.  This is copied into
tss->esp0 when the process becomes current on a cpu.

> 4) What are the members suffixed with 'h' in tss_struct? I thought they were
> the segment shadow registers until I saw the member __ldth, because I didn't
> believe that ldt had a shadow register.

Segment registers are only 16 bits.  the __*h values are the high 16
bits that are filler.

> 5) Is there a particular reason for the double underscore convention
> prefixing certain members?

To avoid any namespace collisions.

I suggest that you read the Intel documentation:
http://developer.intel.com/design/pentium4/manuals/245472.htm
In particular Chapter 6 Task Management

--

				Brian Gerst
