Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262090AbSIYTw5>; Wed, 25 Sep 2002 15:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262091AbSIYTw5>; Wed, 25 Sep 2002 15:52:57 -0400
Received: from mx1.elte.hu ([157.181.1.137]:52875 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262090AbSIYTwp>;
	Wed, 25 Sep 2002 15:52:45 -0400
Date: Wed, 25 Sep 2002 22:04:42 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [ANNOUNCE] [patch] kksymoops, in-kernel symbolic oopser, 2.5.38-B0
In-Reply-To: <Pine.LNX.4.33.0209251250150.2836-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209252159090.19020-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


one config variant (no-modules, no-kksymoops) did not compile due to
linux/errno.h not being included in linux/module.h, the attached patch
does this properly.

	Ingo

--- linux/arch/i386/kernel/head.S.orig	Fri Sep 20 17:20:16 2002
+++ linux/arch/i386/kernel/head.S	Wed Sep 25 21:46:56 2002
@@ -121,7 +121,7 @@
  */
 	xorl %eax,%eax
 	movl $__bss_start,%edi
-	movl $_end,%ecx
+	movl $__bss_stop,%ecx
 	subl %edi,%ecx
 	rep
 	stosb
--- linux/arch/i386/kernel/process.c.orig	Fri Sep 20 17:20:12 2002
+++ linux/arch/i386/kernel/process.c	Wed Sep 25 21:46:56 2002
@@ -33,6 +33,7 @@
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/mc146818rtc.h>
+#include <linux/module.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -155,8 +156,6 @@
 
 __setup("idle=", idle_setup);
 
-extern void show_trace(unsigned long* esp);
-
 void show_regs(struct pt_regs * regs)
 {
 	unsigned long cr0 = 0L, cr2 = 0L, cr3 = 0L, cr4 = 0L;
@@ -164,6 +163,8 @@
 	printk("\n");
 	printk("Pid: %d, comm: %20s\n", current->pid, current->comm);
 	printk("EIP: %04x:[<%08lx>] CPU: %d",0xffff & regs->xcs,regs->eip, smp_processor_id());
+	print_symbol("EIP is at %s\n", regs->eip);
+
 	if (regs->xcs & 3)
 		printk(" ESP: %04x:%08lx",0xffff & regs->xss,regs->esp);
 	printk(" EFLAGS: %08lx    %s\n",regs->eflags, print_tainted());
--- linux/arch/i386/kernel/traps.c.orig	Fri Sep 20 17:20:19 2002
+++ linux/arch/i386/kernel/traps.c	Wed Sep 25 21:46:56 2002
@@ -94,7 +94,6 @@
 
 #ifdef CONFIG_MODULES
 
-extern struct module *module_list;
 extern struct module kernel_module;
 
 static inline int kernel_text_address(unsigned long addr)
@@ -142,10 +141,12 @@
 	while (((long) stack & (THREAD_SIZE-1)) != 0) {
 		addr = *stack++;
 		if (kernel_text_address(addr)) {
-			if (i && ((i % 6) == 0))
-				printk("\n   ");
 			printk("[<%08lx>] ", addr);
-			i++;
+			if (print_symbol("%s\n", addr)) {
+				/* save screen space */
+				if ((i++ % 6) == 0)
+					printk("\n   ");
+			}
 		}
 	}
 	printk("\n");
@@ -206,8 +207,11 @@
 		esp = regs->esp;
 		ss = regs->xss & 0xffff;
 	}
+	print_modules();
 	printk("CPU:    %d\nEIP:    %04x:[<%08lx>]    %s\nEFLAGS: %08lx\n",
 		smp_processor_id(), 0xffff & regs->xcs, regs->eip, print_tainted(), regs->eflags);
+
+	print_symbol("EIP is at %s\n", regs->eip);
 	printk("eax: %08lx   ebx: %08lx   ecx: %08lx   edx: %08lx\n",
 		regs->eax, regs->ebx, regs->ecx, regs->edx);
 	printk("esi: %08lx   edi: %08lx   ebp: %08lx   esp: %08lx\n",
@@ -268,6 +272,7 @@
 		(unsigned long)file < PAGE_OFFSET || __get_user(c, file))
 		file = "<bad filename>";
 
+	printk("------------[ cut here ]------------\n");
 	printk("kernel BUG at %s:%d!\n", file, line);
 
 no_bug:
--- linux/arch/i386/Config.help.orig	Fri Sep 20 17:20:16 2002
+++ linux/arch/i386/Config.help	Wed Sep 25 21:46:56 2002
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
--- linux/arch/i386/config.in.orig	Wed Sep 25 21:43:13 2002
+++ linux/arch/i386/config.in	Wed Sep 25 21:46:56 2002
@@ -435,6 +435,7 @@
    if [ "$CONFIG_HIGHMEM" = "y" ]; then
       bool '  Highmem debugging' CONFIG_DEBUG_HIGHMEM
    fi
+   bool '  Load all symbols for debugging/kksymoops' CONFIG_KALLSYMS
 fi
 
 if [ "$CONFIG_X86_LOCAL_APIC" = "y" ]; then
--- linux/arch/i386/vmlinux.lds.S.orig	Fri Sep 20 17:20:19 2002
+++ linux/arch/i386/vmlinux.lds.S	Wed Sep 25 21:46:56 2002
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
--- linux/include/linux/kallsyms.h.orig	Wed Sep 25 21:46:56 2002
+++ linux/include/linux/kallsyms.h	Wed Sep 25 21:46:56 2002
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
--- linux/include/linux/module.h.orig	Fri Sep 20 17:20:32 2002
+++ linux/include/linux/module.h	Wed Sep 25 22:01:19 2002
@@ -10,6 +10,7 @@
 #include <linux/config.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/errno.h>
 
 #include <asm/atomic.h>
 
@@ -316,8 +317,6 @@
 #define MOD_DEC_USE_COUNT	do { } while (0)
 #define MOD_IN_USE		1
 
-extern struct module *module_list;
-
 #endif /* !__GENKSYMS__ */
 
 #endif /* MODULE */
@@ -504,6 +503,30 @@
 #define SET_MODULE_OWNER(some_struct) do { (some_struct)->owner = THIS_MODULE; } while (0)
 #else
 #define SET_MODULE_OWNER(some_struct) do { } while (0)
+#endif
+
+extern void print_modules(void);
+
+#if defined(CONFIG_MODULES) || defined(CONFIG_KALLSYMS)
+
+extern struct module *module_list;
+
+/*
+ * print_symbols takes a format string containing one %s.
+ * If support for resolving symbols is compiled in, the %s will
+ * be replaced by the closest symbol to the address and the entire
+ * string is printk()ed. Otherwise, nothing is printed.
+ */
+extern int print_symbol(const char *fmt, unsigned long address);
+
+#else
+
+static inline int
+print_symbol(const char *fmt, unsigned long address)
+{
+	return -ESRCH;
+}
+
 #endif
 
 #endif /* _LINUX_MODULE_H */
--- linux/include/linux/sched.h.orig	Wed Sep 25 21:43:13 2002
+++ linux/include/linux/sched.h	Wed Sep 25 21:46:56 2002
@@ -151,7 +151,13 @@
 
 extern void sched_init(void);
 extern void init_idle(task_t *idle, int cpu);
+
 extern void show_state(void);
+extern void show_trace(unsigned long *stack);
+extern void show_stack(unsigned long *stack);
+extern void show_regs(struct pt_regs *);
+
+
 extern void cpu_init (void);
 extern void trap_init(void);
 extern void update_process_times(int user);
--- linux/include/asm-i386/hardirq.h.orig	Fri Sep 20 17:20:32 2002
+++ linux/include/asm-i386/hardirq.h	Wed Sep 25 21:46:56 2002
@@ -97,6 +97,4 @@
   extern void synchronize_irq(unsigned int irq);
 #endif /* CONFIG_SMP */
 
-extern void show_stack(unsigned long * esp);
-
 #endif /* __ASM_HARDIRQ_H */
--- linux/include/asm-i386/ptrace.h.orig	Fri Sep 20 17:20:16 2002
+++ linux/include/asm-i386/ptrace.h	Wed Sep 25 21:46:56 2002
@@ -57,7 +57,6 @@
 #ifdef __KERNEL__
 #define user_mode(regs) ((VM_MASK & (regs)->eflags) || (3 & (regs)->xcs))
 #define instruction_pointer(regs) ((regs)->eip)
-extern void show_regs(struct pt_regs *);
 #endif
 
 #endif
--- linux/kernel/Makefile.orig	Fri Sep 20 17:20:19 2002
+++ linux/kernel/Makefile	Wed Sep 25 21:46:56 2002
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
--- linux/kernel/kallsyms.c.orig	Wed Sep 25 21:46:56 2002
+++ linux/kernel/kallsyms.c	Wed Sep 25 21:51:18 2002
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
+	*mod_name = m->name;
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
--- linux/kernel/module.c.orig	Fri Sep 20 17:20:19 2002
+++ linux/kernel/module.c	Wed Sep 25 21:52:00 2002
@@ -3,6 +3,7 @@
 #include <linux/module.h>
 #include <asm/module.h>
 #include <asm/uaccess.h>
+#include <linux/kallsyms.h>
 #include <linux/vmalloc.h>
 #include <linux/smp_lock.h>
 #include <asm/pgalloc.h>
@@ -39,13 +40,19 @@
 extern const struct exception_table_entry __start___ex_table[];
 extern const struct exception_table_entry __stop___ex_table[];
 
-extern const char __start___kallsyms[] __attribute__ ((weak));
-extern const char __stop___kallsyms[] __attribute__ ((weak));
+extern const char __start___kallsyms[] __attribute__((weak));
+extern const char __stop___kallsyms[] __attribute__((weak));
+
+/* modutils uses these exported symbols to figure out if
+   kallsyms support is present */
+
+EXPORT_SYMBOL(__start___kallsyms);
+EXPORT_SYMBOL(__stop___kallsyms);
 
 struct module kernel_module =
 {
 	.size_of_struct		= sizeof(struct module),
-	.name 			= "",
+	.name 			= NULL,
 	.uc	 		= {ATOMIC_INIT(1)},
 	.flags			= MOD_RUNNING,
 	.syms			= __start___ksymtab,
@@ -1220,6 +1227,30 @@
 	.show	= s_show
 };
 
+#define MODLIST_SIZE 4096
+
+/*
+ * this function isn't smp safe but that's not really a problem; it's
+ * called from oops context only and any locking could actually prevent
+ * the oops from going out; the line that is generated is informational
+ * only and should NEVER prevent the real oops from going out. 
+ */
+void print_modules(void)
+{
+	static char modlist[MODLIST_SIZE];
+	struct module *this_mod;
+	int pos = 0;
+
+	this_mod = module_list;
+	while (this_mod) {
+		if (this_mod->name)
+			pos += snprintf(modlist+pos, MODLIST_SIZE-pos-1, 
+					"%s ", this_mod->name);
+		this_mod = this_mod->next;
+	}
+	printk("%s\n",modlist);
+}
+
 #else		/* CONFIG_MODULES */
 
 /* Dummy syscalls for people who don't want modules */
@@ -1265,4 +1296,79 @@
 	return 1;
 }
 
+void print_modules(void)
+{
+}
+
 #endif	/* CONFIG_MODULES */
+
+
+#if defined(CONFIG_MODULES) || defined(CONFIG_KALLSYMS)
+
+#define MAX_SYMBOL_SIZE 512
+
+static void
+address_to_exported_symbol(unsigned long address, const char **mod_name, 
+			   const char **sym_name, unsigned long *sym_start,
+			   unsigned long *sym_end)
+{
+	struct module *this_mod;
+	int i;
+
+	for (this_mod = module_list; this_mod; this_mod = this_mod->next) {
+		/* walk the symbol list of this module. Only symbols
+		   who's address is smaller than the searched for address
+		   are relevant; and only if it's better than the best so far */
+		for (i = 0; i < this_mod->nsyms; i++)
+			if ((this_mod->syms[i].value <= address) &&
+			    (*sym_start < this_mod->syms[i].value)) {
+				*sym_start = this_mod->syms[i].value;
+				*sym_name  = this_mod->syms[i].name;
+				*mod_name  = this_mod->name;
+				if (i + 1 < this_mod->nsyms)
+					*sym_end = this_mod->syms[i+1].value;
+				else
+					*sym_end = (unsigned long) this_mod + this_mod->size;
+			}
+	}
+}
+
+int
+print_symbol(const char *fmt, unsigned long address)
+{
+	/* static to not take up stackspace; if we race here too bad */
+	static char buffer[MAX_SYMBOL_SIZE];
+
+	const char *mod_name = NULL, *sec_name = NULL, *sym_name = NULL;
+	unsigned long mod_start, mod_end, sec_start, sec_end,
+		sym_start, sym_end;
+	char *tag = "";
+	
+	memset(buffer, 0, MAX_SYMBOL_SIZE);
+
+	sym_start = 0;
+	if (!kallsyms_address_to_symbol(address, &mod_name, &mod_start, &mod_end, &sec_name, &sec_start, &sec_end, &sym_name, &sym_start, &sym_end)) {
+		tag = "E ";
+		address_to_exported_symbol(address, &mod_name, &sym_name, &sym_start, &sym_end);
+	}
+
+	if (sym_start) {
+		if (mod_name)
+		    snprintf(buffer, MAX_SYMBOL_SIZE - 1, "%s%s+%#x/%#x [%s]",
+			 tag, sym_name,
+			 (unsigned int)(address - sym_start),
+			 (unsigned int)(sym_end - sym_start),
+			 mod_name);
+		else
+		    snprintf(buffer, MAX_SYMBOL_SIZE - 1, "%s%s+%#x/%#x",
+			 tag, sym_name,
+			 (unsigned int)(address - sym_start),
+			 (unsigned int)(sym_end - sym_start));
+		printk(fmt, buffer);
+	} else {
+		printk(fmt, "[unresolved]");
+	}
+	return 0;
+}
+
+#endif
--- linux/Makefile.orig	Wed Sep 25 21:43:13 2002
+++ linux/Makefile	Wed Sep 25 21:46:56 2002
@@ -138,6 +138,7 @@
 MAKEFILES	= $(TOPDIR)/.config
 GENKSYMS	= /sbin/genksyms
 DEPMOD		= /sbin/depmod
+KALLSYMS	= /sbin/kallsyms
 PERL		= perl
 MODFLAGS	= -DMODULE
 CFLAGS_MODULE   = $(MODFLAGS)
@@ -291,32 +292,64 @@
 vmlinux-objs := $(HEAD) $(INIT) $(CORE_FILES) $(LIBS) $(DRIVERS) $(NETWORKS)
 
 quiet_cmd_link_vmlinux = LD      $@
-cmd_link_vmlinux = $(LD) $(LDFLAGS) $(LDFLAGS_$(@F)) $(HEAD) $(INIT) \
-		--start-group \
-		$(CORE_FILES) \
-		$(LIBS) \
-		$(DRIVERS) \
-		$(NETWORKS) \
-		--end-group \
-		-o vmlinux
+define cmd_link_vmlinux
+	$(LD) $(LDFLAGS) $(LDFLAGS_vmlinux) $(HEAD) $(INIT) \
+	--start-group \
+	$(CORE_FILES) \
+	$(LIBS) \
+	$(DRIVERS) \
+	$(NETWORKS) \
+	--end-group \
+	$(filter $(kallsyms.o),$^) \
+	-o $@
+endef
 
 #	set -e makes the rule exit immediately on error
 
-define rule_link_vmlinux
+define rule_vmlinux
 	set -e
 	echo '  Generating build number'
-	. scripts/mkversion > .tmpversion
-	mv -f .tmpversion .version
+	. scripts/mkversion > .tmp_version
+	mv -f .tmp_version .version
 	+$(MAKE) -C init
 	$(call cmd,link_vmlinux)
 	echo 'cmd_$@ := $(cmd_link_vmlinux)' > $(@D)/.$(@F).cmd
-	$(NM) vmlinux | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > System.map
+	$(NM) $@ | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > System.map
 endef
 
 LDFLAGS_vmlinux += -T arch/$(ARCH)/vmlinux.lds.s
 
-vmlinux: $(vmlinux-objs) arch/$(ARCH)/vmlinux.lds.s FORCE
-	$(call if_changed_rule,link_vmlinux)
+#	Generate section listing all symbols and add it into vmlinux
+
+ifdef CONFIG_KALLSYMS
+
+kallsyms.o := .tmp_kallsyms.o
+
+quiet_cmd_kallsyms = KSYM    $@
+cmd_kallsyms = $(KALLSYMS) $< > $@
+
+.tmp_kallsyms.o: .tmp_vmlinux
+	$(call cmd,kallsyms)
+
+# 	After generating .tmp_vmlinux just like vmlinux, decrement the version
+#	number again, so the final vmlinux gets the same one.
+#	Ignore return value of 'expr'.
+
+define rule_.tmp_vmlinux
+	$(rule_vmlinux)
+	if expr 0`cat .version` - 1 > .tmp_version; then true; fi
+	mv -f .tmp_version .version
+endef
+
+.tmp_vmlinux: $(vmlinux-objs) arch/$(ARCH)/vmlinux.lds.s FORCE
+	$(call if_changed_rule,.tmp_vmlinux)
+
+endif
+
+#	Finally the vmlinux rule
+
+vmlinux: $(vmlinux-objs) $(kallsyms.o) arch/$(ARCH)/vmlinux.lds.s FORCE
+	$(call if_changed_rule,vmlinux)
 
 #	The actual objects are generated when descending, 
 #	make sure no implicit rule kicks in
@@ -820,7 +853,7 @@
 
 # FIXME Should go into a make.lib or something 
 # ===========================================================================
-echo_target = $(RELDIR)/$@
+echo_target = $@
 
 a_flags = -Wp,-MD,$(depfile) $(AFLAGS) $(NOSTDINC_FLAGS) \
 	  $(modkern_aflags) $(EXTRA_AFLAGS) $(AFLAGS_$(*F).o)

