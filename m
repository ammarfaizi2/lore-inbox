Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129867AbQLVSah>; Fri, 22 Dec 2000 13:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130541AbQLVSa1>; Fri, 22 Dec 2000 13:30:27 -0500
Received: from Cantor.suse.de ([194.112.123.193]:12549 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129867AbQLVSaR>;
	Fri, 22 Dec 2000 13:30:17 -0500
Date: Fri, 22 Dec 2000 18:59:48 +0100
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Some assembly microoptimizations for 2.4
Message-ID: <20001222185948.A26703@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch does some "micro optimizations" for 2.4, that are
partly not so micro. It tries to avoid segment register reloads for 
interrupts taken from kernel mode (e.g. the idle task), because they
require expensive locked cycles to read the GDT. It also changes
switch_to() not to misalign the call/ret stack during context switch, 
which helps somewhat on the Athlon.

They have been running well for some time on my workstation. 

-Andi

--- arch/i386/kernel/entry.S	2000/11/10 04:49:56	1.92
+++ arch/i386/kernel/entry.S	2000/12/22 18:16:38
@@ -106,10 +106,14 @@
 	popl %edi;	\
 	popl %ebp;	\
 	popl %eax;	\
+	cmpl $__KERNEL_DS,(%esp); \
+	je 4f ; \
 1:	popl %ds;	\
 2:	popl %es;	\
 	addl $4,%esp;	\
 3:	iret;		\
+4:	addl $12,%esp;	\
+	iret; \
 .section .fixup,"ax";	\
 4:	movl $0,(%esp);	\
 	jmp 1b;		\
@@ -271,13 +275,13 @@
 	jne   handle_softirq
 
 ENTRY(ret_from_intr)
-	GET_CURRENT(%ebx)
-	movl EFLAGS(%esp),%eax		# mix EFLAGS and CS
-	movb CS(%esp),%al
-	testl $(VM_MASK | 3),%eax	# return to VM86 mode or non-supervisor?
+	GET_CURRENT(%ebx)	
+	movl EFLAGS(%esp),%eax      # mix EFLAGS and CS
+	movb		CS(%esp),%al
+	testl $(VM_MASK | 3),%eax   # return to VM86 mode or non-supervisor?
 	jne ret_with_reschedule
 	jmp restore_all
-
+	
 	ALIGN
 handle_softirq:
 	call SYMBOL_NAME(do_softirq)
@@ -313,9 +317,11 @@
 	pushl %esi			# push the error code
 	pushl %edx			# push the pt_regs pointer
 	movl $(__KERNEL_DS),%edx
+	cmpl %edx,%ecx
+	jz 1f	# should only happen for *_user or kernel bugs
 	movl %edx,%ds
 	movl %edx,%es
-	GET_CURRENT(%ebx)
+1:	GET_CURRENT(%ebx)
 	call *%edi
 	addl $8,%esp
 	jmp ret_from_exception
--- include/asm-i386/system.h	2000/09/26 05:25:56	1.44
+++ include/asm-i386/system.h	2000/12/22 18:17:26
@@ -20,7 +20,9 @@
 		     "movl %3,%%esp\n\t"	/* restore ESP */	\
 		     "movl $1f,%1\n\t"		/* save EIP */		\
 		     "pushl %4\n\t"		/* restore EIP */	\
-		     "jmp __switch_to\n"				\
+		     "call __switch_to\n\t"				\
+		     "popl  %%esi\n\t"	\
+		     "jmp   *%%esi\n\t"	\
 		     "1:\t"						\
 		     "popl %%ebp\n\t"					\
 		     "popl %%edi\n\t"					\
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
