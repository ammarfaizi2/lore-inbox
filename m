Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbVE0PWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbVE0PWP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 11:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbVE0PWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 11:22:15 -0400
Received: from mailfe08.swip.net ([212.247.154.225]:28604 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261807AbVE0PWC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 11:22:02 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: [OOPS] 2.6.12-rc3 ptrace bug?
From: Alexander Nyberg <alexn@telia.com>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>
In-Reply-To: <20050527170209.59355a59@laptop.hypervisor.org>
References: <20050527170209.59355a59@laptop.hypervisor.org>
Content-Type: text/plain
Date: Fri, 27 May 2005 17:22:00 +0200
Message-Id: <1117207320.950.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fre 2005-05-27 klockan 17:02 +0200 skrev Udo A. Steinberg:
> The attached (radically shortened) program to measure pipe performance oopses
> the Linux-2.6.12-rc3 kernel when traced using "strace -f". The problem no longer
> occurs in -rc4 or -rc5. It would be good to know whether the bug causing the
> problem is known and has been fixed or simply went away due to other changes.
> I have been unable to find a Changelog detailing the patches that went
> into -rc4.
> 
> The bug is reproducible on all -rc3 kernels I've tried.

Yeah it is known and fixed:

tree 8eece0b3fd959622afdef405dc42dc4a6b63efe7
parent 47c297529bd23d93d2a088d9620bb220763e9cb1
author Alexander Nyberg <alexn@telia.com> Fri, 06 May 2005 06:15:03 -0700
committer Linus Torvalds <torvalds@ppc970.osdl.org> Fri, 06 May 2005 06:36:30 -0700

[PATCH] x86 stack initialisation fix

The recent change fix-crash-in-entrys-restore_all.patch

 	childregs->esp = esp;

 	p->thread.esp = (unsigned long) childregs;
-	p->thread.esp0 = (unsigned long) (childregs+1);
+	p->thread.esp0 = (unsigned long) (childregs+1) - 8;

 	p->thread.eip = (unsigned long) ret_from_fork;

introduces an inconsistency between esp and esp0 before the task is run the
first time.  esp0 is no longer the actual start of the stack, but 8 bytes
off.

This shows itself clearly in a scenario when a ptracer that is set to also
ptrace eventual children traces program1 which then clones thread1.  Now
the ptracer wants to modify the registers of thread1.  The x86 ptrace
implementation bases it's knowledge about saved user-space registers upon
p->thread.esp0.  But this will be a few bytes off causing certain writes to
the kernel stack to overwrite a saved kernel function address making the
kernel when actually running thread1 jump out into user-space.  Very
spectacular.

The testcase I've used is:
/* start with strace -f ./a.out */
#include <pthread.h>
#include <stdio.h>

void *do_thread(void *p)
{
	for (;;);
}

int main()
{
	pthread_t one;
	pthread_create(&one, NULL, &do_thread, NULL);
	for (;;);
	return 0;
}

So, my solution is to instead of just adjusting esp0 that creates an
inconsitent state I adjust where the user-space registers are saved with -8
bytes.  This gives us the wanted extra bytes on the start of the stack and
esp0 is now correct.  This solves the issues I saw from the original
testcase from Mateusz Berezecki and has survived testing here.  I think
this should go into -mm a round or two first however as there might be some
cruft around depending on pt_regs lying on the start of the stack.  That
however would have broken with the first change too!

It's actually a 2-line diff but I had to move the comment of why the -8 bytes
are there a few lines up. Thanks to Zwane for helping me with this.

Signed-off-by: Alexander Nyberg <alexn@telia.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>

 i386/kernel/process.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

Index: arch/i386/kernel/process.c
===================================================================
--- 52672d42102a4d0c8b4fc13b79812290efbd5d3a/arch/i386/kernel/process.c  (mode:100644 sha1:85bd56d4431417836a1b6c3992d57bf36e9186ca)
+++ 8eece0b3fd959622afdef405dc42dc4a6b63efe7/arch/i386/kernel/process.c  (mode:100644 sha1:96e3ea6b17c7b989c1bafb3c1ce87f7768348693)
@@ -400,11 +400,6 @@ int copy_thread(int nr, unsigned long cl
 	int err;
 
 	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
-	*childregs = *regs;
-	childregs->eax = 0;
-	childregs->esp = esp;
-
-	p->thread.esp = (unsigned long) childregs;
 	/*
 	 * The below -8 is to reserve 8 bytes on top of the ring0 stack.
 	 * This is necessary to guarantee that the entire "struct pt_regs"
@@ -415,7 +410,13 @@ int copy_thread(int nr, unsigned long cl
 	 * "struct pt_regs" is possible, but they may contain the
 	 * completely wrong values.
 	 */
-	p->thread.esp0 = (unsigned long) (childregs+1) - 8;
+	childregs = (struct pt_regs *) ((unsigned long) childregs - 8);
+	*childregs = *regs;
+	childregs->eax = 0;
+	childregs->esp = esp;
+
+	p->thread.esp = (unsigned long) childregs;
+	p->thread.esp0 = (unsigned long) (childregs+1);
 
 	p->thread.eip = (unsigned long) ret_from_fork;
 
-
To unsubscribe from this list: send the line "unsubscribe bk-commits-head" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


