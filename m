Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280434AbRKJEiS>; Fri, 9 Nov 2001 23:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280460AbRKJEiJ>; Fri, 9 Nov 2001 23:38:09 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:9737 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S280434AbRKJEhv>;
	Fri, 9 Nov 2001 23:37:51 -0500
Date: Sat, 10 Nov 2001 14:35:58 +1100
From: Anton Blanchard <anton@samba.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives?
Message-ID: <20011110143557.A767@krispykreme>
In-Reply-To: <20011109105921.A6822@krispykreme> <7462.1005282683@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7462.1005282683@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> Is that TOC save and restore just for module code or does it apply to
> all calls through function pointers?
>
> On IA64, R1 (global data pointer) must be saved and restored on all
> calls through function pointers, even if both the caller and callee are
> in the kernel.  You might know that this is a kernel to kernel call but
> gcc does not so it has to assume the worst.  This is not a module
> problem, it affects all indirect function calls.

Yep all indirect function calls require save and reload of the TOC
(which is r2):

std     r2,40(r1)
mtctr   r0
ld      r2,8(r9)
bctrl			# function call

When calling a function in the kernel from within the kernel (eg printk),
we dont have to save and reload the TOC:

000014ec bl .printk
000014f0 nop

Alan Modra tells me the linker does the fixup of nop -> r2 reload. So
in this case it isnt needed.

However when we do the same printk from a module, the nop is replaced
with an r2 reload:

000014ec  bl	0x2f168		# call trampoline
000014f0  ld	r2,40(r1)

And because we have to load the new TOC for the call to printk, it is
done in a small trampoline. (r12 is a pointer to the function descriptor
for printk which contains 3 values, 1. the function address, 2. the TOC,
ignore the 3rd)

0002f168  ld	r12,-32456(r2)
0002f16c  std	r2,40(r1)
0002f170  ld	r0,0(r12)
0002f174  ld	r2,8(r12)
0002f178  mtctr	r0
0002f17c  bctr			# call printk

So the trampoline and r2 restore is the overhead Im talking about :)

btw the trampoline is also required because of the limited range of
relative branches on ppc. So ppc32 also has an overhead except it is
smaller because it doesnt need the TOC juggling.

Anton
