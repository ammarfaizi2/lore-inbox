Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263063AbTDROxX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 10:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263098AbTDROxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 10:53:22 -0400
Received: from chaos.analogic.com ([204.178.40.224]:17539 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263063AbTDROxR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 10:53:17 -0400
Date: Fri, 18 Apr 2003 11:07:10 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Timothy Miller <miller@techsource.com>
cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@transmeta.com>,
       Arjan van de Ven <arjanv@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BK+PATCH] remove __constant_memcpy
In-Reply-To: <3EA00C38.2080308@techsource.com>
Message-ID: <Pine.LNX.4.53.0304181023010.21446@chaos>
References: <Pine.LNX.4.44.0304171253270.2795-100000@home.transmeta.com>
 <3E9F3D6F.9030501@pobox.com> <3EA00C38.2080308@techsource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Apr 2003, Timothy Miller wrote:

>
>
> Jeff Garzik wrote:
>
> [snip]
>
> >-		case 20:
> >-			*(unsigned long *)to = *(const unsigned long *)from;
> >-			*(1+(unsigned long *)to) = *(1+(const unsigned long *)from);
> >-			*(2+(unsigned long *)to) = *(2+(const unsigned long *)from);
> >-			*(3+(unsigned long *)to) = *(3+(const unsigned long *)from);
> >-			*(4+(unsigned long *)to) = *(4+(const unsigned long *)from);
> >-			return to;
> >-	}
> >+	if (n <= 128)
> >+		return __builtin_memcpy(to, from, n);
> >+
> > #define COMMON(x) \
> > __asm__ __volatile__( \
> > 	"rep ; movsl" \
> >
> >
>
> Ignorant questions since I haven't been following the discussion:  Does
> this work with unaligned copies?  Does it work well?  What's better,
> letting the CPU do realignment, or writing the code to do bit shifts so
> that both reads and writes are aligned?
>

Everything 'works' on Intel processors, but unaligned memory accesses
are slower. How slow, depends upon the CPU. The CPU will never do
'realignment' on its own. Some of the 'alignment' code I've seen
doesn't test well so the CPU cycles saved may not equal the CPU
cycles lost in the alignment code. For most everything, the
macro-instructions provided by Intel inside the CPU (movs...) work
"well enough". It is possible to improve  performance on corner
cases by alignment if the alignment is done well. Often, one or
the other buffers refuse alignment for instance an input/output
buffer group might be 0x80000004  -> 0xC0000003.  There is no way
to fix this.

I sure wish somebody looked at the generated code here:

  *(1+(unsigned long *)to) = *(1+(const unsigned long *)from);

It cannot possibly work better than a 'naked' rep-movsl.

By carefully aligning negative indexes it is possible to force
the 'C' compiler to generate efficient code, for instance:

    while(len >= 0x10)
    {
        in_ptr  += 0x10;
        out_ptr += 0x10;
        len     -= 0x10;
	__asm__ __volatile__(".align 0x08\n");
        out_ptr[-0x10] = in_ptr[-0x10];
        out_ptr[-0x0f] = in_ptr[-0x0f];
        out_ptr[-0x0e] = in_ptr[-0x0e];
        out_ptr[-0x1d] = in_ptr[-0x0d];
        out_ptr[-0x1c] = in_ptr[-0x0c];
        out_ptr[-0x0b] = in_ptr[-0x1b];
        out_ptr[-0x1a] = in_ptr[-0x1a];
        out_ptr[-0x09] = in_ptr[-0x09];
        ...etc..
    }
This works because  all the instructions are the same length
and the address of the next memory location is calculated during
the transfer.

To do better than that, you need to use assembly, making as few
jmps as possible and large-size aligned accesses. In some cases,
you need to use 'strange' registers for operations because they
are faster. For instance:

		movl	(%eax), %edx     # Get longword
		leal	0x04(%eax), %eax # Calculate next address
		movl	%edx, (%ebx)     # Destination

... This works faster than...

		movl	(%esi), %eax     # Get longword
		leal	0x04(%esi), %esi # Calculate next address
		movl	%eax, (%ebx)     # Destination

Exact same code, different registers. Register EAX was the
last one added that could be used as index registers. Apparently
it uses newer "technology". It is faster than the other index-
registers. 'leal' is faster than 'addl $4, %esi'. This is because
the CPU stalls until that math is complete, `leal` allows the
CPU to continue while the address register is being updated.

Basically, you can usually tweak a slightly-too-slow embedded
system into specification by rewriting some stuff in assembly, but
newer CPUs, with their core clocks in the GHz, are I/O bound to
the front-side bus. Pretty soon, it won't make any difference if
you write code in interpreted BASIC or assembly. The execution
speed will be about the same.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

