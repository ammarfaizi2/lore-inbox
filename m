Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262402AbTCQHwf>; Mon, 17 Mar 2003 02:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262409AbTCQHwf>; Mon, 17 Mar 2003 02:52:35 -0500
Received: from zok.sgi.com ([204.94.215.101]:36836 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S262402AbTCQHwQ>;
	Mon, 17 Mar 2003 02:52:16 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: linux-ia64@linuxia64.org
Subject: [patch] 2.4.21-pre5 kksymoops for i386/ia64
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 17 Mar 2003 19:02:43 +1100
Message-ID: <26040.1047888163@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Automatic decoding of oops on 2.5 has been very useful, so this patch
adds kksymoops support to 2.4.21-pre5.  Currently only for i386 and
ia64, other architectures are easy to add.

Index: 21-pre5.1/kernel/module.c
--- 21-pre5.1/kernel/module.c Wed, 11 Dec 2002 11:38:55 +1100 kaos (linux-2.4/j/45_module.c 1.1.2.1.3.1.3.1.1.1.2.2 644)
+++ 21-pre5.1(w)/kernel/module.c Mon, 17 Mar 2003 17:22:39 +1100 kaos (linux-2.4/j/45_module.c 1.1.2.1.3.1.3.1.1.1.2.2 644)
@@ -3,6 +3,7 @@
 #include <linux/module.h>
 #include <asm/module.h>
 #include <asm/uaccess.h>
+#include <linux/kallsyms.h>
 #include <linux/vmalloc.h>
 #include <linux/smp_lock.h>
 #include <asm/pgalloc.h>
@@ -1235,6 +1236,30 @@ struct seq_operations ksyms_op = {
 	show:	s_show
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
@@ -1280,4 +1305,81 @@ int try_inc_mod_count(struct module *mod
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
+void
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
+		if (*mod_name)
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
+	}
+#if 0
+ else {
+		printk(fmt, "[unresolved]");
+	}
+#endif
+}
+
+#endif
Index: 21-pre5.1/kernel/ksyms.c
--- 21-pre5.1/kernel/ksyms.c Thu, 27 Feb 2003 19:36:53 +1100 kaos (linux-2.4/j/46_ksyms.c 1.1.2.2.1.1.2.1.1.8.2.1.2.1.1.4.1.39 644)
+++ 21-pre5.1(w)/kernel/ksyms.c Mon, 17 Mar 2003 17:42:52 +1100 kaos (linux-2.4/j/46_ksyms.c 1.1.2.2.1.1.2.1.1.8.2.1.2.1.1.4.1.39 644)
@@ -56,6 +56,9 @@
 #ifdef CONFIG_KMOD
 #include <linux/kmod.h>
 #endif
+#ifdef CONFIG_KALLSYMS
+#include <linux/kallsyms.h>
+#endif
 
 extern void set_device_ro(kdev_t dev,int flag);
 
@@ -81,6 +84,15 @@ EXPORT_SYMBOL(inter_module_get_request);
 EXPORT_SYMBOL(inter_module_put);
 EXPORT_SYMBOL(try_inc_mod_count);
 
+#ifdef CONFIG_KALLSYMS
+extern const char __start___kallsyms[];
+extern const char __stop___kallsyms[];
+EXPORT_SYMBOL(__start___kallsyms);
+EXPORT_SYMBOL(__stop___kallsyms);
+EXPORT_SYMBOL(kallsyms_symbol_to_address);
+EXPORT_SYMBOL(kallsyms_address_to_symbol);
+#endif
+
 /* process memory management */
 EXPORT_SYMBOL(do_mmap_pgoff);
 EXPORT_SYMBOL(do_munmap);
Index: 21-pre5.1/kernel/Makefile
--- 21-pre5.1/kernel/Makefile Tue, 18 Sep 2001 13:43:44 +1000 kaos (linux-2.4/k/3_Makefile 1.1.10.2 644)
+++ 21-pre5.1(w)/kernel/Makefile Mon, 17 Mar 2003 18:11:54 +1100 kaos (linux-2.4/k/3_Makefile 1.1.10.2 644)
@@ -19,6 +19,7 @@ obj-y     = sched.o dma.o fork.o exec_do
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
 obj-$(CONFIG_PM) += pm.o
+obj-$(CONFIG_KALLSYMS) += kallsyms.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
Index: 21-pre5.1/include/linux/module.h
--- 21-pre5.1/include/linux/module.h Thu, 01 Aug 2002 11:23:16 +1000 kaos (linux-2.4/c/b/46_module.h 1.1.1.1.2.6.1.1.1.2.1.1 644)
+++ 21-pre5.1(w)/include/linux/module.h Mon, 17 Mar 2003 17:55:02 +1100 kaos (linux-2.4/c/b/46_module.h 1.1.1.1.2.6.1.1.1.2.1.1 644)
@@ -412,4 +412,29 @@ __attribute__((section("__ksymtab"))) =	
 #define SET_MODULE_OWNER(some_struct) do { } while (0)
 #endif
 
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
+extern void print_symbol(const char *fmt, unsigned long address);
+
+#else
+
+#include <linux/errno.h>
+static inline int
+print_symbol(const char *fmt, unsigned long address)
+{
+	return -ESRCH;
+}
+
+#endif
+
 #endif /* _LINUX_MODULE_H */
Index: 21-pre5.1/arch/ia64/kernel/process.c
--- 21-pre5.1/arch/ia64/kernel/process.c Thu, 27 Feb 2003 19:36:53 +1100 kaos (linux-2.4/r/c/50_process.c 1.1.3.1.3.1.2.2.1.2.1.2 644)
+++ 21-pre5.1(w)/arch/ia64/kernel/process.c Mon, 17 Mar 2003 17:19:58 +1100 kaos (linux-2.4/r/c/50_process.c 1.1.3.1.3.1.2.2.1.2.1.2 644)
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/module.h>
 #include <linux/personality.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -37,8 +38,9 @@ static void
 do_show_stack (struct unw_frame_info *info, void *arg)
 {
 	unsigned long ip, sp, bsp;
+	char buf[80];			/* don't make it so big that it overflows the stack! */
 
-	printk("\nCall Trace: ");
+	printk("\nCall Trace:\n");
 	do {
 		unw_get_ip(info, &ip);
 		if (ip == 0)
@@ -46,7 +48,9 @@ do_show_stack (struct unw_frame_info *in
 
 		unw_get_sp(info, &sp);
 		unw_get_bsp(info, &bsp);
-		printk("[<%016lx>] sp=0x%016lx bsp=0x%016lx\n", ip, sp, bsp);
+		snprintf(buf, sizeof(buf), " [<%016lx>] %%s sp=0x%016lx bsp=0x%016lx\n",
+			 ip, sp, bsp);
+		print_symbol(buf, ip);
 	} while (unw_unwind(info) >= 0);
 }
 
@@ -73,13 +77,22 @@ show_stack (struct task_struct *task)
 }
 
 void
+dump_stack (void)
+{
+	show_stack(NULL);
+}
+
+void
 show_regs (struct pt_regs *regs)
 {
 	unsigned long ip = regs->cr_iip + ia64_psr(regs)->ri;
 
 	printk("\nPid: %d, comm: %20s\n", current->pid, current->comm);
+	printk("Registers: cpu %d, sapicid 0x%04x, time %ld\n",
+	       smp_processor_id(),  hard_smp_processor_id(), jiffies);
 	printk("psr : %016lx ifs : %016lx ip  : [<%016lx>]    %s\n",
 	       regs->cr_ipsr, regs->cr_ifs, ip, print_tainted());
+	print_symbol("ip is at %s\n", ip);
 	printk("unat: %016lx pfs : %016lx rsc : %016lx\n",
 	       regs->ar_unat, regs->ar_pfs, regs->ar_rsc);
 	printk("rnat: %016lx bsps: %016lx pr  : %016lx\n",
Index: 21-pre5.1/arch/ia64/config.in
--- 21-pre5.1/arch/ia64/config.in Sun, 12 Jan 2003 11:14:47 +1100 kaos (linux-2.4/s/c/38_config.in 1.1.2.1.2.2.3.1.1.2.1.5 644)
+++ 21-pre5.1(w)/arch/ia64/config.in Mon, 17 Mar 2003 17:32:06 +1100 kaos (linux-2.4/s/c/38_config.in 1.1.2.1.2.2.3.1.1.2.1.5 644)
@@ -284,6 +284,7 @@ if [ "$CONFIG_DEBUG_KERNEL" != "n" ]; th
    bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
    bool '  Turn on compare-and-exchange bug checking (slow!)' CONFIG_IA64_DEBUG_CMPXCHG
    bool '  Turn on irq debug checks (slow!)' CONFIG_IA64_DEBUG_IRQ
+   bool '  Load all symbols for debugging/kksymoops' CONFIG_KALLSYMS
 fi
 
 endmenu
Index: 21-pre5.1/arch/i386/vmlinux.lds
--- 21-pre5.1/arch/i386/vmlinux.lds Fri, 11 Jan 2002 15:36:30 +1100 kaos (linux-2.4/R/c/35_vmlinux.ld 1.1.4.1.2.1 644)
+++ 21-pre5.1(w)/arch/i386/vmlinux.lds Mon, 17 Mar 2003 17:31:24 +1100 kaos (linux-2.4/R/c/35_vmlinux.ld 1.1.4.1.2.1 644)
@@ -28,6 +28,10 @@ SECTIONS
   __ksymtab : { *(__ksymtab) }
   __stop___ksymtab = .;
 
+  __start___kallsyms = .;	/* All kernel symbols */
+  __kallsyms : { *(__kallsyms) }
+  __stop___kallsyms = .;
+
   .data : {			/* Data */
 	*(.data)
 	CONSTRUCTORS
Index: 21-pre5.1/arch/i386/kernel/traps.c
--- 21-pre5.1/arch/i386/kernel/traps.c Sun, 18 Aug 2002 23:16:19 +1000 kaos (linux-2.4/S/c/22_traps.c 1.1.2.1.1.2.1.1.1.12 644)
+++ 21-pre5.1(w)/arch/i386/kernel/traps.c Mon, 17 Mar 2003 17:19:00 +1100 kaos (linux-2.4/S/c/22_traps.c 1.1.2.1.1.2.1.1.1.12 644)
@@ -139,15 +139,16 @@ void show_trace(unsigned long * stack)
 	if (!stack)
 		stack = (unsigned long*)&stack;
 
-	printk("Call Trace:   ");
+	printk("Call Trace:");
+#if CONFIG_KALLSYMS
+	printk("\n");
+#endif
 	i = 1;
 	while (((long) stack & (THREAD_SIZE-1)) != 0) {
 		addr = *stack++;
 		if (kernel_text_address(addr)) {
-			if (i && ((i % 6) == 0))
-				printk("\n ");
-			printk(" [<%08lx>]", addr);
-			i++;
+			printk(" [<%08lx>] ", addr);
+			print_symbol("%s\n", addr);
 		}
 	}
 	printk("\n");
@@ -208,8 +209,11 @@ void show_registers(struct pt_regs *regs
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
@@ -227,7 +231,7 @@ void show_registers(struct pt_regs *regs
 		printk("\nStack: ");
 		show_stack((unsigned long*)esp);
 
-		printk("\nCode: ");
+		printk("Code: ");
 		if(regs->eip < PAGE_OFFSET)
 			goto bad;
 
Index: 21-pre5.1/arch/i386/config.in
--- 21-pre5.1/arch/i386/config.in Wed, 29 Jan 2003 16:24:17 +1100 kaos (linux-2.4/T/c/36_config.in 1.1.2.1.2.32 644)
+++ 21-pre5.1(w)/arch/i386/config.in Mon, 17 Mar 2003 17:30:24 +1100 kaos (linux-2.4/T/c/36_config.in 1.1.2.1.2.32 644)
@@ -471,6 +471,7 @@ if [ "$CONFIG_DEBUG_KERNEL" != "n" ]; th
    bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
    bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
    bool '  Compile the kernel with frame pointers' CONFIG_FRAME_POINTER
+   bool '  Load all symbols for debugging/kksymoops' CONFIG_KALLSYMS
 fi
 
 endmenu
Index: 21-pre5.1/Makefile
--- 21-pre5.1/Makefile Thu, 27 Feb 2003 19:36:53 +1100 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15.1.2.2.25.2.2.1.17.1.4.1.29.1.40.1.51 644)
+++ 21-pre5.1(w)/Makefile Mon, 17 Mar 2003 17:37:53 +1100 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15.1.2.2.25.2.2.1.17.1.4.1.29.1.40.1.51 644)
@@ -37,6 +37,7 @@ OBJDUMP		= $(CROSS_COMPILE)objdump
 MAKEFILES	= $(TOPDIR)/.config
 GENKSYMS	= /sbin/genksyms
 DEPMOD		= /sbin/depmod
+KALLSYMS	= /sbin/kallsyms
 MODFLAGS	= -DMODULE
 CFLAGS_KERNEL	=
 PERL		= perl
@@ -198,7 +199,7 @@ DRIVERS := $(DRIVERS-y)
 CLEAN_FILES = \
 	kernel/ksyms.lst include/linux/compile.h \
 	vmlinux System.map \
-	.tmp* \
+	$(TMPPREFIX).tmp* \
 	drivers/char/consolemap_deftbl.c drivers/video/promcon_tbl.c \
 	drivers/char/conmakehash \
 	drivers/char/drm/*-mod.c \
@@ -278,16 +279,42 @@ Version: dummy
 boot: vmlinux
 	@$(MAKE) CFLAGS="$(CFLAGS) $(CFLAGS_KERNEL)" -C arch/$(ARCH)/boot
 
+LD_VMLINUX	:= $(LD) $(LINKFLAGS) $(HEAD) init/main.o init/version.o init/do_mounts.o \
+			--start-group \
+			$(CORE_FILES) \
+			$(DRIVERS) \
+			$(NETWORKS) \
+			$(LIBS) \
+			--end-group
+ifeq ($(CONFIG_KALLSYMS),y)
+LD_VMLINUX_KALLSYMS	:= $(TMPPREFIX).tmp_kallsyms3.o
+else
+LD_VMLINUX_KALLSYMS	:=
+endif
+
 vmlinux: include/linux/version.h $(CONFIGURATION) init/main.o init/version.o init/do_mounts.o linuxsubdirs
-	$(LD) $(LINKFLAGS) $(HEAD) init/main.o init/version.o init/do_mounts.o \
-		--start-group \
-		$(CORE_FILES) \
-		$(DRIVERS) \
-		$(NETWORKS) \
-		$(LIBS) \
-		--end-group \
-		-o vmlinux
+	@$(MAKE) CFLAGS="$(CFLAGS) $(CFLAGS_KERNEL)" kallsyms
+
+.PHONY:	kallsyms
+
+kallsyms:
+ifeq ($(CONFIG_KALLSYMS),y)
+	@echo kallsyms pass 1
+	$(LD_VMLINUX) -o $(TMPPREFIX).tmp_vmlinux1
+	@$(KALLSYMS) $(TMPPREFIX).tmp_vmlinux1 > $(TMPPREFIX).tmp_kallsyms1.o
+	@echo kallsyms pass 2
+	@$(LD_VMLINUX) $(TMPPREFIX).tmp_kallsyms1.o -o $(TMPPREFIX).tmp_vmlinux2
+	@$(KALLSYMS) $(TMPPREFIX).tmp_vmlinux2 > $(TMPPREFIX).tmp_kallsyms2.o
+	@echo kallsyms pass 3
+	@$(LD_VMLINUX) $(TMPPREFIX).tmp_kallsyms2.o -o $(TMPPREFIX).tmp_vmlinux3
+	@$(KALLSYMS) $(TMPPREFIX).tmp_vmlinux3 > $(TMPPREFIX).tmp_kallsyms3.o
+endif
+	$(LD_VMLINUX) $(LD_VMLINUX_KALLSYMS) -o $(TMPPREFIX)vmlinux
+ifneq ($(TMPPREFIX),)
+	mv $(TMPPREFIX)vmlinux vmlinux
+endif
 	$(NM) vmlinux | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > System.map
+	@rm -f $(TMPPREFIX).tmp_vmlinux* $(TMPPREFIX).tmp_kallsyms*
 
 symlinks:
 	rm -f include/asm
Index: 21-pre5.1/Documentation/Configure.help
--- 21-pre5.1/Documentation/Configure.help Thu, 27 Feb 2003 19:36:53 +1100 kaos (linux-2.4/Z/c/10_Configure. 1.1.2.8.2.10.1.4.2.10.2.71 644)
+++ 21-pre5.1(w)/Documentation/Configure.help Mon, 17 Mar 2003 17:34:52 +1100 kaos (linux-2.4/Z/c/10_Configure. 1.1.2.8.2.10.1.4.2.10.2.71 644)
@@ -20554,6 +20554,16 @@ CONFIG_MAGIC_SYSRQ
   keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
   unless you really know what this hack does.
 
+Load all symbols for debugging/kksymoops
+CONFIG_KALLSYMS
+  Normally only exported symbols are available to modules. For
+  debugging you may want all symbols, not just the exported ones. If
+  you say Y here then extra data is added to the kernel and modules,
+  this data lists all the non-stack symbols in the kernel or module
+  and can be used by any debugger.  You need modutils >= 2.3.11 to use
+  this option. See "man kallsyms" for the data format, it adds 10-20%
+  to the size of the kernel and the loaded modules. If unsure, say N.
+
 ISDN support
 CONFIG_ISDN
   ISDN ("Integrated Services Digital Networks", called RNIS in France)
Index: 21-pre5.1/include/linux/kallsyms.h
--- 21-pre5.1/include/linux/kallsyms.h Mon, 17 Mar 2003 18:15:52 +1100 kaos ()
+++ 21-pre5.1(w)/include/linux/kallsyms.h Mon, 17 Mar 2003 17:55:02 +1100 kaos (linux-2.4/R/g/44_kallsyms.h  644)
@@ -0,0 +1,169 @@
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
+int kallsyms_symbol_complete(
+	char	 *prefix_name	/* Prefix of a symbol name to lookup */
+	);
+int kallsyms_symbol_next(
+	char	 *prefix_name,	/* Prefix of a symbol name to lookup */
+	int flag			/* Indicate if search from the head */
+	);
+
+#endif /* kallsyms.h */
Index: 21-pre5.1/kernel/kallsyms.c
--- 21-pre5.1/kernel/kallsyms.c Mon, 17 Mar 2003 18:15:52 +1100 kaos ()
+++ 21-pre5.1(w)/kernel/kallsyms.c Mon, 17 Mar 2003 17:48:59 +1100 kaos (linux-2.4/R/g/45_kallsyms.c  644)
@@ -0,0 +1,419 @@
+/* An example of using kallsyms data in a kernel debugger.
+
+   Copyright 2000 Keith Owens <kaos@ocs.com.au> April 2000
+
+   This file is part of the Linux modutils.
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
+  */
+
+/*
+   This code uses the list of all kernel and module symbols to :-
+
+   * Find any non-stack symbol in a kernel or module.  Symbols do
+     not have to be exported for debugging.
+
+   * Convert an address to the module (or kernel) that owns it, the
+     section it is in and the nearest symbol.  This finds all non-stack
+     symbols, not just exported ones.
+
+   You need modutils >= 2.3.11 and a kernel with the kallsyms patch
+   which was compiled with CONFIG_KALLSYMS.
+ */
+
+#include <linux/elf.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/kallsyms.h>
+
+/* These external symbols are only set on kernels compiled with
+ * CONFIG_KALLSYMS.
+ */
+
+extern const char __start___kallsyms[];
+extern const char __stop___kallsyms[];
+
+static struct module **kallsyms_module_list;
+
+static void kallsyms_get_module_list(void)
+{
+	const struct kallsyms_header	*ka_hdr;
+	const struct kallsyms_section	*ka_sec;
+	const struct kallsyms_symbol	*ka_sym;
+	const char			*ka_str;
+	int i;
+	const char *p;
+
+	if (__start___kallsyms >= __stop___kallsyms)
+		return;
+	ka_hdr = (struct kallsyms_header *)__start___kallsyms;
+	ka_sec = (struct kallsyms_section *)
+		((char *)(ka_hdr) + ka_hdr->section_off);
+	ka_sym = (struct kallsyms_symbol *)
+		((char *)(ka_hdr) + ka_hdr->symbol_off);
+	ka_str = 
+		((char *)(ka_hdr) + ka_hdr->string_off);
+
+	for (i = 0; i < ka_hdr->symbols; kallsyms_next_sym(ka_hdr, ka_sym), ++i) {
+		p = ka_str + ka_sym->name_off;
+		if (strcmp(p, "module_list") == 0) {
+			if (ka_sym->symbol_addr)
+				kallsyms_module_list = (struct module **)(ka_sym->symbol_addr);
+			break;
+		}
+	}
+}
+
+static inline void kallsyms_do_first_time(void)
+{
+	static int first_time = 1;
+	if (first_time)
+		kallsyms_get_module_list();
+	first_time = 0;
+}
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
+	kallsyms_do_first_time();
+	if (!kallsyms_module_list)
+		return(0);
+
+	/* Restart? */
+	m = *kallsyms_module_list;
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
+	kallsyms_do_first_time();
+	if (!kallsyms_module_list)
+		return(0);
+
+	for (m = *kallsyms_module_list; m; m = m->next) {
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
+	*mod_name = *(m->name) ? m->name : "kernel";
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
+	kallsyms_do_first_time();
+	if (!kallsyms_module_list)
+		return(0);
+
+	for (m = *kallsyms_module_list; m; m = m->next) {
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
+
+
+/* paramter prefix_name is a buffer provided by the caller, it must ends with '\0'. */
+/* return the extra string together with the given prefix of a symbol name. */
+/* return 0 means no prefix string is found. */
+/* return >0 means prefix string is found. */
+int kallsyms_symbol_complete(
+	char	 *prefix_name	/* Prefix of a symbol name to lookup */
+	)
+{
+	const struct kallsyms_header	*ka_hdr = NULL;	/* stupid gcc */
+	const struct kallsyms_symbol	*ka_sym = NULL;
+	const char			*ka_str = NULL;
+	const struct module *m;
+	int i = 0;
+	int prefix_len=strlen(prefix_name);
+	int cur_pos=0, last_pos=0;
+	int find=0;
+	int number=0;
+	const char *p;
+
+	kallsyms_do_first_time();
+	if (!kallsyms_module_list)
+		return(0);
+
+	for (m = *kallsyms_module_list; m; m = m->next) {
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
+			if (strncmp(p, prefix_name,prefix_len) == 0) {
+				++number;
+				if (find == 0) {
+					last_pos = strlen(p);
+					strncpy(prefix_name, p, last_pos+1);
+					find = 1;
+				}
+				else {
+					for (cur_pos = prefix_len ; cur_pos < last_pos; cur_pos++) {
+						if (*(p + cur_pos) == '\0'
+							|| *(p + cur_pos) != prefix_name[cur_pos]) {
+							last_pos = cur_pos;
+							prefix_name[cur_pos] = '\0';
+							break;
+						}
+					}
+				}
+			}
+		}
+	}
+
+	return number;
+}
+
+/* paramter prefix_name is a buffer provided by the caller, it must ends with '\0'. */
+/* parameter flag = 0 means search from the head, flag = 1 means continue search. */
+/* return a symbol string which matches the given prefix. */
+/* return 0 means no prefix string is found. */
+/* return >0 means prefix string is found. */
+int kallsyms_symbol_next(
+	char	 *prefix_name,	/* Prefix of a symbol name to lookup */
+	int flag			/* Indicate if search from the head */
+	)
+{
+	const struct kallsyms_header	*ka_hdr = NULL;	/* stupid gcc */
+	const char			*ka_str = NULL;
+	static const struct kallsyms_symbol	*ka_sym;
+	static const struct module *m;
+	static int i;
+	int prefix_len=strlen(prefix_name);
+	const char *p;
+
+	kallsyms_do_first_time();
+	if (!kallsyms_module_list)
+		return(0);
+
+	if(!flag) {
+		m = *kallsyms_module_list;
+	}
+
+	for (; m; m = m->next) {
+		if (!mod_member_present(m, kallsyms_start) ||
+		    !mod_member_present(m, kallsyms_end) ||
+		    m->kallsyms_start >= m->kallsyms_end)
+			continue;
+		ka_hdr = (struct kallsyms_header *)m->kallsyms_start;
+		if(!flag) {
+			ka_sym = (struct kallsyms_symbol *)
+				((char *)(ka_hdr) + ka_hdr->symbol_off);
+			i = 0;
+		}
+		ka_str = ((char *)(ka_hdr) + ka_hdr->string_off);
+
+		for (; i < ka_hdr->symbols; ++i, kallsyms_next_sym(ka_hdr, ka_sym)) {
+			p = ka_str + ka_sym->name_off;
+			if (strncmp(p, prefix_name,prefix_len) == 0) {
+				strncpy(prefix_name, p, strlen(p)+1);
+				++i;
+				kallsyms_next_sym(ka_hdr, ka_sym);
+				return 1;
+			}
+		}
+	}
+
+	return 0;
+}
+
+

