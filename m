Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWIUXZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWIUXZu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 19:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWIUXZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 19:25:50 -0400
Received: from tomts36.bellnexxia.net ([209.226.175.93]:22726 "EHLO
	tomts36-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932110AbWIUXZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 19:25:48 -0400
Date: Thu, 21 Sep 2006 19:20:24 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH] Linux Kernel Markers 0.7 for 2.6.17 (with type checking!)
Message-ID: <20060921232024.GA16155@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 19:14:49 up 29 days, 20:23,  2 users,  load average: 0.18, 0.13, 0.11
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Still thinking about Frank's comment about type checking, I came up with this
type checking scheme where the marker loading infrastructure checks for
consistency of the format string passed as parameter by the probe with the
marker before probe setup.

The probe itself uses the compiler to make sure that its arguments follows the
format string.

Thanks for all the comments,

Mathieu


---BEGIN---

--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -1082,6 +1082,8 @@ config KPROBES
 	  for kernel debugging, non-intrusive instrumentation and testing.
 	  If in doubt, say "N".
 
+source "kernel/Kconfig.marker"
+
 source "ltt/Kconfig"
 
 endmenu
--- /dev/null
+++ b/include/linux/marker.h
@@ -0,0 +1,127 @@
+/*****************************************************************************
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
+ * - subsystem_event must be unique thorough the kernel!
+ *
+ * Dynamically overridable function call based on marker mechanism
+ *          from Frank Ch. Eigler <fche@redhat.com>.
+ *
+ * (C) Copyright 2006 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
+ *
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ */
+
+#include <linux/linkage.h>
+
+#define MARK_KPROBE_PREFIX "__mark_kprobe_"
+#define MARK_CALL_PREFIX "__mark_call_"
+#define MARK_JUMP_SELECT_PREFIX "__mark_jump_select_"
+#define MARK_JUMP_CALL_PREFIX "__mark_jump_call_"
+#define MARK_JUMP_INLINE_PREFIX "__mark_jump_inline_"
+#define MARK_JUMP_OVER_PREFIX "__mark_jump_over_"
+#define MARK_FORMAT_PREFIX "__mark_format_"
+
+#define MARK_MAX_FORMAT_LEN	1024
+
+#ifdef CONFIG_MARK_SYMBOL
+#define MARK_SYM(name) \
+	do { \
+		__label__ here; \
+		here: asm volatile \
+			(MARK_KPROBE_PREFIX#name " = %0" : : "m" (*&&here)); \
+	} while(0)
+#else 
+#define MARK_SYM(name)
+#endif
+
+#ifdef CONFIG_MARK_JUMP_CALL
+#define MARK_JUMP_CALL_PROTOTYPE(name) \
+	static marker_probe_func *__mark_call_##name \
+			asm (MARK_CALL_PREFIX#name) = \
+			__mark_empty_function
+#define MARK_JUMP_CALL(name, format, args...) \
+	do { \
+		preempt_disable(); \
+		(*__mark_call_##name)(format, ## args); \
+		preempt_enable_no_resched(); \
+	} while(0)
+#else
+#define MARK_JUMP_CALL_PROTOTYPE(name)
+#define MARK_JUMP_CALL(name, format, args...)
+#endif
+
+#ifdef CONFIG_MARK_JUMP_INLINE
+#define MARK_JUMP_INLINE(name, format, args...) \
+		(void) (__mark_inline_##name(format, ## args))
+#else
+#define MARK_JUMP_INLINE(name, format, args...)
+#endif
+
+#define MARK_JUMP(name, format, args...) \
+	do { \
+		__label__ over_label, call_label, inline_label; \
+		volatile static void *__mark_jump_select_##name \
+				asm (MARK_JUMP_SELECT_PREFIX#name) = \
+					&&over_label; \
+		volatile static void *__mark_jump_call_##name \
+				asm (MARK_JUMP_CALL_PREFIX#name) \
+				__attribute__((unused)) =  \
+					&&call_label; \
+		volatile static void *__mark_jump_inline_##name \
+				asm (MARK_JUMP_INLINE_PREFIX#name) \
+				__attribute__((unused)) =  \
+					&&inline_label; \
+		volatile static void *__mark_jump_over_##name \
+				asm (MARK_JUMP_OVER_PREFIX#name) \
+				__attribute__((unused)) =  \
+					&&over_label; \
+		static const char *__mark_format_##name \
+				asm (MARK_FORMAT_PREFIX#name) \
+				__attribute__((unused)) = \
+					format; \
+		MARK_JUMP_CALL_PROTOTYPE(name); \
+		goto *__mark_jump_select_##name; \
+call_label: \
+		MARK_JUMP_CALL(name, format, ## args); \
+		goto over_label; \
+inline_label: \
+		MARK_JUMP_INLINE(name, format, ## args); \
+over_label: \
+		do {} while(0); \
+	} while(0)
+
+#define MARK(name, format, args...) \
+	do { \
+		__mark_check_format(format, ## args); \
+		MARK_SYM(name); \
+		MARK_JUMP(name, format, ## args); \
+	} while(0)
+
+enum marker_type { MARKER_CALL, MARKER_INLINE };
+
+typedef asmlinkage void marker_probe_func(const char *fmt, ...);
+
+static inline __attribute__ ((format (printf, 1, 2)))
+void __mark_check_format(const char *fmt, ...)
+{ }
+
+extern marker_probe_func __mark_empty_function;
+
+int marker_set_probe(const char *name, const char *format,
+			marker_probe_func *probe,
+			enum marker_type type);
+
+void marker_disable_probe(const char *name, marker_probe_func *probe,
+			enum marker_type type);
--- /dev/null
+++ b/kernel/Kconfig.marker
@@ -0,0 +1,31 @@
+# Code markers configuration
+
+menu "Marker configuration"
+
+
+config MARK_SYMBOL
+	bool "Replace markers with symbols"
+	default n
+	help
+	  Put symbols in place of markers, useful for kprobe.
+
+config MARK_JUMP_CALL
+	bool "Replace markers with a jump over an inactive function call"
+	default n
+	help
+	  Put a jump over a call in place of markers.
+
+config MARK_JUMP_INLINE
+	bool "Replace markers with a jump over an inline function"
+	default n
+	help
+	  Put a jump over an inline function.
+
+config MARK_JUMP
+	bool "Jump marker probes set/disable infrastructure"
+	select KALLSYMS
+	default n
+	help
+	  Install or remove probes from markers.
+
+endmenu
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
 obj-$(CONFIG_RELAY) += relay.o
+obj-$(CONFIG_MARK_JUMP) += marker.o
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
--- /dev/null
+++ b/kernel/marker.c
@@ -0,0 +1,196 @@
+/*****************************************************************************
+ * marker.c
+ *
+ * Code markup for dynamic and static tracing. Marker control module.
+ *
+ * (C) Copyright 2006 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
+ *
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ *
+ * Design :
+ * kernel/marker.c deals with all marker activation from a centralized,
+ * coherent mechanism. The functions that will be called will simply sit in
+ * modules.
+ *
+ * Before activating a probe, the marker module :
+ * 1 - takes proper locking
+ * 2 - verifies that the function pointer and jmp target are at their default
+ *     values, otherwise the "set" operation fails.
+ * 4 - does function pointer and jump setup.
+ *
+ * Setting them back to disabled is :
+ * 1 - setting back the default jmp and call values
+ * 2 - call synchronize_sched()
+ * 
+ * A probe module must call marker disable on all its markers before module
+ * unload.
+ *
+ * The marker module will also deal with inline jump selection, which is
+ * the same case as presented here, but without the function pointer.
+ */
+
+
+#include <linux/marker.h>
+#include <linux/spinlock.h>
+#include <linux/module.h>
+#include <linux/kallsyms.h>
+#include <linux/string.h>
+
+static DEFINE_SPINLOCK(marker_lock);
+
+struct marker_pointers {
+	void **call;
+	void **jmpselect;
+	void **jmpcall;
+	void **jmpinline;
+	void **jmpover;
+	void **format;
+};
+
+asmlinkage void __mark_empty_function(const char *fmt, ...)
+{
+}
+EXPORT_SYMBOL(__mark_empty_function);
+
+/* Pointers can be used around preemption disabled */
+static int marker_get_pointers(const char *name,
+	struct marker_pointers *ptrs)
+{
+	char call_sym[KSYM_NAME_LEN] = MARK_CALL_PREFIX;
+	char jmpselect_sym[KSYM_NAME_LEN] = MARK_JUMP_SELECT_PREFIX;
+	char jmpcall_sym[KSYM_NAME_LEN] = MARK_JUMP_CALL_PREFIX;
+	char jmpinline_sym[KSYM_NAME_LEN] = MARK_JUMP_INLINE_PREFIX;
+	char jmpover_sym[KSYM_NAME_LEN] = MARK_JUMP_OVER_PREFIX;
+	char format_sym[KSYM_NAME_LEN] = MARK_FORMAT_PREFIX;
+	unsigned int call_sym_len = sizeof(MARK_CALL_PREFIX);
+	unsigned int jmpselect_sym_len = sizeof(MARK_JUMP_SELECT_PREFIX);
+	unsigned int jmpcall_sym_len = sizeof(MARK_JUMP_CALL_PREFIX);
+	unsigned int jmpinline_sym_len = sizeof(MARK_JUMP_INLINE_PREFIX);
+	unsigned int jmpover_sym_len = sizeof(MARK_JUMP_OVER_PREFIX);
+	unsigned int format_sym_len = sizeof(MARK_FORMAT_PREFIX);
+
+	strncat(call_sym, name, KSYM_NAME_LEN-call_sym_len);
+	strncat(jmpselect_sym, name, KSYM_NAME_LEN-jmpselect_sym_len);
+	strncat(jmpcall_sym, name, KSYM_NAME_LEN-jmpcall_sym_len);
+	strncat(jmpinline_sym, name, KSYM_NAME_LEN-jmpinline_sym_len);
+	strncat(jmpover_sym, name, KSYM_NAME_LEN-jmpover_sym_len);
+	strncat(format_sym, name, KSYM_NAME_LEN-format_sym_len);
+
+	ptrs->call = (void**)kallsyms_lookup_name(call_sym);
+	ptrs->jmpselect = (void**)kallsyms_lookup_name(jmpselect_sym);
+	ptrs->jmpcall = (void**)kallsyms_lookup_name(jmpcall_sym);
+	ptrs->jmpinline = (void**)kallsyms_lookup_name(jmpinline_sym);
+	ptrs->jmpover = (void**)kallsyms_lookup_name(jmpover_sym);
+	ptrs->format = (void**)kallsyms_lookup_name(format_sym);
+
+	if (!(ptrs->call && ptrs->jmpselect && ptrs->jmpcall
+		&& ptrs->jmpinline && ptrs->jmpover && ptrs->format)) {
+		return ENOENT;
+	}
+	return 0;
+}
+
+int marker_set_probe(const char *name, const char *format,
+		marker_probe_func *probe,
+		enum marker_type type)
+{
+	int result = 0;
+	struct marker_pointers ptrs;
+
+	spin_lock(&marker_lock);
+	result = marker_get_pointers(name, &ptrs);
+	if (result) {
+		printk(KERN_NOTICE
+			"Unable to find kallsyms for markers in %s\n",
+			name);
+		goto unlock;
+	}
+
+	switch(type) {
+		case MARKER_CALL:
+			if (*ptrs.call != __mark_empty_function) {
+				result = EBUSY;
+				printk(KERN_NOTICE
+					"Probe already installed on "
+					"marker in %s\n",
+					name);
+				goto unlock;
+			}
+			/* Check the types if format provided by probe */
+			if (format && strncmp(format, *ptrs.format,
+					MARK_MAX_FORMAT_LEN)) {
+				result = EPERM;
+				printk(KERN_NOTICE
+					"Format mismatch for probe %s "
+					"(%s), marker (%s)\n",
+					name,
+					format,
+					(const char*)*ptrs.format);
+				goto unlock;
+			}
+			/* Setup the call pointer */
+			*ptrs.call = probe;
+			/* Setup the jump */
+			*ptrs.jmpselect = *ptrs.jmpcall;
+			break;
+		case MARKER_INLINE:
+			if (*ptrs.jmpover == *ptrs.jmpinline) {
+				result = ENODEV;
+				printk(KERN_NOTICE
+					"No inline probe exists "
+					"for marker in %s\n",
+					name);
+				goto unlock;
+			}
+			/* Setup the call pointer */
+			*ptrs.call = __mark_empty_function;
+			/* Setup the jump */
+			*ptrs.jmpselect = *ptrs.jmpinline;
+			break;
+		default:
+			result = ENOENT;
+			printk(KERN_ERR
+				"Unknown marker type\n");
+			break;
+	}
+unlock:
+	spin_unlock(&marker_lock);
+	return result;
+}
+EXPORT_SYMBOL_GPL(marker_set_probe);
+
+void marker_disable_probe(const char *name, marker_probe_func *probe,
+		enum marker_type type)
+{
+	int result = 0;
+	struct marker_pointers ptrs;
+
+	spin_lock(&marker_lock);
+	result = marker_get_pointers(name, &ptrs);
+	if (result)
+		goto unlock;
+
+	switch(type) {
+		case MARKER_CALL:
+			if (*ptrs.call == probe) {
+				*ptrs.jmpselect = *ptrs.jmpover;
+				*ptrs.call = __mark_empty_function;
+			}
+			break;
+		case MARKER_INLINE:
+			if (*ptrs.jmpselect == *ptrs.jmpinline)
+				*ptrs.jmpselect = *ptrs.jmpover;
+			break;
+		default:
+			result = ENOENT;
+			printk(KERN_ERR
+				"Unknown marker type\n");
+			break;
+	}
+unlock:
+	spin_unlock(&marker_lock);
+	if (!result && type == MARKER_CALL)
+		synchronize_sched();
+}
+EXPORT_SYMBOL_GPL(marker_disable_probe);
---END---

---BEGIN---

/* probe.c
 *
 * Loads a function at a marker call site.
 *
 * (C) Copyright 2006 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
 *
 * This file is released under the GPLv2.
 * See the file COPYING for more details.
 */

#include <linux/marker.h>
#include <linux/module.h>
#include <linux/kallsyms.h>

/* function to install */
#define DO_MARK1_FORMAT "%d"
asmlinkage void do_mark1(const char *format, int value)
{
	__mark_check_format(DO_MARK1_FORMAT, value);
	printk("value is %d\n", value);
}

int init_module(void)
{
	return marker_set_probe("subsys_mark1", DO_MARK1_FORMAT,
			(marker_probe_func*)do_mark1,
			MARKER_CALL);
}

void cleanup_module(void)
{
	marker_disable_probe("subsys_mark1", (marker_probe_func*)do_mark1,
		MARKER_CALL);
}

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Mathieu Desnoyers");
MODULE_DESCRIPTION("Probe");

---END---


---BEGIN---

/* test-mark.c
 *
 */

#include <linux/marker.h>
#include <linux/module.h>
#include <linux/proc_fs.h>
#include <linux/sched.h>

int x=7;

struct proc_dir_entry *pentry = NULL;

static int my_open(struct inode *inode, struct file *file)
{
	MARK(subsys_mark1, "%d", 1);
	MARK(subsys_mark2, "%d %s", 2, "blah2");
	MARK(subsys_mark3, "%d %s", x, "blah3");

	return -EPERM;
}


static struct file_operations my_operations = {
	.open = my_open,
};

int init_module(void)
{
	pentry = create_proc_entry("testmark", 0444, NULL);
	if (pentry)
		pentry->proc_fops = &my_operations;
	return 0;
}

void cleanup_module(void)
{
	remove_proc_entry("testmark", NULL);
}

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Mathieu Desnoyers");
MODULE_DESCRIPTION("Marker Test");

---END---


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
