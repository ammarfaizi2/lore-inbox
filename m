Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275987AbRJGKZv>; Sun, 7 Oct 2001 06:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275989AbRJGKZn>; Sun, 7 Oct 2001 06:25:43 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:32785 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S275987AbRJGKZ0>;
	Sun, 7 Oct 2001 06:25:26 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.11-pre4 remove spurious kernel recompiles
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 07 Oct 2001 20:25:42 +1000
Message-ID: <23246.1002450342@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel build dependency chain currently goes
  Makefile ->
    include/linux/version.h ->
      340 sources and 66 .h files
The 66 .h files in turn infect almost every source, including anything
that includes module.h.  The result is that changing a single character
in the top level Makefile forces a recompile of the entire kernel, for
no good reason.

The second problem is that version.h contains both UTS_RELEASE and
LINUX_VERSION_CODE.  Changing the EXTRAVERSION field affects
UTS_RELEASE and again forces a massive recompile via version.h.  This
is completely spurious, there are only 30 files that really care about
the full UTS_RELEASE field.

This patch removes the dependency on the top level Makefile and
seperates UTS_RELEASE from LINUX_VERSION_CODE.  Changing the top level
Makefile no longer forces a complete recompile.  Changing EXTRAVERSION
only affects a few files.  Changing VERSION, PATCHLEVEL or SUBLEVEL
still does a major recompile, no way around that because of the number
of places that test LINUX_VERSION_CODE and modules that need the kernel
version string.

Note: This patch is not to be merged into Linus or AC trees yet, it
      needs review first.

Index: 11-pre4.1/Makefile
--- 11-pre4.1/Makefile Fri, 05 Oct 2001 15:05:09 +1000 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15.1.2.2.25.2.2.1.17.1.4.1.29 644)
+++ 11-pre4.1(w)/Makefile Sun, 07 Oct 2001 20:18:20 +1000 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15.1.2.2.25.2.2.1.17.1.4.1.29 644)
@@ -212,7 +212,7 @@ CLEAN_DIRS = \
 
 # files removed with 'make mrproper'
 MRPROPER_FILES = \
-	include/linux/autoconf.h include/linux/version.h \
+	include/linux/autoconf.h include/linux/version.h include/linux/uts_release.h \
 	drivers/net/hamradio/soundmodem/sm_tbl_{afsk1200,afsk2666,fsk9600}.h \
 	drivers/net/hamradio/soundmodem/sm_tbl_{hapn4800,psk4800}.h \
 	drivers/net/hamradio/soundmodem/sm_tbl_{afsk2400_7,afsk2400_8}.h \
@@ -255,7 +255,7 @@ Version: dummy
 boot: vmlinux
 	@$(MAKE) CFLAGS="$(CFLAGS) $(CFLAGS_KERNEL)" -C arch/$(ARCH)/boot
 
-vmlinux: include/linux/version.h $(CONFIGURATION) init/main.o init/version.o linuxsubdirs
+vmlinux: include/linux/version.h include/linux/uts_release.h $(CONFIGURATION) init/main.o init/version.o linuxsubdirs
 	$(LD) $(LINKFLAGS) $(HEAD) init/main.o init/version.o \
 		--start-group \
 		$(CORE_FILES) \
@@ -280,7 +280,7 @@ xconfig: symlinks
 	$(MAKE) -C scripts kconfig.tk
 	wish -f scripts/kconfig.tk
 
-menuconfig: include/linux/version.h symlinks
+menuconfig: symlinks
 	$(MAKE) -C scripts/lxdialog all
 	$(CONFIG_SHELL) scripts/Menuconfig arch/$(ARCH)/config.in
 
@@ -293,16 +293,17 @@ include/config/MARKER: scripts/split-inc
 
 linuxsubdirs: $(patsubst %, _dir_%, $(SUBDIRS))
 
-$(patsubst %, _dir_%, $(SUBDIRS)) : dummy include/linux/version.h include/config/MARKER
+$(patsubst %, _dir_%, $(SUBDIRS)) : dummy include/linux/version.h include/linux/uts_release.h include/config/MARKER
 	$(MAKE) CFLAGS="$(CFLAGS) $(CFLAGS_KERNEL)" -C $(patsubst _dir_%, %, $@)
 
 $(TOPDIR)/include/linux/version.h: include/linux/version.h
+$(TOPDIR)/include/linux/uts_release.h: include/linux/uts_release.h
 $(TOPDIR)/include/linux/compile.h: include/linux/compile.h
 
 newversion:
 	. scripts/mkversion > .version
 
-include/linux/compile.h: $(CONFIGURATION) include/linux/version.h newversion
+include/linux/compile.h: $(CONFIGURATION) include/linux/version.h include/linux/uts_release.h newversion
 	@echo -n \#define UTS_VERSION \"\#`cat .version` > .ver
 	@if [ -n "$(CONFIG_SMP)" ] ; then echo -n " SMP" >> .ver; fi
 	@if [ -f .name ]; then  echo -n \-`cat .name` >> .ver; fi
@@ -320,11 +321,17 @@ include/linux/compile.h: $(CONFIGURATION
 	@echo \#define LINUX_COMPILER \"`$(CC) $(CFLAGS) -v 2>&1 | tail -1`\" >> .ver
 	@mv -f .ver $@
 
-include/linux/version.h: ./Makefile
-	@echo \#define UTS_RELEASE \"$(KERNELRELEASE)\" > .ver
-	@echo \#define LINUX_VERSION_CODE `expr $(VERSION) \\* 65536 + $(PATCHLEVEL) \\* 256 + $(SUBLEVEL)` >> .ver
+include/linux/version.h: dummy
+	@rm -f .ver
+	@echo \#define LINUX_VERSION_CODE `expr $(VERSION) \\* 65536 + $(PATCHLEVEL) \\* 256 + $(SUBLEVEL)` > .ver
+	@echo \#define LINUX_VERSION_STRING \"$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)\" >> .ver
 	@echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))' >>.ver
-	@mv -f .ver $@
+	@cmp -s .ver $@ && rm .ver || mv -f .ver $@
+
+include/linux/uts_release.h: dummy
+	@rm -f .uts
+	@echo \#define UTS_RELEASE \"$(KERNELRELEASE)\" > .uts
+	@cmp -s .uts $@ && rm .uts || mv -f .uts $@
 
 init/version.o: init/version.c include/linux/compile.h include/config/MARKER
 	$(CC) $(CFLAGS) $(CFLAGS_KERNEL) -DUTS_MACHINE='"$(ARCH)"' -c -o init/version.o init/version.c
@@ -356,7 +363,7 @@ endif
 modules: $(patsubst %, _mod_%, $(SUBDIRS))
 
 .PHONY: $(patsubst %, _mod_%, $(SUBDIRS))
-$(patsubst %, _mod_%, $(SUBDIRS)) : include/linux/version.h include/config/MARKER
+$(patsubst %, _mod_%, $(SUBDIRS)) : include/linux/version.h include/linux/uts_release.h include/config/MARKER
 	$(MAKE) -C $(patsubst _mod_%, %, $@) CFLAGS="$(CFLAGS) $(MODFLAGS)" MAKING_MODULES=1 modules
 
 .PHONY: modules_install
@@ -449,7 +456,7 @@ htmldocs: sgmldocs
 sums:
 	find . -type f -print | sort | xargs sum > .SUMS
 
-dep-files: scripts/mkdep archdep include/linux/version.h
+dep-files: scripts/mkdep archdep include/linux/version.h include/linux/uts_release.h
 	scripts/mkdep -- init/*.c > .depend
 	scripts/mkdep -- `find $(FINDHPATH) -name SCCS -prune -o -follow -name \*.h ! -name modversions.h -print` > .hdepend
 	$(MAKE) $(patsubst %,_sfdep_%,$(SUBDIRS)) _FASTDEP_ALL_SUB_DIRS="$(SUBDIRS)"
Index: 11-pre4.1/init/version.c
--- 11-pre4.1/init/version.c Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/k/10_version.c 1.1 644)
+++ 11-pre4.1(w)/init/version.c Sun, 07 Oct 2001 19:33:49 +1000 kaos (linux-2.4/k/10_version.c 1.1 644)
@@ -9,6 +9,7 @@
 #include <linux/uts.h>
 #include <linux/utsname.h>
 #include <linux/version.h>
+#include <linux/uts_release.h>
 #include <linux/compile.h>
 
 #define version(a) Version_ ## a
Index: 11-pre4.1/include/asm-parisc/linux_logo.h
--- 11-pre4.1/include/asm-parisc/linux_logo.h Sat, 09 Jun 2001 11:25:53 +1000 kaos (linux-2.4/l/18_linux_logo 1.1.2.1 644)
+++ 11-pre4.1(w)/include/asm-parisc/linux_logo.h Sun, 07 Oct 2001 19:33:52 +1000 kaos (linux-2.4/l/18_linux_logo 1.1.2.1 644)
@@ -19,7 +19,7 @@
  */
  
 #include <linux/init.h>
-#include <linux/version.h>
+#include <linux/uts_release.h>
 
 #define linux_logo_banner "Linux/PA-RISC version " UTS_RELEASE
 
Index: 11-pre4.1/include/asm-mips64/linux_logo.h
--- 11-pre4.1/include/asm-mips64/linux_logo.h Mon, 10 Sep 2001 15:46:51 +1000 kaos (linux-2.4/p/29_linux_logo 1.1.2.1.1.1 644)
+++ 11-pre4.1(w)/include/asm-mips64/linux_logo.h Sun, 07 Oct 2001 19:33:55 +1000 kaos (linux-2.4/p/29_linux_logo 1.1.2.1.1.1 644)
@@ -19,7 +19,7 @@
  */
  
 #include <linux/init.h>
-#include <linux/version.h>
+#include <linux/uts_release.h>
 
 #define linux_logo_banner "Linux/MIPS64 version " UTS_RELEASE
 
Index: 11-pre4.1/include/asm-ia64/linux_logo.h
--- 11-pre4.1/include/asm-ia64/linux_logo.h Sat, 09 Jun 2001 11:25:53 +1000 kaos (linux-2.4/t/18_linux_logo 1.1.2.1 644)
+++ 11-pre4.1(w)/include/asm-ia64/linux_logo.h Sun, 07 Oct 2001 19:33:57 +1000 kaos (linux-2.4/t/18_linux_logo 1.1.2.1 644)
@@ -20,7 +20,7 @@
  */
  
 #include <linux/init.h>
-#include <linux/version.h>
+#include <linux/uts_release.h>
 
 #define linux_logo_banner "Linux/ia64 version " UTS_RELEASE
 
Index: 11-pre4.1/include/asm-sh/linux_logo.h
--- 11-pre4.1/include/asm-sh/linux_logo.h Sun, 09 Sep 2001 19:22:07 +1000 kaos (linux-2.4/u/37_linux_logo 1.1.2.2 644)
+++ 11-pre4.1(w)/include/asm-sh/linux_logo.h Sun, 07 Oct 2001 19:33:59 +1000 kaos (linux-2.4/u/37_linux_logo 1.1.2.2 644)
@@ -20,7 +20,7 @@
  */
 
 #include <linux/init.h>
-#include <linux/version.h>
+#include <linux/uts_release.h>
 
 #define linux_logo_banner "Linux/SuperH version " UTS_RELEASE
 
Index: 11-pre4.1/include/asm-arm/linux_logo.h
--- 11-pre4.1/include/asm-arm/linux_logo.h Sat, 09 Jun 2001 11:25:53 +1000 kaos (linux-2.4/z/42_linux_logo 1.2.1.1 644)
+++ 11-pre4.1(w)/include/asm-arm/linux_logo.h Sun, 07 Oct 2001 19:34:02 +1000 kaos (linux-2.4/z/42_linux_logo 1.2.1.1 644)
@@ -11,7 +11,7 @@
  */
 
 #include <linux/init.h>
-#include <linux/version.h>
+#include <linux/uts_release.h>
 
 #define linux_logo_banner "ARM Linux version " UTS_RELEASE
 
Index: 11-pre4.1/include/asm-sparc64/linux_logo.h
--- 11-pre4.1/include/asm-sparc64/linux_logo.h Sat, 09 Jun 2001 11:25:53 +1000 kaos (linux-2.4/C/49_linux_logo 1.1.2.1 644)
+++ 11-pre4.1(w)/include/asm-sparc64/linux_logo.h Sun, 07 Oct 2001 19:34:04 +1000 kaos (linux-2.4/C/49_linux_logo 1.1.2.1 644)
@@ -19,7 +19,7 @@
  */
  
 #include <linux/init.h>
-#include <linux/version.h>
+#include <linux/uts_release.h>
 
 #define linux_logo_banner "Linux/UltraSPARC version " UTS_RELEASE
 
Index: 11-pre4.1/include/asm-ppc/linux_logo.h
--- 11-pre4.1/include/asm-ppc/linux_logo.h Sat, 09 Jun 2001 11:25:53 +1000 kaos (linux-2.4/F/46_linux_logo 1.2.1.2 644)
+++ 11-pre4.1(w)/include/asm-ppc/linux_logo.h Sun, 07 Oct 2001 19:34:58 +1000 kaos (linux-2.4/F/46_linux_logo 1.2.1.2 644)
@@ -16,6 +16,7 @@
 #ifdef __KERNEL__
  
 #include <linux/init.h>
+#include <linux/uts_release.h>
 
 #define linux_logo_banner "Linux/PPC version " UTS_RELEASE
 
Index: 11-pre4.1/include/asm-sparc/linux_logo.h
--- 11-pre4.1/include/asm-sparc/linux_logo.h Sat, 09 Jun 2001 11:25:53 +1000 kaos (linux-2.4/J/34_linux_logo 1.1.2.1 644)
+++ 11-pre4.1(w)/include/asm-sparc/linux_logo.h Sun, 07 Oct 2001 19:35:01 +1000 kaos (linux-2.4/J/34_linux_logo 1.1.2.1 644)
@@ -19,7 +19,7 @@
  */
  
 #include <linux/init.h>
-#include <linux/version.h>
+#include <linux/uts_release.h>
 
 #define linux_logo_banner "Linux/SPARC version " UTS_RELEASE
 
Index: 11-pre4.1/include/asm-m68k/linux_logo.h
--- 11-pre4.1/include/asm-m68k/linux_logo.h Wed, 13 Jun 2001 12:08:44 +1000 kaos (linux-2.4/O/14_linux_logo 1.1.2.2 644)
+++ 11-pre4.1(w)/include/asm-m68k/linux_logo.h Sun, 07 Oct 2001 19:35:03 +1000 kaos (linux-2.4/O/14_linux_logo 1.1.2.2 644)
@@ -20,7 +20,7 @@
  
 #include <linux/config.h>
 #include <linux/init.h>
-#include <linux/version.h>
+#include <linux/uts_release.h>
 
 #define linux_logo_banner "Linux/m68k version " UTS_RELEASE
 
Index: 11-pre4.1/include/asm-alpha/linux_logo.h
--- 11-pre4.1/include/asm-alpha/linux_logo.h Sat, 09 Jun 2001 11:25:53 +1000 kaos (linux-2.4/P/2_linux_logo 1.1.2.1 644)
+++ 11-pre4.1(w)/include/asm-alpha/linux_logo.h Sun, 07 Oct 2001 19:35:08 +1000 kaos (linux-2.4/P/2_linux_logo 1.1.2.1 644)
@@ -19,7 +19,7 @@
  */
  
 #include <linux/init.h>
-#include <linux/version.h>
+#include <linux/uts_release.h>
 
 #define linux_logo_banner "Linux/AXP version " UTS_RELEASE
 
Index: 11-pre4.1/include/asm-i386/linux_logo.h
--- 11-pre4.1/include/asm-i386/linux_logo.h Sat, 09 Jun 2001 11:25:53 +1000 kaos (linux-2.4/T/44_linux_logo 1.1.2.1 644)
+++ 11-pre4.1(w)/include/asm-i386/linux_logo.h Sun, 07 Oct 2001 19:35:26 +1000 kaos (linux-2.4/T/44_linux_logo 1.1.2.1 644)
@@ -19,7 +19,7 @@
  */
  
 #include <linux/init.h>
-#include <linux/version.h>
+#include <linux/uts_release.h>
 
 #define linux_logo_banner "Linux/ia32 version " UTS_RELEASE
 
Index: 11-pre4.1/include/linux/module.h
--- 11-pre4.1/include/linux/module.h Thu, 04 Oct 2001 16:23:36 +1000 kaos (linux-2.4/c/b/46_module.h 1.1.1.1.2.5 644)
+++ 11-pre4.1(w)/include/linux/module.h Sun, 07 Oct 2001 19:47:04 +1000 kaos (linux-2.4/c/b/46_module.h 1.1.1.1.2.5 644)
@@ -298,7 +298,7 @@ extern struct module __this_module;
 
 #include <linux/version.h>
 static const char __module_kernel_version[] __attribute__((section(".modinfo"))) =
-"kernel_version=" UTS_RELEASE;
+"kernel_version=" LINUX_VERSION_STRING;
 #ifdef MODVERSIONS
 static const char __module_using_checksums[] __attribute__((section(".modinfo"))) =
 "using_checksums=1";
Index: 11-pre4.1/drivers/cdrom/mcdx.c
--- 11-pre4.1/drivers/cdrom/mcdx.c Sat, 08 Sep 2001 14:40:18 +1000 kaos (linux-2.4/L/b/23_mcdx.c 1.3.1.1 644)
+++ 11-pre4.1(w)/drivers/cdrom/mcdx.c Sun, 07 Oct 2001 19:35:35 +1000 kaos (linux-2.4/L/b/23_mcdx.c 1.3.1.1 644)
@@ -56,7 +56,7 @@ static const char *mcdx_c_version
     = "$Id$";
 #endif
 
-#include <linux/version.h>
+#include <linux/uts_release.h>
 #include <linux/module.h>
 
 #include <linux/errno.h>
Index: 11-pre4.1/drivers/cdrom/aztcd.c
--- 11-pre4.1/drivers/cdrom/aztcd.c Mon, 10 Sep 2001 15:46:51 +1000 kaos (linux-2.4/L/b/28_aztcd.c 1.1.1.2 644)
+++ 11-pre4.1(w)/drivers/cdrom/aztcd.c Sun, 07 Oct 2001 19:35:38 +1000 kaos (linux-2.4/L/b/28_aztcd.c 1.1.1.2 644)
@@ -165,7 +165,7 @@
 			 Torben Mathiasen <tmm@image.dk>
 */
 
-#include <linux/version.h>
+#include <linux/uts_release.h>
 
 #define MAJOR_NR AZTECH_CDROM_MAJOR
 
Index: 11-pre4.1/drivers/scsi/megaraid.c
--- 11-pre4.1/drivers/scsi/megaraid.c Tue, 02 Oct 2001 11:04:33 +1000 kaos (linux-2.4/Q/b/35_megaraid.c 1.2.1.5.1.3.1.3 644)
+++ 11-pre4.1(w)/drivers/scsi/megaraid.c Sun, 07 Oct 2001 19:37:54 +1000 kaos (linux-2.4/Q/b/35_megaraid.c 1.2.1.5.1.3.1.3 644)
@@ -452,6 +452,7 @@
 
 #include <linux/config.h>
 #include <linux/version.h>
+#include <linux/uts_release.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/errno.h>
Index: 11-pre4.1/drivers/char/ftape/zftape/zftape-init.c
--- 11-pre4.1/drivers/char/ftape/zftape/zftape-init.c Fri, 14 Sep 2001 12:20:01 +1000 kaos (linux-2.4/Z/b/49_zftape-ini 1.2.1.1 644)
+++ 11-pre4.1(w)/drivers/char/ftape/zftape/zftape-init.c Sun, 07 Oct 2001 19:39:24 +1000 kaos (linux-2.4/Z/b/49_zftape-ini 1.2.1.1 644)
@@ -23,7 +23,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/errno.h>
-#include <linux/version.h>
+#include <linux/uts_release.h>
 #include <linux/fs.h>
 #include <asm/segment.h>
 #include <linux/kernel.h>
Index: 11-pre4.1/drivers/char/ftape/lowlevel/ftape-init.c
--- 11-pre4.1/drivers/char/ftape/lowlevel/ftape-init.c Fri, 14 Sep 2001 12:20:01 +1000 kaos (linux-2.4/a/c/39_ftape-init 1.1.1.1 644)
+++ 11-pre4.1(w)/drivers/char/ftape/lowlevel/ftape-init.c Sun, 07 Oct 2001 19:39:27 +1000 kaos (linux-2.4/a/c/39_ftape-init 1.1.1.1 644)
@@ -24,6 +24,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/version.h>
+#include <linux/uts_release.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
Index: 11-pre4.1/drivers/char/ftape/compressor/zftape-compress.c
--- 11-pre4.1/drivers/char/ftape/compressor/zftape-compress.c Fri, 14 Sep 2001 12:20:01 +1000 kaos (linux-2.4/a/c/42_zftape-com 1.1.1.1 644)
+++ 11-pre4.1(w)/drivers/char/ftape/compressor/zftape-compress.c Sun, 07 Oct 2001 19:39:29 +1000 kaos (linux-2.4/a/c/42_zftape-com 1.1.1.1 644)
@@ -34,6 +34,7 @@
 #include <linux/errno.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/uts_release.h>
 
 #include <linux/zftape.h>
 
Index: 11-pre4.1/drivers/block/floppy.c
--- 11-pre4.1/drivers/block/floppy.c Tue, 11 Sep 2001 11:19:14 +1000 kaos (linux-2.4/c/c/40_floppy.c 1.2.1.1.1.2 644)
+++ 11-pre4.1(w)/drivers/block/floppy.c Sun, 07 Oct 2001 19:39:36 +1000 kaos (linux-2.4/c/c/40_floppy.c 1.2.1.1.1.2 644)
@@ -147,6 +147,7 @@ static int print_unex=1;
 #include <linux/tqueue.h>
 #define FDPATCHES
 #include <linux/fdreg.h>
+#include <linux/uts_release.h>
 
 /*
  * 1998/1/21 -- Richard Gooch <rgooch@atnf.csiro.au> -- devfs support
Index: 11-pre4.1/arch/ppc/kernel/chrp_setup.c
--- 11-pre4.1/arch/ppc/kernel/chrp_setup.c Sun, 09 Sep 2001 19:22:07 +1000 kaos (linux-2.4/I/c/36_chrp_setup 1.3.1.2.1.5.1.3 644)
+++ 11-pre4.1(w)/arch/ppc/kernel/chrp_setup.c Sun, 07 Oct 2001 19:39:43 +1000 kaos (linux-2.4/I/c/36_chrp_setup 1.3.1.2.1.5.1.3 644)
@@ -33,7 +33,7 @@
 #include <linux/ioport.h>
 #include <linux/console.h>
 #include <linux/pci.h>
-#include <linux/version.h>
+#include <linux/uts_release.h>
 #include <linux/adb.h>
 #include <linux/module.h>
 #include <linux/delay.h>
Index: 11-pre4.1/arch/alpha/boot/bootp.c
--- 11-pre4.1/arch/alpha/boot/bootp.c Fri, 05 Oct 2001 15:05:09 +1000 kaos (linux-2.4/R/c/26_bootp.c 1.2 644)
+++ 11-pre4.1(w)/arch/alpha/boot/bootp.c Sun, 07 Oct 2001 19:40:18 +1000 kaos (linux-2.4/R/c/26_bootp.c 1.2 644)
@@ -9,7 +9,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/string.h>
-#include <linux/version.h>
+#include <linux/uts_release.h>
 #include <linux/mm.h>
 
 #include <asm/system.h>
Index: 11-pre4.1/arch/alpha/boot/main.c
--- 11-pre4.1/arch/alpha/boot/main.c Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/R/c/30_main.c 1.1 644)
+++ 11-pre4.1(w)/arch/alpha/boot/main.c Sun, 07 Oct 2001 19:40:21 +1000 kaos (linux-2.4/R/c/30_main.c 1.1 644)
@@ -7,7 +7,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/string.h>
-#include <linux/version.h>
+#include <linux/uts_release.h>
 #include <linux/mm.h>
 
 #include <asm/system.h>
Index: 11-pre4.1/arch/i386/boot/setup.S
--- 11-pre4.1/arch/i386/boot/setup.S Tue, 07 Aug 2001 18:58:36 +1000 kaos (linux-2.4/T/c/45_setup.S 1.1.1.3.1.1 644)
+++ 11-pre4.1(w)/arch/i386/boot/setup.S Sun, 07 Oct 2001 19:40:25 +1000 kaos (linux-2.4/T/c/45_setup.S 1.1.1.3.1.1 644)
@@ -46,7 +46,7 @@
 
 #include <linux/config.h>
 #include <asm/segment.h>
-#include <linux/version.h>
+#include <linux/uts_release.h>
 #include <linux/compile.h>
 #include <asm/boot.h>
 #include <asm/e820.h>
Index: 11-pre4.1/drivers/s390/block/xpram.c
--- 11-pre4.1/drivers/s390/block/xpram.c Tue, 11 Sep 2001 11:19:14 +1000 kaos (linux-2.4/q/d/42_xpram.c 1.2.1.3 644)
+++ 11-pre4.1(w)/drivers/s390/block/xpram.c Sun, 07 Oct 2001 19:35:32 +1000 kaos (linux-2.4/q/d/42_xpram.c 1.2.1.3 644)
@@ -57,6 +57,7 @@
 
 #include <linux/module.h>
 #include <linux/version.h>
+#include <linux/uts_release.h>
 
 #ifdef MODULE
 char kernel_version [] = UTS_RELEASE; 
Index: 11-pre4.1/drivers/scsi/aic7xxx_old.c
--- 11-pre4.1/drivers/scsi/aic7xxx_old.c Tue, 02 Oct 2001 11:04:33 +1000 kaos (linux-2.4/y/d/26_aic7xxx_ol 1.9 644)
+++ 11-pre4.1(w)/drivers/scsi/aic7xxx_old.c Sun, 07 Oct 2001 19:39:12 +1000 kaos (linux-2.4/y/d/26_aic7xxx_ol 1.9 644)
@@ -232,6 +232,7 @@
 #include <asm/irq.h>
 #include <asm/byteorder.h>
 #include <linux/version.h>
+#include <linux/uts_release.h>
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
Index: 11-pre4.1/arch/ppc/kernel/btext.c
--- 11-pre4.1/arch/ppc/kernel/btext.c Sun, 09 Sep 2001 19:22:07 +1000 kaos (linux-2.4/h/f/32_btext.c 1.2 644)
+++ 11-pre4.1(w)/arch/ppc/kernel/btext.c Sun, 07 Oct 2001 19:39:46 +1000 kaos (linux-2.4/h/f/32_btext.c 1.2 644)
@@ -10,7 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/init.h>
-#include <linux/version.h>
+#include <linux/uts_release.h>
 
 #include <asm/sections.h>
 #include <asm/bootx.h>
Index: 11-pre4.1/include/asm-mips/linux_logo_sgi.h
--- 11-pre4.1/include/asm-mips/linux_logo_sgi.h Mon, 10 Sep 2001 15:46:51 +1000 kaos (linux-2.4/m/f/1_linux_logo 1.1 644)
+++ 11-pre4.1(w)/include/asm-mips/linux_logo_sgi.h Sun, 07 Oct 2001 19:35:12 +1000 kaos (linux-2.4/m/f/1_linux_logo 1.1 644)
@@ -10,7 +10,7 @@
  */
  
 #include <linux/init.h>
-#include <linux/version.h>
+#include <linux/uts_release.h>
 #include <linux/config.h>
 
 #define linux_logo_banner "Linux/MIPS version " UTS_RELEASE
Index: 11-pre4.1/include/asm-mips/linux_logo_dec.h
--- 11-pre4.1/include/asm-mips/linux_logo_dec.h Mon, 10 Sep 2001 15:46:51 +1000 kaos (linux-2.4/m/f/2_linux_logo 1.1 644)
+++ 11-pre4.1(w)/include/asm-mips/linux_logo_dec.h Sun, 07 Oct 2001 19:35:23 +1000 kaos (linux-2.4/m/f/2_linux_logo 1.1 644)
@@ -10,7 +10,7 @@
  */
  
 #include <linux/init.h>
-#include <linux/version.h>
+#include <linux/uts_release.h>
 #include <linux/config.h>
 
 #define linux_logo_banner "Linux/MIPSel version " UTS_RELEASE

