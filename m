Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWGCVhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWGCVhW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 17:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbWGCVhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 17:37:21 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:6362 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750852AbWGCVhU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 17:37:20 -0400
Date: Mon, 3 Jul 2006 23:37:15 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@mars.ravnborg.org>
Subject: [PATCH] final pre -rc1 kbuild update
Message-ID: <20060703213715.GA14106@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

A few more kbuild goodies:
    kbuild: explicit turn off gcc stack-protector
    kbuild: introduce utsrelease.h

The stack-protector commit only adds the two -fno-stack-protector and
-fno-stack-protector-all flags to CFLAGS in top-level Makefile.

The utsrelease.h commit touches all present users of UTS_RELEASE.

Please pull from:
    git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git

	Sam

    kbuild: explicit turn off gcc stack-protector
    
    Ubuntu has enabled -fstack-protector per default in gcc
    breaking kernel build. Explicit turn it off for now.
    Later we may decide to make it configurable if the
    kernel starts to support it.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>


    kbuild: introduce utsrelease.h
    
    include/linux/version.h contained both actual KERNEL version
    and UTS_RELEASE that contains a subset from git SHA1 for when
    kernel was compiled as part of a git repository.
    This had the unfortunate side-effect that all files including version.h
    would be recompiled when some git changes was made due to changes SHA1.
    Split it out so we keep independent parts in separate files.
    
    Also update checkversion.pl script to no longer check for UTS_RELEASE.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Following is diffstat and shortlog for utsrelease.h commit only.

 Makefile                                       |   30 ++++++++++++++----------
 arch/alpha/boot/bootp.c                        |    2 +-
 arch/alpha/boot/bootpz.c                       |    2 +-
 arch/alpha/boot/main.c                         |    2 +-
 arch/frv/kernel/setup.c                        |    2 +-
 arch/i386/boot/setup.S                         |    2 +-
 arch/powerpc/platforms/chrp/setup.c            |    2 +-
 arch/powerpc/platforms/powermac/bootx_init.c   |    2 +-
 arch/ppc/syslib/btext.c                        |    2 +-
 arch/x86_64/boot/setup.S                       |    2 +-
 drivers/net/wireless/bcm43xx/bcm43xx_ethtool.c |    2 +-
 include/linux/vermagic.h                       |    2 +-
 init/version.c                                 |    1 +
 scripts/checkversion.pl                        |    7 ++----
 14 files changed, 33 insertions(+), 27 deletions(-)
commit 63104eec234bdecb55fd9c15467ae00d0a3f42ac
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Mon Jul 3 23:30:54 2006 +0200

    kbuild: introduce utsrelease.h
    
    include/linux/version.h contained both actual KERNEL version
    and UTS_RELEASE that contains a subset from git SHA1 for when
    kernel was compiled as part of a git repository.
    This had the unfortunate side-effect that all files including version.h
    would be recompiled when some git changes was made due to changes SHA1.
    Split it out so we keep independent parts in separate files.
    
    Also update checkversion.pl script to no longer check for UTS_RELEASE.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

diff --git a/Makefile b/Makefile
index 1cc793f..b36aeb6 100644
--- a/Makefile
+++ b/Makefile
@@ -812,8 +812,8 @@ endif
 # prepare2 creates a makefile if using a separate output directory
 prepare2: prepare3 outputmakefile
 
-prepare1: prepare2 include/linux/version.h include/asm \
-                   include/config/auto.conf
+prepare1: prepare2 include/linux/version.h include/linux/utsrelease.h \
+                   include/asm include/config/auto.conf
 ifneq ($(KBUILD_MODULES),)
 	$(Q)mkdir -p $(MODVERDIR)
 	$(Q)rm -f $(MODVERDIR)/*
@@ -848,21 +848,26 @@ # KERNELRELEASE can change from a few di
 # needs to be updated, so this check is forced on all builds
 
 uts_len := 64
+define filechk_utsrelease.h
+	if [ `echo -n "$(KERNELRELEASE)" | wc -c ` -gt $(uts_len) ]; then \
+	  echo '"$(KERNELRELEASE)" exceeds $(uts_len) characters' >&2;    \
+	  exit 1;                                                         \
+	fi;                                                               \
+	(echo \#define UTS_RELEASE \"$(KERNELRELEASE)\";)
+endef
 
 define filechk_version.h
-	if [ `echo -n "$(KERNELRELEASE)" | wc -c ` -gt $(uts_len) ]; then \
-	  echo '"$(KERNELRELEASE)" exceeds $(uts_len) characters' >&2; \
-	  exit 1; \
-	fi; \
-	(echo \#define UTS_RELEASE \"$(KERNELRELEASE)\"; \
-	  echo \#define LINUX_VERSION_CODE `expr $(VERSION) \\* 65536 + $(PATCHLEVEL) \\* 256 + $(SUBLEVEL)`; \
-	 echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))'; \
-	)
+	(echo \#define LINUX_VERSION_CODE $(shell                             \
+	expr $(VERSION) \* 65536 + $(PATCHLEVEL) \* 256 + $(SUBLEVEL));     \
+	echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))';)
 endef
 
-include/linux/version.h: $(srctree)/Makefile include/config/kernel.release FORCE
+include/linux/version.h: $(srctree)/Makefile FORCE
 	$(call filechk,version.h)
 
+include/linux/utsrelease.h: include/config/kernel.release FORCE
+	$(call filechk,utsrelease.h)
+
 # ---------------------------------------------------------------------------
 
 PHONY += depend dep
@@ -955,7 +960,8 @@ CLEAN_FILES +=	vmlinux System.map \
 # Directories & files removed with 'make mrproper'
 MRPROPER_DIRS  += include/config include2
 MRPROPER_FILES += .config .config.old include/asm .version .old_version \
-                  include/linux/autoconf.h include/linux/version.h \
+                  include/linux/autoconf.h include/linux/version.h      \
+                  include/linux/utsrelease.h                            \
 		  Module.symvers tags TAGS cscope*
 
 # clean - Delete most, but leave enough to build external modules
diff --git a/arch/alpha/boot/bootp.c b/arch/alpha/boot/bootp.c
index ec53c28..3af21c7 100644
--- a/arch/alpha/boot/bootp.c
+++ b/arch/alpha/boot/bootp.c
@@ -9,7 +9,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/string.h>
-#include <linux/version.h>
+#include <linux/utsrelease.h>
 #include <linux/mm.h>
 
 #include <asm/system.h>
diff --git a/arch/alpha/boot/bootpz.c b/arch/alpha/boot/bootpz.c
index a6657f2..4307bde 100644
--- a/arch/alpha/boot/bootpz.c
+++ b/arch/alpha/boot/bootpz.c
@@ -11,7 +11,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/string.h>
-#include <linux/version.h>
+#include <linux/utsrelease.h>
 #include <linux/mm.h>
 
 #include <asm/system.h>
diff --git a/arch/alpha/boot/main.c b/arch/alpha/boot/main.c
index 78c9b0b..90ed55b 100644
--- a/arch/alpha/boot/main.c
+++ b/arch/alpha/boot/main.c
@@ -7,7 +7,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/string.h>
-#include <linux/version.h>
+#include <linux/utsrelease.h>
 #include <linux/mm.h>
 
 #include <asm/system.h>
diff --git a/arch/frv/kernel/setup.c b/arch/frv/kernel/setup.c
index 5db3d4e..af08ccd 100644
--- a/arch/frv/kernel/setup.c
+++ b/arch/frv/kernel/setup.c
@@ -10,7 +10,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#include <linux/version.h>
+#include <linux/utsrelease.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
diff --git a/arch/i386/boot/setup.S b/arch/i386/boot/setup.S
index 0a5a3be..d2b684c 100644
--- a/arch/i386/boot/setup.S
+++ b/arch/i386/boot/setup.S
@@ -47,7 +47,7 @@
  */
 
 #include <asm/segment.h>
-#include <linux/version.h>
+#include <linux/utsrelease.h>
 #include <linux/compile.h>
 #include <asm/boot.h>
 #include <asm/e820.h>
diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index 1f1771b..9df9f20 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -24,7 +24,7 @@ #include <linux/interrupt.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/pci.h>
-#include <linux/version.h>
+#include <linux/utsrelease.h>
 #include <linux/adb.h>
 #include <linux/module.h>
 #include <linux/delay.h>
diff --git a/arch/powerpc/platforms/powermac/bootx_init.c b/arch/powerpc/platforms/powermac/bootx_init.c
index cb257ae..24f09e2 100644
--- a/arch/powerpc/platforms/powermac/bootx_init.c
+++ b/arch/powerpc/platforms/powermac/bootx_init.c
@@ -12,7 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/init.h>
-#include <linux/version.h>
+#include <linux/utsrelease.h>
 #include <asm/sections.h>
 #include <asm/prom.h>
 #include <asm/page.h>
diff --git a/arch/ppc/syslib/btext.c b/arch/ppc/syslib/btext.c
index 51ab6e9..d116670 100644
--- a/arch/ppc/syslib/btext.c
+++ b/arch/ppc/syslib/btext.c
@@ -6,7 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/init.h>
-#include <linux/version.h>
+#include <linux/utsrelease.h>
 
 #include <asm/sections.h>
 #include <asm/bootx.h>
diff --git a/arch/x86_64/boot/setup.S b/arch/x86_64/boot/setup.S
index 7de8b8f..a50b631 100644
--- a/arch/x86_64/boot/setup.S
+++ b/arch/x86_64/boot/setup.S
@@ -46,7 +46,7 @@
  */
 
 #include <asm/segment.h>
-#include <linux/version.h>
+#include <linux/utsrelease.h>
 #include <linux/compile.h>
 #include <asm/boot.h>
 #include <asm/e820.h>
diff --git a/drivers/net/wireless/bcm43xx/bcm43xx_ethtool.c b/drivers/net/wireless/bcm43xx/bcm43xx_ethtool.c
index b3ffcf5..e386dcc 100644
--- a/drivers/net/wireless/bcm43xx/bcm43xx_ethtool.c
+++ b/drivers/net/wireless/bcm43xx/bcm43xx_ethtool.c
@@ -32,7 +32,7 @@ #include "bcm43xx_ethtool.h"
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 #include <linux/string.h>
-#include <linux/version.h>
+#include <linux/utsrelease.h>
 
 
 static void bcm43xx_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
diff --git a/include/linux/vermagic.h b/include/linux/vermagic.h
index dc7c621..46919f9 100644
--- a/include/linux/vermagic.h
+++ b/include/linux/vermagic.h
@@ -1,4 +1,4 @@
-#include <linux/version.h>
+#include <linux/utsrelease.h>
 #include <linux/module.h>
 
 /* Simply sanity version stamp for modules. */
diff --git a/init/version.c b/init/version.c
index 3ddc3ce..e290802 100644
--- a/init/version.c
+++ b/init/version.c
@@ -10,6 +10,7 @@ #include <linux/compile.h>
 #include <linux/module.h>
 #include <linux/uts.h>
 #include <linux/utsname.h>
+#include <linux/utsrelease.h>
 #include <linux/version.h>
 
 #define version(a) Version_ ## a
diff --git a/scripts/checkversion.pl b/scripts/checkversion.pl
index 9f84e56..ec7d211 100755
--- a/scripts/checkversion.pl
+++ b/scripts/checkversion.pl
@@ -1,7 +1,7 @@
 #! /usr/bin/perl
 #
-# checkversion find uses of LINUX_VERSION_CODE, KERNEL_VERSION, or
-# UTS_RELEASE without including <linux/version.h>, or cases of
+# checkversion find uses of LINUX_VERSION_CODE or KERNEL_VERSION
+# without including <linux/version.h>, or cases of
 # including <linux/version.h> that don't need it.
 # Copyright (C) 2003, Randy Dunlap <rdunlap@xenotime.net>
 
@@ -41,8 +41,7 @@ foreach $file (@ARGV)
 	}
 
 	# Look for uses: LINUX_VERSION_CODE, KERNEL_VERSION, UTS_RELEASE
-	if (($_ =~ /LINUX_VERSION_CODE/) || ($_ =~ /\WKERNEL_VERSION/) ||
-		($_ =~ /UTS_RELEASE/)) {
+	if (($_ =~ /LINUX_VERSION_CODE/) || ($_ =~ /\WKERNEL_VERSION/)) {
 	    $fUseVersion = 1;
 	    last LINE if $iLinuxVersion;
 	}
