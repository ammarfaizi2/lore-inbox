Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbWB0L5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbWB0L5V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 06:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWB0L5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 06:57:21 -0500
Received: from mail4.hitachi.co.jp ([133.145.228.5]:29850 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S1751061AbWB0L5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 06:57:20 -0500
Message-ID: <4402E920.5080402@sdl.hitachi.co.jp>
Date: Mon, 27 Feb 2006 20:57:20 +0900
From: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>
Cc: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>,
       SystemTAP <systemtap@sources.redhat.com>,
       Jim Keniston <jkenisto@us.ibm.com>, linux-kernel@vger.kernel.org,
       Yumiko Sugita <sugita@sdl.hitachi.co.jp>,
       Satoshi Oshima <soshima@redhat.com>, Hideo Aoki <haoki@redhat.com>
Subject: [PATCH][take2][2/2] kprobe: kprobe-booster against 2.6.16-rc5 for
 i386
References: <43DE0A4D.20908@sdl.hitachi.co.jp>
In-Reply-To: <43DE0A4D.20908@sdl.hitachi.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew

Here is a patch of kprobe-booster for i386 arch against linux-2.6.16-rc5.
The kprobe-booster patch is also under the influence of the NX-protection
support patch. So, I fixed that.

Could you replace the previous patches with these patches?

The description of kprobe-booster:
==================================
Current kprobe copies the original instruction at the probe
point and replaces it with a breakpoint instruction (int3).
When the kernel hits the probe point, kprobe handler is invoked.
And the copied instruction is single-step executed on the copied
buffer (not on the original address) by kprobe. After that,
the kprobe checks registers and modify it (if need) as if the
instructions was executed on the original address.

My proposal is based on the fact there are many instructions which
do NOT require the register modification after the single-step
execution. When the copied instruction is a kind of them, kprobe
just jumps back to the next instruction after single-step execution.
If so, why don't we execute those instructions directly?

With kprobe-booster patch, kprobes will execute a copied
instruction directly and (if need) jump back to original code.
This direct execution is executed when the kprobe don't have
both post_handler and break_handler, and the copied instruction
can be executed directly.

I sorted instructions which can be executed directly or not;

- Call instructions are NG(can not be executed directly).
  We should correct the return address pushed into top of stack.
- Indirect instructions except for absolute indirect-jumps
  are NG. Those instructions changes EIP randomly. We should
  check EIP and correct it.
- Instructions that change EIP beyond the range of the
  instruction buffer are NG.
- Instructions that change EIP to tail 5 bytes of the
  instruction buffer (it is the size of a jump instruction).
  We must write a jump instruction which backs to original
  kernel code in the instruction buffer.
- Break point instruction is NG. We should not touch EIP and
  pass to other handlers.
- Absolute direct/indirect jumps are OK.- Conditional Jumps are NG.
- Halt and software-interruptions are NG. Because it will stay on
  the instruction buffer of kprobes.
- Prefixes are NG.
- Unknown/reserved opcode is NG.
- Other 1 byte instructions are OK. But those instructions need a
  jump back code.
- 2 bytes instructions are mapped sparsely. So, in this release,
  this patch don't boost those instructions.

 From Intel's IA-32 opcode map described in IA-32 Intel
Architecture Software Developer's Manual Vol.2 B,
I determined that following opcodes are not boostable.

- 0FH (2byte escape)
- 70H - 7FH (Jump on condition)
- 9AH (Call) and 9CH (Pushf)
- C0H-C1H (Grp 2: includes reserved opcode)
- C6H-C7H (Grp11: includes reserved opcode)
- CCH-CEH (Software-interrupt)
- D0H-D3H (Grp2: includes reserved opcode)
- D6H (Reserved)
- D8H-DFH (Coprocessor)
- E0H-E3H (loop/conditional jump)
- E8H (Call)
- F0H-F3H (Prefixes and reserved)
- F4H (Halt)
- F6H-F7H (Grp3: includes reserved opcode)
- FEH-FFH(Grp4,5: includes reserved opcode)

Kprobe-booster checks whether target instruction can be boosted
 (can be executed directly) at arch_copy_kprobe() function.
If the target instruction can be boosted, it clears "boostable"
flag. If not, it sets "boostable" flag -1. This is disabled status.
In resume_execution() function, If "boostable" flag is cleared,
kprobe-booster measures the size of the target instruction and
sets "boostable" flag 1.

In kprobe_handler(), kprobe checks the "boostable" flag.
If the flag is 1, it resets current kprobe and executes instruction
buffer directly instead of single stepping.

When unregistering a boosted kprobe, it calls synchronize_sched()
after "int3" is removed. So we can ensure followings after
the synchronize_sched() called.
- interrupt handlers are finished on all CPUs.
- instruction buffer is not executed on all CPUs.
And we can release the boosted kprobe safely.

And also, on preemptible kernel, the booster is not enabled
where the kernel preemption is enabled. So, there are no
preempted threads on the instruction buffer.

Best Regards,

-- 
Masami HIRAMATSU
2nd Research Dept.
Hitachi, Ltd., Systems Development Laboratory
E-mail: hiramatu@sdl.hitachi.co.jp

Signed-off-by: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>

 arch/i386/kernel/kprobes.c |   92 ++++++++++++++++++++++++++++++++++++++++++++-
 include/asm-i386/kprobes.h |    6 ++
 2 files changed, 96 insertions(+), 2 deletions(-)
diff -Narup a/arch/i386/kernel/kprobes.c b/arch/i386/kernel/kprobes.c
--- a/arch/i386/kernel/kprobes.c	2006-02-27 16:30:58.000000000 +0900
+++ b/arch/i386/kernel/kprobes.c	2006-02-27 16:38:59.000000000 +0900
@@ -41,6 +41,49 @@ void jprobe_return_end(void);
 DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);

+/* insert a jmp code */
+static inline void set_jmp_op(void *from, void *to)
+{
+	struct __arch_jmp_op {
+		char op;
+		long raddr;
+	} __attribute__((packed)) *jop;
+	jop = (struct __arch_jmp_op *)from;
+	jop->raddr = (long)(to) - ((long)(from) + 5);
+	jop->op = RELATIVEJUMP_INSTRUCTION;
+}
+
+/*
+ * returns non-zero if opcodes can be boosted.
+ */
+static inline int can_boost(kprobe_opcode_t opcode)
+{
+	switch (opcode & 0xf0 ) {
+	case 0x70:
+		return 0; /* can't boost conditional jump */
+	case 0x90:
+		/* can't boost call and pushf */
+		return opcode != 0x9a && opcode != 0x9c;
+	case 0xc0:
+		/* can't boost undefined opcodes and soft-interruptions */
+		return (0xc1 < opcode && opcode < 0xc6) ||
+			(0xc7 < opcode && opcode < 0xcc) || opcode == 0xcf;
+	case 0xd0:
+		/* can boost AA* and XLAT */
+		return (opcode == 0xd4 || opcode == 0xd5 || opcode == 0xd7);
+	case 0xe0:
+		/* can boost in/out and (may be) jmps */
+		return (0xe3 < opcode && opcode != 0xe8);
+	case 0xf0:
+		/* clear and set flags can be boost */
+		return (opcode == 0xf5 || (0xf7 < opcode && opcode < 0xfe));
+	default:
+		/* currently, can't boost 2 bytes opcodes */
+		return opcode != 0x0f;
+	}
+}
+
+
 /*
  * returns non-zero if opcode modifies the interrupt flag.
  */
@@ -65,6 +108,11 @@ int __kprobes arch_prepare_kprobe(struct

 	memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
 	p->opcode = *p->addr;
+	if (can_boost(p->opcode)) {
+		p->ainsn.boostable = 0;
+	} else {
+		p->ainsn.boostable = -1;
+	}
 	return 0;
 }

@@ -158,6 +206,9 @@ static int __kprobes kprobe_handler(stru
 	kprobe_opcode_t *addr = NULL;
 	unsigned long *lp;
 	struct kprobe_ctlblk *kcb;
+#ifdef CONFIG_PREEMPT
+	unsigned pre_preempt_count = preempt_count();
+#endif /* CONFIG_PREEMPT */

 	/*
 	 * We don't want to be preempted for the entire
@@ -252,6 +303,21 @@ static int __kprobes kprobe_handler(stru
 		/* handler has already set things up, so skip ss setup */
 		return 1;

+	if (p->ainsn.boostable == 1 &&
+#ifdef CONFIG_PREEMPT
+	    !(pre_preempt_count()) && /*
+				       * This enables booster when the direct
+				       * execution path aren't preempted.
+				       */
+#endif /* CONFIG_PREEMPT */
+	    !p->post_handler && !p->break_handler ) {
+		/* Boost up -- we can execute copied instructions directly */
+		reset_current_kprobe();
+		regs->eip = (unsigned long)p->ainsn.insn;
+		preempt_enable_no_resched();
+		return 1;
+	}
+
 ss_probe:
 	prepare_singlestep(p, regs);
 	kcb->kprobe_status = KPROBE_HIT_SS;
@@ -357,6 +423,8 @@ int __kprobes trampoline_probe_handler(s
  * 2) If the single-stepped instruction was a call, the return address
  * that is atop the stack is the address following the copied instruction.
  * We need to make it the address following the original instruction.
+ *
+ * This function also checks instruction size for preparing direct execution.
  */
 static void __kprobes resume_execution(struct kprobe *p,
 		struct pt_regs *regs, struct kprobe_ctlblk *kcb)
@@ -377,6 +445,7 @@ static void __kprobes resume_execution(s
 	case 0xca:
 	case 0xea:		/* jmp absolute -- eip is correct */
 		/* eip is already adjusted, no more changes required */
+		p->ainsn.boostable = 1;
 		goto no_change;
 	case 0xe8:		/* call relative - Fix return addr */
 		*tos = orig_eip + (*tos - copy_eip);
@@ -384,18 +453,37 @@ static void __kprobes resume_execution(s
 	case 0xff:
 		if ((p->ainsn.insn[1] & 0x30) == 0x10) {
 			/* call absolute, indirect */
-			/* Fix return addr; eip is correct. */
+			/*
+			 * Fix return addr; eip is correct.
+			 * But this is not boostable
+			 */
 			*tos = orig_eip + (*tos - copy_eip);
 			goto no_change;
 		} else if (((p->ainsn.insn[1] & 0x31) == 0x20) ||	/* jmp near, absolute indirect */
 			   ((p->ainsn.insn[1] & 0x31) == 0x21)) {	/* jmp far, absolute indirect */
-			/* eip is correct. */
+			/* eip is correct. And this is boostable */
+			p->ainsn.boostable = 1;
 			goto no_change;
 		}
 	default:
 		break;
 	}

+	if (p->ainsn.boostable == 0) {
+		if ((regs->eip > copy_eip) &&
+		    (regs->eip - copy_eip) + 5 < MAX_INSN_SIZE) {
+			/*
+			 * These instructions can be executed directly if it
+			 * jumps back to correct address.
+			 */
+			set_jmp_op((void *)regs->eip,
+				   (void *)orig_eip + (regs->eip - copy_eip));
+			p->ainsn.boostable = 1;
+		} else {
+			p->ainsn.boostable = -1;
+		}
+	}
+
 	regs->eip = orig_eip + (regs->eip - copy_eip);

 no_change:
diff -Narup a/include/asm-i386/kprobes.h b/include/asm-i386/kprobes.h
--- a/include/asm-i386/kprobes.h	2006-02-27 16:21:48.000000000 +0900
+++ b/include/asm-i386/kprobes.h	2006-02-27 16:38:59.000000000 +0900
@@ -34,6 +34,7 @@ struct pt_regs;

 typedef u8 kprobe_opcode_t;
 #define BREAKPOINT_INSTRUCTION	0xcc
+#define RELATIVEJUMP_INSTRUCTION 0xe9
 #define MAX_INSN_SIZE 16
 #define MAX_STACK_SIZE 64
 #define MIN_STACK_SIZE(ADDR) (((MAX_STACK_SIZE) < \
@@ -51,6 +52,11 @@ void kretprobe_trampoline(void);
 struct arch_specific_insn {
 	/* copy of the original instruction */
 	kprobe_opcode_t *insn;
+	/*
+	 * If this flag is not 0, this kprobe can be boost when its
+	 * post_handler and break_handler is not set.
+	 */
+	int boostable;
 };

 struct prev_kprobe {


