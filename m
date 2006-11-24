Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966205AbWKXVyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966205AbWKXVyN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 16:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966216AbWKXVyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 16:54:12 -0500
Received: from tomts36-srv.bellnexxia.net ([209.226.175.93]:54726 "EHLO
	tomts36-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S966205AbWKXVyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 16:54:04 -0500
Date: Fri, 24 Nov 2006 16:54:01 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       Karim Yaghmour <karim@opersys.com>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, Richard J Moore <richardj_moore@uk.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com
Subject: [PATCH 3/16] LTTng 0.6.36 for 2.6.18 : Linux Kernel Markers
Message-ID: <20061124215401.GD25048@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 16:52:41 up 93 days, 19:00,  4 users,  load average: 0.62, 0.38, 0.28
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the Linux Kernel Markers, except the build system modification
(/Makefile), which is in patch16-2.6.18-lttng-core-0.6.36-build.diff.

patch03-2.6.18-lttng-core-0.6.36-markers.diff

Signed-off-by : Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--BEGIN--
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -118,6 +118,12 @@ #define RODATA								\
         __ksymtab_strings : AT(ADDR(__ksymtab_strings) - LOAD_OFFSET) {	\
 		*(__ksymtab_strings)					\
 	}								\
+	/* Kernel markers : pointers */					\
+	.markers : AT(ADDR(.markers) - LOAD_OFFSET) {			\
+		VMLINUX_SYMBOL(__start___markers) = .;			\
+		*(.markers)						\
+		VMLINUX_SYMBOL(__stop___markers) = .;			\
+	}								\
 	__end_rodata = .;						\
 	. = ALIGN(4096);						\
 									\
--- /dev/null
+++ b/kernel/Kconfig.marker
@@ -0,0 +1,17 @@
+# Code markers configuration
+
+config MARKERS
+	bool "Activate markers"
+	select MODULES
+	default n
+	help
+	  Place an empty function call at each marker site. Can be
+	  dynamically changed for a probe function.
+
+config MARKERS_DISABLE_OPTIMIZATION
+	bool "Disable architecture specific marker optimization"
+	depends EMBEDDED
+	default n
+	help
+	  Disable code replacement jump optimisations. Especially useful if your
+	  code is in a read-only rom/flash.
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -345,6 +345,9 @@ #endif
 	/* The command line arguments (may be mangled).  People like
 	   keeping pointers to this stuff */
 	char *args;
+
+	const struct __mark_marker *markers;
+	unsigned int num_markers;
 };
 
 /* FIXME: It'd be nice to isolate modules during init, too, so they
@@ -468,6 +471,7 @@ extern void print_modules(void);
 struct device_driver;
 void module_add_driver(struct module *, struct device_driver *);
 void module_remove_driver(struct device_driver *);
+extern void list_modules(void);
 
 #else /* !CONFIG_MODULES... */
 #define EXPORT_SYMBOL(sym)
--- /dev/null
+++ b/include/linux/marker.h
@@ -0,0 +1,65 @@
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
+ * MARK(subsystem_event, "%d %s", someint, somestring);
+ * Where :
+ * - Subsystem is the name of your subsystem.
+ * - event is the name of the event to mark.
+ * - "%d %s" is the formatted string for printk.
+ * - someint is an integer.
+ * - somestring is a char *.
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
--- /dev/null
+++ b/include/asm-arm/marker.h
@@ -0,0 +1,13 @@
+/*
+ * marker.h
+ *
+ * Code markup for dynamic and static tracing. Architecture specific
+ * optimisations.
+ * 
+ * No optimisation implemented.
+ *
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ */
+
+#include <asm-generic/marker.h>
--- /dev/null
+++ b/include/asm-cris/marker.h
@@ -0,0 +1,13 @@
+/*
+ * marker.h
+ *
+ * Code markup for dynamic and static tracing. Architecture specific
+ * optimisations.
+ * 
+ * No optimisation implemented.
+ *
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ */
+
+#include <asm-generic/marker.h>
--- /dev/null
+++ b/include/asm-frv/marker.h
@@ -0,0 +1,13 @@
+/*
+ * marker.h
+ *
+ * Code markup for dynamic and static tracing. Architecture specific
+ * optimisations.
+ * 
+ * No optimisation implemented.
+ *
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ */
+
+#include <asm-generic/marker.h>
--- /dev/null
+++ b/include/asm-generic/marker.h
@@ -0,0 +1,49 @@
+/*
+ * marker.h
+ *
+ * Code markup for dynamic and static tracing. Generic header.
+ * 
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ *
+ * Note : the empty asm volatile with read constraint is used here instead of a
+ * "used" attribute to fix a gcc 4.1.x bug.
+ */
+
+struct __mark_marker_c {
+	const char *name;
+	marker_probe_func **call;
+	const char *format;
+} __attribute__((packed));
+
+struct __mark_marker {
+	const struct __mark_marker_c *cmark;
+	volatile char *enable;
+} __attribute__((packed));
+
+#ifdef CONFIG_MARKERS
+
+#define MARK(name, format, args...) \
+	do { \
+		static marker_probe_func *__mark_call_##name = \
+					__mark_empty_function; \
+		volatile static char __marker_enable_##name = 0; \
+		static const struct __mark_marker_c __mark_c_##name \
+			__attribute__((section(".markers.c"))) = \
+			{ #name, &__mark_call_##name, format } ; \
+		static const struct __mark_marker __mark_##name \
+			__attribute__((section(".markers"))) = \
+			{ &__mark_c_##name, &__marker_enable_##name } ; \
+		asm volatile ( "" : : "i" (&__mark_##name)); \
+		__mark_check_format(format, ## args); \
+		if (unlikely(__marker_enable_##name)) { \
+			preempt_disable(); \
+			(*__mark_call_##name)(format, ## args); \
+			preempt_enable_no_resched(); \
+		} \
+	} while (0)
+
+
+#define MARK_ENABLE_IMMEDIATE_OFFSET 0
+
+#endif
--- /dev/null
+++ b/include/asm-h8300/marker.h
@@ -0,0 +1,13 @@
+/*
+ * marker.h
+ *
+ * Code markup for dynamic and static tracing. Architecture specific
+ * optimisations.
+ * 
+ * No optimisation implemented.
+ *
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ */
+
+#include <asm-generic/marker.h>
--- /dev/null
+++ b/include/asm-i386/marker.h
@@ -0,0 +1,53 @@
+/*
+ * marker.h
+ *
+ * Code markup for dynamic and static tracing. i386 architecture optimisations.
+ *
+ * (C) Copyright 2006 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
+ *
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ */
+
+
+struct __mark_marker_c {
+	const char *name;
+	marker_probe_func **call;
+	const char *format;
+} __attribute__((packed));
+
+struct __mark_marker {
+	struct __mark_marker_c *cmark;
+	volatile char *enable;
+} __attribute__((packed));
+
+#ifdef CONFIG_MARKERS
+#define MARK(name, format, args...) \
+	do { \
+		static marker_probe_func *__mark_call_##name = \
+					__mark_empty_function; \
+		static const struct __mark_marker_c __mark_c_##name \
+			__attribute__((section(".markers.c"))) = \
+			{ #name, &__mark_call_##name, format } ; \
+		char condition; \
+		asm volatile(	".section .markers, \"a\";\n\t" \
+					".long %1, 0f;\n\t" \
+					".previous;\n\t" \
+					".align 2\n\t" \
+					"0:\n\t" \
+					"movb $0,%0;\n\t" \
+				: "=r" (condition) \
+				: "m" (__mark_c_##name)); \
+		__mark_check_format(format, ## args); \
+		if (unlikely(condition)) { \
+			preempt_disable(); \
+			(*__mark_call_##name)(format, ## args); \
+			preempt_enable_no_resched(); \
+		} \
+	} while (0)
+
+/* Offset of the immediate value from the start of the movb instruction, in
+ * bytes. */
+#define MARK_ENABLE_IMMEDIATE_OFFSET 1
+
+#endif
--- /dev/null
+++ b/include/asm-ia64/marker.h
@@ -0,0 +1,13 @@
+/*
+ * marker.h
+ *
+ * Code markup for dynamic and static tracing. Architecture specific
+ * optimisations.
+ * 
+ * No optimisation implemented.
+ *
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ */
+
+#include <asm-generic/marker.h>
--- /dev/null
+++ b/include/asm-m32r/marker.h
@@ -0,0 +1,13 @@
+/*
+ * marker.h
+ *
+ * Code markup for dynamic and static tracing. Architecture specific
+ * optimisations.
+ * 
+ * No optimisation implemented.
+ *
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ */
+
+#include <asm-generic/marker.h>
--- /dev/null
+++ b/include/asm-m68k/marker.h
@@ -0,0 +1,13 @@
+/*
+ * marker.h
+ *
+ * Code markup for dynamic and static tracing. Architecture specific
+ * optimisations.
+ * 
+ * No optimisation implemented.
+ *
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ */
+
+#include <asm-generic/marker.h>
--- /dev/null
+++ b/include/asm-m68knommu/marker.h
@@ -0,0 +1,13 @@
+/*
+ * marker.h
+ *
+ * Code markup for dynamic and static tracing. Architecture specific
+ * optimisations.
+ * 
+ * No optimisation implemented.
+ *
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ */
+
+#include <asm-generic/marker.h>
--- /dev/null
+++ b/include/asm-mips/marker.h
@@ -0,0 +1,13 @@
+/*
+ * marker.h
+ *
+ * Code markup for dynamic and static tracing. Architecture specific
+ * optimisations.
+ * 
+ * No optimisation implemented.
+ *
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ */
+
+#include <asm-generic/marker.h>
--- /dev/null
+++ b/include/asm-parisc/marker.h
@@ -0,0 +1,13 @@
+/*
+ * marker.h
+ *
+ * Code markup for dynamic and static tracing. Architecture specific
+ * optimisations.
+ * 
+ * No optimisation implemented.
+ *
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ */
+
+#include <asm-generic/marker.h>
--- /dev/null
+++ b/include/asm-powerpc/marker.h
@@ -0,0 +1,57 @@
+/*
+ * marker.h
+ *
+ * Code markup for dynamic and static tracing. PowerPC architecture
+ * optimisations.
+ *
+ * (C) Copyright 2006 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
+ *
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ */
+
+#include <asm/asm-compat.h>
+
+struct __mark_marker_c {
+	const char *name;
+	marker_probe_func **call;
+	const char *format;
+} __attribute__((packed));
+
+struct __mark_marker {
+	struct __mark_marker_c *cmark;
+	volatile short *enable;
+} __attribute__((packed));
+
+#ifdef CONFIG_MARKERS
+
+#define MARK(name, format, args...) \
+	do { \
+		static marker_probe_func *__mark_call_##name = \
+					__mark_empty_function; \
+		static const struct __mark_marker_c __mark_c_##name \
+			__attribute__((section(".markers.c"))) = \
+			{ #name, &__mark_call_##name, format } ; \
+		char condition; \
+		asm volatile(	".section .markers, \"a\";\n\t" \
+					PPC_LONG "%1, 0f;\n\t" \
+					".previous;\n\t" \
+					".align 4\n\t" \
+					"0:\n\t" \
+					"li %0,0;\n\t" \
+				: "=r" (condition) \
+				: "i" (&__mark_c_##name)); \
+		__mark_check_format(format, ## args); \
+		if (unlikely(condition)) { \
+			preempt_disable(); \
+			(*__mark_call_##name)(format, ## args); \
+			preempt_enable_no_resched(); \
+		} \
+	} while (0)
+
+
+/* Offset of the immediate value from the start of the addi instruction (result
+ * of the li mnemonic), in bytes. */
+#define MARK_ENABLE_IMMEDIATE_OFFSET 2
+
+#endif
--- /dev/null
+++ b/include/asm-ppc64/marker.h
@@ -0,0 +1,13 @@
+/*
+ * marker.h
+ *
+ * Code markup for dynamic and static tracing. Architecture specific
+ * optimisations.
+ * 
+ * No optimisation implemented.
+ *
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ */
+
+#include <asm-generic/marker.h>
--- /dev/null
+++ b/include/asm-ppc/marker.h
@@ -0,0 +1,13 @@
+/*
+ * marker.h
+ *
+ * Code markup for dynamic and static tracing. Architecture specific
+ * optimisations.
+ * 
+ * No optimisation implemented.
+ *
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ */
+
+#include <asm-generic/marker.h>
--- /dev/null
+++ b/include/asm-s390/marker.h
@@ -0,0 +1,13 @@
+/*
+ * marker.h
+ *
+ * Code markup for dynamic and static tracing. Architecture specific
+ * optimisations.
+ * 
+ * No optimisation implemented.
+ *
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ */
+
+#include <asm-generic/marker.h>
--- /dev/null
+++ b/include/asm-sh64/marker.h
@@ -0,0 +1,13 @@
+/*
+ * marker.h
+ *
+ * Code markup for dynamic and static tracing. Architecture specific
+ * optimisations.
+ * 
+ * No optimisation implemented.
+ *
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ */
+
+#include <asm-generic/marker.h>
--- /dev/null
+++ b/include/asm-sh/marker.h
@@ -0,0 +1,13 @@
+/*
+ * marker.h
+ *
+ * Code markup for dynamic and static tracing. Architecture specific
+ * optimisations.
+ * 
+ * No optimisation implemented.
+ *
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ */
+
+#include <asm-generic/marker.h>
--- /dev/null
+++ b/include/asm-sparc64/marker.h
@@ -0,0 +1,13 @@
+/*
+ * marker.h
+ *
+ * Code markup for dynamic and static tracing. Architecture specific
+ * optimisations.
+ * 
+ * No optimisation implemented.
+ *
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ */
+
+#include <asm-generic/marker.h>
--- /dev/null
+++ b/include/asm-sparc/marker.h
@@ -0,0 +1,13 @@
+/*
+ * marker.h
+ *
+ * Code markup for dynamic and static tracing. Architecture specific
+ * optimisations.
+ * 
+ * No optimisation implemented.
+ *
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ */
+
+#include <asm-generic/marker.h>
--- /dev/null
+++ b/include/asm-um/marker.h
@@ -0,0 +1,13 @@
+/*
+ * marker.h
+ *
+ * Code markup for dynamic and static tracing. Architecture specific
+ * optimisations.
+ * 
+ * No optimisation implemented.
+ *
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ */
+
+#include <asm-generic/marker.h>
--- /dev/null
+++ b/include/asm-v850/marker.h
@@ -0,0 +1,13 @@
+/*
+ * marker.h
+ *
+ * Code markup for dynamic and static tracing. Architecture specific
+ * optimisations.
+ * 
+ * No optimisation implemented.
+ *
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ */
+
+#include <asm-generic/marker.h>
--- /dev/null
+++ b/include/asm-x86_64/marker.h
@@ -0,0 +1,13 @@
+/*
+ * marker.h
+ *
+ * Code markup for dynamic and static tracing. Architecture specific
+ * optimisations.
+ * 
+ * No optimisation implemented.
+ *
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ */
+
+#include <asm-generic/marker.h>
--- /dev/null
+++ b/include/asm-xtensa/marker.h
@@ -0,0 +1,13 @@
+/*
+ * marker.h
+ *
+ * Code markup for dynamic and static tracing. Architecture specific
+ * optimisations.
+ * 
+ * No optimisation implemented.
+ *
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ */
+
+#include <asm-generic/marker.h>
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -132,6 +132,8 @@ extern const unsigned long __start___kcr
 extern const unsigned long __start___kcrctab_gpl_future[];
 extern const unsigned long __start___kcrctab_unused[];
 extern const unsigned long __start___kcrctab_unused_gpl[];
+extern const struct __mark_marker __start___markers[];
+extern const struct __mark_marker __stop___markers[];
 
 #ifndef CONFIG_MODVERSIONS
 #define symversion(base, idx) NULL
@@ -292,6 +294,174 @@ static struct module *find_module(const 
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
+		if (mod->license_gplok)
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
+		if (mod->license_gplok)
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
+		if (mod->license_gplok) {
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
@@ -1481,6 +1651,7 @@ static struct module *load_module(void _
 	unsigned int unusedcrcindex;
 	unsigned int unusedgplindex;
 	unsigned int unusedgplcrcindex;
+	unsigned int markersindex;
 	struct module *mod;
 	long err = 0;
 	void *percpu = NULL, *ptr = NULL; /* Stops spurious gcc warning */
@@ -1577,6 +1748,7 @@ #endif
 #ifdef ARCH_UNWIND_SECTION_NAME
 	unwindex = find_sec(hdr, sechdrs, secstrings, ARCH_UNWIND_SECTION_NAME);
 #endif
+	markersindex = find_sec(hdr, sechdrs, secstrings, ".markers");
 
 	/* Don't keep modinfo section */
 	sechdrs[infoindex].sh_flags &= ~(unsigned long)SHF_ALLOC;
@@ -1587,6 +1759,13 @@ #ifdef CONFIG_KALLSYMS
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
@@ -1723,6 +1902,11 @@ #endif
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
@@ -2134,6 +2318,26 @@ struct seq_operations modules_op = {
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
+		MARK(list_modules, "%s enum module_state %d %lu",
+				mod->name, mod->state, refcount);
+	}
+	mutex_unlock(&module_mutex);
+}
+EXPORT_SYMBOL(list_modules);
+
 /* Given an address, look for it in the module exception tables. */
 const struct exception_table_entry *search_module_extables(unsigned long addr)
 {
--END--

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
