Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWITXuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWITXuf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 19:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWITXuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 19:50:35 -0400
Received: from tomts22.bellnexxia.net ([209.226.175.184]:61379 "EHLO
	tomts22-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1750772AbWITXue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 19:50:34 -0400
Date: Wed, 20 Sep 2006 19:45:18 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
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
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Linux Markers 0.4 (+dynamic probe loader) for 2.6.17
Message-ID: <20060920234517.GA29171@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 19:29:23 up 28 days, 20:38,  6 users,  load average: 0.20, 0.15, 0.10
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I thought about it a little more, and here is still another enhanced version of
the Linux Markers. It also allows the possibility to insert an inlined function
inside the MARKERS surrounded by a uncontidional jump.

I just made what will be the marker loader module : it works with the
"JUMP over CALL" flavor of the marker to provide dynamic loading and unloading
of a probe (using insmod/rmmod). I included the code at the bottom of this
email, with the Makefile and a small module example. As the marker loader uses
special flags, it has to be built out of tree. 
Hint : use "make TARGET=subsys_mark1" to build marker-loader.ko.

Comments/ideas are welcome.

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
@@ -0,0 +1,98 @@
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
+ * Update : Dynamically overridable function call based on marker mechanism
+ *          from Frank Ch. Eigler <fche@redhat.com>.
+ * Notes :
+ * To remove a probe :
+ * * set the function pointer back to __mark_empty_function
+ * * call synchronize_sched() to wait for all the functions to return
+ * * unload the module containing the function
+ *
+ * (C) Copyright 2006 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
+ *
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ */
+
+#ifdef CONFIG_MARK_SYMBOL
+#define MARK_SYM(name)	__asm__ ("__mark_kprobe_" #name ":")
+#else 
+#define MARK_SYM(name)
+#endif
+
+
+#ifdef CONFIG_MARK_JUMP_CALL
+#define MARK_JUMP_CALL_PROTOTYPE(name) \
+	static void \
+		(*__mark_##name##_call)(const char *fmt, ...) \
+		asm ("__mark_"#name"_call") = \
+			__mark_empty_function
+#define MARK_JUMP_CALL(name, format, args...) \
+	do { \
+		preempt_disable(); \
+		(void) (__mark_##name##_call(format, ## args)); \
+		preempt_enable_no_resched(); \
+	} while(0)
+#else
+#define MARK_JUMP_CALL_PROTOTYPE(name)
+#define MARK_JUMP_CALL(name, format, args...)
+#endif
+
+#ifdef CONFIG_MARK_JUMP_INLINE
+#define MARK_JUMP_INLINE(name, format, args...) \
+		(void) (__mark_##name##_inline(format, ## args))
+#else
+#define MARK_JUMP_INLINE(name, format, args...)
+#endif
+
+#define MARK_JUMP(name, format, args...) \
+	do { \
+		__label__ over_label, call_label, inline_label; \
+		volatile static void *__mark_##name##_jump_over \
+				asm ("__mark_"#name"_jump_over") = \
+					&&over_label; \
+		volatile static void *__mark_##name##_jump_call \
+				asm ("__mark_"#name"_jump_call") \
+				__attribute__((unused)) =  \
+					&&call_label; \
+		volatile static void *__mark_##name##_jump_inline \
+				asm ("__mark_"#name"_jump_inline") \
+				__attribute__((unused)) =  \
+					&&inline_label; \
+		MARK_JUMP_CALL_PROTOTYPE(name); \
+		goto *__mark_##name##_jump_over; \
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
+static inline __attribute__ ((format (printf, 1, 2)))
+void __mark_check_format(const char *fmt, ...)
+{ }
+
+extern void __mark_empty_function(const char *fmt, ...);
--- a/init/main.c
+++ b/init/main.c
@@ -737,3 +737,10 @@ static int init(void * unused)
 
 	panic("No init found.  Try passing init= option to kernel.");
 }
+
+#ifdef CONFIG_MARK_JUMP
+void __mark_empty_function(const char *fmt, ...)
+{
+}
+EXPORT_SYMBOL(__mark_empty_function);
+#endif
--- /dev/null
+++ b/kernel/Kconfig.marker
@@ -0,0 +1,24 @@
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
+endmenu

---END---



---MARKER LOADER---
---BEGIN---

/* marker-loader.c
 *
 * Marker Loader
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
void do_mark1(const char *format, int value)
{
	printk("value is %d\n", value);
}

static void *saved_over;

static void **target_mark_call;
static void **target_mark_jump_over;
static void **target_mark_jump_call;
static void **target_mark_jump_inline;

void show_symbol_pointers(void)
{
	printk("Marker loader : Loading symbols...\n");
	printk("  %s %p %p\n", __stringify(CALL), target_mark_call,
		target_mark_call?*target_mark_call:0x0);
	printk("  %s %p %p\n", __stringify(JUMP_OVER), target_mark_jump_over,
		target_mark_jump_over?*target_mark_jump_over:0x0);
	printk("  %s %p %p\n", __stringify(JUMP_CALL), target_mark_jump_call,
		target_mark_jump_call?*target_mark_jump_call:0x0);
	printk("  %s %p %p\n", __stringify(JUMP_INLINE), target_mark_jump_inline,
		target_mark_jump_inline?*target_mark_jump_inline:0x0);
}

int mark_install_hook(void)
{
	target_mark_call = (void**)kallsyms_lookup_name(__stringify(CALL));
	target_mark_jump_over = (void**)kallsyms_lookup_name(__stringify(JUMP_OVER));
	target_mark_jump_call = (void**)kallsyms_lookup_name(__stringify(JUMP_CALL));
	target_mark_jump_inline = (void**)kallsyms_lookup_name(__stringify(JUMP_INLINE));

	show_symbol_pointers();
	
	if(!(target_mark_call && target_mark_jump_over && target_mark_jump_call && 
		target_mark_jump_inline)) {
		printk("Target symbols missing in kallsyms.\n");
		return -EPERM;
	}
	
	printk("Installing hook\n");
	*target_mark_call = (void*)do_mark1;
	saved_over = *target_mark_jump_over;
	*target_mark_jump_over = *target_mark_jump_call;

	return 0;
}

int init_module(void)
{
	return mark_install_hook();
}

void cleanup_module(void)
{
	printk("Removing hook\n");
	*target_mark_jump_over = saved_over;
	*target_mark_call = __mark_empty_function;

	/* Wait for instrumentation functions to return before quitting */
	synchronize_sched();
}

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Mathieu Desnoyers");
MODULE_DESCRIPTION("Marker Loader");

---END---


-- MARKER LOADER Makefile ---
---BEGIN---

export MARKER_CFLAGS

MARKER_CFLAGS	:= -DCALL="__mark_$(TARGET)_call" -DJUMP_OVER="__mark_$(TARGET)_jump_over"
MARKER_CFLAGS	+= -DJUMP_CALL="__mark_$(TARGET)_jump_call" -DJUMP_INLINE="__mark_$(TARGET)_jump_inline"

EXTRA_CFLAGS	+= $(MARKER_CFLAGS)

ifneq ($(KERNELRELEASE),)

obj-m += marker-loader.o

else
	KERNELDIR ?= /lib/modules/$(shell uname -r)/build
	PWD := $(shell pwd)
	KERNELRELEASE = $(shell cat $(KERNELDIR)/$(KBUILD_OUTPUT)/include/linux/version.h | sed -n 's/.*UTS_RELEASE.*\"\(.*\)\".*/\1/p')
ifneq ($(INSTALL_MOD_PATH),)
	DEPMOD_OPT := -b $(INSTALL_MOD_PATH)
endif

default:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules

modules_install:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules_install
	if [ -f $(KERNELDIR)/$(KBUILD_OUTPUT)/System.map ] ; then /sbin/depmod -ae -F $(KERNELDIR)/$(KBUILD_OUTPUT)/System.map $(DEPMOD_OPT) $(KERNELRELEASE) ; fi


clean:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) clean
endif

---END---

--Marker test program--
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
        if(pentry)
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
