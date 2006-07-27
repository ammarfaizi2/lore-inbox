Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbWG0WOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbWG0WOx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 18:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWG0WOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 18:14:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50588 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751369AbWG0WOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 18:14:53 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Sam Ravnborg <sam@ravnborg.org>
X-Fcc: ~/Mail/linus
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Jakub Jelinek <jakub@redhat.com>
Subject: Re: [PATCH] vDSO hash-style fix
In-Reply-To: Sam Ravnborg's message of  Thursday, 27 July 2006 13:04:54 +0200 <20060727110453.GA27162@mars.ravnborg.org>
X-Shopping-List: (1) Resentful yies
   (2) Asiatic Ink
   (3) Slanderous eggplants
   (4) Prehistoric attention
   (5) Transparent vapor
Message-Id: <20060727221442.6D97718003B@magilla.sf.frob.com>
Date: Thu, 27 Jul 2006 15:14:42 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a new version of the patch that addresses the issues cited.

Signed-off-by: Roland McGrath <roland@redhat.com>

---
diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
index 14ef386..5438335 100644  
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -407,6 +407,20 @@ more details, with real examples.
 	The second argument is optional, and if supplied will be used
 	if first argument is not supported.
 
+    ld-option
+    	ld-option is used to check if $(CC) when used to link object files
+	supports the given option.  An optional second option may be
+	specified if first option are not supported.
+
+	Example:
+		#arch/i386/kernel/Makefile
+		vsyscall-flags += $(call ld-option, -Wl$(comma)--hash-style=sysv)
+
+	In the above example vsyscall-flags will be assigned the option
+	-Wl$(comma)--hash-style=sysv if it is supported by $(CC).
+	The second argument is optional, and if supplied will be used
+	if first argument is not supported.
+
     cc-option
 	cc-option is used to check if $(CC) support a given option, and not
 	supported to use an optional second option.
diff --git a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
index 1b452a1..5b5fa68 100644  
--- a/arch/i386/kernel/Makefile
+++ b/arch/i386/kernel/Makefile
@@ -59,7 +59,8 @@ quiet_cmd_syscall = SYSCALL $@
 
 export CPPFLAGS_vsyscall.lds += -P -C -U$(ARCH)
 
-vsyscall-flags = -shared -s -Wl,-soname=linux-gate.so.1
+vsyscall-flags = -shared -s -Wl,-soname=linux-gate.so.1 \
+		 $(call ld-option, -Wl$(comma)--hash-style=sysv)
 SYSCFLAGS_vsyscall-sysenter.so	= $(vsyscall-flags)
 SYSCFLAGS_vsyscall-int80.so	= $(vsyscall-flags)
 
diff --git a/arch/i386/kernel/vsyscall.lds.S b/arch/i386/kernel/vsyscall.lds.S
index e26975f..f66cd11 100644  
--- a/arch/i386/kernel/vsyscall.lds.S
+++ b/arch/i386/kernel/vsyscall.lds.S
@@ -10,6 +10,7 @@ SECTIONS
   . = VDSO_PRELINK + SIZEOF_HEADERS;
 
   .hash           : { *(.hash) }		:text
+  .gnu.hash       : { *(.gnu.hash) }
   .dynsym         : { *(.dynsym) }
   .dynstr         : { *(.dynstr) }
   .gnu.version    : { *(.gnu.version) }
diff --git a/arch/ia64/kernel/Makefile b/arch/ia64/kernel/Makefile
index 0e4553f..ad8215a 100644  
--- a/arch/ia64/kernel/Makefile
+++ b/arch/ia64/kernel/Makefile
@@ -45,7 +45,8 @@ CPPFLAGS_gate.lds := -P -C -U$(ARCH)
 quiet_cmd_gate = GATE $@
       cmd_gate = $(CC) -nostdlib $(GATECFLAGS_$(@F)) -Wl,-T,$(filter-out FORCE,$^) -o $@
 
-GATECFLAGS_gate.so = -shared -s -Wl,-soname=linux-gate.so.1
+GATECFLAGS_gate.so = -shared -s -Wl,-soname=linux-gate.so.1 \
+		     $(call ld-option, -Wl$(comma)--hash-style=sysv)
 $(obj)/gate.so: $(obj)/gate.lds $(obj)/gate.o FORCE
 	$(call if_changed,gate)
 
diff --git a/arch/ia64/kernel/gate.lds.S b/arch/ia64/kernel/gate.lds.S
index cc35cdd..6d19833 100644  
--- a/arch/ia64/kernel/gate.lds.S
+++ b/arch/ia64/kernel/gate.lds.S
@@ -12,6 +12,7 @@ SECTIONS
   . = GATE_ADDR + SIZEOF_HEADERS;
 
   .hash				: { *(.hash) }				:readable
+  .gnu.hash			: { *(.gnu.hash) }
   .dynsym			: { *(.dynsym) }
   .dynstr			: { *(.dynstr) }
   .gnu.version			: { *(.gnu.version) }
diff --git a/arch/parisc/kernel/vmlinux.lds.S b/arch/parisc/kernel/vmlinux.lds.S
index 9989495..b3677fc 100644  
--- a/arch/parisc/kernel/vmlinux.lds.S
+++ b/arch/parisc/kernel/vmlinux.lds.S
@@ -204,6 +204,7 @@ SECTIONS
 	*(.dynstr)
 	*(.dynamic)
 	*(.hash)
+	*(.gnu.hash)
 #endif
 	}
 
diff --git a/arch/powerpc/kernel/vdso32/Makefile b/arch/powerpc/kernel/vdso32/Makefile
index 8a3bed5..61ac45a 100644  
--- a/arch/powerpc/kernel/vdso32/Makefile
+++ b/arch/powerpc/kernel/vdso32/Makefile
@@ -14,7 +14,8 @@ obj-vdso32 := $(addprefix $(obj)/, $(obj
 
 
 EXTRA_CFLAGS := -shared -s -fno-common -fno-builtin
-EXTRA_CFLAGS += -nostdlib -Wl,-soname=linux-vdso32.so.1
+EXTRA_CFLAGS += -nostdlib -Wl,-soname=linux-vdso32.so.1 \
+		$(call ld-option, -Wl$(comma)--hash-style=sysv)
 EXTRA_AFLAGS := -D__VDSO32__ -s
 
 obj-y += vdso32_wrapper.o
diff --git a/arch/powerpc/kernel/vdso32/vdso32.lds.S b/arch/powerpc/kernel/vdso32/vdso32.lds.S
index f4bad72..6187af2 100644  
--- a/arch/powerpc/kernel/vdso32/vdso32.lds.S
+++ b/arch/powerpc/kernel/vdso32/vdso32.lds.S
@@ -14,6 +14,7 @@ SECTIONS
 {
   . = VDSO32_LBASE + SIZEOF_HEADERS;
   .hash           : { *(.hash) }			:text
+  .gnu.hash       : { *(.gnu.hash) }
   .dynsym         : { *(.dynsym) }
   .dynstr         : { *(.dynstr) }
   .gnu.version    : { *(.gnu.version) }
diff --git a/arch/powerpc/kernel/vdso64/Makefile b/arch/powerpc/kernel/vdso64/Makefile
index ab39988..1d0d02b 100644  
--- a/arch/powerpc/kernel/vdso64/Makefile
+++ b/arch/powerpc/kernel/vdso64/Makefile
@@ -8,7 +8,8 @@ targets := $(obj-vdso64) vdso64.so
 obj-vdso64 := $(addprefix $(obj)/, $(obj-vdso64))
 
 EXTRA_CFLAGS := -shared -s -fno-common -fno-builtin
-EXTRA_CFLAGS +=  -nostdlib -Wl,-soname=linux-vdso64.so.1
+EXTRA_CFLAGS += -nostdlib -Wl,-soname=linux-vdso64.so.1 \
+		$(call ld-option, -Wl$(comma)--hash-style=sysv)
 EXTRA_AFLAGS := -D__VDSO64__ -s
 
 obj-y += vdso64_wrapper.o
diff --git a/arch/powerpc/kernel/vdso64/vdso64.lds.S b/arch/powerpc/kernel/vdso64/vdso64.lds.S
index 4bdf224..4a2b6dc 100644  
--- a/arch/powerpc/kernel/vdso64/vdso64.lds.S
+++ b/arch/powerpc/kernel/vdso64/vdso64.lds.S
@@ -12,6 +12,7 @@ SECTIONS
 {
   . = VDSO64_LBASE + SIZEOF_HEADERS;
   .hash           : { *(.hash) }		:text
+  .gnu.hash       : { *(.gnu.hash) }
   .dynsym         : { *(.dynsym) }
   .dynstr         : { *(.dynstr) }
   .gnu.version    : { *(.gnu.version) }
diff --git a/arch/ppc/kernel/vmlinux.lds.S b/arch/ppc/kernel/vmlinux.lds.S
index 09c6525..095fd33 100644  
--- a/arch/ppc/kernel/vmlinux.lds.S
+++ b/arch/ppc/kernel/vmlinux.lds.S
@@ -8,6 +8,7 @@ SECTIONS
   . = + SIZEOF_HEADERS;
   .interp : { *(.interp) }
   .hash          : { *(.hash)		}
+  .gnu.hash      : { *(.gnu.hash)	}
   .dynsym        : { *(.dynsym)		}
   .dynstr        : { *(.dynstr)		}
   .rel.text      : { *(.rel.text)		}
diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
index 2517ecb..68ed24d 100644  
--- a/arch/um/kernel/dyn.lds.S
+++ b/arch/um/kernel/dyn.lds.S
@@ -26,6 +26,7 @@ SECTIONS
 
   /* Read-only sections, merged into text segment: */
   .hash           : { *(.hash) }
+  .gnu.hash       : { *(.gnu.hash) }
   .dynsym         : { *(.dynsym) }
   .dynstr         : { *(.dynstr) }
   .gnu.version    : { *(.gnu.version) }
diff --git a/arch/x86_64/ia32/Makefile b/arch/x86_64/ia32/Makefile
index 62bc5f5..cdae364 100644  
--- a/arch/x86_64/ia32/Makefile
+++ b/arch/x86_64/ia32/Makefile
@@ -23,6 +23,7 @@ targets := $(foreach F,sysenter syscall,
 # The DSO images are built using a special linker script
 quiet_cmd_syscall = SYSCALL $@
       cmd_syscall = $(CC) -m32 -nostdlib -shared -s \
+			  $(call ld-option, -Wl$(comma)--hash-style=sysv) \
 			   -Wl,-soname=linux-gate.so.1 -o $@ \
 			   -Wl,-T,$(filter-out FORCE,$^)
 
diff --git a/arch/x86_64/ia32/vsyscall.lds b/arch/x86_64/ia32/vsyscall.lds
index f2e75ed..1dc86ff 100644  
--- a/arch/x86_64/ia32/vsyscall.lds
+++ b/arch/x86_64/ia32/vsyscall.lds
@@ -11,6 +11,7 @@ SECTIONS
   . = VSYSCALL_BASE + SIZEOF_HEADERS;
 
   .hash           : { *(.hash) }		:text
+  .gnu.hash       : { *(.gnu.hash) }
   .dynsym         : { *(.dynsym) }
   .dynstr         : { *(.dynstr) }
   .gnu.version    : { *(.gnu.version) }
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 2180c88..ceeb087 100644  
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -85,6 +85,13 @@ cc-version = $(shell $(CONFIG_SHELL) $(s
 cc-ifversion = $(shell if [ $(call cc-version, $(CC)) $(1) $(2) ]; then \
                        echo $(3); fi;)
 
+# ld-option
+# Usage: ldflags += $(call ld-option, -Wl$(comma)--hash-style=both)
+ld-option = $(shell if $(CC) $(1) \
+			     -nostdlib -o ldtest$$$$.out -xc /dev/null \
+             > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi; \
+	     rm -f ldtest$$$$.out)
+
 ###
 # Shorthand for $(Q)$(MAKE) -f scripts/Makefile.build obj=
 # Usage:
