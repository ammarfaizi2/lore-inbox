Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263163AbVGABUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbVGABUS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 21:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbVGABUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 21:20:18 -0400
Received: from mtaout4.barak.net.il ([212.150.49.174]:12449 "EHLO
	mtaout4.barak.net.il") by vger.kernel.org with ESMTP
	id S263186AbVGABSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 21:18:22 -0400
Date: Fri, 01 Jul 2005 04:23:08 +0300
From: eliad lubovsky <eliadl@013.net>
Subject: Re: Handle kernel page faults using task gate
In-reply-to: <20050630071101.GB26239@elte.hu>
To: Ingo Molnar <mingo@elte.hu>
Cc: 76306.1226@compuserve.com, linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <1120180987.3312.30.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2)
Content-type: multipart/mixed; boundary="=-erZsIACfkZj6Avx+hECH"
References: <1119997135.4074.106.camel@localhost.localdomain>
 <20050629130901.GA29776@elte.hu> <20050629192740.GA5940@elte.hu>
 <1120114635.3422.2.camel@localhost.localdomain>
 <20050630071101.GB26239@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-erZsIACfkZj6Avx+hECH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

attached a patch, it may be more clear to understand what I have done.
To cause a page fault there is a need to compile the kernel with 8KB
stack, and use the following module and application:
the module is a char device "my_device", the application opens a fd to
the module and call ioctl, the module respond in calling to an
overloaded stack function which cause a page fault. 
the task gate is being set dynamically by the ioctl sys_call.


#include <linux/module.h>
#include <linux/types.h>
#include <linux/kernel.h>
#include <linux/fs.h>
#include <linux/mm.h>
#include <linux/init.h>
#include <linux/ioport.h>
#include <asm/io.h>
#include <linux/vmalloc.h>
                                                                                                                             
#include <asm/irq.h>
#include <asm/uaccess.h>
                                                                                                                             
int simple_open (struct inode *inode, struct file *filp);
int simple_release(struct inode *inode, struct file *filp);
int simple_ioctl (struct inode *inode, struct file *filp, unsigned int
cmd, unsigned long arg);
                                                                                                                             
static int simple_major = 0;
//extern void my_set_task_gate(unsigned int n, unsigned int gdt);
//extern void my_set_page_fault_intr_gate();
                                                                                                                             
struct file_operations simple_nopage_ops = {
    open:    simple_open,
    release: simple_release,
    ioctl:   simple_ioctl
};
                                                                                                                             
struct file_operations *simple_fops = {
    &simple_nopage_ops,
};
                                                                                                                             
int simple_open (struct inode *inode, struct file *filp)
{
  filp->f_op = simple_fops;
  filp->private_data = 0;

return 0;
}
                                                                                                                             int simple_release(struct inode *inode, struct file *filp)
{
 printk(KERN_INFO "Driver: simple release\n");
    return 0;
}

/* declare a stack that is larger then a PAGE_SIZE
*/                                                                                                                             static void call_overloaded_stack(void)
{
char buff[1420];
char buff1[1420];
char buff2[1500];

 printk(KERN_INFO "overloaded stack called\n");
 buff[1400] = 1;
 buff1[1400] = 1;
 buff2[1450] = 1;
}

/* cause a page fault by calling to call_overloaded_stack() method */
int simple_ioctl (struct inode *inode, struct file *filp,
                 unsigned int cmd, unsigned long arg)
{
  printk(KERN_INFO "Driver: Pre simple ioctl\n");

  /* set task gate */
//  my_set_task_gate(14,  GDT_ENTRY_PAGE_FAULT_TSS); /* it is being set
by the ioctl sys_call */

  call_overloaded_stack();

  /* return to interrupt gate */
//  my_set_page_fault_intr_gate();
  return 0;
}

static int __init mm_init(void)
{
  int result;
                                                                                                                               printk("Driver: initialized\n");

  result = register_chrdev(simple_major, "my_device",
&simple_nopage_ops);
  if (result < 0)
  {
        printk(KERN_WARNING "Driver: my_device: unable to get major
%d\n", simple_major);
        return result;
  }
  if (simple_major == 0)
      simple_major = result;
                                                                                                                                                                                                                                                              return 0;
}
                                                                  
static void __exit mm_exit(void)
{
  printk("Driver: exited\n");
  unregister_chrdev(simple_major, "my_device");
}

MODULE_AUTHOR("Eliad Lubovsky");
MODULE_DESCRIPTION("Memory Test");
MODULE_LICENSE("GPL");

module_init(mm_init);
module_exit(mm_exit);


/***********************************************************/
Application: open device and implement ioctl to cause a page fault by an
overloaded stack.

#include <unistd.h>
#include <stdio.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <fcntl.h>
                                                                                                                                                                                                                                                         int main(int argc, char ** argv) {
  int ret;
  unsigned int i=0;
  int fd = open("/dev/my_device", O_RDWR);

  if(fd<0) {
        printf("Failed to open my_device\n");
        exit(1);
  }

  ret = ioctl(fd, 0, i);
                                                                                                                               if(ret != 0) {
    printf("Ioctl failed\n");
    exit(1);
  }
                                                                                                                               close(fd);
  return 0;
}


On Thu, 2005-06-30 at 10:11, Ingo Molnar wrote:
> * eliad lubovsky <eliadl@013.net> wrote:
> 
> > How do I clear the 'busy' bit?
> > I set my TSS descriptor with
> > __set_tss_desc(cpu, GDT_ENTRY_PAGE_FAULT_TSS, &pagefault_tss);
> 
> i suspect you have to clear the busy bit in the pagefault handler 
> itself. The CPU marks it as busy upon fault. I guess it would be OK to 
> just do the above __set_tss_desc() for _every_ pagefault, that too will 
> clear the busy bit, but you are probably better off just clearing that 
> bit manually:
> 
>     cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &= 0xfffffdff;
> 
> 	Ingo

--=-erZsIACfkZj6Avx+hECH
Content-Disposition: attachment; filename=2.6.9_pagefault.patch
Content-Type: text/x-patch; name=2.6.9_pagefault.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -urNp linux-2.6.9.orig/arch/i386/kernel/cpu/common.c linux-2.6.9/arch/i386/kernel/cpu/common.c
--- linux-2.6.9.orig/arch/i386/kernel/cpu/common.c	2004-10-18 23:53:07.000000000 +0200
+++ linux-2.6.9/arch/i386/kernel/cpu/common.c	2005-06-30 13:24:06.000000000 +0300
@@ -565,11 +565,13 @@ void __init cpu_init (void)
 	/* Set up doublefault TSS pointer in the GDT */
 	__set_tss_desc(cpu, GDT_ENTRY_DOUBLEFAULT_TSS, &doublefault_tss);
 
+	/* Set up page fault TSS pointer in the GDT */
+	__set_tss_desc(cpu, GDT_ENTRY_PAGE_FAULT_TSS, &pagefault_tss); 
+
 	/* Clear %fs and %gs. */
 	asm volatile ("xorl %eax, %eax; movl %eax, %fs; movl %eax, %gs");
 
 	/* Clear all 6 debug registers: */
-
 #define CD(register) __asm__("movl %0,%%db" #register ::"r"(0) );
 
 	CD(0); CD(1); CD(2); CD(3); /* no db4 and db5 */; CD(6); CD(7);
diff -urNp linux-2.6.9.orig/arch/i386/kernel/Makefile linux-2.6.9/arch/i386/kernel/Makefile
--- linux-2.6.9.orig/arch/i386/kernel/Makefile	2004-10-18 23:53:25.000000000 +0200
+++ linux-2.6.9/arch/i386/kernel/Makefile	2005-06-30 13:24:44.000000000 +0300
@@ -7,7 +7,7 @@ extra-y := head.o init_task.o vmlinux.ld
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o \
-		doublefault.o
+		doublefault.o pagefault.o
 
 obj-y				+= cpu/
 obj-y				+= timers/
diff -urNp linux-2.6.9.orig/arch/i386/kernel/pagefault.c linux-2.6.9/arch/i386/kernel/pagefault.c
--- linux-2.6.9.orig/arch/i386/kernel/pagefault.c	1970-01-01 02:00:00.000000000 +0200
+++ linux-2.6.9/arch/i386/kernel/pagefault.c	2005-07-01 03:03:02.000000000 +0300
@@ -0,0 +1,79 @@
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <linux/init_task.h>
+#include <linux/fs.h>
+
+#include <asm/uaccess.h>
+#include <asm/pgtable.h>
+#include <asm/processor.h>
+#include <asm/desc.h>
+#include <asm/vmalloc_thread_info.h>
+
+#define PAGEFAULT_STACKSIZE (2048)
+static unsigned long pagefault_stack[PAGEFAULT_STACKSIZE];
+#define STACK_START (unsigned long)(pagefault_stack+PAGEFAULT_STACKSIZE)
+
+#define ptr_ok(x) ((x) > PAGE_OFFSET && (x) < PAGE_OFFSET + 0x1000000)
+
+extern struct vm_struct *find_vm_area(void *addr);
+extern void expand_stack_size(struct vm_struct *area);
+
+static void pagefault_fn(void)
+{
+	unsigned int address, aligned_addr;
+	unsigned int i=0;
+	struct vm_struct *area;
+
+	goto handle_fault;
+
+return_from_fault:
+
+//        __set_tss_desc(0, GDT_ENTRY_PAGE_FAULT_TSS, &pagefault_tss);
+        __asm__("iret");
+
+handle_fault:
+
+printk("gdt entry a 0x%x\ngdt entry b 0x%x\n", (unsigned)(cpu_gdt_table[GDT_ENTRY_PAGE_FAULT_TSS].a), (unsigned)(cpu_gdt_table[GDT_ENTRY_PAGE_FAULT_TSS].b));
+
+	/* clear busy bit in the tss descriptor */
+	cpu_gdt_table[GDT_ENTRY_PAGE_FAULT_TSS].b &= 0xfffffdff;
+        //__set_tss_desc(0, GDT_ENTRY_PAGE_FAULT_TSS, &pagefault_tss);
+
+        __asm__("movl %%cr2,%0":"=r" (address));
+
+	aligned_addr = ((address+PAGE_SIZE)&(~(PAGE_SIZE-1)));
+	printk("Page fault address 0x%x, start address 0x%x\n", address, aligned_addr);
+
+	/* search for the vm area */
+	for(i=0; i<THREAD_SIZE/PAGE_SIZE; i++) {
+		area = find_vm_area((void*)(aligned_addr-(i*PAGE_SIZE)));
+		if(area) {
+			printk("vm area 0x%x, addr 0x%x, address 0x%x\n", (unsigned int)area, (unsigned int)(area->addr), aligned_addr-(i*4096));
+			break;
+		}
+	}
+
+	/* allocate a new physical page, expand the stack size */
+	expand_stack_size(area);
+
+	goto return_from_fault;
+}
+
+struct tss_struct pagefault_tss __cacheline_aligned = {
+	.esp0		= STACK_START,
+	.ss0		= __KERNEL_DS,
+	.ldt		= 0,
+	.io_bitmap_base	= INVALID_IO_BITMAP_OFFSET,
+
+	.eip		= (unsigned long) pagefault_fn,
+	.eflags		= X86_EFLAGS_SF | 0x2,	/* 0x2 bit is always set */
+	.esp		= STACK_START,
+	.es		= __USER_DS,
+	.cs		= __KERNEL_CS,
+	.ss		= __KERNEL_DS,
+	.ds		= __USER_DS,
+
+	.__cr3		= __pa(swapper_pg_dir)
+};
diff -urNp linux-2.6.9.orig/arch/i386/kernel/traps.c linux-2.6.9/arch/i386/kernel/traps.c
--- linux-2.6.9.orig/arch/i386/kernel/traps.c	2004-10-18 23:53:23.000000000 +0200
+++ linux-2.6.9/arch/i386/kernel/traps.c	2005-06-30 13:23:49.000000000 +0300
@@ -1025,6 +1025,20 @@ static void __init set_task_gate(unsigne
 	_set_gate(idt_table+n,5,0,0,(gdt_entry<<3));
 }
 
+void my_set_task_gate(unsigned int n, unsigned int gdt_entry)
+{
+	set_task_gate(n, gdt_entry);
+}
+
+EXPORT_SYMBOL(my_set_task_gate);
+
+void my_set_page_fault_intr_gate()
+{
+	set_intr_gate(14,&page_fault);
+}
+
+EXPORT_SYMBOL(my_set_page_fault_intr_gate);
+
 
 void __init trap_init(void)
 {
diff -urNp linux-2.6.9.orig/fs/ioctl.c linux-2.6.9/fs/ioctl.c
--- linux-2.6.9.orig/fs/ioctl.c	2004-10-18 23:53:43.000000000 +0200
+++ linux-2.6.9/fs/ioctl.c	2005-06-30 13:26:21.000000000 +0300
@@ -57,6 +57,9 @@ asmlinkage long sys_ioctl(unsigned int f
 	unsigned int flag;
 	int on, error = -EBADF;
 
+	/* set task gate entry in the idt */
+	my_set_task_gate(14, GDT_ENTRY_PAGE_FAULT_TSS);
+
 	filp = fget(fd);
 	if (!filp)
 		goto out;
@@ -133,6 +136,9 @@ asmlinkage long sys_ioctl(unsigned int f
 	fput(filp);
 
 out:
+	/* set intr gate entry in the idt */
+	my_set_page_fault_intr_gate();
+
 	return error;
 }
 
diff -urNp linux-2.6.9.orig/include/asm-i386/processor.h linux-2.6.9/include/asm-i386/processor.h
--- linux-2.6.9.orig/include/asm-i386/processor.h	2004-10-18 23:53:07.000000000 +0200
+++ linux-2.6.9/include/asm-i386/processor.h	2005-06-30 13:22:59.000000000 +0300
@@ -86,6 +86,7 @@ struct cpuinfo_x86 {
 extern struct cpuinfo_x86 boot_cpu_data;
 extern struct cpuinfo_x86 new_cpu_data;
 extern struct tss_struct doublefault_tss;
+extern struct tss_struct pagefault_tss;
 DECLARE_PER_CPU(struct tss_struct, init_tss);
 
 #ifdef CONFIG_SMP
diff -urNp linux-2.6.9.orig/include/asm-i386/segment.h linux-2.6.9/include/asm-i386/segment.h
--- linux-2.6.9.orig/include/asm-i386/segment.h	2004-10-18 23:53:44.000000000 +0200
+++ linux-2.6.9/include/asm-i386/segment.h	2005-06-30 13:22:43.000000000 +0300
@@ -42,7 +42,7 @@
  *  27 - unused
  *  28 - unused
  *  29 - unused
- *  30 - unused
+ *  30 - TSS for page fault handler
  *  31 - TSS for double fault handler
  */
 #define GDT_ENTRY_TLS_ENTRIES	3
@@ -71,6 +71,7 @@
 #define GDT_ENTRY_PNPBIOS_BASE		(GDT_ENTRY_KERNEL_BASE + 6)
 #define GDT_ENTRY_APMBIOS_BASE		(GDT_ENTRY_KERNEL_BASE + 11)
 
+#define GDT_ENTRY_PAGE_FAULT_TSS	30
 #define GDT_ENTRY_DOUBLEFAULT_TSS	31
 
 /*
diff -urNp linux-2.6.9.orig/include/asm-i386/smp.h linux-2.6.9/include/asm-i386/smp.h
--- linux-2.6.9.orig/include/asm-i386/smp.h	2004-10-18 23:55:36.000000000 +0200
+++ linux-2.6.9/include/asm-i386/smp.h	2005-06-30 13:22:32.000000000 +0300
@@ -50,7 +50,8 @@ extern u8 x86_cpu_to_apicid[];
  * from the initial startup. We map APIC_BASE very early in page_setup(),
  * so this is correct in the x86 case.
  */
-#define smp_processor_id() (current_thread_info()->cpu)
+//#define smp_processor_id() (current_thread_info()->cpu)
+#define smp_processor_id() 0
 
 extern cpumask_t cpu_callout_map;
 #define cpu_possible_map cpu_callout_map
diff -urNp linux-2.6.9.orig/include/asm-i386/thread_info.h linux-2.6.9/include/asm-i386/thread_info.h
--- linux-2.6.9.orig/include/asm-i386/thread_info.h	2004-10-18 23:53:21.000000000 +0200
+++ linux-2.6.9/include/asm-i386/thread_info.h	2005-06-30 13:22:14.000000000 +0300
@@ -55,7 +55,7 @@ struct thread_info {
 #ifdef CONFIG_4KSTACKS
 #define THREAD_SIZE            (4096)
 #else
-#define THREAD_SIZE		(8192)
+#define THREAD_SIZE		(8192*2)
 #endif
 
 #define STACK_WARN             (THREAD_SIZE/8)
diff -urNp linux-2.6.9.orig/include/asm-i386/vmalloc_thread_info.h linux-2.6.9/include/asm-i386/vmalloc_thread_info.h
--- linux-2.6.9.orig/include/asm-i386/vmalloc_thread_info.h	1970-01-01 02:00:00.000000000 +0200
+++ linux-2.6.9/include/asm-i386/vmalloc_thread_info.h	2005-06-30 13:25:55.000000000 +0300
@@ -0,0 +1,15 @@
+#ifndef _LINUX_VMALLOC_THREAD_INFO_H 
+#define _LINUX_VMALLOC_THREAD_INFO_H
+
+#include <linux/spinlock.h>
+#include <asm/page.h>		/* pgprot_t */
+
+
+/*
+ *	Highlevel APIs for driver use
+ */
+extern void *vmalloc_thread_info(unsigned long size);
+extern void extend_stack_size(struct vm_struct *area);
+
+#endif /* _LINUX_VMALLOC_THREAD_INFO_H */
+
diff -urNp linux-2.6.9.orig/include/linux/gfp.h linux-2.6.9/include/linux/gfp.h
--- linux-2.6.9.orig/include/linux/gfp.h	2004-10-18 23:53:44.000000000 +0200
+++ linux-2.6.9/include/linux/gfp.h	2005-06-30 13:23:23.000000000 +0300
@@ -91,6 +91,19 @@ static inline struct page *alloc_pages_n
 		NODE_DATA(nid)->node_zonelists + (gfp_mask & GFP_ZONEMASK));
 }
 
+extern struct page *
+FASTCALL(__alloc_thread_info_pages(unsigned int, unsigned int, struct zonelist *));
+                                                                                                                             
+static inline struct page *alloc_thread_info_pages_node(int nid, unsigned int gfp_mask,
+                                                unsigned int order)
+{
+        if (unlikely(order >= MAX_ORDER))
+                return NULL;
+                                                                                                                             
+        return __alloc_thread_info_pages(gfp_mask, order,
+                NODE_DATA(nid)->node_zonelists + (gfp_mask & GFP_ZONEMASK));
+}
+
 #ifdef CONFIG_NUMA
 extern struct page *alloc_pages_current(unsigned gfp_mask, unsigned order);
 
@@ -107,9 +120,12 @@ extern struct page *alloc_page_vma(unsig
 #else
 #define alloc_pages(gfp_mask, order) \
 		alloc_pages_node(numa_node_id(), gfp_mask, order)
+#define alloc_thread_info_pages(gfp_mask, order) \
+		alloc_thread_info_pages_node(numa_node_id(), gfp_mask, order)
 #define alloc_page_vma(gfp_mask, vma, addr) alloc_pages(gfp_mask, 0)
 #endif
 #define alloc_page(gfp_mask) alloc_pages(gfp_mask, 0)
+#define alloc_thread_info_page(gfp_mask) alloc_thread_info_pages(gfp_mask, 0)
 
 extern unsigned long FASTCALL(__get_free_pages(unsigned int gfp_mask, unsigned int order));
 extern unsigned long FASTCALL(get_zeroed_page(unsigned int gfp_mask));
diff -urNp linux-2.6.9.orig/kernel/fork.c linux-2.6.9/kernel/fork.c
--- linux-2.6.9.orig/kernel/fork.c	2004-10-18 23:53:13.000000000 +0200
+++ linux-2.6.9/kernel/fork.c	2005-06-30 13:21:42.000000000 +0300
@@ -79,7 +79,11 @@ static kmem_cache_t *task_struct_cachep;
 
 void free_task(struct task_struct *tsk)
 {
+#if 0
 	free_thread_info(tsk->thread_info);
+#else
+	vfree_thread_info(tsk->thread_info);
+#endif
 	free_task_struct(tsk);
 }
 EXPORT_SYMBOL(free_task);
@@ -264,7 +268,12 @@ static struct task_struct *dup_task_stru
 	if (!tsk)
 		return NULL;
 
+#if 0
 	ti = alloc_thread_info(tsk);
+#else
+          ti = vmalloc_thread_info(THREAD_SIZE);
+#endif
+
 	if (!ti) {
 		free_task_struct(tsk);
 		return NULL;
diff -urNp linux-2.6.9.orig/mm/Makefile linux-2.6.9/mm/Makefile
--- linux-2.6.9.orig/mm/Makefile	2004-10-18 23:54:37.000000000 +0200
+++ linux-2.6.9/mm/Makefile	2005-06-30 13:20:45.000000000 +0300
@@ -5,7 +5,7 @@
 mmu-y			:= nommu.o
 mmu-$(CONFIG_MMU)	:= fremap.o highmem.o madvise.o memory.o mincore.o \
 			   mlock.o mmap.o mprotect.o mremap.o msync.o rmap.o \
-			   vmalloc.o
+			   vmalloc.o vmalloc_thread_info.o
 
 obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o fadvise.o \
 			   page_alloc.o page-writeback.o pdflush.o prio_tree.o \
diff -urNp linux-2.6.9.orig/mm/page_alloc.c linux-2.6.9/mm/page_alloc.c
--- linux-2.6.9.orig/mm/page_alloc.c	2004-10-18 23:53:11.000000000 +0200
+++ linux-2.6.9/mm/page_alloc.c	2005-06-30 13:20:28.000000000 +0300
@@ -2069,3 +2069,157 @@ void *__init alloc_large_system_hash(con
 
 	return table;
 }
+
+
+struct page * fastcall
+__alloc_thread_info_pages(unsigned int gfp_mask, unsigned int order,
+		struct zonelist *zonelist)
+{
+	const int wait = gfp_mask & __GFP_WAIT;
+	unsigned long min;
+	struct zone **zones, *z;
+	struct page *page;
+	struct reclaim_state reclaim_state;
+//	struct task_struct *p = current;
+	int i;
+	int alloc_type;
+	int do_retry;
+	int can_try_harder;
+
+	might_sleep_if(wait);
+
+	/*
+	 * The caller may dip into page reserves a bit more if the caller
+	 * cannot run direct reclaim, or is the caller has realtime scheduling
+	 * policy
+	 */
+//	can_try_harder = (unlikely(rt_task(p)) && !in_interrupt()) || !wait;
+	can_try_harder = 0;
+
+	zones = zonelist->zones;  /* the list of zones suitable for gfp_mask */
+
+	if (unlikely(zones[0] == NULL)) {
+		/* Should this ever happen?? */
+		return NULL;
+	}
+
+	alloc_type = zone_idx(zones[0]);
+
+	/* Go through the zonelist once, looking for a zone with enough free */
+	for (i = 0; (z = zones[i]) != NULL; i++) {
+		min = z->pages_low + (1<<order) + z->protection[alloc_type];
+
+		if (z->free_pages < min)
+			continue;
+
+		page = buffered_rmqueue(z, order, gfp_mask);
+		if (page)
+			goto got_pg;
+	}
+
+	for (i = 0; (z = zones[i]) != NULL; i++)
+		wakeup_kswapd(z);
+
+	/*
+	 * Go through the zonelist again. Let __GFP_HIGH and allocations
+	 * coming from realtime tasks to go deeper into reserves
+	 */
+	for (i = 0; (z = zones[i]) != NULL; i++) {
+		min = z->pages_min;
+		if (gfp_mask & __GFP_HIGH)
+			min /= 2;
+		if (can_try_harder)
+			min -= min / 4;
+		min += (1<<order) + z->protection[alloc_type];
+
+		if (z->free_pages < min)
+			continue;
+
+		page = buffered_rmqueue(z, order, gfp_mask);
+		if (page)
+			goto got_pg;
+	}
+
+#if 0
+	/* This allocation should allow future memory freeing. */
+	if ((p->flags & (PF_MEMALLOC | PF_MEMDIE)) && !in_interrupt()) {
+		/* go through the zonelist yet again, ignoring mins */
+		for (i = 0; (z = zones[i]) != NULL; i++) {
+			page = buffered_rmqueue(z, order, gfp_mask);
+			if (page)
+				goto got_pg;
+		}
+		goto nopage;
+	}
+#endif
+#if 0
+	/* Atomic allocations - we can't balance anything */
+	if (!wait)
+		goto nopage;
+
+#endif
+rebalance:
+#if 0
+	/* We now go into synchronous reclaim */
+	p->flags |= PF_MEMALLOC;
+	reclaim_state.reclaimed_slab = 0;
+	p->reclaim_state = &reclaim_state;
+
+	try_to_free_pages(zones, gfp_mask, order);
+
+	p->reclaim_state = NULL;
+	p->flags &= ~PF_MEMALLOC;
+#endif
+	/* go through the zonelist yet one more time */
+	for (i = 0; (z = zones[i]) != NULL; i++) {
+		min = z->pages_min;
+		if (gfp_mask & __GFP_HIGH)
+			min /= 2;
+		if (can_try_harder)
+			min -= min / 4;
+		min += (1<<order) + z->protection[alloc_type];
+
+		if (z->free_pages < min)
+			continue;
+
+		page = buffered_rmqueue(z, order, gfp_mask);
+		if (page)
+			goto got_pg;
+	}
+
+	/*
+	 * Don't let big-order allocations loop unless the caller explicitly
+	 * requests that.  Wait for some write requests to complete then retry.
+	 *
+	 * In this implementation, __GFP_REPEAT means __GFP_NOFAIL for order
+	 * <= 3, but that may not be true in other implementations.
+	 */
+	do_retry = 0;
+	if (!(gfp_mask & __GFP_NORETRY)) {
+		if ((order <= 3) || (gfp_mask & __GFP_REPEAT))
+			do_retry = 1;
+		if (gfp_mask & __GFP_NOFAIL)
+			do_retry = 1;
+	}
+	if (do_retry) {
+		blk_congestion_wait(WRITE, HZ/50);
+		goto rebalance;
+	}
+
+nopage:
+#if 0
+	if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit()) {
+		printk(KERN_WARNING "%s: page allocation failure."
+			" order:%d, mode:0x%x\n",
+			p->comm, order, gfp_mask);
+		dump_stack();
+	}
+#endif
+	return NULL;
+got_pg:
+	zone_statistics(zonelist, z);
+	kernel_map_pages(page, 1 << order, 1);
+	return page;
+}
+
+EXPORT_SYMBOL(__alloc_thread_info_pages);
diff -urNp linux-2.6.9.orig/mm/vmalloc_thread_info.c linux-2.6.9/mm/vmalloc_thread_info.c
--- linux-2.6.9.orig/mm/vmalloc_thread_info.c	1970-01-01 02:00:00.000000000 +0200
+++ linux-2.6.9/mm/vmalloc_thread_info.c	2005-07-01 03:45:18.000000000 +0300
@@ -0,0 +1,502 @@
+/*
+ *  linux/mm/vmalloc_thread_info.c
+ *
+ */
+
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/highmem.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+
+#include <linux/vmalloc.h>
+
+#include <asm/uaccess.h>
+#include <asm/tlbflush.h>
+
+
+extern rwlock_t vmlist_lock;
+extern struct vm_struct *vmlist;
+
+void __vunmap_thread_info(void *addr, int deallocate_pages)
+{
+        struct vm_struct *area;
+                                                                                
+        if (!addr)
+                return;
+                                                                                
+        if ((PAGE_SIZE-1) & (unsigned long)addr) {
+                printk(KERN_ERR "Trying to vfree() bad address (%p)\n", addr);
+                WARN_ON(1);
+                return;
+        }
+                                                                                
+        area = remove_vm_area(addr);
+        if (unlikely(!area)) {
+                printk(KERN_ERR "Trying to vfree() nonexistent vm area (%p)\n",
+                                addr);
+                WARN_ON(1);
+                return;
+        }
+                                                                                
+        if (deallocate_pages) {
+		int i;                                                                                
+
+                for (i = 0; i < area->nr_pages; i++) {
+                        if (!(area->pages[i]))
+                                continue;
+                        __free_page(area->pages[i]);
+                }
+                kfree(area->pages);
+        }
+                                                                                
+        kfree(area);
+        return;
+}
+
+void vfree_thread_info(void *addr)
+{
+        BUG_ON(in_interrupt());
+        __vunmap_thread_info(addr, 1);
+}
+
+EXPORT_SYMBOL(vfree_thread_info);
+
+static int map_area_pte_ti(pte_t *pte, unsigned long address,
+                               unsigned long size, pgprot_t prot,
+                               struct page ***pages)
+{
+        unsigned long end;
+        struct page *page = **pages;
+                                                                                
+        address &= ~PMD_MASK;
+        end = address + size;
+        if (end > PMD_SIZE)
+                end = PMD_SIZE;
+                                                                                
+//        do {
+                //struct page *page = **pages;
+                WARN_ON(!pte_none(*pte));
+                if (!page)
+                        return -ENOMEM;
+                set_pte(pte, mk_pte(page, prot));
+
+
+//                address += PAGE_SIZE;
+                pte += (THREAD_SIZE/PAGE_SIZE-1);
+                (*pages) += (THREAD_SIZE/PAGE_SIZE-1);
+                page = **pages;
+                WARN_ON(!pte_none(*pte));
+                if (!page)
+                        return -ENOMEM;
+                set_pte(pte, mk_pte(page, prot));
+
+//                address += PAGE_SIZE;
+//                pte++;
+//                (*pages)++;
+
+
+
+//        } while (address < end);
+        return 0;
+}
+
+static int map_area_pmd_ti(pmd_t *pmd, unsigned long address,
+                               unsigned long size, pgprot_t prot,
+                               struct page ***pages)
+{
+        unsigned long base, end;
+                                                                                
+        base = address & PGDIR_MASK;
+        address &= ~PGDIR_MASK;
+        end = address + size;
+        if (end > PGDIR_SIZE)
+                end = PGDIR_SIZE;
+                                                                                
+        do {
+                pte_t * pte = pte_alloc_kernel(&init_mm, pmd, base + address);
+                if (!pte)
+                        return -ENOMEM;
+                if (map_area_pte_ti(pte, address, end - address, prot, pages))
+                        return -ENOMEM;
+                address = (address + PMD_SIZE) & PMD_MASK;
+                pmd++;
+        } while (address < end);
+                                                                                
+        return 0;
+}
+
+int map_vm_area_ti(struct vm_struct *area, pgprot_t prot, struct page ***pages)
+{
+        unsigned long address = (unsigned long) area->addr;
+        unsigned long end = address + (area->size-PAGE_SIZE);
+        pgd_t *dir;
+        int err = 0;
+                                                                                
+        dir = pgd_offset_k(address);
+        spin_lock(&init_mm.page_table_lock);
+        do {
+                pmd_t *pmd = pmd_alloc(&init_mm, dir, address);
+                if (!pmd) {
+                        err = -ENOMEM;
+                        break;
+                }
+                if (map_area_pmd_ti(pmd, address, end - address, prot, pages)) {
+                        err = -ENOMEM;
+                        break;
+                }
+                                                                                
+                address = (address + PGDIR_SIZE) & PGDIR_MASK;
+                dir++;
+        } while (address && (address < end));
+                                                                                
+        spin_unlock(&init_mm.page_table_lock);
+        flush_cache_vmap((unsigned long) area->addr, end);
+        return err;
+}
+
+struct vm_struct *__get_vm_area_ti(unsigned long size, unsigned long flags,
+                                unsigned long start, unsigned long end)
+{
+        struct vm_struct **p, *tmp, *area;
+        unsigned long align = THREAD_SIZE;
+        unsigned long addr;
+
+        addr = ALIGN(start, align);
+        area = kmalloc(sizeof(*area), GFP_KERNEL);
+        if (unlikely(!area))
+                return NULL;
+
+        /*
+         * We always allocate a guard page.
+         */
+        size += PAGE_SIZE;
+        if (unlikely(!size)) {
+                kfree (area);
+                return NULL;
+        }
+                                                                                                                             
+        write_lock(&vmlist_lock);
+        for (p = &vmlist; (tmp = *p) != NULL ;p = &tmp->next) {
+                if ((unsigned long)tmp->addr < addr) {
+                        if((unsigned long)tmp->addr + tmp->size >= addr)
+                                addr = ALIGN(tmp->size +
+                                             (unsigned long)tmp->addr, align);
+                        continue;
+                }
+                if ((size + addr) < addr)
+                        goto out;
+                if (size + addr <= (unsigned long)tmp->addr)
+                        	goto found;
+                addr = ALIGN(tmp->size + (unsigned long)tmp->addr, align);
+                if (addr > end - size)
+                        goto out;
+        }
+                                                                                                                             
+found:
+        area->next = *p;
+        *p = area;
+                                                                                                                             
+        area->flags = flags;
+        area->addr = (void *)addr;
+        area->size = size;
+        area->pages = NULL;
+        area->nr_pages = 0;
+        area->phys_addr = 0;
+        write_unlock(&vmlist_lock);
+        return area;
+                                                                                                                             
+out:
+        write_unlock(&vmlist_lock);
+        kfree(area);
+        if (printk_ratelimit())
+                printk(KERN_WARNING "allocation failed: out of vmalloc space - use vmalloc=<size> to increase size.\n");
+        return NULL;
+}
+
+struct vm_struct *get_vm_area_ti(unsigned long size, unsigned long flags)
+{
+        return __get_vm_area_ti(size, flags, VMALLOC_START, VMALLOC_END);
+}
+
+void *__vmalloc_thread_info(unsigned long size, int gfp_mask, pgprot_t prot)
+{
+        struct vm_struct *area;
+        struct page **pages;
+        unsigned int nr_pages, array_size;
+                                                                                                                             
+        size = PAGE_ALIGN(size);
+        if (!size || (size >> PAGE_SHIFT) > num_physpages)
+                return NULL;
+                                                                                                                             
+        area = get_vm_area_ti(size, VM_ALLOC);
+        if (!area)
+                return NULL;
+                                                                                                                             
+        nr_pages = size >> PAGE_SHIFT;
+        array_size = (nr_pages * sizeof(struct page *));
+                                                                                                                             
+        area->nr_pages = nr_pages;
+        area->pages = pages = kmalloc(array_size, (gfp_mask & ~__GFP_HIGHMEM));
+        if (!area->pages) {
+                remove_vm_area(area->addr);
+                kfree(area);
+                return NULL;
+        }
+        memset(area->pages, 0, array_size);
+                                                                                                                             
+//        for (i = 0; i < area->nr_pages; i++) {
+
+          area->pages[0] = alloc_page(gfp_mask);
+                if (unlikely(!area->pages[0])) {
+                        /* Successfully allocated i pages, free them in __vunmap() */
+                        area->nr_pages = 4; //try to free all pages
+                        goto fail;
+                }
+
+#if 0
+          area->pages[1] = alloc_page(gfp_mask);
+                if (unlikely(!area->pages[1])) {
+                        /* Successfully allocated i pages, free them in __vunmap() */
+                        area->nr_pages = 1;
+                        goto fail;
+                }
+
+          area->pages[2] = alloc_page(gfp_mask);
+                if (unlikely(!area->pages[2])) {
+                        /* Successfully allocated i pages, free them in __vunmap() */
+                        area->nr_pages = 2;
+                        goto fail;
+                }
+#endif
+          area->pages[THREAD_SIZE/PAGE_SIZE-1] = alloc_page(gfp_mask);
+                if (unlikely(!area->pages[THREAD_SIZE/PAGE_SIZE-1])) {
+                        /* Successfully allocated i pages, free them in __vunmap() */
+                        area->nr_pages = 4;
+                        goto fail;
+                }
+//        }
+
+        if (map_vm_area_ti(area, prot, &pages))
+                goto fail;
+
+        area->nr_pages = 4;
+        return area->addr;
+                                                                                                                             
+fail:
+        area->nr_pages = 4;
+        vfree_thread_info(area->addr);
+        return NULL;
+}
+
+void *vmalloc_thread_info(unsigned long size)
+{
+       return __vmalloc_thread_info(size, GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL);
+}
+
+EXPORT_SYMBOL(vmalloc_thread_info);
+
+struct vm_struct *find_vm_area(void *addr)
+{
+        struct vm_struct **p, *tmp;
+                                                                                                                             
+        write_lock(&vmlist_lock);
+        for (p = &vmlist ; (tmp = *p) != NULL ;p = &tmp->next) {
+                 if ((unsigned)(tmp->addr) == (unsigned)addr)
+                         goto found;
+        }
+        write_unlock(&vmlist_lock);
+        return NULL;
+                                                                                                                             
+found:
+	printk("vm_area found 0x%x\n", (unsigned int)(tmp->addr));
+//        unmap_vm_area(tmp);
+//        *p = tmp->next;
+        write_unlock(&vmlist_lock);
+        return tmp;
+}
+
+EXPORT_SYMBOL(find_vm_area);
+
+void page_table_trace(unsigned start_address)
+{
+        unsigned int curr_address, i;
+        pgd_t *pgd;
+        pmd_t *pmd;
+        pte_t *ptep;
+                                                                                                                             
+                                                                                                                             
+        for(i=0; i<4; i++) {
+                printk("-------------------------------\n");
+                curr_address = start_address+i*PAGE_SIZE;
+                pgd = pgd_offset_k(curr_address);
+                if (pgd_none(*pgd) || pgd_bad(*pgd))
+                        printk("bad pgd address 0x%x\n", curr_address);
+#if 0
+                else
+                        printk("pgd address 0x%x pgd 0x%x\n", curr_address, (unsigned int)(pgd_val(*pgd)));
+#endif
+                                                                                                                             
+                pmd = pmd_offset(pgd, curr_address);
+                if (pmd_none(*pmd) || pmd_bad(*pmd))
+                        printk("bad pmd address 0x%x\n", curr_address);
+#if 0
+                else
+                        printk("pmd address 0x%x pmd 0x%x\n", curr_address, (unsigned int)(pmd_val(*pmd)));
+#endif
+                ptep = pte_offset_kernel(pmd, curr_address);
+                if (!ptep)
+                        printk("bad pte address 0x%x\n", curr_address);
+                else
+                        printk("pte address 0x%x pte 0x%x\n", curr_address, (unsigned int)(pte_val(*ptep)));
+        }
+                                                                                                                             
+                printk("-------------------------------\n");
+}
+
+static int map_expand_stack_area_pte(pte_t *pte, unsigned long address,
+                               unsigned long size, pgprot_t prot,
+                               struct page ***pages)
+{
+        unsigned long end;
+                                                                                                                             
+        printk(KERN_INFO "Pre map_expand_stack_area_pte address 0x%x, size %d\n", (unsigned)address, (unsigned)size);
+        address &= ~PMD_MASK;
+        end = address + size;
+        if (end > PMD_SIZE)
+                end = PMD_SIZE;
+                                                                                                                             
+        do {
+                struct page *page = **pages;
+                                                                                                                             
+                WARN_ON(!pte_none(*pte));
+                if (!page)
+                        return -ENOMEM;
+                                                                                                                             
+                set_pte(pte, mk_pte(page, prot));
+                                                                                                                             
+                printk(KERN_INFO "map_expand_stack_area_pte pte 0x%x address 0x%x\n", (unsigned int)(pte_val(*pte)), (unsigned)address);
+                address += PAGE_SIZE;
+                pte++;
+                (*pages)++;
+        } while (address < end);
+        return 0;
+}
+
+static int map_expand_stack_area_pmd(pmd_t *pmd, unsigned long address,
+                               unsigned long size, pgprot_t prot,
+                               struct page ***pages)
+{
+        unsigned long base, end;
+                                                                                                                             
+        base = address & PGDIR_MASK;
+        address &= ~PGDIR_MASK;
+        end = address + size;
+                                                                                                                             
+        if (end > PGDIR_SIZE)
+                end = PGDIR_SIZE;
+
+        printk("map_expand_stack_area_pmd: address 0x%x, end 0x%x\n", (unsigned int)address, (unsigned int)end);
+                                                                                                                             
+        do {
+                pte_t * pte = pte_alloc_kernel(&init_mm, pmd, base + address);
+                if (!pte)
+                        return -ENOMEM;
+                if (map_expand_stack_area_pte(pte, address, end - address, prot, pages))
+                        return -ENOMEM;
+                address = (address + PMD_SIZE) & PMD_MASK;
+                pmd++;
+        } while (address < end);
+                                                                                                                             
+        return 0;
+}
+
+int static map_expand_stack_vm_area(unsigned long address, pgprot_t prot, struct page ***pages)
+{
+//        unsigned long address = (unsigned long) area->addr;
+        unsigned long end = address + PAGE_SIZE; // 1 page mappings
+//        unsigned long end = address + PAGE_SIZE*2; // 2 pages mappings
+        //unsigned long end = address + (area->size-PAGE_SIZE);
+        pgd_t *dir;
+        int err = 0;
+                                                                                                                             
+        dir = pgd_offset_k(address);
+        spin_lock(&init_mm.page_table_lock);
+        do {
+                pmd_t *pmd = pmd_alloc(&init_mm, dir, address);
+                if (!pmd) {
+                        err = -ENOMEM;
+                        break;
+                }
+                if (map_expand_stack_area_pmd(pmd, address, end - address, prot, pages)) {
+                        err = -ENOMEM;
+                        break;
+                }
+                                                                                                                             
+                address = (address + PGDIR_SIZE) & PGDIR_MASK;
+                dir++;
+        } while (address && (address < end));
+                                                                                                                             
+        spin_unlock(&init_mm.page_table_lock);
+        flush_cache_vmap(address, end);
+        //flush_cache_vmap((unsigned long) area->addr, end);
+        return err;
+}
+
+void expand_stack_size(struct vm_struct *area)
+{
+        struct page **pages;
+        unsigned int expand_address = (unsigned int)((area->addr)+PAGE_SIZE*2);
+//      unsigned int expand_address = (unsigned int)((area->addr)+PAGE_SIZE);
+        unsigned gfp_mask = GFP_KERNEL | __GFP_HIGHMEM;
+        pgprot_t prot = PAGE_KERNEL;
+                                                                                                                             
+#if 1
+	if(area){
+		if(area->pages[0])
+        		printk("area[0] exist  ");
+		if(area->pages[1])
+        		printk("area[1] exist  ");
+		if(area->pages[2])
+        		printk("area[2] exist  ");
+		if(area->pages[3])
+        		printk("area[3] exist\n");
+	}
+#endif
+
+          area->pages[2] = alloc_thread_info_page(gfp_mask);
+                if (unlikely(!area->pages[2])) {
+                        /* Successfully allocated i pages, free them in __vunmap() */
+                        area->nr_pages = 2;
+                        printk("Alloc page failed\n");
+                        goto fail;
+                }
+                                                                                                                             
+#if 0
+          area->pages[1] = alloc_thread_info_page(gfp_mask);
+                if (unlikely(!area->pages[1])) {
+                        /* Successfully allocated i pages, free them in __vunmap() */
+                        area->nr_pages = 1;
+                        printk("Alloc page failed\n");
+                        goto fail;
+                }
+                                                                                                                             
+#endif
+                                                                                                                             
+        area->nr_pages = 4;
+        pages = &(area->pages[2]);
+                                                                                                                             
+        if (map_expand_stack_vm_area(expand_address, prot, &pages))
+                goto fail;
+
+	page_table_trace((unsigned int)(area->addr));
+	return;
+fail:
+
+        printk("failed to expand_stack_size\n");
+//      vfree(area->addr);
+}
+
+EXPORT_SYMBOL(expand_stack_size);
+

--=-erZsIACfkZj6Avx+hECH--

