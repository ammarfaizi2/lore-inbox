Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269191AbTGJK1V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 06:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269192AbTGJK1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 06:27:21 -0400
Received: from asplinux.ru ([195.133.213.194]:21513 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S269191AbTGJK1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 06:27:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kirill Korotaev <dev@sw.ru>
Organization: SW Soft
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [announce, patch] 4G/4G split on x86, 64 GB RAM (and more) support
Date: Thu, 10 Jul 2003 14:50:42 +0400
User-Agent: KMail/1.4.2
References: <Pine.LNX.4.44.0307091656240.1654-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0307091656240.1654-100000@localhost.localdomain>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200307101450.42340.dev@sw.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > b. As far as I see you are mapping LDT in kernel-space at default addr
> > using fixmap/kmap, but is LDT mapped in user-space? [...]
> yes, it is also visible to user-space, otherwise user-space LDT
> descriptors would not work. The top 16 MB of virtual memory also hosts the
> 'virtual LDT'.
> the top 16 MB is split up into per-CPU areas, each CPU has its own. Check
> out atomic_kmap.h for details.
But you need to remap it every time a switch occurs. Your task switch is very 
much slower a normal one. This reason I don't map per-CPU LDT, only per-CPU 
task structs (2 ptes), which is less than 100 cpu clocks.

> > Now I do as follows:
> > - I map default_ldt at some fixed addr in all processes, including
> > swapper (one GLOBAL page)
> > - I don't change LDT allocation/loading...
> > - But LDT is allocated via vmalloc, so I changed vmalloc to return
> > addresses higher than TASK_SIZE (i.e. > 3GB in my case)
> > - I changed do_page_fault to setup vmalloced pages to current->mm->pgd
> >  instead of cr3 context.
> ugh. I think the LDT mapping scheme in my patch is cleaner and more
> robust.
Not sure. Your patch changes a lot of code which requires a lot of testing. 
Mine changes only 2 lines (do_page_fault (cr3 changes to current->mm->pgd) 
and VMALLOC_START)!

> on x86 it's not possible to switch into PAE mode and to switch to a new
> pagetable, atomically. So when PAE mode is enabled, it has to use the same
> pagetable as the 2-level pagetables - if for nothing else but a split
> moment. The PAE root pagetable is 4x 8 byte entries (32 bytes) at the %cr3
> address. The 2-level root pagetable is 4096 bytes at %cr3. The first 32
> bytes thus overlap - these 32 bytes cover 32 MB of RAM. So to keep the
> switchover as simple as possible, we have to leave out the first 32 MB.
> (this whole problem could be avoided by writing some trampoline code which
> uses temporary pagetables.)
Ugggghhh... You are right. The smallest offset is thus 32Mb :(

> > 9. entry.S
> > - %cr3 vs %esp check. I've found in Intel docs that "movl %cr3, reg"
> > takes a long time (I didn't check it btw myself), so as for me I check
> > esp here, instead of cr3. Your RESTORE_ALL is too long, global vars and
> > markers can be avoided here.
> sure - but the TLB flush dominates the overhead anyway. I intend to cut
> down on the overhead in this path, but there's just so much to be won.
My tests showed me that TLB flush in a hard instruction, but every additional 
instruction influence quite noticebly (~0.2%-0.6%) either.
At least I saw every instruction influence when was measuring gettimeofday 
speed.

> > - Why do you reload %esp every time? It's reload can be avoided as well
> > as reload of cr3 if called from kernel (The problem with NMI is
> > solvable)
> have you solved the NMI problem? Does it work under load?
Yes. I solved it. I do not reload esp and cr3 every time, only when I'm sure 
it requires reloading. And I do not mask interrupts for it via call gates, 
nor do I introduce any magic marks or vars.
It works under load fine, I perfomed quite a big number of long time tests to 
compare perfomance and check stablitiy.
The idea is the following:
1. cr3+esp reloading is not atomic, so we need to guarentee that interrupting 
this sequence should detect it somehow and do reloading again.
2. all task structs are mapped at high addresses 0xffxxxxxx
3. We have two flags indicating that reloading has begun: cr3 and esp.
Whether we finished with reloading or not depends on reloading order.
4. Using previous I decided to reload cr3 and then esp.
5. There 3 situations:
a. we didn't relaod cr3, nor esp
b. we reloaded cr3, but not esp
c. we reloaded both.
Situations a and b require esp reloading. Situation c doesn't require any 
actions.
6. We can detect both situations a and b checking that esp is not higher than 
0xffxxxxxx and overload it if required. When such situations are detected I 
do reload cr3 either. So with some small probability I can reload cr3 twice. 
Not dangerous. If you don't like double cr3-reloads, you can check cr3 
instead of esp, but my tests showed that checking esp gives a bit better 
perfomance and is easier.
7. I do cli before SWITCH+RESTORE_ALL preventing interrupts in this sequence. 
eflags are restore by iret anyway. I.e. interrupts can't interrupt switching 
to user-space, only to kernel-space switching.
8. NMI is special. The only difference is that unlike usual interrupts NMI can 
interrupt returning to user-space either. This is solved easily by saving 
current cr3/esp on enter and restoring them if required on leave ("required" 
== esp >= 0xffxxxxxx).

> just boot a 64 GB box with mem=nopentium.
I think disabling PSE is not a good idea for such amount of memory.
But for 4Kb pages you are right....

Kirill

