Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWEPOUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWEPOUh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 10:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWEPOUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 10:20:37 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:12732
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751112AbWEPOUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 10:20:36 -0400
Message-Id: <4469FC07.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Tue, 16 May 2006 16:21:27 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andreas Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: [PATCH 1/3] reliable stack trace support
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are the generic bits needed to enable reliable stack traces based
on Dwarf2-like (.eh_frame) unwind information. Subsequent patches will
enable x86-64 and i386 to make use of this.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.17-rc4/include/asm-generic/unwind.h	1970-01-01 01:00:00.000000000 +0100
+++ 2.6.17-rc4-unwind-generic/include/asm-generic/unwind.h	2006-05-16 14:36:21.000000000 +0200
@@ -0,0 +1,119 @@
+#ifndef _ASM_GENERIC_UNWIND_H
+#define _ASM_GENERIC_UNWIND_H
+
+/*
+ * Copyright (C) 2002-2006 Novell, Inc.
+ *	Jan Beulich <jbeulich@novell.com>
+ *
+ * A simple API for unwinding kernel stacks.  This is used for
+ * debugging and error reporting purposes.  The kernel doesn't need
+ * full-blown stack unwinding with all the bells and whistles, so there
+ * is not much point in implementing the full Dwarf2 unwind API.
+ */
+
+struct module;
+
+#ifdef CONFIG_STACK_UNWIND
+
+#define ARCH_UNWIND_SECTION_NAME ".eh_frame"
+
+/*
+ * Initialize unwind support.
+ */
+extern void unwind_init(void);
+
+extern void *
+unwind_add_table(struct module *,
+                 const void *table_start,
+                 unsigned long table_size);
+
+extern void
+unwind_remove_table(void *handle, int init_only);
+
+extern int
+unwind_init_frame_info(struct unwind_frame_info *,
+                       struct task_struct *,
+                       /*const*/ struct pt_regs *);
+
+/*
+ * Prepare to unwind a blocked task.
+ */
+extern int
+unwind_init_blocked(struct unwind_frame_info *, struct task_struct *);
+
+/*
+ * Prepare to unwind the currently running thread.
+ */
+extern int
+unwind_init_running(struct unwind_frame_info *,
+                    asmlinkage void (*callback)(struct unwind_frame_info *, void *arg),
+                    void *arg);
+
+/*
+ * Unwind to previous to frame.  Returns 0 if successful, negative
+ * number in case of an error.
+ */
+extern int
+unwind(struct unwind_frame_info *);
+
+/*
+ * Unwind until the return pointer is in user-land (or until an error
+ * occurs).  Returns 0 if successful, negative number in case of
+ * error.
+ */
+extern int
+unwind_to_user(struct unwind_frame_info *);
+
+#else
+
+struct unwind_frame_info {};
+
+static inline void unwind_init(void) {}
+
+static inline void *
+unwind_add_table(struct module *mod,
+                 const void *table_start,
+                 unsigned long table_size)
+{
+	return NULL;
+}
+
+static inline void
+unwind_remove_table(void *handle, int init_only)
+{}
+
+static inline int
+unwind_init_frame_info(struct unwind_frame_info *info,
+                       struct task_struct *tsk,
+                       const struct pt_regs *regs)
+{
+	return -ENOSYS;
+}
+
+static inline int
+unwind_init_blocked(struct unwind_frame_info *info, struct task_struct *tsk)
+{
+	return -ENOSYS;
+}
+
+static inline int
+unwind_init_running(struct unwind_frame_info *info,
+                    asmlinkage void (*callback)(struct unwind_frame_info *, void *arg),
+                    void *arg)
+{
+	return -ENOSYS;
+}
+
+static inline int unwind(struct unwind_frame_info *info)
+{
+	return -ENOSYS;
+}
+
+static inline int unwind_to_user(struct unwind_frame_info *info)
+{
+	return -ENOSYS;
+}
+
+#endif
+
+#endif /* _ASM_GENERIC_UNWIND_H */
--- linux-2.6.17-rc4/include/linux/module.h	2006-05-16 15:15:48.000000000 +0200
+++ 2.6.17-rc4-unwind-generic/include/linux/module.h	2006-05-15 17:59:46.000000000 +0200
@@ -284,6 +284,12 @@ struct module
 	/* The size of the executable code in each section.  */
 	unsigned long init_text_size, core_text_size;
 
+#if defined(CONFIG_STACK_UNWIND) /* || defined(CONFIG_IA64) || defined(CONFIG_PARISC) */
+# define MODULE_UNWIND_INFO
+	/* The handle returned from unwind_add_table. */
+	void *unwind_info;
+#endif
+
 	/* Arch-specific module values */
 	struct mod_arch_specific arch;
 
--- linux-2.6.17-rc4/init/main.c	2006-05-16 15:15:49.000000000 +0200
+++ 2.6.17-rc4-unwind-generic/init/main.c	2006-05-15 17:26:14.000000000 +0200
@@ -54,6 +54,12 @@
 #include <asm/sections.h>
 #include <asm/cacheflush.h>
 
+#ifdef CONFIG_STACK_UNWIND
+#include <asm/unwind.h>
+#else
+#include <asm-generic/unwind.h>
+#endif
+
 #ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/smp.h>
 #endif
@@ -482,6 +488,7 @@ asmlinkage void __init start_kernel(void
 		   __stop___param - __start___param,
 		   &unknown_bootoption);
 	sort_main_extable();
+	unwind_init();
 	trap_init();
 	rcu_init();
 	init_IRQ();
--- linux-2.6.17-rc4/kernel/Makefile	2006-05-16 15:15:49.000000000 +0200
+++ 2.6.17-rc4-unwind-generic/kernel/Makefile	2006-05-15 08:52:50.000000000 +0200
@@ -22,6 +22,7 @@ obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += module.o
 obj-$(CONFIG_OBSOLETE_INTERMODULE) += intermodule.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
+obj-$(CONFIG_STACK_UNWIND) += unwind.o
 obj-$(CONFIG_PM) += power/
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_KEXEC) += kexec.o
--- linux-2.6.17-rc4/kernel/module.c	2006-05-16 15:15:49.000000000 +0200
+++ 2.6.17-rc4-unwind-generic/kernel/module.c	2006-05-16 08:46:46.000000000 +0200
@@ -43,6 +43,9 @@
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 #include <asm/cacheflush.h>
+#ifdef MODULE_UNWIND_INFO
+#include <asm/unwind.h>
+#endif
 
 #if 0
 #define DEBUGP printk
@@ -1051,6 +1054,10 @@ static void free_module(struct module *m
 	remove_sect_attrs(mod);
 	mod_kobject_remove(mod);
 
+#ifdef MODULE_UNWIND_INFO
+	unwind_remove_table(mod->unwind_info, 0);
+#endif
+
 	/* Arch-specific cleanup. */
 	module_arch_cleanup(mod);
 
@@ -1412,7 +1419,7 @@ static struct module *load_module(void _
 	unsigned int i, symindex = 0, strindex = 0, setupindex, exindex,
 		exportindex, modindex, obsparmindex, infoindex, gplindex,
 		crcindex, gplcrcindex, versindex, pcpuindex, gplfutureindex,
-		gplfuturecrcindex;
+		gplfuturecrcindex, unwindex = 0;
 	struct module *mod;
 	long err = 0;
 	void *percpu = NULL, *ptr = NULL; /* Stops spurious gcc warning */
@@ -1502,6 +1509,9 @@ static struct module *load_module(void _
 	versindex = find_sec(hdr, sechdrs, secstrings, "__versions");
 	infoindex = find_sec(hdr, sechdrs, secstrings, ".modinfo");
 	pcpuindex = find_pcpusec(hdr, sechdrs, secstrings);
+#ifdef ARCH_UNWIND_SECTION_NAME
+	unwindex = find_sec(hdr, sechdrs, secstrings, ARCH_UNWIND_SECTION_NAME);
+#endif
 
 	/* Don't keep modinfo section */
 	sechdrs[infoindex].sh_flags &= ~(unsigned long)SHF_ALLOC;
@@ -1510,6 +1520,8 @@ static struct module *load_module(void _
 	sechdrs[symindex].sh_flags |= SHF_ALLOC;
 	sechdrs[strindex].sh_flags |= SHF_ALLOC;
 #endif
+	if (unwindex)
+		sechdrs[unwindex].sh_flags |= SHF_ALLOC;
 
 	/* Check module struct version now, before we try to use module. */
 	if (!check_modstruct_version(sechdrs, versindex, mod)) {
@@ -1738,6 +1750,13 @@ static struct module *load_module(void _
 		goto arch_cleanup;
 	add_sect_attrs(mod, hdr->e_shnum, secstrings, sechdrs);
 
+#ifdef MODULE_UNWIND_INFO
+	/* Size of section 0 is 0, so this works well if no unwind info. */
+	mod->unwind_info = unwind_add_table(mod,
+	                                    (void *)sechdrs[unwindex].sh_addr,
+	                                    sechdrs[unwindex].sh_size);
+#endif
+
 	/* Get rid of temporary copy */
 	vfree(hdr);
 
@@ -1836,6 +1855,9 @@ sys_init_module(void __user *umod,
 	mod->state = MODULE_STATE_LIVE;
 	/* Drop initial reference. */
 	module_put(mod);
+#ifdef MODULE_UNWIND_INFO
+	unwind_remove_table(mod->unwind_info, 1);
+#endif
 	module_free(mod, mod->module_init);
 	mod->module_init = NULL;
 	mod->init_size = 0;
--- linux-2.6.17-rc4/kernel/unwind.c	1970-01-01 01:00:00.000000000 +0100
+++ 2.6.17-rc4-unwind-generic/kernel/unwind.c	2006-05-16 14:36:08.000000000 +0200
@@ -0,0 +1,876 @@
+/*
+ * Copyright (C) 2002-2006 Novell, Inc.
+ *	Jan Beulich <jbeulich@novell.com>
+ *
+ * A simple API for unwinding kernel stacks.  This is used for
+ * debugging and error reporting purposes.  The kernel doesn't need
+ * full-blown stack unwinding with all the bells and whistles, so there
+ * is not much point in implementing the full Dwarf2 unwind API.
+ */
+
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <asm/sections.h>
+#include <asm/uaccess.h>
+#include <asm/unaligned.h>
+#include <asm/unwind.h>
+
+extern char __start_unwind[], __end_unwind[];
+
+#define MAX_STACK_DEPTH 8
+
+#define FIELD_SIZEOF(t, f) (sizeof(((t*)0)->f))
+#define VALUE_BUILD_BUG_ON(e) (sizeof(char[1 - 2 * !!(e)]))
+
+#define EXTRA_INFO(f) { \
+		VALUE_BUILD_BUG_ON(offsetof(struct unwind_frame_info, f) \
+		                   % FIELD_SIZEOF(struct unwind_frame_info, f)) \
+		* offsetof(struct unwind_frame_info, f) / FIELD_SIZEOF(struct unwind_frame_info, f), \
+		FIELD_SIZEOF(struct unwind_frame_info, f) \
+	}
+#define PTREGS_INFO(f) EXTRA_INFO(regs.f)
+
+static const struct {
+	unsigned offs:BITS_PER_LONG / 2;
+	unsigned width:BITS_PER_LONG / 2;
+} reg_info[] = {
+	UNW_REGISTER_INFO
+};
+
+#undef PTREGS_INFO
+#undef EXTRA_INFO
+
+#ifndef REG_INVALID
+#define REG_INVALID(r) (reg_info[r].width == 0)
+#endif
+
+#define DW_CFA_nop                          0x00
+#define DW_CFA_set_loc                      0x01
+#define DW_CFA_advance_loc1                 0x02
+#define DW_CFA_advance_loc2                 0x03
+#define DW_CFA_advance_loc4                 0x04
+#define DW_CFA_offset_extended              0x05
+#define DW_CFA_restore_extended             0x06
+#define DW_CFA_undefined                    0x07
+#define DW_CFA_same_value                   0x08
+#define DW_CFA_register                     0x09
+#define DW_CFA_remember_state               0x0a
+#define DW_CFA_restore_state                0x0b
+#define DW_CFA_def_cfa                      0x0c
+#define DW_CFA_def_cfa_register             0x0d
+#define DW_CFA_def_cfa_offset               0x0e
+#define DW_CFA_def_cfa_expression           0x0f
+#define DW_CFA_expression                   0x10
+#define DW_CFA_offset_extended_sf           0x11
+#define DW_CFA_def_cfa_sf                   0x12
+#define DW_CFA_def_cfa_offset_sf            0x13
+#define DW_CFA_val_offset                   0x14
+#define DW_CFA_val_offset_sf                0x15
+#define DW_CFA_val_expression               0x16
+#define DW_CFA_lo_user                      0x1c
+#define DW_CFA_GNU_window_save              0x2d
+#define DW_CFA_GNU_args_size                0x2e
+#define DW_CFA_GNU_negative_offset_extended 0x2f
+#define DW_CFA_hi_user                      0x3f
+
+#define DW_EH_PE_FORM     0x07
+#define DW_EH_PE_native   0x00
+#define DW_EH_PE_leb128   0x01
+#define DW_EH_PE_data2    0x02
+#define DW_EH_PE_data4    0x03
+#define DW_EH_PE_data8    0x04
+#define DW_EH_PE_signed   0x08
+#define DW_EH_PE_ADJUST   0x70
+#define DW_EH_PE_abs      0x00
+#define DW_EH_PE_pcrel    0x10
+#define DW_EH_PE_textrel  0x20
+#define DW_EH_PE_datarel  0x30
+#define DW_EH_PE_funcrel  0x40
+#define DW_EH_PE_aligned  0x50
+#define DW_EH_PE_indirect 0x80
+#define DW_EH_PE_omit     0xff
+
+typedef unsigned long uleb128_t;
+typedef   signed long sleb128_t;
+
+DEFINE_SPINLOCK(table_lock);
+static atomic_t lookups, removals;
+
+static struct unwind_table {
+	struct {
+		unsigned long pc;
+		unsigned long range;
+	} core, init;
+	const void *address;
+	unsigned long size;
+	struct unwind_table *link;
+	atomic_t users;
+	const char *name;
+} root_table, *last_table;
+
+struct unwind_item {
+	enum item_location {
+		Nowhere,
+		Memory,
+		Register,
+		Value
+	} where;
+	uleb128_t value;
+};
+
+struct unwind_state {
+	uleb128_t loc, org;
+	const uint8_t *cieStart, *cieEnd;
+	uleb128_t codeAlign;
+	sleb128_t dataAlign;
+	struct cfa {
+		uleb128_t reg, offs;
+	} cfa;
+	struct unwind_item regs[ARRAY_SIZE(reg_info)];
+	unsigned stackDepth:8;
+	unsigned version:8;
+	const uint8_t *label;
+	const uint8_t *stack[MAX_STACK_DEPTH];
+};
+
+static const struct cfa badCFA = {ARRAY_SIZE(reg_info), 1};
+
+static struct unwind_table *
+find_table(unsigned long pc)
+{
+	int old_removals;
+	struct unwind_table *table = NULL;
+
+	do {
+		if (table)
+				atomic_dec(&table->users);
+		old_removals = atomic_read(&removals);
+		atomic_inc(&lookups);
+		for (table = &root_table; table; table = table->link)
+			if ((pc >= table->core.pc && pc < table->core.pc + table->core.range)
+			    || (pc >= table->init.pc && pc < table->init.pc + table->init.range)) {
+				atomic_inc(&table->users);
+				break;
+			}
+		atomic_dec(&lookups);
+	} while (atomic_read(&removals) != old_removals);
+	return table;
+}
+
+static void
+drop_table(struct unwind_table *table)
+{
+	if (table)
+		atomic_dec(&table->users);
+}
+
+static void
+init_unwind_table (struct unwind_table *table, const char *name,
+                   const void *core_start, unsigned long core_size,
+                   const void *init_start, unsigned long init_size,
+                   const void *table_start, unsigned long table_size)
+{
+	table->core.pc = (unsigned long)core_start;
+	table->core.range = core_size;
+	table->init.pc = (unsigned long)init_start;
+	table->init.range = init_size;
+	table->address = table_start;
+	table->size = table_size;
+	table->link = NULL;
+	atomic_set(&table->users, 0);
+	table->name = name;
+}
+
+/*
+ * Initialize unwind support.
+ */
+void __init
+unwind_init(void)
+{
+	init_unwind_table(&root_table, "kernel",
+	                  _text, _end - _text,
+	                  NULL, 0,
+	                  __start_unwind, __end_unwind - __start_unwind);
+}
+
+void *
+unwind_add_table(struct module *module,
+              const void *table_start,
+              unsigned long table_size)
+{
+	struct unwind_table *table;
+
+	if (table_size <= 0)
+		return NULL;
+
+	table = kmalloc(sizeof(*table), GFP_USER);
+	if (!table)
+		return NULL;
+
+	init_unwind_table(table, module->name,
+	                  module->module_core, module->core_size,
+	                  module->module_init, module->init_size,
+	                  table_start, table_size);
+
+	spin_lock(&table_lock);
+	if (last_table)
+		last_table->link = table;
+	else
+		root_table.link = table;
+	last_table = table;
+	spin_unlock(&table_lock);
+
+	return table;
+}
+
+void
+unwind_remove_table(void *handle, int init_only)
+{
+	struct unwind_table *table = handle, *prev;
+
+	if (!table || table == &root_table)
+		return;
+
+	if (init_only && table == last_table) {
+		table->init.pc = 0;
+		table->init.range = 0;
+		return;
+	}
+
+	spin_lock(&table_lock);
+	for (prev = &root_table; prev->link && prev->link != table; prev = prev->link)
+		;
+	if (prev->link) {
+		if (init_only) {
+			table->init.pc = 0;
+			table->init.range = 0;
+			table = NULL;
+		} else {
+			prev->link = table->link;
+			if (!prev->link)
+				last_table = prev;
+			atomic_inc(&removals);
+		}
+	} else
+		table = NULL;
+	spin_unlock(&table_lock);
+
+	if (table) {
+		while (atomic_read(&table->users) || atomic_read(&lookups))
+			msleep(1);
+		kfree(table);
+	}
+}
+
+static uleb128_t
+get_uleb128(const uint8_t **pcur, const uint8_t *end)
+{
+	const uint8_t *cur = *pcur;
+	uleb128_t value;
+	unsigned shift;
+
+	for (shift = 0, value = 0; cur < end; shift += 7) {
+		if (shift + 7 > 8 * sizeof(value) && (*cur & 0x7fU) >= (1U << (8 * sizeof(value) - shift))) {
+			cur = end + 1;
+			break;
+		}
+		value |= (uleb128_t)(*cur & 0x7f) << shift;
+		if (!(*cur++ & 0x80))
+			break;
+	}
+	*pcur = cur;
+	return value;
+}
+
+static sleb128_t
+get_sleb128(const uint8_t **pcur, const uint8_t *end)
+{
+	const uint8_t *cur = *pcur;
+	sleb128_t value;
+	unsigned shift;
+
+	for (shift = 0, value = 0; cur < end; shift += 7) {
+		if (shift + 7 > 8 * sizeof(value) && (*cur & 0x7fU) >= (1U << (8 * sizeof(value) - shift))) {
+			cur = end + 1;
+			break;
+		}
+		value |= (sleb128_t)(*cur & 0x7f) << shift;
+		if (!(*cur & 0x80)) {
+			value |= -(*cur++ & 0x40) << shift;
+			break;
+		}
+	}
+	*pcur = cur;
+	return value;
+}
+
+static unsigned long
+read_pointer(const uint8_t **pLoc, const void *end, signed ptrType)
+{
+	unsigned long value = 0;
+	union {
+		const uint8_t *p8;
+		const uint16_t *p16;
+		const uint32_t *p32;
+		const unsigned long *pul;
+	} ptr;
+
+	if (ptrType < 0 || ptrType == DW_EH_PE_omit)
+		return 0;
+	ptr.p8 = *pLoc;
+	switch(ptrType & DW_EH_PE_FORM) {
+	case DW_EH_PE_data2:
+		if (end < (const void *)(ptr.p16 + 1))
+			return 0;
+		BUILD_BUG_ON(sizeof(uint16_t) > sizeof(unsigned long));
+		value = get_unaligned(ptr.p16++);
+		break;
+	case DW_EH_PE_data4:
+#ifdef CONFIG_64BIT
+		if (end < (const void *)(ptr.p32 + 1))
+			return 0;
+		BUILD_BUG_ON(sizeof(uint32_t) > sizeof(unsigned long));
+		value = get_unaligned(ptr.p32++);
+		break;
+	case DW_EH_PE_data8:
+		BUILD_BUG_ON(sizeof(uint64_t) != sizeof(unsigned long));
+#else
+		BUILD_BUG_ON(sizeof(uint32_t) != sizeof(unsigned long));
+#endif
+	case DW_EH_PE_native:
+		if (end < (const void *)(ptr.pul + 1))
+			return 0;
+		value = get_unaligned(ptr.pul++);
+		break;
+	case DW_EH_PE_leb128:
+		BUILD_BUG_ON(sizeof(uleb128_t) > sizeof(unsigned long));
+		value = ptrType & DW_EH_PE_signed ? get_sleb128(&ptr.p8, end) : get_uleb128(&ptr.p8, end);
+		if ((const void *)ptr.p8 > end)
+			return 0;
+		break;
+	default:
+		return 0;
+	}
+	switch(ptrType & DW_EH_PE_ADJUST) {
+	case DW_EH_PE_abs:
+		break;
+	case DW_EH_PE_pcrel:
+		value += (unsigned long)*pLoc;
+		break;
+	default:
+		return 0;
+	}
+	if ((ptrType & DW_EH_PE_indirect) && __get_user(value, (unsigned long *)value))
+		return 0;
+	*pLoc = ptr.p8;
+	return value;
+}
+
+static signed
+fde_pointer_type(const uint32_t *cie)
+{
+	const uint8_t *ptr = (const uint8_t *)(cie + 2);
+	unsigned version = *ptr;
+
+	if (version != 1)
+		return -1; // unsupported
+	if (*++ptr) {
+		const char *aug;
+		const uint8_t *end = (const uint8_t *)(cie + 1) + *cie;
+		uleb128_t len;
+
+		// check if augmentation size is first (and thus present)
+		if (*ptr != 'z')
+			return -1;
+		// check if augmentation string is nul-terminated
+		if ((ptr = memchr(aug = (const void *)ptr, 0, end - ptr)) == NULL)
+			return -1;
+		++ptr; // skip terminator
+		get_uleb128(&ptr, end); // skip code alignment
+		get_sleb128(&ptr, end); // skip data alignment
+		version <= 1 ? (void)++ptr : (void)get_uleb128(&ptr, end); // skip return address column
+		len = get_uleb128(&ptr, end); // augmentation length
+		if (ptr + len < ptr || ptr + len > end)
+			return -1;
+		end = ptr + len;
+		while (*++aug) {
+			if (ptr >= end)
+				return -1;
+			switch(*aug) {
+			case 'L':
+				++ptr;
+				break;
+			case 'P': {
+					signed ptrType = *ptr++;
+
+					if (!read_pointer(&ptr, end, ptrType) || ptr > end)
+						return -1;
+				}
+				break;
+			case 'R':
+				return *ptr;
+			default:
+				return -1;
+			}
+		}
+	}
+	return DW_EH_PE_native|DW_EH_PE_abs;
+}
+
+static int
+advance_loc(unsigned long delta, struct unwind_state *state)
+{
+	state->loc += delta * state->codeAlign;
+	return delta > 0;
+}
+
+static void
+set_rule(uleb128_t reg, enum item_location where, uleb128_t value, struct unwind_state *state)
+{
+	if (reg < ARRAY_SIZE(state->regs)) {
+		state->regs[reg].where = where;
+		state->regs[reg].value = value;
+	}
+}
+
+static int
+processCFI(const uint8_t *start,
+           const uint8_t *end,
+           unsigned long targetLoc,
+           signed ptrType,
+           struct unwind_state *state)
+{
+	union {
+		const uint8_t *p8;
+		const uint16_t *p16;
+		const uint32_t *p32;
+	} ptr;
+	int result = 1;
+
+	if (start != state->cieStart) {
+		state->loc = state->org;
+		result = processCFI(state->cieStart, state->cieEnd, 0, ptrType, state);
+		if (targetLoc == 0 && state->label == NULL)
+			return result;
+	}
+	for (ptr.p8 = start; result && ptr.p8 < end; ) {
+		switch(*ptr.p8 >> 6) {
+			uleb128_t value;
+
+		case 0:
+			switch(*ptr.p8++) {
+			case DW_CFA_nop:
+				break;
+			case DW_CFA_set_loc:
+				if ((state->loc = read_pointer(&ptr.p8, end, ptrType)) == 0)
+					result = 0;
+				break;
+			case DW_CFA_advance_loc1:
+				result = ptr.p8 < end && advance_loc(*ptr.p8++, state);
+				break;
+			case DW_CFA_advance_loc2:
+				result = ptr.p8 <= end + 2 && advance_loc(*ptr.p16++, state);
+				break;
+			case DW_CFA_advance_loc4:
+				result = ptr.p8 <= end + 4 && advance_loc(*ptr.p32++, state);
+				break;
+			case DW_CFA_offset_extended:
+				value = get_uleb128(&ptr.p8, end);
+				set_rule(value, Memory, get_uleb128(&ptr.p8, end), state);
+				break;
+			case DW_CFA_val_offset:
+				value = get_uleb128(&ptr.p8, end);
+				set_rule(value, Value, get_uleb128(&ptr.p8, end), state);
+				break;
+			case DW_CFA_offset_extended_sf:
+				value = get_uleb128(&ptr.p8, end);
+				set_rule(value, Memory, get_sleb128(&ptr.p8, end), state);
+				break;
+			case DW_CFA_val_offset_sf:
+				value = get_uleb128(&ptr.p8, end);
+				set_rule(value, Value, get_sleb128(&ptr.p8, end), state);
+				break;
+			case DW_CFA_restore_extended:
+			case DW_CFA_undefined:
+			case DW_CFA_same_value:
+				set_rule(get_uleb128(&ptr.p8, end), Nowhere, 0, state);
+				break;
+			case DW_CFA_register:
+				value = get_uleb128(&ptr.p8, end);
+				set_rule(value, Register, get_uleb128(&ptr.p8, end), state);
+				break;
+			case DW_CFA_remember_state:
+				if (ptr.p8 == state->label) {
+					state->label = NULL;
+					return 1;
+				}
+				if (state->stackDepth >= MAX_STACK_DEPTH)
+					return 0;
+				state->stack[state->stackDepth++] = ptr.p8;
+				break;
+			case DW_CFA_restore_state:
+				if (state->stackDepth) {
+					const uleb128_t loc = state->loc;
+					const uint8_t *label = state->label;
+
+					state->label = state->stack[state->stackDepth - 1];
+					memcpy(&state->cfa, &badCFA, sizeof(state->cfa));
+					memset(state->regs, 0, sizeof(state->regs));
+					state->stackDepth = 0;
+					result = processCFI(start, end, 0, ptrType, state);
+					state->loc = loc;
+					state->label = label;
+				} else
+					return 0;
+				break;
+			case DW_CFA_def_cfa:
+				state->cfa.reg = get_uleb128(&ptr.p8, end);
+				//nobreak
+			case DW_CFA_def_cfa_offset:
+				state->cfa.offs = get_uleb128(&ptr.p8, end);
+				break;
+			case DW_CFA_def_cfa_sf:
+				state->cfa.reg = get_uleb128(&ptr.p8, end);
+				//nobreak
+			case DW_CFA_def_cfa_offset_sf:
+				state->cfa.offs = get_sleb128(&ptr.p8, end) * state->dataAlign;
+				break;
+			case DW_CFA_def_cfa_register:
+				state->cfa.reg = get_uleb128(&ptr.p8, end);
+				break;
+//todo			case DW_CFA_def_cfa_expression:
+//todo			case DW_CFA_expression:
+//todo			case DW_CFA_val_expression:
+			case DW_CFA_GNU_args_size:
+				get_uleb128(&ptr.p8, end);
+				break;
+			case DW_CFA_GNU_negative_offset_extended:
+				value = get_uleb128(&ptr.p8, end);
+				set_rule(value, Memory, (uleb128_t)0 - get_uleb128(&ptr.p8, end), state);
+				break;
+			case DW_CFA_GNU_window_save:
+			default:
+				result = 0;
+				break;
+			}
+			break;
+		case 1:
+			result = advance_loc(*ptr.p8++ & 0x3f, state);
+			break;
+		case 2:
+			value = *ptr.p8++ & 0x3f;
+			set_rule(value, Memory, get_uleb128(&ptr.p8, end), state);
+			break;
+		case 3:
+			set_rule(*ptr.p8++ & 0x3f, Nowhere, 0, state);
+			break;
+		}
+		if (ptr.p8 > end)
+			result = 0;
+		if (result && targetLoc != 0 && targetLoc < state->loc)
+			return 1;
+	}
+	return result
+	   && ptr.p8 == end
+	   && (targetLoc == 0
+	    || (/*todo While in theory this should apply, gcc in practice omits everything
+	          past the function prolog, and hence the location never reaches the
+	          end of the function.
+	        targetLoc < state->loc &&*/ state->label == NULL));
+}
+
+/*
+ * Unwind to previous to frame.  Returns 0 if successful, negative
+ * number in case of an error.
+ */
+int
+unwind(struct unwind_frame_info *frame)
+{
+#define FRAME_REG(r, t) (((t *)frame)[reg_info[r].offs])
+	const uint32_t *fde = NULL, *cie = NULL;
+	const uint8_t *ptr = NULL, *end = NULL;
+	unsigned long startLoc = 0, endLoc = 0, cfa;
+	unsigned i;
+	signed ptrType = -1;
+	uleb128_t retAddrReg = 0;
+	struct unwind_table *table;
+	struct unwind_state state;
+
+	if (UNW_PC(frame) == 0)
+		return -EINVAL;
+	if ((table = find_table(UNW_PC(frame))) != NULL && !(table->size & (sizeof(*fde) - 1))) {
+		unsigned long tableSize = table->size;
+
+		for (fde = (uint32_t *)table->address;
+		     tableSize > sizeof(*fde) && tableSize - sizeof(*fde) >= *fde;
+		     tableSize -= sizeof(*fde) + *fde, fde += 1 + *fde / sizeof(*fde)) {
+			if (!*fde || (*fde & (sizeof(*fde) - 1)))
+				break;
+			if (!fde[1])
+				continue; // this is a CIE
+			if ((fde[1] & (sizeof(*fde) - 1))
+			    || fde[1] > (unsigned long)(fde + 1) - (unsigned long)table->address)
+				continue; // this is not a valid FDE
+			cie = fde + 1 - fde[1] / sizeof(*fde);
+			if (*cie <= sizeof(*cie) + 4
+			    || *cie >= fde[1] - sizeof(*fde)
+			    || (*cie & (sizeof(*cie) - 1))
+			    || cie[1]
+			    || (ptrType = fde_pointer_type(cie)) < 0) {
+				cie = NULL; // this is not a (valid) CIE
+				continue;
+			}
+			ptr = (const uint8_t *)(fde + 2);
+			startLoc = read_pointer(&ptr, (const uint8_t *)(fde + 1) + *fde, ptrType);
+			endLoc = startLoc + read_pointer(&ptr,
+			                                 (const uint8_t *)(fde + 1) + *fde,
+			                                 ptrType & DW_EH_PE_indirect
+			                                 ? ptrType
+			                                 : ptrType & (DW_EH_PE_FORM|DW_EH_PE_signed));
+			if (UNW_PC(frame) >= startLoc && UNW_PC(frame) < endLoc)
+				break;
+			cie = NULL;
+		}
+	}
+	if (cie != NULL) {
+		memset(&state, 0, sizeof(state));
+		state.cieEnd = ptr; // keep here temporarily
+		ptr = (const uint8_t *)(cie + 2);
+		end = (const uint8_t *)(cie + 1) + *cie;
+		if ((state.version = *ptr) != 1)
+			cie = NULL; // unsupported version
+		else if (*++ptr) {
+			// check if augmentation size is first (and thus present)
+			if (*ptr == 'z') {
+				// check for ignorable (or already handled) nul-terminated augmentation string
+				while (++ptr < end && *ptr)
+					if (strchr("LPR", *ptr) == NULL)
+						break;
+			}
+			if (ptr >= end || *ptr)
+				cie = NULL;
+		}
+		++ptr;
+	}
+	if (cie != NULL) {
+		// get code aligment factor
+		state.codeAlign = get_uleb128(&ptr, end);
+		// get data aligment factor
+		state.dataAlign = get_sleb128(&ptr, end);
+		if (state.codeAlign == 0 || state.dataAlign == 0 || ptr >= end)
+			cie = NULL;
+		else {
+			retAddrReg = state.version <= 1 ? *ptr++ : get_uleb128(&ptr, end);
+			// skip augmentation
+			if (((const char *)(cie + 2))[1] == 'z')
+				ptr += get_uleb128(&ptr, end);
+			if (ptr > end
+			   || retAddrReg >= ARRAY_SIZE(reg_info)
+			   || REG_INVALID(retAddrReg)
+			   || reg_info[retAddrReg].width != sizeof(unsigned long))
+				cie = NULL;
+		}
+	}
+	if (cie != NULL) {
+		state.cieStart = ptr;
+		ptr = state.cieEnd;
+		state.cieEnd = end;
+		end = (const uint8_t *)(fde + 1) + *fde;
+		// skip augmentation
+		if (((const char *)(cie + 2))[1] == 'z') {
+			uleb128_t augSize = get_uleb128(&ptr, end);
+
+			if ((ptr += augSize) > end)
+				fde = NULL;
+		}
+	}
+	if (cie == NULL || fde == NULL) {
+#ifdef UNW_FP
+		unsigned long top, bottom;
+#endif
+
+		drop_table(table);
+#ifdef UNW_FP
+		top = STACK_TOP(frame->task);
+		bottom = STACK_BOTTOM(frame->task);
+# if FRAME_RETADDR_OFFSET < 0
+		if (UNW_SP(frame) < top && UNW_FP(frame) <= UNW_SP(frame) && bottom < UNW_FP(frame)
+# else
+		if (UNW_SP(frame) > top && UNW_FP(frame) >= UNW_SP(frame) && bottom > UNW_FP(frame)
+# endif
+		   && !((UNW_SP(frame) | UNW_FP(frame)) & (sizeof(unsigned long) - 1))) {
+			unsigned long link;
+
+			if (!__get_user(link, (unsigned long *)(UNW_FP(frame) + FRAME_LINK_OFFSET))
+# if FRAME_RETADDR_OFFSET < 0
+			   && link > bottom && link < UNW_FP(frame)
+# else
+			   && link > UNW_FP(frame) && link < bottom
+# endif
+			   && !(link & (sizeof(link) - 1))
+			   && !__get_user(UNW_PC(frame), (unsigned long *)(UNW_FP(frame) + FRAME_RETADDR_OFFSET))) {
+				UNW_SP(frame) = UNW_FP(frame) + FRAME_RETADDR_OFFSET
+# if FRAME_RETADDR_OFFSET < 0
+					-
+# else
+					+
+# endif
+					  sizeof(UNW_PC(frame));
+				UNW_FP(frame) = link;
+				return 0;
+			}
+		}
+#endif
+		return -ENXIO;
+	}
+	state.org = startLoc;
+	memcpy(&state.cfa, &badCFA, sizeof(state.cfa));
+	// process instructions
+	if (!processCFI(ptr, end, UNW_PC(frame), ptrType, &state)
+	   || state.loc > endLoc
+	   || state.regs[retAddrReg].where == Nowhere
+	   || state.cfa.reg >= ARRAY_SIZE(reg_info)
+	   || reg_info[state.cfa.reg].width != sizeof(unsigned long)
+	   || state.cfa.offs % sizeof(unsigned long)) {
+		drop_table(table);
+		return -EIO;
+	}
+	drop_table(table);
+	// update frame
+	cfa = FRAME_REG(state.cfa.reg, unsigned long) + state.cfa.offs;
+	startLoc = min((unsigned long)UNW_SP(frame), cfa);
+	endLoc = max((unsigned long)UNW_SP(frame), cfa);
+#ifndef CONFIG_64BIT
+# define CASES CASE(8); CASE(16); CASE(32)
+#else
+# define CASES CASE(8); CASE(16); CASE(32); CASE(64)
+#endif
+	for (i = 0; i < ARRAY_SIZE(state.regs); ++i) {
+		if (REG_INVALID(i)) {
+			if (state.regs[i].where == Nowhere)
+				continue;
+			return -EIO;
+		}
+		switch(state.regs[i].where) {
+		default:
+			break;
+		case Register:
+			if (state.regs[i].value >= ARRAY_SIZE(reg_info)
+			   || REG_INVALID(state.regs[i].value)
+			   || reg_info[i].width > reg_info[state.regs[i].value].width)
+				return -EIO;
+			switch(reg_info[state.regs[i].value].width) {
+#define CASE(n) \
+			case sizeof(uint##n##_t): \
+				state.regs[i].value = FRAME_REG(state.regs[i].value, const uint##n##_t); \
+				break
+			CASES;
+#undef CASE
+			default:
+				return -EIO;
+			}
+			break;
+		}
+	}
+	for (i = 0; i < ARRAY_SIZE(state.regs); ++i) {
+		if (REG_INVALID(i))
+			continue;
+		switch(state.regs[i].where) {
+		case Nowhere:
+			if (reg_info[i].width != sizeof(UNW_SP(frame))
+			   || &FRAME_REG(i, __typeof__(UNW_SP(frame))) != &UNW_SP(frame))
+				continue;
+			UNW_SP(frame) = cfa;
+			break;
+		case Register:
+			switch(reg_info[i].width) {
+#define CASE(n) case sizeof(uint##n##_t): \
+				FRAME_REG(i, uint##n##_t) = state.regs[i].value; \
+				break
+			CASES;
+#undef CASE
+			default:
+				return -EIO;
+			}
+			break;
+		case Value:
+			if (reg_info[i].width != sizeof(unsigned long))
+				return -EIO;
+			FRAME_REG(i, unsigned long) = cfa + state.regs[i].value * state.dataAlign;
+			break;
+		case Memory: {
+				unsigned long addr = cfa + state.regs[i].value * state.dataAlign;
+
+				if ((state.regs[i].value * state.dataAlign) % sizeof(unsigned long)
+				   || addr < startLoc
+				   || addr + sizeof(unsigned long) < addr
+				   || addr + sizeof(unsigned long) > endLoc)
+					return -EIO;
+				switch(reg_info[i].width) {
+#define CASE(n)     case sizeof(uint##n##_t): \
+					__get_user(FRAME_REG(i, uint##n##_t), (uint##n##_t *)addr); \
+					break
+				CASES;
+#undef CASE
+				default:
+					return -EIO;
+				}
+			}
+			break;
+		}
+	}
+	return 0;
+#undef CASES
+#undef FRAME_REG
+}
+EXPORT_SYMBOL_GPL(unwind);
+
+int unwind_init_frame_info(struct unwind_frame_info *info, struct task_struct *tsk, /*const*/ struct pt_regs *regs)
+{
+	info->task = tsk;
+	arch_unw_init_frame_info(info, regs);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(unwind_init_frame_info);
+
+/*
+ * Prepare to unwind a blocked task.
+ */
+int unwind_init_blocked(struct unwind_frame_info *info, struct task_struct *tsk)
+{
+	info->task = tsk;
+	arch_unw_init_blocked(info);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(unwind_init_blocked);
+
+/*
+ * Prepare to unwind the currently running thread.
+ */
+int unwind_init_running(struct unwind_frame_info *info,
+                        asmlinkage void (*callback)(struct unwind_frame_info *, void *arg),
+                        void *arg)
+{
+	info->task = current;
+	arch_unwind_init_running(info, callback, arg);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(unwind_init_running);
+
+/*
+ * Unwind until the return pointer is in user-land (or until an error
+ * occurs).  Returns 0 if successful, negative number in case of
+ * error.
+ */
+int unwind_to_user(struct unwind_frame_info *info)
+{
+	while (!arch_unw_user_mode(info)) {
+		int err = unwind(info);
+
+		if (err < 0)
+			return err;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(unwind_to_user);
--- linux-2.6.17-rc4/lib/Kconfig.debug	2006-05-16 15:15:49.000000000 +0200
+++ 2.6.17-rc4-unwind-generic/lib/Kconfig.debug	2006-05-16 15:16:46.000000000 +0200
@@ -188,7 +188,7 @@ config FRAME_POINTER
 
 config UNWIND_INFO
 	bool "Compile the kernel with frame unwind information"
-	depends on !IA64
+	depends on !IA64 && !PARISC
 	depends on !MODULES || !(MIPS || PARISC || PPC || SUPERH || SPARC64 || V850)
 	help
 	  If you say Y here the resulting kernel image will be slightly larger
@@ -196,6 +196,14 @@ config UNWIND_INFO
 	  If you don't debug the kernel, you can say N, but we may not be able
 	  to solve problems without frame unwind information or frame pointers.
 
+config STACK_UNWIND
+	bool "Stack unwind support"
+	depends on UNWIND_INFO
+	depends on n
+	help
+	  This enables more precise stack traces, omitting all unrelated
+	  occurrences of pointers into kernel code from the dump.
+
 config FORCED_INLINING
 	bool "Force gcc to inline functions marked 'inline'"
 	depends on DEBUG_KERNEL


