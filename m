Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266786AbUI0MKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266786AbUI0MKr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 08:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266793AbUI0MKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 08:10:47 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:44014 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266786AbUI0MKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 08:10:06 -0400
Date: Mon, 27 Sep 2004 17:40:21 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       akpm@osdl.org, suparna@in.ibm.com, trini@kernel.crashing.org,
       kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Patch] kprobes exception notifier fix 2.6.9-rc2
Message-ID: <20040927121021.GA17292@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20040923053029.GB1291@in.ibm.com> <20040923080627.GA89752@muc.de> <20040923123250.5e62f547.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <20040923123250.5e62f547.davem@davemloft.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

As per Andi and David's request, I have updated exception notifiers for x86_64
and sparc64. This patch can been applied over linux-2.6.9-rc2-mm4. 
Also KGDB exception notifier handler for x86_64 and 
kprobes notifier handler for sparc64 have been updated. 
I have only tested this patch on i386 architecture.

Please let me know if you have any issues.

Thanks
Prasanna

On Thu, Sep 23, 2004 at 12:32:50PM -0700, David S. Miller wrote:
> On 23 Sep 2004 10:06:28 +0200
> Andi Kleen <ak@muc.de> wrote:
> 
> > On Thu, Sep 23, 2004 at 11:00:29AM +0530, Prasanna S Panchamukhi wrote:
> > > In order to make other debuggers use exception notifiers, kprobes 
> > > notifier return values are required to be modified. This patch modifies the
> > > return values of kprobes notifier return values in a clean way.
> > 
> > It's incompatible to x86-64. If you change anything in exception
> > notifiers change both.
> 
> And please change sparc64 as well, as it has the same exception
> notification implemented there as well.

-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>

--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kprobes-exceptions-notifier-fix.patch"


This patch modifies the return value of kprobes exceptions notify handler.
The kprobes exception notifier returns NOTIFY_STOP on handling notification.
This patch helps other debuggers to co-exists with the Kprobes. Other debuggers 
registered for exceptions notification must return NOTIFY_STOP on handling 
the notification.

Signed-Off-By : Prasanna S Panchamukhi <prasanna@in.ibm.com>

---

---



---

 linux-2.6.9-rc2-prasanna/arch/i386/kernel/kprobes.c     |   10 ++---
 linux-2.6.9-rc2-prasanna/arch/i386/kernel/traps.c       |   18 +++++-----
 linux-2.6.9-rc2-prasanna/arch/i386/mm/fault.c           |    2 -
 linux-2.6.9-rc2-prasanna/arch/sparc64/kernel/kprobes.c  |   12 +++---
 linux-2.6.9-rc2-prasanna/arch/sparc64/kernel/traps.c    |   28 ++++++++--------
 linux-2.6.9-rc2-prasanna/arch/sparc64/mm/fault.c        |    4 +-
 linux-2.6.9-rc2-prasanna/arch/x86_64/kernel/kgdb_stub.c |    4 +-
 linux-2.6.9-rc2-prasanna/arch/x86_64/kernel/nmi.c       |    3 +
 linux-2.6.9-rc2-prasanna/arch/x86_64/kernel/traps.c     |   16 +++++----
 linux-2.6.9-rc2-prasanna/include/linux/notifier.h       |    4 ++
 linux-2.6.9-rc2-prasanna/kernel/kprobes.c               |    3 +
 11 files changed, 58 insertions(+), 46 deletions(-)

diff -puN arch/i386/kernel/kprobes.c~kprobes-exceptions-notifier-fix arch/i386/kernel/kprobes.c
--- linux-2.6.9-rc2/arch/i386/kernel/kprobes.c~kprobes-exceptions-notifier-fix	2004-09-27 11:55:57.000000000 +0530
+++ linux-2.6.9-rc2-prasanna/arch/i386/kernel/kprobes.c	2004-09-27 11:55:57.000000000 +0530
@@ -267,26 +267,26 @@ int kprobe_exceptions_notify(struct noti
 	switch (val) {
 	case DIE_INT3:
 		if (kprobe_handler(args->regs))
-			return NOTIFY_OK;
+			return NOTIFY_STOP;
 		break;
 	case DIE_DEBUG:
 		if (post_kprobe_handler(args->regs))
-			return NOTIFY_OK;
+			return NOTIFY_STOP;
 		break;
 	case DIE_GPF:
 		if (kprobe_running() &&
 		    kprobe_fault_handler(args->regs, args->trapnr))
-			return NOTIFY_OK;
+			return NOTIFY_STOP;
 		break;
 	case DIE_PAGE_FAULT:
 		if (kprobe_running() &&
 		    kprobe_fault_handler(args->regs, args->trapnr))
-			return NOTIFY_OK;
+			return NOTIFY_STOP;
 		break;
 	default:
 		break;
 	}
-	return NOTIFY_BAD;
+	return NOTIFY_DONE;
 }
 
 int setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
diff -puN arch/i386/kernel/traps.c~kprobes-exceptions-notifier-fix arch/i386/kernel/traps.c
--- linux-2.6.9-rc2/arch/i386/kernel/traps.c~kprobes-exceptions-notifier-fix	2004-09-27 11:55:57.000000000 +0530
+++ linux-2.6.9-rc2-prasanna/arch/i386/kernel/traps.c	2004-09-27 11:55:57.000000000 +0530
@@ -464,7 +464,7 @@ asmlinkage void do_##name(struct pt_regs
 { \
 	CHK_REMOTE_DEBUG(trapnr,signr,error_code,regs,) \
 	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) \
-						== NOTIFY_OK) \
+						== NOTIFY_STOP) \
 		return; \
 	do_trap(trapnr, signr, str, 0, regs, error_code, NULL); \
 }
@@ -478,7 +478,7 @@ asmlinkage void do_##name(struct pt_regs
 	info.si_code = sicode; \
 	info.si_addr = (void __user *)siaddr; \
 	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) \
-						== NOTIFY_BAD) \
+						== NOTIFY_STOP) \
 		return; \
 	do_trap(trapnr, signr, str, 0, regs, error_code, &info); \
 }
@@ -488,7 +488,7 @@ asmlinkage void do_##name(struct pt_regs
 { \
 	CHK_REMOTE_DEBUG(trapnr, signr, error_code,regs, return) \
 	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) \
-						== NOTIFY_OK) \
+						== NOTIFY_STOP) \
 		return; \
 	do_trap(trapnr, signr, str, 1, regs, error_code, NULL); \
 }
@@ -502,7 +502,7 @@ asmlinkage void do_##name(struct pt_regs
 	info.si_code = sicode; \
 	info.si_addr = (void __user *)siaddr; \
 	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) \
-						== NOTIFY_OK) \
+						== NOTIFY_STOP) \
 		return; \
 	do_trap(trapnr, signr, str, 1, regs, error_code, &info); \
 }
@@ -572,7 +572,7 @@ gp_in_kernel:
 	if (!fixup_exception(regs)) {
  		CHK_REMOTE_DEBUG(13,SIGSEGV,error_code,regs,)
 		if (notify_die(DIE_GPF, "general protection fault", regs,
-				error_code, 13, SIGSEGV) == NOTIFY_OK);
+				error_code, 13, SIGSEGV) == NOTIFY_STOP);
 			return;
 		die("general protection fault", regs, error_code);
 	}
@@ -646,7 +646,7 @@ static void default_do_nmi(struct pt_reg
  
 	if (!(reason & 0xc0)) {
 		if (notify_die(DIE_NMI_IPI, "nmi_ipi", regs, reason, 0, SIGINT)
-							== NOTIFY_BAD)
+							== NOTIFY_STOP)
 			return;
 #ifdef CONFIG_X86_LOCAL_APIC
 		/*
@@ -661,7 +661,7 @@ static void default_do_nmi(struct pt_reg
 		unknown_nmi_error(reason, regs);
 		return;
 	}
-	if (notify_die(DIE_NMI, "nmi", regs, reason, 0, SIGINT) == NOTIFY_BAD)
+	if (notify_die(DIE_NMI, "nmi", regs, reason, 0, SIGINT) == NOTIFY_STOP)
 		return;
 	if (reason & 0x80)
 		mem_parity_error(reason, regs);
@@ -718,7 +718,7 @@ void unset_nmi_callback(void)
 asmlinkage int do_int3(struct pt_regs *regs, long error_code)
 {
 	if (notify_die(DIE_INT3, "int3", regs, error_code, 3, SIGTRAP)
-			== NOTIFY_OK)
+			== NOTIFY_STOP)
 		return 1;
 	/* This is an interrupt gate, because kprobes wants interrupts
 	disabled.  Normal trap handlers don't. */
@@ -759,7 +759,7 @@ asmlinkage void do_debug(struct pt_regs 
 	__asm__ __volatile__("movl %%db6,%0" : "=r" (condition));
 
 	if (notify_die(DIE_DEBUG, "debug", regs, condition, error_code,
-					SIGTRAP) == NOTIFY_OK)
+					SIGTRAP) == NOTIFY_STOP)
 		return;
 	/* It's safe to allow irq's after DR6 has been saved */
 	if (regs->eflags & X86_EFLAGS_IF)
diff -puN arch/i386/mm/fault.c~kprobes-exceptions-notifier-fix arch/i386/mm/fault.c
--- linux-2.6.9-rc2/arch/i386/mm/fault.c~kprobes-exceptions-notifier-fix	2004-09-27 11:55:57.000000000 +0530
+++ linux-2.6.9-rc2-prasanna/arch/i386/mm/fault.c	2004-09-27 11:55:57.000000000 +0530
@@ -227,7 +227,7 @@ asmlinkage void do_page_fault(struct pt_
 	__asm__("movl %%cr2,%0":"=r" (address));
 
 	if (notify_die(DIE_PAGE_FAULT, "page fault", regs, error_code, 14,
-					SIGSEGV) == NOTIFY_OK)
+					SIGSEGV) == NOTIFY_STOP)
 		return;
 	/* It's safe to allow irq's after cr2 has been saved */
 	if (regs->eflags & (X86_EFLAGS_IF|VM_MASK))
diff -puN include/linux/notifier.h~kprobes-exceptions-notifier-fix include/linux/notifier.h
--- linux-2.6.9-rc2/include/linux/notifier.h~kprobes-exceptions-notifier-fix	2004-09-27 11:55:57.000000000 +0530
+++ linux-2.6.9-rc2-prasanna/include/linux/notifier.h	2004-09-27 11:55:57.000000000 +0530
@@ -29,6 +29,10 @@ extern int notifier_call_chain(struct no
 #define NOTIFY_OK		0x0001		/* Suits me */
 #define NOTIFY_STOP_MASK	0x8000		/* Don't call further */
 #define NOTIFY_BAD		(NOTIFY_STOP_MASK|0x0002)	/* Bad/Veto action	*/
+/*
+ * Clean way to return from the notifier and stop further calls.
+ */
+#define NOTIFY_STOP		(NOTIFY_OK|NOTIFY_STOP_MASK)
 
 /*
  *	Declared notifiers so far. I can imagine quite a few more chains
diff -puN kernel/kprobes.c~kprobes-exceptions-notifier-fix kernel/kprobes.c
--- linux-2.6.9-rc2/kernel/kprobes.c~kprobes-exceptions-notifier-fix	2004-09-27 11:55:57.000000000 +0530
+++ linux-2.6.9-rc2-prasanna/kernel/kprobes.c	2004-09-27 11:55:57.000000000 +0530
@@ -25,6 +25,8 @@
  *		hlists and exceptions notifier as suggested by Andi Kleen.
  * 2004-July	Suparna Bhattacharya <suparna@in.ibm.com> added jumper probes
  *		interface to access function arguments.
+ * 2004-Sep	Prasanna S Panchamukhi <prasanna@in.ibm.com> Changed Kprobes
+ *		exceptions notifier to be first on the priority list.
  */
 #include <linux/kprobes.h>
 #include <linux/spinlock.h>
@@ -108,6 +110,7 @@ void unregister_kprobe(struct kprobe *p)
 
 static struct notifier_block kprobe_exceptions_nb = {
 	.notifier_call = kprobe_exceptions_notify,
+	.priority = 0x7fffffff /* we need to notified first */
 };
 
 int register_jprobe(struct jprobe *jp)
diff -puN arch/x86_64/kernel/traps.c~kprobes-exceptions-notifier-fix arch/x86_64/kernel/traps.c
--- linux-2.6.9-rc2/arch/x86_64/kernel/traps.c~kprobes-exceptions-notifier-fix	2004-09-27 11:55:57.000000000 +0530
+++ linux-2.6.9-rc2-prasanna/arch/x86_64/kernel/traps.c	2004-09-27 11:55:57.000000000 +0530
@@ -440,7 +440,8 @@ static void do_trap(int trapnr, int sign
 #define DO_ERROR(trapnr, signr, str, name) \
 asmlinkage void do_##name(struct pt_regs * regs, long error_code) \
 { \
-	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) == NOTIFY_BAD) \
+	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) \
+							== NOTIFY_STOP) \
 		return; \
 	do_trap(trapnr, signr, str, regs, error_code, NULL); \
 }
@@ -453,7 +454,8 @@ asmlinkage void do_##name(struct pt_regs
 	info.si_errno = 0; \
 	info.si_code = sicode; \
 	info.si_addr = (void __user *)siaddr; \
-	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) == NOTIFY_BAD) \
+	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) \
+							== NOTIFY_STOP) \
 		return; \
 	do_trap(trapnr, signr, str, regs, error_code, &info); \
 }
@@ -474,7 +476,8 @@ DO_ERROR(18, SIGSEGV, "reserved", reserv
 asmlinkage void *do_##name(struct pt_regs * regs, long error_code) \
 { \
 	struct pt_regs *pr = ((struct pt_regs *)(current->thread.rsp0))-1; \
-	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) == NOTIFY_BAD) \
+	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) \
+							== NOTIFY_STOP) \
 		return regs; \
 	if (regs->cs & 3) { \
 		memcpy(pr, regs, sizeof(struct pt_regs)); \
@@ -568,7 +571,8 @@ asmlinkage void default_do_nmi(struct pt
 	unsigned char reason = inb(0x61);
 
 	if (!(reason & 0xc0)) {
-		if (notify_die(DIE_NMI_IPI, "nmi_ipi", regs, reason, 0, SIGINT) == NOTIFY_BAD)
+		if (notify_die(DIE_NMI_IPI, "nmi_ipi", regs, reason, 0, SIGINT)
+								== NOTIFY_STOP)
 			return;
 #ifdef CONFIG_X86_LOCAL_APIC
 		/*
@@ -583,7 +587,7 @@ asmlinkage void default_do_nmi(struct pt
 		unknown_nmi_error(reason, regs);
 		return;
 	}
-	if (notify_die(DIE_NMI, "nmi", regs, reason, 0, SIGINT) == NOTIFY_BAD)
+	if (notify_die(DIE_NMI, "nmi", regs, reason, 0, SIGINT) == NOTIFY_STOP)
 		return; 
 	if (reason & 0x80)
 		mem_parity_error(reason, regs);
@@ -679,7 +683,7 @@ clear_TF_reenable:
 clear_TF:
 	/* RED-PEN could cause spurious errors */
 	if (notify_die(DIE_DEBUG, "debug2", regs, condition, 1, SIGTRAP) 
-	    != NOTIFY_BAD)
+								!= NOTIFY_STOP)
 	regs->eflags &= ~TF_MASK;
 	return regs;	
 }
diff -puN arch/x86_64/kernel/nmi.c~kprobes-exceptions-notifier-fix arch/x86_64/kernel/nmi.c
--- linux-2.6.9-rc2/arch/x86_64/kernel/nmi.c~kprobes-exceptions-notifier-fix	2004-09-27 11:55:57.000000000 +0530
+++ linux-2.6.9-rc2-prasanna/arch/x86_64/kernel/nmi.c	2004-09-27 11:55:57.000000000 +0530
@@ -390,7 +390,8 @@ void nmi_watchdog_tick (struct pt_regs *
 		 */
 		alert_counter[cpu]++;
 		if (alert_counter[cpu] == 5*nmi_hz) {
-			if (notify_die(DIE_NMI, "nmi", regs, reason, 2, SIGINT) == NOTIFY_BAD) { 
+			if (notify_die(DIE_NMI, "nmi", regs, reason, 2, SIGINT)
+							== NOTIFY_STOP) {
 				alert_counter[cpu] = 0; 
 				return;
 			} 
diff -puN arch/x86_64/kernel/kgdb_stub.c~kprobes-exceptions-notifier-fix arch/x86_64/kernel/kgdb_stub.c
--- linux-2.6.9-rc2/arch/x86_64/kernel/kgdb_stub.c~kprobes-exceptions-notifier-fix	2004-09-27 11:55:57.000000000 +0530
+++ linux-2.6.9-rc2-prasanna/arch/x86_64/kernel/kgdb_stub.c	2004-09-27 11:55:57.000000000 +0530
@@ -2197,9 +2197,9 @@ static int kgdb_notify(struct notifier_b
 		return NOTIFY_DONE;
 	if (cmd == DIE_NMI_IPI) {
 		if (in_kgdb(d->regs))
-			return NOTIFY_BAD;
+			return NOTIFY_STOP;
 	} else if (kgdb_handle_exception(d->trapnr, d->signr, d->err, d->regs))
-		return NOTIFY_BAD; /* skip */
+		return NOTIFY_STOP; /* skip */
 
 	return NOTIFY_DONE;
 }
diff -puN arch/sparc64/kernel/kprobes.c~kprobes-exceptions-notifier-fix arch/sparc64/kernel/kprobes.c
--- linux-2.6.9-rc2/arch/sparc64/kernel/kprobes.c~kprobes-exceptions-notifier-fix	2004-09-27 11:55:57.000000000 +0530
+++ linux-2.6.9-rc2-prasanna/arch/sparc64/kernel/kprobes.c	2004-09-27 11:55:57.000000000 +0530
@@ -179,26 +179,26 @@ int kprobe_exceptions_notify(struct noti
 	switch (val) {
 	case DIE_DEBUG:
 		if (kprobe_handler(args->regs))
-			return NOTIFY_OK;
+			return NOTIFY_STOP;
 		break;
 	case DIE_DEBUG_2:
 		if (post_kprobe_handler(args->regs))
-			return NOTIFY_OK;
+			return NOTIFY_STOP;
 		break;
 	case DIE_GPF:
 		if (kprobe_running() &&
 		    kprobe_fault_handler(args->regs, args->trapnr))
-			return NOTIFY_OK;
+			return NOTIFY_STOP;
 		break;
 	case DIE_PAGE_FAULT:
 		if (kprobe_running() &&
 		    kprobe_fault_handler(args->regs, args->trapnr))
-			return NOTIFY_OK;
+			return NOTIFY_STOP;
 		break;
 	default:
 		break;
 	}
-	return NOTIFY_BAD;
+	return NOTIFY_DONE;
 }
 
 asmlinkage void kprobe_trap(unsigned long trap_level, struct pt_regs *regs)
@@ -216,7 +216,7 @@ asmlinkage void kprobe_trap(unsigned lon
 	 */
 	if (notify_die((trap_level == 0x170) ? DIE_DEBUG : DIE_DEBUG_2,
 		       (trap_level == 0x170) ? "debug" : "debug_2",
-		       regs, 0, trap_level, SIGTRAP) != NOTIFY_OK)
+		       regs, 0, trap_level, SIGTRAP) != NOTIFY_STOP)
 		bad_trap(regs, trap_level);
 }
 
diff -puN arch/sparc64/kernel/traps.c~kprobes-exceptions-notifier-fix arch/sparc64/kernel/traps.c
--- linux-2.6.9-rc2/arch/sparc64/kernel/traps.c~kprobes-exceptions-notifier-fix	2004-09-27 11:55:57.000000000 +0530
+++ linux-2.6.9-rc2-prasanna/arch/sparc64/kernel/traps.c	2004-09-27 11:55:57.000000000 +0530
@@ -96,7 +96,7 @@ void bad_trap(struct pt_regs *regs, long
 	siginfo_t info;
 
 	if (notify_die(DIE_TRAP, "bad trap", regs,
-		       0, lvl, SIGTRAP) == NOTIFY_OK)
+		       0, lvl, SIGTRAP) == NOTIFY_STOP)
 		return;
 
 	if (lvl < 0x100) {
@@ -126,7 +126,7 @@ void bad_trap_tl1(struct pt_regs *regs, 
 	char buffer[32];
 	
 	if (notify_die(DIE_TRAP_TL1, "bad trap tl1", regs,
-		       0, lvl, SIGTRAP) == NOTIFY_OK)
+		       0, lvl, SIGTRAP) == NOTIFY_STOP)
 		return;
 
 	dump_tl1_traplog((struct tl1_traplog *)(regs + 1));
@@ -149,7 +149,7 @@ void instruction_access_exception(struct
 	siginfo_t info;
 
 	if (notify_die(DIE_TRAP, "instruction access exception", regs,
-		       0, 0x8, SIGTRAP) == NOTIFY_OK)
+		       0, 0x8, SIGTRAP) == NOTIFY_STOP)
 		return;
 
 	if (regs->tstate & TSTATE_PRIV) {
@@ -173,7 +173,7 @@ void instruction_access_exception_tl1(st
 				      unsigned long sfsr, unsigned long sfar)
 {
 	if (notify_die(DIE_TRAP_TL1, "instruction access exception tl1", regs,
-		       0, 0x8, SIGTRAP) == NOTIFY_OK)
+		       0, 0x8, SIGTRAP) == NOTIFY_STOP)
 		return;
 
 	dump_tl1_traplog((struct tl1_traplog *)(regs + 1));
@@ -186,7 +186,7 @@ void data_access_exception(struct pt_reg
 	siginfo_t info;
 
 	if (notify_die(DIE_TRAP, "data access exception", regs,
-		       0, 0x30, SIGTRAP) == NOTIFY_OK)
+		       0, 0x30, SIGTRAP) == NOTIFY_STOP)
 		return;
 
 	if (regs->tstate & TSTATE_PRIV) {
@@ -260,7 +260,7 @@ void do_iae(struct pt_regs *regs)
 	spitfire_clean_and_reenable_l1_caches();
 
 	if (notify_die(DIE_TRAP, "instruction access exception", regs,
-		       0, 0x8, SIGTRAP) == NOTIFY_OK)
+		       0, 0x8, SIGTRAP) == NOTIFY_STOP)
 		return;
 
 	info.si_signo = SIGBUS;
@@ -292,7 +292,7 @@ void do_dae(struct pt_regs *regs)
 	spitfire_clean_and_reenable_l1_caches();
 
 	if (notify_die(DIE_TRAP, "data access exception", regs,
-		       0, 0x30, SIGTRAP) == NOTIFY_OK)
+		       0, 0x30, SIGTRAP) == NOTIFY_STOP)
 		return;
 
 	info.si_signo = SIGBUS;
@@ -1695,7 +1695,7 @@ void do_fpe_common(struct pt_regs *regs)
 void do_fpieee(struct pt_regs *regs)
 {
 	if (notify_die(DIE_TRAP, "fpu exception ieee", regs,
-		       0, 0x24, SIGFPE) == NOTIFY_OK)
+		       0, 0x24, SIGFPE) == NOTIFY_STOP)
 		return;
 
 	do_fpe_common(regs);
@@ -1709,7 +1709,7 @@ void do_fpother(struct pt_regs *regs)
 	int ret = 0;
 
 	if (notify_die(DIE_TRAP, "fpu exception other", regs,
-		       0, 0x25, SIGFPE) == NOTIFY_OK)
+		       0, 0x25, SIGFPE) == NOTIFY_STOP)
 		return;
 
 	switch ((current_thread_info()->xfsr[0] & 0x1c000)) {
@@ -1728,7 +1728,7 @@ void do_tof(struct pt_regs *regs)
 	siginfo_t info;
 
 	if (notify_die(DIE_TRAP, "tagged arithmetic overflow", regs,
-		       0, 0x26, SIGEMT) == NOTIFY_OK)
+		       0, 0x26, SIGEMT) == NOTIFY_STOP)
 		return;
 
 	if (regs->tstate & TSTATE_PRIV)
@@ -1750,7 +1750,7 @@ void do_div0(struct pt_regs *regs)
 	siginfo_t info;
 
 	if (notify_die(DIE_TRAP, "integer division by zero", regs,
-		       0, 0x28, SIGFPE) == NOTIFY_OK)
+		       0, 0x28, SIGFPE) == NOTIFY_STOP)
 		return;
 
 	if (regs->tstate & TSTATE_PRIV)
@@ -1936,7 +1936,7 @@ void do_illegal_instruction(struct pt_re
 	siginfo_t info;
 
 	if (notify_die(DIE_TRAP, "illegal instruction", regs,
-		       0, 0x10, SIGILL) == NOTIFY_OK)
+		       0, 0x10, SIGILL) == NOTIFY_STOP)
 		return;
 
 	if (tstate & TSTATE_PRIV)
@@ -1965,7 +1965,7 @@ void mem_address_unaligned(struct pt_reg
 	siginfo_t info;
 
 	if (notify_die(DIE_TRAP, "memory address unaligned", regs,
-		       0, 0x34, SIGSEGV) == NOTIFY_OK)
+		       0, 0x34, SIGSEGV) == NOTIFY_STOP)
 		return;
 
 	if (regs->tstate & TSTATE_PRIV) {
@@ -1991,7 +1991,7 @@ void do_privop(struct pt_regs *regs)
 	siginfo_t info;
 
 	if (notify_die(DIE_TRAP, "privileged operation", regs,
-		       0, 0x11, SIGILL) == NOTIFY_OK)
+		       0, 0x11, SIGILL) == NOTIFY_STOP)
 		return;
 
 	if (test_thread_flag(TIF_32BIT)) {
diff -puN arch/sparc64/mm/fault.c~kprobes-exceptions-notifier-fix arch/sparc64/mm/fault.c
--- linux-2.6.9-rc2/arch/sparc64/mm/fault.c~kprobes-exceptions-notifier-fix	2004-09-27 11:55:57.000000000 +0530
+++ linux-2.6.9-rc2-prasanna/arch/sparc64/mm/fault.c	2004-09-27 11:55:57.000000000 +0530
@@ -149,7 +149,7 @@ static void unhandled_fault(unsigned lon
 	       (tsk->mm ? (unsigned long) tsk->mm->pgd :
 		          (unsigned long) tsk->active_mm->pgd));
 	if (notify_die(DIE_GPF, "general protection fault", regs,
-		       0, 0, SIGSEGV) == NOTIFY_OK)
+		       0, 0, SIGSEGV) == NOTIFY_STOP)
 		return;
 	die_if_kernel("Oops", regs);
 }
@@ -325,7 +325,7 @@ asmlinkage void do_sparc64_fault(struct 
 	fault_code = get_thread_fault_code();
 
 	if (notify_die(DIE_PAGE_FAULT, "page_fault", regs,
-		       fault_code, 0, SIGSEGV) == NOTIFY_OK)
+		       fault_code, 0, SIGSEGV) == NOTIFY_STOP)
 		return;
 
 	si_code = SEGV_MAPERR;

_

--EVF5PPMfhYS0aIcm--
