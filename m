Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288146AbSACCk3>; Wed, 2 Jan 2002 21:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288145AbSACCkS>; Wed, 2 Jan 2002 21:40:18 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:38810 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S288146AbSACCkI>;
	Wed, 2 Jan 2002 21:40:08 -0500
Date: Thu, 3 Jan 2002 03:39:56 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200201030239.DAA21812@harpo.it.uu.se>
To: alan@lxorguk.ukuu.org.uk
Subject: [PATCH] 2.2.21pre CONFIG_MODVERSIONS make rules update
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

Here's a backport of the 2.4 CONFIG_MODVERSIONS make rules for
2.2.21pre. This is needed on fast boxes since 'make dep' can update
modversions.h at sub-second intervals, and this breaks make's
'st_mtime'-based dependency checking. (Without this patch, it's
basically impossible to build 2.2.20 with modversions on my P4,
due to incomplete expansion of symbol versions.)

/Mikael

diff -ruN linux-2.2.21pre2/Makefile linux-2.2.21pre2.modver-2.4-backport/Makefile
--- linux-2.2.21pre2/Makefile	Wed Jan  2 14:01:50 2002
+++ linux-2.2.21pre2.modver-2.4-backport/Makefile	Wed Jan  2 14:11:07 2002
@@ -445,6 +445,9 @@
 #	set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i fastdep ;done
 # let this be made through the fastdep rule in Rules.make
 	$(MAKE) $(patsubst %,_sfdep_%,$(SUBDIRS)) _FASTDEP_ALL_SUB_DIRS="$(SUBDIRS)"
+ifdef CONFIG_MODVERSIONS
+	$(MAKE) update-modverfile
+endif
 
 MODVERFILE :=
 
diff -ruN linux-2.2.21pre2/Rules.make linux-2.2.21pre2.modver-2.4-backport/Rules.make
--- linux-2.2.21pre2/Rules.make	Mon Dec 11 22:10:06 2000
+++ linux-2.2.21pre2.modver-2.4-backport/Rules.make	Wed Jan  2 14:11:07 2002
@@ -230,8 +230,16 @@
 	
 $(addprefix $(MODINCL)/,$(SYMTAB_OBJS:.o=.ver)): $(TOPDIR)/include/linux/autoconf.h
 
-$(TOPDIR)/include/linux/modversions.h: $(addprefix $(MODINCL)/,$(SYMTAB_OBJS:.o=.ver))
-	@echo updating $(TOPDIR)/include/linux/modversions.h
+# updates .ver files but not modversions.h
+fastdep: $(addprefix $(MODINCL)/,$(SYMTAB_OBJS:.o=.ver))
+
+# updates .ver files and modversions.h like before (is this needed?)
+dep: fastdep update-modverfile
+
+endif # SYMTAB_OBJS 
+
+# update modversions.h, but only if it would change
+update-modverfile:
 	@(echo "#ifndef _LINUX_MODVERSIONS_H";\
 	  echo "#define _LINUX_MODVERSIONS_H"; \
 	  echo "#include <linux/modsetver.h>"; \
@@ -240,11 +248,14 @@
 	    if [ -f $$f ]; then echo "#include <linux/modules/$${f}>"; fi; \
 	  done; \
 	  echo "#endif"; \
-	) > $@
-
-dep fastdep: $(TOPDIR)/include/linux/modversions.h
-
-endif # SYMTAB_OBJS 
+	) > $(TOPDIR)/include/linux/modversions.h.tmp
+	@if [ -r $(TOPDIR)/include/linux/modversions.h ] && cmp -s $(TOPDIR)/include/linux/modversions.h $(TOPDIR)/include/linux/modversions.h.tmp; then \
+		echo $(TOPDIR)/include/linux/modversions.h was not updated; \
+		rm -f $(TOPDIR)/include/linux/modversions.h.tmp; \
+	else \
+		echo $(TOPDIR)/include/linux/modversions.h was updated; \
+		mv -f $(TOPDIR)/include/linux/modversions.h.tmp $(TOPDIR)/include/linux/modversions.h; \
+	fi
 
 $(M_OBJS): $(TOPDIR)/include/linux/modversions.h
 ifdef MAKING_MODULES
