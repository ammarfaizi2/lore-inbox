Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274096AbRJDPiK>; Thu, 4 Oct 2001 11:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274758AbRJDPiB>; Thu, 4 Oct 2001 11:38:01 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:15856 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S274096AbRJDPhy>; Thu, 4 Oct 2001 11:37:54 -0400
Message-ID: <3BBC8216.4B708192@mvista.com>
Date: Thu, 04 Oct 2001 08:36:54 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Standard way of generating assembler offsets
In-Reply-To: <28136.1002196028@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This sound great.  It has been a struggle for me for some time.

A couple of comments:

The symbol name IMHO should contain both the member name and the
structure name.  Otherwise there may be a problem if two structures use
the same member name (flags comes to mind).

This is way down on the list, but is it possible to generate a separate
file for each *.S AND put the "required symbols" in the *.S.  

When I last did this we put a comment in the *.S that had a special
format and changed the make rule for *.S->*.o to first build the
required file.  The *.S then used #include "sym*.h" to get the symbols. 
I think the standard make rule even removed the sys*.h file after the
*.o was built.  The actual section in the *.S that defined the required
symbols was written as cpp macros which were stripped with a sed
script.  The result (with a standard header and tail) was compiled and
run to generate the sym*.h file.  Even the includes needed to generate
the symbols were in the *.S so a dep script can generate the needed
stuff for the *.S.

The nice thing about this method is that it is easy to keep track of the
required symbols and the make dependencies are simple (and easily
derived).

George

Keith Owens wrote:
> 
> Almost every architecture generates Assembler values to map the offsets
> of fields in C structures, about the only exception is i386 and that is
> because its offsets are hard coded into entry.S.  Every arch has done
> it differently, none of them have got it exactly right.
> 
> As part of kbuild 2.5 I am standardizing on one method for generating
> Assembler offsets.  This change is required for kbuild 2.5 but it can
> be added to 2.4 without disturbing the current kbuild, I want to do
> this gradually now instead of a single massive change in kernel 2.5.  I
> will be issuing per architecture changes for generating Assembler
> offsets against 2.4.
> 
> The kbuild 2.5 method for generating Assembler offsets satisfies these
> requirements:
> 
> * No manual intervention required.  Many architectures rely on users
>   running make dep after changing config options that affect the
>   Assembler offsets.  If the user forgets to run make dep then the C
>   and Assembler code is out of sync - totally unacceptable.  This is
>   completely fixed in kbuild 2.5; I cannot do a complete fix in kbuild
>   2.4 but it is still better than the existing manual system.
> 
> * Standard name for the related files.  There are 6+ different names
>   for the files used to generate Assembler offsets, kbuild 2.5 uses
>   asm-offsets.[csh] on all architectures.
> 
> * Allows for multiple parallel compiles from the same source tree.
>   Writing the generated asm-offsets.h to include/asm is not an option,
>   it prevents concurrent compiles.
> 
> * The method must work in native and cross compile mode and give
>   exactly the same results.  Some 2.4 code only works in native mode,
>   some architectures have different methods for native and cross
>   compile with different output formats.  Yeuch!
> 
> * Standard scripts for generating the output.  Every arch does it
>   differently in 2.4, standards are good!
> 
> * Correct dependency trees.  Because 2.4 make dep does not scan .S
>   files, there is little or no dependency information.  Even if the
>   offsets are regenerated, the affected Assembler code does not always
>   get rebuilt.  kbuild 2.5 handles dependencies for Assembler as well
>   as C; I cannot get kbuild 2.4 perfect but I can improve on the
>   existing (or non-existent) 2.4 dependencies.
> 
> All architectures will define arch/$(ARCH)/asm-offsets.c.  This has a
> standard prologue for the macros that convert offsets to Assembler,
> followed by arch specific field references.
> 
> arch/$(ARCH)/asm-offsets.s is generated from arch/$(ARCH)/asm-offsets.c
> using standard rules, although kbuild 2.4 needs some tweaking.
> 
> arch/$(ARCH)/asm-offsets.h is generated from arch/$(ARCH)/asm-offsets.s
> by a semi-standard script.  Most of the script is common to all
> architectures but the precise format of the Assembler output is arch
> specific.
> 
> The final result is included in *only* the Assembler programs that need
> it, as #include "asm-offsets.h" with -I arch/$(ARCH) in the relevant
> Makefiles.  Hard coding relative paths in source files is a pet hate,
> use #include "localname.h" and -I instead.  Including the generated
> file in C code is not allowed, it severly pollutes the dependency
> chain, to the extent that any config change can force a complete
> recompile, unacceptable.
> 
> Example from i386:
> 
> arch/i386/asm-offsets.c
> 
> /*
>  * Generate definitions needed by assembly language modules.
>  * This code generates raw asm output which is post-processed to extract
>  * and format the required data.
>  */
> 
> #include <linux/types.h>
> #include <linux/stddef.h>
> #include <linux/sched.h>
> 
> /* Use marker if you need to separate the values later */
> 
> #define DEFINE(sym, val, marker) \
>   asm volatile("\n-> " #sym " %0 " #val " " #marker : : "i" (val))
> 
> #define BLANK() asm volatile("\n->" : : )
> 
> int
> main(void)
> {
>   DEFINE(state,        offsetof(struct task_struct, state),);
>   DEFINE(flags,        offsetof(struct task_struct, flags),);
>   DEFINE(sigpending,   offsetof(struct task_struct, sigpending),);
>   DEFINE(addr_limit,   offsetof(struct task_struct, addr_limit),);
>   DEFINE(exec_domain,  offsetof(struct task_struct, exec_domain),);
>   DEFINE(need_resched, offsetof(struct task_struct, need_resched),);
>   DEFINE(tsk_ptrace,   offsetof(struct task_struct, ptrace),);
>   DEFINE(processor,    offsetof(struct task_struct, processor),);
>   BLANK();
>   DEFINE(ENOSYS,       ENOSYS,);
>   return 0;
> }
> 
> asm-offsets.s to asm-offsets.h.
> 
> # Convert raw asm offsets into something that can be included as
> # assembler definitions.  It converts
> #   -> symbol $value source
> # into
> #   symbol = value /* 0xvalue source */
> 
> echo '#ifndef __ASM_OFFSETS_H__'
> echo '#define __ASM_OFFSETS_H__'
> echo '/*'
> echo ' * DO NOT MODIFY'
> echo ' *'
> echo " * This file was generated by arch/$(ARCH)/Makefile.in."
> echo ' *'
> echo ' */'
> echo ''
> awk '
>   /^->$/{printf("\n")}
>   /^-> /{
>     sym = $2;
>     val = $3;
>     sub(/^\$/, "", val);
>     $1 = "";
>     $2 = "";
>     $3 = "";
>     printf("%-20s = %3d\t/* 0x%x\t%s */\n", sym, val, val, $0)
>   }
> '
> echo '#endif'
> 
> Generated arch/i386/asm-offsets.h
> 
> #ifndef __ASM_OFFSETS_H__
> #define __ASM_OFFSETS_H__
> /*
>  * DO NOT MODIFY
>  *
>  * This file was generated by arch/i386/Makefile.in.
>  *
>  */
> 
> state                =   0      /* 0x0     offsetof(struct task_struct, state) */
> flags                =   4      /* 0x4     offsetof(struct task_struct, flags) */
> sigpending           =   8      /* 0x8     offsetof(struct task_struct, sigpending) */
> addr_limit           =  12      /* 0xc     offsetof(struct task_struct, addr_limit) */
> exec_domain          =  16      /* 0x10    offsetof(struct task_struct, exec_domain) */
> need_resched         =  20      /* 0x14    offsetof(struct task_struct, need_resched) */
> tsk_ptrace           =  24      /* 0x18    offsetof(struct task_struct, ptrace) */
> processor            =  52      /* 0x34    offsetof(struct task_struct, processor) */
> 
> ENOSYS               =  38      /* 0x26    ENOSYS */
> #endif
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
