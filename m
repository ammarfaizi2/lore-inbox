Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVC0WYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVC0WYr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 17:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVC0WYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 17:24:36 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:32462 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261605AbVC0WYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 17:24:08 -0500
Date: Sun, 27 Mar 2005 14:24:06 -0800
From: "H. J. Lu" <hjl@lucon.org>
To: binutils@sources.redhat.com, GNU C Library <libc-alpha@sources.redhat.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: i386/x86_64 segment register issuses (Re: PATCH: Fix x86 segment register access)
Message-ID: <20050327222406.GA6435@lucon.org>
References: <20050326020506.GA8068@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050326020506.GA8068@lucon.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that 2.4 kernel has

arch/i386/kernel/process.c:     asm volatile("movl %%" #seg ",%0":"=m" (*(int *)&(value)))
arch/i386/kernel/process.c:     asm volatile("movl %%fs,%0":"=m" (*(int *)&prev->fs));
arch/i386/kernel/process.c:     asm volatile("movl %%gs,%0":"=m" (*(int *)&prev->gs));
arch/x86_64/kernel/process.c:   asm("movl %%gs,%0" : "=m" (p->thread.gsindex));
arch/x86_64/kernel/process.c:   asm("movl %%fs,%0" : "=m" (p->thread.fsindex));
arch/x86_64/kernel/process.c:   asm("movl %%es,%0" : "=m" (p->thread.es));
arch/x86_64/kernel/process.c:   asm("movl %%ds,%0" : "=m" (p->thread.ds));
arch/x86_64/kernel/process.c:   asm volatile("movl %%es,%0" : "=m" (prev->es));
arch/x86_64/kernel/process.c:   asm volatile ("movl %%ds,%0" : "=m" (prev->ds));

2.6 kernel has

arch/i386/kernel/process.c:     asm volatile("movl %%fs,%0":"=m" (*(int *)&prev->fs));
arch/i386/kernel/process.c:     asm volatile("movl %%gs,%0":"=m" (*(int *)&prev->gs));
arch/x86_64/kernel/process.c:   asm("movl %%gs,%0" : "=m" (p->thread.gsindex));
arch/x86_64/kernel/process.c:   asm("movl %%fs,%0" : "=m" (p->thread.fsindex));
arch/x86_64/kernel/process.c:   asm("movl %%es,%0" : "=m" (p->thread.es));
arch/x86_64/kernel/process.c:   asm("movl %%ds,%0" : "=m" (p->thread.ds));
arch/x86_64/kernel/process.c:   asm volatile("movl %%es,%0" : "=m" (prev->es));
arch/x86_64/kernel/process.c:   asm volatile ("movl %%ds,%0" : "=m" (prev->ds));
arch/x86_64/kernel/process.c:           asm volatile("movl %%fs,%0" : "=g" (fsindex));
arch/x86_64/kernel/process.c:           asm volatile("movl %%gs,%0" : "=g" (gsindex));

The new assembler will disallow them since those instructions with
memory operand will only use the first 16bits. If the memory operand
is 16bit, you won't see any problems. But if the memory destinatin
is 32bit, the upper 16bits may have random values. The new assembler
will force people to use

	mov (%eax),%ds
	movw (%eax),%ds
	movw %ds,(%eax)
	mov %ds,(%eax)

Will it be a big problem for kernel people?

BTW, I haven't checked glibc yet. It may have similar issues.

H.J.
---
On Fri, Mar 25, 2005 at 06:05:06PM -0800, H. J. Lu wrote:
> X86 segment register access is a special. We can move between a segment
> register and a 16/32/64bit general-purpose register. But we can only
> move between a segment register and a 16bit memory address. The current
> assembler allows "movl (%eax),%ds", but doesn't allow "movq %rax,%ds".
> The disassembler display "movl (%eax),%ds". This patch tries to fix
> those.
> 
> 
> H.J.
> ----
> gas/testsuite/
> 
> 2005-03-25  H.J. Lu  <hongjiu.lu@intel.com>
> 
> 	* gas/i386/i386.exp: Run segment and inval-seg for i386. Run
> 	x86-64-segment and x86-64-inval-seg for x86-64.
> 
> 	* gas/i386/intel.d: Expect movw for moving between memory and
> 	segment register.
> 	* gas/i386/naked.d: Likewise.
> 	* gas/i386/opcode.d: Likewise.
> 	* gas/i386/x86-64-opcode.d: Likewise.
> 
> 	* gas/i386/opcode.s: Use movw for moving between memory and
> 	segment register.
> 	* gas/i386/x86-64-opcode.s: Likewise.
> 
> 	* : Likewise.
> 
> 	* gas/i386/inval-seg.l: New.
> 	* gas/i386/inval-seg.s: New.
> 	* gas/i386/segment.l: New.
> 	* gas/i386/segment.s: New.
> 	* gas/i386/x86-64-inval-seg.l: New.
> 	* gas/i386/x86-64-inval-seg.s: New.
> 	* gas/i386/x86-64-segment.l: New.
> 	* gas/i386/x86-64-segment.s: New.
> 
> include/opcode/
> 
> 2005-03-25  H.J. Lu  <hongjiu.lu@intel.com>
> 
> 	* i386.h (i386_optab): Don't allow the `l' suffix for moving
> 	moving between memory and segment register. Allow movq for
> 	moving between general-purpose register and segment register.
> 
> opcodes/
> 
> 2005-03-25  H.J. Lu  <hongjiu.lu@intel.com>
> 
> 	* i386-dis.c (SEG_Fixup): New.
> 	(Sv): New.
> 	(dis386): Use "Sv" for 0x8c and 0x8e.
> 
