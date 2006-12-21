Return-Path: <linux-kernel-owner+w=401wt.eu-S1161029AbWLUAAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161029AbWLUAAu (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 19:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161038AbWLUAAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 19:00:50 -0500
Received: from tomts13.bellnexxia.net ([209.226.175.34]:56032 "EHLO
	tomts13-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161029AbWLUAAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 19:00:49 -0500
Date: Wed, 20 Dec 2006 19:00:47 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>
Cc: ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 3/4] Linux Kernel Markers : i386 optimisation
Message-ID: <20061221000047.GD28643@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20061220235216.GA28643@Krystal>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 18:59:32 up 119 days, 21:07,  6 users,  load average: 1.12, 1.05, 0.87
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the i386 optimisation for the Linux Kernel Markers.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- /dev/null
+++ b/include/asm-i386/marker.h
@@ -0,0 +1,54 @@
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
+#define MARK_POLYMORPHIC
+
+#endif

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
