Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268088AbUHKQOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268088AbUHKQOq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 12:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268085AbUHKQOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 12:14:45 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:60320 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268091AbUHKQNS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 12:13:18 -0400
Date: Wed, 11 Aug 2004 21:45:54 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org, ak@muc.de, akpm@osdl.org,
       suparna@in.ibm.com, shemminger@osdl.org
Cc: prasanna@in.ibm.com
Subject: [3/4] Jumper Probes patch to provide function arguments
Message-ID: <20040811161554.GE24460@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mvpLiMfbWzRoNl4x"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Below is [3/4] kprobes-func-args-268-rc4.patch.

A special kprobe type which can be placed on function entry points,
and employs a simple mirroring principle to allow seamless access
to the arguments of a function being probed. The probe handler
routine should have the same prototype as the function being probed.
Currently implemented for x86.

Your comments are welcome!

Thanks
Prasanna
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>

--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kprobes-func-args-268-rc4.patch"


A special kprobe type which can be placed on function entry points,
and employs a simple mirroring principle to allow seamless access 
to the arguments of a function being probed. The probe handler 
routine should have the same prototype as the function being probed.
Currently implemented for x86.

The way it works is that when the probe is hit, the breakpoint
handler simply irets to the probe handler's eip while retaining
register and stack state corresponding to the function entry.
After it is done, the probe handler calls jprobe_return() which
traps again to restore processor state and switch back to the
probed function. Linus noted correctly at KS that we need to be 
careful as gcc assumes that the callee owns arguments. We save and
restore enough stack bytes to cover argument space.

Sample Usage:
	static int jip_queue_xmit(struct sk_buff *skb, int ipfragok)
	{
		... whatever ...
		jprobe_return();
		return 0;
	}

	struct jprobe jp = {
		{.addr = (kprobe_opcode_t *) ip_queue_xmit},
		.entry = (kprobe_opcode_t *) jip_queue_xmit
	};
	register_jprobe(&jp);

---

---



---

 linux-2.6.8-rc4-prasanna/arch/i386/kernel/kprobes.c |   77 +++++++++++++++++++-
 linux-2.6.8-rc4-prasanna/include/asm-i386/kprobes.h |    4 +
 linux-2.6.8-rc4-prasanna/include/linux/kprobes.h    |   43 ++++++++++-
 linux-2.6.8-rc4-prasanna/kernel/kprobes.c           |   19 ++++
 4 files changed, 139 insertions(+), 4 deletions(-)

diff -puN arch/i386/kernel/kprobes.c~kprobes-func-args-268-rc4 arch/i386/kernel/kprobes.c
--- linux-2.6.8-rc4/arch/i386/kernel/kprobes.c~kprobes-func-args-268-rc4	2004-08-11 21:01:31.000000000 +0530
+++ linux-2.6.8-rc4-prasanna/arch/i386/kernel/kprobes.c	2004-08-11 21:04:43.000000000 +0530
@@ -16,11 +16,13 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  *
- * Copyright (C) IBM Corporation, 2002
+ * Copyright (C) IBM Corporation, 2002, 2004
  *
  * 2002-Oct	Created by Vamsi Krishna S <vamsi_krishna@in.ibm.com> Kernel
  *		Probes initial implementation ( includes contributions from
  *		Rusty Russell).
+ * 2004-July	Suparna Bhattacharya <suparna@in.ibm.com> added jumper probes
+ *		interface to access function arguments.
  */
 
 #include <linux/config.h>
@@ -30,12 +32,17 @@
 #include <linux/preempt.h>
 #include <asm/kdebug.h>
 
+
 /* kprobe_status settings */
 #define KPROBE_HIT_ACTIVE	0x00000001
 #define KPROBE_HIT_SS		0x00000002
 
 static struct kprobe *current_kprobe;
 static unsigned long kprobe_status, kprobe_old_eflags, kprobe_saved_eflags;
+static struct pt_regs jprobe_saved_regs;
+static long *jprobe_saved_esp;
+/* copy of the kernel stack at the probe fire time */
+static kprobe_opcode_t jprobes_stack[MAX_STACK_SIZE];
 
 /*
  * returns non-zero if opcode modifies the interrupt flag.
@@ -91,6 +98,11 @@ static inline int kprobe_handler(struct 
 		if (p) {
 			disarm_kprobe(p, regs);
 			ret = 1;
+		} else {
+			p = current_kprobe;
+			if (p->break_handler && p->break_handler(p, regs)) {
+				goto ss_probe;
+			}
 		}
 		/* If it's not ours, can't be delete race, (we hold lock). */
 		goto no_kprobe;
@@ -121,8 +133,12 @@ static inline int kprobe_handler(struct 
 	if (is_IF_modifier(p->opcode))
 		kprobe_saved_eflags &= ~IF_MASK;
 
-	p->pre_handler(p, regs);
+	if (p->pre_handler(p, regs)) {
+		/* handler has already set things up, so skip ss setup */
+		return 1;
+	}
 
+      ss_probe:
 	prepare_singlestep(p, regs);
 	kprobe_status = KPROBE_HIT_SS;
 	return 1;
@@ -273,3 +289,60 @@ int kprobe_exceptions_notify(struct noti
 	}
 	return NOTIFY_BAD;
 }
+
+int setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	struct jprobe *jp = container_of(p, struct jprobe, kp);
+	jprobe_saved_regs = *regs;
+	jprobe_saved_esp = &regs->esp;
+	unsigned long addr = (unsigned long)jprobe_saved_esp;
+	/*
+	 * TBD: As Linus pointed out, gcc assumes that the callee
+	 * owns the argument space and could overwrite it, e.g.
+	 * tailcall optimization. So, to be absolutely safe
+	 * we also save and restore enough stack bytes to cover
+	 * the argument area.
+	 */
+	memcpy(jprobes_stack, (kprobe_opcode_t *) addr,
+	       MIN_STACK_SIZE(addr));
+	regs->eflags &= ~IF_MASK;
+	regs->eip = (unsigned long)(jp->entry);
+	return 1;
+}
+
+void jprobe_return(void)
+{
+	preempt_enable_no_resched();
+	asm volatile ("       xchgl   %%ebx,%%esp     \n"
+		      "       int3			\n"::"b"
+		      (jprobe_saved_esp):"memory");
+}
+void jprobe_return_end(void)
+{
+};
+
+int longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	u8 *addr = (u8 *) (regs->eip - 1);
+	unsigned long stack_addr = (unsigned long)jprobe_saved_esp;
+	struct jprobe *jp = container_of(p, struct jprobe, kp);
+
+	if ((addr > (u8 *) jprobe_return) && (addr < (u8 *) jprobe_return_end)) {
+		if (&regs->esp != jprobe_saved_esp) {
+			struct pt_regs *saved_regs =
+			    container_of(jprobe_saved_esp, struct pt_regs, esp);
+			printk("current esp %p does not match saved esp %p\n",
+			       &regs->esp, jprobe_saved_esp);
+			printk("Saved registers for jprobe %p\n", jp);
+			show_registers(saved_regs);
+			printk("Current registers\n");
+			show_registers(regs);
+			BUG();
+		}
+		*regs = jprobe_saved_regs;
+		memcpy((kprobe_opcode_t *) stack_addr, jprobes_stack,
+		       MIN_STACK_SIZE(stack_addr));
+		return 1;
+	}
+	return 0;
+}
diff -puN include/asm-i386/kprobes.h~kprobes-func-args-268-rc4 include/asm-i386/kprobes.h
--- linux-2.6.8-rc4/include/asm-i386/kprobes.h~kprobes-func-args-268-rc4	2004-08-11 21:01:31.000000000 +0530
+++ linux-2.6.8-rc4-prasanna/include/asm-i386/kprobes.h	2004-08-11 21:01:31.000000000 +0530
@@ -32,6 +32,10 @@ struct pt_regs;
 typedef u8 kprobe_opcode_t;
 #define BREAKPOINT_INSTRUCTION	0xcc
 #define MAX_INSN_SIZE 16
+#define MAX_STACK_SIZE 64
+#define MIN_STACK_SIZE(ADDR) ((((ADDR) + MAX_STACK_SIZE) <  \
+	(((ADDR) & PAGE_MASK) + PAGE_SIZE) ? ((ADDR) + MAX_STACK_SIZE) \
+	: (((ADDR) & PAGE_MASK) + PAGE_SIZE )) - (ADDR))
 
 /* trap3/1 are intr gates for kprobes.  So, restore the status of IF,
  * if necessary, before executing the original int3/1 (trap) handler.
diff -puN include/linux/kprobes.h~kprobes-func-args-268-rc4 include/linux/kprobes.h
--- linux-2.6.8-rc4/include/linux/kprobes.h~kprobes-func-args-268-rc4	2004-08-11 21:01:31.000000000 +0530
+++ linux-2.6.8-rc4-prasanna/include/linux/kprobes.h	2004-08-11 21:01:31.000000000 +0530
@@ -18,11 +18,13 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  *
- * Copyright (C) IBM Corporation, 2002
+ * Copyright (C) IBM Corporation, 2002, 2004
  *
  * 2002-Oct	Created by Vamsi Krishna S <vamsi_krishna@in.ibm.com> Kernel
  *		Probes initial implementation ( includes suggestions from
  *		Rusty Russell).
+ * 2004-July	Suparna Bhattacharya <suparna@in.ibm.com> added jumper probes
+ *		interface to access function arguments.
  */
 #include <linux/config.h>
 #include <linux/list.h>
@@ -32,7 +34,8 @@
 
 struct kprobe;
 struct pt_regs;
-typedef void (*kprobe_pre_handler_t) (struct kprobe *, struct pt_regs *);
+typedef int (*kprobe_pre_handler_t) (struct kprobe *, struct pt_regs *);
+typedef int (*kprobe_break_handler_t) (struct kprobe *, struct pt_regs *);
 typedef void (*kprobe_post_handler_t) (struct kprobe *, struct pt_regs *,
 				       unsigned long flags);
 typedef int (*kprobe_fault_handler_t) (struct kprobe *, struct pt_regs *,
@@ -53,6 +56,10 @@ struct kprobe {
 	 * Return 1 if it handled fault, otherwise kernel will see it. */
 	kprobe_fault_handler_t fault_handler;
 
+	/* ... called if breakpoint trap occurs in probe handler.
+	 * Return 1 if it handled break, otherwise kernel will see it. */
+	kprobe_break_handler_t break_handler;
+
 	/* Saved opcode (which has been replaced with breakpoint) */
 	kprobe_opcode_t opcode;
 
@@ -60,6 +67,21 @@ struct kprobe {
 	kprobe_opcode_t insn[MAX_INSN_SIZE];
 };
 
+/*
+ * Special probe type that uses setjmp-longjmp type tricks to resume
+ * execution at a specified entry with a matching prototype corresponding
+ * to the probed function - a trick to enable arguments to become
+ * accessible seamlessly by probe handling logic.
+ * Note:
+ * Because of the way compilers allocate stack space for local variables
+ * etc upfront, regardless of sub-scopes within a function, this mirroring
+ * principle currently works only for probes placed on function entry points.
+ */
+struct jprobe {
+	struct kprobe kp;
+	kprobe_opcode_t *entry;	/* probe handling code to jump to */
+};
+
 #ifdef CONFIG_KPROBES
 /* Locks kprobe: irq must be disabled */
 void lock_kprobes(void);
@@ -73,12 +95,19 @@ static inline int kprobe_running(void)
 }
 
 extern void arch_prepare_kprobe(struct kprobe *p);
+extern void show_registers(struct pt_regs *regs);
 
 /* Get the kprobe at this addr (if any).  Must have called lock_kprobes */
 struct kprobe *get_kprobe(void *addr);
 
 int register_kprobe(struct kprobe *p);
 void unregister_kprobe(struct kprobe *p);
+int setjmp_pre_handler(struct kprobe *, struct pt_regs *);
+int longjmp_break_handler(struct kprobe *, struct pt_regs *);
+int register_jprobe(struct jprobe *p);
+void unregister_jprobe(struct jprobe *p);
+void jprobe_return(void);
+
 #else
 static inline int kprobe_running(void)
 {
@@ -91,5 +120,15 @@ static inline int register_kprobe(struct
 static inline void unregister_kprobe(struct kprobe *p)
 {
 }
+static inline int register_jprobe(struct jprobe *p)
+{
+	return -ENOSYS;
+}
+static inline void unregister_jprobe(struct jprobe *p)
+{
+}
+static inline void jprobe_return(void)
+{
+}
 #endif
 #endif				/* _LINUX_KPROBES_H */
diff -puN kernel/kprobes.c~kprobes-func-args-268-rc4 kernel/kprobes.c
--- linux-2.6.8-rc4/kernel/kprobes.c~kprobes-func-args-268-rc4	2004-08-11 21:01:31.000000000 +0530
+++ linux-2.6.8-rc4-prasanna/kernel/kprobes.c	2004-08-11 21:01:31.000000000 +0530
@@ -23,6 +23,8 @@
  *		Rusty Russell).
  * 2004-Aug	Updated by Prasanna S Panchamukhi <prasanna@in.ibm.com> with
  *		hlists and exceptions notifier as suggested by Andi Kleen.
+ * 2004-July	Suparna Bhattacharya <suparna@in.ibm.com> added jumper probes
+ *		interface to access function arguments.
  */
 #include <linux/kprobes.h>
 #include <linux/spinlock.h>
@@ -106,6 +108,20 @@ static struct notifier_block kprobe_exce
 	.notifier_call = kprobe_exceptions_notify,
 };
 
+int register_jprobe(struct jprobe *jp)
+{
+	/* Todo: Verify probepoint is a function entry point */
+	jp->kp.pre_handler = setjmp_pre_handler;
+	jp->kp.break_handler = longjmp_break_handler;
+
+	return register_kprobe(&jp->kp);
+}
+
+void unregister_jprobe(struct jprobe *jp)
+{
+	unregister_kprobe(&jp->kp);
+}
+
 static int __init init_kprobes(void)
 {
 	int i, err = 0;
@@ -123,3 +139,6 @@ __initcall(init_kprobes);
 
 EXPORT_SYMBOL_GPL(register_kprobe);
 EXPORT_SYMBOL_GPL(unregister_kprobe);
+EXPORT_SYMBOL_GPL(register_jprobe);
+EXPORT_SYMBOL_GPL(unregister_jprobe);
+EXPORT_SYMBOL_GPL(jprobe_return);

_

--mvpLiMfbWzRoNl4x--
