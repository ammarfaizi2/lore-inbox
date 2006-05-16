Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWEPPEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWEPPEX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932066AbWEPPEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:04:23 -0400
Received: from ns2.suse.de ([195.135.220.15]:37762 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932069AbWEPPEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:04:22 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [PATCH 1/3] reliable stack trace support
Date: Tue, 16 May 2006 17:04:14 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <4469FC07.76E4.0078.0@novell.com>
In-Reply-To: <4469FC07.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605161704.15028.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 May 2006 16:21, Jan Beulich wrote:
> These are the generic bits needed to enable reliable stack traces based
> on Dwarf2-like (.eh_frame) unwind information. Subsequent patches will
> enable x86-64 and i386 to make use of this.

Thanks for doing this. 

First are you sure this is compiling on its own? People don't like
it when their git bisect doesn't work anymore.

I unfortunately have to go through some coding style nits.

> 
> +
> +/*
> + * Initialize unwind support.
> + */
> +extern void unwind_init(void);
> +
> +extern void *
> +unwind_add_table(struct module *,

The type should be on the same line as the function name. Same further down.
Also if you want to comment the functions it would be better to use
kerneldoc compliant comments in the function definitions.
(Documentation/kernel-doc-nano-HOWTO.txt)

> +#if defined(CONFIG_STACK_UNWIND) /* || defined(CONFIG_IA64) || defined(CONFIG_PARISC) */

The comment should be dropped?

> +# define MODULE_UNWIND_INFO

Why do you need a second define for this? CONFIG_STACK_UNWIND should be enough,
no?

> +#ifdef CONFIG_STACK_UNWIND
> +#include <asm/unwind.h>
> +#else
> +#include <asm-generic/unwind.h>
> +#endif

Normally the other archs should get stub includes that include asm-generic/unwind.h

>  #ifdef CONFIG_X86_LOCAL_APIC
>  #include <asm/smp.h>
>  #endif
> @@ -482,6 +488,7 @@ asmlinkage void __init start_kernel(void
>  		   __stop___param - __start___param,
>  		   &unknown_bootoption);
>  	sort_main_extable();
> +	unwind_init();

Stupid q. but what happens when we get a crash before unwind_init? 
Is the failure benign?

> --- linux-2.6.17-rc4/kernel/module.c	2006-05-16 15:15:49.000000000 +0200
> +++ 2.6.17-rc4-unwind-generic/kernel/module.c	2006-05-16 08:46:46.000000000 +0200
> @@ -43,6 +43,9 @@
>  #include <asm/uaccess.h>
>  #include <asm/semaphore.h>
>  #include <asm/cacheflush.h>
> +#ifdef MODULE_UNWIND_INFO
> +#include <asm/unwind.h>
> +#endif

It should be possible to include this without the ifdef, no?

>  
>  #if 0
>  #define DEBUGP printk
> @@ -1051,6 +1054,10 @@ static void free_module(struct module *m
>  	remove_sect_attrs(mod);
>  	mod_kobject_remove(mod);
>  
> +#ifdef MODULE_UNWIND_INFO
> +	unwind_remove_table(mod->unwind_info, 0);
> +#endif

Might be better to stub it in the include

> +#define FIELD_SIZEOF(t, f) (sizeof(((t*)0)->f))
> +#define VALUE_BUILD_BUG_ON(e) (sizeof(char[1 - 2 * !!(e)]))

Can you move those to kernel.h. Maybe with a short comment for the later.

> +#define EXTRA_INFO(f) { \
> +		VALUE_BUILD_BUG_ON(offsetof(struct unwind_frame_info, f) \
> +		                   % FIELD_SIZEOF(struct unwind_frame_info, f)) \
> +		* offsetof(struct unwind_frame_info, f) / FIELD_SIZEOF(struct unwind_frame_info, f), \
> +		FIELD_SIZEOF(struct unwind_frame_info, f) \
> +	}
> +#define PTREGS_INFO(f) EXTRA_INFO(regs.f)
> +
> +static const struct {
> +	unsigned offs:BITS_PER_LONG / 2;
> +	unsigned width:BITS_PER_LONG / 2;
> +} reg_info[] = {
> +	UNW_REGISTER_INFO
> +};
> +
> +#undef PTREGS_INFO
> +#undef EXTRA_INFO

Where are they actually used?  I can't find UNW_REGISTER_INFO 
in the patch.

In general it looks a bit overcomplicated. Can you just
use the values directly in the unwinder code?

> +
> +#ifndef REG_INVALID

Who would set it?

> +#define REG_INVALID(r) (reg_info[r].width == 0)
> +#endif
> +
> +#define DW_CFA_nop                          0x00

I guess it would be useful to have them in some include.
Maybe linux/dwarf2.h ?

> +DEFINE_SPINLOCK(table_lock);
> +static atomic_t lookups, removals;
> +
> +static struct unwind_table {
> +	struct {
> +		unsigned long pc;
> +		unsigned long range;
> +	} core, init;
> +	const void *address;
> +	unsigned long size;
> +	struct unwind_table *link;
> +	atomic_t users;
> +	const char *name;
> +} root_table, *last_table;
> +
> +struct unwind_item {
> +	enum item_location {
> +		Nowhere,
> +		Memory,
> +		Register,
> +		Value
> +	} where;
> +	uleb128_t value;
> +};
> +
> +struct unwind_state {
> +	uleb128_t loc, org;
> +	const uint8_t *cieStart, *cieEnd;
> +	uleb128_t codeAlign;
> +	sleb128_t dataAlign;
> +	struct cfa {
> +		uleb128_t reg, offs;
> +	} cfa;
> +	struct unwind_item regs[ARRAY_SIZE(reg_info)];
> +	unsigned stackDepth:8;
> +	unsigned version:8;
> +	const uint8_t *label;
> +	const uint8_t *stack[MAX_STACK_DEPTH];

In general please replace all uintN_t with uN 

> +};
> +
> +static const struct cfa badCFA = {ARRAY_SIZE(reg_info), 1};

White space after { 

> +
> +static struct unwind_table *
> +find_table(unsigned long pc)

Should be on one line. More further down.

> +{
> +	int old_removals;
> +	struct unwind_table *table = NULL;
> +
> +	do {
> +		if (table)
> +				atomic_dec(&table->users);
> +		old_removals = atomic_read(&removals);
> +		atomic_inc(&lookups);
> +		for (table = &root_table; table; table = table->link)
> +			if ((pc >= table->core.pc && pc < table->core.pc + table->core.range)
> +			    || (pc >= table->init.pc && pc < table->init.pc + table->init.range)) {
And should fit on 80 chars.
> +				atomic_inc(&table->users);
> +				break;
> +			}
> +		atomic_dec(&lookups);
> +	} while (atomic_read(&removals) != old_removals);

This looks like a seq lock? Use the real thing? 

 
> +	return table;
> +}
> +
> +static void
> +drop_table(struct unwind_table *table)
> +{
> +	if (table)
> +		atomic_dec(&table->users);
> +}
> +
> +static void
> +init_unwind_table (struct unwind_table *table, const char *name,

No space before (

> +                   const void *core_start, unsigned long core_size,
> +                   const void *init_start, unsigned long init_size,
> +                   const void *table_start, unsigned long table_size)
> +{

A function with that many arguments scares me. But ok.

> +	table = kmalloc(sizeof(*table), GFP_USER);

GFP_KERNEL.

> +	if (!table)
> +		return NULL;
> +
> +	init_unwind_table(table, module->name,
> +	                  module->module_core, module->core_size,
> +	                  module->module_init, module->init_size,
> +	                  table_start, table_size);
> +
> +	spin_lock(&table_lock);
> +	if (last_table)
> +		last_table->link = table;
> +	else
> +		root_table.link = table;
> +	last_table = table;
> +	spin_unlock(&table_lock);
> +
> +	return table;
> +}
> +
> +void
> +unwind_remove_table(void *handle, int init_only)
> +{
> +	struct unwind_table *table = handle, *prev;
> +
> +	if (!table || table == &root_table)
> +		return;
> +
> +	if (init_only && table == last_table) {
> +		table->init.pc = 0;
> +		table->init.range = 0;
> +		return;
> +	}
> +
> +	spin_lock(&table_lock);
> +	for (prev = &root_table; prev->link && prev->link != table; prev = prev->link)
> +		;
> +	if (prev->link) {
> +		if (init_only) {
> +			table->init.pc = 0;
> +			table->init.range = 0;
> +			table = NULL;
> +		} else {
> +			prev->link = table->link;
> +			if (!prev->link)
> +				last_table = prev;
> +			atomic_inc(&removals);
> +		}
> +	} else
> +		table = NULL;
> +	spin_unlock(&table_lock);
> +
> +	if (table) {
> +		while (atomic_read(&table->users) || atomic_read(&lookups))
> +			msleep(1);

Can't this livelock? 

I suspect it isn't needed anyways because module unload uses stop_machine()
already and that should be enough to stop the lockups which don't block.



Please use /* */ comments

> +		if (((const char *)(cie + 2))[1] == 'z') {
> +			uleb128_t augSize = get_uleb128(&ptr, end);
> +
> +			if ((ptr += augSize) > end)
> +				fde = NULL;
> +		}
> +	}
> +	if (cie == NULL || fde == NULL) {
> +#ifdef UNW_FP

This should be CONFIG_FRAME_POINTER

> +		unsigned long top, bottom;
> +#endif
> +
> +		drop_table(table);
> +#ifdef UNW_FP
> +		top = STACK_TOP(frame->task);
> +		bottom = STACK_BOTTOM(frame->task);
> +# if FRAME_RETADDR_OFFSET < 0

Nasty ifdefs. Can you perhaps isolate that < 0 case in a separate function. Also
when does it happen anyways? A little bit cleanup here would be good.

> +			switch(reg_info[state.regs[i].value].width) {
> +#define CASE(n) \
> +			case sizeof(uint##n##_t): \
> +				state.regs[i].value = FRAME_REG(state.regs[i].value, const uint##n##_t); \

80 characters.




> +EXPORT_SYMBOL_GPL(unwind_init_frame_info);

I would actually use EXPORT_SYMBOL().  Would be unfair to not give an unwinder
to any modules.


>  config UNWIND_INFO
>  	bool "Compile the kernel with frame unwind information"
> -	depends on !IA64
> +	depends on !IA64 && !PARISC

Why PARISC?

>  	depends on !MODULES || !(MIPS || PARISC || PPC || SUPERH || SPARC64 || V850)
>  	help
>  	  If you say Y here the resulting kernel image will be slightly larger
> @@ -196,6 +196,14 @@ config UNWIND_INFO
>  	  If you don't debug the kernel, you can say N, but we may not be able
>  	  to solve problems without frame unwind information or frame pointers.
>  
> +config STACK_UNWIND
> +	bool "Stack unwind support"
> +	depends on UNWIND_INFO
> +	depends on n
> +	help
> +	  This enables more precise stack traces, omitting all unrelated
> +	  occurrences of pointers into kernel code from the dump.
>  config FORCED_INLINING
>  	bool "Force gcc to inline functions marked 'inline'"
>  	depends on DEBUG_KERNEL

First again please make sure it's not enabled before it's complete.

Hmm, I assume you tested it, but it's unclear to me where the eh_frame is stored
in the x86-64 vmlinux.lds. There is no entry? Hopefully it's not after _end. 

-Andi

 
