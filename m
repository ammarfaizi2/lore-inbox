Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267974AbRHKPDi>; Sat, 11 Aug 2001 11:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268017AbRHKPD3>; Sat, 11 Aug 2001 11:03:29 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:2830 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S267974AbRHKPDM>;
	Sat, 11 Aug 2001 11:03:12 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Announce: Kernel Build for 2.5, Release 1.1 is available.
Date: Sun, 12 Aug 2001 01:03:00 +1000
Message-ID: <1904.997542180@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

Release 1.1 of kernel build for kernel 2.5 (kbuild 2.5) is available.
http://sourceforge.net/projects/kbuild/, Package kbuild-2.5, download
release 1.1.

http://marc.theaimsgroup.com/?l=linux-kernel&m=99725412902968&w=2
contains information about the base release.

Changes from Release 1.

  Upgrade to kernel 2.4.8.  Nice to see how simple the DRM Makefile is
  now.

  Correct a race when parallel building the global makefile, not all
  objects were being recognised as targets and were not recognised as
  candidates for recompile.

  Replace hand coded rules with side_effect().

  Document kbuild targets and C to assembler conversions.  As always,
  Documentation/kbuild/kbuild-2.5.txt is your friend.

  Remove the assembler() command.  kbuild now works out if the source
  is .c or .S, no need for human intervention.

  If you explicitly make foo.i or foo.s then kbuild automatically
  generates the required rules with the same flags as the corresponding
  .o file.  Useful for debugging pre-processor or assembler problems,
  especially when gcc -save-temps does not work with multiple
  directories.

  Standard generation of .s from .c files, where a .s file is required
  according to make.  This includes tracking the dependencies of the .c
  file.

That last change lets me solve a long standing problem with kbuild 2.4.
Every architecture has Assembler that requires offsets of fields within
C structures or the mapping of C names to numbers.  Assembler cannot
include the C definitions so we need a mapping from C constructs to
Assembler numbers.  Every architecture has handled this problem in a
different way, none of the methods are 100% accurate nor dependable.

i386 hard codes the offsets into the assembler code and hopes that the
structure definitions never change.

Alpha uses a C program that generates the text for the assembler.  This
does not work in a cross compile environment because it assumes that
HOSTCC == CC.

Cris generates a chunk of assembler from C then uses .include instead
of #include, with some fancy conditional selection.

Mips, parisc, ppc, sparc generate assembler then extract and reformat
lines from the assembler.  This works in both local and cross compile
mode and is getting close to the correct way of doing it.  But it still
has problems, see below.

IA64 in 2.4 is particularly loathsome.  It uses different methods in
native and cross compile modes, when the cross compile version would do
for both.  It ships a copy of the generated asm/offsets.h which is
totally unreliable because the real offsets.h depends on the user's
.config.  To add insult to injury, offsets.h is included in processor.h
and ptrace.h on ia64 which means that it pollutes almost every C file.

None of the above methods handle dependency checking at all.  PPC makes
an attempt but it is manually defined and is incomplete, no other arch
even makes an attempt.  All architectures assume that the user always
runs make dep after any config changes that affect the assembler
offsets.  If the user forgets to run make dep and the assembler and C
values do not match - oops.

kbuild 2.5 has a solution which works in all modes, is standard across
all architectures and automatically tracks dependency changes.  No more
room for human error.

* Create arch/$(ARCH)/offsets.c containing code like this, from
  arch/i386/offsets.c.  This should be the standard format on all
  architectures, the only difference should be the list of fields to
  generate.

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
    asm volatile("\n-> " #sym " %c0 " #val " " #marker : : "i" (val))

  int
  main(void)
  {
    DEFINE(state,        offsetof(struct task_struct, state),);
    DEFINE(flags,        offsetof(struct task_struct, flags),);
    DEFINE(sigpending,   offsetof(struct task_struct, sigpending),);
    DEFINE(addr_limit,   offsetof(struct task_struct, addr_limit),);
    DEFINE(exec_domain,  offsetof(struct task_struct, exec_domain),);
    DEFINE(need_resched, offsetof(struct task_struct, need_resched),);
    DEFINE(tsk_ptrace,   offsetof(struct task_struct, ptrace),);
    DEFINE(processor,    offsetof(struct task_struct, processor),);
    DEFINE(ENOSYS,       ENOSYS,);
    return 0;
  }

* When that code is compiled from .c to .s using CC for the target
  system, the generated Assembler contains lines like this

  -> state 0 offsetof(struct task_struct, state)
  -> flags 4 offsetof(struct task_struct, flags)
  -> sigpending 8 offsetof(struct task_struct, sigpending)
  -> addr_limit 12 offsetof(struct task_struct, addr_limit)
  -> exec_domain 16 offsetof(struct task_struct, exec_domain)
  -> need_resched 20 offsetof(struct task_struct, need_resched)
  -> tsk_ptrace 24 offsetof(struct task_struct, ptrace)
  -> processor 52 offsetof(struct task_struct, processor)
  -> ENOSYS 38 ENOSYS

  interspersed with Assembler declarations and blank lines.

* In arch/$(ARCH)/Makefile.in, define user commands to extract the
  '->' lines from offsets.s and reformat as required for your
  architecture.  arch/i386/Makefile.in contains

  # Convert raw asm offsets into something that can be included as
  # assembler definitions.  It converts
  #   -> symbol value source
  # into
  #   symbol  = value /* 0xvalue source */

  user_command(offsets.h
	  ($(objfile offsets.s))
	  (set -e;
	    (echo "#ifndef __ASM_OFFSETS_H__";
	     echo "#define __ASM_OFFSETS_H__";
	     awk "/^->/{
	       sym = \$$2;
	       val = \$$3;
	       \$$1 = \"\";
	       \$$2 = \"\";
	       \$$3 = \"\";
	       printf(\"%-20s = %3d\t\t\t/* 0x%x\t%s */\n\",
		 sym, val, val, \$$0)
	     }";
	     echo "#endif";
	    ) < $< > $(@D).tmp_$(@F);
	    cmp -s $(@D).tmp_$(@F) $@ || mv $(@D).tmp_$(@F) $@
	  )
	  ()
	  )

  The awk code is a little complicated because it has to cope with both
  shell (" -> \", $ -> \$) and make ($ -> $$) quoting rules but it
  works, and only has to be coded once.  The output from awk is written
  to a .tmp_ file first, the result is compared with the previous
  version (if any) and only if they are different is offsets.h updated.
  The compare and update avoids spurious Assembler recompiles, most
  config changes do not affect offsets.h.

  The final output is in arch/$(ARCH)/offsets.h.  On i386, offsets.h
  contains

  #ifndef __ASM_OFFSETS_H__
  #define __ASM_OFFSETS_H__
  state        =   0 /* 0x0  offsetof(struct task_struct, state) */
  flags        =   4 /* 0x4  offsetof(struct task_struct, flags) */
  sigpending   =   8 /* 0x8  offsetof(struct task_struct, sigpending) */
  addr_limit   =  12 /* 0xc  offsetof(struct task_struct, addr_limit) */
  exec_domain  =  16 /* 0x10 offsetof(struct task_struct, exec_domain) */
  need_resched =  20 /* 0x14 offsetof(struct task_struct, need_resched) */
  tsk_ptrace   =  24 /* 0x18 offsetof(struct task_struct, ptrace) */
  processor    =  52 /* 0x34 offsetof(struct task_struct, processor) */
  ENOSYS       =  38 /* 0x26 ENOSYS */
  #endif

  My aim is to standardize the format of the output from offsets.s and
  do any arch specific processing in the makefile.  In the long run
  this will be easier than having eight different ways of generating
  assembler output.  I have included a marker parameter in the DEFINE
  macro, marker appears at the end of the '->' line, just in case an
  architecture needs some indicator in order to split the offsets into
  multiple files.

* Do not, under any circumstances, include offsets.h in any files that
  are used by C source, offsets.h must only be used in Assembler code.
  IA64 made the mistake of including offsets.h in processor.h and
  ptrace.h so they have to ship the generated offsets.h to avoid C
  compile errors on parallel builds.  But the version that is shipped
  is incorrect, it does not match the user's config, a potential source
  of human error.

* Do not ship arch/$(arch)/offsets.h nor include it in any patches.  Add
  offsets.h to your don't diff list.

* Specify arch/$(ARCH)/offsets.h as a pre-requisite of only the objects
  that need it in order to assemble.  arch/i386/kernel/Makefile.in has

  $(objfile entry.o): $(objfile /arch/$(ARCH)/offsets.h)

  You only need to specify this dependency for the Assembler files that
  use the generated offset values.

When kbuild 2.5 wants to compile entry.o, it checks if offsets.h is up
to date.  user_command() says that offsets.h depends on offsets.s.
offsets.s implicitly depends on offsets.c, there is no need for an
explicit rule.  Not only does offsets.s directly depend on offsets.c,
it indirectly depends on all the files included by offsets.c, either
directly or indirectly, and on all the CONFIG_ settings in offsets.c
and the included files.

If anything that affects config.s has changed it is rebuilt, the '->'
lines are extracted and, if offsets.h has changed, it is replaced.
That will force a recompile of the affected assembler objects.  The
result is a standard, reliable and, above all, an automatic method of
converting C values to Assembler lines.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.3 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE7dUkji4UHNye0ZOoRAiS6AJsEyMYRmEReH09ZFThu5bf7rVPDtQCgjhAY
w+JAoVEaOASjcl+kHL34fiE=
=fuW1
-----END PGP SIGNATURE-----

