Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269449AbUICAML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269449AbUICAML (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 20:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269443AbUICAJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 20:09:23 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:31732 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S269409AbUIBX61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 19:58:27 -0400
Date: Thu, 2 Sep 2004 20:02:51 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>, William Lee Irwin III <wli@holomorphy.com>,
       Matt Mackall <mpm@selenic.com>
Subject: [PATCH][7/8] Arch agnostic completely out of line locks / i386
Message-ID: <Pine.LNX.4.58.0409021239290.4481@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 arch/i386/kernel/time.c              |   13 +++++++++++++
 arch/i386/kernel/vmlinux.lds.S       |    1 +
 arch/i386/oprofile/op_model_athlon.c |    2 +-
 arch/i386/oprofile/op_model_p4.c     |    2 +-
 arch/i386/oprofile/op_model_ppro.c   |    2 +-
 include/asm-i386/ptrace.h            |    4 ++++
 include/asm-i386/rwlock.h            |   32 ++++++++++----------------------
 include/asm-i386/spinlock.h          |   10 ++++------
 8 files changed, 35 insertions(+), 31 deletions(-)

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.9-rc1-mm1-stage/include/asm-i386/ptrace.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/include/asm-i386/ptrace.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 ptrace.h
--- linux-2.6.9-rc1-mm1-stage/include/asm-i386/ptrace.h	26 Aug 2004 13:13:13 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1-stage/include/asm-i386/ptrace.h	2 Sep 2004 23:24:30 -0000
@@ -57,7 +57,11 @@ struct pt_regs {
 #ifdef __KERNEL__
 #define user_mode(regs) ((VM_MASK & (regs)->eflags) || (3 & (regs)->xcs))
 #define instruction_pointer(regs) ((regs)->eip)
+#if defined(CONFIG_SMP) && defined(CONFIG_FRAME_POINTER)
+extern unsigned long profile_pc(struct pt_regs *regs);
+#else
 #define profile_pc(regs) instruction_pointer(regs)
 #endif
+#endif

 #endif
Index: linux-2.6.9-rc1-mm1-stage/include/asm-i386/rwlock.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/include/asm-i386/rwlock.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 rwlock.h
--- linux-2.6.9-rc1-mm1-stage/include/asm-i386/rwlock.h	26 Aug 2004 13:13:13 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1-stage/include/asm-i386/rwlock.h	2 Sep 2004 13:08:15 -0000
@@ -22,25 +22,19 @@

 #define __build_read_lock_ptr(rw, helper)   \
 	asm volatile(LOCK "subl $1,(%0)\n\t" \
-		     "js 2f\n" \
+		     "jns 1f\n" \
+		     "call " helper "\n\t" \
 		     "1:\n" \
-		     LOCK_SECTION_START("") \
-		     "2:\tcall " helper "\n\t" \
-		     "jmp 1b\n" \
-		     LOCK_SECTION_END \
 		     ::"a" (rw) : "memory")

 #define __build_read_lock_const(rw, helper)   \
 	asm volatile(LOCK "subl $1,%0\n\t" \
-		     "js 2f\n" \
-		     "1:\n" \
-		     LOCK_SECTION_START("") \
-		     "2:\tpushl %%eax\n\t" \
+		     "jns 1f\n" \
+		     "pushl %%eax\n\t" \
 		     "leal %0,%%eax\n\t" \
 		     "call " helper "\n\t" \
 		     "popl %%eax\n\t" \
-		     "jmp 1b\n" \
-		     LOCK_SECTION_END \
+		     "1:\n" \
 		     :"=m" (*(volatile int *)rw) : : "memory")

 #define __build_read_lock(rw, helper)	do { \
@@ -52,25 +46,19 @@

 #define __build_write_lock_ptr(rw, helper) \
 	asm volatile(LOCK "subl $" RW_LOCK_BIAS_STR ",(%0)\n\t" \
-		     "jnz 2f\n" \
+		     "jz 1f\n" \
+		     "call " helper "\n\t" \
 		     "1:\n" \
-		     LOCK_SECTION_START("") \
-		     "2:\tcall " helper "\n\t" \
-		     "jmp 1b\n" \
-		     LOCK_SECTION_END \
 		     ::"a" (rw) : "memory")

 #define __build_write_lock_const(rw, helper) \
 	asm volatile(LOCK "subl $" RW_LOCK_BIAS_STR ",%0\n\t" \
-		     "jnz 2f\n" \
-		     "1:\n" \
-		     LOCK_SECTION_START("") \
-		     "2:\tpushl %%eax\n\t" \
+		     "jz 1f\n" \
+		     "pushl %%eax\n\t" \
 		     "leal %0,%%eax\n\t" \
 		     "call " helper "\n\t" \
 		     "popl %%eax\n\t" \
-		     "jmp 1b\n" \
-		     LOCK_SECTION_END \
+		     "1:\n" \
 		     :"=m" (*(volatile int *)rw) : : "memory")

 #define __build_write_lock(rw, helper)	do { \
Index: linux-2.6.9-rc1-mm1-stage/include/asm-i386/spinlock.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/include/asm-i386/spinlock.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 spinlock.h
--- linux-2.6.9-rc1-mm1-stage/include/asm-i386/spinlock.h	26 Aug 2004 13:13:13 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1-stage/include/asm-i386/spinlock.h	2 Sep 2004 13:08:15 -0000
@@ -46,20 +46,18 @@ typedef struct {
 #define spin_lock_string \
 	"\n1:\t" \
 	"lock ; decb %0\n\t" \
-	"js 2f\n" \
-	LOCK_SECTION_START("") \
+	"jns 3f\n" \
 	"2:\t" \
 	"rep;nop\n\t" \
 	"cmpb $0,%0\n\t" \
 	"jle 2b\n\t" \
 	"jmp 1b\n" \
-	LOCK_SECTION_END
+	"3:\n\t"

 #define spin_lock_string_flags \
 	"\n1:\t" \
 	"lock ; decb %0\n\t" \
-	"js 2f\n\t" \
-	LOCK_SECTION_START("") \
+	"jns 4f\n\t" \
 	"2:\t" \
 	"testl $0x200, %1\n\t" \
 	"jz 3f\n\t" \
@@ -70,7 +68,7 @@ typedef struct {
 	"jle 3b\n\t" \
 	"cli\n\t" \
 	"jmp 1b\n" \
-	LOCK_SECTION_END
+	"4:\n\t"

 /*
  * This works. Despite all the confusion.
Index: linux-2.6.9-rc1-mm1-stage/arch/i386/kernel/time.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/arch/i386/kernel/time.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 time.c
--- linux-2.6.9-rc1-mm1-stage/arch/i386/kernel/time.c	26 Aug 2004 13:12:51 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1-stage/arch/i386/kernel/time.c	2 Sep 2004 23:24:58 -0000
@@ -200,6 +200,19 @@ unsigned long long monotonic_clock(void)
 }
 EXPORT_SYMBOL(monotonic_clock);

+#if defined(CONFIG_SMP) && defined(CONFIG_FRAME_POINTER)
+unsigned long profile_pc(struct pt_regs *regs)
+{
+	unsigned long pc = instruction_pointer(regs);
+
+	if (pc >= (unsigned long)&__lock_text_start &&
+	    pc <= (unsigned long)&__lock_text_end)
+		return *(unsigned long *)(regs->ebp + 4);
+
+	return pc;
+}
+EXPORT_SYMBOL(profile_pc);
+#endif

 /*
  * timer_interrupt() needs to keep up the real-time clock,
Index: linux-2.6.9-rc1-mm1-stage/arch/i386/kernel/vmlinux.lds.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/arch/i386/kernel/vmlinux.lds.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vmlinux.lds.S
--- linux-2.6.9-rc1-mm1-stage/arch/i386/kernel/vmlinux.lds.S	26 Aug 2004 13:12:51 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1-stage/arch/i386/kernel/vmlinux.lds.S	2 Sep 2004 13:08:15 -0000
@@ -18,6 +18,7 @@ SECTIONS
   .text : {
 	*(.text)
 	SCHED_TEXT
+	LOCK_TEXT
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x9090
Index: linux-2.6.9-rc1-mm1-stage/arch/i386/oprofile/op_model_athlon.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/arch/i386/oprofile/op_model_athlon.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 op_model_athlon.c
--- linux-2.6.9-rc1-mm1-stage/arch/i386/oprofile/op_model_athlon.c	26 Aug 2004 13:12:52 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1-stage/arch/i386/oprofile/op_model_athlon.c	2 Sep 2004 14:05:58 -0000
@@ -96,7 +96,7 @@ static int athlon_check_ctrs(unsigned in
 {
 	unsigned int low, high;
 	int i;
-	unsigned long eip = instruction_pointer(regs);
+	unsigned long eip = profile_pc(regs);
 	int is_kernel = !user_mode(regs);

 	for (i = 0 ; i < NUM_COUNTERS; ++i) {
Index: linux-2.6.9-rc1-mm1-stage/arch/i386/oprofile/op_model_p4.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/arch/i386/oprofile/op_model_p4.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 op_model_p4.c
--- linux-2.6.9-rc1-mm1-stage/arch/i386/oprofile/op_model_p4.c	26 Aug 2004 13:12:52 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1-stage/arch/i386/oprofile/op_model_p4.c	2 Sep 2004 14:05:58 -0000
@@ -595,7 +595,7 @@ static int p4_check_ctrs(unsigned int co
 {
 	unsigned long ctr, low, high, stag, real;
 	int i;
-	unsigned long eip = instruction_pointer(regs);
+	unsigned long eip = profile_pc(regs);
 	int is_kernel = !user_mode(regs);

 	stag = get_stagger();
Index: linux-2.6.9-rc1-mm1-stage/arch/i386/oprofile/op_model_ppro.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/arch/i386/oprofile/op_model_ppro.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 op_model_ppro.c
--- linux-2.6.9-rc1-mm1-stage/arch/i386/oprofile/op_model_ppro.c	26 Aug 2004 13:12:52 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm1-stage/arch/i386/oprofile/op_model_ppro.c	2 Sep 2004 14:05:58 -0000
@@ -91,7 +91,7 @@ static int ppro_check_ctrs(unsigned int
 {
 	unsigned int low, high;
 	int i;
-	unsigned long eip = instruction_pointer(regs);
+	unsigned long eip = profile_pc(regs);
 	int is_kernel = !user_mode(regs);

 	for (i = 0 ; i < NUM_COUNTERS; ++i) {
