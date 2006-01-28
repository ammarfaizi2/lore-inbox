Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWA1V7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWA1V7q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 16:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWA1V7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 16:59:46 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:25092 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750769AbWA1V7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 16:59:46 -0500
Date: Sat, 28 Jan 2006 22:59:37 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: LKML <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH RFC] put UTS_RELEASE in separate utsversion.h file
Message-ID: <20060128215937.GA14442@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During the last few days I have been toying with a allmodconfig tree
and got irritated by all the extra modules being build over and over
again.
The root cause was the definition of UTS_RELEASE in version.h.
I had enabled automatic appending of git version and it changed each
time I committed something resulting in a lot of recompiling.
With the following patch the recompile is kept minimal, the most
annoying part being all the .mod.c files - but they actually use
UTS_RELEASE so this is avoidable.

I have not updated checkversion.pl - Randy can you do that?

I have not applied the patch yet - wanted some feedback from lkml first.
Only functional changes is in top-level makefile.
For all users of UTS_RELEASE I simple included utsversion.h.

Note: I do not know if any external stuff(*) uses UTS_RELEASE and expect it
to be in version.h!

(*) I here think of glibc, gcc, udev etc. External modules will have to cope
with this change like any in-kernel module

	Sam
	
diff --git a/Makefile b/Makefile
index ec7e24f..b5b9c25 100644
--- a/Makefile
+++ b/Makefile
@@ -842,20 +842,26 @@ include/config/MARKER: scripts/basic/spl
 
 uts_len := 64
 
-define filechk_version.h
+define filechk_utsversion.h
 	if [ `echo -n "$(KERNELRELEASE)" | wc -c ` -gt $(uts_len) ]; then \
-	  echo '"$(KERNELRELEASE)" exceeds $(uts_len) characters' >&2; \
-	  exit 1; \
-	fi; \
-	(echo \#define UTS_RELEASE \"$(KERNELRELEASE)\"; \
-	  echo \#define LINUX_VERSION_CODE `expr $(VERSION) \\* 65536 + $(PATCHLEVEL) \\* 256 + $(SUBLEVEL)`; \
-	 echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))'; \
-	)
+	  echo '"$(KERNELRELEASE)" exceeds $(uts_len) characters' >&2;    \
+	  exit 1;                                                         \
+	fi;                                                               \
+	(echo \#define UTS_RELEASE \"$(KERNELRELEASE)\";)
 endef
 
-include/linux/version.h: $(srctree)/Makefile .config FORCE
+define filechk_version.h
+	(echo \#define LINUX_VERSION_CODE $(shell                             \
+	expr $(VERSION) \* 65536 + $(PATCHLEVEL) \* 256 + $(SUBLEVEL));     \
+	echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))';)
+endef
+
+include/linux/version.h: .config include/linux/utsversion.h FORCE
 	$(call filechk,version.h)
 
+include/linux/utsversion.h: .config FORCE
+	$(call filechk,utsversion.h)
+
 # ---------------------------------------------------------------------------
 
 .PHONY: depend dep
diff --git a/arch/alpha/boot/bootp.c b/arch/alpha/boot/bootp.c
index ec53c28..b5580d9 100644
--- a/arch/alpha/boot/bootp.c
+++ b/arch/alpha/boot/bootp.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/version.h>
+#include <linux/utsversion.h>
 #include <linux/mm.h>
 
 #include <asm/system.h>
diff --git a/arch/alpha/boot/bootpz.c b/arch/alpha/boot/bootpz.c
index a6657f2..8d9a318 100644
--- a/arch/alpha/boot/bootpz.c
+++ b/arch/alpha/boot/bootpz.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/version.h>
+#include <linux/utsversion.h>
 #include <linux/mm.h>
 
 #include <asm/system.h>
diff --git a/arch/alpha/boot/main.c b/arch/alpha/boot/main.c
index 78c9b0b..25ce6b3 100644
--- a/arch/alpha/boot/main.c
+++ b/arch/alpha/boot/main.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/version.h>
+#include <linux/utsversion.h>
 #include <linux/mm.h>
 
 #include <asm/system.h>
diff --git a/arch/frv/kernel/setup.c b/arch/frv/kernel/setup.c
index 5908dea..92bf6ed 100644
--- a/arch/frv/kernel/setup.c
+++ b/arch/frv/kernel/setup.c
@@ -12,6 +12,7 @@
 
 #include <linux/config.h>
 #include <linux/version.h>
+#include <linux/utsversion.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
diff --git a/arch/i386/boot/setup.S b/arch/i386/boot/setup.S
index ca668d9..b7c289a 100644
--- a/arch/i386/boot/setup.S
+++ b/arch/i386/boot/setup.S
@@ -49,6 +49,7 @@
 #include <linux/config.h>
 #include <asm/segment.h>
 #include <linux/version.h>
+#include <linux/utsversion.h>
 #include <linux/compile.h>
 #include <asm/boot.h>
 #include <asm/e820.h>
diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index 2dc87aa..36a9996 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -28,6 +28,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/version.h>
+#include <linux/utsversion.h>
 #include <linux/adb.h>
 #include <linux/module.h>
 #include <linux/delay.h>
diff --git a/arch/powerpc/platforms/powermac/bootx_init.c b/arch/powerpc/platforms/powermac/bootx_init.c
index fa8b4d7..c8cd384 100644
--- a/arch/powerpc/platforms/powermac/bootx_init.c
+++ b/arch/powerpc/platforms/powermac/bootx_init.c
@@ -14,6 +14,7 @@
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/version.h>
+#include <linux/utsversion.h>
 #include <asm/sections.h>
 #include <asm/prom.h>
 #include <asm/page.h>
diff --git a/arch/ppc/platforms/chrp_setup.c b/arch/ppc/platforms/chrp_setup.c
index 48996b7..fc4ad8e 100644
--- a/arch/ppc/platforms/chrp_setup.c
+++ b/arch/ppc/platforms/chrp_setup.c
@@ -28,6 +28,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/version.h>
+#include <linux/utsversion.h>
 #include <linux/adb.h>
 #include <linux/module.h>
 #include <linux/delay.h>
diff --git a/arch/ppc/syslib/btext.c b/arch/ppc/syslib/btext.c
index 12fa83e..b40fd33 100644
--- a/arch/ppc/syslib/btext.c
+++ b/arch/ppc/syslib/btext.c
@@ -8,6 +8,7 @@
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/version.h>
+#include <linux/utsversion.h>
 
 #include <asm/sections.h>
 #include <asm/bootx.h>
diff --git a/arch/x86_64/boot/setup.S b/arch/x86_64/boot/setup.S
index 12ea0b6..b8ace49 100644
--- a/arch/x86_64/boot/setup.S
+++ b/arch/x86_64/boot/setup.S
@@ -48,6 +48,7 @@
 #include <linux/config.h>
 #include <asm/segment.h>
 #include <linux/version.h>
+#include <linux/utsversion.h>
 #include <linux/compile.h>
 #include <asm/boot.h>
 #include <asm/e820.h>
diff --git a/include/linux/vermagic.h b/include/linux/vermagic.h
index fadc535..fa91e0d 100644
--- a/include/linux/vermagic.h
+++ b/include/linux/vermagic.h
@@ -1,4 +1,5 @@
 #include <linux/version.h>
+#include <linux/utsversion.h>
 #include <linux/module.h>
 
 /* Simply sanity version stamp for modules. */
diff --git a/init/version.c b/init/version.c
index 3ddc3ce..fa2a300 100644
--- a/init/version.c
+++ b/init/version.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/uts.h>
 #include <linux/utsname.h>
+#include <linux/utsversion.h>
 #include <linux/version.h>
 
 #define version(a) Version_ ## a
