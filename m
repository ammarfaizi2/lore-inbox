Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282271AbRK2Bmg>; Wed, 28 Nov 2001 20:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282272AbRK2Bm2>; Wed, 28 Nov 2001 20:42:28 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:26081 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S282271AbRK2BmN>; Wed, 28 Nov 2001 20:42:13 -0500
To: linux-kernel@vger.kernel.org
Subject: task_structs cache colouring (performance measurement)
X-Mailer: Mew version 1.94.2 on XEmacs 21.1 (Cuyahoga Valley)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011129104154Z.yamamura@flab.fujitsu.co.jp>
Date: Thu, 29 Nov 2001 10:41:54 +0900
From: Shuji YAMAMURA <yamamura@flab.fujitsu.co.jp>
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  I have been trying to see cache memory behavior of linux scheduler,
especially with focusing on scalability on SMP machines.

  As you know, the current scheduler consumes long time to search a
single runqueue due to very bad cache behavior, while locking a
runqueue lock. Attached patch does colouring for a task structure and
can reduce cache misses/lock contention on searching a runqueue.
I think that the kernel should have a coloured task structures to
reduce scheduling overhead.

  Measurement using the web-bench on 8-way P3Xeon systems, a request
processing performance achieved maximum of 15% improvement compared to
the original kernel, very effective on SMP systems under heavy
workload.

[Patch summary]
  The attached patch for colouring mainly alternates "current macro".
The current macro returns the coloured address of a task struct and
tricks the caller. The current macro copies a few upper bits to the
lower bits and returns it.

[Benchmarking Result]
  - webbench as a workload
  - 2.4.4 distribution of the Linux kernel.
  - an 8-way 550MHz Pentium-III Xeon with 1MB L2-Cache as a server
  - we measured also the performance of "Manfred's colouring patch"
    posted to lkml, and "Multi Queue scheduler".

    note. We modified Manfred's patch NOT to use %cr2.
            in include/asm-i386/current.h.
            "#define current get_current()"
               => "#define current hard_get_current()"

  <request processing performance improvement,
                   compared to the original kernel>

      # of cpus  4colouring  Manfred   MultiQ
     ----------------------------------------
      1          6%          8%        1%
      2          11%         15%       14%
      4          15%         20%       22%
     *8          13%         13%       13%

   *) The server is in idle because we don't have enough client
      power, so it shows less performance improvement than 4 cpus.

  <cache statistics and lock contention statistics
            during execution of list_for_each (4SMP)>

                          original  4colouring
    -------------------------------------------
    L2 read mess/L2 read  96.9%     17.9%
    lock hold time
      MEANS(MAX) [us]     40(136)   20(129)
    lock contention       19.0%     9.5%

  We are welcome any comments and other ideas for implementation,
and if someone who has more than 8-way systems is interested in this
result and tests this patch, please let us know its result.

  And, we plan to show you the evaluation results in detail via web
sites.

Thank you,

------------------------------------------------------------
diff -u -r linux-2.4.4/arch/i386/kernel/entry.S linux-2.4.4-4c-1mb/arch/i386/kernel/entry.S
--- linux-2.4.4/arch/i386/kernel/entry.S	Thu Nov  9 10:09:50 2000
+++ linux-2.4.4-4c-1mb/arch/i386/kernel/entry.S	Mon Nov 26 17:01:56 2001
@@ -131,7 +131,12 @@
 
 #define GET_CURRENT(reg) \
 	movl $-8192, reg; \
-	andl %esp, reg
+	andl %esp, reg; \
+	pushl reg; \
+	shrl $13, reg; \
+	andl $0x00000060, reg; \
+	orl  0(%esp), reg; \
+	addl $4, %esp
 
 ENTRY(lcall7)
 	pushfl			# We get a different stack layout with call gates,
@@ -145,7 +150,7 @@
 	movl %ecx,CS(%esp)	#
 	movl %esp,%ebx
 	pushl %ebx
-	andl $-8192,%ebx	# GET_CURRENT
+	GET_CURRENT(%ebx)
 	movl exec_domain(%ebx),%edx	# Get the execution domain
 	movl 4(%edx),%edx	# Get the lcall7 handler for the domain
 	pushl $0x7
@@ -166,7 +171,7 @@
 	movl %ecx,CS(%esp)	#
 	movl %esp,%ebx
 	pushl %ebx
-	andl $-8192,%ebx	# GET_CURRENT
+	GET_CURRENT(%ebx)
 	movl exec_domain(%ebx),%edx	# Get the execution domain
 	movl 4(%edx),%edx	# Get the lcall7 handler for the domain
 	pushl $0x27
diff -u -r linux-2.4.4/arch/i386/kernel/head.S linux-2.4.4-4c-1mb/arch/i386/kernel/head.S
--- linux-2.4.4/arch/i386/kernel/head.S	Sat Apr 21 08:23:30 2001
+++ linux-2.4.4-4c-1mb/arch/i386/kernel/head.S	Thu Nov 29 10:19:25 2001
@@ -322,7 +322,7 @@
 	ret
 
 ENTRY(stack_start)
-	.long SYMBOL_NAME(init_task_union)+8192
+	.long SYMBOL_NAME(init_task_union)+8192-32*4  /* 32 * n colouring */
 	.long __KERNEL_DS
 
 /* This is the default interrupt "handler" :-) */
diff -u -r linux-2.4.4/arch/i386/kernel/process.c linux-2.4.4-4c-1mb/arch/i386/kernel/process.c
--- linux-2.4.4/arch/i386/kernel/process.c	Sat Feb 10 04:29:44 2001
+++ linux-2.4.4-4c-1mb/arch/i386/kernel/process.c	Mon Nov 26 17:02:33 2001
@@ -532,7 +532,7 @@
 {
 	struct pt_regs * childregs;
 
-	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p)) - 1;
+	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p - (((unsigned long) p >> 13) & 0x00000060))) - 1;
 	struct_cpy(childregs, regs);
 	childregs->eax = 0;
 	childregs->esp = esp;
diff -u -r linux-2.4.4/arch/i386/lib/getuser.S linux-2.4.4-4c-1mb/arch/i386/lib/getuser.S
--- linux-2.4.4/arch/i386/lib/getuser.S	Tue Jan 13 06:42:52 1998
+++ linux-2.4.4-4c-1mb/arch/i386/lib/getuser.S	Mon Nov 26 17:09:17 2001
@@ -29,6 +29,11 @@
 __get_user_1:
 	movl %esp,%edx
 	andl $0xffffe000,%edx
+	pushl %edx
+	shrl $13, %edx
+	andl $0x00000060, %edx
+	orl  0(%esp), %edx
+	addl $4, %esp
 	cmpl addr_limit(%edx),%eax
 	jae bad_get_user
 1:	movzbl (%eax),%edx
@@ -42,6 +47,11 @@
 	movl %esp,%edx
 	jc bad_get_user
 	andl $0xffffe000,%edx
+	pushl %edx
+	shrl $13, %edx
+	andl $0x00000060, %edx
+	orl  0(%esp), %edx
+	addl $4, %esp
 	cmpl addr_limit(%edx),%eax
 	jae bad_get_user
 2:	movzwl -1(%eax),%edx
@@ -55,6 +65,11 @@
 	movl %esp,%edx
 	jc bad_get_user
 	andl $0xffffe000,%edx
+	pushl %edx
+	shrl $13, %edx
+	andl $0x00000060, %edx
+	orl  0(%esp), %edx
+	addl $4, %esp
 	cmpl addr_limit(%edx),%eax
 	jae bad_get_user
 3:	movl -3(%eax),%edx
diff -u -r linux-2.4.4/arch/i386/lib/putuser.S linux-2.4.4-4c-1mb/arch/i386/lib/putuser.S
--- linux-2.4.4/arch/i386/lib/putuser.S	Tue Jan 13 06:37:26 1998
+++ linux-2.4.4-4c-1mb/arch/i386/lib/putuser.S	Mon Nov 26 17:09:31 2001
@@ -28,6 +28,11 @@
 __put_user_1:
 	movl %esp,%ecx
 	andl $0xffffe000,%ecx
+	pushl %ecx
+	shrl $13, %ecx
+	andl $0x00000060, %ecx
+	orl  0(%esp), %ecx
+	addl $4, %esp
 	cmpl addr_limit(%ecx),%eax
 	jae bad_put_user
 1:	movb %dl,(%eax)
@@ -41,6 +46,11 @@
 	movl %esp,%ecx
 	jc bad_put_user
 	andl $0xffffe000,%ecx
+	pushl %ecx
+	shrl $13, %ecx
+	andl $0x00000060, %ecx
+	orl  0(%esp), %ecx
+	addl $4, %esp
 	cmpl addr_limit(%ecx),%eax
 	jae bad_put_user
 2:	movw %dx,-1(%eax)
@@ -54,6 +64,11 @@
 	movl %esp,%ecx
 	jc bad_put_user
 	andl $0xffffe000,%ecx
+	pushl %ecx
+	shrl $13, %ecx
+	andl $0x00000060, %ecx
+	orl  0(%esp), %ecx
+	addl $4, %esp
 	cmpl addr_limit(%ecx),%eax
 	jae bad_put_user
 3:	movl %edx,-3(%eax)
diff -u -r linux-2.4.4/arch/i386/vmlinux.lds linux-2.4.4-4c-1mb/arch/i386/vmlinux.lds
--- linux-2.4.4/arch/i386/vmlinux.lds	Thu Jan  4 13:45:26 2001
+++ linux-2.4.4-4c-1mb/arch/i386/vmlinux.lds	Wed Nov 28 09:42:22 2001
@@ -36,7 +36,9 @@
 
   _edata = .;			/* End of data section */
 
-  . = ALIGN(8192);		/* init_task */
+  . = ALIGN(8192);	/* init_task */
+  . |= (.>>13) & 0x00000060;
+
   .data.init_task : { *(.data.init_task) }
 
   . = ALIGN(4096);		/* Init code and data */
diff -u -r linux-2.4.4/include/asm-i386/current.h linux-2.4.4-4c-1mb/include/asm-i386/current.h
--- linux-2.4.4/include/asm-i386/current.h	Sat Aug 15 08:35:22 1998
+++ linux-2.4.4-4c-1mb/include/asm-i386/current.h	Tue Nov 27 10:22:42 2001
@@ -7,6 +7,31 @@
 {
 	struct task_struct *current;
 	__asm__("andl %%esp,%0; ":"=r" (current) : "0" (~8191UL));
+	/*
+	 * task_struct coloring.
+	 *  - L2-cache(1MB, 4way, 32bytes/line).
+	 *  - 4 coloring(shifted 0, 32, 64, 96 bytes by copying upper two bits)
+	 *
+	 *                           cache
+	 *                             line index  offset in cache block
+	 *               cache tag     (13 bits)  (5 bits)
+	 *            +-------------+-------------+-----+
+	 * original   |           10|      #######|#####|
+	 *            +-------------+-------------+-----+
+	 *               # is same in any task struct.
+	 *
+	 *            +-------------+-------------+-----+
+	 * colored    |           10|      #####10|#####|
+	 *            +-------------+-------------+-----+
+	 *                        |    copy    /|\
+	 *                        +-------------+
+	 *
+	 * - the number of bits to copy depends on the number of coloring.
+	 *     ex. 8 coloring/3 bits, 16 coloring/4 bits.
+	 * - the number of bits to shift depends on the L2-cache configuration.
+	 *     ex. 512KB(4way)/12 bits, 512KB(8way)/11 bits.
+	 */
+	(unsigned long)current |= ((unsigned long)current >> 13) & 0x00000060;
 	return current;
  }
  
diff -u -r linux-2.4.4/include/asm-i386/hw_irq.h linux-2.4.4-4c-1mb/include/asm-i386/hw_irq.h
--- linux-2.4.4/include/asm-i386/hw_irq.h	Sat Apr 28 07:48:20 2001
+++ linux-2.4.4-4c-1mb/include/asm-i386/hw_irq.h	Mon Nov 26 16:55:31 2001
@@ -112,7 +112,12 @@
 
 #define GET_CURRENT \
 	"movl %esp, %ebx\n\t" \
-	"andl $-8192, %ebx\n\t"
+	"andl $-8192, %ebx\n\t" \
+	"pushl %ebx\n\t" \
+	"shrl $13, %ebx\n\t" \
+	"andl $0x00000060, %ebx\n\t" \
+	"orl  0(%esp), %ebx\n\t" \
+	"addl $4, %esp\n\t"
 
 /*
  *	SMP has a few special interrupts for IPI messages
diff -u -r linux-2.4.4/include/asm-i386/processor.h linux-2.4.4-4c-1mb/include/asm-i386/processor.h
--- linux-2.4.4/include/asm-i386/processor.h	Sat Apr 28 07:48:21 2001
+++ linux-2.4.4-4c-1mb/include/asm-i386/processor.h	Mon Nov 26 17:00:19 2001
@@ -444,8 +444,16 @@
 #define KSTK_ESP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)))[1022])
 
 #define THREAD_SIZE (2*PAGE_SIZE)
-#define alloc_task_struct() ((struct task_struct *) __get_free_pages(GFP_KERNEL,1))
-#define free_task_struct(p) free_pages((unsigned long) (p), 1)
+#define GFP_KERNEL 0x07
+extern unsigned long FASTCALL(__get_free_pages(int gfp_mask, unsigned long order));
+extern inline struct task_struct * alloc_task_struct(void)
+{
+	struct task_struct *p;
+	p = (struct task_struct *) __get_free_pages(GFP_KERNEL,1);
+	(unsigned long)p |= ((unsigned long)p >> 13) & 0x00000060;
+	return p;
+}
+#define free_task_struct(p) free_pages(((unsigned long) (p) & 0xffffe000UL), 1)
 #define get_task_struct(tsk)      atomic_inc(&virt_to_page(tsk)->count)
 
 #define init_task	(init_task_union.task)
------------------------------------------------------------

-----
Computer Systems Laboratories, Fujitsu Labs.
Shuji YAMAMURA (yamamura@flab.fujitsu.co.jp)
