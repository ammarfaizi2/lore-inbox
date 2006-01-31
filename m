Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030244AbWAaAm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbWAaAm3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 19:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbWAaAm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 19:42:29 -0500
Received: from mail7.hitachi.co.jp ([133.145.228.42]:3732 "EHLO
	mail7.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S1030244AbWAaAm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 19:42:28 -0500
Message-ID: <43DEB290.1050000@sdl.hitachi.co.jp>
Date: Tue, 31 Jan 2006 09:42:56 +0900
From: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>
CC: SystemTAP <systemtap@sources.redhat.com>,
       Jim Keniston <jkenisto@us.ibm.com>, linux-kernel@vger.kernel.org,
       Yumiko Sugita <sugita@sdl.hitachi.co.jp>,
       Satoshi Oshima <soshima@redhat.com>, Hideo Aoki <haoki@redhat.com>
Subject: Re: [PATCH][2/2] kprobe: kprobe-booster against 2.6.16-rc1 for i386
References: <43DE0A4D.20908@sdl.hitachi.co.jp>
In-Reply-To: <43DE0A4D.20908@sdl.hitachi.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I took a single mistake

Masami Hiramatsu wrote:
> @@ -240,6 +291,21 @@ static int __kprobes kprobe_handler(stru
>  		/* handler has already set things up, so skip ss setup */
>  		return 1;
> 
> +	if (p->ainsn.boostable == 1 &&
> +#ifdef CONFIG_PREEMPT
> +	    !(pre_preempt_count()) && /*

This should be;
> +	    !(pre_preempt_count) && /*

And I attach a fixed patch in this mail.

> +				       * This enables booster when the direct
> +				       * execution path aren't preempted.
> +				       */
> +#endif /* CONFIG_PREEMPT */
> +	    !p->post_handler && !p->break_handler ) {
> +		/* Boost up -- we can execute copied instructions directly */
> +		reset_current_kprobe();
> +		regs->eip = (unsigned long)&p->ainsn.insn;
> +		preempt_enable_no_resched();
> +		return 1;
> +	}
> +
>  ss_probe:
>  	prepare_singlestep(p, regs);
>  	kcb->kprobe_status = KPROBE_HIT_SS;
> @@ -345,6 +411,8 @@ int __kprobes trampoline_probe_handler(s


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
--- a/arch/i386/kernel/kprobes.c	2006-01-24 22:43:17.000000000 +0900
+++ b/arch/i386/kernel/kprobes.c	2006-01-24 23:12:23.000000000 +0900
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
@@ -60,6 +103,11 @@ int __kprobes arch_prepare_kprobe(struct
 {
 	memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
 	p->opcode = *p->addr;
+	if (can_boost(p->opcode)) {
+		p->ainsn.boostable = 0;
+	} else {
+		p->ainsn.boostable = -1;
+	}
 	return 0;
 }

@@ -146,6 +194,9 @@ static int __kprobes kprobe_handler(stru
 	kprobe_opcode_t *addr = NULL;
 	unsigned long *lp;
 	struct kprobe_ctlblk *kcb;
+#ifdef CONFIG_PREEMPT
+	unsigned pre_preempt_count = preempt_count();
+#endif /* CONFIG_PREEMPT */

 	/*
 	 * We don't want to be preempted for the entire
@@ -240,6 +291,21 @@ static int __kprobes kprobe_handler(stru
 		/* handler has already set things up, so skip ss setup */
 		return 1;

+	if (p->ainsn.boostable == 1 &&
+#ifdef CONFIG_PREEMPT
+	    !(pre_preempt_count) && /*
+				       * This enables booster when the direct
+				       * execution path aren't preempted.
+				       */
+#endif /* CONFIG_PREEMPT */
+	    !p->post_handler && !p->break_handler ) {
+		/* Boost up -- we can execute copied instructions directly */
+		reset_current_kprobe();
+		regs->eip = (unsigned long)&p->ainsn.insn;
+		preempt_enable_no_resched();
+		return 1;
+	}
+
 ss_probe:
 	prepare_singlestep(p, regs);
 	kcb->kprobe_status = KPROBE_HIT_SS;
@@ -345,6 +411,8 @@ int __kprobes trampoline_probe_handler(s
  * 2) If the single-stepped instruction was a call, the return address
  * that is atop the stack is the address following the copied instruction.
  * We need to make it the address following the original instruction.
+ *
+ * This function also checks instruction size for preparing direct execution.
  */
 static void __kprobes resume_execution(struct kprobe *p,
 		struct pt_regs *regs, struct kprobe_ctlblk *kcb)
@@ -365,6 +433,7 @@ static void __kprobes resume_execution(s
 	case 0xca:
 	case 0xea:		/* jmp absolute -- eip is correct */
 		/* eip is already adjusted, no more changes required */
+		p->ainsn.boostable = 1;
 		goto no_change;
 	case 0xe8:		/* call relative - Fix return addr */
 		*tos = orig_eip + (*tos - copy_eip);
@@ -372,18 +441,37 @@ static void __kprobes resume_execution(s
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
--- a/include/asm-i386/kprobes.h	2006-01-24 19:07:39.000000000 +0900
+++ b/include/asm-i386/kprobes.h	2006-01-24 22:54:35.000000000 +0900
@@ -31,6 +31,7 @@ struct pt_regs;

 typedef u8 kprobe_opcode_t;
 #define BREAKPOINT_INSTRUCTION	0xcc
+#define RELATIVEJUMP_INSTRUCTION 0xe9
 #define MAX_INSN_SIZE 16
 #define MAX_STACK_SIZE 64
 #define MIN_STACK_SIZE(ADDR) (((MAX_STACK_SIZE) < \
@@ -48,6 +49,11 @@ void kretprobe_trampoline(void);
 struct arch_specific_insn {
 	/* copy of the original instruction */
 	kprobe_opcode_t insn[MAX_INSN_SIZE];
+	/*
+	 * If this flag is not 0, this kprobe can be boost when its
+	 * post_handler and break_handler is not set.
+	 */
+	int boostable;
 };

 struct prev_kprobe {


