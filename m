Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317636AbSGFLvm>; Sat, 6 Jul 2002 07:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317637AbSGFLvl>; Sat, 6 Jul 2002 07:51:41 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:9993 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317636AbSGFLvh>;
	Sat, 6 Jul 2002 07:51:37 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [patch] 2.5.25 remove unnecessary recompiles when changing EXTRAVERSION
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 06 Jul 2002 21:53:58 +1000
Message-ID: <30028.1025956438@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux/version.h contains both the numeric part of the kernel
version and the full uts_release string.  version.h is included almost
everywhere, either on its own or via module.h.  module.h and modutils
only require the numeric kernel version, the use of UTS_RELEASE is
incorrect and causes significant recompiles when EXTRAVERSION changes.

This patch moves UTS_RELEASE into its own header which is explicitly
included in only the files that really use UTS_RELEASE.  module.h uses
a new field (KERNEL_VERSION_STRING) which has been added to version.h.
With this patch, a change to EXTRAVERSION no longer recompiles 95% of
your kernel.

The only significant changes are to module.h and Makefile.  The rest of
the patch is adding #include <linux/uts_release.h> in those files that
use UTS_RELEASE.  I suspect some of those files really only need
KERNEL_VERSION_STRING but that has been left as an exercise for the
file owners.  Some of those files may no longer required version.h,
again that has been left for the file owners.

Do not backport this change to 2.[024].  Their builds have incomplete
dependency trees, some changes to the top level Makefile only work as a
lucky side effect of the extra recompiles.

 include/linux/module.h                          |    2 +-
 Makefile                                        |   13 +++++++++----
 arch/alpha/boot/bootp.c                         |    1 +
 arch/alpha/boot/main.c                          |    1 +
 arch/i386/boot/setup.S                          |    1 +
 arch/ppc/kernel/btext.c                         |    1 +
 arch/ppc/platforms/chrp_setup.c                 |    1 +
 arch/ppc64/kernel/chrp_setup.c                  |    1 +
 arch/x86_64/boot/setup.S                        |    1 +
 drivers/block/floppy.c                          |    1 +
 drivers/cdrom/aztcd.c                           |    1 +
 drivers/cdrom/mcdx.c                            |    1 +
 drivers/char/ftape/compressor/zftape-compress.c |    1 +
 drivers/char/ftape/lowlevel/ftape-init.c        |    1 +
 drivers/char/ftape/zftape/zftape-init.c         |    1 +
 drivers/scsi/aic7xxx_old.c                      |    1 +
 drivers/scsi/megaraid.c                         |    1 +
 drivers/usb/core/hcd.c                          |    1 +
 include/asm-alpha/linux_logo.h                  |    1 +
 include/asm-arm/linux_logo.h                    |    1 +
 include/asm-i386/linux_logo.h                   |    1 +
 include/asm-ia64/linux_logo.h                   |    1 +
 include/asm-m68k/linux_logo.h                   |    1 +
 include/asm-mips/linux_logo_dec.h               |    1 +
 include/asm-mips/linux_logo_sgi.h               |    1 +
 include/asm-mips64/linux_logo.h                 |    1 +
 include/asm-parisc/linux_logo.h                 |    1 +
 include/asm-ppc/linux_logo.h                    |    1 +
 include/asm-ppc64/linux_logo.h                  |    1 +
 include/asm-sh/linux_logo.h                     |    1 +
 include/asm-sparc/linux_logo.h                  |    1 +
 include/asm-sparc64/linux_logo.h                |    1 +
 include/asm-x86_64/linux_logo.h                 |    1 +
 init/version.c                                  |    1 +
 sound/core/info.c                               |    1 +
 35 files changed, 43 insertions, 5 deletions

diff 25.1/include/linux/module.h
--- 25.1/include/linux/module.h
+++ 25.1/include/linux/module.h
@@ -285,7 +285,7 @@ extern struct module __this_module;
 
 #include <linux/version.h>
 static const char __module_kernel_version[] __attribute__((section(".modinfo"))) =
-"kernel_version=" UTS_RELEASE;
+"kernel_version=" KERNEL_VERSION_STRING;
 #ifdef CONFIG_MODVERSIONS
 static const char __module_using_checksums[] __attribute__((section(".modinfo"))) =
 "using_checksums=1";
diff 25.1/Makefile
--- 25.1/Makefile
+++ 25.1/Makefile
@@ -344,15 +344,20 @@ include/linux/autoconf.h: .config
 
 uts_len := 64
 
-include/linux/version.h: Makefile
+include/linux/uts_release.h: Makefile
+	@echo -n '  Generating $@'
 	@if expr length "$(KERNELRELEASE)" \> $(uts_len) >/dev/null ; then \
 	  echo '"$(KERNELRELEASE)" exceeds $(uts_len) characters' >&2; \
 	  exit 1; \
 	fi;
+	@(echo \#define UTS_RELEASE \"$(KERNELRELEASE)\";) > $@.tmp
+	@$(update-if-changed)
+
+include/linux/version.h: Makefile include/linux/uts_release.h
 	@echo -n '  Generating $@'
-	@(echo \#define UTS_RELEASE \"$(KERNELRELEASE)\"; \
-	  echo \#define LINUX_VERSION_CODE `expr $(VERSION) \\* 65536 + $(PATCHLEVEL) \\* 256 + $(SUBLEVEL)`; \
+	@(echo \#define LINUX_VERSION_CODE `expr $(VERSION) \\* 65536 + $(PATCHLEVEL) \\* 256 + $(SUBLEVEL)`; \
 	 echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))'; \
+	 echo '#define KERNEL_VERSION_STRING "$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)"'; \
 	) > $@.tmp
 	@$(update-if-changed)
 
@@ -611,7 +616,7 @@ CLEAN_FILES += \
 
 # 	files removed with 'make mrproper'
 MRPROPER_FILES += \
-	include/linux/autoconf.h include/linux/version.h \
+	include/linux/autoconf.h include/linux/version.h include/linux/uts_release.h \
 	drivers/net/hamradio/soundmodem/sm_tbl_{afsk1200,afsk2666,fsk9600}.h \
 	drivers/net/hamradio/soundmodem/sm_tbl_{hapn4800,psk4800}.h \
 	drivers/net/hamradio/soundmodem/sm_tbl_{afsk2400_7,afsk2400_8}.h \
diff 25.1/arch/alpha/boot/bootp.c
--- 25.1/arch/alpha/boot/bootp.c
+++ 25.1/arch/alpha/boot/bootp.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/version.h>
+#include <linux/uts_release.h>
 #include <linux/mm.h>
 
 #include <asm/system.h>
diff 25.1/arch/alpha/boot/main.c
--- 25.1/arch/alpha/boot/main.c
+++ 25.1/arch/alpha/boot/main.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/version.h>
+#include <linux/uts_release.h>
 #include <linux/mm.h>
 
 #include <asm/system.h>
diff 25.1/arch/i386/boot/setup.S
--- 25.1/arch/i386/boot/setup.S
+++ 25.1/arch/i386/boot/setup.S
@@ -50,6 +50,7 @@
 #include <linux/config.h>
 #include <asm/segment.h>
 #include <linux/version.h>
+#include <linux/uts_release.h>
 #include <linux/compile.h>
 #include <asm/boot.h>
 #include <asm/e820.h>
diff 25.1/arch/ppc/kernel/btext.c
--- 25.1/arch/ppc/kernel/btext.c
+++ 25.1/arch/ppc/kernel/btext.c
@@ -11,6 +11,7 @@
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/version.h>
+#include <linux/uts_release.h>
 
 #include <asm/sections.h>
 #include <asm/bootx.h>
diff 25.1/arch/ppc/platforms/chrp_setup.c
--- 25.1/arch/ppc/platforms/chrp_setup.c
+++ 25.1/arch/ppc/platforms/chrp_setup.c
@@ -31,6 +31,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/version.h>
+#include <linux/uts_release.h>
 #include <linux/adb.h>
 #include <linux/module.h>
 #include <linux/delay.h>
diff 25.1/arch/ppc64/kernel/chrp_setup.c
--- 25.1/arch/ppc64/kernel/chrp_setup.c
+++ 25.1/arch/ppc64/kernel/chrp_setup.c
@@ -37,6 +37,7 @@
 #include <linux/console.h>
 #include <linux/pci.h>
 #include <linux/version.h>
+#include <linux/uts_release.h>
 #include <linux/adb.h>
 #include <linux/module.h>
 #include <linux/delay.h>
diff 25.1/arch/x86_64/boot/setup.S
--- 25.1/arch/x86_64/boot/setup.S
+++ 25.1/arch/x86_64/boot/setup.S
@@ -47,6 +47,7 @@
 #include <linux/config.h>
 #include <asm/segment.h>
 #include <linux/version.h>
+#include <linux/uts_release.h>
 #include <linux/compile.h>
 #include <asm/boot.h>
 #include <asm/e820.h>
diff 25.1/drivers/block/floppy.c
--- 25.1/drivers/block/floppy.c
+++ 25.1/drivers/block/floppy.c
@@ -153,6 +153,7 @@ static int print_unex=1;
 #include <linux/tqueue.h>
 #define FDPATCHES
 #include <linux/fdreg.h>
+#include <linux/uts_release.h>
 
 /*
  * 1998/1/21 -- Richard Gooch <rgooch@atnf.csiro.au> -- devfs support
diff 25.1/drivers/cdrom/aztcd.c
--- 25.1/drivers/cdrom/aztcd.c
+++ 25.1/drivers/cdrom/aztcd.c
@@ -166,6 +166,7 @@
 */
 
 #include <linux/version.h>
+#include <linux/uts_release.h>
 
 #define MAJOR_NR AZTECH_CDROM_MAJOR
 #define DEVICE_NR(device) (minor(device))
diff 25.1/drivers/cdrom/mcdx.c
--- 25.1/drivers/cdrom/mcdx.c
+++ 25.1/drivers/cdrom/mcdx.c
@@ -57,6 +57,7 @@ static const char *mcdx_c_version
 #endif
 
 #include <linux/version.h>
+#include <linux/uts_release.h>
 #include <linux/module.h>
 
 #include <linux/errno.h>
diff 25.1/drivers/char/ftape/compressor/zftape-compress.c
--- 25.1/drivers/char/ftape/compressor/zftape-compress.c
+++ 25.1/drivers/char/ftape/compressor/zftape-compress.c
@@ -34,6 +34,7 @@
 #include <linux/errno.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/uts_release.h>
 
 #include <linux/zftape.h>
 
diff 25.1/drivers/char/ftape/lowlevel/ftape-init.c
--- 25.1/drivers/char/ftape/lowlevel/ftape-init.c
+++ 25.1/drivers/char/ftape/lowlevel/ftape-init.c
@@ -24,6 +24,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/version.h>
+#include <linux/uts_release.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
diff 25.1/drivers/char/ftape/zftape/zftape-init.c
--- 25.1/drivers/char/ftape/zftape/zftape-init.c
+++ 25.1/drivers/char/ftape/zftape/zftape-init.c
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/version.h>
+#include <linux/uts_release.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/signal.h>
diff 25.1/drivers/scsi/aic7xxx_old.c
--- 25.1/drivers/scsi/aic7xxx_old.c
+++ 25.1/drivers/scsi/aic7xxx_old.c
@@ -225,6 +225,7 @@
 #include <asm/irq.h>
 #include <asm/byteorder.h>
 #include <linux/version.h>
+#include <linux/uts_release.h>
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
diff 25.1/drivers/scsi/megaraid.c
--- 25.1/drivers/scsi/megaraid.c
+++ 25.1/drivers/scsi/megaraid.c
@@ -479,6 +479,7 @@
 
 #include <linux/config.h>
 #include <linux/version.h>
+#include <linux/uts_release.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/errno.h>
diff 25.1/drivers/usb/core/hcd.c
--- 25.1/drivers/usb/core/hcd.c
+++ 25.1/drivers/usb/core/hcd.c
@@ -25,6 +25,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/version.h>
+#include <linux/uts_release.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/completion.h>
diff 25.1/include/asm-alpha/linux_logo.h
--- 25.1/include/asm-alpha/linux_logo.h
+++ 25.1/include/asm-alpha/linux_logo.h
@@ -20,6 +20,7 @@
  
 #include <linux/init.h>
 #include <linux/version.h>
+#include <linux/uts_release.h>
 
 #define linux_logo_banner "Linux/AXP version " UTS_RELEASE
 
diff 25.1/include/asm-arm/linux_logo.h
--- 25.1/include/asm-arm/linux_logo.h
+++ 25.1/include/asm-arm/linux_logo.h
@@ -12,6 +12,7 @@
 
 #include <linux/init.h>
 #include <linux/version.h>
+#include <linux/uts_release.h>
 
 #define linux_logo_banner "ARM Linux version " UTS_RELEASE
 
diff 25.1/include/asm-i386/linux_logo.h
--- 25.1/include/asm-i386/linux_logo.h
+++ 25.1/include/asm-i386/linux_logo.h
@@ -20,6 +20,7 @@
  
 #include <linux/init.h>
 #include <linux/version.h>
+#include <linux/uts_release.h>
 
 #define linux_logo_banner "Linux/ia32 version " UTS_RELEASE
 
diff 25.1/include/asm-ia64/linux_logo.h
--- 25.1/include/asm-ia64/linux_logo.h
+++ 25.1/include/asm-ia64/linux_logo.h
@@ -21,6 +21,7 @@
  
 #include <linux/init.h>
 #include <linux/version.h>
+#include <linux/uts_release.h>
 
 #define linux_logo_banner "Linux/ia64 version " UTS_RELEASE
 
diff 25.1/include/asm-m68k/linux_logo.h
--- 25.1/include/asm-m68k/linux_logo.h
+++ 25.1/include/asm-m68k/linux_logo.h
@@ -21,6 +21,7 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/version.h>
+#include <linux/uts_release.h>
 
 #define linux_logo_banner "Linux/m68k version " UTS_RELEASE
 
diff 25.1/include/asm-mips/linux_logo_dec.h
--- 25.1/include/asm-mips/linux_logo_dec.h
+++ 25.1/include/asm-mips/linux_logo_dec.h
@@ -11,6 +11,7 @@
  
 #include <linux/init.h>
 #include <linux/version.h>
+#include <linux/uts_release.h>
 #include <linux/config.h>
 
 #define linux_logo_banner "Linux/MIPSel version " UTS_RELEASE
diff 25.1/include/asm-mips/linux_logo_sgi.h
--- 25.1/include/asm-mips/linux_logo_sgi.h
+++ 25.1/include/asm-mips/linux_logo_sgi.h
@@ -11,6 +11,7 @@
  
 #include <linux/init.h>
 #include <linux/version.h>
+#include <linux/uts_release.h>
 #include <linux/config.h>
 
 #define linux_logo_banner "Linux/MIPS version " UTS_RELEASE
diff 25.1/include/asm-mips64/linux_logo.h
--- 25.1/include/asm-mips64/linux_logo.h
+++ 25.1/include/asm-mips64/linux_logo.h
@@ -20,6 +20,7 @@
  
 #include <linux/init.h>
 #include <linux/version.h>
+#include <linux/uts_release.h>
 
 #define linux_logo_banner "Linux/MIPS64 version " UTS_RELEASE
 
diff 25.1/include/asm-parisc/linux_logo.h
--- 25.1/include/asm-parisc/linux_logo.h
+++ 25.1/include/asm-parisc/linux_logo.h
@@ -20,6 +20,7 @@
  
 #include <linux/init.h>
 #include <linux/version.h>
+#include <linux/uts_release.h>
 
 #define linux_logo_banner "Linux/PA-RISC version " UTS_RELEASE
 
diff 25.1/include/asm-ppc/linux_logo.h
--- 25.1/include/asm-ppc/linux_logo.h
+++ 25.1/include/asm-ppc/linux_logo.h
@@ -16,6 +16,7 @@
 #ifdef __KERNEL__
  
 #include <linux/init.h>
+#include <linux/uts_release.h>
 
 #define linux_logo_banner "Linux/PPC version " UTS_RELEASE
 
diff 25.1/include/asm-ppc64/linux_logo.h
--- 25.1/include/asm-ppc64/linux_logo.h
+++ 25.1/include/asm-ppc64/linux_logo.h
@@ -17,6 +17,7 @@
  */
  
 #include <linux/init.h>
+#include <linux/uts_release.h>
 
 #define linux_logo_banner "Linux/PPC-64 version " UTS_RELEASE
 
diff 25.1/include/asm-sh/linux_logo.h
--- 25.1/include/asm-sh/linux_logo.h
+++ 25.1/include/asm-sh/linux_logo.h
@@ -21,6 +21,7 @@
 
 #include <linux/init.h>
 #include <linux/version.h>
+#include <linux/uts_release.h>
 
 #define linux_logo_banner "Linux/SuperH version " UTS_RELEASE
 
diff 25.1/include/asm-sparc/linux_logo.h
--- 25.1/include/asm-sparc/linux_logo.h
+++ 25.1/include/asm-sparc/linux_logo.h
@@ -20,6 +20,7 @@
  
 #include <linux/init.h>
 #include <linux/version.h>
+#include <linux/uts_release.h>
 
 #define linux_logo_banner "Linux/SPARC version " UTS_RELEASE
 
diff 25.1/include/asm-sparc64/linux_logo.h
--- 25.1/include/asm-sparc64/linux_logo.h
+++ 25.1/include/asm-sparc64/linux_logo.h
@@ -20,6 +20,7 @@
  
 #include <linux/init.h>
 #include <linux/version.h>
+#include <linux/uts_release.h>
 
 #define linux_logo_banner "Linux/UltraSPARC version " UTS_RELEASE
 
diff 25.1/include/asm-x86_64/linux_logo.h
--- 25.1/include/asm-x86_64/linux_logo.h
+++ 25.1/include/asm-x86_64/linux_logo.h
@@ -20,6 +20,7 @@
  
 #include <linux/init.h>
 #include <linux/version.h>
+#include <linux/uts_release.h>
 
 /* We should create logo of penguin with a big hammer (-: --pavel */
 
diff 25.1/init/version.c
--- 25.1/init/version.c
+++ 25.1/init/version.c
@@ -10,6 +10,7 @@
 #include <linux/uts.h>
 #include <linux/utsname.h>
 #include <linux/version.h>
+#include <linux/uts_release.h>
 
 #define version(a) Version_ ## a
 #define version_string(a) version(a)
diff 25.1/sound/core/info.c
--- 25.1/sound/core/info.c
+++ 25.1/sound/core/info.c
@@ -29,6 +29,7 @@
 #include <sound/minors.h>
 #include <sound/info.h>
 #include <sound/version.h>
+#include <linux/uts_release.h>
 #include <linux/proc_fs.h>
 #ifdef CONFIG_DEVFS_FS
 #include <linux/devfs_fs_kernel.h>

