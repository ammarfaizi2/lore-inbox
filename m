Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266259AbSKZH2T>; Tue, 26 Nov 2002 02:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266257AbSKZH2T>; Tue, 26 Nov 2002 02:28:19 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:13457 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S266259AbSKZH2L>; Tue, 26 Nov 2002 02:28:11 -0500
To: Greg Ungerer <gerg@snapgear.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: linux-2.5.49-uc0 (MMU-less fix ups)
References: <3DDF81F5.5050809@snapgear.com>
	<buok7j2cq1k.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<3DE1ABDC.2020104@snapgear.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 26 Nov 2002 16:35:19 +0900
In-Reply-To: <3DE1ABDC.2020104@snapgear.com>
Message-ID: <buor8d87phk.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

Here's another v850 update for 2.5.49-uc0 (applies on top of the previous one).
Mostly stuff for the new module mechanism.


Patch:



--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
  filename=linux-2.5.49-uc0-v850-20021126-dist-upd0.patch
Content-Description: linux-2.5.49-uc0-v850-20021126-dist-upd0.patch

diff -ruN -X../cludes ../orig/linux-2.5.49-uc0/arch/v850/kernel/Makefile arch/v850/kernel/Makefile
--- ../orig/linux-2.5.49-uc0/arch/v850/kernel/Makefile	2002-11-25 10:34:43.000000000 +0900
+++ arch/v850/kernel/Makefile	2002-11-25 14:22:17.000000000 +0900
@@ -15,7 +15,7 @@
 	 signal.o irq.o mach.o ptrace.o bug.o
 export-objs += v850_ksyms.o rte_mb_a_pci.o
 
-obj-$(CONFIG_MODULES)		+= v850_ksyms.o
+obj-$(CONFIG_MODULES)		+= module.o v850_ksyms.o
 # chip-specific code
 obj-$(CONFIG_V850E_MA1)		+= ma.o	nb85e_utils.o nb85e_timer_d.o
 obj-$(CONFIG_V850E_NB85E)	+= nb85e_intc.o
diff -ruN -X../cludes ../orig/linux-2.5.49-uc0/arch/v850/kernel/bug.c arch/v850/kernel/bug.c
--- ../orig/linux-2.5.49-uc0/arch/v850/kernel/bug.c	2002-11-05 11:25:22.000000000 +0900
+++ arch/v850/kernel/bug.c	2002-11-26 14:39:56.000000000 +0900
@@ -60,3 +60,76 @@
 	machine_halt ();
 }
 #endif /* CONFIG_RESET_GUARD */
+
+
+
+struct spec_reg_name {
+	const char *name;
+	int gpr;
+};
+
+struct spec_reg_name spec_reg_names[] = {
+	{ "sp", GPR_SP },
+	{ "gp", GPR_GP },
+	{ "tp", GPR_TP },
+	{ "ep", GPR_EP },
+	{ "lp", GPR_LP },
+	{ 0, 0 }
+};
+
+void show_regs (struct pt_regs *regs)
+{
+	int gpr_base, gpr_offs;
+
+	printk ("     pc 0x%08lx    psw 0x%08lx                       kernel_mode %d\n",
+		regs->pc, regs->psw, regs->kernel_mode);
+	printk ("   ctpc 0x%08lx  ctpsw 0x%08lx   ctbp 0x%08lx\n",
+		regs->ctpc, regs->ctpsw, regs->ctbp);
+
+	for (gpr_base = 0; gpr_base < NUM_GPRS; gpr_base += 4) {
+		for (gpr_offs = 0; gpr_offs < 4; gpr_offs++) {
+			int gpr = gpr_base + gpr_offs;
+			long val = regs->gpr[gpr];
+			struct spec_reg_name *srn;
+
+			for (srn = spec_reg_names; srn->name; srn++)
+				if (srn->gpr == gpr)
+					break;
+
+			if (srn->name)
+				printk ("%7s 0x%08lx", srn->name, val);
+			else
+				printk ("    r%02d 0x%08lx", gpr, val);
+		}
+
+		printk ("\n");
+	}
+}
+
+void show_stack (unsigned long *sp)
+{
+	unsigned long end;
+	unsigned long addr = (unsigned long)sp;
+
+	if (! addr)
+		addr = stack_addr ();
+
+	addr = addr & ~3;
+	end = (addr + THREAD_SIZE - 1) & THREAD_MASK;
+
+	while (addr < end) {
+		printk ("%8lX: ", addr);
+		while (addr < end) {
+			printk (" %8lX", *(unsigned long *)addr);
+			addr += sizeof (unsigned long);
+			if (! (addr & 0xF))
+				break;
+		}
+		printk ("\n");
+	}
+}
+
+void dump_stack ()
+{
+	show_stack (0);
+}
diff -ruN -X../cludes ../orig/linux-2.5.49-uc0/arch/v850/kernel/gbus_int.c arch/v850/kernel/gbus_int.c
--- ../orig/linux-2.5.49-uc0/arch/v850/kernel/gbus_int.c	2002-11-25 10:34:43.000000000 +0900
+++ arch/v850/kernel/gbus_int.c	2002-11-26 15:55:25.000000000 +0900
@@ -14,11 +14,10 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/irq.h>
-#include <linux/sched.h>	/* For some unfathomable reason,
-				   request_irq/free_irq are declared here.  */
+#include <linux/interrupt.h>
+#include <linux/signal.h>
 
 #include <asm/machdep.h>
-#include <asm/irq.h>
 
 
 /* The number of shared GINT interrupts. */
diff -ruN -X../cludes ../orig/linux-2.5.49-uc0/arch/v850/kernel/module.c arch/v850/kernel/module.c
--- ../orig/linux-2.5.49-uc0/arch/v850/kernel/module.c	1970-01-01 09:00:00.000000000 +0900
+++ arch/v850/kernel/module.c	2002-11-26 11:31:32.000000000 +0900
@@ -0,0 +1,225 @@
+/*
+ * arch/v850/kernel/module.c -- Architecture-specific module functions
+ *
+ *  Copyright (C) 2002  NEC Corporation
+ *  Copyright (C) 2002  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001  Rusty Russell
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details.
+ *
+ * Written by Miles Bader <miles@gnu.org>
+ *
+ * Derived in part from arch/ppc/kernel/module.c
+ */
+
+#include <linux/kernel.h>
+#include <linux/vmalloc.h>
+#include <linux/moduleloader.h>
+#include <linux/elf.h>
+
+#if 0
+#define DEBUGP printk
+#else
+#define DEBUGP(fmt , ...)
+#endif
+
+void *module_alloc (unsigned long size)
+{
+	return size == 0 ? 0 : vmalloc (size);
+}
+
+void module_free (struct module *mod, void *module_region)
+{
+	vfree (module_region);
+	/* FIXME: If module_region == mod->init_region, trim exception
+           table entries. */
+}
+
+int module_finalize (const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
+		     struct module *mod)
+{
+	return 0;
+}
+
+/* Count how many different relocations (different symbol, different
+   addend) */
+static unsigned int count_relocs(const Elf32_Rela *rela, unsigned int num)
+{
+	unsigned int i, j, ret = 0;
+
+	/* Sure, this is order(n^2), but it's usually short, and not
+           time critical */
+	for (i = 0; i < num; i++) {
+		for (j = 0; j < i; j++) {
+			/* If this addend appeared before, it's
+                           already been counted */
+			if (ELF32_R_SYM(rela[i].r_info)
+			    == ELF32_R_SYM(rela[j].r_info)
+			    && rela[i].r_addend == rela[j].r_addend)
+				break;
+		}
+		if (j == i) ret++;
+	}
+	return ret;
+}
+
+/* Get the potential trampolines size required of the init and
+   non-init sections */
+static unsigned long get_plt_size(const Elf32_Ehdr *hdr,
+				  const Elf32_Shdr *sechdrs,
+				  const char *secstrings,
+				  int is_init)
+{
+	unsigned long ret = 0;
+	unsigned i;
+
+	/* Everything marked ALLOC (this includes the exported
+           symbols) */
+	for (i = 1; i < hdr->e_shnum; i++) {
+		/* If it's called *.init*, and we're not init, we're
+                   not interested */
+		if ((strstr(secstrings + sechdrs[i].sh_name, ".init") != 0)
+		    != is_init)
+			continue;
+
+		if (sechdrs[i].sh_type == SHT_RELA) {
+			DEBUGP("Found relocations in section %u\n", i);
+			DEBUGP("Ptr: %p.  Number: %u\n",
+			       (void *)hdr + sechdrs[i].sh_offset,
+			       sechdrs[i].sh_size / sizeof(Elf32_Rela));
+			ret += count_relocs((void *)hdr
+					     + sechdrs[i].sh_offset,
+					     sechdrs[i].sh_size
+					     / sizeof(Elf32_Rela))
+				* sizeof(struct v850_plt_entry);
+		}
+	}
+
+	return ret;
+}
+
+long module_core_size (const Elf32_Ehdr *hdr, const Elf32_Shdr *sechdrs,
+		       const char *secstrings, struct module *mod)
+{
+	mod->arch.core_plt_offset = (mod->core_size + 3) & ~3;
+	return mod->core_size + get_plt_size (hdr, sechdrs, secstrings, 1);
+}
+
+long module_init_size (const Elf32_Ehdr *hdr, const Elf32_Shdr *sechdrs,
+		       const char *secstrings, struct module *mod)
+{
+	mod->arch.init_plt_offset = (mod->init_size + 3) & ~3;
+	return mod->init_size + get_plt_size (hdr, sechdrs, secstrings, 1);
+}
+
+int apply_relocate (Elf32_Shdr *sechdrs, const char *strtab,
+		    unsigned int symindex, unsigned int relsec,
+		    struct module *mod)
+{
+	printk ("Barf\n");
+	return -ENOEXEC;
+}
+
+/* Set up a trampoline in the PLT to bounce us to the distant function */
+static uint32_t do_plt_call(void *location, Elf32_Addr val, struct module *mod)
+{
+	struct v850_plt_entry *entry;
+	/* Instructions used to do the indirect jump.  */
+	uint32_t tramp[2];
+
+	/* We have to trash a register, so we assume that any control
+	   transfer more than 21-bits away must be a function call
+	   (so we can use a call-clobbered register).  */
+	tramp[0] = 0x0621 + ((val & 0xffff) << 16);   /* mov sym, r1 ... */
+	tramp[1] = ((val >> 16) & 0xffff) + 0x610000; /* ...; jmp r1 */
+
+	/* Init, or core PLT? */
+	if (location >= mod->module_core
+	    && location < mod->module_core + mod->arch.core_plt_offset)
+		entry = mod->module_core + mod->arch.core_plt_offset;
+	else
+		entry = mod->module_init + mod->arch.init_plt_offset;
+
+	/* Find this entry, or if that fails, the next avail. entry */
+	while (entry->tramp[0])
+		if (entry->tramp[0] == tramp[0] && entry->tramp[1] == tramp[1])
+			return (uint32_t)entry;
+		else
+			entry++;
+
+	entry->tramp[0] = tramp[0];
+	entry->tramp[1] = tramp[1];
+
+	return (uint32_t)entry;
+}
+
+int apply_relocate_add (Elf32_Shdr *sechdrs, const char *strtab,
+			unsigned int symindex, unsigned int relsec,
+			struct module *mod)
+{
+	unsigned int i;
+	Elf32_Rela *rela = (void *)sechdrs[relsec].sh_offset;
+
+	DEBUGP ("Applying relocate section %u to %u\n", relsec,
+		sechdrs[relsec].sh_info);
+
+	for (i = 0; i < sechdrs[relsec].sh_size / sizeof (*rela); i++) {
+		/* This is where to make the change */
+		uint32_t *loc
+			= ((void *)sechdrs[sechdrs[relsec].sh_info].sh_offset
+			   + rela[i].r_offset);
+		/* This is the symbol it is referring to */
+		Elf32_Sym *sym
+			= ((Elf32_Sym *)sechdrs[symindex].sh_offset
+			   + ELF32_R_SYM (rela[i].r_info));
+		uint32_t val = sym->st_value;
+
+		if (! val) {
+			printk (KERN_WARNING "%s: Unknown symbol %s\n",
+				mod->name, strtab + sym->st_name);
+			return -ENOENT;
+		}
+
+		val += rela[i].r_addend;
+
+		switch (ELF32_R_TYPE (rela[i].r_info)) {
+		case R_V850_32:
+			/* We write two shorts instead of a long because even
+			   32-bit insns only need half-word alignment, but
+			   32-bit data writes need to be long-word aligned.  */
+			val += ((uint16_t *)loc)[0];
+			val += ((uint16_t *)loc)[1] << 16;
+			((uint16_t *)loc)[0] = val & 0xffff;
+			((uint16_t *)loc)[1] = (val >> 16) & 0xffff;
+			break;
+
+		case R_V850_22_PCREL:
+			/* Maybe jump indirectly via a PLT table entry.  */
+			if ((int32_t)(val - (uint32_t)loc) > 0x1fffff
+			    || (int32_t)(val - (uint32_t)loc) < -0x200000)
+				val = do_plt_call (loc, val, mod);
+
+			val -= (uint32_t)loc;
+
+			/* We write two shorts instead of a long because
+			   even 32-bit insns only need half-word alignment,
+			   but 32-bit data writes need to be long-word
+			   aligned.  */
+			((uint16_t *)loc)[0] =
+				(*(uint16_t *)loc & 0xffc0) /* opcode + reg */
+				| ((val >> 16) & 0xffc03f); /* offs high */
+			((uint16_t *)loc)[1] =
+				(val & 0xffff);		    /* offs low */
+			break;
+
+		default:
+			printk (KERN_ERR "module %s: Unknown reloc: %u\n",
+				mod->name, ELF32_R_TYPE (rela[i].r_info));
+			return -ENOEXEC;
+		}
+	}
+
+	return 0;
+}
diff -ruN -X../cludes ../orig/linux-2.5.49-uc0/arch/v850/kernel/process.c arch/v850/kernel/process.c
--- ../orig/linux-2.5.49-uc0/arch/v850/kernel/process.c	2002-11-05 11:25:22.000000000 +0900
+++ arch/v850/kernel/process.c	2002-11-26 14:25:17.000000000 +0900
@@ -58,49 +58,6 @@
 	(*idle) ();
 }
 
-struct spec_reg_name {
-	const char *name;
-	int gpr;
-};
-
-struct spec_reg_name spec_reg_names[] = {
-	{ "sp", GPR_SP },
-	{ "gp", GPR_GP },
-	{ "tp", GPR_TP },
-	{ "ep", GPR_EP },
-	{ "lp", GPR_LP },
-	{ 0, 0 }
-};
-
-void show_regs (struct pt_regs *regs)
-{
-	int gpr_base, gpr_offs;
-
-	printk ("     pc 0x%08lx    psw 0x%08lx                       kernel_mode %d\n",
-		regs->pc, regs->psw, regs->kernel_mode);
-	printk ("   ctpc 0x%08lx  ctpsw 0x%08lx   ctbp 0x%08lx\n",
-		regs->ctpc, regs->ctpsw, regs->ctbp);
-
-	for (gpr_base = 0; gpr_base < NUM_GPRS; gpr_base += 4) {
-		for (gpr_offs = 0; gpr_offs < 4; gpr_offs++) {
-			int gpr = gpr_base + gpr_offs;
-			long val = regs->gpr[gpr];
-			struct spec_reg_name *srn;
-
-			for (srn = spec_reg_names; srn->name; srn++)
-				if (srn->gpr == gpr)
-					break;
-
-			if (srn->name)
-				printk ("%7s 0x%08lx", srn->name, val);
-			else
-				printk ("    r%02d 0x%08lx", gpr, val);
-		}
-
-		printk ("\n");
-	}
-}
-
 /*
  * This is the mechanism for creating a new kernel thread.
  *
diff -ruN -X../cludes ../orig/linux-2.5.49-uc0/arch/v850/kernel/v850_ksyms.c arch/v850/kernel/v850_ksyms.c
--- ../orig/linux-2.5.49-uc0/arch/v850/kernel/v850_ksyms.c	2002-11-05 11:25:22.000000000 +0900
+++ arch/v850/kernel/v850_ksyms.c	2002-11-26 15:39:02.000000000 +0900
@@ -27,6 +27,9 @@
 extern void dump_thread (struct pt_regs *, struct user *);
 EXPORT_SYMBOL (dump_thread);
 EXPORT_SYMBOL (kernel_thread);
+EXPORT_SYMBOL (enable_irq);
+EXPORT_SYMBOL (disable_irq);
+EXPORT_SYMBOL (disable_irq_nosync);
 EXPORT_SYMBOL (__bug);
 
 /* Networking helper routines. */
diff -ruN -X../cludes ../orig/linux-2.5.49-uc0/include/asm-v850/elf.h include/asm-v850/elf.h
--- ../orig/linux-2.5.49-uc0/include/asm-v850/elf.h	2002-11-05 11:25:31.000000000 +0900
+++ include/asm-v850/elf.h	2002-11-26 11:10:17.000000000 +0900
@@ -19,7 +19,8 @@
 /*
  * This is used to ensure we don't load something for the wrong architecture.
  */
-#define elf_check_arch(x) ( (x)->e_machine == EM_CYGNUS_V850 )
+#define elf_check_arch(x)  \
+  ((x)->e_machine == EM_V850 || (x)->e_machine == EM_CYGNUS_V850)
 
 /*
  * These are used to set parameters in the core dumps.
diff -ruN -X../cludes ../orig/linux-2.5.49-uc0/include/asm-v850/irq.h include/asm-v850/irq.h
--- ../orig/linux-2.5.49-uc0/include/asm-v850/irq.h	2002-11-05 11:25:32.000000000 +0900
+++ include/asm-v850/irq.h	2002-11-26 15:45:12.000000000 +0900
@@ -52,6 +52,17 @@
    interrupt.  */
 extern unsigned int handle_irq (int irq, struct pt_regs *regs);
 
+
+/* Enable interrupt handling on an irq.  */
+extern void enable_irq(unsigned int irq);
+
+/* Disable an irq and wait for completion.  */
+extern void disable_irq (unsigned int irq);
+
+/* Disable an irq without waiting. */
+extern void disable_irq_nosync (unsigned int irq);
+
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __V850_IRQ_H__ */
diff -ruN -X../cludes ../orig/linux-2.5.49-uc0/include/asm-v850/module.h include/asm-v850/module.h
--- ../orig/linux-2.5.49-uc0/include/asm-v850/module.h	2002-11-05 11:25:32.000000000 +0900
+++ include/asm-v850/module.h	2002-11-26 11:31:26.000000000 +0900
@@ -3,20 +3,40 @@
  *
  *  Copyright (C) 2001,02  NEC Corporation
  *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001  Rusty Russell
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
  * archive for more details.
  *
  * Written by Miles Bader <miles@gnu.org>
+ *
+ * Derived in part from include/asm-ppc/module.h
  */
 
 #ifndef __V850_MODULE_H__
 #define __V850_MODULE_H__
 
-#define arch_init_modules(x)	((void)0)
-#define module_arch_init(x)	(0)
-#define module_map(sz)		vmalloc (sz)
-#define module_unmap(sz)	vfree (sz)
+#define MODULE_SYMBOL_PREFIX "_"
+
+struct v850_plt_entry
+{
+	/* Indirect jump instruction sequence (6-byte mov + 2-byte jr).  */
+	unsigned long tramp[2];
+};
+
+struct mod_arch_specific
+{
+	/* How much of the core is actually taken up with core (then
+           we know the rest is for the PLT).  */
+	unsigned int core_plt_offset;
+
+	/* Same for init.  */
+	unsigned int init_plt_offset;
+};
+
+#define Elf_Shdr Elf32_Shdr
+#define Elf_Sym Elf32_Sym
+#define Elf_Ehdr Elf32_Ehdr
 
 #endif /* __V850_MODULE_H__ */

--=-=-=



Thanks,

-Miles
-- 
"1971 pickup truck; will trade for guns"

--=-=-=--
