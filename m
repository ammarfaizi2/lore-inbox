Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293577AbSCEEOb>; Mon, 4 Mar 2002 23:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293579AbSCEEOW>; Mon, 4 Mar 2002 23:14:22 -0500
Received: from mnh-1-19.mv.com ([207.22.10.51]:54282 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S293577AbSCEEOG>;
	Mon, 4 Mar 2002 23:14:06 -0500
Message-Id: <200203050415.XAA06766@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages 
In-Reply-To: Your message of "Mon, 04 Mar 2002 22:51:11 GMT."
             <E16i1IV-0000ss-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 04 Mar 2002 23:15:56 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@lxorguk.ukuu.org.uk said:
> You seem to misunderstand the way the allocation works - we allocate
> address space not memory in things like mmap. We allocate pages on
> demand when referenced. The page allocator is only called after a page
> is referenced

I understand perfectly well how it works.

You still don't understand what I'm talking about.  To make this a bit more
concrete, the patch below implements what I want (plus a couple of bug fixes
needed to make it work).

If you want to run it, apply the 2.4.18-2 UML patch (available at 
http://prdownloads.sourceforge.net/user-mode-linux/uml-patch-2.4.18-2.bz2) to 
a stock 2.4.18 pool.  Copy the pool, apply the patch below to one of them,
and build both.

Mount a 64M tmpfs on /tmp, boot up two 64M UMLs without the patch, run a -j 2
kernel build in each and watch them hang (see http://user-mode-linux/sf.net
for lots of docs, filesystem images, etc if you haven't run UML before).  If 
you have gdb running on them, you will see that they're stuck at some random 
place in the kernel taking an infinite stream of SIGBUSes on a page that tmpfs 
can't back.  If you apply the relay_signal piece of the patch to this pool, 
you will get panics instead of hangs.

Now do the same with two 64M UMLs with the patch.  You will see the build die
like this, but the UMLs stay up and they're fairly healthy:

gcc -D__KERNEL__ -I/kernel/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686    -c -o dma.o dma.c
cpp: output pipe has been closed
gcc: Internal compiler error: program cc1 got fatal signal 11
make[2]: *** [dma.o] Error 1

Note the following:
	the host is not short of memory, so address space accounting and the
possibility of random process deaths do not come into play
	you did not build or reboot the host kernel - all this is strictly 
inside UML
	the code added to mm.h is a no-op for every arch but UML

So, does this make things at all clearer?  Without the patch I get random
UML deaths when tmpfs can't back a page.  With it, tmpfs is forced to back
newly allocated pages when they're allocated, and the allocation returns NULL
if it can't.  The result being I get no UML deaths and fairly reasonable 
behavior.

				Jeff


diff -Naur um/arch/um/kernel/exec_kern.c back/arch/um/kernel/exec_kern.c
--- um/arch/um/kernel/exec_kern.c	Mon Mar  4 17:27:34 2002
+++ back/arch/um/kernel/exec_kern.c	Mon Mar  4 17:20:52 2002
@@ -38,6 +38,12 @@
 	int new_pid;
 
 	stack = alloc_stack();
+	if(stack == 0){
+		printk(KERN_ERR 
+		       "flush_thread : failed to allocate temporary stack\n");
+		do_exit(SIGKILL);
+	}
+		
 	new_pid = start_fork_tramp((void *) current->thread.kernel_stack,
 				   stack, 0, exec_tramp);
 	if(new_pid < 0){
diff -Naur um/arch/um/kernel/mem.c back/arch/um/kernel/mem.c
--- um/arch/um/kernel/mem.c	Mon Mar  4 17:27:34 2002
+++ back/arch/um/kernel/mem.c	Mon Mar  4 16:04:01 2002
@@ -212,6 +212,32 @@
 "    just be swapped out.\n        Example: mem=64M\n\n"
 );
 
+struct page *arch_validate(struct page *page, int order)
+{
+	unsigned long addr, zero = 0;
+	int i;
+
+	addr = (unsigned long) page_address(page);
+	for(i = 0; i < (1 << order); i++){
+		current->thread.fault_addr = (void *) addr;
+		if(__do_copy_to_user((void *) addr, &zero, sizeof(zero),
+				     &current->thread.fault_addr,
+				     &current->thread.fault_catcher))
+			return(NULL);
+		addr += PAGE_SIZE;
+	}
+	return(page);
+}
+
+extern void relay_signal(int sig, void *sc, int usermode);
+
+void bus_handler(int sig, void *sc, int usermode)
+{
+	if(current->thread.fault_catcher != NULL)
+		do_longjmp(current->thread.fault_catcher);
+	else relay_signal(sig, sc, usermode);
+}
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
diff -Naur um/arch/um/kernel/process_kern.c back/arch/um/kernel/process_kern.c
--- um/arch/um/kernel/process_kern.c	Mon Mar  4 17:27:34 2002
+++ back/arch/um/kernel/process_kern.c	Mon Mar  4 17:19:00 2002
@@ -141,7 +141,7 @@
 	unsigned long page;
 
 	if((page = __get_free_page(GFP_KERNEL)) == 0)
-		panic("Couldn't allocate new stack");
+		return(0);
 	stack_protections(page);
 	return(page);
 }
@@ -318,6 +318,11 @@
 		panic("copy_thread : pipe failed");
 	if(current->thread.forking){
 		stack = alloc_stack();
+		if(stack == 0){
+			printk(KERN_ERR "copy_thread : failed to allocate "
+			       "temporary stack\n");
+			return(-ENOMEM);
+		}
 		clone_vm = (p->mm == current->mm);
 		p->thread.temp_stack = stack;
 		new_pid = start_fork_tramp((void *) p->thread.kernel_stack,
diff -Naur um/arch/um/kernel/trap_kern.c back/arch/um/kernel/trap_kern.c
--- um/arch/um/kernel/trap_kern.c	Mon Mar  4 17:27:34 2002
+++ back/arch/um/kernel/trap_kern.c	Mon Mar  4 17:22:26 2002
@@ -30,6 +30,7 @@
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	struct siginfo si;
+	void *catcher;
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *pte;
@@ -40,6 +41,7 @@
 		return(0);
 	}
 	if(mm == NULL) panic("Segfault with no mm");
+	catcher = current->thread.fault_catcher;
 	si.si_code = SEGV_MAPERR;
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, address);
@@ -84,10 +86,10 @@
 	up_read(&mm->mmap_sem);
 	return(0);
  bad:
-	if (current->thread.fault_catcher != NULL) {
+	if(catcher != NULL) {
 		current->thread.fault_addr = (void *) address;
 		up_read(&mm->mmap_sem);
-		do_longjmp(current->thread.fault_catcher);
+		do_longjmp(catcher);
 	} 
 	else if(current->thread.fault_addr != NULL){
 		panic("fault_addr set but no fault catcher");
@@ -120,6 +122,7 @@
 
 void relay_signal(int sig, void *sc, int usermode)
 {
+	if(!usermode) panic("Kernel mode signal %d", sig);
 	force_sig(sig, current);
 }
 
diff -Naur um/arch/um/kernel/trap_user.c back/arch/um/kernel/trap_user.c
--- um/arch/um/kernel/trap_user.c	Mon Mar  4 17:27:34 2002
+++ back/arch/um/kernel/trap_user.c	Mon Mar  4 15:45:58 2002
@@ -420,11 +420,13 @@
 
 extern int timer_ready, timer_on;
 
+extern void bus_handler(int sig, void *sc, int usermode);
+
 static void (*handlers[])(int, void *, int) = {
 	[ SIGTRAP ] relay_signal,
 	[ SIGFPE ] relay_signal,
 	[ SIGILL ] relay_signal,
-	[ SIGBUS ] relay_signal,
+	[ SIGBUS ] bus_handler,
 	[ SIGSEGV] segv_handler,
 	[ SIGIO ] sigio_handler,
 	[ SIGVTALRM ] timer_handler,
diff -Naur um/include/asm-um/page.h back/include/asm-um/page.h
--- um/include/asm-um/page.h	Mon Mar  4 17:27:34 2002
+++ back/include/asm-um/page.h	Mon Mar  4 15:45:46 2002
@@ -42,4 +42,7 @@
 #define virt_to_page(kaddr)	(mem_map + (__pa(kaddr) >> PAGE_SHIFT))
 #define VALID_PAGE(page)	((page - mem_map) < max_mapnr)
 
+extern struct page *arch_validate(struct page *page, int order);
+#define HAVE_ARCH_VALIDATE
+
 #endif
diff -Naur um/include/linux/mm.h back/include/linux/mm.h
--- um/include/linux/mm.h	Mon Mar  4 16:16:44 2002
+++ back/include/linux/mm.h	Mon Mar  4 16:43:26 2002
@@ -358,6 +358,13 @@
 extern struct page * FASTCALL(__alloc_pages(unsigned int gfp_mask, unsigned int order, zonelist_t *zonelist));
 extern struct page * alloc_pages_node(int nid, unsigned int gfp_mask, unsigned int order);
 
+#ifndef HAVE_ARCH_VALIDATE
+static inline struct page *arch_validate(struct page *page, int order)
+{
+        return(page);
+}
+#endif
+
 static inline struct page * alloc_pages(unsigned int gfp_mask, unsigned int order)
 {
 	/*
@@ -365,7 +372,7 @@
 	 */
 	if (order >= MAX_ORDER)
 		return NULL;
-	return _alloc_pages(gfp_mask, order);
+	return arch_validate(_alloc_pages(gfp_mask, order), order);
 }
 
 #define alloc_page(gfp_mask) alloc_pages(gfp_mask, 0)

