Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbVC2TTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVC2TTk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 14:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVC2TSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 14:18:53 -0500
Received: from sccrmhc14.comcast.net ([204.127.202.59]:56986 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261319AbVC2TRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 14:17:39 -0500
Date: Tue, 29 Mar 2005 11:17:35 -0800
From: "H. J. Lu" <hjl@lucon.org>
To: binutils@sources.redhat.com
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: PATCH: i386/x86_64 segment register access update
Message-ID: <20050329191735.GA20140@lucon.org>
References: <20050326020506.GA8068@lucon.org> <20050327222406.GA6435@lucon.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <20050327222406.GA6435@lucon.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The new i386/x86_64 assemblers no longer accept instructions for moving
between a segment register and a 32bit memory location, i.e.,

        movl (%eax),%ds
        movl %ds,(%eax)

To generate instructions for moving between a segment register and a
16bit memory location without the 16bit operand size prefix, 0x66,

        mov (%eax),%ds
        mov %ds,(%eax)

should be used. It will work with both new and old assemblers. The
assembler starting from 2.16.90.0.1 will also support

        movw (%eax),%ds
        movw %ds,(%eax)

without the 0x66 prefix. I am enclosing patches for 2.4 and 2.6 kernels
here. The resulting kernel binaries should be unchanged as before, with
old and new assemblers, if gcc never generates memory access for

               unsigned gsindex;
               asm volatile("movl %%gs,%0" : "=g" (gsindex));

If gcc does generate memory access for the code above, the upper bits
in gsindex are undefined and the new assembler doesn't allow it.


H.J.

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4-seg-4.patch"

--- linux/arch/i386/kernel/apm.c.seg	2005-03-27 13:10:45.000000000 -0800
+++ linux/arch/i386/kernel/apm.c	2005-03-28 10:30:24.000000000 -0800
@@ -327,7 +327,7 @@ extern int (*console_blank_hook)(int);
  * Save a segment register away
  */
 #define savesegment(seg, where) \
-		__asm__ __volatile__("movl %%" #seg ",%0" : "=m" (where))
+		__asm__ __volatile__("mov %%" #seg ",%0" : "=m" (where))
 
 /*
  * Maximum number of events stored
@@ -553,7 +553,7 @@ static inline void apm_restore_cpus(unsi
 
 #ifdef APM_ZERO_SEGS
 #	define APM_DECL_SEGS \
-		unsigned int saved_fs; unsigned int saved_gs;
+		unsigned short saved_fs; unsigned short saved_gs;
 #	define APM_DO_SAVE_SEGS \
 		savesegment(fs, saved_fs); savesegment(gs, saved_gs)
 #	define APM_DO_ZERO_SEGS \
--- linux/arch/i386/kernel/process.c.seg	2005-03-27 13:10:45.000000000 -0800
+++ linux/arch/i386/kernel/process.c	2005-03-28 10:30:24.000000000 -0800
@@ -544,7 +544,7 @@ void release_thread(struct task_struct *
  * Save a segment.
  */
 #define savesegment(seg,value) \
-	asm volatile("movl %%" #seg ",%0":"=m" (*(int *)&(value)))
+	asm volatile("mov %%" #seg ",%0":"=m" (value))
 
 int copy_thread(int nr, unsigned long clone_flags, unsigned long esp,
 	unsigned long unused,
@@ -661,8 +661,8 @@ void fastcall __switch_to(struct task_st
 	 * Save away %fs and %gs. No need to save %es and %ds, as
 	 * those are always kernel segments while inside the kernel.
 	 */
-	asm volatile("movl %%fs,%0":"=m" (*(int *)&prev->fs));
-	asm volatile("movl %%gs,%0":"=m" (*(int *)&prev->gs));
+	asm volatile("mov %%fs,%0":"=m" (prev->fs));
+	asm volatile("mov %%gs,%0":"=m" (prev->gs));
 
 	/*
 	 * Restore %fs and %gs.
--- linux/arch/x86_64/kernel/process.c.seg	2005-03-27 13:10:51.000000000 -0800
+++ linux/arch/x86_64/kernel/process.c	2005-03-28 11:16:57.000000000 -0800
@@ -527,10 +527,10 @@ int copy_thread(int nr, unsigned long cl
 	p->thread.fs = me->thread.fs;
 	p->thread.gs = me->thread.gs;
 
-	asm("movl %%gs,%0" : "=m" (p->thread.gsindex));
-	asm("movl %%fs,%0" : "=m" (p->thread.fsindex));
-	asm("movl %%es,%0" : "=m" (p->thread.es));
-	asm("movl %%ds,%0" : "=m" (p->thread.ds));
+	asm("mov %%gs,%0" : "=m" (p->thread.gsindex));
+	asm("mov %%fs,%0" : "=m" (p->thread.fsindex));
+	asm("mov %%es,%0" : "=m" (p->thread.es));
+	asm("mov %%ds,%0" : "=m" (p->thread.ds));
 
 	unlazy_fpu(current);	
 	p->thread.i387 = current->thread.i387;
@@ -575,11 +575,11 @@ struct task_struct *__switch_to(struct t
 	/* 
 	 * Switch DS and ES.	 
 	 */
-	asm volatile("movl %%es,%0" : "=m" (prev->es)); 
+	asm volatile("mov %%es,%0" : "=m" (prev->es)); 
 	if (unlikely(next->es | prev->es))
 		loadsegment(es, next->es); 
 	
-	asm volatile ("movl %%ds,%0" : "=m" (prev->ds)); 
+	asm volatile ("mov %%ds,%0" : "=m" (prev->ds)); 
 	if (unlikely(next->ds | prev->ds))
 		loadsegment(ds, next->ds);
 
@@ -588,7 +588,7 @@ struct task_struct *__switch_to(struct t
 	 */
 	{ 
 		unsigned fsindex;
-		asm volatile("movl %%fs,%0" : "=g" (fsindex)); 
+		asm volatile("movl %%fs,%0" : "=r" (fsindex)); 
 		/* segment register != 0 always requires a reload. 
 		   also reload when it has changed. 
 		   when prev process used 64bit base always reload
@@ -609,7 +609,7 @@ struct task_struct *__switch_to(struct t
 	}
 	{
 		unsigned gsindex;
-		asm volatile("movl %%gs,%0" : "=g" (gsindex)); 
+		asm volatile("movl %%gs,%0" : "=r" (gsindex)); 
 		if (unlikely((gsindex | next->gsindex) || prev->gs)) {
 			load_gs_index(next->gsindex);
 			if (gsindex)
--- linux/include/asm-i386/system.h.seg	2005-03-27 15:33:12.000000000 -0800
+++ linux/include/asm-i386/system.h	2005-03-28 10:30:24.000000000 -0800
@@ -84,7 +84,7 @@ static inline unsigned long _get_base(ch
 #define loadsegment(seg,value)			\
 	asm volatile("\n"			\
 		"1:\t"				\
-		"movl %0,%%" #seg "\n"		\
+		"mov %0,%%" #seg "\n"		\
 		"2:\n"				\
 		".section .fixup,\"ax\"\n"	\
 		"3:\t"				\
@@ -96,7 +96,7 @@ static inline unsigned long _get_base(ch
 		".align 4\n\t"			\
 		".long 1b,3b\n"			\
 		".previous"			\
-		: :"m" (*(unsigned int *)&(value)))
+		: :"m" (value))
 
 /*
  * Clear and set 'TS' bit respectively

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6-seg-5.patch"

--- linux/arch/i386/kernel/process.c.seg	2005-03-27 13:07:14.000000000 -0800
+++ linux/arch/i386/kernel/process.c	2005-03-28 10:28:47.000000000 -0800
@@ -597,8 +597,8 @@ struct task_struct fastcall * __switch_t
 	 * Save away %fs and %gs. No need to save %es and %ds, as
 	 * those are always kernel segments while inside the kernel.
 	 */
-	asm volatile("movl %%fs,%0":"=m" (*(int *)&prev->fs));
-	asm volatile("movl %%gs,%0":"=m" (*(int *)&prev->gs));
+	asm volatile("mov %%fs,%0":"=m" (prev->fs));
+	asm volatile("mov %%gs,%0":"=m" (prev->gs));
 
 	/*
 	 * Restore %fs and %gs if needed.
--- linux/arch/i386/kernel/vm86.c.seg	2005-03-27 13:07:14.000000000 -0800
+++ linux/arch/i386/kernel/vm86.c	2005-03-28 10:28:47.000000000 -0800
@@ -294,8 +294,8 @@ static void do_sys_vm86(struct kernel_vm
  */
 	info->regs32->eax = 0;
 	tsk->thread.saved_esp0 = tsk->thread.esp0;
-	asm volatile("movl %%fs,%0":"=m" (tsk->thread.saved_fs));
-	asm volatile("movl %%gs,%0":"=m" (tsk->thread.saved_gs));
+	asm volatile("mov %%fs,%0":"=m" (tsk->thread.saved_fs));
+	asm volatile("mov %%gs,%0":"=m" (tsk->thread.saved_gs));
 
 	tss = &per_cpu(init_tss, get_cpu());
 	tsk->thread.esp0 = (unsigned long) &info->VM86_TSS_ESP0;
--- linux/arch/x86_64/kernel/process.c.seg	2005-03-27 13:07:49.000000000 -0800
+++ linux/arch/x86_64/kernel/process.c	2005-03-28 11:11:04.206766410 -0800
@@ -391,10 +391,10 @@ int copy_thread(int nr, unsigned long cl
 	p->thread.fs = me->thread.fs;
 	p->thread.gs = me->thread.gs;
 
-	asm("movl %%gs,%0" : "=m" (p->thread.gsindex));
-	asm("movl %%fs,%0" : "=m" (p->thread.fsindex));
-	asm("movl %%es,%0" : "=m" (p->thread.es));
-	asm("movl %%ds,%0" : "=m" (p->thread.ds));
+	asm("mov %%gs,%0" : "=m" (p->thread.gsindex));
+	asm("mov %%fs,%0" : "=m" (p->thread.fsindex));
+	asm("mov %%es,%0" : "=m" (p->thread.es));
+	asm("mov %%ds,%0" : "=m" (p->thread.ds));
 
 	if (unlikely(me->thread.io_bitmap_ptr != NULL)) { 
 		p->thread.io_bitmap_ptr = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
@@ -457,11 +457,11 @@ struct task_struct *__switch_to(struct t
 	 * Switch DS and ES.
 	 * This won't pick up thread selector changes, but I guess that is ok.
 	 */
-	asm volatile("movl %%es,%0" : "=m" (prev->es)); 
+	asm volatile("mov %%es,%0" : "=m" (prev->es)); 
 	if (unlikely(next->es | prev->es))
 		loadsegment(es, next->es); 
 	
-	asm volatile ("movl %%ds,%0" : "=m" (prev->ds)); 
+	asm volatile ("mov %%ds,%0" : "=m" (prev->ds)); 
 	if (unlikely(next->ds | prev->ds))
 		loadsegment(ds, next->ds);
 
@@ -472,7 +472,7 @@ struct task_struct *__switch_to(struct t
 	 */
 	{ 
 		unsigned fsindex;
-		asm volatile("movl %%fs,%0" : "=g" (fsindex)); 
+		asm volatile("movl %%fs,%0" : "=r" (fsindex)); 
 		/* segment register != 0 always requires a reload. 
 		   also reload when it has changed. 
 		   when prev process used 64bit base always reload
@@ -493,7 +493,7 @@ struct task_struct *__switch_to(struct t
 	}
 	{ 
 		unsigned gsindex;
-		asm volatile("movl %%gs,%0" : "=g" (gsindex)); 
+		asm volatile("movl %%gs,%0" : "=r" (gsindex)); 
 		if (unlikely(gsindex | next->gsindex | prev->gs)) {
 			load_gs_index(next->gsindex);
 			if (gsindex)
--- linux/include/asm-i386/system.h.seg	2005-03-27 13:09:12.000000000 -0800
+++ linux/include/asm-i386/system.h	2005-03-28 10:28:47.000000000 -0800
@@ -81,7 +81,7 @@ static inline unsigned long _get_base(ch
 #define loadsegment(seg,value)			\
 	asm volatile("\n"			\
 		"1:\t"				\
-		"movl %0,%%" #seg "\n"		\
+		"mov %0,%%" #seg "\n"		\
 		"2:\n"				\
 		".section .fixup,\"ax\"\n"	\
 		"3:\t"				\
@@ -93,13 +93,13 @@ static inline unsigned long _get_base(ch
 		".align 4\n\t"			\
 		".long 1b,3b\n"			\
 		".previous"			\
-		: :"m" (*(unsigned int *)&(value)))
+		: :"m" (value))
 
 /*
  * Save a segment register away
  */
 #define savesegment(seg, value) \
-	asm volatile("movl %%" #seg ",%0":"=m" (*(int *)&(value)))
+	asm volatile("mov %%" #seg ",%0":"=m" (value))
 
 /*
  * Clear and set 'TS' bit respectively

--pf9I7BMVVzbSWLtt--
