Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268335AbTGIPAv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 11:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268376AbTGIPAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 11:00:51 -0400
Received: from mx1.elte.hu ([157.181.1.137]:57239 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268335AbTGIPAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 11:00:46 -0400
Date: Wed, 9 Jul 2003 17:14:27 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: =?koi8-r?Q?=22?=Kirill Korotaev=?koi8-r?Q?=22=20?= <kksx@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [announce, patch] 4G/4G split on x86, 64 GB RAM (and more)
 support
In-Reply-To: <E19aCeB-000ICs-00.kksx-mail-ru@f23.mail.ru>
Message-ID: <Pine.LNX.4.44.0307091656240.1654-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Jul 2003, [koi8-r] "Kirill Korotaev[koi8-r] "  wrote:

> b. As far as I see you are mapping LDT in kernel-space at default addr
> using fixmap/kmap, but is LDT mapped in user-space? [...]

yes, it is also visible to user-space, otherwise user-space LDT
descriptors would not work. The top 16 MB of virtual memory also hosts the
'virtual LDT'.

> [...] How LDTs from different processes on different CPUs are
> non-overlapped?

the top 16 MB is split up into per-CPU areas, each CPU has its own. Check 
out atomic_kmap.h for details.

> Now I do as follows:
> - I map default_ldt at some fixed addr in all processes, including swapper
> (one GLOBAL page)
> - I don't change LDT allocation/loading...
> - But LDT is allocated via vmalloc, so I changed vmalloc to return addresses
> higher than TASK_SIZE (i.e. > 3GB in my case)
> - I changed do_page_fault to setup vmalloced pages to current->mm->pgd
>  instead of cr3 context.

ugh. I think the LDT mapping scheme in my patch is cleaner and more
robust.

> 6. PAGE_OFFSET
> 
> + * Note: on PAE the kernel must never go below 32 MB, we use the
> + * first 8 entries of the 2-level boot pgd for PAE magic.
>
> Could you please help me to understand where this magic is?
> I use now 64Mb offset, but I failed to understand why it refused to boot with
> 16MB offset (AFAIR even w/o PAE).

on x86 it's not possible to switch into PAE mode and to switch to a new
pagetable, atomically. So when PAE mode is enabled, it has to use the same
pagetable as the 2-level pagetables - if for nothing else but a split
moment. The PAE root pagetable is 4x 8 byte entries (32 bytes) at the %cr3
address. The 2-level root pagetable is 4096 bytes at %cr3. The first 32
bytes thus overlap - these 32 bytes cover 32 MB of RAM. So to keep the
switchover as simple as possible, we have to leave out the first 32 MB.  
(this whole problem could be avoided by writing some trampoline code which
uses temporary pagetables.)


> 7. X_TRAMP_ADDR, TODO: do boot-time code fixups not these runtime fixups.)
> 
> I did it another way: I introduced a new section which is mapped at high
> addresses in all pgds, and fit all the entry code from
> interrupts/exceptions/syscalls there. No relocations/fixups/trampolines
> are required with such approach.

yeah - i'll do something like this too. (Initially i wanted to have a
per-CPU trampoline, but it's not necessary anymore.)

> 9. entry.S
> 
> - %cr3 vs %esp check. I've found in Intel docs that "movl %cr3, reg"
> takes a long time (I didn't check it btw myself), so as for me I check
> esp here, instead of cr3. Your RESTORE_ALL is too long, global vars and
> markers can be avoided here.

sure - but the TLB flush dominates the overhead anyway. I intend to cut
down on the overhead in this path, but there's just so much to be won.

> - Why have you cut lcall7/lcall27? Due to call gate doesn't cli
> interrupts? Bad!! really bad :)

i have cut it because nothing i care about uses it. Feel free to add it
back.

> - Better to remove macro call_SYMBOL_NAME_ABS and many other hacks due
> to code relocation. Use vmlinux.lds to specify code offset.

yeah, agreed.

> - Why do you reload %esp every time? It's reload can be avoided as well
> as reload of cr3 if called from kernel (The problem with NMI is
> solvable)

have you solved the NMI problem? Does it work under load?

> 10. Bug in init_entry_mappings()?
> 
> +BUG_ON(sizeof(struct desc_struct)*NR_CPUS*GDT_ENTRIES > 2*PAGE_SIZE);
> AFAIK more than 1 entry per CPU is used (at least in 2.4.x).

what do you mean?

> Why do you think that warm-reboot is impossible?

it's not impossible, i just didnt fix it yet.

> 12. 8MB/16MB startup mapping.
> 
> As far as I understand 16MB startup mapping is not required here, am I
> wrong? Memory is mapped via 4MB pages so only a few pgd/pmd pages (1+4)
> are required. What else could consume memory so much before we mapped it
> all?

just boot a 64 GB box with mem=nopentium.

> 14.debug regs
> 
> do you catch watchpoints on kernel in do_debug()?
> Hardware breakpoints are using linear addresses and can be setup'ed by user
>  to kernel code... in this case %dr7 should be cleared and restored on
>  user-space returning...

indeed, i'll fix this.

> 15. perfomance
> 
>     Have you measured perfomance with your patch?
> I found that PAE-enabled kernel executes sys_gettimeofday (I've chosen it for
> measuring in my tests) ~2 times slower than non-PAE kernel, and 5.2 times
> slower than std kernel.

yes, i've written about the basic syscall-latency observations.  
(gettimeofday()  latency is very close to null-syscall latency.)

>     But in real-life tests (jbb2000, web-server stress tests) I found
> that 4GB splitted kernel perfomance is <1-2% worse than w/o it. Looks
> very good, I think?

yeah, i've seen similar general real-life impact of 4G/4G, which is good -
but i wanted to point out the worst-case as well.

	Ingo

