Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267613AbUHEJVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267613AbUHEJVm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 05:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267614AbUHEJVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 05:21:42 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:28071 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267613AbUHEJVI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 05:21:08 -0400
Date: Thu, 5 Aug 2004 14:54:00 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org, ak@muc.de, akpm@osdl.org,
       suparna@in.ibm.com
Subject: [1/3] kprobes-func-args-268-rc3.patch
Message-ID: <20040805092400.GA2303@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Below is the [1/3] kprobes-func-args-268-rc3.patch patch.

Please see the description of the patch for more details. 

Your comments are welcome!


Thanks 
prasanna

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>

--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kprobes-func-args-268-rc3.patch"


From: Suparna Bhattacharya <suparna@in.ibm.com>

DESC
Jumper Kernel Probes to access function arguments
EDESC

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
careful as gcc assumes that the callee owns arguments. For the
time being we try to avoid tailcalls in the probe function; in 
the long run we should probably also save and restore enough 
stack bytes to cover argument space.

Sample Usage:
	static int jip_queue_xmit(struct sk_buff *skb, int ipfragok)
	{
		... whatever ...
		jprobe_return();
		/*No tailcalls please */
		return 0;
	}

	struct jprobe jp = {
		{.addr = (kprobe_opcode_t *) ip_queue_xmit},
		.entry = (kprobe_opcode_t *) jip_queue_xmit
	};
	register_jprobe(&jp);

---



---


diff -puN arch/i386/kernel/kprobes.c~kprobes-func-args-268-rc3 arch/i386/kernel/kprobes.c
--- linux-2.6.8-rc3/arch/i386/kernel/kprobes.c~kprobes-func-args-268-rc3	2004-08-06 04:38:38.991377216 -0700
+++ linux-2.6.8-rc3-root/arch/i386/kernel/kprobes.c	2004-08-06 04:38:39.008374632 -0700
@@ -16,11 +16,13 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  *
- * Copyright (C) IBM Corporation, 2002
+ * Copyright (C) IBM Corporation, 2002, 2004
  *
  * 2002 	Created by Vamsi Krishna S <vamsi_krishna@in.ibm.com> Kernel
  *		Probes initial implementation ( includes contributions from
  *		Rusty Russell).
+ * 2004-July	Suparna Bhattacharya <suparna@in.ibm.com> added jumper probes
+ *		interface to access function arguments.
  */
 
 #include <linux/config.h>
@@ -28,6 +30,7 @@
 #include <linux/ptrace.h>
 #include <linux/spinlock.h>
 #include <linux/preempt.h>
+#include <linux/module.h>
 
 /* kprobe_status settings */
 #define KPROBE_HIT_ACTIVE	0x00000001
@@ -35,6 +38,9 @@
 
 static struct kprobe *current_kprobe;
 static unsigned long kprobe_status, kprobe_old_eflags, kprobe_saved_eflags;
+static struct pt_regs kprobe_saved_regs;
+static long *kprobe_saved_esp;
+extern void show_registers(struct pt_regs *regs);
 
 /*
  * returns non-zero if opcode modifies the interrupt flag.
@@ -90,6 +96,11 @@ int kprobe_handler(struct pt_regs *regs)
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
@@ -113,8 +124,12 @@ int kprobe_handler(struct pt_regs *regs)
 	if(is_IF_modifier(p->opcode))
 		kprobe_saved_eflags &= ~IF_MASK;
 
-	p->pre_handler(p, regs);
+	if (p->pre_handler(p, regs)) {
+		/* handler has already set things up, so skip ss setup */
+		return 1;
+	}
 
+ss_probe:
 	prepare_singlestep(p, regs);
 	kprobe_status = KPROBE_HIT_SS;
 	return 1;
@@ -220,3 +235,59 @@ int kprobe_fault_handler(struct pt_regs 
 	}
 	return 0;
 }
+
+int setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	struct jprobe *jp = container_of(p, struct jprobe, kp);
+
+	kprobe_saved_regs = *regs;
+	kprobe_saved_esp = &regs->esp;
+	/*
+	 * TBD: As Linus pointed out, gcc assumes that the callee
+	 * owns the argument space and could overwrite it, e.g.
+	 * tailcall optimization. So, to be absolutely safe
+	 * should we also save and restore enough stack bytes
+	 * to cover the argument area ? For the time being, we
+	 * just warn against tailcalls in jprobe handlers and
+	 * hope for the best.
+	 */
+	regs->eflags &= ~IF_MASK;
+	regs->eip = (unsigned long)(jp->entry);
+	return 1;
+}
+
+void jprobe_return(void)
+{
+	preempt_enable_no_resched();
+	asm volatile(
+		"       xchgl   %%ebx,%%esp     \n"
+		"       int3			\n"
+		: : "b"(kprobe_saved_esp) : "memory");
+}
+void jprobe_return_end(void) {};
+
+EXPORT_SYMBOL_GPL(jprobe_return);
+
+int longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	u8 *addr = (u8 *)(regs->eip-1);
+
+	if ((addr > (u8 *)jprobe_return) && (addr < (u8 *)jprobe_return_end)) {
+		if (&regs->esp != kprobe_saved_esp) {
+			struct pt_regs *saved_regs = container_of(
+				kprobe_saved_esp, struct pt_regs, esp);
+			struct jprobe *jp = container_of(p, struct jprobe, kp);
+
+			printk("current esp %p does not match saved esp %p\n",
+				&regs->esp, kprobe_saved_esp);
+			printk("Saved registers for jprobe %p\n", jp);
+			show_registers(saved_regs);
+			printk("Current registers\n");
+			show_registers(regs);
+			BUG();
+		}
+		*regs = kprobe_saved_regs;
+		return 1;
+	}
+	return 0;
+}
diff -puN include/linux/kprobes.h~kprobes-func-args-268-rc3 include/linux/kprobes.h
--- linux-2.6.8-rc3/include/linux/kprobes.h~kprobes-func-args-268-rc3	2004-08-06 04:38:38.995376608 -0700
+++ linux-2.6.8-rc3-root/include/linux/kprobes.h	2004-08-06 04:38:39.009374480 -0700
@@ -18,11 +18,13 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  *
- * Copyright (C) IBM Corporation, 2002
+ * Copyright (C) IBM Corporation, 2002, 2004
  *
  * 2002 	Created by Vamsi Krishna S <vamsi_krishna@in.ibm.com> Kernel
  *		Probes initial implementation ( includes suggestions from
  *		Rusty Russell).
+ * 2004-July	Suparna Bhattacharya <suparna@in.ibm.com> added jumper probes
+ *		interface to access function arguments.
  */
 #include <linux/config.h>
 #include <linux/list.h>
@@ -33,7 +35,8 @@
 struct kprobe;
 struct pt_regs;
 
-typedef void (*kprobe_pre_handler_t)(struct kprobe *, struct pt_regs *);
+typedef int (*kprobe_pre_handler_t)(struct kprobe *, struct pt_regs *);
+typedef int (*kprobe_break_handler_t)(struct kprobe *, struct pt_regs *);
 typedef void (*kprobe_post_handler_t)(struct kprobe *, struct pt_regs *,
 				      unsigned long flags);
 typedef int (*kprobe_fault_handler_t)(struct kprobe *, struct pt_regs *,
@@ -54,6 +57,10 @@ struct kprobe {
 	  * Return 1 if it handled fault, otherwise kernel will see it. */
 	kprobe_fault_handler_t fault_handler;
 
+	 /* ... called if breakpoint trap occurs in probe handler.
+	  * Return 1 if it handled break, otherwise kernel will see it. */
+	kprobe_break_handler_t break_handler;
+
 	/* Saved opcode (which has been replaced with breakpoint) */
 	kprobe_opcode_t opcode;
 
@@ -61,6 +68,21 @@ struct kprobe {
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
+	kprobe_opcode_t *entry; /* probe handling code to jump to */
+};
+
 #ifdef CONFIG_KPROBES
 /* Locks kprobe: irq must be disabled */
 void lock_kprobes(void);
@@ -80,9 +102,18 @@ struct kprobe *get_kprobe(void *addr);
 
 int register_kprobe(struct kprobe *p);
 void unregister_kprobe(struct kprobe *p);
+
+int setjmp_pre_handler(struct kprobe *, struct pt_regs *);
+int longjmp_break_handler(struct kprobe *, struct pt_regs *);
+int register_jprobe(struct jprobe *p);
+void unregister_jprobe(struct jprobe *p);
+void jprobe_return(void);
 #else
 static inline int kprobe_running(void) { return 0; }
 static inline int register_kprobe(struct kprobe *p) { return -ENOSYS; }
 static inline void unregister_kprobe(struct kprobe *p) { }
+static inline int register_jprobe(struct jprobe *p) { return -ENOSYS; }
+static inline void unregister_jprobe(struct jprobe *p) { }
+static inline void jprobe_return(void) { }
 #endif
 #endif /* _LINUX_KPROBES_H */
diff -puN kernel/kprobes.c~kprobes-func-args-268-rc3 kernel/kprobes.c
--- linux-2.6.8-rc3/kernel/kprobes.c~kprobes-func-args-268-rc3	2004-08-06 04:38:38.999376000 -0700
+++ linux-2.6.8-rc3-root/kernel/kprobes.c	2004-08-06 04:38:39.010374328 -0700
@@ -16,11 +16,13 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  *
- * Copyright (C) IBM Corporation, 2002
+ * Copyright (C) IBM Corporation, 2002, 2004
  *
  * 2002		Created by Vamsi Krishna S <vamsi_krishna@in.ibm.com> Kernel
  *              Probes initial implementation (includes suggestions from
  *              Rusty Russell).
+ * 2004-July	Suparna Bhattacharya <suparna@in.ibm.com> added jumper probes
+ *		interface to access function arguments.
  */
 #include <linux/kprobes.h>
 #include <linux/spinlock.h>
@@ -94,6 +96,20 @@ void unregister_kprobe(struct kprobe *p)
 	spin_unlock_irq(&kprobe_lock);
 }
 
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
 	int i;
@@ -109,3 +125,5 @@ __initcall(init_kprobes);
 
 EXPORT_SYMBOL_GPL(register_kprobe);
 EXPORT_SYMBOL_GPL(unregister_kprobe);
+EXPORT_SYMBOL_GPL(register_jprobe);
+EXPORT_SYMBOL_GPL(unregister_jprobe);

_

--tKW2IUtsqtDRztdT--
