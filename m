Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262085AbTCZUWJ>; Wed, 26 Mar 2003 15:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262087AbTCZUWJ>; Wed, 26 Mar 2003 15:22:09 -0500
Received: from chaos.analogic.com ([204.178.40.224]:29583 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262085AbTCZUWG>; Wed, 26 Mar 2003 15:22:06 -0500
Date: Wed, 26 Mar 2003 15:36:22 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: ravikumar.chakaravarthy@amd.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to turn paging on!!
In-Reply-To: <99F2150714F93F448942F9A9F112634CA54B3A@txexmtae.amd.com>
Message-ID: <Pine.LNX.4.53.0303261521030.2136@chaos>
References: <99F2150714F93F448942F9A9F112634CA54B3A@txexmtae.amd.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Mar 2003 ravikumar.chakaravarthy@amd.com wrote:

> I tweaked the kernel and boot loader to load the kernel at 0xdf000000,
> physical address. I did the following changes to setup the
> initial page table.
>
> However during boot, in arch/i386/kernel/head.S when the paging bit is set
>        movl %eax,%cr0          /* ..and set paging (PG) bit */
>
> My computer hangs!!
>
> Any idea why??
>
>   -Ravi
[SNIPPED...]
Because you can't just abitrarily change stuff around. For instance,
The PTE must be accessible as well as the GTD and the IDT when you
enable paging. In your code, you just mapped them out!
When you change the mapping, there MUST be a 1:1 physical to virtual
relationship for these descriptors. That's why they are in "low" memory.

To make this clear, let's assume you are running normally and you
want to turn the paging off. If you are at a normal virtual address,
you can't do that without crashing. You need to jump (or call) somewhere
that the physical and the virtual address are the same. Then you can
turn off paging (as long as you don't get any interrupts). Once
your EIP is at an address where there is a 1:1 correspondence
between a physical and virtual address, you can turn this off at
will. You need to turn it on before you "return".

There is nothing "magic" about low memory. You could build the GDT,
the IDT, and PTEs at 0xfff00000 and as long at the PTEs did a 1:1
mapping for this address __and__ your code that executed the mov CR0
instruction was up where there is a 1:1 mapping for the code, too.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

