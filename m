Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275045AbRJNL1p>; Sun, 14 Oct 2001 07:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275082AbRJNL10>; Sun, 14 Oct 2001 07:27:26 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:33288 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S275045AbRJNL1H>;
	Sun, 14 Oct 2001 07:27:07 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Standard way of generating assembler offsets 
In-Reply-To: Your message of "Mon, 08 Oct 2001 02:49:46 MST."
             <20011008.024946.74749362.davem@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 14 Oct 2001 21:27:19 +1000
Message-ID: <1519.1003058839@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Oct 2001 02:49:46 -0700 (PDT), 
"David S. Miller" <davem@redhat.com> wrote:
>BTW, I assume you have already taken a look at how we
>do this on Sparc64.  See arch/sparc64/kernel/check_asm.sh
>and the "check_asm" target in arch/sparc64/kernel/Makefile
>
>It also works in all cross-compilation etc. environments.
>And I bet it would work on every platform with very minimal
>changes, if any.

I finally had time to look at sparc64 check_asm.  The code suffers from
several problems:

* It is only built at make dep time so any patches after make dep that
  affect the asm offsets are not picked up.

* The code has to know about all the config options that affect the
  structures, it manually tests for SMP and SPIN_LOCK_DEBUG.  That is
  bad enough but other architectures are much worse, several config
  settings can change the asm offsets, each config setting would have
  to be manually defined.

* The asm output lists all fields in the input structures.  It is
  arguable if this is a good or bad thing, I prefer to explicitly
  define just the symbols required by asm so I view this as a bad
  feature.

* check_asm can only generate offsetof and sizeof fields.  So
  calculated fields like AOFF_task_fpregs have to be done elsewhere.

* The code is complex.  I thought my asm-offsets.c->.s->.h conversion
  was complicated but asm_check takes the cake.

Here is a first cut at doing sparc64 asm offsets the same way that i386
and ia64 are done in kbuild 2.5.

* It uses .c->.s->h so it plugs directly into the kbuild 2.5 dependency
  handling, any patch or config changes that affect asm-offsets.h will
  automatically rebuild asm-offsets.h.

* Only the fields actually used by asm are listed.  I may have missed a
  field or two but gcc will tell us that.

* asm-offsets.c DEFINE() can do any calculation.  So AOFF_task_fpregs
  is now calculated here.

* Less complex :).

* The addition of comments against each define makes the result more
  readable.

==== arch/sparc64/asm-offsets.c ====

/*
 * Generate definitions needed by assembly language modules.
 * This code generates raw asm output which is post-processed to extract
 * and format the required data.
 */

#include <linux/types.h>
#include <linux/stddef.h>
#include <linux/sched.h>

/* Use marker if you need to separate the values later */

#define DEFINE(sym, val, marker) \
  asm volatile("\n-> " #sym " %0 " #val " " #marker : : "i" (val))

#define BLANK() asm volatile("\n->" : : )

int
main(void)
{
  DEFINE(AOFF_mm_context,		offsetof(struct mm_struct, context),);
  BLANK();

  DEFINE(AOFF_task_blocked,		offsetof(struct task_struct, blocked),);
  DEFINE(AOFF_task_egid,		offsetof(struct task_struct, egid),);
  DEFINE(ASIZ_task_egid,		sizeof(((struct task_struct *)NULL)->egid),);
  DEFINE(AOFF_task_euid,		offsetof(struct task_struct, euid),);
  DEFINE(ASIZ_task_euid,		sizeof(((struct task_struct *)NULL)->euid),);
  DEFINE(AOFF_task_flags,		offsetof(struct task_struct, flags),);
  DEFINE(AOFF_task_fpregs,		(sizeof(struct task_struct) + (64 - 1)) & ~(64 - 1),);
  DEFINE(AOFF_task_gid,			offsetof(struct task_struct, gid),);
  DEFINE(ASIZ_task_gid,			sizeof(((struct task_struct *)NULL)->gid),);
  DEFINE(AOFF_task_need_resched,	offsetof(struct task_struct, need_resched),);
  DEFINE(AOFF_task_personality,		offsetof(struct task_struct, personality),);
  DEFINE(ASIZ_task_personality,		sizeof(((struct task_struct *)NULL)->personality),);
  DEFINE(AOFF_task_pid,			offsetof(struct task_struct, pid),);
  DEFINE(AOFF_task_p_opptr,		offsetof(struct task_struct, p_opptr),);
  DEFINE(AOFF_task_processor,		offsetof(struct task_struct, processor),);
  DEFINE(AOFF_task_ptrace,		offsetof(struct task_struct, ptrace),);
  DEFINE(AOFF_task_sigpending,		offsetof(struct task_struct, sigpending),);
  DEFINE(AOFF_task_thread,		offsetof(struct task_struct, thread),);
  DEFINE(AOFF_task_uid,			offsetof(struct task_struct, uid),);
  DEFINE(ASIZ_task_uid,			sizeof(((struct task_struct *)NULL)->uid),);
  BLANK();

  DEFINE(AOFF_thread_current_ds,	offsetof(struct thread_struct, current_ds),);
  DEFINE(AOFF_thread_fault_address,	offsetof(struct thread_struct, fault_address),);
  DEFINE(AOFF_thread_fault_code,	offsetof(struct thread_struct, fault_code),);
  DEFINE(AOFF_thread_flags,		offsetof(struct thread_struct, flags),);
  DEFINE(AOFF_thread_fork_kpsr,		offsetof(struct thread_struct, fork_kpsr),);
  DEFINE(AOFF_thread_fpdepth,		offsetof(struct thread_struct, fpdepth),);
  DEFINE(AOFF_thread_fpsaved,		offsetof(struct thread_struct, fpsaved),);
  DEFINE(AOFF_thread_gsr,		offsetof(struct thread_struct, gsr),);
  DEFINE(AOFF_thread_kernel_cntd0,	offsetof(struct thread_struct, kernel_cntd0),);
  DEFINE(AOFF_thread_pcr_reg,		offsetof(struct thread_struct, pcr_reg),);
  DEFINE(AOFF_thread_reg_window,	offsetof(struct thread_struct, reg_window),);
  DEFINE(AOFF_thread_rwbuf_stkptrs,	offsetof(struct thread_struct, rwbuf_stkptrs),);
  DEFINE(AOFF_thread_use_blkcommit,	offsetof(struct thread_struct, use_blkcommit),);
  DEFINE(AOFF_thread_utraps,		offsetof(struct thread_struct, utraps),);
  DEFINE(AOFF_thread_uwinmask,		offsetof(struct thread_struct, uwinmask),);
  DEFINE(AOFF_thread_w_saved,		offsetof(struct thread_struct, w_saved),);
  DEFINE(AOFF_thread_xfsr,		offsetof(struct thread_struct, xfsr),);

  return 0;
}

==== arch/sparc64/Makefile.in ====

# Convert raw asm offsets into something that can be included as
# assembler definitions.  It converts
#   -> symbol $value source
# into
#   #define symbol value /* 0xvalue source */

user_command(asm-offsets.h
	($(objfile asm-offsets.s))
	(set -e;
	  (echo "#ifndef __ASM_OFFSETS_H__";
	   echo "#define __ASM_OFFSETS_H__";
	   echo "/*";
	   echo " * DO NOT MODIFY";
	   echo " *";
	   echo " * This file was generated by arch/$(ARCH)/Makefile.in.";
	   echo " *";
	   echo " */";
	   echo "";
	   awk "/^->\$$/{printf(\"\\n\");}
	     /^-> /{
	       sym = \$$2;
	       val = \$$3;
	       sub(/^\\\$$/, \"\", val);
	       \$$1 = \"\";
	       \$$2 = \"\";
	       \$$3 = \"\";
	       printf(\"#define %-24s %4d\\t\\t\\t/* 0x%x\\t%s */\\n\",
	         sym, val, val, \$$0)
	     }";
	   echo "";
	   echo "#endif";
	  ) < $< > $@;
	)
	()
	)

==== arch/sparc64/asm-offsets.h output ====

This is partial output and was actually generated on i386 so the
numbers are wrong but it shows what the output will look like.  I do
not have access to a machine for compiling 2.4 sparc64 kernels so none
of the thread values are in this sample.

#ifndef __ASM_OFFSETS_H__
#define __ASM_OFFSETS_H__
/*
 * DO NOT MODIFY
 *
 * This file was generated by arch/sparc64/Makefile.in.
 *
 */

#define AOFF_mm_context           128			/* 0x80	   offsetof(struct mm_struct, context) */

#define AOFF_task_blocked        1632			/* 0x660	   offsetof(struct task_struct, blocked) */
#define AOFF_task_egid            572			/* 0x23c	   offsetof(struct task_struct, egid) */
#define ASIZ_task_egid              4			/* 0x4	   sizeof(((struct task_struct *)NULL)->egid) */
#define AOFF_task_euid            556			/* 0x22c	   offsetof(struct task_struct, euid) */
#define ASIZ_task_euid              4			/* 0x4	   sizeof(((struct task_struct *)NULL)->euid) */
#define AOFF_task_flags             4			/* 0x4	   offsetof(struct task_struct, flags) */
#define AOFF_task_fpregs         1728			/* 0x6c0	   (sizeof(struct task_struct) + (64 - 1)) & ~(64 - 1) */
#define AOFF_task_gid             568			/* 0x238	   offsetof(struct task_struct, gid) */
#define ASIZ_task_gid               4			/* 0x4	   sizeof(((struct task_struct *)NULL)->gid) */
#define AOFF_task_need_resched     20			/* 0x14	   offsetof(struct task_struct, need_resched) */
#define AOFF_task_personality     116			/* 0x74	   offsetof(struct task_struct, personality) */
#define ASIZ_task_personality       4			/* 0x4	   sizeof(((struct task_struct *)NULL)->personality) */
#define AOFF_task_pid             124			/* 0x7c	   offsetof(struct task_struct, pid) */
#define AOFF_task_p_opptr         148			/* 0x94	   offsetof(struct task_struct, p_opptr) */
#define AOFF_task_processor        52			/* 0x34	   offsetof(struct task_struct, processor) */
#define AOFF_task_ptrace           24			/* 0x18	   offsetof(struct task_struct, ptrace) */
#define AOFF_task_sigpending        8			/* 0x8	   offsetof(struct task_struct, sigpending) */
#define AOFF_task_thread          880			/* 0x370	   offsetof(struct task_struct, thread) */
#define AOFF_task_uid             552			/* 0x228	   offsetof(struct task_struct, uid) */
#define ASIZ_task_uid               4			/* 0x4	   sizeof(((struct task_struct *)NULL)->uid) */

/* Thread values would be here if I could compile for sparc64. */

#endif

