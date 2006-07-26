Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161023AbWGZUPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161023AbWGZUPT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 16:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751783AbWGZUPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 16:15:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21904 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751778AbWGZUPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 16:15:17 -0400
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org, Jakub Jelinek <jakub@redhat.com>
Subject: [PATCH] vDSO hash-style fix
Message-Id: <20060726201502.A14FE18003A@magilla.sf.frob.com>
Date: Wed, 26 Jul 2006 13:15:02 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest toolchains can produce a new ELF section in DSOs and
dynamically-linked executables.  The new section ".gnu.hash" replaces
".hash", and allows for more efficient runtime symbol lookups by the
dynamic linker.  The new ld option --hash-style={sysv|gnu|both}
controls whether to produce the old ".hash", the new ".gnu.hash", or
both.  In some new systems such as Fedora Core 6, gcc by default
passes --hash-style=gnu to the linker, so that a standard invocation
of "gcc -shared" results in producing a DSO with only ".gnu.hash".
The new ".gnu.hash" sections need to be dealt with the same way as
".hash" sections in all respects; only the dynamic linker cares about
their contents.  To work with older dynamic linkers (i.e. preexisting
releases of glibc), a binary must have the old ".hash" section.  The
--hash-style=both option produces binaries that a new dynamic linker
can use more efficiently, but an old dynamic linker can still handle.

The new section runs afoul of the custom linker scripts used to
build vDSO images for the kernel.  On ia64, the failure mode for
this is a boot-time panic because the vDSO's PT_IA_64_UNWIND
segment winds up ill-formed.

This patch addresses the problem in two ways.

First, it mentions ".gnu.hash" in all the linker scripts alongside
".hash".  This produces correct vDSO images with --hash-style=sysv (or
old tools), with --hash-style=gnu, or with --hash-style=both.

Second, it passes the --hash-style=sysv option when building the vDSO
images, so that ".gnu.hash" is not actually produced.  This is the
most conservative choice for compatibility with any old userland.
There is some concern that some ancient glibc builds (though not any
known old production system) might choke on --hash-style=both
binaries.  The optimizations provided by the new style of hash section
do not really matter for a DSO with a tiny number of symbols, as the
vDSO has.  If someone wants to use =gnu or =both for their vDSO builds
and worry less about that compatibility, just change the option and
the linker script changes will make any choice work fine.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/i386/kernel/Makefile               |    4 ++--
 arch/i386/kernel/vsyscall.lds.S         |    1 +
 arch/ia64/kernel/Makefile               |    3 ++-
 arch/ia64/kernel/gate.lds.S             |    1 +
 arch/parisc/kernel/vmlinux.lds.S        |    1 +
 arch/powerpc/kernel/vdso32/Makefile     |    4 ++--
 arch/powerpc/kernel/vdso32/vdso32.lds.S |    1 +
 arch/powerpc/kernel/vdso64/Makefile     |    5 ++---
 arch/powerpc/kernel/vdso64/vdso64.lds.S |    1 +
 arch/ppc/kernel/vmlinux.lds.S           |    1 +
 arch/um/kernel/dyn.lds.S                |    1 +
 arch/x86_64/ia32/Makefile               |    1 +
 arch/x86_64/ia32/vsyscall.lds           |    1 +
 scripts/Kbuild.include                  |    6 ++++++
 14 files changed, 23 insertions(+), 8 deletions(-)

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
index 2180c88..a3c0fdc 100644  
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -85,6 +85,12 @@ cc-version = $(shell $(CONFIG_SHELL) $(s
 cc-ifversion = $(shell if [ $(call cc-version, $(CC)) $(1) $(2) ]; then \
                        echo $(3); fi;)
 
+# ld-option
+# Usage: ldflags += $(call ld-option, -Wl$(comma)--hash-style=both)
+ld-option = $(shell if $(CC) $(1) \
+			     -nostdlib -o /dev/null -xc /dev/null \
+             > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
+
 ###
 # Shorthand for $(Q)$(MAKE) -f scripts/Makefile.build obj=
 # Usage:
