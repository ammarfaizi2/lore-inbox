Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280951AbRKTHY3>; Tue, 20 Nov 2001 02:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280950AbRKTHYU>; Tue, 20 Nov 2001 02:24:20 -0500
Received: from t2.redhat.com ([199.183.24.243]:48879 "EHLO dot.cygnus.com")
	by vger.kernel.org with ESMTP id <S280949AbRKTHYJ>;
	Tue, 20 Nov 2001 02:24:09 -0500
Date: Mon, 19 Nov 2001 23:23:55 -0800
From: Richard Henderson <rth@redhat.com>
To: Jay.Estabrook@compaq.com
Cc: linux-kernel@vger.kernel.org
Subject: [alpha] cleanup opDEC workaround
Message-ID: <20011119232355.C16091@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would someone with an affected system (Multia or Jensen) try this out?

It removes two global variables, and avoids an extra test once we're
done with startup code.


r~



--- 2.4.15-7/arch/alpha/kernel/traps.c.~2~	Mon Nov 19 23:05:50 2001
+++ 2.4.15-7/arch/alpha/kernel/traps.c	Mon Nov 19 23:07:32 2001
@@ -24,31 +24,32 @@
 
 #include "proto.h"
 
-/* data/code implementing a work-around for some SRMs which
-   mishandle opDEC faults
-*/
-static int opDEC_testing = 0;
-static int opDEC_fix = 0;
-static unsigned long opDEC_test_pc = 0;
+/* Work-around for some SRMs which mishandle opDEC faults.  */
+static int opDEC_fix;
 
 static void
 opDEC_check(void)
 {
-	unsigned long test_pc;
+	unsigned long data;
 
-	lock_kernel();
-	opDEC_testing = 1;
+	/* We temporarily set opDEC_fix so that we skip forward to either
+	   the cmpteq (for a broken srm) or the addt (for a working srm).
+	   Because of this skip, at the end of the sequence $f0 will be 0
+	   for a working srm, and 2.0 for a broken srm.  */
 
-	__asm__ __volatile__(
-		"       br      %0,1f\n"
-		"1:     addq    %0,8,%0\n"
-		"       stq     %0,%1\n"
-		"       cvttq/svm $f31,$f31\n"
-		: "=&r"(test_pc), "=m"(opDEC_test_pc)
-		: );
+	opDEC_fix = 8;
 
-	opDEC_testing = 0;
-	unlock_kernel();
+	__asm__ __volatile__(
+		"fmov $f31, $f0\n\t"
+		"cvttq/svm $f31, $f31\n\t"
+		"cmpteq $f31, $f31, $f0\n\t"
+		"addt $f31, $f31, $f31\n\t"
+		"stt $f0, %0"
+		: "=m"(data));
+
+	opDEC_fix = data ? 4 : 0;
+	if (data)
+		printk("opDEC fixup enabled.\n");
 }
 
 void
@@ -231,24 +232,22 @@ do_entIF(unsigned long type, unsigned lo
 	 unsigned long a2, unsigned long a3, unsigned long a4,
 	 unsigned long a5, struct pt_regs regs)
 {
-	if (!opDEC_testing || type != 4) {
-		die_if_kernel((type == 1 ? "Kernel Bug" : "Instruction fault"),
-		      &regs, type, 0);
-	}
-
 	switch (type) {
-	      case 0: /* breakpoint */
+	case 0: /* breakpoint */
+		die_if_kernel("Breakpoint fault", &regs, type, 0);
 		if (ptrace_cancel_bpt(current)) {
 			regs.pc -= 4;	/* make pc point to former bpt */
 		}
 		send_sig(SIGTRAP, current, 1);
 		return;
 
-	      case 1: /* bugcheck */
+	case 1: /* bugcheck */
+		die_if_kernel("Kernel Bug", &regs, type, 0);
 		send_sig(SIGTRAP, current, 1);
 		return;
 
-	      case 2: /* gentrap */
+	case 2: /* gentrap */
+		die_if_kernel("Divide by zero fault", &regs, type, 0);
 		/*
 		 * The exception code should be passed on to the signal
 		 * handler as the second argument.  Linux doesn't do that
@@ -285,27 +284,14 @@ do_entIF(unsigned long type, unsigned lo
 		}
 		break;
 
-	      case 4: /* opDEC */
+	case 4: /* opDEC */
 		if (implver() == IMPLVER_EV4) {
-			/* The some versions of SRM do not handle
-			   the opDEC properly - they return the PC of the
-			   opDEC fault, not the instruction after as the
-			   Alpha architecture requires.  Here we fix it up.
-			   We do this by intentionally causing an opDEC
-			   fault during the boot sequence and testing if
-			   we get the correct PC.  If not, we set a flag
-			   to correct it every time through.
-			*/
-			if (opDEC_testing) {
-				if (regs.pc == opDEC_test_pc) {
-					opDEC_fix = 4;
-					regs.pc += 4;
-					printk("opDEC fixup enabled.\n");
-				}
-				return;
-			}
+			/* Some versions of SRM do not handle opDEC properly.
+			   They return the PC of the opDEC fault, not the
+			   instruction after the fault as the architecture
+			   requires.  Here we fix it up.  */
 			regs.pc += opDEC_fix; 
-			
+
 			/* EV4 does not implement anything except normal
 			   rounding.  Everything else will come here as
 			   an illegal instruction.  Emulate them.  */
@@ -314,7 +300,7 @@ do_entIF(unsigned long type, unsigned lo
 		}
 		break;
 
-	      case 3: /* FEN fault */
+	case 3: /* FEN fault */
 		/* Irritating users can call PAL_clrfen to disable the
 		   FPU for the process.  The kernel will then trap in
 		   do_switch_stack and undo_switch_stack when we try
@@ -328,10 +314,12 @@ do_entIF(unsigned long type, unsigned lo
 		__reload_thread(&current->thread);
 		return;
 
-	      case 5: /* illoc */
-	      default: /* unexpected instruction-fault type */
-		      ;
+	case 5: /* illoc */
+	default: /* unexpected instruction-fault type */
+		break;
 	}
+
+	die_if_kernel("Instruction fault", &regs, type, 0);
 	send_sig(SIGILL, current, 1);
 }
 
@@ -1014,9 +1002,7 @@ trap_init(void)
 	wrent(entDbg, 6);
 
 	/* Hack for Multia (UDB) and JENSEN: some of their SRMs have
-	 * a bug in the handling of the opDEC fault.  Fix it up if so.
-	 */
-	if (implver() == IMPLVER_EV4) {
+	   a bug in the handling of the opDEC fault.  Fix it up if so.  */
+	if (implver() == IMPLVER_EV4)
 		opDEC_check();
-	}
 }
