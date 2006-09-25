Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751693AbWIYXeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbWIYXeF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 19:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbWIYXeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 19:34:04 -0400
Received: from tomts40.bellnexxia.net ([209.226.175.97]:65217 "EHLO
	tomts40-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751693AbWIYXd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 19:33:59 -0400
Date: Mon, 25 Sep 2006 19:33:49 -0400
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
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Karim Yaghmour <karim@opersys.com>, Pavel Machek <pavel@suse.cz>,
       Joe Perches <joe@perches.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Jose R. Santos" <jrs@us.ibm.com>
Subject: [PATCH] Linux Kernel Markers 0.13 for 2.6.17
Message-ID: <20060925233349.GA2352@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 19:18:26 up 33 days, 20:27,  5 users,  load average: 0.26, 0.17, 0.14
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a corrected version. Following Jeremy Fitzhardinge's advices :
- I now use memory constraints on an extern symbol to keep inline assembly in
  the right order.
- I declare the symbols around and inside the 2 bytes jump in assembly to make
  sure that gcc will not insert code, padding, etc... All the assembly
  alignment+instruction is all in one inline asm now.
- Use variable argument list in the probe (safe on every architecture). Thanks
  to Frank and Jeremy for pointing this out.

Thanks for all your comments,

Mathieu


---BEGIN---
diff --git a/Makefile b/Makefile
index 1700d3f..78ed30f 100644
--- a/Makefile
+++ b/Makefile
@@ -301,7 +301,8 @@ # Use LINUXINCLUDE when you must referen
 # Needed to be compatible with the O= option
 LINUXINCLUDE    := -Iinclude \
                    $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include) \
-		   -include include/linux/autoconf.h
+		   -include include/linux/autoconf.h \
+		   -include include/linux/marker.h
 
 CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 
diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 213c785..95c1d1b 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -630,6 +630,12 @@ source "fs/Kconfig"
 
 source "arch/alpha/oprofile/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/alpha/Kconfig.debug"
 
 source "security/Kconfig"
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 08b7cc9..4c03f09 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -871,6 +871,12 @@ source "fs/Kconfig"
 
 source "arch/arm/oprofile/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/arm/Kconfig.debug"
 
 source "security/Kconfig"
diff --git a/arch/arm26/Kconfig b/arch/arm26/Kconfig
index cf4ebf4..f34e157 100644
--- a/arch/arm26/Kconfig
+++ b/arch/arm26/Kconfig
@@ -232,6 +232,12 @@ source "drivers/misc/Kconfig"
 
 source "drivers/usb/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/arm26/Kconfig.debug"
 
 source "security/Kconfig"
diff --git a/arch/cris/Kconfig b/arch/cris/Kconfig
index 856b665..84f8efd 100644
--- a/arch/cris/Kconfig
+++ b/arch/cris/Kconfig
@@ -179,6 +179,12 @@ source "sound/Kconfig"
 
 source "drivers/usb/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/cris/Kconfig.debug"
 
 source "security/Kconfig"
diff --git a/arch/frv/Kconfig b/arch/frv/Kconfig
index 95a3892..8708a75 100644
--- a/arch/frv/Kconfig
+++ b/arch/frv/Kconfig
@@ -345,6 +345,12 @@ source "drivers/Kconfig"
 
 source "fs/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/frv/Kconfig.debug"
 
 source "security/Kconfig"
diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index cabf0bf..bdb67ed 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -197,6 +197,12 @@ endmenu
 
 source "fs/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/h8300/Kconfig.debug"
 
 source "security/Kconfig"
diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index 8dfa305..e6cc7da 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -1081,6 +1081,9 @@ config KPROBES
 	  a probepoint and specifies the callback.  Kprobes is useful
 	  for kernel debugging, non-intrusive instrumentation and testing.
 	  If in doubt, say "N".
+
+source "kernel/Kconfig.marker"
+
 endmenu
 
 source "arch/i386/Kconfig.debug"
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 0f3076a..2342975 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -499,6 +499,9 @@ config KPROBES
 	  a probepoint and specifies the callback.  Kprobes is useful
 	  for kernel debugging, non-intrusive instrumentation and testing.
 	  If in doubt, say "N".
+
+source "kernel/Kconfig.marker"
+
 endmenu
 
 source "arch/ia64/Kconfig.debug"
diff --git a/arch/m32r/Kconfig b/arch/m32r/Kconfig
index 41fd490..50f0a8e 100644
--- a/arch/m32r/Kconfig
+++ b/arch/m32r/Kconfig
@@ -386,6 +386,12 @@ source "fs/Kconfig"
 
 source "arch/m32r/oprofile/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/m32r/Kconfig.debug"
 
 source "security/Kconfig"
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 805b81f..5af9e00 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -652,6 +652,12 @@ endmenu
 
 source "fs/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/m68k/Kconfig.debug"
 
 source "security/Kconfig"
diff --git a/arch/m68knommu/Kconfig b/arch/m68knommu/Kconfig
index 3cde682..bd01cc0 100644
--- a/arch/m68knommu/Kconfig
+++ b/arch/m68knommu/Kconfig
@@ -652,6 +652,12 @@ source "drivers/Kconfig"
 
 source "fs/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/m68knommu/Kconfig.debug"
 
 source "security/Kconfig"
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e8ff09f..4d5dbf9 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1850,6 +1850,12 @@ source "fs/Kconfig"
 
 source "arch/mips/oprofile/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/mips/Kconfig.debug"
 
 source "security/Kconfig"
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 910fb3a..a0a7dd7 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -251,6 +251,12 @@ source "fs/Kconfig"
 
 source "arch/parisc/oprofile/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/parisc/Kconfig.debug"
 
 source "security/Kconfig"
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6729c98..44f25b5 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -1011,6 +1011,9 @@ config KPROBES
 	  a probepoint and specifies the callback.  Kprobes is useful
 	  for kernel debugging, non-intrusive instrumentation and testing.
 	  If in doubt, say "N".
+
+source "kernel/Kconfig.marker"
+
 endmenu
 
 source "arch/powerpc/Kconfig.debug"
diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
index e9a8f5d..ca871ab 100644
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -1412,6 +1412,12 @@ source "lib/Kconfig"
 
 source "arch/powerpc/oprofile/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/ppc/Kconfig.debug"
 
 source "security/Kconfig"
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 01c5c08..57600b5 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -476,6 +476,12 @@ source "fs/Kconfig"
 
 source "arch/s390/oprofile/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/s390/Kconfig.debug"
 
 source "security/Kconfig"
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 2bcecf4..0fd24d3 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -644,6 +644,12 @@ source "fs/Kconfig"
 
 source "arch/sh/oprofile/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/sh/Kconfig.debug"
 
 source "security/Kconfig"
diff --git a/arch/sh64/Kconfig b/arch/sh64/Kconfig
index 58c678e..f4ecb4d 100644
--- a/arch/sh64/Kconfig
+++ b/arch/sh64/Kconfig
@@ -276,6 +276,12 @@ source "fs/Kconfig"
 
 source "arch/sh64/oprofile/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/sh64/Kconfig.debug"
 
 source "security/Kconfig"
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 9431e96..de02311 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -289,6 +289,12 @@ endmenu
 
 source "fs/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/sparc/Kconfig.debug"
 
 source "security/Kconfig"
diff --git a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
index 43a66f5..971f5e2 100644
--- a/arch/sparc64/Kconfig
+++ b/arch/sparc64/Kconfig
@@ -419,6 +419,9 @@ config KPROBES
 	  a probepoint and specifies the callback.  Kprobes is useful
 	  for kernel debugging, non-intrusive instrumentation and testing.
 	  If in doubt, say "N".
+
+source "kernel/Kconfig.marker"
+
 endmenu
 
 source "arch/sparc64/Kconfig.debug"
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 76e85bb..9481883 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -312,4 +312,10 @@ config INPUT
 	bool
 	default n
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/um/Kconfig.debug"
diff --git a/arch/v850/Kconfig b/arch/v850/Kconfig
index 37ec644..6ce651f 100644
--- a/arch/v850/Kconfig
+++ b/arch/v850/Kconfig
@@ -324,6 +324,12 @@ source "sound/Kconfig"
 
 source "drivers/usb/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/v850/Kconfig.debug"
 
 source "security/Kconfig"
diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
index 408d44a..6feb011 100644
--- a/arch/x86_64/Kconfig
+++ b/arch/x86_64/Kconfig
@@ -611,6 +611,9 @@ config KPROBES
 	  a probepoint and specifies the callback.  Kprobes is useful
 	  for kernel debugging, non-intrusive instrumentation and testing.
 	  If in doubt, say "N".
+
+source "kernel/Kconfig.marker"
+
 endmenu
 
 source "arch/x86_64/Kconfig.debug"
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index dbeb350..413abb8 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -255,6 +255,12 @@ config EMBEDDED_RAMDISK_IMAGE
 	  provide one yourself.
 endmenu
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/xtensa/Kconfig.debug"
 
 source "security/Kconfig"
diff --git a/include/asm-alpha/marker.h b/include/asm-alpha/marker.h
new file mode 100644
index 0000000..8d9467f
--- /dev/null
+++ b/include/asm-alpha/marker.h
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
diff --git a/include/asm-arm/marker.h b/include/asm-arm/marker.h
new file mode 100644
index 0000000..8d9467f
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
diff --git a/include/asm-arm26/marker.h b/include/asm-arm26/marker.h
new file mode 100644
index 0000000..8d9467f
--- /dev/null
+++ b/include/asm-arm26/marker.h
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
diff --git a/include/asm-cris/marker.h b/include/asm-cris/marker.h
new file mode 100644
index 0000000..8d9467f
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
diff --git a/include/asm-frv/marker.h b/include/asm-frv/marker.h
new file mode 100644
index 0000000..8d9467f
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
diff --git a/include/asm-generic/marker.h b/include/asm-generic/marker.h
new file mode 100644
index 0000000..f18ee68
--- /dev/null
+++ b/include/asm-generic/marker.h
@@ -0,0 +1,22 @@
+/*
+ * marker.h
+ *
+ * Code markup for dynamic and static tracing. Generic header.
+ * 
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ */
+
+#define MARK_CALL(name, format, args...) \
+	do { \
+		static marker_probe_func *__mark_call_##name = \
+					__mark_empty_function; \
+		asm volatile(	".section .markers, \"a\";\n\t" \
+				".long %1, %2;\n\t" \
+				".previous;\n\t" : "+m" (__marker_sequencer) : \
+			"m" (__mark_call_##name), \
+			"m" (*format)); \
+		preempt_disable(); \
+		(*__mark_call_##name)(format, ## args); \
+		preempt_enable_no_resched(); \
+	} while(0)
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 9d11550..d029043 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -90,6 +90,12 @@ #define RODATA								\
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
diff --git a/include/asm-h8300/marker.h b/include/asm-h8300/marker.h
new file mode 100644
index 0000000..8d9467f
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
diff --git a/include/asm-i386/marker.h b/include/asm-i386/marker.h
new file mode 100644
index 0000000..4f1e30c
--- /dev/null
+++ b/include/asm-i386/marker.h
@@ -0,0 +1,30 @@
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
+#include <asm-generic/marker.h>
+
+#define ARCH_HAS_MARK_JUMP
+
+/* Note : max 256 bytes between over_label and near_jump */
+#define MARK_JUMP(name, format, args...) \
+	do { \
+		asm volatile(	".section .markers, \"a\";\n\t" \
+				".long 0f, 1f, 2f;\n\t" \
+				".previous;\n\t" \
+				".align 16;\n\t" \
+				".byte 0xeb;\n\t" \
+				"0:\n\t" \
+				".byte 2f-1f;\n\t" \
+				"1:\n\t" \
+			: "+m" (__marker_sequencer) : ); \
+		MARK_CALL(name, format, ## args); \
+		asm volatile (	"2:\n\t" : "+m" (__marker_sequencer) : ); \
+	} while(0)
diff --git a/include/asm-ia64/marker.h b/include/asm-ia64/marker.h
new file mode 100644
index 0000000..8d9467f
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
diff --git a/include/asm-m32r/marker.h b/include/asm-m32r/marker.h
new file mode 100644
index 0000000..8d9467f
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
diff --git a/include/asm-m68k/marker.h b/include/asm-m68k/marker.h
new file mode 100644
index 0000000..8d9467f
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
diff --git a/include/asm-m68knommu/marker.h b/include/asm-m68knommu/marker.h
new file mode 100644
index 0000000..8d9467f
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
diff --git a/include/asm-mips/marker.h b/include/asm-mips/marker.h
new file mode 100644
index 0000000..8d9467f
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
diff --git a/include/asm-parisc/marker.h b/include/asm-parisc/marker.h
new file mode 100644
index 0000000..8d9467f
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
diff --git a/include/asm-powerpc/marker.h b/include/asm-powerpc/marker.h
new file mode 100644
index 0000000..8d9467f
--- /dev/null
+++ b/include/asm-powerpc/marker.h
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
diff --git a/include/asm-ppc/marker.h b/include/asm-ppc/marker.h
new file mode 100644
index 0000000..8d9467f
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
diff --git a/include/asm-ppc64/marker.h b/include/asm-ppc64/marker.h
new file mode 100644
index 0000000..8d9467f
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
diff --git a/include/asm-s390/marker.h b/include/asm-s390/marker.h
new file mode 100644
index 0000000..8d9467f
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
diff --git a/include/asm-sh/marker.h b/include/asm-sh/marker.h
new file mode 100644
index 0000000..8d9467f
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
diff --git a/include/asm-sh64/marker.h b/include/asm-sh64/marker.h
new file mode 100644
index 0000000..8d9467f
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
diff --git a/include/asm-sparc/marker.h b/include/asm-sparc/marker.h
new file mode 100644
index 0000000..8d9467f
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
diff --git a/include/asm-sparc64/marker.h b/include/asm-sparc64/marker.h
new file mode 100644
index 0000000..8d9467f
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
diff --git a/include/asm-um/marker.h b/include/asm-um/marker.h
new file mode 100644
index 0000000..8d9467f
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
diff --git a/include/asm-v850/marker.h b/include/asm-v850/marker.h
new file mode 100644
index 0000000..8d9467f
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
diff --git a/include/asm-x86_64/marker.h b/include/asm-x86_64/marker.h
new file mode 100644
index 0000000..8d9467f
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
diff --git a/include/asm-xtensa/marker.h b/include/asm-xtensa/marker.h
new file mode 100644
index 0000000..8d9467f
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
diff --git a/include/linux/marker.h b/include/linux/marker.h
new file mode 100644
index 0000000..2916e53
--- /dev/null
+++ b/include/linux/marker.h
@@ -0,0 +1,90 @@
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
+ * Dynamically overridable function call based on marker mechanism
+ *          from Frank Ch. Eigler <fche@redhat.com>.
+ *
+ * The marker mechanism supports multiple instances of the same marker.
+ * Markers can be put in inline functions, inlined static functions and
+ * unrolled loops without changing the optimisations.
+ *
+ * (C) Copyright 2006 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
+ *
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ */
+
+#ifndef __ASSEMBLY__
+
+#include <asm/marker.h>
+
+#if !defined(ARCH_HAS_MARK_JUMP) || defined(CONFIG_MARKERS_FORCE_DIRECT_CALL)
+#undef MARK_JUMP
+#undef ARCH_HAS_MARK_JUMP
+#define MARK_JUMP MARK_CALL
+#endif
+
+#define MARK_NOARGS " "
+#define MARK_MAX_FORMAT_LEN	1024
+
+#ifdef CONFIG_MARKERS
+#define MARK(name, format, args...) \
+	do { \
+		__label__ here; \
+here:   	asm volatile(	".section .markers, \"a\";\n\t" \
+				".long %1, %2;\n\t" \
+				".previous;\n\t" : "+m" (__marker_sequencer) : \
+			"m" (*(#name)), \
+			"m" (*&&here)); \
+		__mark_check_format(format, ## args); \
+		MARK_JUMP(name, format, ## args); \
+	} while(0)
+#else
+#define MARK(name, format, args...) \
+		__mark_check_format(format, ## args)
+#endif
+
+typedef void marker_probe_func(const char *fmt, ...);
+
+struct __mark_marker {
+	const char *name;
+	const void *location;
+#ifdef ARCH_HAS_MARK_JUMP
+	char *select;
+	const void *jump_call;
+	const void *jump_over;
+#endif
+	marker_probe_func **call;
+	const char *format;
+};
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
+extern int __marker_sequencer; /* doesn't exist, never referenced */
+
+#endif
+#endif
diff --git a/include/linux/module.h b/include/linux/module.h
index eaec13d..5689857 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -254,6 +254,8 @@ struct module
 	const struct kernel_symbol *syms;
 	unsigned int num_syms;
 	const unsigned long *crcs;
+	const struct __mark_marker *markers;
+	unsigned int num_markers;
 
 	/* GPL-only exported symbols. */
 	const struct kernel_symbol *gpl_syms;
diff --git a/kernel/Kconfig.marker b/kernel/Kconfig.marker
new file mode 100644
index 0000000..2a828c7
--- /dev/null
+++ b/kernel/Kconfig.marker
@@ -0,0 +1,18 @@
+# Code markers configuration
+
+config MARKERS
+	bool "Activate markers"
+	select MODULES
+	default n
+	help
+	  Place an empty function call at each marker site. Can by
+	  dynamically changed for a probe function.
+
+config MARKERS_FORCE_DIRECT_CALL
+	bool "Disable markers jump optimisations"
+	depends EMBEDDED
+	default n
+	help
+	  Disable code replacement jump optimisations. Especially useful if your
+	  code is in a read-only rom/flash.
+
diff --git a/kernel/module.c b/kernel/module.c
index bbe0486..083cb00 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -123,6 +123,8 @@ extern const struct kernel_symbol __stop
 extern const unsigned long __start___kcrctab[];
 extern const unsigned long __start___kcrctab_gpl[];
 extern const unsigned long __start___kcrctab_gpl_future[];
+extern const struct __mark_marker __start___markers[];
+extern const struct __mark_marker __stop___markers[];
 
 #ifndef CONFIG_MODVERSIONS
 #define symversion(base, idx) NULL
@@ -236,6 +238,153 @@ static struct module *find_module(const 
 	return NULL;
 }
 
+#ifdef CONFIG_MARKERS
+void __mark_empty_function(const char *fmt, ...)
+{
+}
+EXPORT_SYMBOL(__mark_empty_function);
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
+	for(iter = begin; iter < end; iter++) {
+		if (strcmp(name, iter->name) == 0) {
+			if (format && strcmp(format, iter->format) != 0) {
+				printk(KERN_NOTICE
+					"Format mismatch for probe %s "
+					"(%s), marker (%s)\n",
+					name,
+					format,
+					iter->format);
+				continue;
+			}
+			found++;
+			*iter->call = probe;
+#ifdef ARCH_HAS_MARK_JUMP
+			if (probe != __mark_empty_function)
+				*iter->select = 0;
+			else
+				*iter->select = iter->jump_over
+					- iter->jump_call;
+#endif
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
+	for(iter = begin; iter < end; iter++) {
+		if (*iter->call == probe) {
+#ifdef ARCH_HAS_MARK_JUMP
+			*iter->select = iter->jump_over
+				- iter->jump_call;
+#endif
+			*iter->call = __mark_empty_function;
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
+	for(iter = begin; iter < end; iter++) {
+		if (probe)
+			if (probe != *iter->call) continue;
+		printk("name %s location 0x%p\n", iter->name, iter->location);
+#ifdef ARCH_HAS_MARK_JUMP
+		printk("  select %hu jump_call %p jump_over %p\n",
+			*iter->select, iter->jump_call, iter->jump_over);
+#endif
+		printk("  func 0x%p format \"%s\"\n",
+			*iter->call, iter->format);
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
+		found += marker_set_probe_range(name, format, probe,
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
+		found += marker_remove_probe_range(probe,
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
+		printk("Listing markers for module %s\n", mod->name);
+		found += marker_list_probe_range(probe,
+				mod->markers, mod->markers+mod->num_markers);
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
@@ -1412,7 +1561,7 @@ static struct module *load_module(void _
 	unsigned int i, symindex = 0, strindex = 0, setupindex, exindex,
 		exportindex, modindex, obsparmindex, infoindex, gplindex,
 		crcindex, gplcrcindex, versindex, pcpuindex, gplfutureindex,
-		gplfuturecrcindex;
+		gplfuturecrcindex, markersindex;
 	struct module *mod;
 	long err = 0;
 	void *percpu = NULL, *ptr = NULL; /* Stops spurious gcc warning */
@@ -1502,6 +1651,7 @@ #endif
 	versindex = find_sec(hdr, sechdrs, secstrings, "__versions");
 	infoindex = find_sec(hdr, sechdrs, secstrings, ".modinfo");
 	pcpuindex = find_pcpusec(hdr, sechdrs, secstrings);
+	markersindex = find_sec(hdr, sechdrs, secstrings, ".markers");
 
 	/* Don't keep modinfo section */
 	sechdrs[infoindex].sh_flags &= ~(unsigned long)SHF_ALLOC;
@@ -1510,6 +1660,11 @@ #ifdef CONFIG_KALLSYMS
 	sechdrs[symindex].sh_flags |= SHF_ALLOC;
 	sechdrs[strindex].sh_flags |= SHF_ALLOC;
 #endif
+#ifdef CONFIG_MARKERS
+	sechdrs[markersindex].sh_flags |= SHF_ALLOC;
+#else
+	sechdrs[markersindex].sh_flags &= ~(unsigned long)SHF_ALLOC;
+#endif
 
 	/* Check module struct version now, before we try to use module. */
 	if (!check_modstruct_version(sechdrs, versindex, mod)) {
@@ -1642,6 +1797,11 @@ #endif
 	mod->gpl_future_syms = (void *)sechdrs[gplfutureindex].sh_addr;
 	if (gplfuturecrcindex)
 		mod->gpl_future_crcs = (void *)sechdrs[gplfuturecrcindex].sh_addr;
+	if (markersindex) {
+		mod->markers = (void *)sechdrs[markersindex].sh_addr;
+		mod->num_markers =
+			sechdrs[markersindex].sh_size / sizeof(*mod->markers);
+	}
 
 #ifdef CONFIG_MODVERSIONS
 	if ((mod->num_syms && !crcindex) || 
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
void do_mark1(const char *format, ...)
{
	va_list ap;
	int value;

	va_start(ap, format);
	value = va_arg(ap, int);
	printk("value is %d\n", value);
	
	va_end(ap);
}

void do_mark2(const char *format, ...)
{
	va_list ap;

	va_start(ap, format);
	vprintk(format, ap);
	va_end(ap);
	printk("\n");
}

#define DO_MARK3_FORMAT "%d %s %s"
void do_mark3(const char *format, ...)
{
	va_list ap;
	int value;
	const char *s1, *s2;
	
	va_start(ap, format);
	value = va_arg(ap, int);
	s1 = va_arg(ap, const char*);
	s2 = va_arg(ap, const char *);

	printk("value is %d %s %s\n",
		value, s1, s2);
	va_end(ap);
}

int init_module(void)
{
	int result;
	result = marker_set_probe("subsys_mark1", DO_MARK1_FORMAT,
			(marker_probe_func*)do_mark1);
	if(!result) goto end;
	result = marker_set_probe("subsys_mark2", NULL,
			(marker_probe_func*)do_mark2);
	if(!result) goto cleanup1;
	result = marker_set_probe("subsys_mark3", DO_MARK3_FORMAT,
			(marker_probe_func*)do_mark3);
	if(!result) goto cleanup2;

	return 0;

cleanup2:
	marker_remove_probe((marker_probe_func*)do_mark2);
cleanup1:
	marker_remove_probe((marker_probe_func*)do_mark1);
end:
	return -EPERM;
}

void cleanup_module(void)
{
	marker_remove_probe((marker_probe_func*)do_mark1);
	marker_remove_probe((marker_probe_func*)do_mark2);
	marker_remove_probe((marker_probe_func*)do_mark3);
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
#include <asm/ptrace.h>

volatile int x = 7;

struct proc_dir_entry *pentry = NULL;

static inline void test(struct pt_regs * regs)
{
	MARK(kernel_debug_test, "%d %ld %p", 2, regs->eip, regs);
}

static int my_open(struct inode *inode, struct file *file)
{
	unsigned int i;

	for(i=0; i<2; i++) {
		MARK(subsys_mark1, "%d", 1);
	}
	MARK(subsys_mark2, "%d %s %s", 2, "blah2", "blahx");
	MARK(subsys_mark3, "%d %s %s", x, "blah3", "blah5");
	test(NULL);
	test(NULL);

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

	marker_list_probe(NULL);

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
