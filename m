Return-Path: <linux-kernel-owner+w=401wt.eu-S1161038AbWLUABp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161038AbWLUABp (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 19:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161044AbWLUABo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 19:01:44 -0500
Received: from tomts13-srv.bellnexxia.net ([209.226.175.34]:56150 "EHLO
	tomts13-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161038AbWLUABn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 19:01:43 -0500
Date: Wed, 20 Dec 2006 19:01:40 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, paulus@samba.org,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>
Cc: ltt-dev@shafik.org, systemtap@sources.redhat.com, linuxppc-dev@ozlabs.org,
       Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4/4] Linux Kernel Markers : powerpc optimisation
Message-ID: <20061221000140.GE28643@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20061220235216.GA28643@Krystal>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 19:00:50 up 119 days, 21:08,  6 users,  load average: 1.68, 1.23, 0.94
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the powerpc Linux Kernel Markers optimised version.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- /dev/null
+++ b/include/asm-powerpc/marker.h
@@ -0,0 +1,58 @@
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
+#define MARK_POLYMORPHIC
+
+#endif

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
