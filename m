Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266753AbUJAWJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266753AbUJAWJy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 18:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266786AbUJAWHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 18:07:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:12521 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266753AbUJAWFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 18:05:22 -0400
Date: Fri, 1 Oct 2004 15:08:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kirill Korotaev <dev@sw.ru>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Fix of stack dump in {SOFT|HARD}IRQs
Message-Id: <20041001150834.76e037b6.akpm@osdl.org>
In-Reply-To: <415D36AA.3000907@sw.ru>
References: <415D36AA.3000907@sw.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> wrote:
>
> This patch fixes incorrect check for stack ptr in 
> show_trace()->valid_stack_ptr(). When called from hardirq/softirq 
> show_trace() prints "Stack pointer is garbage, not printing trace" 
> message instead of call traces.

Thanks for fixing that up.

In future, please ensure that patches are in `patch -p1' form, as described
in http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt.

And please don't declare external functions in .c files - it defeats
compiler typechecking.  I'll use the below fixup for that.

--- 25/arch/i386/kernel/irq.c~fix-of-stack-dump-in-soft-hardirqs-cleanup	Fri Oct  1 15:05:24 2004
+++ 25-akpm/arch/i386/kernel/irq.c	Fri Oct  1 15:05:45 2004
@@ -10,12 +10,14 @@
  * io_apic.c.)
  */
 
-#include <asm/uaccess.h>
 #include <linux/module.h>
 #include <linux/seq_file.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
 
+#include <asm/uaccess.h>
+#include <asm/hardirq.h>
+
 #ifdef CONFIG_4KSTACKS
 /*
  * per-CPU IRQ handling contexts (thread information and stack)
diff -puN arch/i386/kernel/traps.c~fix-of-stack-dump-in-soft-hardirqs-cleanup arch/i386/kernel/traps.c
--- 25/arch/i386/kernel/traps.c~fix-of-stack-dump-in-soft-hardirqs-cleanup	Fri Oct  1 15:05:24 2004
+++ 25-akpm/arch/i386/kernel/traps.c	Fri Oct  1 15:06:01 2004
@@ -50,6 +50,7 @@
 #include <asm/smp.h>
 #include <asm/arch_hooks.h>
 #include <asm/kdebug.h>
+#include <asm/hardirq.h>
 
 #include <linux/irq.h>
 #include <linux/module.h>
@@ -107,8 +108,6 @@ int register_die_notifier(struct notifie
 
 static int valid_stack_ptr(struct task_struct *task, void *p)
 {
-	extern int is_irq_stack_ptr(struct task_struct *, void *);
-
 	if (is_irq_stack_ptr(task, p))
 		return 1;
 	if (p >= (void *)task->thread_info &&
diff -puN include/asm-i386/hardirq.h~fix-of-stack-dump-in-soft-hardirqs-cleanup include/asm-i386/hardirq.h
--- 25/include/asm-i386/hardirq.h~fix-of-stack-dump-in-soft-hardirqs-cleanup	Fri Oct  1 15:05:24 2004
+++ 25-akpm/include/asm-i386/hardirq.h	Fri Oct  1 15:06:29 2004
@@ -36,4 +36,7 @@ static inline void ack_bad_irq(unsigned 
 #endif
 }
 
+struct task_struct;
+int is_irq_stack_ptr(struct task_struct *task, void *p);
+
 #endif /* __ASM_HARDIRQ_H */
_

