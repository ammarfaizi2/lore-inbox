Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269649AbUJABBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269649AbUJABBn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 21:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269653AbUJABBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 21:01:43 -0400
Received: from fmr04.intel.com ([143.183.121.6]:28032 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S269649AbUJABB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 21:01:29 -0400
Date: Thu, 30 Sep 2004 18:00:41 -0700
From: Suresh Siddha <suresh.b.siddha@intel.com>
To: Andi Kleen <ak@muc.de>, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: [Patch] no exec: sync x86_64 behaviour with i386
Message-ID: <20040930180041.D29549@unix-os.sc.intel.com>
References: <20040924154644.B25742@unix-os.sc.intel.com> <20040925085155.GA97641@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040925085155.GA97641@muc.de>; from ak@muc.de on Sat, Sep 25, 2004 at 10:51:55AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 10:51:55AM +0200, Andi Kleen wrote:
> Thanks, x86-64 part looks good.

On Sat, Sep 25, 2004 at 10:35:07PM +0200, Ingo Molnar wrote:
> * Suresh Siddha <suresh.b.siddha@intel.com> wrote:
> > +#define elf_read_implies_exec(ex, have_pt_gnu_stack)       (!(have_pt_gnu_stack))
> yeah, we noticed this a couple of days ago and the fix is in BK already
> (post 2.6.9-rc2 commit).

Here is a new patch with the already fixed i386 hunk removed.
Andrew/Andi please apply.

thanks,
suresh
--

Sync x86_64 noexec behaviour with i386. 
And remove all the confusing noexec related boot parameters.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>


diff -Nru linux-2.6.9-rc3/arch/x86_64/ia32/ia32_binfmt.c linux-nx/arch/x86_64/ia32/ia32_binfmt.c
--- linux-2.6.9-rc3/arch/x86_64/ia32/ia32_binfmt.c	2004-09-29 20:03:48.000000000 -0700
+++ linux-nx/arch/x86_64/ia32/ia32_binfmt.c	2004-09-10 15:21:23.322846112 -0700
@@ -182,6 +182,7 @@
 #define user user32
 
 #define __ASM_X86_64_ELF_H 1
+#define elf_read_implies_exec(ex, have_pt_gnu_stack)	(!(have_pt_gnu_stack))
 //#include <asm/ia32.h>
 #include <linux/elf.h>
 
@@ -360,11 +361,11 @@
 		mpnt->vm_start = PAGE_MASK & (unsigned long) bprm->p;
 		mpnt->vm_end = IA32_STACK_TOP;
 		if (executable_stack == EXSTACK_ENABLE_X)
-			mpnt->vm_flags = vm_stack_flags32 |  VM_EXEC;
+			mpnt->vm_flags = VM_STACK_FLAGS |  VM_EXEC;
 		else if (executable_stack == EXSTACK_DISABLE_X)
-			mpnt->vm_flags = vm_stack_flags32 & ~VM_EXEC;
+			mpnt->vm_flags = VM_STACK_FLAGS & ~VM_EXEC;
 		else
-			mpnt->vm_flags = vm_stack_flags32;
+			mpnt->vm_flags = VM_STACK_FLAGS;
  		mpnt->vm_page_prot = (mpnt->vm_flags & VM_EXEC) ? 
  			PAGE_COPY_EXEC : PAGE_COPY;
 		insert_vm_struct(mm, mpnt);
@@ -390,9 +391,6 @@
 	unsigned long map_addr;
 	struct task_struct *me = current; 
 
-	if (prot & PROT_READ) 
-		prot |= vm_force_exec32;
-
 	down_write(&me->mm->mmap_sem);
 	map_addr = do_mmap(filep, ELF_PAGESTART(addr),
 			   eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr), prot, 
diff -Nru linux-2.6.9-rc3/arch/x86_64/ia32/sys_ia32.c linux-nx/arch/x86_64/ia32/sys_ia32.c
--- linux-2.6.9-rc3/arch/x86_64/ia32/sys_ia32.c	2004-09-29 20:04:32.000000000 -0700
+++ linux-nx/arch/x86_64/ia32/sys_ia32.c	2004-09-10 15:21:23.323845960 -0700
@@ -218,9 +218,6 @@
 			return -EBADF;
 	}
 	
-	if (a.prot & PROT_READ) 
-		a.prot |= vm_force_exec32;
-
 	mm = current->mm; 
 	down_write(&mm->mmap_sem); 
 	retval = do_mmap_pgoff(file, a.addr, a.len, a.prot, a.flags, a.offset>>PAGE_SHIFT);
@@ -235,8 +232,6 @@
 asmlinkage long 
 sys32_mprotect(unsigned long start, size_t len, unsigned long prot)
 {
-	if (prot & PROT_READ) 
-		prot |= vm_force_exec32;
 	return sys_mprotect(start,len,prot); 
 }
 
@@ -1044,9 +1039,6 @@
 			return -EBADF;
 	}
 
-	if (prot & PROT_READ)
-		prot |= vm_force_exec32;
-
 	down_write(&mm->mmap_sem);
 	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
 	up_write(&mm->mmap_sem);
diff -Nru linux-2.6.9-rc3/arch/x86_64/kernel/setup64.c linux-nx/arch/x86_64/kernel/setup64.c
--- linux-2.6.9-rc3/arch/x86_64/kernel/setup64.c	2004-09-29 20:04:24.000000000 -0700
+++ linux-nx/arch/x86_64/kernel/setup64.c	2004-09-10 15:21:23.323845960 -0700
@@ -43,80 +43,27 @@
 
 unsigned long __supported_pte_mask = ~0UL;
 static int do_not_nx __initdata = 0;
-unsigned long vm_stack_flags = __VM_STACK_FLAGS; 
-unsigned long vm_stack_flags32 = __VM_STACK_FLAGS; 
-unsigned long vm_data_default_flags = __VM_DATA_DEFAULT_FLAGS; 
-unsigned long vm_data_default_flags32 = __VM_DATA_DEFAULT_FLAGS; 
-unsigned long vm_force_exec32 = PROT_EXEC; 
 
 /* noexec=on|off
 Control non executable mappings for 64bit processes.
 
-on	Enable
+on	Enable(default)
 off	Disable
-noforce (default) Don't enable by default for heap/stack/data, 
-	but allow PROT_EXEC to be effective
-
 */ 
 static int __init nonx_setup(char *str)
 {
 	if (!strcmp(str, "on")) {
                 __supported_pte_mask |= _PAGE_NX; 
  		do_not_nx = 0; 
- 		vm_data_default_flags &= ~VM_EXEC; 
- 		vm_stack_flags &= ~VM_EXEC;  
-	} else if (!strcmp(str, "noforce") || !strcmp(str, "off")) {
-		do_not_nx = (str[0] == 'o');
-		if (do_not_nx)
-			__supported_pte_mask &= ~_PAGE_NX; 
-		vm_data_default_flags |= VM_EXEC; 
-		vm_stack_flags |= VM_EXEC;
+	} else if (!strcmp(str, "off")) {
+		do_not_nx = 1;
+		__supported_pte_mask &= ~_PAGE_NX; 
         } 
         return 1;
 } 
 
 __setup("noexec=", nonx_setup); 
 
-/* noexec32=opt{,opt} 
-
-Control the no exec default for 32bit processes. Can be also overwritten
-per executable using ELF header flags (e.g. needed for the X server)
-Requires noexec=on or noexec=noforce to be effective.
-
-Valid options: 
-   all,on    Heap,stack,data is non executable. 	
-   off       (default) Heap,stack,data is executable
-   stack     Stack is non executable, heap/data is.
-   force     Don't imply PROT_EXEC for PROT_READ 
-   compat    (default) Imply PROT_EXEC for PROT_READ
-
-*/
- static int __init nonx32_setup(char *s)
- {
-	 while (*s) {
-		if (!strncmp(s, "all", 3) || !strncmp(s,"on",2)) {
-			vm_data_default_flags32 &= ~VM_EXEC; 
-			vm_stack_flags32 &= ~VM_EXEC;  
-		} else if (!strncmp(s, "off",3)) {
-			vm_data_default_flags32 |= VM_EXEC; 
-			vm_stack_flags32 |= VM_EXEC;  
-		} else if (!strncmp(s, "stack", 5)) {
-			vm_data_default_flags32 |= VM_EXEC; 
-			vm_stack_flags32 &= ~VM_EXEC;  		
-		} else if (!strncmp(s, "force",5)) {
-			vm_force_exec32 = 0; 
-		} else if (!strncmp(s, "compat",5)) {
-			vm_force_exec32 = PROT_EXEC;
-		} 
-		s += strcspn(s, ",");
-		if (*s == ',')
-			++s;
-	 }
-	 return 1;
-} 
-
-__setup("noexec32=", nonx32_setup); 
-
 /*
  * Great future plan:
  * Declare PDA itself and support (irqstack,tss,pml4) as per cpu data.
diff -Nru linux-2.6.9-rc3/Documentation/kernel-parameters.txt linux-nx/Documentation/kernel-parameters.txt
--- linux-2.6.9-rc3/Documentation/kernel-parameters.txt	2004-09-29 20:06:04.000000000 -0700
+++ linux-nx/Documentation/kernel-parameters.txt	2004-09-10 15:21:23.320846416 -0700
@@ -746,7 +746,7 @@
 
 	noexec		[IA-64]
 
-	noexec		[i386]
+	noexec		[i386, x86_64]
 			noexec=on: enable non-executable mappings (default)
 			noexec=off: disable nn-executable mappings
 
diff -Nru linux-2.6.9-rc3/Documentation/x86_64/boot-options.txt linux-nx/Documentation/x86_64/boot-options.txt
--- linux-2.6.9-rc3/Documentation/x86_64/boot-options.txt	2004-09-29 20:05:52.000000000 -0700
+++ linux-nx/Documentation/x86_64/boot-options.txt	2004-09-10 15:21:23.321846264 -0700
@@ -87,22 +87,8 @@
 
   noexec=on|off
 
-  on      Enable
+  on      Enable(default)
   off     Disable
-  noforce (default) Don't enable by default for heap/stack/data,
-          but allow PROT_EXEC to be effective
-
-  noexec32=opt{,opt}
-
-  Control the no exec default for 32bit processes.
-  Requires noexec=on or noexec=noforce to be effective.
-
-  Valid options:
-     all,on    Heap,stack,data is non executable.
-     off       (default) Heap,stack,data is executable
-     stack     Stack is non executable, heap/data is.
-     force     Don't imply PROT_EXEC for PROT_READ
-     compat    (default) Imply PROT_EXEC for PROT_READ
 
 SMP
 
diff -Nru linux-2.6.9-rc3/include/asm-x86_64/elf.h linux-nx/include/asm-x86_64/elf.h
--- linux-2.6.9-rc3/include/asm-x86_64/elf.h	2004-09-29 20:05:25.000000000 -0700
+++ linux-nx/include/asm-x86_64/elf.h	2004-09-10 15:21:23.324845808 -0700
@@ -143,6 +143,11 @@
 #ifdef __KERNEL__
 extern void set_personality_64bit(void);
 #define SET_PERSONALITY(ex, ibcs2) set_personality_64bit()
+/*
+ * An executable for which elf_read_implies_exec() returns TRUE will
+ * have the READ_IMPLIES_EXEC personality flag set automatically.
+ */
+#define elf_read_implies_exec(ex, have_pt_gnu_stack)	(!(have_pt_gnu_stack))
 	
 /*
  * An executable for which elf_read_implies_exec() returns TRUE will
diff -Nru linux-2.6.9-rc3/include/asm-x86_64/page.h linux-nx/include/asm-x86_64/page.h
--- linux-2.6.9-rc3/include/asm-x86_64/page.h	2004-09-29 20:03:49.000000000 -0700
+++ linux-nx/include/asm-x86_64/page.h	2004-09-10 15:21:23.324845808 -0700
@@ -130,18 +130,10 @@
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
 #define pfn_to_kaddr(pfn)      __va((pfn) << PAGE_SHIFT)
 
-#define __VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
-				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
-#define __VM_STACK_FLAGS 	(VM_GROWSDOWN | VM_READ | VM_WRITE | VM_EXEC | \
-                                VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
-
 #define VM_DATA_DEFAULT_FLAGS \
-	(test_thread_flag(TIF_IA32) ? vm_data_default_flags32 : \
-	  vm_data_default_flags) 
+	(((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0 ) | \
+	 VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
-#define VM_STACK_DEFAULT_FLAGS \
-	(test_thread_flag(TIF_IA32) ? vm_stack_flags32 : vm_stack_flags) 
-	
 #define CONFIG_ARCH_GATE_AREA 1	
 
 #ifndef __ASSEMBLY__
