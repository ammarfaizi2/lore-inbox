Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030427AbWJJXQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030427AbWJJXQP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 19:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030631AbWJJXQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 19:16:15 -0400
Received: from gw.goop.org ([64.81.55.164]:38878 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1030427AbWJJXQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 19:16:14 -0400
Message-ID: <452C29BB.8030405@goop.org>
Date: Tue, 10 Oct 2006 16:16:11 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Michael Ellerman <michael@ellerman.id.au>
Subject: Re: 2.6.19-rc1-mm1
References: <20061010000928.9d2d519a.akpm@osdl.org>	<452BE1DC.9030503@goop.org>	<20061010122511.8232e9d5.akpm@osdl.org> <17708.10335.310098.583695@cargo.ozlabs.ibm.com>
In-Reply-To: <17708.10335.310098.583695@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras wrote:
> Andrew Morton writes:
>
>   
>> My plan was to pathetically spam the powerpc guys with it once all the
>> above is merged up.  I took a close look and couldn't see why it was
>> failing.
>>     
>
> What was the failure?
>   

I've included it below.  But Michael Ellerman said it worked OK for him 
when applied to the plain Linus tree, and Andrew said that 
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm3/hot-fixes/slab-reduce-numa-text-size-tidy-fix.patch 
fixed it.  So I thought it was OK.

    J

> On Wed, 04 Oct 2006 00:22:33 -0600
> akpm@osdl.org wrote:
>
>> > Subject: generic-implementatation-of-bug-fix
>
> x86_64 works OK.  powerpc compiles now, but hangs after "returning from
> prom_init".  I can't see why.  The quickest way to fix this is to merge it
> into mainline as-is then whistle innocently.
>
> Can any of the powerpc guys spot-the-bug??
>
> Thanks.
>
>
> From: Jeremy Fitzhardinge <jeremy@goop.org>
>
> This makes powerpc use the generic BUG machinery.  The biggest reports the
> function name, since it is redundant with kallsyms, and not needed in general.
>
> There is an overall reduction of code, since module_32/64 duplicated several
> functions.
>
> Unfortunately there's no way to tell gcc that BUG won't return, so the BUG
> macro includes a goto loop.  This will generate a real jmp instruction, which
> is never used.
>
> BTW, powerpc doesn't seem to be using BUG_OPCODE or BUG_ILLEGAL_INSTRUCTION
> for actual BUGs any more (I presume they were once used).  There are still a
> couple of uses of those macros elsewhere (kernel/prom_init.c and
> kernel/head_64.S); should be converted to "twi 31,0,0" as well?
>
> [akpm@osdl.org: build fixes]
> Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>
> Cc: Andi Kleen <ak@muc.de>
> Cc: Hugh Dickens <hugh@veritas.com>
> Cc: Michael Ellerman <michael@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
>
>  arch/powerpc/Kconfig              |    5 +
>  arch/powerpc/kernel/module_32.c   |   43 +-------------
>  arch/powerpc/kernel/module_64.c   |   43 +-------------
>  arch/powerpc/kernel/traps.c       |   54 ++----------------
>  arch/powerpc/kernel/vmlinux.lds.S |    6 --
>  arch/powerpc/xmon/xmon.c          |   10 +--
>  include/asm-powerpc/bug.h         |   83 ++++++++++++++--------------
>  include/asm-powerpc/module.h      |    2 
>  8 files changed, 65 insertions(+), 181 deletions(-)
>
> diff -puN arch/powerpc/Kconfig~generic-bug-for-powerpc arch/powerpc/Kconfig
> --- a/arch/powerpc/Kconfig~generic-bug-for-powerpc
> +++ a/arch/powerpc/Kconfig
> @@ -99,6 +99,11 @@ config AUDIT_ARCH
>  	bool
>  	default y
>  
> +config GENERIC_BUG
> +	bool
> +	default y
> +	depends on BUG
> +
>  config DEFAULT_UIMAGE
>  	bool
>  	help
> diff -puN arch/powerpc/kernel/module_32.c~generic-bug-for-powerpc arch/powerpc/kernel/module_32.c
> --- a/arch/powerpc/kernel/module_32.c~generic-bug-for-powerpc
> +++ a/arch/powerpc/kernel/module_32.c
> @@ -23,6 +23,7 @@
>  #include <linux/string.h>
>  #include <linux/kernel.h>
>  #include <linux/cache.h>
> +#include <linux/bug.h>
>  
>  #if 0
>  #define DEBUGP printk
> @@ -273,48 +274,10 @@ int module_finalize(const Elf_Ehdr *hdr,
>  		    const Elf_Shdr *sechdrs,
>  		    struct module *me)
>  {
> -	char *secstrings;
> -	unsigned int i;
> -
> -	me->arch.bug_table = NULL;
> -	me->arch.num_bugs = 0;
> -
> -	/* Find the __bug_table section, if present */
> -	secstrings = (char *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
> -	for (i = 1; i < hdr->e_shnum; i++) {
> -		if (strcmp(secstrings+sechdrs[i].sh_name, "__bug_table"))
> -			continue;
> -		me->arch.bug_table = (void *) sechdrs[i].sh_addr;
> -		me->arch.num_bugs = sechdrs[i].sh_size / sizeof(struct bug_entry);
> -		break;
> -	}
> -
> -	/*
> -	 * Strictly speaking this should have a spinlock to protect against
> -	 * traversals, but since we only traverse on BUG()s, a spinlock
> -	 * could potentially lead to deadlock and thus be counter-productive.
> -	 */
> -	list_add(&me->arch.bug_list, &module_bug_list);
> -
> -	return 0;
> +	return module_bug_finalize(hdr, sechdrs, me);
>  }
>  
>  void module_arch_cleanup(struct module *mod)
>  {
> -	list_del(&mod->arch.bug_list);
> -}
> -
> -struct bug_entry *module_find_bug(unsigned long bugaddr)
> -{
> -	struct mod_arch_specific *mod;
> -	unsigned int i;
> -	struct bug_entry *bug;
> -
> -	list_for_each_entry(mod, &module_bug_list, bug_list) {
> -		bug = mod->bug_table;
> -		for (i = 0; i < mod->num_bugs; ++i, ++bug)
> -			if (bugaddr == bug->bug_addr)
> -				return bug;
> -	}
> -	return NULL;
> +	module_bug_cleanup(mod);
>  }
> diff -puN arch/powerpc/kernel/module_64.c~generic-bug-for-powerpc arch/powerpc/kernel/module_64.c
> --- a/arch/powerpc/kernel/module_64.c~generic-bug-for-powerpc
> +++ a/arch/powerpc/kernel/module_64.c
> @@ -20,6 +20,7 @@
>  #include <linux/moduleloader.h>
>  #include <linux/err.h>
>  #include <linux/vmalloc.h>
> +#include <linux/bug.h>
>  #include <asm/module.h>
>  #include <asm/uaccess.h>
>  
> @@ -416,48 +417,10 @@ LIST_HEAD(module_bug_list);
>  int module_finalize(const Elf_Ehdr *hdr,
>  		const Elf_Shdr *sechdrs, struct module *me)
>  {
> -	char *secstrings;
> -	unsigned int i;
> -
> -	me->arch.bug_table = NULL;
> -	me->arch.num_bugs = 0;
> -
> -	/* Find the __bug_table section, if present */
> -	secstrings = (char *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
> -	for (i = 1; i < hdr->e_shnum; i++) {
> -		if (strcmp(secstrings+sechdrs[i].sh_name, "__bug_table"))
> -			continue;
> -		me->arch.bug_table = (void *) sechdrs[i].sh_addr;
> -		me->arch.num_bugs = sechdrs[i].sh_size / sizeof(struct bug_entry);
> -		break;
> -	}
> -
> -	/*
> -	 * Strictly speaking this should have a spinlock to protect against
> -	 * traversals, but since we only traverse on BUG()s, a spinlock
> -	 * could potentially lead to deadlock and thus be counter-productive.
> -	 */
> -	list_add(&me->arch.bug_list, &module_bug_list);
> -
> -	return 0;
> +	return module_bug_finalize(hdr, sechdrs, me);
>  }
>  
>  void module_arch_cleanup(struct module *mod)
>  {
> -	list_del(&mod->arch.bug_list);
> -}
> -
> -struct bug_entry *module_find_bug(unsigned long bugaddr)
> -{
> -	struct mod_arch_specific *mod;
> -	unsigned int i;
> -	struct bug_entry *bug;
> -
> -	list_for_each_entry(mod, &module_bug_list, bug_list) {
> -		bug = mod->bug_table;
> -		for (i = 0; i < mod->num_bugs; ++i, ++bug)
> -			if (bugaddr == bug->bug_addr)
> -				return bug;
> -	}
> -	return NULL;
> +	module_bug_cleanup(mod);
>  }
> diff -puN arch/powerpc/kernel/traps.c~generic-bug-for-powerpc arch/powerpc/kernel/traps.c
> --- a/arch/powerpc/kernel/traps.c~generic-bug-for-powerpc
> +++ a/arch/powerpc/kernel/traps.c
> @@ -32,6 +32,7 @@
>  #include <linux/kprobes.h>
>  #include <linux/kexec.h>
>  #include <linux/backlight.h>
> +#include <linux/bug.h>
>  
>  #include <asm/kdebug.h>
>  #include <asm/pgtable.h>
> @@ -731,54 +732,9 @@ static int emulate_instruction(struct pt
>  	return -EINVAL;
>  }
>  
> -/*
> - * Look through the list of trap instructions that are used for BUG(),
> - * BUG_ON() and WARN_ON() and see if we hit one.  At this point we know
> - * that the exception was caused by a trap instruction of some kind.
> - * Returns 1 if we should continue (i.e. it was a WARN_ON) or 0
> - * otherwise.
> - */
> -extern struct bug_entry __start___bug_table[], __stop___bug_table[];
> -
> -#ifndef CONFIG_MODULES
> -#define module_find_bug(x)	NULL
> -#endif
> -
> -struct bug_entry *find_bug(unsigned long bugaddr)
> +int is_valid_bugaddr(unsigned long addr)
>  {
> -	struct bug_entry *bug;
> -
> -	for (bug = __start___bug_table; bug < __stop___bug_table; ++bug)
> -		if (bugaddr == bug->bug_addr)
> -			return bug;
> -	return module_find_bug(bugaddr);
> -}
> -
> -static int check_bug_trap(struct pt_regs *regs)
> -{
> -	struct bug_entry *bug;
> -	unsigned long addr;
> -
> -	if (regs->msr & MSR_PR)
> -		return 0;	/* not in kernel */
> -	addr = regs->nip;	/* address of trap instruction */
> -	if (addr < PAGE_OFFSET)
> -		return 0;
> -	bug = find_bug(regs->nip);
> -	if (bug == NULL)
> -		return 0;
> -	if (bug->line & BUG_WARNING_TRAP) {
> -		/* this is a WARN_ON rather than BUG/BUG_ON */
> -		printk(KERN_ERR "Badness in %s at %s:%ld\n",
> -		       bug->function, bug->file,
> -		       bug->line & ~BUG_WARNING_TRAP);
> -		dump_stack();
> -		return 1;
> -	}
> -	printk(KERN_CRIT "kernel BUG in %s at %s:%ld!\n",
> -	       bug->function, bug->file, bug->line);
> -
> -	return 0;
> +	return is_kernel_addr(addr);
>  }
>  
>  void __kprobes program_check_exception(struct pt_regs *regs)
> @@ -812,7 +768,9 @@ void __kprobes program_check_exception(s
>  			return;
>  		if (debugger_bpt(regs))
>  			return;
> -		if (check_bug_trap(regs)) {
> +
> +		if (!(regs->msr & MSR_PR) &&  /* not user-mode */
> +		    report_bug(regs->nip) == BUG_TRAP_TYPE_WARN) {
>  			regs->nip += 4;
>  			return;
>  		}
> diff -puN arch/powerpc/kernel/vmlinux.lds.S~generic-bug-for-powerpc arch/powerpc/kernel/vmlinux.lds.S
> --- a/arch/powerpc/kernel/vmlinux.lds.S~generic-bug-for-powerpc
> +++ a/arch/powerpc/kernel/vmlinux.lds.S
> @@ -62,11 +62,7 @@ SECTIONS
>  		__stop___ex_table = .;
>  	}
>  
> -	__bug_table : {
> -		__start___bug_table = .;
> -		*(__bug_table)
> -		__stop___bug_table = .;
> -	}
> +	BUG_TABLE
>  
>  /*
>   * Init sections discarded at runtime
> diff -puN arch/powerpc/xmon/xmon.c~generic-bug-for-powerpc arch/powerpc/xmon/xmon.c
> --- a/arch/powerpc/xmon/xmon.c~generic-bug-for-powerpc
> +++ a/arch/powerpc/xmon/xmon.c
> @@ -19,6 +19,7 @@
>  #include <linux/module.h>
>  #include <linux/sysrq.h>
>  #include <linux/interrupt.h>
> +#include <linux/bug.h>
>  
>  #include <asm/ptrace.h>
>  #include <asm/string.h>
> @@ -32,7 +33,6 @@
>  #include <asm/cputable.h>
>  #include <asm/rtas.h>
>  #include <asm/sstep.h>
> -#include <asm/bug.h>
>  
>  #ifdef CONFIG_PPC64
>  #include <asm/hvcall.h>
> @@ -1329,7 +1329,7 @@ static void backtrace(struct pt_regs *ex
>  
>  static void print_bug_trap(struct pt_regs *regs)
>  {
> -	struct bug_entry *bug;
> +	const struct bug_entry *bug;
>  	unsigned long addr;
>  
>  	if (regs->msr & MSR_PR)
> @@ -1340,11 +1340,11 @@ static void print_bug_trap(struct pt_reg
>  	bug = find_bug(regs->nip);
>  	if (bug == NULL)
>  		return;
> -	if (bug->line & BUG_WARNING_TRAP)
> +	if (is_warning_bug(bug))
>  		return;
>  
> -	printf("kernel BUG in %s at %s:%d!\n",
> -	       bug->function, bug->file, (unsigned int)bug->line);
> +	printf("kernel BUG at %s:%u!\n",
> +	       bug->file, bug->line);
>  }
>  
>  void excprint(struct pt_regs *fp)
> diff -puN include/asm-powerpc/bug.h~generic-bug-for-powerpc include/asm-powerpc/bug.h
> --- a/include/asm-powerpc/bug.h~generic-bug-for-powerpc
> +++ a/include/asm-powerpc/bug.h
> @@ -13,37 +13,40 @@
>  
>  #ifndef __ASSEMBLY__
>  
> -struct bug_entry {
> -	unsigned long	bug_addr;
> -	long		line;
> -	const char	*file;
> -	const char	*function;
> -};
> -
> -struct bug_entry *find_bug(unsigned long bugaddr);
> -
> -/*
> - * If this bit is set in the line number it means that the trap
> - * is for WARN_ON rather than BUG or BUG_ON.
> - */
> -#define BUG_WARNING_TRAP	0x1000000
> -
>  #ifdef CONFIG_BUG
>  
> +/* _EMIT_BUG_ENTRY expects args %0,%1,%2,%3 to be FILE, LINE, flags and
> +   sizeof(struct bug_entry), respectively */
> +#ifdef CONFIG_DEBUG_BUGVERBOSE
> +#define _EMIT_BUG_ENTRY				\
> +	".section __bug_table,\"a\"\n"		\
> +	"2:\t" PPC_LONG "1b, %0\n"		\
> +	"\t.short %1, %2\n"			\
> +	".org 2b+%3\n"				\
> +	".previous\n"
> +#else
> +#define _EMIT_BUG_ENTRY				\
> +	".section __bug_table,\"a\"\n"		\
> +	"2:\t" PPC_LONG "1b\n"			\
> +	"\t.short %2\n"				\
> +	".org 2b+%3\n"				\
> +	".previous\n"
> +#endif
> +
>  /*
>   * BUG_ON() and WARN_ON() do their best to cooperate with compile-time
>   * optimisations. However depending on the complexity of the condition
>   * some compiler versions may not produce optimal results.
>   */
>  
> -#define BUG() do {							 \
> -	__asm__ __volatile__(						 \
> -		"1:	twi 31,0,0\n"					 \
> -		".section __bug_table,\"a\"\n"				 \
> -		"\t"PPC_LONG"	1b,%0,%1,%2\n"				 \
> -		".previous"						 \
> -		: : "i" (__LINE__), "i" (__FILE__), "i" (__FUNCTION__)); \
> -} while (0)
> +#define BUG() do {							\
> +		__asm__ __volatile__(					\
> +			"1:	twi 31,0,0\n"				\
> +			_EMIT_BUG_ENTRY					\
> +			: : "i" (__FILE__), "i" (__LINE__),		\
> +			    "i" (0), "i"  (sizeof(struct bug_entry)));	\
> +		for(;;) ;						\
> +	} while (0)
>  
>  #define BUG_ON(x) do {						\
>  	if (__builtin_constant_p(x)) {				\
> @@ -51,23 +54,22 @@ struct bug_entry *find_bug(unsigned long
>  			BUG();					\
>  	} else {						\
>  		__asm__ __volatile__(				\
> -		"1:	"PPC_TLNEI"	%0,0\n"			\
> -		".section __bug_table,\"a\"\n"			\
> -		"\t"PPC_LONG"	1b,%1,%2,%3\n"			\
> -		".previous"					\
> -		: : "r" ((long)(x)), "i" (__LINE__),		\
> -		    "i" (__FILE__), "i" (__FUNCTION__));	\
> +		"1:	"PPC_TLNEI"	%4,0\n"			\
> +		_EMIT_BUG_ENTRY					\
> +		: : "i" (__FILE__), "i" (__LINE__), "i" (0),	\
> +		  "i" (sizeof(struct bug_entry)),		\
> +		  "r" ((long)(x)));				\
> +		for(;;) ;					\
>  	}							\
>  } while (0)
>  
>  #define __WARN() do {						\
>  	__asm__ __volatile__(					\
>  		"1:	twi 31,0,0\n"				\
> -		".section __bug_table,\"a\"\n"			\
> -		"\t"PPC_LONG"	1b,%0,%1,%2\n"			\
> -		".previous"					\
> -		: : "i" (__LINE__ + BUG_WARNING_TRAP),		\
> -		    "i" (__FILE__), "i" (__FUNCTION__));	\
> +		_EMIT_BUG_ENTRY					\
> +		: : "i" (__FILE__), "i" (__LINE__),		\
> +		  "i" (BUGFLAG_WARNING),			\
> +		  "i" (sizeof(struct bug_entry)));		\
>  } while (0)
>  
>  #define WARN_ON(x) ({						\
> @@ -77,13 +79,12 @@ struct bug_entry *find_bug(unsigned long
>  			__WARN();				\
>  	} else {						\
>  		__asm__ __volatile__(				\
> -		"1:	"PPC_TLNEI"	%0,0\n"			\
> -		".section __bug_table,\"a\"\n"			\
> -		"\t"PPC_LONG"	1b,%1,%2,%3\n"			\
> -		".previous"					\
> -		: : "r" (__ret_warn_on),			\
> -		    "i" (__LINE__ + BUG_WARNING_TRAP),		\
> -		    "i" (__FILE__), "i" (__FUNCTION__));	\
> +		"1:	"PPC_TLNEI"	%4,0\n"			\
> +		_EMIT_BUG_ENTRY					\
> +		: : "i" (__FILE__), "i" (__LINE__),		\
> +		  "i" (BUGFLAG_WARNING),			\
> +		  "i" (sizeof(struct bug_entry)),		\
> +		  "r" (__ret_warn_on));				\
>  	}							\
>  	unlikely(__ret_warn_on);				\
>  })
> diff -puN include/asm-powerpc/module.h~generic-bug-for-powerpc include/asm-powerpc/module.h
> --- a/include/asm-powerpc/module.h~generic-bug-for-powerpc
> +++ a/include/asm-powerpc/module.h
> @@ -46,8 +46,6 @@ struct mod_arch_specific {
>  	unsigned int num_bugs;
>  };
>  
> -extern struct bug_entry *module_find_bug(unsigned long bugaddr);
> -
>  /*
>   * Select ELF headers.
>   * Make empty section for module_frob_arch_sections to expand.
> _
>

