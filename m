Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbVIJSGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbVIJSGh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 14:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbVIJSGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 14:06:35 -0400
Received: from ppp-62-11-72-160.dialup.tiscali.it ([62.11.72.160]:35752 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S932149AbVIJSEo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 14:04:44 -0400
Message-Id: <20050910174627.569839000@zion.home.lan>
References: <20050910174452.907256000@zion.home.lan>
Date: Sat, 10 Sep 2005 19:44:54 +0200
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, Sam Ravnborg <sam@ravnborg.org>,
       Paolo Blaisorblade Giarrusso <blaisorblade@yahoo.it>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: user-mode-linux-devel@lists.sourceforge.net
Subject: [patch 2/7] i386 / uml: add dwarf sections to static link script
Content-Disposition: inline; filename=uml-add-dwarf-sections-to-static-link-script
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Inside the linker script, insert the code for DWARF debug info sections. This
may help GDB'ing a Uml binary. Actually, it seems that ld is able to guess
what I added correctly, but normal linker scripts include this section so it
should be correct anyway adding it.

On request by Sam Ravnborg <sam@ravnborg.org>, I've added it to
asm-generic/vmlinux.lds.s. I've also moved there the stabs debug section,
used the new macro in i386 linker script and added DWARF debug section to
that.

In the truth, I've not been able to verify the difference in GDB behaviour
after this change (I've seen large improvements with another patch). This
may depend on my binutils version, older one may have worse defaults.

However, this section is present in normal linker script, so add it at
least for the sake of cleanness.

Cc: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/i386/kernel/vmlinux.lds.S    |   11 +++--------
 arch/um/kernel/dyn.lds.S          |   37 ++++--------------------------------
 arch/um/kernel/uml.lds.S          |   14 +++++---------
 include/asm-generic/vmlinux.lds.h |   38 +++++++++++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/arch/i386/kernel/vmlinux.lds.S b/arch/i386/kernel/vmlinux.lds.S
--- a/arch/i386/kernel/vmlinux.lds.S
+++ b/arch/i386/kernel/vmlinux.lds.S
@@ -144,12 +144,7 @@ SECTIONS
 	*(.exitcall.exit)
 	}
 
-  /* Stabs debugging sections.  */
-  .stab 0 : { *(.stab) }
-  .stabstr 0 : { *(.stabstr) }
-  .stab.excl 0 : { *(.stab.excl) }
-  .stab.exclstr 0 : { *(.stab.exclstr) }
-  .stab.index 0 : { *(.stab.index) }
-  .stab.indexstr 0 : { *(.stab.indexstr) }
-  .comment 0 : { *(.comment) }
+  STABS_DEBUG
+
+  DWARF_DEBUG
 }
diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
--- a/arch/um/kernel/dyn.lds.S
+++ b/arch/um/kernel/dyn.lds.S
@@ -146,37 +146,8 @@ SECTIONS
   }
   _end = .;
   PROVIDE (end = .);
-   /* Stabs debugging sections.  */
-  .stab          0 : { *(.stab) }
-  .stabstr       0 : { *(.stabstr) }
-  .stab.excl     0 : { *(.stab.excl) }
-  .stab.exclstr  0 : { *(.stab.exclstr) }
-  .stab.index    0 : { *(.stab.index) }
-  .stab.indexstr 0 : { *(.stab.indexstr) }
-  .comment       0 : { *(.comment) }
-  /* DWARF debug sections.
-     Symbols in the DWARF debugging sections are relative to the beginning
-     of the section so we begin them at 0.  */
-  /* DWARF 1 */
-  .debug          0 : { *(.debug) }
-  .line           0 : { *(.line) }
-  /* GNU DWARF 1 extensions */
-  .debug_srcinfo  0 : { *(.debug_srcinfo) }
-  .debug_sfnames  0 : { *(.debug_sfnames) }
-  /* DWARF 1.1 and DWARF 2 */
-  .debug_aranges  0 : { *(.debug_aranges) }
-  .debug_pubnames 0 : { *(.debug_pubnames) }
-  /* DWARF 2 */
-  .debug_info     0 : { *(.debug_info .gnu.linkonce.wi.*) }
-  .debug_abbrev   0 : { *(.debug_abbrev) }
-  .debug_line     0 : { *(.debug_line) }
-  .debug_frame    0 : { *(.debug_frame) }
-  .debug_str      0 : { *(.debug_str) }
-  .debug_loc      0 : { *(.debug_loc) }
-  .debug_macinfo  0 : { *(.debug_macinfo) }
-  /* SGI/MIPS DWARF 2 extensions */
-  .debug_weaknames 0 : { *(.debug_weaknames) }
-  .debug_funcnames 0 : { *(.debug_funcnames) }
-  .debug_typenames 0 : { *(.debug_typenames) }
-  .debug_varnames  0 : { *(.debug_varnames) }
+
+  STABS_DEBUG
+
+  DWARF_DEBUG
 }
diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
--- a/arch/um/kernel/uml.lds.S
+++ b/arch/um/kernel/uml.lds.S
@@ -93,14 +93,10 @@ SECTIONS
    *(.bss)
    *(COMMON)
   }
-  _end = . ;
+  _end = .;
   PROVIDE (end = .);
-  /* Stabs debugging sections.  */
-  .stab 0 : { *(.stab) }
-  .stabstr 0 : { *(.stabstr) }
-  .stab.excl 0 : { *(.stab.excl) }
-  .stab.exclstr 0 : { *(.stab.exclstr) }
-  .stab.index 0 : { *(.stab.index) }
-  .stab.indexstr 0 : { *(.stab.indexstr) }
-  .comment 0 : { *(.comment) }
+
+  STABS_DEBUG
+
+  DWARF_DEBUG
 }
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -103,3 +103,41 @@
 		VMLINUX_SYMBOL(__kprobes_text_start) = .;		\
 		*(.kprobes.text)					\
 		VMLINUX_SYMBOL(__kprobes_text_end) = .;
+
+		/* DWARF debug sections.
+		Symbols in the DWARF debugging sections are relative to
+		the beginning of the section so we begin them at 0.  */
+#define DWARF_DEBUG							\
+		/* DWARF 1 */						\
+		.debug          0 : { *(.debug) }			\
+		.line           0 : { *(.line) }			\
+		/* GNU DWARF 1 extensions */				\
+		.debug_srcinfo  0 : { *(.debug_srcinfo) }		\
+		.debug_sfnames  0 : { *(.debug_sfnames) }		\
+		/* DWARF 1.1 and DWARF 2 */				\
+		.debug_aranges  0 : { *(.debug_aranges) }		\
+		.debug_pubnames 0 : { *(.debug_pubnames) }		\
+		/* DWARF 2 */						\
+		.debug_info     0 : { *(.debug_info			\
+				.gnu.linkonce.wi.*) }			\
+		.debug_abbrev   0 : { *(.debug_abbrev) }		\
+		.debug_line     0 : { *(.debug_line) }			\
+		.debug_frame    0 : { *(.debug_frame) }			\
+		.debug_str      0 : { *(.debug_str) }			\
+		.debug_loc      0 : { *(.debug_loc) }			\
+		.debug_macinfo  0 : { *(.debug_macinfo) }		\
+		/* SGI/MIPS DWARF 2 extensions */			\
+		.debug_weaknames 0 : { *(.debug_weaknames) }		\
+		.debug_funcnames 0 : { *(.debug_funcnames) }		\
+		.debug_typenames 0 : { *(.debug_typenames) }		\
+		.debug_varnames  0 : { *(.debug_varnames) }		\
+
+		/* Stabs debugging sections.  */
+#define STABS_DEBUG							\
+		.stab 0 : { *(.stab) }					\
+		.stabstr 0 : { *(.stabstr) }				\
+		.stab.excl 0 : { *(.stab.excl) }			\
+		.stab.exclstr 0 : { *(.stab.exclstr) }			\
+		.stab.index 0 : { *(.stab.index) }			\
+		.stab.indexstr 0 : { *(.stab.indexstr) }		\
+		.comment 0 : { *(.comment) }

--
