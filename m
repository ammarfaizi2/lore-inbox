Return-Path: <linux-kernel-owner+w=401wt.eu-S1751523AbXALAH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbXALAH0 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 19:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbXALAH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 19:07:26 -0500
Received: from tomts43.bellnexxia.net ([209.226.175.110]:39688 "EHLO
	tomts43-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751525AbXALAHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 19:07:23 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Douglas Niehaus <niehaus@eecs.ku.edu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: [PATCH 02/05] Linux Kernel Markers, architecture independant code.
Date: Thu, 11 Jan 2007 19:02:15 -0500
Message-Id: <1168560139334-git-send-email-mathieu.desnoyers@polymtl.ca>
X-Mailer: git-send-email 1.4.4.3
In-Reply-To: <11685601382063-git-send-email-mathieu.desnoyers@polymtl.ca>
References: <11685601382063-git-send-email-mathieu.desnoyers@polymtl.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Markers, architecture independant code.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -121,6 +121,14 @@
         __ksymtab_strings : AT(ADDR(__ksymtab_strings) - LOAD_OFFSET) {	\
 		*(__ksymtab_strings)					\
 	}								\
+	/* Kernel markers : pointers */					\
+	.markers : AT(ADDR(.markers) - LOAD_OFFSET) {			\
+		VMLINUX_SYMBOL(__start___markers) = .;			\
+		*(.markers)						\
+		VMLINUX_SYMBOL(__stop___markers) = .;			\
+	}								\
+	__end_rodata = .;						\
+	. = ALIGN(4096);						\
 									\
 	/* Built-in module parameters. */				\
 	__param : AT(ADDR(__param) - LOAD_OFFSET) {			\
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -356,6 +356,9 @@ struct module
 	/* The command line arguments (may be mangled).  People like
 	   keeping pointers to this stuff */
 	char *args;
+
+	const struct __mark_marker *markers;
+	unsigned int num_markers;
 };
 
 /* FIXME: It'd be nice to isolate modules during init, too, so they
@@ -469,6 +472,7 @@ extern void print_modules(void);
 struct device_driver;
 void module_add_driver(struct module *, struct device_driver *);
 void module_remove_driver(struct device_driver *);
+extern void list_modules(void);
 
 #else /* !CONFIG_MODULES... */
 #define EXPORT_SYMBOL(sym)
--- /dev/null
+++ b/include/linux/marker.h
@@ -0,0 +1,67 @@
+#ifndef _LINUX_MARKER_H
+#define _LINUX_MARKER_H
+
+/*
+ * marker.h
+ *
+ * Code markup for dynamic and static tracing.
+ *
+ * Example :
+ *
+ * MARK(subsystem_event, "%d %s %p[struct task_struct *]",
+ *   someint, somestring, current);
+ * Where :
+ * - Subsystem is the name of your subsystem.
+ * - event is the name of the event to mark.
+ * - "%d %s %p[struct task_struct *]" is the formatted string for printk.
+ * - someint is an integer.
+ * - somestring is a char pointer.
+ * - current is a pointer to a struct task_struct.
+ *
+ * - Dynamically overridable function call based on marker mechanism
+ *   from Frank Ch. Eigler <fche@redhat.com>.
+ * - Thanks to Jeremy Fitzhardinge <jeremy@goop.org> for his constructive
+ *   criticism about gcc optimization related issues.
+ *
+ * The marker mechanism supports multiple instances of the same marker.
+ * Markers can be put in inline functions, inlined static functions and
+ * unrolled loops.
+ *
+ * (C) Copyright 2006 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
+ *
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ */
+
+#ifndef __ASSEMBLY__
+
+typedef void marker_probe_func(const char *fmt, ...);
+
+#ifndef CONFIG_MARKERS_DISABLE_OPTIMIZATION
+#include <asm/marker.h>
+#else
+#include <asm-generic/marker.h>
+#endif
+
+#define MARK_NOARGS " "
+#define MARK_MAX_FORMAT_LEN	1024
+
+#ifndef CONFIG_MARKERS
+#define MARK(name, format, args...) \
+		__mark_check_format(format, ## args)
+#endif
+
+static inline __attribute__ ((format (printf, 1, 2)))
+void __mark_check_format(const char *fmt, ...)
+{ }
+
+extern marker_probe_func __mark_empty_function;
+
+extern int marker_set_probe(const char *name, const char *format,
+				marker_probe_func *probe);
+
+extern int marker_remove_probe(marker_probe_func *probe);
+extern int marker_list_probe(marker_probe_func *probe);
+
+#endif
+#endif
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -138,6 +138,8 @@ extern const unsigned long __start___kcrctab_gpl[];
 extern const unsigned long __start___kcrctab_gpl_future[];
 extern const unsigned long __start___kcrctab_unused[];
 extern const unsigned long __start___kcrctab_unused_gpl[];
+extern const struct __mark_marker __start___markers[];
+extern const struct __mark_marker __stop___markers[];
 
 #ifndef CONFIG_MODVERSIONS
 #define symversion(base, idx) NULL
@@ -298,6 +300,189 @@ static struct module *find_module(const char *name)
 	return NULL;
 }
 
+#ifdef CONFIG_MARKERS
+void __mark_empty_function(const char *fmt, ...)
+{
+}
+EXPORT_SYMBOL(__mark_empty_function);
+
+#define MARK_ENABLE_OFFSET(a) \
+	(typeof(a))((char*)a+MARK_ENABLE_IMMEDIATE_OFFSET)
+
+static int marker_set_probe_range(const char *name, 
+	const char *format,
+	marker_probe_func *probe,
+	const struct __mark_marker *begin,
+	const struct __mark_marker *end)
+{
+	const struct __mark_marker *iter;
+	int found = 0;
+
+	for (iter = begin; iter < end; iter++) {
+		if (strcmp(name, iter->cmark->name) == 0) {
+			if (format
+				&& strcmp(format, iter->cmark->format) != 0) {
+				printk(KERN_NOTICE
+					"Format mismatch for probe %s "
+					"(%s), marker (%s)\n",
+					name,
+					format,
+					iter->cmark->format);
+				continue;
+			}
+			if (probe == __mark_empty_function) {
+				if (*iter->cmark->call
+					!= __mark_empty_function) {
+					*iter->cmark->call =
+						__mark_empty_function;
+				}
+				/* Can have many enables for one function */
+				*MARK_ENABLE_OFFSET(iter->enable) = 0;
+#ifdef MARK_POLYMORPHIC
+				flush_icache_range(
+					MARK_ENABLE_OFFSET(iter->enable),
+					sizeof(*(iter->enable)));
+#endif
+			} else {
+				if (*iter->cmark->call
+					!= __mark_empty_function) {
+					if (*iter->cmark->call != probe) {
+						printk(KERN_NOTICE
+							"Marker %s busy, "
+							"probe %p already "
+							"installed\n",
+							name,
+							*iter->cmark->call);
+						continue;
+					}
+				} else {
+					found++;
+					*iter->cmark->call = probe;
+				}
+				/* Can have many enables for one function */
+				*MARK_ENABLE_OFFSET(iter->enable) = 1;
+#ifdef MARK_POLYMORPHIC
+				flush_icache_range(
+					MARK_ENABLE_OFFSET(iter->enable),
+					sizeof(*(iter->enable)));
+#endif
+			}
+			found++;
+		}
+	}
+	return found;
+}
+
+static int marker_remove_probe_range(marker_probe_func *probe,
+	const struct __mark_marker *begin,
+	const struct __mark_marker *end)
+{
+	const struct __mark_marker *iter;
+	int found = 0;
+
+	for (iter = begin; iter < end; iter++) {
+		if (*iter->cmark->call == probe) {
+			*MARK_ENABLE_OFFSET(iter->enable) = 0;
+#ifdef MARK_POLYMORPHIC
+				flush_icache_range(
+					MARK_ENABLE_OFFSET(iter->enable),
+					sizeof(*(iter->enable)));
+#endif
+			*iter->cmark->call = __mark_empty_function;
+			found++;
+		}
+	}
+	return found;
+}
+
+static int marker_list_probe_range(marker_probe_func *probe,
+	const struct __mark_marker *begin,
+	const struct __mark_marker *end)
+{
+	const struct __mark_marker *iter;
+	int found = 0;
+
+	for (iter = begin; iter < end; iter++) {
+		if (probe)
+			if (probe != *iter->cmark->call) continue;
+		printk("name %s \n", iter->cmark->name);
+		printk("  enable %u ", *MARK_ENABLE_OFFSET(iter->enable));
+		printk("  func 0x%p format \"%s\"\n",
+			*iter->cmark->call, iter->cmark->format);
+		found++;
+	}
+	return found;
+}
+/* markers use the modlist_lock to to synchronise */
+int marker_set_probe(const char *name, const char *format,
+				marker_probe_func *probe)
+{
+	struct module *mod;
+	int found = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&modlist_lock, flags);
+	/* Core kernel markers */
+	found += marker_set_probe_range(name, format, probe,
+			__start___markers, __stop___markers);
+	/* Markers in modules. */ 
+	list_for_each_entry(mod, &modules, list) {
+		if (!mod->taints)
+			found += marker_set_probe_range(name, format, probe,
+				mod->markers, mod->markers+mod->num_markers);
+	}
+	spin_unlock_irqrestore(&modlist_lock, flags);
+	return found;
+}
+EXPORT_SYMBOL(marker_set_probe);
+
+int marker_remove_probe(marker_probe_func *probe)
+{
+	struct module *mod;
+	int found = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&modlist_lock, flags);
+	/* Core kernel markers */
+	found += marker_remove_probe_range(probe,
+			__start___markers, __stop___markers);
+	/* Markers in modules. */ 
+	list_for_each_entry(mod, &modules, list) {
+		if (!mod->taints)
+			found += marker_remove_probe_range(probe,
+				mod->markers, mod->markers+mod->num_markers);
+	}
+	spin_unlock_irqrestore(&modlist_lock, flags);
+	return found;
+}
+EXPORT_SYMBOL(marker_remove_probe);
+
+int marker_list_probe(marker_probe_func *probe)
+{
+	struct module *mod;
+	int found = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&modlist_lock, flags);
+	/* Core kernel markers */
+	printk("Listing kernel markers\n");
+	found += marker_list_probe_range(probe,
+			__start___markers, __stop___markers);
+	/* Markers in modules. */ 
+	printk("Listing module markers\n");
+	list_for_each_entry(mod, &modules, list) {
+		if (!mod->taints) {
+			printk("Listing markers for module %s\n", mod->name);
+			found += marker_list_probe_range(probe,
+				mod->markers, mod->markers+mod->num_markers);
+		}
+	}
+	spin_unlock_irqrestore(&modlist_lock, flags);
+	return found;
+}
+EXPORT_SYMBOL(marker_list_probe);
+#endif
+
 #ifdef CONFIG_SMP
 /* Number of blocks used and allocated. */
 static unsigned int pcpu_num_used, pcpu_num_allocated;
@@ -1561,6 +1746,7 @@ static struct module *load_module(void __user *umod,
 	unsigned int unusedcrcindex;
 	unsigned int unusedgplindex;
 	unsigned int unusedgplcrcindex;
+	unsigned int markersindex;
 	struct module *mod;
 	long err = 0;
 	void *percpu = NULL, *ptr = NULL; /* Stops spurious gcc warning */
@@ -1657,6 +1843,7 @@ static struct module *load_module(void __user *umod,
 #ifdef ARCH_UNWIND_SECTION_NAME
 	unwindex = find_sec(hdr, sechdrs, secstrings, ARCH_UNWIND_SECTION_NAME);
 #endif
+	markersindex = find_sec(hdr, sechdrs, secstrings, ".markers");
 
 	/* Don't keep modinfo section */
 	sechdrs[infoindex].sh_flags &= ~(unsigned long)SHF_ALLOC;
@@ -1667,6 +1854,13 @@ static struct module *load_module(void __user *umod,
 #endif
 	if (unwindex)
 		sechdrs[unwindex].sh_flags |= SHF_ALLOC;
+#ifdef CONFIG_MARKERS
+	if (markersindex)
+		sechdrs[markersindex].sh_flags |= SHF_ALLOC;
+#else
+	if (markersindex)
+		sechdrs[markersindex].sh_flags &= ~(unsigned long)SHF_ALLOC;
+#endif
 
 	/* Check module struct version now, before we try to use module. */
 	if (!check_modstruct_version(sechdrs, versindex, mod)) {
@@ -1803,6 +1997,11 @@ static struct module *load_module(void __user *umod,
 	mod->gpl_future_syms = (void *)sechdrs[gplfutureindex].sh_addr;
 	if (gplfuturecrcindex)
 		mod->gpl_future_crcs = (void *)sechdrs[gplfuturecrcindex].sh_addr;
+	if (markersindex) {
+		mod->markers = (void *)sechdrs[markersindex].sh_addr;
+		mod->num_markers =
+			sechdrs[markersindex].sh_size / sizeof(*mod->markers);
+	}
 
 	mod->unused_syms = (void *)sechdrs[unusedindex].sh_addr;
 	if (unusedcrcindex)
@@ -2243,6 +2442,26 @@ const struct seq_operations modules_op = {
 	.show	= m_show
 };
 
+void list_modules(void)
+{
+	/* Enumerate loaded modules */
+	struct list_head	*i;
+	struct module		*mod;
+	unsigned long refcount = 0;
+	
+	mutex_lock(&module_mutex);
+	list_for_each(i, &modules) {
+		mod = list_entry(i, struct module, list);
+#ifdef CONFIG_MODULE_UNLOAD
+		refcount = local_read(&mod->ref[0].count);
+#endif //CONFIG_MODULE_UNLOAD
+		MARK(list_modules, "%s %d[enum module_state] %lu",
+				mod->name, mod->state, refcount);
+	}
+	mutex_unlock(&module_mutex);
+}
+EXPORT_SYMBOL(list_modules);
+
 /* Given an address, look for it in the module exception tables. */
 const struct exception_table_entry *search_module_extables(unsigned long addr)
 {
