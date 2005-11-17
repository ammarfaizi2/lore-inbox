Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030568AbVKQBRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030568AbVKQBRk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 20:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030583AbVKQBRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 20:17:40 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:19899 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030568AbVKQBRk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 20:17:40 -0500
Date: Thu, 17 Nov 2005 02:17:28 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] prefer pkg-config for the QT check 
Message-ID: <Pine.LNX.4.61.0511170147200.861@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This makes pkg-config now the prefered way to configure QT and properly 
fixes the recent Fedora breakage and leaves the old QT detection as 
fallback mechanism.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 scripts/kconfig/Makefile |   68 ++++++++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 29 deletions(-)

Index: linux-2.6-mm/scripts/kconfig/Makefile
===================================================================
--- linux-2.6-mm.orig/scripts/kconfig/Makefile	2005-11-14 18:57:59.000000000 +0100
+++ linux-2.6-mm/scripts/kconfig/Makefile	2005-11-14 21:16:58.000000000 +0100
@@ -129,8 +129,8 @@ endif
 HOSTCFLAGS_lex.zconf.o	:= -I$(src)
 HOSTCFLAGS_zconf.tab.o	:= -I$(src)
 
-HOSTLOADLIBES_qconf	= -L$(QTLIBPATH) -Wl,-rpath,$(QTLIBPATH) -l$(LIBS_QT) -ldl
-HOSTCXXFLAGS_qconf.o	= -I$(QTDIR)/include -D LKC_DIRECT_LINK
+HOSTLOADLIBES_qconf	= $(KC_QT_LIBS) -ldl
+HOSTCXXFLAGS_qconf.o	= $(KC_QT_CFLAGS) -D LKC_DIRECT_LINK
 
 HOSTLOADLIBES_gconf	= `pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --libs`
 HOSTCFLAGS_gconf.o	= `pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --cflags` \
@@ -139,40 +139,50 @@ HOSTCFLAGS_gconf.o	= `pkg-config gtk+-2.
 $(obj)/qconf.o: $(obj)/.tmp_qtcheck
 
 ifeq ($(qconf-target),1)
-MOC = $(QTDIR)/bin/moc
-QTLIBPATH = $(QTDIR)/lib
+$(obj)/.tmp_qtcheck: $(src)/Makefile
 -include $(obj)/.tmp_qtcheck
 
 # QT needs some extra effort...
 $(obj)/.tmp_qtcheck:
-	@set -e; for d in $$QTDIR /usr/share/qt* /usr/lib/qt*; do \
-	  if [ -f $$d/include/qconfig.h ]; then DIR=$$d; break; fi; \
-	done; \
-	if [ -z "$$DIR" ]; then \
-	  echo "*"; \
-	  echo "* Unable to find the QT installation. Please make sure that the"; \
-	  echo "* QT development package is correctly installed and the QTDIR"; \
-	  echo "* environment variable is set to the correct location."; \
-	  echo "*"; \
-	  false; \
-	fi; \
-	LIBPATH=$$DIR/lib; LIB=qt; \
-	if [ -f $$QTLIB/libqt-mt.so ] ; then \
-		LIB=qt-mt; \
-		LIBPATH=$$QTLIB; \
+	@set -e; echo "  CHECK   qt"; dir=""; pkg=""; \
+	pkg-config --exists qt 2> /dev/null && pkg=qt; \
+	pkg-config --exists qt-mt 2> /dev/null && pkg=qt-mt; \
+	if [ -n "$$pkg" ]; then \
+	  cflags="\$$(shell pkg-config $$pkg --cflags)"; \
+	  libs="\$$(shell pkg-config $$pkg --libs)"; \
+	  moc="\$$(shell pkg-config $$pkg --variable=prefix)/bin/moc"; \
+	  dir="$$(pkg-config $$pkg --variable=prefix)"; \
 	else \
-		$(HOSTCXX) -print-multi-os-directory > /dev/null 2>&1 && \
-		LIBPATH=$$DIR/lib/$$($(HOSTCXX) -print-multi-os-directory); \
-		if [ -f $$LIBPATH/libqt-mt.so ]; then LIB=qt-mt; fi; \
+	  for d in $$QTDIR /usr/share/qt* /usr/lib/qt*; do \
+	    if [ -f $$d/include/qconfig.h ]; then dir=$$d; break; fi; \
+	  done; \
+	  if [ -z "$$dir" ]; then \
+	    echo "*"; \
+	    echo "* Unable to find the QT installation. Please make sure that"; \
+	    echo "* the QT development package is correctly installed and"; \
+	    echo "* either install pkg-config or set the QTDIR environment"; \
+	    echo "* variable to the correct location."; \
+	    echo "*"; \
+	    false; \
+	  fi; \
+	  libpath=$$dir/lib; lib=qt; osdir=""; \
+	  $(HOSTCXX) -print-multi-os-directory > /dev/null 2>&1 && \
+	    osdir=x$$($(HOSTCXX) -print-multi-os-directory); \
+	  test -d $$libpath/$$osdir && libpath=$$libpath/$$osdir; \
+	  test -f $$libpath/libqt-mt.so && lib=qt-mt; \
+	  cflags="-I$$dir/include"; \
+	  libs="-L$$libpath -Wl,-rpath,$$libpath -l$$lib"; \
+	  moc="$$dir/bin/moc"; \
 	fi; \
-	echo "QTDIR=$$DIR" > $@; echo "QTLIBPATH=$$LIBPATH" >> $@; \
-	echo "LIBS_QT=$$LIB" >> $@; \
-	if [ ! -x $$DIR/bin/moc -a -x /usr/bin/moc ]; then \
+	if [ ! -x $$dir/bin/moc -a -x /usr/bin/moc ]; then \
 	  echo "*"; \
-	  echo "* Unable to find $$DIR/bin/moc, using /usr/bin/moc instead."; \
+	  echo "* Unable to find $$dir/bin/moc, using /usr/bin/moc instead."; \
 	  echo "*"; \
-	  echo "MOC=/usr/bin/moc" >> $@; \
-	fi
+	  moc="/usr/bin/moc"; \
+	fi; \
+	echo "KC_QT_CFLAGS=$$cflags" > $@; \
+	echo "KC_QT_LIBS=$$libs" >> $@; \
+	echo "KC_QT_MOC=$$moc" >> $@
 endif
 
 $(obj)/gconf.o: $(obj)/.tmp_gtkcheck
@@ -210,7 +220,7 @@ $(obj)/qconf.o: $(obj)/qconf.moc $(obj)/
 $(obj)/gconf.o: $(obj)/lkc_defs.h
 
 $(obj)/%.moc: $(src)/%.h
-	$(MOC) -i $< -o $@
+	$(KC_QT_MOC) -i $< -o $@
 
 $(obj)/lkc_defs.h: $(src)/lkc_proto.h
 	sed < $< > $@ 's/P(\([^,]*\),.*/#define \1 (\*\1_p)/'
