Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWCZLyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWCZLyb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 06:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWCZLya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 06:54:30 -0500
Received: from smtpout.mac.com ([17.250.248.89]:9203 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751290AbWCZLya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 06:54:30 -0500
Date: Sun, 26 Mar 2006 06:54:16 -0500
From: Kyle Moffett <mrmacman_g4@mac.com>
To: linux-kernel@vger.kernel.org
Cc: nix@esperi.org.uk, rob@landley.net, mmazur@kernel.pl,
       llh-discuss@lists.pld-linux.org
Subject: [RFC][PATCH 1/2] Create initial kernel ABI header infrastructure
Message-Id: <20060326065416.93d5ce68.mrmacman_g4@mac.com>
In-Reply-To: <20060326065205.d691539c.mrmacman_g4@mac.com>
References: <200603141619.36609.mmazur@kernel.pl>
	<200603231811.26546.mmazur@kernel.pl>
	<DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com>
	<200603241623.49861.rob@landley.net>
	<878xqzpl8g.fsf@hades.wkstn.nix>
	<D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com>
	<20060326065205.d691539c.mrmacman_g4@mac.com>
X-Mailer: Sylpheed version 2.2.1 (GTK+ 2.8.13; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Create initial kernel ABI header infrastructure

The model proposed for the new kernel ABI headers is that the headers
pertinent to both kernelspace and userspace would be reorganized and
cleaned out into include/kabi.  The new headers should stay in a restricted
namespace such that they are useable anywhere.  Just as include/asm is
symlinked to include/asm-$ARCH, include/kabi/arch will be symlinked to
include/kabi/arch-$ARCH to provide a straightforward way of selecting the
correct architecture ABI.

This creates the first architecture-specific header file, "stddef.h", which
implements a basic BITS_PER_LONG definition, and adds the corresponding
Makefile bits to create the include/kabi/arch symlink.

There's probably something else that needs to be done about getting the
correct include/kabi/* files in the tarball but I'm not aware of it at this
time, so I'll just pretend it doesn't exist :-D.

This appears to compile correctly with allmodconfig on powerpc (32-bit)

Signed-off-by: Kyle Moffett <mrmacman_g4@mac.com>

---
commit affadc51c2b4c96785809a352973a9f6a51a4c37
tree e0979fa864eab8902ccae459060b18f077ad1d4e
parent 36ddf5bbdea7ba4582abc62f106f0f0e9f0b6b91
author Kyle Moffett <mrmacman_g4@mac.com> Sun, 26 Mar 2006 06:18:06 -0500
committer Kyle Moffett <mrmacman_g4@mac.com> Sun, 26 Mar 2006 06:18:06 -0500

 Makefile                             |   22 +++++++++++++++++++---
 include/kabi/arch-alpha/stddef.h     |    7 +++++++
 include/kabi/arch-arm/stddef.h       |    7 +++++++
 include/kabi/arch-arm26/stddef.h     |    7 +++++++
 include/kabi/arch-cris/stddef.h      |    7 +++++++
 include/kabi/arch-frv/stddef.h       |    7 +++++++
 include/kabi/arch-h8300/stddef.h     |    7 +++++++
 include/kabi/arch-i386/stddef.h      |    7 +++++++
 include/kabi/arch-ia64/stddef.h      |    7 +++++++
 include/kabi/arch-m32r/stddef.h      |    7 +++++++
 include/kabi/arch-m68k/stddef.h      |    7 +++++++
 include/kabi/arch-m68knommu/stddef.h |    1 +
 include/kabi/arch-mips/stddef.h      |   12 ++++++++++++
 include/kabi/arch-parisc/stddef.h    |   12 ++++++++++++
 include/kabi/arch-powerpc/stddef.h   |   12 ++++++++++++
 include/kabi/arch-ppc/stddef.h       |    1 +
 include/kabi/arch-s390/stddef.h      |   12 ++++++++++++
 include/kabi/arch-sh/stddef.h        |    7 +++++++
 include/kabi/arch-sh64/stddef.h      |    7 +++++++
 include/kabi/arch-sparc/stddef.h     |    7 +++++++
 include/kabi/arch-sparc64/stddef.h   |    7 +++++++
 include/kabi/arch-v850/stddef.h      |    7 +++++++
 include/kabi/arch-x86_64/stddef.h    |    7 +++++++
 include/kabi/arch-xtensa/stddef.h    |    7 +++++++
 24 files changed, 188 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index af6210d..8e9045a 100644
--- a/Makefile
+++ b/Makefile
@@ -787,13 +787,15 @@ ifneq ($(KBUILD_SRC),)
 		/bin/false; \
 	fi;
 	$(Q)if [ ! -d include2 ]; then mkdir -p include2; fi;
+	$(Q)if [ ! -d include2/kabi ]; then mkdir -p include2/kabi; fi;
 	$(Q)ln -fsn $(srctree)/include/asm-$(ARCH) include2/asm
+	$(Q)ln -fsn $(srctree)/include/kabi/arch-$(ARCH) include2/kabi/arch
 endif
 
 # prepare2 creates a makefile if using a separate output directory
 prepare2: prepare3 outputmakefile
 
-prepare1: prepare2 include/linux/version.h include/asm \
+prepare1: prepare2 include/linux/version.h include/asm include/kabi/arch \
                    include/config/MARKER
 ifneq ($(KBUILD_MODULES),)
 	$(Q)rm -rf $(MODVERDIR)
@@ -822,6 +824,12 @@ include/asm:
 	$(Q)if [ ! -d include ]; then mkdir -p include; fi;
 	@ln -fsn asm-$(ARCH) $@
 
+include/kabi/arch:
+	@echo '  SYMLINK $@ -> include/kabi/arch-$(ARCH)'
+	$(Q)if [ ! -d include ]; then mkdir -p include; fi;
+	$(Q)if [ ! -d include/kabi ]; then mkdir -p include/kabi; fi;
+	@ln -fsn arch-$(ARCH) $@
+
 # 	Split autoconf.h into include/linux/config/*
 
 include/config/MARKER: scripts/basic/split-include include/linux/autoconf.h
@@ -944,7 +952,8 @@ CLEAN_FILES +=	vmlinux System.map \
 MRPROPER_DIRS  += include/config include2
 MRPROPER_FILES += .config .config.old include/asm .version .old_version \
                   include/linux/autoconf.h include/linux/version.h \
-		  .kernelrelease Module.symvers tags TAGS cscope*
+		  .kernelrelease Module.symvers tags TAGS cscope* \
+		  include/kabi/arch
 
 # clean - Delete most, but leave enough to build external modules
 #
@@ -1195,12 +1204,19 @@ define all-sources
 	  find $(__srctree)security/selinux/include $(RCS_FIND_IGNORE) \
 	       -name '*.[chS]' -print; \
 	  find $(__srctree)include $(RCS_FIND_IGNORE) \
-	       \( -name config -o -name 'asm-*' \) -prune \
+	       \( -name config -o -name 'asm-*' -o -name 'kabi' \) -prune \
+	       -o -name '*.[chS]' -print; \
+	  find $(__srctree)include/kabi $(RCS_FIND_IGNORE) \
+	       \( -name 'arch-*' \) -prune \
 	       -o -name '*.[chS]' -print; \
 	  for ARCH in $(ALLINCLUDE_ARCHS) ; do \
 	       find $(__srctree)include/asm-$${ARCH} $(RCS_FIND_IGNORE) \
 	            -name '*.[chS]' -print; \
 	  done ; \
+	  for ARCH in $(ALLINCLUDE_ARCHS) ; do \
+	       find $(__srctree)include/kabi/arch-$${ARCH} $(RCS_FIND_IGNORE) \
+	            -name '*.[chS]' -print; \
+	  done ; \
 	  find $(__srctree)include/asm-generic $(RCS_FIND_IGNORE) \
 	       -name '*.[chS]' -print )
 endef
diff --git a/include/kabi/arch-alpha/stddef.h b/include/kabi/arch-alpha/stddef.h
new file mode 100644
index 0000000..dd0ea38
--- /dev/null
+++ b/include/kabi/arch-alpha/stddef.h
@@ -0,0 +1,7 @@
+#ifndef  __KABI_ARCH_ALPHA_STDDEF_H
+# define __KABI_ARCH_ALPHA_STDDEF_H 1
+
+# define __KABI_BITS_PER_LONG 64
+# define __KABI_BITS_PER_LONG_SHIFT 6
+
+#endif /* not __KABI_ARCH_ALPHA_STDDEF_H */
diff --git a/include/kabi/arch-arm/stddef.h b/include/kabi/arch-arm/stddef.h
new file mode 100644
index 0000000..556b13a
--- /dev/null
+++ b/include/kabi/arch-arm/stddef.h
@@ -0,0 +1,7 @@
+#ifndef  __KABI_ARCH_ARM_STDDEF_H
+# define __KABI_ARCH_ARM_STDDEF_H 1
+
+# define __KABI_BITS_PER_LONG 32
+# define __KABI_BITS_PER_LONG_SHIFT 5
+
+#endif /* not __KABI_ARCH_ARM_STDDEF_H */
diff --git a/include/kabi/arch-arm26/stddef.h b/include/kabi/arch-arm26/stddef.h
new file mode 100644
index 0000000..74a6959
--- /dev/null
+++ b/include/kabi/arch-arm26/stddef.h
@@ -0,0 +1,7 @@
+#ifndef  __KABI_ARCH_ARM26_STDDEF_H
+# define __KABI_ARCH_ARM26_STDDEF_H 1
+
+# define __KABI_BITS_PER_LONG 32
+# define __KABI_BITS_PER_LONG_SHIFT 5
+
+#endif /* not __KABI_ARCH_ARM26_STDDEF_H */
diff --git a/include/kabi/arch-cris/stddef.h b/include/kabi/arch-cris/stddef.h
new file mode 100644
index 0000000..ca3a965
--- /dev/null
+++ b/include/kabi/arch-cris/stddef.h
@@ -0,0 +1,7 @@
+#ifndef  __KABI_ARCH_CRIS_STDDEF_H
+# define __KABI_ARCH_CRIS_STDDEF_H 1
+
+# define __KABI_BITS_PER_LONG 32
+# define __KABI_BITS_PER_LONG_SHIFT 5
+
+#endif /* not __KABI_ARCH_CRIS_STDDEF_H */
diff --git a/include/kabi/arch-frv/stddef.h b/include/kabi/arch-frv/stddef.h
new file mode 100644
index 0000000..6d47d06
--- /dev/null
+++ b/include/kabi/arch-frv/stddef.h
@@ -0,0 +1,7 @@
+#ifndef  __KABI_ARCH_FRV_STDDEF_H
+# define __KABI_ARCH_FRV_STDDEF_H 1
+
+# define __KABI_BITS_PER_LONG 32
+# define __KABI_BITS_PER_LONG_SHIFT 5
+
+#endif /* not __KABI_ARCH_FRV_STDDEF_H */
diff --git a/include/kabi/arch-h8300/stddef.h b/include/kabi/arch-h8300/stddef.h
new file mode 100644
index 0000000..fc05a8e
--- /dev/null
+++ b/include/kabi/arch-h8300/stddef.h
@@ -0,0 +1,7 @@
+#ifndef  __KABI_ARCH_H8300_STDDEF_H
+# define __KABI_ARCH_H8300_STDDEF_H 1
+
+# define __KABI_BITS_PER_LONG 32
+# define __KABI_BITS_PER_LONG_SHIFT 5
+
+#endif /* not __KABI_ARCH_H8300_STDDEF_H */
diff --git a/include/kabi/arch-i386/stddef.h b/include/kabi/arch-i386/stddef.h
new file mode 100644
index 0000000..a2006b9
--- /dev/null
+++ b/include/kabi/arch-i386/stddef.h
@@ -0,0 +1,7 @@
+#ifndef  __KABI_ARCH_I386_STDDEF_H
+# define __KABI_ARCH_I386_STDDEF_H 1
+
+# define __KABI_BITS_PER_LONG 32
+# define __KABI_BITS_PER_LONG_SHIFT 5
+
+#endif /* not __KABI_ARCH_I386_STDDEF_H */
diff --git a/include/kabi/arch-ia64/stddef.h b/include/kabi/arch-ia64/stddef.h
new file mode 100644
index 0000000..6847a92
--- /dev/null
+++ b/include/kabi/arch-ia64/stddef.h
@@ -0,0 +1,7 @@
+#ifndef  __KABI_ARCH_IA64_STDDEF_H
+# define __KABI_ARCH_IA64_STDDEF_H 1
+
+# define __KABI_BITS_PER_LONG 64
+# define __KABI_BITS_PER_LONG_SHIFT 6
+
+#endif /* not __KABI_ARCH_IA64_STDDEF_H */
diff --git a/include/kabi/arch-m32r/stddef.h b/include/kabi/arch-m32r/stddef.h
new file mode 100644
index 0000000..fdb97ad
--- /dev/null
+++ b/include/kabi/arch-m32r/stddef.h
@@ -0,0 +1,7 @@
+#ifndef  __KABI_ARCH_M32R_STDDEF_H
+# define __KABI_ARCH_M32R_STDDEF_H 1
+
+# define __KABI_BITS_PER_LONG 32
+# define __KABI_BITS_PER_LONG_SHIFT 5
+
+#endif /* not __KABI_ARCH_M32R_STDDEF_H */
diff --git a/include/kabi/arch-m68k/stddef.h b/include/kabi/arch-m68k/stddef.h
new file mode 100644
index 0000000..b2c1490
--- /dev/null
+++ b/include/kabi/arch-m68k/stddef.h
@@ -0,0 +1,7 @@
+#ifndef  __KABI_ARCH_M68K_STDDEF_H
+# define __KABI_ARCH_M68K_STDDEF_H 1
+
+# define __KABI_BITS_PER_LONG 32
+# define __KABI_BITS_PER_LONG_SHIFT 5
+
+#endif /* not __KABI_ARCH_M68K_STDDEF_H */
diff --git a/include/kabi/arch-m68knommu/stddef.h b/include/kabi/arch-m68knommu/stddef.h
new file mode 100644
index 0000000..f01d529
--- /dev/null
+++ b/include/kabi/arch-m68knommu/stddef.h
@@ -0,0 +1 @@
+#include <kabi/arch-m68k/stddef.h>
diff --git a/include/kabi/arch-mips/stddef.h b/include/kabi/arch-mips/stddef.h
new file mode 100644
index 0000000..318a2d1
--- /dev/null
+++ b/include/kabi/arch-mips/stddef.h
@@ -0,0 +1,12 @@
+#ifndef  __KABI_ARCH_MIPS_STDDEF_H
+# define __KABI_ARCH_MIPS_STDDEF_H 1
+
+# if _MIPS_SZLONG == 64
+#  define __KABI_BITS_PER_LONG 64
+#  define __KABI_BITS_PER_LONG_SHIFT 6
+# else
+#  define __KABI_BITS_PER_LONG 32
+#  define __KABI_BITS_PER_LONG_SHIFT 5
+# endif
+
+#endif /* not __KABI_ARCH_MIPS_STDDEF_H */
diff --git a/include/kabi/arch-parisc/stddef.h b/include/kabi/arch-parisc/stddef.h
new file mode 100644
index 0000000..ae24ae9
--- /dev/null
+++ b/include/kabi/arch-parisc/stddef.h
@@ -0,0 +1,12 @@
+#ifndef  __KABI_ARCH_PARISC_STDDEF_H
+# define __KABI_ARCH_PARISC_STDDEF_H 1
+
+# ifdef __LP64__
+#  define __KABI_BITS_PER_LONG 64
+#  define __KABI_BITS_PER_LONG_SHIFT 6
+# else
+#  define __KABI_BITS_PER_LONG 32
+#  define __KABI_BITS_PER_LONG_SHIFT 5
+# endif
+
+#endif /* not __KABI_ARCH_PARISC_STDDEF_H */
diff --git a/include/kabi/arch-powerpc/stddef.h b/include/kabi/arch-powerpc/stddef.h
new file mode 100644
index 0000000..f9acee1
--- /dev/null
+++ b/include/kabi/arch-powerpc/stddef.h
@@ -0,0 +1,12 @@
+#ifndef  __KABI_ARCH_POWERPC_STDDEF_H
+# define __KABI_ARCH_POWERPC_STDDEF_H 1
+
+# ifdef __powerpc64__
+#  define __KABI_BITS_PER_LONG 64
+#  define __KABI_BITS_PER_LONG_SHIFT 6
+# else
+#  define __KABI_BITS_PER_LONG 32
+#  define __KABI_BITS_PER_LONG_SHIFT 5
+# endif
+
+#endif /* not __KABI_ARCH_POWERPC_STDDEF_H */
diff --git a/include/kabi/arch-ppc/stddef.h b/include/kabi/arch-ppc/stddef.h
new file mode 100644
index 0000000..a244f18
--- /dev/null
+++ b/include/kabi/arch-ppc/stddef.h
@@ -0,0 +1 @@
+#include <kabi/arch-powerpc/stddef.h>
diff --git a/include/kabi/arch-s390/stddef.h b/include/kabi/arch-s390/stddef.h
new file mode 100644
index 0000000..d1f26b0
--- /dev/null
+++ b/include/kabi/arch-s390/stddef.h
@@ -0,0 +1,12 @@
+#ifndef  __KABI_ARCH_S390_STDDEF_H
+# define __KABI_ARCH_S390_STDDEF_H 1
+
+# ifdef __s390x__
+#  define __KABI_BITS_PER_LONG 64
+#  define __KABI_BITS_PER_LONG_SHIFT 6
+# else
+#  define __KABI_BITS_PER_LONG 32
+#  define __KABI_BITS_PER_LONG_SHIFT 5
+# endif
+
+#endif /* not __KABI_ARCH_S390_STDDEF_H */
diff --git a/include/kabi/arch-sh/stddef.h b/include/kabi/arch-sh/stddef.h
new file mode 100644
index 0000000..d0f81dd
--- /dev/null
+++ b/include/kabi/arch-sh/stddef.h
@@ -0,0 +1,7 @@
+#ifndef  __KABI_ARCH_SH_STDDEF_H
+# define __KABI_ARCH_SH_STDDEF_H 1
+
+# define __KABI_BITS_PER_LONG 32
+# define __KABI_BITS_PER_LONG_SHIFT 5
+
+#endif /* not __KABI_ARCH_SH_STDDEF_H */
diff --git a/include/kabi/arch-sh64/stddef.h b/include/kabi/arch-sh64/stddef.h
new file mode 100644
index 0000000..5d00497
--- /dev/null
+++ b/include/kabi/arch-sh64/stddef.h
@@ -0,0 +1,7 @@
+#ifndef  __KABI_ARCH_SH64_STDDEF_H
+# define __KABI_ARCH_SH64_STDDEF_H 1
+
+# define __KABI_BITS_PER_LONG 32
+# define __KABI_BITS_PER_LONG_SHIFT 5
+
+#endif /* not __KABI_ARCH_SH64_STDDEF_H */
diff --git a/include/kabi/arch-sparc/stddef.h b/include/kabi/arch-sparc/stddef.h
new file mode 100644
index 0000000..e00c10c
--- /dev/null
+++ b/include/kabi/arch-sparc/stddef.h
@@ -0,0 +1,7 @@
+#ifndef  __KABI_ARCH_SPARC_STDDEF_H
+# define __KABI_ARCH_SPARC_STDDEF_H 1
+
+# define __KABI_BITS_PER_LONG 32
+# define __KABI_BITS_PER_LONG_SHIFT 5
+
+#endif /* not __KABI_ARCH_SPARC_STDDEF_H */
diff --git a/include/kabi/arch-sparc64/stddef.h b/include/kabi/arch-sparc64/stddef.h
new file mode 100644
index 0000000..5125f4b
--- /dev/null
+++ b/include/kabi/arch-sparc64/stddef.h
@@ -0,0 +1,7 @@
+#ifndef  __KABI_ARCH_SPARC64_STDDEF_H
+# define __KABI_ARCH_SPARC64_STDDEF_H 1
+
+# define __KABI_BITS_PER_LONG 64
+# define __KABI_BITS_PER_LONG_SHIFT 6
+
+#endif /* not __KABI_ARCH_SPARC64_STDDEF_H */
diff --git a/include/kabi/arch-v850/stddef.h b/include/kabi/arch-v850/stddef.h
new file mode 100644
index 0000000..84328e5
--- /dev/null
+++ b/include/kabi/arch-v850/stddef.h
@@ -0,0 +1,7 @@
+#ifndef  __KABI_ARCH_V850_STDDEF_H
+# define __KABI_ARCH_V850_STDDEF_H 1
+
+# define __KABI_BITS_PER_LONG 32
+# define __KABI_BITS_PER_LONG_SHIFT 5
+
+#endif /* not __KABI_ARCH_V850_STDDEF_H */
diff --git a/include/kabi/arch-x86_64/stddef.h b/include/kabi/arch-x86_64/stddef.h
new file mode 100644
index 0000000..e20e620
--- /dev/null
+++ b/include/kabi/arch-x86_64/stddef.h
@@ -0,0 +1,7 @@
+#ifndef  __KABI_ARCH_X86_64_STDDEF_H
+# define __KABI_ARCH_X86_64_STDDEF_H 1
+
+# define __KABI_BITS_PER_LONG 64
+# define __KABI_BITS_PER_LONG_SHIFT 6
+
+#endif /* not __KABI_ARCH_X86_64_STDDEF_H */
diff --git a/include/kabi/arch-xtensa/stddef.h b/include/kabi/arch-xtensa/stddef.h
new file mode 100644
index 0000000..672c19f
--- /dev/null
+++ b/include/kabi/arch-xtensa/stddef.h
@@ -0,0 +1,7 @@
+#ifndef  __KABI_ARCH_XTENSA_STDDEF_H
+# define __KABI_ARCH_XTENSA_STDDEF_H 1
+
+# define __KABI_BITS_PER_LONG 32
+# define __KABI_BITS_PER_LONG_SHIFT 5
+
+#endif /* not __KABI_ARCH_XTENSA_STDDEF_H */
