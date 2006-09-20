Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWITUSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWITUSK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 16:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWITUSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 16:18:09 -0400
Received: from tomts25-srv.bellnexxia.net ([209.226.175.188]:22959 "EHLO
	tomts25-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1750726AbWITUSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 16:18:04 -0400
Date: Wed, 20 Sep 2006 16:18:01 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: "Frank Ch. Eigler" <fche@redhat.com>, Karim Yaghmour <karim@opersys.com>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, Tom Zanussi <zanussi@us.ibm.com>,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       systemtap@sources.redhat.com, ltt-dev@shafik.org
Subject: [PATCH] Linux Kernel Markers 0.3 for Linux 2.6.17
Message-ID: <20060920201801.GA26897@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 15:52:20 up 28 days, 17:01,  4 users,  load average: 0.55, 0.51, 0.65
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


Following the advices I received, and reusing Frank's marker mechanism,
I made a much simplified, yet very very low impact, version of markers.


Only two modes (can be both enabled) :

  * Replace markers by a symbol
  * Replace markers by a jump over an inactive call

Absolutely no code polymorphism is necessary and it is fully portable. 
Dynamically overriding addresses at those symbols at runtime (both the jump
target and the function call address) permits dynamic activation of
instrumentation. On-the-fly removal of the instrumentation is possible,
as well as unloading of its module.

Jump impact : 1.16 cycles (see tests below)


Comments are welcome. :)

Mathieu


* Tests

Tests (load value, test and predicted branch in a loop vs load value
and jump to this address) show that there is a performance amelioration
with the approach I propose. (tests done in user space (upper-bound))

This is on a 3Ghz Pentium 4 with hyperthreading enabled

No instrumentation at all, simply running a loop:
Cycles for 1000000000 loops : 6595327792
(avg. 6.59 cycles per loop)

This load+jump approach :
Cycles for 1000000000 loops of load+jump : 7756373910
(avg. 7.75 cycles per loop)

Frank "predicted branch" approach :
Cycles for 1000000000 loops of load,test+predicted branch : 10036469235
(avg. 10.03 cycles per loop)

So, Frank's approach seems to add a 3.44 cycles each time the sleeping probe is
hit, while my approach adds 1.16 cycles.



--- BEGIN ---

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
@@ -0,0 +1,76 @@
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
+#ifdef CONFIG_MARK_JUMP
+#define MARK_JUMP(name, format, args...) \
+	do {\
+		__label__ call_label, over_label; \
+		volatile static void *__mark_##name##_jump_over \
+				asm ("__mark_"#name"_jump_over") = \
+					&&over_label; \
+		volatile static void *__mark_##name##_jump_call \
+				asm ("__mark_"#name"_jump_call") \
+				__attribute__((unused)) =  \
+					&&call_label; \
+		static void \
+				(*__mark_##name##_call)(const char *fmt, ...) \
+				asm ("__mark_"#name"_call") = \
+					__mark_empty_function; \
+		goto *__mark_##name##_jump_over; \
+call_label: \
+		preempt_disable(); \
+		(void) (__mark_##name##_call(format, ## args)); \
+		preempt_enable_no_resched(); \
+over_label: \
+		do {} while(0); \
+	} while(0)
+#else
+#define MARK_JUMP(name, format, args...)
+#endif
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
@@ -0,0 +1,18 @@
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
+config MARK_JUMP
+	bool "Replace markers with a jump over an inactive function call"
+	default n
+	help
+	  Put a jump over a call in place of markers.
+
+endmenu

--- END ---



OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
