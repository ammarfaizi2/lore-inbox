Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311034AbSCHTQ7>; Fri, 8 Mar 2002 14:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311027AbSCHTQy>; Fri, 8 Mar 2002 14:16:54 -0500
Received: from mnh-1-04.mv.com ([207.22.10.36]:9992 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S311034AbSCHTQl>;
	Fri, 8 Mar 2002 14:16:41 -0500
Message-Id: <200203081917.OAA03071@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages 
In-Reply-To: Your message of "Wed, 06 Mar 2002 20:52:29 EST."
             <20020306205229.A15048@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 08 Mar 2002 14:17:53 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bcrl@redhat.com said:
> Versus fully allocating the backing store, which would neither hang
> nor  cause segfaults.  This is the behaviour that one expects by
> default, and  should be the first line of defense before going to the
> overcommit model.   Get that aspect of reliability in place, then add
> the overcommit support.

OK, the patch below (against UML 2.4.18-2) implements reliable overcommit 
for UML.

The test was the same as before -
	64M tmpfs on /tmp
	two 64M UMLs
	one -j 2 kernel build running in each

tmpfs was exhausted nearly immediately.  Both builds ran to completion.
At the end, the 64M tmpfs was divided roughly 30M/35M between the two UMLs.

The first chunk of the patch (mm.h) is the hook that I started this thread 
talking about.  It's a noop for all arches except UML (or s390 if they decide
they can use it).

The next two (asm/page.h and mem.c) implement the hook for UML.  I believe
it correctly preserves the failure semantics of alloc_pages.  Please let me
know if I missed something.

It tests for unbacked pages by writing to them and catching the resulting
SIGBUS.  On a host with address space accounting, it would instead map the
page and catch the map failures.

The rest of the patch is UML bug fixes which you're only interested in if
you want to boot it up.

One bug - if alloc_pages returns a combination of backed and unbacked pages
for an order > 0 allocation, the backed pages will effectively be leaked.

TBD -
	a corresponding arch hook in free_pages which UML can use for 
	MADV_DONTNEED

	some way of poking at unbacked pages to see if they are now backed
	and can be released back to free_pages

These two items would go some way to allowing multiple UMLs to pass host
memory back and forth as needed when it gets scarce.

				Jeff

diff -Naur um/include/linux/mm.h back/include/linux/mm.h
--- um/include/linux/mm.h	Thu Mar  7 11:56:36 2002
+++ back/include/linux/mm.h	Thu Mar  7 11:57:31 2002
@@ -358,6 +358,13 @@
 extern struct page * FASTCALL(__alloc_pages(unsigned int gfp_mask, unsigned int order, zonelist_t *zonelist));
 extern struct page * alloc_pages_node(int nid, unsigned int gfp_mask, unsigned int order);
 
+#ifndef HAVE_ARCH_VALIDATE
+static inline struct page *arch_validate(struct page *page, unsigned int gfp_mask, int order)
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
+	return arch_validate(_alloc_pages(gfp_mask, order), gfp_mask, order);
 }
 
 #define alloc_page(gfp_mask) alloc_pages(gfp_mask, 0)
diff -Naur um/include/asm-um/page.h back/include/asm-um/page.h
--- um/include/asm-um/page.h	Mon Mar  4 17:27:34 2002
+++ back/include/asm-um/page.h	Thu Mar  7 11:57:01 2002
@@ -42,4 +42,7 @@
 #define virt_to_page(kaddr)	(mem_map + (__pa(kaddr) >> PAGE_SHIFT))
 #define VALID_PAGE(page)	((page - mem_map) < max_mapnr)
 
+extern struct page *arch_validate(struct page *page, int mask, int order);
+#define HAVE_ARCH_VALIDATE
+
 #endif
diff -Naur um/arch/um/kernel/mem.c back/arch/um/kernel/mem.c
--- um/arch/um/kernel/mem.c	Mon Mar  4 17:27:34 2002
+++ back/arch/um/kernel/mem.c	Thu Mar  7 11:57:17 2002
@@ -212,6 +212,39 @@
 "    just be swapped out.\n        Example: mem=64M\n\n"
 );
 
+struct page *arch_validate(struct page *page, int mask, int order)
+{
+	unsigned long addr, zero = 0;
+	int i;
+
+ again:
+	if(page == NULL) return(page);
+	addr = (unsigned long) page_address(page);
+	for(i = 0; i < (1 << order); i++){
+		current->thread.fault_addr = (void *) addr;
+		if(__do_copy_to_user((void *) addr, &zero, 
+				     sizeof(zero),
+				     &current->thread.fault_addr,
+				     &current->thread.fault_catcher)){
+			if(!(mask & __GFP_WAIT)) return(NULL);
+			else break;
+		}
+		addr += PAGE_SIZE;
+	}
+	if(i == (1 << order)) return(page);
+	page = _alloc_pages(mask, order);
+	goto again;
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
diff -Naur um/arch/um/kernel/exec_kern.c back/arch/um/kernel/exec_kern.c
--- um/arch/um/kernel/exec_kern.c	Mon Mar  4 17:27:34 2002
+++ back/arch/um/kernel/exec_kern.c	Mon Mar  4 18:05:20 2002
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
diff -Naur um/arch/um/kernel/process_kern.c back/arch/um/kernel/process_kern.c
--- um/arch/um/kernel/process_kern.c	Mon Mar  4 17:27:34 2002
+++ back/arch/um/kernel/process_kern.c	Mon Mar  4 18:05:20 2002
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
+++ back/arch/um/kernel/trap_kern.c	Mon Mar  4 18:05:20 2002
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
+++ back/arch/um/kernel/trap_user.c	Mon Mar  4 18:05:20 2002
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

