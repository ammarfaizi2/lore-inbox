Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269379AbTCDLUc>; Tue, 4 Mar 2003 06:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269380AbTCDLUc>; Tue, 4 Mar 2003 06:20:32 -0500
Received: from badne3.ux.his.no ([152.94.1.63]:55018 "EHLO badne3.ux.his.no")
	by vger.kernel.org with ESMTP id <S269379AbTCDLU1>;
	Tue, 4 Mar 2003 06:20:27 -0500
Date: Tue, 4 Mar 2003 12:30:54 +0100
From: Erlend Aasland <erlend-a@ux.his.no>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5][RFC] Make mconf inform user about supported make targets
Message-ID: <20030304113054.GA29401@badne3.ux.his.no>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Scenario: I do a make menuconfig on my sparc64 machine. When mconf exits, it
tells me "Next, you may run 'make bzImage', 'make bzdisk', or 'make install'."

Problem: These are i386-specific targets. Issuing a "make help", I see
that {vmlinux{,.aout},tftpboot.img} are the sparc64-specific targets.

Solution: Get mconf to tell the user about arch-specific targets,
instead of i386 targets.

So, here is a trivial patch that change scripts/kconfig/Makefile and
scripts/kconfig/mconf.c. Small changes are also needed in most of the
arch/*/Makefiles. I've attached patches for all arch's that define
archhelp.

(I'm not shure if this is the easiest way to accomplish this, but
I've tested it (on sparc64) and it seems to work ok)

Patches are against 2.5.63.


Erlend Aasland


diff -urN linux-2.5.63/scripts/kconfig/Makefile linux-2.5.63-conf/scripts/kconfig/Makefile
--- linux-2.5.63/scripts/kconfig/Makefile	Mon Feb 17 22:57:19 2003
+++ linux-2.5.63-conf/scripts/kconfig/Makefile	Fri Feb 21 15:35:26 2003
@@ -19,7 +19,7 @@
 qconf-cxxobjs	:= qconf.o
 
 clean-files	:= libkconfig.so lkc_defs.h qconf.moc .tmp_qtcheck \
-		   zconf.tab.c zconf.tab.h lex.zconf.c
+		   zconf.tab.c zconf.tab.h lex.zconf.c arch.h
 
 # generated files seem to need this to find local include files
 HOSTCFLAGS_lex.zconf.o	:= -I$(src)
@@ -28,6 +28,8 @@
 HOSTLOADLIBES_qconf	= -L$(QTDIR)/lib -Wl,-rpath,$(QTDIR)/lib -l$(QTLIB) -ldl
 HOSTCXXFLAGS_qconf.o	= -I$(QTDIR)/include 
 
+$(obj)/mconf.o: $(src)/arch.h
+
 $(obj)/conf.o $(obj)/mconf.o $(obj)/qconf.o: $(obj)/zconf.tab.h
 
 $(obj)/qconf.o: $(obj)/.tmp_qtcheck
@@ -91,3 +93,24 @@
 	flex -P$(notdir $*) -o$@ $<
 
 endif
+
+include arch/$(ARCH)/Makefile
+
+ifndef generate_kconfig_arch.h
+define generate_kconfig_arch.h
+  (echo "#ifndef ARCH_H"; \
+   echo "#define ARCH_H"; \
+   echo ""; \
+   echo "/*"; \
+   echo " * This file was automatically generated"; \
+   echo " *"; \
+   echo ""; \
+   echo 'static const char arch_maketargets[] = "";'; \
+   echo '";'; \
+   echo ""; \
+   echo "#endif";
+endef
+endif
+
+$(src)/arch.h:
+	@$(generate_kconfig_arch.h) > $(src)/arch.h
diff -urN linux-2.5.63/scripts/kconfig/mconf.c linux-2.5.63-conf/scripts/kconfig/mconf.c
--- linux-2.5.63/scripts/kconfig/mconf.c	Mon Feb 17 22:56:02 2003
+++ linux-2.5.63-conf/scripts/kconfig/mconf.c	Fri Feb 21 15:35:26 2003
@@ -19,6 +19,7 @@
 #include <termios.h>
 #include <unistd.h>
 
+#include "arch.h"
 #define LKC_DIRECT_LINK
 #include "lkc.h"
 
@@ -772,7 +773,7 @@
 		printf("\n\n"
 			"*** End of Linux kernel configuration.\n"
 			"*** Check the top-level Makefile for additional configuration.\n"
-			"*** Next, you may run 'make bzImage', 'make bzdisk', or 'make install'.\n\n");
+			"*** Next, you may run %s 'make modules', 'make vmlinux' or 'make all'.\n\n", arch_maketargets);
 	} else
 		printf("\n\nYour kernel configuration changes were NOT saved.\n\n");
 

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="make-alpha.patch"

--- linux-2.5.63/arch/alpha/Makefile	Mon Feb 17 22:56:20 2003
+++ linux-2.5.63-conf/arch/alpha/Makefile	Fri Feb 21 15:52:42 2003
@@ -134,3 +134,17 @@
   echo '  bootimage	- SRM bootable image (arch/alpha/boot/bootimage)'
   echo '  bootpfile	- BOOTP bootable image (arch/alpha/boot/bootpfile)'
 endef
+
+define generate_kconfig_arch.h
+( echo "#ifndef ARCH_H"; \
+  echo "#define ARCH_H"; \
+  echo "/*"; \
+  echo " * This file was automatically generated"; \
+  echo " */"; \
+  echo ""; \
+  echo -n 'static const char arch_maketargets[] = "'; \
+  echo -n "\\'make boot\\', \\'make bootimage\\', \\'make bootpfile\\',"; \
+  echo '";'; \
+  echo ""; \
+  echo "#endif"; )
+endef

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="make-arm.patch"

--- linux-2.5.63/arch/arm/Makefile	Mon Feb 17 22:56:11 2003
+++ linux-2.5.63-conf/arch/arm/Makefile	Fri Feb 21 16:00:12 2003
@@ -226,3 +226,18 @@
   echo  '                  (distribution) /sbin/installkernel or'
   echo  '                  install to $$(INSTALL_PATH) and run lilo'
 endef
+
+define generate_kconfig_arch.h
+( echo "#ifndef ARCH_H"; \
+  echo "#define ARCH_H"; \
+  echo "/*"; \
+  echo " * This file was automatically generated"; \
+  echo " */"; \
+  echo ""; \
+  echo -n 'static const char arch_maketargets[] = "'; \
+  echo -n "\\'make zImage\\', \\'make Image\\', \\'make bootpImage\\', \\'make initrd\\',\n"; \
+  echo -n "\\'make install\\', \\'make zinstall\\',"; \
+  echo '";'; \
+  echo ""; \
+  echo "#endif"; )
+endef

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="make-i386.patch"

--- linux-2.5.63/arch/i386/Makefile	Mon Feb 17 22:56:11 2003
+++ linux-2.5.63-conf/arch/i386/Makefile	Fri Feb 21 15:50:45 2003
@@ -124,3 +124,16 @@
   echo  '		   install to $$(INSTALL_PATH) and run lilo'
 endef
 
+define generate_kconfig_arch.h
+( echo "#ifndef ARCH_H"; \
+  echo "#define ARCH_H"; \
+  echo "/*"; \
+  echo " * This file was automatically generated"; \
+  echo " */"; \
+  echo ""; \
+  echo -n 'static const char arch_maketargets[] = "'; \
+  echo -n "\\'make bzImage\\', \\'make install\\',"; \
+  echo '";'; \
+  echo ""; \
+  echo "#endif"; )
+endef

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="make-ia64.patch"

--- linux-2.5.63/arch/ia64/Makefile	Mon Feb 17 22:55:50 2003
+++ linux-2.5.63-conf/arch/ia64/Makefile	Fri Feb 21 15:54:11 2003
@@ -91,3 +91,17 @@
   echo '  compressed	- Build compressed kernel image'
   echo '  boot		- Build vmlinux and bootloader for Ski simulator'
 endef
+
+define generate_kconfig_arch.h
+( echo "#ifndef ARCH_H"; \
+  echo "#define ARCH_H"; \
+  echo "/*"; \
+  echo " * This file was automatically generated"; \
+  echo " */"; \
+  echo ""; \
+  echo -n 'static const char arch_maketargets[] = "'; \
+  echo -n "\\'make compressed\\', \\'make boot\\',"; \
+  echo '";'; \
+  echo ""; \
+  echo "#endif"; )
+endef

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="make-parisc.patch"

--- linux-2.5.63/arch/parisc/Makefile	Mon Feb 17 22:56:56 2003
+++ linux-2.5.63-conf/arch/parisc/Makefile	Fri Feb 21 16:00:57 2003
@@ -102,3 +102,17 @@
 	@echo  '* vmlinux	- Uncompressed kernel image (./vmlinux)'
 	@echo  '  palo		- Bootable image (./lifimage)'
 endef
+
+define generate_kconfig_arch.h
+( echo "#ifndef ARCH_H"; \
+  echo "#define ARCH_H"; \
+  echo "/*"; \
+  echo " * This file was automatically generated"; \
+  echo " */"; \
+  echo ""; \
+  echo -n 'static const char arch_maketargets[] = "'; \
+  echo -n "\\'make palo\\',"; \
+  echo '";'; \
+  echo ""; \
+  echo "#endif"; )
+endef

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="make-sparc64.patch"

--- linux-2.5.63/arch/sparc64/Makefile	Mon Feb 17 22:57:18 2003
+++ linux-2.5.63-conf/arch/sparc64/Makefile	Fri Feb 21 15:46:35 2003
@@ -80,3 +80,16 @@
   echo  '  tftpboot.img  - Image prepared for tftp'
 endef

+define generate_kconfig_arch.h
+( echo "#ifndef ARCH_H"; \
+  echo "#define ARCH_H"; \
+  echo "/*"; \
+  echo " * This file was automatically generated"; \
+  echo " */"; \
+  echo ""; \
+  echo -n 'static const char arch_maketargets[] = "'; \
+  echo -n "\\'make vmlinux.aout\\', \\'make tftpboot.img\\',"; \
+  echo '";'; \
+  echo ""; \
+  echo "#endif"; )
+endef

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="make-x86_64.patch"

--- linux-2.5.63/arch/x86_64/Makefile	Mon Feb 17 22:56:54 2003
+++ linux-2.5.63-conf/arch/x86_64/Makefile	Fri Feb 21 16:02:00 2003
@@ -106,4 +106,16 @@
 
 CLEAN_FILES += arch/$(ARCH)/boot/fdimage arch/$(ARCH)/boot/mtools.conf
 
-
+define generate_kconfig_arch.h
+( echo "#ifndef ARCH_H"; \
+  echo "#define ARCH_H"; \
+  echo "/*"; \
+  echo " * This file was automatically generated"; \
+  echo " */"; \
+  echo ""; \
+  echo -n 'static const char arch_maketargets[] = "'; \
+  echo -n "\\'make bzImage\\', \\'make install\\',"; \
+  echo '";'; \
+  echo ""; \
+  echo "#endif"; )
+endef

--LZvS9be/3tNcYl/X--
