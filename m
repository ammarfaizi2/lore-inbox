Return-Path: <linux-kernel-owner+w=401wt.eu-S932323AbWLLSUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWLLSUe (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 13:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWLLSUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 13:20:34 -0500
Received: from smtp.osdl.org ([65.172.181.25]:53168 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932323AbWLLSUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 13:20:33 -0500
Date: Tue, 12 Dec 2006 10:20:19 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: LKML Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Mach-O binary format support and Darwin syscall personality
 [Was: uts banner changes]
In-Reply-To: <D571C4CB-3D52-446C-802E-024C4C333562@mac.com>
Message-ID: <Pine.LNX.4.64.0612121008490.3535@woody.osdl.org>
References: <457D750C.9060807@shadowen.org> <20061211163333.GA17947@aepfle.de>
 <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org>
 <Pine.LNX.4.64.0612110852010.12500@woody.osdl.org> <20061211180414.GA18833@aepfle.de>
 <20061211181813.GB18963@aepfle.de> <Pine.LNX.4.64.0612111022140.12500@woody.osdl.org>
 <320BD259-74D6-411F-82A4-4BF3CB15012F@mac.com> <Pine.LNX.4.64.0612120815550.6452@woody.osdl.org>
 <D571C4CB-3D52-446C-802E-024C4C333562@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Dec 2006, Kyle Moffett wrote:
> 
> Virtually all of my easily accessible computers right now are PowerPC and all
> of my assembly experience is PPC and MIPS, so as far as the x86-syscall
> support I have no clue whatsoever.

Ok. On ppc, the issues are perhaps a bit more straightforward, because 
there is really just one way to do system calls: "sc".

That said, powerpc simply doesn't historically do any system call 
translation, so you'll just have to implement the same kind of translation 
layer that sparc has done, for example.

See: DoSyscall in arch/powerpc/kernel/entry_32.S. Right now it just does

		...
		cmplwi  0,r0,NR_syscalls
	        lis     r10,sys_call_table@h
	        ori     r10,r10,sys_call_table@l
	        slwi    r0,r0,2
	        bge-    66f
	        lwzx    r10,r10,r0      /* Fetch system call handler [ptr] */
	        mtlr    r10
	        addi    r9,r1,STACK_FRAME_OVERHEAD
	        PPC440EP_ERR42
	        blrl                    /* Call handler */
	        .globl  ret_from_syscall
	ret_from_syscall:
		...

ie it uses one global table ("sys_call_table" and "NR_syscalls") for 
everything, and you'd need to make it use different tables (and table 
sizes) conditionally on the "Apple binary flag"

Alternatively, you could perhaps fit it in the exception table itself 
(arch/powerpc/kernel/entry.S), but that gets just nastier and more 
low-level, so I doubt it's all that great an idea.

> So I guess all I have to do is:
>  (A)  Write a bunch of new syscall handlers taking arguments of the same types
> as the Darwin syscall handlers,

Yes. The big issue tends to be to translate all the errno's and the fcntl 
structure pointers etc. THAT can be quite painful indeed. You might ask 
David Miller and company about their SunOS stuff, and look at things like

	arch/sparc/kernel/{sys_sunos.c,sunos_ioctl.c}

for some sorry examples.

>  (B)  Figure out how to switch tables depending on the "syscall personality"
> of "current"

See above. "DoSyscall" is where you enter.

		Linus
