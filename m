Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130159AbQKRKuf>; Sat, 18 Nov 2000 05:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131475AbQKRKu1>; Sat, 18 Nov 2000 05:50:27 -0500
Received: from Cantor.suse.de ([194.112.123.193]:15880 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130159AbQKRKuL>;
	Sat, 18 Nov 2000 05:50:11 -0500
Date: Sat, 18 Nov 2000 11:20:09 +0100
From: Andi Kleen <ak@suse.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Speed up interrupt entry
Message-ID: <20001118112009.A23763@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

It turns out that segment register reloading is rather expensive on modern
CPUs -- it needs several locked cycles to access the segment table which
are especially expensive on SMP. 

This patch against 2.4.0test11-pre5 tries to avoid the segment register
reload for interrupts if possible, when the interrupt was entered
from kernel mode.

Only subtle point is the changed retint_with_reschedule test, the comment
should explain my reasoning. Testing against the kernel data segment
is equivalent to testing the EFLAGS/cs (unless some kernel user messes
with segments, which I consider not likely) 

It also removes a bogus optimization that was added during 2.3 -- using
pushl $ret_from_intr ; jmp do_IRQ for interrupts. This one usually is slower on
Athlon (and probably P3 too) because it misaligns the call/return stack. 
I changed it back to call do_IRQ ; jmp ret_from_intr.

Ideas for this patch came from Jeff Merkey and from starring at CPU simulator
logs for too long. 

It is not a bug fix, but I think it is a nice simple optimization and I hope 
you consider it for 2.4. 

-Andi


Index: include/asm-i386/hw_irq.h
===================================================================
RCS file: /cvs/linux/include/asm-i386/hw_irq.h,v
retrieving revision 1.11
diff -u -u -r1.11 hw_irq.h
--- include/asm-i386/hw_irq.h	2000/05/16 16:08:15	1.11
+++ include/asm-i386/hw_irq.h	2000/11/18 10:33:48
@@ -92,6 +92,10 @@
 #define __STR(x) #x
 #define STR(x) __STR(x)
 
+/* 
+ * A segment register reload is rather expensive. Try to avoid it 
+ * if possible. 
+ */ 
 #define SAVE_ALL \
 	"cld\n\t" \
 	"pushl %es\n\t" \
@@ -103,9 +107,12 @@
 	"pushl %edx\n\t" \
 	"pushl %ecx\n\t" \
 	"pushl %ebx\n\t" \
-	"movl $" STR(__KERNEL_DS) ",%edx\n\t" \
-	"movl %edx,%ds\n\t" \
-	"movl %edx,%es\n\t"
+	"movl $" STR(__KERNEL_DS),%eax\n\t" \
+	"cmpl %eax,7*4(%esp)\n\t"  \
+	"je 1f\n\t"  \
+	"movl %eax,%ds\n\t" \
+	"movl %eax,%es\n\t" \
+	"1:\n\t"
 
 #define IRQ_NAME2(nr) nr##_interrupt(void)
 #define IRQ_NAME(nr) IRQ_NAME2(IRQ##nr)
@@ -155,9 +162,9 @@
 	"\n" __ALIGN_STR"\n" \
 	"common_interrupt:\n\t" \
 	SAVE_ALL \
-	"pushl $ret_from_intr\n\t" \
 	SYMBOL_NAME_STR(call_do_IRQ)":\n\t" \
-	"jmp "SYMBOL_NAME_STR(do_IRQ));
+	"call " SYMBOL_NAME_STR(do_IRQ) "\n\t" \
+	"jmp ret_from_intr\n");
 
 /* 
  * subtle. orig_eax is used by the signal code to distinct between
Index: arch/i386/kernel/entry.S
===================================================================
RCS file: /cvs/linux/arch/i386/kernel/entry.S,v
retrieving revision 1.92
diff -u -u -r1.92 entry.S
--- arch/i386/kernel/entry.S	2000/11/10 04:49:56	1.92
+++ arch/i386/kernel/entry.S	2000/11/18 10:33:48
@@ -97,6 +97,17 @@
 	movl $(__KERNEL_DS),%edx; \
 	movl %edx,%ds; \
 	movl %edx,%es;
+			
+#define RESTORE_ALL_KERNEL	\
+	popl %ebx;	\
+	popl %ecx;	\
+	popl %edx;	\
+	popl %esi;	\
+	popl %edi;	\
+	popl %ebp;	\
+	popl %eax;	\
+	addl $12,%esp; \
+	iret
 
 #define RESTORE_ALL	\
 	popl %ebx;	\
@@ -271,12 +282,13 @@
 	jne   handle_softirq
 
 ENTRY(ret_from_intr)
-	GET_CURRENT(%ebx)
-	movl EFLAGS(%esp),%eax		# mix EFLAGS and CS
-	movb CS(%esp),%al
-	testl $(VM_MASK | 3),%eax	# return to VM86 mode or non-supervisor?
-	jne ret_with_reschedule
-	jmp restore_all
+	GET_CURRENT(%ebx)	
+	/* Following test implies that the beginning of SAVE_ALL or the end of RESTORE_ALL 
+	   could be rescheduled in kernel. This is ok because they're interruptible. It also
+	   decreases the missing reschedule race on syscall exit by a few instructions. -AK */ 	
+	cmpl  $__KERNEL_DS,DS(%esp)
+	jne   ret_with_reschedule	
+	RESTORE_ALL_KERNEL	
 
 	ALIGN
 handle_softirq:
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
