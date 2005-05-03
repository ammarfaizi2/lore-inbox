Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbVECLev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVECLev (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 07:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVECLev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 07:34:51 -0400
Received: from mailfe06.swip.net ([212.247.154.161]:46764 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261478AbVECLep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 07:34:45 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: 2.6.12-rc3 OOPS  in vanilla source (once more)
From: Alexander Nyberg <alexn@telia.com>
To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org
Cc: Mateusz Berezecki <mateuszb@gmail.com>, linux-kernel@vger.kernel.org,
       zwane@arm.linux.org.uk, stsp@aknet.ru
In-Reply-To: <20050502200545.266b4e55.akpm@osdl.org>
References: <42763388.1030008@gmail.com>
	 <20050502200545.266b4e55.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 03 May 2005 13:34:10 +0200
Message-Id: <1115120050.945.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > i send it once more....
> > 
> >  May  2 12:56:31 localhost kernel: Unable to handle kernel NULL pointer 
> >  dereference at virtual address 00000000

Ok I think I have this sucker all sorted out now. The recent change
fix-crash-in-entrys-restore_all.patch

 25-akpm/arch/i386/kernel/process.c	2005-04-10 15:31:38.000000000 -0700
@@ -405,7 +405,7 @@ int copy_thread(int nr, unsigned long cl
 	childregs->esp = esp;
 
 	p->thread.esp = (unsigned long) childregs;
-	p->thread.esp0 = (unsigned long) (childregs+1);
+	p->thread.esp0 = (unsigned long) (childregs+1) - 8;
 
 	p->thread.eip = (unsigned long) ret_from_fork;

introduces an inconsistency between esp and esp0 before the task is run
the first time. esp0 is no longer the actual start of the stack, but 8
bytes off.

This shows itself clearly in a scenario when a ptracer that is set to
also ptrace eventual children traces program1 which then clones thread1.
Now the ptracer wants to modify the registers of thread1. The x86 ptrace
implementation bases it's knowledge about saved user-space registers
upon p->thread.esp0. But this will be a few bytes off causing certain
writes to the kernel stack to overwrite a saved kernel function address
making the kernel when actually running thread1 jump out into
user-space. Very spectacular.

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
inconsitent state I adjust where the user-space registers are saved with
-8 bytes. This gives us the wanted extra bytes on the start of the stack
and esp0 is now correct. This solves the issues I saw from the original
testcase from Mateusz Berezecki and has survived testing here. I think
this should go into -mm a round or two first however as there might be
some cruft around depending on pt_regs lying on the start of the stack.
That however would have broken with the first change too!

It's actually a 2-line diff but I had to move the comment of why the -8 bytes 
are there a few lines up. Thanks to Zwane for helping me with this.


Signed-off-by: Alexander Nyberg <alexn@telia.com>

Index: latest/arch/i386/kernel/process.c
===================================================================
--- latest.orig/arch/i386/kernel/process.c	2005-04-30 15:44:02.000000000 +0200
+++ latest/arch/i386/kernel/process.c	2005-05-03 12:54:16.000000000 +0200
@@ -400,11 +400,6 @@
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
@@ -415,7 +410,13 @@
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
 


