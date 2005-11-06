Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbVKFKP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbVKFKP0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 05:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbVKFKP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 05:15:26 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:32902 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S932348AbVKFKPZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 05:15:25 -0500
Date: Sun, 6 Nov 2005 11:18:45 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: davej@redhat.com, thang@redhat.com, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel@vger.kernel.org,
       Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH] kbuild updates
Message-ID: <20051106101844.GA11921@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus - please apply.

A patch to introduce -imacros to include autoconf.h, so we
no longer rely on everyone to include config.h.

And a fix for make xconfig for fedora.

Pull from:
master.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git

diffstat and patches included below for information.

	Sam


Russell King:
      kbuild: permanently fix kernel configuration include mess

Sam Ravnborg:
      kconfig: fix xconfig on fedora 2 & 3 (x86_64)

 Makefile                 |    8 ++------
 include/linux/config.h   |    4 +++-
 scripts/kconfig/Makefile |   15 ++++++++++-----
 3 files changed, 15 insertions(+), 12 deletions(-)

[PATCH] kbuild: permanently fix kernel configuration include mess

Include autoconf.h into every kernel compilation via the gcc command line
using -imacros.  This ensures that we have the kernel configuration
included from the start, rather than relying on each file having #include
<linux/config.h> as appropriate.  History has shown that this is something
which is difficult to get right.

Since we now include the kernel configuration automatically, make
configcheck becomes meaningless, so remove it.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---
commit 2dd34b488a99135ad2a529e33087ddd6a09e992a
tree 785b06eabfea3fdebf571b1e2b8a1ea695974416
parent f912696ab330bf539231d1f8032320f2a08b850f
author Russell King <rmk+lkml@arm.linux.org.uk> Sun, 30 Oct 2005 22:42:11 +0100
committer Sam Ravnborg <sam@mars.ravnborg.org> Sun, 06 Nov 2005 10:22:04 +0100

 Makefile               |    8 ++------
 include/linux/config.h |    4 +++-
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 7960132..2dac801 100644
--- a/Makefile
+++ b/Makefile
@@ -346,7 +346,8 @@ AFLAGS_KERNEL	=
 # Use LINUXINCLUDE when you must reference the include/ directory.
 # Needed to be compatible with the O= option
 LINUXINCLUDE    := -Iinclude \
-                   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include)
+                   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include) \
+		   -imacros include/linux/autoconf.h
 
 CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 
@@ -1249,11 +1250,6 @@ tags: FORCE
 # Scripts to check various things for consistency
 # ---------------------------------------------------------------------------
 
-configcheck:
-	find * $(RCS_FIND_IGNORE) \
-		-name '*.[hcS]' -type f -print | sort \
-		| xargs $(PERL) -w scripts/checkconfig.pl
-
 includecheck:
 	find * $(RCS_FIND_IGNORE) \
 		-name '*.[hcS]' -type f -print | sort \
diff --git a/include/linux/config.h b/include/linux/config.h
index 9d1c14f..a91f5e5 100644
--- a/include/linux/config.h
+++ b/include/linux/config.h
@@ -1,6 +1,8 @@
 #ifndef _LINUX_CONFIG_H
 #define _LINUX_CONFIG_H
-
+/* This file is no longer in use and kept only for backward compatibility.
+ * autoconf.h is now included via -imacros on the commandline
+ */
 #include <linux/autoconf.h>
 
 #endif

kconfig: fix xconfig on fedora 2 & 3 (x86_64)

From: Than Ngo <than@redhat.com>
qt as installed on fedora core (2 and 3) does not work with vanilla
kernel. The linker fails to locate the qt lib:

Actual Results:  # make xconfig
  HOSTLD  scripts/kconfig/qconf
  /usr/bin/ld: cannot find -lqt
  collect2: ld returned 1 exit status

Than Ngo has provided following fix for the bug.

Cc: Than Ngo <than@redhat.com>
Acked-by: Dave Jones <davej@redhat.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---
commit ab919c06144cfb11c05b5b5cd291daa96ac2e423
tree 8747dc3122c0c2ebefaf004a2d71e2cb7bd97615
parent 2dd34b488a99135ad2a529e33087ddd6a09e992a
author Sam Ravnborg <sam@mars.ravnborg.org> Sun, 06 Nov 2005 11:05:21 +0100
committer Sam Ravnborg <sam@mars.ravnborg.org> Sun, 06 Nov 2005 11:05:21 +0100

 scripts/kconfig/Makefile |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 0dd9691..455aeab 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -129,7 +129,7 @@ endif
 HOSTCFLAGS_lex.zconf.o	:= -I$(src)
 HOSTCFLAGS_zconf.tab.o	:= -I$(src)
 
-HOSTLOADLIBES_qconf	= -L$(QTLIBPATH) -Wl,-rpath,$(QTLIBPATH) -l$(QTLIB) -ldl
+HOSTLOADLIBES_qconf	= -L$(QTLIBPATH) -Wl,-rpath,$(QTLIBPATH) -l$(LIBS_QT) -ldl
 HOSTCXXFLAGS_qconf.o	= -I$(QTDIR)/include -D LKC_DIRECT_LINK
 
 HOSTLOADLIBES_gconf	= `pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --libs`
@@ -163,11 +163,16 @@ $(obj)/.tmp_qtcheck:
 	  false; \
 	fi; \
 	LIBPATH=$$DIR/lib; LIB=qt; \
-	$(HOSTCXX) -print-multi-os-directory > /dev/null 2>&1 && \
-	  LIBPATH=$$DIR/lib/$$($(HOSTCXX) -print-multi-os-directory); \
-	if [ -f $$LIBPATH/libqt-mt.so ]; then LIB=qt-mt; fi; \
+	if [ -f $$QTLIB/libqt-mt.so ] ; then \
+		LIB=qt-mt; \
+		LIBPATH=$$QTLIB; \
+	else \
+		$(HOSTCXX) -print-multi-os-directory > /dev/null 2>&1 && \
+		LIBPATH=$$DIR/lib/$$($(HOSTCXX) -print-multi-os-directory); \
+		if [ -f $$LIBPATH/libqt-mt.so ]; then LIB=qt-mt; fi; \
+	fi; \
 	echo "QTDIR=$$DIR" > $@; echo "QTLIBPATH=$$LIBPATH" >> $@; \
-	echo "QTLIB=$$LIB" >> $@; \
+	echo "LIBS_QT=$$LIB" >> $@; \
 	if [ ! -x $$DIR/bin/moc -a -x /usr/bin/moc ]; then \
 	  echo "*"; \
 	  echo "* Unable to find $$DIR/bin/moc, using /usr/bin/moc instead."; \
