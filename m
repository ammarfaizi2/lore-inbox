Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284045AbRLAKRc>; Sat, 1 Dec 2001 05:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284044AbRLAKRX>; Sat, 1 Dec 2001 05:17:23 -0500
Received: from colorfullife.com ([216.156.138.34]:61446 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S284041AbRLAKRI>;
	Sat, 1 Dec 2001 05:17:08 -0500
Message-ID: <000901c17a51$62526070$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Davide Libenzi" <davidel@xmailserver.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] task_struct colouring ...
Date: Sat, 1 Dec 2001 11:17:25 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> 2) Code clarity
>
I really liked Ben's idea of an include file with macros for asm access to the current pointer.
That was a major improvement for the code clarity. IMHO a patch that changes current
should introduce such a file.

>       unsigned long tskb = __get_free_pages(GFP_KERNEL, 1), tsk;
>      tsk = tskb | ((tskb >> 13) & 0x00000060) | SMP_CACHE_BYTES;
>      *(unsigned long *) tskb = tsk;

You only colour 2 bits (offset 32, 64 or 96 - all within one cacheline on P 4) - I doubt that this
helps a lot. And you do not colour the stack top - all processes sleeping in accept() will still
have their wait queues at the same cache colour. And if you use more bits, you risk
stack overflows.

Which means there are only 2 options for the memory allocation:
- split stack and task structure into 2 independant parts. task struct from slab, stack
    8 kB-colouring.
- switch to 16 kB allocations for stack+task, and then colour both stack and task
    structure.

There are obviously lots of alternatives how to look up the task structure address:
* bottom of stack allocation (your patch)
* %cr2 (broken, only works for OS' that never cause page faults such as Netware)
* gs: (segment register, x86-64 uses that. But i386 doesn't have the swapgs instruction)
* str (Ben's patch)
* read from local apic memory (real slow!, uncached memory reference)

> More, in finding the pointer directly at the base (SP & ~8191UL) makes it
> easy for external programs ( ie gdb ) to seek the task_struct w/out
> knowing the internal math that created it.

Is that a realistic problem? Usually you want to go from task struct to the stack, not the other
way around.

--
    Manfred

