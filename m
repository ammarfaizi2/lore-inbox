Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267828AbTGIKnc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 06:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265792AbTGIKnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 06:43:32 -0400
Received: from f23.mail.ru ([194.67.57.149]:19719 "EHLO f23.mail.ru")
	by vger.kernel.org with ESMTP id S268201AbTGIKn0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 06:43:26 -0400
From: =?koi8-r?Q?=22?=Kirill Korotaev=?koi8-r?Q?=22=20?= <kksx@mail.ru>
To: =?koi8-r?Q?=22?=Ingo Molnar=?koi8-r?Q?=22=20?= <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [announce, patch] 4G/4G split on x86, 64 GB RAM (and more) support
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.133.213.194]
Date: Wed, 09 Jul 2003 14:58:03 +0400
Reply-To: =?koi8-r?Q?=22?=Kirill Korotaev=?koi8-r?Q?=22=20?= 
	  <kksx@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19aCeB-000ICs-00.kksx-mail-ru@f23.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> yeah - i wrote the 4G/4G patch a couple of weeks ago. I'll send it to lkml
> soon, feel free to comment on it. How does your patch currently look like?

My patch is also ready a couple of weeks ago :))) , but I haven't got
company's permission to publish it yet :((((( And mine is for 2.4.x
kernels... But can be quite easialy adopted for 2.5.x and even for 2.2.x :)))

I have quiete a lot of questions/comments on your patch...
Some of them can be irrelevant since I didn't deal with 2.5.x kernels but I don't think that there are much changes in this part of code.

1. TASK_SIZE, PAGE_OFFSET_USER

I didn't change TASK_SIZE in my patch, since there is a bug in libpthread,
which causes SIGSEGV when java on non-standart kernel split is run :(((
Test it with your kernel pls if not yet. You can find a jbb2000 test in
internet.

2. LDT

a. why have you changed this line? Have you tested your patch with apps using
LDT? I would recommend you to install libc2.5 with TLS support in libpthreads
and insert printk in write_ldt to see if LDT is really used and run a
pthread-aware app, e.g. java.

-		if (unlikely(prev->context.ldt != next->context.ldt))
+		if (unlikely(prev->context.size + next->context.size))

b. As far as I see you are mapping LDT in kernel-space at default addr using
fixmap/kmap, but is LDT mapped in user-space? How LDTs from different processes on different CPUs are non-overlapped?

I triead two solutions with LDT:
- I mapped process's LDT at it's fixed addr both to user-space and
kernel-space and remapped it every time task switch occured, but even though
this addrs were different for different CPUs it didn't work on my machine (no
matter UP/SMP). It worked fine with bochs (x86 emulator), but refused to work
in real life, I think there is some CPU caching which can't be controlled
easialy.
- I tried to reload LDT and  %fs,%gs on returning to user-space, but it
 didn't helped either. And It was quite a messy solution, since fs/gs is
saved/restored in some places in kernel, but I didn't want just simply save
it on kernel-entering and restore on kernel-leaving. So I give up with this
one either...

Now I do as follows:
- I map default_ldt at some fixed addr in all processes, including swapper
(one GLOBAL page)
- I don't change LDT allocation/loading...
- But LDT is allocated via vmalloc, so I changed vmalloc to return addresses
higher than TASK_SIZE (i.e. > 3GB in my case)
- I changed do_page_fault to setup vmalloced pages to current->mm->pgd
 instead of cr3 context.

3. csum_partial_xxx

It looks almost the same, but I plan to optimize it to use get_user_pages()
and to so to avoid double memory access (coping and after that checksumming
=> checksumming with inline copying).

4.  TASK_SIZE

It sounds strange: PAGE_OFFSET_USER. User-space have no offset (=0).
+#define TASK_SIZE	(PAGE_OFFSET_USER)

5. LDT_SIZE

+#define MAX_LDT_PAGES 16
Can be defined as PAGE_ALIGN(LDT_ENTRIES*LDT_ENTRY_SIZE)

6. PAGE_OFFSET

+ * Note: on PAE the kernel must never go below 32 MB, we use the
+ * first 8 entries of the 2-level boot pgd for PAE magic.
Could you please help me to understand where this magic is?
I use now 64Mb offset, but I failed to understand why it refused to boot with
16MB offset (AFAIR even w/o PAE).

7. X_TRAMP_ADDR, TODO: do boot-time code fixups not these runtime fixups.)

I did it another way:
I introduced a new section which is mapped at high addresses in all pgds, and
fit all the entry code from interrupts/exceptions/syscalls there. No
relocations/fixups/trampolines are required with such approach.

8. thread_info.h, /* offsets into the thread_info struct for assembly code
access */

I added offset.c file which is preprocessed first and which generates
 offset.h with offsets to all required struct fields (for me it is: tsk->xxx,
tsk->thread->xxx)

9. entry.S

- %cr3 vs %esp check.
I've found in Intel docs that "movl %cr3, reg" takes a long time (I didn't check it btw myself), so as for me I check esp here, instead of cr3. Your RESTORE_ALL is too long, global vars and markers can be avoided here.
- Why have you cut lcall7/lcall27? Due to call gate doesn't cli interrupts? Bad!! really bad :)
- Better to remove macro call_SYMBOL_NAME_ABS and many other hacks due to code relocation. Use vmlinux.lds to specify code offset.
- Why do you reload %esp every time? It's reload can be avoided as well as reload of cr3 if called from kernel (The problem with NMI is solvable)

10. Bug in init_entry_mappings()?

+BUG_ON(sizeof(struct desc_struct)*NR_CPUS*GDT_ENTRIES > 2*PAGE_SIZE);
AFAIK more than 1 entry per CPU is used (at least in 2.4.x).

11. machine_real_restart()

+       /*
+        * NOTE: this is a wrong 4G/4G PAE assumption. But it will triple
+        * fault the CPU (ie. reboot it) in a guaranteed way so we dont
+        * lose anything but the ability to warm-reboot. (which doesnt
+        * work on those big boxes using 4G/4G PAE anyway.)
+        */
Why do you think that warm-reboot is impossible?
BTW, as for me this path didn't reboot at all until I fixed it. Check your kernel with option "reboot=b"

12. 8MB/16MB startup mapping.

As far as I understand 16MB startup mapping is not required here, am I wrong? Memory is mapped via 4MB pages so only a few pgd/pmd pages (1+4) are required. What else could consume memory so much before we mapped it all?

13. Code style

Don't use magic constants like 8191, 8192 (THREAD_SIZE), 4096 (PAGE_SIZE) or smth like that. Looks wierd.

14.debug regs

do you catch watchpoints on kernel in do_debug()?
Hardware breakpoints are using linear addresses and can be setup'ed by user
 to kernel code... in this case %dr7 should be cleared and restored on
 user-space returning...

15. perfomance

    Have you measured perfomance with your patch?
I found that PAE-enabled kernel executes sys_gettimeofday (I've chosen it for
measuring in my tests) ~2 times slower than non-PAE kernel, and 5.2 times
slower than std kernel.
So for a simple loop with sys_gettimeofday():
PAE 4GB:	3.0 sec
4GB:		1.43 sec
original:	0.57 sec

    But in real-life tests (jbb2000, web-server stress tests) I found that
 4GB splitted kernel perfomance is <1-2% worse than w/o it. Looks very good,
 I think?

WBR, Kirill

