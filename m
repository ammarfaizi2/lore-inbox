Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319455AbSIGITy>; Sat, 7 Sep 2002 04:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319456AbSIGITy>; Sat, 7 Sep 2002 04:19:54 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:21767 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S319455AbSIGITw>; Sat, 7 Sep 2002 04:19:52 -0400
Date: Sat, 7 Sep 2002 12:24:17 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>,
       Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5.33] alpha: compile fixes
Message-ID: <20020907122417.B17245@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- add another argument to do_fork();
- assorted compile fixes.

Ivan.

--- 2.5.33/arch/alpha/kernel/smp.c	Sun Sep  1 02:04:54 2002
+++ linux/arch/alpha/kernel/smp.c	Wed Sep  4 17:11:38 2002
@@ -432,7 +432,7 @@ fork_by_hand(void)
 	/* Don't care about the contents of regs since we'll never
 	   reschedule the forked task. */
 	struct pt_regs regs;
-	return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0);
+	return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL);
 }
 
 /*
--- 2.5.33/arch/alpha/kernel/process.c	Sun Sep  1 02:04:55 2002
+++ linux/arch/alpha/kernel/process.c	Thu Sep  5 21:17:57 2002
@@ -261,11 +261,13 @@ alpha_clone(unsigned long clone_flags, u
 	    struct switch_stack * swstack)
 {
 	struct task_struct *p;
+	struct pt_regs *u_regs = (struct pt_regs *) (swstack+1);
+	int *user_tid = (int *)u_regs->r19;
+
 	if (!usp)
 		usp = rdusp();
 
-	p = do_fork(clone_flags & ~CLONE_IDLETASK,
-		    usp, (struct pt_regs *) (swstack+1), 0);
+	p = do_fork(clone_flags & ~CLONE_IDLETASK, usp, u_regs, 0, user_tid);
 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
@@ -274,7 +276,7 @@ alpha_vfork(struct switch_stack * swstac
 {
 	struct task_struct *p;
 	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, rdusp(),
-		    (struct pt_regs *) (swstack+1), 0);
+		    (struct pt_regs *) (swstack+1), 0, NULL);
 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
--- 2.5.33/arch/alpha/kernel/irq.c	Sun Sep  1 02:05:31 2002
+++ linux/arch/alpha/kernel/irq.c	Wed Sep  4 20:59:56 2002
@@ -12,11 +12,11 @@
 
 #include <linux/config.h>
 #include <linux/kernel.h>
-#include <linux/ptrace.h>
 #include <linux/errno.h>
 #include <linux/kernel_stat.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
+#include <linux/ptrace.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/random.h>
--- 2.5.33/arch/alpha/Makefile	Sun Sep  1 02:04:48 2002
+++ linux/arch/alpha/Makefile	Wed Sep  4 18:41:53 2002
@@ -128,6 +128,9 @@ archmrproper:
 
 vmlinux: arch/alpha/vmlinux.lds.s
 
+arch/$(ARCH)/vmlinux.lds.s: arch/$(ARCH)/vmlinux.lds.S
+	$(CPP) $(CPPFLAGS) $(CPPFLAGS_$@) -D__ASSEMBLY__ -P -C -U$(ARCH) $< -o $@
+
 bootpfile:
 	@$(MAKEBOOT) bootpfile
 
--- 2.5.33/include/asm-alpha/kmap_types.h	Thu Jan  1 00:00:00 1970
+++ linux/include/asm-alpha/kmap_types.h	Thu Sep  5 21:22:54 2002
@@ -0,0 +1,31 @@
+#ifndef _ASM_KMAP_TYPES_H
+#define _ASM_KMAP_TYPES_H
+
+/* Dummy header just to define km_type. */
+
+#include <linux/config.h>
+
+#if CONFIG_DEBUG_HIGHMEM
+# define D(n) __KM_FENCE_##n ,
+#else
+# define D(n)
+#endif
+
+enum km_type {
+D(0)	KM_BOUNCE_READ,
+D(1)	KM_SKB_SUNRPC_DATA,
+D(2)	KM_SKB_DATA_SOFTIRQ,
+D(3)	KM_USER0,
+D(4)	KM_USER1,
+D(5)	KM_BIO_SRC_IRQ,
+D(6)	KM_BIO_DST_IRQ,
+D(7)	KM_PTE0,
+D(8)	KM_PTE1,
+D(9)	KM_IRQ0,
+D(10)	KM_IRQ1,
+D(11)	KM_TYPE_NR
+};
+
+#undef D
+
+#endif
--- 2.5.33/include/asm-alpha/user.h	Wed Sep  4 20:45:35 2002
+++ linux/include/asm-alpha/user.h	Wed Sep  4 21:01:33 2002
@@ -1,6 +1,7 @@
 #ifndef _ALPHA_USER_H
 #define _ALPHA_USER_H
 
+#include <linux/sched.h>
 #include <linux/ptrace.h>
 
 #include <asm/page.h>
--- 2.5.33/include/asm-alpha/ide.h	Sun Sep  1 02:05:32 2002
+++ linux/include/asm-alpha/ide.h	Wed Sep  4 20:45:58 2002
@@ -80,6 +80,17 @@ static __inline__ void ide_init_default_
 #endif
 }
 
+#define ide_request_irq(irq,hand,flg,dev,id)	request_irq((irq),(hand),(flg),(dev),(id))
+#define ide_free_irq(irq,dev_id)		free_irq((irq), (dev_id))
+#define ide_check_region(from,extent)		check_region((from), (extent))
+#define ide_request_region(from,extent,name)	request_region((from), (extent), (name))
+#define ide_release_region(from,extent)		release_region((from), (extent))
+
+#define ide_ack_intr(hwif)		(1)
+#define ide_fix_driveid(id)		do {} while (0)
+#define ide_release_lock(lock)		do {} while (0)
+#define ide_get_lock(lock, hdlr, data)	do {} while (0)
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASMalpha_IDE_H */
