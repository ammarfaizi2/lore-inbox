Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281664AbRKUW2d>; Wed, 21 Nov 2001 17:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281683AbRKUW2Y>; Wed, 21 Nov 2001 17:28:24 -0500
Received: from t2.redhat.com ([199.183.24.243]:27890 "EHLO dot.cygnus.com")
	by vger.kernel.org with ESMTP id <S281664AbRKUW2I>;
	Wed, 21 Nov 2001 17:28:08 -0500
Date: Wed, 21 Nov 2001 14:27:53 -0800
From: Richard Henderson <rth@redhat.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Jay.Estabrook@compaq.com, linux-kernel@vger.kernel.org
Subject: Re: [alpha] cleanup opDEC workaround
Message-ID: <20011121142753.A876@redhat.com>
In-Reply-To: <20011119232355.C16091@redhat.com> <20011120133150.A9033@jurassic.park.msu.ru> <20011120090818.A16366@redhat.com> <20011120205105.A15395@jurassic.park.msu.ru> <20011120104748.B16422@redhat.com> <20011121151555.A20128@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011121151555.A20128@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Wed, Nov 21, 2001 at 03:15:55PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2001 at 03:15:55PM +0300, Ivan Kokshaysky wrote:
> > I suppose the other alternative to get the testing code out of
> > the normal entIF is to create a custom entIF that is installed
> > only during opDEC testing.  Seems too much work...
> 
> Agreed. Alternatively, it's possible to hack dummy_emul(), which
> doesn't affect the normal case.

Actually, the custom entIF isn't that much work.  What about this?


r~



--- traps.c.orig	Wed Nov 21 14:13:31 2001
+++ traps.c	Wed Nov 21 14:25:22 2001
@@ -24,31 +24,35 @@
 
 #include "proto.h"
 
-/* data/code implementing a work-around for some SRMs which
-   mishandle opDEC faults
-*/
-static int opDEC_testing = 0;
-static int opDEC_fix = 0;
-static unsigned long opDEC_test_pc = 0;
+/* Work-around for some SRMs which mishandle opDEC faults.  */
+static int opDEC_fix;
 
-static void
+extern void opDEC_check_entIF(void);
+asm(".section .text.init,\"ax\"			\n\
+	.ent opDEC_check_entIF			\n\
+opDEC_check_entIF:				\n\
+	ldq $16,8($sp)				\n\
+	call_pal 63	/* PAL_rti */		\n\
+	.end opDEC_check_entIF			\n\
+	.previous");
+
+static void __init
 opDEC_check(void)
 {
-	unsigned long test_pc;
+	long diff;
 
-	lock_kernel();
-	opDEC_testing = 1;
+	wrent(opDEC_check_entIF, 3);
 
 	__asm__ __volatile__(
-		"       br      %0,1f\n"
-		"1:     addq    %0,8,%0\n"
-		"       stq     %0,%1\n"
-		"       cvttq/svm $f31,$f31\n"
-		: "=&r"(test_pc), "=m"(opDEC_test_pc)
-		: );
-
-	opDEC_testing = 0;
-	unlock_kernel();
+		"br %0,1f\n"
+		"1:\n\t"
+		"cvttq/svm $f31, $f31\n\t"
+		"subq $16, %0, %0"
+		: "=r"(diff) : : "$16");
+
+	opDEC_fix = 4 - diff;
+	if (opDEC_fix)
+		printk("opDEC fixup enabled.\n");
 }
 
 void
@@ -231,24 +235,22 @@
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
@@ -285,27 +287,14 @@
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
@@ -314,7 +303,7 @@
 		}
 		break;
 
-	      case 3: /* FEN fault */
+	case 3: /* FEN fault */
 		/* Irritating users can call PAL_clrfen to disable the
 		   FPU for the process.  The kernel will then trap in
 		   do_switch_stack and undo_switch_stack when we try
@@ -328,10 +317,12 @@
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
 
@@ -999,24 +990,22 @@
 	return -ENOSYS;
 }
 
-void
+void __init
 trap_init(void)
 {
 	/* Tell PAL-code what global pointer we want in the kernel.  */
 	register unsigned long gptr __asm__("$29");
 	wrkgp(gptr);
 
+	/* Hack for Multia (UDB) and JENSEN: some of their SRMs have
+	   a bug in the handling of the opDEC fault.  Fix it up if so.  */
+	if (implver() == IMPLVER_EV4)
+		opDEC_check();
+
 	wrent(entArith, 1);
 	wrent(entMM, 2);
 	wrent(entIF, 3);
 	wrent(entUna, 4);
 	wrent(entSys, 5);
 	wrent(entDbg, 6);
-
-	/* Hack for Multia (UDB) and JENSEN: some of their SRMs have
-	 * a bug in the handling of the opDEC fault.  Fix it up if so.
-	 */
-	if (implver() == IMPLVER_EV4) {
-		opDEC_check();
-	}
 }
