Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264857AbTBTEpr>; Wed, 19 Feb 2003 23:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264863AbTBTEpr>; Wed, 19 Feb 2003 23:45:47 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:31750 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264857AbTBTEpo>; Wed, 19 Feb 2003 23:45:44 -0500
Date: Wed, 19 Feb 2003 20:52:46 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>
cc: Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Ingo Molnar <mingo@elte.hu>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous
 reboots)
In-Reply-To: <Pine.LNX.4.50.0302192113480.10247-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.44.0302192039400.1453-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Feb 2003, Zwane Mwaikambo wrote:
>
> 	Here is a triple fault case (2.5.62-pgcl) and since i'm not a Real 
> Man i had to use a simulator ;) Unfortunately i can't unwind the stack.

Well, the reason you can't unwind the stack is the same reason you got the 
double fault: the stack pointer is crap.

> Freeing unused kernel memory: 100k freed
> double fault, gdt at c0268020 [255 bytes]
> double fault, tss at c027d800
> eip = c01181c4, esp = f7f9bf90
> eax = c0003dfc, ebx = ffffffff, ecx = 0000007b, edx = f7f9c04c
> esi = 00000003, edi = c01181b0

Whee. So the double-fault patch actually ends up being useful? It didn't 
help with Chris' problem, but hey, if it helps with something else..

Anyway, that %esp is crap, which also explains this:

> 0xc01181c4 <do_page_fault+20>:  mov    %eax,0xc(%esp,1)

Took a page fault because 0xc(%esp) wasn't there, and the page fault 
couldn't write the fault trace to the stack (same reason), so you got a 
double fault.

Anyway, it's hard to try to re-create any state from the above. Very few 
clues about why the stack pointer is so messed up, but _usually_ a messed 
up stack pointer is because the stack itself got hammered, and then the 
stack pointer gets corrupted when somebody restores it off the stack (ie 
the normal 

	movl %ebp,%esp
	popl %ebp
	ret

kind of epilogue thing).

You could try to make the double-fault handler print out more information, 
suggested starting point something like the following: the stack pointer 
is corrupted, but we know what the original top-of-stack was (esp0), so we 
could print out part of that stack to get a guess about what it was doing 
when it all went south..

			Linus

------

===== arch/i386/kernel/doublefault.c 1.1 vs edited =====
--- 1.1/arch/i386/kernel/doublefault.c	Wed Feb 19 17:48:55 2003
+++ edited/arch/i386/kernel/doublefault.c	Wed Feb 19 20:50:47 2003
@@ -33,13 +33,26 @@
 
 		if (ptr_ok(tss)) {
 			struct tss_struct *t = (struct tss_struct *)tss;
+			unsigned long esp0 = t->esp0;
 
 			printk("eip = %08lx, esp = %08lx\n", t->eip, t->esp);
 
 			printk("eax = %08lx, ebx = %08lx, ecx = %08lx, edx = %08lx\n",
 				t->eax, t->ebx, t->ecx, t->edx);
-			printk("esi = %08lx, edi = %08lx\n",
-				t->esi, t->edi);
+			printk("esi = %08lx, edi = %08lx, %ebp = %08lx\n",
+				t->esi, t->edi, t->ebp);
+
+			/*
+			 * We could print out the stack contents here: esp0
+			 * is the beginning of the stack, we could print out
+			 * all the code points we can find underneath it or
+			 * something.. 
+			 */
+		
+			/* This might be a point to try to kill the process and clean up */
+			t->esp = esp0;
+			t->eip = (unsigned long) do_exit;
+			asm volatile("iret");
 		}
 	}
 

