Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263781AbUFBSA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263781AbUFBSA7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 14:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbUFBR6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 13:58:47 -0400
Received: from whitehorse.blackwire.com ([199.247.156.30]:42368 "HELO
	whitehorse.blackwire.com") by vger.kernel.org with SMTP
	id S263784AbUFBRyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 13:54:21 -0400
From: pjordan@whitehorse.blackwire.com
Date: Wed, 2 Jun 2004 10:53:22 -0700
To: linux-kernel@vger.kernel.org
Subject: kernel_unaligned_trap_fault -> undefined - sparc64
Message-ID: <20040602175322.GA21878@panama>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  LD      .tmp_vmlinux1
arch/sparc64/kernel/built-in.o(__ex_table+0x3c4): undefined reference to `kernel_unaligned_trap_fault'
arch/sparc64/kernel/built-in.o(__ex_table+0x3cc): undefined reference to `kernel_unaligned_trap_fault'
arch/sparc64/kernel/built-in.o(__ex_table+0x3d4): undefined reference to `kernel_unaligned_trap_fault'
arch/sparc64/kernel/built-in.o(__ex_table+0x3dc): undefined reference to `kernel_unaligned_trap_fault'
arch/sparc64/kernel/built-in.o(__ex_table+0x3e4): undefined reference to `kernel_unaligned_trap_fault'
arch/sparc64/kernel/built-in.o(__ex_table+0x3ec): more undefined references to `kernel_unaligned_trap_fault' follow
make: *** [.tmp_vmlinux1] Error 1



I am using Dan Kegel's "crosstools" to build this kernel using 
 "make ARCH=sparc64 CC=/opt/crosstool/sparc64-unknown-linux-gnu/gcc-3.4.0-glibc-2.3.2/bin/sparc64-unknown-linux-gnu-gcc"
  to build it.

Oh yeah, I also had to comment out line 449 of include/asm/unistd.h to get it
to compile:

/* static __inline__ _syscall1(int,_exit,int,exitcode) */


Looking at arch/sparc64/kernel/unaligned.c lines 408 - 451, if I simply comment
out the 'kernel_unaligned_trap_fault' I can get the thing to build,
and it even boots on an E4500. (ultrasparc/sun4u)
[ s/kernel_unaligned_trap_fault)/)/ is sufficient for a build :) ]

unaligned.c 408-451:
===================

asmlinkage void kernel_unaligned_trap(struct pt_regs *regs, unsigned int insn, unsigned long sfar, unsigned long sfsr)
{
        enum direction dir = decode_direction(insn);
        int size = decode_access_size(insn);

        if (!ok_for_kernel(insn) || dir == both) {
                printk("Unsupported unaligned load/store trap for kernel at <%016lx>.\n",
                       regs->tpc);
                unaligned_panic("Kernel does fpu/atomic unaligned load/store.", regs);
                __asm__ __volatile__ ( "\n"
"kernel_unaligned_trap_fault:\n\t"
                "mov    %0, %%o0\n\t"
                "call   kernel_mna_trap_fault\n\t"
                " mov   %1, %%o1\n\t"
                :
                : "r" (regs), "r" (insn)
                : "o0", "o1", "o2", "o3", "o4", "o5", "o7",
                  "g1", "g2", "g3", "g4", "g5", "g7", "cc");
        } else {
                unsigned long addr = compute_effective_address(regs, insn, ((insn >> 25) & 0x1f));

#ifdef DEBUG_MNA
                printk("KMNA: pc=%016lx [dir=%s addr=%016lx size=%d] retpc[%016lx]\n",
                       regs->tpc, dirstrings[dir], addr, size, regs->u_regs[UREG_RETPC]);
#endif
                switch (dir) {
                case load:
                        do_integer_load(fetch_reg_addr(((insn>>25)&0x1f), regs),
                                        size, (unsigned long *) addr,
                                        decode_signedness(insn), decode_asi(insn, regs),
                                        kernel_unaligned_trap_fault);
                        break;

                case store:
                        do_integer_store(((insn>>25)&0x1f), size,
                                         (unsigned long *) addr, regs,
                                         decode_asi(insn, regs),
                                         kernel_unaligned_trap_fault);
                        break;
#if 0 /* unsupported */
                case both:
                        do_atomic(fetch_reg_addr(((insn>>25)&0x1f), regs),
                                  (unsigned long *) addr,
                                          kernel_unaligned_trap_fault);
                        break;
#endif
                default:
                        panic("Impossible kernel unaligned trap.");
                        /* Not reached... */
                }
                advance(regs);
        }
}



===============

/opt/crosstool/sparc64-unknown-linux-gnu/gcc-3.4.0-glibc-2.3.2/bin/sparc64-unknown-linux-gnu-gcc --version
sparc64-unknown-linux-gnu-gcc (GCC) 3.4.0

  Straight out of "crosstools".  Running on a freshly installed debian sid
with 2.6.6 on ix86.

I have another problem now as well with NULL pointer dereference
in drivers/char/vt.c line 2891.

"Badness in poke_blanked_console" - is that an unrelated issue?

Thanks,

Peter
