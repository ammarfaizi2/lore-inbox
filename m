Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWA3Moc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWA3Moc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 07:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWA3Moc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 07:44:32 -0500
Received: from mail4.hitachi.co.jp ([133.145.228.5]:17052 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP id S932245AbWA3Mob
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 07:44:31 -0500
Message-ID: <43DE0A3A.4090404@sdl.hitachi.co.jp>
Date: Mon, 30 Jan 2006 21:44:42 +0900
From: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>
Cc: SystemTAP <systemtap@sources.redhat.com>,
       Jim Keniston <jkenisto@us.ibm.com>, linux-kernel@vger.kernel.org,
       Yumiko Sugita <sugita@sdl.hitachi.co.jp>,
       Satoshi Oshima <soshima@redhat.com>, Hideo Aoki <haoki@redhat.com>
Subject: [PATCH][0/2] kprobe: kprobe-booster against 2.6.16-rc1 for i386
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew

I would like to propose the kprobe-booster and kretprobe-booster
to reduce overhead of kprobes and kretprobes.
They have already been discussed on the SystemTap ML.

I send a couple of patches of kprobe-booster and a patch of
kretprobe-booster in next mails.
These patches are against 2.6.16-rc1 and can be applied against
2.6.16-rc1-mm4.

Here are the descriptions of kprobe-booster and kretprobe-booster.

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


The description of kretprobe-booster:
====================================
In the normal operation, kretprobe make a target function return
to trampoline code. And a kprobe (called trampoline_probe) have
been inserted at the trampoline code. When the kernel hits this
kprobe, it calls kretprobe's handler and it returns to original return
address.

Kretprobe-booster patch removes the trampoline_probe. It allows
the tranpoline code to call kretprobe's handler directly instead of
invoking kprobe. And tranpoline code returns to original return
address.

This new tranpoline code stores and restores registers, so the kretprobe
handler is still able to access those registers.

Best Regards,

-- 
Masami HIRAMATSU
2nd Research Dept.
Hitachi, Ltd., Systems Development Laboratory
E-mail: hiramatu@sdl.hitachi.co.jp

