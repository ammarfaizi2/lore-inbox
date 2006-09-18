Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751973AbWIRXpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbWIRXpH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 19:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbWIRXpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 19:45:07 -0400
Received: from tomts22.bellnexxia.net ([209.226.175.184]:57786 "EHLO
	tomts22-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1030270AbWIRXpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 19:45:05 -0400
Date: Mon, 18 Sep 2006 19:45:02 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: "Frank Ch. Eigler" <fche@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Ingo Molnar <mingo@elte.hu>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com
Subject: [PATCH] Linux Kernel Markers
Message-ID: <20060918234502.GA197@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 19:27:13 up 26 days, 20:35,  5 users,  load average: 0.54, 0.44, 0.37
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Following this huge discussion thread, I tried to come with a marker mechanism
(which is something everyone seems to agree that is a necessity) that would be
useful to each kind of tracing (dynamic and static) (concerned projects :
SystemTAP, LKET, LKST, LTTng) and even combinations of those. Religious
considerations aside, I really think that this kind of generic markup is
necessary to fill *everybody*'s need. If I forgot about a specific genericity
aspect, please tell me.

I take for agreed that both static and dynamic tracing are useful for different
needs and that a full markup must support both and combinations, letting the
user or the distribution choose.

If you like it, please add the right menuconfig lines in arch/*/Kconfig and a
NOPS macro in include/asm-*/marker.h.

Comments are, as always, welcome.

Mathieu

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
+++ b/include/asm-i386/marker.h
@@ -0,0 +1,12 @@
+/*****************************************************************************
+ * marker.h
+ *
+ * Code markup for dynamic and static tracing. i386 support.
+ *
+ * Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
+ *
+ * September 2006
+ */
+
+#define JPROBE_TARGET \
+	__asm__ ( GENERIC_NOP5 )
--- /dev/null
+++ b/include/linux/marker.h
@@ -0,0 +1,77 @@
+/*****************************************************************************
+ * marker.h
+ *
+ * Code markup for dynamic and static tracing.
+ *
+ * Use either :
+ * MARK
+ * MARK_NOPRINT (will never call printk)
+ * MARK_STATIC (not dynamically instrumentable, will never call printk)
+ *
+ * Example :
+ *
+ * MARK(subsystem_event, "Event happened %d %s", someint, somestring);
+ * Where :
+ * - Subsystem is the name of your subsystem.
+ * - event is the name of the event to mark.
+ * - "Event happened %d %s" is the formatted string for printk.
+ * - someint is an integer.
+ * - somestring is a char *.
+ *
+ * Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
+ *
+ * September 2006
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+
+#include <asm/marker.h>
+
+#define MARK_SYM(event) \
+	__asm__ ( "__mark_" KBUILD_BASENAME "_" #event ":" )
+
+#define MARK_INACTIVE(event, format, args...)
+
+#define MARK_PRINT(event, format, args...)	printk(format, ##args);
+
+#define MARK_FPROBE(event, format, args...) 	fprobe_##event(args);
+
+#define MARK_KPROBE(event, format, args...)	MARK_SYM(event);
+
+#define MARK_JPROBE(event, format, args...) \
+	do { \
+		MARK_SYM(event); \
+		JPROBE_TARGET; \
+	} while(0)
+
+/* Menu configured markers */
+#ifndef CONFIG_MARK
+#define MARK	MARK_INACTIVE
+#elif defined(CONFIG_MARK_PRINT)
+#define MARK	MARK_PRINT
+#elif defined(CONFIG_MARK_FPROBE)
+#define MARK	MARK_FPROBE
+#elif defined(CONFIG_MARK_KPROBE)
+#define MARK	MARK_KPROBE
+#elif defined(CONFIG_MARK_JPROBE)
+#define MARK	MARK_JPROBE
+#endif
+
+#ifndef CONFIG_MARK_NOPRINT
+#define MARK_NOPRINT	MARK_INACTIVE
+#elif defined(CONFIG_MARK_NOPRINT_FPROBE)
+#define MARK_NOPRINT	MARK_FPROBE
+#elif defined(CONFIG_MARK_NOPRINT_KPROBE)
+#define MARK_NOPRINT	MARK_KPROBE
+#elif defined(CONFIG_MARK_NOPRINT_JPROBE)
+#define MARK_NOPRINT	MARK_JPROBE
+#endif
+
+#ifndef CONFIG_MARK_STATIC
+#define MARK_STATIC	MARK_INACTIVE
+#else
+#define MARK_STATIC	MARK_FPROBE
+#endif
+
+
--- /dev/null
+++ b/kernel/Kconfig.marker
@@ -0,0 +1,75 @@
+# Code markers configuration
+
+menu "Marker configuration"
+
+
+config MARK
+	bool "Enable MARK code markers"
+	default y
+	help
+	  Activate markers that can call printk or can be instrumented
+	  dynamically.
+
+choice
+	prompt "MARK code marker behavior"
+	default MARK_KPROBE
+	depends on MARK
+	help
+	  Configuration of markers that can call printk or can be
+	  instrumented dynamically.
+
+config MARK_KPROBE
+	bool "KPROBE"
+	---help---
+	Change markers for a symbol "__mark_modulename_event".
+config MARK_JPROBE
+	bool "JPROBE"
+	---help---
+	Change markers for a symbol "__mark_modulename_event"
+	and create a target for a high speed dynamic probe.
+config MARK_FPROBE
+	bool "FPROBE"
+	---help---
+	Change markers for a function call.
+config MARK_PRINT
+	bool "PRINT"
+	---help---
+	Call printk from the marker.
+endchoice
+
+config MARK_NOPRINT
+	bool "Enable MARK_NOPRINT code markers"
+	default y
+	help
+	  Activate markers that cannot call printk.
+ 
+choice
+	prompt "MARK_NOPRINT code marker behavior"
+	default MARK_NOPRINT_KPROBE
+	depends on MARK_NOPRINT
+	help
+	  Configuration of markers that cannot call printk.
+
+config MARK_NOPRINT_KPROBE
+	bool "KPROBE"
+	---help---
+	Change markers for a symbol "__mark_modulename_event".
+config MARK_NOPRINT_JPROBE
+	bool "JPROBE"
+	---help---
+	Change markers for a symbol "__mark_modulename_event"
+	and create a target for a high speed dynamic probe.
+config MARK_NOPRINT_FPROBE
+	bool "FPROBE"
+	---help---
+	Change markers for a function call.
+endchoice
+
+config MARK_STATIC
+	bool "Enable MARK_STATIC code markers"
+	default y
+	help
+	  Activate markers that cannot be instrumented dynamically. They will
+	  generate function calls to each function-style probe.
+
+endmenu


--- END ---


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
