Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbVJYWHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbVJYWHV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 18:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbVJYWFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 18:05:39 -0400
Received: from [151.97.230.9] ([151.97.230.9]:60645 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932432AbVJYWFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 18:05:32 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 10/11] uml: avoid malloc to sleep in atomic sections
Date: Wed, 26 Oct 2005 00:02:54 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051025220253.20010.96269.stgit@zion.home.lan>
In-Reply-To: <20051025220053.20010.56979.stgit@zion.home.lan>
References: <20051025220053.20010.56979.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Ugly trick to help make malloc not sleeping - we can't do anything else. But
this is not yet optimal, since spinlock don't trigger in_atomic() when
preemption is disabled.

Also, even if ugly, this was already used in one place, and was even more bogus.
Fix it.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/kern_util.h   |    4 +++-
 arch/um/include/user.h        |    1 +
 arch/um/kernel/helper.c       |    4 ++--
 arch/um/kernel/main.c         |   11 +++++++----
 arch/um/kernel/process_kern.c |   21 +++++++++++++--------
 5 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/arch/um/include/kern_util.h b/arch/um/include/kern_util.h
--- a/arch/um/include/kern_util.h
+++ b/arch/um/include/kern_util.h
@@ -109,9 +109,11 @@ extern void machine_halt(void);
 extern int is_syscall(unsigned long addr);
 extern void arch_switch(void);
 extern void free_irq(unsigned int, void *);
-extern int um_in_interrupt(void);
 extern int cpu(void);
 
+/* Are we disallowed to sleep? Used to choose between GFP_KERNEL and GFP_ATOMIC. */
+extern int __cant_sleep(void);
+
 #endif
 
 /*
diff --git a/arch/um/include/user.h b/arch/um/include/user.h
--- a/arch/um/include/user.h
+++ b/arch/um/include/user.h
@@ -18,6 +18,7 @@ extern int open_gdb_chan(void);
 extern unsigned long strlcpy(char *, const char *, unsigned long);
 extern unsigned long strlcat(char *, const char *, unsigned long);
 extern void *um_vmalloc(int size);
+extern void *um_vmalloc_atomic(int size);
 extern void vfree(void *ptr);
 
 #endif
diff --git a/arch/um/kernel/helper.c b/arch/um/kernel/helper.c
--- a/arch/um/kernel/helper.c
+++ b/arch/um/kernel/helper.c
@@ -61,7 +61,7 @@ int run_helper(void (*pre_exec)(void *),
 
 	if((stack_out != NULL) && (*stack_out != 0))
 		stack = *stack_out;
-	else stack = alloc_stack(0, um_in_interrupt());
+	else stack = alloc_stack(0, __cant_sleep());
 	if(stack == 0)
 		return(-ENOMEM);
 
@@ -124,7 +124,7 @@ int run_helper_thread(int (*proc)(void *
 	unsigned long stack, sp;
 	int pid, status, err;
 
-	stack = alloc_stack(stack_order, um_in_interrupt());
+	stack = alloc_stack(stack_order, __cant_sleep());
 	if(stack == 0) return(-ENOMEM);
 
 	sp = stack + (page_size() << stack_order) - sizeof(void *);
diff --git a/arch/um/kernel/main.c b/arch/um/kernel/main.c
--- a/arch/um/kernel/main.c
+++ b/arch/um/kernel/main.c
@@ -197,11 +197,14 @@ void *__wrap_malloc(int size)
 {
 	void *ret;
 
-	if(!CAN_KMALLOC())
+	if (!CAN_KMALLOC())
 		return(__real_malloc(size));
-	else if(size <= PAGE_SIZE) /* finding contiguos pages can be hard*/
-		ret = um_kmalloc(size);
-	else ret = um_vmalloc(size);
+	else if (size <= PAGE_SIZE) /* finding contiguos pages can be hard*/
+		ret = __cant_sleep() ? um_kmalloc_atomic(size) :
+			um_kmalloc(size);
+	else
+		ret = __cant_sleep() ? um_vmalloc_atomic(size) :
+			um_vmalloc(size);
 
 	/* glibc people insist that if malloc fails, errno should be
 	 * set by malloc as well. So we do.
diff --git a/arch/um/kernel/process_kern.c b/arch/um/kernel/process_kern.c
--- a/arch/um/kernel/process_kern.c
+++ b/arch/um/kernel/process_kern.c
@@ -287,17 +287,27 @@ EXPORT_SYMBOL(disable_hlt);
 
 void *um_kmalloc(int size)
 {
-	return(kmalloc(size, GFP_KERNEL));
+	return kmalloc(size, GFP_KERNEL);
 }
 
 void *um_kmalloc_atomic(int size)
 {
-	return(kmalloc(size, GFP_ATOMIC));
+	return kmalloc(size, GFP_ATOMIC);
 }
 
 void *um_vmalloc(int size)
 {
-	return(vmalloc(size));
+	return vmalloc(size);
+}
+
+void *um_vmalloc_atomic(int size)
+{
+	return __vmalloc(size, GFP_ATOMIC | __GFP_HIGHMEM, PAGE_KERNEL);
+}
+
+int __cant_sleep(void) {
+	return in_atomic() || irqs_disabled() || in_interrupt();
+	/* Is in_interrupt() really needed? */
 }
 
 unsigned long get_fault_addr(void)
@@ -373,11 +383,6 @@ int smp_sigio_handler(void)
 	return(0);
 }
 
-int um_in_interrupt(void)
-{
-	return(in_interrupt());
-}
-
 int cpu(void)
 {
 	return(current_thread->cpu);

