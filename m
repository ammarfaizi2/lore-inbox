Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317865AbSHUMTZ>; Wed, 21 Aug 2002 08:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318263AbSHUMTZ>; Wed, 21 Aug 2002 08:19:25 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:63637 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317865AbSHUMTX>;
	Wed, 21 Aug 2002 08:19:23 -0400
Date: Wed, 21 Aug 2002 18:03:33 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (re-xmit): kprobes for i386
Message-ID: <20020821180333.A1227@in.ibm.com>
Reply-To: vamsi@in.ibm.com
References: <20020821140155.A987@in.ibm.com> <20020821055103.121A62C05E@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020821055103.121A62C05E@lists.samba.org>; from rusty@rustcorp.com.au on Wed, Aug 21, 2002 at 08:48:44PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty,

On Wed, Aug 21, 2002 at 08:48:44PM +1000, Rusty Russell wrote:
> In message <20020821140155.A987@in.ibm.com> you write:
> > No. Don't do this. When a trap occurs in kernel space, the
> 
> Sorry Vamsi: I'll have more faith in your code next time, I promise.
> 
Thanks :-). But, I think you forgot to apply my incremental patch. 
Here it is:

Thanks again,
Vamsi.
-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi@in.ibm.com
--
diff -u 31-dp/arch/i386/kernel/entry.S 31-dp/arch/i386/kernel/entry.S
--- 31-dp/arch/i386/kernel/entry.S	2002-08-21 11:20:18.000000000 +0530
+++ 31-dp/arch/i386/kernel/entry.S	2002-08-21 12:10:30.000000000 +0530
@@ -430,7 +430,7 @@
 	jmp ret_from_exception
 
 ENTRY(debug)
-	pushl %eax
+	pushl $-1			# mark this as an int
 	SAVE_ALL
 	movl %esp,%edx
 	pushl $0
@@ -452,7 +452,7 @@
 	RESTORE_ALL
 
 ENTRY(int3)
-	pushl %eax
+	pushl $-1			# mark this as an int
 	SAVE_ALL
 	movl %esp,%edx
 	pushl $0
diff -u 31-dp/arch/i386/kernel/kprobes.c 31-dp/arch/i386/kernel/kprobes.c
--- 31-dp/arch/i386/kernel/kprobes.c	2002-08-21 11:20:18.000000000 +0530
+++ 31-dp/arch/i386/kernel/kprobes.c	2002-08-21 12:09:50.000000000 +0530
@@ -117,11 +117,12 @@
 	/*
 	 * We singlestepped with interrupts disabled. So, the result on
 	 * the stack would be incorrect for "pushfl" instruction.
+	 * Note that regs->esp is actually the top of the stack when the
+	 * trap occurs in kernel space.
 	 */
 	if (current_kprobe->opcode == 0x9c) { /* pushfl */
-		unsigned long *stacktop = (unsigned long *)regs->esp;
-		*stacktop &= ~(TF_MASK | IF_MASK);
-		*stacktop |= kprobe_old_eflags;
+		regs->esp &= ~(TF_MASK | IF_MASK);
+		regs->esp |= kprobe_old_eflags;
 	}
 
 	rearm_kprobe(current_kprobe, regs);
diff -u 31-dp/include/linux/kprobes.h 31-dp/include/linux/kprobes.h
--- 31-dp/include/linux/kprobes.h	2002-08-21 11:20:18.000000000 +0530
+++ 31-dp/include/linux/kprobes.h	2002-08-21 12:30:24.000000000 +0530
@@ -2,6 +2,8 @@
 #define _LINUX_KPROBES_H
 #include <linux/config.h>
 #include <linux/list.h>
+#include <linux/notifier.h>
+#include <linux/smp.h>
 #include <asm/kprobes.h>
 
 struct kprobe;
