Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261534AbSIXBw4>; Mon, 23 Sep 2002 21:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261533AbSIXBwy>; Mon, 23 Sep 2002 21:52:54 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:5104 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261529AbSIXBuz>;
	Mon, 23 Sep 2002 21:50:55 -0400
Message-ID: <3D8FC5C8.ED4D4C8@us.ibm.com>
Date: Mon, 23 Sep 2002 18:54:16 -0700
From: Larry Kessler <kessler@us.ibm.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       "ipslinux (Keith Mitchell)" <ipslinux@us.ibm.com>,
       Linus Torvalds <torvalds@home.transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Hien Nguyen <hien@us.ibm.com>,
       James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>
Subject: [PATCH-RFC} 3 of 4 - New problem logging macros, plus template 
 generation
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please see [PATCH-RFC] README 1ST note...

Summary of this patch...

Rules.make
        Creates formating templates for modules

arch/i386/vmlinux.lds.S
        .log section gets DISCARDed  

scripts/generate_templates.c
        A user-mode utility that reads information stored
        in the .log section of one or more .o files, and

        creates the corresponding formatting templates.
        (The .log section is created when compiling
        problem() and detail()/array_detail() invocations.)

scripts/evlib.c
        Stuff copied from libevl that generate_templates.c
        needs.

scripts/evlib.h
        Ditto

kernel/problem.c
        Implements the __problem function, which is called
        by the problem macro.

include/linux/problem.h
        Implements the introduce, problem, detail and 
        array_detail macros.



diff -Naur linux.org/Makefile linux.problem.patched/Makefile
--- linux.org/Makefile	Mon Sep 23 17:09:51 2002
+++ linux.problem.patched/Makefile	Mon Sep 23 17:09:51 2002
@@ -175,7 +175,7 @@
 # Helpers built in scripts/
 # ---------------------------------------------------------------------------
 
-scripts/docproc scripts/fixdep scripts/split-include : scripts ;
+scripts/docproc scripts/fixdep scripts/split-include scripts/generate_templates : scripts ;
 
 .PHONY: scripts
 scripts:
@@ -498,6 +498,9 @@
 $(patsubst %, _modinst_%, $(SUBDIRS)) :
 	@$(MAKE) -C $(patsubst _modinst_%, %, $@) modules_install
 
+.PHONY: module_templates
+module_templates: $(SUBDIRS)
+
 else # CONFIG_MODULES
 
 # Modules not configured
@@ -559,6 +562,25 @@
 	. scripts/mkversion > .version ; \
 	rpm -ta $(TOPDIR)/../$(KERNELPATH).tar.gz ; \
 	rm $(TOPDIR)/../$(KERNELPATH).tar.gz
+
+# Templates for events logged with problem()
+# ---------------------------------------------------------------------------
+TEMPLATE_HOME=/var/evlog/templates
+
+templates: scripts/generate_templates FORCE
+	rm -rf templates
+	scripts/generate_templates templates \
+		$(INIT) \
+		$(CORE_FILES) \
+		$(LIBS) \
+		$(DRIVERS) \
+		$(NETWORKS)
+ifdef CONFIG_MODULES
+	$(MAKE) module_templates MAKECMDGOALS=module_templates
+endif
+
+templates_install:
+	cp -r templates/* $(TEMPLATE_HOME)
 
 else # ifeq ($(filter $(noconfig_targets),$(MAKECMDGOALS)),)
 
diff -Naur linux.org/Rules.make linux.problem.patched/Rules.make
--- linux.org/Rules.make	Mon Sep 23 17:09:51 2002
+++ linux.problem.patched/Rules.make	Mon Sep 23 17:09:51 2002
@@ -115,10 +115,12 @@
 # contain a comma
 depfile = $(subst $(comma),_,$(@D)/.$(@F).d)
 
-# We're called for one of three purposes:
+# We're called for one of four purposes:
 # o fastdep: build module version files (.ver) for $(export-objs) in
 #   the current directory
 # o modules_install: install the modules in the current directory
+# o module_templates: for each module with a .log section, generate
+#   the corresponding event-logging templates
 # o build: When no target is given, first_rule is the default and
 #   will build the built-in and modular objects in this dir
 #   (or a subset thereof, depending on $(KBUILD_MODULES),$(KBUILD_BUILTIN)
@@ -225,12 +227,28 @@
 ifneq ($(obj-m),)
 	@echo Installing modules in $(MODLIB)/kernel/$(RELDIR)
 	@mkdir -p $(MODLIB)/kernel/$(RELDIR)
-	@cp $(obj-m) $(MODLIB)/kernel/$(RELDIR)
+	@(for o in $(obj-m); do objcopy -R .log $$o $(MODLIB)/kernel/$(RELDIR)/$$o; done)
 else
 	@echo -n
 endif
 
 else # ! modules_install
+ifeq ($(MAKECMDGOALS),module_templates)
+
+# ==========================================================================
+# Creating event-logging templates for modules
+# ==========================================================================
+
+.PHONY: module_templates
+
+module_templates: sub_dirs
+ifneq ($(obj-m),)
+	@$(TOPDIR)/scripts/generate_templates $(TOPDIR)/templates $(obj-m)
+else
+	@echo -n
+endif
+
+else # ! module_templates
 
 # ==========================================================================
 # Building
@@ -405,6 +423,7 @@
 
 targets += $(host-progs-single) $(host-progs-multi-objs) $(host-progs-multi) 
 
+endif # ! module_templates
 endif # ! modules_install
 endif # ! fastdep
 
diff -Naur linux.org/arch/i386/vmlinux.lds.S linux.problem.patched/arch/i386/vmlinux.lds.S
--- linux.org/arch/i386/vmlinux.lds.S	Mon Sep 23 17:09:51 2002
+++ linux.problem.patched/arch/i386/vmlinux.lds.S	Mon Sep 23 17:09:51 2002
@@ -88,6 +88,7 @@
 	*(.text.exit)
 	*(.data.exit)
 	*(.exitcall.exit)
+	*(.log)
 	}
 
   /* Stabs debugging sections.  */
diff -Naur linux.org/include/linux/problem.h linux.problem.patched/include/linux/problem.h
--- linux.org/include/linux/problem.h	Wed Dec 31 16:00:00 1969
+++ linux.problem.patched/include/linux/problem.h	Mon Sep 23 17:09:51 2002
@@ -0,0 +1,160 @@
+/*
+ * Linux Event Logging for the Enterprise
+ * Copyright (c) International Business Machines Corp., 2002
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ *  Please send e-mail to lkessler@users.sourceforge.net if you have
+ *  questions or comments.
+ *
+ *  Project Website:  http://evlog.sourceforge.net/
+ *
+ */
+
+/*
+ * introduce(), problem(), and detail() macros
+ * Sample usage:
+ *	problem(LOG_ALERT, "Disk on fire!",
+ *		detail(disk, "%s", drive->name),
+ *		detail(temperature, "%d", drive->degC),
+ *		detail(action, "%s", "Put out fire; run fsck."));
+ */
+
+#ifndef _LINUX_PROBLEM_H
+#define _LINUX_PROBLEM_H
+#include <linux/stringify.h>
+#include <linux/kernel.h>
+#include <linux/evl_log.h>
+
+/*
+ * Facility name defaults to the name of the module, as set in the kernel
+ * build.  Define EVL_FACILITY_NAME before including this header if that's
+ * unsatisfactory.
+ */
+#ifndef EVL_FACILITY_NAME
+#define EVL_FACILITY_NAME KBUILD_MODNAME
+#endif
+
+#define introduce(msg, addr, ...) \
+	problem(LOG_INFO, "Introducing: " msg, \
+	detail(addr, "%p", addr), \
+	## __VA_ARGS__)
+
+#ifndef CONFIG_EVLOG
+/*
+ * Enterprise Event Logging not configured.  Use printks.  As usual with
+ * piecemeal printks, these can get garbled on an excited multiprocessor.
+ * Consider buffering up the details and doing one printk() per problem().
+ */
+#define detail(name, fmt, expr) printk(__stringify(name) "=" fmt " ", expr)
+#define problem(sev, string,...) \
+do { \
+   printk("<%d>%s: %s  ", sev, __stringify(EVL_FACILITY_NAME), string); \
+   __VA_ARGS__; printk("\n"); \
+} while(0)
+
+#define array_detail(name, fmt, delim, addr, dim) \
+({ \
+	typeof(addr) a = addr; \
+	int i, d = dim; \
+	printk(__stringify(name) "="); \
+	for (i = 0; i < d; i++) { \
+		printk("%s" fmt, (i > 0 ? (delim) : ""), a[i]); \
+	} \
+})
+#else	/* CONFIG_EVLOG */
+
+extern int evl_gen_event_type(const char *s1, const char *s2, const char *s3);
+extern void __problem(const char *fac, int evtype, posix_log_severity_t sev, ...);
+
+/* This does the printf-style typechecking */
+static void __checkformat(const char *,...)__attribute__((format(printf,1,2)));
+static inline void __checkformat(const char *fmt,...) { }
+
+/*
+ * Bloat doesn't matter: this doesn't end up in vmlinux.
+ * line and file are required to figure out which details() go with which
+ * problem().  All three are good to know.
+ */
+struct log_position
+{
+   int line;
+   char function[128 - sizeof(int)];
+   char file[128];
+};
+
+#define _LOG_POS { __LINE__, __FUNCTION__, __FILE__ }
+
+/*
+ * Information about a problem() message or detail.
+ * Again, bloat doesn't matter: this doesn't end up in vmlinux.
+ * Note that, because of default alignment in the .log section,
+ * sizeof(struct log_info) should be a multiple of 32.
+ */
+struct log_info
+{
+   int type;				/* 1 = problem, 2 = detail */
+   char name[128 - sizeof(int)];	/* message for problem() */
+   char format[64];			/* facility name for problem() */
+   struct log_position pos;
+};
+
+/*
+ * Boils down to __LINE__, __stringify(name), fmt, expr.  Inserts information
+ * into .log section as a side-effect.  The line and name are passed so that
+ * we can make sure the order of attributes (details) in the event record
+ * matches the order in the template generated by generate_templates.c.
+ * Use typeof to avoid evaluating expr twice.
+ */
+#define detail(name, fmt, expr)		\
+__LINE__, __stringify(name), fmt,	\
+({                              \
+   typeof(expr) __expr;                     \
+   static struct log_info __attribute__((section(".log"), unused)) __ \
+      = { 2, __stringify(name), fmt, _LOG_POS };         \
+   (void *)&__expr; /* Avoid uninitialized warning */         \
+   __checkformat(fmt, __expr);                  \
+   expr;                           \
+})
+
+#define problem(sev, string, ...)                  \
+do {                              \
+   static struct log_info __attribute__((section(".log"),unused)) ___ \
+      = { 1, string, __stringify(EVL_FACILITY_NAME), _LOG_POS };               \
+   __problem(__stringify(EVL_FACILITY_NAME), \
+   	evl_gen_event_type(__FILE__, __FUNCTION__, string), \
+	sev, ## __VA_ARGS__, 0);      \
+} while(0)
+
+#define __array_detail(name, fmt, delim, addr, dim) \
+__LINE__, "_ARRAY", __stringify(name), fmt, addr, \
+({ \
+   typeof(*(addr)) __expr; \
+   static struct log_info __attribute__((section(".log"), unused)) __ \
+      = { 3, __stringify(name), fmt "/" delim, _LOG_POS }; \
+   (void *)&__expr; /* Avoid uninitialized warning */ \
+   __checkformat(fmt, __expr);                  \
+   dim; \
+})
+#define array_detail(name, fmt, delim, addr, dim) \
+	detail(name##__dim, "%d", dim), \
+	__array_detail(name, fmt, delim, addr, dim)
+
+#define EVL_MAX_DETAILS 128
+
+#endif /* CONFIG_EVLOG */
+
+#endif /*_LINUX_PROBLEM_H*/
diff -Naur linux.org/kernel/Makefile linux.problem.patched/kernel/Makefile
--- linux.org/kernel/Makefile	Mon Sep 23 17:09:51 2002
+++ linux.problem.patched/kernel/Makefile	Mon Sep 23 17:09:51 2002
@@ -3,7 +3,7 @@
 #
 
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-		printk.o platform.o suspend.o dma.o evlog.o
+		printk.o platform.o suspend.o dma.o evlog.o problem.o
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
@@ -17,7 +17,7 @@
 obj-$(CONFIG_PM) += pm.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
-obj-$(CONFIG_EVLOG) += evlog.o
+obj-$(CONFIG_EVLOG) += evlog.o problem.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -Naur linux.org/kernel/problem.c linux.problem.patched/kernel/problem.c
--- linux.org/kernel/problem.c	Wed Dec 31 16:00:00 1969
+++ linux.problem.patched/kernel/problem.c	Mon Sep 23 17:09:51 2002
@@ -0,0 +1,297 @@
+/*
+ * Linux Event Logging for the Enterprise
+ * Copyright (c) International Business Machines Corp., 2002
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ *  Please send e-mail to lkessler@users.sourceforge.net if you have
+ *  questions or comments.
+ *
+ *  Project Website:  http://evlog.sourceforge.net/
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/time.h>
+#include <linux/smp_lock.h>
+#include <linux/evl_log.h>
+#include <linux/problem.h>
+#include <stdarg.h>
+
+extern int evl_gen_facility_code(const char *fname,
+	posix_log_facility_t *fcode);
+extern const char *parse_printf_fmt(const char *fmt, int *pqualifier, int *wp);
+extern void evl_append_to_buf(char *buf, size_t *reclen, const void *data,
+	size_t datasz);
+extern void evl_append_string_to_buf(char *buf, size_t *reclen, const char *s,
+	int null);
+
+enum dtype {
+	dty_int,
+	dty_string,
+	dty_array
+};
+
+/* "detail" is a macro name, so we have to misspell it here. */
+struct dtail {
+	long long	value;
+	enum dtype	type;
+	int		size;	/* in bytes */
+	int		line;
+	const char	*name;
+};
+
+/*
+ * details[] currently contains nd elements.  Find the slot for the new detail
+ * whose line number and name are line and name.  (If is_array = 1, that detail
+ * will sort AFTER other details on that line.)  If this slot is occupied,
+ * shift the others up accordingly.  An insertion sort, necessitated by the
+ * lack of qsort in the kernel.
+ */
+static int
+find_slot_for_detail(struct dtail *details, int nd, int line, const char *name,
+	int is_array)
+{
+	int dx, i;
+
+	for (dx = nd; dx > 0; dx--) {
+		int ret;
+		ret = line - details[dx-1].line;
+		if (ret == 0) {
+			int dx1_is_array = (details[dx-1].type == dty_array);
+			ret = is_array - dx1_is_array;
+			if (ret == 0) {
+				ret = strcmp(name, details[dx-1].name);
+			}
+		}
+		if (ret >= 0) {
+			break;
+		}
+	}
+	
+	for (i = nd; i > dx; i--) {
+		details[i] = details[i-1];
+	}
+	return dx;
+}
+
+/*
+ * buf is a buffer of size POSIX_LOG_ENTRY_MAXLEN.  It currently contains
+ * *reclen bytes.  args is a zero-terminated list of line/name/format/value
+ * sets -- for example,
+ *	101,"m","%d",x->m, 101,"n","%llx",n, 102,"s","%s",x->s, 0
+ * For a value that's an array, the arg "_ARRAY" appears between the line
+ * number and name, and the "value" is an address/dimension pair -- for example,
+ *	101, "_ARRAY", "macaddr", "%hhx", x->macaddr, 8
+ * Using each format as a guide, copy the corresponding values into buf.
+ * Before packing, values are sorted according to line number and name.
+ * (This is necessary because we cannot otherwise guarantee that the
+ * corresponding information generated from the .log section will match
+ * our order.)
+ *
+ * Set *reclen to what the updated size would be if buf were big enough.
+ * Called with problem_lock held.
+ *
+ * Note: This function is based on vsnprintf() (see lib/vsprintf.c), and
+ * should be kept in sync with that function.
+ */
+static int
+evl_pack_details(char *buf, size_t *reclen, va_list args)
+{
+#define COPYDETAIL(type) { \
+	type v=va_arg(args,type); \
+	memcpy(&details[dx].value, &v, sizeof(v)); \
+	details[dx].size = sizeof(v); \
+}
+
+	const char *s, *arr;
+	struct dtail details[EVL_MAX_DETAILS];
+	int i, nd, dx, line;
+
+	for (nd = 0; (line = va_arg(args, int)) != 0; nd++) {
+		const char *fmt;
+		const char *name;
+		int qualifier;	/* as in pack_args() */
+		int wp = 0x0;
+		int is_array = 0;
+
+		if (nd >= EVL_MAX_DETAILS) {
+			printk(KERN_ERR "problem() call has > %d details; excess details ignored\n",
+				EVL_MAX_DETAILS);
+			break;
+		}
+
+		name = va_arg(args, char*);
+		if (!strcmp(name, "_ARRAY")) {
+			is_array = 1;
+			name = va_arg(args, char*);
+		}
+		dx = find_slot_for_detail(details, nd, line, name, is_array);
+		details[dx].line = line;
+		details[dx].name = name;
+		details[dx].type = (is_array ? dty_array : dty_int);
+
+		fmt = va_arg(args, char*);
+		if (*fmt != '%') {
+			return -1;
+		}
+
+		fmt = parse_printf_fmt(fmt, &qualifier, &wp);
+
+		if (strlen(fmt) != 1 || wp != 0x0) {
+			return -1;
+		}
+
+		if (is_array) {
+			int dim, elsz;
+			arr = va_arg(args, void*);
+			dim = va_arg(args, int);
+			if (dim < 0) {
+				dim = 0;
+			}
+			switch (*fmt) {
+			case 'c':
+				/*
+				 * Should we default to int here, and respect
+				 * %hc and %hhc?  That would probably be
+				 * counter-intuitive.
+				 */
+				elsz = sizeof(char);
+				break;
+			case 'p':
+				elsz = sizeof(void*);
+				break;
+			case 'o':
+			case 'X':
+			case 'x':
+			case 'd':
+			case 'i':
+			case 'u':
+				switch (qualifier) {
+		    		case 'L': elsz = sizeof(long long);	break;
+		    		case 'l': elsz = sizeof(long);		break;
+				case 'Z': elsz = sizeof(size_t);	break;
+				case 'H': elsz = sizeof(char);		break;
+				case 'h': elsz = sizeof(short);		break;
+				default:  elsz = sizeof(int);		break;
+				}
+				break;
+			default:	return -1;
+			}
+			details[dx].size = dim * elsz;
+			memcpy(&details[dx].value, &arr, sizeof(void*));
+		} else {
+			/* Not array */
+			switch (*fmt) {
+			case 'c':
+				COPYDETAIL(int)
+				break;
+			case 's':
+				s = va_arg(args, char *);
+				memcpy(&details[dx].value, &s, sizeof(char*));
+				details[dx].type = dty_string;
+				break;
+			case 'p':
+				COPYDETAIL(void*)
+				break;
+			case 'o':
+			case 'X':
+			case 'x':
+			case 'd':
+			case 'i':
+			case 'u':
+				switch (qualifier) {
+		    		case 'L': COPYDETAIL(long long)	break;
+		    		case 'l': COPYDETAIL(long)	break;
+				case 'Z': COPYDETAIL(size_t)	break;
+				default:  COPYDETAIL(int)	break;
+				}
+				break;
+			default:
+				/* Bogus conversion */
+				return -1;
+			}
+		}
+	}
+
+	for (i = 0; i < nd; i++) {
+		switch (details[i].type) {
+		case dty_int:
+			evl_append_to_buf(buf, reclen, &details[i].value,
+				details[i].size);
+			break;
+		case dty_string:
+			memcpy(&s, &details[i].value, sizeof(char*));
+			evl_append_string_to_buf(buf, reclen, s, 1);
+			break;
+		case dty_array:
+			memcpy(&arr, &details[i].value, sizeof(void*));
+			evl_append_to_buf(buf, reclen, arr, details[i].size);
+			break;
+		}
+	}
+	return 0;
+}
+
+/*
+ * We make recbuf static and protect it with a lock because it may be too
+ * big for the kernel stack.
+ */
+static char recbuf[POSIX_LOG_ENTRY_MAXLEN];
+static spinlock_t problem_lock = SPIN_LOCK_UNLOCKED;
+/*
+ * Log an event with the indicated facility, event type, and severity.
+ * The remaining args are quartets of (line, name, format, value).  A
+ * line number of 0 terminates the args.  The line number and name are
+ * used to determine the order, and the (printf) format is used to
+ * determine the type.
+ */
+void
+__problem(const char *facname, int evtype, posix_log_severity_t sev, ...)
+{
+	va_list args;
+	posix_log_facility_t faccode;
+	size_t reclen = 0;
+	uint flags = 0;
+	unsigned long plflags;
+
+	if (evl_gen_facility_code(facname, &faccode) != 0) {
+		faccode = LOG_KERN;
+	}
+
+	spin_lock_irqsave(&problem_lock, plflags);
+	va_start(args, sev);
+	if (evl_pack_details(recbuf, &reclen, args) != 0) {
+		printk(KERN_ERR "evl_pack_details() failed in __problem() -- "
+			"facility=%s, event type=0x%x, severity=%d\n",
+			facname, evtype, sev);
+	}
+	va_end(args);
+
+	if (reclen > POSIX_LOG_ENTRY_MAXLEN) {
+		reclen = POSIX_LOG_ENTRY_MAXLEN;
+		flags |= POSIX_LOG_TRUNCATE;
+	}
+
+	(void) posix_log_write(faccode, evtype, sev, recbuf, reclen,
+		(reclen == 0 ? POSIX_LOG_NODATA : POSIX_LOG_BINARY), flags);
+	spin_unlock_irqrestore(&problem_lock, plflags);
+}
+
+EXPORT_SYMBOL(__problem);
diff -Naur linux.org/scripts/Makefile linux.problem.patched/scripts/Makefile
--- linux.org/scripts/Makefile	Mon Sep 23 17:09:51 2002
+++ linux.problem.patched/scripts/Makefile	Mon Sep 23 17:09:51 2002
@@ -8,8 +8,10 @@
 # docproc: 	 Preprocess .tmpl file in order to generate .sgml documentation
 # conmakehash:	 Create arrays for initializing the kernel console tables
 # tkparse: 	 Used by xconfig
+# generate_templates:	Used to generate a formatting template for each
+#		problem() call in the kernel
 
-all: fixdep split-include docproc conmakehash __chmod
+all: fixdep split-include docproc conmakehash __chmod generate_templates
 
 # The following temporary rule will make sure that people's
 # trees get updated to the right permissions, since patch(1)
@@ -63,3 +65,5 @@
 	@rm -f core $(host-progs)
 	@$(MAKE) -C lxdialog mrproper
 
+generate_templates: generate_templates.c evlib.c evlib.h
+	$(HOSTCC) $(HOSTCFLAGS) -o generate_templates generate_templates.c evlib.c -lbfd -liberty
diff -Naur linux.org/scripts/evlib.c linux.problem.patched/scripts/evlib.c
--- linux.org/scripts/evlib.c	Wed Dec 31 16:00:00 1969
+++ linux.problem.patched/scripts/evlib.c	Mon Sep 23 17:09:51 2002
@@ -0,0 +1,398 @@
+/*
+ * Linux Event Logging for the Enterprise
+ * Copyright (c) International Business Machines Corp., 2002
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ *  Please send e-mail to lkessler@users.sourceforge.net if you have
+ *  questions or comments.
+ *
+ *  Project Website:  http://evlog.sourceforge.net/
+ *
+ */
+
+#include <stdlib.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stddef.h>
+#include <string.h>
+#include <ctype.h>
+#include <assert.h>
+#include <stdint.h>
+#include <errno.h>
+
+#include "evlib.h"
+
+/*
+ * This file contains functions from libevl that are used by
+ * generate_templates.c.
+ */
+
+/*** from libevl's lib/template/template.c ***/
+struct type_info _evlTmplTypeInfo[] = {
+	{ "none" },
+	{ "schar" },
+	{ "uchar" },
+	{ "short" },
+	{ "ushort" },
+	{ "int" },
+	{ "uint" },
+	{ "long" },
+	{ "ulong" },
+	{ "longlong" },
+	{ "ulonglong" },
+	{ "float" },
+	{ "double" },
+	{ "ldouble" },
+	{ "string" },
+	{ "wchar" },
+	{ "wstring" },
+	{ "address" },
+	{ "struct" },
+	{ "prefix3" },
+	{ "list" },
+	{ "struct" },
+	{ "typedef" },
+	{ 0 }
+};
+
+/*** from libevl's lib/util/format.c ***/
+
+/*
+ * fmt points to the character after the % in a printf-style conversion spec.
+ * Parse the spec into its components and store them in *pf.  Returns -1 if
+ * an error is detected, or 0 otherwise.
+ *
+ * Only 'l', 'L', 'h', 'z', 'j', and 't' are recognized as modifier characters.
+ * Also 'Z' for printk.
+ * There is no check here for the validity of the conversion letter or of the
+ * modifier letters.  That's up to the caller.  (_evlGetTypeFromConversion()
+ * can be used to do this check.)
+ */
+int
+_evlParseFmtConvSpec(const char *fmt, struct evl_parsed_format *pf)
+{
+	static char *flags = "-+ #0'";
+	unsigned long width = 0;
+	unsigned long precision = 0;
+	const char *f;
+	const char *c;
+	const char *modifier;
+	int nflags = 0, mfwidth = 0;
+
+	for (f = fmt; strchr(flags, *f); f++) {
+		/* *f is a flag.  Make sure there are no duplicates. */
+		for (c = fmt; c < f; c++) {
+			if (*c == *f) {
+				return -1;
+			}
+		}
+	}
+	nflags = f - fmt;
+
+	/* f points to the character after the flags. */
+	width = strtoul(f, (char**) &c, 10);
+
+	/* c points to the character after the width. */
+	f = c;
+	if (*f == '.') {
+		f++;
+		precision = strtoul(f, (char**) &c, 10);
+		if (width == 0 && c == f) {
+			/* Just the period, no numbers. */
+			return -1;
+		}
+		f = c;
+	}
+
+	/* f points to the letter(s) at the end of the conversion spec. */
+	modifier = f;
+	while (strchr("hjlLtzZ", *f)) {
+		f++;
+	}
+	mfwidth = f - modifier;
+	if (mfwidth > 2) {
+		/* Too many modifier letters. */
+		return -1;
+	}
+
+	/* f had better point to the conversion letter. */
+	if (!isalpha(*f)) {
+		return -1;
+	}
+
+	pf->fm_width = width;
+	pf->fm_precision = precision;
+	pf->fm_length = 1 + (f - fmt);
+	pf->fm_conversion = *f;
+	if (nflags > 0) {
+		(void) strncpy(pf->fm_flags, fmt, nflags);
+	}
+	pf->fm_flags[nflags] = '\0';
+	if (mfwidth > 0) {
+		(void) strncpy(pf->fm_modifier, modifier, mfwidth);
+	}
+	pf->fm_modifier[mfwidth] = '\0';
+	return 0;
+}
+
+/***** Parsing of printf-style format strings *****/
+
+/*
+ * Architecture-dependent types that correspond to %d modifiers that are
+ * extensions in glibc printf().
+ */
+static tmpl_base_type_t typeof_size_t;	/* %zd */
+static tmpl_base_type_t typeof_intmax_t;	/* %jd */
+static tmpl_base_type_t typeof_ptrdiff_t;	/* %td */
+
+/* Return a basic int type whose size is sz. */
+static tmpl_base_type_t
+computeIntType(size_t sz)
+{
+	if (sz == sizeof(int)) {
+		return TY_INT;
+	} else if (sz == sizeof(long)) {
+		return TY_LONG;
+	} else if (sz == sizeof(long long)) {
+		return TY_LONGLONG;
+	}
+
+	assert(0);
+	/*NOTREACHED*/
+	return TY_INT;
+}
+
+static void
+computeSpecialTypes(void)
+{
+	static int alreadyComputed = 0;
+	if (alreadyComputed) {
+		return;
+	}
+	typeof_size_t = computeIntType(sizeof(size_t));
+	typeof_intmax_t = computeIntType(sizeof(intmax_t));
+	typeof_ptrdiff_t = computeIntType(sizeof(ptrdiff_t));
+	alreadyComputed = 1;
+}
+
+/* Handle %<mod>c.  We recognize only %c and %lc. */
+static tmpl_base_type_t
+adjustCharType(const char *mod, int promote)
+{
+	if (!strcmp(mod, "")) {
+		return (promote ? TY_INT : TY_CHAR);
+	}
+	if (!strcmp(mod, "l")) {
+		return TY_WCHAR;
+	}
+	return TY_NONE;
+}
+
+/* Handle modifiers to %d and similar int conversions. */
+static tmpl_base_type_t
+adjustIntType(const char *mod, int promote)
+{
+	if (!strcmp(mod, "")) {
+		return TY_INT;
+	}
+	if (!strcmp(mod, "h")) {
+		return (promote ? TY_INT : TY_SHORT);
+	}
+	if (!strcmp(mod, "hh")) {
+		return (promote ? TY_INT : TY_CHAR);
+	}
+	if (!strcmp(mod, "l")) {
+		return TY_LONG;
+	}
+	if (!strcmp(mod, "ll")
+	    || !strcmp(mod, "L") /* for printk */ ) {
+		return TY_LONGLONG;
+	}
+	if (!strcmp(mod, "z")
+	    || !strcmp(mod, "Z") /* for printk */ ) {
+		computeSpecialTypes();
+		return typeof_size_t;
+	}
+	if (!strcmp(mod, "j")) {
+		computeSpecialTypes();
+		return typeof_intmax_t;
+	}
+	if (!strcmp(mod, "t")) {
+		computeSpecialTypes();
+		return typeof_ptrdiff_t;
+	}
+	return TY_NONE;
+}
+
+/*
+ * Handle modifiers to %f and similar double conversions.  The only
+ * modifier we recognize is L.
+ */
+static tmpl_base_type_t
+adjustDoubleType(const char *mod)
+{
+	if (!strcmp(mod, "")) {
+		return TY_DOUBLE;
+	}
+	if (!strcmp(mod, "L")) {
+		return TY_LDOUBLE;
+	}
+	return TY_NONE;
+}
+
+/* Handle %<mod>s.  We recognize only %s and %ls. */
+static tmpl_base_type_t
+adjustStringType(const char *mod)
+{
+	if (!strcmp(mod, "")) {
+		return TY_STRING;
+	}
+	if (!strcmp(mod, "l")) {
+		return TY_WSTRING;
+	}
+	return TY_NONE;
+}
+
+/* Handle %<mod>n.  Theoretically, we can get this via printk(). */
+static tmpl_base_type_t
+validateNConversion(const char *mod) {
+	if (!strcmp(mod, "")
+	    || !strcmp(mod, "l")
+	    || !strcmp(mod, "ll")
+	    || !strcmp(mod, "L")) {
+		return TY_SPECIAL;
+	}
+	return TY_NONE;
+}
+
+/*
+ * Given parsed conversion spec pf, return the type of value it converts.
+ * If promote != 0, promote small integers to int.
+ * Return TY_NONE for an illegal modifier/conversion combo.
+ */
+tmpl_base_type_t
+_evlGetTypeFromConversion(struct evl_parsed_format *pf, int promote)
+{
+	const char *mod = pf->fm_modifier;
+
+	switch (pf->fm_conversion) {
+	case 'c':
+		return adjustCharType(mod, promote);
+	case 'd':
+	case 'i':
+	case 'o':
+	case 'u':
+	case 'x':
+	case 'X':
+		return adjustIntType(mod, promote);
+	case 'a':
+	case 'A':
+	case 'e':
+	case 'E':
+	case 'f':
+	case 'F':
+	case 'g':
+	case 'G':
+		return adjustDoubleType(mod);
+	case 's':
+		return adjustStringType(mod);
+	case 'p':
+		return (strlen(mod) == 0 ? TY_ADDRESS : TY_NONE);
+	case 'C':
+		return (strlen(mod) == 0 ? TY_WCHAR : TY_NONE);
+	case 'S':
+		return (strlen(mod) == 0 ? TY_WSTRING : TY_NONE);
+	case 'n':
+		return validateNConversion(mod);
+	default:
+		return TY_NONE;
+	}
+	/*NOTREACHED*/
+}
+
+/*** from libevl's lib/facreg.c ***/
+
+/*
+ * This is the code for CRC algorithm #1 from
+ * http://www.cl.cam.ac.uk/Research/SRG/bluebook/21/crc/node6.html.
+ * It was chosen for simplicity rather than efficiency, since we don't expect
+ * it to be called much.
+ */
+
+#define QUOTIENT 0x04c11db7
+
+unsigned int
+evl_crc32(const unsigned char *data, int len)
+{
+	unsigned int	result;
+	int		i,j;
+	unsigned char	octet;
+    
+	result = -1;
+    
+	for (i=0; i<len; i++) {
+		octet = *(data++);
+		for (j=0; j<8; j++) {
+			if ((octet >> 7) ^ (result >> 31)) {
+				result = (result << 1) ^ QUOTIENT;
+			} else {
+				result = (result << 1);
+			}
+			octet <<= 1;
+		}
+	}
+ 
+	return ~result;	/* The complement of the remainder */
+}
+
+/***** from libevl's lib/facreg.c *****/
+
+int
+_evlGenCanonicalFacilityName(const unsigned char *facName,
+	unsigned char *canonical)
+{
+	const unsigned char *f;
+	unsigned char *c;
+
+	if (!facName || !canonical || facName[0] == '\0') {
+		return EINVAL;
+	}
+
+	for (f=facName, c=canonical; *f; f++, c++) {
+		unsigned int uf = *f;
+		if ('A' <= uf && uf <= 'Z') {
+			*c = uf | 0x20;		/* ASCII toupper(uf) */
+		} else if (uf > 0x7f
+		    || ('a' <= uf && uf <= 'z')
+		    || ('0' <= uf && uf <= '9')
+		    || uf == '.'
+		    || uf == '_') {
+			*c = uf;
+		} else if (uf == ' ') {
+			*c = '_';
+		} else {
+			*c = '.';
+		}
+	}
+	*c = '\0';
+
+	/* "." and ".." are reserved directory names, so we convert them. */
+	if (!strcmp(canonical, ".") || !strcmp(canonical, "..")) {
+		canonical[0] = '_';
+	}
+	return 0;
+}
diff -Naur linux.org/scripts/evlib.h linux.problem.patched/scripts/evlib.h
--- linux.org/scripts/evlib.h	Wed Dec 31 16:00:00 1969
+++ linux.problem.patched/scripts/evlib.h	Mon Sep 23 17:09:51 2002
@@ -0,0 +1,78 @@
+/*
+ * Linux Event Logging for the Enterprise
+ * Copyright (c) International Business Machines Corp., 2002
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ *  Please send e-mail to lkessler@users.sourceforge.net if you have
+ *  questions or comments.
+ *
+ *  Project Website:  http://evlog.sourceforge.net/
+ *
+ */
+
+/*** from evlib's include/evl_template.h ***/
+typedef enum tmpl_base_type {
+	TY_NONE,	/* absence of value */
+	TY_CHAR,	/* signed char, actually */
+	TY_UCHAR,
+	TY_SHORT,
+	TY_USHORT,
+	TY_INT,
+	TY_UINT,
+	TY_LONG,
+	TY_ULONG,
+	TY_LONGLONG,
+	TY_ULONGLONG,
+	TY_FLOAT,
+	TY_DOUBLE,
+	TY_LDOUBLE,
+	TY_STRING,
+	TY_WCHAR,
+	TY_WSTRING,
+	TY_ADDRESS,
+	TY_STRUCT,
+	TY_PREFIX3,
+	TY_LIST,	/*for arrays of structs, and when parsing initializers*/
+	TY_STRUCTNAME,		/* converted to TY_STRUCT after lookup */
+	TY_TYPEDEF,		/* type name better be a typedef name */
+	TY_SPECIAL		/* catch-all for special cases */
+} tmpl_base_type_t;
+
+/* Just the relevant field here... */
+struct type_info {
+	const char *ti_name;
+};
+
+extern struct type_info _evlTmplTypeInfo[];
+
+/*** from evlib's include/evl_util.h ***/
+
+struct evl_parsed_format {
+	char	fm_flags[10];	/* e.g., "#0" in "%#08x" */
+	int	fm_width;	/* e.g., 2 in "%02d" */
+	int	fm_precision;	/* e.g., 2 in "%6.2f" */
+	char	fm_modifier[3];	/* e.g., "ll" in "%lld" */
+	char	fm_conversion;	/* e.g., 'f' in "%6.2f" */
+	size_t	fm_length;	/* not counting % */
+};
+
+extern int _evlParseFmtConvSpec(const char *fmt, struct evl_parsed_format *pf);
+extern tmpl_base_type_t _evlGetTypeFromConversion(struct evl_parsed_format *pf,
+	int promote);
+extern unsigned int evl_crc32(const unsigned char *data, int len);
+extern int _evlGenCanonicalFacilityName(const unsigned char *facName,
+	unsigned char *canonical);
diff -Naur linux.org/scripts/generate_templates.c linux.problem.patched/scripts/generate_templates.c
--- linux.org/scripts/generate_templates.c	Wed Dec 31 16:00:00 1969
+++ linux.problem.patched/scripts/generate_templates.c	Mon Sep 23 17:09:51 2002
@@ -0,0 +1,392 @@
+/*
+ * Linux Event Logging for the Enterprise
+ * Copyright (c) International Business Machines Corp., 2002
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ *  Please send e-mail to lkessler@users.sourceforge.net if you have
+ *  questions or comments.
+ *
+ *  Project Website:  http://evlog.sourceforge.net/
+ *
+ */
+
+/*
+ * Usage: generate_templates tmpldir file1.o file2.o ...
+ * This program extracts data from the .log section of each specified
+ * object file, and produces a formatting template in the tmpldir directory
+ * for each event-logging call.
+ */
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdint.h>
+#include <ctype.h>
+#include <bfd.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <errno.h>
+#include <limits.h>
+
+#include "evlib.h"
+
+static const char *progname = NULL;
+static int errors = 0;
+
+/* From linux/problem.h */
+struct log_position {
+	int line;
+	char function[128 - sizeof(int)];
+	char file[128];
+};
+
+struct log_info {
+	int type;		/* 1 = problem, 2 = detail */
+	char name[128 - sizeof(int)];		/* message for problem() */
+	char format[64];	/* facility name for problem() */
+	struct log_position pos;
+};
+
+static unsigned int
+crc32(const char *s)
+{
+	return evl_crc32((const unsigned char*)s, strlen(s));
+}
+
+static int
+compute_event_type(const struct log_info *info)
+{
+	return crc32(info->pos.file)
+		+ crc32(info->pos.function)
+		+ crc32(info->name);
+}
+
+static void
+ensure_dir_exists(const char *path)
+{
+	struct stat st;
+	if (stat(path, &st) == 0) {
+		if (!S_ISDIR(st.st_mode)) {
+			errno = ENOTDIR;
+			goto badpath;
+		}
+	} else {
+		if (errno != ENOENT) {
+			goto badpath;
+		}
+		if (mkdir(path, 0755) != 0) {
+			goto badpath;
+		}
+	}
+	return;
+
+badpath:
+	fprintf(stderr, "%s: directory does not exist and cannot be created:\n",
+		progname);
+	perror(path);
+	exit(1);
+}
+
+/*
+ * Open the template source file for the facility named facname --
+ * rootdir/cfacname/cfacname.t, where cfacname is the canonical version
+ * of facname.  If necessary, create the file and the directory it goes in.
+ * Return a pointer to the open file, or NULL on failure.
+ */
+static FILE *
+open_tmpl_src_file(const char *rootdir, const char *facname)
+{
+	char path[PATH_MAX];
+	char cfacname[PATH_MAX];
+	FILE *f;
+
+	(void) _evlGenCanonicalFacilityName(facname, cfacname);
+	if (snprintf(path, PATH_MAX, "%s/%s", rootdir, cfacname) >= PATH_MAX) {
+		errno = ENAMETOOLONG;
+		goto badpath;
+	}
+	ensure_dir_exists(path);
+
+	if (snprintf(path, PATH_MAX, "%s/%s/%s.t", rootdir, cfacname, cfacname)
+	    >= PATH_MAX) {
+		errno = ENAMETOOLONG;
+		goto badpath;
+	}
+
+	f = fopen(path, "a");
+	if (!f) {
+		goto badpath;
+	}
+	if (ftell(f) == 0L) {
+		/* First time opening this file */
+		fprintf(f, "/*\n");
+		fprintf(f, " * Automatically generated by %s\n", progname);
+		fprintf(f, " * Register facility with /sbin/evlfacility -a '%s' -k\n", facname);
+		fprintf(f, " * Compile with /sbin/evltc %s.t\n", cfacname);
+		fprintf(f, " */\n");
+	}
+
+	return f;
+
+badpath:
+	fprintf(stderr, "%s: Cannot open template source file %s.t\n",
+		progname, cfacname);
+	perror(path);
+	exit(1);
+	/*NOTREACHED*/
+}
+
+/*
+ * Copy s to a static buffer, replacing special characters with 2-character
+ * escapes.  Return the buffer's address.
+ */
+static char *
+add_escapes(const char *s)
+{
+	static char s_with_escapes[512];
+	char *swe;
+	for (swe = s_with_escapes; *s; s++, swe++) {
+		switch (*s) {
+		case '\\':	*swe++ = '\\'; *swe = '\\'; break;
+		case '"':	*swe++ = '\\'; *swe = '"'; break;
+		case '\a':	*swe++ = '\\'; *swe = 'a'; break;
+		case '\b':	*swe++ = '\\'; *swe = 'b'; break;
+		case '\f':	*swe++ = '\\'; *swe = 'f'; break;
+		case '\n':	*swe++ = '\\'; *swe = 'n'; break;
+		case '\r':	*swe++ = '\\'; *swe = 'r'; break;
+		case '\t':	*swe++ = '\\'; *swe = 't'; break;
+		case '\v':	*swe++ = '\\'; *swe = 'v'; break;
+		default:	*swe = *s; break;
+		}
+	}
+	*swe = '\0';
+	return s_with_escapes;
+}
+
+/*
+ * Create the template source for the problem() call whose information
+ * is pointed to by info.  num_details is the number of details
+ * (non-const attributes) in the call.
+ */
+static void
+create_template(const char *rootdir, const struct log_info *info,
+	int num_details)
+{
+	int i;
+	const char *facname = info->format;
+	FILE *t = open_tmpl_src_file(rootdir, facname);
+
+	fprintf(t, "facility \"%s\";\n", facname);
+	fprintf(t, "event_type 0x%x;\n", compute_event_type(info));
+	fprintf(t, "const {\n");
+	fprintf(t, "\tstring message = \"%s\";\n", add_escapes(info->name));
+	fprintf(t, "\tstring file = \"%s\";\n", info->pos.file);
+	fprintf(t, "\tstring function = \"%s\";\n", info->pos.function);
+	fprintf(t, "\tint line = %d;\n", info->pos.line);
+	fprintf(t, "}\n");
+	if (num_details > 0) {
+		fprintf(t, "attributes {\n");
+		for (i = 1; i <= num_details; i++) {
+			tmpl_base_type_t ty;
+			struct evl_parsed_format pf;
+			char *fmt = info[i].format;
+			char *slash, *delimiter = NULL;
+			int is_array = 0;
+
+			if (info[i].type == 3) {
+				/*
+				 * An array attribute.  The format string
+				 * contains both the format and the delimiter,
+				 * separated by '/'.  We should previously
+				 * have spit out the dimension attribute, with
+				 * the name arrname__dim.
+				 */
+				is_array = 1;
+				slash = strchr(fmt, '/');
+				if (slash) {
+					*slash = '\0';
+					delimiter = slash + 1;
+				} else {
+					fprintf(stderr,
+"%s: bad format/delimiter %s for detail %s of problem \"%s\"\n",
+						progname, fmt, info[i].name,
+						info->name);
+					errors++;
+					delimiter = " ";
+				}
+			}
+			if (*fmt != '%'
+			    || _evlParseFmtConvSpec(fmt+1, &pf) != 0) {
+				fprintf(stderr,
+"%s: bad format %s for detail %s of problem \"%s\"\n",
+					progname, fmt, info[i].name,
+					info->name);
+				errors++;
+				continue;
+			}
+			ty = _evlGetTypeFromConversion(&pf, !is_array);
+			if (is_array) {
+				fprintf(t, "\t%s %s[%s__dim] \"%s\" delimiter=\"%s\";\n",
+					_evlTmplTypeInfo[ty].ti_name,
+					info[i].name, info[i].name, fmt,
+					add_escapes(delimiter));
+			} else {
+				fprintf(t, "\t%s %s \"%s\";\n",
+					_evlTmplTypeInfo[ty].ti_name,
+					info[i].name, fmt);
+			}
+		}
+		fprintf(t, "}\n");
+	}
+	fprintf(t, "format\n");
+	fprintf(t, "%%file%%:%%function%%:%%line%%\n");
+	fprintf(t, "%%message%%");
+	if (num_details > 0) {
+		fprintf(t, " ");
+		for (i = 1; i <= num_details; i++) {
+			fprintf(t, " %s=%%%s%%", info[i].name, info[i].name);
+		}
+	}
+	fprintf(t, "\n");
+	fprintf(t, "END\n");
+	(void) fclose(t);
+}
+
+/*
+ * Used by qsort.  Note that details on the same line are sorted by name.
+ * We haven't figured out a way to ensure that the order is the same as
+ * in the problem() call, which would be preferable.  More important is
+ * that the order is predictable, even across architectures.
+ */
+static int
+compare_loginfos(const void *va, const void *vb)
+{
+	const struct log_info *a = va, *b = vb;
+	int ret;
+
+	ret = strcmp(a->pos.file, b->pos.file);
+	if (ret == 0) {
+		ret = a->pos.line - b->pos.line;
+		if (ret == 0) {
+			ret = a->type - b->type;
+			if (ret == 0) {
+				ret = strcmp(a->name, b->name);
+			}
+		}
+	}
+	return ret;
+}
+
+static unsigned int
+num_details(const struct log_info *info)
+{
+	unsigned int i;
+
+	for (i = 1; info[i].type > 1; i++);
+	return i-1;
+}
+
+#ifdef DEBUG
+static void
+dump_details(const struct log_info *info, int ndetails)
+{
+	const struct log_info *in, *end = info + ndetails;
+	for (in = info; in < end; in++) {
+		printf("%p %d %s\t%s\t%s:%s:%d\n",
+			in, in->type, in->name, in->format,
+			in->pos.file, in->pos.function, in->pos.line);
+	}
+}
+#endif
+
+static void
+do_section(bfd *bfd, asection *log, void *tsd)
+{
+	bfd_size_type size;
+	size_t number;
+	struct log_info *contents, *info;
+
+	/* Not log section? */
+	if (strcmp(log->name, ".log") != 0)
+		return;
+
+	size = bfd_section_size(bfd, log);
+	number = size / sizeof(struct log_info);
+	contents = malloc(size + sizeof(struct log_info));
+
+	if (!bfd_get_section_contents(bfd, log, contents, 0, size)) {
+		bfd_perror("Getting section contents");
+		exit(1);
+	}
+
+	/* Sort them into order, to ensure details for all problems adjacent */
+	qsort(contents, number, sizeof(struct log_info), compare_loginfos);
+
+	/* Terminator can't look like a detail (type = 2, 3, etc). */
+	contents[number].type = 0;
+
+	for (info = contents; info < contents + number;
+	    info += num_details(info) + 1) {
+		create_template(tsd, info, num_details(info));
+	}
+	free(contents);
+}
+
+int
+main(int argc, char *argv[])
+{
+	unsigned int i;
+	const char *tsd;	/* template source directory */
+
+	progname = argv[0];
+
+	bfd_init();
+	tsd = argv[1];
+	ensure_dir_exists(tsd);
+
+	for (i = 2; i < argc; i++) {
+		bfd *obj;
+
+		obj = bfd_openr(argv[i], NULL);
+		if (bfd_get_error()) {
+			bfd_perror("Opening file");
+			exit(1);
+		}
+		/* You have to check format before using it.  Sigh. */
+		if (bfd_check_format(obj, bfd_archive)) {
+			bfd *i, *nexti;
+
+			for (i = bfd_openr_next_archived_file(obj, NULL);
+			    i;
+			    i = nexti) {
+				bfd_map_over_sections(i, do_section, (void*) tsd);
+				nexti = bfd_openr_next_archived_file(obj, i);
+				bfd_close(i);
+				bfd_set_error(bfd_error_no_error);
+			}
+		} else if (bfd_check_format(obj, bfd_object)) {
+			bfd_map_over_sections(obj, do_section, (void*) tsd);
+		} else {
+			bfd_perror("Identifying file");
+			exit(1);
+		}
+		bfd_close(obj);
+		/* BFD's error caching is screwed.  Grrr. */
+		bfd_set_error(bfd_error_no_error);
+	}
+	exit (errors ? 1 : 0);
+}
