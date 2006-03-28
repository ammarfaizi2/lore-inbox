Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbWC2ADH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWC2ADH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 19:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbWC2ABq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 19:01:46 -0500
Received: from [151.97.230.9] ([151.97.230.9]:26561 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S964858AbWC2ABj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 19:01:39 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 2/7] uml: split ldt.h in arch-independent and arch-dependant code
Date: Wed, 29 Mar 2006 01:56:53 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060328235652.13838.7939.stgit@zion.home.lan>
In-Reply-To: <20060328235442.13838.26861.stgit@zion.home.lan>
References: <20060328235442.13838.26861.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

ldt-{i386,x86_64}.h is made of two different parts - some code for parsing of
LDT descriptors, which is arch-dependant, and the code to handle uml_ldt_t (an
LDT block inside UML), which is mostly arch-independant (among x86 and x86_64,
at least).

Join the common part in a single file (ldt.h) and split the rest away
(host_ldt-{i386,x86_64}.h).

This is needed because processor.h, with next patches, will start including the
LDT descriptor parsing macros in host_ldt.h, but it can't include ldt.h because
it uses semaphores (and to define semaphores one must first include
processor.h!).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Makefile                 |    2 +
 include/asm-um/host_ldt-i386.h   |   34 ++++++++++++++++++
 include/asm-um/host_ldt-x86_64.h |   38 ++++++++++++++++++++
 include/asm-um/ldt-i386.h        |   69 ------------------------------------
 include/asm-um/ldt-x86_64.h      |   73 --------------------------------------
 include/asm-um/ldt.h             |   41 +++++++++++++++++++++
 6 files changed, 114 insertions(+), 143 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 8d14c7a..b982483 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -20,7 +20,7 @@ core-y			+= $(ARCH_DIR)/kernel/		\
 
 # Have to precede the include because the included Makefiles reference them.
 SYMLINK_HEADERS := archparam.h system.h sigcontext.h processor.h ptrace.h \
-	module.h vm-flags.h elf.h ldt.h
+	module.h vm-flags.h elf.h host_ldt.h
 SYMLINK_HEADERS := $(foreach header,$(SYMLINK_HEADERS),include/asm-um/$(header))
 
 # XXX: The "os" symlink is only used by arch/um/include/os.h, which includes
diff --git a/include/asm-um/host_ldt-i386.h b/include/asm-um/host_ldt-i386.h
new file mode 100644
index 0000000..b27cb0a
--- /dev/null
+++ b/include/asm-um/host_ldt-i386.h
@@ -0,0 +1,34 @@
+#ifndef __ASM_HOST_LDT_I386_H
+#define __ASM_HOST_LDT_I386_H
+
+#include "asm/arch/ldt.h"
+
+/*
+ * macros stolen from include/asm-i386/desc.h
+ */
+#define LDT_entry_a(info) \
+	((((info)->base_addr & 0x0000ffff) << 16) | ((info)->limit & 0x0ffff))
+
+#define LDT_entry_b(info) \
+	(((info)->base_addr & 0xff000000) | \
+	(((info)->base_addr & 0x00ff0000) >> 16) | \
+	((info)->limit & 0xf0000) | \
+	(((info)->read_exec_only ^ 1) << 9) | \
+	((info)->contents << 10) | \
+	(((info)->seg_not_present ^ 1) << 15) | \
+	((info)->seg_32bit << 22) | \
+	((info)->limit_in_pages << 23) | \
+	((info)->useable << 20) | \
+	0x7000)
+
+#define LDT_empty(info) (\
+	(info)->base_addr	== 0	&& \
+	(info)->limit		== 0	&& \
+	(info)->contents	== 0	&& \
+	(info)->read_exec_only	== 1	&& \
+	(info)->seg_32bit	== 0	&& \
+	(info)->limit_in_pages	== 0	&& \
+	(info)->seg_not_present	== 1	&& \
+	(info)->useable		== 0	)
+
+#endif
diff --git a/include/asm-um/host_ldt-x86_64.h b/include/asm-um/host_ldt-x86_64.h
new file mode 100644
index 0000000..74a63f7
--- /dev/null
+++ b/include/asm-um/host_ldt-x86_64.h
@@ -0,0 +1,38 @@
+#ifndef __ASM_HOST_LDT_X86_64_H
+#define __ASM_HOST_LDT_X86_64_H
+
+#include "asm/arch/ldt.h"
+
+/*
+ * macros stolen from include/asm-x86_64/desc.h
+ */
+#define LDT_entry_a(info) \
+	((((info)->base_addr & 0x0000ffff) << 16) | ((info)->limit & 0x0ffff))
+
+/* Don't allow setting of the lm bit. It is useless anyways because
+ * 64bit system calls require __USER_CS. */
+#define LDT_entry_b(info) \
+	(((info)->base_addr & 0xff000000) | \
+	(((info)->base_addr & 0x00ff0000) >> 16) | \
+	((info)->limit & 0xf0000) | \
+	(((info)->read_exec_only ^ 1) << 9) | \
+	((info)->contents << 10) | \
+	(((info)->seg_not_present ^ 1) << 15) | \
+	((info)->seg_32bit << 22) | \
+	((info)->limit_in_pages << 23) | \
+	((info)->useable << 20) | \
+	/* ((info)->lm << 21) | */ \
+	0x7000)
+
+#define LDT_empty(info) (\
+	(info)->base_addr	== 0	&& \
+	(info)->limit		== 0	&& \
+	(info)->contents	== 0	&& \
+	(info)->read_exec_only	== 1	&& \
+	(info)->seg_32bit	== 0	&& \
+	(info)->limit_in_pages	== 0	&& \
+	(info)->seg_not_present	== 1	&& \
+	(info)->useable		== 0	&& \
+	(info)->lm              == 0)
+
+#endif
diff --git a/include/asm-um/ldt-i386.h b/include/asm-um/ldt-i386.h
deleted file mode 100644
index 175722a..0000000
--- a/include/asm-um/ldt-i386.h
+++ /dev/null
@@ -1,69 +0,0 @@
-/*
- * Copyright (C) 2004 Fujitsu Siemens Computers GmbH
- * Licensed under the GPL
- *
- * Author: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
- */
-
-#ifndef __ASM_LDT_I386_H
-#define __ASM_LDT_I386_H
-
-#include "asm/semaphore.h"
-#include "asm/arch/ldt.h"
-
-struct mmu_context_skas;
-extern void ldt_host_info(void);
-extern long init_new_ldt(struct mmu_context_skas * to_mm,
-			 struct mmu_context_skas * from_mm);
-extern void free_ldt(struct mmu_context_skas * mm);
-
-#define LDT_PAGES_MAX \
-	((LDT_ENTRIES * LDT_ENTRY_SIZE)/PAGE_SIZE)
-#define LDT_ENTRIES_PER_PAGE \
-	(PAGE_SIZE/LDT_ENTRY_SIZE)
-#define LDT_DIRECT_ENTRIES \
-	((LDT_PAGES_MAX*sizeof(void *))/LDT_ENTRY_SIZE)
-
-struct ldt_entry {
-	__u32 a;
-	__u32 b;
-};
-
-typedef struct uml_ldt {
-	int entry_count;
-	struct semaphore semaphore;
-	union {
-		struct ldt_entry * pages[LDT_PAGES_MAX];
-		struct ldt_entry entries[LDT_DIRECT_ENTRIES];
-	} u;
-} uml_ldt_t;
-
-/*
- * macros stolen from include/asm-i386/desc.h
- */
-#define LDT_entry_a(info) \
-	((((info)->base_addr & 0x0000ffff) << 16) | ((info)->limit & 0x0ffff))
-
-#define LDT_entry_b(info) \
-	(((info)->base_addr & 0xff000000) | \
-	(((info)->base_addr & 0x00ff0000) >> 16) | \
-	((info)->limit & 0xf0000) | \
-	(((info)->read_exec_only ^ 1) << 9) | \
-	((info)->contents << 10) | \
-	(((info)->seg_not_present ^ 1) << 15) | \
-	((info)->seg_32bit << 22) | \
-	((info)->limit_in_pages << 23) | \
-	((info)->useable << 20) | \
-	0x7000)
-
-#define LDT_empty(info) (\
-	(info)->base_addr	== 0	&& \
-	(info)->limit		== 0	&& \
-	(info)->contents	== 0	&& \
-	(info)->read_exec_only	== 1	&& \
-	(info)->seg_32bit	== 0	&& \
-	(info)->limit_in_pages	== 0	&& \
-	(info)->seg_not_present	== 1	&& \
-	(info)->useable		== 0	)
-
-#endif
diff --git a/include/asm-um/ldt-x86_64.h b/include/asm-um/ldt-x86_64.h
deleted file mode 100644
index 96b35aa..0000000
--- a/include/asm-um/ldt-x86_64.h
+++ /dev/null
@@ -1,73 +0,0 @@
-/*
- * Copyright (C) 2004 Fujitsu Siemens Computers GmbH
- * Licensed under the GPL
- *
- * Author: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
- */
-
-#ifndef __ASM_LDT_X86_64_H
-#define __ASM_LDT_X86_64_H
-
-#include "asm/semaphore.h"
-#include "asm/arch/ldt.h"
-
-struct mmu_context_skas;
-extern void ldt_host_info(void);
-extern long init_new_ldt(struct mmu_context_skas * to_mm,
-			 struct mmu_context_skas * from_mm);
-extern void free_ldt(struct mmu_context_skas * mm);
-
-#define LDT_PAGES_MAX \
-	((LDT_ENTRIES * LDT_ENTRY_SIZE)/PAGE_SIZE)
-#define LDT_ENTRIES_PER_PAGE \
-	(PAGE_SIZE/LDT_ENTRY_SIZE)
-#define LDT_DIRECT_ENTRIES \
-	((LDT_PAGES_MAX*sizeof(void *))/LDT_ENTRY_SIZE)
-
-struct ldt_entry {
-	__u32 a;
-	__u32 b;
-};
-
-typedef struct uml_ldt {
-	int entry_count;
-	struct semaphore semaphore;
-	union {
-		struct ldt_entry * pages[LDT_PAGES_MAX];
-		struct ldt_entry entries[LDT_DIRECT_ENTRIES];
-	} u;
-} uml_ldt_t;
-
-/*
- * macros stolen from include/asm-x86_64/desc.h
- */
-#define LDT_entry_a(info) \
-	((((info)->base_addr & 0x0000ffff) << 16) | ((info)->limit & 0x0ffff))
-
-/* Don't allow setting of the lm bit. It is useless anyways because
- * 64bit system calls require __USER_CS. */
-#define LDT_entry_b(info) \
-	(((info)->base_addr & 0xff000000) | \
-	(((info)->base_addr & 0x00ff0000) >> 16) | \
-	((info)->limit & 0xf0000) | \
-	(((info)->read_exec_only ^ 1) << 9) | \
-	((info)->contents << 10) | \
-	(((info)->seg_not_present ^ 1) << 15) | \
-	((info)->seg_32bit << 22) | \
-	((info)->limit_in_pages << 23) | \
-	((info)->useable << 20) | \
-	/* ((info)->lm << 21) | */ \
-	0x7000)
-
-#define LDT_empty(info) (\
-	(info)->base_addr	== 0	&& \
-	(info)->limit		== 0	&& \
-	(info)->contents	== 0	&& \
-	(info)->read_exec_only	== 1	&& \
-	(info)->seg_32bit	== 0	&& \
-	(info)->limit_in_pages	== 0	&& \
-	(info)->seg_not_present	== 1	&& \
-	(info)->useable		== 0	&& \
-	(info)->lm              == 0)
-
-#endif
diff --git a/include/asm-um/ldt.h b/include/asm-um/ldt.h
new file mode 100644
index 0000000..96f82a4
--- /dev/null
+++ b/include/asm-um/ldt.h
@@ -0,0 +1,41 @@
+/*
+ * Copyright (C) 2004 Fujitsu Siemens Computers GmbH
+ * Licensed under the GPL
+ *
+ * Author: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
+ */
+
+#ifndef __ASM_LDT_H
+#define __ASM_LDT_H
+
+#include "asm/semaphore.h"
+#include "asm/host_ldt.h"
+
+struct mmu_context_skas;
+extern void ldt_host_info(void);
+extern long init_new_ldt(struct mmu_context_skas * to_mm,
+			 struct mmu_context_skas * from_mm);
+extern void free_ldt(struct mmu_context_skas * mm);
+
+#define LDT_PAGES_MAX \
+	((LDT_ENTRIES * LDT_ENTRY_SIZE)/PAGE_SIZE)
+#define LDT_ENTRIES_PER_PAGE \
+	(PAGE_SIZE/LDT_ENTRY_SIZE)
+#define LDT_DIRECT_ENTRIES \
+	((LDT_PAGES_MAX*sizeof(void *))/LDT_ENTRY_SIZE)
+
+struct ldt_entry {
+	__u32 a;
+	__u32 b;
+};
+
+typedef struct uml_ldt {
+	int entry_count;
+	struct semaphore semaphore;
+	union {
+		struct ldt_entry * pages[LDT_PAGES_MAX];
+		struct ldt_entry entries[LDT_DIRECT_ENTRIES];
+	} u;
+} uml_ldt_t;
+
+#endif
