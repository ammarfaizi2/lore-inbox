Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWH3X0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWH3X0L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 19:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWH3X0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 19:26:10 -0400
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:919 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751136AbWH3X0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 19:26:08 -0400
Date: Wed, 30 Aug 2006 19:26:06 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>
Cc: ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: [PATCH 14/16] LTTng : Linux Trace Toolkit Next Generation 0.5.95, kernel 2.6.17
Message-ID: <20060830232606.GO17079@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_Krystal-24151-1156980366-0001-2"
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 19:25:25 up 7 days, 20:34,  9 users,  load average: 0.97, 0.74, 0.48
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-24151-1156980366-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

14- LTTng architecture dependant instrumentation --- s390 (incomplete)
patch-2.6.17-lttng-0.5.95-instrumentation-s390.diff

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

--=_Krystal-24151-1156980366-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-2.6.17-lttng-0.5.95-instrumentation-s390.diff"

--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -7,6 +7,8 @@
  *               Hartmut Penner (hp@de.ibm.com),
  *               Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com),
  *		 Heiko Carstens <heiko.carstens@de.ibm.com>
+ *  Portions added by T. Halloran: (C) Copyright 2002 IBM Poughkeepsie,
+ *	IBM Corporation
  */
 
 #include <linux/sys.h>
@@ -229,6 +231,13 @@ sysc_do_restart:
                                   # ATTENTION: check sys_execve_glue before
                                   # changing anything here !!
 
+#ifdef CONFIG_LTT /* tjh - ltt port */
+        /* add call to trace_real_syscall_exit */
+        la      %r2,SP_PTREGS(%r15)   # load pt_regs as first parameter
+        l       %r1,BASED(.Ltracesysext)
+        basr    %r14,%r1
+        lm      %r0,%r6,SP_R0(%r15) /* restore call clobbered regs */
+#endif
 sysc_return:
 	tm	SP_PSW+1(%r15),0x01	# returning to user ?
 	bno	BASED(sysc_leave)
diff --git a/arch/s390/kernel/sys_s390.c b/arch/s390/kernel/sys_s390.c
index e351780..0e2c701 100644
--- a/arch/s390/kernel/sys_s390.c
+++ b/arch/s390/kernel/sys_s390.c
@@ -149,6 +149,8 @@ asmlinkage long sys_ipc(uint call, int f
         struct ipc_kludge tmp;
 	int ret;
 
+        ltt_ev_ipc(LTT_EV_IPC_CALL, call, first);
+
         switch (call) {
         case SEMOP:
 		return sys_semtimedop(first, (struct sembuf __user *)ptr,
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index a46793b..d0a9e75 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -5,6 +5,7 @@
  *    Copyright (C) 1999,2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
  *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
  *               Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com),
+ *  Portions added by T. Halloran: (C) Copyright 2002 IBM Poughkeepsie, IBM Corporation
  *
  *  Derived from "arch/i386/kernel/traps.c"
  *    Copyright (C) 1991, 1992 Linus Torvalds
@@ -30,6 +31,7 @@ #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/kallsyms.h>
 #include <linux/reboot.h>
+#include <linux/ltt-events.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -311,6 +313,9 @@ #endif
 static void inline do_trap(long interruption_code, int signr, char *str,
                            struct pt_regs *regs, siginfo_t *info)
 {
+         trapid_t ltt_interruption_code;
+         char * ic_ptr = (char *) &ltt_interruption_code;
+
 	/*
 	 * We got all needed information from the lowcore and can
 	 * now safely switch on interrupts.
@@ -318,6 +323,10 @@ static void inline do_trap(long interrup
         if (regs->psw.mask & PSW_MASK_PSTATE)
 		local_irq_enable();
 
+	memset(&ltt_interruption_code,0,sizeof(ltt_interruption_code));
+	memcpy(ic_ptr+4,&interruption_code,sizeof(interruption_code));
+	ltt_ev_trap_entry(ltt_interruption_code, (regs->psw.addr & PSW_ADDR_INSN));
+
         if (regs->psw.mask & PSW_MASK_PSTATE) {
                 struct task_struct *tsk = current;
 
@@ -332,6 +341,7 @@ static void inline do_trap(long interrup
                 else
                         die(str, regs, interruption_code);
         }
+	ltt_ev_trap_exit();
 }
 
 static inline void *get_check_address(struct pt_regs *regs)
@@ -428,6 +438,8 @@ asmlinkage void illegal_op(struct pt_reg
 	siginfo_t info;
         __u8 opcode[6];
 	__u16 *location;
+        trapid_t ltt_interruption_code;
+        char * ic_ptr = (char *) &ltt_interruption_code;
 	int signal = 0;
 
 	location = (__u16 *) get_check_address(regs);
@@ -490,6 +502,7 @@ #endif
 		do_trap(interruption_code, signal,
 			"illegal operation", regs, &info);
 	}
+	ltt_ev_trap_exit();
 }
 
 
@@ -499,6 +512,8 @@ specification_exception(struct pt_regs *
 {
         __u8 opcode[6];
 	__u16 *location = NULL;
+        trapid_t ltt_interruption_code;
+        char * ic_ptr = (char *) &ltt_interruption_code;
 	int signal = 0;
 
 	location = (__u16 *) get_check_address(regs);
@@ -554,6 +569,7 @@ specification_exception(struct pt_regs *
 		do_trap(interruption_code, signal, 
 			"specification exception", regs, &info);
 	}
+	ltt_ev_trap_exit();
 }
 #else
 DO_ERROR_INFO(SIGILL, "specification exception", specification_exception,
@@ -563,6 +579,8 @@ #endif
 asmlinkage void data_exception(struct pt_regs * regs, long interruption_code)
 {
 	__u16 *location;
+        trapid_t ltt_interruption_code;
+        char * ic_ptr = (char *) &ltt_interruption_code;
 	int signal = 0;
 
 	location = (__u16 *) get_check_address(regs);
@@ -574,6 +592,10 @@ asmlinkage void data_exception(struct pt
 	if (regs->psw.mask & PSW_MASK_PSTATE)
 		local_irq_enable();
 
+	memset(&ltt_interruption_code,0,sizeof(ltt_interruption_code));
+	memcpy(ic_ptr+4,&interruption_code,sizeof(interruption_code));
+	ltt_ev_trap_entry(ltt_interruption_code, (regs->psw.addr & PSW_ADDR_INSN));
+
 	if (MACHINE_HAS_IEEE)
 		__asm__ volatile ("stfpc %0\n\t" 
 				  : "=m" (current->thread.fp_regs.fpc));
@@ -649,6 +671,7 @@ #endif 
 		do_trap(interruption_code, signal, 
 			"data exception", regs, &info);
 	}
+	ltt_ev_trap_exit();
 }
 
 asmlinkage void space_switch_exception(struct pt_regs * regs, long int_code)
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 81ade40..f0a50c0 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -5,6 +5,7 @@
  *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
  *    Author(s): Hartmut Penner (hp@de.ibm.com)
  *               Ulrich Weigand (uweigand@de.ibm.com)
+ *  Portions added by T. Halloran: (C) Copyright 2002 IBM Poughkeepsie, IBM Corporation
  *
  *  Derived from "arch/i386/mm/fault.c"
  *    Copyright (C) 1995  Linus Torvalds
@@ -170,6 +171,8 @@ do_exception(struct pt_regs *regs, unsig
 	int user_address;
 	const struct exception_table_entry *fixup;
 	int si_code = SEGV_MAPERR;
+	trapid_t ltt_interruption_code;
+	char * ic_ptr = (char *) &ltt_interruption_code;
 
         tsk = current;
         mm = tsk->mm;
@@ -217,6 +220,9 @@ do_exception(struct pt_regs *regs, unsig
 	 */
 	local_irq_enable();
 
+        memset(&ltt_interruption_code,0,sizeof(ltt_interruption_code));
+        memcpy(ic_ptr+4,&error_code,sizeof(error_code));
+        ltt_ev_trap_entry(ltt_interruption_code,(regs->psw.addr & PSW_ADDR_INSN));
         down_read(&mm->mmap_sem);
 
         vma = find_vma(mm, address);
@@ -284,6 +290,7 @@ bad_area:
                 tsk->thread.prot_addr = address;
                 tsk->thread.trap_no = error_code;
 		do_sigsegv(regs, error_code, si_code, address);
+                ltt_ev_trap_exit();
                 return;
 	}
 
@@ -339,6 +346,8 @@ do_sigbus:
 	/* Kernel mode? Handle exceptions or die */
 	if (!(regs->psw.mask & PSW_MASK_PSTATE))
 		goto no_context;
+
+	ltt_ev_trap_exit();
 }
 
 void do_protection_exception(struct pt_regs *regs, unsigned long error_code)
diff --git a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
index b56e796..c5b56f1 100644

--=_Krystal-24151-1156980366-0001-2--
