Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262535AbTIPWrv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 18:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbTIPWrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 18:47:51 -0400
Received: from animal.blarg.net ([206.124.128.1]:18890 "EHLO animal.blarg.net")
	by vger.kernel.org with ESMTP id S262535AbTIPWrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 18:47:48 -0400
Date: Tue, 16 Sep 2003 15:47:47 -0700
From: Ben Johnson <ben@blarg.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linear vs. logical addresses?  how does cpu interpret kernel addrs?
Message-ID: <20030916154747.A22526@blarg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

short version:

1) When I am referencing a pointer in the kernel, is the value of that
pointer variable interpreted by the cpu as a logical or linear address?

2) if I have two overlapping data/stack segments presently selected,
each with a different base, how does the cpu know which segment/base
address to use to get the linear address?




longer version:

(please stop me if I'm just being stupid.)

As I understand it, logical addresses are interpreted as offsets from
the base address of some current segment descriptor.  in at least the
2.0 kernel the base address of the data segment selected by the
"KERNEL_DS" segment selector is 0xc00000000.  so, to get a linear
address I would do this...

int anything;
ulong linear_anything_addr = ((unsigned long) & anything) + 0xc00000000;

right?


and...

I'm messing with stack segments, trying to give each kernel stack it's
own segment.  (just for kicks.)  I have one data segment with a base
address of 0xc0000000 and a limit of 1GB(4GB?) that I think I use for
all data access.  If I make a stack segment with a base address that
falls within the area governed by the data segment, say the base address
is 0xc00000ff,  what happens when I do something like this?:

struct pt_regs * regs;
unsigned long * stack_pointer;

regs = ((struct pt_regs *) (current->kernel_stack_page + PAGE_SIZE))-1;
stack_pointer = (unsigned long *) regs->esp;
printk( "%ul", *stack_pointer );   /* what is this pointing to? */


So, what I'm thinking here is that the value of %%esp is treated as an
offset from the base address of the stack segment, 0xc00000ff, but when
I use it in a non-stack oriented context, it's possibly treated as an
offset from some other segment's base address.  how does the cpu choose
which segment to use?

Thanks a lot.

- Ben

