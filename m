Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274544AbRIYH1E>; Tue, 25 Sep 2001 03:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274545AbRIYH05>; Tue, 25 Sep 2001 03:26:57 -0400
Received: from zok.SGI.COM ([204.94.215.101]:26006 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S274544AbRIYH0r>;
	Tue, 25 Sep 2001 03:26:47 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.9-ac15 tainted kernel flag
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 25 Sep 2001 17:27:01 +1000
Message-ID: <506.1001402821@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.4.9-ac15 adds /proc/sys/kernel/tainted and prints
the tainted status on every IP, EIP, PSW, NIP, IPR, EPC, PC, TPC, PSR ...
dump that I could find.

The patch hits every architecture, it has been tested on i386.

Index: 9.42/kernel/sysctl.c
--- 9.42/kernel/sysctl.c Tue, 25 Sep 2001 10:38:51 +1000 kaos (linux-2.4/j/38_sysctl.c 1.1.3.4.3.1.1.7 644)
+++ 9.42(w)/kernel/sysctl.c Tue, 25 Sep 2001 16:18:07 +1000 kaos (linux-2.4/j/38_sysctl.c 1.1.3.4.3.1.1.7 644)
@@ -172,6 +172,8 @@ static ctl_table kern_table[] = {
 	 0644, NULL, &proc_dointvec},
 	{KERN_CORE_USES_PID, "core_uses_pid", &core_uses_pid, sizeof(int),
 	 0644, NULL, &proc_dointvec},
+	{KERN_TAINTED, "tainted", &tainted, sizeof(int),
+	 0644, NULL, &proc_dointvec},
 	{KERN_CAP_BSET, "cap-bound", &cap_bset, sizeof(kernel_cap_t),
 	 0600, NULL, &proc_dointvec_bset},
 #ifdef CONFIG_BLK_DEV_INITRD
Index: 9.42/kernel/panic.c
--- 9.42/kernel/panic.c Wed, 18 Apr 2001 11:14:47 +1000 kaos (linux-2.4/j/51_panic.c 1.1.2.1 644)
+++ 9.42(w)/kernel/panic.c Tue, 25 Sep 2001 16:56:14 +1000 kaos (linux-2.4/j/51_panic.c 1.1.2.1 644)
@@ -99,3 +99,24 @@ NORET_TYPE void panic(const char * fmt, 
 		CHECK_EMERGENCY_SYNC
 	}
 }
+
+/**
+ *	print_tainted - return a string to represent the kernel taint state.
+ *
+ *	The string is overwritten by the next call to print_taint().
+ */
+ 
+const char *print_tainted()
+{
+	static char buf[20];
+	if (tainted) {
+		snprintf(buf, sizeof(buf), "Tainted: %c%c",
+			tainted & 1 ? 'P' : 'G',
+			tainted & 2 ? 'F' : ' ');
+	}
+	else
+		snprintf(buf, sizeof(buf), "Not tainted");
+	return(buf);
+}
+
+int tainted = 0;
Index: 9.42/include/linux/sysctl.h
--- 9.42/include/linux/sysctl.h Mon, 17 Sep 2001 13:20:12 +1000 kaos (linux-2.4/e/b/38_sysctl.h 1.1.5.1.1.1.2.8 644)
+++ 9.42(w)/include/linux/sysctl.h Tue, 25 Sep 2001 16:18:07 +1000 kaos (linux-2.4/e/b/38_sysctl.h 1.1.5.1.1.1.2.8 644)
@@ -121,6 +121,7 @@ enum
 	KERN_IEEE_EMULATION_WARNINGS=50, /* int: unimplemented ieee instructions */
 	KERN_S390_USER_DEBUG_LOGGING=51,  /* int: dumps of user faults */
 	KERN_CORE_USES_PID=52,		/* int: use core or core.%pid */
+	KERN_TAINTED=53,	/* int: various kernel tainted flags */
 };
 
 
Index: 9.42/include/linux/kernel.h
--- 9.42/include/linux/kernel.h Sat, 22 Sep 2001 14:32:51 +1000 kaos (linux-2.4/g/b/11_kernel.h 1.1.2.1.1.7 644)
+++ 9.42(w)/include/linux/kernel.h Tue, 25 Sep 2001 16:18:08 +1000 kaos (linux-2.4/g/b/11_kernel.h 1.1.2.1.1.7 644)
@@ -96,6 +96,9 @@ static inline void console_verbose(void)
 extern void bust_spinlocks(int yes);
 extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
 
+extern int tainted;
+extern const char *print_tainted(void);
+
 #if DEBUG
 #define pr_debug(fmt,arg...) \
 	printk(KERN_DEBUG fmt,##arg)
Index: 9.42/arch/parisc/mm/pa20.c
--- 9.42/arch/parisc/mm/pa20.c Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/l/c/45_pa20.c 1.1 644)
+++ 9.42(w)/arch/parisc/mm/pa20.c Tue, 25 Sep 2001 16:32:52 +1000 kaos (linux-2.4/l/c/45_pa20.c 1.1 644)
@@ -127,8 +127,9 @@ static void pa20_show_regs(struct pt_reg
 	/*
 	 * Saved cp0 registers
 	 */
-	printk("epc  : %08lx\nStatus: %08x\nCause : %08x\n",
-	       (unsigned long) regs->cp0_epc, (unsigned int) regs->cp0_status,
+	printk("epc  : %08lx    %s\nStatus: %08x\nCause : %08x\n",
+	       (unsigned long) regs->cp0_epc, print_tainted(),
+	       (unsigned int) regs->cp0_status,
 	       (unsigned int) regs->cp0_cause);
 }
 
Index: 9.42/arch/parisc/mm/pa11.c
--- 9.42/arch/parisc/mm/pa11.c Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/l/c/46_pa11.c 1.1 644)
+++ 9.42(w)/arch/parisc/mm/pa11.c Tue, 25 Sep 2001 16:32:43 +1000 kaos (linux-2.4/l/c/46_pa11.c 1.1 644)
@@ -127,8 +127,9 @@ static void pa11_show_regs(struct pt_reg
 	/*
 	 * Saved cp0 registers
 	 */
-	printk("epc  : %08lx\nStatus: %08x\nCause : %08x\n",
-	       (unsigned long) regs->cp0_epc, (unsigned int) regs->cp0_status,
+	printk("epc  : %08lx    %s\nStatus: %08x\nCause : %08x\n",
+	       (unsigned long) regs->cp0_epc, print_tainted(),
+	       (unsigned int) regs->cp0_status,
 	       (unsigned int) regs->cp0_cause);
 }
 
Index: 9.42/arch/parisc/kernel/traps.c
--- 9.42/arch/parisc/kernel/traps.c Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/m/c/0_traps.c 1.1 644)
+++ 9.42(w)/arch/parisc/kernel/traps.c Tue, 25 Sep 2001 16:34:23 +1000 kaos (linux-2.4/m/c/0_traps.c 1.1 644)
@@ -82,7 +82,7 @@ void show_regs(struct pt_regs *regs)
 
 	printk("     YZrvWESTHLNXBCVMcbcbcbcbOGFRQPDI\nPSW: ");
 	printbinary(regs->gr[0], 32);
-	printk("\n");
+	printk("    %s\n", print_tainted());
 
 	for (i = 0; i < 32; i += 4) {
 		int j;
Index: 9.42/arch/s390/kernel/process.c
--- 9.42/arch/s390/kernel/process.c Sat, 22 Sep 2001 14:41:20 +1000 kaos (linux-2.4/n/c/22_process.c 1.7 644)
+++ 9.42(w)/arch/s390/kernel/process.c Tue, 25 Sep 2001 16:36:38 +1000 kaos (linux-2.4/n/c/22_process.c 1.7 644)
@@ -127,9 +127,10 @@ static int sprintf_regs(int line, char *
 		break;
 	case sp_psw:
 		if(regs)
-			linelen=sprintf(buff, "%s PSW:    %08lx %08lx\n", mode,
+			linelen=sprintf(buff, "%s PSW:    %08lx %08lx    %s\n", mode,
 				(unsigned long) regs->psw.mask,
-				(unsigned long) regs->psw.addr);
+				(unsigned long) regs->psw.addr,
+				print_tainted());
 		else
 			linelen=sprintf(buff,"pt_regs=NULL some info unavailable\n");
 		break;
Index: 9.42/arch/mips64/mm/r4xx0.c
--- 9.42/arch/mips64/mm/r4xx0.c Mon, 27 Aug 2001 09:52:57 +1000 kaos (linux-2.4/o/c/27_r4xx0.c 1.2.1.2 644)
+++ 9.42(w)/arch/mips64/mm/r4xx0.c Tue, 25 Sep 2001 16:39:12 +1000 kaos (linux-2.4/o/c/27_r4xx0.c 1.2.1.2 644)
@@ -2109,8 +2109,8 @@ static void r4k_show_regs(struct pt_regs
 	printk("Lo      : %016lx\n", regs->lo);
 
 	/* Saved cp0 registers. */
-	printk("epc     : %016lx\nbadvaddr: %016lx\n",
-	       regs->cp0_epc, regs->cp0_badvaddr);
+	printk("epc     : %016lx    %s\nbadvaddr: %016lx\n",
+	       regs->cp0_epc, print_tainted(), regs->cp0_badvaddr);
 	printk("Status  : %08x\nCause   : %08x\n",
 	       (unsigned int) regs->cp0_status, (unsigned int) regs->cp0_cause);
 }
Index: 9.42/arch/mips64/mm/andes.c
--- 9.42/arch/mips64/mm/andes.c Mon, 27 Aug 2001 09:52:57 +1000 kaos (linux-2.4/o/c/32_andes.c 1.1.1.2 644)
+++ 9.42(w)/arch/mips64/mm/andes.c Tue, 25 Sep 2001 16:40:09 +1000 kaos (linux-2.4/o/c/32_andes.c 1.1.1.2 644)
@@ -326,8 +326,8 @@ static void andes_show_regs(struct pt_re
 	printk("Lo      : %016lx\n", regs->lo);
 
 	/* Saved cp0 registers. */
-	printk("epc     : %016lx\nbadvaddr: %016lx\n",
-	       regs->cp0_epc, regs->cp0_badvaddr);
+	printk("epc     : %016lx    %s\nbadvaddr: %016lx\n",
+	       regs->cp0_epc, print_tainted(), regs->cp0_badvaddr);
 	printk("Status  : %08x\nCause   : %08x\n",
 	       (unsigned int) regs->cp0_status, (unsigned int) regs->cp0_cause);
 }
Index: 9.42/arch/ia64/kernel/process.c
--- 9.42/arch/ia64/kernel/process.c Sun, 05 Aug 2001 13:29:36 +1000 kaos (linux-2.4/r/c/50_process.c 1.1.3.1.3.1 644)
+++ 9.42(w)/arch/ia64/kernel/process.c Tue, 25 Sep 2001 16:41:04 +1000 kaos (linux-2.4/r/c/50_process.c 1.1.3.1.3.1 644)
@@ -63,8 +63,8 @@ show_regs (struct pt_regs *regs)
 {
 	unsigned long ip = regs->cr_iip + ia64_psr(regs)->ri;
 
-	printk("\npsr : %016lx ifs : %016lx ip  : [<%016lx>]\n",
-	       regs->cr_ipsr, regs->cr_ifs, ip);
+	printk("\npsr : %016lx ifs : %016lx ip  : [<%016lx>]    %s\n",
+	       regs->cr_ipsr, regs->cr_ifs, ip, print_tainted());
 	printk("unat: %016lx pfs : %016lx rsc : %016lx\n",
 	       regs->ar_unat, regs->ar_pfs, regs->ar_rsc);
 	printk("rnat: %016lx bsps: %016lx pr  : %016lx\n",
Index: 9.42/arch/sh/kernel/process.c
--- 9.42/arch/sh/kernel/process.c Mon, 17 Sep 2001 13:20:12 +1000 kaos (linux-2.4/t/c/34_process.c 1.4.1.1 644)
+++ 9.42(w)/arch/sh/kernel/process.c Tue, 25 Sep 2001 16:41:35 +1000 kaos (linux-2.4/t/c/34_process.c 1.4.1.1 644)
@@ -81,8 +81,8 @@ void machine_power_off(void)
 void show_regs(struct pt_regs * regs)
 {
 	printk("\n");
-	printk("PC  : %08lx SP  : %08lx SR  : %08lx TEA : %08x\n",
-	       regs->pc, regs->regs[15], regs->sr, ctrl_inl(MMU_TEA));
+	printk("PC  : %08lx SP  : %08lx SR  : %08lx TEA : %08x    %s\n",
+	       regs->pc, regs->regs[15], regs->sr, ctrl_inl(MMU_TEA), print_tainted());
 	printk("R0  : %08lx R1  : %08lx R2  : %08lx R3  : %08lx\n",
 	       regs->regs[0],regs->regs[1],
 	       regs->regs[2],regs->regs[3]);
Index: 9.42/arch/arm/kernel/process.c
--- 9.42/arch/arm/kernel/process.c Tue, 14 Aug 2001 09:42:10 +1000 kaos (linux-2.4/w/c/43_process.c 1.6 644)
+++ 9.42(w)/arch/arm/kernel/process.c Tue, 25 Sep 2001 16:41:56 +1000 kaos (linux-2.4/w/c/43_process.c 1.6 644)
@@ -158,10 +158,10 @@ void show_regs(struct pt_regs * regs)
 
 	flags = condition_codes(regs);
 
-	printk("pc : [<%08lx>]    lr : [<%08lx>]\n"
+	printk("pc : [<%08lx>]    lr : [<%08lx>]    %s\n"
 	       "sp : %08lx  ip : %08lx  fp : %08lx\n",
 		instruction_pointer(regs),
-		regs->ARM_lr, regs->ARM_sp,
+		regs->ARM_lr, print_tainted(), regs->ARM_sp,
 		regs->ARM_ip, regs->ARM_fp);
 	printk("r10: %08lx  r9 : %08lx  r8 : %08lx\n",
 		regs->ARM_r10, regs->ARM_r9,
Index: 9.42/arch/sparc64/kernel/process.c
--- 9.42/arch/sparc64/kernel/process.c Sat, 09 Jun 2001 11:25:53 +1000 kaos (linux-2.4/z/c/36_process.c 1.5 644)
+++ 9.42(w)/arch/sparc64/kernel/process.c Tue, 25 Sep 2001 16:43:28 +1000 kaos (linux-2.4/z/c/36_process.c 1.5 644)
@@ -282,8 +282,8 @@ void __show_regs(struct pt_regs * regs)
 	       local_irq_count(smp_processor_id()),
 	       irqs_running());
 #endif
-	printk("TSTATE: %016lx TPC: %016lx TNPC: %016lx Y: %08x\n", regs->tstate,
-	       regs->tpc, regs->tnpc, regs->y);
+	printk("TSTATE: %016lx TPC: %016lx TNPC: %016lx Y: %08x    %s\n", regs->tstate,
+	       regs->tpc, regs->tnpc, regs->y, print_tainted());
 	printk("g0: %016lx g1: %016lx g2: %016lx g3: %016lx\n",
 	       regs->u_regs[0], regs->u_regs[1], regs->u_regs[2],
 	       regs->u_regs[3]);
@@ -349,8 +349,8 @@ void show_regs(struct pt_regs *regs)
 
 void show_regs32(struct pt_regs32 *regs)
 {
-	printk("PSR: %08x PC: %08x NPC: %08x Y: %08x\n", regs->psr,
-	       regs->pc, regs->npc, regs->y);
+	printk("PSR: %08x PC: %08x NPC: %08x Y: %08x    %s\n", regs->psr,
+	       regs->pc, regs->npc, regs->y, print_tainted());
 	printk("g0: %08x g1: %08x g2: %08x g3: %08x ",
 	       regs->u_regs[0], regs->u_regs[1], regs->u_regs[2],
 	       regs->u_regs[3]);
Index: 9.42/arch/m68k/kernel/process.c
--- 9.42/arch/m68k/kernel/process.c Sat, 10 Feb 2001 13:20:52 +1100 kaos (linux-2.4/D/c/2_process.c 1.2 644)
+++ 9.42(w)/arch/m68k/kernel/process.c Tue, 25 Sep 2001 16:43:50 +1000 kaos (linux-2.4/D/c/2_process.c 1.2 644)
@@ -110,8 +110,8 @@ void machine_power_off(void)
 void show_regs(struct pt_regs * regs)
 {
 	printk("\n");
-	printk("Format %02x  Vector: %04x  PC: %08lx  Status: %04x\n",
-	       regs->format, regs->vector, regs->pc, regs->sr);
+	printk("Format %02x  Vector: %04x  PC: %08lx  Status: %04x    %s\n",
+	       regs->format, regs->vector, regs->pc, regs->sr, print_tainted());
 	printk("ORIG_D0: %08lx  D0: %08lx  A2: %08lx  A1: %08lx\n",
 	       regs->orig_d0, regs->d0, regs->a2, regs->a1);
 	printk("A0: %08lx  D5: %08lx  D4: %08lx\n",
Index: 9.42/arch/ppc/kernel/process.c
--- 9.42/arch/ppc/kernel/process.c Thu, 06 Sep 2001 11:18:29 +1000 kaos (linux-2.4/I/c/39_process.c 1.3.1.6 644)
+++ 9.42(w)/arch/ppc/kernel/process.c Tue, 25 Sep 2001 16:44:12 +1000 kaos (linux-2.4/I/c/39_process.c 1.3.1.6 644)
@@ -244,8 +244,8 @@ void show_regs(struct pt_regs * regs)
 {
 	int i;
 
-	printk("NIP: %08lX XER: %08lX LR: %08lX SP: %08lX REGS: %p TRAP: %04lx\n",
-	       regs->nip, regs->xer, regs->link, regs->gpr[1], regs,regs->trap);
+	printk("NIP: %08lX XER: %08lX LR: %08lX SP: %08lX REGS: %p TRAP: %04lx    %s\n",
+	       regs->nip, regs->xer, regs->link, regs->gpr[1], regs,regs->trap, print_tainted());
 	printk("MSR: %08lx EE: %01x PR: %01x FP: %01x ME: %01x IR/DR: %01x%01x\n",
 	       regs->msr, regs->msr&MSR_EE ? 1 : 0, regs->msr&MSR_PR ? 1 : 0,
 	       regs->msr & MSR_FP ? 1 : 0,regs->msr&MSR_ME ? 1 : 0,
Index: 9.42/arch/ppc/kernel/traps.c
--- 9.42/arch/ppc/kernel/traps.c Mon, 27 Aug 2001 09:52:57 +1000 kaos (linux-2.4/I/c/41_traps.c 1.3.1.3.1.1 644)
+++ 9.42(w)/arch/ppc/kernel/traps.c Tue, 25 Sep 2001 16:45:34 +1000 kaos (linux-2.4/I/c/41_traps.c 1.3.1.3.1.1 644)
@@ -191,8 +191,8 @@ SMIException(struct pt_regs *regs)
 void
 UnknownException(struct pt_regs *regs)
 {
-	printk("Bad trap at PC: %lx, SR: %lx, vector=%lx\n",
-	       regs->nip, regs->msr, regs->trap);
+	printk("Bad trap at PC: %lx, SR: %lx, vector=%lx    %s\n",
+	       regs->nip, regs->msr, regs->trap, print_tainted());
 	_exception(SIGTRAP, regs);	
 }
 
@@ -338,9 +338,9 @@ StackOverflow(struct pt_regs *regs)
 void
 trace_syscall(struct pt_regs *regs)
 {
-	printk("Task: %p(%d), PC: %08lX/%08lX, Syscall: %3ld, Result: %s%ld\n",
+	printk("Task: %p(%d), PC: %08lX/%08lX, Syscall: %3ld, Result: %s%ld    %s\n",
 	       current, current->pid, regs->nip, regs->link, regs->gpr[0],
-	       regs->ccr&0x10000000?"Error=":"", regs->gpr[3]);
+	       regs->ccr&0x10000000?"Error=":"", regs->gpr[3], print_tainted());
 }
 
 #ifdef CONFIG_8xx
@@ -376,8 +376,8 @@ SoftwareEmulation(struct pt_regs *regs)
 void
 TAUException(struct pt_regs *regs)
 {
-	printk("TAU trap at PC: %lx, SR: %lx, vector=%lx\n",
-	       regs->nip, regs->msr, regs->trap);
+	printk("TAU trap at PC: %lx, SR: %lx, vector=%lx    %s\n",
+	       regs->nip, regs->msr, regs->trap, print_tainted());
 }
 #endif /* CONFIG_INT_TAU */
 
Index: 9.42/arch/mips/mm/r4xx0.c
--- 9.42/arch/mips/mm/r4xx0.c Tue, 28 Aug 2001 12:42:15 +1000 kaos (linux-2.4/M/c/35_r4xx0.c 1.1.1.2 644)
+++ 9.42(w)/arch/mips/mm/r4xx0.c Tue, 25 Sep 2001 16:46:17 +1000 kaos (linux-2.4/M/c/35_r4xx0.c 1.1.1.2 644)
@@ -2364,8 +2364,8 @@ void show_regs(struct pt_regs * regs)
 	       regs->regs[28], regs->regs[29], regs->regs[30], regs->regs[31]);
 
 	/* Saved cp0 registers. */
-	printk("epc   : %08lx\nStatus: %08lx\nCause : %08lx\n",
-	       regs->cp0_epc, regs->cp0_status, regs->cp0_cause);
+	printk("epc   : %08lx    %s\nStatus: %08lx\nCause : %08lx\n",
+	       regs->cp0_epc, print_tainted(), regs->cp0_status, regs->cp0_cause);
 }
 			
 void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
Index: 9.42/arch/mips/mm/r2300.c
--- 9.42/arch/mips/mm/r2300.c Tue, 28 Aug 2001 12:42:15 +1000 kaos (linux-2.4/M/c/37_r2300.c 1.1.1.2 644)
+++ 9.42(w)/arch/mips/mm/r2300.c Tue, 25 Sep 2001 16:46:48 +1000 kaos (linux-2.4/M/c/37_r2300.c 1.1.1.2 644)
@@ -665,8 +665,10 @@ void show_regs(struct pt_regs * regs)
 	/*
 	 * Saved cp0 registers
 	 */
-	printk("epc  : %08lx\nStatus: %08x\nCause : %08x\n",
-	       (unsigned long) regs->cp0_epc, (unsigned int) regs->cp0_status,
+	printk("epc  : %08lx    %s\nStatus: %08x\nCause : %08x\n",
+	       (unsigned long) regs->cp0_epc,
+	       print_tainted(),
+	       (unsigned int) regs->cp0_status,
 	       (unsigned int) regs->cp0_cause);
 }
 
Index: 9.42/arch/sparc/kernel/process.c
--- 9.42/arch/sparc/kernel/process.c Sat, 10 Feb 2001 13:20:52 +1100 kaos (linux-2.4/O/c/48_process.c 1.2 644)
+++ 9.42(w)/arch/sparc/kernel/process.c Tue, 25 Sep 2001 16:49:07 +1000 kaos (linux-2.4/O/c/48_process.c 1.2 644)
@@ -268,8 +268,8 @@ void show_stackframe(struct sparc_stackf
 
 void show_regs(struct pt_regs * regs)
 {
-        printk("PSR: %08lx PC: %08lx NPC: %08lx Y: %08lx\n", regs->psr,
-	       regs->pc, regs->npc, regs->y);
+        printk("PSR: %08lx PC: %08lx NPC: %08lx Y: %08lx    %s\n", regs->psr,
+	       regs->pc, regs->npc, regs->y, print_tainted());
 	printk("g0: %08lx g1: %08lx g2: %08lx g3: %08lx ",
 	       regs->u_regs[0], regs->u_regs[1], regs->u_regs[2],
 	       regs->u_regs[3]);
Index: 9.42/arch/alpha/kernel/process.c
--- 9.42/arch/alpha/kernel/process.c Wed, 19 Sep 2001 12:05:56 +1000 kaos (linux-2.4/Q/c/17_process.c 1.3.1.2.1.1 644)
+++ 9.42(w)/arch/alpha/kernel/process.c Tue, 25 Sep 2001 16:49:38 +1000 kaos (linux-2.4/Q/c/17_process.c 1.3.1.2.1.1 644)
@@ -215,7 +215,8 @@ show_regs(struct pt_regs * regs)
 {
 	printk("\n");
 	printk("Pid: %d, comm: %20s\n", current->pid, current->comm);
-	printk("ps: %04lx pc: [<%016lx>] CPU %d\n", regs->ps, regs->pc, smp_processor_id());
+	printk("ps: %04lx pc: [<%016lx>] CPU %d    %s\n",
+	       regs->ps, regs->pc, smp_processor_id(), print_tainted());
 	printk("rp: [<%016lx>] sp: %p\n", regs->r26, regs+1);
 	printk(" r0: %016lx  r1: %016lx  r2: %016lx  r3: %016lx\n",
 	       regs->r0, regs->r1, regs->r2, regs->r3);
Index: 9.42/arch/alpha/kernel/traps.c
--- 9.42/arch/alpha/kernel/traps.c Mon, 27 Aug 2001 09:52:57 +1000 kaos (linux-2.4/Q/c/20_traps.c 1.3.1.3 644)
+++ 9.42(w)/arch/alpha/kernel/traps.c Tue, 25 Sep 2001 16:50:05 +1000 kaos (linux-2.4/Q/c/20_traps.c 1.3.1.3 644)
@@ -53,8 +53,8 @@ opDEC_check(void)
 void
 dik_show_regs(struct pt_regs *regs, unsigned long *r9_15)
 {
-	printk("pc = [<%016lx>]  ra = [<%016lx>]  ps = %04lx\n",
-	       regs->pc, regs->r26, regs->ps);
+	printk("pc = [<%016lx>]  ra = [<%016lx>]  ps = %04lx    %s\n",
+	       regs->pc, regs->r26, regs->ps, print_tainted());
 	printk("v0 = %016lx  t0 = %016lx  t1 = %016lx\n",
 	       regs->r0, regs->r1, regs->r2);
 	printk("t2 = %016lx  t3 = %016lx  t4 = %016lx\n",
Index: 9.42/arch/i386/kernel/process.c
--- 9.42/arch/i386/kernel/process.c Wed, 19 Sep 2001 12:05:56 +1000 kaos (linux-2.4/S/c/16_process.c 1.1.3.1.1.1.1.4 644)
+++ 9.42(w)/arch/i386/kernel/process.c Tue, 25 Sep 2001 16:50:49 +1000 kaos (linux-2.4/S/c/16_process.c 1.1.3.1.1.1.1.4 644)
@@ -442,7 +442,7 @@ void show_regs(struct pt_regs * regs)
 	printk("EIP: %04x:[<%08lx>] CPU: %d",0xffff & regs->xcs,regs->eip, smp_processor_id());
 	if (regs->xcs & 3)
 		printk(" ESP: %04x:%08lx",0xffff & regs->xss,regs->esp);
-	printk(" EFLAGS: %08lx\n",regs->eflags);
+	printk(" EFLAGS: %08lx    %s\n",regs->eflags, print_tainted());
 	printk("EAX: %08lx EBX: %08lx ECX: %08lx EDX: %08lx\n",
 		regs->eax,regs->ebx,regs->ecx,regs->edx);
 	printk("ESI: %08lx EDI: %08lx EBP: %08lx",
Index: 9.42/arch/i386/kernel/traps.c
--- 9.42/arch/i386/kernel/traps.c Fri, 03 Aug 2001 15:00:29 +1000 kaos (linux-2.4/S/c/22_traps.c 1.1.2.1.1.2.1.2.1.5 644)
+++ 9.42(w)/arch/i386/kernel/traps.c Tue, 25 Sep 2001 16:18:08 +1000 kaos (linux-2.4/S/c/22_traps.c 1.1.2.1.1.2.1.2.1.5 644)
@@ -201,8 +201,8 @@ void show_registers(struct pt_regs *regs
 		esp = regs->esp;
 		ss = regs->xss & 0xffff;
 	}
-	printk("CPU:    %d\nEIP:    %04x:[<%08lx>]\nEFLAGS: %08lx\n",
-		smp_processor_id(), 0xffff & regs->xcs, regs->eip, regs->eflags);
+	printk("CPU:    %d\nEIP:    %04x:[<%08lx>]    %s\nEFLAGS: %08lx\n",
+		smp_processor_id(), 0xffff & regs->xcs, regs->eip, print_tainted(), regs->eflags);
 	printk("eax: %08lx   ebx: %08lx   ecx: %08lx   edx: %08lx\n",
 		regs->eax, regs->ebx, regs->ecx, regs->edx);
 	printk("esi: %08lx   edi: %08lx   ebp: %08lx   esp: %08lx\n",
Index: 9.42/Documentation/sysctl/kernel.txt
--- 9.42/Documentation/sysctl/kernel.txt Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/X/c/31_kernel.txt 1.1 644)
+++ 9.42(w)/Documentation/sysctl/kernel.txt Tue, 25 Sep 2001 17:18:28 +1000 kaos (linux-2.4/X/c/31_kernel.txt 1.1 644)
@@ -39,6 +39,7 @@ show up in /proc/sys/kernel:
 - rtsig-max
 - sg-big-buff                 [ generic SCSI device (sg) ]
 - shmmax                      [ sysv ipc ]
+- tainted
 - version
 - zero-paged                  [ PPC only ]
 
@@ -217,6 +218,19 @@ This value can be used to query and set 
 on the maximum shared memory segment size that can be created.
 Shared memory segments up to 1Gb are now supported in the 
 kernel.  This value defaults to SHMMAX.
+
+==============================================================
+
+tainted: 
+
+Non-zero if the kernel has been tainted.  Numeric values, which
+can be ORed together:
+
+  1 - A module with a non-GPL license has been loaded, this
+      includes modules with no license.
+      Set by modutils >= 2.4.9.
+  2 - A module was force loaded by insmod -f.
+      Set by modutils >= 2.4.9.
 
 ==============================================================
 
Index: 9.42/Documentation/oops-tracing.txt
--- 9.42/Documentation/oops-tracing.txt Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/Y/c/26_oops-traci 1.1 644)
+++ 9.42(w)/Documentation/oops-tracing.txt Tue, 25 Sep 2001 16:18:08 +1000 kaos (linux-2.4/Y/c/26_oops-traci 1.1 644)
@@ -201,3 +201,26 @@ Roger Maris Cancer Center    INTERNET: g
 820 4th St. N.
 Fargo, ND  58122
 Phone: 701-234-7556
+
+
+---------------------------------------------------------------------------
+Tainted kernels:
+
+Some oops reports contain the string 'Tainted: ' after the program
+counter, this indicates that the kernel has been tainted by some
+mechanism.  The string is followed by a series of position sensitive
+characters, each representing a particular tainted value.
+
+  1: 'G' if all modules loaded have a GPL or compatible license, 'P' if
+     any proprietary module has been loaded.  Modules without a
+     MODULE_LICENSE or with a MODULE_LICENSE that is not recognised by
+     insmod as GPL compatible are assumed to be proprietary.
+
+  2: 'F' if any module was force loaded by insmod -f, ' ' if all
+     modules were loaded normally.
+
+The primary reason for the 'Tainted: ' string is to tell kernel
+debuggers if this is a clean kernel or if anything unusual has
+occurred.  Tainting is permanent, even if an offending module is
+unloading the tainted value remains to indicate that the kernel is not
+trustworthy.
Index: 9.42/arch/cris/kernel/traps.c
--- 9.42/arch/cris/kernel/traps.c Mon, 30 Jul 2001 10:52:30 +1000 kaos (linux-2.4/m/d/19_traps.c 1.1.1.4 644)
+++ 9.42(w)/arch/cris/kernel/traps.c Tue, 25 Sep 2001 16:51:40 +1000 kaos (linux-2.4/m/d/19_traps.c 1.1.1.4 644)
@@ -138,8 +138,8 @@ show_registers(struct pt_regs * regs)
 	   register.  */
 	unsigned long usp = rdusp();
 
-	printk("IRP: %08lx SRP: %08lx DCCR: %08lx USP: %08lx MOF: %08lx\n",
-	       regs->irp, regs->srp, regs->dccr, usp, regs->mof );
+	printk("IRP: %08lx SRP: %08lx DCCR: %08lx USP: %08lx MOF: %08lx    %s\n",
+	       regs->irp, regs->srp, regs->dccr, usp, regs->mof, print_tainted());
 	printk(" r0: %08lx  r1: %08lx   r2: %08lx  r3: %08lx\n",
 	       regs->r0, regs->r1, regs->r2, regs->r3);
 	printk(" r4: %08lx  r5: %08lx   r6: %08lx  r7: %08lx\n",
Index: 9.42/arch/s390x/kernel/process.c
--- 9.42/arch/s390x/kernel/process.c Sat, 22 Sep 2001 14:41:20 +1000 kaos (linux-2.4/p/d/32_process.c 1.5 644)
+++ 9.42(w)/arch/s390x/kernel/process.c Tue, 25 Sep 2001 16:55:40 +1000 kaos (linux-2.4/p/d/32_process.c 1.5 644)
@@ -131,9 +131,10 @@ static int sprintf_regs(int line, char *
 		break;
 	case sp_psw:
 		if(regs)
-			linelen=sprintf(buff, "%s PSW:    %016lx %016lx\n", mode,
+			linelen=sprintf(buff, "%s PSW:    %016lx %016lx    %s\n", mode,
 				(unsigned long) regs->psw.mask,
-				(unsigned long) regs->psw.addr);
+				(unsigned long) regs->psw.addr,
+				print_tainted());
 		else
 			linelen=sprintf(buff,"pt_regs=NULL some info unavailable\n");
 		break;
Index: 9.42/arch/mips/mm/rm7k.c
--- 9.42/arch/mips/mm/rm7k.c Thu, 05 Jul 2001 09:21:22 +1000 kaos (linux-2.4/F/e/29_rm7k.c 1.1 644)
+++ 9.42(w)/arch/mips/mm/rm7k.c Tue, 25 Sep 2001 16:47:04 +1000 kaos (linux-2.4/F/e/29_rm7k.c 1.1 644)
@@ -507,8 +507,8 @@ void show_regs(struct pt_regs * regs)
 	       regs->regs[28], regs->regs[29], regs->regs[30], regs->regs[31]);
 
 	/* Saved cp0 registers. */
-	printk(KERN_INFO "epc   : %08lx\nStatus: %08lx\nCause : %08lx\n",
-	       regs->cp0_epc, regs->cp0_status, regs->cp0_cause);
+	printk(KERN_INFO "epc   : %08lx    %s\nStatus: %08lx\nCause : %08lx\n",
+	       regs->cp0_epc, print_tainted(), regs->cp0_status, regs->cp0_cause);
 }
 
 void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
Index: 9.42/arch/mips/mm/r5432.c
--- 9.42/arch/mips/mm/r5432.c Tue, 28 Aug 2001 12:42:15 +1000 kaos (linux-2.4/F/e/30_r5432.c 1.2 644)
+++ 9.42(w)/arch/mips/mm/r5432.c Tue, 25 Sep 2001 16:47:21 +1000 kaos (linux-2.4/F/e/30_r5432.c 1.2 644)
@@ -765,8 +765,8 @@ void show_regs(struct pt_regs * regs)
 	       regs->regs[28], regs->regs[29], regs->regs[30], regs->regs[31]);
 
 	/* Saved cp0 registers. */
-	printk("epc   : %08lx\nStatus: %08lx\nCause : %08lx\n",
-	       regs->cp0_epc, regs->cp0_status, regs->cp0_cause);
+	printk("epc   : %08lx    %s\nStatus: %08lx\nCause : %08lx\n",
+	       regs->cp0_epc, print_tainted(), regs->cp0_status, regs->cp0_cause);
 }
 			
 void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
Index: 9.42/arch/mips/mm/mips32.c
--- 9.42/arch/mips/mm/mips32.c Tue, 28 Aug 2001 12:42:15 +1000 kaos (linux-2.4/F/e/31_mips32.c 1.2 644)
+++ 9.42(w)/arch/mips/mm/mips32.c Tue, 25 Sep 2001 16:47:38 +1000 kaos (linux-2.4/F/e/31_mips32.c 1.2 644)
@@ -739,8 +739,8 @@ void show_regs(struct pt_regs * regs)
 	       regs->regs[28], regs->regs[29], regs->regs[30], regs->regs[31]);
 
 	/* Saved cp0 registers. */
-	printk("epc   : %08lx\nStatus: %08lx\nCause : %08lx\n",
-	       regs->cp0_epc, regs->cp0_status, regs->cp0_cause);
+	printk("epc   : %08lx    %s\nStatus: %08lx\nCause : %08lx\n",
+	       regs->cp0_epc, print_tainted(), regs->cp0_status, regs->cp0_cause);
 }
 			
 void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
Index: 9.42/arch/ppc64/kernel/process.c
--- 9.42/arch/ppc64/kernel/process.c Mon, 03 Sep 2001 12:31:59 +1000 kaos (linux-2.4/W/e/41_process.c 1.2 644)
+++ 9.42(w)/arch/ppc64/kernel/process.c Tue, 25 Sep 2001 16:53:03 +1000 kaos (linux-2.4/W/e/41_process.c 1.2 644)
@@ -239,8 +239,8 @@ void show_regs(struct pt_regs * regs)
 {
 	int i;
 
-	printk("NIP: %016lX XER: %016lX LR: %016lX REGS: %p TRAP: %04lx\n",
-	       regs->nip, regs->xer, regs->link, regs,regs->trap);
+	printk("NIP: %016lX XER: %016lX LR: %016lX REGS: %p TRAP: %04lx    %s\n",
+	       regs->nip, regs->xer, regs->link, regs,regs->trap, print_tainted());
 	printk("MSR: %016lx EE: %01x PR: %01x FP: %01x ME: %01x IR/DR: %01x%01x\n",
 	       regs->msr, regs->msr&MSR_EE ? 1 : 0, regs->msr&MSR_PR ? 1 : 0,
 	       regs->msr & MSR_FP ? 1 : 0,regs->msr&MSR_ME ? 1 : 0,
Index: 9.42/arch/x86_64/kernel/process.c
--- 9.42/arch/x86_64/kernel/process.c Tue, 21 Aug 2001 17:07:56 +1000 kaos (linux-2.4/b/f/22_process.c 1.1 644)
+++ 9.42(w)/arch/x86_64/kernel/process.c Tue, 25 Sep 2001 16:53:52 +1000 kaos (linux-2.4/b/f/22_process.c 1.1 644)
@@ -198,7 +198,7 @@ void show_regs(struct pt_regs * regs)
 	printk("\n");
 	printk("RIP: %04x:[<%016lx>]", (unsigned)regs->cs & 0xffff, regs->rip);
 	printk(" RSP: %016lx", regs->rsp);
-	printk(" EFLAGS: %08lx\n",regs->eflags);
+	printk(" EFLAGS: %08lx    %s\n",regs->eflags, print_tainted());
 	printk("RAX: %016lx RBX: %016lx RCX: %016lx RDX: %016lx\n",
 		regs->rax,regs->rbx,regs->rcx,regs->rdx);
 	printk("RSI: %016lx RDI: %016lx RBP: %016lx\n",
Index: 9.42/arch/um/sys-i386/sysrq.c
--- 9.42/arch/um/sys-i386/sysrq.c Wed, 19 Sep 2001 12:05:56 +1000 kaos (linux-2.4/o/f/10_sysrq.c 1.1 644)
+++ 9.42(w)/arch/um/sys-i386/sysrq.c Tue, 25 Sep 2001 16:52:36 +1000 kaos (linux-2.4/o/f/10_sysrq.c 1.1 644)
@@ -6,8 +6,8 @@
 void show_regs(struct pt_regs_subarch *regs)
 {
         printk("\n");
-        printk("EIP: %04x:[<%08lx>] CPU: %d",0xffff & regs->xcs, regs->eip,
-	       smp_processor_id());
+        printk("EIP: %04x:[<%08lx>] CPU: %d    %s",0xffff & regs->xcs, regs->eip,
+	       smp_processor_id(), print_tainted());
         if (regs->xcs & 3)
                 printk(" ESP: %04x:%08lx",0xffff & regs->xss, regs->esp);
         printk(" EFLAGS: %08lx\n", regs->eflags);

