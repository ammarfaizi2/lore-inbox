Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbWHCA0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWHCA0S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 20:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWHCAZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 20:25:58 -0400
Received: from 207.47.60.101.static.nextweb.net ([207.47.60.101]:51929 "EHLO
	mail.goop.org") by vger.kernel.org with ESMTP id S1751046AbWHCAZv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 20:25:51 -0400
Message-Id: <20060803002518.690697061@xensource.com>
References: <20060803002510.634721860@xensource.com>
User-Agent: quilt/0.45-1
Date: Wed, 02 Aug 2006 17:25:18 -0700
From: Jeremy Fitzhardinge <jeremy@xensource.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Hollis Blanchard <hollisb@us.ibm.com>
Subject: [patch 8/8] Put .note.* sections into a PT_NOTE segment in vmlinux.
Content-Disposition: inline; filename=notes-segment.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will pack any .note.* section into a PT_NOTE segment in the
output file.

To do this, we tell ld that we need a PT_NOTE segment.  This requires
us to start explicitly mapping sections to segments, so we also need
to explicitly create PT_LOAD segments for text and data, and map the
sections to them appropriately.  Fortunately, each section will
default to its previous section's segment, so it doesn't take many
changes to vmlinux.lds.S.

This only changes i386 for now, but I presume the corresponding
changes for other architectures will be as simple.

This change also adds <linux/elfnote.h>, which defines C and Assembler
macros for actually creating ELF notes.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Hollis Blanchard <hollisb@us.ibm.com>

---
 arch/i386/kernel/vmlinux.lds.S    |   12 ++++-
 include/asm-generic/vmlinux.lds.h |    3 +
 include/linux/elfnote.h           |   88 +++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 2 deletions(-)


===================================================================
--- a/arch/i386/kernel/vmlinux.lds.S
+++ b/arch/i386/kernel/vmlinux.lds.S
@@ -13,6 +13,12 @@ OUTPUT_ARCH(i386)
 OUTPUT_ARCH(i386)
 ENTRY(phys_startup_32)
 jiffies = jiffies_64;
+
+PHDRS {
+	text PT_LOAD FLAGS(5);	/* R_E */
+	data PT_LOAD FLAGS(7);	/* RWE */
+	note PT_NOTE FLAGS(4);	/* R__ */
+}
 SECTIONS
 {
   . = __KERNEL_START;
@@ -26,7 +32,7 @@ SECTIONS
 	KPROBES_TEXT
 	*(.fixup)
 	*(.gnu.warning)
-	} = 0x9090
+	} :text = 0x9090
 
   _etext = .;			/* End of text section */
 
@@ -48,7 +54,7 @@ SECTIONS
   .data : AT(ADDR(.data) - LOAD_OFFSET) {	/* Data */
 	*(.data)
 	CONSTRUCTORS
-	}
+	} :data
 
   . = ALIGN(4096);
   __nosave_begin = .;
@@ -184,4 +190,6 @@ SECTIONS
   STABS_DEBUG
 
   DWARF_DEBUG
+
+  NOTES
 }
===================================================================
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -194,3 +194,6 @@
 		.stab.index 0 : { *(.stab.index) }			\
 		.stab.indexstr 0 : { *(.stab.indexstr) }		\
 		.comment 0 : { *(.comment) }
+
+#define NOTES								\
+		.notes : { *(.note.*) } :note
===================================================================
--- /dev/null
+++ b/include/linux/elfnote.h
@@ -0,0 +1,88 @@
+#ifndef _LINUX_ELFNOTE_H
+#define _LINUX_ELFNOTE_H
+/* 
+ * Helper macros to generate ELF Note structures, which are put into a
+ * PT_NOTE segment of the final vmlinux image.  These are useful for
+ * including name-value pairs of metadata into the kernel binary (or
+ * modules?) for use by external programs.
+ *
+ * Each note has three parts: a name, a type and a desc.  The name is
+ * intended to distinguish the note's originator, so it would be a
+ * company, project, subsystem, etc; it must be in a suitable form for
+ * use in a section name.  The type is an integer which is used to tag
+ * the data, and is considered to be within the "name" namespace (so
+ * "FooCo"'s type 42 is distinct from "BarProj"'s type 42).  The
+ * "desc" field is the actual data.  There are no constraints on the
+ * desc field's contents, though typically they're fairly small.
+ *
+ * All notes from a given NAME are put into a section named
+ * .note.NAME.  When the kernel image is finally linked, all the notes
+ * are packed into a single .notes section, which is mapped into the
+ * PT_NOTE segment.  Because notes for a given name are grouped into
+ * the same section, they'll all be adjacent the output file.
+ *
+ * This file defines macros for both C and assembler use.  Their
+ * syntax is slightly different, but they're semantically similar.
+ *
+ * See the ELF specification for more detail about ELF notes.
+ */
+
+#ifdef __ASSEMBLER__
+/*
+ * Generate a structure with the same shape as Elf{32,64}_Nhdr (which
+ * turn out to be the same size and shape), followed by the name and
+ * desc data with appropriate padding.  The 'desc' argument includes
+ * the assembler pseudo op defining the type of the data: .asciz
+ * "hello, world"
+ */
+.macro ELFNOTE name type desc:vararg
+.pushsection ".note.\name"
+  .align 4
+  .long 2f - 1f			/* namesz */
+  .long 4f - 3f			/* descsz */
+  .long \type
+1:.asciz "\name"
+2:.align 4
+3:\desc
+4:.align 4
+.popsection
+.endm
+#else	/* !__ASSEMBLER__ */
+#include <linux/elf.h>
+/* 
+ * Use an anonymous structure which matches the shape of
+ * Elf{32,64}_Nhdr, but includes the name and desc data.  The size and
+ * type of name and desc depend on the macro arguments.  "name" must
+ * be a literal string, and "desc" must be passed by value.  You may
+ * only define one note per line, since __LINE__ is used to generate
+ * unique symbols.
+ */
+#define _ELFNOTE_PASTE(a,b)	a##b
+#define _ELFNOTE(size, name, unique, type, desc)			\
+	static const struct {						\
+		struct elf##size##_note _nhdr;				\
+		unsigned char _name[sizeof(name)]			\
+		__attribute__((aligned(sizeof(Elf##size##_Word))));	\
+		typeof(desc) _desc					\
+			     __attribute__((aligned(sizeof(Elf##size##_Word)))); \
+	} _ELFNOTE_PASTE(_note_, unique)				\
+		__attribute_used__					\
+		__attribute__((section(".note." name),			\
+			       aligned(sizeof(Elf##size##_Word)),	\
+			       unused)) = {				\
+		{							\
+			sizeof(name),					\
+			sizeof(desc),					\
+			type,						\
+		},							\
+		name,							\
+		desc							\
+	}
+#define ELFNOTE(size, name, type, desc)		\
+	_ELFNOTE(size, name, __LINE__, type, desc)
+
+#define ELFNOTE32(name, type, desc) ELFNOTE(32, name, type, desc)
+#define ELFNOTE64(name, type, desc) ELFNOTE(64, name, type, desc)
+#endif	/* __ASSEMBLER__ */
+
+#endif /* _LINUX_ELFNOTE_H */

--

