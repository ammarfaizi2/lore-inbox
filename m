Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261945AbSIYItJ>; Wed, 25 Sep 2002 04:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261947AbSIYItJ>; Wed, 25 Sep 2002 04:49:09 -0400
Received: from mx1.elte.hu ([157.181.1.137]:25777 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261945AbSIYItA>;
	Wed, 25 Sep 2002 04:49:00 -0400
Date: Wed, 25 Sep 2002 11:02:39 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: [ANNOUNCE] [patch] kksymoops, in-kernel symbolic oopser, 2.5.38-B0
Message-ID: <Pine.LNX.4.44.0209251051190.6169-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch is the latest version of 'kksymoops' for the 2.5
kernel. Kksymoops is an in-kernel symbol resolver, which enables nifty
things like:

 - in-kernel symbolic oopses, symbolic show_stack() and symbolic
   show_trace(). Finally correct symbolic oopses over serial consoles or
   netdump.

 - module symbols are correctly decoded as well. Ie. all the userspace
   oops decoding mismatches are solved, which can arise if a kernel
   crashes and another kernel (with different module symbols) is booted.
   How do you find out the symbols that a particular crashed kernel had?

 - list of modules are printed upon oopsing - this clearly puts every
   crash into perspective - exactly which modules were loaded ...

a sample kksym-oops as it goes straight into the kernel log:

------------[ cut here ]------------
kernel BUG at time.c:100!
invalid operand: 0000
CPU:    1
EIP:    0060:[<c011bc64>]    Not tainted
EFLAGS: 00010246
EIP is at sys_gettimeofday [kernel] 0x84
eax: 0000004e   ebx: ceea0000   ecx: 00000000   edx: 00000068
esi: 00000000   edi: 00000000   ebp: bffffad8   esp: ceea1fa0
ds: 0068   es: 0068   ss: 0068
Process gettimeofday (pid: 547, threadinfo=ceea0000 task=cef2b0c0)
Stack: 00000001 00000004 40156154 00000004 c0112a40 ceea0000 400168e4 bffffb44
       c0107973 00000000 00000000 40156154 400168e4 bffffb44 bffffad8 0000004e
       0000002b 0000002b 0000004e 400cecc1 00000023 00000246 bffffacc 0000002b
Call Trace: [<c0112a40>] do_page_fault [kernel] 0x0
[<c0107973>] syscall_call [kernel] 0x7
Code: 0f 0b 64 00 67 b4 26 c0 eb b6 89 f6 83 ec 0c 89 5c 24 04 8b

ie. all symbols resolved properly.

i believe it's all for the better, much of the above featureset is also
based on distributors' daily experience of how users report crashes and
how it can be made sense of post-mortem. Tester feedback is often a scarce
resource for distributors, so improving the quality of individual reports
is of high importance. Even here on lkml the quality of oops reporting is
often surprisingly low, especially taking the many years of education into
account.

the cost of the feature is an in-kernel copy of the symbol table - most
testers will not care, and it's default-disabled in the .config. This
patch has proven to be very useful in my daily kernel development
activities, hopefully others will find this just as useful.

I've tested the patch on x86, building and oopsing works both with
kksymoops enabled and disabled.

The line of credit for kksymoops goes like this: Arjan took Keith's
original kallsyms work and extended it to the area of kernel oopsing and
stack trace printing - this was the 2.4 kksymoops patch. Which i ported to
2.5 and added some minor fixes, which Kai improved significantly -
essencially Kai rewrote much of the original patch - it's now a nice patch
that fits into the 2.5 build system properly.

Here's an (incomplete) list of Kai's changes:

o switched from a four-stage to a two-stage process.

o moved the new __kallsyms section to the end of vmlinux, so adding this
  section it shouldn't affect the addresses of the other symbols, which
  are lower.

o only zero out the actual .bss

o move print_modules() into module.c - it doesn't really have anything 
  to do with kallsyms. Also, since it provides a large buffer, I made it
  actually use it, not truncate to 80 chars (maybe truncating makes sense,
  but then one should resize the buffer)

o move lookup_symbol() into module.c - it's also useful when 
  CONFIG_KALLSYMS is not set (and I killed the ifdefs from kallsyms.c, we
  now only compile it depending on CONFIG_KALLSYMS). When it cannot
  resolve symbols using kallsyms, it still tries to use the list of 
  exported symbols (that's  somewhat better than nothing, but not sure 
  if really useful)

o kallsyms.c used some rather twisted way to get the list of modules
  ("module_list") instead of just using the global symbol defined in
  kernel/module.c, so I threw that code out.
  kallsyms.c provides three functions, only one of which is actually used
  for kksymoops - I left them all in unconditionally, though, I think
  kdb or sth uses them.

o __{start,stop}___kallsyms needs to be exported, since insmod looks
  for these symbols to determine if the kernel has kallsyms support
  (and if so, automatically adds the information to the module inserted)

--- linux/arch/i386/kernel/head.S.orig	Fri Sep 20 17:20:16 2002
+++ linux/arch/i386/kernel/head.S	Wed Sep 25 10:49:32 2002
@@ -121,7 +121,7 @@
  */
 	xorl %eax,%eax
 	movl $__bss_start,%edi
-	movl $_end,%ecx
+	movl $__bss_stop,%ecx
 	subl %edi,%ecx
 	rep
 	stosb
--- linux/arch/i386/kernel/process.c.orig	Wed Sep 25 10:49:32 2002
+++ linux/arch/i386/kernel/process.c	Wed Sep 25 10:49:32 2002
@@ -159,14 +159,12 @@
 void show_regs(struct pt_regs * regs)
 {
 	unsigned long cr0 = 0L, cr2 = 0L, cr3 = 0L, cr4 = 0L;
-	static char buffer[MAX_SYMBOL_SIZE];
 
 	printk("\n");
 	printk("Pid: %d, comm: %20s\n", current->pid, current->comm);
 	printk("EIP: %04x:[<%08lx>] CPU: %d",0xffff & regs->xcs,regs->eip, smp_processor_id());
+	print_symbol("EIP is at %s\n", regs->eip);
 
-	lookup_symbol(regs->eip, buffer, MAX_SYMBOL_SIZE);
-	printk("\nEIP is at %s \n", buffer);
 	if (regs->xcs & 3)
 		printk(" ESP: %04x:%08lx",0xffff & regs->xss,regs->esp);
 	printk(" EFLAGS: %08lx    %s\n",regs->eflags, print_tainted());
--- linux/arch/i386/kernel/traps.c.orig	Wed Sep 25 10:49:32 2002
+++ linux/arch/i386/kernel/traps.c	Wed Sep 25 10:49:32 2002
@@ -132,8 +132,6 @@
 {
 	int i;
 	unsigned long addr;
-	/* static to not take up stackspace; if we race here too bad */
-	static char buffer[MAX_SYMBOL_SIZE];
 
 	if (!stack)
 		stack = (unsigned long*)&stack;
@@ -143,9 +141,12 @@
 	while (((long) stack & (THREAD_SIZE-1)) != 0) {
 		addr = *stack++;
 		if (kernel_text_address(addr)) {
-			lookup_symbol(addr, buffer, MAX_SYMBOL_SIZE);
-			printk("[<%08lx>] %s \n", addr,buffer);
-			i++;
+			printk("[<%08lx>] ", addr);
+			if (print_symbol("%s\n", addr)) {
+				/* save screen space */
+				if ((i++ % 6) == 0)
+					printk("\n   ");
+			}
 		}
 	}
 	printk("\n");
@@ -198,7 +199,6 @@
 	int in_kernel = 1;
 	unsigned long esp;
 	unsigned short ss;
-	static char buffer[MAX_SYMBOL_SIZE];
 
 	esp = (unsigned long) (&regs->esp);
 	ss = __KERNEL_DS;
@@ -207,12 +207,11 @@
 		esp = regs->esp;
 		ss = regs->xss & 0xffff;
 	}
-
 	print_modules();
-	lookup_symbol(regs->eip, buffer, MAX_SYMBOL_SIZE);
 	printk("CPU:    %d\nEIP:    %04x:[<%08lx>]    %s\nEFLAGS: %08lx\n",
 		smp_processor_id(), 0xffff & regs->xcs, regs->eip, print_tainted(), regs->eflags);
-	printk("\nEIP is at %s \n",buffer);
+
+	print_symbol("EIP is at %s\n", regs->eip);
 	printk("eax: %08lx   ebx: %08lx   ecx: %08lx   edx: %08lx\n",
 		regs->eax, regs->ebx, regs->ecx, regs->edx);
 	printk("esi: %08lx   edi: %08lx   ebp: %08lx   esp: %08lx\n",
--- linux/arch/i386/Config.help.orig	Fri Sep 20 17:20:16 2002
+++ linux/arch/i386/Config.help	Wed Sep 25 10:49:32 2002
@@ -946,6 +946,11 @@
   of the BUG call as well as the EIP and oops trace.  This aids
   debugging but costs about 70-100K of memory.
 
+CONFIG_KALLSYMS
+  Say Y here to let the kernel print out symbolic crash information and
+  symbolic stack backtraces. This increases the size of the kernel
+  somewhat, as all symbols have to be loaded into the kernel image.
+
 CONFIG_DEBUG_OBSOLETE
   Say Y here if you want to reduce the chances of the tree compiling,
   and are prepared to dig into driver internals to fix compile errors.
--- linux/arch/i386/config.in.orig	Wed Sep 25 10:28:11 2002
+++ linux/arch/i386/config.in	Wed Sep 25 10:49:32 2002
@@ -435,6 +435,7 @@
    if [ "$CONFIG_HIGHMEM" = "y" ]; then
       bool '  Highmem debugging' CONFIG_DEBUG_HIGHMEM
    fi
+   bool '  Load all symbols for debugging/kksymoops' CONFIG_KALLSYMS
 fi
 
 if [ "$CONFIG_X86_LOCAL_APIC" = "y" ]; then
--- linux/arch/i386/vmlinux.lds.S.orig	Fri Sep 20 17:20:19 2002
+++ linux/arch/i386/vmlinux.lds.S	Wed Sep 25 10:49:32 2002
@@ -78,9 +78,13 @@
   .data.cacheline_aligned : { *(.data.cacheline_aligned) }
 
   __bss_start = .;		/* BSS */
-  .bss : {
-	*(.bss)
-	}
+  .bss : { *(.bss) }
+  __bss_stop = .; 
+
+  __start___kallsyms = .;     /* All kernel symbols */
+  __kallsyms : { *(__kallsyms) }
+  __stop___kallsyms = .;
+
   _end = . ;
 
   /* Sections to be discarded */
--- linux/include/linux/kallsyms.h.orig	Wed Sep 25 10:49:32 2002
+++ linux/include/linux/kallsyms.h	Wed Sep 25 10:49:32 2002
@@ -0,0 +1,163 @@
+/* kallsyms headers
+   Copyright 2000 Keith Owens <kaos@ocs.com.au>
+
+   This file is part of the Linux modutils.  It is exported to kernel
+   space so debuggers can access the kallsyms data.
+
+   The kallsyms data contains all the non-stack symbols from a kernel
+   or a module.  The kernel symbols are held between __start___kallsyms
+   and __stop___kallsyms.  The symbols for a module are accessed via
+   the struct module chain which is based at module_list.
+
+   This program is free software; you can redistribute it and/or modify it
+   under the terms of the GNU General Public License as published by the
+   Free Software Foundation; either version 2 of the License, or (at your
+   option) any later version.
+
+   This program is distributed in the hope that it will be useful, but
+   WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program; if not, write to the Free Software Foundation,
+   Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#ident "$Id: linux-2.4.9-kallsyms.patch,v 1.8 2002/02/11 18:34:53 arjanv Exp $"
+
+#ifndef MODUTILS_KALLSYMS_H
+#define MODUTILS_KALLSYMS_H 1
+
+/* Have to (re)define these ElfW entries here because external kallsyms
+ * code does not have access to modutils/include/obj.h.  This code is
+ * included from user spaces tools (modutils) and kernel, they need
+ * different includes.
+ */
+
+#ifndef ELFCLASS32
+#ifdef __KERNEL__
+#include <linux/elf.h>
+#else	/* __KERNEL__ */
+#include <elf.h>
+#endif	/* __KERNEL__ */
+#endif	/* ELFCLASS32 */
+
+#ifndef ELFCLASSM
+#define ELFCLASSM ELF_CLASS
+#endif
+
+#ifndef ElfW
+# if ELFCLASSM == ELFCLASS32
+#  define ElfW(x)  Elf32_ ## x
+#  define ELFW(x)  ELF32_ ## x
+# else
+#  define ElfW(x)  Elf64_ ## x
+#  define ELFW(x)  ELF64_ ## x
+# endif
+#endif
+
+/* Format of data in the kallsyms section.
+ * Most of the fields are small numbers but the total size and all
+ * offsets can be large so use the 32/64 bit types for these fields.
+ *
+ * Do not use sizeof() on these structures, modutils may be using extra
+ * fields.  Instead use the size fields in the header to access the
+ * other bits of data.
+ */  
+
+struct kallsyms_header {
+	int		size;		/* Size of this header */
+	ElfW(Word)	total_size;	/* Total size of kallsyms data */
+	int		sections;	/* Number of section entries */
+	ElfW(Off)	section_off;	/* Offset to first section entry */
+	int		section_size;	/* Size of one section entry */
+	int		symbols;	/* Number of symbol entries */
+	ElfW(Off)	symbol_off;	/* Offset to first symbol entry */
+	int		symbol_size;	/* Size of one symbol entry */
+	ElfW(Off)	string_off;	/* Offset to first string */
+	ElfW(Addr)	start;		/* Start address of first section */
+	ElfW(Addr)	end;		/* End address of last section */
+};
+
+struct kallsyms_section {
+	ElfW(Addr)	start;		/* Start address of section */
+	ElfW(Word)	size;		/* Size of this section */
+	ElfW(Off)	name_off;	/* Offset to section name */
+	ElfW(Word)	flags;		/* Flags from section */
+};
+
+struct kallsyms_symbol {
+	ElfW(Off)	section_off;	/* Offset to section that owns this symbol */
+	ElfW(Addr)	symbol_addr;	/* Address of symbol */
+	ElfW(Off)	name_off;	/* Offset to symbol name */
+};
+
+#define KALLSYMS_SEC_NAME "__kallsyms"
+#define KALLSYMS_IDX 2			/* obj_kallsyms creates kallsyms as section 2 */
+
+#define kallsyms_next_sec(h,s) \
+	((s) = (struct kallsyms_section *)((char *)(s) + (h)->section_size))
+#define kallsyms_next_sym(h,s) \
+	((s) = (struct kallsyms_symbol *)((char *)(s) + (h)->symbol_size))
+
+#ifdef CONFIG_KALLSYMS
+
+int kallsyms_symbol_to_address(
+	const char       *name,			/* Name to lookup */
+	unsigned long    *token,		/* Which module to start with */
+	const char      **mod_name,		/* Set to module name or "kernel" */
+	unsigned long    *mod_start,		/* Set to start address of module */
+	unsigned long    *mod_end,		/* Set to end address of module */
+	const char      **sec_name,		/* Set to section name */
+	unsigned long    *sec_start,		/* Set to start address of section */
+	unsigned long    *sec_end,		/* Set to end address of section */
+	const char      **sym_name,		/* Set to full symbol name */
+	unsigned long    *sym_start,		/* Set to start address of symbol */
+	unsigned long    *sym_end		/* Set to end address of symbol */
+	);
+
+int kallsyms_address_to_symbol(
+	unsigned long     address,		/* Address to lookup */
+	const char      **mod_name,		/* Set to module name */
+	unsigned long    *mod_start,		/* Set to start address of module */
+	unsigned long    *mod_end,		/* Set to end address of module */
+	const char      **sec_name,		/* Set to section name */
+	unsigned long    *sec_start,		/* Set to start address of section */
+	unsigned long    *sec_end,		/* Set to end address of section */
+	const char      **sym_name,		/* Set to full symbol name */
+	unsigned long    *sym_start,		/* Set to start address of symbol */
+	unsigned long    *sym_end		/* Set to end address of symbol */
+	);
+
+int kallsyms_sections(void *token,
+		      int (*callback)(void *,	/* token */
+		      	const char *,		/* module name */
+			const char *,		/* section name */
+			ElfW(Addr),		/* Section start */
+			ElfW(Addr),		/* Section end */
+			ElfW(Word)		/* Section flags */
+		      )
+		);
+
+#else
+
+static inline int kallsyms_address_to_symbol(
+	unsigned long     address,		/* Address to lookup */
+	const char      **mod_name,		/* Set to module name */
+	unsigned long    *mod_start,		/* Set to start address of module */
+	unsigned long    *mod_end,		/* Set to end address of module */
+	const char      **sec_name,		/* Set to section name */
+	unsigned long    *sec_start,		/* Set to start address of section */
+	unsigned long    *sec_end,		/* Set to end address of section */
+	const char      **sym_name,		/* Set to full symbol name */
+	unsigned long    *sym_start,		/* Set to start address of symbol */
+	unsigned long    *sym_end		/* Set to end address of symbol */
+	)
+{
+	return -ESRCH;
+}
+
+#endif
+
+#endif /* kallsyms.h */
--- linux/include/linux/module.h.orig	Wed Sep 25 10:49:32 2002
+++ linux/include/linux/module.h	Wed Sep 25 10:49:32 2002
@@ -504,19 +504,26 @@
 #define SET_MODULE_OWNER(some_struct) do { } while (0)
 #endif
 
+extern void print_modules(void);
+
 #if defined(CONFIG_MODULES) || defined(CONFIG_KALLSYMS)
 
 extern struct module *module_list;
 
-extern int lookup_symbol(unsigned long address, char *buffer, int buflen);
+/*
+ * print_symbols takes a format string containing one %s.
+ * If support for resolving symbols is compiled in, the %s will
+ * be replaced by the closest symbol to the address and the entire
+ * string is printk()ed. Otherwise, nothing is printed.
+ */
+extern int print_symbol(const char *fmt, unsigned long address);
 
 #else
 
 static inline int
-lookup_symbol(unsigned long address, char *buffer, int buflen)
+print_symbol(const char *fmt, unsigned long address)
 {
-	buffer[0] = 0;
-	return 0;
+	return -ESRCH;
 }
 
 #endif
--- linux/include/linux/sched.h.orig	Wed Sep 25 10:49:32 2002
+++ linux/include/linux/sched.h	Wed Sep 25 10:49:32 2002
@@ -152,12 +152,9 @@
 extern void sched_init(void);
 extern void init_idle(task_t *idle, int cpu);
 
-#define MAX_SYMBOL_SIZE 512
-
 extern void show_state(void);
 extern void show_trace(unsigned long *stack);
 extern void show_stack(unsigned long *stack);
-extern void print_modules(void);
 extern void show_regs(struct pt_regs *);
 
 
--- linux/include/asm-i386/hardirq.h.orig	Fri Sep 20 17:20:32 2002
+++ linux/include/asm-i386/hardirq.h	Wed Sep 25 10:49:32 2002
@@ -97,6 +97,4 @@
   extern void synchronize_irq(unsigned int irq);
 #endif /* CONFIG_SMP */
 
-extern void show_stack(unsigned long * esp);
-
 #endif /* __ASM_HARDIRQ_H */
--- linux/include/asm-i386/ptrace.h.orig	Fri Sep 20 17:20:16 2002
+++ linux/include/asm-i386/ptrace.h	Wed Sep 25 10:49:32 2002
@@ -57,7 +57,6 @@
 #ifdef __KERNEL__
 #define user_mode(regs) ((VM_MASK & (regs)->eflags) || (3 & (regs)->xcs))
 #define instruction_pointer(regs) ((regs)->eip)
-extern void show_regs(struct pt_regs *);
 #endif
 
 #endif
--- linux/kernel/Makefile.orig	Fri Sep 20 17:20:19 2002
+++ linux/kernel/Makefile	Wed Sep 25 10:49:32 2002
@@ -3,7 +3,7 @@
 #
 
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-		printk.o platform.o suspend.o dma.o
+	      printk.o platform.o suspend.o dma.o module.o
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
@@ -14,6 +14,7 @@
 obj-$(CONFIG_SMP) += cpu.o
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
+obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_PM) += pm.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
--- linux/kernel/kallsyms.c.orig	Wed Sep 25 10:49:32 2002
+++ linux/kernel/kallsyms.c	Wed Sep 25 10:49:32 2002
@@ -0,0 +1,227 @@
+/*
+ * kksymoops.c: in-kernel printing of symbolic oopses and stack traces.
+ *
+ *  Copyright 2000 Keith Owens <kaos@ocs.com.au> April 2000
+ *  Copyright 2002 Arjan van de Ven <arjanv@redhat.com>
+ *
+   This code uses the list of all kernel and module symbols to :-
+
+   * Find any non-stack symbol in a kernel or module.  Symbols do
+     not have to be exported for debugging.
+
+   * Convert an address to the module (or kernel) that owns it, the
+     section it is in and the nearest symbol.  This finds all non-stack
+     symbols, not just exported ones.
+
+ */
+
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/kallsyms.h>
+
+/* A symbol can appear in more than one module.  A token is used to
+ * restart the scan at the next module, set the token to 0 for the
+ * first scan of each symbol.
+ */
+
+int kallsyms_symbol_to_address(
+	const char	 *name,		/* Name to lookup */
+	unsigned long 	 *token,	/* Which module to start at */
+	const char	**mod_name,	/* Set to module name */
+	unsigned long 	 *mod_start,	/* Set to start address of module */
+	unsigned long 	 *mod_end,	/* Set to end address of module */
+	const char	**sec_name,	/* Set to section name */
+	unsigned long 	 *sec_start,	/* Set to start address of section */
+	unsigned long 	 *sec_end,	/* Set to end address of section */
+	const char	**sym_name,	/* Set to full symbol name */
+	unsigned long 	 *sym_start,	/* Set to start address of symbol */
+	unsigned long 	 *sym_end	/* Set to end address of symbol */
+	)
+{
+	const struct kallsyms_header	*ka_hdr = NULL;	/* stupid gcc */
+	const struct kallsyms_section	*ka_sec;
+	const struct kallsyms_symbol	*ka_sym = NULL;
+	const char			*ka_str = NULL;
+	const struct module *m;
+	int i = 0, l;
+	const char *p, *pt_R;
+	char *p2;
+
+	/* Restart? */
+	m = module_list;
+	if (token && *token) {
+		for (; m; m = m->next)
+			if ((unsigned long)m == *token)
+				break;
+		if (m)
+			m = m->next;
+	}
+
+	for (; m; m = m->next) {
+		if (!mod_member_present(m, kallsyms_start) || 
+		    !mod_member_present(m, kallsyms_end) ||
+		    m->kallsyms_start >= m->kallsyms_end)
+			continue;
+		ka_hdr = (struct kallsyms_header *)m->kallsyms_start;
+		ka_sym = (struct kallsyms_symbol *)
+			((char *)(ka_hdr) + ka_hdr->symbol_off);
+		ka_str = 
+			((char *)(ka_hdr) + ka_hdr->string_off);
+		for (i = 0; i < ka_hdr->symbols; ++i, kallsyms_next_sym(ka_hdr, ka_sym)) {
+			p = ka_str + ka_sym->name_off;
+			if (strcmp(p, name) == 0)
+				break;
+			/* Unversioned requests match versioned names */
+			if (!(pt_R = strstr(p, "_R")))
+				continue;
+			l = strlen(pt_R);
+			if (l < 10)
+				continue;	/* Not _R.*xxxxxxxx */
+			(void)simple_strtoul(pt_R+l-8, &p2, 16);
+			if (*p2)
+				continue;	/* Not _R.*xxxxxxxx */
+			if (strncmp(p, name, pt_R-p) == 0)
+				break;	/* Match with version */
+		}
+		if (i < ka_hdr->symbols)
+			break;
+	}
+
+	if (token)
+		*token = (unsigned long)m;
+	if (!m)
+		return(0);	/* not found */
+
+	ka_sec = (const struct kallsyms_section *)
+		((char *)ka_hdr + ka_hdr->section_off + ka_sym->section_off);
+	*mod_name = *(m->name) ? m->name : "kernel";
+	*mod_start = ka_hdr->start;
+	*mod_end = ka_hdr->end;
+	*sec_name = ka_sec->name_off + ka_str;
+	*sec_start = ka_sec->start;
+	*sec_end = ka_sec->start + ka_sec->size;
+	*sym_name = ka_sym->name_off + ka_str;
+	*sym_start = ka_sym->symbol_addr;
+	if (i < ka_hdr->symbols-1) {
+		const struct kallsyms_symbol *ka_symn = ka_sym;
+		kallsyms_next_sym(ka_hdr, ka_symn);
+		*sym_end = ka_symn->symbol_addr;
+	}
+	else
+		*sym_end = *sec_end;
+	return(1);
+}
+
+int kallsyms_address_to_symbol(
+	unsigned long	  address,	/* Address to lookup */
+	const char	**mod_name,	/* Set to module name */
+	unsigned long 	 *mod_start,	/* Set to start address of module */
+	unsigned long 	 *mod_end,	/* Set to end address of module */
+	const char	**sec_name,	/* Set to section name */
+	unsigned long 	 *sec_start,	/* Set to start address of section */
+	unsigned long 	 *sec_end,	/* Set to end address of section */
+	const char	**sym_name,	/* Set to full symbol name */
+	unsigned long 	 *sym_start,	/* Set to start address of symbol */
+	unsigned long 	 *sym_end	/* Set to end address of symbol */
+	)
+{
+	const struct kallsyms_header	*ka_hdr = NULL;	/* stupid gcc */
+	const struct kallsyms_section	*ka_sec = NULL;
+	const struct kallsyms_symbol	*ka_sym;
+	const char			*ka_str;
+	const struct module *m;
+	int i;
+	unsigned long end;
+
+	for (m = module_list; m; m = m->next) {
+	  
+		if (!mod_member_present(m, kallsyms_start) || 
+		    !mod_member_present(m, kallsyms_end) ||
+		    m->kallsyms_start >= m->kallsyms_end)
+			continue;
+		ka_hdr = (struct kallsyms_header *)m->kallsyms_start;
+		ka_sec = (const struct kallsyms_section *)
+			((char *)ka_hdr + ka_hdr->section_off);
+		/* Is the address in any section in this module? */
+		for (i = 0; i < ka_hdr->sections; ++i, kallsyms_next_sec(ka_hdr, ka_sec)) {
+			if (ka_sec->start <= address &&
+			    (ka_sec->start + ka_sec->size) > address)
+				break;
+		}
+		if (i < ka_hdr->sections)
+			break;	/* Found a matching section */
+	}
+
+	if (!m)
+		return(0);	/* not found */
+
+	ka_sym = (struct kallsyms_symbol *)
+		((char *)(ka_hdr) + ka_hdr->symbol_off);
+	ka_str = 
+		((char *)(ka_hdr) + ka_hdr->string_off);
+	*mod_name = m->name;
+	*mod_start = ka_hdr->start;
+	*mod_end = ka_hdr->end;
+	*sec_name = ka_sec->name_off + ka_str;
+	*sec_start = ka_sec->start;
+	*sec_end = ka_sec->start + ka_sec->size;
+	*sym_name = *sec_name;		/* In case we find no matching symbol */
+	*sym_start = *sec_start;
+	*sym_end = *sec_end;
+
+	for (i = 0; i < ka_hdr->symbols; ++i, kallsyms_next_sym(ka_hdr, ka_sym)) {
+		if (ka_sym->symbol_addr > address)
+			continue;
+		if (i < ka_hdr->symbols-1) {
+			const struct kallsyms_symbol *ka_symn = ka_sym;
+			kallsyms_next_sym(ka_hdr, ka_symn);
+			end = ka_symn->symbol_addr;
+		}
+		else
+			end = *sec_end;
+		if (end <= address)
+			continue;
+		if ((char *)ka_hdr + ka_hdr->section_off + ka_sym->section_off
+		    != (char *)ka_sec)
+			continue;	/* wrong section */
+		*sym_name = ka_str + ka_sym->name_off;
+		*sym_start = ka_sym->symbol_addr;
+		*sym_end = end;
+		break;
+	}
+	return(1);
+}
+
+/* List all sections in all modules.  The callback routine is invoked with
+ * token, module name, section name, section start, section end, section flags.
+ */
+int kallsyms_sections(void *token,
+		      int (*callback)(void *, const char *, const char *, ElfW(Addr), ElfW(Addr), ElfW(Word)))
+{
+	const struct kallsyms_header	*ka_hdr = NULL;	/* stupid gcc */
+	const struct kallsyms_section	*ka_sec = NULL;
+	const char			*ka_str;
+	const struct module *m;
+	int i;
+
+	for (m = module_list; m; m = m->next) {
+		if (!mod_member_present(m, kallsyms_start) || 
+		    !mod_member_present(m, kallsyms_end) ||
+		    m->kallsyms_start >= m->kallsyms_end)
+			continue;
+		ka_hdr = (struct kallsyms_header *)m->kallsyms_start;
+		ka_sec = (const struct kallsyms_section *) ((char *)ka_hdr + ka_hdr->section_off);
+		ka_str = ((char *)(ka_hdr) + ka_hdr->string_off);
+		for (i = 0; i < ka_hdr->sections; ++i, kallsyms_next_sec(ka_hdr, ka_sec)) {
+			if (callback(
+				token,
+				*(m->name) ? m->name : "kernel",
+				ka_sec->name_off + ka_str,
+				ka_sec->start,
+				ka_sec->start + ka_sec->size,
+				ka_sec->flags))
+				return(0);
+		}
+	}
+	return(1);
+}
--- linux/kernel/module.c.orig	Wed Sep 25 10:49:32 2002
+++ linux/kernel/module.c	Wed Sep 25 10:49:32 2002
@@ -1305,51 +1305,51 @@
 
 #if defined(CONFIG_MODULES) || defined(CONFIG_KALLSYMS)
 
-int lookup_symbol(unsigned long address, char *buffer, int buflen)
+#define MAX_SYMBOL_SIZE 512
+
+int print_symbol(const char *fmt, unsigned long address)
 {
 	struct module *this_mod;
 	unsigned long bestsofar;
+	/* static to not take up stackspace; if we race here too bad */
+	static char buffer[MAX_SYMBOL_SIZE];
 
 	const char *mod_name = NULL, *sec_name = NULL, *sym_name = NULL;
 	unsigned long mod_start, mod_end, sec_start, sec_end,
 							sym_start, sym_end;
 	
-	if (!buffer)
-		return -EFAULT;
-	
-	if (buflen < 256)
-		return -ENOMEM;
-	
-	memset(buffer, 0, buflen);
+	memset(buffer, 0, MAX_SYMBOL_SIZE);
 
 	if (!kallsyms_address_to_symbol(address,&mod_name,&mod_start,&mod_end,&sec_name, &sec_start, &sec_end, &sym_name, &sym_start, &sym_end)) {
-		/* kallsyms doesn't have a clue; lets try harder */
+		/* kallsyms doesn't have a clue; lets try our list 
+		 * of exported symbols */
 		bestsofar = 0;
-		snprintf(buffer, buflen-1, "[unresolved]");
+		sprintf(buffer, "[unresolved]");
 		
-		this_mod = module_list;
-
-		while (this_mod != NULL) {
+		for (this_mod = module_list; this_mod; this_mod = this_mod->next) {
 			int i;
 			/* walk the symbol list of this module. Only symbols
 			   who's address is smaller than the searched for address
 			   are relevant; and only if it's better than the best so far */
 			for (i = 0; i < this_mod->nsyms; i++)
 				if ((this_mod->syms[i].value <= address) &&
-					(bestsofar<this_mod->syms[i].value)) {
-					snprintf(buffer,buflen-1,"%s [%s] 0x%x",
+				    (bestsofar < this_mod->syms[i].value)) {
+					snprintf(buffer, MAX_SYMBOL_SIZE - 1,
+						 "%s [%s] 0x%x",
 						this_mod->syms[i].name,
 						this_mod->name,
 						(unsigned int)(address - this_mod->syms[i].value));
 					bestsofar = this_mod->syms[i].value;
 				}
-			this_mod = this_mod->next;
 		}
 
-	} else /* kallsyms success */
-		snprintf(buffer,buflen-1,"%s [%s] 0x%x",sym_name,mod_name,(unsigned int)(address-sym_start));
-
-	return strlen(buffer);
+	} else { /* kallsyms success */
+		snprintf(buffer,MAX_SYMBOL_SIZE - 1, "%s [%s] 0x%x",
+			 sym_name, mod_name,
+			 (unsigned int)(address - sym_start));
+	}
+	printk(fmt, buffer);
+	return 0;
 }
 
 #endif
--- linux/Makefile.orig	Wed Sep 25 10:49:32 2002
+++ linux/Makefile	Wed Sep 25 10:49:32 2002
@@ -331,9 +331,13 @@
 .tmp_kallsyms.o: .tmp_vmlinux
 	$(call cmd,kallsyms)
 
+# 	After generating .tmp_vmlinux just like vmlinux, decrement the version
+#	number again, so the final vmlinux gets the same one.
+#	Ignore return value of 'expr'.
+
 define rule_.tmp_vmlinux
 	$(rule_vmlinux)
-	expr 0`cat .version` - 1 > .tmp_version
+	if expr 0`cat .version` - 1 > .tmp_version; then true; fi
 	mv -f .tmp_version .version
 endef
 

