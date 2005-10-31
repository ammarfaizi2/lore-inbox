Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbVJaDwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbVJaDwO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 22:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbVJaDwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 22:52:14 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:46255 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751328AbVJaDwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 22:52:11 -0500
Message-Id: <200510310439.j9V4dfbw000872@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       bstroesser@fujitsu-siemens.com
Subject: [PATCH 8/10] UML - Maintain own LDT entries
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 30 Oct 2005 23:39:41 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
 
Patch imlements full LDT handling in SKAS:
 * UML holds it's own LDT table, used to deliver data on
   modify_ldt(READ)
 * UML disables the default_ldt, inherited from the host (SKAS3)
   or resets LDT entries, set by host's clib and inherited in
   SKAS0
 * A new global variable skas_needs_stub is inserted, that
   can be used to decide, whether stub-pages must be supported
   or not.
 * Uses the syscall-stub to replace missing PTRACE_LDT (therefore, 
   write_ldt_entry needs to be modified)
 
Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.14-akpm/arch/um/kernel/skas/include/mmu-skas.h
===================================================================
--- 2.6.14-akpm.orig/arch/um/kernel/skas/include/mmu-skas.h	2005-10-28 12:58:12.000000000 -0400
+++ 2.6.14-akpm/arch/um/kernel/skas/include/mmu-skas.h	2005-10-28 16:09:59.000000000 -0400
@@ -8,6 +8,7 @@
 
 #include "linux/config.h"
 #include "mm_id.h"
+#include "asm/ldt.h"
 
 struct mmu_context_skas {
 	struct mm_id id;
@@ -15,6 +16,7 @@ struct mmu_context_skas {
 #ifdef CONFIG_3_LEVEL_PGTABLES
         unsigned long last_pmd;
 #endif
+	uml_ldt_t ldt;
 };
 
 extern void switch_mm_skas(struct mm_id * mm_idp);
Index: 2.6.14-akpm/arch/um/kernel/skas/include/skas.h
===================================================================
--- 2.6.14-akpm.orig/arch/um/kernel/skas/include/skas.h	2005-10-28 12:58:12.000000000 -0400
+++ 2.6.14-akpm/arch/um/kernel/skas/include/skas.h	2005-10-28 16:09:59.000000000 -0400
@@ -10,7 +10,8 @@
 #include "sysdep/ptrace.h"
 
 extern int userspace_pid[];
-extern int proc_mm, ptrace_faultinfo;
+extern int proc_mm, ptrace_faultinfo, ptrace_ldt;
+extern int skas_needs_stub;
 
 extern void switch_threads(void *me, void *next);
 extern void thread_wait(void *sw, void *fb);
Index: 2.6.14-akpm/arch/um/kernel/skas/mem.c
===================================================================
--- 2.6.14-akpm.orig/arch/um/kernel/skas/mem.c	2005-08-28 19:41:01.000000000 -0400
+++ 2.6.14-akpm/arch/um/kernel/skas/mem.c	2005-10-28 16:09:59.000000000 -0400
@@ -20,7 +20,7 @@ unsigned long set_task_sizes_skas(int ar
 	*task_size_out = CONFIG_HOST_TASK_SIZE;
 #else
 	*host_size_out = top;
-	if (proc_mm && ptrace_faultinfo)
+	if (!skas_needs_stub)
 		*task_size_out = top;
 	else *task_size_out = CONFIG_STUB_START & PGDIR_MASK;
 #endif
Index: 2.6.14-akpm/arch/um/kernel/skas/mmu.c
===================================================================
--- 2.6.14-akpm.orig/arch/um/kernel/skas/mmu.c	2005-10-28 12:58:12.000000000 -0400
+++ 2.6.14-akpm/arch/um/kernel/skas/mmu.c	2005-10-28 16:09:59.000000000 -0400
@@ -15,6 +15,7 @@
 #include "asm/mmu.h"
 #include "asm/pgalloc.h"
 #include "asm/pgtable.h"
+#include "asm/ldt.h"
 #include "os.h"
 #include "skas.h"
 
@@ -77,13 +78,12 @@ static int init_stub_pte(struct mm_struc
 
 int init_new_context_skas(struct task_struct *task, struct mm_struct *mm)
 {
-	struct mm_struct *cur_mm = current->mm;
-	struct mm_id *cur_mm_id = &cur_mm->context.skas.id;
-	struct mm_id *mm_id = &mm->context.skas.id;
+ 	struct mmu_context_skas *from_mm = NULL;
+	struct mmu_context_skas *to_mm = &mm->context.skas;
 	unsigned long stack = 0;
-	int from, ret = -ENOMEM;
+	int from_fd, ret = -ENOMEM;
 
-	if(!proc_mm || !ptrace_faultinfo){
+	if(skas_needs_stub){
 		stack = get_zeroed_page(GFP_KERNEL);
 		if(stack == 0)
 			goto out;
@@ -105,33 +105,43 @@ int init_new_context_skas(struct task_st
 
 		mm->nr_ptes--;
 	}
-	mm_id->stack = stack;
+
+	to_mm->id.stack = stack;
+	if(current->mm != NULL && current->mm != &init_mm)
+		from_mm = &current->mm->context.skas;
 
 	if(proc_mm){
-		if((cur_mm != NULL) && (cur_mm != &init_mm))
-			from = cur_mm_id->u.mm_fd;
-		else from = -1;
+		if(from_mm)
+			from_fd = from_mm->id.u.mm_fd;
+		else from_fd = -1;
 
-		ret = new_mm(from, stack);
+		ret = new_mm(from_fd, stack);
 		if(ret < 0){
 			printk("init_new_context_skas - new_mm failed, "
 			       "errno = %d\n", ret);
 			goto out_free;
 		}
-		mm_id->u.mm_fd = ret;
+		to_mm->id.u.mm_fd = ret;
 	}
 	else {
-		if((cur_mm != NULL) && (cur_mm != &init_mm))
-			mm_id->u.pid = copy_context_skas0(stack,
-							  cur_mm_id->u.pid);
-		else mm_id->u.pid = start_userspace(stack);
+		if(from_mm)
+			to_mm->id.u.pid = copy_context_skas0(stack,
+							     from_mm->id.u.pid);
+		else to_mm->id.u.pid = start_userspace(stack);
+	}
+
+	ret = init_new_ldt(to_mm, from_mm);
+	if(ret < 0){
+		printk("init_new_context_skas - init_ldt"
+		       " failed, errno = %d\n", ret);
+		goto out_free;
 	}
 
 	return 0;
 
  out_free:
-	if(mm_id->stack != 0)
-		free_page(mm_id->stack);
+	if(to_mm->id.stack != 0)
+		free_page(to_mm->id.stack);
  out:
 	return ret;
 }
Index: 2.6.14-akpm/arch/um/kernel/skas/process.c
===================================================================
--- 2.6.14-akpm.orig/arch/um/kernel/skas/process.c	2005-10-28 15:47:24.000000000 -0400
+++ 2.6.14-akpm/arch/um/kernel/skas/process.c	2005-10-28 16:09:59.000000000 -0400
@@ -381,9 +381,9 @@ int copy_context_skas0(unsigned long new
 }
 
 /*
- * This is used only, if proc_mm is available, while PTRACE_FAULTINFO
- * isn't. Opening /proc/mm creates a new mm_context, which lacks the stub-pages
- * Thus, we map them using /proc/mm-fd
+ * This is used only, if stub pages are needed, while proc_mm is
+ * availabl. Opening /proc/mm creates a new mm_context, which lacks
+ * the stub-pages. Thus, we map them using /proc/mm-fd
  */
 void map_stub_pages(int fd, unsigned long code,
 		    unsigned long data, unsigned long stack)
Index: 2.6.14-akpm/arch/um/kernel/skas/process_kern.c
===================================================================
--- 2.6.14-akpm.orig/arch/um/kernel/skas/process_kern.c	2005-10-28 12:58:12.000000000 -0400
+++ 2.6.14-akpm/arch/um/kernel/skas/process_kern.c	2005-10-28 17:31:08.000000000 -0400
@@ -145,7 +145,7 @@ int new_mm(int from, unsigned long stack
 			       "err = %d\n", -n);
 	}
 
-	if(!ptrace_faultinfo)
+	if(skas_needs_stub)
 		map_stub_pages(fd, CONFIG_STUB_CODE, CONFIG_STUB_DATA, stack);
 
 	return(fd);
Index: 2.6.14-akpm/arch/um/os-Linux/start_up.c
===================================================================
--- 2.6.14-akpm.orig/arch/um/os-Linux/start_up.c	2005-10-28 12:58:12.000000000 -0400
+++ 2.6.14-akpm/arch/um/os-Linux/start_up.c	2005-10-28 17:31:08.000000000 -0400
@@ -135,7 +135,9 @@ static int stop_ptraced_child(int pid, v
 }
 
 int ptrace_faultinfo = 1;
+int ptrace_ldt = 1;
 int proc_mm = 1;
+int skas_needs_stub = 0;
 
 static int __init skas0_cmd_param(char *str, int* add)
 {
@@ -352,14 +354,26 @@ __uml_setup("noptracefaultinfo", noptrac
 "    it. To support PTRACE_FAULTINFO, the host needs to be patched\n"
 "    using the current skas3 patch.\n\n");
 
+static int __init noptraceldt_cmd_param(char *str, int* add)
+{
+	ptrace_ldt = 0;
+	return 0;
+}
+
+__uml_setup("noptraceldt", noptraceldt_cmd_param,
+"noptraceldt\n"
+"    Turns off usage of PTRACE_LDT, even if host supports it.\n"
+"    To support PTRACE_LDT, the host needs to be patched using\n"
+"    the current skas3 patch.\n\n");
+
 #ifdef UML_CONFIG_MODE_SKAS
-static inline void check_skas3_ptrace_support(void)
+static inline void check_skas3_ptrace_faultinfo(void)
 {
 	struct ptrace_faultinfo fi;
 	void *stack;
 	int pid, n;
 
-	printf("Checking for the skas3 patch in the host...");
+	printf("  - PTRACE_FAULTINFO...");
 	pid = start_ptraced_child(&stack);
 
 	n = ptrace(PTRACE_FAULTINFO, pid, 0, &fi);
@@ -381,9 +395,49 @@ static inline void check_skas3_ptrace_su
 	stop_ptraced_child(pid, stack, 1, 1);
 }
 
-int can_do_skas(void)
+static inline void check_skas3_ptrace_ldt(void)
+{
+#ifdef PTRACE_LDT
+	void *stack;
+	int pid, n;
+	unsigned char ldtbuf[40];
+	struct ptrace_ldt ldt_op = (struct ptrace_ldt) {
+		.func = 2, /* read default ldt */
+		.ptr = ldtbuf,
+		.bytecount = sizeof(ldtbuf)};
+
+	printf("  - PTRACE_LDT...");
+	pid = start_ptraced_child(&stack);
+
+	n = ptrace(PTRACE_LDT, pid, 0, (unsigned long) &ldt_op);
+	if (n < 0) {
+		if(errno == EIO)
+			printf("not found\n");
+		else {
+			perror("not found");
+		}
+		ptrace_ldt = 0;
+	}
+	else {
+		if(ptrace_ldt)
+			printf("found\n");
+		else
+			printf("found, but use is disabled\n");
+	}
+
+	stop_ptraced_child(pid, stack, 1, 1);
+#else
+	/* PTRACE_LDT might be disabled via cmdline option.
+	 * We want to override this, else we might use the stub
+	 * without real need
+	 */
+	ptrace_ldt = 1;
+#endif
+}
+
+static inline void check_skas3_proc_mm(void)
 {
-	printf("Checking for /proc/mm...");
+	printf("  - /proc/mm...");
 	if (os_access("/proc/mm", OS_ACC_W_OK) < 0) {
  		proc_mm = 0;
 		printf("not found\n");
@@ -394,8 +448,19 @@ int can_do_skas(void)
 		else
 			printf("found\n");
 	}
+}
+
+int can_do_skas(void)
+{
+	printf("Checking for the skas3 patch in the host:\n");
+
+	check_skas3_proc_mm();
+	check_skas3_ptrace_faultinfo();
+	check_skas3_ptrace_ldt();
+
+	if(!proc_mm || !ptrace_faultinfo || !ptrace_ldt)
+		skas_needs_stub = 1;
 
-	check_skas3_ptrace_support();
 	return 1;
 }
 #else
Index: 2.6.14-akpm/arch/um/scripts/Makefile.rules
===================================================================
--- 2.6.14-akpm.orig/arch/um/scripts/Makefile.rules	2005-10-28 12:58:12.000000000 -0400
+++ 2.6.14-akpm/arch/um/scripts/Makefile.rules	2005-10-28 16:09:59.000000000 -0400
@@ -26,8 +26,13 @@ define unprofile
 	$(patsubst -pg,,$(patsubst -fprofile-arcs -ftest-coverage,,$(1)))
 endef
 
+# cmd_make_link checks to see if the $(foo-dir) variable starts with a /.  If
+# so, it's considered to be a path relative to $(srcdir) rather than 
+# $(srcdir)/arch/$(SUBARCH).  This is because x86_64 wants to get ldt.c from
+# arch/um/sys-i386 rather than arch/i386 like the other borrowed files.  So,
+# it sets $(ldt.c-dir) to /arch/um/sys-i386.
 quiet_cmd_make_link = SYMLINK $@
-cmd_make_link       = ln -sf $(srctree)/arch/$(SUBARCH)/$($(notdir $@)-dir)/$(notdir $@) $@
+cmd_make_link       = rm -f $@; ln -sf $(srctree)$(if $(filter-out /%,$($(notdir $@)-dir)),/arch/$(SUBARCH))/$($(notdir $@)-dir)/$(notdir $@) $@
 
 # this needs to be before the foreach, because targets does not accept
 # complete paths like $(obj)/$(f). To make sure this works, use a := assignment
Index: 2.6.14-akpm/arch/um/sys-i386/ldt.c
===================================================================
--- 2.6.14-akpm.orig/arch/um/sys-i386/ldt.c	2005-10-28 12:58:12.000000000 -0400
+++ 2.6.14-akpm/arch/um/sys-i386/ldt.c	2005-10-28 17:31:07.000000000 -0400
@@ -3,53 +3,26 @@
  * Licensed under the GPL
  */
 
+#include "linux/stddef.h"
 #include "linux/config.h"
 #include "linux/sched.h"
 #include "linux/slab.h"
 #include "linux/types.h"
+#include "linux/errno.h"
 #include "asm/uaccess.h"
-#include "asm/ptrace.h"
 #include "asm/smp.h"
 #include "asm/ldt.h"
+#include "asm/unistd.h"
 #include "choose-mode.h"
 #include "kern.h"
 #include "mode_kern.h"
 
-#ifdef CONFIG_MODE_TT
-
 extern int modify_ldt(int func, void *ptr, unsigned long bytecount);
 
-static int do_modify_ldt_tt(int func, void *ptr, unsigned long bytecount)
-{
-	return modify_ldt(func, ptr, bytecount);
-}
-
-#endif
-
-#ifdef CONFIG_MODE_SKAS
-
-#include "skas.h"
-#include "skas_ptrace.h"
-
-static int do_modify_ldt_skas(int func, void *ptr, unsigned long bytecount)
-{
-	struct ptrace_ldt ldt;
-	u32 cpu;
-	int res;
-
-	ldt = ((struct ptrace_ldt) { .func	= func,
-				     .ptr	= ptr,
-				     .bytecount = bytecount });
-
-	cpu = get_cpu();
-	res = ptrace(PTRACE_LDT, userspace_pid[cpu], 0, (unsigned long) &ldt);
-	put_cpu();
-
-	return res;
-}
-#endif
+#ifdef CONFIG_MODE_TT
 
-int sys_modify_ldt(int func, void __user *ptr, unsigned long bytecount)
+static long do_modify_ldt_tt(int func, void __user *ptr, 
+			      unsigned long bytecount)
 {
 	struct user_desc info;
 	int res = 0;
@@ -89,8 +62,7 @@ int sys_modify_ldt(int func, void __user
 		goto out;
 	}
 
-	res = CHOOSE_MODE_PROC(do_modify_ldt_tt, do_modify_ldt_skas, func,
-				p, bytecount);
+	res = modify_ldt(func, p, bytecount);
 	if(res < 0)
 		goto out;
 
@@ -108,3 +80,467 @@ out:
 	kfree(buf);
 	return res;
 }
+
+#endif
+
+#ifdef CONFIG_MODE_SKAS
+
+#include "skas.h"
+#include "skas_ptrace.h"
+#include "asm/mmu_context.h"
+
+long write_ldt_entry(struct mm_id * mm_idp, int func, struct user_desc * desc,
+		     void **addr, int done)
+{
+	long res;
+
+	if(proc_mm){
+		/* This is a special handling for the case, that the mm to
+		 * modify isn't current->active_mm.
+		 * If this is called directly by modify_ldt,
+		 *     (current->active_mm->context.skas.u == mm_idp)
+		 * will be true. So no call to switch_mm_skas(mm_idp) is done.
+		 * If this is called in case of init_new_ldt or PTRACE_LDT,
+		 * mm_idp won't belong to current->active_mm, but child->mm.
+		 * So we need to switch child's mm into our userspace, then
+		 * later switch back.
+		 *
+		 * Note: I'm unshure: should interrupts be disabled here?
+		 */
+		if(!current->active_mm || current->active_mm == &init_mm ||
+		   mm_idp != &current->active_mm->context.skas.id)
+			switch_mm_skas(mm_idp);
+	}
+
+	if(ptrace_ldt) {
+		struct ptrace_ldt ldt_op = (struct ptrace_ldt) {
+			.func = func,
+			.ptr = desc,
+			.bytecount = sizeof(*desc)};
+		u32 cpu;
+		int pid;
+
+		if(!proc_mm)
+			pid = mm_idp->u.pid;
+		else {
+			cpu = get_cpu();
+			pid = userspace_pid[cpu];
+		}
+
+		res = ptrace(PTRACE_LDT, pid, 0, (unsigned long) &ldt_op);
+		if(res)
+			res = errno;
+
+		if(proc_mm) 
+			put_cpu();
+	}
+	else {
+		void *stub_addr;
+		res = syscall_stub_data(mm_idp, (unsigned long *)desc,
+					(sizeof(*desc) + sizeof(long) - 1) &
+					    ~(sizeof(long) - 1),
+					addr, &stub_addr);
+		if(!res){
+			unsigned long args[] = { func,
+						 (unsigned long)stub_addr,
+						 sizeof(*desc),
+						 0, 0, 0 };
+			res = run_syscall_stub(mm_idp, __NR_modify_ldt, args,
+					       0, addr, done);
+		}
+	}
+
+	if(proc_mm){
+		/* This is the second part of special handling, that makes
+		 * PTRACE_LDT possible to implement.
+		 */
+		if(current->active_mm && current->active_mm != &init_mm &&
+		   mm_idp != &current->active_mm->context.skas.id)
+			switch_mm_skas(&current->active_mm->context.skas.id);
+	}
+
+	return res;
+}
+
+static long read_ldt_from_host(void __user * ptr, unsigned long bytecount)
+{
+	int res, n;
+	struct ptrace_ldt ptrace_ldt = (struct ptrace_ldt) {
+			.func = 0,
+			.bytecount = bytecount,
+			.ptr = (void *)kmalloc(bytecount, GFP_KERNEL)};
+	u32 cpu;
+
+	if(ptrace_ldt.ptr == NULL)
+		return -ENOMEM;
+
+	/* This is called from sys_modify_ldt only, so userspace_pid gives
+	 * us the right number
+	 */
+
+	cpu = get_cpu();
+	res = ptrace(PTRACE_LDT, userspace_pid[cpu], 0,
+		     (unsigned long) &ptrace_ldt);
+	put_cpu();
+	if(res < 0)
+		goto out;
+
+	n = copy_to_user(ptr, ptrace_ldt.ptr, res);
+	if(n != 0)
+		res = -EFAULT;
+
+  out:
+	kfree(ptrace_ldt.ptr);
+
+	return res;
+}
+
+/*
+ * In skas mode, we hold our own ldt data in UML.
+ * Thus, the code implementing sys_modify_ldt_skas
+ * is very similar to (and mostly stolen from) sys_modify_ldt
+ * for arch/i386/kernel/ldt.c
+ * The routines copied and modified in part are:
+ * - read_ldt
+ * - read_default_ldt
+ * - write_ldt
+ * - sys_modify_ldt_skas
+ */
+
+static int read_ldt(void __user * ptr, unsigned long bytecount)
+{
+	int i, err = 0;
+	unsigned long size;
+	uml_ldt_t * ldt = &current->mm->context.skas.ldt;
+
+	if(!ldt->entry_count)
+		goto out;
+	if(bytecount > LDT_ENTRY_SIZE*LDT_ENTRIES)
+		bytecount = LDT_ENTRY_SIZE*LDT_ENTRIES;
+	err = bytecount;
+
+	if(ptrace_ldt){
+		return read_ldt_from_host(ptr, bytecount);
+	}
+
+	down(&ldt->semaphore);
+	if(ldt->entry_count <= LDT_DIRECT_ENTRIES){
+		size = LDT_ENTRY_SIZE*LDT_DIRECT_ENTRIES;
+		if(size > bytecount)
+			size = bytecount;
+		if(copy_to_user(ptr, ldt->entries, size))
+			err = -EFAULT;
+		bytecount -= size;
+		ptr += size;
+	}
+	else {
+		for(i=0; i<ldt->entry_count/LDT_ENTRIES_PER_PAGE && bytecount;
+			 i++){
+			size = PAGE_SIZE;
+			if(size > bytecount)
+				size = bytecount;
+			if(copy_to_user(ptr, ldt->pages[i], size)){
+				err = -EFAULT;
+				break;
+			}
+			bytecount -= size;
+			ptr += size;
+		}
+	}
+	up(&ldt->semaphore);
+
+	if(bytecount == 0 || err == -EFAULT)
+		goto out;
+
+	if(clear_user(ptr, bytecount))
+		err = -EFAULT;
+
+out:
+	return err;
+}
+
+static int read_default_ldt(void __user * ptr, unsigned long bytecount)
+{
+	int err;
+
+	if(bytecount > 5*LDT_ENTRY_SIZE)
+		bytecount = 5*LDT_ENTRY_SIZE;
+
+	err = bytecount;
+	/* UML doesn't support lcall7 and lcall27.
+	 * So, we don't really have a default ldt, but emulate
+	 * an empty ldt of common host default ldt size.
+	 */
+	if(clear_user(ptr, bytecount))
+		err = -EFAULT;
+
+	return err;
+}
+
+static int write_ldt(void __user * ptr, unsigned long bytecount, int func)
+{
+	uml_ldt_t * ldt = &current->mm->context.skas.ldt;
+	struct mm_id * mm_idp = &current->mm->context.skas.id;
+	int i, err;
+	struct user_desc ldt_info;
+	struct ldt_entry entry0, *ldt_p;
+	void *addr = NULL;
+
+	err = -EINVAL;
+	if(bytecount != sizeof(ldt_info))
+		goto out;
+	err = -EFAULT;
+	if(copy_from_user(&ldt_info, ptr, sizeof(ldt_info)))
+		goto out;
+
+	err = -EINVAL;
+	if(ldt_info.entry_number >= LDT_ENTRIES)
+		goto out;
+	if(ldt_info.contents == 3){
+		if (func == 1)
+			goto out;
+		if (ldt_info.seg_not_present == 0)
+			goto out;
+	}
+
+        if(!ptrace_ldt)
+                down(&ldt->semaphore);
+
+	err = write_ldt_entry(mm_idp, func, &ldt_info, &addr, 1);
+	if(err)
+		goto out_unlock;
+        else if(ptrace_ldt) {
+	/* With PTRACE_LDT available, this is used as a flag only */
+                ldt->entry_count = 1;
+                goto out;
+        }
+
+	if(ldt_info.entry_number >= ldt->entry_count &&
+	   ldt_info.entry_number >= LDT_DIRECT_ENTRIES){
+		for(i=ldt->entry_count/LDT_ENTRIES_PER_PAGE;
+		    i*LDT_ENTRIES_PER_PAGE <= ldt_info.entry_number;
+		    i++){
+			if(i == 0)
+				memcpy(&entry0, ldt->entries, sizeof(entry0));
+			ldt->pages[i] = (struct ldt_entry *)
+					__get_free_page(GFP_KERNEL|__GFP_ZERO);
+			if(!ldt->pages[i]){
+				err = -ENOMEM;
+				/* Undo the change in host */
+				memset(&ldt_info, 0, sizeof(ldt_info));
+				write_ldt_entry(mm_idp, 1, &ldt_info, &addr, 1);
+				goto out_unlock;
+			}
+			if(i == 0) {
+				memcpy(ldt->pages[0], &entry0, sizeof(entry0));
+				memcpy(ldt->pages[0]+1, ldt->entries+1,
+				       sizeof(entry0)*(LDT_DIRECT_ENTRIES-1));
+			}
+			ldt->entry_count = (i + 1) * LDT_ENTRIES_PER_PAGE;
+		}
+	}
+	if(ldt->entry_count <= ldt_info.entry_number)
+		ldt->entry_count = ldt_info.entry_number + 1;
+
+	if(ldt->entry_count <= LDT_DIRECT_ENTRIES)
+		ldt_p = ldt->entries + ldt_info.entry_number;
+	else
+		ldt_p = ldt->pages[ldt_info.entry_number/LDT_ENTRIES_PER_PAGE] +
+			ldt_info.entry_number%LDT_ENTRIES_PER_PAGE;
+
+	if(ldt_info.base_addr == 0 && ldt_info.limit == 0 &&
+	   (func == 1 || LDT_empty(&ldt_info))){
+		ldt_p->a = 0;
+		ldt_p->b = 0;
+	}
+	else{
+		if (func == 1)
+			ldt_info.useable = 0;
+		ldt_p->a = LDT_entry_a(&ldt_info);
+		ldt_p->b = LDT_entry_b(&ldt_info);
+	}
+	err = 0;
+
+out_unlock:
+	up(&ldt->semaphore);
+out:
+	return err;
+}
+
+static long do_modify_ldt_skas(int func, void __user *ptr, 
+			       unsigned long bytecount)
+{
+	int ret = -ENOSYS;
+
+	switch (func) {
+		case 0:
+			ret = read_ldt(ptr, bytecount);
+			break;
+		case 1:
+		case 0x11:
+			ret = write_ldt(ptr, bytecount, func);
+			break;
+		case 2:
+			ret = read_default_ldt(ptr, bytecount);
+			break;
+	}
+	return ret;
+}
+
+short dummy_list[9] = {0, -1};
+short * host_ldt_entries = NULL;
+
+void ldt_get_host_info(void)
+{
+	long ret;
+	struct ldt_entry * ldt;
+	int i, size, k, order;
+
+	host_ldt_entries = dummy_list+1;
+
+	for(i = LDT_PAGES_MAX-1, order=0; i; i>>=1, order++);
+
+	ldt = (struct ldt_entry *)
+	      __get_free_pages(GFP_KERNEL|__GFP_ZERO, order);
+	if(ldt == NULL) {
+		printk("ldt_get_host_info: couldn't allocate buffer for host ldt\n");
+		return;
+	}
+
+	ret = modify_ldt(0, ldt, (1<<order)*PAGE_SIZE);
+	if(ret < 0) {
+		printk("ldt_get_host_info: couldn't read host ldt\n");
+		goto out_free;
+	}
+	if(ret == 0) {
+		/* default_ldt is active, simply write an empty entry 0 */
+		host_ldt_entries = dummy_list;
+		goto out_free;
+	}
+
+	for(i=0, size=0; i<ret/LDT_ENTRY_SIZE; i++){
+		if(ldt[i].a != 0 || ldt[i].b != 0)
+			size++;
+	}
+
+	if(size < sizeof(dummy_list)/sizeof(dummy_list[0])) {
+		host_ldt_entries = dummy_list;
+	}
+	else {
+		size = (size + 1) * sizeof(dummy_list[0]);
+		host_ldt_entries = (short *)kmalloc(size, GFP_KERNEL);
+		if(host_ldt_entries == NULL) {
+			printk("ldt_get_host_info: couldn't allocate host ldt list\n");
+			goto out_free;
+		}
+	}
+
+	for(i=0, k=0; i<ret/LDT_ENTRY_SIZE; i++){
+		if(ldt[i].a != 0 || ldt[i].b != 0) {
+			host_ldt_entries[k++] = i;
+		}
+	}
+	host_ldt_entries[k] = -1;
+
+out_free:
+	free_pages((unsigned long)ldt, order);
+}
+
+long init_new_ldt(struct mmu_context_skas * new_mm,
+		  struct mmu_context_skas * from_mm)
+{
+	struct user_desc desc;
+	short * num_p;
+	int i;
+	long page, err=0;
+	void *addr = NULL;
+
+	memset(&desc, 0, sizeof(desc));
+
+	if(!ptrace_ldt)
+		init_MUTEX(&new_mm->ldt.semaphore);
+
+	if(!from_mm){
+		/*
+		 * We have to initialize a clean ldt.
+		 */
+		if(proc_mm) {
+			/*
+			 * If the new mm was created using proc_mm, host's
+			 * default-ldt currently is assigned, which normally
+			 * contains the call-gates for lcall7 and lcall27.
+			 * To remove these gates, we simply write an empty
+			 * entry as number 0 to the host.
+			 */
+			err = write_ldt_entry(&new_mm->id, 1, &desc,
+					      &addr, 1);
+		}
+		else{
+			/*
+			 * Now we try to retrieve info about the ldt, we
+			 * inherited from the host. All ldt-entries found
+			 * will be reset in the following loop
+			 */
+			if(host_ldt_entries == NULL)
+				ldt_get_host_info();
+			for(num_p=host_ldt_entries; *num_p != -1; num_p++){
+				desc.entry_number = *num_p;
+				err = write_ldt_entry(&new_mm->id, 1, &desc,
+						      &addr, *(num_p + 1) == -1);
+				if(err)
+					break;
+			}
+		}
+		new_mm->ldt.entry_count = 0;
+	}
+	else if (!ptrace_ldt) {
+		/* Our local LDT is used to supply the data for
+		 * modify_ldt(READLDT), if PTRACE_LDT isn't available,
+		 * i.e., we have to use the stub for modify_ldt, which
+		 * can't handle the big read buffer of up to 64kB.
+		 */
+		down(&from_mm->ldt.semaphore);
+		if(from_mm->ldt.entry_count <= LDT_DIRECT_ENTRIES){
+			memcpy(new_mm->ldt.entries, from_mm->ldt.entries,
+			       sizeof(new_mm->ldt.entries));
+		}
+		else{
+			i = from_mm->ldt.entry_count / LDT_ENTRIES_PER_PAGE;
+			while(i-->0){
+				page = __get_free_page(GFP_KERNEL|__GFP_ZERO);
+				if (!page){
+					err = -ENOMEM;
+					break;
+				}
+				new_mm->ldt.pages[i] = (struct ldt_entry*)page;
+				memcpy(new_mm->ldt.pages[i],
+				       from_mm->ldt.pages[i], PAGE_SIZE);
+			}
+		}
+		new_mm->ldt.entry_count = from_mm->ldt.entry_count;
+		up(&from_mm->ldt.semaphore);
+	}
+
+	return err;
+}
+
+
+void free_ldt(struct mmu_context_skas * mm)
+{
+	int i;
+
+	if(!ptrace_ldt && mm->ldt.entry_count > LDT_DIRECT_ENTRIES){
+		i = mm->ldt.entry_count / LDT_ENTRIES_PER_PAGE;
+		while(i-- > 0){
+			free_page((long )mm->ldt.pages[i]);
+		}
+	}
+	mm->ldt.entry_count = 0;
+}
+#endif
+
+int sys_modify_ldt(int func, void __user *ptr, unsigned long bytecount)
+{
+	return(CHOOSE_MODE_PROC(do_modify_ldt_tt, do_modify_ldt_skas, func,
+	                        ptr, bytecount));
+}
Index: 2.6.14-akpm/arch/um/sys-x86_64/Makefile
===================================================================
--- 2.6.14-akpm.orig/arch/um/sys-x86_64/Makefile	2005-10-28 12:58:12.000000000 -0400
+++ 2.6.14-akpm/arch/um/sys-x86_64/Makefile	2005-10-28 16:09:59.000000000 -0400
@@ -5,7 +5,7 @@
 #
 
 #XXX: why into lib-y?
-lib-y = bitops.o bugs.o csum-partial.o delay.o fault.o mem.o memcpy.o \
+lib-y = bitops.o bugs.o csum-partial.o delay.o fault.o ldt.o mem.o memcpy.o \
 	ptrace.o ptrace_user.o sigcontext.o signal.o stub.o \
 	stub_segv.o syscalls.o syscall_table.o sysrq.o thunk.o
 
@@ -14,7 +14,7 @@ obj-$(CONFIG_MODULES) += module.o um_mod
 
 USER_OBJS := ptrace_user.o sigcontext.o
 
-SYMLINKS = bitops.c csum-copy.S csum-partial.c csum-wrappers.c memcpy.S \
+SYMLINKS = bitops.c csum-copy.S csum-partial.c csum-wrappers.c ldt.c memcpy.S \
 	thunk.S module.c
 
 include arch/um/scripts/Makefile.rules
@@ -23,6 +23,7 @@ bitops.c-dir = lib
 csum-copy.S-dir = lib
 csum-partial.c-dir = lib
 csum-wrappers.c-dir = lib
+ldt.c-dir = /arch/um/sys-i386
 memcpy.S-dir = lib
 thunk.S-dir = lib
 module.c-dir = kernel
Index: 2.6.14-akpm/arch/um/sys-x86_64/syscalls.c
===================================================================
--- 2.6.14-akpm.orig/arch/um/sys-x86_64/syscalls.c	2005-08-28 19:41:01.000000000 -0400
+++ 2.6.14-akpm/arch/um/sys-x86_64/syscalls.c	2005-10-28 16:09:59.000000000 -0400
@@ -29,81 +29,6 @@ asmlinkage long sys_uname64(struct new_u
 }
 
 #ifdef CONFIG_MODE_TT
-extern int modify_ldt(int func, void *ptr, unsigned long bytecount);
-
-long sys_modify_ldt_tt(int func, void *ptr, unsigned long bytecount)
-{
-	/* XXX This should check VERIFY_WRITE depending on func, check this
-	 * in i386 as well.
-	 */
-	if (!access_ok(VERIFY_READ, ptr, bytecount))
-		return -EFAULT;
-	return(modify_ldt(func, ptr, bytecount));
-}
-#endif
-
-#ifdef CONFIG_MODE_SKAS
-extern int userspace_pid[];
-
-#include "skas_ptrace.h"
-
-long sys_modify_ldt_skas(int func, void *ptr, unsigned long bytecount)
-{
-	struct ptrace_ldt ldt;
-        void *buf;
-        int res, n;
-
-        buf = kmalloc(bytecount, GFP_KERNEL);
-        if(buf == NULL)
-                return(-ENOMEM);
-
-        res = 0;
-
-        switch(func){
-        case 1:
-        case 0x11:
-                res = copy_from_user(buf, ptr, bytecount);
-                break;
-        }
-
-        if(res != 0){
-                res = -EFAULT;
-                goto out;
-        }
-
-	ldt = ((struct ptrace_ldt) { .func	= func,
-				     .ptr	= buf,
-				     .bytecount = bytecount });
-#warning Need to look up userspace_pid by cpu
-	res = ptrace(PTRACE_LDT, userspace_pid[0], 0, (unsigned long) &ldt);
-        if(res < 0)
-                goto out;
-
-        switch(func){
-        case 0:
-        case 2:
-                n = res;
-                res = copy_to_user(ptr, buf, n);
-                if(res != 0)
-                        res = -EFAULT;
-                else
-                        res = n;
-                break;
-        }
-
- out:
-        kfree(buf);
-        return(res);
-}
-#endif
-
-long sys_modify_ldt(int func, void *ptr, unsigned long bytecount)
-{
-        return(CHOOSE_MODE_PROC(sys_modify_ldt_tt, sys_modify_ldt_skas, func,
-                                ptr, bytecount));
-}
-
-#ifdef CONFIG_MODE_TT
 extern long arch_prctl(int code, unsigned long addr);
 
 static long arch_prctl_tt(int code, unsigned long addr)
Index: 2.6.14-akpm/include/asm-um/ldt-i386.h
===================================================================
--- 2.6.14-akpm.orig/include/asm-um/ldt-i386.h	2005-10-28 06:47:18.772411750 -0400
+++ 2.6.14-akpm/include/asm-um/ldt-i386.h	2005-10-28 17:31:07.000000000 -0400
@@ -0,0 +1,69 @@
+/*
+ * Copyright (C) 2004 Fujitsu Siemens Computers GmbH
+ * Licensed under the GPL
+ *
+ * Author: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
+ */
+
+#ifndef __ASM_LDT_I386_H
+#define __ASM_LDT_I386_H
+
+#include "asm/semaphore.h"
+#include "asm/arch/ldt.h"
+
+struct mmu_context_skas;
+extern void ldt_host_info(void);
+extern long init_new_ldt(struct mmu_context_skas * to_mm,
+			 struct mmu_context_skas * from_mm);
+extern void free_ldt(struct mmu_context_skas * mm);
+
+#define LDT_PAGES_MAX \
+	((LDT_ENTRIES * LDT_ENTRY_SIZE)/PAGE_SIZE)
+#define LDT_ENTRIES_PER_PAGE \
+	(PAGE_SIZE/LDT_ENTRY_SIZE)
+#define LDT_DIRECT_ENTRIES \
+	((LDT_PAGES_MAX*sizeof(void *))/LDT_ENTRY_SIZE)
+
+struct ldt_entry {
+	__u32 a;
+	__u32 b;
+};
+
+typedef struct uml_ldt {
+	int entry_count;
+	struct semaphore semaphore;
+	union {
+		struct ldt_entry * pages[LDT_PAGES_MAX];
+		struct ldt_entry entries[LDT_DIRECT_ENTRIES];
+	};
+} uml_ldt_t;
+
+/*
+ * macros stolen from include/asm-i386/desc.h
+ */
+#define LDT_entry_a(info) \
+	((((info)->base_addr & 0x0000ffff) << 16) | ((info)->limit & 0x0ffff))
+
+#define LDT_entry_b(info) \
+	(((info)->base_addr & 0xff000000) | \
+	(((info)->base_addr & 0x00ff0000) >> 16) | \
+	((info)->limit & 0xf0000) | \
+	(((info)->read_exec_only ^ 1) << 9) | \
+	((info)->contents << 10) | \
+	(((info)->seg_not_present ^ 1) << 15) | \
+	((info)->seg_32bit << 22) | \
+	((info)->limit_in_pages << 23) | \
+	((info)->useable << 20) | \
+	0x7000)
+
+#define LDT_empty(info) (\
+	(info)->base_addr	== 0	&& \
+	(info)->limit		== 0	&& \
+	(info)->contents	== 0	&& \
+	(info)->read_exec_only	== 1	&& \
+	(info)->seg_32bit	== 0	&& \
+	(info)->limit_in_pages	== 0	&& \
+	(info)->seg_not_present	== 1	&& \
+	(info)->useable		== 0	)
+
+#endif
Index: 2.6.14-akpm/include/asm-um/ldt.h
===================================================================
--- 2.6.14-akpm.orig/include/asm-um/ldt.h	2005-08-28 19:41:01.000000000 -0400
+++ 2.6.14-akpm/include/asm-um/ldt.h	2005-10-28 17:31:07.000000000 -0400
@@ -1,3 +1,72 @@
+/*
+ * Copyright (C) 2004 Fujitsu Siemens Computers GmbH
+ * Licensed under the GPL
+ *
+ * Author: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
+ */
+
+#ifndef __ASM_LDT_I386_H
+#define __ASM_LDT_I386_H
+
+#include "asm/semaphore.h"
+#include "asm/arch/ldt.h"
+
+struct mmu_context_skas;
+extern void ldt_host_info(void);
+extern long init_new_ldt(struct mmu_context_skas * to_mm,
+			 struct mmu_context_skas * from_mm);
+extern void free_ldt(struct mmu_context_skas * mm);
+
+#define LDT_PAGES_MAX \
+	((LDT_ENTRIES * LDT_ENTRY_SIZE)/PAGE_SIZE)
+#define LDT_ENTRIES_PER_PAGE \
+	(PAGE_SIZE/LDT_ENTRY_SIZE)
+#define LDT_DIRECT_ENTRIES \
+	((LDT_PAGES_MAX*sizeof(void *))/LDT_ENTRY_SIZE)
+
+struct ldt_entry {
+	__u32 a;
+	__u32 b;
+};
+
+typedef struct uml_ldt {
+	int entry_count;
+	struct semaphore semaphore;
+	union {
+		struct ldt_entry * pages[LDT_PAGES_MAX];
+		struct ldt_entry entries[LDT_DIRECT_ENTRIES];
+	};
+} uml_ldt_t;
+
+/*
+ * macros stolen from include/asm-i386/desc.h
+ */
+#define LDT_entry_a(info) \
+	((((info)->base_addr & 0x0000ffff) << 16) | ((info)->limit & 0x0ffff))
+
+#define LDT_entry_b(info) \
+	(((info)->base_addr & 0xff000000) | \
+	(((info)->base_addr & 0x00ff0000) >> 16) | \
+	((info)->limit & 0xf0000) | \
+	(((info)->read_exec_only ^ 1) << 9) | \
+	((info)->contents << 10) | \
+	(((info)->seg_not_present ^ 1) << 15) | \
+	((info)->seg_32bit << 22) | \
+	((info)->limit_in_pages << 23) | \
+	((info)->useable << 20) | \
+	0x7000)
+
+#define LDT_empty(info) (\
+	(info)->base_addr	== 0	&& \
+	(info)->limit		== 0	&& \
+	(info)->contents	== 0	&& \
+	(info)->read_exec_only	== 1	&& \
+	(info)->seg_32bit	== 0	&& \
+	(info)->limit_in_pages	== 0	&& \
+	(info)->seg_not_present	== 1	&& \
+	(info)->useable		== 0	)
+
+#endif
 #ifndef __UM_LDT_H
 #define __UM_LDT_H
 

