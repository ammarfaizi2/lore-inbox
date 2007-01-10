Return-Path: <linux-kernel-owner+w=401wt.eu-S932785AbXAJNpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932785AbXAJNpz (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 08:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932810AbXAJNpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 08:45:55 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:53746 "EHLO scrub.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932785AbXAJNpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 08:45:54 -0500
Date: Wed, 10 Jan 2007 14:45:28 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Jean Delvare <khali@linux-fr.org>
cc: Andrey Borzenkov <arvidjaar@mail.ru>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andy Whitcroft <apw@shadowen.org>,
       Herbert Poetzl <herbert@13thfloor.at>, Olaf Hering <olaf@aepfle.de>
Subject: Re: .version keeps being updated
In-Reply-To: <20070109214421.281ff564.khali@linux-fr.org>
Message-ID: <Pine.LNX.4.64.0701101426400.14458@scrub.home>
References: <20070109102057.c684cc78.khali@linux-fr.org>
 <20070109170550.AFEF460C343@tzec.mtu.ru> <20070109214421.281ff564.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 9 Jan 2007, Jean Delvare wrote:

> I tried a git bisect to find out what commit was reponsible for it, and
> the winner is...
> 
> 8993780a6e44fb4e7ed34e33458506a775356c6e is first bad commit
> commit 8993780a6e44fb4e7ed34e33458506a775356c6e
> Author: Linus Torvalds <torvalds@woody.osdl.org>
> Date:   Mon Dec 11 09:28:46 2006 -0800
> 
> [..]
> Reverting this from 2.6.20-rc1 made the build behave again, however I
> found that reverting it from 2.6.20-rc2 did _not_ fix the problem. I
> also had to revert the following patch to make things work as before
> again:
> 
> commit ef129412b4cbd6686d0749612cb9b76e207271f4
> Author: Andrew Morton <akpm@osdl.org>
> Date:   Fri Dec 22 01:12:01 2006 -0800

To make the list complete, this patch started all the mess:

commit a2ee8649ba6d71416712e798276bf7c40b64e6e5
Author: Herbert Poetzl <herbert@13thfloor.at>
Date:   Fri Dec 8 02:36:00 2006 -0800

    [PATCH] Fix linux banner utsname information

and this tries to fix a problem in Andrew's patch:

commit d449db98d5d7d90f29f9f6e091b0e1d996184df1
Author: Mikael Pettersson <mikpe@it.uu.se>
Date:   Fri Dec 29 16:48:09 2006 -0800

    [PATCH] fix mrproper incompleteness

The patch below reverts pretty much everything and instead introduces a 
seperate format string for proc.

bye, Roman



[PATCH] fix linux banner format string

Revert previous attempts at messing with the linux banner string and 
simply use a separate format string for proc.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---
 Makefile               |   31 +++++++++----------------------
 fs/proc/proc_misc.c    |    8 +-------
 include/linux/kernel.h |    3 +++
 init/Makefile          |   10 +++++++++-
 init/main.c            |    8 --------
 init/version.c         |   10 ++++++++++
 6 files changed, 32 insertions(+), 38 deletions(-)

Index: linux-2.6-git/fs/proc/proc_misc.c
===================================================================
--- linux-2.6-git.orig/fs/proc/proc_misc.c	2007-01-10 04:27:23.000000000 +0100
+++ linux-2.6-git/fs/proc/proc_misc.c	2007-01-10 04:33:01.000000000 +0100
@@ -47,7 +47,6 @@
 #include <linux/vmalloc.h>
 #include <linux/crash_dump.h>
 #include <linux/pid_namespace.h>
-#include <linux/compile.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
@@ -254,12 +253,7 @@ static int version_read_proc(char *page,
 {
 	int len;
 
-	/* FIXED STRING! Don't touch! */
-	len = snprintf(page, PAGE_SIZE,
-		"%s version %s"
-		" (" LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ")"
-		" (" LINUX_COMPILER ")"
-		" %s\n",
+	len = snprintf(page, PAGE_SIZE, linux_proc_banner,
 		utsname()->sysname,
 		utsname()->release,
 		utsname()->version);
Index: linux-2.6-git/include/linux/kernel.h
===================================================================
--- linux-2.6-git.orig/include/linux/kernel.h	2007-01-10 04:26:37.000000000 +0100
+++ linux-2.6-git/include/linux/kernel.h	2007-01-10 04:27:05.000000000 +0100
@@ -17,6 +17,9 @@
 #include <asm/byteorder.h>
 #include <asm/bug.h>
 
+extern const char linux_banner[];
+extern const char linux_proc_banner[];
+
 #define INT_MAX		((int)(~0U>>1))
 #define INT_MIN		(-INT_MAX - 1)
 #define UINT_MAX	(~0U)
Index: linux-2.6-git/init/main.c
===================================================================
--- linux-2.6-git.orig/init/main.c	2007-01-10 04:34:02.000000000 +0100
+++ linux-2.6-git/init/main.c	2007-01-10 14:20:02.000000000 +0100
@@ -50,9 +50,7 @@
 #include <linux/buffer_head.h>
 #include <linux/debug_locks.h>
 #include <linux/lockdep.h>
-#include <linux/utsrelease.h>
 #include <linux/pid_namespace.h>
-#include <linux/compile.h>
 #include <linux/device.h>
 
 #include <asm/io.h>
@@ -482,12 +480,6 @@ void __init __attribute__((weak)) smp_se
 {
 }
 
-static const char linux_banner[] =
-	"Linux version " UTS_RELEASE
-	" (" LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ")"
-	" (" LINUX_COMPILER ")"
-	" " UTS_VERSION "\n";
-
 asmlinkage void __init start_kernel(void)
 {
 	char * command_line;
Index: linux-2.6-git/init/version.c
===================================================================
--- linux-2.6-git.orig/init/version.c	2007-01-10 04:29:20.000000000 +0100
+++ linux-2.6-git/init/version.c	2007-01-10 04:41:11.000000000 +0100
@@ -33,3 +33,13 @@ struct uts_namespace init_uts_ns = {
 	},
 };
 EXPORT_SYMBOL_GPL(init_uts_ns);
+
+/* FIXED STRING! Don't touch! */
+const char __init linux_banner[] =
+	"Linux version " UTS_RELEASE " (" LINUX_COMPILE_BY "@"
+	LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION "\n";
+
+const char linux_proc_banner[] =
+	"%s version %s"
+	" (" LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ")"
+	" (" LINUX_COMPILER ") %s\n";
Index: linux-2.6-git/init/Makefile
===================================================================
--- linux-2.6-git.orig/init/Makefile	2007-01-10 04:44:59.000000000 +0100
+++ linux-2.6-git/init/Makefile	2007-01-10 14:06:15.000000000 +0100
@@ -15,6 +15,14 @@ clean-files := ../include/linux/compile.
 
 # dependencies on generated files need to be listed explicitly
 
-$(obj)/main.o: include/linux/compile.h
 $(obj)/version.o: include/linux/compile.h
 
+# compile.h changes depending on hostname, generation number, etc,
+# so we regenerate it always.
+# mkcompile_h will make sure to only update the
+# actual file if its content has changed.
+
+include/linux/compile.h: FORCE
+	@echo '  CHK     $@'
+	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkcompile_h $@ \
+	"$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CONFIG_PREEMPT)" "$(CC) $(CFLAGS)"
Index: linux-2.6-git/Makefile
===================================================================
--- linux-2.6-git.orig/Makefile	2007-01-10 14:01:24.000000000 +0100
+++ linux-2.6-git/Makefile	2007-01-10 14:06:15.000000000 +0100
@@ -368,14 +368,10 @@ endif
 # Detect when mixed targets is specified, and make a second invocation
 # of make so .config is not included in this case either (for *config).
 
-PHONY += generated_headers
-
-generated_headers: include/linux/version.h include/linux/compile.h \
-		include/linux/utsrelease.h
-
-no-dot-config-targets := generated_headers clean mrproper distclean \
+no-dot-config-targets := clean mrproper distclean \
 			 cscope TAGS tags help %docs check% \
-			 headers_% kernelrelease kernelversion
+			 include/linux/version.h headers_% \
+			 kernelrelease kernelversion
 
 config-targets := 0
 mixed-targets  := 0
@@ -738,16 +734,6 @@ debug_kallsyms: .tmp_map$(last_kallsyms)
 
 endif # ifdef CONFIG_KALLSYMS
 
-# compile.h changes depending on hostname, generation number, etc,
-# so we regenerate it always.
-# mkcompile_h will make sure to only update the
-# actual file if its content has changed.
-
-include/linux/compile.h: FORCE
-	@echo '  CHK     $@'
-	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkcompile_h $@ \
-	"$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CONFIG_PREEMPT)" "$(CC) $(CFLAGS)"
-
 # vmlinux image - including updated kernel symbols
 vmlinux: $(vmlinux-lds) $(vmlinux-init) $(vmlinux-main) $(kallsyms.o) FORCE
 ifdef CONFIG_HEADERS_CHECK
@@ -866,8 +852,8 @@ endif
 # prepare2 creates a makefile if using a separate output directory
 prepare2: prepare3 outputmakefile
 
-prepare1: prepare2 generated_headers include/asm include/config/auto.conf
-
+prepare1: prepare2 include/linux/version.h include/linux/utsrelease.h \
+                   include/asm include/config/auto.conf
 ifneq ($(KBUILD_MODULES),)
 	$(Q)mkdir -p $(MODVERDIR)
 	$(Q)rm -f $(MODVERDIR)/*
@@ -936,14 +922,14 @@ export INSTALL_HDR_PATH
 HDRARCHES=$(filter-out generic,$(patsubst $(srctree)/include/asm-%/Kbuild,%,$(wildcard $(srctree)/include/asm-*/Kbuild)))
 
 PHONY += headers_install_all
-headers_install_all: generated_headers scripts_basic FORCE
+headers_install_all: include/linux/version.h scripts_basic FORCE
 	$(Q)$(MAKE) $(build)=scripts scripts/unifdef
 	$(Q)for arch in $(HDRARCHES); do \
 	 $(MAKE) ARCH=$$arch -f $(srctree)/scripts/Makefile.headersinst obj=include BIASMDIR=-bi-$$arch ;\
 	 done
 
 PHONY += headers_install
-headers_install: generated_headers scripts_basic FORCE
+headers_install: include/linux/version.h scripts_basic FORCE
 	@if [ ! -r $(srctree)/include/asm-$(ARCH)/Kbuild ]; then \
 	  echo '*** Error: Headers not exportable for this architecture ($(ARCH))'; \
 	  exit 1 ; fi
@@ -1040,7 +1026,8 @@ CLEAN_FILES +=	vmlinux System.map \
 # Directories & files removed with 'make mrproper'
 MRPROPER_DIRS  += include/config include2 usr/include
 MRPROPER_FILES += .config .config.old include/asm .version .old_version \
-                  include/linux/autoconf.h include/linux/utsrelease.h include/linux/version.h \
+                  include/linux/autoconf.h include/linux/version.h      \
+                  include/linux/utsrelease.h                            \
 		  Module.symvers tags TAGS cscope*
 
 # clean - Delete most, but leave enough to build external modules
